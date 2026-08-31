#Requires -Version 7.0
<#
.SYNOPSIS
    Downloads the published override packs and imports the Discovery + Monitoring pair for one
    deployment profile and tuning tier - the supported way to apply a tuning baseline.

.DESCRIPTION
    Every release ships 66 public override packs: 11 deployment profiles, each with Lab, Standard,
    and Strict tiers, each tier a Discovery + Monitoring pair. Exactly one pair should be imported
    per management group. This script fetches the release's Overrides bundle (or uses a local copy),
    pulls out the pair you choose, and imports both files in one batch.

    Import the profile that matches the capability packs you actually installed - an override pack
    references the packs it tunes, so a profile covering capabilities you did not import will fail
    to import with an unresolved reference.

.PARAMETER DeploymentProfile
    Which topology profile to apply.

.PARAMETER TuningTier
    Lab (forgiving), Standard (the coded defaults, made explicit), or Strict (tight).

.PARAMETER Source
    A local Hyper-V-Private-Cloud-Monitoring-Overrides.zip, an already-extracted folder, or an
    https URL. Default: the latest published bundle on the documentation site.

.PARAMETER Destination
    Working folder for download/extract. Default: .\HyperVPrivateCloudOverrides

.PARAMETER Import
    Import the pair into the connected management group (requires the OperationsManager module).
    Without it the two files are staged and printed for a console import.

.EXAMPLE
    ./Install-HyperVPrivateCloudOverrides.ps1 -DeploymentProfile ClusteredSAN -TuningTier Standard -Import

.EXAMPLE
    ./Install-HyperVPrivateCloudOverrides.ps1 -DeploymentProfile Standalone -TuningTier Lab -Source D:\downloads\Hyper-V-Private-Cloud-Monitoring-Overrides.zip
#>
[CmdletBinding()]
param(
    [Parameter(Mandatory)]
    [ValidateSet('Standalone', 'ClusteredSAN', 'ClusteredPure', 'ClusteredS2D', 'HybridSANAndS2D',
        'HybridPureAndS2D', 'HyperVOverSMB', 'NetworkATC', 'SDNEnabled', 'VMMManaged', 'CompletePrivateCloud')]
    [string]$DeploymentProfile,
    [Parameter(Mandatory)]
    [ValidateSet('Lab', 'Standard', 'Strict')]
    [string]$TuningTier,
    [string]$Source = 'https://labs.hybridsolutions.cloud/hybrid-health-monitoring/downloads/hyper-v-private-cloud/latest/Hyper-V-Private-Cloud-Monitoring-Overrides.zip',
    [string]$Destination = (Join-Path (Get-Location) 'HyperVPrivateCloudOverrides'),
    [switch]$Import
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

if (-not (Test-Path -LiteralPath $Destination)) { [void](New-Item -ItemType Directory -Path $Destination -Force) }

# Resolve the source into an extracted folder.
$extractRoot = $null
if ($Source -match '^https?://') {
    $zipPath = Join-Path $Destination 'Hyper-V-Private-Cloud-Monitoring-Overrides.zip'
    Write-Host "Downloading override bundle: $Source"
    Invoke-WebRequest -Uri $Source -OutFile $zipPath -MaximumRedirection 5
    $extractRoot = Join-Path $Destination 'extracted'
    if (Test-Path -LiteralPath $extractRoot) { Remove-Item -LiteralPath $extractRoot -Recurse -Force }
    Expand-Archive -LiteralPath $zipPath -DestinationPath $extractRoot
}
elseif (Test-Path -LiteralPath $Source -PathType Leaf) {
    $extractRoot = Join-Path $Destination 'extracted'
    if (Test-Path -LiteralPath $extractRoot) { Remove-Item -LiteralPath $extractRoot -Recurse -Force }
    Expand-Archive -LiteralPath $Source -DestinationPath $extractRoot
}
elseif (Test-Path -LiteralPath $Source -PathType Container) {
    $extractRoot = $Source
}
else {
    throw "Source '$Source' is not a URL, a zip file, or a folder."
}

$pair = foreach ($kind in 'Discovery', 'Monitoring') {
    $name = "HyperVPrivateCloud.Overrides.$DeploymentProfile.$TuningTier.$kind.xml"
    $found = @(Get-ChildItem -LiteralPath $extractRoot -Recurse -File -Filter $name)
    if ($found.Count -ne 1) { throw "Expected exactly one '$name' in '$extractRoot', found $($found.Count). Is the source the release Overrides bundle?" }
    $found[0]
}

$stage = Join-Path $Destination 'selected'
if (-not (Test-Path -LiteralPath $stage)) { [void](New-Item -ItemType Directory -Path $stage -Force) }
foreach ($file in $pair) { Copy-Item -LiteralPath $file.FullName -Destination (Join-Path $stage $file.Name) -Force }

Write-Host ''
Write-Host "Selected $DeploymentProfile / $TuningTier pair:"
foreach ($file in $pair) { Write-Host "    $($file.Name)" }

if ($Import) {
    Import-Module OperationsManager -ErrorAction Stop
    Write-Host 'Importing both override packs as one batch...'
    try {
        Import-SCOMManagementPack -Fullname @($pair | ForEach-Object FullName)
    }
    catch {
        throw "Override import failed: $($_.Exception.Message). Most common cause: the '$DeploymentProfile' profile tunes capability packs you have not imported - import those capability packs first, or pick the profile that matches your installed set."
    }
    Write-Host "Tuning applied: $DeploymentProfile / $TuningTier. Import exactly one pair per management group; importing another tier later replaces this one only if you remove this pair first."
} else {
    Write-Host "Staged in ${stage}. Import both files from the SCOM console (Administration > Management Packs > Import), or re-run with -Import."
}
