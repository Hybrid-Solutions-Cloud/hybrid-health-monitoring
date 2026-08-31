#Requires -Version 7.0
<#
.SYNOPSIS
    Downloads, extracts, and optionally imports every external management pack that
    Hyper-V Private Cloud Monitoring requires - one command instead of five download pages.

.DESCRIPTION
    The SCOM console can only auto-resolve references from its own online catalog, and the
    Microsoft infrastructure packs this product references are not in it, so a manual import
    stops at "cannot resolve reference". This script closes that gap (ADR 0050):

      1. Downloads the official Microsoft Download Center MSIs for the capabilities you choose
         (Cluster, CSV, S2D/Storage, SDN, File Services) and, optionally, the Pure Storage pack.
      2. Extracts the .mp/.mpb files from each MSI with an administrative install (no system change).
      3. With -Import, imports everything in one batch through the OperationsManager module,
         which resolves intra-batch ordering itself.

    Nothing is redistributed: every byte comes from the publisher's official link at run time.
    If Microsoft rotates a direct URL, the script falls back to telling you the download page.

.PARAMETER Capability
    Which capability prerequisite sets to fetch. Default: all Microsoft sets.
    Core needs nothing external; VMM prerequisites come from your VMM installation media.

.PARAMETER IncludePureStorage
    Also fetch the Pure Storage FlashArray pack (2.0.120.0). Not supported on SCOM 2025.

.PARAMETER Destination
    Where MSIs are downloaded and packs extracted. Default: .\HyperVPrivateCloudPrereqs

.PARAMETER Import
    Import the extracted packs into the connected management group (requires the
    OperationsManager PowerShell module; run on a management server or a console machine).

.EXAMPLE
    ./Install-HyperVPrivateCloudPrerequisites.ps1 -Capability Cluster, CSV -Import

.EXAMPLE
    ./Install-HyperVPrivateCloudPrerequisites.ps1 -Destination D:\prereqs
    # download + extract everything, then import the folder from the SCOM console yourself
