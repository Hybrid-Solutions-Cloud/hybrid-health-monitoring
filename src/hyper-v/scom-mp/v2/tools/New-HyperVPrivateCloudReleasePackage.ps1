#Requires -Version 7.0
<#
.SYNOPSIS
    Seals and packages Hyper-V Private Cloud Monitoring v2 release assets.

.DESCRIPTION
    Derives the strong-name public key token from the supplied key, builds the authored product
    MPs with that exact identity, optionally verifies each source MP through Microsoft VSAE,
    seals through the VSAE SealMp task, verifies every resulting strong name, generates all public
    override profiles, and creates deterministic core, complete, override, and deployment-profile
    ZIP assets.

    Test mode produces clearly non-release-eligible evidence. Release mode cannot skip VSAE and
    requires an approved permanent signing-identity assertion plus a clean source commit. SCOM
    runtime certification is performed by the operator after repository publication and is not a
    packaging prerequisite. The signing key is never copied into an asset or archive.

.PARAMETER Version
    Four-part version used by every sealed product MP.

.PARAMETER OverrideVersion
    Independent four-part version used by the public, unsealed starter override MPs.

.PARAMETER SigningKeyPath
    Path to the strong-name key pair. The key must be outside the repository.

.PARAMETER DependencyPath
    Curated directories containing compatible sealed Microsoft and vendor `.mp` or `.mpb`
    prerequisites. Each dependency must use the referenced ID and token at the referenced minimum
    version or higher. Signed MPB identities are inspected with Microsoft's SDK and converted to
    transient remapped VSAE references only inside the working directory. Required unless Test
    mode explicitly skips VSAE verification.

.PARAMETER OutputPath
    New, empty destination for working files and final assets.

.PARAMETER BuildMode
    Test creates non-release artifacts. Release activates all release gates.

.PARAMETER SkipSdkVerification
    Permitted only in Test mode. Strong-name sealing and verification still run.

.PARAMETER ApprovedReleaseSigningIdentity
    Required in Release mode. Asserts that the supplied key is the permanent, approved product
    signing identity obtained through the governed release environment.

.PARAMETER SourceDateEpoch
    Reproducible UTC timestamp applied to every ZIP entry. Defaults to the ZIP epoch.

.EXAMPLE
    ./New-HyperVPrivateCloudReleasePackage.ps1 -Version 2.0.0.0 `
        -SigningKeyPath $env:RUNNER_TEMP/hyper-v-private-cloud-release.snk `
        -DependencyPath D:/scom-dependencies/approved -OutputPath D:/release/hyper-v-v2 `
        -BuildMode Release -ApprovedReleaseSigningIdentity

.NOTES
    Author: Kristopher Turner
    Contact: kris@hybridsolutions.cloud
#>

[Diagnostics.CodeAnalysis.SuppressMessageAttribute(
    'PSAvoidUsingWriteHost',
    '',
    Justification = 'Release progress and asset summaries are intentional operator-facing output.'
)]
[CmdletBinding()]
param(
    [Parameter()]
    [ValidatePattern('^\d+\.\d+\.\d+\.\d+$')]
    [string]$Version = '2.0.0.0',

    [Parameter()]
    [ValidatePattern('^\d+\.\d+\.\d+\.\d+$')]
    [string]$OverrideVersion = '1.0.0.0',

    [Parameter(Mandatory)]
    [ValidateScript({ Test-Path -LiteralPath $_ -PathType Leaf })]
    [string]$SigningKeyPath,

    [Parameter()]
    [ValidateScript({ Test-Path -LiteralPath $_ -PathType Container })]
    [string[]]$DependencyPath = @(),

    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [string]$OutputPath,

    [Parameter()]
    [ValidateSet('Test', 'Release')]
    [string]$BuildMode = 'Test',

    [Parameter()]
    [switch]$SkipSdkVerification,

    [Parameter()]
    [switch]$ApprovedReleaseSigningIdentity,

    [Parameter()]
    [ValidateRange(315532800, 253402300799)]
    [long]$SourceDateEpoch = 315532800,

    [Parameter()]
    [ValidateScript({ [string]::IsNullOrWhiteSpace($_) -or (Test-Path -LiteralPath $_ -PathType Leaf) })]
    [string]$MsBuildPath,

    [Parameter()]
    [ValidateScript({ Test-Path -LiteralPath $_ -PathType Leaf })]
    [string]$VsacTasksPath = 'C:\Program Files (x86)\MSBuild\Microsoft\VSAC\Microsoft.SystemCenter.Authoring.Build.dll',

    [Parameter()]
    [ValidateScript({ Test-Path -LiteralPath $_ -PathType Container })]
    [string]$FastSealDirectory = 'C:\Program Files (x86)\System Center Visual Studio 2022 Authoring Extensions\Tools',

    [Parameter()]
    [ValidateScript({ Test-Path -LiteralPath $_ -PathType Leaf })]
    [string]$MpbPackagingAssemblyPath = 'C:\Program Files (x86)\MSBuild\Microsoft\VSAC\Microsoft.EnterpriseManagement.Packaging.dll',

    [Parameter()]
    [ValidateScript({ [string]::IsNullOrWhiteSpace($_) -or (Test-Path -LiteralPath $_ -PathType Leaf) })]
    [string]$StrongNameToolPath
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function Get-HcsMsBuildPath {
    [CmdletBinding()]
    param([Parameter()][AllowEmptyString()][string]$ExplicitPath)

    if (-not [string]::IsNullOrWhiteSpace($ExplicitPath)) {
        return (Resolve-Path -LiteralPath $ExplicitPath).Path
    }
    $vswherePath = Join-Path ${env:ProgramFiles(x86)} 'Microsoft Visual Studio\Installer\vswhere.exe'
    if (-not (Test-Path -LiteralPath $vswherePath -PathType Leaf)) {
        throw 'Visual Studio Installer vswhere.exe was not found. Supply -MsBuildPath explicitly.'
    }
    $installationPath = (& $vswherePath -latest -products * -version '[17.0,18.0)' -requires Microsoft.Component.MSBuild -property installationPath | Select-Object -First 1)
    if ([string]::IsNullOrWhiteSpace($installationPath)) {
        throw 'Visual Studio 2022 with MSBuild was not found.'
    }
    $resolved = Join-Path $installationPath 'MSBuild\Current\Bin\MSBuild.exe'
    if (-not (Test-Path -LiteralPath $resolved -PathType Leaf)) { throw "MSBuild was not found at '$resolved'." }
    return $resolved
}

function Get-HcsStrongNameToolPath {
    [CmdletBinding()]
    param([Parameter()][AllowEmptyString()][string]$ExplicitPath)

    if (-not [string]::IsNullOrWhiteSpace($ExplicitPath)) {
        return (Resolve-Path -LiteralPath $ExplicitPath).Path
    }
    $sdkRoot = Join-Path ${env:ProgramFiles(x86)} 'Microsoft SDKs\Windows'
    $candidate = Get-ChildItem -LiteralPath $sdkRoot -Filter sn.exe -File -Recurse -ErrorAction SilentlyContinue |
        Where-Object FullName -Match 'NETFX' |
        Sort-Object FullName -Descending |
        Select-Object -First 1
    if ($null -eq $candidate) { throw 'The .NET Framework Strong Name utility sn.exe was not found. Supply -StrongNameToolPath.' }
    return $candidate.FullName
}

function Invoke-HcsNativeTool {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)][string]$FilePath,
        [Parameter(Mandatory)][string[]]$ArgumentList,
        [Parameter(Mandatory)][string]$FailureMessage
    )

    $output = @(& $FilePath @ArgumentList 2>&1)
    if ($LASTEXITCODE -ne 0) {
        $detail = ($output | ForEach-Object ToString) -join [Environment]::NewLine
        throw "$FailureMessage$([Environment]::NewLine)$detail"
    }
    return @($output | ForEach-Object ToString)
}

function Get-HcsPublicKeyToken {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)][string]$KeyPath,
        [Parameter(Mandatory)][string]$SnPath,
        [Parameter(Mandatory)][string]$WorkingPath
    )

    $publicKeyPath = Join-Path $WorkingPath 'signing-identity.public-key.snk'
    try {
        Invoke-HcsNativeTool -FilePath $SnPath -ArgumentList @('-q', '-p', $KeyPath, $publicKeyPath) -FailureMessage 'Failed to derive the public key from the signing key.' | Out-Null
        $tokenOutput = Invoke-HcsNativeTool -FilePath $SnPath -ArgumentList @('-q', '-t', $publicKeyPath) -FailureMessage 'Failed to calculate the signing public key token.'
        $match = [regex]::Match(($tokenOutput -join "`n"), '(?im)Public key token is\s+([0-9a-f]{16})')
        if (-not $match.Success) { throw 'sn.exe did not return a 16-character public key token.' }
        return $match.Groups[1].Value.ToLowerInvariant()
    }
    finally {
        if (Test-Path -LiteralPath $publicKeyPath -PathType Leaf) { [System.IO.File]::Delete($publicKeyPath) }
    }
}

