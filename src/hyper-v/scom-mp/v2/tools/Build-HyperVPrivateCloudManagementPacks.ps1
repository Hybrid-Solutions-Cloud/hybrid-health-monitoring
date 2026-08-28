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

function Get-HcsMonitoringContent {
    [CmdletBinding()]
    param()

    $hostDefinitions = @(
        @('VMMS', 'VMMSState', 'Hyper-V Virtual Machine Management service health', 'AvailabilityState', 'AvailabilityHealth', 'Error', 'Tracks the VMMS service required for Hyper-V management.', 'Verify the vmms service, dependencies, maintenance state, and recent Hyper-V VMMS events.'),
        @('VmCompute', 'VmComputeState', 'Hyper-V Host Compute service health', 'AvailabilityState', 'AvailabilityHealth', 'Error', 'Tracks the Host Compute Service used by modern Hyper-V workloads.', 'Verify the vmcompute service and Host Compute Service operational events.'),
        @('PowerShell', 'HyperVPowerShellState', 'Hyper-V monitoring capability', 'ConfigurationState', 'ConfigurationHealth', 'Error', 'Verifies that the Hyper-V PowerShell module required by discovery and monitoring is usable.', 'Install Hyper-V management tools and verify that the HealthService account can load the Hyper-V module.'),
        @('Hypervisor', 'HypervisorState', 'Hyper-V hypervisor health', 'AvailabilityState', 'AvailabilityHealth', 'Error', 'Verifies that the Hyper-V host interface responds.', 'Check hypervisor launch configuration, VMMS, virtualization firmware settings, and recent system events.'),
        @('Cpu', 'CpuState', 'Hyper-V host processor pressure', 'PerformanceState', 'PerformanceHealth', 'Error', 'Tracks sustained hypervisor logical-processor utilization.', 'Review root and guest virtual processor counters, NUMA placement, interrupts, DPCs, and workload placement.'),
        @('Memory', 'MemoryState', 'Hyper-V host available memory', 'PerformanceState', 'PerformanceHealth', 'Error', 'Tracks absolute memory available to the management partition.', 'Review Dynamic Memory demand, host reserve, paging, NUMA, and workload placement.'),
        @('Paging', 'PagingState', 'Hyper-V host hard paging', 'PerformanceState', 'PerformanceHealth', 'Warning', 'Tracks sustained pages read from disk as memory pressure evidence.', 'Correlate paging with available memory, storage latency, VM demand, and host reserve.'),
        @('VirtualMachines', 'VirtualMachineState', 'Hyper-V expected VM state', 'AvailabilityState', 'AvailabilityHealth', 'Error', 'Detects auto-start VMs that are unexpectedly stopped or failed.', 'Confirm expected-state policy, current owner, migration or failover activity, and VMMS events.'),
        @('Checkpoints', 'CheckpointState', 'Hyper-V checkpoint age', 'ConfigurationState', 'ConfigurationHealth', 'Warning', 'Detects checkpoints older than the configured operational threshold.', 'Confirm backup activity and checkpoint purpose, then merge or remove stale checkpoints using supported procedures.'),
        @('Replication', 'ReplicationState', 'Hyper-V Replica health', 'AvailabilityState', 'AvailabilityHealth', 'Warning', 'Tracks the worst Hyper-V Replica relationship health on the host.', 'Inspect replication connectivity, authentication, backlog, storage, and last successful replication.'),
        @('VirtualSwitches', 'VirtualSwitchState', 'Hyper-V virtual switch health', 'AvailabilityState', 'AvailabilityHealth', 'Error', 'Detects external virtual switches with no bound physical uplink.', 'Review switch type, SET membership, physical adapter state, and recent network configuration changes.'),
        @('StorageAttachments', 'StorageAttachmentState', 'Hyper-V virtual disk attachment health', 'AvailabilityState', 'AvailabilityHealth', 'Error', 'Detects missing or unreadable VHD/VHDX attachments.', 'Validate the VM disk path, storage availability, permissions, VHD chain, and active backup or merge operations.'),
        @('Pipeline', 'PipelineState', 'Hyper-V host monitoring pipeline health', 'AvailabilityState', 'AvailabilityHealth', 'Error', 'Tracks completion of the shared host health probe.', 'Review Operations Manager event 8201, workflow state, module availability, permissions, and timeout settings.')
    )
    $vmDefinitions = @(
        @('Availability', 'AvailabilityState', 'VM expected runtime state', 'AvailabilityState', 'AvailabilityHealth', 'Error', 'Tracks expected versus actual VM runtime state.', 'Confirm the VM start policy, current owner, maintenance state, clustered role, and VMMS events.'),
        @('Heartbeat', 'HeartbeatState', 'VM heartbeat integration service', 'AvailabilityState', 'AvailabilityHealth', 'Error', 'Tracks guest heartbeat while the VM is running.', 'Check guest OS state, integration services, CPU scheduling, storage latency, and guest event logs.'),
        @('IntegrationServices', 'IntegrationServicesState', 'VM integration services health', 'ConfigurationState', 'ConfigurationHealth', 'Warning', 'Tracks enabled Hyper-V integration-service status.', 'Review guest integration components, supported guest version, service status, and VM configuration.'),
        @('Checkpoints', 'CheckpointState', 'VM checkpoint age', 'ConfigurationState', 'ConfigurationHealth', 'Warning', 'Tracks checkpoint count and oldest age for this VM.', 'Confirm backup activity and checkpoint purpose before merging or removing stale checkpoints.'),
        @('Replication', 'ReplicationState', 'VM Replica relationship health', 'AvailabilityState', 'AvailabilityHealth', 'Warning', 'Tracks Replica health for this VM.', 'Inspect authentication, network reachability, storage, backlog, and replication events.'),
        @('Storage', 'StorageState', 'VM virtual disk availability', 'AvailabilityState', 'AvailabilityHealth', 'Error', 'Tracks availability and readability of attached VHD/VHDX files.', 'Validate the disk path, storage fabric, permissions, VHD chain, and merge or backup operations.'),
        @('Network', 'NetworkState', 'VM virtual network connectivity', 'AvailabilityState', 'AvailabilityHealth', 'Warning', 'Tracks VM adapters that are disconnected or unhealthy.', 'Check vNIC status, vSwitch binding, VLAN policy, port ACLs, and physical uplinks.'),
        @('MemoryPressure', 'MemoryPressureState', 'VM Dynamic Memory pressure', 'PerformanceState', 'PerformanceHealth', 'Warning', 'Tracks reported Dynamic Memory pressure for running VMs.', 'Review assigned and demanded memory, host reserve, guest workload, and Dynamic Memory limits.'),
        @('Pipeline', 'PipelineState', 'VM monitoring pipeline health', 'AvailabilityState', 'AvailabilityHealth', 'Error', 'Tracks completion of the per-VM health probe.', 'Review Operations Manager event 8202, VM ownership, module availability, permissions, and timeouts.')
    )

    $hostContent = Get-HcsTargetMonitorContent -Definitions $hostDefinitions -Kind Host
    $runtime = Get-HcsTargetMonitorContent -Definitions $vmDefinitions -Kind VmRuntime
    $rollup = Get-HcsRollupContent
    return [pscustomobject]@{
        HostMonitors = $hostContent.Monitors
        VmRuntimeMonitors = $runtime.Monitors
        RollupMonitors = $rollup.Monitors
        StringResources = $hostContent.StringResources + $runtime.StringResources
        DisplayStrings = $hostContent.DisplayStrings + $runtime.DisplayStrings
        RollupDisplayStrings = $rollup.DisplayStrings
        KnowledgeArticles = $hostContent.KnowledgeArticles + $runtime.KnowledgeArticles
    }
}

