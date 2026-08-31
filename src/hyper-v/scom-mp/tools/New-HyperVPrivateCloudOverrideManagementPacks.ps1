#Requires -Version 7.0
<#
.SYNOPSIS
    Generates capability-aware Hyper-V Private Cloud Discovery and Monitoring override MPs.

.DESCRIPTION
    Renders a supported deployment profile and Lab, Standard, or Strict tuning tier into two
    customer-owned, unsealed Management Packs. Every workflow, context class, module, parameter,
    and product reference comes from the explicit v2 tuning catalog. The product reference version
    is independent from the customer override MP version.

.PARAMETER DeploymentProfile
    Supported capability composition from packages.json, such as Standalone, ClusteredS2D, or
    CompletePrivateCloud.

.PARAMETER TuningTier
    Reviewed Lab, Standard, or Strict starter values.

.PARAMETER OrganizationId
    XML-safe customer identifier used as the Management Pack ID prefix.

.PARAMETER OrganizationName
    Customer name used in console display strings.

.PARAMETER PublicProfile
    Emits the official HCS public starter profile rather than a customer-prefixed copy.

.PARAMETER EmitExample
    Emits deterministic public .xml.example files containing release-time version and token
    placeholders. Example files are source evidence and are replaced with real identities during
    governed release packaging.

.PARAMETER Version
    Independent four-part version for the unsealed override MPs. Defaults to 1.0.0.0.

.PARAMETER ProductVersion
    Exact four-part version of the installed sealed HCS v2 product MPs. No default is permitted.

.PARAMETER PublicKeyToken
    Exact public key token of the installed sealed HCS v2 product MPs.

.PARAMETER OutputPath
    Destination directory for the two generated files.

.PARAMETER ProfilePath
    Optional custom schema-2.0 deployment profile containing capabilities, same-MP groups, and
    targeting declarations. Unknown capabilities and cross-MP group targets fail generation.

.PARAMETER CatalogPath
    Optional explicit tuning catalog path, primarily for offline validation tests.

.PARAMETER ContractPath
    Optional explicit package/profile contract path, primarily for offline validation tests.

