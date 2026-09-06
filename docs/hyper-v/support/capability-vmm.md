# Hyper-V Private Cloud Monitoring - Virtual Machine Manager Integration

Generated support reference. [All capabilities](catalog.md) · [Day-2 triage](index.md).

Default conditions below come from the compiled candidate source, not the effective overrides in your management group. Read the monitor-specific knowledge together with the common safety and verification guidance. Microsoft links explain the underlying technology; product thresholds are not Microsoft recommendations.

## VMM Logical Network {#hypervprivatecloud.capability.vmm.logicalnetwork}

`HyperVPrivateCloud.Capability.VMM.LogicalNetwork`

VMM logical network describing connectivity policy and associated network sites. A missing site is a configuration problem, not proof that every existing VM network packet is failing.

### Support scope

VMM management, host agents, jobs, clouds and network configuration. Cloud quota exhaustion is not necessarily physical-cluster resource exhaustion; inspect the named constrained dimension.

Element: HyperVPrivateCloud.Capability.VMM.LogicalNetwork. Kind: ClassType.

### Identity and monitoring ownership

Base class=System!System.LogicalEntity; hosted=false; singleton=false; declared properties=VMMServer, LogicalNetworkId, Name, Description, NetworkVirtualizationEnabled. Inherited properties also apply. Inspect the exact instance and its monitoring path; inventory-only classes do not acquire health merely by appearing in a diagram.

### Read-only investigation

Use the matching read-only VMM task and native Jobs/Fabric/Clouds views. Capture the failing job ID and inner error, host agent status/version, configured cloud limit and consumed value, or exact logical network/site/uplink binding. Verify the VMM Run As account and supported module runtime for query failures.

### Corrective action and escalation

Resolve the reported inner job or communication error. Coordinate agent updates with the VMM upgrade baseline. Change cloud quotas only after confirming physical headroom and tenant policy. Correct missing network sites or uplink mappings through VMM, not by ad hoc host-side changes. Do not rerun mutating failed jobs without checking partial completion.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm fresh VMM queries, expected host status, valid network bindings and quota headroom. Recent-failure monitors may remain unhealthy until their lookback window expires even after successful new jobs.

### What this object represents

VMM logical network describing connectivity policy and associated network sites. A missing site is a configuration problem, not proof that every existing VM network packet is failing.

### Microsoft references

