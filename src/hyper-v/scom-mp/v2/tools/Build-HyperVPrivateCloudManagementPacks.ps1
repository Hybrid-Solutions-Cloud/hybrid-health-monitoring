#Requires -Version 7.0
<#
.SYNOPSIS
    Builds authored Hyper-V Private Cloud Monitoring v2 Management Pack XML.

.DESCRIPTION
    Applies the product version and signing-token reference value to deterministic v2 source.
    Planned artifacts are never emitted, so an incomplete authoring milestone cannot be mistaken
    for a complete release bundle.

.PARAMETER Version
    Four-part product Management Pack version.

.PARAMETER PublicKeyToken
    Sixteen-character public key token used by references between sealed product packs.

.PARAMETER OutputPath
    Destination directory for generated development XML.

.PARAMETER RequireComplete
    Fails unless every required artifact in the manifest is marked Authored.

.NOTES
    Author: Kristopher Turner
    Contact: kris@hybridsolutions.cloud
#>

[CmdletBinding()]
[System.Diagnostics.CodeAnalysis.SuppressMessageAttribute(
    'PSAvoidUsingWriteHost',
    '',
    Justification = 'Build summaries are intentional operator-facing console output.'
)]
param(
    [Parameter()]
    [ValidatePattern('^\d+\.\d+\.\d+\.\d+$')]
    [string]$Version = '2.0.0.0',

    [Parameter(Mandatory)]
    [ValidatePattern('^[0-9a-fA-F]{16}$')]
    [string]$PublicKeyToken,

    [Parameter()]
    [string]$OutputPath,

    [Parameter()]
    [switch]$RequireComplete
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function ConvertTo-HcsDisplayName {
    [CmdletBinding()]
    param([Parameter(Mandatory)][string]$Value)

    $leaf = $Value -replace '^HybridSolutionsCloud\.HyperVPrivateCloud\.', ''
    $leaf = $leaf -replace '([a-z0-9])([A-Z])', '$1 $2'
    return ($leaf -replace '\.', ' ')
}

function Get-HcsElementDisplayStringContent {
    [CmdletBinding()]
    param([Parameter(Mandatory)][xml]$ManagementPack)

    $result = [System.Text.StringBuilder]::new()
    foreach ($classType in $ManagementPack.SelectNodes('/ManagementPack/TypeDefinitions/EntityTypes/ClassTypes/ClassType')) {
        foreach ($property in $classType.SelectNodes('Property')) {
            $name = [System.Security.SecurityElement]::Escape((ConvertTo-HcsDisplayName -Value ([string]$property.ID)))
            [void]$result.AppendLine("        <DisplayString ElementID=`"$($classType.ID)`" SubElementID=`"$($property.ID)`"><Name>$name</Name></DisplayString>")
        }
    }
    foreach ($relationship in $ManagementPack.SelectNodes('/ManagementPack/TypeDefinitions/EntityTypes/RelationshipTypes/RelationshipType')) {
        $name = [System.Security.SecurityElement]::Escape((ConvertTo-HcsDisplayName -Value ([string]$relationship.ID)))
        [void]$result.AppendLine("        <DisplayString ElementID=`"$($relationship.ID)`"><Name>$name</Name></DisplayString>")
    }
    return $result.ToString().TrimEnd()
}

$sourceRoot = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$manifestPath = Join-Path $sourceRoot 'build/build-manifest.json'
$manifest = Get-Content -LiteralPath $manifestPath -Raw | ConvertFrom-Json

if ($manifest.namespace -ne 'HybridSolutionsCloud.HyperVPrivateCloud') {
    throw "Unexpected v2 namespace '$($manifest.namespace)'."
}

$requiredPlanned = @($manifest.artifacts | Where-Object { $_.required -and $_.implementationStatus -ne 'Authored' })
if ($RequireComplete -and $requiredPlanned.Count -gt 0) {
    $missing = $requiredPlanned.id -join ', '
    throw "The v2 source is not complete. Required artifacts not yet authored: $missing"
}

if ([string]::IsNullOrWhiteSpace($OutputPath)) {
    $OutputPath = Join-Path $sourceRoot 'out/development'
}

$resolvedOutput = [System.IO.Path]::GetFullPath($OutputPath)
[System.IO.Directory]::CreateDirectory($resolvedOutput) | Out-Null
$builtArtifacts = [System.Collections.Generic.List[object]]::new()

foreach ($artifact in @($manifest.artifacts | Where-Object implementationStatus -eq 'Authored')) {
    $sourcePath = Join-Path $sourceRoot $artifact.source
    if (-not (Test-Path -LiteralPath $sourcePath -PathType Leaf)) {
        throw "Authored Management Pack source does not exist: $sourcePath"
    }

    $content = Get-Content -LiteralPath $sourcePath -Raw
    $content = $content.Replace('{{VERSION}}', $Version)
    $content = $content.Replace('{{PUBLIC_KEY_TOKEN}}', $PublicKeyToken.ToLowerInvariant())
    if ($artifact.kind -eq 'Discovery') {
        $discoveryScriptPath = Join-Path (Split-Path -Parent $sourcePath) 'Discover-HyperVPrivateCloudTopology.ps1.template'
        if (-not (Test-Path -LiteralPath $discoveryScriptPath -PathType Leaf)) {
            throw "Discovery script source does not exist: $discoveryScriptPath"
        }
        $discoveryScript = Get-Content -LiteralPath $discoveryScriptPath -Raw
        if ($discoveryScript.Contains(']]>')) {
            throw "Discovery script contains the CDATA terminator: $discoveryScriptPath"
        }
        $content = $content.Replace('{{TOPOLOGY_DISCOVERY_SCRIPT}}', $discoveryScript.TrimEnd())
    }
    if ($artifact.kind -eq 'Library' -or $artifact.id.EndsWith('.Library', [System.StringComparison]::Ordinal)) {
        [xml]$librarySource = $content.Replace('{{ELEMENT_DISPLAY_STRINGS}}', '')
        $content = $content.Replace(
            '{{ELEMENT_DISPLAY_STRINGS}}',
            (Get-HcsElementDisplayStringContent -ManagementPack $librarySource)
        )
    }
    if ($content -match '\{\{[A-Z_]+\}\}') {
        throw "Unresolved build token in $sourcePath"
    }

    try {
        [xml]$xml = $content
    }
    catch {
        throw "Generated XML is not well formed for $($artifact.id): $($_.Exception.Message)"
    }

    if ([string]$xml.ManagementPack.Manifest.Identity.ID -ne $artifact.id) {
        throw "Generated Management Pack identity does not match '$($artifact.id)'."
    }
    if ([string]$xml.ManagementPack.Manifest.Identity.Version -ne $Version) {
        throw "Generated Management Pack '$($artifact.id)' does not use version '$Version'."
    }

    $outputFile = Join-Path $resolvedOutput $artifact.output
    [System.IO.File]::WriteAllText($outputFile, $content, [System.Text.UTF8Encoding]::new($false))
    $builtArtifacts.Add([pscustomobject]@{
            id = $artifact.id
            version = $Version
            output = $artifact.output
            releaseForm = $artifact.releaseForm
            sealed = $false
        })
}

$buildReceipt = [ordered]@{
    schemaVersion = '1.0'
    productName = $manifest.productName
    productVersion = $Version
    complete = ($requiredPlanned.Count -eq 0)
    pendingRequiredArtifacts = @($requiredPlanned.id)
    artifacts = @($builtArtifacts)
}
$receiptPath = Join-Path $resolvedOutput 'build-receipt.json'
[System.IO.File]::WriteAllText(
    $receiptPath,
    ($buildReceipt | ConvertTo-Json -Depth 6),
    [System.Text.UTF8Encoding]::new($false)
)

Write-Host "Built $($builtArtifacts.Count) authored v2 Management Pack artifact(s) in '$resolvedOutput'."
if ($requiredPlanned.Count -gt 0) {
    Write-Host "Required artifacts still planned: $($requiredPlanned.id -join ', ')."
}