function Get-HcsRelativePath {
    [CmdletBinding()]
    param([Parameter(Mandatory)][string]$BasePath, [Parameter(Mandatory)][string]$Path)
    return [System.IO.Path]::GetRelativePath($BasePath, $Path).Replace('\', '/')
}

function Get-HcsFileHashValue {
    [CmdletBinding()]
    param([Parameter(Mandatory)][string]$Path)
    return (Get-FileHash -LiteralPath $Path -Algorithm SHA256).Hash.ToLowerInvariant()
}

function Get-HcsAssemblyIdentity {
    [CmdletBinding()]
    param([Parameter(Mandatory)][string]$Path)

    try { $assemblyName = [System.Reflection.AssemblyName]::GetAssemblyName($Path) }
    catch { throw "Sealed Management Pack '$Path' is not a readable .NET assembly: $($_.Exception.Message)" }
    $token = ($assemblyName.GetPublicKeyToken() | ForEach-Object { $_.ToString('x2') }) -join ''
    return [pscustomobject]@{
        id = $assemblyName.Name
        version = $assemblyName.Version.ToString()
        publicKeyToken = $token
        path = $Path
        key = "$($assemblyName.Name)|$($assemblyName.Version)|$token"
        kind = 'mp'
        xmlPath = $null
    }
}

function Get-HcsBundleManagementPackIdentity {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)][string]$BundlePath,
        [Parameter(Mandatory)][string]$ExtractionPath,
        [Parameter(Mandatory)][string]$PackagingAssemblyPath
    )

    $sdkDirectory = Split-Path -Parent $PackagingAssemblyPath
    $coreAssemblyPath = Join-Path $sdkDirectory 'Microsoft.EnterpriseManagement.Core.dll'
    if (-not (Test-Path -LiteralPath $coreAssemblyPath -PathType Leaf)) {
        throw "Microsoft.EnterpriseManagement.Core.dll was not found beside '$PackagingAssemblyPath'."
    }
    $coreAssembly = [System.Reflection.Assembly]::LoadFrom($coreAssemblyPath)
    $packagingAssembly = [System.Reflection.Assembly]::LoadFrom($PackagingAssemblyPath)
    $readerType = $packagingAssembly.GetType('Microsoft.EnterpriseManagement.Packaging.ManagementPackMsiBundleReader', $true)
    $storeType = $coreAssembly.GetType('Microsoft.EnterpriseManagement.Configuration.IO.ManagementPackFileStore', $true)
    $writerType = $coreAssembly.GetType('Microsoft.EnterpriseManagement.Configuration.IO.ManagementPackXmlWriter', $true)
    $reader = [System.Activator]::CreateInstance($readerType)
    $store = [System.Activator]::CreateInstance($storeType)
    $bundle = $reader.Read($BundlePath, $store)
    [System.IO.Directory]::CreateDirectory($ExtractionPath) | Out-Null
    $writer = [System.Activator]::CreateInstance($writerType, @($ExtractionPath))
    foreach ($managementPack in $bundle.ManagementPacks) {
        if (-not $managementPack.Sealed -or [string]::IsNullOrWhiteSpace([string]$managementPack.KeyToken)) {
            throw "Bundle '$BundlePath' contains unsealed or unsigned Management Pack '$($managementPack.Name)'."
        }
        $xmlPath = $writer.WriteManagementPack($managementPack)
        $token = ([string]$managementPack.KeyToken).ToLowerInvariant()
        [pscustomobject]@{
            id = [string]$managementPack.Name
            version = $managementPack.Version.ToString()
            publicKeyToken = $token
            path = $BundlePath
            key = "$($managementPack.Name)|$($managementPack.Version)|$token"
            kind = 'mpb'
            xmlPath = $xmlPath
        }
    }
}