.EXAMPLE
    ./New-HyperVPrivateCloudOverrideManagementPacks.ps1 -DeploymentProfile ClusteredS2D `
        -TuningTier Standard -OrganizationId Contoso -OrganizationName 'Contoso' `
        -Version 2.0.0.0 -ProductVersion 2.0.0.0 -PublicKeyToken 0123456789abcdef `
        -OutputPath ./out

.NOTES
    Author: Kristopher Turner
    Contact: kris@hybridsolutions.cloud
    Version: 2.0.0
#>

[Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingWriteHost', '', Justification = 'HCS scripting standard requires Write-Host for operator status.')]
[CmdletBinding(DefaultParameterSetName = 'Customer')]
param(
    [Parameter(Mandatory)]
    [ValidatePattern('^[A-Za-z][A-Za-z0-9]*$')]
    [string]$DeploymentProfile,

    [Parameter(Mandatory)]
    [ValidateSet('Lab', 'Standard', 'Strict')]
    [string]$TuningTier,

    [Parameter(Mandatory, ParameterSetName = 'Customer')]
    [ValidatePattern('^[A-Za-z][A-Za-z0-9.]*$')]
    [string]$OrganizationId,

    [Parameter(Mandatory, ParameterSetName = 'Customer')]
    [ValidateNotNullOrEmpty()]
    [string]$OrganizationName,

    [Parameter(Mandatory, ParameterSetName = 'Public')]
    [switch]$PublicProfile,

    [Parameter(Mandatory, ParameterSetName = 'Example')]
    [switch]$EmitExample,

    [Parameter(ParameterSetName = 'Customer')]
    [Parameter(ParameterSetName = 'Public')]
    [ValidatePattern('^\d+\.\d+\.\d+\.\d+$')]
    [string]$Version = '1.0.0.0',

    [Parameter(Mandatory, ParameterSetName = 'Customer')]
    [Parameter(Mandatory, ParameterSetName = 'Public')]
    [ValidatePattern('^\d+\.\d+\.\d+\.\d+$')]
    [string]$ProductVersion,

    [Parameter(Mandatory, ParameterSetName = 'Customer')]
    [Parameter(Mandatory, ParameterSetName = 'Public')]
    [ValidatePattern('^[0-9a-fA-F]{16}$')]
    [string]$PublicKeyToken,

    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [string]$OutputPath,

    [Parameter()]
    [ValidateScript({ Test-Path -LiteralPath $_ -PathType Leaf })]
    [string]$ProfilePath,

    [Parameter()]
    [ValidateScript({ Test-Path -LiteralPath $_ -PathType Leaf })]
    [string]$CatalogPath,

    [Parameter()]
    [ValidateScript({ Test-Path -LiteralPath $_ -PathType Leaf })]
    [string]$ContractPath
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function ConvertTo-HcsXmlText {
    param([Parameter(Mandatory)][AllowEmptyString()][string]$Value)
    return [System.Security.SecurityElement]::Escape($Value)
}

function ConvertTo-HcsOverrideValue {
    param([Parameter(Mandatory)][AllowEmptyString()][object]$Value)
    if ($Value -is [bool]) { return $Value.ToString().ToLowerInvariant() }
    return [string]$Value
}

function Get-HcsDocumentKind {
    param([Parameter(Mandatory)][ValidateSet('Discovery', 'Monitor', 'Rule')][string]$WorkflowKind)
    if ($WorkflowKind -eq 'Discovery') { return 'Discovery' }
    return 'Monitoring'
}

function Get-HcsReferenceText {
    param(
        [Parameter(Mandatory)][object[]]$References,
        [Parameter(Mandatory)][System.Collections.Generic.HashSet[string]]$RequiredAliases,
        [Parameter(Mandatory)][string]$ProductManagementPackVersion,
        [Parameter(Mandatory)][string]$ProductToken
    )

    $builder = [System.Text.StringBuilder]::new()
    foreach ($reference in $References) {
        if (-not $RequiredAliases.Contains([string]$reference.alias)) { continue }
        $isProductReference = $null -ne $reference.PSObject.Properties['versionSource'] -and [string]$reference.versionSource -eq 'product'
        $version = if ($isProductReference) { $ProductManagementPackVersion } else { [string]$reference.version }
        $token = if ($isProductReference) { $ProductToken } else { [string]$reference.publicKeyToken }
        $tokenText = if ($token -like '{{*}}') { $token } else { $token.ToLowerInvariant() }
        [void]$builder.AppendLine("      <Reference Alias=`"$($reference.alias)`"><ID>$($reference.id)</ID><Version>$version</Version><PublicKeyToken>$tokenText</PublicKeyToken></Reference>")
    }
    return $builder.ToString().TrimEnd()
}