#>
[CmdletBinding()]
param(
    [ValidateSet('Cluster', 'CSV', 'S2D', 'SDN', 'FileServices', 'All')]
    [string[]]$Capability = @('All'),
    [switch]$IncludePureStorage,
    [string]$Destination = (Join-Path (Get-Location) 'HyperVPrivateCloudPrereqs'),
    [switch]$Import
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

# Publisher-official sources. Page is authoritative; direct links are a convenience that can rotate.
$catalog = @(
    [pscustomobject]@{
        Key = 'Cluster'; Name = 'Windows Server Cluster MP 10.1.0.0'
        Page = 'https://www.microsoft.com/en-us/download/details.aspx?id=54701'
        Direct = 'https://download.microsoft.com/download/b/d/5/bd59d8e4-4bf7-4dac-819a-1ac12e21c965/Microsoft SC MP for WS Cluster 2016 and 1709 Plus.msi'
    }
    [pscustomobject]@{
        Key = 'CSV'; Name = 'Windows Server 2016+ MP (Cluster Shared Volumes) 10.1.2.2'
        Page = 'https://www.microsoft.com/en-us/download/details.aspx?id=54303'
        Direct = 'https://download.microsoft.com/download/c0becab2-ada7-435e-9215-42ef7dd44727/Microsoft System Center Management Pack for Windows Server 2016 and 1709 Plus.msi'
    }
    [pscustomobject]@{
        Key = 'S2D'; Name = 'Storage Spaces Direct MP 1.0.47.4'
        Page = 'https://www.microsoft.com/en-us/download/details.aspx?id=100782'
        Direct = 'https://download.microsoft.com/download/7/0/5/70509486-2d0f-4e53-a99f-f6db413e7df6/Microsoft System Center Management Pack for StorageSpacesDirect.msi'
    }
    [pscustomobject]@{
        Key = 'SDN'; Name = 'SDN Monitoring MP 10.0.0.2'
        Page = 'https://www.microsoft.com/en-us/download/details.aspx?id=54300'
        Direct = 'https://download.microsoft.com/download/a/3/0/a30bf7cc-78c9-4702-b3f2-3859ca824dc5/Microsoft System Center Management Pack for SDN Monitoring.msi'
    }
    [pscustomobject]@{
        Key = 'FileServices'; Name = 'File and iSCSI Services MP 10.1.0.4'
        Page = 'https://www.microsoft.com/en-us/download/details.aspx?id=57594'
        Direct = 'https://download.microsoft.com/download/a/0/7/a071e8d0-d188-4ed8-8a8c-84dfdc1ac675/Microsoft SCMP for File and iSCSI Services 2016 and above.msi'
    }
)
$pure = [pscustomobject]@{
    Key = 'PureStorage'; Name = 'Pure Storage FlashArray MP 2.0.120.0 (not supported on SCOM 2025)'
    Page = 'https://github.com/PureStorage-Connect/SCOM-Management-Pack/releases/tag/v2.0.120.0'
    Direct = 'https://github.com/PureStorage-Connect/SCOM-Management-Pack/releases/download/v2.0.120.0/PureStorageFlashArray.mpb'
}

$selected = if ($Capability -contains 'All') { $catalog } else { $catalog | Where-Object Key -in $Capability }
$selected = @($selected)
if ($IncludePureStorage) { $selected += $pure }
if ($selected.Count -eq 0) { throw 'Nothing selected.' }

$downloadRoot = Join-Path $Destination 'downloads'
$packRoot = Join-Path $Destination 'management-packs'
foreach ($dir in $Destination, $downloadRoot, $packRoot) {
    if (-not (Test-Path -LiteralPath $dir)) { [void](New-Item -ItemType Directory -Path $dir -Force) }
}

$failures = [System.Collections.Generic.List[string]]::new()
foreach ($item in $selected) {
    $fileName = [System.IO.Path]::GetFileName(([uri]$item.Direct).LocalPath)
    $target = Join-Path $downloadRoot $fileName
    Write-Host "==> $($item.Name)"
    if (Test-Path -LiteralPath $target) {
        Write-Host "    already downloaded: $fileName"
    }
    else {
        try {
            Invoke-WebRequest -Uri ([uri]::EscapeUriString($item.Direct)) -OutFile $target -MaximumRedirection 5
            Write-Host "    downloaded: $fileName ($([math]::Round((Get-Item $target).Length / 1KB)) KB)"
        }
        catch {
            $failures.Add("$($item.Name): direct link failed ($($_.Exception.Message)). Download it manually from $($item.Page) into $downloadRoot and re-run.")
            continue
        }
    }

    if ($fileName -like '*.mpb' -or $fileName -like '*.mp') {
        Copy-Item -LiteralPath $target -Destination (Join-Path $packRoot $fileName) -Force
        continue
    }

    # Administrative extract: unpacks the MSI payload without installing anything.
    $extractDir = Join-Path $Destination ("extract-" + $item.Key)
    if (Test-Path -LiteralPath $extractDir) { Remove-Item -LiteralPath $extractDir -Recurse -Force }
    $process = Start-Process -FilePath 'msiexec.exe' -ArgumentList @('/a', "`"$target`"", '/qn', "TARGETDIR=`"$extractDir`"") -Wait -PassThru
    if ($process.ExitCode -ne 0) {
        $failures.Add("$($item.Name): msiexec extraction failed with exit code $($process.ExitCode). Install the MSI manually and copy its .mp files from %ProgramFiles(x86)%\System Center Management Packs.")
        continue
    }
    $extracted = @(Get-ChildItem -LiteralPath $extractDir -Recurse -File | Where-Object { $_.Extension -in @('.mp', '.mpb') })
    if ($extracted.Count -eq 0) {
        $failures.Add("$($item.Name): the MSI extracted but contained no .mp/.mpb files - inspect $extractDir.")
        continue
    }
    foreach ($file in $extracted) { Copy-Item -LiteralPath $file.FullName -Destination (Join-Path $packRoot $file.Name) -Force }
    Write-Host "    extracted $($extracted.Count) pack file(s)"
}

$packs = @(Get-ChildItem -LiteralPath $packRoot -File | Where-Object { $_.Extension -in @('.mp', '.mpb') })
Write-Host ''
Write-Host "Pack files ready in ${packRoot}: $($packs.Count)"

if ($failures.Count -gt 0) {
    Write-Warning "Some items need manual attention:"
    foreach ($failure in $failures) { Write-Warning "  $failure" }
}

if ($Import) {
    if ($packs.Count -eq 0) { throw 'Nothing to import.' }
    Import-Module OperationsManager -ErrorAction Stop
    Write-Host "Importing $($packs.Count) management pack file(s) as one batch (SCOM resolves the order)..."
    Import-SCOMManagementPack -Fullname ($packs | ForEach-Object FullName)
    Write-Host 'Prerequisite import complete. Now import the Hyper-V Private Cloud packs: core first, then your capabilities.'
}
else {
    Write-Host 'Next: import everything in that folder from the SCOM console (Administration > Management Packs > Import),'
    Write-Host 'or re-run with -Import on a machine with the OperationsManager module.'
}
if ($failures.Count -gt 0) { exit 1 }