function Get-HcsSealedManagementPackXml {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)][string]$ManagementPackPath,
        [Parameter(Mandatory)][string]$ExtractionPath,
        [Parameter(Mandatory)][string]$CoreAssemblyPath,
        [Parameter(Mandatory)][string[]]$ReferenceDirectories
    )

    $coreAssembly = [System.Reflection.Assembly]::LoadFrom($CoreAssemblyPath)
    $managementPackType = $coreAssembly.GetType('Microsoft.EnterpriseManagement.Configuration.ManagementPack', $true)
    $writerType = $coreAssembly.GetType('Microsoft.EnterpriseManagement.Configuration.IO.ManagementPackXmlWriter', $true)
    $constructor = $managementPackType.GetConstructor([type[]]@([string], [string[]]))
    if ($null -eq $constructor) { throw 'The Microsoft SCOM SDK ManagementPack(string, string[]) constructor was not found.' }
    $managementPack = $constructor.Invoke([object[]]@($ManagementPackPath, [string[]]$ReferenceDirectories))
    if (-not $managementPack.Sealed -or [string]::IsNullOrWhiteSpace([string]$managementPack.KeyToken)) {
        throw "Management Pack '$ManagementPackPath' is not sealed with a publisher identity."
    }
    [System.IO.Directory]::CreateDirectory($ExtractionPath) | Out-Null
    $writer = [System.Activator]::CreateInstance($writerType, @($ExtractionPath))
    return $writer.WriteManagementPack($managementPack)
}

function Resolve-HcsExternalIdentity {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)][object[]]$Identities,
        [Parameter(Mandatory)][string]$Id,
        [Parameter(Mandatory)][version]$MinimumVersion,
        [Parameter(Mandatory)][string]$PublicKeyToken
    )

    $candidates = @($Identities | Where-Object {
            [string]$_.id -eq $Id -and
            [string]$_.publicKeyToken -eq $PublicKeyToken.ToLowerInvariant() -and
            [version]$_.version -ge $MinimumVersion
        } | Sort-Object { [version]$_.version }, path -Descending | Select-Object -First 1)
    if ($candidates.Count -eq 0) { return $null }
    return $candidates[0]
}

function Copy-HcsFile {
    [CmdletBinding()]
    param([Parameter(Mandatory)][string]$Source, [Parameter(Mandatory)][string]$Destination)
    [System.IO.Directory]::CreateDirectory((Split-Path -Parent $Destination)) | Out-Null
    [System.IO.File]::Copy($Source, $Destination, $true)
}

function Write-HcsDeterministicZip {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)][string]$SourcePath,
        [Parameter(Mandatory)][string]$DestinationPath,
        [Parameter(Mandatory)][DateTimeOffset]$Timestamp
    )

    Add-Type -AssemblyName System.IO.Compression
    $destinationDirectory = Split-Path -Parent $DestinationPath
    [System.IO.Directory]::CreateDirectory($destinationDirectory) | Out-Null
    $fileStream = [System.IO.File]::Open($DestinationPath, [System.IO.FileMode]::Create, [System.IO.FileAccess]::ReadWrite, [System.IO.FileShare]::None)
    try {
        $archive = [System.IO.Compression.ZipArchive]::new($fileStream, [System.IO.Compression.ZipArchiveMode]::Create, $false)
        try {
            $files = Get-ChildItem -LiteralPath $SourcePath -File -Recurse | Sort-Object { Get-HcsRelativePath -BasePath $SourcePath -Path $_.FullName }
            foreach ($file in $files) {
                $relativePath = Get-HcsRelativePath -BasePath $SourcePath -Path $file.FullName
                $entry = $archive.CreateEntry($relativePath, [System.IO.Compression.CompressionLevel]::Optimal)
                $entry.LastWriteTime = $Timestamp
                $entryStream = $entry.Open()
                try {
                    $sourceStream = [System.IO.File]::OpenRead($file.FullName)
                    try { $sourceStream.CopyTo($entryStream) } finally { $sourceStream.Dispose() }
                }
                finally { $entryStream.Dispose() }
            }
        }
        finally { $archive.Dispose() }
    }
    finally { $fileStream.Dispose() }
}

function Invoke-HcsVsaeVerification {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)][string]$ManagementPackPath,
        [Parameter(Mandatory)][string[]]$ReferenceFiles,
        [Parameter(Mandatory)][string]$MsBuild,
        [Parameter(Mandatory)][string]$VerificationProject,
        [Parameter(Mandatory)][string]$TasksPath,
        [Parameter(Mandatory)][string]$WorkingPath
    )

    [System.IO.Directory]::CreateDirectory($WorkingPath) | Out-Null
    $referenceListPath = Join-Path $WorkingPath 'reference-files.txt'
    [System.IO.File]::WriteAllLines($referenceListPath, [string[]]($ReferenceFiles | Sort-Object -Unique), [System.Text.UTF8Encoding]::new($false))
    $arguments = @(
        $VerificationProject,
        '/nologo', '/t:Verify', '/verbosity:minimal',
        "/p:VerificationTargetFile=$ManagementPackPath",
        "/p:ReferenceListPath=$referenceListPath",
        "/p:VsacTasksPath=$TasksPath",
        "/p:VerificationWorkingPath=$WorkingPath\"
    )
    Invoke-HcsNativeTool -FilePath $MsBuild -ArgumentList $arguments -FailureMessage "Microsoft VSAE verification failed for '$(Split-Path -Leaf $ManagementPackPath)'." | Write-Output
}

function Invoke-HcsSeal {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)][string]$ManagementPackPath,
        [Parameter(Mandatory)][string]$DestinationPath,
        [Parameter(Mandatory)][string]$KeyPath,
        [Parameter(Mandatory)][string]$MsBuild,
        [Parameter(Mandatory)][string]$SealProject,
        [Parameter(Mandatory)][string]$TasksPath,
        [Parameter(Mandatory)][string]$FastSealPath
    )

    $arguments = @(
        $SealProject,
        '/nologo', '/t:Seal', '/verbosity:minimal',
        "/p:SourceManagementPack=$ManagementPackPath",
        "/p:OutputDirectory=$DestinationPath",
        "/p:SigningKeyFile=$KeyPath",
        "/p:VsacTasksPath=$TasksPath",
        "/p:FastSealDirectory=$FastSealPath",
        '/p:CompanyName=Hybrid Solutions Cloud',
        '/p:CopyrightText=Copyright Hybrid Solutions Cloud'
    )
    Invoke-HcsNativeTool -FilePath $MsBuild -ArgumentList $arguments -FailureMessage "Microsoft VSAE sealing failed for '$(Split-Path -Leaf $ManagementPackPath)'." | Write-Output
}

