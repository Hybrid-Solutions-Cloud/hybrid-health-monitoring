#Requires -Version 7.0
<#
.SYNOPSIS
    Generates customer-owned Hyper-V Discovery and Monitoring override Management Packs.

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
    Four-part version for the generated unsealed Management Packs. This customer-owned version is
    independent of the installed sealed product version and defaults to 1.0.0.0.

.PARAMETER ProductVersion
    Four-part version of the installed sealed Hyper-V product Management Packs. This value is
    mandatory because an incorrect reference version produces an override MP that cannot import.

.PARAMETER PublicKeyToken
    Public key token of the sealed Hyper-V product Management Packs.

.PARAMETER OutputPath
    Destination directory for the generated customer-owned XML files.

.PARAMETER ProfilePath
    Optional path to a compatible profile manifest. When omitted, the selected built-in profile is
    used. Custom profiles must declare the supported schemaVersion.

.NOTES
    Author: Kristopher Turner
    Contact: kris@hybridsolutions.cloud
    Version: 1.1.0
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
    [string]$Version = '1.0.0.0',

    [Parameter(Mandatory)]
    [ValidatePattern('^\d+\.\d+\.\d+\.\d+$')]
    [string]$ProductVersion,

    [Parameter(Mandatory)]
    [ValidatePattern('^[0-9a-fA-F]{16}$')]
    [string]$PublicKeyToken,

    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [string]$OutputPath,

    [Parameter()]
    [ValidateScript({ Test-Path -LiteralPath $_ -PathType Leaf })]
    [string]$ProfilePath
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
        [Parameter(Mandatory)][string]$CustomerManagementPackVersion,
        [Parameter(Mandatory)][string]$ProductManagementPackVersion,
        [Parameter(Mandatory)][string]$ProductPublicKeyToken,
        [Parameter(Mandatory)][string]$SelectedTuningProfile
    )

    $organizationNameXml = ConvertTo-XmlText -Value $CustomerOrganizationName
    $managementPackId = if ($CustomerOrganizationId -eq 'HybridSolutionsCloud') {
        "HybridSolutionsCloud.HyperV.$Kind.Overrides.$SelectedTuningProfile"
    }
    else {
        "$CustomerOrganizationId.HybridSolutionsCloud.HyperV.$Kind.Overrides"
    }
    $displayName = if ($CustomerOrganizationId -eq 'HybridSolutionsCloud') {
        "Hybrid Solutions Cloud Hyper-V $Kind Overrides ($SelectedTuningProfile)"
    }
    else {
        "$organizationNameXml Hyper-V $Kind Overrides ($SelectedTuningProfile starter)"
    }
    $description = if ($CustomerOrganizationId -eq 'HybridSolutionsCloud') {
        "Official unsealed $SelectedTuningProfile profile for the Hybrid Solutions Cloud Hyper-V Management Pack. Import only one public tuning profile."
    }
    else {
        "Customer-owned unsealed overrides generated from the reviewed $SelectedTuningProfile starter profile."
    }
    $productId = "HybridSolutionsCloud.HyperV.$Kind"
    $alias = "HCSHyperV$Kind"
    return @"
