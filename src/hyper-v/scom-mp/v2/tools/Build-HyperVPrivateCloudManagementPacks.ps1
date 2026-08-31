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

    # Drop the product and capability prefixes so a relationship reads "Boundary Contains Logical Unit" rather
    # than "Capability Storage Boundary Contains Logical Unit"; Get-HcsAreaDisplayName supplies the area when a
    # console-global name (class, discovery) needs it.
    $leaf = $Value -replace '^HyperVPrivateCloud\.(Capability\.[A-Za-z0-9]+\.)?', ''
    # -creplace: the default -replace is case-insensitive, which split every letter pair ("B ou nd ar yI d").
    $leaf = $leaf -creplace '([a-z0-9])([A-Z])', '$1 $2'
    $leaf = $leaf -creplace '([A-Z]+)([A-Z][a-z])', '$1 $2'
    return ($leaf -replace '\.', ' ')
}

function Get-HcsAreaDisplayName {
    [CmdletBinding()]
    param([Parameter(Mandatory)][string]$Value)

    if ($Value -match '^HyperVPrivateCloud\.Capability\.([A-Za-z0-9]+)\.') {
        $area = $Matches[1]
        switch ($area) {
            'S2D' { return 'Storage Spaces Direct' }
            'SDN' { return 'SDN' }
            'VMM' { return 'VMM' }
            'NetworkATC' { return 'Network ATC' }
            default { return ($area -creplace '([a-z0-9])([A-Z])', '$1 $2') }
        }
    }
    return 'Hyper-V Private Cloud'
}