$repositoryRoot = (Resolve-Path (Join-Path $PSScriptRoot '../../../../..')).Path
$resolvedKeyPath = (Resolve-Path -LiteralPath $SigningKeyPath).Path
$repositoryPrefix = $repositoryRoot.TrimEnd('\') + '\'
if ($resolvedKeyPath.StartsWith($repositoryPrefix, [System.StringComparison]::OrdinalIgnoreCase)) {
    throw 'SigningKeyPath must be outside the repository. Signing keys must never be source-controlled or packaged.'
}
$headCommit = (& git -C $repositoryRoot rev-parse HEAD 2>&1 | Select-Object -First 1).ToString().Trim().ToLowerInvariant()
if ($BuildMode -eq 'Release') {
    if ($SkipSdkVerification) { throw 'Release mode cannot skip Microsoft VSAE verification.' }
    if (-not $ApprovedReleaseSigningIdentity) { throw 'Release mode requires -ApprovedReleaseSigningIdentity.' }
    if ($LASTEXITCODE -ne 0 -or $headCommit -notmatch '^[0-9a-f]{40}$') { throw 'Release mode requires a resolvable source commit.' }
    $worktreeStatus = @(& git -C $repositoryRoot status --porcelain 2>&1)
    if ($LASTEXITCODE -ne 0 -or $worktreeStatus.Count -gt 0) { throw 'Release mode requires a clean Git worktree.' }
}
if (-not $SkipSdkVerification -and $DependencyPath.Count -eq 0) {
    throw 'DependencyPath is required when Microsoft VSAE verification is enabled.'
}

$resolvedOutput = [System.IO.Path]::GetFullPath($OutputPath)
if (Test-Path -LiteralPath $resolvedOutput) {
    $existing = @(Get-ChildItem -LiteralPath $resolvedOutput -Force)
    if ($existing.Count -gt 0) { throw "OutputPath must be empty: '$resolvedOutput'." }
}
[System.IO.Directory]::CreateDirectory($resolvedOutput) | Out-Null
$workingRoot = Join-Path $resolvedOutput 'work'
$builtPath = Join-Path $workingRoot 'built'
$sealedPath = Join-Path $workingRoot 'sealed'
$verifyPath = Join-Path $workingRoot 'verify'
$bundleReferenceRoot = Join-Path $workingRoot 'mpb-verification'
$stagingRoot = Join-Path $workingRoot 'staging'
$assetsPath = Join-Path $resolvedOutput 'assets'
foreach ($path in @($builtPath, $sealedPath, $verifyPath, $bundleReferenceRoot, $stagingRoot, $assetsPath)) {
    [System.IO.Directory]::CreateDirectory($path) | Out-Null
}

$resolvedMsBuild = Get-HcsMsBuildPath -ExplicitPath $MsBuildPath
$resolvedSn = Get-HcsStrongNameToolPath -ExplicitPath $StrongNameToolPath
$publicKeyToken = Get-HcsPublicKeyToken -KeyPath $resolvedKeyPath -SnPath $resolvedSn -WorkingPath $workingRoot
$buildTool = Join-Path $PSScriptRoot 'Build-HyperVPrivateCloudManagementPacks.ps1'
$overrideTool = Join-Path $PSScriptRoot 'New-HyperVPrivateCloudOverrideManagementPacks.ps1'
$manifestPath = Join-Path $PSScriptRoot '../build/build-manifest.json'
$contractPath = Join-Path $PSScriptRoot '../../contracts/packages.v2.json'
$verificationProject = Join-Path $repositoryRoot 'tools/scom/VerifyManagementPack.proj'
$sealProjectTemplate = Join-Path $repositoryRoot 'tools/scom/SealManagementPack.proj'
$sealProject = Join-Path $workingRoot 'SealManagementPack.proj'
Copy-HcsFile -Source $sealProjectTemplate -Destination $sealProject
$manifest = Get-Content -LiteralPath $manifestPath -Raw | ConvertFrom-Json
$contract = Get-Content -LiteralPath $contractPath -Raw | ConvertFrom-Json

& $buildTool -Version $Version -PublicKeyToken $publicKeyToken -OutputPath $builtPath -RequireComplete

$externalReferences = @(
    foreach ($path in $DependencyPath) {
        Get-ChildItem -LiteralPath (Resolve-Path -LiteralPath $path).Path -Filter '*.mp' -File -Recurse
    }
) | Sort-Object FullName -Unique
$bundleFiles = @(
    foreach ($path in $DependencyPath) {
        Get-ChildItem -LiteralPath (Resolve-Path -LiteralPath $path).Path -Filter '*.mpb' -File -Recurse
    }
) | Sort-Object FullName -Unique
$externalReferenceIdentities = @(
    $externalReferences | ForEach-Object { Get-HcsAssemblyIdentity -Path $_.FullName }
    foreach ($bundleFile in $bundleFiles) {
        $bundleExtractionPath = Join-Path $bundleReferenceRoot "source/$([System.IO.Path]::GetFileNameWithoutExtension($bundleFile.Name))-$((Get-HcsFileHashValue -Path $bundleFile.FullName).Substring(0, 12))"
        Get-HcsBundleManagementPackIdentity -BundlePath $bundleFile.FullName -ExtractionPath $bundleExtractionPath -PackagingAssemblyPath $MpbPackagingAssemblyPath
    }
)
$duplicateExternalIdentities = @($externalReferenceIdentities | Group-Object key | Where-Object Count -gt 1)
if ($duplicateExternalIdentities.Count -gt 0) {
    $duplicates = $duplicateExternalIdentities | ForEach-Object Name
    throw "DependencyPath contains duplicate sealed identities. Supply one exact file per identity: $($duplicates -join ', ')"
}
if (-not $SkipSdkVerification) {
    foreach ($externalReference in $externalReferences) {
        Invoke-HcsNativeTool -FilePath $resolvedSn -ArgumentList @('-q', '-vf', $externalReference.FullName) `
            -FailureMessage "Strong-name verification failed for publisher dependency '$($externalReference.FullName)'." | Out-Null
    }
}
$bundleReferenceIdentities = @($externalReferenceIdentities | Where-Object kind -eq 'mpb')
$bundleVerificationFiles = @()
$bundleVerificationToken = $null
$verificationRemapIds = $null
if (-not $SkipSdkVerification -and $bundleReferenceIdentities.Count -gt 0) {
    $transientKeyPath = Join-Path ([System.IO.Path]::GetTempPath()) "hcs-mpb-verification-$([guid]::NewGuid().ToString('N')).snk"
    try {
        Invoke-HcsNativeTool -FilePath $resolvedSn -ArgumentList @('-q', '-k', $transientKeyPath) -FailureMessage 'Failed to generate the transient MPB verification key.' | Out-Null
        $bundleVerificationToken = Get-HcsPublicKeyToken -KeyPath $transientKeyPath -SnPath $resolvedSn -WorkingPath $bundleReferenceRoot
        $referenceDirectories = [string[]]@($DependencyPath | ForEach-Object { (Resolve-Path -LiteralPath $_).Path })
        $reachableIdentities = [System.Collections.Generic.Dictionary[string, object]]::new([System.StringComparer]::Ordinal)
        $dependencyEdges = [System.Collections.Generic.Dictionary[string, object]]::new([System.StringComparer]::Ordinal)
        $inspectionQueue = [System.Collections.Generic.Queue[object]]::new()
        foreach ($artifact in $manifest.artifacts) {
            if ([string]$artifact.implementationStatus -ne 'Authored') { continue }
            [xml]$authoredXml = Get-Content -LiteralPath (Join-Path $builtPath $artifact.output) -Raw
            foreach ($reference in $authoredXml.SelectNodes('/ManagementPack/Manifest/References/Reference')) {
                $candidate = Resolve-HcsExternalIdentity -Identities $externalReferenceIdentities -Id ([string]$reference.ID) `
                    -MinimumVersion ([version]([string]$reference.Version)) -PublicKeyToken ([string]$reference.PublicKeyToken)
                if ($null -ne $candidate) { $inspectionQueue.Enqueue($candidate) }
            }
        }
        while ($inspectionQueue.Count -gt 0) {
            $identity = $inspectionQueue.Dequeue()
            if ($reachableIdentities.ContainsKey([string]$identity.key)) { continue }
            $reachableIdentities.Add([string]$identity.key, $identity)
            if ([string]$identity.kind -eq 'mp' -and [string]::IsNullOrWhiteSpace([string]$identity.xmlPath)) {
                $looseExtractionPath = Join-Path $bundleReferenceRoot "source-loose/$($identity.id)-$((Get-HcsFileHashValue -Path $identity.path).Substring(0, 12))"
                $identity.xmlPath = Get-HcsSealedManagementPackXml -ManagementPackPath $identity.path `
                    -ExtractionPath $looseExtractionPath -CoreAssemblyPath (Join-Path (Split-Path -Parent $MpbPackagingAssemblyPath) 'Microsoft.EnterpriseManagement.Core.dll') `
                    -ReferenceDirectories $referenceDirectories
            }
            [xml]$identityXml = Get-Content -LiteralPath $identity.xmlPath -Raw
            $edges = [System.Collections.Generic.HashSet[string]]::new([System.StringComparer]::Ordinal)
            foreach ($reference in $identityXml.SelectNodes('/ManagementPack/Manifest/References/Reference')) {
                $dependency = Resolve-HcsExternalIdentity -Identities $externalReferenceIdentities -Id ([string]$reference.ID) `
                    -MinimumVersion ([version]([string]$reference.Version)) -PublicKeyToken ([string]$reference.PublicKeyToken)
                if ($null -ne $dependency) {
                    [void]$edges.Add([string]$dependency.key)
                    if (-not $reachableIdentities.ContainsKey([string]$dependency.key)) { $inspectionQueue.Enqueue($dependency) }
                }
            }
            $dependencyEdges.Add([string]$identity.key, $edges)
        }
        $remappedIdentityKeys = [System.Collections.Generic.HashSet[string]]::new([System.StringComparer]::Ordinal)
        foreach ($entry in $reachableIdentities.GetEnumerator()) {
            if ([string]$entry.Value.kind -eq 'mpb') { [void]$remappedIdentityKeys.Add([string]$entry.Key) }
        }
        do {
            $addedParent = $false
            foreach ($entry in $dependencyEdges.GetEnumerator()) {
                if ($remappedIdentityKeys.Contains([string]$entry.Key)) { continue }
                foreach ($dependencyKey in $entry.Value) {
                    if ($remappedIdentityKeys.Contains([string]$dependencyKey)) {
                        [void]$remappedIdentityKeys.Add([string]$entry.Key)
                        $addedParent = $true
                        break
                    }
                }
            }
        } while ($addedParent)
        $verificationRemapIds = [System.Collections.Generic.HashSet[string]]::new([System.StringComparer]::Ordinal)
        foreach ($key in $remappedIdentityKeys) { [void]$verificationRemapIds.Add([string]$reachableIdentities[$key].id) }
        $remappedSourcePath = Join-Path $bundleReferenceRoot 'remapped-source'
        $remappedSealedPath = Join-Path $bundleReferenceRoot 'sealed'
        [System.IO.Directory]::CreateDirectory($remappedSourcePath) | Out-Null
        [System.IO.Directory]::CreateDirectory($remappedSealedPath) | Out-Null
        foreach ($key in @($remappedIdentityKeys | Sort-Object)) {
            $identity = $reachableIdentities[$key]
            [xml]$bundleXml = Get-Content -LiteralPath $identity.xmlPath -Raw
            foreach ($reference in $bundleXml.SelectNodes('/ManagementPack/Manifest/References/Reference')) {
                if ($verificationRemapIds.Contains([string]$reference.ID)) { $reference.PublicKeyToken = $bundleVerificationToken }
            }
            $remappedPath = Join-Path $remappedSourcePath "$($identity.id).xml"
            [System.IO.File]::WriteAllText($remappedPath, $bundleXml.OuterXml, [System.Text.UTF8Encoding]::new($false))
            Invoke-HcsSeal -ManagementPackPath $remappedPath -DestinationPath $remappedSealedPath -KeyPath $transientKeyPath `
                -MsBuild $resolvedMsBuild -SealProject $sealProject -TasksPath $VsacTasksPath -FastSealPath $FastSealDirectory
        }
        $bundleVerificationFiles = @(Get-ChildItem -LiteralPath $remappedSealedPath -Filter '*.mp' -File)
    }
    finally {
        if (Test-Path -LiteralPath $transientKeyPath -PathType Leaf) { [System.IO.File]::Delete($transientKeyPath) }
    }
}
$sealedArtifacts = [System.Collections.Generic.List[object]]::new()
$productReferences = [System.Collections.Generic.List[object]]::new()
foreach ($artifact in $manifest.artifacts) {
    if ([string]$artifact.implementationStatus -ne 'Authored') { continue }
    $sourcePath = Join-Path $builtPath $artifact.output
    [xml]$sourceXml = Get-Content -LiteralPath $sourcePath -Raw
    foreach ($reference in $sourceXml.SelectNodes('/ManagementPack/Manifest/References/Reference')) {
        $productReferences.Add([pscustomobject]@{
                owner = [string]$artifact.id
                alias = [string]$reference.Alias
                id = [string]$reference.ID
                version = [string]$reference.Version
                publicKeyToken = [string]$reference.PublicKeyToken
            })
    }
    if (-not $SkipSdkVerification) {
        $sealedReferenceFiles = @(Get-ChildItem -LiteralPath $sealedPath -Filter '*.mp' -File)
        $availableIdentities = @($externalReferenceIdentities) + @($sealedReferenceFiles | ForEach-Object { Get-HcsAssemblyIdentity -Path $_.FullName })
        $targetBundleReferenceIds = [System.Collections.Generic.HashSet[string]]::new([System.StringComparer]::Ordinal)
        foreach ($reference in $sourceXml.SelectNodes('/ManagementPack/Manifest/References/Reference')) {
            $requiredId = [string]$reference.ID
            $requiredVersion = [version]([string]$reference.Version)
            $requiredToken = ([string]$reference.PublicKeyToken).ToLowerInvariant()
            $compatible = @($availableIdentities | Where-Object {
                    [string]$_.id -eq $requiredId -and
                    [string]$_.publicKeyToken -eq $requiredToken -and
                    [version]$_.version -ge $requiredVersion
                })
            if ($compatible.Count -eq 0) {
                throw "Compatible sealed dependency '$requiredId' version '$requiredVersion' or higher with token '$requiredToken' required by '$($artifact.id)' was not supplied."
            }
            if ($null -ne $verificationRemapIds -and $verificationRemapIds.Contains($requiredId)) { [void]$targetBundleReferenceIds.Add($requiredId) }
        }
        $verificationTargetPath = $sourcePath
        if ($targetBundleReferenceIds.Count -gt 0) {
            [xml]$verificationTarget = $sourceXml.OuterXml
            foreach ($reference in $verificationTarget.SelectNodes('/ManagementPack/Manifest/References/Reference')) {
                if ($targetBundleReferenceIds.Contains([string]$reference.ID)) { $reference.PublicKeyToken = $bundleVerificationToken }
            }
            $remappedTargetPath = Join-Path $verifyPath "mpb-remapped/$($artifact.id)"
            [System.IO.Directory]::CreateDirectory($remappedTargetPath) | Out-Null
            $verificationTargetPath = Join-Path $remappedTargetPath "$($artifact.id).xml"
            [System.IO.File]::WriteAllText($verificationTargetPath, $verificationTarget.OuterXml, [System.Text.UTF8Encoding]::new($false))
        }
        $references = @($externalReferences.FullName) + @($bundleVerificationFiles | ForEach-Object FullName) + @($sealedReferenceFiles | ForEach-Object FullName)
        Invoke-HcsVsaeVerification -ManagementPackPath $verificationTargetPath -ReferenceFiles $references -MsBuild $resolvedMsBuild `
            -VerificationProject $verificationProject -TasksPath $VsacTasksPath -WorkingPath (Join-Path $verifyPath ([string]$artifact.id))
    }
    Invoke-HcsSeal -ManagementPackPath $sourcePath -DestinationPath $sealedPath -KeyPath $resolvedKeyPath `
        -MsBuild $resolvedMsBuild -SealProject $sealProject -TasksPath $VsacTasksPath -FastSealPath $FastSealDirectory
    $sealedFile = Join-Path $sealedPath "$($artifact.id).mp"
    if (-not (Test-Path -LiteralPath $sealedFile -PathType Leaf)) { throw "VSAE did not emit the expected sealed artifact '$sealedFile'." }
    Invoke-HcsNativeTool -FilePath $resolvedSn -ArgumentList @('-q', '-vf', $sealedFile) -FailureMessage "Strong-name verification failed for '$sealedFile'." | Out-Null
    $tokenOutput = Invoke-HcsNativeTool -FilePath $resolvedSn -ArgumentList @('-q', '-T', $sealedFile) -FailureMessage "Could not inspect the public key token for '$sealedFile'."
    if (($tokenOutput -join "`n") -notmatch [regex]::Escape($publicKeyToken)) { throw "Sealed artifact '$sealedFile' does not use token '$publicKeyToken'." }
    $assetFile = Join-Path $assetsPath "$($artifact.id).mp"
    Copy-HcsFile -Source $sealedFile -Destination $assetFile
    $sealedArtifacts.Add([pscustomobject]@{
            id = [string]$artifact.id
            file = [System.IO.Path]::GetFileName($assetFile)
            kind = [string]$artifact.kind
            required = [bool]$artifact.required
            sha256 = Get-HcsFileHashValue -Path $assetFile
        })
}

$overrideRoot = Join-Path $stagingRoot 'Overrides'
$overrideFiles = [System.Collections.Generic.List[object]]::new()
foreach ($deploymentProfile in $contract.profiles) {
    foreach ($tier in $contract.overrideTiers) {
        $profilePath = Join-Path $overrideRoot "$($deploymentProfile.id)/$($tier.ToString().ToLowerInvariant())"
        & $overrideTool -DeploymentProfile ([string]$deploymentProfile.id) -TuningTier ([string]$tier) -PublicProfile `
            -Version $OverrideVersion -ProductVersion $Version -PublicKeyToken $publicKeyToken -OutputPath $profilePath
        foreach ($file in Get-ChildItem -LiteralPath $profilePath -Filter '*.xml' -File) {
            $overrideFiles.Add([pscustomobject]@{
                    profile = [string]$deploymentProfile.id
                    tier = [string]$tier
                    file = Get-HcsRelativePath -BasePath $stagingRoot -Path $file.FullName
                    sha256 = Get-HcsFileHashValue -Path $file.FullName
                })
        }
    }
}

$internalIds = [System.Collections.Generic.HashSet[string]]::new([System.StringComparer]::Ordinal)
foreach ($artifact in $manifest.artifacts) { if ([string]$artifact.implementationStatus -eq 'Authored') { [void]$internalIds.Add([string]$artifact.id) } }
$prerequisites = @(
    $productReferences |
        Where-Object { -not $internalIds.Contains([string]$_.id) } |
        Sort-Object id, version, publicKeyToken -Unique
)
$selectedDependencyIdentities = @(
    if (-not $SkipSdkVerification) {
        foreach ($prerequisite in $prerequisites) {
            $identity = Resolve-HcsExternalIdentity -Identities $externalReferenceIdentities -Id ([string]$prerequisite.id) `
                -MinimumVersion ([version]([string]$prerequisite.version)) -PublicKeyToken ([string]$prerequisite.publicKeyToken)
            if ($null -eq $identity) {
                throw "No verified publisher dependency evidence resolves prerequisite '$($prerequisite.id)'."
            }
            $identity
        }
    }
) | Sort-Object key -Unique
$dependencyEvidence = @(
    $selectedDependencyIdentities |
        Group-Object path |
        Sort-Object Name |
        ForEach-Object {
            $sourceIdentities = @($_.Group | Sort-Object id, version | ForEach-Object {
                    [ordered]@{
                        id = [string]$_.id
                        version = [string]$_.version
                        publicKeyToken = [string]$_.publicKeyToken
                    }
                })
            $sourceType = [string]$_.Group[0].kind
            $sourceVerification = if ($sourceType -eq 'mp') {
                [ordered]@{ strongNameVerified = (-not $SkipSdkVerification) }
            }
            else {
                $signature = Get-AuthenticodeSignature -LiteralPath ([string]$_.Name)
                [ordered]@{
                    authenticodeStatus = [string]$signature.Status
                    signerSubject = if ($null -ne $signature.SignerCertificate) { [string]$signature.SignerCertificate.Subject } else { '' }
                    signerThumbprint = if ($null -ne $signature.SignerCertificate) { ([string]$signature.SignerCertificate.Thumbprint).ToLowerInvariant() } else { '' }
                }
            }
            [ordered]@{
                sourceFile = [System.IO.Path]::GetFileName([string]$_.Name)
                sourceType = $sourceType
                sha256 = Get-HcsFileHashValue -Path ([string]$_.Name)
                verification = $sourceVerification
                identities = $sourceIdentities
            }
        }
)
$releaseManifest = [ordered]@{
    schemaVersion = '1.0'
    productName = [string]$manifest.productName
    productVersion = $Version
    overrideVersion = $OverrideVersion
    buildMode = $BuildMode
    releaseEligible = ($BuildMode -eq 'Release' -and -not $SkipSdkVerification)
    publicKeyToken = $publicKeyToken
    sourceCommit = $headCommit
    sourceDateEpoch = $SourceDateEpoch
    verification = [ordered]@{
        vsae = (-not $SkipSdkVerification)
        mpbDependencies = @($selectedDependencyIdentities | Where-Object kind -eq 'mpb').Count
        mpbVsaeIdentityRemap = (-not $SkipSdkVerification -and $null -ne $verificationRemapIds -and $verificationRemapIds.Count -gt 0)
        verificationRemappedDependencies = @($verificationRemapIds | Sort-Object)
        externalStrongNames = (-not $SkipSdkVerification)
        strongName = $true
        runtimeCertification = 'post-publication-operator-validation'
    }
    artifacts = @($sealedArtifacts)
    publicOverrides = @($overrideFiles)
    prerequisites = @($prerequisites)
    dependencyEvidence = $dependencyEvidence
}
$releaseManifestPath = Join-Path $stagingRoot 'release-manifest.json'
[System.IO.File]::WriteAllText($releaseManifestPath, ($releaseManifest | ConvertTo-Json -Depth 8), [System.Text.UTF8Encoding]::new($false))
$readme = @"
# Hyper-V Private Cloud Monitoring $Version

