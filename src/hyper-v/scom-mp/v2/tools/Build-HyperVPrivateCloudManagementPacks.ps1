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
    foreach ($id in $classIds) { [void]$discoveryTypes.AppendLine("<DiscoveryClass TypeID=`"HybridSolutionsCloud.HyperVPrivateCloud.Capability.Storage.$id`" />") }
    foreach ($id in $relationshipIds) { [void]$discoveryTypes.AppendLine("<DiscoveryRelationship TypeID=`"HybridSolutionsCloud.HyperVPrivateCloud.Capability.Storage.$id`" />") }

    $definitions = @(
        [pscustomobject]@{ Leaf = 'IntegrationHealth'; Target = 'HCSV2Library!HybridSolutionsCloud.HyperVPrivateCloud.HostRole'; Type = 'Integration'; Title = 'Windows SAN integration health'; Description = 'Verifies Windows Storage, iSCSI, Fibre Channel, and MPIO query coverage.'; Response = 'Install the required management tools, validate DSM claims and redundant paths, then review Operations Manager event 8403.'; Parent = 'ConfigurationState'; Category = 'ConfigurationHealth'; Alert = 'Error'; Configuration = '<ComputerName>$Target/Host/Property[Type="Windows!Microsoft.Windows.Computer"]/PrincipalName$</ComputerName><IntervalSeconds>300</IntervalSeconds><SyncTime /><TimeoutSeconds>120</TimeoutSeconds>' },
        [pscustomobject]@{ Leaf = 'AttachmentAvailability'; Target = 'HybridSolutionsCloud.HyperVPrivateCloud.Capability.Storage.HostAttachment'; Type = 'Object'; Title = 'SAN disk attachment availability'; Description = 'Tracks Windows-visible SAN disk state and writability.'; Response = 'Validate the array presentation, fabric, Windows disk state, DSM, and recent storage events before returning the disk to service.'; Parent = 'AvailabilityState'; Category = 'AvailabilityHealth'; Alert = 'Error'; Configuration = '<ObjectKind>Attachment</ObjectKind><Identity /><DiskNumber>$Target/Property[Type="HybridSolutionsCloud.HyperVPrivateCloud.Capability.Storage.HostAttachment"]/DiskNumber$</DiskNumber><StorageId>$Target/Property[Type="HybridSolutionsCloud.HyperVPrivateCloud.Capability.Storage.HostAttachment"]/StorageId$</StorageId><BusType>$Target/Property[Type="HybridSolutionsCloud.HyperVPrivateCloud.Capability.Storage.HostAttachment"]/BusType$</BusType><MinimumPathCount>2</MinimumPathCount><PropertyName>ObjectState</PropertyName><IntervalSeconds>300</IntervalSeconds><SyncTime /><TimeoutSeconds>120</TimeoutSeconds>' },
        [pscustomobject]@{ Leaf = 'AttachmentRedundancy'; Target = 'HybridSolutionsCloud.HyperVPrivateCloud.Capability.Storage.HostAttachment'; Type = 'Object'; Title = 'SAN MPIO path redundancy'; Description = 'Tracks MPIO path count for iSCSI and Fibre Channel disks.'; Response = 'Inspect HBA or NIC links, switches, target ports, MPIO policy, and vendor DSM state. Do not change claiming policy without vendor guidance.'; Parent = 'AvailabilityState'; Category = 'AvailabilityHealth'; Alert = 'Warning'; Configuration = '<ObjectKind>Attachment</ObjectKind><Identity /><DiskNumber>$Target/Property[Type="HybridSolutionsCloud.HyperVPrivateCloud.Capability.Storage.HostAttachment"]/DiskNumber$</DiskNumber><StorageId>$Target/Property[Type="HybridSolutionsCloud.HyperVPrivateCloud.Capability.Storage.HostAttachment"]/StorageId$</StorageId><BusType>$Target/Property[Type="HybridSolutionsCloud.HyperVPrivateCloud.Capability.Storage.HostAttachment"]/BusType$</BusType><MinimumPathCount>2</MinimumPathCount><PropertyName>RedundancyState</PropertyName><IntervalSeconds>300</IntervalSeconds><SyncTime /><TimeoutSeconds>120</TimeoutSeconds>' },
        [pscustomobject]@{ Leaf = 'IscsiSessionAvailability'; Target = 'HybridSolutionsCloud.HyperVPrivateCloud.Capability.Storage.IscsiSession'; Type = 'Object'; Title = 'iSCSI session availability'; Description = 'Tracks established iSCSI sessions and active connections.'; Response = 'Check initiator service state, target reachability, VLAN and MPIO design, authentication, and persistent-target configuration.'; Parent = 'AvailabilityState'; Category = 'AvailabilityHealth'; Alert = 'Error'; Configuration = '<ObjectKind>IscsiSession</ObjectKind><Identity>$Target/Property[Type="HybridSolutionsCloud.HyperVPrivateCloud.Capability.Storage.IscsiSession"]/SessionId$</Identity><DiskNumber>0</DiskNumber><StorageId /><BusType>iSCSI</BusType><MinimumPathCount>1</MinimumPathCount><PropertyName>ObjectState</PropertyName><IntervalSeconds>300</IntervalSeconds><SyncTime /><TimeoutSeconds>120</TimeoutSeconds>' },
        [pscustomobject]@{ Leaf = 'FibreChannelPortAvailability'; Target = 'HybridSolutionsCloud.HyperVPrivateCloud.Capability.Storage.FibreChannelPort'; Type = 'Object'; Title = 'Fibre Channel port availability'; Description = 'Tracks HBA provider and Fibre Channel port operational state.'; Response = 'Inspect HBA, driver, firmware, optic, cable, switch port, zoning, and array target-port state.'; Parent = 'AvailabilityState'; Category = 'AvailabilityHealth'; Alert = 'Error'; Configuration = '<ObjectKind>FibreChannelPort</ObjectKind><Identity>$Target/Property[Type="HybridSolutionsCloud.HyperVPrivateCloud.Capability.Storage.FibreChannelPort"]/PortId$</Identity><DiskNumber>0</DiskNumber><StorageId /><BusType>Fibre Channel</BusType><MinimumPathCount>1</MinimumPathCount><PropertyName>ObjectState</PropertyName><IntervalSeconds>300</IntervalSeconds><SyncTime /><TimeoutSeconds>120</TimeoutSeconds>' }
    )
    $monitors = [System.Text.StringBuilder]::new()
    $resources = [System.Text.StringBuilder]::new()
    $displays = [System.Text.StringBuilder]::new()
    $knowledge = [System.Text.StringBuilder]::new()
    foreach ($definition in $definitions) {
        $id = "HybridSolutionsCloud.HyperVPrivateCloud.Capability.Storage.$($definition.Leaf).Monitor"
        $messageId = "$id.Message"
        $typeId = "HybridSolutionsCloud.HyperVPrivateCloud.Capability.Storage.$($definition.Type)Health.MonitorType"
        $detailProperty = if ($definition.Leaf -eq 'AttachmentRedundancy') { 'RedundancyStateDetail' } elseif ($definition.Type -eq 'Integration') { 'StorageIntegrationStateDetail' } else { 'ObjectStateDetail' }
        [void]$monitors.AppendLine("<UnitMonitor ID=`"$id`" Accessibility=`"Public`" Enabled=`"true`" Target=`"$($definition.Target)`" ParentMonitorID=`"Health!System.Health.$($definition.Parent)`" Remotable=`"true`" Priority=`"Normal`" TypeID=`"$typeId`" ConfirmDelivery=`"true`"><Category>$($definition.Category)</Category><AlertSettings AlertMessage=`"$messageId`"><AlertOnState>$($definition.Alert)</AlertOnState><AutoResolve>true</AutoResolve><AlertPriority>Normal</AlertPriority><AlertSeverity>MatchMonitorHealth</AlertSeverity><AlertParameters><AlertParameter1>`$Data/Context/Property[@Name='$detailProperty']`$</AlertParameter1></AlertParameters></AlertSettings><OperationalStates><OperationalState ID=`"Good`" MonitorTypeStateID=`"Good`" HealthState=`"Success`" /><OperationalState ID=`"Warning`" MonitorTypeStateID=`"Warning`" HealthState=`"Warning`" /><OperationalState ID=`"Critical`" MonitorTypeStateID=`"Critical`" HealthState=`"Error`" /></OperationalStates><Configuration>$($definition.Configuration)</Configuration></UnitMonitor>")
        [void]$resources.AppendLine("<StringResource ID=`"$messageId`" />")
        [void]$displays.AppendLine("<DisplayString ElementID=`"$id`"><Name>$($definition.Title)</Name><Description>$($definition.Description)</Description></DisplayString>")
        foreach ($state in @('Good', 'Warning', 'Critical')) { [void]$displays.AppendLine("<DisplayString ElementID=`"$id`" SubElementID=`"$state`"><Name>$state</Name></DisplayString>") }
        [void]$displays.AppendLine("<DisplayString ElementID=`"$messageId`"><Name>$($definition.Title)</Name><Description>$($definition.Description) Detail: {0}</Description></DisplayString>")
        [void]$knowledge.AppendLine("<KnowledgeArticle ElementID=`"$id`" Visible=`"true`"><MamlContent><maml:section xmlns:maml=`"http://schemas.microsoft.com/maml/2004/10`"><maml:title>Summary</maml:title><maml:para>$($definition.Description)</maml:para></maml:section><maml:section xmlns:maml=`"http://schemas.microsoft.com/maml/2004/10`"><maml:title>Operator response</maml:title><maml:para>$($definition.Response)</maml:para></maml:section></MamlContent></KnowledgeArticle>")
    }

    $viewDefinitions = @(
        @('LogicalUnit', 'LogicalUnit', 'SAN logical units', 'HCSV2Presentation!HybridSolutionsCloud.HyperVPrivateCloud.Storage.Folder'),
        @('HostAttachment', 'HostAttachment', 'Host SAN attachments', 'HCSV2Presentation!HybridSolutionsCloud.HyperVPrivateCloud.Storage.Folder'),
        @('IscsiSession', 'IscsiSession', 'iSCSI sessions', 'HCSV2Presentation!HybridSolutionsCloud.HyperVPrivateCloud.Storage.Folder'),
        @('FibreChannelPort', 'FibreChannelPort', 'Fibre Channel ports', 'HCSV2Presentation!HybridSolutionsCloud.HyperVPrivateCloud.Storage.Folder'),
        @('VirtualDiskMapping', 'VirtualDiskMapping', 'VHDX to SAN mappings', 'HCSV2Presentation!HybridSolutionsCloud.HyperVPrivateCloud.Storage.Folder')
    )
    $views = [System.Text.StringBuilder]::new()
    $folderItems = [System.Text.StringBuilder]::new()
    foreach ($view in $viewDefinitions) {
        $id = "HybridSolutionsCloud.HyperVPrivateCloud.Capability.Storage.$($view[0]).State.View"
        [void]$views.AppendLine("<View ID=`"$id`" Accessibility=`"Public`" Enabled=`"true`" Target=`"HybridSolutionsCloud.HyperVPrivateCloud.Capability.Storage.$($view[1])`" TypeID=`"SC!Microsoft.SystemCenter.StateViewType`" Visible=`"true`"><Category>Operations</Category><Criteria /></View>")
        [void]$folderItems.AppendLine("<FolderItem ElementID=`"$id`" ID=`"$id.FolderItem`" Folder=`"$($view[3])`" />")
        [void]$displays.AppendLine("<DisplayString ElementID=`"$id`"><Name>$($view[2])</Name></DisplayString>")
    }
    $alertViewId = 'HybridSolutionsCloud.HyperVPrivateCloud.Capability.Storage.ActiveAlerts.View'
    [void]$views.AppendLine("<View ID=`"$alertViewId`" Accessibility=`"Public`" Enabled=`"true`" Target=`"HybridSolutionsCloud.HyperVPrivateCloud.Capability.Storage.HostAttachment`" TypeID=`"SC!Microsoft.SystemCenter.AlertViewType`" Visible=`"true`"><Category>Operations</Category><Criteria><ResolutionState><StateRange Operator=`"NotEquals`">255</StateRange></ResolutionState></Criteria></View>")
    [void]$folderItems.AppendLine("<FolderItem ElementID=`"$alertViewId`" ID=`"$alertViewId.FolderItem`" Folder=`"HCSV2Presentation!HybridSolutionsCloud.HyperVPrivateCloud.Operations.Folder`" />")
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
        $discoveryId = "HybridSolutionsCloud.HyperVPrivateCloud.Capability.S2D.$($definition.Kind).Relationship.Discovery"
        $relationshipId = "HybridSolutionsCloud.HyperVPrivateCloud.Capability.S2D.StorageContains$($definition.Kind)"
        $computerName = if ($definition.Kind -eq 'Volume') { '$Target/Host/Host/Property[Type="Windows!Microsoft.Windows.Computer"]/PrincipalName$' } elseif ($definition.Kind -eq 'FileShare') { '$Target/Host/Host/Host/Property[Type="Windows!Microsoft.Windows.Computer"]/PrincipalName$' } else { '$Target/Host/Property[Type="Windows!Microsoft.Windows.Computer"]/PrincipalName$' }
        $parentDisk = if ($definition.Kind -eq 'Volume') { '$Target/Host/Property[Type="StorageLibrary!Microsoft.Storage.Library.Windows.Disk"]/UniqueID$' } elseif ($definition.Kind -eq 'FileShare') { '$Target/Host/Host/Property[Type="StorageLibrary!Microsoft.Storage.Library.Windows.Disk"]/UniqueID$' } else { '' }
        $parentVolume = if ($definition.Kind -eq 'FileShare') { '$Target/Host/Property[Type="StorageLibrary!Microsoft.Storage.Library.Windows.Volume"]/UniqueID$' } else { '' }
        [void]$discoveries.AppendLine("<Discovery ID=`"$discoveryId`" Enabled=`"true`" Target=`"S2D!$classId`" ConfirmDelivery=`"false`" Remotable=`"true`" Priority=`"Normal`"><Category>Discovery</Category><DiscoveryTypes><DiscoveryRelationship TypeID=`"$relationshipId`" /></DiscoveryTypes><DataSource ID=`"PowerShellDiscovery`" TypeID=`"Windows!Microsoft.Windows.TimedPowerShell.DiscoveryProvider`"><IntervalSeconds>1800</IntervalSeconds><SyncTime /><ScriptName>HyperVPrivateCloud.S2D.RelationshipDiscovery.ps1</ScriptName><ScriptBody><![CDATA[{{S2D_RELATIONSHIP_DISCOVERY_SCRIPT}}]]></ScriptBody><Parameters><Parameter><Name>SourceId</Name><Value>`$MPElement`$</Value></Parameter><Parameter><Name>ManagedEntityId</Name><Value>`$Target/Id`$</Value></Parameter><Parameter><Name>ObjectKind</Name><Value>$($definition.Kind)</Value></Parameter><Parameter><Name>ComputerName</Name><Value>$computerName</Value></Parameter><Parameter><Name>UniqueId</Name><Value>`$Target/Property[Type=`"$($definition.KeyType)`"]`/UniqueID`$</Value></Parameter><Parameter><Name>ParentDiskUniqueId</Name><Value>$parentDisk</Value></Parameter><Parameter><Name>ParentVolumeUniqueId</Name><Value>$parentVolume</Value></Parameter></Parameters><TimeoutSeconds>120</TimeoutSeconds></DataSource></Discovery>")
        $rollupId = "HybridSolutionsCloud.HyperVPrivateCloud.Capability.S2D.$($definition.Kind).Dependency.Monitor"
        [void]$rollups.AppendLine("<DependencyMonitor ID=`"$rollupId`" Accessibility=`"Public`" Enabled=`"true`" Target=`"HCSV2Library!HybridSolutionsCloud.HyperVPrivateCloud.StorageComponent`" ParentMonitorID=`"Health!System.Health.AvailabilityState`" Remotable=`"true`" Priority=`"Normal`" RelationshipType=`"$relationshipId`" MemberMonitor=`"Health!System.Health.AvailabilityState`"><Category>AvailabilityHealth</Category><Algorithm>WorstOf</Algorithm><MemberUnAvailable>Success</MemberUnAvailable></DependencyMonitor>")
        $viewId = "HybridSolutionsCloud.HyperVPrivateCloud.Capability.S2D.$($definition.Kind).State.View"
        [void]$views.AppendLine("<View ID=`"$viewId`" Accessibility=`"Public`" Enabled=`"true`" Target=`"S2D!$classId`" TypeID=`"SC!Microsoft.SystemCenter.StateViewType`" Visible=`"true`"><Category>Operations</Category><Criteria /></View>")
        [void]$folderItems.AppendLine("<FolderItem ElementID=`"$viewId`" ID=`"$viewId.FolderItem`" Folder=`"HCSV2Presentation!HybridSolutionsCloud.HyperVPrivateCloud.Storage.Folder`" />")
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
        $id = "HybridSolutionsCloud.HyperVPrivateCloud.Capability.S2D.$($view[0]).View"
        $criteria = if ($view[2] -like '*AlertViewType') { '<Criteria><ResolutionState><StateRange Operator="NotEquals">255</StateRange></ResolutionState></Criteria>' } else { '<Criteria />' }
        [void]$views.AppendLine("<View ID=`"$id`" Accessibility=`"Public`" Enabled=`"true`" Target=`"$($view[1])`" TypeID=`"$($view[2])`" Visible=`"true`"><Category>Operations</Category>$criteria</View>")
        [void]$folderItems.AppendLine("<FolderItem ElementID=`"$id`" ID=`"$id.FolderItem`" Folder=`"HCSV2Presentation!HybridSolutionsCloud.HyperVPrivateCloud.Storage.Folder`" />")
        [void]$displays.AppendLine("<DisplayString ElementID=`"$id`"><Name>$($view[3])</Name></DisplayString>")
    }
    [void]$displays.AppendLine('<DisplayString ElementID="HybridSolutionsCloud.HyperVPrivateCloud.Capability.S2D.IntegrationHealth.Monitor"><Name>S2D integration pipeline health</Name><Description>Verifies the HCS query path without duplicating Microsoft S2D leaf monitoring.</Description></DisplayString>')
    foreach ($state in @('Good', 'Warning', 'Critical')) { [void]$displays.AppendLine("<DisplayString ElementID=`"HybridSolutionsCloud.HyperVPrivateCloud.Capability.S2D.IntegrationHealth.Monitor`" SubElementID=`"$state`"><Name>$state</Name></DisplayString>") }
    [void]$displays.AppendLine('<DisplayString ElementID="HybridSolutionsCloud.HyperVPrivateCloud.Capability.S2D.IntegrationHealth.Monitor.Message"><Name>S2D integration pipeline health</Name><Description>{0}</Description></DisplayString>')

    return [pscustomobject]@{ Discoveries = $discoveries.ToString(); Rollups = $rollups.ToString(); Views = $views.ToString(); FolderItems = $folderItems.ToString(); DisplayStrings = $displays.ToString() }
}

function Get-HcsPureStorageCapabilityContent {
    [CmdletBinding()]
    param()

    $rollupDefinitions = @(
        @('Array', 'HCSV2Library!HybridSolutionsCloud.HyperVPrivateCloud.StorageComponent', 'HybridSolutionsCloud.HyperVPrivateCloud.Capability.PureStorage.StorageContainsPureArray', 'Pure array health'),
        @('Port', 'HCSV2Library!HybridSolutionsCloud.HyperVPrivateCloud.StorageComponent', 'HybridSolutionsCloud.HyperVPrivateCloud.Capability.PureStorage.StorageContainsPurePort', 'Pure port health'),
        @('Host', 'HCSV2Library!HybridSolutionsCloud.HyperVPrivateCloud.HostRole', 'HybridSolutionsCloud.HyperVPrivateCloud.Capability.PureStorage.HostRoleReferencesPureHost', 'Pure host health'),
        @('Volume', 'HCSV2Storage!HybridSolutionsCloud.HyperVPrivateCloud.Capability.Storage.LogicalUnit', 'HybridSolutionsCloud.HyperVPrivateCloud.Capability.PureStorage.LogicalUnitReferencesPureVolume', 'Pure volume health')
    )
    $rollups = [System.Text.StringBuilder]::new()
    $views = [System.Text.StringBuilder]::new()
    $folderItems = [System.Text.StringBuilder]::new()
    $displays = [System.Text.StringBuilder]::new()
    foreach ($definition in $rollupDefinitions) {
        $id = "HybridSolutionsCloud.HyperVPrivateCloud.Capability.PureStorage.$($definition[0]).Dependency.Monitor"
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
        $id = "HybridSolutionsCloud.HyperVPrivateCloud.Capability.PureStorage.$($view[0]).View"
        $criteria = if ($view[2] -like '*AlertViewType') { '<Criteria><ResolutionState><StateRange Operator="NotEquals">255</StateRange></ResolutionState></Criteria>' } else { '<Criteria />' }
        [void]$views.AppendLine("<View ID=`"$id`" Accessibility=`"Public`" Enabled=`"true`" Target=`"Pure!$($view[1])`" TypeID=`"$($view[2])`" Visible=`"true`"><Category>Operations</Category>$criteria</View>")
        [void]$folderItems.AppendLine("<FolderItem ElementID=`"$id`" ID=`"$id.FolderItem`" Folder=`"HCSV2Presentation!HybridSolutionsCloud.HyperVPrivateCloud.Storage.Folder`" />")
        [void]$displays.AppendLine("<DisplayString ElementID=`"$id`"><Name>$($view[3])</Name></DisplayString>")
    }
    [void]$displays.AppendLine('<DisplayString ElementID="HybridSolutionsCloud.HyperVPrivateCloud.Capability.PureStorage.IntegrationHealth.Monitor"><Name>Pure Storage correlation health</Name><Description>Verifies exact IQN, WWPN, and serial correlations without duplicating array monitoring.</Description></DisplayString>')
    foreach ($state in @('Good', 'Warning', 'Critical')) { [void]$displays.AppendLine("<DisplayString ElementID=`"HybridSolutionsCloud.HyperVPrivateCloud.Capability.PureStorage.IntegrationHealth.Monitor`" SubElementID=`"$state`"><Name>$state</Name></DisplayString>") }
    [void]$displays.AppendLine('<DisplayString ElementID="HybridSolutionsCloud.HyperVPrivateCloud.Capability.PureStorage.IntegrationHealth.Monitor.Message"><Name>Pure Storage correlation health</Name><Description>{0}</Description></DisplayString>')
    return [pscustomobject]@{ Rollups = $rollups.ToString(); Views = $views.ToString(); FolderItems = $folderItems.ToString(); DisplayStrings = $displays.ToString() }
}

function Get-HcsFileServicesCapabilityContent {
    [CmdletBinding()]
    param()

    $rollupDefinitions = @(
        @('StorageShare', 'HCSV2Library!HybridSolutionsCloud.HyperVPrivateCloud.StorageComponent', 'HybridSolutionsCloud.HyperVPrivateCloud.Capability.FileServices.StorageContainsSmbShare', 'SMB share health into Storage'),
        @('HostShare', 'HCSV2Library!HybridSolutionsCloud.HyperVPrivateCloud.HostRole', 'HybridSolutionsCloud.HyperVPrivateCloud.Capability.FileServices.HostRoleUsesSmbShare', 'SMB share health into Hyper-V hosts'),
        @('MicrosoftSmb', 'HybridSolutionsCloud.HyperVPrivateCloud.Capability.FileServices.SmbShare', 'HybridSolutionsCloud.HyperVPrivateCloud.Capability.FileServices.SmbShareReferencesMicrosoftSmbService', 'Microsoft SMB service health into shares')
    )
    $rollups = [System.Text.StringBuilder]::new()
    $views = [System.Text.StringBuilder]::new()
    $folderItems = [System.Text.StringBuilder]::new()
    $displays = [System.Text.StringBuilder]::new()
    foreach ($definition in $rollupDefinitions) {
        $id = "HybridSolutionsCloud.HyperVPrivateCloud.Capability.FileServices.$($definition[0]).Dependency.Monitor"
        [void]$rollups.AppendLine("<DependencyMonitor ID=`"$id`" Accessibility=`"Public`" Enabled=`"true`" Target=`"$($definition[1])`" ParentMonitorID=`"Health!System.Health.AvailabilityState`" Remotable=`"true`" Priority=`"Normal`" RelationshipType=`"$($definition[2])`" MemberMonitor=`"Health!System.Health.AvailabilityState`"><Category>AvailabilityHealth</Category><Algorithm>WorstOf</Algorithm><MemberUnAvailable>Success</MemberUnAvailable></DependencyMonitor>")
        [void]$displays.AppendLine("<DisplayString ElementID=`"$id`"><Name>Roll up $($definition[3])</Name></DisplayString>")
    }
    $viewDefinitions = @(
        @('Share', 'HybridSolutionsCloud.HyperVPrivateCloud.Capability.FileServices.SmbShare', 'SC!Microsoft.SystemCenter.StateViewType', 'Hyper-V SMB shares'),
        @('ClientPath', 'HybridSolutionsCloud.HyperVPrivateCloud.Capability.FileServices.SmbClientPath', 'SC!Microsoft.SystemCenter.StateViewType', 'SMB Multichannel and RDMA paths'),
        @('VhdxMapping', 'HybridSolutionsCloud.HyperVPrivateCloud.Capability.FileServices.SmbVhdxMapping', 'SC!Microsoft.SystemCenter.StateViewType', 'SMB VHDX mappings'),
        @('FileServer', 'FileServices!Microsoft.Windows.FileServer', 'SC!Microsoft.SystemCenter.StateViewType', 'Microsoft file servers'),
        @('SmbService', 'FileSMB!Microsoft.Windows.FileServices.Service.SMB.10.0', 'SC!Microsoft.SystemCenter.StateViewType', 'Microsoft SMB services'),
        @('ActiveAlerts', 'HybridSolutionsCloud.HyperVPrivateCloud.Capability.FileServices.SmbShare', 'SC!Microsoft.SystemCenter.AlertViewType', 'SMB and SOFS active alerts'),
        @('Performance', 'FileSMB!Microsoft.Windows.FileServices.Service.SMB.10.0', 'SC!Microsoft.SystemCenter.PerformanceViewType', 'SMB service performance')
    )
    foreach ($view in $viewDefinitions) {
        $id = "HybridSolutionsCloud.HyperVPrivateCloud.Capability.FileServices.$($view[0]).View"
        $criteria = if ($view[2] -like '*AlertViewType') { '<Criteria><ResolutionState><StateRange Operator="NotEquals">255</StateRange></ResolutionState></Criteria>' } else { '<Criteria />' }
        $target = if ($view[1] -like '*!*') { $view[1] } elseif ($view[1] -like 'Microsoft.*') { "FileServices!$($view[1])" } else { $view[1] }
        [void]$views.AppendLine("<View ID=`"$id`" Accessibility=`"Public`" Enabled=`"true`" Target=`"$target`" TypeID=`"$($view[2])`" Visible=`"true`"><Category>Operations</Category>$criteria</View>")
        [void]$folderItems.AppendLine("<FolderItem ElementID=`"$id`" ID=`"$id.FolderItem`" Folder=`"HCSV2Presentation!HybridSolutionsCloud.HyperVPrivateCloud.Storage.Folder`" />")
        [void]$displays.AppendLine("<DisplayString ElementID=`"$id`"><Name>$($view[3])</Name></DisplayString>")
    }
    [void]$displays.AppendLine('<DisplayString ElementID="HybridSolutionsCloud.HyperVPrivateCloud.Capability.FileServices.Health.Monitor"><Name>Hyper-V over SMB health</Name><Description>Validates required SMB connections, continuous availability, and optional RDMA paths.</Description></DisplayString>')
    foreach ($state in @('Good', 'Warning', 'Critical')) { [void]$displays.AppendLine("<DisplayString ElementID=`"HybridSolutionsCloud.HyperVPrivateCloud.Capability.FileServices.Health.Monitor`" SubElementID=`"$state`"><Name>$state</Name></DisplayString>") }
    [void]$displays.AppendLine('<DisplayString ElementID="HybridSolutionsCloud.HyperVPrivateCloud.Capability.FileServices.Health.Monitor.Message"><Name>Hyper-V over SMB health</Name><Description>{0}</Description></DisplayString>')
    return [pscustomobject]@{ Rollups = $rollups.ToString(); Views = $views.ToString(); FolderItems = $folderItems.ToString(); DisplayStrings = $displays.ToString() }
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
    if ($artifact.id -eq 'HybridSolutionsCloud.HyperVPrivateCloud.Capability.Cluster') {
        $capabilityDirectory = Split-Path -Parent $sourcePath
        $scriptTokens = [ordered]@{
            CLUSTER_RELATIONSHIP_DISCOVERY_SCRIPT = 'Discover-HyperVPrivateCloudClusterRelationships.ps1.template'
            CLUSTER_HEALTH_SCRIPT = 'Get-HyperVPrivateCloudClusterIntegrationHealth.ps1.template'
        }
        foreach ($entry in $scriptTokens.GetEnumerator()) {
            $capabilityScriptPath = Join-Path $capabilityDirectory $entry.Value
            if (-not (Test-Path -LiteralPath $capabilityScriptPath -PathType Leaf)) { throw "Cluster capability script source does not exist: $capabilityScriptPath" }
            $capabilityScript = Get-Content -LiteralPath $capabilityScriptPath -Raw
            if ($capabilityScript.Contains(']]>')) { throw "Cluster capability script contains the CDATA terminator: $capabilityScriptPath" }
            $content = $content.Replace("{{$($entry.Key)}}", $capabilityScript.TrimEnd())
        }
    }
    if ($artifact.id -eq 'HybridSolutionsCloud.HyperVPrivateCloud.Capability.Storage') {
        $capabilityDirectory = Split-Path -Parent $sourcePath
        $scriptTokens = [ordered]@{
            STORAGE_TOPOLOGY_DISCOVERY_SCRIPT = 'Discover-HyperVPrivateCloudStorageTopology.ps1.template'
            STORAGE_INTEGRATION_HEALTH_SCRIPT = 'Get-HyperVPrivateCloudStorageIntegrationHealth.ps1.template'
            STORAGE_OBJECT_HEALTH_SCRIPT = 'Get-HyperVPrivateCloudStorageObjectHealth.ps1.template'
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
    if ($artifact.id -eq 'HybridSolutionsCloud.HyperVPrivateCloud.Capability.S2D') {
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
        }
        foreach ($entry in $scriptTokens.GetEnumerator()) {
            $capabilityScriptPath = Join-Path $capabilityDirectory $entry.Value
            if (-not (Test-Path -LiteralPath $capabilityScriptPath -PathType Leaf)) { throw "S2D capability script source does not exist: $capabilityScriptPath" }
            $capabilityScript = Get-Content -LiteralPath $capabilityScriptPath -Raw
            if ($capabilityScript.Contains(']]>')) { throw "S2D capability script contains the CDATA terminator: $capabilityScriptPath" }
            $content = $content.Replace("{{$($entry.Key)}}", $capabilityScript.TrimEnd())
        }
    }
    if ($artifact.id -eq 'HybridSolutionsCloud.HyperVPrivateCloud.Capability.PureStorage') {
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
    if ($artifact.id -eq 'HybridSolutionsCloud.HyperVPrivateCloud.Capability.FileServices') {
        $capabilityDirectory = Split-Path -Parent $sourcePath
        $scriptTokens = [ordered]@{
            FILE_SERVICES_DISCOVERY_SCRIPT = 'Discover-HyperVPrivateCloudFileServices.ps1.template'
            FILE_SERVICES_HEALTH_SCRIPT = 'Get-HyperVPrivateCloudFileServicesHealth.ps1.template'
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