function Get-HcsTargetMonitorContent {
    [CmdletBinding()]
    param([Parameter(Mandatory)][array]$Definitions, [Parameter(Mandatory)][ValidateSet('Host', 'VmRuntime')][string]$Kind)

    $monitors = [System.Text.StringBuilder]::new()
    $resources = [System.Text.StringBuilder]::new()
    $displays = [System.Text.StringBuilder]::new()
    $knowledge = [System.Text.StringBuilder]::new()
    foreach ($definition in $Definitions) {
        $prefix = if ($Kind -eq 'Host') { 'Host' } else { 'VmRuntime' }
        $monitorId = "HybridSolutionsCloud.HyperVPrivateCloud.$prefix.$($definition[0]).Monitor"
        $messageId = "$monitorId.Message"
        $target = if ($Kind -eq 'Host') { 'HCSV2Library!HybridSolutionsCloud.HyperVPrivateCloud.HostRole' } else { 'HCSV2Library!HybridSolutionsCloud.HyperVPrivateCloud.VirtualMachineRuntime' }
        $typeId = if ($Kind -eq 'Host') { 'HybridSolutionsCloud.HyperVPrivateCloud.PropertyBag.ThreeState.MonitorType' } else { 'HybridSolutionsCloud.HyperVPrivateCloud.VmPropertyBag.ThreeState.MonitorType' }
        $alertState = if ($definition[5] -eq 'Warning') { 'Warning' } else { 'Error' }
        $configuration = if ($Kind -eq 'Host') {
            "<PropertyName>$($definition[1])</PropertyName><IntervalSeconds>300</IntervalSeconds><SyncTime /><TimeoutSeconds>120</TimeoutSeconds><CpuWarningPercent>80</CpuWarningPercent><CpuCriticalPercent>90</CpuCriticalPercent><MemoryWarningMB>4096</MemoryWarningMB><MemoryCriticalMB>2048</MemoryCriticalMB><PagesInputWarningPerSecond>5</PagesInputWarningPerSecond><PagesInputCriticalPerSecond>20</PagesInputCriticalPerSecond><CheckpointWarningHours>168</CheckpointWarningHours><CheckpointCriticalHours>336</CheckpointCriticalHours>"
        }
        else {
            '<PropertyName>{0}</PropertyName><VMId>$Target/Property[Type="HCSV2Library!HybridSolutionsCloud.HyperVPrivateCloud.VirtualMachineRuntime"]/VMId$</VMId><ExpectedState>$Target/Property[Type="HCSV2Library!HybridSolutionsCloud.HyperVPrivateCloud.VirtualMachineRuntime"]/ExpectedState$</ExpectedState><IntervalSeconds>300</IntervalSeconds><SyncTime /><TimeoutSeconds>120</TimeoutSeconds><CheckpointWarningHours>168</CheckpointWarningHours><CheckpointCriticalHours>336</CheckpointCriticalHours>' -f $definition[1]
        }
        [void]$monitors.AppendLine("      <UnitMonitor ID=`"$monitorId`" Accessibility=`"Public`" Enabled=`"true`" Target=`"$target`" ParentMonitorID=`"Health!System.Health.$($definition[3])`" Remotable=`"true`" Priority=`"Normal`" TypeID=`"$typeId`" ConfirmDelivery=`"true`"><Category>$($definition[4])</Category><AlertSettings AlertMessage=`"$messageId`"><AlertOnState>$alertState</AlertOnState><AutoResolve>true</AutoResolve><AlertPriority>Normal</AlertPriority><AlertSeverity>MatchMonitorHealth</AlertSeverity><AlertParameters><AlertParameter1>`$Data/Context/Property[@Name='$($definition[1])Detail']`$</AlertParameter1></AlertParameters></AlertSettings><OperationalStates><OperationalState ID=`"Good`" MonitorTypeStateID=`"Good`" HealthState=`"Success`" /><OperationalState ID=`"Warning`" MonitorTypeStateID=`"Warning`" HealthState=`"Warning`" /><OperationalState ID=`"Critical`" MonitorTypeStateID=`"Critical`" HealthState=`"Error`" /></OperationalStates><Configuration>$configuration</Configuration></UnitMonitor>")
        [void]$resources.AppendLine("<StringResource ID=`"$messageId`" />")
        [void]$displays.AppendLine("    <DisplayString ElementID=`"$monitorId`"><Name>$($definition[2])</Name><Description>$($definition[6])</Description></DisplayString>")
        foreach ($state in @('Good', 'Warning', 'Critical')) { [void]$displays.AppendLine("    <DisplayString ElementID=`"$monitorId`" SubElementID=`"$state`"><Name>$state</Name></DisplayString>") }
        [void]$displays.AppendLine("    <DisplayString ElementID=`"$messageId`"><Name>$($definition[2])</Name><Description>$($definition[6]) Detail: {0}</Description></DisplayString>")
        [void]$knowledge.AppendLine("    <KnowledgeArticle ElementID=`"$monitorId`" Visible=`"true`"><MamlContent><maml:section xmlns:maml=`"http://schemas.microsoft.com/maml/2004/10`"><maml:title>Summary</maml:title><maml:para>$($definition[6])</maml:para></maml:section><maml:section xmlns:maml=`"http://schemas.microsoft.com/maml/2004/10`"><maml:title>Operator response</maml:title><maml:para>$($definition[7])</maml:para></maml:section></MamlContent></KnowledgeArticle>")
    }
    return [pscustomobject]@{ Monitors = $monitors.ToString(); StringResources = $resources.ToString(); DisplayStrings = $displays.ToString(); KnowledgeArticles = $knowledge.ToString() }
}

function Get-HcsRollupContent {
    [CmdletBinding()]
    param()

    $monitors = [System.Text.StringBuilder]::new()
    $displays = [System.Text.StringBuilder]::new()
    $serviceBranches = @(
        @('Management', 'ManagementComponent'), @('Compute', 'ComputeComponent'), @('VirtualMachines', 'VirtualMachineComponent'), @('Availability', 'AvailabilityComponent'), @('Storage', 'StorageComponent'), @('Network', 'NetworkComponent'), @('Monitoring', 'MonitoringComponent')
    )
    foreach ($branch in $serviceBranches) {
        $id = "HybridSolutionsCloud.HyperVPrivateCloud.Service.$($branch[0]).Availability.Dependency.Monitor"
        $relationship = "HCSV2Library!HybridSolutionsCloud.HyperVPrivateCloud.ServiceContains$($branch[1])"
        [void]$monitors.AppendLine("      <DependencyMonitor ID=`"$id`" Accessibility=`"Public`" Enabled=`"true`" Target=`"HCSV2Library!HybridSolutionsCloud.HyperVPrivateCloud.Service`" ParentMonitorID=`"Health!System.Health.AvailabilityState`" Remotable=`"true`" Priority=`"Normal`" RelationshipType=`"$relationship`" MemberMonitor=`"Health!System.Health.AvailabilityState`"><Category>AvailabilityHealth</Category><Algorithm>WorstOf</Algorithm><MemberUnAvailable>Error</MemberUnAvailable></DependencyMonitor>")
        [void]$displays.AppendLine("    <DisplayString ElementID=`"$id`"><Name>Roll up $($branch[0]) availability</Name></DisplayString>")
    }
    $componentRollups = @(
        @('Management', 'ManagementComponent', 'ManagementComponentContainsHostRole'),
        @('Compute', 'ComputeComponent', 'ComputeComponentContainsHostRole'),
        @('VirtualMachines', 'VirtualMachineComponent', 'VirtualMachineComponentContainsRuntime'),
        @('Availability', 'AvailabilityComponent', 'AvailabilityComponentContainsRuntime'),
        @('Storage', 'StorageComponent', 'StorageComponentContainsRuntime'),
        @('Network', 'NetworkComponent', 'NetworkComponentContainsRuntime'),
        @('Monitoring', 'MonitoringComponent', 'MonitoringComponentContainsHostRole')
    )
    foreach ($rollup in $componentRollups) {
        $id = "HybridSolutionsCloud.HyperVPrivateCloud.$($rollup[0]).Members.Availability.Dependency.Monitor"
        [void]$monitors.AppendLine("      <DependencyMonitor ID=`"$id`" Accessibility=`"Public`" Enabled=`"true`" Target=`"HCSV2Library!HybridSolutionsCloud.HyperVPrivateCloud.$($rollup[1])`" ParentMonitorID=`"Health!System.Health.AvailabilityState`" Remotable=`"true`" Priority=`"Normal`" RelationshipType=`"HCSV2Library!HybridSolutionsCloud.HyperVPrivateCloud.$($rollup[2])`" MemberMonitor=`"Health!System.Health.AvailabilityState`"><Category>AvailabilityHealth</Category><Algorithm>WorstOf</Algorithm><MemberUnAvailable>Error</MemberUnAvailable></DependencyMonitor>")
        [void]$displays.AppendLine("    <DisplayString ElementID=`"$id`"><Name>Roll up $($rollup[0]) member availability</Name></DisplayString>")
    }
    return [pscustomobject]@{ Monitors = $monitors.ToString(); DisplayStrings = $displays.ToString() }
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
    if ($artifact.kind -eq 'Monitoring') {
        $monitoringDirectory = Split-Path -Parent $sourcePath
        $scriptTokens = [ordered]@{
            HOST_HEALTH_SCRIPT = 'Get-HyperVPrivateCloudHostHealth.ps1.template'
            VM_HEALTH_SCRIPT = 'Get-HyperVPrivateCloudVmHealth.ps1.template'
            DIAGNOSTIC_SCRIPT = 'Get-HyperVPrivateCloudDiagnosticSummary.ps1.template'
        }
        foreach ($entry in $scriptTokens.GetEnumerator()) {
            $monitoringScriptPath = Join-Path $monitoringDirectory $entry.Value
            if (-not (Test-Path -LiteralPath $monitoringScriptPath -PathType Leaf)) { throw "Monitoring script source does not exist: $monitoringScriptPath" }
            $monitoringScript = Get-Content -LiteralPath $monitoringScriptPath -Raw
            if ($monitoringScript.Contains(']]>')) { throw "Monitoring script contains the CDATA terminator: $monitoringScriptPath" }
            $content = $content.Replace("{{$($entry.Key)}}", $monitoringScript.TrimEnd())
        }
        $monitorContent = Get-HcsMonitoringContent
        $content = $content.Replace('{{HOST_MONITORS}}', $monitorContent.HostMonitors)
        $content = $content.Replace('{{VM_RUNTIME_MONITORS}}', $monitorContent.VmRuntimeMonitors)
        $content = $content.Replace('{{ROLLUP_MONITORS}}', $monitorContent.RollupMonitors)
        $content = $content.Replace('{{STRING_RESOURCES}}', $monitorContent.StringResources)
        $content = $content.Replace('{{MONITOR_DISPLAY_STRINGS}}', $monitorContent.DisplayStrings)
        $content = $content.Replace('{{ROLLUP_DISPLAY_STRINGS}}', $monitorContent.RollupDisplayStrings)
        $content = $content.Replace('{{KNOWLEDGE_ARTICLES}}', $monitorContent.KnowledgeArticles)
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
    pendingRequiredArtifacts = @($requiredPlanned | ForEach-Object id)
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
    Write-Host "Required artifacts still planned: $(@($requiredPlanned | ForEach-Object id) -join ', ')."
}