This package contains sealed product Management Packs plus public, unsealed starter override MPs.
Import only the capability MPs selected for the deployment and import every Microsoft/vendor
prerequisite listed in `release-manifest.json` first. Review and copy starter overrides into
customer-owned MPs; never use the Default Management Pack for customization.

Build mode: **$BuildMode**

Product public key token: `$publicKeyToken`

Test-mode packages are not public release artifacts and are not supported for production use.
"@
[System.IO.File]::WriteAllText((Join-Path $stagingRoot 'README.md'), $readme, [System.Text.UTF8Encoding]::new($false))

$timestamp = [DateTimeOffset]::FromUnixTimeSeconds($SourceDateEpoch)
$completeStage = Join-Path $workingRoot 'bundle-complete'
$coreStage = Join-Path $workingRoot 'bundle-core'
$overrideStage = Join-Path $workingRoot 'bundle-overrides'
foreach ($path in @($completeStage, $coreStage, $overrideStage)) { [System.IO.Directory]::CreateDirectory($path) | Out-Null }
foreach ($artifact in $sealedArtifacts) { Copy-HcsFile -Source (Join-Path $assetsPath $artifact.file) -Destination (Join-Path $completeStage "ManagementPacks/$($artifact.file)") }
Copy-HcsFile -Source $releaseManifestPath -Destination (Join-Path $completeStage 'release-manifest.json')
Copy-HcsFile -Source (Join-Path $stagingRoot 'README.md') -Destination (Join-Path $completeStage 'README.md')
foreach ($file in Get-ChildItem -LiteralPath $overrideRoot -File -Recurse) { Copy-HcsFile -Source $file.FullName -Destination (Join-Path $completeStage (Get-HcsRelativePath -BasePath $stagingRoot -Path $file.FullName)) }

