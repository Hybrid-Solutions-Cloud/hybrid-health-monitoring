# Hyper-V Private Cloud Monitoring Library

Generated support reference. [All capabilities](catalog.md) · [Day-2 triage](index.md).

Default conditions below come from the compiled candidate source, not the effective overrides in your management group. Read the monitor-specific knowledge together with the common safety and verification guidance. Microsoft links explain the underlying technology; product thresholds are not Microsoft recommendations.

## Hyper-V Private Cloud Boundary {#hypervprivatecloud.boundary}

`HyperVPrivateCloud.Boundary`

Stable cluster or standalone-host discovery boundary. It scopes membership and identity; use the associated Service DA for operational health rather than treating the boundary identifier as a workload.

### Support scope

A discovered identity, logical boundary, component group or health dependency in the private-cloud service model. Containment draws a diagram; only authored monitors and health dependencies determine its health.

Element: HyperVPrivateCloud.Boundary. Kind: ClassType.

### Identity and monitoring ownership

Base class=System!System.LogicalEntity; hosted=false; singleton=false; declared properties=BoundaryId, BoundaryType, BoundaryName, ManagementAuthority. Inherited properties also apply. Inspect the exact instance and its monitoring path; inventory-only classes do not acquire health merely by appearing in a diagram.

### Read-only investigation

Open Health Explorer from the unhealthy DA, follow the failing health aspect and dependency to the named leaf object, and read its state-change context and knowledge. Check whether the object is an inventory-only reference or an authoritative monitor target. Record the complete root-to-leaf path.

### Corrective action and escalation

Repair the originating leaf condition using its specific runbook and owner. Do not reset or edit a parent DA to conceal child health. Missing relationships or wrong aspect routing require a source change, tests and a new sealed MP version.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm fresh healthy leaf evidence and follow recovery through each dependency back to the solution root. Unknown/unmonitored objects and absent optional capabilities must not be described as fully monitored healthy services.

### What this object represents

Stable cluster or standalone-host discovery boundary. It scopes membership and identity; use the associated Service DA for operational health rather than treating the boundary identifier as a workload.

### Microsoft references

