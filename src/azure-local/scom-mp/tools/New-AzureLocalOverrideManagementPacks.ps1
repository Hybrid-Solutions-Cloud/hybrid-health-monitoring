#Requires -Version 7.0
<#
.SYNOPSIS
    Generates customer-owned Azure Local Discovery and Monitoring override Management Packs.

.DESCRIPTION
    Converts a reviewed Lab, Standard, or Strict starter profile into two separate unsealed XML
    Management Packs. Customer mode creates organization-owned starting points. PublicProfile mode
    creates official first-party profile packs for broad distribution.

.PARAMETER TuningProfile
    Starter profile to render.

.PARAMETER OrganizationId
    XML-safe organization identifier used as the Management Pack ID prefix.

.PARAMETER OrganizationName
    Human-readable organization name used in Management Pack display names.

.PARAMETER PublicProfile
    Generates official product-owned profile packs instead of customer-prefixed starting points.

.PARAMETER Version
    Four-part version for the generated unsealed Management Packs and sealed product references.

.PARAMETER PublicKeyToken
    Public key token of the sealed Azure Local product Management Packs.

.PARAMETER OutputPath
    Destination directory for the generated customer-owned XML files.

.NOTES
    Author: Kristopher Turner
    Contact: kris@hybridsolutions.cloud
    Version: 1.0.0
#>

[Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingWriteHost', '', Justification = 'HCS scripting standard requires Write-Host for operator status.')]
[CmdletBinding(DefaultParameterSetName = 'Customer')]
param(
    [Parameter(Mandatory)]
    [ValidateSet('Lab', 'Standard', 'Strict')]
    [Alias('Profile')]
    [string]$TuningProfile,

    [Parameter(Mandatory, ParameterSetName = 'Customer')]
    [ValidatePattern('^[A-Za-z][A-Za-z0-9.]*$')]
    [string]$OrganizationId,

    [Parameter(Mandatory, ParameterSetName = 'Customer')]
    [ValidateNotNullOrEmpty()]
    [string]$OrganizationName,

    [Parameter(Mandatory, ParameterSetName = 'Public')]
    [switch]$PublicProfile,

    [Parameter()]
    [ValidatePattern('^\d+\.\d+\.\d+\.\d+$')]
    [string]$Version = '0.2.0.0',

    [Parameter(Mandatory)]
    [ValidatePattern('^[0-9a-fA-F]{16}$')]
    [string]$PublicKeyToken,

    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [string]$OutputPath
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function ConvertTo-XmlText {
    param([Parameter(Mandatory)][string]$Value)
    return [System.Security.SecurityElement]::Escape($Value)
}

function Get-OverrideDocument {
    param(
        [Parameter(Mandatory)][ValidateSet('Discovery', 'Monitoring')][string]$Kind,
        [Parameter(Mandatory)][string]$OverridesXml,
        [Parameter(Mandatory)][string]$CustomerOrganizationId,
        [Parameter(Mandatory)][string]$CustomerOrganizationName,
        [Parameter(Mandatory)][string]$ManagementPackVersion,
        [Parameter(Mandatory)][string]$ProductPublicKeyToken,
        [Parameter(Mandatory)][string]$SelectedTuningProfile
    )

    $organizationNameXml = ConvertTo-XmlText -Value $CustomerOrganizationName
    $managementPackId = if ($CustomerOrganizationId -eq 'HybridSolutionsCloud') {
        "HybridSolutionsCloud.AzureLocal.$Kind.Overrides.$SelectedTuningProfile"
    }
    else {
        "$CustomerOrganizationId.HybridSolutionsCloud.AzureLocal.$Kind.Overrides"
    }
    $displayName = if ($CustomerOrganizationId -eq 'HybridSolutionsCloud') {
        "Hybrid Solutions Cloud Azure Local $Kind Overrides ($SelectedTuningProfile)"
    }
    else {
        "$organizationNameXml Azure Local $Kind Overrides ($SelectedTuningProfile starter)"
    }
    $description = if ($CustomerOrganizationId -eq 'HybridSolutionsCloud') {
        "Official unsealed $SelectedTuningProfile profile for the Hybrid Solutions Cloud Azure Local Management Pack. Import only one public tuning profile."
    }
    else {
        "Customer-owned unsealed overrides generated from the reviewed $SelectedTuningProfile starter profile."
    }
    $productId = "HybridSolutionsCloud.AzureLocal.$Kind"
    $alias = "HCSAzureLocal$Kind"
    return @"
<?xml version="1.0" encoding="utf-8"?>
<ManagementPack ContentReadable="true" SchemaVersion="2.0" OriginalSchemaVersion="2.0" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <Manifest>
    <Identity><ID>$managementPackId</ID><Version>$ManagementPackVersion</Version></Identity>
    <Name>$displayName</Name>
    <References>
      <Reference Alias="HCSAzureLocalLibrary"><ID>HybridSolutionsCloud.AzureLocal.Library</ID><Version>$ManagementPackVersion</Version><PublicKeyToken>$($ProductPublicKeyToken.ToLowerInvariant())</PublicKeyToken></Reference>
      <Reference Alias="$alias"><ID>$productId</ID><Version>$ManagementPackVersion</Version><PublicKeyToken>$($ProductPublicKeyToken.ToLowerInvariant())</PublicKeyToken></Reference>
    </References>
  </Manifest>
  <Monitoring><Overrides>
$OverridesXml
  </Overrides></Monitoring>
  <LanguagePacks><LanguagePack ID="ENU" IsDefault="true"><DisplayStrings><DisplayString ElementID="$managementPackId"><Name>$displayName</Name><Description>$description</Description></DisplayString></DisplayStrings></LanguagePack></LanguagePacks>
</ManagementPack>
"@
}

$sourceRoot = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$profilePath = Join-Path $sourceRoot "templates/overrides/$($TuningProfile.ToLowerInvariant())/profile.json"
$profileData = Get-Content -LiteralPath $profilePath -Raw | ConvertFrom-Json
$OrganizationId = if ($PublicProfile) { 'HybridSolutionsCloud' } else { $OrganizationId }
$OrganizationName = if ($PublicProfile) { 'Hybrid Solutions Cloud' } else { $OrganizationName }
$overrideIdPrefix = if ($PublicProfile) { "HybridSolutionsCloud.AzureLocal.$TuningProfile" } else { "$OrganizationId.AzureLocal" }
$outputDirectory = [System.IO.Path]::GetFullPath($OutputPath)
[System.IO.Directory]::CreateDirectory($outputDirectory) | Out-Null

$discoveryOverrides = [System.Text.StringBuilder]::new()
foreach ($setting in $profileData.discoverySettings) {
    $id = "$overrideIdPrefix.Discovery.$($setting.id).Override"
    [void]$discoveryOverrides.AppendLine("    <DiscoveryConfigurationOverride ID=`"$id`" Context=`"HCSAzureLocalLibrary!$($setting.contextClassId)`" Enforced=`"false`" Discovery=`"HCSAzureLocalDiscovery!$($setting.workflowId)`"><Module>$($setting.module)</Module><Parameter>$($setting.parameter)</Parameter><Value>$($setting.value)</Value></DiscoveryConfigurationOverride>")
}

$monitoringOverrides = [System.Text.StringBuilder]::new()
foreach ($setting in $profileData.monitoringSettings) {
    foreach ($shortWorkflowId in $setting.workflowIds) {
        $monitorId = "HybridSolutionsCloud.AzureLocal.Node.$shortWorkflowId.Monitor"
        $id = "$overrideIdPrefix.Monitoring.$shortWorkflowId.$($setting.parameter).Override"
        [void]$monitoringOverrides.AppendLine("    <MonitorConfigurationOverride ID=`"$id`" Context=`"HCSAzureLocalLibrary!HybridSolutionsCloud.AzureLocal.NodeRole`" Enforced=`"false`" Monitor=`"HCSAzureLocalMonitoring!$monitorId`"><Parameter>$($setting.parameter)</Parameter><Value>$($setting.value)</Value></MonitorConfigurationOverride>")
    }
}

$documents = @{
    Discovery = Get-OverrideDocument -Kind Discovery -OverridesXml $discoveryOverrides.ToString() -CustomerOrganizationId $OrganizationId -CustomerOrganizationName $OrganizationName -ManagementPackVersion $Version -ProductPublicKeyToken $PublicKeyToken -SelectedTuningProfile $TuningProfile
    Monitoring = Get-OverrideDocument -Kind Monitoring -OverridesXml $monitoringOverrides.ToString() -CustomerOrganizationId $OrganizationId -CustomerOrganizationName $OrganizationName -ManagementPackVersion $Version -ProductPublicKeyToken $PublicKeyToken -SelectedTuningProfile $TuningProfile
}

foreach ($kind in $documents.Keys) {
    $fileName = if ($PublicProfile) { "HybridSolutionsCloud.AzureLocal.$kind.Overrides.$TuningProfile.xml" } else { "$OrganizationId.HybridSolutionsCloud.AzureLocal.$kind.Overrides.xml" }
    $path = Join-Path $outputDirectory $fileName
    [xml]$documents[$kind] | Out-Null
    [System.IO.File]::WriteAllText($path, $documents[$kind], [System.Text.UTF8Encoding]::new($false))
    Write-Host "Generated $kind overrides: $path" -ForegroundColor Green
}