$coreIds = @($manifest.artifacts | Where-Object { $_.required -and $_.implementationStatus -eq 'Authored' } | ForEach-Object id)
foreach ($id in $coreIds) { Copy-HcsFile -Source (Join-Path $assetsPath "$id.mp") -Destination (Join-Path $coreStage "ManagementPacks/$id.mp") }
Copy-HcsFile -Source $releaseManifestPath -Destination (Join-Path $coreStage 'release-manifest.json')
Copy-HcsFile -Source (Join-Path $stagingRoot 'README.md') -Destination (Join-Path $coreStage 'README.md')
foreach ($file in Get-ChildItem -LiteralPath $overrideRoot -File -Recurse) { Copy-HcsFile -Source $file.FullName -Destination (Join-Path $overrideStage (Get-HcsRelativePath -BasePath $stagingRoot -Path $file.FullName)) }
Copy-HcsFile -Source $releaseManifestPath -Destination (Join-Path $overrideStage 'release-manifest.json')
Copy-HcsFile -Source (Join-Path $stagingRoot 'README.md') -Destination (Join-Path $overrideStage 'README.md')

$bundleFiles = [System.Collections.Generic.List[string]]::new()
$completeZip = Join-Path $assetsPath 'Hyper-V-Private-Cloud-Monitoring-Complete.zip'
$coreZip = Join-Path $assetsPath 'Hyper-V-Private-Cloud-Monitoring-Core.zip'
$overridesZip = Join-Path $assetsPath 'Hyper-V-Private-Cloud-Monitoring-Overrides.zip'
Write-HcsDeterministicZip -SourcePath $completeStage -DestinationPath $completeZip -Timestamp $timestamp
Write-HcsDeterministicZip -SourcePath $coreStage -DestinationPath $coreZip -Timestamp $timestamp
Write-HcsDeterministicZip -SourcePath $overrideStage -DestinationPath $overridesZip -Timestamp $timestamp
foreach ($path in @($completeZip, $coreZip, $overridesZip)) { $bundleFiles.Add($path) }