[Microsoft Learn: manage consoles overview healthexplorer](https://learn.microsoft.com/en-us/system-center/scom/manage-consoles-overview-healthexplorer?view=sc-om-2025)


## Hyper-V Host {#hypervprivatecloud.hostrole}

`HyperVPrivateCloud.HostRole`

Hyper-V role hosted on a managed Windows computer. It owns host probes and host-derived VM discovery; host health can include capability dependencies, so drill into its actual leaf monitor before attributing a red Compute branch to CPU hardware.

### Support scope

Host-based Hyper-V workload or management evidence. A stopped VM must be compared with its intended state; inventory presence is not guest application monitoring.

Element: HyperVPrivateCloud.HostRole. Kind: ClassType.

### Identity and monitoring ownership

Base class=Windows!Microsoft.Windows.LocalApplication; hosted=true; singleton=false; declared properties=HostId, BoundaryId, RoleVersion, RoleState, LogicalProcessorCount, MemoryBytes, VirtualMachineCount, DiscoveryVersion. Inherited properties also apply. Inspect the exact instance and its monitoring path; inventory-only classes do not acquire health merely by appearing in a diagram.

### Read-only investigation

Run the matching read-only host/VM task. Match the stable VM ID and current owner, inspect Get-VM, attached disks, checkpoint chain and Hyper-V-VMMS/High-Availability logs. For management-service errors verify the named service and first failure rather than assuming every guest stopped.

### Corrective action and escalation

Restore the identified service, configuration, storage or VM dependency with the workload owner. Check intended shutdown and maintenance policy first. Never delete checkpoint files, force power operations or restart VMMS/hosts solely to clear an alert.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm the intended VM/service state, fresh host-derived evidence and the originating monitor. Guest application recovery requires a separate workload-level check.

### What this object represents

Hyper-V role hosted on a managed Windows computer. It owns host probes and host-derived VM discovery; host health can include capability dependencies, so drill into its actual leaf monitor before attributing a red Compute branch to CPU hardware.

### Microsoft references

[Microsoft Learn: hyper v start state access failures clustered standalone](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-start-state-access-failures-clustered-standalone)

[Microsoft Learn: hyper v virtual machine backup checkpoint storage](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-virtual-machine-backup-checkpoint-storage)


## Hyper-V Virtual Machine {#hypervprivatecloud.virtualmachine}

`HyperVPrivateCloud.VirtualMachine`

Stable VM identity that survives host migration. Workload-guest SCOM agents are not required. The current VirtualMachineRuntime instance supplies owner-specific observations; this object does not prove application health inside the guest.

### Support scope

Host-based Hyper-V workload or management evidence. A stopped VM must be compared with its intended state; inventory presence is not guest application monitoring.

Element: HyperVPrivateCloud.VirtualMachine. Kind: ClassType.

### Identity and monitoring ownership

Base class=System!System.LogicalEntity; hosted=false; singleton=false; declared properties=BoundaryId, VMId, Name, State, Status, ExpectedState, CurrentHost, Generation, ConfigurationVersion, ProcessorCount, DynamicMemoryEnabled, AssignedMemoryMB, CheckpointType, AutomaticStartAction, AutomaticStopAction. Inherited properties also apply. Inspect the exact instance and its monitoring path; inventory-only classes do not acquire health merely by appearing in a diagram.

### Read-only investigation

Run the matching read-only host/VM task. Match the stable VM ID and current owner, inspect Get-VM, attached disks, checkpoint chain and Hyper-V-VMMS/High-Availability logs. For management-service errors verify the named service and first failure rather than assuming every guest stopped.

### Corrective action and escalation

Restore the identified service, configuration, storage or VM dependency with the workload owner. Check intended shutdown and maintenance policy first. Never delete checkpoint files, force power operations or restart VMMS/hosts solely to clear an alert.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm the intended VM/service state, fresh host-derived evidence and the originating monitor. Guest application recovery requires a separate workload-level check.

### What this object represents

Stable VM identity that survives host migration. Workload-guest SCOM agents are not required. The current VirtualMachineRuntime instance supplies owner-specific observations; this object does not prove application health inside the guest.

### Microsoft references

[Microsoft Learn: hyper v start state access failures clustered standalone](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-start-state-access-failures-clustered-standalone)

[Microsoft Learn: hyper v virtual machine backup checkpoint storage](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-virtual-machine-backup-checkpoint-storage)


## Hyper-V Virtual Machine Runtime {#hypervprivatecloud.virtualmachineruntime}

`HyperVPrivateCloud.VirtualMachineRuntime`

Current host-owned execution context of a VM. Runtime ownership changes with placement; use VMId and the current host together. An old runtime or stale discovery is not a second independent VM failure.

### Support scope

Host-based Hyper-V workload or management evidence. A stopped VM must be compared with its intended state; inventory presence is not guest application monitoring.

Element: HyperVPrivateCloud.VirtualMachineRuntime. Kind: ClassType.

### Identity and monitoring ownership

Base class=Windows!Microsoft.Windows.LocalApplication; hosted=true; singleton=false; declared properties=RuntimeId, BoundaryId, VMId, Name, ExpectedState, CurrentHost. Inherited properties also apply. Inspect the exact instance and its monitoring path; inventory-only classes do not acquire health merely by appearing in a diagram.

### Read-only investigation

Run the matching read-only host/VM task. Match the stable VM ID and current owner, inspect Get-VM, attached disks, checkpoint chain and Hyper-V-VMMS/High-Availability logs. For management-service errors verify the named service and first failure rather than assuming every guest stopped.

### Corrective action and escalation

Restore the identified service, configuration, storage or VM dependency with the workload owner. Check intended shutdown and maintenance policy first. Never delete checkpoint files, force power operations or restart VMMS/hosts solely to clear an alert.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm the intended VM/service state, fresh host-derived evidence and the originating monitor. Guest application recovery requires a separate workload-level check.

### What this object represents

Current host-owned execution context of a VM. Runtime ownership changes with placement; use VMId and the current host together. An old runtime or stale discovery is not a second independent VM failure.

### Microsoft references

[Microsoft Learn: hyper v start state access failures clustered standalone](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-start-state-access-failures-clustered-standalone)

[Microsoft Learn: hyper v virtual machine backup checkpoint storage](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-virtual-machine-backup-checkpoint-storage)


## Hyper-V Virtual Hard Disk {#hypervprivatecloud.virtualharddisk}

`HyperVPrivateCloud.VirtualHardDisk`

Discovered virtual disk attachment/configuration identity. Trace the VM, host path and backing storage; appearing in inventory does not imply direct per-VHD filesystem or array health monitoring.

### Support scope

Host-based Hyper-V workload or management evidence. A stopped VM must be compared with its intended state; inventory presence is not guest application monitoring.

Element: HyperVPrivateCloud.VirtualHardDisk. Kind: ClassType.

### Identity and monitoring ownership

Base class=System!System.LogicalEntity; hosted=false; singleton=false; declared properties=BoundaryId, VMId, DiskId, Path, Format, DiskType, FileSizeBytes, MaximumSizeBytes, ControllerType, ControllerNumber, ControllerLocation. Inherited properties also apply. Inspect the exact instance and its monitoring path; inventory-only classes do not acquire health merely by appearing in a diagram.

### Read-only investigation

Run the matching read-only host/VM task. Match the stable VM ID and current owner, inspect Get-VM, attached disks, checkpoint chain and Hyper-V-VMMS/High-Availability logs. For management-service errors verify the named service and first failure rather than assuming every guest stopped.

### Corrective action and escalation

Restore the identified service, configuration, storage or VM dependency with the workload owner. Check intended shutdown and maintenance policy first. Never delete checkpoint files, force power operations or restart VMMS/hosts solely to clear an alert.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm the intended VM/service state, fresh host-derived evidence and the originating monitor. Guest application recovery requires a separate workload-level check.

### What this object represents

Discovered virtual disk attachment/configuration identity. Trace the VM, host path and backing storage; appearing in inventory does not imply direct per-VHD filesystem or array health monitoring.

### Microsoft references

[Microsoft Learn: hyper v start state access failures clustered standalone](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-start-state-access-failures-clustered-standalone)

[Microsoft Learn: hyper v virtual machine backup checkpoint storage](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-virtual-machine-backup-checkpoint-storage)


## Hyper-V Virtual Network Adapter {#hypervprivatecloud.virtualnetworkadapter}

`HyperVPrivateCloud.VirtualNetworkAdapter`

Discovered VM network adapter and its connectivity mapping. Follow its VM runtime and switch/network dependencies; no guest IP stack or application reachability is inferred from adapter presence.

### Support scope

Host network or external infrastructure evidence at the precise scope of the leaf. TCP reachability is not device hardware, firewall-policy or application health; linked vendor monitors retain their own authority.

Element: HyperVPrivateCloud.VirtualNetworkAdapter. Kind: ClassType.

### Identity and monitoring ownership

Base class=System!System.LogicalEntity; hosted=false; singleton=false; declared properties=BoundaryId, VMId, AdapterId, Name, SwitchId, SwitchName, MacAddress, Status, VlanSetting, IpAddresses. Inherited properties also apply. Inspect the exact instance and its monitoring path; inventory-only classes do not acquire health merely by appearing in a diagram.

### Read-only investigation

Identify the adapter, switch, port or configured endpoint and the actual observation source. Compare link state, negotiated speed and error/discard deltas with device-side evidence. Check routing and the intended port from the collector. An unreachable management endpoint does not by itself prove the data plane failed.

### Corrective action and escalation

Restore the specific path, cable/optic, approved switch configuration or device service with the network/hardware owner. Consult the vendor for proprietary device faults. Do not disable security controls, bounce all uplinks or reboot management devices based only on a failed TCP probe.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Repeat the original path test and confirm relevant native/vendor health. For cumulative errors, observe new deltas; do not expect historic totals to disappear.

### What this object represents

Discovered VM network adapter and its connectivity mapping. Follow its VM runtime and switch/network dependencies; no guest IP stack or application reachability is inferred from adapter presence.

### Microsoft references

[Microsoft Learn: troubleshoot tcp ip communication guidance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/networking/troubleshoot-tcp-ip-communication-guidance)


## Hyper-V Virtual Switch {#hypervprivatecloud.virtualswitch}

`HyperVPrivateCloud.VirtualSwitch`

Hyper-V virtual switch topology object. Its type, host and uplink association describe connectivity, while relevant host/network monitors provide health at their authored scope.

### Support scope

Host network or external infrastructure evidence at the precise scope of the leaf. TCP reachability is not device hardware, firewall-policy or application health; linked vendor monitors retain their own authority.

Element: HyperVPrivateCloud.VirtualSwitch. Kind: ClassType.

### Identity and monitoring ownership

Base class=Windows!Microsoft.Windows.LocalApplication; hosted=true; singleton=false; declared properties=SwitchId, Name, SwitchType, EmbeddedTeamingEnabled, IovEnabled, NetAdapterInterfaceDescriptions. Inherited properties also apply. Inspect the exact instance and its monitoring path; inventory-only classes do not acquire health merely by appearing in a diagram.

### Read-only investigation

Identify the adapter, switch, port or configured endpoint and the actual observation source. Compare link state, negotiated speed and error/discard deltas with device-side evidence. Check routing and the intended port from the collector. An unreachable management endpoint does not by itself prove the data plane failed.

### Corrective action and escalation

Restore the specific path, cable/optic, approved switch configuration or device service with the network/hardware owner. Consult the vendor for proprietary device faults. Do not disable security controls, bounce all uplinks or reboot management devices based only on a failed TCP probe.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Repeat the original path test and confirm relevant native/vendor health. For cumulative errors, observe new deltas; do not expect historic totals to disappear.

### What this object represents

Hyper-V virtual switch topology object. Its type, host and uplink association describe connectivity, while relevant host/network monitors provide health at their authored scope.

### Microsoft references

[Microsoft Learn: troubleshoot tcp ip communication guidance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/networking/troubleshoot-tcp-ip-communication-guidance)


## Hyper-V Replica Relationship {#hypervprivatecloud.replicationrelationship}

`HyperVPrivateCloud.ReplicationRelationship`

Discovered primary/replica relationship for a VM. It represents disaster-recovery topology; read replication monitors and current native replication evidence for protection health.

### Support scope

Host-observed replication state and disaster-recovery protection, not an application availability test inside the guest.

Element: HyperVPrivateCloud.ReplicationRelationship. Kind: ClassType.

### Identity and monitoring ownership

Base class=System!System.LogicalEntity; hosted=false; singleton=false; declared properties=BoundaryId, VMId, RelationshipId, Mode, State, Health, PrimaryServer, ReplicaServer, LastReplicationUtc. Inherited properties also apply. Inspect the exact instance and its monitoring path; inventory-only classes do not acquire health merely by appearing in a diagram.

### Read-only investigation

Use Get-VMReplication and Measure-VMReplication for the named VM on its owner. Inspect replication mode, primary/replica server, health, last replication time and backlog. For a cluster broker, follow network-name and broker resource dependencies. Distinguish planned pause, initial replication and unexpected loss of protection.

### Corrective action and escalation

Restore the actual authentication, certificate, broker, network or storage dependency. Coordinate resume or resynchronization with the recovery owner and verify bandwidth/storage impact. Never perform failover, reverse replication or remove/recreate protection solely to clear an alert.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm replication resumes and lag meets the agreed recovery-point objective. A healthy running primary VM alone does not establish healthy disaster recovery.

### What this object represents

Discovered primary/replica relationship for a VM. It represents disaster-recovery topology; read replication monitors and current native replication evidence for protection health.

### Microsoft references

[Microsoft Learn: hyper v replica troubleshooting guide](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-replica-troubleshooting-guide)


## Hyper-V Monitoring Pipeline {#hypervprivatecloud.monitoringpipeline}

`HyperVPrivateCloud.MonitoringPipeline`

Monitoring-path identity that helps locate collection and discovery problems. Inspect the actual pipeline monitors and last successful sample; a missing pipeline must not be interpreted as a healthy unmonitored host.

### Support scope

Monitoring capability, data collection or freshness. Failure means visibility is impaired; do not infer that the monitored workload itself is down or healthy.

Element: HyperVPrivateCloud.MonitoringPipeline. Kind: ClassType.

### Identity and monitoring ownership

Base class=Windows!Microsoft.Windows.LocalApplication; hosted=true; singleton=false; declared properties=PipelineId, DiscoveryStatus, LastDiscoveryUtc, LastProbeUtc, ErrorSummary. Inherited properties also apply. Inspect the exact instance and its monitoring path; inventory-only classes do not acquire health merely by appearing in a diagram.

### Read-only investigation

Read the first probe error and Operations Manager event context. Verify HealthService availability, supported PowerShell runtime, required modules, Run As scope and agent proxy where cross-object discovery requires it. Compare last successful sample and discovery time.

### Corrective action and escalation

Correct the missing runtime/module, access or source defect. Preserve logs before any approved HealthService restart. Do not reset health or clear the agent cache as a substitute for understanding a repeatable script error.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Require a new successful discovery/sample and initialized leaf monitors. Old green values cannot establish recovery of a broken collector.

### What this object represents

Monitoring-path identity that helps locate collection and discovery problems. Inspect the actual pipeline monitors and last successful sample; a missing pipeline must not be interpreted as a healthy unmonitored host.

### Microsoft references

[Microsoft Learn: manage consoles overview healthexplorer](https://learn.microsoft.com/en-us/system-center/scom/manage-consoles-overview-healthexplorer?view=sc-om-2025)


## Hyper-V Private Cloud {#hypervprivatecloud.service}

`HyperVPrivateCloud.Service`

Distributed application for one cluster, standalone host or VMM fabric boundary. It aggregates component health by aspect and is not itself a running Windows service.

### Support scope

A discovered identity, logical boundary, component group or health dependency in the private-cloud service model. Containment draws a diagram; only authored monitors and health dependencies determine its health.

Element: HyperVPrivateCloud.Service. Kind: ClassType.

### Identity and monitoring ownership

Base class=ServiceDesigner!Microsoft.SystemCenter.ServiceDesigner.Service; hosted=false; singleton=false; declared properties=BoundaryId, BoundaryType. Inherited properties also apply. Inspect the exact instance and its monitoring path; inventory-only classes do not acquire health merely by appearing in a diagram.

### Read-only investigation

Open Health Explorer from the unhealthy DA, follow the failing health aspect and dependency to the named leaf object, and read its state-change context and knowledge. Check whether the object is an inventory-only reference or an authoritative monitor target. Record the complete root-to-leaf path.

### Corrective action and escalation

Repair the originating leaf condition using its specific runbook and owner. Do not reset or edit a parent DA to conceal child health. Missing relationships or wrong aspect routing require a source change, tests and a new sealed MP version.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm fresh healthy leaf evidence and follow recovery through each dependency back to the solution root. Unknown/unmonitored objects and absent optional capabilities must not be described as fully monitored healthy services.

### What this object represents

Distributed application for one cluster, standalone host or VMM fabric boundary. It aggregates component health by aspect and is not itself a running Windows service.

### Microsoft references

[Microsoft Learn: manage consoles overview healthexplorer](https://learn.microsoft.com/en-us/system-center/scom/manage-consoles-overview-healthexplorer?view=sc-om-2025)


## Hyper-V Private Cloud Component {#hypervprivatecloud.componentgroup}

`HyperVPrivateCloud.ComponentGroup`

Common component-group base used by the service model. Derived branches collect selected domain health; this abstract grouping is not a physical device or an independently probed service.

### Support scope

A discovered identity, logical boundary, component group or health dependency in the private-cloud service model. Containment draws a diagram; only authored monitors and health dependencies determine its health.

Element: HyperVPrivateCloud.ComponentGroup. Kind: ClassType.

### Identity and monitoring ownership

Base class=ServiceDesigner!Microsoft.SystemCenter.ServiceDesigner.ServiceComponentGroup; hosted=false; singleton=false; declared properties=BoundaryId. Inherited properties also apply. Inspect the exact instance and its monitoring path; inventory-only classes do not acquire health merely by appearing in a diagram.

### Read-only investigation

Open Health Explorer from the unhealthy DA, follow the failing health aspect and dependency to the named leaf object, and read its state-change context and knowledge. Check whether the object is an inventory-only reference or an authoritative monitor target. Record the complete root-to-leaf path.

### Corrective action and escalation

Repair the originating leaf condition using its specific runbook and owner. Do not reset or edit a parent DA to conceal child health. Missing relationships or wrong aspect routing require a source change, tests and a new sealed MP version.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm fresh healthy leaf evidence and follow recovery through each dependency back to the solution root. Unknown/unmonitored objects and absent optional capabilities must not be described as fully monitored healthy services.

### What this object represents

Common component-group base used by the service model. Derived branches collect selected domain health; this abstract grouping is not a physical device or an independently probed service.

### Microsoft references

[Microsoft Learn: manage consoles overview healthexplorer](https://learn.microsoft.com/en-us/system-center/scom/manage-consoles-overview-healthexplorer?view=sc-om-2025)


## Management and Windows Services {#hypervprivatecloud.managementcomponent}

`HyperVPrivateCloud.ManagementComponent`

Management dependencies for the boundary, including authored host management, directory/DNS and optional VMM/SDN links. Management failure may prevent operations while already-running VMs remain available.

### Support scope

A discovered identity, logical boundary, component group or health dependency in the private-cloud service model. Containment draws a diagram; only authored monitors and health dependencies determine its health.

Element: HyperVPrivateCloud.ManagementComponent. Kind: ClassType.

### Identity and monitoring ownership

Base class=HyperVPrivateCloud.ComponentGroup; hosted=false; singleton=false; declared properties=. Inherited properties also apply. Inspect the exact instance and its monitoring path; inventory-only classes do not acquire health merely by appearing in a diagram.

### Read-only investigation

Open Health Explorer from the unhealthy DA, follow the failing health aspect and dependency to the named leaf object, and read its state-change context and knowledge. Check whether the object is an inventory-only reference or an authoritative monitor target. Record the complete root-to-leaf path.

### Corrective action and escalation

Repair the originating leaf condition using its specific runbook and owner. Do not reset or edit a parent DA to conceal child health. Missing relationships or wrong aspect routing require a source change, tests and a new sealed MP version.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm fresh healthy leaf evidence and follow recovery through each dependency back to the solution root. Unknown/unmonitored objects and absent optional capabilities must not be described as fully monitored healthy services.

### What this object represents

Management dependencies for the boundary, including authored host management, directory/DNS and optional VMM/SDN links. Management failure may prevent operations while already-running VMs remain available.

### Microsoft references

[Microsoft Learn: manage consoles overview healthexplorer](https://learn.microsoft.com/en-us/system-center/scom/manage-consoles-overview-healthexplorer?view=sc-om-2025)


## Compute {#hypervprivatecloud.computecomponent}

`HyperVPrivateCloud.ComputeComponent`

Host and compute infrastructure branch. Host aggregate dependencies can include management or storage prerequisites; follow the selected member monitor to distinguish compute pressure from a dependency failure.

### Support scope

A discovered identity, logical boundary, component group or health dependency in the private-cloud service model. Containment draws a diagram; only authored monitors and health dependencies determine its health.

Element: HyperVPrivateCloud.ComputeComponent. Kind: ClassType.

### Identity and monitoring ownership

Base class=HyperVPrivateCloud.ComponentGroup; hosted=false; singleton=false; declared properties=. Inherited properties also apply. Inspect the exact instance and its monitoring path; inventory-only classes do not acquire health merely by appearing in a diagram.

### Read-only investigation

Open Health Explorer from the unhealthy DA, follow the failing health aspect and dependency to the named leaf object, and read its state-change context and knowledge. Check whether the object is an inventory-only reference or an authoritative monitor target. Record the complete root-to-leaf path.

### Corrective action and escalation

Repair the originating leaf condition using its specific runbook and owner. Do not reset or edit a parent DA to conceal child health. Missing relationships or wrong aspect routing require a source change, tests and a new sealed MP version.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm fresh healthy leaf evidence and follow recovery through each dependency back to the solution root. Unknown/unmonitored objects and absent optional capabilities must not be described as fully monitored healthy services.

### What this object represents

Host and compute infrastructure branch. Host aggregate dependencies can include management or storage prerequisites; follow the selected member monitor to distinguish compute pressure from a dependency failure.

### Microsoft references

[Microsoft Learn: manage consoles overview healthexplorer](https://learn.microsoft.com/en-us/system-center/scom/manage-consoles-overview-healthexplorer?view=sc-om-2025)


## Virtual Machines {#hypervprivatecloud.virtualmachinecomponent}

`HyperVPrivateCloud.VirtualMachineComponent`

Host-observed VM runtime health branch. Power state, integration, disk, network and performance evidence are not a substitute for guest application monitoring.

### Support scope

Host-based Hyper-V workload or management evidence. A stopped VM must be compared with its intended state; inventory presence is not guest application monitoring.

Element: HyperVPrivateCloud.VirtualMachineComponent. Kind: ClassType.

### Identity and monitoring ownership

Base class=HyperVPrivateCloud.ComponentGroup; hosted=false; singleton=false; declared properties=. Inherited properties also apply. Inspect the exact instance and its monitoring path; inventory-only classes do not acquire health merely by appearing in a diagram.

### Read-only investigation

Run the matching read-only host/VM task. Match the stable VM ID and current owner, inspect Get-VM, attached disks, checkpoint chain and Hyper-V-VMMS/High-Availability logs. For management-service errors verify the named service and first failure rather than assuming every guest stopped.

### Corrective action and escalation

Restore the identified service, configuration, storage or VM dependency with the workload owner. Check intended shutdown and maintenance policy first. Never delete checkpoint files, force power operations or restart VMMS/hosts solely to clear an alert.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm the intended VM/service state, fresh host-derived evidence and the originating monitor. Guest application recovery requires a separate workload-level check.

### What this object represents

Host-observed VM runtime health branch. Power state, integration, disk, network and performance evidence are not a substitute for guest application monitoring.

### Microsoft references

[Microsoft Learn: hyper v start state access failures clustered standalone](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-start-state-access-failures-clustered-standalone)

[Microsoft Learn: hyper v virtual machine backup checkpoint storage](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-virtual-machine-backup-checkpoint-storage)


## Availability and Clustering {#hypervprivatecloud.availabilitycomponent}

`HyperVPrivateCloud.AvailabilityComponent`

Availability and clustering branch, including authored VM availability/replication signals and Microsoft cluster leaves. One failed clustered role can redden this branch without taking every node or VM down.

### Support scope

A discovered identity, logical boundary, component group or health dependency in the private-cloud service model. Containment draws a diagram; only authored monitors and health dependencies determine its health.

Element: HyperVPrivateCloud.AvailabilityComponent. Kind: ClassType.

### Identity and monitoring ownership

Base class=HyperVPrivateCloud.ComponentGroup; hosted=false; singleton=false; declared properties=. Inherited properties also apply. Inspect the exact instance and its monitoring path; inventory-only classes do not acquire health merely by appearing in a diagram.

### Read-only investigation

Open Health Explorer from the unhealthy DA, follow the failing health aspect and dependency to the named leaf object, and read its state-change context and knowledge. Check whether the object is an inventory-only reference or an authoritative monitor target. Record the complete root-to-leaf path.

### Corrective action and escalation

Repair the originating leaf condition using its specific runbook and owner. Do not reset or edit a parent DA to conceal child health. Missing relationships or wrong aspect routing require a source change, tests and a new sealed MP version.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm fresh healthy leaf evidence and follow recovery through each dependency back to the solution root. Unknown/unmonitored objects and absent optional capabilities must not be described as fully monitored healthy services.

### What this object represents

Availability and clustering branch, including authored VM availability/replication signals and Microsoft cluster leaves. One failed clustered role can redden this branch without taking every node or VM down.

### Microsoft references

[Microsoft Learn: manage consoles overview healthexplorer](https://learn.microsoft.com/en-us/system-center/scom/manage-consoles-overview-healthexplorer?view=sc-om-2025)


## Storage {#hypervprivatecloud.storagecomponent}

`HyperVPrivateCloud.StorageComponent`

Storage branch combining selected VM storage signals and installed storage capability/vendor dependencies. Follow a fault to its actual CSV, pool, host path or vendor source rather than assuming all storage failed.

### Support scope

A discovered identity, logical boundary, component group or health dependency in the private-cloud service model. Containment draws a diagram; only authored monitors and health dependencies determine its health.

Element: HyperVPrivateCloud.StorageComponent. Kind: ClassType.

### Identity and monitoring ownership

Base class=HyperVPrivateCloud.ComponentGroup; hosted=false; singleton=false; declared properties=. Inherited properties also apply. Inspect the exact instance and its monitoring path; inventory-only classes do not acquire health merely by appearing in a diagram.

### Read-only investigation

Open Health Explorer from the unhealthy DA, follow the failing health aspect and dependency to the named leaf object, and read its state-change context and knowledge. Check whether the object is an inventory-only reference or an authoritative monitor target. Record the complete root-to-leaf path.

### Corrective action and escalation

Repair the originating leaf condition using its specific runbook and owner. Do not reset or edit a parent DA to conceal child health. Missing relationships or wrong aspect routing require a source change, tests and a new sealed MP version.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm fresh healthy leaf evidence and follow recovery through each dependency back to the solution root. Unknown/unmonitored objects and absent optional capabilities must not be described as fully monitored healthy services.

### What this object represents

Storage branch combining selected VM storage signals and installed storage capability/vendor dependencies. Follow a fault to its actual CSV, pool, host path or vendor source rather than assuming all storage failed.

### Microsoft references

[Microsoft Learn: manage consoles overview healthexplorer](https://learn.microsoft.com/en-us/system-center/scom/manage-consoles-overview-healthexplorer?view=sc-om-2025)


## Networking {#hypervprivatecloud.networkcomponent}

`HyperVPrivateCloud.NetworkComponent`

Networking branch combining selected VM, host, physical-network and optional ATC/SDN/VMM network dependencies. Separate management endpoint reachability, control-plane configuration and tenant data-plane availability.

### Support scope

Host network or external infrastructure evidence at the precise scope of the leaf. TCP reachability is not device hardware, firewall-policy or application health; linked vendor monitors retain their own authority.

Element: HyperVPrivateCloud.NetworkComponent. Kind: ClassType.

### Identity and monitoring ownership

Base class=HyperVPrivateCloud.ComponentGroup; hosted=false; singleton=false; declared properties=. Inherited properties also apply. Inspect the exact instance and its monitoring path; inventory-only classes do not acquire health merely by appearing in a diagram.

### Read-only investigation

Identify the adapter, switch, port or configured endpoint and the actual observation source. Compare link state, negotiated speed and error/discard deltas with device-side evidence. Check routing and the intended port from the collector. An unreachable management endpoint does not by itself prove the data plane failed.

### Corrective action and escalation

Restore the specific path, cable/optic, approved switch configuration or device service with the network/hardware owner. Consult the vendor for proprietary device faults. Do not disable security controls, bounce all uplinks or reboot management devices based only on a failed TCP probe.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Repeat the original path test and confirm relevant native/vendor health. For cumulative errors, observe new deltas; do not expect historic totals to disappear.

### What this object represents

Networking branch combining selected VM, host, physical-network and optional ATC/SDN/VMM network dependencies. Separate management endpoint reachability, control-plane configuration and tenant data-plane availability.

### Microsoft references

[Microsoft Learn: troubleshoot tcp ip communication guidance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/networking/troubleshoot-tcp-ip-communication-guidance)


## Monitoring Pipeline {#hypervprivatecloud.monitoringcomponent}

`HyperVPrivateCloud.MonitoringComponent`

Monitoring Pipeline branch for visibility and collection prerequisites. Unhealthy monitoring can invalidate confidence in old green workload states; repair telemetry and require fresh samples.

### Support scope

Monitoring capability, data collection or freshness. Failure means visibility is impaired; do not infer that the monitored workload itself is down or healthy.

Element: HyperVPrivateCloud.MonitoringComponent. Kind: ClassType.

### Identity and monitoring ownership

Base class=HyperVPrivateCloud.ComponentGroup; hosted=false; singleton=false; declared properties=. Inherited properties also apply. Inspect the exact instance and its monitoring path; inventory-only classes do not acquire health merely by appearing in a diagram.

### Read-only investigation

Read the first probe error and Operations Manager event context. Verify HealthService availability, supported PowerShell runtime, required modules, Run As scope and agent proxy where cross-object discovery requires it. Compare last successful sample and discovery time.

### Corrective action and escalation

Correct the missing runtime/module, access or source defect. Preserve logs before any approved HealthService restart. Do not reset health or clear the agent cache as a substitute for understanding a repeatable script error.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Require a new successful discovery/sample and initialized leaf monitors. Old green values cannot establish recovery of a broken collector.

### What this object represents

Monitoring Pipeline branch for visibility and collection prerequisites. Unhealthy monitoring can invalidate confidence in old green workload states; repair telemetry and require fresh samples.

### Microsoft references

[Microsoft Learn: manage consoles overview healthexplorer](https://learn.microsoft.com/en-us/system-center/scom/manage-consoles-overview-healthexplorer?view=sc-om-2025)


## Hyper-V Private Cloud {#hypervprivatecloud.enterprise.solution}

`HyperVPrivateCloud.Enterprise.Solution`

Singleton root named Hyper-V Private Cloud. It summarizes Hyper-V Fabric and Management Stack across discovered boundaries. A red root identifies a contributing dependency, not a total private-cloud outage.

### Support scope

A discovered identity, logical boundary, component group or health dependency in the private-cloud service model. Containment draws a diagram; only authored monitors and health dependencies determine its health.

Element: HyperVPrivateCloud.Enterprise.Solution. Kind: ClassType.

### Identity and monitoring ownership

Base class=ServiceDesigner!Microsoft.SystemCenter.ServiceDesigner.Service; hosted=false; singleton=true; declared properties=. Inherited properties also apply. Inspect the exact instance and its monitoring path; inventory-only classes do not acquire health merely by appearing in a diagram.

### Read-only investigation

Open Health Explorer from the unhealthy DA, follow the failing health aspect and dependency to the named leaf object, and read its state-change context and knowledge. Check whether the object is an inventory-only reference or an authoritative monitor target. Record the complete root-to-leaf path.

### Corrective action and escalation

Repair the originating leaf condition using its specific runbook and owner. Do not reset or edit a parent DA to conceal child health. Missing relationships or wrong aspect routing require a source change, tests and a new sealed MP version.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm fresh healthy leaf evidence and follow recovery through each dependency back to the solution root. Unknown/unmonitored objects and absent optional capabilities must not be described as fully monitored healthy services.

### What this object represents

Singleton root named Hyper-V Private Cloud. It summarizes Hyper-V Fabric and Management Stack across discovered boundaries. A red root identifies a contributing dependency, not a total private-cloud outage.

### Microsoft references

[Microsoft Learn: manage consoles overview healthexplorer](https://learn.microsoft.com/en-us/system-center/scom/manage-consoles-overview-healthexplorer?view=sc-om-2025)


## Hyper-V Fabric {#hypervprivatecloud.enterprise.fabric}

`HyperVPrivateCloud.Enterprise.Fabric`

Singleton fabric DA containing discovered cluster, standalone and VMM service boundaries. Drill into the specific boundary and health aspect to determine impact.

### Support scope

A discovered identity, logical boundary, component group or health dependency in the private-cloud service model. Containment draws a diagram; only authored monitors and health dependencies determine its health.

Element: HyperVPrivateCloud.Enterprise.Fabric. Kind: ClassType.

### Identity and monitoring ownership

Base class=ServiceDesigner!Microsoft.SystemCenter.ServiceDesigner.Service; hosted=false; singleton=true; declared properties=. Inherited properties also apply. Inspect the exact instance and its monitoring path; inventory-only classes do not acquire health merely by appearing in a diagram.

### Read-only investigation

Open Health Explorer from the unhealthy DA, follow the failing health aspect and dependency to the named leaf object, and read its state-change context and knowledge. Check whether the object is an inventory-only reference or an authoritative monitor target. Record the complete root-to-leaf path.

### Corrective action and escalation

Repair the originating leaf condition using its specific runbook and owner. Do not reset or edit a parent DA to conceal child health. Missing relationships or wrong aspect routing require a source change, tests and a new sealed MP version.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm fresh healthy leaf evidence and follow recovery through each dependency back to the solution root. Unknown/unmonitored objects and absent optional capabilities must not be described as fully monitored healthy services.

### What this object represents

Singleton fabric DA containing discovered cluster, standalone and VMM service boundaries. Drill into the specific boundary and health aspect to determine impact.

### Microsoft references

[Microsoft Learn: manage consoles overview healthexplorer](https://learn.microsoft.com/en-us/system-center/scom/manage-consoles-overview-healthexplorer?view=sc-om-2025)


## Management Stack {#hypervprivatecloud.enterprise.managementstack}

`HyperVPrivateCloud.Enterprise.ManagementStack`

Singleton DA collecting boundary Management and Monitoring Pipeline components. Shared dependencies can legitimately appear here and under their fabric boundary; these are multiple impact paths, not necessarily duplicate incidents.

### Support scope

A discovered identity, logical boundary, component group or health dependency in the private-cloud service model. Containment draws a diagram; only authored monitors and health dependencies determine its health.

Element: HyperVPrivateCloud.Enterprise.ManagementStack. Kind: ClassType.

### Identity and monitoring ownership

Base class=ServiceDesigner!Microsoft.SystemCenter.ServiceDesigner.Service; hosted=false; singleton=true; declared properties=. Inherited properties also apply. Inspect the exact instance and its monitoring path; inventory-only classes do not acquire health merely by appearing in a diagram.

### Read-only investigation

Open Health Explorer from the unhealthy DA, follow the failing health aspect and dependency to the named leaf object, and read its state-change context and knowledge. Check whether the object is an inventory-only reference or an authoritative monitor target. Record the complete root-to-leaf path.

### Corrective action and escalation

Repair the originating leaf condition using its specific runbook and owner. Do not reset or edit a parent DA to conceal child health. Missing relationships or wrong aspect routing require a source change, tests and a new sealed MP version.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm fresh healthy leaf evidence and follow recovery through each dependency back to the solution root. Unknown/unmonitored objects and absent optional capabilities must not be described as fully monitored healthy services.

### What this object represents

Singleton DA collecting boundary Management and Monitoring Pipeline components. Shared dependencies can legitimately appear here and under their fabric boundary; these are multiple impact paths, not necessarily duplicate incidents.

### Microsoft references

[Microsoft Learn: manage consoles overview healthexplorer](https://learn.microsoft.com/en-us/system-center/scom/manage-consoles-overview-healthexplorer?view=sc-om-2025)


## Active Directory Management Domain {#hypervprivatecloud.activedirectoryservice}

`HyperVPrivateCloud.ActiveDirectoryService`

Discovered directory dependency or configured service endpoint. Host secure-channel/DC-discovery observations are narrower than full Active Directory domain-controller health; use the AD team and native AD management pack for deeper assessment.

### Support scope

Host-observed domain and secure-channel dependency, not an exhaustive domain-controller replication or AD health assessment.

Element: HyperVPrivateCloud.ActiveDirectoryService. Kind: ClassType.

### Identity and monitoring ownership

Base class=System!System.LogicalEntity; hosted=false; singleton=false; declared properties=BoundaryId, DomainFqdn, DomainNetbiosName, ForestFqdn, DomainControllerAffinity, SiteName. Inherited properties also apply. Inspect the exact instance and its monitoring path; inventory-only classes do not acquire health merely by appearing in a diagram.

### Read-only investigation

Run the read-only domain diagnostic from the affected host. Verify DNS/DC discovery, time synchronization, network reachability and Test-ComputerSecureChannel without -Repair. Correlate NETLOGON errors with directory-team evidence.

### Corrective action and escalation

Restore DNS/time/connectivity first where indicated. If the machine account trust is genuinely broken, use the approved directory recovery procedure with the AD owner. Do not unjoin/rejoin a clustered host or reset machine passwords as a first response.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Repeat the secure-channel and domain discovery checks, verify normal authentication and fresh monitor recovery.

### What this object represents

Discovered directory dependency or configured service endpoint. Host secure-channel/DC-discovery observations are narrower than full Active Directory domain-controller health; use the AD team and native AD management pack for deeper assessment.

### Microsoft references

[Microsoft Learn: broken trust relationship domain joined device its domain secure channel issues](https://learn.microsoft.com/en-us/troubleshoot/windows-server/windows-security/broken-trust-relationship-domain-joined-device-its-domain-secure-channel-issues)


## DNS Infrastructure Service {#hypervprivatecloud.dnsservice}

`HyperVPrivateCloud.DnsService`

Discovered DNS dependency or configured endpoint. A successful resolution/port check is scoped to the tested request and collector, not every zone or DNS client.

### Support scope

DNS service or name-resolution dependency as tested by the configured probe, not proof that every zone or client is healthy.

Element: HyperVPrivateCloud.DnsService. Kind: ClassType.

### Identity and monitoring ownership

Base class=System!System.LogicalEntity; hosted=false; singleton=false; declared properties=BoundaryId, DnsServerAddresses, PrimaryDnsServer, DnsSuffixSearchList. Inherited properties also apply. Inspect the exact instance and its monitoring path; inventory-only classes do not acquire health merely by appearing in a diagram.

### Read-only investigation

Run the DNS diagnostic on the affected host. Record queried name/type, configured resolver, response/error and forward/SRV results. Compare another resolver and another client to distinguish client configuration, path and authoritative-server failures.

### Corrective action and escalation

Correct the proven resolver, zone, record, forwarding or network issue with the DNS owner. Avoid global cache flushes or DNS-service restarts without a specific reason.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Repeat the same failing query from the original host and confirm fresh monitoring evidence, not merely a cached successful answer from another machine.

### What this object represents

Discovered DNS dependency or configured endpoint. A successful resolution/port check is scoped to the tested request and collector, not every zone or DNS client.

### Microsoft references

[Microsoft Learn: troubleshoot dns guidance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/networking/troubleshoot-dns-guidance)

[Microsoft Learn: troubleshoot dns server](https://learn.microsoft.com/en-us/windows-server/networking/dns/troubleshoot/troubleshoot-dns-server)


## Bare-Metal Deployment Service (WDS/PXE) {#hypervprivatecloud.deploymentservice}

`HyperVPrivateCloud.DeploymentService`

Bare-metal deployment/PXE/WDS dependency. Loss can prevent provisioning without affecting running VMs. Only the authored service/endpoint checks are measured; a complete PXE boot transaction needs separate validation.

### Support scope

Host-based Hyper-V workload or management evidence. A stopped VM must be compared with its intended state; inventory presence is not guest application monitoring.

Element: HyperVPrivateCloud.DeploymentService. Kind: ClassType.

### Identity and monitoring ownership

Base class=System!System.LogicalEntity; hosted=false; singleton=false; declared properties=BoundaryId, ServerName, WdsStatus, TftpListenerPort, PxeProvider. Inherited properties also apply. Inspect the exact instance and its monitoring path; inventory-only classes do not acquire health merely by appearing in a diagram.

### Read-only investigation

Run the matching read-only host/VM task. Match the stable VM ID and current owner, inspect Get-VM, attached disks, checkpoint chain and Hyper-V-VMMS/High-Availability logs. For management-service errors verify the named service and first failure rather than assuming every guest stopped.

### Corrective action and escalation

Restore the identified service, configuration, storage or VM dependency with the workload owner. Check intended shutdown and maintenance policy first. Never delete checkpoint files, force power operations or restart VMMS/hosts solely to clear an alert.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm the intended VM/service state, fresh host-derived evidence and the originating monitor. Guest application recovery requires a separate workload-level check.

### What this object represents

Bare-metal deployment/PXE/WDS dependency. Loss can prevent provisioning without affecting running VMs. Only the authored service/endpoint checks are measured; a complete PXE boot transaction needs separate validation.

### Microsoft references

[Microsoft Learn: hyper v start state access failures clustered standalone](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-start-state-access-failures-clustered-standalone)

[Microsoft Learn: hyper v virtual machine backup checkpoint storage](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-virtual-machine-backup-checkpoint-storage)


## Physical Server Chassis {#hypervprivatecloud.physicalchassis}

`HyperVPrivateCloud.PhysicalChassis`

Physical host enclosure or configured hardware-management endpoint. Basic reachability does not establish power, fan, temperature or drive health; hardware depth requires the vendor/native health source.

### Support scope

Host network or external infrastructure evidence at the precise scope of the leaf. TCP reachability is not device hardware, firewall-policy or application health; linked vendor monitors retain their own authority.

Element: HyperVPrivateCloud.PhysicalChassis. Kind: ClassType.

### Identity and monitoring ownership

Base class=System!System.LogicalEntity; hosted=false; singleton=false; declared properties=BoundaryId, ChassisId, Manufacturer, Model, SerialNumber, AssetTag, BmcIpv4Address. Inherited properties also apply. Inspect the exact instance and its monitoring path; inventory-only classes do not acquire health merely by appearing in a diagram.

### Read-only investigation

Identify the adapter, switch, port or configured endpoint and the actual observation source. Compare link state, negotiated speed and error/discard deltas with device-side evidence. Check routing and the intended port from the collector. An unreachable management endpoint does not by itself prove the data plane failed.

### Corrective action and escalation

Restore the specific path, cable/optic, approved switch configuration or device service with the network/hardware owner. Consult the vendor for proprietary device faults. Do not disable security controls, bounce all uplinks or reboot management devices based only on a failed TCP probe.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Repeat the original path test and confirm relevant native/vendor health. For cumulative errors, observe new deltas; do not expect historic totals to disappear.

### What this object represents

Physical host enclosure or configured hardware-management endpoint. Basic reachability does not establish power, fan, temperature or drive health; hardware depth requires the vendor/native health source.

### Microsoft references

[Microsoft Learn: troubleshoot tcp ip communication guidance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/networking/troubleshoot-tcp-ip-communication-guidance)


## Top-of-Rack Switch {#hypervprivatecloud.topofrackswitch}

`HyperVPrivateCloud.TopOfRackSwitch`

Data-switch topology or configured endpoint used by the private-cloud network. Host uplink correlation and device health are separate evidence sources; a reachable management port does not prove every forwarding path works.

### Support scope

Host network or external infrastructure evidence at the precise scope of the leaf. TCP reachability is not device hardware, firewall-policy or application health; linked vendor monitors retain their own authority.

Element: HyperVPrivateCloud.TopOfRackSwitch. Kind: ClassType.

### Identity and monitoring ownership

Base class=System!System.LogicalEntity; hosted=false; singleton=false; declared properties=BoundaryId, SwitchId, SwitchName, ManagementIp, Role. Inherited properties also apply. Inspect the exact instance and its monitoring path; inventory-only classes do not acquire health merely by appearing in a diagram.

### Read-only investigation

Identify the adapter, switch, port or configured endpoint and the actual observation source. Compare link state, negotiated speed and error/discard deltas with device-side evidence. Check routing and the intended port from the collector. An unreachable management endpoint does not by itself prove the data plane failed.

### Corrective action and escalation

Restore the specific path, cable/optic, approved switch configuration or device service with the network/hardware owner. Consult the vendor for proprietary device faults. Do not disable security controls, bounce all uplinks or reboot management devices based only on a failed TCP probe.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Repeat the original path test and confirm relevant native/vendor health. For cumulative errors, observe new deltas; do not expect historic totals to disappear.

### What this object represents

Data-switch topology or configured endpoint used by the private-cloud network. Host uplink correlation and device health are separate evidence sources; a reachable management port does not prove every forwarding path works.

### Microsoft references

[Microsoft Learn: troubleshoot tcp ip communication guidance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/networking/troubleshoot-tcp-ip-communication-guidance)


## Out-of-Band Management Switch {#hypervprivatecloud.outofbandswitch}

`HyperVPrivateCloud.OutOfBandSwitch`

Out-of-band management-switch dependency. Its failure can impair remote recovery while workload data networks remain operational; require device-side evidence for switch hardware/port health.

### Support scope

Host network or external infrastructure evidence at the precise scope of the leaf. TCP reachability is not device hardware, firewall-policy or application health; linked vendor monitors retain their own authority.

Element: HyperVPrivateCloud.OutOfBandSwitch. Kind: ClassType.

### Identity and monitoring ownership

Base class=System!System.LogicalEntity; hosted=false; singleton=false; declared properties=BoundaryId, SwitchId, SwitchName, ManagementIp. Inherited properties also apply. Inspect the exact instance and its monitoring path; inventory-only classes do not acquire health merely by appearing in a diagram.

### Read-only investigation

Identify the adapter, switch, port or configured endpoint and the actual observation source. Compare link state, negotiated speed and error/discard deltas with device-side evidence. Check routing and the intended port from the collector. An unreachable management endpoint does not by itself prove the data plane failed.

### Corrective action and escalation

Restore the specific path, cable/optic, approved switch configuration or device service with the network/hardware owner. Consult the vendor for proprietary device faults. Do not disable security controls, bounce all uplinks or reboot management devices based only on a failed TCP probe.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Repeat the original path test and confirm relevant native/vendor health. For cumulative errors, observe new deltas; do not expect historic totals to disappear.

### What this object represents

Out-of-band management-switch dependency. Its failure can impair remote recovery while workload data networks remain operational; require device-side evidence for switch hardware/port health.

### Microsoft references

[Microsoft Learn: troubleshoot tcp ip communication guidance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/networking/troubleshoot-tcp-ip-communication-guidance)


## Perimeter Edge Firewall {#hypervprivatecloud.edgefirewall}

`HyperVPrivateCloud.EdgeFirewall`

Perimeter/firewall dependency or configured endpoint. TCP reachability does not test all firewall rules, HA state, routing or tenant egress; use the firewall vendor monitoring and a representative flow test.

### Support scope

Host network or external infrastructure evidence at the precise scope of the leaf. TCP reachability is not device hardware, firewall-policy or application health; linked vendor monitors retain their own authority.

Element: HyperVPrivateCloud.EdgeFirewall. Kind: ClassType.

### Identity and monitoring ownership

Base class=System!System.LogicalEntity; hosted=false; singleton=false; declared properties=BoundaryId, FirewallId, DeviceName, ManagementIp, HaRole. Inherited properties also apply. Inspect the exact instance and its monitoring path; inventory-only classes do not acquire health merely by appearing in a diagram.

### Read-only investigation

Identify the adapter, switch, port or configured endpoint and the actual observation source. Compare link state, negotiated speed and error/discard deltas with device-side evidence. Check routing and the intended port from the collector. An unreachable management endpoint does not by itself prove the data plane failed.

### Corrective action and escalation

Restore the specific path, cable/optic, approved switch configuration or device service with the network/hardware owner. Consult the vendor for proprietary device faults. Do not disable security controls, bounce all uplinks or reboot management devices based only on a failed TCP probe.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Repeat the original path test and confirm relevant native/vendor health. For cumulative errors, observe new deltas; do not expect historic totals to disappear.

### What this object represents

Perimeter/firewall dependency or configured endpoint. TCP reachability does not test all firewall rules, HA state, routing or tenant egress; use the firewall vendor monitoring and a representative flow test.

### Microsoft references

[Microsoft Learn: troubleshoot tcp ip communication guidance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/networking/troubleshoot-tcp-ip-communication-guidance)


## Opengear Out-of-Band Console Server {#hypervprivatecloud.consoleserver}

`HyperVPrivateCloud.ConsoleServer`

Remote serial/console access dependency. Health describes the monitored management path, not the health of every attached device. Preserve alternative recovery access during changes.

### Support scope

Host network or external infrastructure evidence at the precise scope of the leaf. TCP reachability is not device hardware, firewall-policy or application health; linked vendor monitors retain their own authority.

Element: HyperVPrivateCloud.ConsoleServer. Kind: ClassType.

### Identity and monitoring ownership

Base class=System!System.LogicalEntity; hosted=false; singleton=false; declared properties=BoundaryId, ApplianceId, Hostname, ManagementIp, Model. Inherited properties also apply. Inspect the exact instance and its monitoring path; inventory-only classes do not acquire health merely by appearing in a diagram.

### Read-only investigation

Identify the adapter, switch, port or configured endpoint and the actual observation source. Compare link state, negotiated speed and error/discard deltas with device-side evidence. Check routing and the intended port from the collector. An unreachable management endpoint does not by itself prove the data plane failed.

### Corrective action and escalation

Restore the specific path, cable/optic, approved switch configuration or device service with the network/hardware owner. Consult the vendor for proprietary device faults. Do not disable security controls, bounce all uplinks or reboot management devices based only on a failed TCP probe.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Repeat the original path test and confirm relevant native/vendor health. For cumulative errors, observe new deltas; do not expect historic totals to disappear.

### What this object represents

Remote serial/console access dependency. Health describes the monitored management path, not the health of every attached device. Preserve alternative recovery access during changes.

### Microsoft references

[Microsoft Learn: troubleshoot tcp ip communication guidance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/networking/troubleshoot-tcp-ip-communication-guidance)


## DHCP and IPAM Infrastructure {#hypervprivatecloud.dhcpservice}

`HyperVPrivateCloud.DhcpService`

Address-assignment dependency or configured endpoint. Service/port checks do not establish free leases, authorization or end-to-end relay behavior unless separately measured.

### Support scope

Configured DHCP service reachability/health evidence. This is not an exhaustive lease, scope or client transaction monitor unless the leaf explicitly measures those facts.

Element: HyperVPrivateCloud.DhcpService. Kind: ClassType.

### Identity and monitoring ownership

Base class=System!System.LogicalEntity; hosted=false; singleton=false; declared properties=BoundaryId, ServiceId, ServerName, ScopeRange, ProviderType. Inherited properties also apply. Inspect the exact instance and its monitoring path; inventory-only classes do not acquire health merely by appearing in a diagram.

### Read-only investigation

Check the named DHCP endpoint, service status, authorization, applicable scope free leases and relay path with the DHCP owner. Compare a client on the server subnet with one behind the affected relay.

### Corrective action and escalation

Correct the proven service, scope or relay issue through approved network change control. Do not authorize unknown DHCP servers or change scope ranges to clear a reachability alarm.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm the configured probe and a representative lease transaction recover without address conflicts.

### What this object represents

Address-assignment dependency or configured endpoint. Service/port checks do not establish free leases, authorization or end-to-end relay behavior unless separately measured.

### Microsoft references

[Microsoft Learn: troubleshoot dhcp guidance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/networking/troubleshoot-dhcp-guidance)


## Hyper-V Private Cloud Objects {#hypervprivatecloud.product.group}

`HyperVPrivateCloud.Product.Group`

Product-scoping group for views and selection. Membership is not a separate service-level monitor and must not be mistaken for the main enterprise solution DA.

### Support scope

A discovered identity, logical boundary, component group or health dependency in the private-cloud service model. Containment draws a diagram; only authored monitors and health dependencies determine its health.

Element: HyperVPrivateCloud.Product.Group. Kind: ClassType.

### Identity and monitoring ownership

Base class=InstanceGroup!Microsoft.SystemCenter.InstanceGroup; hosted=false; singleton=true; declared properties=. Inherited properties also apply. Inspect the exact instance and its monitoring path; inventory-only classes do not acquire health merely by appearing in a diagram.

### Read-only investigation

Open Health Explorer from the unhealthy DA, follow the failing health aspect and dependency to the named leaf object, and read its state-change context and knowledge. Check whether the object is an inventory-only reference or an authoritative monitor target. Record the complete root-to-leaf path.

### Corrective action and escalation

Repair the originating leaf condition using its specific runbook and owner. Do not reset or edit a parent DA to conceal child health. Missing relationships or wrong aspect routing require a source change, tests and a new sealed MP version.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm fresh healthy leaf evidence and follow recovery through each dependency back to the solution root. Unknown/unmonitored objects and absent optional capabilities must not be described as fully monitored healthy services.

### What this object represents

Product-scoping group for views and selection. Membership is not a separate service-level monitor and must not be mistaken for the main enterprise solution DA.

### Microsoft references

[Microsoft Learn: manage consoles overview healthexplorer](https://learn.microsoft.com/en-us/system-center/scom/manage-consoles-overview-healthexplorer?view=sc-om-2025)
