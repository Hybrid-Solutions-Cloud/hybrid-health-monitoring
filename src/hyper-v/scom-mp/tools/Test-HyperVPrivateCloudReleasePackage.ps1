#Requires -Version 7.0
<#
.SYNOPSIS
    Validates Hyper-V Private Cloud Monitoring v2 release assets and bundles.

.DESCRIPTION
    Verifies the release manifest, asset catalog, SHA-256 checksum set, sealed assembly identities,
    stable asset names, profile composition, override counts, ZIP timestamps, path safety, and key
    exclusion. Use -RequireReleaseEligible for a production publication gate.

.PARAMETER PackagePath
    Output root created by New-HyperVPrivateCloudReleasePackage.ps1, or its assets directory.

.PARAMETER RequireReleaseEligible
    Requires Release mode, VSAE verification, a source commit, and releaseEligible=true. SCOM
    runtime certification is a documented post-publication operator activity.

.NOTES
    Author: Kristopher Turner
    Contact: kris@hybridsolutions.cloud
#>

[Diagnostics.CodeAnalysis.SuppressMessageAttribute(
    'PSAvoidUsingWriteHost',
    '',
    Justification = 'Validation summaries are intentional operator-facing output.'
)]
[CmdletBinding()]
param(
    [Parameter(Mandatory)]
    [ValidateScript({ Test-Path -LiteralPath $_ -PathType Container })]
    [string]$PackagePath,

    [Parameter()]
    [switch]$RequireReleaseEligible
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function Get-HcsHashValue {
    [CmdletBinding()]
    param([Parameter(Mandatory)][string]$Path)
    return (Get-FileHash -LiteralPath $Path -Algorithm SHA256).Hash.ToLowerInvariant()
}

function Assert-HcsCondition {
    [CmdletBinding()]
    param([Parameter(Mandatory)][bool]$Condition, [Parameter(Mandatory)][string]$Message)
    if (-not $Condition) { throw $Message }
}

$resolvedPackage = (Resolve-Path -LiteralPath $PackagePath).Path
$assetsPath = if (Test-Path -LiteralPath (Join-Path $resolvedPackage 'assets') -PathType Container) {
    Join-Path $resolvedPackage 'assets'
}
else { $resolvedPackage }
$manifestPath = Join-Path $assetsPath 'release-manifest.json'
$catalogPath = Join-Path $assetsPath 'release-assets.json'
$checksumsPath = Join-Path $assetsPath 'SHA256SUMS.txt'
foreach ($requiredPath in @($manifestPath, $catalogPath, $checksumsPath)) {
    Assert-HcsCondition -Condition (Test-Path -LiteralPath $requiredPath -PathType Leaf) -Message "Required release file is missing: '$requiredPath'."
}
$manifest = Get-Content -LiteralPath $manifestPath -Raw | ConvertFrom-Json
$catalog = Get-Content -LiteralPath $catalogPath -Raw | ConvertFrom-Json
Assert-HcsCondition -Condition ([string]$manifest.schemaVersion -eq '1.0') -Message 'Unsupported release manifest schema.'
Assert-HcsCondition -Condition ([string]$catalog.schemaVersion -eq '1.0') -Message 'Unsupported release asset catalog schema.'
Assert-HcsCondition -Condition ([string]$manifest.productVersion -eq [string]$catalog.productVersion) -Message 'Manifest and asset-catalog product versions differ.'
Assert-HcsCondition -Condition ([string]$manifest.buildMode -eq [string]$catalog.buildMode) -Message 'Manifest and asset-catalog build modes differ.'
Assert-HcsCondition -Condition ([bool]$manifest.releaseEligible -eq [bool]$catalog.releaseEligible) -Message 'Manifest and asset-catalog eligibility values differ.'

$dependencyEvidenceIdentities = @(
    foreach ($source in $manifest.dependencyEvidence) {
        Assert-HcsCondition -Condition ([string]$source.sourceFile -eq [System.IO.Path]::GetFileName([string]$source.sourceFile)) -Message 'Dependency evidence exposes a path instead of a source filename.'
        Assert-HcsCondition -Condition ([string]$source.sourceType -in @('mp', 'mpb')) -Message "Unsupported dependency evidence source type '$($source.sourceType)'."
        Assert-HcsCondition -Condition ([string]$source.sha256 -match '^[0-9a-f]{64}$') -Message "Dependency evidence has an invalid SHA-256 value for '$($source.sourceFile)'."
        if ([string]$source.sourceType -eq 'mp') {
            Assert-HcsCondition -Condition ($source.verification.strongNameVerified -eq $manifest.verification.vsae) -Message "Loose MP strong-name evidence is inconsistent for '$($source.sourceFile)'."
        }
        else {
            Assert-HcsCondition -Condition ([string]$source.verification.authenticodeStatus -in @('Valid', 'NotSigned')) -Message "MPB Authenticode status is unsupported for '$($source.sourceFile)'."
            if ([string]$source.verification.authenticodeStatus -eq 'Valid') {
                Assert-HcsCondition -Condition (-not [string]::IsNullOrWhiteSpace([string]$source.verification.signerSubject)) -Message "Signed MPB is missing its signer subject: '$($source.sourceFile)'."
                Assert-HcsCondition -Condition ([string]$source.verification.signerThumbprint -match '^[0-9a-f]{40}$') -Message "Signed MPB has an invalid signer thumbprint: '$($source.sourceFile)'."
            }
        }
        foreach ($identity in $source.identities) {
            Assert-HcsCondition -Condition ([string]$identity.publicKeyToken -match '^[0-9a-f]{16}$') -Message "Dependency evidence has an invalid token for '$($identity.id)'."
            Assert-HcsCondition -Condition ($null -ne ([version]::Parse([string]$identity.version))) -Message "Dependency evidence has an invalid version for '$($identity.id)'."
            [pscustomobject]@{
                id = [string]$identity.id
                version = [version]([string]$identity.version)
                publicKeyToken = [string]$identity.publicKeyToken
                sourceType = [string]$source.sourceType
            }
        }
    }
)
if ($manifest.verification.vsae -eq $true) {
    Assert-HcsCondition -Condition ($dependencyEvidenceIdentities.Count -gt 0) -Message 'VSAE verification requires publisher dependency evidence.'
    foreach ($prerequisite in $manifest.prerequisites) {
        $matchingEvidence = @($dependencyEvidenceIdentities | Where-Object {
                $_.id -eq [string]$prerequisite.id -and
                $_.publicKeyToken -eq [string]$prerequisite.publicKeyToken -and
                $_.version -ge [version]([string]$prerequisite.version)
            })
        Assert-HcsCondition -Condition ($matchingEvidence.Count -gt 0) -Message "No dependency evidence resolves prerequisite '$($prerequisite.id)'."
    }
    $mpbEvidenceCount = @($dependencyEvidenceIdentities | Where-Object sourceType -eq 'mpb').Count
    Assert-HcsCondition -Condition ($mpbEvidenceCount -eq [int]$manifest.verification.mpbDependencies) -Message 'MPB dependency count differs from dependency evidence.'
    Assert-HcsCondition -Condition ($manifest.verification.externalStrongNames -eq $true) -Message 'VSAE verification requires external loose-MP strong-name verification.'
}

$forbiddenFiles = @(Get-ChildItem -LiteralPath $resolvedPackage -File -Recurse | Where-Object Extension -In @('.snk', '.pfx', '.p12', '.key'))
Assert-HcsCondition -Condition ($forbiddenFiles.Count -eq 0) -Message 'The package contains a forbidden key or certificate file.'

$catalogFiles = @($catalog.assets.file)
foreach ($asset in $catalog.assets) {
    $path = Join-Path $assetsPath ([string]$asset.file)
    Assert-HcsCondition -Condition (Test-Path -LiteralPath $path -PathType Leaf) -Message "Cataloged asset is missing: '$path'."
    Assert-HcsCondition -Condition ((Get-HcsHashValue -Path $path) -eq [string]$asset.sha256) -Message "Catalog hash mismatch: '$path'."
    Assert-HcsCondition -Condition ((Get-Item -LiteralPath $path).Length -eq [long]$asset.bytes) -Message "Catalog size mismatch: '$path'."
}
$expectedCatalogFiles = @(Get-ChildItem -LiteralPath $assetsPath -File | Where-Object Name -NotIn @('release-assets.json', 'SHA256SUMS.txt') | ForEach-Object Name | Sort-Object)
Assert-HcsCondition -Condition (@(Compare-Object @($catalogFiles | Sort-Object) $expectedCatalogFiles).Count -eq 0) -Message 'The asset catalog does not cover the exact release asset set.'

$checksumEntries = @{}
foreach ($line in Get-Content -LiteralPath $checksumsPath) {
    if ($line -notmatch '^([0-9a-f]{64})  (.+)$') { throw "Invalid SHA256SUMS entry: '$line'." }
    if ($checksumEntries.ContainsKey($matches[2])) { throw "Duplicate SHA256SUMS entry: '$($matches[2])'." }
    $checksumEntries[$matches[2]] = $matches[1]
}
$expectedChecksumFiles = @(Get-ChildItem -LiteralPath $assetsPath -File | Where-Object Name -ne 'SHA256SUMS.txt' | ForEach-Object Name | Sort-Object)
Assert-HcsCondition -Condition (@(Compare-Object @($checksumEntries.Keys | Sort-Object) $expectedChecksumFiles).Count -eq 0) -Message 'SHA256SUMS does not cover the exact release asset set.'
foreach ($name in $checksumEntries.Keys) {
    Assert-HcsCondition -Condition ((Get-HcsHashValue -Path (Join-Path $assetsPath $name)) -eq $checksumEntries[$name]) -Message "SHA256SUMS mismatch: '$name'."
}

$mpFiles = @(Get-ChildItem -LiteralPath $assetsPath -Filter '*.mp' -File)
Assert-HcsCondition -Condition ($mpFiles.Count -eq @($manifest.artifacts).Count) -Message 'Sealed MP count differs from the release manifest.'
foreach ($artifact in $manifest.artifacts) {
    $path = Join-Path $assetsPath ([string]$artifact.file)
    Assert-HcsCondition -Condition (Test-Path -LiteralPath $path -PathType Leaf) -Message "Sealed MP is missing: '$path'."
    Assert-HcsCondition -Condition ((Get-HcsHashValue -Path $path) -eq [string]$artifact.sha256) -Message "Sealed MP hash mismatch: '$path'."
    $assembly = [System.Reflection.AssemblyName]::GetAssemblyName($path)
    $token = ($assembly.GetPublicKeyToken() | ForEach-Object { $_.ToString('x2') }) -join ''
    Assert-HcsCondition -Condition ($assembly.Name -eq [string]$artifact.id) -Message "Sealed MP identity mismatch: '$path'."
    Assert-HcsCondition -Condition ($assembly.Version.ToString() -eq [string]$manifest.productVersion) -Message "Sealed MP version mismatch: '$path'."
    Assert-HcsCondition -Condition ($token -eq [string]$manifest.publicKeyToken) -Message "Sealed MP token mismatch: '$path'."
}

$requiredStableAssets = @(
    'Hyper-V-Private-Cloud-Monitoring-Complete.zip',
    'Hyper-V-Private-Cloud-Monitoring-Core.zip',
    'Hyper-V-Private-Cloud-Monitoring-Overrides.zip'
)
foreach ($name in $requiredStableAssets) {
    Assert-HcsCondition -Condition (Test-Path -LiteralPath (Join-Path $assetsPath $name) -PathType Leaf) -Message "Stable release asset is missing: '$name'."
}

Add-Type -AssemblyName System.IO.Compression
$expectedTimestamp = [DateTimeOffset]::FromUnixTimeSeconds([long]$manifest.sourceDateEpoch)
$zipFiles = @(Get-ChildItem -LiteralPath $assetsPath -Filter '*.zip' -File)
foreach ($zipFile in $zipFiles) {
    $archive = [System.IO.Compression.ZipFile]::OpenRead($zipFile.FullName)
    try {
        $names = @($archive.Entries.FullName)
        Assert-HcsCondition -Condition (($names | Select-Object -Unique).Count -eq $names.Count) -Message "ZIP contains duplicate paths: '$($zipFile.Name)'."
        foreach ($entry in $archive.Entries) {
            Assert-HcsCondition -Condition (-not $entry.FullName.StartsWith('/') -and $entry.FullName -notmatch '(^|/)\.\.(/|$)') -Message "ZIP contains an unsafe path: '$($entry.FullName)'."
            # ZIP stores a DOS wall-clock timestamp without a UTC offset. Compare its clock value,
            # not the local offset attached by the machine reading the archive.
            Assert-HcsCondition -Condition ($entry.LastWriteTime.DateTime -eq $expectedTimestamp.DateTime) -Message "ZIP timestamp drift: '$($zipFile.Name):$($entry.FullName)'."
            Assert-HcsCondition -Condition ([System.IO.Path]::GetExtension($entry.FullName) -notin @('.snk', '.pfx', '.p12', '.key')) -Message "ZIP contains a forbidden key file: '$($entry.FullName)'."
        }
    }
    finally { $archive.Dispose() }
}

$completeZip = [System.IO.Compression.ZipFile]::OpenRead((Join-Path $assetsPath 'Hyper-V-Private-Cloud-Monitoring-Complete.zip'))
try {
    Assert-HcsCondition -Condition (@($completeZip.Entries | Where-Object FullName -Like 'ManagementPacks/*.mp').Count -eq @($manifest.artifacts).Count) -Message 'Complete ZIP has the wrong sealed MP count.'
    Assert-HcsCondition -Condition (@($completeZip.Entries | Where-Object FullName -Like 'Overrides/*.xml').Count -eq @($manifest.publicOverrides).Count) -Message 'Complete ZIP has the wrong override count.'
}
finally { $completeZip.Dispose() }

if ($RequireReleaseEligible) {
    Assert-HcsCondition -Condition ([string]$manifest.buildMode -eq 'Release') -Message 'Publication requires a Release-mode package.'
    Assert-HcsCondition -Condition ($manifest.releaseEligible -eq $true) -Message 'Publication requires releaseEligible=true.'
    Assert-HcsCondition -Condition ($manifest.verification.vsae -eq $true) -Message 'Publication requires Microsoft VSAE verification.'
    Assert-HcsCondition -Condition ([string]$manifest.sourceCommit -match '^[0-9a-f]{40}$') -Message 'Publication requires the exact source commit.'
    Assert-HcsCondition -Condition ([string]$manifest.verification.runtimeCertification -eq 'post-publication-operator-validation') -Message 'Publication must declare the post-publication SCOM validation contract.'
}

Write-Host "Validated $($mpFiles.Count) sealed MPs and $($zipFiles.Count) release bundles in '$assetsPath'."
Write-Host "Build mode: $($manifest.buildMode); release eligible: $($manifest.releaseEligible); token: $($manifest.publicKeyToken)."
