# Hyper-V Private Cloud Monitoring - Network ATC

Generated support reference. [All capabilities](catalog.md) · [Day-2 triage](index.md).

Default conditions below come from the compiled candidate source, not the effective overrides in your management group. Read the monitor-specific knowledge together with the common safety and verification guidance. Microsoft links explain the underlying technology; product thresholds are not Microsoft recommendations.

## Network ATC Intent {#hypervprivatecloud.capability.networkatc.networkintent}

`HyperVPrivateCloud.Capability.NetworkATC.NetworkIntent`

Network ATC intent defining the approved role and adapter configuration. Read desired settings and per-node convergence together; intention alone is not proof of applied state.

### Support scope

Network ATC intent and per-node convergence/configuration evidence. This capability is applicable only where Network ATC owns the host network configuration.

Element: HyperVPrivateCloud.Capability.NetworkATC.NetworkIntent. Kind: ClassType.

### Identity and monitoring ownership

Base class=System!System.LogicalEntity; hosted=false; singleton=false; declared properties=BoundaryId, IntentName, Scope, IntentType, AdapterNames, IsCompute, IsManagement, IsStorage, IsStretch, IsSwitchless, OverrideKinds. Inherited properties also apply. Inspect the exact instance and its monitoring path; inventory-only classes do not acquire health merely by appearing in a diagram.

### Read-only investigation

Inspect Get-NetIntent and Get-NetIntentStatus on eligible nodes. Compare intent adapter membership, provisioning errors, node status and approved global overrides. Check adapter symmetry, link/RDMA readiness and switch DCB/PFC settings against the intent. Missing ATC on a manual or VMM-managed network is not itself an outage.

### Corrective action and escalation

Resolve the precise convergence error through the selected network authority. Plan changes to intents and switch configuration together. Do not manually overwrite ATC-managed settings or enable ATC alongside a conflicting VMM/SDN authority merely to satisfy monitoring.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Verify intended nodes converge, effective configuration matches approved policy and no new apply failures occur after the normal convergence interval.

### What this object represents

Network ATC intent defining the approved role and adapter configuration. Read desired settings and per-node convergence together; intention alone is not proof of applied state.

### Microsoft references