[Microsoft Learn: troubleshoot host status errors](https://learn.microsoft.com/en-us/troubleshoot/system-center/vmm/troubleshoot-host-status-errors)

[Microsoft Learn: upgrade vmm](https://learn.microsoft.com/en-us/system-center/vmm/upgrade-vmm?view=sc-vmm-2025)

[Microsoft Learn: self service](https://learn.microsoft.com/en-us/system-center/vmm/self-service?view=sc-vmm-2025)

[Microsoft Learn: network logical](https://learn.microsoft.com/en-us/system-center/vmm/network-logical?view=sc-vmm-2025)

[Microsoft Learn: manage networks](https://learn.microsoft.com/en-us/system-center/vmm/manage-networks?view=sc-vmm-2025)


## VMM Network Site {#hypervprivatecloud.capability.vmm.networksite}

`HyperVPrivateCloud.Capability.VMM.NetworkSite`

VMM network-site definition mapping VLAN/subnet policy and host scope. Validate its intended coverage and uplink association through VMM before making host-side changes.

### Support scope

VMM management, host agents, jobs, clouds and network configuration. Cloud quota exhaustion is not necessarily physical-cluster resource exhaustion; inspect the named constrained dimension.

Element: HyperVPrivateCloud.Capability.VMM.NetworkSite. Kind: ClassType.

### Identity and monitoring ownership

Base class=System!System.LogicalEntity; hosted=false; singleton=false; declared properties=VMMServer, NetworkSiteId, LogicalNetworkId, Name, HostGroupSummary, SubnetVlanSummary. Inherited properties also apply. Inspect the exact instance and its monitoring path; inventory-only classes do not acquire health merely by appearing in a diagram.

### Read-only investigation

Use the matching read-only VMM task and native Jobs/Fabric/Clouds views. Capture the failing job ID and inner error, host agent status/version, configured cloud limit and consumed value, or exact logical network/site/uplink binding. Verify the VMM Run As account and supported module runtime for query failures.

### Corrective action and escalation

Resolve the reported inner job or communication error. Coordinate agent updates with the VMM upgrade baseline. Change cloud quotas only after confirming physical headroom and tenant policy. Correct missing network sites or uplink mappings through VMM, not by ad hoc host-side changes. Do not rerun mutating failed jobs without checking partial completion.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm fresh VMM queries, expected host status, valid network bindings and quota headroom. Recent-failure monitors may remain unhealthy until their lookback window expires even after successful new jobs.

### What this object represents

VMM network-site definition mapping VLAN/subnet policy and host scope. Validate its intended coverage and uplink association through VMM before making host-side changes.

### Microsoft references

[Microsoft Learn: troubleshoot host status errors](https://learn.microsoft.com/en-us/troubleshoot/system-center/vmm/troubleshoot-host-status-errors)

[Microsoft Learn: upgrade vmm](https://learn.microsoft.com/en-us/system-center/vmm/upgrade-vmm?view=sc-vmm-2025)

[Microsoft Learn: self service](https://learn.microsoft.com/en-us/system-center/vmm/self-service?view=sc-vmm-2025)

[Microsoft Learn: network logical](https://learn.microsoft.com/en-us/system-center/vmm/network-logical?view=sc-vmm-2025)

[Microsoft Learn: manage networks](https://learn.microsoft.com/en-us/system-center/vmm/manage-networks?view=sc-vmm-2025)


## Collect VMM private cloud processor utilisation percent {#hypervprivatecloud.capability.vmm.cloudcpuutilization.collection.rule}

`HyperVPrivateCloud.Capability.VMM.CloudCpuUtilization.Collection.Rule`

Collects performance counter data for Collect VMM private cloud processor utilisation percent into Operations Manager databases.

### Support scope

VMM management, host agents, jobs, clouds and network configuration. Cloud quota exhaustion is not necessarily physical-cluster resource exhaustion; inspect the named constrained dimension.

Element: HyperVPrivateCloud.Capability.VMM.CloudCpuUtilization.Collection.Rule. Kind: Rule.

### Alert versus health

Target=VMMDiscovery!Microsoft.SystemCenter.VirtualMachineManager.Discovery.VMMManagementServer; enabled=true; category=PerformanceCollection. Rules collect data or raise event alerts; they do not themselves create unit-monitor health transitions. Repeated or unresolved rule alerts do not by themselves explain a red DA. Correlate with current leaf monitors and event timestamps before closure.

### Read-only investigation

Use the matching read-only VMM task and native Jobs/Fabric/Clouds views. Capture the failing job ID and inner error, host agent status/version, configured cloud limit and consumed value, or exact logical network/site/uplink binding. Verify the VMM Run As account and supported module runtime for query failures.

### Corrective action and escalation

Resolve the reported inner job or communication error. Coordinate agent updates with the VMM upgrade baseline. Change cloud quotas only after confirming physical headroom and tenant policy. Correct missing network sites or uplink mappings through VMM, not by ad hoc host-side changes. Do not rerun mutating failed jobs without checking partial completion.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm fresh VMM queries, expected host status, valid network bindings and quota headroom. Recent-failure monitors may remain unhealthy until their lookback window expires even after successful new jobs.

### Microsoft references

[Microsoft Learn: troubleshoot host status errors](https://learn.microsoft.com/en-us/troubleshoot/system-center/vmm/troubleshoot-host-status-errors)

[Microsoft Learn: upgrade vmm](https://learn.microsoft.com/en-us/system-center/vmm/upgrade-vmm?view=sc-vmm-2025)

[Microsoft Learn: self service](https://learn.microsoft.com/en-us/system-center/vmm/self-service?view=sc-vmm-2025)

[Microsoft Learn: network logical](https://learn.microsoft.com/en-us/system-center/vmm/network-logical?view=sc-vmm-2025)

[Microsoft Learn: manage networks](https://learn.microsoft.com/en-us/system-center/vmm/manage-networks?view=sc-vmm-2025)


## Collect VMM private cloud memory utilisation percent {#hypervprivatecloud.capability.vmm.cloudmemoryutilization.collection.rule}

`HyperVPrivateCloud.Capability.VMM.CloudMemoryUtilization.Collection.Rule`

Collects performance counter data for Collect VMM private cloud memory utilisation percent into Operations Manager databases.

### Support scope

VMM management, host agents, jobs, clouds and network configuration. Cloud quota exhaustion is not necessarily physical-cluster resource exhaustion; inspect the named constrained dimension.

Element: HyperVPrivateCloud.Capability.VMM.CloudMemoryUtilization.Collection.Rule. Kind: Rule.

### Alert versus health

Target=VMMDiscovery!Microsoft.SystemCenter.VirtualMachineManager.Discovery.VMMManagementServer; enabled=true; category=PerformanceCollection. Rules collect data or raise event alerts; they do not themselves create unit-monitor health transitions. Repeated or unresolved rule alerts do not by themselves explain a red DA. Correlate with current leaf monitors and event timestamps before closure.

### Read-only investigation

Use the matching read-only VMM task and native Jobs/Fabric/Clouds views. Capture the failing job ID and inner error, host agent status/version, configured cloud limit and consumed value, or exact logical network/site/uplink binding. Verify the VMM Run As account and supported module runtime for query failures.

### Corrective action and escalation

Resolve the reported inner job or communication error. Coordinate agent updates with the VMM upgrade baseline. Change cloud quotas only after confirming physical headroom and tenant policy. Correct missing network sites or uplink mappings through VMM, not by ad hoc host-side changes. Do not rerun mutating failed jobs without checking partial completion.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm fresh VMM queries, expected host status, valid network bindings and quota headroom. Recent-failure monitors may remain unhealthy until their lookback window expires even after successful new jobs.

### Microsoft references

[Microsoft Learn: troubleshoot host status errors](https://learn.microsoft.com/en-us/troubleshoot/system-center/vmm/troubleshoot-host-status-errors)

[Microsoft Learn: upgrade vmm](https://learn.microsoft.com/en-us/system-center/vmm/upgrade-vmm?view=sc-vmm-2025)

[Microsoft Learn: self service](https://learn.microsoft.com/en-us/system-center/vmm/self-service?view=sc-vmm-2025)

[Microsoft Learn: network logical](https://learn.microsoft.com/en-us/system-center/vmm/network-logical?view=sc-vmm-2025)

[Microsoft Learn: manage networks](https://learn.microsoft.com/en-us/system-center/vmm/manage-networks?view=sc-vmm-2025)


## Collect VMM private cloud storage utilisation percent {#hypervprivatecloud.capability.vmm.cloudstorageutilization.collection.rule}

`HyperVPrivateCloud.Capability.VMM.CloudStorageUtilization.Collection.Rule`

Collects performance counter data for Collect VMM private cloud storage utilisation percent into Operations Manager databases.

### Support scope

VMM management, host agents, jobs, clouds and network configuration. Cloud quota exhaustion is not necessarily physical-cluster resource exhaustion; inspect the named constrained dimension.

Element: HyperVPrivateCloud.Capability.VMM.CloudStorageUtilization.Collection.Rule. Kind: Rule.

### Alert versus health

Target=VMMDiscovery!Microsoft.SystemCenter.VirtualMachineManager.Discovery.VMMManagementServer; enabled=true; category=PerformanceCollection. Rules collect data or raise event alerts; they do not themselves create unit-monitor health transitions. Repeated or unresolved rule alerts do not by themselves explain a red DA. Correlate with current leaf monitors and event timestamps before closure.

### Read-only investigation

Use the matching read-only VMM task and native Jobs/Fabric/Clouds views. Capture the failing job ID and inner error, host agent status/version, configured cloud limit and consumed value, or exact logical network/site/uplink binding. Verify the VMM Run As account and supported module runtime for query failures.

### Corrective action and escalation

Resolve the reported inner job or communication error. Coordinate agent updates with the VMM upgrade baseline. Change cloud quotas only after confirming physical headroom and tenant policy. Correct missing network sites or uplink mappings through VMM, not by ad hoc host-side changes. Do not rerun mutating failed jobs without checking partial completion.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm fresh VMM queries, expected host status, valid network bindings and quota headroom. Recent-failure monitors may remain unhealthy until their lookback window expires even after successful new jobs.

### Microsoft references

[Microsoft Learn: troubleshoot host status errors](https://learn.microsoft.com/en-us/troubleshoot/system-center/vmm/troubleshoot-host-status-errors)

[Microsoft Learn: upgrade vmm](https://learn.microsoft.com/en-us/system-center/vmm/upgrade-vmm?view=sc-vmm-2025)

[Microsoft Learn: self service](https://learn.microsoft.com/en-us/system-center/vmm/self-service?view=sc-vmm-2025)

[Microsoft Learn: network logical](https://learn.microsoft.com/en-us/system-center/vmm/network-logical?view=sc-vmm-2025)

[Microsoft Learn: manage networks](https://learn.microsoft.com/en-us/system-center/vmm/manage-networks?view=sc-vmm-2025)


## Collect VMM host group processor utilisation percent {#hypervprivatecloud.capability.vmm.hostgroupcpuutilization.collection.rule}

`HyperVPrivateCloud.Capability.VMM.HostGroupCpuUtilization.Collection.Rule`

Collects performance counter data for Collect VMM host group processor utilisation percent into Operations Manager databases.

### Support scope

VMM management, host agents, jobs, clouds and network configuration. Cloud quota exhaustion is not necessarily physical-cluster resource exhaustion; inspect the named constrained dimension.

Element: HyperVPrivateCloud.Capability.VMM.HostGroupCpuUtilization.Collection.Rule. Kind: Rule.

### Alert versus health

Target=VMMDiscovery!Microsoft.SystemCenter.VirtualMachineManager.Discovery.VMMManagementServer; enabled=true; category=PerformanceCollection. Rules collect data or raise event alerts; they do not themselves create unit-monitor health transitions. Repeated or unresolved rule alerts do not by themselves explain a red DA. Correlate with current leaf monitors and event timestamps before closure.

### Read-only investigation

Use the matching read-only VMM task and native Jobs/Fabric/Clouds views. Capture the failing job ID and inner error, host agent status/version, configured cloud limit and consumed value, or exact logical network/site/uplink binding. Verify the VMM Run As account and supported module runtime for query failures.

### Corrective action and escalation

Resolve the reported inner job or communication error. Coordinate agent updates with the VMM upgrade baseline. Change cloud quotas only after confirming physical headroom and tenant policy. Correct missing network sites or uplink mappings through VMM, not by ad hoc host-side changes. Do not rerun mutating failed jobs without checking partial completion.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm fresh VMM queries, expected host status, valid network bindings and quota headroom. Recent-failure monitors may remain unhealthy until their lookback window expires even after successful new jobs.

### Microsoft references

[Microsoft Learn: troubleshoot host status errors](https://learn.microsoft.com/en-us/troubleshoot/system-center/vmm/troubleshoot-host-status-errors)

[Microsoft Learn: upgrade vmm](https://learn.microsoft.com/en-us/system-center/vmm/upgrade-vmm?view=sc-vmm-2025)

[Microsoft Learn: self service](https://learn.microsoft.com/en-us/system-center/vmm/self-service?view=sc-vmm-2025)

[Microsoft Learn: network logical](https://learn.microsoft.com/en-us/system-center/vmm/network-logical?view=sc-vmm-2025)

[Microsoft Learn: manage networks](https://learn.microsoft.com/en-us/system-center/vmm/manage-networks?view=sc-vmm-2025)


## Collect VMM host group memory utilisation percent {#hypervprivatecloud.capability.vmm.hostgroupmemoryutilization.collection.rule}

`HyperVPrivateCloud.Capability.VMM.HostGroupMemoryUtilization.Collection.Rule`

Collects performance counter data for Collect VMM host group memory utilisation percent into Operations Manager databases.

### Support scope

VMM management, host agents, jobs, clouds and network configuration. Cloud quota exhaustion is not necessarily physical-cluster resource exhaustion; inspect the named constrained dimension.

Element: HyperVPrivateCloud.Capability.VMM.HostGroupMemoryUtilization.Collection.Rule. Kind: Rule.

### Alert versus health

Target=VMMDiscovery!Microsoft.SystemCenter.VirtualMachineManager.Discovery.VMMManagementServer; enabled=true; category=PerformanceCollection. Rules collect data or raise event alerts; they do not themselves create unit-monitor health transitions. Repeated or unresolved rule alerts do not by themselves explain a red DA. Correlate with current leaf monitors and event timestamps before closure.

### Read-only investigation

Use the matching read-only VMM task and native Jobs/Fabric/Clouds views. Capture the failing job ID and inner error, host agent status/version, configured cloud limit and consumed value, or exact logical network/site/uplink binding. Verify the VMM Run As account and supported module runtime for query failures.

### Corrective action and escalation

Resolve the reported inner job or communication error. Coordinate agent updates with the VMM upgrade baseline. Change cloud quotas only after confirming physical headroom and tenant policy. Correct missing network sites or uplink mappings through VMM, not by ad hoc host-side changes. Do not rerun mutating failed jobs without checking partial completion.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm fresh VMM queries, expected host status, valid network bindings and quota headroom. Recent-failure monitors may remain unhealthy until their lookback window expires even after successful new jobs.

### Microsoft references

[Microsoft Learn: troubleshoot host status errors](https://learn.microsoft.com/en-us/troubleshoot/system-center/vmm/troubleshoot-host-status-errors)

[Microsoft Learn: upgrade vmm](https://learn.microsoft.com/en-us/system-center/vmm/upgrade-vmm?view=sc-vmm-2025)

[Microsoft Learn: self service](https://learn.microsoft.com/en-us/system-center/vmm/self-service?view=sc-vmm-2025)

[Microsoft Learn: network logical](https://learn.microsoft.com/en-us/system-center/vmm/network-logical?view=sc-vmm-2025)

[Microsoft Learn: manage networks](https://learn.microsoft.com/en-us/system-center/vmm/manage-networks?view=sc-vmm-2025)


## Collect VMM host group storage utilisation percent {#hypervprivatecloud.capability.vmm.hostgroupstorageutilization.collection.rule}

`HyperVPrivateCloud.Capability.VMM.HostGroupStorageUtilization.Collection.Rule`

Collects performance counter data for Collect VMM host group storage utilisation percent into Operations Manager databases.

### Support scope

VMM management, host agents, jobs, clouds and network configuration. Cloud quota exhaustion is not necessarily physical-cluster resource exhaustion; inspect the named constrained dimension.

Element: HyperVPrivateCloud.Capability.VMM.HostGroupStorageUtilization.Collection.Rule. Kind: Rule.

### Alert versus health

Target=VMMDiscovery!Microsoft.SystemCenter.VirtualMachineManager.Discovery.VMMManagementServer; enabled=true; category=PerformanceCollection. Rules collect data or raise event alerts; they do not themselves create unit-monitor health transitions. Repeated or unresolved rule alerts do not by themselves explain a red DA. Correlate with current leaf monitors and event timestamps before closure.

### Read-only investigation

Use the matching read-only VMM task and native Jobs/Fabric/Clouds views. Capture the failing job ID and inner error, host agent status/version, configured cloud limit and consumed value, or exact logical network/site/uplink binding. Verify the VMM Run As account and supported module runtime for query failures.

### Corrective action and escalation

Resolve the reported inner job or communication error. Coordinate agent updates with the VMM upgrade baseline. Change cloud quotas only after confirming physical headroom and tenant policy. Correct missing network sites or uplink mappings through VMM, not by ad hoc host-side changes. Do not rerun mutating failed jobs without checking partial completion.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm fresh VMM queries, expected host status, valid network bindings and quota headroom. Recent-failure monitors may remain unhealthy until their lookback window expires even after successful new jobs.

### Microsoft references

[Microsoft Learn: troubleshoot host status errors](https://learn.microsoft.com/en-us/troubleshoot/system-center/vmm/troubleshoot-host-status-errors)

[Microsoft Learn: upgrade vmm](https://learn.microsoft.com/en-us/system-center/vmm/upgrade-vmm?view=sc-vmm-2025)

[Microsoft Learn: self service](https://learn.microsoft.com/en-us/system-center/vmm/self-service?view=sc-vmm-2025)

[Microsoft Learn: network logical](https://learn.microsoft.com/en-us/system-center/vmm/network-logical?view=sc-vmm-2025)

[Microsoft Learn: manage networks](https://learn.microsoft.com/en-us/system-center/vmm/manage-networks?view=sc-vmm-2025)


## Show failed VMM jobs {#hypervprivatecloud.capability.vmm.failedjobs.task}

`HyperVPrivateCloud.Capability.VMM.FailedJobs.Task`

Get-SCJob failures in the last N hours (Parameter, default 24) with error text.

### Summary

Show failed VMM jobs

### What it runs

Get-SCJob failures in the last N hours (Parameter, default 24) with error text.

### Impact

Read-only. The task runs the query on the agent and returns text; it changes nothing.

### Support scope

VMM management, host agents, jobs, clouds and network configuration. Cloud quota exhaustion is not necessarily physical-cluster resource exhaustion; inspect the named constrained dimension.

Element: HyperVPrivateCloud.Capability.VMM.FailedJobs.Task. Kind: Task.

### Execution safety

Target=VMMDiscovery!Microsoft.SystemCenter.VirtualMachineManager.Discovery.VMMManagementServer; enabled=true; timeout=300. Read the task&#39;s original knowledge and parameters before execution. A Remediation task changes state and requires approval; do not execute it solely because the object is red. Even a diagnostic can generate logs or files; review its documented impact.

### Read-only investigation

Use the matching read-only VMM task and native Jobs/Fabric/Clouds views. Capture the failing job ID and inner error, host agent status/version, configured cloud limit and consumed value, or exact logical network/site/uplink binding. Verify the VMM Run As account and supported module runtime for query failures.

### Corrective action and escalation

Resolve the reported inner job or communication error. Coordinate agent updates with the VMM upgrade baseline. Change cloud quotas only after confirming physical headroom and tenant policy. Correct missing network sites or uplink mappings through VMM, not by ad hoc host-side changes. Do not rerun mutating failed jobs without checking partial completion.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm fresh VMM queries, expected host status, valid network bindings and quota headroom. Recent-failure monitors may remain unhealthy until their lookback window expires even after successful new jobs.

### Microsoft references

[Microsoft Learn: troubleshoot host status errors](https://learn.microsoft.com/en-us/troubleshoot/system-center/vmm/troubleshoot-host-status-errors)

[Microsoft Learn: upgrade vmm](https://learn.microsoft.com/en-us/system-center/vmm/upgrade-vmm?view=sc-vmm-2025)

[Microsoft Learn: self service](https://learn.microsoft.com/en-us/system-center/vmm/self-service?view=sc-vmm-2025)

[Microsoft Learn: network logical](https://learn.microsoft.com/en-us/system-center/vmm/network-logical?view=sc-vmm-2025)

[Microsoft Learn: manage networks](https://learn.microsoft.com/en-us/system-center/vmm/manage-networks?view=sc-vmm-2025)


## Show VMM host status {#hypervprivatecloud.capability.vmm.hoststatus.task}

`HyperVPrivateCloud.Capability.VMM.HostStatus.Task`

Overall and communication state, maintenance mode, host group, agent and Hyper-V versions and CPU usage per host.

### Summary

Show VMM host status

### What it runs

Overall and communication state, maintenance mode, host group, agent and Hyper-V versions and CPU usage per host.

### Impact

Read-only. The task runs the query on the agent and returns text; it changes nothing.

### Support scope

VMM management, host agents, jobs, clouds and network configuration. Cloud quota exhaustion is not necessarily physical-cluster resource exhaustion; inspect the named constrained dimension.

Element: HyperVPrivateCloud.Capability.VMM.HostStatus.Task. Kind: Task.

### Execution safety

Target=VMMDiscovery!Microsoft.SystemCenter.VirtualMachineManager.Discovery.VMMManagementServer; enabled=true; timeout=300. Read the task&#39;s original knowledge and parameters before execution. A Remediation task changes state and requires approval; do not execute it solely because the object is red. Even a diagnostic can generate logs or files; review its documented impact.

### Read-only investigation

Use the matching read-only VMM task and native Jobs/Fabric/Clouds views. Capture the failing job ID and inner error, host agent status/version, configured cloud limit and consumed value, or exact logical network/site/uplink binding. Verify the VMM Run As account and supported module runtime for query failures.

### Corrective action and escalation

Resolve the reported inner job or communication error. Coordinate agent updates with the VMM upgrade baseline. Change cloud quotas only after confirming physical headroom and tenant policy. Correct missing network sites or uplink mappings through VMM, not by ad hoc host-side changes. Do not rerun mutating failed jobs without checking partial completion.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm fresh VMM queries, expected host status, valid network bindings and quota headroom. Recent-failure monitors may remain unhealthy until their lookback window expires even after successful new jobs.

### Microsoft references

[Microsoft Learn: troubleshoot host status errors](https://learn.microsoft.com/en-us/troubleshoot/system-center/vmm/troubleshoot-host-status-errors)

[Microsoft Learn: upgrade vmm](https://learn.microsoft.com/en-us/system-center/vmm/upgrade-vmm?view=sc-vmm-2025)

[Microsoft Learn: self service](https://learn.microsoft.com/en-us/system-center/vmm/self-service?view=sc-vmm-2025)

[Microsoft Learn: network logical](https://learn.microsoft.com/en-us/system-center/vmm/network-logical?view=sc-vmm-2025)

[Microsoft Learn: manage networks](https://learn.microsoft.com/en-us/system-center/vmm/manage-networks?view=sc-vmm-2025)


## Show VMM server and agent versions {#hypervprivatecloud.capability.vmm.agentversions.task}

`HyperVPrivateCloud.Capability.VMM.AgentVersions.Task`

Server product version and hosts grouped by agent version.

### Summary

Show VMM server and agent versions

### What it runs

Server product version and hosts grouped by agent version.

### Impact

Read-only. The task runs the query on the agent and returns text; it changes nothing.

### Support scope

VMM management, host agents, jobs, clouds and network configuration. Cloud quota exhaustion is not necessarily physical-cluster resource exhaustion; inspect the named constrained dimension.

Element: HyperVPrivateCloud.Capability.VMM.AgentVersions.Task. Kind: Task.

### Execution safety

Target=VMMDiscovery!Microsoft.SystemCenter.VirtualMachineManager.Discovery.VMMManagementServer; enabled=true; timeout=300. Read the task&#39;s original knowledge and parameters before execution. A Remediation task changes state and requires approval; do not execute it solely because the object is red. Even a diagnostic can generate logs or files; review its documented impact.

### Read-only investigation

Use the matching read-only VMM task and native Jobs/Fabric/Clouds views. Capture the failing job ID and inner error, host agent status/version, configured cloud limit and consumed value, or exact logical network/site/uplink binding. Verify the VMM Run As account and supported module runtime for query failures.

### Corrective action and escalation

Resolve the reported inner job or communication error. Coordinate agent updates with the VMM upgrade baseline. Change cloud quotas only after confirming physical headroom and tenant policy. Correct missing network sites or uplink mappings through VMM, not by ad hoc host-side changes. Do not rerun mutating failed jobs without checking partial completion.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm fresh VMM queries, expected host status, valid network bindings and quota headroom. Recent-failure monitors may remain unhealthy until their lookback window expires even after successful new jobs.

### Microsoft references

[Microsoft Learn: troubleshoot host status errors](https://learn.microsoft.com/en-us/troubleshoot/system-center/vmm/troubleshoot-host-status-errors)

[Microsoft Learn: upgrade vmm](https://learn.microsoft.com/en-us/system-center/vmm/upgrade-vmm?view=sc-vmm-2025)

[Microsoft Learn: self service](https://learn.microsoft.com/en-us/system-center/vmm/self-service?view=sc-vmm-2025)

[Microsoft Learn: network logical](https://learn.microsoft.com/en-us/system-center/vmm/network-logical?view=sc-vmm-2025)

[Microsoft Learn: manage networks](https://learn.microsoft.com/en-us/system-center/vmm/manage-networks?view=sc-vmm-2025)


## Show VMM library servers and shares {#hypervprivatecloud.capability.vmm.librarystatus.task}

`HyperVPrivateCloud.Capability.VMM.LibraryStatus.Task`

Library server status and agent versions, plus share paths and their owning library servers. Share inventory does not establish placement eligibility.

### Summary

Show VMM library servers and shares

### What it runs

Library server status and agent versions, plus share paths and their owning library servers. Share inventory does not establish placement eligibility.

### Impact

Read-only. The task runs the query on the agent and returns text; it changes nothing.

### Support scope

VMM management, host agents, jobs, clouds and network configuration. Cloud quota exhaustion is not necessarily physical-cluster resource exhaustion; inspect the named constrained dimension.

Element: HyperVPrivateCloud.Capability.VMM.LibraryStatus.Task. Kind: Task.

### Execution safety

Target=VMMDiscovery!Microsoft.SystemCenter.VirtualMachineManager.Discovery.VMMManagementServer; enabled=true; timeout=300. Read the task&#39;s original knowledge and parameters before execution. A Remediation task changes state and requires approval; do not execute it solely because the object is red. Even a diagnostic can generate logs or files; review its documented impact.

### Read-only investigation

Use the matching read-only VMM task and native Jobs/Fabric/Clouds views. Capture the failing job ID and inner error, host agent status/version, configured cloud limit and consumed value, or exact logical network/site/uplink binding. Verify the VMM Run As account and supported module runtime for query failures.

### Corrective action and escalation

Resolve the reported inner job or communication error. Coordinate agent updates with the VMM upgrade baseline. Change cloud quotas only after confirming physical headroom and tenant policy. Correct missing network sites or uplink mappings through VMM, not by ad hoc host-side changes. Do not rerun mutating failed jobs without checking partial completion.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm fresh VMM queries, expected host status, valid network bindings and quota headroom. Recent-failure monitors may remain unhealthy until their lookback window expires even after successful new jobs.

### Microsoft references

[Microsoft Learn: troubleshoot host status errors](https://learn.microsoft.com/en-us/troubleshoot/system-center/vmm/troubleshoot-host-status-errors)

[Microsoft Learn: upgrade vmm](https://learn.microsoft.com/en-us/system-center/vmm/upgrade-vmm?view=sc-vmm-2025)

[Microsoft Learn: self service](https://learn.microsoft.com/en-us/system-center/vmm/self-service?view=sc-vmm-2025)

[Microsoft Learn: network logical](https://learn.microsoft.com/en-us/system-center/vmm/network-logical?view=sc-vmm-2025)

[Microsoft Learn: manage networks](https://learn.microsoft.com/en-us/system-center/vmm/manage-networks?view=sc-vmm-2025)


## Remediation: Refresh a host in VMM {#hypervprivatecloud.capability.vmm.refreshhost.task}

`HyperVPrivateCloud.Capability.VMM.RefreshHost.Task`

Read-SCVMHost. Parameter = host name as known to VMM.

### Summary

Refresh a host in VMM

### What it runs

Read-SCVMHost. Parameter = host name as known to VMM.

### Impact

This task changes the state of the target. The console asks for confirmation before it runs; use the read-only tasks first to confirm the diagnosis, and run it inside a change window where the environment requires one. The task output reports the resulting state.

### Support scope

VMM management, host agents, jobs, clouds and network configuration. Cloud quota exhaustion is not necessarily physical-cluster resource exhaustion; inspect the named constrained dimension.

Element: HyperVPrivateCloud.Capability.VMM.RefreshHost.Task. Kind: Task.

### Execution safety

Target=VMMDiscovery!Microsoft.SystemCenter.VirtualMachineManager.Discovery.VMMManagementServer; enabled=true; timeout=300. Read the task&#39;s original knowledge and parameters before execution. A Remediation task changes state and requires approval; do not execute it solely because the object is red. Even a diagnostic can generate logs or files; review its documented impact.

### Read-only investigation

Use the matching read-only VMM task and native Jobs/Fabric/Clouds views. Capture the failing job ID and inner error, host agent status/version, configured cloud limit and consumed value, or exact logical network/site/uplink binding. Verify the VMM Run As account and supported module runtime for query failures.

### Corrective action and escalation

Resolve the reported inner job or communication error. Coordinate agent updates with the VMM upgrade baseline. Change cloud quotas only after confirming physical headroom and tenant policy. Correct missing network sites or uplink mappings through VMM, not by ad hoc host-side changes. Do not rerun mutating failed jobs without checking partial completion.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm fresh VMM queries, expected host status, valid network bindings and quota headroom. Recent-failure monitors may remain unhealthy until their lookback window expires even after successful new jobs.

### Microsoft references

[Microsoft Learn: troubleshoot host status errors](https://learn.microsoft.com/en-us/troubleshoot/system-center/vmm/troubleshoot-host-status-errors)

[Microsoft Learn: upgrade vmm](https://learn.microsoft.com/en-us/system-center/vmm/upgrade-vmm?view=sc-vmm-2025)

[Microsoft Learn: self service](https://learn.microsoft.com/en-us/system-center/vmm/self-service?view=sc-vmm-2025)

[Microsoft Learn: network logical](https://learn.microsoft.com/en-us/system-center/vmm/network-logical?view=sc-vmm-2025)

[Microsoft Learn: manage networks](https://learn.microsoft.com/en-us/system-center/vmm/manage-networks?view=sc-vmm-2025)


## VMM integration and topology-query health {#hypervprivatecloud.capability.vmm.integrationhealth.monitor}

`HyperVPrivateCloud.Capability.VMM.IntegrationHealth.Monitor`

Validates the VMM module, read-only connection, logical-network, network-site, and VM-network queries.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.ManagementStack.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.ManagementStack.Management.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.VMM.Management.Server.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.VMM.IntegrationHealth.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

Validates access to the matching VMM PowerShell module and read-only fabric queries used for HCS logical-network and network-site projections. Microsoft VMM Management Packs remain authoritative for their published fabric objects, monitors, alerts, performance, and dashboards.

### Operator response

Confirm that VMM and Operations Manager integration is healthy, the matching VMM console is installed on the VMM server, and the Microsoft VMM Server Connection Run As profile uses an account with at least Read-Only Administrator scope across the monitored fabric. This workflow is read-only.

### Support scope

VMM management, host agents, jobs, clouds and network configuration. Cloud quota exhaustion is not necessarily physical-cluster resource exhaustion; inspect the named constrained dimension.

Element: HyperVPrivateCloud.Capability.VMM.IntegrationHealth.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: VMMDiscovery!Microsoft.SystemCenter.VirtualMachineManager.Discovery.VMMManagementServer. Parent health aspect: Health!System.Health.AvailabilityState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: Property[@Name=&#39;VmmIntegrationState&#39;] = Good

Warning [Warning]: Property[@Name=&#39;VmmIntegrationState&#39;] = Warning

Error [Critical]: Property[@Name=&#39;VmmIntegrationState&#39;] = Critical

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: ComputerName=$Target/Host/Property[Type=&quot;Windows!Microsoft.Windows.Computer&quot;]/PrincipalName$; FailedJobCriticalCount=1; IntervalSeconds=300; JobLookbackHours=24; PropertyName=VmmIntegrationState; SyncTime=; TimeoutSeconds=240 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Error; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Use the matching read-only VMM task and native Jobs/Fabric/Clouds views. Capture the failing job ID and inner error, host agent status/version, configured cloud limit and consumed value, or exact logical network/site/uplink binding. Verify the VMM Run As account and supported module runtime for query failures.

### Corrective action and escalation

Resolve the reported inner job or communication error. Coordinate agent updates with the VMM upgrade baseline. Change cloud quotas only after confirming physical headroom and tenant policy. Correct missing network sites or uplink mappings through VMM, not by ad hoc host-side changes. Do not rerun mutating failed jobs without checking partial completion.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm fresh VMM queries, expected host status, valid network bindings and quota headroom. Recent-failure monitors may remain unhealthy until their lookback window expires even after successful new jobs.

### Microsoft references

[Microsoft Learn: troubleshoot host status errors](https://learn.microsoft.com/en-us/troubleshoot/system-center/vmm/troubleshoot-host-status-errors)

[Microsoft Learn: upgrade vmm](https://learn.microsoft.com/en-us/system-center/vmm/upgrade-vmm?view=sc-vmm-2025)

[Microsoft Learn: self service](https://learn.microsoft.com/en-us/system-center/vmm/self-service?view=sc-vmm-2025)

[Microsoft Learn: network logical](https://learn.microsoft.com/en-us/system-center/vmm/network-logical?view=sc-vmm-2025)

[Microsoft Learn: manage networks](https://learn.microsoft.com/en-us/system-center/vmm/manage-networks?view=sc-vmm-2025)


## Recent failed VMM jobs {#hypervprivatecloud.capability.vmm.failedjobs.monitor}

`HyperVPrivateCloud.Capability.VMM.FailedJobs.Monitor`

Tracks VMM jobs with Failed status during the configured lookback period.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.ManagementStack.Configuration.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.ManagementStack.Management.Configuration.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.VMM.Management.Server.Configuration.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.VMM.FailedJobs.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

Queries recent VMM jobs with Get-SCJob and changes health when one or more jobs have Failed status within the configured lookback period.

### Operator response

Open the Jobs workspace in the VMM console, inspect the failed step and error code for each listed job, correct the underlying fabric or configuration issue, and rerun the operation only when safe. The monitor performs no restart, retry, or remediation.

### Support scope

VMM management, host agents, jobs, clouds and network configuration. Cloud quota exhaustion is not necessarily physical-cluster resource exhaustion; inspect the named constrained dimension.

Element: HyperVPrivateCloud.Capability.VMM.FailedJobs.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: VMMDiscovery!Microsoft.SystemCenter.VirtualMachineManager.Discovery.VMMManagementServer. Parent health aspect: Health!System.Health.ConfigurationState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: Property[@Name=&#39;FailedJobState&#39;] = Good

Warning [Warning]: Property[@Name=&#39;FailedJobState&#39;] = Warning

Error [Critical]: Property[@Name=&#39;FailedJobState&#39;] = Critical

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: ComputerName=$Target/Host/Property[Type=&quot;Windows!Microsoft.Windows.Computer&quot;]/PrincipalName$; FailedJobCriticalCount=1; IntervalSeconds=300; JobLookbackHours=24; PropertyName=FailedJobState; SyncTime=; TimeoutSeconds=240 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Warning; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Use the matching read-only VMM task and native Jobs/Fabric/Clouds views. Capture the failing job ID and inner error, host agent status/version, configured cloud limit and consumed value, or exact logical network/site/uplink binding. Verify the VMM Run As account and supported module runtime for query failures.

### Corrective action and escalation

Resolve the reported inner job or communication error. Coordinate agent updates with the VMM upgrade baseline. Change cloud quotas only after confirming physical headroom and tenant policy. Correct missing network sites or uplink mappings through VMM, not by ad hoc host-side changes. Do not rerun mutating failed jobs without checking partial completion.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm fresh VMM queries, expected host status, valid network bindings and quota headroom. Recent-failure monitors may remain unhealthy until their lookback window expires even after successful new jobs.

### Microsoft references

[Microsoft Learn: troubleshoot host status errors](https://learn.microsoft.com/en-us/troubleshoot/system-center/vmm/troubleshoot-host-status-errors)

[Microsoft Learn: upgrade vmm](https://learn.microsoft.com/en-us/system-center/vmm/upgrade-vmm?view=sc-vmm-2025)

[Microsoft Learn: self service](https://learn.microsoft.com/en-us/system-center/vmm/self-service?view=sc-vmm-2025)

[Microsoft Learn: network logical](https://learn.microsoft.com/en-us/system-center/vmm/network-logical?view=sc-vmm-2025)

[Microsoft Learn: manage networks](https://learn.microsoft.com/en-us/system-center/vmm/manage-networks?view=sc-vmm-2025)


## VMM management service and agent health {#hypervprivatecloud.capability.vmm.managementservicehealth.monitor}

`HyperVPrivateCloud.Capability.VMM.ManagementServiceHealth.Monitor`

Monitors operational health, status, and thresholds for VMM management service and agent health.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.ManagementStack.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.ManagementStack.Management.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.VMM.Management.Server.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.VMM.ManagementServiceHealth.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

Confirms that the VMM management service and the local VMM agent are running on the management server and that the server accepts a read-only VMM connection.

### Operator response

Start the scvmmservice and scvmmagent services, review their dependencies and service account, and inspect recent VMM server events. This monitor never starts or restarts a service.

### Support scope

VMM management, host agents, jobs, clouds and network configuration. Cloud quota exhaustion is not necessarily physical-cluster resource exhaustion; inspect the named constrained dimension.

Element: HyperVPrivateCloud.Capability.VMM.ManagementServiceHealth.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: VMMDiscovery!Microsoft.SystemCenter.VirtualMachineManager.Discovery.VMMManagementServer. Parent health aspect: Health!System.Health.AvailabilityState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: (Property[@Name=&#39;ManagementServiceState&#39;] = Good OR Property[@Name=&#39;ManagementServiceState&#39;] = NotApplicable)

Warning [Warning]: Property[@Name=&#39;ManagementServiceState&#39;] = Warning

Error [Critical]: Property[@Name=&#39;ManagementServiceState&#39;] = Critical

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: ComputerName=$Target/Host/Property[Type=&quot;Windows!Microsoft.Windows.Computer&quot;]/PrincipalName$; CriticalCpuPercent=90; CriticalJobFailurePercent=25; CriticalMemoryPercent=92; CriticalProTipCount=5; CriticalStoragePercent=90; IntervalSeconds=300; JobLookbackHours=24; MaxAgentVersionDriftCount=0; MinimumJobSampleCount=5; PropertyName=ManagementServiceState; RequireVmNetworkBinding=true; SyncTime=; TimeoutSeconds=240; WarningCpuPercent=75; WarningJobFailurePercent=10; WarningMemoryPercent=80; WarningProTipCount=1; WarningStoragePercent=80 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Error; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Use the matching read-only VMM task and native Jobs/Fabric/Clouds views. Capture the failing job ID and inner error, host agent status/version, configured cloud limit and consumed value, or exact logical network/site/uplink binding. Verify the VMM Run As account and supported module runtime for query failures.

### Corrective action and escalation

Resolve the reported inner job or communication error. Coordinate agent updates with the VMM upgrade baseline. Change cloud quotas only after confirming physical headroom and tenant policy. Correct missing network sites or uplink mappings through VMM, not by ad hoc host-side changes. Do not rerun mutating failed jobs without checking partial completion.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm fresh VMM queries, expected host status, valid network bindings and quota headroom. Recent-failure monitors may remain unhealthy until their lookback window expires even after successful new jobs.

### Microsoft references

[Microsoft Learn: troubleshoot host status errors](https://learn.microsoft.com/en-us/troubleshoot/system-center/vmm/troubleshoot-host-status-errors)

[Microsoft Learn: upgrade vmm](https://learn.microsoft.com/en-us/system-center/vmm/upgrade-vmm?view=sc-vmm-2025)

[Microsoft Learn: self service](https://learn.microsoft.com/en-us/system-center/vmm/self-service?view=sc-vmm-2025)

[Microsoft Learn: network logical](https://learn.microsoft.com/en-us/system-center/vmm/network-logical?view=sc-vmm-2025)

[Microsoft Learn: manage networks](https://learn.microsoft.com/en-us/system-center/vmm/manage-networks?view=sc-vmm-2025)


## VMM host agent communication state {#hypervprivatecloud.capability.vmm.agentcommunication.monitor}

`HyperVPrivateCloud.Capability.VMM.AgentCommunication.Monitor`

Monitors operational health, status, and thresholds for VMM host agent communication state.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.ManagementStack.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.ManagementStack.Management.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.VMM.Management.Server.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.VMM.AgentCommunication.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

Reads the communication state and overall state of every VMM-managed host. A host that is not responding is Critical; a degraded overall state is Warning.

### Operator response

Check WinRM, name resolution, certificates, the host agent service, and the VMM Run As account, then refresh the host in the VMM console.

### Support scope

VMM management, host agents, jobs, clouds and network configuration. Cloud quota exhaustion is not necessarily physical-cluster resource exhaustion; inspect the named constrained dimension.

Element: HyperVPrivateCloud.Capability.VMM.AgentCommunication.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: VMMDiscovery!Microsoft.SystemCenter.VirtualMachineManager.Discovery.VMMManagementServer. Parent health aspect: Health!System.Health.AvailabilityState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: (Property[@Name=&#39;AgentCommunicationState&#39;] = Good OR Property[@Name=&#39;AgentCommunicationState&#39;] = NotApplicable)

Warning [Warning]: Property[@Name=&#39;AgentCommunicationState&#39;] = Warning

Error [Critical]: Property[@Name=&#39;AgentCommunicationState&#39;] = Critical

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: ComputerName=$Target/Host/Property[Type=&quot;Windows!Microsoft.Windows.Computer&quot;]/PrincipalName$; CriticalCpuPercent=90; CriticalJobFailurePercent=25; CriticalMemoryPercent=92; CriticalProTipCount=5; CriticalStoragePercent=90; IntervalSeconds=300; JobLookbackHours=24; MaxAgentVersionDriftCount=0; MinimumJobSampleCount=5; PropertyName=AgentCommunicationState; RequireVmNetworkBinding=true; SyncTime=; TimeoutSeconds=240; WarningCpuPercent=75; WarningJobFailurePercent=10; WarningMemoryPercent=80; WarningProTipCount=1; WarningStoragePercent=80 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Error; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Use the matching read-only VMM task and native Jobs/Fabric/Clouds views. Capture the failing job ID and inner error, host agent status/version, configured cloud limit and consumed value, or exact logical network/site/uplink binding. Verify the VMM Run As account and supported module runtime for query failures.

### Corrective action and escalation

Resolve the reported inner job or communication error. Coordinate agent updates with the VMM upgrade baseline. Change cloud quotas only after confirming physical headroom and tenant policy. Correct missing network sites or uplink mappings through VMM, not by ad hoc host-side changes. Do not rerun mutating failed jobs without checking partial completion.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm fresh VMM queries, expected host status, valid network bindings and quota headroom. Recent-failure monitors may remain unhealthy until their lookback window expires even after successful new jobs.

### Microsoft references

[Microsoft Learn: troubleshoot host status errors](https://learn.microsoft.com/en-us/troubleshoot/system-center/vmm/troubleshoot-host-status-errors)

[Microsoft Learn: upgrade vmm](https://learn.microsoft.com/en-us/system-center/vmm/upgrade-vmm?view=sc-vmm-2025)

[Microsoft Learn: self service](https://learn.microsoft.com/en-us/system-center/vmm/self-service?view=sc-vmm-2025)

[Microsoft Learn: network logical](https://learn.microsoft.com/en-us/system-center/vmm/network-logical?view=sc-vmm-2025)

[Microsoft Learn: manage networks](https://learn.microsoft.com/en-us/system-center/vmm/manage-networks?view=sc-vmm-2025)


## VMM host agent version drift {#hypervprivatecloud.capability.vmm.agentversiondrift.monitor}

`HyperVPrivateCloud.Capability.VMM.AgentVersionDrift.Monitor`

Monitors operational health, status, and thresholds for VMM host agent version drift.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.ManagementStack.Configuration.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.ManagementStack.Management.Configuration.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.VMM.Management.Server.Configuration.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.VMM.AgentVersionDrift.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

Compares the agent version of every managed host with the VMM server version. More than MaxAgentVersionDriftCount drifted hosts is Critical; more than one distinct agent version in the fabric is Warning.

### Operator response

Update the VMM agent on the listed hosts to the version that matches the management server, then refresh the host. Raise MaxAgentVersionDriftCount only during a planned, staged agent upgrade.

### Support scope

VMM management, host agents, jobs, clouds and network configuration. Cloud quota exhaustion is not necessarily physical-cluster resource exhaustion; inspect the named constrained dimension.

Element: HyperVPrivateCloud.Capability.VMM.AgentVersionDrift.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: VMMDiscovery!Microsoft.SystemCenter.VirtualMachineManager.Discovery.VMMManagementServer. Parent health aspect: Health!System.Health.ConfigurationState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: (Property[@Name=&#39;AgentVersionDriftState&#39;] = Good OR Property[@Name=&#39;AgentVersionDriftState&#39;] = NotApplicable)

Warning [Warning]: Property[@Name=&#39;AgentVersionDriftState&#39;] = Warning

Error [Critical]: Property[@Name=&#39;AgentVersionDriftState&#39;] = Critical

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: ComputerName=$Target/Host/Property[Type=&quot;Windows!Microsoft.Windows.Computer&quot;]/PrincipalName$; CriticalCpuPercent=90; CriticalJobFailurePercent=25; CriticalMemoryPercent=92; CriticalProTipCount=5; CriticalStoragePercent=90; IntervalSeconds=1800; JobLookbackHours=24; MaxAgentVersionDriftCount=0; MinimumJobSampleCount=5; PropertyName=AgentVersionDriftState; RequireVmNetworkBinding=true; SyncTime=; TimeoutSeconds=300; WarningCpuPercent=75; WarningJobFailurePercent=10; WarningMemoryPercent=80; WarningProTipCount=1; WarningStoragePercent=80 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Error; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Use the matching read-only VMM task and native Jobs/Fabric/Clouds views. Capture the failing job ID and inner error, host agent status/version, configured cloud limit and consumed value, or exact logical network/site/uplink binding. Verify the VMM Run As account and supported module runtime for query failures.

### Corrective action and escalation

Resolve the reported inner job or communication error. Coordinate agent updates with the VMM upgrade baseline. Change cloud quotas only after confirming physical headroom and tenant policy. Correct missing network sites or uplink mappings through VMM, not by ad hoc host-side changes. Do not rerun mutating failed jobs without checking partial completion.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm fresh VMM queries, expected host status, valid network bindings and quota headroom. Recent-failure monitors may remain unhealthy until their lookback window expires even after successful new jobs.

### Microsoft references

[Microsoft Learn: troubleshoot host status errors](https://learn.microsoft.com/en-us/troubleshoot/system-center/vmm/troubleshoot-host-status-errors)

[Microsoft Learn: upgrade vmm](https://learn.microsoft.com/en-us/system-center/vmm/upgrade-vmm?view=sc-vmm-2025)

[Microsoft Learn: self service](https://learn.microsoft.com/en-us/system-center/vmm/self-service?view=sc-vmm-2025)

[Microsoft Learn: network logical](https://learn.microsoft.com/en-us/system-center/vmm/network-logical?view=sc-vmm-2025)

[Microsoft Learn: manage networks](https://learn.microsoft.com/en-us/system-center/vmm/manage-networks?view=sc-vmm-2025)


## VMM logical network availability {#hypervprivatecloud.capability.vmm.logicalnetworkavailability.monitor}

`HyperVPrivateCloud.Capability.VMM.LogicalNetworkAvailability.Monitor`

Monitors operational health, status, and thresholds for VMM logical network availability.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.ManagementStack.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.ManagementStack.Management.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.VMM.Management.Server.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.VMM.LogicalNetworkAvailability.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

Confirms that the VMM server publishes at least one logical network and that every logical network carries at least one network site definition.

### Operator response

Create or repair the network site definition, assign it to the correct host groups, and associate the required subnets and VLANs.

### Support scope

VMM management, host agents, jobs, clouds and network configuration. Cloud quota exhaustion is not necessarily physical-cluster resource exhaustion; inspect the named constrained dimension.

Element: HyperVPrivateCloud.Capability.VMM.LogicalNetworkAvailability.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: VMMDiscovery!Microsoft.SystemCenter.VirtualMachineManager.Discovery.VMMManagementServer. Parent health aspect: Health!System.Health.AvailabilityState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: (Property[@Name=&#39;LogicalNetworkState&#39;] = Good OR Property[@Name=&#39;LogicalNetworkState&#39;] = NotApplicable)

Warning [Warning]: Property[@Name=&#39;LogicalNetworkState&#39;] = Warning

Error [Critical]: Property[@Name=&#39;LogicalNetworkState&#39;] = Critical

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: ComputerName=$Target/Host/Property[Type=&quot;Windows!Microsoft.Windows.Computer&quot;]/PrincipalName$; CriticalCpuPercent=90; CriticalJobFailurePercent=25; CriticalMemoryPercent=92; CriticalProTipCount=5; CriticalStoragePercent=90; IntervalSeconds=900; JobLookbackHours=24; MaxAgentVersionDriftCount=0; MinimumJobSampleCount=5; PropertyName=LogicalNetworkState; RequireVmNetworkBinding=true; SyncTime=; TimeoutSeconds=300; WarningCpuPercent=75; WarningJobFailurePercent=10; WarningMemoryPercent=80; WarningProTipCount=1; WarningStoragePercent=80 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Warning; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Use the matching read-only VMM task and native Jobs/Fabric/Clouds views. Capture the failing job ID and inner error, host agent status/version, configured cloud limit and consumed value, or exact logical network/site/uplink binding. Verify the VMM Run As account and supported module runtime for query failures.

### Corrective action and escalation

Resolve the reported inner job or communication error. Coordinate agent updates with the VMM upgrade baseline. Change cloud quotas only after confirming physical headroom and tenant policy. Correct missing network sites or uplink mappings through VMM, not by ad hoc host-side changes. Do not rerun mutating failed jobs without checking partial completion.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm fresh VMM queries, expected host status, valid network bindings and quota headroom. Recent-failure monitors may remain unhealthy until their lookback window expires even after successful new jobs.

### Microsoft references

[Microsoft Learn: troubleshoot host status errors](https://learn.microsoft.com/en-us/troubleshoot/system-center/vmm/troubleshoot-host-status-errors)

[Microsoft Learn: upgrade vmm](https://learn.microsoft.com/en-us/system-center/vmm/upgrade-vmm?view=sc-vmm-2025)

[Microsoft Learn: self service](https://learn.microsoft.com/en-us/system-center/vmm/self-service?view=sc-vmm-2025)

[Microsoft Learn: network logical](https://learn.microsoft.com/en-us/system-center/vmm/network-logical?view=sc-vmm-2025)

[Microsoft Learn: manage networks](https://learn.microsoft.com/en-us/system-center/vmm/manage-networks?view=sc-vmm-2025)


## VMM VM network availability {#hypervprivatecloud.capability.vmm.vmnetworkavailability.monitor}

`HyperVPrivateCloud.Capability.VMM.VMNetworkAvailability.Monitor`

Monitors operational health, status, and thresholds for VMM VM network availability.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.ManagementStack.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.ManagementStack.Management.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.VMM.Management.Server.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.VMM.VMNetworkAvailability.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

Confirms that the VMM server publishes VM networks and that none reports a failed, error, or missing status.

### Operator response

Inspect the VM network in the VMM console, repair the underlying logical network or network virtualization configuration, and refresh the fabric.

### Support scope

VMM management, host agents, jobs, clouds and network configuration. Cloud quota exhaustion is not necessarily physical-cluster resource exhaustion; inspect the named constrained dimension.

Element: HyperVPrivateCloud.Capability.VMM.VMNetworkAvailability.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: VMMDiscovery!Microsoft.SystemCenter.VirtualMachineManager.Discovery.VMMManagementServer. Parent health aspect: Health!System.Health.AvailabilityState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: (Property[@Name=&#39;VMNetworkState&#39;] = Good OR Property[@Name=&#39;VMNetworkState&#39;] = NotApplicable)

Warning [Warning]: Property[@Name=&#39;VMNetworkState&#39;] = Warning

Error [Critical]: Property[@Name=&#39;VMNetworkState&#39;] = Critical

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: ComputerName=$Target/Host/Property[Type=&quot;Windows!Microsoft.Windows.Computer&quot;]/PrincipalName$; CriticalCpuPercent=90; CriticalJobFailurePercent=25; CriticalMemoryPercent=92; CriticalProTipCount=5; CriticalStoragePercent=90; IntervalSeconds=900; JobLookbackHours=24; MaxAgentVersionDriftCount=0; MinimumJobSampleCount=5; PropertyName=VMNetworkState; RequireVmNetworkBinding=true; SyncTime=; TimeoutSeconds=300; WarningCpuPercent=75; WarningJobFailurePercent=10; WarningMemoryPercent=80; WarningProTipCount=1; WarningStoragePercent=80 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Error; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Use the matching read-only VMM task and native Jobs/Fabric/Clouds views. Capture the failing job ID and inner error, host agent status/version, configured cloud limit and consumed value, or exact logical network/site/uplink binding. Verify the VMM Run As account and supported module runtime for query failures.

### Corrective action and escalation

Resolve the reported inner job or communication error. Coordinate agent updates with the VMM upgrade baseline. Change cloud quotas only after confirming physical headroom and tenant policy. Correct missing network sites or uplink mappings through VMM, not by ad hoc host-side changes. Do not rerun mutating failed jobs without checking partial completion.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm fresh VMM queries, expected host status, valid network bindings and quota headroom. Recent-failure monitors may remain unhealthy until their lookback window expires even after successful new jobs.

### Microsoft references

[Microsoft Learn: troubleshoot host status errors](https://learn.microsoft.com/en-us/troubleshoot/system-center/vmm/troubleshoot-host-status-errors)

[Microsoft Learn: upgrade vmm](https://learn.microsoft.com/en-us/system-center/vmm/upgrade-vmm?view=sc-vmm-2025)

[Microsoft Learn: self service](https://learn.microsoft.com/en-us/system-center/vmm/self-service?view=sc-vmm-2025)

[Microsoft Learn: network logical](https://learn.microsoft.com/en-us/system-center/vmm/network-logical?view=sc-vmm-2025)

[Microsoft Learn: manage networks](https://learn.microsoft.com/en-us/system-center/vmm/manage-networks?view=sc-vmm-2025)


## VMM VM network to logical network binding {#hypervprivatecloud.capability.vmm.vmnetworkbinding.monitor}

`HyperVPrivateCloud.Capability.VMM.VMNetworkBinding.Monitor`

Monitors operational health, status, and thresholds for VMM VM network to logical network binding.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.ManagementStack.Configuration.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.ManagementStack.Management.Configuration.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.VMM.Management.Server.Configuration.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.VMM.VMNetworkBinding.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

Verifies that every VM network resolves to a logical network. An unbound VM network cannot place a virtual machine adapter on fabric.

### Operator response

Bind the VM network to the intended logical network and confirm the network site and subnet scope. Override RequireVmNetworkBinding to false only where unbound VM networks are deliberate.

### Support scope

VMM management, host agents, jobs, clouds and network configuration. Cloud quota exhaustion is not necessarily physical-cluster resource exhaustion; inspect the named constrained dimension.

Element: HyperVPrivateCloud.Capability.VMM.VMNetworkBinding.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: VMMDiscovery!Microsoft.SystemCenter.VirtualMachineManager.Discovery.VMMManagementServer. Parent health aspect: Health!System.Health.ConfigurationState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: (Property[@Name=&#39;VMNetworkBindingState&#39;] = Good OR Property[@Name=&#39;VMNetworkBindingState&#39;] = NotApplicable)

Warning [Warning]: Property[@Name=&#39;VMNetworkBindingState&#39;] = Warning

Error [Critical]: Property[@Name=&#39;VMNetworkBindingState&#39;] = Critical

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: ComputerName=$Target/Host/Property[Type=&quot;Windows!Microsoft.Windows.Computer&quot;]/PrincipalName$; CriticalCpuPercent=90; CriticalJobFailurePercent=25; CriticalMemoryPercent=92; CriticalProTipCount=5; CriticalStoragePercent=90; IntervalSeconds=900; JobLookbackHours=24; MaxAgentVersionDriftCount=0; MinimumJobSampleCount=5; PropertyName=VMNetworkBindingState; RequireVmNetworkBinding=true; SyncTime=; TimeoutSeconds=300; WarningCpuPercent=75; WarningJobFailurePercent=10; WarningMemoryPercent=80; WarningProTipCount=1; WarningStoragePercent=80 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Error; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Use the matching read-only VMM task and native Jobs/Fabric/Clouds views. Capture the failing job ID and inner error, host agent status/version, configured cloud limit and consumed value, or exact logical network/site/uplink binding. Verify the VMM Run As account and supported module runtime for query failures.

### Corrective action and escalation

Resolve the reported inner job or communication error. Coordinate agent updates with the VMM upgrade baseline. Change cloud quotas only after confirming physical headroom and tenant policy. Correct missing network sites or uplink mappings through VMM, not by ad hoc host-side changes. Do not rerun mutating failed jobs without checking partial completion.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm fresh VMM queries, expected host status, valid network bindings and quota headroom. Recent-failure monitors may remain unhealthy until their lookback window expires even after successful new jobs.

### Microsoft references

[Microsoft Learn: troubleshoot host status errors](https://learn.microsoft.com/en-us/troubleshoot/system-center/vmm/troubleshoot-host-status-errors)

[Microsoft Learn: upgrade vmm](https://learn.microsoft.com/en-us/system-center/vmm/upgrade-vmm?view=sc-vmm-2025)

[Microsoft Learn: self service](https://learn.microsoft.com/en-us/system-center/vmm/self-service?view=sc-vmm-2025)

[Microsoft Learn: network logical](https://learn.microsoft.com/en-us/system-center/vmm/network-logical?view=sc-vmm-2025)

[Microsoft Learn: manage networks](https://learn.microsoft.com/en-us/system-center/vmm/manage-networks?view=sc-vmm-2025)


## VMM virtual switch uplink state {#hypervprivatecloud.capability.vmm.virtualswitchuplink.monitor}

`HyperVPrivateCloud.Capability.VMM.VirtualSwitchUplink.Monitor`

Monitors operational health, status, and thresholds for VMM virtual switch uplink state.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.ManagementStack.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.ManagementStack.Management.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.VMM.Management.Server.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.VMM.VirtualSwitchUplink.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

Reads VMM host network adapters bound to a virtual switch and reports uplinks whose connection state is not connected, or that carry no logical network.

### Operator response

Check the physical adapter, the switch port, the uplink port profile, and the logical network association, then refresh the host network adapters in VMM.

### Support scope

VMM management, host agents, jobs, clouds and network configuration. Cloud quota exhaustion is not necessarily physical-cluster resource exhaustion; inspect the named constrained dimension.

Element: HyperVPrivateCloud.Capability.VMM.VirtualSwitchUplink.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: VMMDiscovery!Microsoft.SystemCenter.VirtualMachineManager.Discovery.VMMManagementServer. Parent health aspect: Health!System.Health.AvailabilityState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: (Property[@Name=&#39;VirtualSwitchUplinkState&#39;] = Good OR Property[@Name=&#39;VirtualSwitchUplinkState&#39;] = NotApplicable)

Warning [Warning]: Property[@Name=&#39;VirtualSwitchUplinkState&#39;] = Warning

Error [Critical]: Property[@Name=&#39;VirtualSwitchUplinkState&#39;] = Critical

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: ComputerName=$Target/Host/Property[Type=&quot;Windows!Microsoft.Windows.Computer&quot;]/PrincipalName$; CriticalCpuPercent=90; CriticalJobFailurePercent=25; CriticalMemoryPercent=92; CriticalProTipCount=5; CriticalStoragePercent=90; IntervalSeconds=600; JobLookbackHours=24; MaxAgentVersionDriftCount=0; MinimumJobSampleCount=5; PropertyName=VirtualSwitchUplinkState; RequireVmNetworkBinding=true; SyncTime=; TimeoutSeconds=300; WarningCpuPercent=75; WarningJobFailurePercent=10; WarningMemoryPercent=80; WarningProTipCount=1; WarningStoragePercent=80 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Error; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Use the matching read-only VMM task and native Jobs/Fabric/Clouds views. Capture the failing job ID and inner error, host agent status/version, configured cloud limit and consumed value, or exact logical network/site/uplink binding. Verify the VMM Run As account and supported module runtime for query failures.

### Corrective action and escalation

Resolve the reported inner job or communication error. Coordinate agent updates with the VMM upgrade baseline. Change cloud quotas only after confirming physical headroom and tenant policy. Correct missing network sites or uplink mappings through VMM, not by ad hoc host-side changes. Do not rerun mutating failed jobs without checking partial completion.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm fresh VMM queries, expected host status, valid network bindings and quota headroom. Recent-failure monitors may remain unhealthy until their lookback window expires even after successful new jobs.

### Microsoft references

[Microsoft Learn: troubleshoot host status errors](https://learn.microsoft.com/en-us/troubleshoot/system-center/vmm/troubleshoot-host-status-errors)

[Microsoft Learn: upgrade vmm](https://learn.microsoft.com/en-us/system-center/vmm/upgrade-vmm?view=sc-vmm-2025)

[Microsoft Learn: self service](https://learn.microsoft.com/en-us/system-center/vmm/self-service?view=sc-vmm-2025)

[Microsoft Learn: network logical](https://learn.microsoft.com/en-us/system-center/vmm/network-logical?view=sc-vmm-2025)

[Microsoft Learn: manage networks](https://learn.microsoft.com/en-us/system-center/vmm/manage-networks?view=sc-vmm-2025)


## VMM host group capacity utilisation {#hypervprivatecloud.capability.vmm.hostgroupcapacity.monitor}

`HyperVPrivateCloud.Capability.VMM.HostGroupCapacity.Monitor`

Monitors operational health, status, and thresholds for VMM host group capacity utilisation.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.ManagementStack.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.ManagementStack.Management.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.VMM.Management.Server.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.VMM.HostGroupCapacity.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

Aggregates processor, memory, and storage utilisation for every host group. Processor uses the reported host utilisation where VMM publishes it, and otherwise assigned virtual processors over logical processors. Defaults are 75 and 90 percent processor, 80 and 92 percent memory, 80 and 90 percent storage.

### Operator response

Rebalance or add capacity in the named host group, review placement rules and reserves, and reclaim orphaned storage before the group saturates.

### Support scope

VMM management, host agents, jobs, clouds and network configuration. Cloud quota exhaustion is not necessarily physical-cluster resource exhaustion; inspect the named constrained dimension.

Element: HyperVPrivateCloud.Capability.VMM.HostGroupCapacity.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: VMMDiscovery!Microsoft.SystemCenter.VirtualMachineManager.Discovery.VMMManagementServer. Parent health aspect: Health!System.Health.PerformanceState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: (Property[@Name=&#39;HostGroupCapacityState&#39;] = Good OR Property[@Name=&#39;HostGroupCapacityState&#39;] = NotApplicable)

Warning [Warning]: Property[@Name=&#39;HostGroupCapacityState&#39;] = Warning

Error [Critical]: Property[@Name=&#39;HostGroupCapacityState&#39;] = Critical

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: ComputerName=$Target/Host/Property[Type=&quot;Windows!Microsoft.Windows.Computer&quot;]/PrincipalName$; CriticalCpuPercent=90; CriticalJobFailurePercent=25; CriticalMemoryPercent=92; CriticalProTipCount=5; CriticalStoragePercent=90; IntervalSeconds=900; JobLookbackHours=24; MaxAgentVersionDriftCount=0; MinimumJobSampleCount=5; PropertyName=HostGroupCapacityState; RequireVmNetworkBinding=true; SyncTime=; TimeoutSeconds=300; WarningCpuPercent=75; WarningJobFailurePercent=10; WarningMemoryPercent=80; WarningProTipCount=1; WarningStoragePercent=80 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Error; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Use the matching read-only VMM task and native Jobs/Fabric/Clouds views. Capture the failing job ID and inner error, host agent status/version, configured cloud limit and consumed value, or exact logical network/site/uplink binding. Verify the VMM Run As account and supported module runtime for query failures.

### Corrective action and escalation

Resolve the reported inner job or communication error. Coordinate agent updates with the VMM upgrade baseline. Change cloud quotas only after confirming physical headroom and tenant policy. Correct missing network sites or uplink mappings through VMM, not by ad hoc host-side changes. Do not rerun mutating failed jobs without checking partial completion.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm fresh VMM queries, expected host status, valid network bindings and quota headroom. Recent-failure monitors may remain unhealthy until their lookback window expires even after successful new jobs.

### Microsoft references

[Microsoft Learn: troubleshoot host status errors](https://learn.microsoft.com/en-us/troubleshoot/system-center/vmm/troubleshoot-host-status-errors)

[Microsoft Learn: upgrade vmm](https://learn.microsoft.com/en-us/system-center/vmm/upgrade-vmm?view=sc-vmm-2025)

[Microsoft Learn: self service](https://learn.microsoft.com/en-us/system-center/vmm/self-service?view=sc-vmm-2025)

[Microsoft Learn: network logical](https://learn.microsoft.com/en-us/system-center/vmm/network-logical?view=sc-vmm-2025)

[Microsoft Learn: manage networks](https://learn.microsoft.com/en-us/system-center/vmm/manage-networks?view=sc-vmm-2025)


## VMM private cloud capacity utilisation {#hypervprivatecloud.capability.vmm.cloudcapacity.monitor}

`HyperVPrivateCloud.Capability.VMM.CloudCapacity.Monitor`

Monitors operational health, status, and thresholds for VMM private cloud capacity utilisation.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.ManagementStack.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.ManagementStack.Management.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.VMM.Management.Server.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.VMM.CloudCapacity.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

Compares used against total processor, memory, and storage capacity for every private cloud. Defaults are 75 and 90 percent processor, 80 and 92 percent memory, 80 and 90 percent storage.

### Operator response

Raise the cloud capacity quota, add host group capacity behind the cloud, or reclaim unused virtual machines and storage.

### Support scope

VMM management, host agents, jobs, clouds and network configuration. Cloud quota exhaustion is not necessarily physical-cluster resource exhaustion; inspect the named constrained dimension.

Element: HyperVPrivateCloud.Capability.VMM.CloudCapacity.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: VMMDiscovery!Microsoft.SystemCenter.VirtualMachineManager.Discovery.VMMManagementServer. Parent health aspect: Health!System.Health.PerformanceState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: (Property[@Name=&#39;CloudCapacityState&#39;] = Good OR Property[@Name=&#39;CloudCapacityState&#39;] = NotApplicable)

Warning [Warning]: Property[@Name=&#39;CloudCapacityState&#39;] = Warning

Error [Critical]: Property[@Name=&#39;CloudCapacityState&#39;] = Critical

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: ComputerName=$Target/Host/Property[Type=&quot;Windows!Microsoft.Windows.Computer&quot;]/PrincipalName$; CriticalCpuPercent=90; CriticalJobFailurePercent=25; CriticalMemoryPercent=92; CriticalProTipCount=5; CriticalStoragePercent=90; IntervalSeconds=900; JobLookbackHours=24; MaxAgentVersionDriftCount=0; MinimumJobSampleCount=5; PropertyName=CloudCapacityState; RequireVmNetworkBinding=true; SyncTime=; TimeoutSeconds=300; WarningCpuPercent=75; WarningJobFailurePercent=10; WarningMemoryPercent=80; WarningProTipCount=1; WarningStoragePercent=80 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Error; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Use the matching read-only VMM task and native Jobs/Fabric/Clouds views. Capture the failing job ID and inner error, host agent status/version, configured cloud limit and consumed value, or exact logical network/site/uplink binding. Verify the VMM Run As account and supported module runtime for query failures.

### Corrective action and escalation

Resolve the reported inner job or communication error. Coordinate agent updates with the VMM upgrade baseline. Change cloud quotas only after confirming physical headroom and tenant policy. Correct missing network sites or uplink mappings through VMM, not by ad hoc host-side changes. Do not rerun mutating failed jobs without checking partial completion.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm fresh VMM queries, expected host status, valid network bindings and quota headroom. Recent-failure monitors may remain unhealthy until their lookback window expires even after successful new jobs.

### Microsoft references

[Microsoft Learn: troubleshoot host status errors](https://learn.microsoft.com/en-us/troubleshoot/system-center/vmm/troubleshoot-host-status-errors)

[Microsoft Learn: upgrade vmm](https://learn.microsoft.com/en-us/system-center/vmm/upgrade-vmm?view=sc-vmm-2025)

[Microsoft Learn: self service](https://learn.microsoft.com/en-us/system-center/vmm/self-service?view=sc-vmm-2025)

[Microsoft Learn: network logical](https://learn.microsoft.com/en-us/system-center/vmm/network-logical?view=sc-vmm-2025)

[Microsoft Learn: manage networks](https://learn.microsoft.com/en-us/system-center/vmm/manage-networks?view=sc-vmm-2025)


## VMM job failure rate {#hypervprivatecloud.capability.vmm.jobfailurerate.monitor}

`HyperVPrivateCloud.Capability.VMM.JobFailureRate.Monitor`

Monitors operational health, status, and thresholds for VMM job failure rate.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.ManagementStack.Configuration.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.ManagementStack.Management.Configuration.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.VMM.Management.Server.Configuration.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.VMM.JobFailureRate.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

Computes the percentage of VMM jobs that failed within JobLookbackHours. The rate is only evaluated once at least MinimumJobSampleCount jobs have run. Defaults are 10 percent warning and 25 percent critical over 24 hours with a minimum sample of 5.

### Operator response

Open the Jobs workspace, group the failures by job type and target, and correct the common fabric or configuration cause. Raise the thresholds only where a known and accepted failure floor exists.

### Support scope

VMM management, host agents, jobs, clouds and network configuration. Cloud quota exhaustion is not necessarily physical-cluster resource exhaustion; inspect the named constrained dimension.

Element: HyperVPrivateCloud.Capability.VMM.JobFailureRate.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: VMMDiscovery!Microsoft.SystemCenter.VirtualMachineManager.Discovery.VMMManagementServer. Parent health aspect: Health!System.Health.ConfigurationState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: (Property[@Name=&#39;JobFailureRateState&#39;] = Good OR Property[@Name=&#39;JobFailureRateState&#39;] = NotApplicable)

Warning [Warning]: Property[@Name=&#39;JobFailureRateState&#39;] = Warning

Error [Critical]: Property[@Name=&#39;JobFailureRateState&#39;] = Critical

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: ComputerName=$Target/Host/Property[Type=&quot;Windows!Microsoft.Windows.Computer&quot;]/PrincipalName$; CriticalCpuPercent=90; CriticalJobFailurePercent=25; CriticalMemoryPercent=92; CriticalProTipCount=5; CriticalStoragePercent=90; IntervalSeconds=900; JobLookbackHours=24; MaxAgentVersionDriftCount=0; MinimumJobSampleCount=5; PropertyName=JobFailureRateState; RequireVmNetworkBinding=true; SyncTime=; TimeoutSeconds=300; WarningCpuPercent=75; WarningJobFailurePercent=10; WarningMemoryPercent=80; WarningProTipCount=1; WarningStoragePercent=80 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Error; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Use the matching read-only VMM task and native Jobs/Fabric/Clouds views. Capture the failing job ID and inner error, host agent status/version, configured cloud limit and consumed value, or exact logical network/site/uplink binding. Verify the VMM Run As account and supported module runtime for query failures.

### Corrective action and escalation

Resolve the reported inner job or communication error. Coordinate agent updates with the VMM upgrade baseline. Change cloud quotas only after confirming physical headroom and tenant policy. Correct missing network sites or uplink mappings through VMM, not by ad hoc host-side changes. Do not rerun mutating failed jobs without checking partial completion.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm fresh VMM queries, expected host status, valid network bindings and quota headroom. Recent-failure monitors may remain unhealthy until their lookback window expires even after successful new jobs.

### Microsoft references

[Microsoft Learn: troubleshoot host status errors](https://learn.microsoft.com/en-us/troubleshoot/system-center/vmm/troubleshoot-host-status-errors)

[Microsoft Learn: upgrade vmm](https://learn.microsoft.com/en-us/system-center/vmm/upgrade-vmm?view=sc-vmm-2025)

[Microsoft Learn: self service](https://learn.microsoft.com/en-us/system-center/vmm/self-service?view=sc-vmm-2025)

[Microsoft Learn: network logical](https://learn.microsoft.com/en-us/system-center/vmm/network-logical?view=sc-vmm-2025)

[Microsoft Learn: manage networks](https://learn.microsoft.com/en-us/system-center/vmm/manage-networks?view=sc-vmm-2025)


## VMM PRO tip state {#hypervprivatecloud.capability.vmm.protip.monitor}

`HyperVPrivateCloud.Capability.VMM.ProTip.Monitor`

Monitors operational health, status, and thresholds for VMM PRO tip state.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.ManagementStack.Configuration.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.ManagementStack.Management.Configuration.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.VMM.Management.Server.Configuration.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.VMM.ProTip.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

Counts active PRO tips surfaced by the VMM server. Defaults are 1 tip warning and 5 tips critical. Where PRO is not enabled, the monitor reports Not Applicable.

### Operator response

Review each PRO tip in the VMM console, implement or dismiss it deliberately, and address the recurring condition that generates it. This Management Pack never implements a PRO tip.

### Support scope

VMM management, host agents, jobs, clouds and network configuration. Cloud quota exhaustion is not necessarily physical-cluster resource exhaustion; inspect the named constrained dimension.

Element: HyperVPrivateCloud.Capability.VMM.ProTip.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: VMMDiscovery!Microsoft.SystemCenter.VirtualMachineManager.Discovery.VMMManagementServer. Parent health aspect: Health!System.Health.ConfigurationState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: (Property[@Name=&#39;ProTipState&#39;] = Good OR Property[@Name=&#39;ProTipState&#39;] = NotApplicable)

Warning [Warning]: Property[@Name=&#39;ProTipState&#39;] = Warning

Error [Critical]: Property[@Name=&#39;ProTipState&#39;] = Critical

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: ComputerName=$Target/Host/Property[Type=&quot;Windows!Microsoft.Windows.Computer&quot;]/PrincipalName$; CriticalCpuPercent=90; CriticalJobFailurePercent=25; CriticalMemoryPercent=92; CriticalProTipCount=5; CriticalStoragePercent=90; IntervalSeconds=900; JobLookbackHours=24; MaxAgentVersionDriftCount=0; MinimumJobSampleCount=5; PropertyName=ProTipState; RequireVmNetworkBinding=true; SyncTime=; TimeoutSeconds=300; WarningCpuPercent=75; WarningJobFailurePercent=10; WarningMemoryPercent=80; WarningProTipCount=1; WarningStoragePercent=80 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Error; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Use the matching read-only VMM task and native Jobs/Fabric/Clouds views. Capture the failing job ID and inner error, host agent status/version, configured cloud limit and consumed value, or exact logical network/site/uplink binding. Verify the VMM Run As account and supported module runtime for query failures.

### Corrective action and escalation

Resolve the reported inner job or communication error. Coordinate agent updates with the VMM upgrade baseline. Change cloud quotas only after confirming physical headroom and tenant policy. Correct missing network sites or uplink mappings through VMM, not by ad hoc host-side changes. Do not rerun mutating failed jobs without checking partial completion.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm fresh VMM queries, expected host status, valid network bindings and quota headroom. Recent-failure monitors may remain unhealthy until their lookback window expires even after successful new jobs.

### Microsoft references

[Microsoft Learn: troubleshoot host status errors](https://learn.microsoft.com/en-us/troubleshoot/system-center/vmm/troubleshoot-host-status-errors)

[Microsoft Learn: upgrade vmm](https://learn.microsoft.com/en-us/system-center/vmm/upgrade-vmm?view=sc-vmm-2025)

[Microsoft Learn: self service](https://learn.microsoft.com/en-us/system-center/vmm/self-service?view=sc-vmm-2025)

[Microsoft Learn: network logical](https://learn.microsoft.com/en-us/system-center/vmm/network-logical?view=sc-vmm-2025)

[Microsoft Learn: manage networks](https://learn.microsoft.com/en-us/system-center/vmm/manage-networks?view=sc-vmm-2025)


## Roll up VMM management-server availability {#hypervprivatecloud.capability.vmm.management.server.availability.dependency.monitor}

`HyperVPrivateCloud.Capability.VMM.Management.Server.Availability.Dependency.Monitor`

Rolls up SCVMM management server availability into the VMM fabric service.

### Support scope

VMM management, host agents, jobs, clouds and network configuration. Cloud quota exhaustion is not necessarily physical-cluster resource exhaustion; inspect the named constrained dimension.

Element: HyperVPrivateCloud.Capability.VMM.Management.Server.Availability.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.ManagementComponent; relationship=HyperVPrivateCloud.Capability.VMM.ManagementContainsVMMManagementServer; member monitor=Health!System.Health.AvailabilityState; parent=Health!System.Health.AvailabilityState; algorithm=WorstOf; unavailable-member policy=Success. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Use the matching read-only VMM task and native Jobs/Fabric/Clouds views. Capture the failing job ID and inner error, host agent status/version, configured cloud limit and consumed value, or exact logical network/site/uplink binding. Verify the VMM Run As account and supported module runtime for query failures.

### Corrective action and escalation

Resolve the reported inner job or communication error. Coordinate agent updates with the VMM upgrade baseline. Change cloud quotas only after confirming physical headroom and tenant policy. Correct missing network sites or uplink mappings through VMM, not by ad hoc host-side changes. Do not rerun mutating failed jobs without checking partial completion.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm fresh VMM queries, expected host status, valid network bindings and quota headroom. Recent-failure monitors may remain unhealthy until their lookback window expires even after successful new jobs.

### Microsoft references

[Microsoft Learn: troubleshoot host status errors](https://learn.microsoft.com/en-us/troubleshoot/system-center/vmm/troubleshoot-host-status-errors)

[Microsoft Learn: upgrade vmm](https://learn.microsoft.com/en-us/system-center/vmm/upgrade-vmm?view=sc-vmm-2025)

[Microsoft Learn: self service](https://learn.microsoft.com/en-us/system-center/vmm/self-service?view=sc-vmm-2025)

[Microsoft Learn: network logical](https://learn.microsoft.com/en-us/system-center/vmm/network-logical?view=sc-vmm-2025)

[Microsoft Learn: manage networks](https://learn.microsoft.com/en-us/system-center/vmm/manage-networks?view=sc-vmm-2025)


## Roll up VMM management-server configuration and failed jobs {#hypervprivatecloud.capability.vmm.management.server.configuration.dependency.monitor}

`HyperVPrivateCloud.Capability.VMM.Management.Server.Configuration.Dependency.Monitor`

Rolls up SCVMM configuration and failed job health into the VMM fabric service.

### Support scope

VMM management, host agents, jobs, clouds and network configuration. Cloud quota exhaustion is not necessarily physical-cluster resource exhaustion; inspect the named constrained dimension.

Element: HyperVPrivateCloud.Capability.VMM.Management.Server.Configuration.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.ManagementComponent; relationship=HyperVPrivateCloud.Capability.VMM.ManagementContainsVMMManagementServer; member monitor=Health!System.Health.ConfigurationState; parent=Health!System.Health.ConfigurationState; algorithm=WorstOf; unavailable-member policy=Success. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Use the matching read-only VMM task and native Jobs/Fabric/Clouds views. Capture the failing job ID and inner error, host agent status/version, configured cloud limit and consumed value, or exact logical network/site/uplink binding. Verify the VMM Run As account and supported module runtime for query failures.

### Corrective action and escalation

Resolve the reported inner job or communication error. Coordinate agent updates with the VMM upgrade baseline. Change cloud quotas only after confirming physical headroom and tenant policy. Correct missing network sites or uplink mappings through VMM, not by ad hoc host-side changes. Do not rerun mutating failed jobs without checking partial completion.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm fresh VMM queries, expected host status, valid network bindings and quota headroom. Recent-failure monitors may remain unhealthy until their lookback window expires even after successful new jobs.

### Microsoft references

[Microsoft Learn: troubleshoot host status errors](https://learn.microsoft.com/en-us/troubleshoot/system-center/vmm/troubleshoot-host-status-errors)

[Microsoft Learn: upgrade vmm](https://learn.microsoft.com/en-us/system-center/vmm/upgrade-vmm?view=sc-vmm-2025)

[Microsoft Learn: self service](https://learn.microsoft.com/en-us/system-center/vmm/self-service?view=sc-vmm-2025)

[Microsoft Learn: network logical](https://learn.microsoft.com/en-us/system-center/vmm/network-logical?view=sc-vmm-2025)

[Microsoft Learn: manage networks](https://learn.microsoft.com/en-us/system-center/vmm/manage-networks?view=sc-vmm-2025)


## Roll up VMM host WinRM availability into the VMM fabric {#hypervprivatecloud.capability.vmm.compute.host.winrm.dependency.monitor}

`HyperVPrivateCloud.Capability.VMM.Compute.Host.WinRM.Dependency.Monitor`

Rolls up host WinRM connectivity from SCVMM into the VMM fabric.

### Support scope

VMM management, host agents, jobs, clouds and network configuration. Cloud quota exhaustion is not necessarily physical-cluster resource exhaustion; inspect the named constrained dimension.

Element: HyperVPrivateCloud.Capability.VMM.Compute.Host.WinRM.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.ComputeComponent; relationship=HyperVPrivateCloud.Capability.VMM.ComputeContainsVMMHost; member monitor=VMMMonitoring!Microsoft.SystemCenter.VirtualMachineManager.HostWinRMService.Monitor; parent=Health!System.Health.AvailabilityState; algorithm=WorstOf; unavailable-member policy=Success. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Use the matching read-only VMM task and native Jobs/Fabric/Clouds views. Capture the failing job ID and inner error, host agent status/version, configured cloud limit and consumed value, or exact logical network/site/uplink binding. Verify the VMM Run As account and supported module runtime for query failures.

### Corrective action and escalation

Resolve the reported inner job or communication error. Coordinate agent updates with the VMM upgrade baseline. Change cloud quotas only after confirming physical headroom and tenant policy. Correct missing network sites or uplink mappings through VMM, not by ad hoc host-side changes. Do not rerun mutating failed jobs without checking partial completion.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm fresh VMM queries, expected host status, valid network bindings and quota headroom. Recent-failure monitors may remain unhealthy until their lookback window expires even after successful new jobs.

### Microsoft references

[Microsoft Learn: troubleshoot host status errors](https://learn.microsoft.com/en-us/troubleshoot/system-center/vmm/troubleshoot-host-status-errors)

[Microsoft Learn: upgrade vmm](https://learn.microsoft.com/en-us/system-center/vmm/upgrade-vmm?view=sc-vmm-2025)

[Microsoft Learn: self service](https://learn.microsoft.com/en-us/system-center/vmm/self-service?view=sc-vmm-2025)

[Microsoft Learn: network logical](https://learn.microsoft.com/en-us/system-center/vmm/network-logical?view=sc-vmm-2025)

[Microsoft Learn: manage networks](https://learn.microsoft.com/en-us/system-center/vmm/manage-networks?view=sc-vmm-2025)


## Roll up VMM host agent-version compliance into the VMM fabric {#hypervprivatecloud.capability.vmm.compute.host.agentversion.dependency.monitor}

`HyperVPrivateCloud.Capability.VMM.Compute.Host.AgentVersion.Dependency.Monitor`

Rolls up SCVMM host agent version compliance into the VMM fabric.

### Support scope

VMM management, host agents, jobs, clouds and network configuration. Cloud quota exhaustion is not necessarily physical-cluster resource exhaustion; inspect the named constrained dimension.

Element: HyperVPrivateCloud.Capability.VMM.Compute.Host.AgentVersion.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.ComputeComponent; relationship=HyperVPrivateCloud.Capability.VMM.ComputeContainsVMMHost; member monitor=VMMMonitoring!Microsoft.SystemCenter.VirtualMachineManager.HostVMMAgentVersionMonitor; parent=Health!System.Health.ConfigurationState; algorithm=WorstOf; unavailable-member policy=Success. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Use the matching read-only VMM task and native Jobs/Fabric/Clouds views. Capture the failing job ID and inner error, host agent status/version, configured cloud limit and consumed value, or exact logical network/site/uplink binding. Verify the VMM Run As account and supported module runtime for query failures.

### Corrective action and escalation

Resolve the reported inner job or communication error. Coordinate agent updates with the VMM upgrade baseline. Change cloud quotas only after confirming physical headroom and tenant policy. Correct missing network sites or uplink mappings through VMM, not by ad hoc host-side changes. Do not rerun mutating failed jobs without checking partial completion.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm fresh VMM queries, expected host status, valid network bindings and quota headroom. Recent-failure monitors may remain unhealthy until their lookback window expires even after successful new jobs.

### Microsoft references

[Microsoft Learn: troubleshoot host status errors](https://learn.microsoft.com/en-us/troubleshoot/system-center/vmm/troubleshoot-host-status-errors)

[Microsoft Learn: upgrade vmm](https://learn.microsoft.com/en-us/system-center/vmm/upgrade-vmm?view=sc-vmm-2025)

[Microsoft Learn: self service](https://learn.microsoft.com/en-us/system-center/vmm/self-service?view=sc-vmm-2025)

[Microsoft Learn: network logical](https://learn.microsoft.com/en-us/system-center/vmm/network-logical?view=sc-vmm-2025)

[Microsoft Learn: manage networks](https://learn.microsoft.com/en-us/system-center/vmm/manage-networks?view=sc-vmm-2025)


## Roll up VMM host WinRM availability into its Hyper-V boundary {#hypervprivatecloud.capability.vmm.management.host.winrm.dependency.monitor}

`HyperVPrivateCloud.Capability.VMM.Management.Host.WinRM.Dependency.Monitor`

Rolls up host WinRM connectivity into the host boundary.

### Support scope

VMM management, host agents, jobs, clouds and network configuration. Cloud quota exhaustion is not necessarily physical-cluster resource exhaustion; inspect the named constrained dimension.

Element: HyperVPrivateCloud.Capability.VMM.Management.Host.WinRM.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.ManagementComponent; relationship=HyperVPrivateCloud.Capability.VMM.ManagementReferencesVMMHost; member monitor=VMMMonitoring!Microsoft.SystemCenter.VirtualMachineManager.HostWinRMService.Monitor; parent=Health!System.Health.AvailabilityState; algorithm=WorstOf; unavailable-member policy=Success. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Use the matching read-only VMM task and native Jobs/Fabric/Clouds views. Capture the failing job ID and inner error, host agent status/version, configured cloud limit and consumed value, or exact logical network/site/uplink binding. Verify the VMM Run As account and supported module runtime for query failures.

### Corrective action and escalation

Resolve the reported inner job or communication error. Coordinate agent updates with the VMM upgrade baseline. Change cloud quotas only after confirming physical headroom and tenant policy. Correct missing network sites or uplink mappings through VMM, not by ad hoc host-side changes. Do not rerun mutating failed jobs without checking partial completion.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm fresh VMM queries, expected host status, valid network bindings and quota headroom. Recent-failure monitors may remain unhealthy until their lookback window expires even after successful new jobs.

### Microsoft references

[Microsoft Learn: troubleshoot host status errors](https://learn.microsoft.com/en-us/troubleshoot/system-center/vmm/troubleshoot-host-status-errors)

[Microsoft Learn: upgrade vmm](https://learn.microsoft.com/en-us/system-center/vmm/upgrade-vmm?view=sc-vmm-2025)

[Microsoft Learn: self service](https://learn.microsoft.com/en-us/system-center/vmm/self-service?view=sc-vmm-2025)

[Microsoft Learn: network logical](https://learn.microsoft.com/en-us/system-center/vmm/network-logical?view=sc-vmm-2025)

[Microsoft Learn: manage networks](https://learn.microsoft.com/en-us/system-center/vmm/manage-networks?view=sc-vmm-2025)


## Roll up VMM host agent-version compliance into its Hyper-V boundary {#hypervprivatecloud.capability.vmm.management.host.agentversion.dependency.monitor}

`HyperVPrivateCloud.Capability.VMM.Management.Host.AgentVersion.Dependency.Monitor`

Rolls up SCVMM host agent compliance into the host boundary.

### Support scope

VMM management, host agents, jobs, clouds and network configuration. Cloud quota exhaustion is not necessarily physical-cluster resource exhaustion; inspect the named constrained dimension.

Element: HyperVPrivateCloud.Capability.VMM.Management.Host.AgentVersion.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.ManagementComponent; relationship=HyperVPrivateCloud.Capability.VMM.ManagementReferencesVMMHost; member monitor=VMMMonitoring!Microsoft.SystemCenter.VirtualMachineManager.HostVMMAgentVersionMonitor; parent=Health!System.Health.ConfigurationState; algorithm=WorstOf; unavailable-member policy=Success. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Use the matching read-only VMM task and native Jobs/Fabric/Clouds views. Capture the failing job ID and inner error, host agent status/version, configured cloud limit and consumed value, or exact logical network/site/uplink binding. Verify the VMM Run As account and supported module runtime for query failures.

### Corrective action and escalation

Resolve the reported inner job or communication error. Coordinate agent updates with the VMM upgrade baseline. Change cloud quotas only after confirming physical headroom and tenant policy. Correct missing network sites or uplink mappings through VMM, not by ad hoc host-side changes. Do not rerun mutating failed jobs without checking partial completion.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm fresh VMM queries, expected host status, valid network bindings and quota headroom. Recent-failure monitors may remain unhealthy until their lookback window expires even after successful new jobs.

### Microsoft references

[Microsoft Learn: troubleshoot host status errors](https://learn.microsoft.com/en-us/troubleshoot/system-center/vmm/troubleshoot-host-status-errors)

[Microsoft Learn: upgrade vmm](https://learn.microsoft.com/en-us/system-center/vmm/upgrade-vmm?view=sc-vmm-2025)

[Microsoft Learn: self service](https://learn.microsoft.com/en-us/system-center/vmm/self-service?view=sc-vmm-2025)

[Microsoft Learn: network logical](https://learn.microsoft.com/en-us/system-center/vmm/network-logical?view=sc-vmm-2025)

[Microsoft Learn: manage networks](https://learn.microsoft.com/en-us/system-center/vmm/manage-networks?view=sc-vmm-2025)


## Roll up VMM private-cloud availability {#hypervprivatecloud.capability.vmm.management.cloud.availability.dependency.monitor}

`HyperVPrivateCloud.Capability.VMM.Management.Cloud.Availability.Dependency.Monitor`

Rolls up SCVMM private cloud availability into the management boundary.

### Support scope

VMM management, host agents, jobs, clouds and network configuration. Cloud quota exhaustion is not necessarily physical-cluster resource exhaustion; inspect the named constrained dimension.

Element: HyperVPrivateCloud.Capability.VMM.Management.Cloud.Availability.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.ManagementComponent; relationship=HyperVPrivateCloud.Capability.VMM.ManagementContainsPrivateCloud; member monitor=Health!System.Health.AvailabilityState; parent=Health!System.Health.AvailabilityState; algorithm=WorstOf; unavailable-member policy=Success. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Use the matching read-only VMM task and native Jobs/Fabric/Clouds views. Capture the failing job ID and inner error, host agent status/version, configured cloud limit and consumed value, or exact logical network/site/uplink binding. Verify the VMM Run As account and supported module runtime for query failures.

### Corrective action and escalation

Resolve the reported inner job or communication error. Coordinate agent updates with the VMM upgrade baseline. Change cloud quotas only after confirming physical headroom and tenant policy. Correct missing network sites or uplink mappings through VMM, not by ad hoc host-side changes. Do not rerun mutating failed jobs without checking partial completion.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm fresh VMM queries, expected host status, valid network bindings and quota headroom. Recent-failure monitors may remain unhealthy until their lookback window expires even after successful new jobs.

### Microsoft references

[Microsoft Learn: troubleshoot host status errors](https://learn.microsoft.com/en-us/troubleshoot/system-center/vmm/troubleshoot-host-status-errors)

[Microsoft Learn: upgrade vmm](https://learn.microsoft.com/en-us/system-center/vmm/upgrade-vmm?view=sc-vmm-2025)

[Microsoft Learn: self service](https://learn.microsoft.com/en-us/system-center/vmm/self-service?view=sc-vmm-2025)

[Microsoft Learn: network logical](https://learn.microsoft.com/en-us/system-center/vmm/network-logical?view=sc-vmm-2025)

[Microsoft Learn: manage networks](https://learn.microsoft.com/en-us/system-center/vmm/manage-networks?view=sc-vmm-2025)


## Roll up VMM private-cloud configuration {#hypervprivatecloud.capability.vmm.management.cloud.configuration.dependency.monitor}

`HyperVPrivateCloud.Capability.VMM.Management.Cloud.Configuration.Dependency.Monitor`

Rolls up SCVMM private cloud configuration into the management boundary.

### Support scope

VMM management, host agents, jobs, clouds and network configuration. Cloud quota exhaustion is not necessarily physical-cluster resource exhaustion; inspect the named constrained dimension.

Element: HyperVPrivateCloud.Capability.VMM.Management.Cloud.Configuration.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.ManagementComponent; relationship=HyperVPrivateCloud.Capability.VMM.ManagementContainsPrivateCloud; member monitor=Health!System.Health.ConfigurationState; parent=Health!System.Health.ConfigurationState; algorithm=WorstOf; unavailable-member policy=Success. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Use the matching read-only VMM task and native Jobs/Fabric/Clouds views. Capture the failing job ID and inner error, host agent status/version, configured cloud limit and consumed value, or exact logical network/site/uplink binding. Verify the VMM Run As account and supported module runtime for query failures.

### Corrective action and escalation

Resolve the reported inner job or communication error. Coordinate agent updates with the VMM upgrade baseline. Change cloud quotas only after confirming physical headroom and tenant policy. Correct missing network sites or uplink mappings through VMM, not by ad hoc host-side changes. Do not rerun mutating failed jobs without checking partial completion.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm fresh VMM queries, expected host status, valid network bindings and quota headroom. Recent-failure monitors may remain unhealthy until their lookback window expires even after successful new jobs.

### Microsoft references

[Microsoft Learn: troubleshoot host status errors](https://learn.microsoft.com/en-us/troubleshoot/system-center/vmm/troubleshoot-host-status-errors)

[Microsoft Learn: upgrade vmm](https://learn.microsoft.com/en-us/system-center/vmm/upgrade-vmm?view=sc-vmm-2025)

[Microsoft Learn: self service](https://learn.microsoft.com/en-us/system-center/vmm/self-service?view=sc-vmm-2025)

[Microsoft Learn: network logical](https://learn.microsoft.com/en-us/system-center/vmm/network-logical?view=sc-vmm-2025)

[Microsoft Learn: manage networks](https://learn.microsoft.com/en-us/system-center/vmm/manage-networks?view=sc-vmm-2025)


## Roll up mapped VMM private-cloud availability into the cluster boundary {#hypervprivatecloud.capability.vmm.clustermanagement.cloud.availability.dependency.monitor}

`HyperVPrivateCloud.Capability.VMM.ClusterManagement.Cloud.Availability.Dependency.Monitor`

Rolls up mapped SCVMM private cloud availability into the cluster boundary.

### Support scope

VMM management, host agents, jobs, clouds and network configuration. Cloud quota exhaustion is not necessarily physical-cluster resource exhaustion; inspect the named constrained dimension.

Element: HyperVPrivateCloud.Capability.VMM.ClusterManagement.Cloud.Availability.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.ManagementComponent; relationship=HyperVPrivateCloud.Capability.VMM.ManagementReferencesPrivateCloud; member monitor=Health!System.Health.AvailabilityState; parent=Health!System.Health.AvailabilityState; algorithm=WorstOf; unavailable-member policy=Success. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Use the matching read-only VMM task and native Jobs/Fabric/Clouds views. Capture the failing job ID and inner error, host agent status/version, configured cloud limit and consumed value, or exact logical network/site/uplink binding. Verify the VMM Run As account and supported module runtime for query failures.

### Corrective action and escalation

Resolve the reported inner job or communication error. Coordinate agent updates with the VMM upgrade baseline. Change cloud quotas only after confirming physical headroom and tenant policy. Correct missing network sites or uplink mappings through VMM, not by ad hoc host-side changes. Do not rerun mutating failed jobs without checking partial completion.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm fresh VMM queries, expected host status, valid network bindings and quota headroom. Recent-failure monitors may remain unhealthy until their lookback window expires even after successful new jobs.

### Microsoft references

[Microsoft Learn: troubleshoot host status errors](https://learn.microsoft.com/en-us/troubleshoot/system-center/vmm/troubleshoot-host-status-errors)

[Microsoft Learn: upgrade vmm](https://learn.microsoft.com/en-us/system-center/vmm/upgrade-vmm?view=sc-vmm-2025)

[Microsoft Learn: self service](https://learn.microsoft.com/en-us/system-center/vmm/self-service?view=sc-vmm-2025)

[Microsoft Learn: network logical](https://learn.microsoft.com/en-us/system-center/vmm/network-logical?view=sc-vmm-2025)

[Microsoft Learn: manage networks](https://learn.microsoft.com/en-us/system-center/vmm/manage-networks?view=sc-vmm-2025)


## Roll up mapped VMM private-cloud configuration into the cluster boundary {#hypervprivatecloud.capability.vmm.clustermanagement.cloud.configuration.dependency.monitor}

`HyperVPrivateCloud.Capability.VMM.ClusterManagement.Cloud.Configuration.Dependency.Monitor`

Rolls up mapped SCVMM private cloud configuration into the cluster boundary.

### Support scope

VMM management, host agents, jobs, clouds and network configuration. Cloud quota exhaustion is not necessarily physical-cluster resource exhaustion; inspect the named constrained dimension.

Element: HyperVPrivateCloud.Capability.VMM.ClusterManagement.Cloud.Configuration.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.ManagementComponent; relationship=HyperVPrivateCloud.Capability.VMM.ManagementReferencesPrivateCloud; member monitor=Health!System.Health.ConfigurationState; parent=Health!System.Health.ConfigurationState; algorithm=WorstOf; unavailable-member policy=Success. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Use the matching read-only VMM task and native Jobs/Fabric/Clouds views. Capture the failing job ID and inner error, host agent status/version, configured cloud limit and consumed value, or exact logical network/site/uplink binding. Verify the VMM Run As account and supported module runtime for query failures.

### Corrective action and escalation

Resolve the reported inner job or communication error. Coordinate agent updates with the VMM upgrade baseline. Change cloud quotas only after confirming physical headroom and tenant policy. Correct missing network sites or uplink mappings through VMM, not by ad hoc host-side changes. Do not rerun mutating failed jobs without checking partial completion.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm fresh VMM queries, expected host status, valid network bindings and quota headroom. Recent-failure monitors may remain unhealthy until their lookback window expires even after successful new jobs.

### Microsoft references

[Microsoft Learn: troubleshoot host status errors](https://learn.microsoft.com/en-us/troubleshoot/system-center/vmm/troubleshoot-host-status-errors)

[Microsoft Learn: upgrade vmm](https://learn.microsoft.com/en-us/system-center/vmm/upgrade-vmm?view=sc-vmm-2025)

[Microsoft Learn: self service](https://learn.microsoft.com/en-us/system-center/vmm/self-service?view=sc-vmm-2025)

[Microsoft Learn: network logical](https://learn.microsoft.com/en-us/system-center/vmm/network-logical?view=sc-vmm-2025)

[Microsoft Learn: manage networks](https://learn.microsoft.com/en-us/system-center/vmm/manage-networks?view=sc-vmm-2025)


## Roll up Performance through VMM.ManagementContainsVMMManagementServer {#hypervprivatecloud.capability.vmm.management.server.performance.dependency.monitor}

`HyperVPrivateCloud.Capability.VMM.Management.Server.Performance.Dependency.Monitor`

Preserves the originating health aspect through this domain dependency. Open the unhealthy member monitor for the actual cause; this rollup does not create a second incident.

### Support scope

VMM management, host agents, jobs, clouds and network configuration. Cloud quota exhaustion is not necessarily physical-cluster resource exhaustion; inspect the named constrained dimension.

Element: HyperVPrivateCloud.Capability.VMM.Management.Server.Performance.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.ManagementComponent; relationship=HyperVPrivateCloud.Capability.VMM.ManagementContainsVMMManagementServer; member monitor=Health!System.Health.PerformanceState; parent=Health!System.Health.PerformanceState; algorithm=WorstOf; unavailable-member policy=Success. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Use the matching read-only VMM task and native Jobs/Fabric/Clouds views. Capture the failing job ID and inner error, host agent status/version, configured cloud limit and consumed value, or exact logical network/site/uplink binding. Verify the VMM Run As account and supported module runtime for query failures.

### Corrective action and escalation

Resolve the reported inner job or communication error. Coordinate agent updates with the VMM upgrade baseline. Change cloud quotas only after confirming physical headroom and tenant policy. Correct missing network sites or uplink mappings through VMM, not by ad hoc host-side changes. Do not rerun mutating failed jobs without checking partial completion.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm fresh VMM queries, expected host status, valid network bindings and quota headroom. Recent-failure monitors may remain unhealthy until their lookback window expires even after successful new jobs.

### Microsoft references

[Microsoft Learn: troubleshoot host status errors](https://learn.microsoft.com/en-us/troubleshoot/system-center/vmm/troubleshoot-host-status-errors)

[Microsoft Learn: upgrade vmm](https://learn.microsoft.com/en-us/system-center/vmm/upgrade-vmm?view=sc-vmm-2025)

[Microsoft Learn: self service](https://learn.microsoft.com/en-us/system-center/vmm/self-service?view=sc-vmm-2025)

[Microsoft Learn: network logical](https://learn.microsoft.com/en-us/system-center/vmm/network-logical?view=sc-vmm-2025)

[Microsoft Learn: manage networks](https://learn.microsoft.com/en-us/system-center/vmm/manage-networks?view=sc-vmm-2025)