foreach ($deploymentProfile in $contract.profiles) {
    $profileStage = Join-Path $workingRoot "bundle-profile-$($deploymentProfile.id)"
    [System.IO.Directory]::CreateDirectory($profileStage) | Out-Null
    $profileArtifactIds = [System.Collections.Generic.HashSet[string]]::new([System.StringComparer]::Ordinal)
    foreach ($id in $coreIds) { [void]$profileArtifactIds.Add([string]$id) }
    foreach ($capability in $deploymentProfile.capabilities) { [void]$profileArtifactIds.Add("HyperVPrivateCloud.Capability.$capability") }
    foreach ($id in $profileArtifactIds) {
        $mpPath = Join-Path $assetsPath "$id.mp"
        if (-not (Test-Path -LiteralPath $mpPath -PathType Leaf)) { throw "Deployment profile '$($deploymentProfile.id)' requires unavailable artifact '$id'." }
        Copy-HcsFile -Source $mpPath -Destination (Join-Path $profileStage "ManagementPacks/$id.mp")
    }
    $profileOverridePath = Join-Path $overrideRoot ([string]$deploymentProfile.id)
    foreach ($file in Get-ChildItem -LiteralPath $profileOverridePath -File -Recurse) {
        Copy-HcsFile -Source $file.FullName -Destination (Join-Path $profileStage "Overrides/$($deploymentProfile.id)/$(Get-HcsRelativePath -BasePath $profileOverridePath -Path $file.FullName)")
    }
    Copy-HcsFile -Source $releaseManifestPath -Destination (Join-Path $profileStage 'release-manifest.json')
    Copy-HcsFile -Source (Join-Path $stagingRoot 'README.md') -Destination (Join-Path $profileStage 'README.md')
    $profileZip = Join-Path $assetsPath "Hyper-V-Private-Cloud-Monitoring-Profile-$($deploymentProfile.id).zip"
    Write-HcsDeterministicZip -SourcePath $profileStage -DestinationPath $profileZip -Timestamp $timestamp
    $bundleFiles.Add($profileZip)
}