[Microsoft Learn: manage network atc](https://learn.microsoft.com/en-us/windows-server/networking/network-atc/manage-network-atc)

[Microsoft Learn: get netintentstatus](https://learn.microsoft.com/en-us/powershell/module/networkatc/get-netintentstatus?view=windowsserver2025-ps)


## Network ATC Intent Node Status {#hypervprivatecloud.capability.networkatc.networkintentnodestatus}

`HyperVPrivateCloud.Capability.NetworkATC.NetworkIntentNodeStatus`

Node-specific realization of an ATC intent. This identifies which host has provisioning, compliance or adapter readiness trouble when the same intent spans several nodes.

### Support scope

Network ATC intent and per-node convergence/configuration evidence. This capability is applicable only where Network ATC owns the host network configuration.

Element: HyperVPrivateCloud.Capability.NetworkATC.NetworkIntentNodeStatus. Kind: ClassType.

### Identity and monitoring ownership

Base class=Windows!Microsoft.Windows.LocalApplication; hosted=true; singleton=false; declared properties=IntentName, BoundaryId, HostName, AdapterNames, IsStorage, ProvisioningStatus, ConfigurationStatus, ErrorCode, RetryCount, Progress, LastSuccess, LastUpdated, LastConfigApplied. Inherited properties also apply. Inspect the exact instance and its monitoring path; inventory-only classes do not acquire health merely by appearing in a diagram.

### Read-only investigation

Inspect Get-NetIntent and Get-NetIntentStatus on eligible nodes. Compare intent adapter membership, provisioning errors, node status and approved global overrides. Check adapter symmetry, link/RDMA readiness and switch DCB/PFC settings against the intent. Missing ATC on a manual or VMM-managed network is not itself an outage.

### Corrective action and escalation

Resolve the precise convergence error through the selected network authority. Plan changes to intents and switch configuration together. Do not manually overwrite ATC-managed settings or enable ATC alongside a conflicting VMM/SDN authority merely to satisfy monitoring.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Verify intended nodes converge, effective configuration matches approved policy and no new apply failures occur after the normal convergence interval.

### What this object represents

Node-specific realization of an ATC intent. This identifies which host has provisioning, compliance or adapter readiness trouble when the same intent spans several nodes.

### Microsoft references

[Microsoft Learn: manage network atc](https://learn.microsoft.com/en-us/windows-server/networking/network-atc/manage-network-atc)

[Microsoft Learn: get netintentstatus](https://learn.microsoft.com/en-us/powershell/module/networkatc/get-netintentstatus?view=windowsserver2025-ps)


## Network ATC Global Configuration Status {#hypervprivatecloud.capability.networkatc.globalconfigurationstatus}

`HyperVPrivateCloud.Capability.NetworkATC.GlobalConfigurationStatus`

ATC global configuration/override observation. Compare the effective cluster-wide policy with the approved baseline before changing individual adapters.

### Support scope

Network ATC intent and per-node convergence/configuration evidence. This capability is applicable only where Network ATC owns the host network configuration.

Element: HyperVPrivateCloud.Capability.NetworkATC.GlobalConfigurationStatus. Kind: ClassType.

### Identity and monitoring ownership

Base class=Windows!Microsoft.Windows.LocalApplication; hosted=true; singleton=false; declared properties=BoundaryId, HostName, OverrideKinds, ProvisioningStatus, ConfigurationStatus, ErrorCode, LastUpdated. Inherited properties also apply. Inspect the exact instance and its monitoring path; inventory-only classes do not acquire health merely by appearing in a diagram.

### Read-only investigation

Inspect Get-NetIntent and Get-NetIntentStatus on eligible nodes. Compare intent adapter membership, provisioning errors, node status and approved global overrides. Check adapter symmetry, link/RDMA readiness and switch DCB/PFC settings against the intent. Missing ATC on a manual or VMM-managed network is not itself an outage.

### Corrective action and escalation

Resolve the precise convergence error through the selected network authority. Plan changes to intents and switch configuration together. Do not manually overwrite ATC-managed settings or enable ATC alongside a conflicting VMM/SDN authority merely to satisfy monitoring.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Verify intended nodes converge, effective configuration matches approved policy and no new apply failures occur after the normal convergence interval.

### What this object represents

ATC global configuration/override observation. Compare the effective cluster-wide policy with the approved baseline before changing individual adapters.

### Microsoft references

[Microsoft Learn: manage network atc](https://learn.microsoft.com/en-us/windows-server/networking/network-atc/manage-network-atc)

[Microsoft Learn: get netintentstatus](https://learn.microsoft.com/en-us/powershell/module/networkatc/get-netintentstatus?view=windowsserver2025-ps)


## Show Network ATC intent status {#hypervprivatecloud.capability.networkatc.intentstatus.task}

`HyperVPrivateCloud.Capability.NetworkATC.IntentStatus.Task`

Get-NetIntent, Get-NetIntentStatus for every intent and node, global overrides, the NetworkATC service and its latest operational events.

### Summary

Show Network ATC intent status

### What it runs

Get-NetIntent, Get-NetIntentStatus for every intent and node, global overrides, the NetworkATC service and its latest operational events.

### Impact

Read-only. The task runs the query on the agent and returns text; it changes nothing.

### Support scope

Network ATC intent and per-node convergence/configuration evidence. This capability is applicable only where Network ATC owns the host network configuration.

Element: HyperVPrivateCloud.Capability.NetworkATC.IntentStatus.Task. Kind: Task.

### Execution safety

Target=HCSV2Library!HyperVPrivateCloud.HostRole; enabled=true; timeout=180. Read the task&#39;s original knowledge and parameters before execution. A Remediation task changes state and requires approval; do not execute it solely because the object is red. Even a diagnostic can generate logs or files; review its documented impact.

### Read-only investigation

Inspect Get-NetIntent and Get-NetIntentStatus on eligible nodes. Compare intent adapter membership, provisioning errors, node status and approved global overrides. Check adapter symmetry, link/RDMA readiness and switch DCB/PFC settings against the intent. Missing ATC on a manual or VMM-managed network is not itself an outage.

### Corrective action and escalation

Resolve the precise convergence error through the selected network authority. Plan changes to intents and switch configuration together. Do not manually overwrite ATC-managed settings or enable ATC alongside a conflicting VMM/SDN authority merely to satisfy monitoring.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Verify intended nodes converge, effective configuration matches approved policy and no new apply failures occur after the normal convergence interval.

### Microsoft references

[Microsoft Learn: manage network atc](https://learn.microsoft.com/en-us/windows-server/networking/network-atc/manage-network-atc)

[Microsoft Learn: get netintentstatus](https://learn.microsoft.com/en-us/powershell/module/networkatc/get-netintentstatus?view=windowsserver2025-ps)


## Show RDMA, DCB and SMB Direct health {#hypervprivatecloud.capability.networkatc.rdmaanddcbhealth.task}

`HyperVPrivateCloud.Capability.NetworkATC.RdmaAndDcbHealth.Task`

RDMA adapters, DCBX willing mode, flow control, traffic classes, QoS policies, SMB client interfaces and RDMA activity counters.

### Summary

Show RDMA, DCB and SMB Direct health

### What it runs

RDMA adapters, DCBX willing mode, flow control, traffic classes, QoS policies, SMB client interfaces and RDMA activity counters.

### Impact

Read-only. The task runs the query on the agent and returns text; it changes nothing.

### Support scope

Network ATC intent and per-node convergence/configuration evidence. This capability is applicable only where Network ATC owns the host network configuration.

Element: HyperVPrivateCloud.Capability.NetworkATC.RdmaAndDcbHealth.Task. Kind: Task.

### Execution safety

Target=HCSV2Library!HyperVPrivateCloud.HostRole; enabled=true; timeout=180. Read the task&#39;s original knowledge and parameters before execution. A Remediation task changes state and requires approval; do not execute it solely because the object is red. Even a diagnostic can generate logs or files; review its documented impact.

### Read-only investigation

Inspect Get-NetIntent and Get-NetIntentStatus on eligible nodes. Compare intent adapter membership, provisioning errors, node status and approved global overrides. Check adapter symmetry, link/RDMA readiness and switch DCB/PFC settings against the intent. Missing ATC on a manual or VMM-managed network is not itself an outage.

### Corrective action and escalation

Resolve the precise convergence error through the selected network authority. Plan changes to intents and switch configuration together. Do not manually overwrite ATC-managed settings or enable ATC alongside a conflicting VMM/SDN authority merely to satisfy monitoring.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Verify intended nodes converge, effective configuration matches approved policy and no new apply failures occur after the normal convergence interval.

### Microsoft references

[Microsoft Learn: manage network atc](https://learn.microsoft.com/en-us/windows-server/networking/network-atc/manage-network-atc)

[Microsoft Learn: get netintentstatus](https://learn.microsoft.com/en-us/powershell/module/networkatc/get-netintentstatus?view=windowsserver2025-ps)


## Remediation: Retry the intent on this node {#hypervprivatecloud.capability.networkatc.retryintent.task}

`HyperVPrivateCloud.Capability.NetworkATC.RetryIntent.Task`

Set-NetIntentRetryState after the underlying fault is fixed. Parameter = intent name.

### Summary

Retry the intent on this node

### What it runs

Set-NetIntentRetryState after the underlying fault is fixed. Parameter = intent name.

### Impact

This task changes the state of the target. The console asks for confirmation before it runs; use the read-only tasks first to confirm the diagnosis, and run it inside a change window where the environment requires one. The task output reports the resulting state.

### Support scope

Network ATC intent and per-node convergence/configuration evidence. This capability is applicable only where Network ATC owns the host network configuration.

Element: HyperVPrivateCloud.Capability.NetworkATC.RetryIntent.Task. Kind: Task.

### Execution safety

Target=HyperVPrivateCloud.Capability.NetworkATC.NetworkIntentNodeStatus; enabled=true; timeout=300. Read the task&#39;s original knowledge and parameters before execution. A Remediation task changes state and requires approval; do not execute it solely because the object is red. Even a diagnostic can generate logs or files; review its documented impact.

### Read-only investigation

Inspect Get-NetIntent and Get-NetIntentStatus on eligible nodes. Compare intent adapter membership, provisioning errors, node status and approved global overrides. Check adapter symmetry, link/RDMA readiness and switch DCB/PFC settings against the intent. Missing ATC on a manual or VMM-managed network is not itself an outage.

### Corrective action and escalation

Resolve the precise convergence error through the selected network authority. Plan changes to intents and switch configuration together. Do not manually overwrite ATC-managed settings or enable ATC alongside a conflicting VMM/SDN authority merely to satisfy monitoring.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Verify intended nodes converge, effective configuration matches approved policy and no new apply failures occur after the normal convergence interval.

### Microsoft references

[Microsoft Learn: manage network atc](https://learn.microsoft.com/en-us/windows-server/networking/network-atc/manage-network-atc)

[Microsoft Learn: get netintentstatus](https://learn.microsoft.com/en-us/powershell/module/networkatc/get-netintentstatus?view=windowsserver2025-ps)


## Network ATC capability and authority health {#hypervprivatecloud.capability.networkatc.capabilityhealth.monitor}

`HyperVPrivateCloud.Capability.NetworkATC.CapabilityHealth.Monitor`

Monitors operational health, status, and thresholds for Network ATC capability and authority health.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.Fabric.Configuration.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.Fabric.Service.Configuration.Dependency.Monitor &gt; HyperVPrivateCloud.Service.Network.Configuration.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.NetworkATC.GlobalStatus.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.NetworkATC.CapabilityHealth.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

Verifies the NetworkATC module, status cmdlet, configured-intent presence, and selected networking authority. Missing Network ATC is Not Applicable unless RequireNetworkATC is overridden to true.

### Operator response

Confirm that Network ATC is the intended authority. Install the NetworkATC feature and management tools when required; otherwise leave RequireNetworkATC false for manual, VMM, SDN, or externally managed networking.

### Support scope

Network ATC intent and per-node convergence/configuration evidence. This capability is applicable only where Network ATC owns the host network configuration.

Element: HyperVPrivateCloud.Capability.NetworkATC.CapabilityHealth.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HyperVPrivateCloud.Capability.NetworkATC.GlobalConfigurationStatus. Parent health aspect: Health!System.Health.ConfigurationState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: (Property[@Name=&#39;CapabilityState&#39;] = Good OR Property[@Name=&#39;CapabilityState&#39;] = NotApplicable)

Warning [Warning]: Property[@Name=&#39;CapabilityState&#39;] = Warning

Error [Critical]: Property[@Name=&#39;CapabilityState&#39;] = Critical

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: AdapterNames=; ComputerName=$Target/Host/Property[Type=&quot;Windows!Microsoft.Windows.Computer&quot;]/PrincipalName$; IntentName=; IntervalSeconds=300; IsStorageIntent=false; MaxTransitionalMinutes=30; Mode=All; PropertyName=CapabilityState; RequireNetworkATC=false; RequireRdmaForStorage=true; SyncTime=; TimeoutSeconds=180 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Error; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Inspect Get-NetIntent and Get-NetIntentStatus on eligible nodes. Compare intent adapter membership, provisioning errors, node status and approved global overrides. Check adapter symmetry, link/RDMA readiness and switch DCB/PFC settings against the intent. Missing ATC on a manual or VMM-managed network is not itself an outage.

### Corrective action and escalation

Resolve the precise convergence error through the selected network authority. Plan changes to intents and switch configuration together. Do not manually overwrite ATC-managed settings or enable ATC alongside a conflicting VMM/SDN authority merely to satisfy monitoring.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Verify intended nodes converge, effective configuration matches approved policy and no new apply failures occur after the normal convergence interval.

### Microsoft references

[Microsoft Learn: manage network atc](https://learn.microsoft.com/en-us/windows-server/networking/network-atc/manage-network-atc)

[Microsoft Learn: get netintentstatus](https://learn.microsoft.com/en-us/powershell/module/networkatc/get-netintentstatus?view=windowsserver2025-ps)


## Network ATC intent convergence health {#hypervprivatecloud.capability.networkatc.intenthealth.monitor}

`HyperVPrivateCloud.Capability.NetworkATC.IntentHealth.Monitor`

Monitors operational health, status, and thresholds for Network ATC intent convergence health.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.Fabric.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.Fabric.Service.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Service.Network.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.NetworkATC.NetworkIntent.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.NetworkATC.IntentNode.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.NetworkATC.IntentHealth.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

Evaluates Get-NetIntentStatus. Success requires ConfigurationStatus Success, ProvisioningStatus Completed, and no error. Failed states and prolonged convergence are Critical.

### Operator response

Review the intent error, progress, retry count, recent Network ATC events, adapter symmetry, required features, and cluster consistency. This Management Pack never retries or changes an intent.

### Support scope

Network ATC intent and per-node convergence/configuration evidence. This capability is applicable only where Network ATC owns the host network configuration.

Element: HyperVPrivateCloud.Capability.NetworkATC.IntentHealth.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HyperVPrivateCloud.Capability.NetworkATC.NetworkIntentNodeStatus. Parent health aspect: Health!System.Health.AvailabilityState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: (Property[@Name=&#39;InstanceKey&#39;] = $Target/Property[Type=&quot;HyperVPrivateCloud.Capability.NetworkATC.NetworkIntentNodeStatus&quot;]/IntentName$ AND (Property[@Name=&#39;IntentState&#39;] = Good OR Property[@Name=&#39;IntentState&#39;] = NotApplicable))

Warning [Warning]: (Property[@Name=&#39;InstanceKey&#39;] = $Target/Property[Type=&quot;HyperVPrivateCloud.Capability.NetworkATC.NetworkIntentNodeStatus&quot;]/IntentName$ AND Property[@Name=&#39;IntentState&#39;] = Warning)

Error [Critical]: (Property[@Name=&#39;InstanceKey&#39;] = $Target/Property[Type=&quot;HyperVPrivateCloud.Capability.NetworkATC.NetworkIntentNodeStatus&quot;]/IntentName$ AND Property[@Name=&#39;IntentState&#39;] = Critical)

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: ComplianceToleranceMinutes=60; ComputerName=$Target/Host/Property[Type=&quot;Windows!Microsoft.Windows.Computer&quot;]/PrincipalName$; ExpectedClusterPriority=7; ExpectedPfcPriority=3; ExpectedTrafficClassCount=2; InstanceKey=$Target/Property[Type=&quot;HyperVPrivateCloud.Capability.NetworkATC.NetworkIntentNodeStatus&quot;]/IntentName$; IntervalSeconds=300; MaxAdapterSpeedVariancePercent=0; MaxNodesOutOfCompliance=0; MaxRetryCount=3; MaxTransitionalMinutes=30; MinimumAdapterSpeedGbps=10; MinimumEtsBandwidthPercent=50; PropertyName=IntentState; RequireDcb=true; RequireNetworkATC=false; RequireRdma=true; RequireRdmaForStorage=true; RequireVmSwitchForComputeIntent=true; SyncTime=; TimeoutSeconds=180 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Error; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Inspect Get-NetIntent and Get-NetIntentStatus on eligible nodes. Compare intent adapter membership, provisioning errors, node status and approved global overrides. Check adapter symmetry, link/RDMA readiness and switch DCB/PFC settings against the intent. Missing ATC on a manual or VMM-managed network is not itself an outage.

### Corrective action and escalation

Resolve the precise convergence error through the selected network authority. Plan changes to intents and switch configuration together. Do not manually overwrite ATC-managed settings or enable ATC alongside a conflicting VMM/SDN authority merely to satisfy monitoring.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Verify intended nodes converge, effective configuration matches approved policy and no new apply failures occur after the normal convergence interval.

### Microsoft references

[Microsoft Learn: manage network atc](https://learn.microsoft.com/en-us/windows-server/networking/network-atc/manage-network-atc)

[Microsoft Learn: get netintentstatus](https://learn.microsoft.com/en-us/powershell/module/networkatc/get-netintentstatus?view=windowsserver2025-ps)


## Network ATC adapter readiness {#hypervprivatecloud.capability.networkatc.adapterreadiness.monitor}

`HyperVPrivateCloud.Capability.NetworkATC.AdapterReadiness.Monitor`

Monitors operational health, status, and thresholds for Network ATC adapter readiness.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.Fabric.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.Fabric.Service.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Service.Network.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.NetworkATC.NetworkIntent.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.NetworkATC.IntentNode.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.NetworkATC.AdapterReadiness.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

Verifies that every participating adapter exists and is Up. Storage intents also require RDMA by default; nested labs can override that requirement.

### Operator response

Check adapter names, link state, make/model/speed symmetry, driver and firmware consistency, RDMA/DCB support, switch configuration, and the Network ATC error code.

### Support scope

Network ATC intent and per-node convergence/configuration evidence. This capability is applicable only where Network ATC owns the host network configuration.

Element: HyperVPrivateCloud.Capability.NetworkATC.AdapterReadiness.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HyperVPrivateCloud.Capability.NetworkATC.NetworkIntentNodeStatus. Parent health aspect: Health!System.Health.AvailabilityState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: (Property[@Name=&#39;InstanceKey&#39;] = $Target/Property[Type=&quot;HyperVPrivateCloud.Capability.NetworkATC.NetworkIntentNodeStatus&quot;]/IntentName$ AND (Property[@Name=&#39;AdapterReadinessState&#39;] = Good OR Property[@Name=&#39;AdapterReadinessState&#39;] = NotApplicable))

Warning [Warning]: (Property[@Name=&#39;InstanceKey&#39;] = $Target/Property[Type=&quot;HyperVPrivateCloud.Capability.NetworkATC.NetworkIntentNodeStatus&quot;]/IntentName$ AND Property[@Name=&#39;AdapterReadinessState&#39;] = Warning)

Error [Critical]: (Property[@Name=&#39;InstanceKey&#39;] = $Target/Property[Type=&quot;HyperVPrivateCloud.Capability.NetworkATC.NetworkIntentNodeStatus&quot;]/IntentName$ AND Property[@Name=&#39;AdapterReadinessState&#39;] = Critical)

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: ComplianceToleranceMinutes=60; ComputerName=$Target/Host/Property[Type=&quot;Windows!Microsoft.Windows.Computer&quot;]/PrincipalName$; ExpectedClusterPriority=7; ExpectedPfcPriority=3; ExpectedTrafficClassCount=2; InstanceKey=$Target/Property[Type=&quot;HyperVPrivateCloud.Capability.NetworkATC.NetworkIntentNodeStatus&quot;]/IntentName$; IntervalSeconds=300; MaxAdapterSpeedVariancePercent=0; MaxNodesOutOfCompliance=0; MaxRetryCount=3; MaxTransitionalMinutes=30; MinimumAdapterSpeedGbps=10; MinimumEtsBandwidthPercent=50; PropertyName=AdapterReadinessState; RequireDcb=true; RequireNetworkATC=false; RequireRdma=true; RequireRdmaForStorage=true; RequireVmSwitchForComputeIntent=true; SyncTime=; TimeoutSeconds=180 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Error; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Inspect Get-NetIntent and Get-NetIntentStatus on eligible nodes. Compare intent adapter membership, provisioning errors, node status and approved global overrides. Check adapter symmetry, link/RDMA readiness and switch DCB/PFC settings against the intent. Missing ATC on a manual or VMM-managed network is not itself an outage.

### Corrective action and escalation

Resolve the precise convergence error through the selected network authority. Plan changes to intents and switch configuration together. Do not manually overwrite ATC-managed settings or enable ATC alongside a conflicting VMM/SDN authority merely to satisfy monitoring.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Verify intended nodes converge, effective configuration matches approved policy and no new apply failures occur after the normal convergence interval.

### Microsoft references

[Microsoft Learn: manage network atc](https://learn.microsoft.com/en-us/windows-server/networking/network-atc/manage-network-atc)

[Microsoft Learn: get netintentstatus](https://learn.microsoft.com/en-us/powershell/module/networkatc/get-netintentstatus?view=windowsserver2025-ps)


## Network ATC global configuration health {#hypervprivatecloud.capability.networkatc.globalconfigurationhealth.monitor}

`HyperVPrivateCloud.Capability.NetworkATC.GlobalConfigurationHealth.Monitor`

Monitors operational health, status, and thresholds for Network ATC global configuration health.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.Fabric.Configuration.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.Fabric.Service.Configuration.Dependency.Monitor &gt; HyperVPrivateCloud.Service.Network.Configuration.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.NetworkATC.GlobalStatus.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.NetworkATC.GlobalConfigurationHealth.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

Tracks global Network ATC cluster/proxy override convergence when those settings are present.

### Operator response

Review Get-NetIntent and Get-NetIntentStatus with GlobalOverrides, then correct the source configuration through approved Network ATC procedures. This Management Pack is read-only.

### Support scope

Network ATC intent and per-node convergence/configuration evidence. This capability is applicable only where Network ATC owns the host network configuration.

Element: HyperVPrivateCloud.Capability.NetworkATC.GlobalConfigurationHealth.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HyperVPrivateCloud.Capability.NetworkATC.GlobalConfigurationStatus. Parent health aspect: Health!System.Health.ConfigurationState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: (Property[@Name=&#39;GlobalState&#39;] = Good OR Property[@Name=&#39;GlobalState&#39;] = NotApplicable)

Warning [Warning]: Property[@Name=&#39;GlobalState&#39;] = Warning

Error [Critical]: Property[@Name=&#39;GlobalState&#39;] = Critical

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: AdapterNames=; ComputerName=$Target/Host/Property[Type=&quot;Windows!Microsoft.Windows.Computer&quot;]/PrincipalName$; IntentName=; IntervalSeconds=300; IsStorageIntent=false; MaxTransitionalMinutes=30; Mode=All; PropertyName=GlobalState; RequireNetworkATC=false; RequireRdmaForStorage=true; SyncTime=; TimeoutSeconds=180 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Error; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Inspect Get-NetIntent and Get-NetIntentStatus on eligible nodes. Compare intent adapter membership, provisioning errors, node status and approved global overrides. Check adapter symmetry, link/RDMA readiness and switch DCB/PFC settings against the intent. Missing ATC on a manual or VMM-managed network is not itself an outage.

### Corrective action and escalation

Resolve the precise convergence error through the selected network authority. Plan changes to intents and switch configuration together. Do not manually overwrite ATC-managed settings or enable ATC alongside a conflicting VMM/SDN authority merely to satisfy monitoring.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Verify intended nodes converge, effective configuration matches approved policy and no new apply failures occur after the normal convergence interval.

### Microsoft references

[Microsoft Learn: manage network atc](https://learn.microsoft.com/en-us/windows-server/networking/network-atc/manage-network-atc)

[Microsoft Learn: get netintentstatus](https://learn.microsoft.com/en-us/powershell/module/networkatc/get-netintentstatus?view=windowsserver2025-ps)


## Network ATC intent provisioning drift {#hypervprivatecloud.capability.networkatc.intentprovisioningdrift.monitor}

`HyperVPrivateCloud.Capability.NetworkATC.IntentProvisioningDrift.Monitor`

Monitors operational health, status, and thresholds for Network ATC intent provisioning drift.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.Fabric.Configuration.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.Fabric.Service.Configuration.Dependency.Monitor &gt; HyperVPrivateCloud.Service.Network.Configuration.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.NetworkATC.NetworkIntent.Configuration.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.NetworkATC.IntentNode.Configuration.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.NetworkATC.IntentProvisioningDrift.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

Compares the provisioning status returned by Get-NetIntentStatus with the ComplianceToleranceMinutes tolerance window. Provisioning that is still in flight inside the window is Warning; provisioning that stays incomplete beyond the window is Critical.

### Operator response

Review the intent progress, retry count, participating adapter state, and recent Network ATC events. Increase ComplianceToleranceMinutes for sites with deliberately long change windows. This Management Pack never retries or changes an intent.

### Support scope

Network ATC intent and per-node convergence/configuration evidence. This capability is applicable only where Network ATC owns the host network configuration.

Element: HyperVPrivateCloud.Capability.NetworkATC.IntentProvisioningDrift.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HyperVPrivateCloud.Capability.NetworkATC.NetworkIntentNodeStatus. Parent health aspect: Health!System.Health.ConfigurationState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: (Property[@Name=&#39;InstanceKey&#39;] = $Target/Property[Type=&quot;HyperVPrivateCloud.Capability.NetworkATC.NetworkIntentNodeStatus&quot;]/IntentName$ AND (Property[@Name=&#39;ProvisioningDriftState&#39;] = Good OR Property[@Name=&#39;ProvisioningDriftState&#39;] = NotApplicable))

Warning [Warning]: (Property[@Name=&#39;InstanceKey&#39;] = $Target/Property[Type=&quot;HyperVPrivateCloud.Capability.NetworkATC.NetworkIntentNodeStatus&quot;]/IntentName$ AND Property[@Name=&#39;ProvisioningDriftState&#39;] = Warning)

Error [Critical]: (Property[@Name=&#39;InstanceKey&#39;] = $Target/Property[Type=&quot;HyperVPrivateCloud.Capability.NetworkATC.NetworkIntentNodeStatus&quot;]/IntentName$ AND Property[@Name=&#39;ProvisioningDriftState&#39;] = Critical)

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: ComplianceToleranceMinutes=60; ComputerName=$Target/Host/Property[Type=&quot;Windows!Microsoft.Windows.Computer&quot;]/PrincipalName$; ExpectedClusterPriority=7; ExpectedPfcPriority=3; ExpectedTrafficClassCount=2; InstanceKey=$Target/Property[Type=&quot;HyperVPrivateCloud.Capability.NetworkATC.NetworkIntentNodeStatus&quot;]/IntentName$; IntervalSeconds=300; MaxAdapterSpeedVariancePercent=0; MaxNodesOutOfCompliance=0; MaxRetryCount=3; MaxTransitionalMinutes=30; MinimumAdapterSpeedGbps=10; MinimumEtsBandwidthPercent=50; PropertyName=ProvisioningDriftState; RequireDcb=true; RequireNetworkATC=false; RequireRdma=true; RequireRdmaForStorage=true; RequireVmSwitchForComputeIntent=true; SyncTime=; TimeoutSeconds=180 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Error; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Inspect Get-NetIntent and Get-NetIntentStatus on eligible nodes. Compare intent adapter membership, provisioning errors, node status and approved global overrides. Check adapter symmetry, link/RDMA readiness and switch DCB/PFC settings against the intent. Missing ATC on a manual or VMM-managed network is not itself an outage.

### Corrective action and escalation

Resolve the precise convergence error through the selected network authority. Plan changes to intents and switch configuration together. Do not manually overwrite ATC-managed settings or enable ATC alongside a conflicting VMM/SDN authority merely to satisfy monitoring.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Verify intended nodes converge, effective configuration matches approved policy and no new apply failures occur after the normal convergence interval.

### Microsoft references

[Microsoft Learn: manage network atc](https://learn.microsoft.com/en-us/windows-server/networking/network-atc/manage-network-atc)

[Microsoft Learn: get netintentstatus](https://learn.microsoft.com/en-us/powershell/module/networkatc/get-netintentstatus?view=windowsserver2025-ps)


## Network ATC intent compliance drift {#hypervprivatecloud.capability.networkatc.intentcompliancedrift.monitor}

`HyperVPrivateCloud.Capability.NetworkATC.IntentComplianceDrift.Monitor`

Monitors operational health, status, and thresholds for Network ATC intent compliance drift.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.Fabric.Configuration.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.Fabric.Service.Configuration.Dependency.Monitor &gt; HyperVPrivateCloud.Service.Network.Configuration.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.NetworkATC.NetworkIntent.Configuration.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.NetworkATC.IntentNode.Configuration.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.NetworkATC.IntentComplianceDrift.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

Compares the requested intent with the applied configuration status. Drift inside ComplianceToleranceMinutes is Warning; drift that persists beyond the window, or a host that never reported a successful apply, is Critical.

### Operator response

Compare Get-NetIntent with Get-NetIntentStatus, look for out-of-band host networking changes, and re-apply the intent through approved Network ATC procedures.

### Support scope

Network ATC intent and per-node convergence/configuration evidence. This capability is applicable only where Network ATC owns the host network configuration.

Element: HyperVPrivateCloud.Capability.NetworkATC.IntentComplianceDrift.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HyperVPrivateCloud.Capability.NetworkATC.NetworkIntentNodeStatus. Parent health aspect: Health!System.Health.ConfigurationState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: (Property[@Name=&#39;InstanceKey&#39;] = $Target/Property[Type=&quot;HyperVPrivateCloud.Capability.NetworkATC.NetworkIntentNodeStatus&quot;]/IntentName$ AND (Property[@Name=&#39;ComplianceDriftState&#39;] = Good OR Property[@Name=&#39;ComplianceDriftState&#39;] = NotApplicable))

Warning [Warning]: (Property[@Name=&#39;InstanceKey&#39;] = $Target/Property[Type=&quot;HyperVPrivateCloud.Capability.NetworkATC.NetworkIntentNodeStatus&quot;]/IntentName$ AND Property[@Name=&#39;ComplianceDriftState&#39;] = Warning)

Error [Critical]: (Property[@Name=&#39;InstanceKey&#39;] = $Target/Property[Type=&quot;HyperVPrivateCloud.Capability.NetworkATC.NetworkIntentNodeStatus&quot;]/IntentName$ AND Property[@Name=&#39;ComplianceDriftState&#39;] = Critical)

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: ComplianceToleranceMinutes=60; ComputerName=$Target/Host/Property[Type=&quot;Windows!Microsoft.Windows.Computer&quot;]/PrincipalName$; ExpectedClusterPriority=7; ExpectedPfcPriority=3; ExpectedTrafficClassCount=2; InstanceKey=$Target/Property[Type=&quot;HyperVPrivateCloud.Capability.NetworkATC.NetworkIntentNodeStatus&quot;]/IntentName$; IntervalSeconds=300; MaxAdapterSpeedVariancePercent=0; MaxNodesOutOfCompliance=0; MaxRetryCount=3; MaxTransitionalMinutes=30; MinimumAdapterSpeedGbps=10; MinimumEtsBandwidthPercent=50; PropertyName=ComplianceDriftState; RequireDcb=true; RequireNetworkATC=false; RequireRdma=true; RequireRdmaForStorage=true; RequireVmSwitchForComputeIntent=true; SyncTime=; TimeoutSeconds=180 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Error; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Inspect Get-NetIntent and Get-NetIntentStatus on eligible nodes. Compare intent adapter membership, provisioning errors, node status and approved global overrides. Check adapter symmetry, link/RDMA readiness and switch DCB/PFC settings against the intent. Missing ATC on a manual or VMM-managed network is not itself an outage.

### Corrective action and escalation

Resolve the precise convergence error through the selected network authority. Plan changes to intents and switch configuration together. Do not manually overwrite ATC-managed settings or enable ATC alongside a conflicting VMM/SDN authority merely to satisfy monitoring.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Verify intended nodes converge, effective configuration matches approved policy and no new apply failures occur after the normal convergence interval.

### Microsoft references

[Microsoft Learn: manage network atc](https://learn.microsoft.com/en-us/windows-server/networking/network-atc/manage-network-atc)

[Microsoft Learn: get netintentstatus](https://learn.microsoft.com/en-us/powershell/module/networkatc/get-netintentstatus?view=windowsserver2025-ps)


## Network ATC intent apply failure and retry count {#hypervprivatecloud.capability.networkatc.intentapplyfailure.monitor}

`HyperVPrivateCloud.Capability.NetworkATC.IntentApplyFailure.Monitor`

Monitors operational health, status, and thresholds for Network ATC intent apply failure and retry count.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.Fabric.Configuration.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.Fabric.Service.Configuration.Dependency.Monitor &gt; HyperVPrivateCloud.Service.Network.Configuration.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.NetworkATC.NetworkIntent.Configuration.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.NetworkATC.IntentNode.Configuration.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.NetworkATC.IntentApplyFailure.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

Raises Critical when the intent status carries an error code, or when the reported retry count reaches MaxRetryCount. A non-zero retry count below the limit is Warning.

### Operator response

Resolve the reported error code, confirm adapter and feature prerequisites, then allow Network ATC to converge. Raise MaxRetryCount only where transient retries are expected and understood.

### Support scope

Network ATC intent and per-node convergence/configuration evidence. This capability is applicable only where Network ATC owns the host network configuration.

Element: HyperVPrivateCloud.Capability.NetworkATC.IntentApplyFailure.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HyperVPrivateCloud.Capability.NetworkATC.NetworkIntentNodeStatus. Parent health aspect: Health!System.Health.ConfigurationState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: (Property[@Name=&#39;InstanceKey&#39;] = $Target/Property[Type=&quot;HyperVPrivateCloud.Capability.NetworkATC.NetworkIntentNodeStatus&quot;]/IntentName$ AND (Property[@Name=&#39;ApplyFailureState&#39;] = Good OR Property[@Name=&#39;ApplyFailureState&#39;] = NotApplicable))

Warning [Warning]: (Property[@Name=&#39;InstanceKey&#39;] = $Target/Property[Type=&quot;HyperVPrivateCloud.Capability.NetworkATC.NetworkIntentNodeStatus&quot;]/IntentName$ AND Property[@Name=&#39;ApplyFailureState&#39;] = Warning)

Error [Critical]: (Property[@Name=&#39;InstanceKey&#39;] = $Target/Property[Type=&quot;HyperVPrivateCloud.Capability.NetworkATC.NetworkIntentNodeStatus&quot;]/IntentName$ AND Property[@Name=&#39;ApplyFailureState&#39;] = Critical)

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: ComplianceToleranceMinutes=60; ComputerName=$Target/Host/Property[Type=&quot;Windows!Microsoft.Windows.Computer&quot;]/PrincipalName$; ExpectedClusterPriority=7; ExpectedPfcPriority=3; ExpectedTrafficClassCount=2; InstanceKey=$Target/Property[Type=&quot;HyperVPrivateCloud.Capability.NetworkATC.NetworkIntentNodeStatus&quot;]/IntentName$; IntervalSeconds=300; MaxAdapterSpeedVariancePercent=0; MaxNodesOutOfCompliance=0; MaxRetryCount=3; MaxTransitionalMinutes=30; MinimumAdapterSpeedGbps=10; MinimumEtsBandwidthPercent=50; PropertyName=ApplyFailureState; RequireDcb=true; RequireNetworkATC=false; RequireRdma=true; RequireRdmaForStorage=true; RequireVmSwitchForComputeIntent=true; SyncTime=; TimeoutSeconds=180 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Error; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Inspect Get-NetIntent and Get-NetIntentStatus on eligible nodes. Compare intent adapter membership, provisioning errors, node status and approved global overrides. Check adapter symmetry, link/RDMA readiness and switch DCB/PFC settings against the intent. Missing ATC on a manual or VMM-managed network is not itself an outage.

### Corrective action and escalation

Resolve the precise convergence error through the selected network authority. Plan changes to intents and switch configuration together. Do not manually overwrite ATC-managed settings or enable ATC alongside a conflicting VMM/SDN authority merely to satisfy monitoring.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Verify intended nodes converge, effective configuration matches approved policy and no new apply failures occur after the normal convergence interval.

### Microsoft references

[Microsoft Learn: manage network atc](https://learn.microsoft.com/en-us/windows-server/networking/network-atc/manage-network-atc)

[Microsoft Learn: get netintentstatus](https://learn.microsoft.com/en-us/powershell/module/networkatc/get-netintentstatus?view=windowsserver2025-ps)


## Network ATC adapter symmetry {#hypervprivatecloud.capability.networkatc.adaptersymmetry.monitor}

`HyperVPrivateCloud.Capability.NetworkATC.AdapterSymmetry.Monitor`

Monitors operational health, status, and thresholds for Network ATC adapter symmetry.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.Fabric.Configuration.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.Fabric.Service.Configuration.Dependency.Monitor &gt; HyperVPrivateCloud.Service.Network.Configuration.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.NetworkATC.NetworkIntent.Configuration.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.NetworkATC.IntentNode.Configuration.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.NetworkATC.AdapterSymmetry.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

Verifies that every adapter the intent declares exists on this node, links at or above MinimumAdapterSpeedGbps, and varies in link speed by no more than MaxAdapterSpeedVariancePercent. Mixed adapter models are Warning.

### Operator response

Align adapter make, model, firmware, driver, and link speed across every node that carries the intent. Adjust MinimumAdapterSpeedGbps and MaxAdapterSpeedVariancePercent for deliberately mixed fabrics.

### Support scope

Network ATC intent and per-node convergence/configuration evidence. This capability is applicable only where Network ATC owns the host network configuration.

Element: HyperVPrivateCloud.Capability.NetworkATC.AdapterSymmetry.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HyperVPrivateCloud.Capability.NetworkATC.NetworkIntentNodeStatus. Parent health aspect: Health!System.Health.ConfigurationState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: (Property[@Name=&#39;InstanceKey&#39;] = $Target/Property[Type=&quot;HyperVPrivateCloud.Capability.NetworkATC.NetworkIntentNodeStatus&quot;]/IntentName$ AND (Property[@Name=&#39;AdapterSymmetryState&#39;] = Good OR Property[@Name=&#39;AdapterSymmetryState&#39;] = NotApplicable))

Warning [Warning]: (Property[@Name=&#39;InstanceKey&#39;] = $Target/Property[Type=&quot;HyperVPrivateCloud.Capability.NetworkATC.NetworkIntentNodeStatus&quot;]/IntentName$ AND Property[@Name=&#39;AdapterSymmetryState&#39;] = Warning)

Error [Critical]: (Property[@Name=&#39;InstanceKey&#39;] = $Target/Property[Type=&quot;HyperVPrivateCloud.Capability.NetworkATC.NetworkIntentNodeStatus&quot;]/IntentName$ AND Property[@Name=&#39;AdapterSymmetryState&#39;] = Critical)

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: ComplianceToleranceMinutes=60; ComputerName=$Target/Host/Property[Type=&quot;Windows!Microsoft.Windows.Computer&quot;]/PrincipalName$; ExpectedClusterPriority=7; ExpectedPfcPriority=3; ExpectedTrafficClassCount=2; InstanceKey=$Target/Property[Type=&quot;HyperVPrivateCloud.Capability.NetworkATC.NetworkIntentNodeStatus&quot;]/IntentName$; IntervalSeconds=300; MaxAdapterSpeedVariancePercent=0; MaxNodesOutOfCompliance=0; MaxRetryCount=3; MaxTransitionalMinutes=30; MinimumAdapterSpeedGbps=10; MinimumEtsBandwidthPercent=50; PropertyName=AdapterSymmetryState; RequireDcb=true; RequireNetworkATC=false; RequireRdma=true; RequireRdmaForStorage=true; RequireVmSwitchForComputeIntent=true; SyncTime=; TimeoutSeconds=180 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Error; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Inspect Get-NetIntent and Get-NetIntentStatus on eligible nodes. Compare intent adapter membership, provisioning errors, node status and approved global overrides. Check adapter symmetry, link/RDMA readiness and switch DCB/PFC settings against the intent. Missing ATC on a manual or VMM-managed network is not itself an outage.

### Corrective action and escalation

Resolve the precise convergence error through the selected network authority. Plan changes to intents and switch configuration together. Do not manually overwrite ATC-managed settings or enable ATC alongside a conflicting VMM/SDN authority merely to satisfy monitoring.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Verify intended nodes converge, effective configuration matches approved policy and no new apply failures occur after the normal convergence interval.

### Microsoft references

[Microsoft Learn: manage network atc](https://learn.microsoft.com/en-us/windows-server/networking/network-atc/manage-network-atc)

[Microsoft Learn: get netintentstatus](https://learn.microsoft.com/en-us/powershell/module/networkatc/get-netintentstatus?view=windowsserver2025-ps)


## Network ATC RDMA enabled and operational state {#hypervprivatecloud.capability.networkatc.rdmastate.monitor}

`HyperVPrivateCloud.Capability.NetworkATC.RdmaState.Monitor`

Monitors operational health, status, and thresholds for Network ATC RDMA enabled and operational state.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.Fabric.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.Fabric.Service.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Service.Network.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.NetworkATC.NetworkIntent.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.NetworkATC.IntentNode.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.NetworkATC.RdmaState.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

Checks Get-NetAdapterRdma for every adapter of a storage-bearing intent. RDMA that is disabled or not operational is Critical. Non-storage intents, and hosts where RequireRdma is overridden to false, report Not Applicable.

### Operator response

Verify RDMA capability, driver and firmware level, DCB or iWARP prerequisites, and switch configuration. Override RequireRdma to false only for nested or lab fabrics.

### Support scope

Network ATC intent and per-node convergence/configuration evidence. This capability is applicable only where Network ATC owns the host network configuration.

Element: HyperVPrivateCloud.Capability.NetworkATC.RdmaState.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HyperVPrivateCloud.Capability.NetworkATC.NetworkIntentNodeStatus. Parent health aspect: Health!System.Health.AvailabilityState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: (Property[@Name=&#39;InstanceKey&#39;] = $Target/Property[Type=&quot;HyperVPrivateCloud.Capability.NetworkATC.NetworkIntentNodeStatus&quot;]/IntentName$ AND (Property[@Name=&#39;RdmaState&#39;] = Good OR Property[@Name=&#39;RdmaState&#39;] = NotApplicable))

Warning [Warning]: (Property[@Name=&#39;InstanceKey&#39;] = $Target/Property[Type=&quot;HyperVPrivateCloud.Capability.NetworkATC.NetworkIntentNodeStatus&quot;]/IntentName$ AND Property[@Name=&#39;RdmaState&#39;] = Warning)

Error [Critical]: (Property[@Name=&#39;InstanceKey&#39;] = $Target/Property[Type=&quot;HyperVPrivateCloud.Capability.NetworkATC.NetworkIntentNodeStatus&quot;]/IntentName$ AND Property[@Name=&#39;RdmaState&#39;] = Critical)

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: ComplianceToleranceMinutes=60; ComputerName=$Target/Host/Property[Type=&quot;Windows!Microsoft.Windows.Computer&quot;]/PrincipalName$; ExpectedClusterPriority=7; ExpectedPfcPriority=3; ExpectedTrafficClassCount=2; InstanceKey=$Target/Property[Type=&quot;HyperVPrivateCloud.Capability.NetworkATC.NetworkIntentNodeStatus&quot;]/IntentName$; IntervalSeconds=300; MaxAdapterSpeedVariancePercent=0; MaxNodesOutOfCompliance=0; MaxRetryCount=3; MaxTransitionalMinutes=30; MinimumAdapterSpeedGbps=10; MinimumEtsBandwidthPercent=50; PropertyName=RdmaState; RequireDcb=true; RequireNetworkATC=false; RequireRdma=true; RequireRdmaForStorage=true; RequireVmSwitchForComputeIntent=true; SyncTime=; TimeoutSeconds=180 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Error; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Inspect Get-NetIntent and Get-NetIntentStatus on eligible nodes. Compare intent adapter membership, provisioning errors, node status and approved global overrides. Check adapter symmetry, link/RDMA readiness and switch DCB/PFC settings against the intent. Missing ATC on a manual or VMM-managed network is not itself an outage.

### Corrective action and escalation

Resolve the precise convergence error through the selected network authority. Plan changes to intents and switch configuration together. Do not manually overwrite ATC-managed settings or enable ATC alongside a conflicting VMM/SDN authority merely to satisfy monitoring.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Verify intended nodes converge, effective configuration matches approved policy and no new apply failures occur after the normal convergence interval.

### Microsoft references

[Microsoft Learn: manage network atc](https://learn.microsoft.com/en-us/windows-server/networking/network-atc/manage-network-atc)

[Microsoft Learn: get netintentstatus](https://learn.microsoft.com/en-us/powershell/module/networkatc/get-netintentstatus?view=windowsserver2025-ps)


## Network ATC RDMA configuration drift {#hypervprivatecloud.capability.networkatc.rdmaconfigurationdrift.monitor}

`HyperVPrivateCloud.Capability.NetworkATC.RdmaConfigurationDrift.Monitor`

Monitors operational health, status, and thresholds for Network ATC RDMA configuration drift.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.Fabric.Configuration.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.Fabric.Service.Configuration.Dependency.Monitor &gt; HyperVPrivateCloud.Service.Network.Configuration.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.NetworkATC.NetworkIntent.Configuration.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.NetworkATC.IntentNode.Configuration.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.NetworkATC.RdmaConfigurationDrift.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

Reads Get-NetAdapterQos for the storage intent adapters and confirms that QoS is enabled and priority flow control is operational for ExpectedPfcPriority.

### Operator response

Compare the adapter QoS state with the intent and the physical switch policy, then re-apply the intent. Change ExpectedPfcPriority when the fabric standard uses a different lossless priority.

### Support scope

Network ATC intent and per-node convergence/configuration evidence. This capability is applicable only where Network ATC owns the host network configuration.

Element: HyperVPrivateCloud.Capability.NetworkATC.RdmaConfigurationDrift.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HyperVPrivateCloud.Capability.NetworkATC.NetworkIntentNodeStatus. Parent health aspect: Health!System.Health.ConfigurationState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: (Property[@Name=&#39;InstanceKey&#39;] = $Target/Property[Type=&quot;HyperVPrivateCloud.Capability.NetworkATC.NetworkIntentNodeStatus&quot;]/IntentName$ AND (Property[@Name=&#39;RdmaConfigurationDriftState&#39;] = Good OR Property[@Name=&#39;RdmaConfigurationDriftState&#39;] = NotApplicable))

Warning [Warning]: (Property[@Name=&#39;InstanceKey&#39;] = $Target/Property[Type=&quot;HyperVPrivateCloud.Capability.NetworkATC.NetworkIntentNodeStatus&quot;]/IntentName$ AND Property[@Name=&#39;RdmaConfigurationDriftState&#39;] = Warning)

Error [Critical]: (Property[@Name=&#39;InstanceKey&#39;] = $Target/Property[Type=&quot;HyperVPrivateCloud.Capability.NetworkATC.NetworkIntentNodeStatus&quot;]/IntentName$ AND Property[@Name=&#39;RdmaConfigurationDriftState&#39;] = Critical)

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: ComplianceToleranceMinutes=60; ComputerName=$Target/Host/Property[Type=&quot;Windows!Microsoft.Windows.Computer&quot;]/PrincipalName$; ExpectedClusterPriority=7; ExpectedPfcPriority=3; ExpectedTrafficClassCount=2; InstanceKey=$Target/Property[Type=&quot;HyperVPrivateCloud.Capability.NetworkATC.NetworkIntentNodeStatus&quot;]/IntentName$; IntervalSeconds=300; MaxAdapterSpeedVariancePercent=0; MaxNodesOutOfCompliance=0; MaxRetryCount=3; MaxTransitionalMinutes=30; MinimumAdapterSpeedGbps=10; MinimumEtsBandwidthPercent=50; PropertyName=RdmaConfigurationDriftState; RequireDcb=true; RequireNetworkATC=false; RequireRdma=true; RequireRdmaForStorage=true; RequireVmSwitchForComputeIntent=true; SyncTime=; TimeoutSeconds=180 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Warning; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Inspect Get-NetIntent and Get-NetIntentStatus on eligible nodes. Compare intent adapter membership, provisioning errors, node status and approved global overrides. Check adapter symmetry, link/RDMA readiness and switch DCB/PFC settings against the intent. Missing ATC on a manual or VMM-managed network is not itself an outage.

### Corrective action and escalation

Resolve the precise convergence error through the selected network authority. Plan changes to intents and switch configuration together. Do not manually overwrite ATC-managed settings or enable ATC alongside a conflicting VMM/SDN authority merely to satisfy monitoring.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Verify intended nodes converge, effective configuration matches approved policy and no new apply failures occur after the normal convergence interval.

### Microsoft references

[Microsoft Learn: manage network atc](https://learn.microsoft.com/en-us/windows-server/networking/network-atc/manage-network-atc)

[Microsoft Learn: get netintentstatus](https://learn.microsoft.com/en-us/powershell/module/networkatc/get-netintentstatus?view=windowsserver2025-ps)


## Network ATC DCB and PFC policy compliance {#hypervprivatecloud.capability.networkatc.dcbpfccompliance.monitor}

`HyperVPrivateCloud.Capability.NetworkATC.DcbPfcCompliance.Monitor`

Monitors operational health, status, and thresholds for Network ATC DCB and PFC policy compliance.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.Fabric.Configuration.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.Fabric.Service.Configuration.Dependency.Monitor &gt; HyperVPrivateCloud.Service.Network.Configuration.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.NetworkATC.NetworkIntent.Configuration.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.NetworkATC.IntentNode.Configuration.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.NetworkATC.DcbPfcCompliance.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

Confirms that DCB and QoS are enabled on the participating adapters, that DCBX willing mode is not silently accepting switch policy, and that ExpectedPfcPriority appears in the operational traffic classes.

### Operator response

Align the host DCB policy with the physical switch, disable DCBX willing mode where the host owns the policy, and re-apply the intent. Override RequireDcb to false for fabrics that do not use DCB.

### Support scope

Network ATC intent and per-node convergence/configuration evidence. This capability is applicable only where Network ATC owns the host network configuration.

Element: HyperVPrivateCloud.Capability.NetworkATC.DcbPfcCompliance.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HyperVPrivateCloud.Capability.NetworkATC.NetworkIntentNodeStatus. Parent health aspect: Health!System.Health.ConfigurationState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: (Property[@Name=&#39;InstanceKey&#39;] = $Target/Property[Type=&quot;HyperVPrivateCloud.Capability.NetworkATC.NetworkIntentNodeStatus&quot;]/IntentName$ AND (Property[@Name=&#39;DcbPfcState&#39;] = Good OR Property[@Name=&#39;DcbPfcState&#39;] = NotApplicable))

Warning [Warning]: (Property[@Name=&#39;InstanceKey&#39;] = $Target/Property[Type=&quot;HyperVPrivateCloud.Capability.NetworkATC.NetworkIntentNodeStatus&quot;]/IntentName$ AND Property[@Name=&#39;DcbPfcState&#39;] = Warning)

Error [Critical]: (Property[@Name=&#39;InstanceKey&#39;] = $Target/Property[Type=&quot;HyperVPrivateCloud.Capability.NetworkATC.NetworkIntentNodeStatus&quot;]/IntentName$ AND Property[@Name=&#39;DcbPfcState&#39;] = Critical)

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: ComplianceToleranceMinutes=60; ComputerName=$Target/Host/Property[Type=&quot;Windows!Microsoft.Windows.Computer&quot;]/PrincipalName$; ExpectedClusterPriority=7; ExpectedPfcPriority=3; ExpectedTrafficClassCount=2; InstanceKey=$Target/Property[Type=&quot;HyperVPrivateCloud.Capability.NetworkATC.NetworkIntentNodeStatus&quot;]/IntentName$; IntervalSeconds=300; MaxAdapterSpeedVariancePercent=0; MaxNodesOutOfCompliance=0; MaxRetryCount=3; MaxTransitionalMinutes=30; MinimumAdapterSpeedGbps=10; MinimumEtsBandwidthPercent=50; PropertyName=DcbPfcState; RequireDcb=true; RequireNetworkATC=false; RequireRdma=true; RequireRdmaForStorage=true; RequireVmSwitchForComputeIntent=true; SyncTime=; TimeoutSeconds=180 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Error; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Inspect Get-NetIntent and Get-NetIntentStatus on eligible nodes. Compare intent adapter membership, provisioning errors, node status and approved global overrides. Check adapter symmetry, link/RDMA readiness and switch DCB/PFC settings against the intent. Missing ATC on a manual or VMM-managed network is not itself an outage.

### Corrective action and escalation

Resolve the precise convergence error through the selected network authority. Plan changes to intents and switch configuration together. Do not manually overwrite ATC-managed settings or enable ATC alongside a conflicting VMM/SDN authority merely to satisfy monitoring.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Verify intended nodes converge, effective configuration matches approved policy and no new apply failures occur after the normal convergence interval.

### Microsoft references

[Microsoft Learn: manage network atc](https://learn.microsoft.com/en-us/windows-server/networking/network-atc/manage-network-atc)

[Microsoft Learn: get netintentstatus](https://learn.microsoft.com/en-us/powershell/module/networkatc/get-netintentstatus?view=windowsserver2025-ps)


## Network ATC ETS bandwidth policy compliance {#hypervprivatecloud.capability.networkatc.etspolicycompliance.monitor}

`HyperVPrivateCloud.Capability.NetworkATC.EtsPolicyCompliance.Monitor`

Monitors operational health, status, and thresholds for Network ATC ETS bandwidth policy compliance.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.Fabric.Configuration.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.Fabric.Service.Configuration.Dependency.Monitor &gt; HyperVPrivateCloud.Service.Network.Configuration.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.NetworkATC.GlobalStatus.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.NetworkATC.EtsPolicyCompliance.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

Verifies that a traffic class carries ExpectedPfcPriority with at least MinimumEtsBandwidthPercent reserved bandwidth under the ETS algorithm, and that a class carries ExpectedClusterPriority.

### Operator response

Compare Get-NetQosTrafficClass with the intent and the switch ETS policy, then re-apply the intent. Adjust MinimumEtsBandwidthPercent, ExpectedPfcPriority, and ExpectedClusterPriority to the fabric standard.

### Support scope

Network ATC intent and per-node convergence/configuration evidence. This capability is applicable only where Network ATC owns the host network configuration.

Element: HyperVPrivateCloud.Capability.NetworkATC.EtsPolicyCompliance.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HyperVPrivateCloud.Capability.NetworkATC.GlobalConfigurationStatus. Parent health aspect: Health!System.Health.ConfigurationState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: (Property[@Name=&#39;EtsPolicyState&#39;] = Good OR Property[@Name=&#39;EtsPolicyState&#39;] = NotApplicable)

Warning [Warning]: Property[@Name=&#39;EtsPolicyState&#39;] = Warning

Error [Critical]: Property[@Name=&#39;EtsPolicyState&#39;] = Critical

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: ComplianceToleranceMinutes=60; ComputerName=$Target/Host/Property[Type=&quot;Windows!Microsoft.Windows.Computer&quot;]/PrincipalName$; ExpectedClusterPriority=7; ExpectedPfcPriority=3; ExpectedTrafficClassCount=2; IntervalSeconds=300; IsStorageIntent=false; MaxAdapterSpeedVariancePercent=0; MaxNodesOutOfCompliance=0; MaxRetryCount=3; MinimumAdapterSpeedGbps=10; MinimumEtsBandwidthPercent=50; Mode=All; PropertyName=EtsPolicyState; RequireDcb=true; RequireNetworkATC=false; RequireRdma=true; RequireVmSwitchForComputeIntent=true; SyncTime=; TimeoutSeconds=180 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Warning; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Inspect Get-NetIntent and Get-NetIntentStatus on eligible nodes. Compare intent adapter membership, provisioning errors, node status and approved global overrides. Check adapter symmetry, link/RDMA readiness and switch DCB/PFC settings against the intent. Missing ATC on a manual or VMM-managed network is not itself an outage.

### Corrective action and escalation

Resolve the precise convergence error through the selected network authority. Plan changes to intents and switch configuration together. Do not manually overwrite ATC-managed settings or enable ATC alongside a conflicting VMM/SDN authority merely to satisfy monitoring.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Verify intended nodes converge, effective configuration matches approved policy and no new apply failures occur after the normal convergence interval.

### Microsoft references

[Microsoft Learn: manage network atc](https://learn.microsoft.com/en-us/windows-server/networking/network-atc/manage-network-atc)

[Microsoft Learn: get netintentstatus](https://learn.microsoft.com/en-us/powershell/module/networkatc/get-netintentstatus?view=windowsserver2025-ps)


## Network ATC QoS traffic class configuration {#hypervprivatecloud.capability.networkatc.qostrafficclass.monitor}

`HyperVPrivateCloud.Capability.NetworkATC.QosTrafficClass.Monitor`

Monitors operational health, status, and thresholds for Network ATC QoS traffic class configuration.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.Fabric.Configuration.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.Fabric.Service.Configuration.Dependency.Monitor &gt; HyperVPrivateCloud.Service.Network.Configuration.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.NetworkATC.GlobalStatus.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.NetworkATC.QosTrafficClass.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

Counts non-default QoS traffic classes against ExpectedTrafficClassCount and raises Critical when the reserved bandwidth across all classes exceeds one hundred percent.

### Operator response

Reconcile the traffic class definitions with the intent, remove duplicate or manual classes, and keep the total reservation at or below one hundred percent.

### Support scope

Network ATC intent and per-node convergence/configuration evidence. This capability is applicable only where Network ATC owns the host network configuration.

Element: HyperVPrivateCloud.Capability.NetworkATC.QosTrafficClass.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HyperVPrivateCloud.Capability.NetworkATC.GlobalConfigurationStatus. Parent health aspect: Health!System.Health.ConfigurationState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: (Property[@Name=&#39;QosTrafficClassState&#39;] = Good OR Property[@Name=&#39;QosTrafficClassState&#39;] = NotApplicable)

Warning [Warning]: Property[@Name=&#39;QosTrafficClassState&#39;] = Warning

Error [Critical]: Property[@Name=&#39;QosTrafficClassState&#39;] = Critical

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: ComplianceToleranceMinutes=60; ComputerName=$Target/Host/Property[Type=&quot;Windows!Microsoft.Windows.Computer&quot;]/PrincipalName$; ExpectedClusterPriority=7; ExpectedPfcPriority=3; ExpectedTrafficClassCount=2; IntervalSeconds=300; IsStorageIntent=false; MaxAdapterSpeedVariancePercent=0; MaxNodesOutOfCompliance=0; MaxRetryCount=3; MinimumAdapterSpeedGbps=10; MinimumEtsBandwidthPercent=50; Mode=All; PropertyName=QosTrafficClassState; RequireDcb=true; RequireNetworkATC=false; RequireRdma=true; RequireVmSwitchForComputeIntent=true; SyncTime=; TimeoutSeconds=180 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Error; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Inspect Get-NetIntent and Get-NetIntentStatus on eligible nodes. Compare intent adapter membership, provisioning errors, node status and approved global overrides. Check adapter symmetry, link/RDMA readiness and switch DCB/PFC settings against the intent. Missing ATC on a manual or VMM-managed network is not itself an outage.

### Corrective action and escalation

Resolve the precise convergence error through the selected network authority. Plan changes to intents and switch configuration together. Do not manually overwrite ATC-managed settings or enable ATC alongside a conflicting VMM/SDN authority merely to satisfy monitoring.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Verify intended nodes converge, effective configuration matches approved policy and no new apply failures occur after the normal convergence interval.

### Microsoft references

[Microsoft Learn: manage network atc](https://learn.microsoft.com/en-us/windows-server/networking/network-atc/manage-network-atc)

[Microsoft Learn: get netintentstatus](https://learn.microsoft.com/en-us/powershell/module/networkatc/get-netintentstatus?view=windowsserver2025-ps)


## Network ATC virtual switch compliance {#hypervprivatecloud.capability.networkatc.vmswitchcompliance.monitor}

`HyperVPrivateCloud.Capability.NetworkATC.VmSwitchCompliance.Monitor`

Monitors operational health, status, and thresholds for Network ATC virtual switch compliance.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.Fabric.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.Fabric.Service.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Service.Network.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.NetworkATC.NetworkIntent.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.NetworkATC.IntentNode.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.NetworkATC.VmSwitchCompliance.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

Confirms that an external virtual switch exists, is bound to the adapters the intent declares, and uses Switch Embedded Teaming when the intent declares more than one adapter.

### Operator response

Compare Get-VMSwitch with the intent, remove manually created switches that conflict with Network ATC, and re-apply the intent. Override RequireVmSwitchForComputeIntent to false for storage-only nodes.

### Support scope

Network ATC intent and per-node convergence/configuration evidence. This capability is applicable only where Network ATC owns the host network configuration.

Element: HyperVPrivateCloud.Capability.NetworkATC.VmSwitchCompliance.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HyperVPrivateCloud.Capability.NetworkATC.NetworkIntentNodeStatus. Parent health aspect: Health!System.Health.AvailabilityState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: (Property[@Name=&#39;InstanceKey&#39;] = $Target/Property[Type=&quot;HyperVPrivateCloud.Capability.NetworkATC.NetworkIntentNodeStatus&quot;]/IntentName$ AND (Property[@Name=&#39;VmSwitchState&#39;] = Good OR Property[@Name=&#39;VmSwitchState&#39;] = NotApplicable))

Warning [Warning]: (Property[@Name=&#39;InstanceKey&#39;] = $Target/Property[Type=&quot;HyperVPrivateCloud.Capability.NetworkATC.NetworkIntentNodeStatus&quot;]/IntentName$ AND Property[@Name=&#39;VmSwitchState&#39;] = Warning)

Error [Critical]: (Property[@Name=&#39;InstanceKey&#39;] = $Target/Property[Type=&quot;HyperVPrivateCloud.Capability.NetworkATC.NetworkIntentNodeStatus&quot;]/IntentName$ AND Property[@Name=&#39;VmSwitchState&#39;] = Critical)

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: ComplianceToleranceMinutes=60; ComputerName=$Target/Host/Property[Type=&quot;Windows!Microsoft.Windows.Computer&quot;]/PrincipalName$; ExpectedClusterPriority=7; ExpectedPfcPriority=3; ExpectedTrafficClassCount=2; InstanceKey=$Target/Property[Type=&quot;HyperVPrivateCloud.Capability.NetworkATC.NetworkIntentNodeStatus&quot;]/IntentName$; IntervalSeconds=300; MaxAdapterSpeedVariancePercent=0; MaxNodesOutOfCompliance=0; MaxRetryCount=3; MaxTransitionalMinutes=30; MinimumAdapterSpeedGbps=10; MinimumEtsBandwidthPercent=50; PropertyName=VmSwitchState; RequireDcb=true; RequireNetworkATC=false; RequireRdma=true; RequireRdmaForStorage=true; RequireVmSwitchForComputeIntent=true; SyncTime=; TimeoutSeconds=180 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Warning; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Inspect Get-NetIntent and Get-NetIntentStatus on eligible nodes. Compare intent adapter membership, provisioning errors, node status and approved global overrides. Check adapter symmetry, link/RDMA readiness and switch DCB/PFC settings against the intent. Missing ATC on a manual or VMM-managed network is not itself an outage.

### Corrective action and escalation

Resolve the precise convergence error through the selected network authority. Plan changes to intents and switch configuration together. Do not manually overwrite ATC-managed settings or enable ATC alongside a conflicting VMM/SDN authority merely to satisfy monitoring.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Verify intended nodes converge, effective configuration matches approved policy and no new apply failures occur after the normal convergence interval.

### Microsoft references

[Microsoft Learn: manage network atc](https://learn.microsoft.com/en-us/windows-server/networking/network-atc/manage-network-atc)

[Microsoft Learn: get netintentstatus](https://learn.microsoft.com/en-us/powershell/module/networkatc/get-netintentstatus?view=windowsserver2025-ps)


## Network ATC cluster-wide intent consistency {#hypervprivatecloud.capability.networkatc.clusterintentconsistency.monitor}

`HyperVPrivateCloud.Capability.NetworkATC.ClusterIntentConsistency.Monitor`

Monitors operational health, status, and thresholds for Network ATC cluster-wide intent consistency.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.Fabric.Configuration.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.Fabric.Service.Configuration.Dependency.Monitor &gt; HyperVPrivateCloud.Service.Network.Configuration.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.NetworkATC.GlobalStatus.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.NetworkATC.ClusterIntentConsistency.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

Groups every intent status record returned for the cluster and counts nodes that are not reporting a successful configuration. More than MaxNodesOutOfCompliance failing records is Critical; transitional records are Warning.

### Operator response

Identify the listed node and intent pair, resolve the node-level failure, and let Network ATC converge the cluster. Raise MaxNodesOutOfCompliance only during a planned, staged rollout.

### Support scope

Network ATC intent and per-node convergence/configuration evidence. This capability is applicable only where Network ATC owns the host network configuration.

Element: HyperVPrivateCloud.Capability.NetworkATC.ClusterIntentConsistency.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HyperVPrivateCloud.Capability.NetworkATC.GlobalConfigurationStatus. Parent health aspect: Health!System.Health.ConfigurationState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: (Property[@Name=&#39;ClusterConsistencyState&#39;] = Good OR Property[@Name=&#39;ClusterConsistencyState&#39;] = NotApplicable)

Warning [Warning]: Property[@Name=&#39;ClusterConsistencyState&#39;] = Warning

Error [Critical]: Property[@Name=&#39;ClusterConsistencyState&#39;] = Critical

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: AdapterNames=; ComplianceToleranceMinutes=60; ComputerName=$Target/Host/Property[Type=&quot;Windows!Microsoft.Windows.Computer&quot;]/PrincipalName$; ExpectedClusterPriority=7; ExpectedPfcPriority=3; ExpectedTrafficClassCount=2; IntentName=; IntervalSeconds=300; IsStorageIntent=false; MaxAdapterSpeedVariancePercent=0; MaxNodesOutOfCompliance=0; MaxRetryCount=3; MinimumAdapterSpeedGbps=10; MinimumEtsBandwidthPercent=50; Mode=All; PropertyName=ClusterConsistencyState; RequireDcb=true; RequireNetworkATC=false; RequireRdma=true; RequireVmSwitchForComputeIntent=true; SyncTime=; TimeoutSeconds=180 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Error; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Inspect Get-NetIntent and Get-NetIntentStatus on eligible nodes. Compare intent adapter membership, provisioning errors, node status and approved global overrides. Check adapter symmetry, link/RDMA readiness and switch DCB/PFC settings against the intent. Missing ATC on a manual or VMM-managed network is not itself an outage.

### Corrective action and escalation

Resolve the precise convergence error through the selected network authority. Plan changes to intents and switch configuration together. Do not manually overwrite ATC-managed settings or enable ATC alongside a conflicting VMM/SDN authority merely to satisfy monitoring.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Verify intended nodes converge, effective configuration matches approved policy and no new apply failures occur after the normal convergence interval.

### Microsoft references

[Microsoft Learn: manage network atc](https://learn.microsoft.com/en-us/windows-server/networking/network-atc/manage-network-atc)

[Microsoft Learn: get netintentstatus](https://learn.microsoft.com/en-us/powershell/module/networkatc/get-netintentstatus?view=windowsserver2025-ps)


## Network ATC global override drift {#hypervprivatecloud.capability.networkatc.globaloverridedrift.monitor}

`HyperVPrivateCloud.Capability.NetworkATC.GlobalOverrideDrift.Monitor`

Monitors operational health, status, and thresholds for Network ATC global override drift.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.Fabric.Configuration.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.Fabric.Service.Configuration.Dependency.Monitor &gt; HyperVPrivateCloud.Service.Network.Configuration.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.NetworkATC.GlobalStatus.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.NetworkATC.GlobalOverrideDrift.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

Tracks the global cluster and proxy override status against the ComplianceToleranceMinutes tolerance window. Absent global overrides report Not Applicable.

### Operator response

Review Get-NetIntentStatus with GlobalOverrides, correct the source configuration through approved Network ATC procedures, and allow the override to re-apply.

### Support scope

Network ATC intent and per-node convergence/configuration evidence. This capability is applicable only where Network ATC owns the host network configuration.

Element: HyperVPrivateCloud.Capability.NetworkATC.GlobalOverrideDrift.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HyperVPrivateCloud.Capability.NetworkATC.GlobalConfigurationStatus. Parent health aspect: Health!System.Health.ConfigurationState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: (Property[@Name=&#39;GlobalDriftState&#39;] = Good OR Property[@Name=&#39;GlobalDriftState&#39;] = NotApplicable)

Warning [Warning]: Property[@Name=&#39;GlobalDriftState&#39;] = Warning

Error [Critical]: Property[@Name=&#39;GlobalDriftState&#39;] = Critical

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: AdapterNames=; ComplianceToleranceMinutes=60; ComputerName=$Target/Host/Property[Type=&quot;Windows!Microsoft.Windows.Computer&quot;]/PrincipalName$; ExpectedClusterPriority=7; ExpectedPfcPriority=3; ExpectedTrafficClassCount=2; IntentName=; IntervalSeconds=300; IsStorageIntent=false; MaxAdapterSpeedVariancePercent=0; MaxNodesOutOfCompliance=0; MaxRetryCount=3; MinimumAdapterSpeedGbps=10; MinimumEtsBandwidthPercent=50; Mode=All; PropertyName=GlobalDriftState; RequireDcb=true; RequireNetworkATC=false; RequireRdma=true; RequireVmSwitchForComputeIntent=true; SyncTime=; TimeoutSeconds=180 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Error; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Inspect Get-NetIntent and Get-NetIntentStatus on eligible nodes. Compare intent adapter membership, provisioning errors, node status and approved global overrides. Check adapter symmetry, link/RDMA readiness and switch DCB/PFC settings against the intent. Missing ATC on a manual or VMM-managed network is not itself an outage.

### Corrective action and escalation

Resolve the precise convergence error through the selected network authority. Plan changes to intents and switch configuration together. Do not manually overwrite ATC-managed settings or enable ATC alongside a conflicting VMM/SDN authority merely to satisfy monitoring.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Verify intended nodes converge, effective configuration matches approved policy and no new apply failures occur after the normal convergence interval.

### Microsoft references

[Microsoft Learn: manage network atc](https://learn.microsoft.com/en-us/windows-server/networking/network-atc/manage-network-atc)

[Microsoft Learn: get netintentstatus](https://learn.microsoft.com/en-us/powershell/module/networkatc/get-netintentstatus?view=windowsserver2025-ps)


## Roll up participating adapter health {#hypervprivatecloud.capability.networkatc.nodeadapter.dependency.monitor}

`HyperVPrivateCloud.Capability.NetworkATC.NodeAdapter.Dependency.Monitor`

Rolls up the health of member Roll up participating adapter health objects into the parent entity.

### Support scope

Network ATC intent and per-node convergence/configuration evidence. This capability is applicable only where Network ATC owns the host network configuration.

Element: HyperVPrivateCloud.Capability.NetworkATC.NodeAdapter.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HyperVPrivateCloud.Capability.NetworkATC.NetworkIntentNodeStatus; relationship=HyperVPrivateCloud.Capability.NetworkATC.NodeStatusReferencesComputerNetworkAdapter; member monitor=Health!System.Health.AvailabilityState; parent=Health!System.Health.AvailabilityState; algorithm=WorstOf; unavailable-member policy=Warning. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Inspect Get-NetIntent and Get-NetIntentStatus on eligible nodes. Compare intent adapter membership, provisioning errors, node status and approved global overrides. Check adapter symmetry, link/RDMA readiness and switch DCB/PFC settings against the intent. Missing ATC on a manual or VMM-managed network is not itself an outage.

### Corrective action and escalation

Resolve the precise convergence error through the selected network authority. Plan changes to intents and switch configuration together. Do not manually overwrite ATC-managed settings or enable ATC alongside a conflicting VMM/SDN authority merely to satisfy monitoring.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Verify intended nodes converge, effective configuration matches approved policy and no new apply failures occur after the normal convergence interval.

### Microsoft references

[Microsoft Learn: manage network atc](https://learn.microsoft.com/en-us/windows-server/networking/network-atc/manage-network-atc)

[Microsoft Learn: get netintentstatus](https://learn.microsoft.com/en-us/powershell/module/networkatc/get-netintentstatus?view=windowsserver2025-ps)


## Roll up per-node intent health {#hypervprivatecloud.capability.networkatc.intentnode.dependency.monitor}

`HyperVPrivateCloud.Capability.NetworkATC.IntentNode.Dependency.Monitor`

Rolls up the health of member Roll up per-node intent health objects into the parent entity.

### Support scope

Network ATC intent and per-node convergence/configuration evidence. This capability is applicable only where Network ATC owns the host network configuration.

Element: HyperVPrivateCloud.Capability.NetworkATC.IntentNode.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HyperVPrivateCloud.Capability.NetworkATC.NetworkIntent; relationship=HyperVPrivateCloud.Capability.NetworkATC.NetworkIntentContainsNodeStatus; member monitor=Health!System.Health.AvailabilityState; parent=Health!System.Health.AvailabilityState; algorithm=WorstOf; unavailable-member policy=Warning. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Inspect Get-NetIntent and Get-NetIntentStatus on eligible nodes. Compare intent adapter membership, provisioning errors, node status and approved global overrides. Check adapter symmetry, link/RDMA readiness and switch DCB/PFC settings against the intent. Missing ATC on a manual or VMM-managed network is not itself an outage.

### Corrective action and escalation

Resolve the precise convergence error through the selected network authority. Plan changes to intents and switch configuration together. Do not manually overwrite ATC-managed settings or enable ATC alongside a conflicting VMM/SDN authority merely to satisfy monitoring.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Verify intended nodes converge, effective configuration matches approved policy and no new apply failures occur after the normal convergence interval.

### Microsoft references

[Microsoft Learn: manage network atc](https://learn.microsoft.com/en-us/windows-server/networking/network-atc/manage-network-atc)

[Microsoft Learn: get netintentstatus](https://learn.microsoft.com/en-us/powershell/module/networkatc/get-netintentstatus?view=windowsserver2025-ps)


## Roll up Network ATC intent health {#hypervprivatecloud.capability.networkatc.networkintent.dependency.monitor}

`HyperVPrivateCloud.Capability.NetworkATC.NetworkIntent.Dependency.Monitor`

Rolls up the health of member Roll up Network ATC intent health objects into the parent entity.

### Support scope

Network ATC intent and per-node convergence/configuration evidence. This capability is applicable only where Network ATC owns the host network configuration.

Element: HyperVPrivateCloud.Capability.NetworkATC.NetworkIntent.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.NetworkComponent; relationship=HyperVPrivateCloud.Capability.NetworkATC.NetworkComponentContainsNetworkIntent; member monitor=Health!System.Health.AvailabilityState; parent=Health!System.Health.AvailabilityState; algorithm=WorstOf; unavailable-member policy=Success. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Inspect Get-NetIntent and Get-NetIntentStatus on eligible nodes. Compare intent adapter membership, provisioning errors, node status and approved global overrides. Check adapter symmetry, link/RDMA readiness and switch DCB/PFC settings against the intent. Missing ATC on a manual or VMM-managed network is not itself an outage.

### Corrective action and escalation

Resolve the precise convergence error through the selected network authority. Plan changes to intents and switch configuration together. Do not manually overwrite ATC-managed settings or enable ATC alongside a conflicting VMM/SDN authority merely to satisfy monitoring.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Verify intended nodes converge, effective configuration matches approved policy and no new apply failures occur after the normal convergence interval.

### Microsoft references

[Microsoft Learn: manage network atc](https://learn.microsoft.com/en-us/windows-server/networking/network-atc/manage-network-atc)

[Microsoft Learn: get netintentstatus](https://learn.microsoft.com/en-us/powershell/module/networkatc/get-netintentstatus?view=windowsserver2025-ps)


## Roll up Network ATC global configuration health {#hypervprivatecloud.capability.networkatc.globalstatus.dependency.monitor}

`HyperVPrivateCloud.Capability.NetworkATC.GlobalStatus.Dependency.Monitor`

Rolls up the health of member Roll up Network ATC global configuration health objects into the parent entity.

### Support scope

Network ATC intent and per-node convergence/configuration evidence. This capability is applicable only where Network ATC owns the host network configuration.

Element: HyperVPrivateCloud.Capability.NetworkATC.GlobalStatus.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.NetworkComponent; relationship=HyperVPrivateCloud.Capability.NetworkATC.NetworkComponentContainsGlobalStatus; member monitor=Health!System.Health.ConfigurationState; parent=Health!System.Health.ConfigurationState; algorithm=WorstOf; unavailable-member policy=Success. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Inspect Get-NetIntent and Get-NetIntentStatus on eligible nodes. Compare intent adapter membership, provisioning errors, node status and approved global overrides. Check adapter symmetry, link/RDMA readiness and switch DCB/PFC settings against the intent. Missing ATC on a manual or VMM-managed network is not itself an outage.

### Corrective action and escalation

Resolve the precise convergence error through the selected network authority. Plan changes to intents and switch configuration together. Do not manually overwrite ATC-managed settings or enable ATC alongside a conflicting VMM/SDN authority merely to satisfy monitoring.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Verify intended nodes converge, effective configuration matches approved policy and no new apply failures occur after the normal convergence interval.

### Microsoft references

[Microsoft Learn: manage network atc](https://learn.microsoft.com/en-us/windows-server/networking/network-atc/manage-network-atc)

[Microsoft Learn: get netintentstatus](https://learn.microsoft.com/en-us/powershell/module/networkatc/get-netintentstatus?view=windowsserver2025-ps)


## Roll up Configuration through NetworkATC.NetworkIntentContainsNodeStatus {#hypervprivatecloud.capability.networkatc.intentnode.configuration.dependency.monitor}

`HyperVPrivateCloud.Capability.NetworkATC.IntentNode.Configuration.Dependency.Monitor`

Preserves the originating health aspect through this domain dependency. Open the unhealthy member monitor for the actual cause; this rollup does not create a second incident.

### Support scope

Network ATC intent and per-node convergence/configuration evidence. This capability is applicable only where Network ATC owns the host network configuration.

Element: HyperVPrivateCloud.Capability.NetworkATC.IntentNode.Configuration.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HyperVPrivateCloud.Capability.NetworkATC.NetworkIntent; relationship=HyperVPrivateCloud.Capability.NetworkATC.NetworkIntentContainsNodeStatus; member monitor=Health!System.Health.ConfigurationState; parent=Health!System.Health.ConfigurationState; algorithm=WorstOf; unavailable-member policy=Warning. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Inspect Get-NetIntent and Get-NetIntentStatus on eligible nodes. Compare intent adapter membership, provisioning errors, node status and approved global overrides. Check adapter symmetry, link/RDMA readiness and switch DCB/PFC settings against the intent. Missing ATC on a manual or VMM-managed network is not itself an outage.

### Corrective action and escalation

Resolve the precise convergence error through the selected network authority. Plan changes to intents and switch configuration together. Do not manually overwrite ATC-managed settings or enable ATC alongside a conflicting VMM/SDN authority merely to satisfy monitoring.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Verify intended nodes converge, effective configuration matches approved policy and no new apply failures occur after the normal convergence interval.

### Microsoft references

[Microsoft Learn: manage network atc](https://learn.microsoft.com/en-us/windows-server/networking/network-atc/manage-network-atc)

[Microsoft Learn: get netintentstatus](https://learn.microsoft.com/en-us/powershell/module/networkatc/get-netintentstatus?view=windowsserver2025-ps)


## Roll up Configuration through NetworkATC.NetworkComponentContainsNetworkIntent {#hypervprivatecloud.capability.networkatc.networkintent.configuration.dependency.monitor}

`HyperVPrivateCloud.Capability.NetworkATC.NetworkIntent.Configuration.Dependency.Monitor`

Preserves the originating health aspect through this domain dependency. Open the unhealthy member monitor for the actual cause; this rollup does not create a second incident.

### Support scope

Network ATC intent and per-node convergence/configuration evidence. This capability is applicable only where Network ATC owns the host network configuration.

Element: HyperVPrivateCloud.Capability.NetworkATC.NetworkIntent.Configuration.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.NetworkComponent; relationship=HyperVPrivateCloud.Capability.NetworkATC.NetworkComponentContainsNetworkIntent; member monitor=Health!System.Health.ConfigurationState; parent=Health!System.Health.ConfigurationState; algorithm=WorstOf; unavailable-member policy=Success. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Inspect Get-NetIntent and Get-NetIntentStatus on eligible nodes. Compare intent adapter membership, provisioning errors, node status and approved global overrides. Check adapter symmetry, link/RDMA readiness and switch DCB/PFC settings against the intent. Missing ATC on a manual or VMM-managed network is not itself an outage.

### Corrective action and escalation

Resolve the precise convergence error through the selected network authority. Plan changes to intents and switch configuration together. Do not manually overwrite ATC-managed settings or enable ATC alongside a conflicting VMM/SDN authority merely to satisfy monitoring.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Verify intended nodes converge, effective configuration matches approved policy and no new apply failures occur after the normal convergence interval.

### Microsoft references

[Microsoft Learn: manage network atc](https://learn.microsoft.com/en-us/windows-server/networking/network-atc/manage-network-atc)

[Microsoft Learn: get netintentstatus](https://learn.microsoft.com/en-us/powershell/module/networkatc/get-netintentstatus?view=windowsserver2025-ps)