function Get-HcsElementDisplayStringContent {
    [CmdletBinding()]
    param([Parameter(Mandatory)][xml]$ManagementPack)

    $result = [System.Text.StringBuilder]::new()
    # Elements the template already names by hand keep their authored strings; a second DisplayString for the
    # same ElementID would fail import.
    $authored = [System.Collections.Generic.HashSet[string]]::new([System.StringComparer]::Ordinal)
    foreach ($existing in $ManagementPack.SelectNodes('/ManagementPack/LanguagePacks/LanguagePack/DisplayStrings/DisplayString[not(@SubElementID)]')) {
        [void]$authored.Add([string]$existing.ElementID)
    }
    $escape = { param($s) [System.Security.SecurityElement]::Escape($s) }
    foreach ($classType in $ManagementPack.SelectNodes('/ManagementPack/TypeDefinitions/EntityTypes/ClassTypes/ClassType')) {
        $classId = [string]$classType.ID
        if (-not $authored.Contains($classId)) {
            $area = Get-HcsAreaDisplayName -Value $classId
            $leaf = ConvertTo-HcsDisplayName -Value $classId
            $name = & $escape "$area $leaf"
            $description = & $escape "$leaf object discovered and monitored by the Hyper-V Private Cloud $area capability."
            [void]$result.AppendLine("        <DisplayString ElementID=`"$classId`"><Name>$name</Name><Description>$description</Description></DisplayString>")
        }
        foreach ($property in $classType.SelectNodes('Property')) {
            $name = & $escape (ConvertTo-HcsDisplayName -Value ([string]$property.ID))
            [void]$result.AppendLine("        <DisplayString ElementID=`"$classId`" SubElementID=`"$($property.ID)`"><Name>$name</Name></DisplayString>")
        }
    }
    foreach ($relationship in $ManagementPack.SelectNodes('/ManagementPack/TypeDefinitions/EntityTypes/RelationshipTypes/RelationshipType')) {
        if ($authored.Contains([string]$relationship.ID)) { continue }
        $name = & $escape (ConvertTo-HcsDisplayName -Value ([string]$relationship.ID))
        [void]$result.AppendLine("        <DisplayString ElementID=`"$($relationship.ID)`"><Name>$name</Name></DisplayString>")
    }
    foreach ($discovery in $ManagementPack.SelectNodes('/ManagementPack/Monitoring/Discoveries/Discovery')) {
        $discoveryId = [string]$discovery.ID
        if ($authored.Contains($discoveryId)) { continue }
        $area = Get-HcsAreaDisplayName -Value $discoveryId
        $leaf = ConvertTo-HcsDisplayName -Value $discoveryId
        $name = & $escape "$area $leaf"
        $description = & $escape "Discovers $area objects and relationships for Hyper-V Private Cloud Monitoring."
        [void]$result.AppendLine("        <DisplayString ElementID=`"$discoveryId`"><Name>$name</Name><Description>$description</Description></DisplayString>")
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

    # Monitors whose signal is now evaluated by a depth monitor with thresholds in the monitor type
    # (overridable without breaking cookdown). The legacy IDs stay in the pack because they are part
    # of the sealed 1.0.0.0 identity, but ship disabled so the same condition is not alerted twice.
    $superseded = @{
        'HyperVPrivateCloud.Host.Cpu.Monitor' = 'HyperVPrivateCloud.Host.LogicalProcessorUtilization.Monitor'
        'HyperVPrivateCloud.Host.Memory.Monitor' = 'HyperVPrivateCloud.Host.AvailableMemory.Monitor'
        'HyperVPrivateCloud.Host.Paging.Monitor' = 'HyperVPrivateCloud.Host.MemoryPagesPressure.Monitor'
        'HyperVPrivateCloud.VmRuntime.MemoryPressure.Monitor' = 'HyperVPrivateCloud.VmRuntime.MemoryPressureRatio.Monitor'
    }
    $monitors = [System.Text.StringBuilder]::new()
    $resources = [System.Text.StringBuilder]::new()
    $displays = [System.Text.StringBuilder]::new()
    $knowledge = [System.Text.StringBuilder]::new()
    foreach ($definition in $Definitions) {
        $prefix = if ($Kind -eq 'Host') { 'Host' } else { 'VmRuntime' }
        $monitorId = "HyperVPrivateCloud.$prefix.$($definition[0]).Monitor"
        $messageId = "$monitorId.Message"
        $enabled = 'true'
        $supersededNote = ''
        if ($superseded.ContainsKey($monitorId)) {
            $enabled = 'false'
            $supersededNote = " Disabled by default: superseded by $($superseded[$monitorId]), which evaluates the same signal with thresholds that can be overridden without breaking probe cookdown. Enable this monitor only if you disable the superseding one."
        }
        $target = if ($Kind -eq 'Host') { 'HCSV2Library!HyperVPrivateCloud.HostRole' } else { 'HCSV2Library!HyperVPrivateCloud.VirtualMachineRuntime' }
        $typeId = if ($Kind -eq 'Host') { 'HyperVPrivateCloud.PropertyBag.ThreeState.MonitorType' } else { 'HyperVPrivateCloud.VmPropertyBag.ThreeState.MonitorType' }
        $alertState = if ($definition[5] -eq 'Warning') { 'Warning' } else { 'Error' }
        $configuration = if ($Kind -eq 'Host') {
            "<PropertyName>$($definition[1])</PropertyName><IntervalSeconds>300</IntervalSeconds><SyncTime /><TimeoutSeconds>120</TimeoutSeconds><CpuWarningPercent>80</CpuWarningPercent><CpuCriticalPercent>90</CpuCriticalPercent><MemoryWarningMB>4096</MemoryWarningMB><MemoryCriticalMB>2048</MemoryCriticalMB><PagesInputWarningPerSecond>5</PagesInputWarningPerSecond><PagesInputCriticalPerSecond>20</PagesInputCriticalPerSecond><CheckpointWarningHours>168</CheckpointWarningHours><CheckpointCriticalHours>336</CheckpointCriticalHours>"
        }
        else {
            '<PropertyName>{0}</PropertyName><VMId>$Target/Property[Type="HCSV2Library!HyperVPrivateCloud.VirtualMachineRuntime"]/VMId$</VMId><ExpectedState>$Target/Property[Type="HCSV2Library!HyperVPrivateCloud.VirtualMachineRuntime"]/ExpectedState$</ExpectedState><IntervalSeconds>300</IntervalSeconds><SyncTime /><TimeoutSeconds>120</TimeoutSeconds><CheckpointWarningHours>168</CheckpointWarningHours><CheckpointCriticalHours>336</CheckpointCriticalHours>' -f $definition[1]
        }
        [void]$monitors.AppendLine("      <UnitMonitor ID=`"$monitorId`" Accessibility=`"Public`" Enabled=`"$enabled`" Target=`"$target`" ParentMonitorID=`"Health!System.Health.$($definition[3])`" Remotable=`"true`" Priority=`"Normal`" TypeID=`"$typeId`" ConfirmDelivery=`"true`"><Category>$($definition[4])</Category><AlertSettings AlertMessage=`"$messageId`"><AlertOnState>$alertState</AlertOnState><AutoResolve>true</AutoResolve><AlertPriority>Normal</AlertPriority><AlertSeverity>MatchMonitorHealth</AlertSeverity><AlertParameters><AlertParameter1>`$Data/Context/Property[@Name='$($definition[1])Detail']`$</AlertParameter1></AlertParameters></AlertSettings><OperationalStates><OperationalState ID=`"Good`" MonitorTypeStateID=`"Good`" HealthState=`"Success`" /><OperationalState ID=`"Warning`" MonitorTypeStateID=`"Warning`" HealthState=`"Warning`" /><OperationalState ID=`"Critical`" MonitorTypeStateID=`"Critical`" HealthState=`"Error`" /></OperationalStates><Configuration>$configuration</Configuration></UnitMonitor>")
        [void]$resources.AppendLine("<StringResource ID=`"$messageId`" />")
        [void]$displays.AppendLine("    <DisplayString ElementID=`"$monitorId`"><Name>$($definition[2])</Name><Description>$($definition[6])$supersededNote</Description></DisplayString>")
        foreach ($state in @('Good', 'Warning', 'Critical')) { [void]$displays.AppendLine("    <DisplayString ElementID=`"$monitorId`" SubElementID=`"$state`"><Name>$state</Name></DisplayString>") }
        [void]$displays.AppendLine("    <DisplayString ElementID=`"$messageId`"><Name>$($definition[2])</Name><Description>$($definition[6]) Detail: {0}</Description></DisplayString>")
        [void]$knowledge.AppendLine("    <KnowledgeArticle ElementID=`"$monitorId`" Visible=`"true`"><MamlContent><maml:section xmlns:maml=`"http://schemas.microsoft.com/maml/2004/10`"><maml:title>Summary</maml:title><maml:para>$($definition[6])$supersededNote</maml:para></maml:section><maml:section xmlns:maml=`"http://schemas.microsoft.com/maml/2004/10`"><maml:title>Operator response</maml:title><maml:para>$($definition[7])</maml:para></maml:section></MamlContent></KnowledgeArticle>")
    }
    return [pscustomobject]@{ Monitors = $monitors.ToString(); StringResources = $resources.ToString(); DisplayStrings = $displays.ToString(); KnowledgeArticles = $knowledge.ToString() }
}

function Get-HcsRollupContent {
    [CmdletBinding()]
    param()

    $monitors = [System.Text.StringBuilder]::new()
    $displays = [System.Text.StringBuilder]::new()
    $aspects = @(
        @('Availability', 'AvailabilityState', 'AvailabilityHealth'),
        @('Performance', 'PerformanceState', 'PerformanceHealth'),
        @('Configuration', 'ConfigurationState', 'ConfigurationHealth')
    )

    # Service level: every branch rolls its Availability, Performance and Configuration aggregate into the DA.
    # A branch with no members for an aspect simply stays Not Monitored for that aspect.
    $serviceBranches = @(
        @('Management', 'ManagementComponent'), @('Compute', 'ComputeComponent'), @('VirtualMachines', 'VirtualMachineComponent'), @('Availability', 'AvailabilityComponent'), @('Storage', 'StorageComponent'), @('Network', 'NetworkComponent'), @('Monitoring', 'MonitoringComponent')
    )
    foreach ($branch in $serviceBranches) {
        $relationship = "HCSV2Library!HyperVPrivateCloud.ServiceContains$($branch[1])"
        foreach ($aspect in $aspects) {
            $id = "HyperVPrivateCloud.Service.$($branch[0]).$($aspect[0]).Dependency.Monitor"
            [void]$monitors.AppendLine("      <DependencyMonitor ID=`"$id`" Accessibility=`"Public`" Enabled=`"true`" Target=`"HCSV2Library!HyperVPrivateCloud.Service`" ParentMonitorID=`"Health!System.Health.$($aspect[1])`" Remotable=`"true`" Priority=`"Normal`" RelationshipType=`"$relationship`" MemberMonitor=`"Health!System.Health.$($aspect[1])`"><Category>$($aspect[2])</Category><Algorithm>WorstOf</Algorithm><MemberUnAvailable>Error</MemberUnAvailable></DependencyMonitor>")
            [void]$displays.AppendLine("    <DisplayString ElementID=`"$id`"><Name>Roll up $($branch[0]) $($aspect[0].ToLowerInvariant())</Name><Description>Rolls the $($aspect[0].ToLowerInvariant()) state of the $($branch[0]) branch into the Hyper-V Private Cloud Distributed Application.</Description></DisplayString>")
        }
    }

    # Component level. Each branch rolls up the monitors that belong to its own domain so a VM heartbeat failure
    # is visible under Virtual Machines and Availability, not under Storage and Networking as well. The first
    # entry of each branch keeps its 1.0.0.0 element ID (".Members.Availability.Dependency.Monitor"); a member
    # that is a specific unit monitor uses MemberUnAvailable=Success so disabling that monitor by override does
    # not redden the branch, while whole-aggregate members keep Error so an unreachable agent does.
    #   @(idLeaf, componentClass, relationship, parentState, category, memberMonitor, memberUnavailable, displayName)
    $componentRollups = @(
        @('Management.Members.Availability', 'ManagementComponent', 'ManagementComponentContainsHostRole', 'AvailabilityState', 'AvailabilityHealth', 'HyperVPrivateCloud.Host.VMMS.Monitor', 'Success', 'Roll up Hyper-V management service (VMMS) availability into Management'),
        @('Management.Members.HostCompute.Availability', 'ManagementComponent', 'ManagementComponentContainsHostRole', 'AvailabilityState', 'AvailabilityHealth', 'HyperVPrivateCloud.Host.VmCompute.Monitor', 'Success', 'Roll up Host Compute Service availability into Management'),
        @('Management.Members.Hypervisor.Availability', 'ManagementComponent', 'ManagementComponentContainsHostRole', 'AvailabilityState', 'AvailabilityHealth', 'HyperVPrivateCloud.Host.Hypervisor.Monitor', 'Success', 'Roll up hypervisor availability into Management'),
        @('Compute.Members.Availability', 'ComputeComponent', 'ComputeComponentContainsHostRole', 'AvailabilityState', 'AvailabilityHealth', 'Health!System.Health.AvailabilityState', 'Error', 'Roll up Hyper-V host availability into Compute'),
        @('Compute.Members.Performance', 'ComputeComponent', 'ComputeComponentContainsHostRole', 'PerformanceState', 'PerformanceHealth', 'Health!System.Health.PerformanceState', 'Success', 'Roll up Hyper-V host performance into Compute'),
        @('Compute.Members.Configuration', 'ComputeComponent', 'ComputeComponentContainsHostRole', 'ConfigurationState', 'ConfigurationHealth', 'Health!System.Health.ConfigurationState', 'Success', 'Roll up Hyper-V host configuration into Compute'),
        @('VirtualMachines.Members.Availability', 'VirtualMachineComponent', 'VirtualMachineComponentContainsRuntime', 'AvailabilityState', 'AvailabilityHealth', 'Health!System.Health.AvailabilityState', 'Error', 'Roll up virtual machine availability into Virtual Machines'),
        @('VirtualMachines.Members.Performance', 'VirtualMachineComponent', 'VirtualMachineComponentContainsRuntime', 'PerformanceState', 'PerformanceHealth', 'Health!System.Health.PerformanceState', 'Success', 'Roll up virtual machine performance into Virtual Machines'),
        @('VirtualMachines.Members.Configuration', 'VirtualMachineComponent', 'VirtualMachineComponentContainsRuntime', 'ConfigurationState', 'ConfigurationHealth', 'Health!System.Health.ConfigurationState', 'Success', 'Roll up virtual machine configuration into Virtual Machines'),
        @('Availability.Members.Availability', 'AvailabilityComponent', 'AvailabilityComponentContainsRuntime', 'AvailabilityState', 'AvailabilityHealth', 'HyperVPrivateCloud.VmRuntime.Availability.Monitor', 'Success', 'Roll up VM expected-state availability into Availability and Clustering'),
        @('Availability.Members.Heartbeat.Availability', 'AvailabilityComponent', 'AvailabilityComponentContainsRuntime', 'AvailabilityState', 'AvailabilityHealth', 'HyperVPrivateCloud.VmRuntime.Heartbeat.Monitor', 'Success', 'Roll up VM heartbeat into Availability and Clustering'),
        @('Availability.Members.Replication.Availability', 'AvailabilityComponent', 'AvailabilityComponentContainsRuntime', 'AvailabilityState', 'AvailabilityHealth', 'HyperVPrivateCloud.VmRuntime.Replication.Monitor', 'Success', 'Roll up Hyper-V Replica health into Availability and Clustering'),
        @('Storage.Members.Availability', 'StorageComponent', 'StorageComponentContainsRuntime', 'AvailabilityState', 'AvailabilityHealth', 'HyperVPrivateCloud.VmRuntime.Storage.Monitor', 'Success', 'Roll up VM virtual disk availability into Storage'),
        @('Storage.Members.Latency.Performance', 'StorageComponent', 'StorageComponentContainsRuntime', 'PerformanceState', 'PerformanceHealth', 'HyperVPrivateCloud.VmRuntime.VirtualStorageLatency.Monitor', 'Success', 'Roll up VM virtual storage latency into Storage'),
        @('Storage.Members.Queue.Performance', 'StorageComponent', 'StorageComponentContainsRuntime', 'PerformanceState', 'PerformanceHealth', 'HyperVPrivateCloud.VmRuntime.VirtualStorageQueueLength.Monitor', 'Success', 'Roll up VM virtual storage queue length into Storage'),
        @('Network.Members.Availability', 'NetworkComponent', 'NetworkComponentContainsRuntime', 'AvailabilityState', 'AvailabilityHealth', 'HyperVPrivateCloud.VmRuntime.Network.Monitor', 'Success', 'Roll up VM virtual network connectivity into Networking'),
        @('Monitoring.Members.Availability', 'MonitoringComponent', 'MonitoringComponentContainsHostRole', 'AvailabilityState', 'AvailabilityHealth', 'HyperVPrivateCloud.Host.Pipeline.Monitor', 'Success', 'Roll up host monitoring pipeline health into Monitoring Pipeline'),
        @('Monitoring.Members.Capability.Configuration', 'MonitoringComponent', 'MonitoringComponentContainsHostRole', 'ConfigurationState', 'ConfigurationHealth', 'HyperVPrivateCloud.Host.PowerShell.Monitor', 'Success', 'Roll up Hyper-V monitoring capability into Monitoring Pipeline')
    )
    foreach ($rollup in $componentRollups) {
        $id = "HyperVPrivateCloud.$($rollup[0]).Dependency.Monitor"
        [void]$monitors.AppendLine("      <DependencyMonitor ID=`"$id`" Accessibility=`"Public`" Enabled=`"true`" Target=`"HCSV2Library!HyperVPrivateCloud.$($rollup[1])`" ParentMonitorID=`"Health!System.Health.$($rollup[3])`" Remotable=`"true`" Priority=`"Normal`" RelationshipType=`"HCSV2Library!HyperVPrivateCloud.$($rollup[2])`" MemberMonitor=`"$($rollup[5])`"><Category>$($rollup[4])</Category><Algorithm>WorstOf</Algorithm><MemberUnAvailable>$($rollup[6])</MemberUnAvailable></DependencyMonitor>")
        [void]$displays.AppendLine("    <DisplayString ElementID=`"$id`"><Name>$($rollup[7])</Name><Description>Dependency roll-up through the $($rollup[2] -creplace '([a-z0-9])([A-Z])', '$1 $2') relationship.</Description></DisplayString>")
    }
    return [pscustomobject]@{ Monitors = $monitors.ToString(); DisplayStrings = $displays.ToString() }
}

function Get-HcsStorageCapabilityContent {
    [CmdletBinding()]
    param()

    $integrationFilters = @'
          <ConditionDetection ID="GoodFilter" TypeID="System!System.ExpressionFilter"><Expression><Or><Expression><SimpleExpression><ValueExpression><XPathQuery Type="String">Property[@Name='StorageIntegrationState']</XPathQuery></ValueExpression><Operator>Equal</Operator><ValueExpression><Value Type="String">Good</Value></ValueExpression></SimpleExpression></Expression><Expression><SimpleExpression><ValueExpression><XPathQuery Type="String">Property[@Name='StorageIntegrationState']</XPathQuery></ValueExpression><Operator>Equal</Operator><ValueExpression><Value Type="String">NotApplicable</Value></ValueExpression></SimpleExpression></Expression></Or></Expression></ConditionDetection>
          <ConditionDetection ID="WarningFilter" TypeID="System!System.ExpressionFilter"><Expression><SimpleExpression><ValueExpression><XPathQuery Type="String">Property[@Name='StorageIntegrationState']</XPathQuery></ValueExpression><Operator>Equal</Operator><ValueExpression><Value Type="String">Warning</Value></ValueExpression></SimpleExpression></Expression></ConditionDetection>
          <ConditionDetection ID="CriticalFilter" TypeID="System!System.ExpressionFilter"><Expression><SimpleExpression><ValueExpression><XPathQuery Type="String">Property[@Name='StorageIntegrationState']</XPathQuery></ValueExpression><Operator>Equal</Operator><ValueExpression><Value Type="String">Critical</Value></ValueExpression></SimpleExpression></Expression></ConditionDetection>
'@
    $objectFilters = @'
          <ConditionDetection ID="GoodFilter" TypeID="System!System.ExpressionFilter"><Expression><Or><Expression><SimpleExpression><ValueExpression><XPathQuery Type="String">Property[@Name='$Config/PropertyName$']</XPathQuery></ValueExpression><Operator>Equal</Operator><ValueExpression><Value Type="String">Good</Value></ValueExpression></SimpleExpression></Expression><Expression><SimpleExpression><ValueExpression><XPathQuery Type="String">Property[@Name='$Config/PropertyName$']</XPathQuery></ValueExpression><Operator>Equal</Operator><ValueExpression><Value Type="String">NotApplicable</Value></ValueExpression></SimpleExpression></Expression></Or></Expression></ConditionDetection>
          <ConditionDetection ID="WarningFilter" TypeID="System!System.ExpressionFilter"><Expression><SimpleExpression><ValueExpression><XPathQuery Type="String">Property[@Name='$Config/PropertyName$']</XPathQuery></ValueExpression><Operator>Equal</Operator><ValueExpression><Value Type="String">Warning</Value></ValueExpression></SimpleExpression></Expression></ConditionDetection>
          <ConditionDetection ID="CriticalFilter" TypeID="System!System.ExpressionFilter"><Expression><SimpleExpression><ValueExpression><XPathQuery Type="String">Property[@Name='$Config/PropertyName$']</XPathQuery></ValueExpression><Operator>Equal</Operator><ValueExpression><Value Type="String">Critical</Value></ValueExpression></SimpleExpression></Expression></ConditionDetection>
'@
    $detections = '<RegularDetections><RegularDetection MonitorTypeStateID="Good"><Node ID="GoodFilter"><Node ID="DataSource" /></Node></RegularDetection><RegularDetection MonitorTypeStateID="Warning"><Node ID="WarningFilter"><Node ID="DataSource" /></Node></RegularDetection><RegularDetection MonitorTypeStateID="Critical"><Node ID="CriticalFilter"><Node ID="DataSource" /></Node></RegularDetection></RegularDetections>'

    $classIds = @('LogicalUnit', 'HostAttachment', 'IscsiSession', 'FibreChannelPort', 'VirtualDiskMapping')
    $relationshipIds = @('BoundaryContainsLogicalUnit', 'HostContainsAttachment', 'LogicalUnitContainsAttachment', 'HostContainsIscsiSession', 'HostContainsFibreChannelPort', 'ComponentContainsLogicalUnit', 'ComponentContainsAttachment', 'ComponentContainsIscsiSession', 'ComponentContainsFibreChannelPort', 'ComponentContainsVirtualDiskMapping', 'VirtualDiskMappingReferencesVirtualHardDisk', 'VirtualDiskMappingReferencesLogicalUnit', 'VirtualHardDiskUsesLogicalUnit')
    $discoveryTypes = [System.Text.StringBuilder]::new()
    foreach ($id in $classIds) { [void]$discoveryTypes.AppendLine("<DiscoveryClass TypeID=`"HyperVPrivateCloud.Capability.Storage.$id`" />") }
    foreach ($id in $relationshipIds) { [void]$discoveryTypes.AppendLine("<DiscoveryRelationship TypeID=`"HyperVPrivateCloud.Capability.Storage.$id`" />") }

    $definitions = @(
        [pscustomobject]@{ Leaf = 'IntegrationHealth'; Target = 'HCSV2Library!HyperVPrivateCloud.HostRole'; Type = 'Integration'; Title = 'Windows SAN integration health'; Description = 'Verifies Windows Storage, iSCSI, Fibre Channel, and MPIO query coverage.'; Response = 'Install the required management tools, validate DSM claims and redundant paths, then review Operations Manager event 8403.'; Parent = 'ConfigurationState'; Category = 'ConfigurationHealth'; Alert = 'Error'; Configuration = '<ComputerName>$Target/Host/Property[Type="Windows!Microsoft.Windows.Computer"]/PrincipalName$</ComputerName><IntervalSeconds>300</IntervalSeconds><SyncTime /><TimeoutSeconds>120</TimeoutSeconds>' },
        [pscustomobject]@{ Leaf = 'AttachmentAvailability'; Superseded = 'HyperVPrivateCloud.Capability.Storage.LogicalUnitOperationalStatus.Monitor'; Target = 'HyperVPrivateCloud.Capability.Storage.HostAttachment'; Type = 'Object'; Title = 'SAN disk attachment availability'; Description = 'Tracks Windows-visible SAN disk state and writability.'; Response = 'Validate the array presentation, fabric, Windows disk state, DSM, and recent storage events before returning the disk to service.'; Parent = 'AvailabilityState'; Category = 'AvailabilityHealth'; Alert = 'Error'; Configuration = '<ObjectKind>Attachment</ObjectKind><Identity /><DiskNumber>$Target/Property[Type="HyperVPrivateCloud.Capability.Storage.HostAttachment"]/DiskNumber$</DiskNumber><StorageId>$Target/Property[Type="HyperVPrivateCloud.Capability.Storage.HostAttachment"]/StorageId$</StorageId><BusType>$Target/Property[Type="HyperVPrivateCloud.Capability.Storage.HostAttachment"]/BusType$</BusType><MinimumPathCount>2</MinimumPathCount><PropertyName>ObjectState</PropertyName><IntervalSeconds>300</IntervalSeconds><SyncTime /><TimeoutSeconds>120</TimeoutSeconds>' },
        [pscustomobject]@{ Leaf = 'AttachmentRedundancy'; Superseded = 'HyperVPrivateCloud.Capability.Storage.MultipathPathCount.Monitor'; Target = 'HyperVPrivateCloud.Capability.Storage.HostAttachment'; Type = 'Object'; Title = 'SAN MPIO path redundancy'; Description = 'Tracks MPIO path count for iSCSI and Fibre Channel disks.'; Response = 'Inspect HBA or NIC links, switches, target ports, MPIO policy, and vendor DSM state. Do not change claiming policy without vendor guidance.'; Parent = 'AvailabilityState'; Category = 'AvailabilityHealth'; Alert = 'Warning'; Configuration = '<ObjectKind>Attachment</ObjectKind><Identity /><DiskNumber>$Target/Property[Type="HyperVPrivateCloud.Capability.Storage.HostAttachment"]/DiskNumber$</DiskNumber><StorageId>$Target/Property[Type="HyperVPrivateCloud.Capability.Storage.HostAttachment"]/StorageId$</StorageId><BusType>$Target/Property[Type="HyperVPrivateCloud.Capability.Storage.HostAttachment"]/BusType$</BusType><MinimumPathCount>2</MinimumPathCount><PropertyName>RedundancyState</PropertyName><IntervalSeconds>300</IntervalSeconds><SyncTime /><TimeoutSeconds>120</TimeoutSeconds>' },
        [pscustomobject]@{ Leaf = 'IscsiSessionAvailability'; Superseded = 'HyperVPrivateCloud.Capability.Storage.IscsiSessionConnectedState.Monitor'; Target = 'HyperVPrivateCloud.Capability.Storage.IscsiSession'; Type = 'Object'; Title = 'iSCSI session availability'; Description = 'Tracks established iSCSI sessions and active connections.'; Response = 'Check initiator service state, target reachability, VLAN and MPIO design, authentication, and persistent-target configuration.'; Parent = 'AvailabilityState'; Category = 'AvailabilityHealth'; Alert = 'Error'; Configuration = '<ObjectKind>IscsiSession</ObjectKind><Identity>$Target/Property[Type="HyperVPrivateCloud.Capability.Storage.IscsiSession"]/SessionId$</Identity><DiskNumber>0</DiskNumber><StorageId /><BusType>iSCSI</BusType><MinimumPathCount>1</MinimumPathCount><PropertyName>ObjectState</PropertyName><IntervalSeconds>300</IntervalSeconds><SyncTime /><TimeoutSeconds>120</TimeoutSeconds>' },
        [pscustomobject]@{ Leaf = 'FibreChannelPortAvailability'; Superseded = 'HyperVPrivateCloud.Capability.Storage.FibreChannelPortLinkState.Monitor'; Target = 'HyperVPrivateCloud.Capability.Storage.FibreChannelPort'; Type = 'Object'; Title = 'Fibre Channel port availability'; Description = 'Tracks HBA provider and Fibre Channel port operational state.'; Response = 'Inspect HBA, driver, firmware, optic, cable, switch port, zoning, and array target-port state.'; Parent = 'AvailabilityState'; Category = 'AvailabilityHealth'; Alert = 'Error'; Configuration = '<ObjectKind>FibreChannelPort</ObjectKind><Identity>$Target/Property[Type="HyperVPrivateCloud.Capability.Storage.FibreChannelPort"]/PortId$</Identity><DiskNumber>0</DiskNumber><StorageId /><BusType>Fibre Channel</BusType><MinimumPathCount>1</MinimumPathCount><PropertyName>ObjectState</PropertyName><IntervalSeconds>300</IntervalSeconds><SyncTime /><TimeoutSeconds>120</TimeoutSeconds>' }
    )
    $monitors = [System.Text.StringBuilder]::new()
    $resources = [System.Text.StringBuilder]::new()
    $displays = [System.Text.StringBuilder]::new()
    $knowledge = [System.Text.StringBuilder]::new()
    foreach ($definition in $definitions) {
        $id = "HyperVPrivateCloud.Capability.Storage.$($definition.Leaf).Monitor"
        $messageId = "$id.Message"
        $typeId = "HyperVPrivateCloud.Capability.Storage.$($definition.Type)Health.MonitorType"
        $detailProperty = if ($definition.Leaf -eq 'AttachmentRedundancy') { 'RedundancyStateDetail' } elseif ($definition.Type -eq 'Integration') { 'StorageIntegrationStateDetail' } else { 'ObjectStateDetail' }
        $storageEnabled = 'true'; $storageNote = ''
        if ($definition.PSObject.Properties['Superseded']) { $storageEnabled = 'false'; $storageNote = " Disabled by default: superseded by $($definition.Superseded), which evaluates the same condition with overridable thresholds; enable this monitor only if you disable the superseding one." }
        [void]$monitors.AppendLine("<UnitMonitor ID=`"$id`" Accessibility=`"Public`" Enabled=`"$storageEnabled`" Target=`"$($definition.Target)`" ParentMonitorID=`"Health!System.Health.$($definition.Parent)`" Remotable=`"true`" Priority=`"Normal`" TypeID=`"$typeId`" ConfirmDelivery=`"true`"><Category>$($definition.Category)</Category><AlertSettings AlertMessage=`"$messageId`"><AlertOnState>$($definition.Alert)</AlertOnState><AutoResolve>true</AutoResolve><AlertPriority>Normal</AlertPriority><AlertSeverity>MatchMonitorHealth</AlertSeverity><AlertParameters><AlertParameter1>`$Data/Context/Property[@Name='$detailProperty']`$</AlertParameter1></AlertParameters></AlertSettings><OperationalStates><OperationalState ID=`"Good`" MonitorTypeStateID=`"Good`" HealthState=`"Success`" /><OperationalState ID=`"Warning`" MonitorTypeStateID=`"Warning`" HealthState=`"Warning`" /><OperationalState ID=`"Critical`" MonitorTypeStateID=`"Critical`" HealthState=`"Error`" /></OperationalStates><Configuration>$($definition.Configuration)</Configuration></UnitMonitor>")
        [void]$resources.AppendLine("<StringResource ID=`"$messageId`" />")
        [void]$displays.AppendLine("<DisplayString ElementID=`"$id`"><Name>$($definition.Title)</Name><Description>$($definition.Description)$storageNote</Description></DisplayString>")
        foreach ($state in @('Good', 'Warning', 'Critical')) { [void]$displays.AppendLine("<DisplayString ElementID=`"$id`" SubElementID=`"$state`"><Name>$state</Name></DisplayString>") }
        [void]$displays.AppendLine("<DisplayString ElementID=`"$messageId`"><Name>$($definition.Title)</Name><Description>$($definition.Description) Detail: {0}</Description></DisplayString>")
        [void]$knowledge.AppendLine("<KnowledgeArticle ElementID=`"$id`" Visible=`"true`"><MamlContent><maml:section xmlns:maml=`"http://schemas.microsoft.com/maml/2004/10`"><maml:title>Summary</maml:title><maml:para>$($definition.Description)$storageNote</maml:para></maml:section><maml:section xmlns:maml=`"http://schemas.microsoft.com/maml/2004/10`"><maml:title>Operator response</maml:title><maml:para>$($definition.Response)</maml:para></maml:section></MamlContent></KnowledgeArticle>")
    }

    $viewDefinitions = @(
        @('LogicalUnit', 'LogicalUnit', 'SAN logical units', 'HCSV2Presentation!HyperVPrivateCloud.Storage.Folder'),
        @('HostAttachment', 'HostAttachment', 'Host SAN attachments', 'HCSV2Presentation!HyperVPrivateCloud.Storage.Folder'),
        @('IscsiSession', 'IscsiSession', 'iSCSI sessions', 'HCSV2Presentation!HyperVPrivateCloud.Storage.Folder'),
        @('FibreChannelPort', 'FibreChannelPort', 'Fibre Channel ports', 'HCSV2Presentation!HyperVPrivateCloud.Storage.Folder'),
        @('VirtualDiskMapping', 'VirtualDiskMapping', 'VHDX to SAN mappings', 'HCSV2Presentation!HyperVPrivateCloud.Storage.Folder')
    )
    $views = [System.Text.StringBuilder]::new()
    $folderItems = [System.Text.StringBuilder]::new()
    foreach ($view in $viewDefinitions) {
        $id = "HyperVPrivateCloud.Capability.Storage.$($view[0]).State.View"
        [void]$views.AppendLine("<View ID=`"$id`" Accessibility=`"Public`" Enabled=`"true`" Target=`"HyperVPrivateCloud.Capability.Storage.$($view[1])`" TypeID=`"SC!Microsoft.SystemCenter.StateViewType`" Visible=`"true`"><Category>Operations</Category><Criteria /></View>")
        [void]$folderItems.AppendLine("<FolderItem ElementID=`"$id`" ID=`"$id.FolderItem`" Folder=`"$($view[3])`" />")
        [void]$displays.AppendLine("<DisplayString ElementID=`"$id`"><Name>$($view[2])</Name></DisplayString>")
    }
    $alertViewId = 'HyperVPrivateCloud.Capability.Storage.ActiveAlerts.View'
    [void]$views.AppendLine("<View ID=`"$alertViewId`" Accessibility=`"Public`" Enabled=`"true`" Target=`"HyperVPrivateCloud.Capability.Storage.HostAttachment`" TypeID=`"SC!Microsoft.SystemCenter.AlertViewType`" Visible=`"true`"><Category>Operations</Category><Criteria><ResolutionState><StateRange Operator=`"NotEquals`">255</StateRange></ResolutionState></Criteria></View>")
    [void]$folderItems.AppendLine("<FolderItem ElementID=`"$alertViewId`" ID=`"$alertViewId.FolderItem`" Folder=`"HCSV2Presentation!HyperVPrivateCloud.Operations.Folder`" />")
    [void]$displays.AppendLine("<DisplayString ElementID=`"$alertViewId`"><Name>SAN and storage active alerts</Name></DisplayString>")

    return [pscustomobject]@{
        IntegrationFilters = $integrationFilters.Trim()
        ObjectFilters = $objectFilters.Trim()
        Detections = $detections
        DiscoveryTypes = $discoveryTypes.ToString()
        Monitors = $monitors.ToString()
        Views = $views.ToString()
        FolderItems = $folderItems.ToString()
        StringResources = $resources.ToString()
        DisplayStrings = $displays.ToString()
        Knowledge = $knowledge.ToString()
    }
}

function Get-HcsS2DCapabilityContent {
    [CmdletBinding()]
    param()

    $definitions = @(
        [pscustomobject]@{ Kind = 'StorageSubSystem'; KeyType = 'StorageLibrary!Microsoft.Storage.Library.StorageArray'; Name = 'S2D storage subsystems' },
        [pscustomobject]@{ Kind = 'StorageNode'; KeyType = 'StorageLibrary!Microsoft.Storage.Library.Windows.Node'; Name = 'S2D storage nodes' },
        [pscustomobject]@{ Kind = 'PhysicalDisk'; KeyType = 'StorageLibrary!Microsoft.Storage.Library.Windows.Disk'; Name = 'S2D physical disks' },
        [pscustomobject]@{ Kind = 'StoragePool'; KeyType = 'StorageLibrary!Microsoft.Storage.Library.Windows.Pool'; Name = 'S2D storage pools' },
        [pscustomobject]@{ Kind = 'VirtualDisk'; KeyType = 'StorageLibrary!Microsoft.Storage.Library.Windows.Disk'; Name = 'S2D virtual disks' },
        [pscustomobject]@{ Kind = 'Volume'; KeyType = 'StorageLibrary!Microsoft.Storage.Library.Windows.Volume'; Name = 'S2D volumes' },
        [pscustomobject]@{ Kind = 'FileShare'; KeyType = 'StorageLibrary!Microsoft.Storage.Library.Windows.FileShare'; Name = 'S2D file shares' }
    )
    $discoveries = [System.Text.StringBuilder]::new()
    $rollups = [System.Text.StringBuilder]::new()
    $views = [System.Text.StringBuilder]::new()
    $folderItems = [System.Text.StringBuilder]::new()
    $displays = [System.Text.StringBuilder]::new()
    foreach ($definition in $definitions) {
        $classId = "Microsoft.Windows.Server.10.0.Storage.StorageSpacesDirect.$($definition.Kind)"
        $discoveryId = "HyperVPrivateCloud.Capability.S2D.$($definition.Kind).Relationship.Discovery"
        $relationshipId = "HyperVPrivateCloud.Capability.S2D.StorageContains$($definition.Kind)"
        $computerName = if ($definition.Kind -eq 'Volume') { '$Target/Host/Host/Property[Type="Windows!Microsoft.Windows.Computer"]/PrincipalName$' } elseif ($definition.Kind -eq 'FileShare') { '$Target/Host/Host/Host/Property[Type="Windows!Microsoft.Windows.Computer"]/PrincipalName$' } else { '$Target/Host/Property[Type="Windows!Microsoft.Windows.Computer"]/PrincipalName$' }
        $parentDisk = if ($definition.Kind -eq 'Volume') { '$Target/Host/Property[Type="StorageLibrary!Microsoft.Storage.Library.Windows.Disk"]/UniqueID$' } elseif ($definition.Kind -eq 'FileShare') { '$Target/Host/Host/Property[Type="StorageLibrary!Microsoft.Storage.Library.Windows.Disk"]/UniqueID$' } else { '' }
        $parentVolume = if ($definition.Kind -eq 'FileShare') { '$Target/Host/Property[Type="StorageLibrary!Microsoft.Storage.Library.Windows.Volume"]/UniqueID$' } else { '' }
        [void]$discoveries.AppendLine("<Discovery ID=`"$discoveryId`" Enabled=`"true`" Target=`"S2D!$classId`" ConfirmDelivery=`"false`" Remotable=`"true`" Priority=`"Normal`"><Category>Discovery</Category><DiscoveryTypes><DiscoveryRelationship TypeID=`"$relationshipId`" /></DiscoveryTypes><DataSource ID=`"PowerShellDiscovery`" TypeID=`"HCSV2Library!HyperVPrivateCloud.Pwsh.DiscoveryProvider`"><IntervalSeconds>14400</IntervalSeconds><ScriptName>HyperVPrivateCloud.S2D.RelationshipDiscovery.ps1</ScriptName><ScriptBody><![CDATA[{{S2D_RELATIONSHIP_DISCOVERY_SCRIPT}}]]></ScriptBody><Arguments>-SourceId `"`$MPElement`$`" -ManagedEntityId `"`$Target/Id`$`" -ObjectKind `"$($definition.Kind)`" -ComputerName `"$computerName`" -UniqueId `"`$Target/Property[Type=`"$($definition.KeyType)`"]`/UniqueID`$`" -ParentDiskUniqueId `"$parentDisk`" -ParentVolumeUniqueId `"$parentVolume`"</Arguments><TimeoutSeconds>120</TimeoutSeconds></DataSource></Discovery>")
        $rollupId = "HyperVPrivateCloud.Capability.S2D.$($definition.Kind).Dependency.Monitor"
        [void]$rollups.AppendLine("<DependencyMonitor ID=`"$rollupId`" Accessibility=`"Public`" Enabled=`"true`" Target=`"HCSV2Library!HyperVPrivateCloud.StorageComponent`" ParentMonitorID=`"Health!System.Health.AvailabilityState`" Remotable=`"true`" Priority=`"Normal`" RelationshipType=`"$relationshipId`" MemberMonitor=`"Health!System.Health.AvailabilityState`"><Category>AvailabilityHealth</Category><Algorithm>WorstOf</Algorithm><MemberUnAvailable>Success</MemberUnAvailable></DependencyMonitor>")
        $viewId = "HyperVPrivateCloud.Capability.S2D.$($definition.Kind).State.View"
        [void]$views.AppendLine("<View ID=`"$viewId`" Accessibility=`"Public`" Enabled=`"true`" Target=`"S2D!$classId`" TypeID=`"SC!Microsoft.SystemCenter.StateViewType`" Visible=`"true`"><Category>Operations</Category><Criteria /></View>")
        [void]$folderItems.AppendLine("<FolderItem ElementID=`"$viewId`" ID=`"$viewId.FolderItem`" Folder=`"HCSV2Presentation!HyperVPrivateCloud.Storage.Folder`" />")
        [void]$displays.AppendLine("<DisplayString ElementID=`"$rollupId`"><Name>Roll up $($definition.Name) health</Name></DisplayString>")
        [void]$displays.AppendLine("<DisplayString ElementID=`"$viewId`"><Name>$($definition.Name)</Name></DisplayString>")
    }

    $extraViews = @(
        @('Performance', 'S2D!Microsoft.Windows.Server.10.0.Storage.StorageSpacesDirect.StorageSubSystem', 'SC!Microsoft.SystemCenter.PerformanceViewType', 'S2D performance'),
        @('ActiveAlerts', 'S2D!Microsoft.Windows.Server.10.0.Storage.StorageSpacesDirect.StorageObject.Group', 'SC!Microsoft.SystemCenter.AlertViewType', 'S2D active alerts'),
        @('Faults', 'S2D!Microsoft.Windows.Server.10.0.Storage.StorageSpacesDirect.StorageObject.Group', 'SC!Microsoft.SystemCenter.AlertViewType', 'S2D faults'),
        @('OngoingJobs', 'S2D!Microsoft.Windows.Server.10.0.Storage.StorageSpacesDirect.StorageObject.Group', 'SC!Microsoft.SystemCenter.AlertViewType', 'S2D ongoing jobs')
    )
    foreach ($view in $extraViews) {
        $id = "HyperVPrivateCloud.Capability.S2D.$($view[0]).View"
        $criteria = if ($view[2] -like '*AlertViewType') { '<Criteria><ResolutionState><StateRange Operator="NotEquals">255</StateRange></ResolutionState></Criteria>' } else { '<Criteria />' }
        [void]$views.AppendLine("<View ID=`"$id`" Accessibility=`"Public`" Enabled=`"true`" Target=`"$($view[1])`" TypeID=`"$($view[2])`" Visible=`"true`"><Category>Operations</Category>$criteria</View>")
        [void]$folderItems.AppendLine("<FolderItem ElementID=`"$id`" ID=`"$id.FolderItem`" Folder=`"HCSV2Presentation!HyperVPrivateCloud.Storage.Folder`" />")
        [void]$displays.AppendLine("<DisplayString ElementID=`"$id`"><Name>$($view[3])</Name></DisplayString>")
    }
    [void]$displays.AppendLine('<DisplayString ElementID="HyperVPrivateCloud.Capability.S2D.IntegrationHealth.Monitor"><Name>S2D integration pipeline health</Name><Description>Verifies the HCS query path without duplicating Microsoft S2D leaf monitoring.</Description></DisplayString>')
    foreach ($state in @('Good', 'Warning', 'Critical')) { [void]$displays.AppendLine("<DisplayString ElementID=`"HyperVPrivateCloud.Capability.S2D.IntegrationHealth.Monitor`" SubElementID=`"$state`"><Name>$state</Name></DisplayString>") }
    [void]$displays.AppendLine('<DisplayString ElementID="HyperVPrivateCloud.Capability.S2D.IntegrationHealth.Monitor.Message"><Name>S2D integration pipeline health</Name><Description>{0}</Description></DisplayString>')

    return [pscustomobject]@{ Discoveries = $discoveries.ToString(); Rollups = $rollups.ToString(); Views = $views.ToString(); FolderItems = $folderItems.ToString(); DisplayStrings = $displays.ToString() }
}

function Get-HcsPureStorageCapabilityContent {
    [CmdletBinding()]
    param()

    $rollupDefinitions = @(
        @('Array', 'HCSV2Library!HyperVPrivateCloud.StorageComponent', 'HyperVPrivateCloud.Capability.PureStorage.StorageContainsPureArray', 'Pure array health'),
        @('Port', 'HCSV2Library!HyperVPrivateCloud.StorageComponent', 'HyperVPrivateCloud.Capability.PureStorage.StorageContainsPurePort', 'Pure port health'),
        @('Host', 'HCSV2Library!HyperVPrivateCloud.HostRole', 'HyperVPrivateCloud.Capability.PureStorage.HostRoleReferencesPureHost', 'Pure host health'),
        @('Volume', 'HCSV2Storage!HyperVPrivateCloud.Capability.Storage.LogicalUnit', 'HyperVPrivateCloud.Capability.PureStorage.LogicalUnitReferencesPureVolume', 'Pure volume health')
    )
    $rollups = [System.Text.StringBuilder]::new()
    $views = [System.Text.StringBuilder]::new()
    $folderItems = [System.Text.StringBuilder]::new()
    $displays = [System.Text.StringBuilder]::new()
    foreach ($definition in $rollupDefinitions) {
        $id = "HyperVPrivateCloud.Capability.PureStorage.$($definition[0]).Dependency.Monitor"
        [void]$rollups.AppendLine("<DependencyMonitor ID=`"$id`" Accessibility=`"Public`" Enabled=`"true`" Target=`"$($definition[1])`" ParentMonitorID=`"Health!System.Health.AvailabilityState`" Remotable=`"true`" Priority=`"Normal`" RelationshipType=`"$($definition[2])`" MemberMonitor=`"Health!System.Health.AvailabilityState`"><Category>AvailabilityHealth</Category><Algorithm>WorstOf</Algorithm><MemberUnAvailable>Success</MemberUnAvailable></DependencyMonitor>")
        [void]$displays.AppendLine("<DisplayString ElementID=`"$id`"><Name>Roll up $($definition[3])</Name></DisplayString>")
    }
    $viewDefinitions = @(
        @('Pod', 'PureStorage.FlashArray.Pod', 'SC!Microsoft.SystemCenter.StateViewType', 'Pure ActiveCluster pods'),
        @('PodReplica', 'PureStorage.FlashArray.PodReplica', 'SC!Microsoft.SystemCenter.StateViewType', 'Pure pod replicas'),
        @('Array', 'PureStorage.FlashArray.PureArray', 'SC!Microsoft.SystemCenter.StateViewType', 'Pure arrays'),
        @('Controller', 'PureStorage.FlashArray.PureController', 'SC!Microsoft.SystemCenter.StateViewType', 'Pure controllers'),
        @('Host', 'PureStorage.FlashArray.PureHost', 'SC!Microsoft.SystemCenter.StateViewType', 'Pure hosts'),
        @('Hostgroup', 'PureStorage.FlashArray.PureHostgroup', 'SC!Microsoft.SystemCenter.StateViewType', 'Pure host groups'),
        @('Port', 'PureStorage.FlashArray.PurePort', 'SC!Microsoft.SystemCenter.StateViewType', 'Pure ports'),
        @('Volume', 'PureStorage.FlashArray.PureVolume', 'SC!Microsoft.SystemCenter.StateViewType', 'Pure volumes'),
        @('ActiveAlerts', 'PureStorage.FlashArray.PureArray', 'SC!Microsoft.SystemCenter.AlertViewType', 'Pure active alerts'),
        @('ArrayPerformance', 'PureStorage.FlashArray.PureArray', 'SC!Microsoft.SystemCenter.PerformanceViewType', 'Pure array performance'),
        @('VolumePerformance', 'PureStorage.FlashArray.PureVolume', 'SC!Microsoft.SystemCenter.PerformanceViewType', 'Pure volume performance')
    )
    foreach ($view in $viewDefinitions) {
        $id = "HyperVPrivateCloud.Capability.PureStorage.$($view[0]).View"
        $criteria = if ($view[2] -like '*AlertViewType') { '<Criteria><ResolutionState><StateRange Operator="NotEquals">255</StateRange></ResolutionState></Criteria>' } else { '<Criteria />' }
        [void]$views.AppendLine("<View ID=`"$id`" Accessibility=`"Public`" Enabled=`"true`" Target=`"Pure!$($view[1])`" TypeID=`"$($view[2])`" Visible=`"true`"><Category>Operations</Category>$criteria</View>")
        [void]$folderItems.AppendLine("<FolderItem ElementID=`"$id`" ID=`"$id.FolderItem`" Folder=`"HCSV2Presentation!HyperVPrivateCloud.Storage.Folder`" />")
        [void]$displays.AppendLine("<DisplayString ElementID=`"$id`"><Name>$($view[3])</Name></DisplayString>")
    }
    [void]$displays.AppendLine('<DisplayString ElementID="HyperVPrivateCloud.Capability.PureStorage.IntegrationHealth.Monitor"><Name>Pure Storage correlation health</Name><Description>Verifies exact IQN, WWPN, and serial correlations without duplicating array monitoring.</Description></DisplayString>')
    foreach ($state in @('Good', 'Warning', 'Critical')) { [void]$displays.AppendLine("<DisplayString ElementID=`"HyperVPrivateCloud.Capability.PureStorage.IntegrationHealth.Monitor`" SubElementID=`"$state`"><Name>$state</Name></DisplayString>") }
    [void]$displays.AppendLine('<DisplayString ElementID="HyperVPrivateCloud.Capability.PureStorage.IntegrationHealth.Monitor.Message"><Name>Pure Storage correlation health</Name><Description>{0}</Description></DisplayString>')
    return [pscustomobject]@{ Rollups = $rollups.ToString(); Views = $views.ToString(); FolderItems = $folderItems.ToString(); DisplayStrings = $displays.ToString() }
}

function Get-HcsFileServicesCapabilityContent {
    [CmdletBinding()]
    param()

    $rollupDefinitions = @(
        @('StorageShare', 'HCSV2Library!HyperVPrivateCloud.StorageComponent', 'HyperVPrivateCloud.Capability.FileServices.StorageContainsSmbShare', 'SMB share health into Storage'),
        @('HostShare', 'HCSV2Library!HyperVPrivateCloud.HostRole', 'HyperVPrivateCloud.Capability.FileServices.HostRoleUsesSmbShare', 'SMB share health into Hyper-V hosts'),
        @('MicrosoftSmb', 'HyperVPrivateCloud.Capability.FileServices.SmbShare', 'HyperVPrivateCloud.Capability.FileServices.SmbShareReferencesMicrosoftSmbService', 'Microsoft SMB service health into shares')
    )
    $rollups = [System.Text.StringBuilder]::new()
    $views = [System.Text.StringBuilder]::new()
    $folderItems = [System.Text.StringBuilder]::new()
    $displays = [System.Text.StringBuilder]::new()
    foreach ($definition in $rollupDefinitions) {
        $id = "HyperVPrivateCloud.Capability.FileServices.$($definition[0]).Dependency.Monitor"
        [void]$rollups.AppendLine("<DependencyMonitor ID=`"$id`" Accessibility=`"Public`" Enabled=`"true`" Target=`"$($definition[1])`" ParentMonitorID=`"Health!System.Health.AvailabilityState`" Remotable=`"true`" Priority=`"Normal`" RelationshipType=`"$($definition[2])`" MemberMonitor=`"Health!System.Health.AvailabilityState`"><Category>AvailabilityHealth</Category><Algorithm>WorstOf</Algorithm><MemberUnAvailable>Success</MemberUnAvailable></DependencyMonitor>")
        [void]$displays.AppendLine("<DisplayString ElementID=`"$id`"><Name>Roll up $($definition[3])</Name></DisplayString>")
    }
    $viewDefinitions = @(
        @('Share', 'HyperVPrivateCloud.Capability.FileServices.SmbShare', 'SC!Microsoft.SystemCenter.StateViewType', 'Hyper-V SMB shares'),
        @('ClientPath', 'HyperVPrivateCloud.Capability.FileServices.SmbClientPath', 'SC!Microsoft.SystemCenter.StateViewType', 'SMB Multichannel and RDMA paths'),
        @('VhdxMapping', 'HyperVPrivateCloud.Capability.FileServices.SmbVhdxMapping', 'SC!Microsoft.SystemCenter.StateViewType', 'SMB VHDX mappings'),
        @('FileServer', 'FileServices!Microsoft.Windows.FileServer', 'SC!Microsoft.SystemCenter.StateViewType', 'Microsoft file servers'),
        @('SmbService', 'FileSMB!Microsoft.Windows.FileServices.Service.SMB.10.0', 'SC!Microsoft.SystemCenter.StateViewType', 'Microsoft SMB services'),
        @('ActiveAlerts', 'HyperVPrivateCloud.Capability.FileServices.SmbShare', 'SC!Microsoft.SystemCenter.AlertViewType', 'SMB and SOFS active alerts'),
        @('Performance', 'FileSMB!Microsoft.Windows.FileServices.Service.SMB.10.0', 'SC!Microsoft.SystemCenter.PerformanceViewType', 'SMB service performance')
    )
    foreach ($view in $viewDefinitions) {
        $id = "HyperVPrivateCloud.Capability.FileServices.$($view[0]).View"
        $criteria = if ($view[2] -like '*AlertViewType') { '<Criteria><ResolutionState><StateRange Operator="NotEquals">255</StateRange></ResolutionState></Criteria>' } else { '<Criteria />' }
        $target = if ($view[1] -like '*!*') { $view[1] } elseif ($view[1] -like 'Microsoft.*') { "FileServices!$($view[1])" } else { $view[1] }
        [void]$views.AppendLine("<View ID=`"$id`" Accessibility=`"Public`" Enabled=`"true`" Target=`"$target`" TypeID=`"$($view[2])`" Visible=`"true`"><Category>Operations</Category>$criteria</View>")
        [void]$folderItems.AppendLine("<FolderItem ElementID=`"$id`" ID=`"$id.FolderItem`" Folder=`"HCSV2Presentation!HyperVPrivateCloud.Storage.Folder`" />")
        [void]$displays.AppendLine("<DisplayString ElementID=`"$id`"><Name>$($view[3])</Name></DisplayString>")
    }
    [void]$displays.AppendLine('<DisplayString ElementID="HyperVPrivateCloud.Capability.FileServices.Health.Monitor"><Name>Hyper-V over SMB health</Name><Description>Validates required SMB connections, continuous availability, and optional RDMA paths.</Description></DisplayString>')
    foreach ($state in @('Good', 'Warning', 'Critical')) { [void]$displays.AppendLine("<DisplayString ElementID=`"HyperVPrivateCloud.Capability.FileServices.Health.Monitor`" SubElementID=`"$state`"><Name>$state</Name></DisplayString>") }
    [void]$displays.AppendLine('<DisplayString ElementID="HyperVPrivateCloud.Capability.FileServices.Health.Monitor.Message"><Name>Hyper-V over SMB health</Name><Description>{0}</Description></DisplayString>')
    return [pscustomobject]@{ Rollups = $rollups.ToString(); Views = $views.ToString(); FolderItems = $folderItems.ToString(); DisplayStrings = $displays.ToString() }
}

function Get-HcsPhysicalNetworkCapabilityContent {
    [CmdletBinding()]
    param()

    $folderItems = [System.Text.StringBuilder]::new()
    $displays = [System.Text.StringBuilder]::new()
    $views = @(
        @('Node.State', 'Physical network nodes'),
        @('Switch.State', 'Physical switches'),
        @('Adapter.State', 'Network interfaces and adapters'),
        @('Port.State', 'Physical switch ports'),
        @('Vlan.State', 'Network VLANs'),
        @('Connection.State', 'Network connections'),
        @('ActiveAlerts', 'Physical network active alerts'),
        @('Performance', 'Physical network performance')
    )
    foreach ($view in $views) {
        $id = "HyperVPrivateCloud.Capability.PhysicalNetwork.$($view[0]).View"
        [void]$folderItems.AppendLine("<FolderItem ElementID=`"$id`" ID=`"$id.FolderItem`" Folder=`"HCSV2Presentation!HyperVPrivateCloud.Networking.Folder`" />")
        [void]$displays.AppendLine("<DisplayString ElementID=`"$id`"><Name>$($view[1])</Name></DisplayString>")
    }
    [void]$displays.AppendLine('<DisplayString ElementID="HyperVPrivateCloud.Capability.PhysicalNetwork.IntegrationHealth.Monitor"><Name>Physical-network correlation input health</Name><Description>Validates the exact Windows adapter identities supplied to SCOM built-in MAC-based network topology correlation.</Description></DisplayString>')
    foreach ($state in @('Good', 'Warning', 'Critical')) { [void]$displays.AppendLine("<DisplayString ElementID=`"HyperVPrivateCloud.Capability.PhysicalNetwork.IntegrationHealth.Monitor`" SubElementID=`"$state`"><Name>$state</Name></DisplayString>") }
    [void]$displays.AppendLine('<DisplayString ElementID="HyperVPrivateCloud.Capability.PhysicalNetwork.IntegrationHealth.Monitor.Message"><Name>Physical-network correlation input failed</Name><Description>{0}</Description></DisplayString>')
    [void]$displays.AppendLine('<DisplayString ElementID="HyperVPrivateCloud.Capability.PhysicalNetwork.NetworkAdapter.Dependency.Monitor"><Name>Roll up Hyper-V host network-adapter health</Name></DisplayString>')
    [void]$displays.AppendLine('<DisplayString ElementID="HyperVPrivateCloud.Capability.PhysicalNetwork.VirtualSwitchUplink.Dependency.Monitor"><Name>Roll up physical uplink health into virtual switches</Name></DisplayString>')
    [void]$displays.AppendLine('<DisplayString ElementID="HyperVPrivateCloud.Capability.PhysicalNetwork.Relationship.Discovery"><Name>Discover Hyper-V physical-uplink relationships</Name><Description>Relates external Hyper-V switches to Microsoft Windows network-adapter objects. SCOM remains authoritative for device, switch, port, VLAN, and connection discovery.</Description></DisplayString>')
    return [pscustomobject]@{ FolderItems = $folderItems.ToString(); DisplayStrings = $displays.ToString() }
}

function Get-HcsVmmCapabilityContent {
    [CmdletBinding()]
    param()

    $viewNames = [ordered]@{
        'FabricServices.State' = 'VMM fabric services'
        'ManagementServers.State' = 'VMM management servers'
        'PrivateClouds.State' = 'VMM private clouds'
        'HostGroups.State' = 'VMM host groups'
        'HostClusters.State' = 'VMM host clusters'
        'HyperVHosts.State' = 'VMM Hyper-V hosts'
        'VirtualMachines.State' = 'VMM virtual machines'
        'VMNetworks.State' = 'VMM VM networks'
        'LogicalNetworks.State' = 'VMM logical networks'
        'NetworkSites.State' = 'VMM network sites'
        'VirtualSwitches.State' = 'VMM virtual switches'
        'StoragePools.State' = 'VMM storage pools'
        'ManagementServers.Alerts' = 'VMM management-server active alerts'
        'HyperVHosts.Alerts' = 'VMM Hyper-V host active alerts'
        'PrivateClouds.Alerts' = 'VMM private-cloud active alerts'
        'VirtualMachines.Alerts' = 'VMM virtual-machine active alerts'
        'HyperVHosts.Performance' = 'VMM Hyper-V host performance'
        'VirtualMachines.Performance' = 'VMM virtual-machine performance'
        'StoragePools.Performance' = 'VMM storage-pool performance'
        'PrivateClouds.Performance' = 'VMM private-cloud performance'
    }
    $folderItems = [System.Text.StringBuilder]::new()
    $displayStrings = [System.Text.StringBuilder]::new()
    foreach ($entry in $viewNames.GetEnumerator()) {
        $viewId = "HyperVPrivateCloud.Capability.VMM.$($entry.Key).View"
        [void]$folderItems.AppendLine("<FolderItem ElementID=`"$viewId`" ID=`"$viewId.FolderItem`" Folder=`"HyperVPrivateCloud.Capability.VMM.Folder`" />")
        [void]$displayStrings.AppendLine("<DisplayString ElementID=`"$viewId`"><Name>$($entry.Value)</Name></DisplayString>")
    }
    [void]$displayStrings.AppendLine('<DisplayString ElementID="HyperVPrivateCloud.Capability.VMM.Folder"><Name>Virtual Machine Manager</Name><Description>VMM fabric services, management health, private clouds, hosts, virtual machines, networking, storage, failed jobs, alerts, and performance.</Description></DisplayString>')
    [void]$displayStrings.AppendLine('<DisplayString ElementID="HyperVPrivateCloud.Capability.VMM.IntegrationHealth.Monitor"><Name>VMM integration and topology-query health</Name><Description>Validates the VMM module, read-only connection, logical-network, network-site, and VM-network queries.</Description></DisplayString>')
    [void]$displayStrings.AppendLine('<DisplayString ElementID="HyperVPrivateCloud.Capability.VMM.FailedJobs.Monitor"><Name>Recent failed VMM jobs</Name><Description>Tracks VMM jobs with Failed status during the configured lookback period.</Description></DisplayString>')
    foreach ($monitorId in @('IntegrationHealth', 'FailedJobs')) {
        foreach ($state in @('Good', 'Warning', 'Critical')) {
            [void]$displayStrings.AppendLine("<DisplayString ElementID=`"HyperVPrivateCloud.Capability.VMM.$monitorId.Monitor`" SubElementID=`"$state`"><Name>$state</Name></DisplayString>")
        }
    }
    [void]$displayStrings.AppendLine('<DisplayString ElementID="HyperVPrivateCloud.Capability.VMM.IntegrationHealth.Monitor.Message"><Name>VMM integration query failed</Name><Description>{0}</Description></DisplayString>')
    [void]$displayStrings.AppendLine('<DisplayString ElementID="HyperVPrivateCloud.Capability.VMM.FailedJobs.Monitor.Message"><Name>Recent VMM jobs failed</Name><Description>{0}</Description></DisplayString>')
    $workflowNames = [ordered]@{
        'Fabric.Discovery' = 'Discover VMM fabric service, logical networks, and network sites'
        'Host.Relationship.Discovery' = 'Discover VMM-to-Hyper-V host relationships'
        'Cloud.Relationship.Discovery' = 'Discover VMM private-cloud relationships'
        'Management.Server.Availability.Dependency.Monitor' = 'Roll up VMM management-server availability'
        'Management.Server.Configuration.Dependency.Monitor' = 'Roll up VMM management-server configuration and failed jobs'
        'Compute.Host.WinRM.Dependency.Monitor' = 'Roll up VMM host WinRM availability into the VMM fabric'
        'Compute.Host.AgentVersion.Dependency.Monitor' = 'Roll up VMM host agent-version compliance into the VMM fabric'
        'Management.Host.WinRM.Dependency.Monitor' = 'Roll up VMM host WinRM availability into its Hyper-V boundary'
        'Management.Host.AgentVersion.Dependency.Monitor' = 'Roll up VMM host agent-version compliance into its Hyper-V boundary'
        'Management.Cloud.Availability.Dependency.Monitor' = 'Roll up VMM private-cloud availability'
        'Management.Cloud.Configuration.Dependency.Monitor' = 'Roll up VMM private-cloud configuration'
        'ClusterManagement.Cloud.Availability.Dependency.Monitor' = 'Roll up mapped VMM private-cloud availability into the cluster boundary'
        'ClusterManagement.Cloud.Configuration.Dependency.Monitor' = 'Roll up mapped VMM private-cloud configuration into the cluster boundary'
    }
    foreach ($entry in $workflowNames.GetEnumerator()) {
        [void]$displayStrings.AppendLine("<DisplayString ElementID=`"HyperVPrivateCloud.Capability.VMM.$($entry.Key)`"><Name>$($entry.Value)</Name></DisplayString>")
    }
    return [pscustomobject]@{ FolderItems = $folderItems.ToString(); DisplayStrings = $displayStrings.ToString() }
}

$sourceRoot = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$manifestPath = Join-Path $sourceRoot 'build/build-manifest.json'
$manifest = Get-Content -LiteralPath $manifestPath -Raw | ConvertFrom-Json

if ($manifest.namespace -ne 'HyperVPrivateCloud') {
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
            HOST_TASK_SCRIPT = 'Invoke-HyperVPrivateCloudHostTask.ps1.template'
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
    if ($artifact.id -eq 'HyperVPrivateCloud.Capability.Cluster') {
        $capabilityDirectory = Split-Path -Parent $sourcePath
        $scriptTokens = [ordered]@{
            CLUSTER_RELATIONSHIP_DISCOVERY_SCRIPT = 'Discover-HyperVPrivateCloudClusterRelationships.ps1.template'
            CLUSTER_HEALTH_SCRIPT = 'Get-HyperVPrivateCloudClusterIntegrationHealth.ps1.template'
            CLUSTER_CSV_HEALTH_SCRIPT = 'Get-HyperVPrivateCloudClusterCsvHealth.ps1.template'
            CLUSTER_TASK_SCRIPT = 'Invoke-HyperVPrivateCloudClusterTask.ps1.template'
            CLUSTER_ROLE_DISCOVERY_SCRIPT = 'Discover-HyperVPrivateCloudClusterRole.ps1.template'
        }
        foreach ($entry in $scriptTokens.GetEnumerator()) {
            $capabilityScriptPath = Join-Path $capabilityDirectory $entry.Value
            if (-not (Test-Path -LiteralPath $capabilityScriptPath -PathType Leaf)) { throw "Cluster capability script source does not exist: $capabilityScriptPath" }
            $capabilityScript = Get-Content -LiteralPath $capabilityScriptPath -Raw
            if ($capabilityScript.Contains(']]>')) { throw "Cluster capability script contains the CDATA terminator: $capabilityScriptPath" }
            $content = $content.Replace("{{$($entry.Key)}}", $capabilityScript.TrimEnd())
        }
    }
    if ($artifact.id -eq 'HyperVPrivateCloud.Capability.Storage') {
        $capabilityDirectory = Split-Path -Parent $sourcePath
        $scriptTokens = [ordered]@{
            STORAGE_TOPOLOGY_DISCOVERY_SCRIPT = 'Discover-HyperVPrivateCloudStorageTopology.ps1.template'
            STORAGE_INTEGRATION_HEALTH_SCRIPT = 'Get-HyperVPrivateCloudStorageIntegrationHealth.ps1.template'
            STORAGE_OBJECT_HEALTH_SCRIPT = 'Get-HyperVPrivateCloudStorageObjectHealth.ps1.template'
            STORAGE_TASK_SCRIPT = 'Invoke-HyperVPrivateCloudStorageTask.ps1.template'
        }
        foreach ($entry in $scriptTokens.GetEnumerator()) {
            $capabilityScriptPath = Join-Path $capabilityDirectory $entry.Value
            if (-not (Test-Path -LiteralPath $capabilityScriptPath -PathType Leaf)) { throw "Storage capability script source does not exist: $capabilityScriptPath" }
            $capabilityScript = Get-Content -LiteralPath $capabilityScriptPath -Raw
            if ($capabilityScript.Contains(']]>')) { throw "Storage capability script contains the CDATA terminator: $capabilityScriptPath" }
            $content = $content.Replace("{{$($entry.Key)}}", $capabilityScript.TrimEnd())
        }
        $storageContent = Get-HcsStorageCapabilityContent
        $content = $content.Replace('{{STORAGE_INTEGRATION_FILTERS}}', $storageContent.IntegrationFilters)
        $content = $content.Replace('{{STORAGE_INTEGRATION_DETECTIONS}}', $storageContent.Detections)
        $content = $content.Replace('{{STORAGE_OBJECT_FILTERS}}', $storageContent.ObjectFilters)
        $content = $content.Replace('{{STORAGE_OBJECT_DETECTIONS}}', $storageContent.Detections)
        $content = $content.Replace('{{STORAGE_DISCOVERY_TYPES}}', $storageContent.DiscoveryTypes)
        $content = $content.Replace('{{STORAGE_MONITORS}}', $storageContent.Monitors)
        $content = $content.Replace('{{STORAGE_VIEWS}}', $storageContent.Views)
        $content = $content.Replace('{{STORAGE_FOLDER_ITEMS}}', $storageContent.FolderItems)
        $content = $content.Replace('{{STORAGE_STRING_RESOURCES}}', $storageContent.StringResources)
        $content = $content.Replace('{{STORAGE_DISPLAY_STRINGS}}', $storageContent.DisplayStrings)
        $content = $content.Replace('{{STORAGE_KNOWLEDGE}}', $storageContent.Knowledge)
    }
    if ($artifact.id -eq 'HyperVPrivateCloud.Capability.S2D') {
        $capabilityDirectory = Split-Path -Parent $sourcePath
        $s2dContent = Get-HcsS2DCapabilityContent
        $content = $content.Replace('{{S2D_DISCOVERIES}}', $s2dContent.Discoveries)
        $content = $content.Replace('{{S2D_ROLLUPS}}', $s2dContent.Rollups)
        $content = $content.Replace('{{S2D_VIEWS}}', $s2dContent.Views)
        $content = $content.Replace('{{S2D_FOLDER_ITEMS}}', $s2dContent.FolderItems)
        $content = $content.Replace('{{S2D_DISPLAY_STRINGS}}', $s2dContent.DisplayStrings)
        $scriptTokens = [ordered]@{
            S2D_RELATIONSHIP_DISCOVERY_SCRIPT = 'Discover-HyperVPrivateCloudS2DRelationships.ps1.template'
            S2D_INTEGRATION_HEALTH_SCRIPT = 'Get-HyperVPrivateCloudS2DIntegrationHealth.ps1.template'
            S2D_OBJECT_HEALTH_SCRIPT = 'Get-HyperVPrivateCloudS2DObjectHealth.ps1.template'
            S2D_TASK_SCRIPT = 'Invoke-HyperVPrivateCloudS2DTask.ps1.template'
        }
        foreach ($entry in $scriptTokens.GetEnumerator()) {
            $capabilityScriptPath = Join-Path $capabilityDirectory $entry.Value
            if (-not (Test-Path -LiteralPath $capabilityScriptPath -PathType Leaf)) { throw "S2D capability script source does not exist: $capabilityScriptPath" }
            $capabilityScript = Get-Content -LiteralPath $capabilityScriptPath -Raw
            if ($capabilityScript.Contains(']]>')) { throw "S2D capability script contains the CDATA terminator: $capabilityScriptPath" }
            $content = $content.Replace("{{$($entry.Key)}}", $capabilityScript.TrimEnd())
        }
    }
    if ($artifact.id -eq 'HyperVPrivateCloud.Capability.PureStorage') {
        $capabilityDirectory = Split-Path -Parent $sourcePath
        $scriptTokens = [ordered]@{
            PURE_CORRELATION_DISCOVERY_SCRIPT = 'Discover-HyperVPrivateCloudPureCorrelations.ps1.template'
            PURE_INTEGRATION_HEALTH_SCRIPT = 'Get-HyperVPrivateCloudPureIntegrationHealth.ps1.template'
        }
        foreach ($entry in $scriptTokens.GetEnumerator()) {
            $capabilityScriptPath = Join-Path $capabilityDirectory $entry.Value
            if (-not (Test-Path -LiteralPath $capabilityScriptPath -PathType Leaf)) { throw "Pure Storage capability script source does not exist: $capabilityScriptPath" }
            $capabilityScript = Get-Content -LiteralPath $capabilityScriptPath -Raw
            if ($capabilityScript.Contains(']]>')) { throw "Pure Storage capability script contains the CDATA terminator: $capabilityScriptPath" }
            $content = $content.Replace("{{$($entry.Key)}}", $capabilityScript.TrimEnd())
        }
        $pureContent = Get-HcsPureStorageCapabilityContent
        $content = $content.Replace('{{PURE_ROLLUPS}}', $pureContent.Rollups)
        $content = $content.Replace('{{PURE_VIEWS}}', $pureContent.Views)
        $content = $content.Replace('{{PURE_FOLDER_ITEMS}}', $pureContent.FolderItems)
        $content = $content.Replace('{{PURE_DISPLAY_STRINGS}}', $pureContent.DisplayStrings)
    }
    if ($artifact.id -eq 'HyperVPrivateCloud.Capability.FileServices') {
        $capabilityDirectory = Split-Path -Parent $sourcePath
        $scriptTokens = [ordered]@{
            FILE_SERVICES_DISCOVERY_SCRIPT = 'Discover-HyperVPrivateCloudFileServices.ps1.template'
            FILE_SERVICES_HEALTH_SCRIPT = 'Get-HyperVPrivateCloudFileServicesHealth.ps1.template'
            FILE_SERVICES_TASK_SCRIPT = 'Invoke-HyperVPrivateCloudFileServicesTask.ps1.template'
        }
        foreach ($entry in $scriptTokens.GetEnumerator()) {
            $capabilityScriptPath = Join-Path $capabilityDirectory $entry.Value
            if (-not (Test-Path -LiteralPath $capabilityScriptPath -PathType Leaf)) { throw "File Services capability script source does not exist: $capabilityScriptPath" }
            $capabilityScript = Get-Content -LiteralPath $capabilityScriptPath -Raw
            if ($capabilityScript.Contains(']]>')) { throw "File Services capability script contains the CDATA terminator: $capabilityScriptPath" }
            $content = $content.Replace("{{$($entry.Key)}}", $capabilityScript.TrimEnd())
        }
        $fileServicesContent = Get-HcsFileServicesCapabilityContent
        $content = $content.Replace('{{FILE_SERVICES_ROLLUPS}}', $fileServicesContent.Rollups)
        $content = $content.Replace('{{FILE_SERVICES_VIEWS}}', $fileServicesContent.Views)
        $content = $content.Replace('{{FILE_SERVICES_FOLDER_ITEMS}}', $fileServicesContent.FolderItems)
        $content = $content.Replace('{{FILE_SERVICES_DISPLAY_STRINGS}}', $fileServicesContent.DisplayStrings)
    }
    if ($artifact.id -eq 'HyperVPrivateCloud.Capability.PhysicalNetwork') {
        $capabilityDirectory = Split-Path -Parent $sourcePath
        $scriptTokens = [ordered]@{
            PHYSICAL_NETWORK_DISCOVERY_SCRIPT = 'Discover-HyperVPrivateCloudPhysicalNetworkRelationships.ps1.template'
            PHYSICAL_NETWORK_HEALTH_SCRIPT = 'Get-HyperVPrivateCloudPhysicalNetworkIntegrationHealth.ps1.template'
            PHYSICAL_NETWORK_TASK_SCRIPT = 'Invoke-HyperVPrivateCloudPhysicalNetworkTask.ps1.template'
        }
        foreach ($entry in $scriptTokens.GetEnumerator()) {
            $capabilityScriptPath = Join-Path $capabilityDirectory $entry.Value
            if (-not (Test-Path -LiteralPath $capabilityScriptPath -PathType Leaf)) { throw "Physical Network capability script source does not exist: $capabilityScriptPath" }
            $capabilityScript = Get-Content -LiteralPath $capabilityScriptPath -Raw
            if ($capabilityScript.Contains(']]>')) { throw "Physical Network capability script contains the CDATA terminator: $capabilityScriptPath" }
            $content = $content.Replace("{{$($entry.Key)}}", $capabilityScript.TrimEnd())
        }
        $physicalNetworkContent = Get-HcsPhysicalNetworkCapabilityContent
        $content = $content.Replace('{{PHYSICAL_NETWORK_FOLDER_ITEMS}}', $physicalNetworkContent.FolderItems)
        $content = $content.Replace('{{PHYSICAL_NETWORK_DISPLAY_STRINGS}}', $physicalNetworkContent.DisplayStrings)
    }
    if ($artifact.id -eq 'HyperVPrivateCloud.Capability.NetworkATC') {
        $capabilityDirectory = Split-Path -Parent $sourcePath
        $scriptTokens = [ordered]@{
            NETWORK_ATC_DISCOVERY_SCRIPT = 'Discover-HyperVPrivateCloudNetworkAtc.ps1.template'
            NETWORK_ATC_HEALTH_SCRIPT = 'Get-HyperVPrivateCloudNetworkAtcHealth.ps1.template'
            NETWORK_ATC_TASK_SCRIPT = 'Invoke-HyperVPrivateCloudNetworkAtcTask.ps1.template'
        }
        foreach ($entry in $scriptTokens.GetEnumerator()) {
            $capabilityScriptPath = Join-Path $capabilityDirectory $entry.Value
            if (-not (Test-Path -LiteralPath $capabilityScriptPath -PathType Leaf)) { throw "Network ATC capability script source does not exist: $capabilityScriptPath" }
            $capabilityScript = Get-Content -LiteralPath $capabilityScriptPath -Raw
            if ($capabilityScript.Contains(']]>')) { throw "Network ATC capability script contains the CDATA terminator: $capabilityScriptPath" }
            $content = $content.Replace("{{$($entry.Key)}}", $capabilityScript.TrimEnd())
        }
    }
    if ($artifact.id -eq 'HyperVPrivateCloud.Capability.SDN') {
        $capabilityDirectory = Split-Path -Parent $sourcePath
        $scriptTokens = [ordered]@{
            SDN_RELATIONSHIP_DISCOVERY_SCRIPT = 'Discover-HyperVPrivateCloudSdnRelationships.ps1.template'
            SDN_INTEGRATION_HEALTH_SCRIPT = 'Get-HyperVPrivateCloudSdnIntegrationHealth.ps1.template'
            SDN_TASK_SCRIPT = 'Invoke-HyperVPrivateCloudSdnTask.ps1.template'
        }
        foreach ($entry in $scriptTokens.GetEnumerator()) {
            $capabilityScriptPath = Join-Path $capabilityDirectory $entry.Value
            if (-not (Test-Path -LiteralPath $capabilityScriptPath -PathType Leaf)) { throw "SDN capability script source does not exist: $capabilityScriptPath" }
            $capabilityScript = Get-Content -LiteralPath $capabilityScriptPath -Raw
            if ($capabilityScript.Contains(']]>')) { throw "SDN capability script contains the CDATA terminator: $capabilityScriptPath" }
            $content = $content.Replace("{{$($entry.Key)}}", $capabilityScript.TrimEnd())
        }
    }
    if ($artifact.id -eq 'HyperVPrivateCloud.Capability.VMM') {
        $capabilityDirectory = Split-Path -Parent $sourcePath
        $scriptTokens = [ordered]@{
            VMM_FABRIC_DISCOVERY_SCRIPT = 'Discover-HyperVPrivateCloudVmmFabric.ps1.template'
            VMM_HOST_DISCOVERY_SCRIPT = 'Discover-HyperVPrivateCloudVmmHostRelationships.ps1.template'
            VMM_CLOUD_DISCOVERY_SCRIPT = 'Discover-HyperVPrivateCloudVmmCloudRelationships.ps1.template'
            VMM_HEALTH_SCRIPT = 'Get-HyperVPrivateCloudVmmHealth.ps1.template'
            VMM_TASK_SCRIPT = 'Invoke-HyperVPrivateCloudVmmTask.ps1.template'
        }
        foreach ($entry in $scriptTokens.GetEnumerator()) {
            $capabilityScriptPath = Join-Path $capabilityDirectory $entry.Value
            if (-not (Test-Path -LiteralPath $capabilityScriptPath -PathType Leaf)) { throw "VMM capability script source does not exist: $capabilityScriptPath" }
            $capabilityScript = Get-Content -LiteralPath $capabilityScriptPath -Raw
            if ($capabilityScript.Contains(']]>')) { throw "VMM capability script contains the CDATA terminator: $capabilityScriptPath" }
            $content = $content.Replace("{{$($entry.Key)}}", $capabilityScript.TrimEnd())
        }
        $vmmContent = Get-HcsVmmCapabilityContent
        $content = $content.Replace('{{VMM_FOLDER_ITEMS}}', $vmmContent.FolderItems)
        $content = $content.Replace('{{VMM_DISPLAY_STRINGS}}', $vmmContent.DisplayStrings)
    }
    if ($content.Contains('{{ELEMENT_DISPLAY_STRINGS}}')) {
        [xml]$librarySource = $content.Replace('{{ELEMENT_DISPLAY_STRINGS}}', '')
        $content = $content.Replace(
            '{{ELEMENT_DISPLAY_STRINGS}}',
            (Get-HcsElementDisplayStringContent -ManagementPack $librarySource)
        )
    }
    if ($content -match '\{\{[A-Z0-9_]+\}\}') {
        throw "Unresolved build token in $sourcePath"
    }
    # A token that lost one brace on each side ({S2D_DISCOVERIES}) is not matched above and silently drops
    # the generated content; treat any single-brace upper-case token as corruption.
    if ($content -cmatch '(?<![\{$])\{[A-Z][A-Z0-9_]{3,}\}(?!\})') {
        throw "Corrupted single-brace build token '$($Matches[0])' in $sourcePath"
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
