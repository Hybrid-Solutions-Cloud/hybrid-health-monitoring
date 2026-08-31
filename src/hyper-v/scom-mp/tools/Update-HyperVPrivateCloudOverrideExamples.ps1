#Requires -Version 7.0
<#
.SYNOPSIS
    Regenerates every committed v2 public deployment-profile override example.

.DESCRIPTION
    Runs the v2 override generator for every deployment profile and tuning tier declared by the
    package contract. Output is deterministic and contains release-time placeholders. CI generates
    the same tree in a temporary directory and rejects any byte-level drift.

.PARAMETER OutputRoot
    Destination root. Defaults to the committed public example tree.

.NOTES
    Author: Kristopher Turner
    Contact: kris@hybridsolutions.cloud
    Version: 2.0.0
#>

[Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingWriteHost', '', Justification = 'HCS scripting standard requires Write-Host for operator status.')]
[CmdletBinding()]
param(
    [Parameter()]
    [ValidateNotNullOrEmpty()]
    [string]$OutputRoot
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$v2Root = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$contractPath = Join-Path $v2Root 'contracts/packages.json'
$generatorPath = Join-Path $PSScriptRoot 'New-HyperVPrivateCloudOverrideManagementPacks.ps1'
$contract = Get-Content -LiteralPath $contractPath -Raw | ConvertFrom-Json
if ([string]$contract.schemaVersion -ne '1.0') {
    throw "Unsupported package contract schemaVersion '$($contract.schemaVersion)'. Expected '1.0'."
}

$resolvedOutputRoot = if ([string]::IsNullOrWhiteSpace($OutputRoot)) {
    Join-Path $v2Root 'templates/overrides/public'
}
else {
    [System.IO.Path]::GetFullPath($OutputRoot)
}
[System.IO.Directory]::CreateDirectory($resolvedOutputRoot) | Out-Null

$count = 0
foreach ($deploymentDefinition in $contract.profiles) {
    foreach ($tier in $contract.overrideTiers) {
        $destination = Join-Path $resolvedOutputRoot "$($deploymentDefinition.id)/$($tier.ToString().ToLowerInvariant())"
        [System.IO.Directory]::CreateDirectory($destination) | Out-Null
        & $generatorPath -DeploymentProfile ([string]$deploymentDefinition.id) -TuningTier ([string]$tier) -EmitExample -OutputPath $destination
        $count += 2
    }
}

Write-Host "Generated $count public v2 override example file(s) in '$resolvedOutputRoot'." -ForegroundColor Green