<?xml version="1.0" encoding="utf-8"?>
<ManagementPack ContentReadable="true" SchemaVersion="2.0" OriginalSchemaVersion="2.0" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <Manifest>
    <Identity><ID>$managementPackId</ID><Version>$CustomerManagementPackVersion</Version></Identity>
    <Name>$displayName</Name>
    <References>
      <Reference Alias="HCSHyperVLibrary"><ID>HybridSolutionsCloud.HyperV.Library</ID><Version>$ProductManagementPackVersion</Version><PublicKeyToken>$($ProductPublicKeyToken.ToLowerInvariant())</PublicKeyToken></Reference>
      <Reference Alias="$alias"><ID>$productId</ID><Version>$ProductManagementPackVersion</Version><PublicKeyToken>$($ProductPublicKeyToken.ToLowerInvariant())</PublicKeyToken></Reference>
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
$profilePath = if ($ProfilePath) {
    (Resolve-Path -LiteralPath $ProfilePath).Path
}
else {
    Join-Path $sourceRoot "templates/overrides/$($TuningProfile.ToLowerInvariant())/profile.json"
}
$profileData = Get-Content -LiteralPath $profilePath -Raw | ConvertFrom-Json
if ([string]$profileData.schemaVersion -ne '1.2') {
    throw "Unsupported Hyper-V override profile schemaVersion '$($profileData.schemaVersion)'. Expected '1.2'."
}
$OrganizationId = if ($PublicProfile) { 'HybridSolutionsCloud' } else { $OrganizationId }
$OrganizationName = if ($PublicProfile) { 'Hybrid Solutions Cloud' } else { $OrganizationName }
$overrideIdPrefix = if ($PublicProfile) { "HybridSolutionsCloud.HyperV.$TuningProfile" } else { "$OrganizationId.HyperV" }
$outputDirectory = [System.IO.Path]::GetFullPath($OutputPath)
[System.IO.Directory]::CreateDirectory($outputDirectory) | Out-Null

$discoveryOverrides = [System.Text.StringBuilder]::new()
foreach ($setting in $profileData.discoverySettings) {
    $id = "$overrideIdPrefix.Discovery.$($setting.id).Override"
    [void]$discoveryOverrides.AppendLine("    <DiscoveryConfigurationOverride ID=`"$id`" Context=`"HCSHyperVLibrary!$($setting.contextClassId)`" Enforced=`"false`" Discovery=`"HCSHyperVDiscovery!$($setting.workflowId)`"><Module>$($setting.module)</Module><Parameter>$($setting.parameter)</Parameter><Value>$($setting.value)</Value></DiscoveryConfigurationOverride>")
}

$monitoringOverrides = [System.Text.StringBuilder]::new()
foreach ($setting in $profileData.monitoringSettings) {
    foreach ($target in $setting.targets) {
        $id = "$overrideIdPrefix.Monitoring.$($target.id).$($setting.parameter).Override"
        [void]$monitoringOverrides.AppendLine("    <MonitorConfigurationOverride ID=`"$id`" Context=`"HCSHyperVLibrary!$($target.contextClassId)`" Enforced=`"false`" Monitor=`"HCSHyperVMonitoring!$($target.monitorId)`"><Parameter>$($setting.parameter)</Parameter><Value>$($setting.value)</Value></MonitorConfigurationOverride>")
    }
}

$documents = @{
    Discovery = Get-OverrideDocument -Kind Discovery -OverridesXml $discoveryOverrides.ToString() -CustomerOrganizationId $OrganizationId -CustomerOrganizationName $OrganizationName -CustomerManagementPackVersion $Version -ProductManagementPackVersion $ProductVersion -ProductPublicKeyToken $PublicKeyToken -SelectedTuningProfile $TuningProfile
    Monitoring = Get-OverrideDocument -Kind Monitoring -OverridesXml $monitoringOverrides.ToString() -CustomerOrganizationId $OrganizationId -CustomerOrganizationName $OrganizationName -CustomerManagementPackVersion $Version -ProductManagementPackVersion $ProductVersion -ProductPublicKeyToken $PublicKeyToken -SelectedTuningProfile $TuningProfile
}

foreach ($kind in $documents.Keys) {
    $fileName = if ($PublicProfile) { "HybridSolutionsCloud.HyperV.$kind.Overrides.$TuningProfile.xml" } else { "$OrganizationId.HybridSolutionsCloud.HyperV.$kind.Overrides.xml" }
    $path = Join-Path $outputDirectory $fileName
    [xml]$documents[$kind] | Out-Null
    [System.IO.File]::WriteAllText($path, $documents[$kind], [System.Text.UTF8Encoding]::new($false))
    Write-Host "Generated $kind overrides: $path" -ForegroundColor Green
}