function Get-HcsGroupSection {
    param(
        [Parameter(Mandatory)][AllowEmptyCollection()][object[]]$Groups,
        [Parameter(Mandatory)][string]$ManagementPackId
    )

    $classBuilder = [System.Text.StringBuilder]::new()
    $discoveryBuilder = [System.Text.StringBuilder]::new()
    $displayBuilder = [System.Text.StringBuilder]::new()
    foreach ($group in $Groups) {
        $classId = "$ManagementPackId.Group.$($group.id)"
        $discoveryId = "$classId.Discovery"
        [void]$classBuilder.AppendLine("        <ClassType ID=`"$classId`" Accessibility=`"Public`" Abstract=`"false`" Base=`"InstanceGroup!Microsoft.SystemCenter.InstanceGroup`" Hosted=`"false`" Singleton=`"true`" Extension=`"false`" />")
        [void]$discoveryBuilder.AppendLine("      <Discovery ID=`"$discoveryId`" Enabled=`"true`" Target=`"$classId`" ConfirmDelivery=`"false`" Remotable=`"true`" Priority=`"Normal`">")
        [void]$discoveryBuilder.AppendLine('        <Category>Discovery</Category>')
        [void]$discoveryBuilder.AppendLine('        <DiscoveryTypes><DiscoveryRelationship TypeID="InstanceGroup!Microsoft.SystemCenter.InstanceGroupContainsEntities" /></DiscoveryTypes>')
        [void]$discoveryBuilder.AppendLine('        <DataSource ID="GroupPopulation" TypeID="SC!Microsoft.SystemCenter.GroupPopulator">')
        [void]$discoveryBuilder.AppendLine('          <RuleId>$MPElement$</RuleId>')
        [void]$discoveryBuilder.AppendLine("          <GroupInstanceId>`$MPElement[Name=`"$classId`"]`$</GroupInstanceId>")
        [void]$discoveryBuilder.AppendLine('          <MembershipRules><MembershipRule>')
        [void]$discoveryBuilder.AppendLine("            <MonitoringClass>`$MPElement[Name=`"$($group.memberClassRef)!$($group.memberClassId)`"]`$</MonitoringClass>")
        [void]$discoveryBuilder.AppendLine('            <RelationshipClass>$MPElement[Name="InstanceGroup!Microsoft.SystemCenter.InstanceGroupContainsEntities"]$</RelationshipClass>')
        [void]$discoveryBuilder.AppendLine('          </MembershipRule></MembershipRules>')
        [void]$discoveryBuilder.AppendLine('        </DataSource>')
        [void]$discoveryBuilder.AppendLine('      </Discovery>')
        $groupName = ConvertTo-HcsXmlText -Value ([string]$group.displayName)
        [void]$displayBuilder.AppendLine("        <DisplayString ElementID=`"$classId`"><Name>$groupName</Name><Description>Dynamic override-target group generated in the same unsealed Management Pack as the overrides that reference it.</Description></DisplayString>")
        [void]$displayBuilder.AppendLine("        <DisplayString ElementID=`"$discoveryId`"><Name>Populate $groupName</Name></DisplayString>")
    }

    return [pscustomobject]@{
        TypeDefinitions = if ($Groups.Count -gt 0) { "  <TypeDefinitions><EntityTypes><ClassTypes>`n$($classBuilder.ToString().TrimEnd())`n      </ClassTypes></EntityTypes></TypeDefinitions>" } else { '' }
        Discoveries = if ($Groups.Count -gt 0) { "    <Discoveries>`n$($discoveryBuilder.ToString().TrimEnd())`n    </Discoveries>" } else { '' }
        DisplayStrings = $displayBuilder.ToString().TrimEnd()
    }
}

function Get-HcsOverrideElement {
    param(
        [Parameter(Mandatory)][object]$Setting,
        [Parameter(Mandatory)][object]$TargetSet,
        [Parameter(Mandatory)][object]$Target,
        [Parameter(Mandatory)][string]$Context,
        [Parameter(Mandatory)][string]$OverrideId,
        [Parameter(Mandatory)][string]$Value
    )

    $workflow = "$($Target.workflowRef)!$($Target.workflowId)"
    switch ([string]$TargetSet.kind) {
        'Discovery' {
            if ([string]$Setting.type -ne 'Configuration') { throw "Discovery setting '$($Setting.id)' must use type Configuration." }
            return "      <DiscoveryConfigurationOverride ID=`"$OverrideId`" Context=`"$Context`" Enforced=`"false`" Discovery=`"$workflow`" Module=`"$($Target.module)`" Parameter=`"$($Setting.parameter)`"><Value>$Value</Value></DiscoveryConfigurationOverride>"
        }
        'Monitor' {
            if ([string]$Setting.type -eq 'Property') {
                return "      <MonitorPropertyOverride ID=`"$OverrideId`" Context=`"$Context`" Enforced=`"false`" Monitor=`"$workflow`" Property=`"$($Setting.property)`"><Value>$Value</Value></MonitorPropertyOverride>"
            }
            return "      <MonitorConfigurationOverride ID=`"$OverrideId`" Context=`"$Context`" Enforced=`"false`" Monitor=`"$workflow`" Parameter=`"$($Setting.parameter)`"><Value>$Value</Value></MonitorConfigurationOverride>"
        }
        'Rule' {
            if ([string]$Setting.type -eq 'Property') {
                return "      <RulePropertyOverride ID=`"$OverrideId`" Context=`"$Context`" Enforced=`"false`" Rule=`"$workflow`" Property=`"$($Setting.property)`"><Value>$Value</Value></RulePropertyOverride>"
            }
            return "      <RuleConfigurationOverride ID=`"$OverrideId`" Context=`"$Context`" Enforced=`"false`" Rule=`"$workflow`" Module=`"$($Target.module)`" Parameter=`"$($Setting.parameter)`"><Value>$Value</Value></RuleConfigurationOverride>"
        }
    }
}

$v2Root = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$catalogFile = if ($CatalogPath) { (Resolve-Path -LiteralPath $CatalogPath).Path } else { Join-Path $v2Root 'templates/overrides/tuning-catalog.json' }
$contractFile = if ($ContractPath) { (Resolve-Path -LiteralPath $ContractPath).Path } else { Join-Path $v2Root 'contracts/packages.json' }
$catalog = Get-Content -LiteralPath $catalogFile -Raw | ConvertFrom-Json
$contract = Get-Content -LiteralPath $contractFile -Raw | ConvertFrom-Json

if ([string]$catalog.schemaVersion -ne '2.0') { throw "Unsupported v2 tuning catalog schemaVersion '$($catalog.schemaVersion)'. Expected '2.0'." }
if ([string]$contract.schemaVersion -ne '1.0') { throw "Unsupported package contract schemaVersion '$($contract.schemaVersion)'. Expected '1.0'." }

$customProfile = -not [string]::IsNullOrWhiteSpace($ProfilePath)
if ($customProfile) {
    $deploymentDefinition = Get-Content -LiteralPath (Resolve-Path -LiteralPath $ProfilePath).Path -Raw | ConvertFrom-Json
    if ([string]$deploymentDefinition.schemaVersion -ne '2.0') { throw "Unsupported deployment profile schemaVersion '$($deploymentDefinition.schemaVersion)'. Expected '2.0'." }
    if ([string]$deploymentDefinition.id -ne $DeploymentProfile) { throw "Profile ID '$($deploymentDefinition.id)' does not match -DeploymentProfile '$DeploymentProfile'." }
}
else {
    $deploymentDefinition = @($contract.profiles | Where-Object { [string]$_.id -eq $DeploymentProfile }) | Select-Object -First 1
    if ($null -eq $deploymentDefinition) { throw "Unknown deployment profile '$DeploymentProfile'." }
}

$validCapabilities = @($contract.artifacts | Where-Object { [string]$_.id -match '\.Capability\.([^.]+)$' } | ForEach-Object { [regex]::Match([string]$_.id, '\.Capability\.([^.]+)$').Groups[1].Value })
$selectedCapabilities = @($deploymentDefinition.capabilities | ForEach-Object { [string]$_ })
foreach ($capability in $selectedCapabilities) {
    if ($capability -notin $validCapabilities) { throw "Deployment profile '$DeploymentProfile' contains unknown capability '$capability'." }
}

$referencesByAlias = @{}
foreach ($reference in $catalog.references) {
    if ($referencesByAlias.ContainsKey([string]$reference.alias)) { throw "Duplicate catalog reference alias '$($reference.alias)'." }
    $referencesByAlias[[string]$reference.alias] = $reference
}
$targetSetsById = @{}
foreach ($targetSet in $catalog.targetSets) {
    if ($targetSetsById.ContainsKey([string]$targetSet.id)) { throw "Duplicate target set '$($targetSet.id)'." }
    $targetSetsById[[string]$targetSet.id] = $targetSet
}
foreach ($setting in $catalog.settings) {
    if (-not $targetSetsById.ContainsKey([string]$setting.targetSet)) { throw "Setting '$($setting.id)' references unknown target set '$($setting.targetSet)'." }
    if ($null -eq $setting.values.$TuningTier) { throw "Setting '$($setting.id)' has no '$TuningTier' value." }
}

$groups = @()
$targeting = @()
if ($customProfile) {
    if ($null -ne $deploymentDefinition.PSObject.Properties['groups']) { $groups = @($deploymentDefinition.groups) }
    if ($null -ne $deploymentDefinition.PSObject.Properties['targeting']) { $targeting = @($deploymentDefinition.targeting) }
}
elseif ($null -ne $catalog.tierDefaults.PSObject.Properties[$TuningTier]) {
    $tierDefault = $catalog.tierDefaults.$TuningTier
    if ($null -ne $tierDefault.PSObject.Properties['groups']) { $groups = @($tierDefault.groups) }
    if ($null -ne $tierDefault.PSObject.Properties['targeting']) { $targeting = @($tierDefault.targeting) }
}

$groupsById = @{}
foreach ($group in $groups) {
    if ([string]$group.id -notmatch '^[A-Za-z][A-Za-z0-9.]*$') { throw "Group ID '$($group.id)' is not XML-safe." }
    if ([string]$group.kind -notin @('Discovery', 'Monitoring')) { throw "Group '$($group.id)' kind must be Discovery or Monitoring." }
    if ($groupsById.ContainsKey([string]$group.id)) { throw "Duplicate group '$($group.id)'." }
    if (-not $referencesByAlias.ContainsKey([string]$group.memberClassRef)) { throw "Group '$($group.id)' uses unknown memberClassRef '$($group.memberClassRef)'." }
    $groupsById[[string]$group.id] = $group
}
$targetingByTargetSet = @{}
foreach ($target in $targeting) {
    if (-not $targetSetsById.ContainsKey([string]$target.targetSet)) { throw "Targeting declaration references unknown target set '$($target.targetSet)'." }
    if ([string]$target.type -notin @('class', 'group')) { throw "Targeting type '$($target.type)' for '$($target.targetSet)' must be class or group." }
    if ($targetingByTargetSet.ContainsKey([string]$target.targetSet)) { throw "Target set '$($target.targetSet)' has multiple targeting declarations." }
    if ([string]$target.type -eq 'group') {
        if (-not $groupsById.ContainsKey([string]$target.groupRef)) { throw "Target set '$($target.targetSet)' references unknown group '$($target.groupRef)'." }
        $targetSet = $targetSetsById[[string]$target.targetSet]
        $documentKind = Get-HcsDocumentKind -WorkflowKind ([string]$targetSet.kind)
        if ([string]$groupsById[[string]$target.groupRef].kind -ne $documentKind) {
            throw "Cross-MP group reference is not allowed: target set '$($target.targetSet)' is in the $documentKind Overrides MP but group '$($target.groupRef)' is in the $($groupsById[[string]$target.groupRef].kind) Overrides MP."
        }
    }
    $targetingByTargetSet[[string]$target.targetSet] = $target
}

# Public and example override packs carry no organisation prefix: they are named for the product
# they override, not for their author. A customer generating their own passes -OrganizationId and
# gets the conventional "<Org>.HyperVPrivateCloud.Overrides.*" identity.
$isPublicArtifact = $PublicProfile -or $EmitExample
$organizationIdValue = if ($isPublicArtifact) { '' } else { $OrganizationId }
$organizationNameValue = if ($isPublicArtifact) { 'Hybrid Solutions Cloud' } else { $OrganizationName }
$customerVersion = if ($EmitExample) { '{{VERSION}}' } else { $Version }
$productVersionValue = if ($EmitExample) { '{{PRODUCT_VERSION}}' } else { $ProductVersion }
$productTokenValue = if ($EmitExample) { '{{PUBLIC_KEY_TOKEN}}' } else { $PublicKeyToken.ToLowerInvariant() }
$outputDirectory = [System.IO.Path]::GetFullPath($OutputPath)
[System.IO.Directory]::CreateDirectory($outputDirectory) | Out-Null

foreach ($documentKind in @('Discovery', 'Monitoring')) {
    $idPrefix = if ([string]::IsNullOrWhiteSpace($organizationIdValue)) { '' } else { "$organizationIdValue." }
    $managementPackId = "${idPrefix}HyperVPrivateCloud.Overrides.$DeploymentProfile.$TuningTier.$documentKind"
    $displayName = if ($isPublicArtifact) {
        "Hyper-V Private Cloud Monitoring - $DeploymentProfile $TuningTier $documentKind Overrides"
    }
    else {
        "$(ConvertTo-HcsXmlText -Value $organizationNameValue) - Hyper-V Private Cloud $DeploymentProfile $TuningTier $documentKind Overrides"
    }
    $documentGroups = @($groups | Where-Object { [string]$_.kind -eq $documentKind })
    $groupSections = Get-HcsGroupSection -Groups $documentGroups -ManagementPackId $managementPackId
    $requiredAliases = [System.Collections.Generic.HashSet[string]]::new([System.StringComparer]::Ordinal)
    $overrides = [System.Text.StringBuilder]::new()

    foreach ($setting in $catalog.settings) {
        $targetSet = $targetSetsById[[string]$setting.targetSet]
        if ((Get-HcsDocumentKind -WorkflowKind ([string]$targetSet.kind)) -ne $documentKind) { continue }
        if ([string]$targetSet.capability -ne 'Core' -and [string]$targetSet.capability -notin $selectedCapabilities) { continue }
        $targetingDeclaration = if ($targetingByTargetSet.ContainsKey([string]$targetSet.id)) { $targetingByTargetSet[[string]$targetSet.id] } else { $null }

        foreach ($target in $targetSet.targets) {
            if (-not $referencesByAlias.ContainsKey([string]$target.workflowRef)) { throw "Target '$($target.id)' uses unknown workflowRef '$($target.workflowRef)'." }
            [void]$requiredAliases.Add([string]$target.workflowRef)
            $context = if ($null -ne $targetingDeclaration -and [string]$targetingDeclaration.type -eq 'group') {
                "$managementPackId.Group.$($targetingDeclaration.groupRef)"
            }
            else {
                if (-not $referencesByAlias.ContainsKey([string]$target.contextRef)) { throw "Target '$($target.id)' uses unknown contextRef '$($target.contextRef)'." }
                [void]$requiredAliases.Add([string]$target.contextRef)
                "$($target.contextRef)!$($target.contextClassId)"
            }
            $value = ConvertTo-HcsOverrideValue -Value $setting.values.$TuningTier
            $overrideId = "$managementPackId.$($setting.id).$($target.id).Override"
            [void]$overrides.AppendLine((Get-HcsOverrideElement -Setting $setting -TargetSet $targetSet -Target $target -Context $context -OverrideId $overrideId -Value $value))
        }
    }

    foreach ($group in $documentGroups) {
        [void]$requiredAliases.Add('SC')
        [void]$requiredAliases.Add('InstanceGroup')
        [void]$requiredAliases.Add([string]$group.memberClassRef)
    }
    $referenceText = Get-HcsReferenceText -References @($catalog.references) -RequiredAliases $requiredAliases -ProductManagementPackVersion $productVersionValue -ProductToken $productTokenValue
    $description = "Unsealed, customer-owned $TuningTier starter overrides for the $DeploymentProfile deployment profile. Review in a test management group, customize locally, and export after every change."
    $typeDefinitionsText = if ([string]::IsNullOrWhiteSpace($groupSections.TypeDefinitions)) { '' } else { "`n$($groupSections.TypeDefinitions)" }
    $discoveriesText = if ([string]::IsNullOrWhiteSpace($groupSections.Discoveries)) { '' } else { "`n$($groupSections.Discoveries)" }
    $groupDisplayText = if ([string]::IsNullOrWhiteSpace($groupSections.DisplayStrings)) { '' } else { "`n$($groupSections.DisplayStrings)" }
    $document = @"
<?xml version="1.0" encoding="utf-8"?>
<ManagementPack ContentReadable="true" SchemaVersion="2.0" OriginalSchemaVersion="2.0" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <Manifest>
    <Identity><ID>$managementPackId</ID><Version>$customerVersion</Version></Identity>
    <Name>$displayName</Name>
    <References>
$referenceText
    </References>
  </Manifest>$typeDefinitionsText
  <Monitoring>$discoveriesText
    <Overrides>
$($overrides.ToString().TrimEnd())
    </Overrides>
  </Monitoring>
  <LanguagePacks><LanguagePack ID="ENU" IsDefault="true"><DisplayStrings>
        <DisplayString ElementID="$managementPackId"><Name>$displayName</Name><Description>$description</Description></DisplayString>$groupDisplayText
      </DisplayStrings></LanguagePack></LanguagePacks>
</ManagementPack>
"@

    [xml]$document | Out-Null
    $extension = if ($EmitExample) { 'xml.example' } else { 'xml' }
    $fileName = "$managementPackId.$extension"
    $outputFile = Join-Path $outputDirectory $fileName
    [System.IO.File]::WriteAllText($outputFile, $document, [System.Text.UTF8Encoding]::new($false))
    Write-Host "Generated $documentKind overrides: $outputFile" -ForegroundColor Green
}