Copy-HcsFile -Source $releaseManifestPath -Destination (Join-Path $assetsPath 'release-manifest.json')
$assetCatalog = [ordered]@{
    schemaVersion = '1.0'
    productVersion = $Version
    buildMode = $BuildMode
    releaseEligible = $releaseManifest.releaseEligible
    assets = @(
        Get-ChildItem -LiteralPath $assetsPath -File |
            Where-Object Name -NotIn @('release-assets.json', 'SHA256SUMS.txt') |
            Sort-Object Name |
            ForEach-Object { [ordered]@{ file = $_.Name; sha256 = Get-HcsFileHashValue -Path $_.FullName; bytes = $_.Length } }
    )
}
$assetCatalogPath = Join-Path $assetsPath 'release-assets.json'
[System.IO.File]::WriteAllText($assetCatalogPath, ($assetCatalog | ConvertTo-Json -Depth 5), [System.Text.UTF8Encoding]::new($false))
$checksumFiles = Get-ChildItem -LiteralPath $assetsPath -File | Where-Object Name -ne 'SHA256SUMS.txt' | Sort-Object Name
$checksumLines = @($checksumFiles | ForEach-Object { "$(Get-HcsFileHashValue -Path $_.FullName)  $($_.Name)" })
[System.IO.File]::WriteAllLines((Join-Path $assetsPath 'SHA256SUMS.txt'), $checksumLines, [System.Text.UTF8Encoding]::new($false))

$keyName = [System.IO.Path]::GetFileName($resolvedKeyPath)
$forbidden = Get-ChildItem -LiteralPath $resolvedOutput -File -Recurse | Where-Object { $_.Name -eq $keyName -or $_.Extension -in @('.snk', '.pfx', '.p12') }
if ($null -ne $forbidden) { throw 'A key or certificate file was found in the release output. Packaging stopped.' }

Write-Host "Created $($sealedArtifacts.Count) sealed MP assets, $($overrideFiles.Count) public override MPs, and $($bundleFiles.Count) deterministic bundles."
Write-Host "Public key token: $publicKeyToken"
Write-Host "Final assets: $assetsPath"
if ($BuildMode -eq 'Test') { Write-Host 'This is a non-release-eligible test package.' }
