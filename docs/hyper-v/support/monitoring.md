# Hyper-V Private Cloud Monitoring

Generated support reference. [All capabilities](catalog.md) · [Day-2 triage](index.md).

Default conditions below come from the compiled candidate source, not the effective overrides in your management group. Read the monitor-specific knowledge together with the common safety and verification guidance. Microsoft links explain the underlying technology; product thresholds are not Microsoft recommendations.

## Collect Hyper-V hypervisor logical processor total run time {#hypervprivatecloud.host.cpu.collection.rule}

`HyperVPrivateCloud.Host.Cpu.Collection.Rule`

Collects total logical processor run time percentage across all physical CPU cores on the host.

### Support scope

Measured resource pressure or I/O delay. A warning is an opportunity to investigate headroom; a threshold crossing alone does not identify the defective component or predict a failure time.

Element: HyperVPrivateCloud.Host.Cpu.Collection.Rule. Kind: Rule.

### Alert versus health

Target=HCSV2Library!HyperVPrivateCloud.HostRole; enabled=true; category=PerformanceCollection. Rules collect data or raise event alerts; they do not themselves create unit-monitor health transitions. Repeated or unresolved rule alerts do not by themselves explain a red DA. Correlate with current leaf monitors and event timestamps before closure.

### Read-only investigation

Record the named counter, measured value, units, sampling interval and effective thresholds. Compare a representative time series with workload changes, host placement and storage/network evidence. Separate host/root/guest CPU and assigned/demanded memory. Missing counters are a telemetry problem, not zero utilization.

### Corrective action and escalation

Address the identified contention, workload placement or failing path with its owner. Capacity changes require a headroom and failover-reserve check. Do not blindly increase thresholds, reboot hosts or reduce VM resources to suppress symptoms.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Observe the same metric over a representative load period, confirm sustained recovery and verify workload response independently. Product defaults require site-specific review and are not Microsoft service-level guarantees.

### Microsoft references

[Microsoft Learn: troubleshoot hyper v virtual machine performance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/troubleshoot-hyper-v-virtual-machine-performance)


## Collect host available memory {#hypervprivatecloud.host.availablememory.collection.rule}

`HyperVPrivateCloud.Host.AvailableMemory.Collection.Rule`

Collects available physical memory on the host in megabytes.

### Support scope

Measured resource pressure or I/O delay. A warning is an opportunity to investigate headroom; a threshold crossing alone does not identify the defective component or predict a failure time.

Element: HyperVPrivateCloud.Host.AvailableMemory.Collection.Rule. Kind: Rule.

### Alert versus health

Target=HCSV2Library!HyperVPrivateCloud.HostRole; enabled=true; category=PerformanceCollection. Rules collect data or raise event alerts; they do not themselves create unit-monitor health transitions. Repeated or unresolved rule alerts do not by themselves explain a red DA. Correlate with current leaf monitors and event timestamps before closure.

### Read-only investigation

Record the named counter, measured value, units, sampling interval and effective thresholds. Compare a representative time series with workload changes, host placement and storage/network evidence. Separate host/root/guest CPU and assigned/demanded memory. Missing counters are a telemetry problem, not zero utilization.

### Corrective action and escalation

Address the identified contention, workload placement or failing path with its owner. Capacity changes require a headroom and failover-reserve check. Do not blindly increase thresholds, reboot hosts or reduce VM resources to suppress symptoms.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Observe the same metric over a representative load period, confirm sustained recovery and verify workload response independently. Product defaults require site-specific review and are not Microsoft service-level guarantees.

### Microsoft references

[Microsoft Learn: troubleshoot hyper v virtual machine performance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/troubleshoot-hyper-v-virtual-machine-performance)


## Collect Hyper-V Dynamic Memory balancer available memory {#hypervprivatecloud.host.dynamicmemoryavailable.collection.rule}

`HyperVPrivateCloud.Host.DynamicMemoryAvailable.Collection.Rule`

Collects available memory reported by the Hyper-V Dynamic Memory balancer in megabytes.

### Support scope

Measured resource pressure or I/O delay. A warning is an opportunity to investigate headroom; a threshold crossing alone does not identify the defective component or predict a failure time.

Element: HyperVPrivateCloud.Host.DynamicMemoryAvailable.Collection.Rule. Kind: Rule.

### Alert versus health

Target=HCSV2Library!HyperVPrivateCloud.HostRole; enabled=true; category=PerformanceCollection. Rules collect data or raise event alerts; they do not themselves create unit-monitor health transitions. Repeated or unresolved rule alerts do not by themselves explain a red DA. Correlate with current leaf monitors and event timestamps before closure.

### Read-only investigation

Record the named counter, measured value, units, sampling interval and effective thresholds. Compare a representative time series with workload changes, host placement and storage/network evidence. Separate host/root/guest CPU and assigned/demanded memory. Missing counters are a telemetry problem, not zero utilization.

### Corrective action and escalation

Address the identified contention, workload placement or failing path with its owner. Capacity changes require a headroom and failover-reserve check. Do not blindly increase thresholds, reboot hosts or reduce VM resources to suppress symptoms.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Observe the same metric over a representative load period, confirm sustained recovery and verify workload response independently. Product defaults require site-specific review and are not Microsoft service-level guarantees.

### Microsoft references

[Microsoft Learn: troubleshoot hyper v virtual machine performance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/troubleshoot-hyper-v-virtual-machine-performance)


## Collect Hyper-V virtual processor total run time {#hypervprivatecloud.host.virtualprocessor.collection.rule}

`HyperVPrivateCloud.Host.VirtualProcessor.Collection.Rule`

Collects total run time percentage for all hypervisor virtual processors on the host.

### Support scope

Measured resource pressure or I/O delay. A warning is an opportunity to investigate headroom; a threshold crossing alone does not identify the defective component or predict a failure time.

Element: HyperVPrivateCloud.Host.VirtualProcessor.Collection.Rule. Kind: Rule.

### Alert versus health

Target=HCSV2Library!HyperVPrivateCloud.HostRole; enabled=true; category=PerformanceCollection. Rules collect data or raise event alerts; they do not themselves create unit-monitor health transitions. Repeated or unresolved rule alerts do not by themselves explain a red DA. Correlate with current leaf monitors and event timestamps before closure.

### Read-only investigation

Record the named counter, measured value, units, sampling interval and effective thresholds. Compare a representative time series with workload changes, host placement and storage/network evidence. Separate host/root/guest CPU and assigned/demanded memory. Missing counters are a telemetry problem, not zero utilization.

### Corrective action and escalation

Address the identified contention, workload placement or failing path with its owner. Capacity changes require a headroom and failover-reserve check. Do not blindly increase thresholds, reboot hosts or reduce VM resources to suppress symptoms.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Observe the same metric over a representative load period, confirm sustained recovery and verify workload response independently. Product defaults require site-specific review and are not Microsoft service-level guarantees.

### Microsoft references

[Microsoft Learn: troubleshoot hyper v virtual machine performance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/troubleshoot-hyper-v-virtual-machine-performance)


## Collect Hyper-V root virtual processor total run time (disabled by default) {#hypervprivatecloud.host.rootvirtualprocessor.collection.rule}

`HyperVPrivateCloud.Host.RootVirtualProcessor.Collection.Rule`

Collects total run time percentage for the root (parent) partition virtual processors on the host.

### Support scope

Measured resource pressure or I/O delay. A warning is an opportunity to investigate headroom; a threshold crossing alone does not identify the defective component or predict a failure time.

Element: HyperVPrivateCloud.Host.RootVirtualProcessor.Collection.Rule. Kind: Rule.

### Alert versus health

Target=HCSV2Library!HyperVPrivateCloud.HostRole; enabled=false; category=PerformanceCollection. Rules collect data or raise event alerts; they do not themselves create unit-monitor health transitions. Repeated or unresolved rule alerts do not by themselves explain a red DA. Correlate with current leaf monitors and event timestamps before closure.

### Read-only investigation

Record the named counter, measured value, units, sampling interval and effective thresholds. Compare a representative time series with workload changes, host placement and storage/network evidence. Separate host/root/guest CPU and assigned/demanded memory. Missing counters are a telemetry problem, not zero utilization.

### Corrective action and escalation

Address the identified contention, workload placement or failing path with its owner. Capacity changes require a headroom and failover-reserve check. Do not blindly increase thresholds, reboot hosts or reduce VM resources to suppress symptoms.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Observe the same metric over a representative load period, confirm sustained recovery and verify workload response independently. Product defaults require site-specific review and are not Microsoft service-level guarantees.

### Microsoft references

[Microsoft Learn: troubleshoot hyper v virtual machine performance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/troubleshoot-hyper-v-virtual-machine-performance)


## Collect host memory pages input per second {#hypervprivatecloud.host.pagesinput.collection.rule}

`HyperVPrivateCloud.Host.PagesInput.Collection.Rule`

Collects memory hard page faults resolved by reading from disk per second on the host.

### Support scope

Host-based Hyper-V workload or management evidence. A stopped VM must be compared with its intended state; inventory presence is not guest application monitoring.

Element: HyperVPrivateCloud.Host.PagesInput.Collection.Rule. Kind: Rule.

### Alert versus health

Target=HCSV2Library!HyperVPrivateCloud.HostRole; enabled=true; category=PerformanceCollection. Rules collect data or raise event alerts; they do not themselves create unit-monitor health transitions. Repeated or unresolved rule alerts do not by themselves explain a red DA. Correlate with current leaf monitors and event timestamps before closure.

### Read-only investigation

Run the matching read-only host/VM task. Match the stable VM ID and current owner, inspect Get-VM, attached disks, checkpoint chain and Hyper-V-VMMS/High-Availability logs. For management-service errors verify the named service and first failure rather than assuming every guest stopped.

### Corrective action and escalation

Restore the identified service, configuration, storage or VM dependency with the workload owner. Check intended shutdown and maintenance policy first. Never delete checkpoint files, force power operations or restart VMMS/hosts solely to clear an alert.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm the intended VM/service state, fresh host-derived evidence and the originating monitor. Guest application recovery requires a separate workload-level check.

### Microsoft references

[Microsoft Learn: hyper v start state access failures clustered standalone](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-start-state-access-failures-clustered-standalone)

[Microsoft Learn: hyper v virtual machine backup checkpoint storage](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-virtual-machine-backup-checkpoint-storage)


## Collect physical network interface bytes per second {#hypervprivatecloud.host.networkbytes.collection.rule}

`HyperVPrivateCloud.Host.NetworkBytes.Collection.Rule`

Collects total inbound and outbound network bytes per second across physical network interfaces on the host.

### Support scope

Host network or external infrastructure evidence at the precise scope of the leaf. TCP reachability is not device hardware, firewall-policy or application health; linked vendor monitors retain their own authority.

Element: HyperVPrivateCloud.Host.NetworkBytes.Collection.Rule. Kind: Rule.

### Alert versus health

Target=HCSV2Library!HyperVPrivateCloud.HostRole; enabled=true; category=PerformanceCollection. Rules collect data or raise event alerts; they do not themselves create unit-monitor health transitions. Repeated or unresolved rule alerts do not by themselves explain a red DA. Correlate with current leaf monitors and event timestamps before closure.

### Read-only investigation

Identify the adapter, switch, port or configured endpoint and the actual observation source. Compare link state, negotiated speed and error/discard deltas with device-side evidence. Check routing and the intended port from the collector. An unreachable management endpoint does not by itself prove the data plane failed.

### Corrective action and escalation

Restore the specific path, cable/optic, approved switch configuration or device service with the network/hardware owner. Consult the vendor for proprietary device faults. Do not disable security controls, bounce all uplinks or reboot management devices based only on a failed TCP probe.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Repeat the original path test and confirm relevant native/vendor health. For cumulative errors, observe new deltas; do not expect historic totals to disappear.

### Microsoft references

[Microsoft Learn: troubleshoot tcp ip communication guidance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/networking/troubleshoot-tcp-ip-communication-guidance)


## Collect Hyper-V virtual network adapter bytes per second (disabled by default) {#hypervprivatecloud.host.virtualnetworkbytes.collection.rule}

`HyperVPrivateCloud.Host.VirtualNetworkBytes.Collection.Rule`

Collects total bytes per second across all virtual network adapters on the host.

### Support scope

Host network or external infrastructure evidence at the precise scope of the leaf. TCP reachability is not device hardware, firewall-policy or application health; linked vendor monitors retain their own authority.

Element: HyperVPrivateCloud.Host.VirtualNetworkBytes.Collection.Rule. Kind: Rule.

### Alert versus health

Target=HCSV2Library!HyperVPrivateCloud.HostRole; enabled=false; category=PerformanceCollection. Rules collect data or raise event alerts; they do not themselves create unit-monitor health transitions. Repeated or unresolved rule alerts do not by themselves explain a red DA. Correlate with current leaf monitors and event timestamps before closure.

### Read-only investigation

Identify the adapter, switch, port or configured endpoint and the actual observation source. Compare link state, negotiated speed and error/discard deltas with device-side evidence. Check routing and the intended port from the collector. An unreachable management endpoint does not by itself prove the data plane failed.

### Corrective action and escalation

Restore the specific path, cable/optic, approved switch configuration or device service with the network/hardware owner. Consult the vendor for proprietary device faults. Do not disable security controls, bounce all uplinks or reboot management devices based only on a failed TCP probe.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Repeat the original path test and confirm relevant native/vendor health. For cumulative errors, observe new deltas; do not expect historic totals to disappear.

### Microsoft references

[Microsoft Learn: troubleshoot tcp ip communication guidance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/networking/troubleshoot-tcp-ip-communication-guidance)


## Collect physical disk average read latency {#hypervprivatecloud.host.physicaldiskreadlatency.collection.rule}

`HyperVPrivateCloud.Host.PhysicalDiskReadLatency.Collection.Rule`

Collects average physical disk read latency in seconds per read across disks on the host.

### Support scope

Measured resource pressure or I/O delay. A warning is an opportunity to investigate headroom; a threshold crossing alone does not identify the defective component or predict a failure time.

Element: HyperVPrivateCloud.Host.PhysicalDiskReadLatency.Collection.Rule. Kind: Rule.

### Alert versus health

Target=HCSV2Library!HyperVPrivateCloud.HostRole; enabled=true; category=PerformanceCollection. Rules collect data or raise event alerts; they do not themselves create unit-monitor health transitions. Repeated or unresolved rule alerts do not by themselves explain a red DA. Correlate with current leaf monitors and event timestamps before closure.

### Read-only investigation

Record the named counter, measured value, units, sampling interval and effective thresholds. Compare a representative time series with workload changes, host placement and storage/network evidence. Separate host/root/guest CPU and assigned/demanded memory. Missing counters are a telemetry problem, not zero utilization.

### Corrective action and escalation

Address the identified contention, workload placement or failing path with its owner. Capacity changes require a headroom and failover-reserve check. Do not blindly increase thresholds, reboot hosts or reduce VM resources to suppress symptoms.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Observe the same metric over a representative load period, confirm sustained recovery and verify workload response independently. Product defaults require site-specific review and are not Microsoft service-level guarantees.

### Microsoft references

[Microsoft Learn: troubleshoot hyper v virtual machine performance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/troubleshoot-hyper-v-virtual-machine-performance)


## Collect physical disk average write latency {#hypervprivatecloud.host.physicaldiskwritelatency.collection.rule}

`HyperVPrivateCloud.Host.PhysicalDiskWriteLatency.Collection.Rule`

Collects average physical disk write latency in seconds per write across disks on the host.

### Support scope

Measured resource pressure or I/O delay. A warning is an opportunity to investigate headroom; a threshold crossing alone does not identify the defective component or predict a failure time.

Element: HyperVPrivateCloud.Host.PhysicalDiskWriteLatency.Collection.Rule. Kind: Rule.

### Alert versus health

Target=HCSV2Library!HyperVPrivateCloud.HostRole; enabled=true; category=PerformanceCollection. Rules collect data or raise event alerts; they do not themselves create unit-monitor health transitions. Repeated or unresolved rule alerts do not by themselves explain a red DA. Correlate with current leaf monitors and event timestamps before closure.

### Read-only investigation

Record the named counter, measured value, units, sampling interval and effective thresholds. Compare a representative time series with workload changes, host placement and storage/network evidence. Separate host/root/guest CPU and assigned/demanded memory. Missing counters are a telemetry problem, not zero utilization.

### Corrective action and escalation

Address the identified contention, workload placement or failing path with its owner. Capacity changes require a headroom and failover-reserve check. Do not blindly increase thresholds, reboot hosts or reduce VM resources to suppress symptoms.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Observe the same metric over a representative load period, confirm sustained recovery and verify workload response independently. Product defaults require site-specific review and are not Microsoft service-level guarantees.

### Microsoft references

[Microsoft Learn: troubleshoot hyper v virtual machine performance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/troubleshoot-hyper-v-virtual-machine-performance)


## Collect physical disk average read queue length (disabled by default) {#hypervprivatecloud.host.physicaldiskreadqueue.collection.rule}

`HyperVPrivateCloud.Host.PhysicalDiskReadQueue.Collection.Rule`

Collects average physical disk read queue length across disks on the host.

### Support scope

Host-based Hyper-V workload or management evidence. A stopped VM must be compared with its intended state; inventory presence is not guest application monitoring.

Element: HyperVPrivateCloud.Host.PhysicalDiskReadQueue.Collection.Rule. Kind: Rule.

### Alert versus health

Target=HCSV2Library!HyperVPrivateCloud.HostRole; enabled=false; category=PerformanceCollection. Rules collect data or raise event alerts; they do not themselves create unit-monitor health transitions. Repeated or unresolved rule alerts do not by themselves explain a red DA. Correlate with current leaf monitors and event timestamps before closure.

### Read-only investigation

Run the matching read-only host/VM task. Match the stable VM ID and current owner, inspect Get-VM, attached disks, checkpoint chain and Hyper-V-VMMS/High-Availability logs. For management-service errors verify the named service and first failure rather than assuming every guest stopped.

### Corrective action and escalation

Restore the identified service, configuration, storage or VM dependency with the workload owner. Check intended shutdown and maintenance policy first. Never delete checkpoint files, force power operations or restart VMMS/hosts solely to clear an alert.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm the intended VM/service state, fresh host-derived evidence and the originating monitor. Guest application recovery requires a separate workload-level check.

### Microsoft references

[Microsoft Learn: hyper v start state access failures clustered standalone](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-start-state-access-failures-clustered-standalone)

[Microsoft Learn: hyper v virtual machine backup checkpoint storage](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-virtual-machine-backup-checkpoint-storage)


## Collect physical disk average write queue length (disabled by default) {#hypervprivatecloud.host.physicaldiskwritequeue.collection.rule}

`HyperVPrivateCloud.Host.PhysicalDiskWriteQueue.Collection.Rule`

Collects average physical disk write queue length across disks on the host.

### Support scope

Host-based Hyper-V workload or management evidence. A stopped VM must be compared with its intended state; inventory presence is not guest application monitoring.

Element: HyperVPrivateCloud.Host.PhysicalDiskWriteQueue.Collection.Rule. Kind: Rule.

### Alert versus health

Target=HCSV2Library!HyperVPrivateCloud.HostRole; enabled=false; category=PerformanceCollection. Rules collect data or raise event alerts; they do not themselves create unit-monitor health transitions. Repeated or unresolved rule alerts do not by themselves explain a red DA. Correlate with current leaf monitors and event timestamps before closure.

### Read-only investigation

Run the matching read-only host/VM task. Match the stable VM ID and current owner, inspect Get-VM, attached disks, checkpoint chain and Hyper-V-VMMS/High-Availability logs. For management-service errors verify the named service and first failure rather than assuming every guest stopped.

### Corrective action and escalation

Restore the identified service, configuration, storage or VM dependency with the workload owner. Check intended shutdown and maintenance policy first. Never delete checkpoint files, force power operations or restart VMMS/hosts solely to clear an alert.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm the intended VM/service state, fresh host-derived evidence and the originating monitor. Guest application recovery requires a separate workload-level check.

### Microsoft references

[Microsoft Learn: hyper v start state access failures clustered standalone](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-start-state-access-failures-clustered-standalone)

[Microsoft Learn: hyper v virtual machine backup checkpoint storage](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-virtual-machine-backup-checkpoint-storage)


## Collect host available memory as a percentage of installed memory {#hypervprivatecloud.host.availablememorypercent.collection.rule}

`HyperVPrivateCloud.Host.AvailableMemoryPercent.Collection.Rule`

Collects physical memory available to the host as a percentage of installed memory.

### Support scope

Measured resource pressure or I/O delay. A warning is an opportunity to investigate headroom; a threshold crossing alone does not identify the defective component or predict a failure time.

Element: HyperVPrivateCloud.Host.AvailableMemoryPercent.Collection.Rule. Kind: Rule.

### Alert versus health

Target=HCSV2Library!HyperVPrivateCloud.HostRole; enabled=true; category=PerformanceCollection. Rules collect data or raise event alerts; they do not themselves create unit-monitor health transitions. Repeated or unresolved rule alerts do not by themselves explain a red DA. Correlate with current leaf monitors and event timestamps before closure.

### Read-only investigation

Record the named counter, measured value, units, sampling interval and effective thresholds. Compare a representative time series with workload changes, host placement and storage/network evidence. Separate host/root/guest CPU and assigned/demanded memory. Missing counters are a telemetry problem, not zero utilization.

### Corrective action and escalation

Address the identified contention, workload placement or failing path with its owner. Capacity changes require a headroom and failover-reserve check. Do not blindly increase thresholds, reboot hosts or reduce VM resources to suppress symptoms.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Observe the same metric over a representative load period, confirm sustained recovery and verify workload response independently. Product defaults require site-specific review and are not Microsoft service-level guarantees.

### Microsoft references

[Microsoft Learn: troubleshoot hyper v virtual machine performance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/troubleshoot-hyper-v-virtual-machine-performance)


## Collect worst host network interface utilization percentage {#hypervprivatecloud.host.networkutilizationpercent.collection.rule}

`HyperVPrivateCloud.Host.NetworkUtilizationPercent.Collection.Rule`

Collects the highest network interface utilization percentage across all physical adapters on the host.

### Support scope

Measured resource pressure or I/O delay. A warning is an opportunity to investigate headroom; a threshold crossing alone does not identify the defective component or predict a failure time.

Element: HyperVPrivateCloud.Host.NetworkUtilizationPercent.Collection.Rule. Kind: Rule.

### Alert versus health

Target=HCSV2Library!HyperVPrivateCloud.HostRole; enabled=true; category=PerformanceCollection. Rules collect data or raise event alerts; they do not themselves create unit-monitor health transitions. Repeated or unresolved rule alerts do not by themselves explain a red DA. Correlate with current leaf monitors and event timestamps before closure.

### Read-only investigation

Record the named counter, measured value, units, sampling interval and effective thresholds. Compare a representative time series with workload changes, host placement and storage/network evidence. Separate host/root/guest CPU and assigned/demanded memory. Missing counters are a telemetry problem, not zero utilization.

### Corrective action and escalation

Address the identified contention, workload placement or failing path with its owner. Capacity changes require a headroom and failover-reserve check. Do not blindly increase thresholds, reboot hosts or reduce VM resources to suppress symptoms.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Observe the same metric over a representative load period, confirm sustained recovery and verify workload response independently. Product defaults require site-specific review and are not Microsoft service-level guarantees.

### Microsoft references

[Microsoft Learn: troubleshoot hyper v virtual machine performance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/troubleshoot-hyper-v-virtual-machine-performance)


## Collect VM virtual processor total run time {#hypervprivatecloud.vmruntime.virtualprocessorruntime.collection.rule}

`HyperVPrivateCloud.VmRuntime.VirtualProcessorRunTime.Collection.Rule`

Collects average hypervisor virtual processor total run time percentage for the virtual machine.

### Support scope

Measured resource pressure or I/O delay. A warning is an opportunity to investigate headroom; a threshold crossing alone does not identify the defective component or predict a failure time.

Element: HyperVPrivateCloud.VmRuntime.VirtualProcessorRunTime.Collection.Rule. Kind: Rule.

### Alert versus health

Target=HCSV2Library!HyperVPrivateCloud.VirtualMachineRuntime; enabled=true; category=PerformanceCollection. Rules collect data or raise event alerts; they do not themselves create unit-monitor health transitions. Repeated or unresolved rule alerts do not by themselves explain a red DA. Correlate with current leaf monitors and event timestamps before closure.

### Read-only investigation

Record the named counter, measured value, units, sampling interval and effective thresholds. Compare a representative time series with workload changes, host placement and storage/network evidence. Separate host/root/guest CPU and assigned/demanded memory. Missing counters are a telemetry problem, not zero utilization.

### Corrective action and escalation

Address the identified contention, workload placement or failing path with its owner. Capacity changes require a headroom and failover-reserve check. Do not blindly increase thresholds, reboot hosts or reduce VM resources to suppress symptoms.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Observe the same metric over a representative load period, confirm sustained recovery and verify workload response independently. Product defaults require site-specific review and are not Microsoft service-level guarantees.

### Microsoft references

[Microsoft Learn: troubleshoot hyper v virtual machine performance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/troubleshoot-hyper-v-virtual-machine-performance)


## Collect VM busiest virtual processor run time {#hypervprivatecloud.vmruntime.virtualprocessorpeakruntime.collection.rule}

`HyperVPrivateCloud.VmRuntime.VirtualProcessorPeakRunTime.Collection.Rule`

Collects run time percentage for the busiest virtual processor assigned to the virtual machine.

### Support scope

Measured resource pressure or I/O delay. A warning is an opportunity to investigate headroom; a threshold crossing alone does not identify the defective component or predict a failure time.

Element: HyperVPrivateCloud.VmRuntime.VirtualProcessorPeakRunTime.Collection.Rule. Kind: Rule.

### Alert versus health

Target=HCSV2Library!HyperVPrivateCloud.VirtualMachineRuntime; enabled=true; category=PerformanceCollection. Rules collect data or raise event alerts; they do not themselves create unit-monitor health transitions. Repeated or unresolved rule alerts do not by themselves explain a red DA. Correlate with current leaf monitors and event timestamps before closure.

### Read-only investigation

Record the named counter, measured value, units, sampling interval and effective thresholds. Compare a representative time series with workload changes, host placement and storage/network evidence. Separate host/root/guest CPU and assigned/demanded memory. Missing counters are a telemetry problem, not zero utilization.

### Corrective action and escalation

Address the identified contention, workload placement or failing path with its owner. Capacity changes require a headroom and failover-reserve check. Do not blindly increase thresholds, reboot hosts or reduce VM resources to suppress symptoms.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Observe the same metric over a representative load period, confirm sustained recovery and verify workload response independently. Product defaults require site-specific review and are not Microsoft service-level guarantees.

### Microsoft references

[Microsoft Learn: troubleshoot hyper v virtual machine performance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/troubleshoot-hyper-v-virtual-machine-performance)


## Collect VM assigned memory {#hypervprivatecloud.vmruntime.assignedmemory.collection.rule}

`HyperVPrivateCloud.VmRuntime.AssignedMemory.Collection.Rule`

Collects the physical memory currently assigned to the virtual machine in megabytes.

### Support scope

Measured resource pressure or I/O delay. A warning is an opportunity to investigate headroom; a threshold crossing alone does not identify the defective component or predict a failure time.

Element: HyperVPrivateCloud.VmRuntime.AssignedMemory.Collection.Rule. Kind: Rule.

### Alert versus health

Target=HCSV2Library!HyperVPrivateCloud.VirtualMachineRuntime; enabled=true; category=PerformanceCollection. Rules collect data or raise event alerts; they do not themselves create unit-monitor health transitions. Repeated or unresolved rule alerts do not by themselves explain a red DA. Correlate with current leaf monitors and event timestamps before closure.

### Read-only investigation

Record the named counter, measured value, units, sampling interval and effective thresholds. Compare a representative time series with workload changes, host placement and storage/network evidence. Separate host/root/guest CPU and assigned/demanded memory. Missing counters are a telemetry problem, not zero utilization.

### Corrective action and escalation

Address the identified contention, workload placement or failing path with its owner. Capacity changes require a headroom and failover-reserve check. Do not blindly increase thresholds, reboot hosts or reduce VM resources to suppress symptoms.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Observe the same metric over a representative load period, confirm sustained recovery and verify workload response independently. Product defaults require site-specific review and are not Microsoft service-level guarantees.

### Microsoft references

[Microsoft Learn: troubleshoot hyper v virtual machine performance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/troubleshoot-hyper-v-virtual-machine-performance)


## Collect VM memory demand {#hypervprivatecloud.vmruntime.memorydemand.collection.rule}

`HyperVPrivateCloud.VmRuntime.MemoryDemand.Collection.Rule`

Collects current memory demand from the guest operating system in megabytes.

### Support scope

Measured resource pressure or I/O delay. A warning is an opportunity to investigate headroom; a threshold crossing alone does not identify the defective component or predict a failure time.

Element: HyperVPrivateCloud.VmRuntime.MemoryDemand.Collection.Rule. Kind: Rule.

### Alert versus health

Target=HCSV2Library!HyperVPrivateCloud.VirtualMachineRuntime; enabled=true; category=PerformanceCollection. Rules collect data or raise event alerts; they do not themselves create unit-monitor health transitions. Repeated or unresolved rule alerts do not by themselves explain a red DA. Correlate with current leaf monitors and event timestamps before closure.

### Read-only investigation

Record the named counter, measured value, units, sampling interval and effective thresholds. Compare a representative time series with workload changes, host placement and storage/network evidence. Separate host/root/guest CPU and assigned/demanded memory. Missing counters are a telemetry problem, not zero utilization.

### Corrective action and escalation

Address the identified contention, workload placement or failing path with its owner. Capacity changes require a headroom and failover-reserve check. Do not blindly increase thresholds, reboot hosts or reduce VM resources to suppress symptoms.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Observe the same metric over a representative load period, confirm sustained recovery and verify workload response independently. Product defaults require site-specific review and are not Microsoft service-level guarantees.

### Microsoft references

[Microsoft Learn: troubleshoot hyper v virtual machine performance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/troubleshoot-hyper-v-virtual-machine-performance)


## Collect VM memory pressure {#hypervprivatecloud.vmruntime.memorypressure.collection.rule}

`HyperVPrivateCloud.VmRuntime.MemoryPressure.Collection.Rule`

Collects Hyper-V Dynamic Memory pressure ratio as a percentage for the virtual machine.

### Support scope

Measured resource pressure or I/O delay. A warning is an opportunity to investigate headroom; a threshold crossing alone does not identify the defective component or predict a failure time.

Element: HyperVPrivateCloud.VmRuntime.MemoryPressure.Collection.Rule. Kind: Rule.

### Alert versus health

Target=HCSV2Library!HyperVPrivateCloud.VirtualMachineRuntime; enabled=true; category=PerformanceCollection. Rules collect data or raise event alerts; they do not themselves create unit-monitor health transitions. Repeated or unresolved rule alerts do not by themselves explain a red DA. Correlate with current leaf monitors and event timestamps before closure.

### Read-only investigation

Record the named counter, measured value, units, sampling interval and effective thresholds. Compare a representative time series with workload changes, host placement and storage/network evidence. Separate host/root/guest CPU and assigned/demanded memory. Missing counters are a telemetry problem, not zero utilization.

### Corrective action and escalation

Address the identified contention, workload placement or failing path with its owner. Capacity changes require a headroom and failover-reserve check. Do not blindly increase thresholds, reboot hosts or reduce VM resources to suppress symptoms.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Observe the same metric over a representative load period, confirm sustained recovery and verify workload response independently. Product defaults require site-specific review and are not Microsoft service-level guarantees.

### Microsoft references

[Microsoft Learn: troubleshoot hyper v virtual machine performance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/troubleshoot-hyper-v-virtual-machine-performance)


## Collect VM virtual storage device read bytes per second {#hypervprivatecloud.vmruntime.virtualstoragereadbytes.collection.rule}

`HyperVPrivateCloud.VmRuntime.VirtualStorageReadBytes.Collection.Rule`

Collects virtual storage device read throughput in bytes per second for the virtual machine.

### Support scope

Host-based Hyper-V workload or management evidence. A stopped VM must be compared with its intended state; inventory presence is not guest application monitoring.

Element: HyperVPrivateCloud.VmRuntime.VirtualStorageReadBytes.Collection.Rule. Kind: Rule.

### Alert versus health

Target=HCSV2Library!HyperVPrivateCloud.VirtualMachineRuntime; enabled=true; category=PerformanceCollection. Rules collect data or raise event alerts; they do not themselves create unit-monitor health transitions. Repeated or unresolved rule alerts do not by themselves explain a red DA. Correlate with current leaf monitors and event timestamps before closure.

### Read-only investigation

Run the matching read-only host/VM task. Match the stable VM ID and current owner, inspect Get-VM, attached disks, checkpoint chain and Hyper-V-VMMS/High-Availability logs. For management-service errors verify the named service and first failure rather than assuming every guest stopped.

### Corrective action and escalation

Restore the identified service, configuration, storage or VM dependency with the workload owner. Check intended shutdown and maintenance policy first. Never delete checkpoint files, force power operations or restart VMMS/hosts solely to clear an alert.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm the intended VM/service state, fresh host-derived evidence and the originating monitor. Guest application recovery requires a separate workload-level check.

### Microsoft references

[Microsoft Learn: hyper v start state access failures clustered standalone](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-start-state-access-failures-clustered-standalone)

[Microsoft Learn: hyper v virtual machine backup checkpoint storage](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-virtual-machine-backup-checkpoint-storage)


## Collect VM virtual storage device write bytes per second {#hypervprivatecloud.vmruntime.virtualstoragewritebytes.collection.rule}

`HyperVPrivateCloud.VmRuntime.VirtualStorageWriteBytes.Collection.Rule`

Collects virtual storage device write throughput in bytes per second for the virtual machine.

### Support scope

Host-based Hyper-V workload or management evidence. A stopped VM must be compared with its intended state; inventory presence is not guest application monitoring.

Element: HyperVPrivateCloud.VmRuntime.VirtualStorageWriteBytes.Collection.Rule. Kind: Rule.

### Alert versus health

Target=HCSV2Library!HyperVPrivateCloud.VirtualMachineRuntime; enabled=true; category=PerformanceCollection. Rules collect data or raise event alerts; they do not themselves create unit-monitor health transitions. Repeated or unresolved rule alerts do not by themselves explain a red DA. Correlate with current leaf monitors and event timestamps before closure.

### Read-only investigation

Run the matching read-only host/VM task. Match the stable VM ID and current owner, inspect Get-VM, attached disks, checkpoint chain and Hyper-V-VMMS/High-Availability logs. For management-service errors verify the named service and first failure rather than assuming every guest stopped.

### Corrective action and escalation

Restore the identified service, configuration, storage or VM dependency with the workload owner. Check intended shutdown and maintenance policy first. Never delete checkpoint files, force power operations or restart VMMS/hosts solely to clear an alert.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm the intended VM/service state, fresh host-derived evidence and the originating monitor. Guest application recovery requires a separate workload-level check.

### Microsoft references

[Microsoft Learn: hyper v start state access failures clustered standalone](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-start-state-access-failures-clustered-standalone)

[Microsoft Learn: hyper v virtual machine backup checkpoint storage](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-virtual-machine-backup-checkpoint-storage)


## Collect VM virtual storage device latency {#hypervprivatecloud.vmruntime.virtualstoragelatency.collection.rule}

`HyperVPrivateCloud.VmRuntime.VirtualStorageLatency.Collection.Rule`

Collects worst virtual storage device latency in milliseconds across virtual hard disks attached to the VM.

### Support scope

Measured resource pressure or I/O delay. A warning is an opportunity to investigate headroom; a threshold crossing alone does not identify the defective component or predict a failure time.

Element: HyperVPrivateCloud.VmRuntime.VirtualStorageLatency.Collection.Rule. Kind: Rule.

### Alert versus health

Target=HCSV2Library!HyperVPrivateCloud.VirtualMachineRuntime; enabled=true; category=PerformanceCollection. Rules collect data or raise event alerts; they do not themselves create unit-monitor health transitions. Repeated or unresolved rule alerts do not by themselves explain a red DA. Correlate with current leaf monitors and event timestamps before closure.

### Read-only investigation

Record the named counter, measured value, units, sampling interval and effective thresholds. Compare a representative time series with workload changes, host placement and storage/network evidence. Separate host/root/guest CPU and assigned/demanded memory. Missing counters are a telemetry problem, not zero utilization.

### Corrective action and escalation

Address the identified contention, workload placement or failing path with its owner. Capacity changes require a headroom and failover-reserve check. Do not blindly increase thresholds, reboot hosts or reduce VM resources to suppress symptoms.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Observe the same metric over a representative load period, confirm sustained recovery and verify workload response independently. Product defaults require site-specific review and are not Microsoft service-level guarantees.

### Microsoft references

[Microsoft Learn: troubleshoot hyper v virtual machine performance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/troubleshoot-hyper-v-virtual-machine-performance)


## Collect VM virtual network adapter bytes sent per second {#hypervprivatecloud.vmruntime.virtualnetworkbytessent.collection.rule}

`HyperVPrivateCloud.VmRuntime.VirtualNetworkBytesSent.Collection.Rule`

Collects network throughput sent in bytes per second across all virtual network adapters for the VM.

### Support scope

Host network or external infrastructure evidence at the precise scope of the leaf. TCP reachability is not device hardware, firewall-policy or application health; linked vendor monitors retain their own authority.

Element: HyperVPrivateCloud.VmRuntime.VirtualNetworkBytesSent.Collection.Rule. Kind: Rule.

### Alert versus health

Target=HCSV2Library!HyperVPrivateCloud.VirtualMachineRuntime; enabled=true; category=PerformanceCollection. Rules collect data or raise event alerts; they do not themselves create unit-monitor health transitions. Repeated or unresolved rule alerts do not by themselves explain a red DA. Correlate with current leaf monitors and event timestamps before closure.

### Read-only investigation

Identify the adapter, switch, port or configured endpoint and the actual observation source. Compare link state, negotiated speed and error/discard deltas with device-side evidence. Check routing and the intended port from the collector. An unreachable management endpoint does not by itself prove the data plane failed.

### Corrective action and escalation

Restore the specific path, cable/optic, approved switch configuration or device service with the network/hardware owner. Consult the vendor for proprietary device faults. Do not disable security controls, bounce all uplinks or reboot management devices based only on a failed TCP probe.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Repeat the original path test and confirm relevant native/vendor health. For cumulative errors, observe new deltas; do not expect historic totals to disappear.

### Microsoft references

[Microsoft Learn: troubleshoot tcp ip communication guidance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/networking/troubleshoot-tcp-ip-communication-guidance)


## Collect VM virtual network adapter bytes received per second {#hypervprivatecloud.vmruntime.virtualnetworkbytesreceived.collection.rule}

`HyperVPrivateCloud.VmRuntime.VirtualNetworkBytesReceived.Collection.Rule`

Collects network throughput received in bytes per second across all virtual network adapters for the VM.

### Support scope

Host network or external infrastructure evidence at the precise scope of the leaf. TCP reachability is not device hardware, firewall-policy or application health; linked vendor monitors retain their own authority.

Element: HyperVPrivateCloud.VmRuntime.VirtualNetworkBytesReceived.Collection.Rule. Kind: Rule.

### Alert versus health

Target=HCSV2Library!HyperVPrivateCloud.VirtualMachineRuntime; enabled=true; category=PerformanceCollection. Rules collect data or raise event alerts; they do not themselves create unit-monitor health transitions. Repeated or unresolved rule alerts do not by themselves explain a red DA. Correlate with current leaf monitors and event timestamps before closure.

### Read-only investigation

Identify the adapter, switch, port or configured endpoint and the actual observation source. Compare link state, negotiated speed and error/discard deltas with device-side evidence. Check routing and the intended port from the collector. An unreachable management endpoint does not by itself prove the data plane failed.

### Corrective action and escalation

Restore the specific path, cable/optic, approved switch configuration or device service with the network/hardware owner. Consult the vendor for proprietary device faults. Do not disable security controls, bounce all uplinks or reboot management devices based only on a failed TCP probe.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Repeat the original path test and confirm relevant native/vendor health. For cumulative errors, observe new deltas; do not expect historic totals to disappear.

### Microsoft references

[Microsoft Learn: troubleshoot tcp ip communication guidance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/networking/troubleshoot-tcp-ip-communication-guidance)


## Collect Microsoft-Windows-Hyper-V-VMMS-Admin errors and warnings {#hypervprivatecloud.host.event.vmms.collection.rule}

`HyperVPrivateCloud.Host.Event.Vmms.Collection.Rule`

Collects Error, Critical and Warning events from the Microsoft-Windows-Hyper-V-VMMS-Admin channel (Virtual Machine Management Service) into the operational database and the Data Warehouse so the Hyper-V host and VM event views and reports have data.

### Support scope

Host-based Hyper-V workload or management evidence. A stopped VM must be compared with its intended state; inventory presence is not guest application monitoring.

Element: HyperVPrivateCloud.Host.Event.Vmms.Collection.Rule. Kind: Rule.

### Alert versus health

Target=HCSV2Library!HyperVPrivateCloud.HostRole; enabled=true; category=EventCollection. Rules collect data or raise event alerts; they do not themselves create unit-monitor health transitions. Repeated or unresolved rule alerts do not by themselves explain a red DA. Correlate with current leaf monitors and event timestamps before closure.

### Read-only investigation

Run the matching read-only host/VM task. Match the stable VM ID and current owner, inspect Get-VM, attached disks, checkpoint chain and Hyper-V-VMMS/High-Availability logs. For management-service errors verify the named service and first failure rather than assuming every guest stopped.

### Corrective action and escalation

Restore the identified service, configuration, storage or VM dependency with the workload owner. Check intended shutdown and maintenance policy first. Never delete checkpoint files, force power operations or restart VMMS/hosts solely to clear an alert.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm the intended VM/service state, fresh host-derived evidence and the originating monitor. Guest application recovery requires a separate workload-level check.

### Microsoft references

[Microsoft Learn: hyper v start state access failures clustered standalone](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-start-state-access-failures-clustered-standalone)

[Microsoft Learn: hyper v virtual machine backup checkpoint storage](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-virtual-machine-backup-checkpoint-storage)


## Collect Microsoft-Windows-Hyper-V-Worker-Admin errors and warnings {#hypervprivatecloud.host.event.worker.collection.rule}

`HyperVPrivateCloud.Host.Event.Worker.Collection.Rule`

Collects Error, Critical and Warning events from the Microsoft-Windows-Hyper-V-Worker-Admin channel (Hyper-V worker process) into the operational database and the Data Warehouse so the Hyper-V host and VM event views and reports have data.

### Support scope

Host-based Hyper-V workload or management evidence. A stopped VM must be compared with its intended state; inventory presence is not guest application monitoring.

Element: HyperVPrivateCloud.Host.Event.Worker.Collection.Rule. Kind: Rule.

### Alert versus health

Target=HCSV2Library!HyperVPrivateCloud.HostRole; enabled=true; category=EventCollection. Rules collect data or raise event alerts; they do not themselves create unit-monitor health transitions. Repeated or unresolved rule alerts do not by themselves explain a red DA. Correlate with current leaf monitors and event timestamps before closure.

### Read-only investigation

Run the matching read-only host/VM task. Match the stable VM ID and current owner, inspect Get-VM, attached disks, checkpoint chain and Hyper-V-VMMS/High-Availability logs. For management-service errors verify the named service and first failure rather than assuming every guest stopped.

### Corrective action and escalation

Restore the identified service, configuration, storage or VM dependency with the workload owner. Check intended shutdown and maintenance policy first. Never delete checkpoint files, force power operations or restart VMMS/hosts solely to clear an alert.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm the intended VM/service state, fresh host-derived evidence and the originating monitor. Guest application recovery requires a separate workload-level check.

### Microsoft references

[Microsoft Learn: hyper v start state access failures clustered standalone](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-start-state-access-failures-clustered-standalone)

[Microsoft Learn: hyper v virtual machine backup checkpoint storage](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-virtual-machine-backup-checkpoint-storage)


## Collect Microsoft-Windows-Hyper-V-Hypervisor-Admin errors and warnings {#hypervprivatecloud.host.event.hypervisor.collection.rule}

`HyperVPrivateCloud.Host.Event.Hypervisor.Collection.Rule`

Collects Error, Critical and Warning events from the Microsoft-Windows-Hyper-V-Hypervisor-Admin channel (hypervisor) into the operational database and the Data Warehouse so the Hyper-V host and VM event views and reports have data.

### Support scope

Host-based Hyper-V workload or management evidence. A stopped VM must be compared with its intended state; inventory presence is not guest application monitoring.

Element: HyperVPrivateCloud.Host.Event.Hypervisor.Collection.Rule. Kind: Rule.

### Alert versus health

Target=HCSV2Library!HyperVPrivateCloud.HostRole; enabled=true; category=EventCollection. Rules collect data or raise event alerts; they do not themselves create unit-monitor health transitions. Repeated or unresolved rule alerts do not by themselves explain a red DA. Correlate with current leaf monitors and event timestamps before closure.

### Read-only investigation

Run the matching read-only host/VM task. Match the stable VM ID and current owner, inspect Get-VM, attached disks, checkpoint chain and Hyper-V-VMMS/High-Availability logs. For management-service errors verify the named service and first failure rather than assuming every guest stopped.

### Corrective action and escalation

Restore the identified service, configuration, storage or VM dependency with the workload owner. Check intended shutdown and maintenance policy first. Never delete checkpoint files, force power operations or restart VMMS/hosts solely to clear an alert.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm the intended VM/service state, fresh host-derived evidence and the originating monitor. Guest application recovery requires a separate workload-level check.

### Microsoft references

[Microsoft Learn: hyper v start state access failures clustered standalone](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-start-state-access-failures-clustered-standalone)

[Microsoft Learn: hyper v virtual machine backup checkpoint storage](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-virtual-machine-backup-checkpoint-storage)


## Collect Microsoft-Windows-Hyper-V-Config-Admin errors and warnings {#hypervprivatecloud.host.event.config.collection.rule}

`HyperVPrivateCloud.Host.Event.Config.Collection.Rule`

Collects Error, Critical and Warning events from the Microsoft-Windows-Hyper-V-Config-Admin channel (VM configuration store) into the operational database and the Data Warehouse so the Hyper-V host and VM event views and reports have data.

### Support scope

Host-based Hyper-V workload or management evidence. A stopped VM must be compared with its intended state; inventory presence is not guest application monitoring.

Element: HyperVPrivateCloud.Host.Event.Config.Collection.Rule. Kind: Rule.

### Alert versus health

Target=HCSV2Library!HyperVPrivateCloud.HostRole; enabled=true; category=EventCollection. Rules collect data or raise event alerts; they do not themselves create unit-monitor health transitions. Repeated or unresolved rule alerts do not by themselves explain a red DA. Correlate with current leaf monitors and event timestamps before closure.

### Read-only investigation

Run the matching read-only host/VM task. Match the stable VM ID and current owner, inspect Get-VM, attached disks, checkpoint chain and Hyper-V-VMMS/High-Availability logs. For management-service errors verify the named service and first failure rather than assuming every guest stopped.

### Corrective action and escalation

Restore the identified service, configuration, storage or VM dependency with the workload owner. Check intended shutdown and maintenance policy first. Never delete checkpoint files, force power operations or restart VMMS/hosts solely to clear an alert.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm the intended VM/service state, fresh host-derived evidence and the originating monitor. Guest application recovery requires a separate workload-level check.

### Microsoft references

[Microsoft Learn: hyper v start state access failures clustered standalone](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-start-state-access-failures-clustered-standalone)

[Microsoft Learn: hyper v virtual machine backup checkpoint storage](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-virtual-machine-backup-checkpoint-storage)


## Collect Microsoft-Windows-Hyper-V-StorageVSP-Admin errors and warnings {#hypervprivatecloud.host.event.storagevsp.collection.rule}

`HyperVPrivateCloud.Host.Event.StorageVsp.Collection.Rule`

Collects Error, Critical and Warning events from the Microsoft-Windows-Hyper-V-StorageVSP-Admin channel (storage virtualization service provider) into the operational database and the Data Warehouse so the Hyper-V host and VM event views and reports have data.

### Support scope

Host-based Hyper-V workload or management evidence. A stopped VM must be compared with its intended state; inventory presence is not guest application monitoring.

Element: HyperVPrivateCloud.Host.Event.StorageVsp.Collection.Rule. Kind: Rule.

### Alert versus health

Target=HCSV2Library!HyperVPrivateCloud.HostRole; enabled=true; category=EventCollection. Rules collect data or raise event alerts; they do not themselves create unit-monitor health transitions. Repeated or unresolved rule alerts do not by themselves explain a red DA. Correlate with current leaf monitors and event timestamps before closure.

### Read-only investigation

Run the matching read-only host/VM task. Match the stable VM ID and current owner, inspect Get-VM, attached disks, checkpoint chain and Hyper-V-VMMS/High-Availability logs. For management-service errors verify the named service and first failure rather than assuming every guest stopped.

### Corrective action and escalation

Restore the identified service, configuration, storage or VM dependency with the workload owner. Check intended shutdown and maintenance policy first. Never delete checkpoint files, force power operations or restart VMMS/hosts solely to clear an alert.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm the intended VM/service state, fresh host-derived evidence and the originating monitor. Guest application recovery requires a separate workload-level check.

### Microsoft references

[Microsoft Learn: hyper v start state access failures clustered standalone](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-start-state-access-failures-clustered-standalone)

[Microsoft Learn: hyper v virtual machine backup checkpoint storage](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-virtual-machine-backup-checkpoint-storage)


## Collect Microsoft-Windows-Hyper-V-VmSwitch-Operational errors and warnings {#hypervprivatecloud.host.event.vmswitch.collection.rule}

`HyperVPrivateCloud.Host.Event.VmSwitch.Collection.Rule`

Collects Error, Critical and Warning events from the Microsoft-Windows-Hyper-V-VmSwitch-Operational channel (virtual switch) into the operational database and the Data Warehouse so the Hyper-V host and VM event views and reports have data.

### Support scope

Host-based Hyper-V workload or management evidence. A stopped VM must be compared with its intended state; inventory presence is not guest application monitoring.

Element: HyperVPrivateCloud.Host.Event.VmSwitch.Collection.Rule. Kind: Rule.

### Alert versus health

Target=HCSV2Library!HyperVPrivateCloud.HostRole; enabled=true; category=EventCollection. Rules collect data or raise event alerts; they do not themselves create unit-monitor health transitions. Repeated or unresolved rule alerts do not by themselves explain a red DA. Correlate with current leaf monitors and event timestamps before closure.

### Read-only investigation

Run the matching read-only host/VM task. Match the stable VM ID and current owner, inspect Get-VM, attached disks, checkpoint chain and Hyper-V-VMMS/High-Availability logs. For management-service errors verify the named service and first failure rather than assuming every guest stopped.

### Corrective action and escalation

Restore the identified service, configuration, storage or VM dependency with the workload owner. Check intended shutdown and maintenance policy first. Never delete checkpoint files, force power operations or restart VMMS/hosts solely to clear an alert.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm the intended VM/service state, fresh host-derived evidence and the originating monitor. Guest application recovery requires a separate workload-level check.

### Microsoft references

[Microsoft Learn: hyper v start state access failures clustered standalone](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-start-state-access-failures-clustered-standalone)

[Microsoft Learn: hyper v virtual machine backup checkpoint storage](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-virtual-machine-backup-checkpoint-storage)


## Collect Microsoft-Windows-Hyper-V-Compute-Admin errors and warnings {#hypervprivatecloud.host.event.compute.collection.rule}

`HyperVPrivateCloud.Host.Event.Compute.Collection.Rule`

Collects Error, Critical and Warning events from the Microsoft-Windows-Hyper-V-Compute-Admin channel (Host Compute Service) into the operational database and the Data Warehouse so the Hyper-V host and VM event views and reports have data.

### Support scope

Host-based Hyper-V workload or management evidence. A stopped VM must be compared with its intended state; inventory presence is not guest application monitoring.

Element: HyperVPrivateCloud.Host.Event.Compute.Collection.Rule. Kind: Rule.

### Alert versus health

Target=HCSV2Library!HyperVPrivateCloud.HostRole; enabled=true; category=EventCollection. Rules collect data or raise event alerts; they do not themselves create unit-monitor health transitions. Repeated or unresolved rule alerts do not by themselves explain a red DA. Correlate with current leaf monitors and event timestamps before closure.

### Read-only investigation

Run the matching read-only host/VM task. Match the stable VM ID and current owner, inspect Get-VM, attached disks, checkpoint chain and Hyper-V-VMMS/High-Availability logs. For management-service errors verify the named service and first failure rather than assuming every guest stopped.

### Corrective action and escalation

Restore the identified service, configuration, storage or VM dependency with the workload owner. Check intended shutdown and maintenance policy first. Never delete checkpoint files, force power operations or restart VMMS/hosts solely to clear an alert.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm the intended VM/service state, fresh host-derived evidence and the originating monitor. Guest application recovery requires a separate workload-level check.

### Microsoft references

[Microsoft Learn: hyper v start state access failures clustered standalone](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-start-state-access-failures-clustered-standalone)

[Microsoft Learn: hyper v virtual machine backup checkpoint storage](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-virtual-machine-backup-checkpoint-storage)


## Collect Microsoft-Windows-Hyper-V-High-Availability-Admin errors and warnings {#hypervprivatecloud.host.event.highavailability.collection.rule}

`HyperVPrivateCloud.Host.Event.HighAvailability.Collection.Rule`

Collects Error, Critical and Warning events from the Microsoft-Windows-Hyper-V-High-Availability-Admin channel (clustered VM high availability) into the operational database and the Data Warehouse so the Hyper-V host and VM event views and reports have data.

### Support scope

Host-based Hyper-V workload or management evidence. A stopped VM must be compared with its intended state; inventory presence is not guest application monitoring.

Element: HyperVPrivateCloud.Host.Event.HighAvailability.Collection.Rule. Kind: Rule.

### Alert versus health

Target=HCSV2Library!HyperVPrivateCloud.HostRole; enabled=true; category=EventCollection. Rules collect data or raise event alerts; they do not themselves create unit-monitor health transitions. Repeated or unresolved rule alerts do not by themselves explain a red DA. Correlate with current leaf monitors and event timestamps before closure.

### Read-only investigation

Run the matching read-only host/VM task. Match the stable VM ID and current owner, inspect Get-VM, attached disks, checkpoint chain and Hyper-V-VMMS/High-Availability logs. For management-service errors verify the named service and first failure rather than assuming every guest stopped.

### Corrective action and escalation

Restore the identified service, configuration, storage or VM dependency with the workload owner. Check intended shutdown and maintenance policy first. Never delete checkpoint files, force power operations or restart VMMS/hosts solely to clear an alert.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm the intended VM/service state, fresh host-derived evidence and the originating monitor. Guest application recovery requires a separate workload-level check.

### Microsoft references

[Microsoft Learn: hyper v start state access failures clustered standalone](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-start-state-access-failures-clustered-standalone)

[Microsoft Learn: hyper v virtual machine backup checkpoint storage](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-virtual-machine-backup-checkpoint-storage)


## Hyper-V live migration failed {#hypervprivatecloud.host.event.livemigrationfailed.alert.rule}

`HyperVPrivateCloud.Host.Event.LiveMigrationFailed.Alert.Rule`

A virtual machine live migration or quick migration failed on this host (Hyper-V-VMMS events 21502, 21501, and 21125). The VM stays on its source host; Cluster-Aware Updating, drain and manual migrations that depend on it stall.

### Summary

A virtual machine live migration or quick migration failed on this host (Hyper-V-VMMS events 21502, 21501, and 21125). The VM stays on its source host; Cluster-Aware Updating, drain and manual migrations that depend on it stall.

### Causes

Processor compatibility mismatch between source and destination (event 21502 with &quot;processor-specific features&quot; text).

Virtual switch name missing on the destination node (21502/21125).

Migration network, WinRM, Kerberos constrained delegation or firewall (TCP 6600) problems (21502 with connection errors).

Simultaneous live migration limit reached (21501).

### Resolutions

Read the full event text for the failing VM and destination host; each cause above has a distinct message.

For hardware compatibility, enable &quot;Migrate to a physical computer with a different processor version&quot; on the VM or start VMs on the oldest CPU generation first.

Create the missing virtual switch with the same name on the destination, then Refresh virtual machine configuration in Failover Cluster Manager.

Validate live-migration settings (Get-VMHost &#124; Select VirtualMachineMigration*), constrained delegation and firewall rules, then retry.

### Support scope

Host-based Hyper-V workload or management evidence. A stopped VM must be compared with its intended state; inventory presence is not guest application monitoring.

Element: HyperVPrivateCloud.Host.Event.LiveMigrationFailed.Alert.Rule. Kind: Rule.

### Alert versus health

Target=HCSV2Library!HyperVPrivateCloud.HostRole; enabled=true; category=Alert. Rules collect data or raise event alerts; they do not themselves create unit-monitor health transitions. Repeated or unresolved rule alerts do not by themselves explain a red DA. Correlate with current leaf monitors and event timestamps before closure.

### Read-only investigation

Run the matching read-only host/VM task. Match the stable VM ID and current owner, inspect Get-VM, attached disks, checkpoint chain and Hyper-V-VMMS/High-Availability logs. For management-service errors verify the named service and first failure rather than assuming every guest stopped.

### Corrective action and escalation

Restore the identified service, configuration, storage or VM dependency with the workload owner. Check intended shutdown and maintenance policy first. Never delete checkpoint files, force power operations or restart VMMS/hosts solely to clear an alert.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm the intended VM/service state, fresh host-derived evidence and the originating monitor. Guest application recovery requires a separate workload-level check.

### Microsoft references

[Microsoft Learn: hyper v start state access failures clustered standalone](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-start-state-access-failures-clustered-standalone)

[Microsoft Learn: hyper v virtual machine backup checkpoint storage](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-virtual-machine-backup-checkpoint-storage)


## Hyper-V hypervisor is not running {#hypervprivatecloud.host.event.hypervisornotrunning.alert.rule}

`HyperVPrivateCloud.Host.Event.HypervisorNotRunning.Alert.Rule`

A virtual machine could not be started because the hypervisor is not running on this host (Hyper-V-Worker event 3112). No VM can start on this host until the hypervisor loads.

### Summary

A virtual machine could not be started because the hypervisor is not running on this host (Hyper-V-Worker event 3112). No VM can start on this host until the hypervisor loads.

### Causes

Hardware virtualization (Intel VT-x/AMD-V), SLAT or Data Execution Prevention disabled in firmware.

Hypervisor launch type set to Off (bcdedit hypervisorlaunchtype off), often left after troubleshooting.

A boot-time hypervisor failure recorded in the Hyper-V-Hypervisor Admin log (event 41) or a conflicting hypervisor product.

### Resolutions

Check (Get-CimInstance Win32_ComputerSystem).HypervisorPresent and the Hyper-V-Hypervisor Admin log after the last boot.

Enable virtualization extensions and DEP in firmware; set bcdedit /set hypervisorlaunchtype auto; reboot.

Remove or disable competing hypervisors and security products that block hypervisor launch.

### Support scope

Host-based Hyper-V workload or management evidence. A stopped VM must be compared with its intended state; inventory presence is not guest application monitoring.

Element: HyperVPrivateCloud.Host.Event.HypervisorNotRunning.Alert.Rule. Kind: Rule.

### Alert versus health

Target=HCSV2Library!HyperVPrivateCloud.HostRole; enabled=true; category=Alert. Rules collect data or raise event alerts; they do not themselves create unit-monitor health transitions. Repeated or unresolved rule alerts do not by themselves explain a red DA. Correlate with current leaf monitors and event timestamps before closure.

### Read-only investigation

Run the matching read-only host/VM task. Match the stable VM ID and current owner, inspect Get-VM, attached disks, checkpoint chain and Hyper-V-VMMS/High-Availability logs. For management-service errors verify the named service and first failure rather than assuming every guest stopped.

### Corrective action and escalation

Restore the identified service, configuration, storage or VM dependency with the workload owner. Check intended shutdown and maintenance policy first. Never delete checkpoint files, force power operations or restart VMMS/hosts solely to clear an alert.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm the intended VM/service state, fresh host-derived evidence and the originating monitor. Guest application recovery requires a separate workload-level check.

### Microsoft references

[Microsoft Learn: hyper v start state access failures clustered standalone](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-start-state-access-failures-clustered-standalone)

[Microsoft Learn: hyper v virtual machine backup checkpoint storage](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-virtual-machine-backup-checkpoint-storage)


## Hyper-V worker process reported an error for a virtual machine {#hypervprivatecloud.host.event.workererror.alert.rule}

`HyperVPrivateCloud.Host.Event.WorkerError.Alert.Rule`

The Hyper-V worker process (vmwp.exe) logged an Error or Critical event for a virtual machine. These events cover VM crashes, resets, failed starts and unrecoverable virtual-processor errors, and normally mean a VM is down or was restarted.

### Summary

The Hyper-V worker process (vmwp.exe) logged an Error or Critical event for a virtual machine. These events cover VM crashes, resets, failed starts and unrecoverable virtual-processor errors, and normally mean a VM is down or was restarted.

### Causes

Guest triple fault or unrecoverable virtual processor error (the VM was reset or turned off).

Storage device failure or missing VHDX during start or run time.

Worker process terminated unexpectedly (memory, driver or host resource exhaustion).

### Resolutions

Open the event on the host; the description names the VM and the failure. Check the VM state (Get-VM) and start or resume it once the cause is fixed.

Correlate with the VM storage availability and host physical disk latency monitors for storage-driven failures.

For repeated guest crashes collect a guest memory dump and review the guest OS logs; for worker crashes review host Application log WER entries for vmwp.exe.

### Support scope

Host-based Hyper-V workload or management evidence. A stopped VM must be compared with its intended state; inventory presence is not guest application monitoring.

Element: HyperVPrivateCloud.Host.Event.WorkerError.Alert.Rule. Kind: Rule.

### Alert versus health

Target=HCSV2Library!HyperVPrivateCloud.HostRole; enabled=true; category=Alert. Rules collect data or raise event alerts; they do not themselves create unit-monitor health transitions. Repeated or unresolved rule alerts do not by themselves explain a red DA. Correlate with current leaf monitors and event timestamps before closure.

### Read-only investigation

Run the matching read-only host/VM task. Match the stable VM ID and current owner, inspect Get-VM, attached disks, checkpoint chain and Hyper-V-VMMS/High-Availability logs. For management-service errors verify the named service and first failure rather than assuming every guest stopped.

### Corrective action and escalation

Restore the identified service, configuration, storage or VM dependency with the workload owner. Check intended shutdown and maintenance policy first. Never delete checkpoint files, force power operations or restart VMMS/hosts solely to clear an alert.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm the intended VM/service state, fresh host-derived evidence and the originating monitor. Guest application recovery requires a separate workload-level check.

### Microsoft references

[Microsoft Learn: hyper v start state access failures clustered standalone](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-start-state-access-failures-clustered-standalone)

[Microsoft Learn: hyper v virtual machine backup checkpoint storage](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-virtual-machine-backup-checkpoint-storage)


## Hyper-V Virtual Machine Management Service reported an error {#hypervprivatecloud.host.event.vmmserror.alert.rule}

`HyperVPrivateCloud.Host.Event.VmmsError.Alert.Rule`

The Virtual Machine Management Service (VMMS) logged an Error or Critical event other than a live-migration failure, for example a VM that failed to start or initialize, a configuration that could not be loaded, a checkpoint or export failure, or a Hyper-V Replica error.

### Summary

The Virtual Machine Management Service (VMMS) logged an Error or Critical event other than a live-migration failure, for example a VM that failed to start or initialize, a configuration that could not be loaded, a checkpoint or export failure, or a Hyper-V Replica error.

### Causes

VM failed to start: insufficient memory, missing virtual switch, inaccessible VHDX or configuration file, or a permission problem for the NT Virtual Machine\Virtual Machines identity.

Configuration file corruption after an unclean shutdown.

Hyper-V Replica connectivity, authentication or storage problems.

Checkpoint or backup operations failing on the VM storage.

### Resolutions

Read the event text; it names the VM and the operation. Check Get-VM state and the VM Storage and Replica monitors on this host.

For start failures verify memory headroom, the virtual switch and storage path, then Start-VM.

For configuration errors restore the VM configuration from backup or re-import the VM.

For Replica errors use Get-VMReplication / Measure-VMReplication and resume or resynchronize replication.

### Support scope

Host-based Hyper-V workload or management evidence. A stopped VM must be compared with its intended state; inventory presence is not guest application monitoring.

Element: HyperVPrivateCloud.Host.Event.VmmsError.Alert.Rule. Kind: Rule.

### Alert versus health

Target=HCSV2Library!HyperVPrivateCloud.HostRole; enabled=true; category=Alert. Rules collect data or raise event alerts; they do not themselves create unit-monitor health transitions. Repeated or unresolved rule alerts do not by themselves explain a red DA. Correlate with current leaf monitors and event timestamps before closure.

### Read-only investigation

Run the matching read-only host/VM task. Match the stable VM ID and current owner, inspect Get-VM, attached disks, checkpoint chain and Hyper-V-VMMS/High-Availability logs. For management-service errors verify the named service and first failure rather than assuming every guest stopped.

### Corrective action and escalation

Restore the identified service, configuration, storage or VM dependency with the workload owner. Check intended shutdown and maintenance policy first. Never delete checkpoint files, force power operations or restart VMMS/hosts solely to clear an alert.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm the intended VM/service state, fresh host-derived evidence and the originating monitor. Guest application recovery requires a separate workload-level check.

### Microsoft references

[Microsoft Learn: hyper v start state access failures clustered standalone](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-start-state-access-failures-clustered-standalone)

[Microsoft Learn: hyper v virtual machine backup checkpoint storage](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-virtual-machine-backup-checkpoint-storage)


## Hyper-V hypervisor reported an error {#hypervprivatecloud.host.event.hypervisorerror.alert.rule}

`HyperVPrivateCloud.Host.Event.HypervisorError.Alert.Rule`

The hypervisor itself logged an Error, Critical or Warning event. Hypervisor errors are rare and affect every virtual machine on the host: launch failures, microcode or firmware problems, and partition-level faults.

### Summary

The hypervisor itself logged an Error, Critical or Warning event. Hypervisor errors are rare and affect every virtual machine on the host: launch failures, microcode or firmware problems, and partition-level faults.

### Causes

Hypervisor failed to launch at boot (firmware virtualization settings, Secure Boot or DEP).

Processor microcode or platform firmware defects.

Nested virtualization or a conflicting third-party hypervisor.

### Resolutions

Review the event text and the last boot in the Hyper-V-Hypervisor Admin log.

Apply the latest firmware and microcode from the hardware vendor and Windows updates.

If the hypervisor did not launch, follow the hypervisor-not-running knowledge: enable virtualization extensions and hypervisorlaunchtype auto.

### Support scope

Host-based Hyper-V workload or management evidence. A stopped VM must be compared with its intended state; inventory presence is not guest application monitoring.

Element: HyperVPrivateCloud.Host.Event.HypervisorError.Alert.Rule. Kind: Rule.

### Alert versus health

Target=HCSV2Library!HyperVPrivateCloud.HostRole; enabled=true; category=Alert. Rules collect data or raise event alerts; they do not themselves create unit-monitor health transitions. Repeated or unresolved rule alerts do not by themselves explain a red DA. Correlate with current leaf monitors and event timestamps before closure.

### Read-only investigation

Run the matching read-only host/VM task. Match the stable VM ID and current owner, inspect Get-VM, attached disks, checkpoint chain and Hyper-V-VMMS/High-Availability logs. For management-service errors verify the named service and first failure rather than assuming every guest stopped.

### Corrective action and escalation

Restore the identified service, configuration, storage or VM dependency with the workload owner. Check intended shutdown and maintenance policy first. Never delete checkpoint files, force power operations or restart VMMS/hosts solely to clear an alert.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm the intended VM/service state, fresh host-derived evidence and the originating monitor. Guest application recovery requires a separate workload-level check.

### Microsoft references

[Microsoft Learn: hyper v start state access failures clustered standalone](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-start-state-access-failures-clustered-standalone)

[Microsoft Learn: hyper v virtual machine backup checkpoint storage](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-virtual-machine-backup-checkpoint-storage)


## Hyper-V virtual storage provider reported an I/O error {#hypervprivatecloud.host.event.storagevsperror.alert.rule}

`HyperVPrivateCloud.Host.Event.StorageVspError.Alert.Rule`

The Hyper-V storage virtualization service provider (StorageVSP) logged an Error or Critical event. This is I/O between a virtual machine and its VHDX, VHD or pass-through disk failing on the host side and is the earliest host-visible sign of virtual disk data loss.

### Summary

The Hyper-V storage virtualization service provider (StorageVSP) logged an Error or Critical event. This is I/O between a virtual machine and its VHDX, VHD or pass-through disk failing on the host side and is the earliest host-visible sign of virtual disk data loss.

### Causes

Underlying volume, CSV, SMB share or SAN path returning I/O errors or timeouts.

VHDX chain corruption or a missing parent disk.

Volume out of space during a dynamic VHDX expansion.

### Resolutions

Identify the VM and disk from the event text; check the VM storage availability monitor and the host physical disk / CSV / SAN latency and path monitors.

Verify free space on the volume or share holding the VHDX and the VHD chain with Get-VHD.

Repair the storage fault first, then resume or restart the VM and run guest file-system checks.

### Support scope

Host-based Hyper-V workload or management evidence. A stopped VM must be compared with its intended state; inventory presence is not guest application monitoring.

Element: HyperVPrivateCloud.Host.Event.StorageVspError.Alert.Rule. Kind: Rule.

### Alert versus health

Target=HCSV2Library!HyperVPrivateCloud.HostRole; enabled=true; category=Alert. Rules collect data or raise event alerts; they do not themselves create unit-monitor health transitions. Repeated or unresolved rule alerts do not by themselves explain a red DA. Correlate with current leaf monitors and event timestamps before closure.

### Read-only investigation

Run the matching read-only host/VM task. Match the stable VM ID and current owner, inspect Get-VM, attached disks, checkpoint chain and Hyper-V-VMMS/High-Availability logs. For management-service errors verify the named service and first failure rather than assuming every guest stopped.

### Corrective action and escalation

Restore the identified service, configuration, storage or VM dependency with the workload owner. Check intended shutdown and maintenance policy first. Never delete checkpoint files, force power operations or restart VMMS/hosts solely to clear an alert.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm the intended VM/service state, fresh host-derived evidence and the originating monitor. Guest application recovery requires a separate workload-level check.

### Microsoft references

[Microsoft Learn: hyper v start state access failures clustered standalone](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-start-state-access-failures-clustered-standalone)

[Microsoft Learn: hyper v virtual machine backup checkpoint storage](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-virtual-machine-backup-checkpoint-storage)


## Hyper-V virtual switch reported an error {#hypervprivatecloud.host.event.vmswitcherror.alert.rule}

`HyperVPrivateCloud.Host.Event.VmSwitchError.Alert.Rule`

The Hyper-V virtual switch logged an Error or Critical event, for example a physical uplink binding failure, a switch extension failure or a port that could not be created. Virtual machines on the switch may lose connectivity.

### Summary

The Hyper-V virtual switch logged an Error or Critical event, for example a physical uplink binding failure, a switch extension failure or a port that could not be created. Virtual machines on the switch may lose connectivity.

### Causes

Physical adapter bound to the external switch failed, was disabled or its driver reset.

SET team member loss or NIC driver/firmware fault.

A switch extension (VFP, capture, third-party filter) failed to load.

### Resolutions

Read the event; check Get-VMSwitch, Get-VMSwitchTeam and Get-NetAdapter for the uplink state.

Review the physical network and Network ATC monitors for the same host.

Restart the affected adapter or repair the driver/firmware; recreate the switch binding only as a last resort.

### Support scope

Host-based Hyper-V workload or management evidence. A stopped VM must be compared with its intended state; inventory presence is not guest application monitoring.

Element: HyperVPrivateCloud.Host.Event.VmSwitchError.Alert.Rule. Kind: Rule.

### Alert versus health

Target=HCSV2Library!HyperVPrivateCloud.HostRole; enabled=true; category=Alert. Rules collect data or raise event alerts; they do not themselves create unit-monitor health transitions. Repeated or unresolved rule alerts do not by themselves explain a red DA. Correlate with current leaf monitors and event timestamps before closure.

### Read-only investigation

Run the matching read-only host/VM task. Match the stable VM ID and current owner, inspect Get-VM, attached disks, checkpoint chain and Hyper-V-VMMS/High-Availability logs. For management-service errors verify the named service and first failure rather than assuming every guest stopped.

### Corrective action and escalation

Restore the identified service, configuration, storage or VM dependency with the workload owner. Check intended shutdown and maintenance policy first. Never delete checkpoint files, force power operations or restart VMMS/hosts solely to clear an alert.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm the intended VM/service state, fresh host-derived evidence and the originating monitor. Guest application recovery requires a separate workload-level check.

### Microsoft references

[Microsoft Learn: hyper v start state access failures clustered standalone](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-start-state-access-failures-clustered-standalone)

[Microsoft Learn: hyper v virtual machine backup checkpoint storage](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-virtual-machine-backup-checkpoint-storage)


## Hyper-V clustered virtual machine high-availability error {#hypervprivatecloud.host.event.highavailabilityerror.alert.rule}

`HyperVPrivateCloud.Host.Event.HighAvailabilityError.Alert.Rule`

The Hyper-V high-availability component logged an Error or Critical event for a clustered virtual machine role, such as a failed online, a failed move or a configuration that the cluster cannot reach.

### Summary

The Hyper-V high-availability component logged an Error or Critical event for a clustered virtual machine role, such as a failed online, a failed move or a configuration that the cluster cannot reach.

### Causes

VM configuration or virtual hard disk on storage the destination node cannot reach.

Cluster resource failure or a possible-owner restriction preventing the move.

Virtual switch or network name mismatch between nodes.

### Resolutions

Correlate with the Failover Clustering monitors (group failed, CSV offline) and FailoverClustering-Manager events 1069/1205.

Fix storage or network reachability on the destination node, then bring the role online.

Refresh virtual machine configuration in Failover Cluster Manager after correcting switch or path differences.

### Support scope

Host-based Hyper-V workload or management evidence. A stopped VM must be compared with its intended state; inventory presence is not guest application monitoring.

Element: HyperVPrivateCloud.Host.Event.HighAvailabilityError.Alert.Rule. Kind: Rule.

### Alert versus health

Target=HCSV2Library!HyperVPrivateCloud.HostRole; enabled=true; category=Alert. Rules collect data or raise event alerts; they do not themselves create unit-monitor health transitions. Repeated or unresolved rule alerts do not by themselves explain a red DA. Correlate with current leaf monitors and event timestamps before closure.

### Read-only investigation

Run the matching read-only host/VM task. Match the stable VM ID and current owner, inspect Get-VM, attached disks, checkpoint chain and Hyper-V-VMMS/High-Availability logs. For management-service errors verify the named service and first failure rather than assuming every guest stopped.

### Corrective action and escalation

Restore the identified service, configuration, storage or VM dependency with the workload owner. Check intended shutdown and maintenance policy first. Never delete checkpoint files, force power operations or restart VMMS/hosts solely to clear an alert.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm the intended VM/service state, fresh host-derived evidence and the originating monitor. Guest application recovery requires a separate workload-level check.

### Microsoft references

[Microsoft Learn: hyper v start state access failures clustered standalone](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-start-state-access-failures-clustered-standalone)

[Microsoft Learn: hyper v virtual machine backup checkpoint storage](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-virtual-machine-backup-checkpoint-storage)


## Hyper-V Host Compute Service reported an error {#hypervprivatecloud.host.event.computeerror.alert.rule}

`HyperVPrivateCloud.Host.Event.ComputeError.Alert.Rule`

The Host Compute Service (vmcompute) logged an Error or Critical event. Modern Hyper-V VM and container operations route through this service; errors indicate failed compute system creation, start or configuration.

### Summary

The Host Compute Service (vmcompute) logged an Error or Critical event. Modern Hyper-V VM and container operations route through this service; errors indicate failed compute system creation, start or configuration.

### Causes

Service crash or resource exhaustion on the host.

Corrupt or inaccessible VM configuration.

Incompatible VM configuration version after a host upgrade.

### Resolutions

Read the event text; check the vmcompute service and the Host Compute service monitor.

Verify the VM configuration and upgrade its version if the host was upgraded (Update-VMVersion).

Restart the Host Compute Service only when no VM operations are in progress.

### Support scope

Host-based Hyper-V workload or management evidence. A stopped VM must be compared with its intended state; inventory presence is not guest application monitoring.

Element: HyperVPrivateCloud.Host.Event.ComputeError.Alert.Rule. Kind: Rule.

### Alert versus health

Target=HCSV2Library!HyperVPrivateCloud.HostRole; enabled=true; category=Alert. Rules collect data or raise event alerts; they do not themselves create unit-monitor health transitions. Repeated or unresolved rule alerts do not by themselves explain a red DA. Correlate with current leaf monitors and event timestamps before closure.

### Read-only investigation

Run the matching read-only host/VM task. Match the stable VM ID and current owner, inspect Get-VM, attached disks, checkpoint chain and Hyper-V-VMMS/High-Availability logs. For management-service errors verify the named service and first failure rather than assuming every guest stopped.

### Corrective action and escalation

Restore the identified service, configuration, storage or VM dependency with the workload owner. Check intended shutdown and maintenance policy first. Never delete checkpoint files, force power operations or restart VMMS/hosts solely to clear an alert.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm the intended VM/service state, fresh host-derived evidence and the originating monitor. Guest application recovery requires a separate workload-level check.

### Microsoft references

[Microsoft Learn: hyper v start state access failures clustered standalone](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-start-state-access-failures-clustered-standalone)

[Microsoft Learn: hyper v virtual machine backup checkpoint storage](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-virtual-machine-backup-checkpoint-storage)


## Hyper-V virtual machine configuration error {#hypervprivatecloud.host.event.configerror.alert.rule}

`HyperVPrivateCloud.Host.Event.ConfigError.Alert.Rule`

The Hyper-V configuration store logged an Error or Critical event: a VM configuration file (.vmcx/.vmrs) could not be read, written or is corrupt. The VM may fail to start or lose settings.

### Summary

The Hyper-V configuration store logged an Error or Critical event: a VM configuration file (.vmcx/.vmrs) could not be read, written or is corrupt. The VM may fail to start or lose settings.

### Causes

Unclean shutdown or storage failure while the configuration was being written.

Configuration path on storage that is offline or read-only.

Permissions on the configuration folder changed.

### Resolutions

Locate the VM and path from the event; verify the storage is online and writable.

Restore the configuration from backup or the .vmcx copy and re-import if corrupt.

Check NTFS permissions for the NT Virtual Machine\Virtual Machines identity.

### Support scope

Host-based Hyper-V workload or management evidence. A stopped VM must be compared with its intended state; inventory presence is not guest application monitoring.

Element: HyperVPrivateCloud.Host.Event.ConfigError.Alert.Rule. Kind: Rule.

### Alert versus health

Target=HCSV2Library!HyperVPrivateCloud.HostRole; enabled=true; category=Alert. Rules collect data or raise event alerts; they do not themselves create unit-monitor health transitions. Repeated or unresolved rule alerts do not by themselves explain a red DA. Correlate with current leaf monitors and event timestamps before closure.

### Read-only investigation

Run the matching read-only host/VM task. Match the stable VM ID and current owner, inspect Get-VM, attached disks, checkpoint chain and Hyper-V-VMMS/High-Availability logs. For management-service errors verify the named service and first failure rather than assuming every guest stopped.

### Corrective action and escalation

Restore the identified service, configuration, storage or VM dependency with the workload owner. Check intended shutdown and maintenance policy first. Never delete checkpoint files, force power operations or restart VMMS/hosts solely to clear an alert.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm the intended VM/service state, fresh host-derived evidence and the originating monitor. Guest application recovery requires a separate workload-level check.

### Microsoft references

[Microsoft Learn: hyper v start state access failures clustered standalone](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-start-state-access-failures-clustered-standalone)

[Microsoft Learn: hyper v virtual machine backup checkpoint storage](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-virtual-machine-backup-checkpoint-storage)


## Collect Hyper-V diagnostic and PowerShell runtime summary {#hypervprivatecloud.diagnosticsummary.task}

`HyperVPrivateCloud.DiagnosticSummary.Task`

Returns a read-only summary of the executing PowerShell process plus host, VM, switch, and replication state.

### Support scope

A discovered identity, logical boundary, component group or health dependency in the private-cloud service model. Containment draws a diagram; only authored monitors and health dependencies determine its health.

Element: HyperVPrivateCloud.DiagnosticSummary.Task. Kind: Task.

### Execution safety

Target=HCSV2Library!HyperVPrivateCloud.HostRole; enabled=true; timeout=180. Read the task&#39;s original knowledge and parameters before execution. A Remediation task changes state and requires approval; do not execute it solely because the object is red. Even a diagnostic can generate logs or files; review its documented impact.

### Read-only investigation

Open Health Explorer from the unhealthy DA, follow the failing health aspect and dependency to the named leaf object, and read its state-change context and knowledge. Check whether the object is an inventory-only reference or an authoritative monitor target. Record the complete root-to-leaf path.

### Corrective action and escalation

Repair the originating leaf condition using its specific runbook and owner. Do not reset or edit a parent DA to conceal child health. Missing relationships or wrong aspect routing require a source change, tests and a new sealed MP version.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm fresh healthy leaf evidence and follow recovery through each dependency back to the solution root. Unknown/unmonitored objects and absent optional capabilities must not be described as fully monitored healthy services.

### Microsoft references

[Microsoft Learn: manage consoles overview healthexplorer](https://learn.microsoft.com/en-us/system-center/scom/manage-consoles-overview-healthexplorer?view=sc-om-2025)


## List virtual machines on this host {#hypervprivatecloud.host.vminventory.task}

`HyperVPrivateCloud.Host.VmInventory.Task`

Get-VM: state, status, uptime, processors, memory, configuration version, cluster membership and start action for every VM on the host.

### Summary

List virtual machines on this host

### What it runs

Get-VM: state, status, uptime, processors, memory, configuration version, cluster membership and start action for every VM on the host.

### Impact

Read-only. The task runs the query on the agent and returns text; it changes nothing.

### Support scope

Host-based Hyper-V workload or management evidence. A stopped VM must be compared with its intended state; inventory presence is not guest application monitoring.

Element: HyperVPrivateCloud.Host.VmInventory.Task. Kind: Task.

### Execution safety

Target=HCSV2Library!HyperVPrivateCloud.HostRole; enabled=true; timeout=180. Read the task&#39;s original knowledge and parameters before execution. A Remediation task changes state and requires approval; do not execute it solely because the object is red. Even a diagnostic can generate logs or files; review its documented impact.

### Read-only investigation

Run the matching read-only host/VM task. Match the stable VM ID and current owner, inspect Get-VM, attached disks, checkpoint chain and Hyper-V-VMMS/High-Availability logs. For management-service errors verify the named service and first failure rather than assuming every guest stopped.

### Corrective action and escalation

Restore the identified service, configuration, storage or VM dependency with the workload owner. Check intended shutdown and maintenance policy first. Never delete checkpoint files, force power operations or restart VMMS/hosts solely to clear an alert.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm the intended VM/service state, fresh host-derived evidence and the originating monitor. Guest application recovery requires a separate workload-level check.

### Microsoft references

[Microsoft Learn: hyper v start state access failures clustered standalone](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-start-state-access-failures-clustered-standalone)

[Microsoft Learn: hyper v virtual machine backup checkpoint storage](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-virtual-machine-backup-checkpoint-storage)


## Show host resource headroom {#hypervprivatecloud.host.headroom.task}

`HyperVPrivateCloud.Host.Headroom.Task`

Logical processors versus assigned virtual processors, physical memory versus assigned and demanded VM memory, NUMA topology and spanning.

### Summary

Show host resource headroom

### What it runs

Logical processors versus assigned virtual processors, physical memory versus assigned and demanded VM memory, NUMA topology and spanning.

### Impact

Read-only. The task runs the query on the agent and returns text; it changes nothing.

### Support scope

Host-based Hyper-V workload or management evidence. A stopped VM must be compared with its intended state; inventory presence is not guest application monitoring.

Element: HyperVPrivateCloud.Host.Headroom.Task. Kind: Task.

### Execution safety

Target=HCSV2Library!HyperVPrivateCloud.HostRole; enabled=true; timeout=180. Read the task&#39;s original knowledge and parameters before execution. A Remediation task changes state and requires approval; do not execute it solely because the object is red. Even a diagnostic can generate logs or files; review its documented impact.

### Read-only investigation

Run the matching read-only host/VM task. Match the stable VM ID and current owner, inspect Get-VM, attached disks, checkpoint chain and Hyper-V-VMMS/High-Availability logs. For management-service errors verify the named service and first failure rather than assuming every guest stopped.

### Corrective action and escalation

Restore the identified service, configuration, storage or VM dependency with the workload owner. Check intended shutdown and maintenance policy first. Never delete checkpoint files, force power operations or restart VMMS/hosts solely to clear an alert.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm the intended VM/service state, fresh host-derived evidence and the originating monitor. Guest application recovery requires a separate workload-level check.

### Microsoft references

[Microsoft Learn: hyper v start state access failures clustered standalone](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-start-state-access-failures-clustered-standalone)

[Microsoft Learn: hyper v virtual machine backup checkpoint storage](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-virtual-machine-backup-checkpoint-storage)


## Show recent Hyper-V errors and warnings {#hypervprivatecloud.host.eventtail.task}

`HyperVPrivateCloud.Host.EventTail.Task`

The most recent Error/Warning events from the VMMS, Worker, Hypervisor, StorageVSP and Config admin channels. Parameter = number of events per channel (default 25).

### Summary

Show recent Hyper-V errors and warnings

### What it runs

The most recent Error/Warning events from the VMMS, Worker, Hypervisor, StorageVSP and Config admin channels. Parameter = number of events per channel (default 25).

### Impact

Read-only. The task runs the query on the agent and returns text; it changes nothing.

### Support scope

Host-based Hyper-V workload or management evidence. A stopped VM must be compared with its intended state; inventory presence is not guest application monitoring.

Element: HyperVPrivateCloud.Host.EventTail.Task. Kind: Task.

### Execution safety

Target=HCSV2Library!HyperVPrivateCloud.HostRole; enabled=true; timeout=180. Read the task&#39;s original knowledge and parameters before execution. A Remediation task changes state and requires approval; do not execute it solely because the object is red. Even a diagnostic can generate logs or files; review its documented impact.

### Read-only investigation

Run the matching read-only host/VM task. Match the stable VM ID and current owner, inspect Get-VM, attached disks, checkpoint chain and Hyper-V-VMMS/High-Availability logs. For management-service errors verify the named service and first failure rather than assuming every guest stopped.

### Corrective action and escalation

Restore the identified service, configuration, storage or VM dependency with the workload owner. Check intended shutdown and maintenance policy first. Never delete checkpoint files, force power operations or restart VMMS/hosts solely to clear an alert.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm the intended VM/service state, fresh host-derived evidence and the originating monitor. Guest application recovery requires a separate workload-level check.

### Microsoft references

[Microsoft Learn: hyper v start state access failures clustered standalone](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-start-state-access-failures-clustered-standalone)

[Microsoft Learn: hyper v virtual machine backup checkpoint storage](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-virtual-machine-backup-checkpoint-storage)


## Show live migration settings and recent migrations {#hypervprivatecloud.host.livemigrationsettings.task}

`HyperVPrivateCloud.Host.LiveMigrationSettings.Task`

Get-VMHost migration settings, migration networks and the last twenty live-migration events (20413, 20417, 21501, 21502, 21125, 21024).

### Summary

Show live migration settings and recent migrations

### What it runs

Get-VMHost migration settings, migration networks and the last twenty live-migration events (20413, 20417, 21501, 21502, 21125, 21024).

### Impact

Read-only. The task runs the query on the agent and returns text; it changes nothing.

### Support scope

Host-based Hyper-V workload or management evidence. A stopped VM must be compared with its intended state; inventory presence is not guest application monitoring.

Element: HyperVPrivateCloud.Host.LiveMigrationSettings.Task. Kind: Task.

### Execution safety

Target=HCSV2Library!HyperVPrivateCloud.HostRole; enabled=true; timeout=180. Read the task&#39;s original knowledge and parameters before execution. A Remediation task changes state and requires approval; do not execute it solely because the object is red. Even a diagnostic can generate logs or files; review its documented impact.

### Read-only investigation

Run the matching read-only host/VM task. Match the stable VM ID and current owner, inspect Get-VM, attached disks, checkpoint chain and Hyper-V-VMMS/High-Availability logs. For management-service errors verify the named service and first failure rather than assuming every guest stopped.

### Corrective action and escalation

Restore the identified service, configuration, storage or VM dependency with the workload owner. Check intended shutdown and maintenance policy first. Never delete checkpoint files, force power operations or restart VMMS/hosts solely to clear an alert.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm the intended VM/service state, fresh host-derived evidence and the originating monitor. Guest application recovery requires a separate workload-level check.

### Microsoft references

[Microsoft Learn: hyper v start state access failures clustered standalone](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-start-state-access-failures-clustered-standalone)

[Microsoft Learn: hyper v virtual machine backup checkpoint storage](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-virtual-machine-backup-checkpoint-storage)


## Show virtual switch, SET team and uplink configuration {#hypervprivatecloud.host.switchconfiguration.task}

`HyperVPrivateCloud.Host.SwitchConfiguration.Task`

Get-VMSwitch, Get-VMSwitchTeam, physical adapters with driver versions and RDMA state.

### Summary

Show virtual switch, SET team and uplink configuration

### What it runs

Get-VMSwitch, Get-VMSwitchTeam, physical adapters with driver versions and RDMA state.

### Impact

Read-only. The task runs the query on the agent and returns text; it changes nothing.

### Support scope

Host-based Hyper-V workload or management evidence. A stopped VM must be compared with its intended state; inventory presence is not guest application monitoring.

Element: HyperVPrivateCloud.Host.SwitchConfiguration.Task. Kind: Task.

### Execution safety

Target=HCSV2Library!HyperVPrivateCloud.HostRole; enabled=true; timeout=180. Read the task&#39;s original knowledge and parameters before execution. A Remediation task changes state and requires approval; do not execute it solely because the object is red. Even a diagnostic can generate logs or files; review its documented impact.

### Read-only investigation

Run the matching read-only host/VM task. Match the stable VM ID and current owner, inspect Get-VM, attached disks, checkpoint chain and Hyper-V-VMMS/High-Availability logs. For management-service errors verify the named service and first failure rather than assuming every guest stopped.

### Corrective action and escalation

Restore the identified service, configuration, storage or VM dependency with the workload owner. Check intended shutdown and maintenance policy first. Never delete checkpoint files, force power operations or restart VMMS/hosts solely to clear an alert.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm the intended VM/service state, fresh host-derived evidence and the originating monitor. Guest application recovery requires a separate workload-level check.

### Microsoft references

[Microsoft Learn: hyper v start state access failures clustered standalone](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-start-state-access-failures-clustered-standalone)

[Microsoft Learn: hyper v virtual machine backup checkpoint storage](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-virtual-machine-backup-checkpoint-storage)


## Check for a pending reboot {#hypervprivatecloud.host.pendingreboot.task}

`HyperVPrivateCloud.Host.PendingReboot.Task`

Component Based Servicing, Windows Update and pending file-rename reboot flags plus the last boot time.

### Summary

Check for a pending reboot

### What it runs

Component Based Servicing, Windows Update and pending file-rename reboot flags plus the last boot time.

### Impact

Read-only. The task runs the query on the agent and returns text; it changes nothing.

### Support scope

Host-based Hyper-V workload or management evidence. A stopped VM must be compared with its intended state; inventory presence is not guest application monitoring.

Element: HyperVPrivateCloud.Host.PendingReboot.Task. Kind: Task.

### Execution safety

Target=HCSV2Library!HyperVPrivateCloud.HostRole; enabled=true; timeout=120. Read the task&#39;s original knowledge and parameters before execution. A Remediation task changes state and requires approval; do not execute it solely because the object is red. Even a diagnostic can generate logs or files; review its documented impact.

### Read-only investigation

Run the matching read-only host/VM task. Match the stable VM ID and current owner, inspect Get-VM, attached disks, checkpoint chain and Hyper-V-VMMS/High-Availability logs. For management-service errors verify the named service and first failure rather than assuming every guest stopped.

### Corrective action and escalation

Restore the identified service, configuration, storage or VM dependency with the workload owner. Check intended shutdown and maintenance policy first. Never delete checkpoint files, force power operations or restart VMMS/hosts solely to clear an alert.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm the intended VM/service state, fresh host-derived evidence and the originating monitor. Guest application recovery requires a separate workload-level check.

### Microsoft references

[Microsoft Learn: hyper v start state access failures clustered standalone](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-start-state-access-failures-clustered-standalone)

[Microsoft Learn: hyper v virtual machine backup checkpoint storage](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-virtual-machine-backup-checkpoint-storage)


## Run the monitoring pipeline self-test {#hypervprivatecloud.host.pipelineselftest.task}

`HyperVPrivateCloud.Host.PipelineSelfTest.Task`

PowerShell version and process, module availability (Hyper-V, FailoverClusters, Storage), hypervisor presence, VMMS/Host Compute/HealthService state and whether Get-VM succeeds under the agent account.

### Summary

Run the monitoring pipeline self-test

### What it runs

PowerShell version and process, module availability (Hyper-V, FailoverClusters, Storage), hypervisor presence, VMMS/Host Compute/HealthService state and whether Get-VM succeeds under the agent account.

### Impact

Read-only. The task runs the query on the agent and returns text; it changes nothing.

### Support scope

Monitoring capability, data collection or freshness. Failure means visibility is impaired; do not infer that the monitored workload itself is down or healthy.

Element: HyperVPrivateCloud.Host.PipelineSelfTest.Task. Kind: Task.

### Execution safety

Target=HCSV2Library!HyperVPrivateCloud.HostRole; enabled=true; timeout=120. Read the task&#39;s original knowledge and parameters before execution. A Remediation task changes state and requires approval; do not execute it solely because the object is red. Even a diagnostic can generate logs or files; review its documented impact.

### Read-only investigation

Read the first probe error and Operations Manager event context. Verify HealthService availability, supported PowerShell runtime, required modules, Run As scope and agent proxy where cross-object discovery requires it. Compare last successful sample and discovery time.

### Corrective action and escalation

Correct the missing runtime/module, access or source defect. Preserve logs before any approved HealthService restart. Do not reset health or clear the agent cache as a substitute for understanding a repeatable script error.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Require a new successful discovery/sample and initialized leaf monitors. Old green values cannot establish recovery of a broken collector.

### Microsoft references

[Microsoft Learn: manage consoles overview healthexplorer](https://learn.microsoft.com/en-us/system-center/scom/manage-consoles-overview-healthexplorer?view=sc-om-2025)


## Run the Hyper-V Best Practices Analyzer {#hypervprivatecloud.host.bpa.task}

`HyperVPrivateCloud.Host.Bpa.Task`

Invoke-BpaModel Microsoft/Windows/Hyper-V and list non-compliant Warning and Error results.

### Summary

Run the Hyper-V Best Practices Analyzer

### What it runs

Invoke-BpaModel Microsoft/Windows/Hyper-V and list non-compliant Warning and Error results.

### Impact

Read-only. The task runs the query on the agent and returns text; it changes nothing.

### Support scope

Host-based Hyper-V workload or management evidence. A stopped VM must be compared with its intended state; inventory presence is not guest application monitoring.

Element: HyperVPrivateCloud.Host.Bpa.Task. Kind: Task.

### Execution safety

Target=HCSV2Library!HyperVPrivateCloud.HostRole; enabled=true; timeout=600. Read the task&#39;s original knowledge and parameters before execution. A Remediation task changes state and requires approval; do not execute it solely because the object is red. Even a diagnostic can generate logs or files; review its documented impact.

### Read-only investigation

Run the matching read-only host/VM task. Match the stable VM ID and current owner, inspect Get-VM, attached disks, checkpoint chain and Hyper-V-VMMS/High-Availability logs. For management-service errors verify the named service and first failure rather than assuming every guest stopped.

### Corrective action and escalation

Restore the identified service, configuration, storage or VM dependency with the workload owner. Check intended shutdown and maintenance policy first. Never delete checkpoint files, force power operations or restart VMMS/hosts solely to clear an alert.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm the intended VM/service state, fresh host-derived evidence and the originating monitor. Guest application recovery requires a separate workload-level check.

### Microsoft references

[Microsoft Learn: hyper v start state access failures clustered standalone](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-start-state-access-failures-clustered-standalone)

[Microsoft Learn: hyper v virtual machine backup checkpoint storage](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-virtual-machine-backup-checkpoint-storage)


## Remediation: Restart the Virtual Machine Management Service {#hypervprivatecloud.host.restartvmms.task}

`HyperVPrivateCloud.Host.RestartVmms.Task`

Restart-Service vmms. Running VMs keep running; management operations pause for a few seconds.

### Summary

Restart the Virtual Machine Management Service

### What it runs

Restart-Service vmms. Running VMs keep running; management operations pause for a few seconds.

### Impact

This task changes the state of the target. The console asks for confirmation before it runs; use the read-only tasks first to confirm the diagnosis, and run it inside a change window where the environment requires one. The task output reports the resulting state.

### Support scope

Host-based Hyper-V workload or management evidence. A stopped VM must be compared with its intended state; inventory presence is not guest application monitoring.

Element: HyperVPrivateCloud.Host.RestartVmms.Task. Kind: Task.

### Execution safety

Target=HCSV2Library!HyperVPrivateCloud.HostRole; enabled=true; timeout=240. Read the task&#39;s original knowledge and parameters before execution. A Remediation task changes state and requires approval; do not execute it solely because the object is red. Even a diagnostic can generate logs or files; review its documented impact.

### Read-only investigation

Run the matching read-only host/VM task. Match the stable VM ID and current owner, inspect Get-VM, attached disks, checkpoint chain and Hyper-V-VMMS/High-Availability logs. For management-service errors verify the named service and first failure rather than assuming every guest stopped.

### Corrective action and escalation

Restore the identified service, configuration, storage or VM dependency with the workload owner. Check intended shutdown and maintenance policy first. Never delete checkpoint files, force power operations or restart VMMS/hosts solely to clear an alert.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm the intended VM/service state, fresh host-derived evidence and the originating monitor. Guest application recovery requires a separate workload-level check.

### Microsoft references

[Microsoft Learn: hyper v start state access failures clustered standalone](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-start-state-access-failures-clustered-standalone)

[Microsoft Learn: hyper v virtual machine backup checkpoint storage](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-virtual-machine-backup-checkpoint-storage)


## Remediation: Restart the Host Compute Service {#hypervprivatecloud.host.restartvmcompute.task}

`HyperVPrivateCloud.Host.RestartVmCompute.Task`

Restart-Service vmcompute. Do not run while VM operations are in progress.

### Summary

Restart the Host Compute Service

### What it runs

Restart-Service vmcompute. Do not run while VM operations are in progress.

### Impact

This task changes the state of the target. The console asks for confirmation before it runs; use the read-only tasks first to confirm the diagnosis, and run it inside a change window where the environment requires one. The task output reports the resulting state.

### Support scope

Host-based Hyper-V workload or management evidence. A stopped VM must be compared with its intended state; inventory presence is not guest application monitoring.

Element: HyperVPrivateCloud.Host.RestartVmCompute.Task. Kind: Task.

### Execution safety

Target=HCSV2Library!HyperVPrivateCloud.HostRole; enabled=true; timeout=240. Read the task&#39;s original knowledge and parameters before execution. A Remediation task changes state and requires approval; do not execute it solely because the object is red. Even a diagnostic can generate logs or files; review its documented impact.

### Read-only investigation

Run the matching read-only host/VM task. Match the stable VM ID and current owner, inspect Get-VM, attached disks, checkpoint chain and Hyper-V-VMMS/High-Availability logs. For management-service errors verify the named service and first failure rather than assuming every guest stopped.

### Corrective action and escalation

Restore the identified service, configuration, storage or VM dependency with the workload owner. Check intended shutdown and maintenance policy first. Never delete checkpoint files, force power operations or restart VMMS/hosts solely to clear an alert.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm the intended VM/service state, fresh host-derived evidence and the originating monitor. Guest application recovery requires a separate workload-level check.

### Microsoft references

[Microsoft Learn: hyper v start state access failures clustered standalone](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-start-state-access-failures-clustered-standalone)

[Microsoft Learn: hyper v virtual machine backup checkpoint storage](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-virtual-machine-backup-checkpoint-storage)


## Show virtual machine detail {#hypervprivatecloud.vmruntime.detail.task}

`HyperVPrivateCloud.VmRuntime.Detail.Task`

Configuration, integration services, network adapters with VLAN and IP, virtual hard disks with the full VHD chain and AVHDX sizes, and checkpoints.

### Summary

Show virtual machine detail

### What it runs

Configuration, integration services, network adapters with VLAN and IP, virtual hard disks with the full VHD chain and AVHDX sizes, and checkpoints.

### Impact

Read-only. The task runs the query on the agent and returns text; it changes nothing.

### Support scope

Host-based Hyper-V workload or management evidence. A stopped VM must be compared with its intended state; inventory presence is not guest application monitoring.

Element: HyperVPrivateCloud.VmRuntime.Detail.Task. Kind: Task.

### Execution safety

Target=HCSV2Library!HyperVPrivateCloud.VirtualMachineRuntime; enabled=true; timeout=180. Read the task&#39;s original knowledge and parameters before execution. A Remediation task changes state and requires approval; do not execute it solely because the object is red. Even a diagnostic can generate logs or files; review its documented impact.

### Read-only investigation

Run the matching read-only host/VM task. Match the stable VM ID and current owner, inspect Get-VM, attached disks, checkpoint chain and Hyper-V-VMMS/High-Availability logs. For management-service errors verify the named service and first failure rather than assuming every guest stopped.

### Corrective action and escalation

Restore the identified service, configuration, storage or VM dependency with the workload owner. Check intended shutdown and maintenance policy first. Never delete checkpoint files, force power operations or restart VMMS/hosts solely to clear an alert.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm the intended VM/service state, fresh host-derived evidence and the originating monitor. Guest application recovery requires a separate workload-level check.

### Microsoft references

[Microsoft Learn: hyper v start state access failures clustered standalone](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-start-state-access-failures-clustered-standalone)

[Microsoft Learn: hyper v virtual machine backup checkpoint storage](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-virtual-machine-backup-checkpoint-storage)


## Show virtual machine performance snapshot {#hypervprivatecloud.vmruntime.performance.task}

`HyperVPrivateCloud.VmRuntime.Performance.Task`

Measure-VM resource metering when enabled, plus live virtual processor and Dynamic Memory pressure counters.

### Summary

Show virtual machine performance snapshot

### What it runs

Measure-VM resource metering when enabled, plus live virtual processor and Dynamic Memory pressure counters.

### Impact

Read-only. The task runs the query on the agent and returns text; it changes nothing.

### Support scope

Host-based Hyper-V workload or management evidence. A stopped VM must be compared with its intended state; inventory presence is not guest application monitoring.

Element: HyperVPrivateCloud.VmRuntime.Performance.Task. Kind: Task.

### Execution safety

Target=HCSV2Library!HyperVPrivateCloud.VirtualMachineRuntime; enabled=true; timeout=180. Read the task&#39;s original knowledge and parameters before execution. A Remediation task changes state and requires approval; do not execute it solely because the object is red. Even a diagnostic can generate logs or files; review its documented impact.

### Read-only investigation

Run the matching read-only host/VM task. Match the stable VM ID and current owner, inspect Get-VM, attached disks, checkpoint chain and Hyper-V-VMMS/High-Availability logs. For management-service errors verify the named service and first failure rather than assuming every guest stopped.

### Corrective action and escalation

Restore the identified service, configuration, storage or VM dependency with the workload owner. Check intended shutdown and maintenance policy first. Never delete checkpoint files, force power operations or restart VMMS/hosts solely to clear an alert.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm the intended VM/service state, fresh host-derived evidence and the originating monitor. Guest application recovery requires a separate workload-level check.

### Microsoft references

[Microsoft Learn: hyper v start state access failures clustered standalone](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-start-state-access-failures-clustered-standalone)

[Microsoft Learn: hyper v virtual machine backup checkpoint storage](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-virtual-machine-backup-checkpoint-storage)


## Show Hyper-V Replica status {#hypervprivatecloud.vmruntime.replica.task}

`HyperVPrivateCloud.VmRuntime.Replica.Task`

Get-VMReplication and Measure-VMReplication for the VM.

### Summary

Show Hyper-V Replica status

### What it runs

Get-VMReplication and Measure-VMReplication for the VM.

### Impact

Read-only. The task runs the query on the agent and returns text; it changes nothing.

### Support scope

Host-observed replication state and disaster-recovery protection, not an application availability test inside the guest.

Element: HyperVPrivateCloud.VmRuntime.Replica.Task. Kind: Task.

### Execution safety

Target=HCSV2Library!HyperVPrivateCloud.VirtualMachineRuntime; enabled=true; timeout=180. Read the task&#39;s original knowledge and parameters before execution. A Remediation task changes state and requires approval; do not execute it solely because the object is red. Even a diagnostic can generate logs or files; review its documented impact.

### Read-only investigation

Use Get-VMReplication and Measure-VMReplication for the named VM on its owner. Inspect replication mode, primary/replica server, health, last replication time and backlog. For a cluster broker, follow network-name and broker resource dependencies. Distinguish planned pause, initial replication and unexpected loss of protection.

### Corrective action and escalation

Restore the actual authentication, certificate, broker, network or storage dependency. Coordinate resume or resynchronization with the recovery owner and verify bandwidth/storage impact. Never perform failover, reverse replication or remove/recreate protection solely to clear an alert.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm replication resumes and lag meets the agreed recovery-point objective. A healthy running primary VM alone does not establish healthy disaster recovery.

### Microsoft references

[Microsoft Learn: hyper v replica troubleshooting guide](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-replica-troubleshooting-guide)


## Remediation: Start the virtual machine {#hypervprivatecloud.vmruntime.start.task}

`HyperVPrivateCloud.VmRuntime.Start.Task`

Start-VM.

### Summary

Start the virtual machine

### What it runs

Start-VM.

### Impact

This task changes the state of the target. The console asks for confirmation before it runs; use the read-only tasks first to confirm the diagnosis, and run it inside a change window where the environment requires one. The task output reports the resulting state.

### Support scope

Host-based Hyper-V workload or management evidence. A stopped VM must be compared with its intended state; inventory presence is not guest application monitoring.

Element: HyperVPrivateCloud.VmRuntime.Start.Task. Kind: Task.

### Execution safety

Target=HCSV2Library!HyperVPrivateCloud.VirtualMachineRuntime; enabled=true; timeout=300. Read the task&#39;s original knowledge and parameters before execution. A Remediation task changes state and requires approval; do not execute it solely because the object is red. Even a diagnostic can generate logs or files; review its documented impact.

### Read-only investigation

Run the matching read-only host/VM task. Match the stable VM ID and current owner, inspect Get-VM, attached disks, checkpoint chain and Hyper-V-VMMS/High-Availability logs. For management-service errors verify the named service and first failure rather than assuming every guest stopped.

### Corrective action and escalation

Restore the identified service, configuration, storage or VM dependency with the workload owner. Check intended shutdown and maintenance policy first. Never delete checkpoint files, force power operations or restart VMMS/hosts solely to clear an alert.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm the intended VM/service state, fresh host-derived evidence and the originating monitor. Guest application recovery requires a separate workload-level check.

### Microsoft references

[Microsoft Learn: hyper v start state access failures clustered standalone](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-start-state-access-failures-clustered-standalone)

[Microsoft Learn: hyper v virtual machine backup checkpoint storage](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-virtual-machine-backup-checkpoint-storage)


## Remediation: Shut down the virtual machine {#hypervprivatecloud.vmruntime.stop.task}

`HyperVPrivateCloud.VmRuntime.Stop.Task`

Stop-VM -Force (guest shutdown through integration services; turns the VM off if the guest does not respond).

### Summary

Shut down the virtual machine

### What it runs

Stop-VM -Force (guest shutdown through integration services; turns the VM off if the guest does not respond).

### Impact

This task changes the state of the target. The console asks for confirmation before it runs; use the read-only tasks first to confirm the diagnosis, and run it inside a change window where the environment requires one. The task output reports the resulting state.

### Support scope

Host-based Hyper-V workload or management evidence. A stopped VM must be compared with its intended state; inventory presence is not guest application monitoring.

Element: HyperVPrivateCloud.VmRuntime.Stop.Task. Kind: Task.

### Execution safety

Target=HCSV2Library!HyperVPrivateCloud.VirtualMachineRuntime; enabled=true; timeout=600. Read the task&#39;s original knowledge and parameters before execution. A Remediation task changes state and requires approval; do not execute it solely because the object is red. Even a diagnostic can generate logs or files; review its documented impact.

### Read-only investigation

Run the matching read-only host/VM task. Match the stable VM ID and current owner, inspect Get-VM, attached disks, checkpoint chain and Hyper-V-VMMS/High-Availability logs. For management-service errors verify the named service and first failure rather than assuming every guest stopped.

### Corrective action and escalation

Restore the identified service, configuration, storage or VM dependency with the workload owner. Check intended shutdown and maintenance policy first. Never delete checkpoint files, force power operations or restart VMMS/hosts solely to clear an alert.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm the intended VM/service state, fresh host-derived evidence and the originating monitor. Guest application recovery requires a separate workload-level check.

### Microsoft references

[Microsoft Learn: hyper v start state access failures clustered standalone](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-start-state-access-failures-clustered-standalone)

[Microsoft Learn: hyper v virtual machine backup checkpoint storage](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-virtual-machine-backup-checkpoint-storage)


## Remediation: Save the virtual machine state {#hypervprivatecloud.vmruntime.save.task}

`HyperVPrivateCloud.VmRuntime.Save.Task`

Save-VM.

### Summary

Save the virtual machine state

### What it runs

Save-VM.

### Impact

This task changes the state of the target. The console asks for confirmation before it runs; use the read-only tasks first to confirm the diagnosis, and run it inside a change window where the environment requires one. The task output reports the resulting state.

### Support scope

Host-based Hyper-V workload or management evidence. A stopped VM must be compared with its intended state; inventory presence is not guest application monitoring.

Element: HyperVPrivateCloud.VmRuntime.Save.Task. Kind: Task.

### Execution safety

Target=HCSV2Library!HyperVPrivateCloud.VirtualMachineRuntime; enabled=true; timeout=600. Read the task&#39;s original knowledge and parameters before execution. A Remediation task changes state and requires approval; do not execute it solely because the object is red. Even a diagnostic can generate logs or files; review its documented impact.

### Read-only investigation

Run the matching read-only host/VM task. Match the stable VM ID and current owner, inspect Get-VM, attached disks, checkpoint chain and Hyper-V-VMMS/High-Availability logs. For management-service errors verify the named service and first failure rather than assuming every guest stopped.

### Corrective action and escalation

Restore the identified service, configuration, storage or VM dependency with the workload owner. Check intended shutdown and maintenance policy first. Never delete checkpoint files, force power operations or restart VMMS/hosts solely to clear an alert.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm the intended VM/service state, fresh host-derived evidence and the originating monitor. Guest application recovery requires a separate workload-level check.

### Microsoft references

[Microsoft Learn: hyper v start state access failures clustered standalone](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-start-state-access-failures-clustered-standalone)

[Microsoft Learn: hyper v virtual machine backup checkpoint storage](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-virtual-machine-backup-checkpoint-storage)


## Remediation: Resume a paused virtual machine {#hypervprivatecloud.vmruntime.resume.task}

`HyperVPrivateCloud.VmRuntime.Resume.Task`

Resume-VM. Use after the storage behind a paused-critical VM has been restored.

### Summary

Resume a paused virtual machine

### What it runs

Resume-VM. Use after the storage behind a paused-critical VM has been restored.

### Impact

This task changes the state of the target. The console asks for confirmation before it runs; use the read-only tasks first to confirm the diagnosis, and run it inside a change window where the environment requires one. The task output reports the resulting state.

### Support scope

Host-based Hyper-V workload or management evidence. A stopped VM must be compared with its intended state; inventory presence is not guest application monitoring.

Element: HyperVPrivateCloud.VmRuntime.Resume.Task. Kind: Task.

### Execution safety

Target=HCSV2Library!HyperVPrivateCloud.VirtualMachineRuntime; enabled=true; timeout=300. Read the task&#39;s original knowledge and parameters before execution. A Remediation task changes state and requires approval; do not execute it solely because the object is red. Even a diagnostic can generate logs or files; review its documented impact.

### Read-only investigation

Run the matching read-only host/VM task. Match the stable VM ID and current owner, inspect Get-VM, attached disks, checkpoint chain and Hyper-V-VMMS/High-Availability logs. For management-service errors verify the named service and first failure rather than assuming every guest stopped.

### Corrective action and escalation

Restore the identified service, configuration, storage or VM dependency with the workload owner. Check intended shutdown and maintenance policy first. Never delete checkpoint files, force power operations or restart VMMS/hosts solely to clear an alert.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm the intended VM/service state, fresh host-derived evidence and the originating monitor. Guest application recovery requires a separate workload-level check.

### Microsoft references

[Microsoft Learn: hyper v start state access failures clustered standalone](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-start-state-access-failures-clustered-standalone)

[Microsoft Learn: hyper v virtual machine backup checkpoint storage](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-virtual-machine-backup-checkpoint-storage)


## Remediation: Restart the virtual machine {#hypervprivatecloud.vmruntime.restart.task}

`HyperVPrivateCloud.VmRuntime.Restart.Task`

Restart-VM -Force.

### Summary

Restart the virtual machine

### What it runs

Restart-VM -Force.

### Impact

This task changes the state of the target. The console asks for confirmation before it runs; use the read-only tasks first to confirm the diagnosis, and run it inside a change window where the environment requires one. The task output reports the resulting state.

### Support scope

Host-based Hyper-V workload or management evidence. A stopped VM must be compared with its intended state; inventory presence is not guest application monitoring.

Element: HyperVPrivateCloud.VmRuntime.Restart.Task. Kind: Task.

### Execution safety

Target=HCSV2Library!HyperVPrivateCloud.VirtualMachineRuntime; enabled=true; timeout=600. Read the task&#39;s original knowledge and parameters before execution. A Remediation task changes state and requires approval; do not execute it solely because the object is red. Even a diagnostic can generate logs or files; review its documented impact.

### Read-only investigation

Run the matching read-only host/VM task. Match the stable VM ID and current owner, inspect Get-VM, attached disks, checkpoint chain and Hyper-V-VMMS/High-Availability logs. For management-service errors verify the named service and first failure rather than assuming every guest stopped.

### Corrective action and escalation

Restore the identified service, configuration, storage or VM dependency with the workload owner. Check intended shutdown and maintenance policy first. Never delete checkpoint files, force power operations or restart VMMS/hosts solely to clear an alert.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm the intended VM/service state, fresh host-derived evidence and the originating monitor. Guest application recovery requires a separate workload-level check.

### Microsoft references

[Microsoft Learn: hyper v start state access failures clustered standalone](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-start-state-access-failures-clustered-standalone)

[Microsoft Learn: hyper v virtual machine backup checkpoint storage](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-virtual-machine-backup-checkpoint-storage)


## Remediation: Remove all checkpoints and merge the VHD chain {#hypervprivatecloud.vmruntime.mergecheckpoints.task}

`HyperVPrivateCloud.VmRuntime.MergeCheckpoints.Task`

Remove-VMSnapshot for every checkpoint; the merge continues in the background.

### Summary

Remove all checkpoints and merge the VHD chain

### What it runs

Remove-VMSnapshot for every checkpoint; the merge continues in the background.

### Impact

This task changes the state of the target. The console asks for confirmation before it runs; use the read-only tasks first to confirm the diagnosis, and run it inside a change window where the environment requires one. The task output reports the resulting state.

### Support scope

Host-based Hyper-V workload or management evidence. A stopped VM must be compared with its intended state; inventory presence is not guest application monitoring.

Element: HyperVPrivateCloud.VmRuntime.MergeCheckpoints.Task. Kind: Task.

### Execution safety

Target=HCSV2Library!HyperVPrivateCloud.VirtualMachineRuntime; enabled=true; timeout=600. Read the task&#39;s original knowledge and parameters before execution. A Remediation task changes state and requires approval; do not execute it solely because the object is red. Even a diagnostic can generate logs or files; review its documented impact.

### Read-only investigation

Run the matching read-only host/VM task. Match the stable VM ID and current owner, inspect Get-VM, attached disks, checkpoint chain and Hyper-V-VMMS/High-Availability logs. For management-service errors verify the named service and first failure rather than assuming every guest stopped.

### Corrective action and escalation

Restore the identified service, configuration, storage or VM dependency with the workload owner. Check intended shutdown and maintenance policy first. Never delete checkpoint files, force power operations or restart VMMS/hosts solely to clear an alert.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm the intended VM/service state, fresh host-derived evidence and the originating monitor. Guest application recovery requires a separate workload-level check.

### Microsoft references

[Microsoft Learn: hyper v start state access failures clustered standalone](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-start-state-access-failures-clustered-standalone)

[Microsoft Learn: hyper v virtual machine backup checkpoint storage](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-virtual-machine-backup-checkpoint-storage)


## Remediation: Create a checkpoint {#hypervprivatecloud.vmruntime.createcheckpoint.task}

`HyperVPrivateCloud.VmRuntime.CreateCheckpoint.Task`

Checkpoint-VM with a timestamped name.

### Summary

Create a checkpoint

### What it runs

Checkpoint-VM with a timestamped name.

### Impact

This task changes the state of the target. The console asks for confirmation before it runs; use the read-only tasks first to confirm the diagnosis, and run it inside a change window where the environment requires one. The task output reports the resulting state.

### Support scope

Host-based Hyper-V workload or management evidence. A stopped VM must be compared with its intended state; inventory presence is not guest application monitoring.

Element: HyperVPrivateCloud.VmRuntime.CreateCheckpoint.Task. Kind: Task.

### Execution safety

Target=HCSV2Library!HyperVPrivateCloud.VirtualMachineRuntime; enabled=true; timeout=600. Read the task&#39;s original knowledge and parameters before execution. A Remediation task changes state and requires approval; do not execute it solely because the object is red. Even a diagnostic can generate logs or files; review its documented impact.

### Read-only investigation

Run the matching read-only host/VM task. Match the stable VM ID and current owner, inspect Get-VM, attached disks, checkpoint chain and Hyper-V-VMMS/High-Availability logs. For management-service errors verify the named service and first failure rather than assuming every guest stopped.

### Corrective action and escalation

Restore the identified service, configuration, storage or VM dependency with the workload owner. Check intended shutdown and maintenance policy first. Never delete checkpoint files, force power operations or restart VMMS/hosts solely to clear an alert.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm the intended VM/service state, fresh host-derived evidence and the originating monitor. Guest application recovery requires a separate workload-level check.

### Microsoft references

[Microsoft Learn: hyper v start state access failures clustered standalone](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-start-state-access-failures-clustered-standalone)

[Microsoft Learn: hyper v virtual machine backup checkpoint storage](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-virtual-machine-backup-checkpoint-storage)


## Remediation: Resume Hyper-V Replica {#hypervprivatecloud.vmruntime.resumereplication.task}

`HyperVPrivateCloud.VmRuntime.ResumeReplication.Task`

Resume-VMReplication.

### Summary

Resume Hyper-V Replica

### What it runs

Resume-VMReplication.

### Impact

This task changes the state of the target. The console asks for confirmation before it runs; use the read-only tasks first to confirm the diagnosis, and run it inside a change window where the environment requires one. The task output reports the resulting state.

### Support scope

Host-observed replication state and disaster-recovery protection, not an application availability test inside the guest.

Element: HyperVPrivateCloud.VmRuntime.ResumeReplication.Task. Kind: Task.

### Execution safety

Target=HCSV2Library!HyperVPrivateCloud.VirtualMachineRuntime; enabled=true; timeout=300. Read the task&#39;s original knowledge and parameters before execution. A Remediation task changes state and requires approval; do not execute it solely because the object is red. Even a diagnostic can generate logs or files; review its documented impact.

### Read-only investigation

Use Get-VMReplication and Measure-VMReplication for the named VM on its owner. Inspect replication mode, primary/replica server, health, last replication time and backlog. For a cluster broker, follow network-name and broker resource dependencies. Distinguish planned pause, initial replication and unexpected loss of protection.

### Corrective action and escalation

Restore the actual authentication, certificate, broker, network or storage dependency. Coordinate resume or resynchronization with the recovery owner and verify bandwidth/storage impact. Never perform failover, reverse replication or remove/recreate protection solely to clear an alert.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm replication resumes and lag meets the agreed recovery-point objective. A healthy running primary VM alone does not establish healthy disaster recovery.

### Microsoft references

[Microsoft Learn: hyper v replica troubleshooting guide](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-replica-troubleshooting-guide)


## Remediation: Live migrate the clustered VM to the best node {#hypervprivatecloud.vmruntime.movetobestnode.task}

`HyperVPrivateCloud.VmRuntime.MoveToBestNode.Task`

Move-ClusterVirtualMachineRole -MigrationType Live; the cluster chooses the destination.

### Summary

Live migrate the clustered VM to the best node

### What it runs

Move-ClusterVirtualMachineRole -MigrationType Live; the cluster chooses the destination.

### Impact

This task changes the state of the target. The console asks for confirmation before it runs; use the read-only tasks first to confirm the diagnosis, and run it inside a change window where the environment requires one. The task output reports the resulting state.

### Support scope

Host-based Hyper-V workload or management evidence. A stopped VM must be compared with its intended state; inventory presence is not guest application monitoring.

Element: HyperVPrivateCloud.VmRuntime.MoveToBestNode.Task. Kind: Task.

### Execution safety

Target=HCSV2Library!HyperVPrivateCloud.VirtualMachineRuntime; enabled=true; timeout=900. Read the task&#39;s original knowledge and parameters before execution. A Remediation task changes state and requires approval; do not execute it solely because the object is red. Even a diagnostic can generate logs or files; review its documented impact.

### Read-only investigation

Run the matching read-only host/VM task. Match the stable VM ID and current owner, inspect Get-VM, attached disks, checkpoint chain and Hyper-V-VMMS/High-Availability logs. For management-service errors verify the named service and first failure rather than assuming every guest stopped.

### Corrective action and escalation

Restore the identified service, configuration, storage or VM dependency with the workload owner. Check intended shutdown and maintenance policy first. Never delete checkpoint files, force power operations or restart VMMS/hosts solely to clear an alert.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm the intended VM/service state, fresh host-derived evidence and the originating monitor. Guest application recovery requires a separate workload-level check.

### Microsoft references

[Microsoft Learn: hyper v start state access failures clustered standalone](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-start-state-access-failures-clustered-standalone)

[Microsoft Learn: hyper v virtual machine backup checkpoint storage](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-virtual-machine-backup-checkpoint-storage)


## Test Active Directory domain and secure channel {#hypervprivatecloud.host.testdomainhealth.task}

`HyperVPrivateCloud.Host.TestDomainHealth.Task`

Runs Test-ComputerSecureChannel and queries Active Directory domain, PDC emulator, forest mode, and assigned site.

### Summary

Test Active Directory domain and secure channel

### What it runs

Runs Test-ComputerSecureChannel and queries Active Directory domain, PDC emulator, forest mode, and assigned site.

### Impact

Read-only. Diagnoses trust and directory health without changing host state.

### Support scope

Host-observed domain and secure-channel dependency, not an exhaustive domain-controller replication or AD health assessment.

Element: HyperVPrivateCloud.Host.TestDomainHealth.Task. Kind: Task.

### Execution safety

Target=HCSV2Library!HyperVPrivateCloud.HostRole; enabled=true; timeout=180. Read the task&#39;s original knowledge and parameters before execution. A Remediation task changes state and requires approval; do not execute it solely because the object is red. Even a diagnostic can generate logs or files; review its documented impact.

### Read-only investigation

Run the read-only domain diagnostic from the affected host. Verify DNS/DC discovery, time synchronization, network reachability and Test-ComputerSecureChannel without -Repair. Correlate NETLOGON errors with directory-team evidence.

### Corrective action and escalation

Restore DNS/time/connectivity first where indicated. If the machine account trust is genuinely broken, use the approved directory recovery procedure with the AD owner. Do not unjoin/rejoin a clustered host or reset machine passwords as a first response.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Repeat the secure-channel and domain discovery checks, verify normal authentication and fresh monitor recovery.

### Microsoft references

[Microsoft Learn: broken trust relationship domain joined device its domain secure channel issues](https://learn.microsoft.com/en-us/troubleshoot/windows-server/windows-security/broken-trust-relationship-domain-joined-device-its-domain-secure-channel-issues)


## Test DNS configuration and name resolution {#hypervprivatecloud.host.testdnsresolution.task}

`HyperVPrivateCloud.Host.TestDnsResolution.Task`

Evaluates configured adapter DNS servers, tests forward resolution, and queries Active Directory domain controller SRV records.

### Summary

Test DNS configuration and name resolution

### What it runs

Evaluates configured adapter DNS servers, tests forward resolution, and queries Active Directory domain controller SRV records.

### Impact

Read-only. Diagnoses DNS resolution timing and records without changing host state.

### Support scope

DNS service or name-resolution dependency as tested by the configured probe, not proof that every zone or client is healthy.

Element: HyperVPrivateCloud.Host.TestDnsResolution.Task. Kind: Task.

### Execution safety

Target=HCSV2Library!HyperVPrivateCloud.HostRole; enabled=true; timeout=180. Read the task&#39;s original knowledge and parameters before execution. A Remediation task changes state and requires approval; do not execute it solely because the object is red. Even a diagnostic can generate logs or files; review its documented impact.

### Read-only investigation

Run the DNS diagnostic on the affected host. Record queried name/type, configured resolver, response/error and forward/SRV results. Compare another resolver and another client to distinguish client configuration, path and authoritative-server failures.

### Corrective action and escalation

Correct the proven resolver, zone, record, forwarding or network issue with the DNS owner. Avoid global cache flushes or DNS-service restarts without a specific reason.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Repeat the same failing query from the original host and confirm fresh monitoring evidence, not merely a cached successful answer from another machine.

### Microsoft references

[Microsoft Learn: troubleshoot dns guidance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/networking/troubleshoot-dns-guidance)

[Microsoft Learn: troubleshoot dns server](https://learn.microsoft.com/en-us/windows-server/networking/dns/troubleshoot/troubleshoot-dns-server)


## Test TCP port connectivity {#hypervprivatecloud.host.testportconnectivity.task}

`HyperVPrivateCloud.Host.TestPortConnectivity.Task`

Probes TCP connectivity to default gateway, domain controller RPC/LDAP/SMB/WinRM ports, and optional user-specified targets.

### Summary

Test TCP port connectivity

### What it runs

Probes TCP connectivity to default gateway, domain controller RPC/LDAP/SMB/WinRM ports, and optional user-specified targets.

### Impact

Read-only. Sends TCP SYN probes without altering service configuration.

### Support scope

Host-based Hyper-V workload or management evidence. A stopped VM must be compared with its intended state; inventory presence is not guest application monitoring.

Element: HyperVPrivateCloud.Host.TestPortConnectivity.Task. Kind: Task.

### Execution safety

Target=HCSV2Library!HyperVPrivateCloud.HostRole; enabled=true; timeout=180. Read the task&#39;s original knowledge and parameters before execution. A Remediation task changes state and requires approval; do not execute it solely because the object is red. Even a diagnostic can generate logs or files; review its documented impact.

### Read-only investigation

Run the matching read-only host/VM task. Match the stable VM ID and current owner, inspect Get-VM, attached disks, checkpoint chain and Hyper-V-VMMS/High-Availability logs. For management-service errors verify the named service and first failure rather than assuming every guest stopped.

### Corrective action and escalation

Restore the identified service, configuration, storage or VM dependency with the workload owner. Check intended shutdown and maintenance policy first. Never delete checkpoint files, force power operations or restart VMMS/hosts solely to clear an alert.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm the intended VM/service state, fresh host-derived evidence and the originating monitor. Guest application recovery requires a separate workload-level check.

### Microsoft references

[Microsoft Learn: hyper v start state access failures clustered standalone](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-start-state-access-failures-clustered-standalone)

[Microsoft Learn: hyper v virtual machine backup checkpoint storage](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-virtual-machine-backup-checkpoint-storage)


## Test bare-metal PXE and WDS deployment services {#hypervprivatecloud.host.testpxewdshealth.task}

`HyperVPrivateCloud.Host.TestPxeWdsHealth.Task`

Checks Windows Deployment Services (WDSServer), active TFTP/PXE UDP listeners, and the REMINST remote install share.

### Summary

Test bare-metal PXE and WDS deployment services

### What it runs

Checks Windows Deployment Services (WDSServer), active TFTP/PXE UDP listeners, and the REMINST remote install share.

### Impact

Read-only. Queries local services, listeners, and file shares.

### Support scope

Host-based Hyper-V workload or management evidence. A stopped VM must be compared with its intended state; inventory presence is not guest application monitoring.

Element: HyperVPrivateCloud.Host.TestPxeWdsHealth.Task. Kind: Task.

### Execution safety

Target=HCSV2Library!HyperVPrivateCloud.HostRole; enabled=true; timeout=180. Read the task&#39;s original knowledge and parameters before execution. A Remediation task changes state and requires approval; do not execute it solely because the object is red. Even a diagnostic can generate logs or files; review its documented impact.

### Read-only investigation

Run the matching read-only host/VM task. Match the stable VM ID and current owner, inspect Get-VM, attached disks, checkpoint chain and Hyper-V-VMMS/High-Availability logs. For management-service errors verify the named service and first failure rather than assuming every guest stopped.

### Corrective action and escalation

Restore the identified service, configuration, storage or VM dependency with the workload owner. Check intended shutdown and maintenance policy first. Never delete checkpoint files, force power operations or restart VMMS/hosts solely to clear an alert.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm the intended VM/service state, fresh host-derived evidence and the originating monitor. Guest application recovery requires a separate workload-level check.

### Microsoft references

[Microsoft Learn: hyper v start state access failures clustered standalone](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-start-state-access-failures-clustered-standalone)

[Microsoft Learn: hyper v virtual machine backup checkpoint storage](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-virtual-machine-backup-checkpoint-storage)


## Test physical server chassis and BMC connectivity {#hypervprivatecloud.host.testchassisbmcconnectivity.task}

`HyperVPrivateCloud.Host.TestChassisBmcConnectivity.Task`

Validates physical server vendor, model, serial, BIOS version, chassis status, and probes out-of-band BMC ping and IPMI/Redfish ports.

### Summary

Test physical server chassis and BMC connectivity

### What it runs

Queries SMBIOS/WMI hardware inventory (vendor, model, serial, BIOS, operational status) and tests ICMP and TCP 443/623 to the out-of-band baseboard management controller (iDRAC, iLO, XClarity).

### Impact

Read-only. Diagnoses chassis reachability and BMC health without disrupting host operations.

### Support scope

Host-based Hyper-V workload or management evidence. A stopped VM must be compared with its intended state; inventory presence is not guest application monitoring.

Element: HyperVPrivateCloud.Host.TestChassisBmcConnectivity.Task. Kind: Task.

### Execution safety

Target=HCSV2Library!HyperVPrivateCloud.HostRole; enabled=true; timeout=180. Read the task&#39;s original knowledge and parameters before execution. A Remediation task changes state and requires approval; do not execute it solely because the object is red. Even a diagnostic can generate logs or files; review its documented impact.

### Read-only investigation

Run the matching read-only host/VM task. Match the stable VM ID and current owner, inspect Get-VM, attached disks, checkpoint chain and Hyper-V-VMMS/High-Availability logs. For management-service errors verify the named service and first failure rather than assuming every guest stopped.

### Corrective action and escalation

Restore the identified service, configuration, storage or VM dependency with the workload owner. Check intended shutdown and maintenance policy first. Never delete checkpoint files, force power operations or restart VMMS/hosts solely to clear an alert.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm the intended VM/service state, fresh host-derived evidence and the originating monitor. Guest application recovery requires a separate workload-level check.

### Microsoft references

[Microsoft Learn: hyper v start state access failures clustered standalone](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-start-state-access-failures-clustered-standalone)

[Microsoft Learn: hyper v virtual machine backup checkpoint storage](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-virtual-machine-backup-checkpoint-storage)


## Test Top-of-Rack and OOB switch connectivity {#hypervprivatecloud.host.testnetworkswitchconnectivity.task}

`HyperVPrivateCloud.Host.TestNetworkSwitchConnectivity.Task`

Probes ICMP ping and SNMP port 161 responsiveness for discovered Top-of-Rack and Out-of-Band management switches.

### Summary

Test Top-of-Rack and OOB switch connectivity

### What it runs

Validates network path connectivity from the Hyper-V host uplinks to physical Top-of-Rack (ToR) and Out-of-Band (OOB) management switches via ICMP ping and SNMP/TCP management port probes.

### Impact

Read-only. Diagnoses network switch reachability without altering switch configuration or ports.

### Support scope

Host network or external infrastructure evidence at the precise scope of the leaf. TCP reachability is not device hardware, firewall-policy or application health; linked vendor monitors retain their own authority.

Element: HyperVPrivateCloud.Host.TestNetworkSwitchConnectivity.Task. Kind: Task.

### Execution safety

Target=HCSV2Library!HyperVPrivateCloud.HostRole; enabled=true; timeout=180. Read the task&#39;s original knowledge and parameters before execution. A Remediation task changes state and requires approval; do not execute it solely because the object is red. Even a diagnostic can generate logs or files; review its documented impact.

### Read-only investigation

Identify the adapter, switch, port or configured endpoint and the actual observation source. Compare link state, negotiated speed and error/discard deltas with device-side evidence. Check routing and the intended port from the collector. An unreachable management endpoint does not by itself prove the data plane failed.

### Corrective action and escalation

Restore the specific path, cable/optic, approved switch configuration or device service with the network/hardware owner. Consult the vendor for proprietary device faults. Do not disable security controls, bounce all uplinks or reboot management devices based only on a failed TCP probe.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Repeat the original path test and confirm relevant native/vendor health. For cumulative errors, observe new deltas; do not expect historic totals to disappear.

### Microsoft references

[Microsoft Learn: troubleshoot tcp ip communication guidance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/networking/troubleshoot-tcp-ip-communication-guidance)


## Test edge firewall gateway and route health {#hypervprivatecloud.host.testfirewallgateway.task}

`HyperVPrivateCloud.Host.TestFirewallGateway.Task`

Tests default gateway ICMP reachability, ARP resolution, HTTPS admin port 443 response, and DNS forwarding through the firewall.

### Summary

Test edge firewall gateway and route health

### What it runs

Validates default gateway reachability, ARP table resolution for the perimeter firewall, TCP 443 HTTPS admin response, and external DNS forwarding through the firewall perimeter.

### Impact

Read-only. Sends non-disruptive ICMP and TCP connection tests against the firewall interface.

### Support scope

Host-based Hyper-V workload or management evidence. A stopped VM must be compared with its intended state; inventory presence is not guest application monitoring.

Element: HyperVPrivateCloud.Host.TestFirewallGateway.Task. Kind: Task.

### Execution safety

Target=HCSV2Library!HyperVPrivateCloud.HostRole; enabled=true; timeout=180. Read the task&#39;s original knowledge and parameters before execution. A Remediation task changes state and requires approval; do not execute it solely because the object is red. Even a diagnostic can generate logs or files; review its documented impact.

### Read-only investigation

Run the matching read-only host/VM task. Match the stable VM ID and current owner, inspect Get-VM, attached disks, checkpoint chain and Hyper-V-VMMS/High-Availability logs. For management-service errors verify the named service and first failure rather than assuming every guest stopped.

### Corrective action and escalation

Restore the identified service, configuration, storage or VM dependency with the workload owner. Check intended shutdown and maintenance policy first. Never delete checkpoint files, force power operations or restart VMMS/hosts solely to clear an alert.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm the intended VM/service state, fresh host-derived evidence and the originating monitor. Guest application recovery requires a separate workload-level check.

### Microsoft references

[Microsoft Learn: hyper v start state access failures clustered standalone](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-start-state-access-failures-clustered-standalone)

[Microsoft Learn: hyper v virtual machine backup checkpoint storage](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-virtual-machine-backup-checkpoint-storage)


## Test Opengear console server port responsiveness {#hypervprivatecloud.host.testopengearport.task}

`HyperVPrivateCloud.Host.TestOpengearPort.Task`

Validates console server SSH (22) and HTTPS (443) management ports, active console sessions, and cellular failover responsiveness.

### Summary

Test Opengear console server port responsiveness

### What it runs

Tests SSH port 22 and HTTPS port 443 connectivity to the discovered Opengear console server appliance, validating terminal server reachability for emergency out-of-band access.

### Impact

Read-only. Tests TCP port connectivity to the console server without initiating sessions.

### Support scope

Host-based Hyper-V workload or management evidence. A stopped VM must be compared with its intended state; inventory presence is not guest application monitoring.

Element: HyperVPrivateCloud.Host.TestOpengearPort.Task. Kind: Task.

### Execution safety

Target=HCSV2Library!HyperVPrivateCloud.HostRole; enabled=true; timeout=180. Read the task&#39;s original knowledge and parameters before execution. A Remediation task changes state and requires approval; do not execute it solely because the object is red. Even a diagnostic can generate logs or files; review its documented impact.

### Read-only investigation

Run the matching read-only host/VM task. Match the stable VM ID and current owner, inspect Get-VM, attached disks, checkpoint chain and Hyper-V-VMMS/High-Availability logs. For management-service errors verify the named service and first failure rather than assuming every guest stopped.

### Corrective action and escalation

Restore the identified service, configuration, storage or VM dependency with the workload owner. Check intended shutdown and maintenance policy first. Never delete checkpoint files, force power operations or restart VMMS/hosts solely to clear an alert.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm the intended VM/service state, fresh host-derived evidence and the originating monitor. Guest application recovery requires a separate workload-level check.

### Microsoft references

[Microsoft Learn: hyper v start state access failures clustered standalone](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-start-state-access-failures-clustered-standalone)

[Microsoft Learn: hyper v virtual machine backup checkpoint storage](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-virtual-machine-backup-checkpoint-storage)


## Test DHCP server scope health and headroom {#hypervprivatecloud.host.testdhcpscopehealth.task}

`HyperVPrivateCloud.Host.TestDhcpScopeHealth.Task`

Queries DHCP server service status, active UDP port 67 listeners, and evaluates scope lease exhaustion and remaining IP headroom.

### Summary

Test DHCP server scope health and headroom

### What it runs

Checks local or target DHCP Server service status, UDP port 67 listener availability, and when DhcpServer module is available, queries scope statistics and address pool utilization.

### Impact

Read-only. Queries DHCP service status and scope statistics without making IP reservations or leases.

### Support scope

Configured DHCP service reachability/health evidence. This is not an exhaustive lease, scope or client transaction monitor unless the leaf explicitly measures those facts.

Element: HyperVPrivateCloud.Host.TestDhcpScopeHealth.Task. Kind: Task.

### Execution safety

Target=HCSV2Library!HyperVPrivateCloud.HostRole; enabled=true; timeout=180. Read the task&#39;s original knowledge and parameters before execution. A Remediation task changes state and requires approval; do not execute it solely because the object is red. Even a diagnostic can generate logs or files; review its documented impact.

### Read-only investigation

Check the named DHCP endpoint, service status, authorization, applicable scope free leases and relay path with the DHCP owner. Compare a client on the server subnet with one behind the affected relay.

### Corrective action and escalation

Correct the proven service, scope or relay issue through approved network change control. Do not authorize unknown DHCP servers or change scope ranges to clear a reachability alarm.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm the configured probe and a representative lease transaction recover without address conflicts.

### Microsoft references

[Microsoft Learn: troubleshoot dhcp guidance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/networking/troubleshoot-dhcp-guidance)


## Hyper-V Virtual Machine Management service health {#hypervprivatecloud.host.vmms.monitor}

`HyperVPrivateCloud.Host.VMMS.Monitor`

Tracks the VMMS service required for Hyper-V management.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.ManagementStack.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.ManagementStack.Management.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Management.Members.Availability.Dependency.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

Tracks the VMMS service required for Hyper-V management.

### Operator response

Verify the vmms service, dependencies, maintenance state, and recent Hyper-V VMMS events.

### Support scope

Host-based Hyper-V workload or management evidence. A stopped VM must be compared with its intended state; inventory presence is not guest application monitoring.

Element: HyperVPrivateCloud.Host.VMMS.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HCSV2Library!HyperVPrivateCloud.HostRole. Parent health aspect: Health!System.Health.AvailabilityState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: (Property[@Name=&#39;VMMSState&#39;] = Good OR Property[@Name=&#39;VMMSState&#39;] = NotApplicable)

Warning [Warning]: Property[@Name=&#39;VMMSState&#39;] = Warning

Error [Critical]: Property[@Name=&#39;VMMSState&#39;] = Critical

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: CheckpointCriticalHours=336; CheckpointWarningHours=168; CpuCriticalPercent=90; CpuWarningPercent=80; IntervalSeconds=300; MemoryCriticalMB=2048; MemoryWarningMB=4096; PagesInputCriticalPerSecond=20; PagesInputWarningPerSecond=5; PropertyName=VMMSState; SyncTime=; TimeoutSeconds=120 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Error; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Run the matching read-only host/VM task. Match the stable VM ID and current owner, inspect Get-VM, attached disks, checkpoint chain and Hyper-V-VMMS/High-Availability logs. For management-service errors verify the named service and first failure rather than assuming every guest stopped.

### Corrective action and escalation

Restore the identified service, configuration, storage or VM dependency with the workload owner. Check intended shutdown and maintenance policy first. Never delete checkpoint files, force power operations or restart VMMS/hosts solely to clear an alert.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm the intended VM/service state, fresh host-derived evidence and the originating monitor. Guest application recovery requires a separate workload-level check.

### Probe-specific state reasons

Good: vmms is Running. Critical: the service is missing or not Running. No native Warning branch. Running VMs can continue despite a management-service failure; check Get-Service vmms and VMMS events before an approved repair.

Critical probe exceptions can also mark unevaluated facets Critical. Read PipelineStateDetail and the first exception before interpreting a facet as a confirmed workload outage. Successful collection is not evidence that every workload is healthy.

### Microsoft references

[Microsoft Learn: hyper v start state access failures clustered standalone](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-start-state-access-failures-clustered-standalone)

[Microsoft Learn: hyper v virtual machine backup checkpoint storage](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-virtual-machine-backup-checkpoint-storage)


## Hyper-V Host Compute service health {#hypervprivatecloud.host.vmcompute.monitor}

`HyperVPrivateCloud.Host.VmCompute.Monitor`

Tracks the Host Compute Service used by modern Hyper-V workloads.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.ManagementStack.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.ManagementStack.Management.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Management.Members.HostCompute.Availability.Dependency.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

Tracks the Host Compute Service used by modern Hyper-V workloads.

### Operator response

Verify the vmcompute service and Host Compute Service operational events.

### Support scope

Host-based Hyper-V workload or management evidence. A stopped VM must be compared with its intended state; inventory presence is not guest application monitoring.

Element: HyperVPrivateCloud.Host.VmCompute.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HCSV2Library!HyperVPrivateCloud.HostRole. Parent health aspect: Health!System.Health.AvailabilityState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: (Property[@Name=&#39;VmComputeState&#39;] = Good OR Property[@Name=&#39;VmComputeState&#39;] = NotApplicable)

Warning [Warning]: Property[@Name=&#39;VmComputeState&#39;] = Warning

Error [Critical]: Property[@Name=&#39;VmComputeState&#39;] = Critical

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: CheckpointCriticalHours=336; CheckpointWarningHours=168; CpuCriticalPercent=90; CpuWarningPercent=80; IntervalSeconds=300; MemoryCriticalMB=2048; MemoryWarningMB=4096; PagesInputCriticalPerSecond=20; PagesInputWarningPerSecond=5; PropertyName=VmComputeState; SyncTime=; TimeoutSeconds=120 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Error; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Run the matching read-only host/VM task. Match the stable VM ID and current owner, inspect Get-VM, attached disks, checkpoint chain and Hyper-V-VMMS/High-Availability logs. For management-service errors verify the named service and first failure rather than assuming every guest stopped.

### Corrective action and escalation

Restore the identified service, configuration, storage or VM dependency with the workload owner. Check intended shutdown and maintenance policy first. Never delete checkpoint files, force power operations or restart VMMS/hosts solely to clear an alert.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm the intended VM/service state, fresh host-derived evidence and the originating monitor. Guest application recovery requires a separate workload-level check.

### Probe-specific state reasons

Good: vmcompute is Running. Critical: the service is missing or not Running. No native Warning branch. Identify dependent compute/container operations and service events; do not equate this with proof that all Hyper-V VMs stopped.

Critical probe exceptions can also mark unevaluated facets Critical. Read PipelineStateDetail and the first exception before interpreting a facet as a confirmed workload outage. Successful collection is not evidence that every workload is healthy.

### Microsoft references

[Microsoft Learn: hyper v start state access failures clustered standalone](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-start-state-access-failures-clustered-standalone)

[Microsoft Learn: hyper v virtual machine backup checkpoint storage](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-virtual-machine-backup-checkpoint-storage)


## Hyper-V monitoring capability {#hypervprivatecloud.host.powershell.monitor}

`HyperVPrivateCloud.Host.PowerShell.Monitor`

Verifies that the Hyper-V PowerShell module required by discovery and monitoring is usable.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.ManagementStack.Configuration.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.ManagementStack.Monitoring.Configuration.Dependency.Monitor &gt; HyperVPrivateCloud.Monitoring.Members.Capability.Configuration.Dependency.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

Verifies that the Hyper-V PowerShell module required by discovery and monitoring is usable.

### Operator response

Install Hyper-V management tools and verify that the HealthService account can load the Hyper-V module.

### Support scope

Monitoring capability, data collection or freshness. Failure means visibility is impaired; do not infer that the monitored workload itself is down or healthy.

Element: HyperVPrivateCloud.Host.PowerShell.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HCSV2Library!HyperVPrivateCloud.HostRole. Parent health aspect: Health!System.Health.ConfigurationState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: (Property[@Name=&#39;HyperVPowerShellState&#39;] = Good OR Property[@Name=&#39;HyperVPowerShellState&#39;] = NotApplicable)

Warning [Warning]: Property[@Name=&#39;HyperVPowerShellState&#39;] = Warning

Error [Critical]: Property[@Name=&#39;HyperVPowerShellState&#39;] = Critical

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: CheckpointCriticalHours=336; CheckpointWarningHours=168; CpuCriticalPercent=90; CpuWarningPercent=80; IntervalSeconds=300; MemoryCriticalMB=2048; MemoryWarningMB=4096; PagesInputCriticalPerSecond=20; PagesInputWarningPerSecond=5; PropertyName=HyperVPowerShellState; SyncTime=; TimeoutSeconds=120 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Error; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Read the first probe error and Operations Manager event context. Verify HealthService availability, supported PowerShell runtime, required modules, Run As scope and agent proxy where cross-object discovery requires it. Compare last successful sample and discovery time.

### Corrective action and escalation

Correct the missing runtime/module, access or source defect. Preserve logs before any approved HealthService restart. Do not reset health or clear the agent cache as a substitute for understanding a repeatable script error.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Require a new successful discovery/sample and initialized leaf monitors. Old green values cannot establish recovery of a broken collector.

### Probe-specific state reasons

Good: the Hyper-V module and Get-VMHost command are available. Critical: that prerequisite is unavailable. This impairs monitoring; it does not independently prove a VM outage. Check the probe runtime, module installation and first error.

Critical probe exceptions can also mark unevaluated facets Critical. Read PipelineStateDetail and the first exception before interpreting a facet as a confirmed workload outage. Successful collection is not evidence that every workload is healthy.

### Microsoft references

[Microsoft Learn: manage consoles overview healthexplorer](https://learn.microsoft.com/en-us/system-center/scom/manage-consoles-overview-healthexplorer?view=sc-om-2025)


## Hyper-V hypervisor health {#hypervprivatecloud.host.hypervisor.monitor}

`HyperVPrivateCloud.Host.Hypervisor.Monitor`

Verifies that the Hyper-V host interface responds.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.ManagementStack.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.ManagementStack.Management.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Management.Members.Hypervisor.Availability.Dependency.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

Verifies that the Hyper-V host interface responds.

### Operator response

Check hypervisor launch configuration, VMMS, virtualization firmware settings, and recent system events.

### Support scope

Host-based Hyper-V workload or management evidence. A stopped VM must be compared with its intended state; inventory presence is not guest application monitoring.

Element: HyperVPrivateCloud.Host.Hypervisor.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HCSV2Library!HyperVPrivateCloud.HostRole. Parent health aspect: Health!System.Health.AvailabilityState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: (Property[@Name=&#39;HypervisorState&#39;] = Good OR Property[@Name=&#39;HypervisorState&#39;] = NotApplicable)

Warning [Warning]: Property[@Name=&#39;HypervisorState&#39;] = Warning

Error [Critical]: Property[@Name=&#39;HypervisorState&#39;] = Critical

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: CheckpointCriticalHours=336; CheckpointWarningHours=168; CpuCriticalPercent=90; CpuWarningPercent=80; IntervalSeconds=300; MemoryCriticalMB=2048; MemoryWarningMB=4096; PagesInputCriticalPerSecond=20; PagesInputWarningPerSecond=5; PropertyName=HypervisorState; SyncTime=; TimeoutSeconds=120 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Error; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Run the matching read-only host/VM task. Match the stable VM ID and current owner, inspect Get-VM, attached disks, checkpoint chain and Hyper-V-VMMS/High-Availability logs. For management-service errors verify the named service and first failure rather than assuming every guest stopped.

### Corrective action and escalation

Restore the identified service, configuration, storage or VM dependency with the workload owner. Check intended shutdown and maintenance policy first. Never delete checkpoint files, force power operations or restart VMMS/hosts solely to clear an alert.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm the intended VM/service state, fresh host-derived evidence and the originating monitor. Guest application recovery requires a separate workload-level check.

### Probe-specific state reasons

Good: Win32_ComputerSystem.HypervisorPresent is true after Get-VMHost succeeds. Critical: it is false or prerequisites failed. Verify the hardware/boot/Hyper-V configuration and event evidence; any boot configuration change or restart requires a maintenance plan. No native Warning branch.

Critical probe exceptions can also mark unevaluated facets Critical. Read PipelineStateDetail and the first exception before interpreting a facet as a confirmed workload outage. Successful collection is not evidence that every workload is healthy.

### Microsoft references

[Microsoft Learn: hyper v start state access failures clustered standalone](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-start-state-access-failures-clustered-standalone)

[Microsoft Learn: hyper v virtual machine backup checkpoint storage](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-virtual-machine-backup-checkpoint-storage)


## Hyper-V host processor pressure {#hypervprivatecloud.host.cpu.monitor}

`HyperVPrivateCloud.Host.Cpu.Monitor`

Tracks sustained hypervisor logical-processor utilization. Disabled by default: superseded by HyperVPrivateCloud.Host.LogicalProcessorUtilization.Monitor, which evaluates the same signal with thresholds that can be overridden without breaking probe cookdown. Enable this monitor only if you disable the superseding one.

### Summary

Tracks sustained hypervisor logical-processor utilization. Disabled by default: superseded by HyperVPrivateCloud.Host.LogicalProcessorUtilization.Monitor, which evaluates the same signal with thresholds that can be overridden without breaking probe cookdown. Enable this monitor only if you disable the superseding one.

### Operator response

Review root and guest virtual processor counters, NUMA placement, interrupts, DPCs, and workload placement.

### Support scope

Measured resource pressure or I/O delay. A warning is an opportunity to investigate headroom; a threshold crossing alone does not identify the defective component or predict a failure time.

Element: HyperVPrivateCloud.Host.Cpu.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HCSV2Library!HyperVPrivateCloud.HostRole. Parent health aspect: Health!System.Health.PerformanceState. Enabled by default: false. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: (Property[@Name=&#39;CpuState&#39;] = Good OR Property[@Name=&#39;CpuState&#39;] = NotApplicable)

Warning [Warning]: Property[@Name=&#39;CpuState&#39;] = Warning

Error [Critical]: Property[@Name=&#39;CpuState&#39;] = Critical

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: CheckpointCriticalHours=336; CheckpointWarningHours=168; CpuCriticalPercent=90; CpuWarningPercent=80; IntervalSeconds=300; MemoryCriticalMB=2048; MemoryWarningMB=4096; PagesInputCriticalPerSecond=20; PagesInputWarningPerSecond=5; PropertyName=CpuState; SyncTime=; TimeoutSeconds=120 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Error; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Record the named counter, measured value, units, sampling interval and effective thresholds. Compare a representative time series with workload changes, host placement and storage/network evidence. Separate host/root/guest CPU and assigned/demanded memory. Missing counters are a telemetry problem, not zero utilization.

### Corrective action and escalation

Address the identified contention, workload placement or failing path with its owner. Capacity changes require a headroom and failover-reserve check. Do not blindly increase thresholds, reboot hosts or reduce VM resources to suppress symptoms.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Observe the same metric over a representative load period, confirm sustained recovery and verify workload response independently. Product defaults require site-specific review and are not Microsoft service-level guarantees.

### Probe-specific state reasons

Critical when observed hypervisor processor utilization is at least CpuCriticalPercent; otherwise Warning at least CpuWarningPercent, otherwise Good. Compare host processor load and VM placement over time. These thresholds differ from the separate logical/root/guest processor monitors; use this monitor configuration, not another monitor value.

Critical probe exceptions can also mark unevaluated facets Critical. Read PipelineStateDetail and the first exception before interpreting a facet as a confirmed workload outage. Successful collection is not evidence that every workload is healthy.

### Microsoft references

[Microsoft Learn: troubleshoot hyper v virtual machine performance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/troubleshoot-hyper-v-virtual-machine-performance)


## Hyper-V host available memory {#hypervprivatecloud.host.memory.monitor}

`HyperVPrivateCloud.Host.Memory.Monitor`

Tracks absolute memory available to the management partition. Disabled by default: superseded by HyperVPrivateCloud.Host.AvailableMemory.Monitor, which evaluates the same signal with thresholds that can be overridden without breaking probe cookdown. Enable this monitor only if you disable the superseding one.

### Summary

Tracks absolute memory available to the management partition. Disabled by default: superseded by HyperVPrivateCloud.Host.AvailableMemory.Monitor, which evaluates the same signal with thresholds that can be overridden without breaking probe cookdown. Enable this monitor only if you disable the superseding one.

### Operator response

Review Dynamic Memory demand, host reserve, paging, NUMA, and workload placement.

### Support scope

Measured resource pressure or I/O delay. A warning is an opportunity to investigate headroom; a threshold crossing alone does not identify the defective component or predict a failure time.

Element: HyperVPrivateCloud.Host.Memory.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HCSV2Library!HyperVPrivateCloud.HostRole. Parent health aspect: Health!System.Health.PerformanceState. Enabled by default: false. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: (Property[@Name=&#39;MemoryState&#39;] = Good OR Property[@Name=&#39;MemoryState&#39;] = NotApplicable)

Warning [Warning]: Property[@Name=&#39;MemoryState&#39;] = Warning

Error [Critical]: Property[@Name=&#39;MemoryState&#39;] = Critical

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: CheckpointCriticalHours=336; CheckpointWarningHours=168; CpuCriticalPercent=90; CpuWarningPercent=80; IntervalSeconds=300; MemoryCriticalMB=2048; MemoryWarningMB=4096; PagesInputCriticalPerSecond=20; PagesInputWarningPerSecond=5; PropertyName=MemoryState; SyncTime=; TimeoutSeconds=120 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Error; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Record the named counter, measured value, units, sampling interval and effective thresholds. Compare a representative time series with workload changes, host placement and storage/network evidence. Separate host/root/guest CPU and assigned/demanded memory. Missing counters are a telemetry problem, not zero utilization.

### Corrective action and escalation

Address the identified contention, workload placement or failing path with its owner. Capacity changes require a headroom and failover-reserve check. Do not blindly increase thresholds, reboot hosts or reduce VM resources to suppress symptoms.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Observe the same metric over a representative load period, confirm sustained recovery and verify workload response independently. Product defaults require site-specific review and are not Microsoft service-level guarantees.

### Probe-specific state reasons

Critical when available physical memory MB is at most MemoryCriticalMB; otherwise Warning at most MemoryWarningMB, otherwise Good. Inspect available capacity, VM allocations and failover reserve before placement or capacity changes.

Critical probe exceptions can also mark unevaluated facets Critical. Read PipelineStateDetail and the first exception before interpreting a facet as a confirmed workload outage. Successful collection is not evidence that every workload is healthy.

### Microsoft references

[Microsoft Learn: troubleshoot hyper v virtual machine performance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/troubleshoot-hyper-v-virtual-machine-performance)


## Hyper-V host hard paging {#hypervprivatecloud.host.paging.monitor}

`HyperVPrivateCloud.Host.Paging.Monitor`

Tracks sustained pages read from disk as memory pressure evidence. Disabled by default: superseded by HyperVPrivateCloud.Host.MemoryPagesPressure.Monitor, which evaluates the same signal with thresholds that can be overridden without breaking probe cookdown. Enable this monitor only if you disable the superseding one.

### Summary

Tracks sustained pages read from disk as memory pressure evidence. Disabled by default: superseded by HyperVPrivateCloud.Host.MemoryPagesPressure.Monitor, which evaluates the same signal with thresholds that can be overridden without breaking probe cookdown. Enable this monitor only if you disable the superseding one.

### Operator response

Correlate paging with available memory, storage latency, VM demand, and host reserve.

### Support scope

Measured resource pressure or I/O delay. A warning is an opportunity to investigate headroom; a threshold crossing alone does not identify the defective component or predict a failure time.

Element: HyperVPrivateCloud.Host.Paging.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HCSV2Library!HyperVPrivateCloud.HostRole. Parent health aspect: Health!System.Health.PerformanceState. Enabled by default: false. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: (Property[@Name=&#39;PagingState&#39;] = Good OR Property[@Name=&#39;PagingState&#39;] = NotApplicable)

Warning [Warning]: Property[@Name=&#39;PagingState&#39;] = Warning

Error [Critical]: Property[@Name=&#39;PagingState&#39;] = Critical

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: CheckpointCriticalHours=336; CheckpointWarningHours=168; CpuCriticalPercent=90; CpuWarningPercent=80; IntervalSeconds=300; MemoryCriticalMB=2048; MemoryWarningMB=4096; PagesInputCriticalPerSecond=20; PagesInputWarningPerSecond=5; PropertyName=PagingState; SyncTime=; TimeoutSeconds=120 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Warning; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Record the named counter, measured value, units, sampling interval and effective thresholds. Compare a representative time series with workload changes, host placement and storage/network evidence. Separate host/root/guest CPU and assigned/demanded memory. Missing counters are a telemetry problem, not zero utilization.

### Corrective action and escalation

Address the identified contention, workload placement or failing path with its owner. Capacity changes require a headroom and failover-reserve check. Do not blindly increase thresholds, reboot hosts or reduce VM resources to suppress symptoms.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Observe the same metric over a representative load period, confirm sustained recovery and verify workload response independently. Product defaults require site-specific review and are not Microsoft service-level guarantees.

### Probe-specific state reasons

Critical when Pages Input/sec is at least PagesInputCriticalPerSecond; otherwise Warning at least PagesInputWarningPerSecond, otherwise Good. An unavailable counter yields NotApplicable, not zero paging. Correlate sustained paging with available memory and storage latency; a single spike does not establish memory exhaustion.

Critical probe exceptions can also mark unevaluated facets Critical. Read PipelineStateDetail and the first exception before interpreting a facet as a confirmed workload outage. Successful collection is not evidence that every workload is healthy.

### Microsoft references

[Microsoft Learn: troubleshoot hyper v virtual machine performance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/troubleshoot-hyper-v-virtual-machine-performance)


## Hyper-V expected VM state {#hypervprivatecloud.host.virtualmachines.monitor}

`HyperVPrivateCloud.Host.VirtualMachines.Monitor`

Detects auto-start VMs that are unexpectedly stopped or failed.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.Fabric.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.Fabric.Service.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Service.Compute.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Compute.Members.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Host.VirtualMachines.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

Detects auto-start VMs that are unexpectedly stopped or failed.

### Operator response

Confirm expected-state policy, current owner, migration or failover activity, and VMMS events.

### Support scope

Host-based Hyper-V workload or management evidence. A stopped VM must be compared with its intended state; inventory presence is not guest application monitoring.

Element: HyperVPrivateCloud.Host.VirtualMachines.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HCSV2Library!HyperVPrivateCloud.HostRole. Parent health aspect: Health!System.Health.AvailabilityState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: (Property[@Name=&#39;VirtualMachineState&#39;] = Good OR Property[@Name=&#39;VirtualMachineState&#39;] = NotApplicable)

Warning [Warning]: Property[@Name=&#39;VirtualMachineState&#39;] = Warning

Error [Critical]: Property[@Name=&#39;VirtualMachineState&#39;] = Critical

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: CheckpointCriticalHours=336; CheckpointWarningHours=168; CpuCriticalPercent=90; CpuWarningPercent=80; IntervalSeconds=300; MemoryCriticalMB=2048; MemoryWarningMB=4096; PagesInputCriticalPerSecond=20; PagesInputWarningPerSecond=5; PropertyName=VirtualMachineState; SyncTime=; TimeoutSeconds=120 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Error; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Run the matching read-only host/VM task. Match the stable VM ID and current owner, inspect Get-VM, attached disks, checkpoint chain and Hyper-V-VMMS/High-Availability logs. For management-service errors verify the named service and first failure rather than assuming every guest stopped.

### Corrective action and escalation

Restore the identified service, configuration, storage or VM dependency with the workload owner. Check intended shutdown and maintenance policy first. Never delete checkpoint files, force power operations or restart VMMS/hosts solely to clear an alert.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm the intended VM/service state, fresh host-derived evidence and the originating monitor. Guest application recovery requires a separate workload-level check.

### Probe-specific state reasons

Critical if any VM with AutomaticStartAction=Start is not Running, Starting, Stopping, Saving, Pausing or Resuming. Otherwise Good; no native Warning branch. This host summary uses auto-start policy; the runtime availability monitor also considers cluster ownership policy. Compare the named VM with its intended operating state before starting anything.

Critical probe exceptions can also mark unevaluated facets Critical. Read PipelineStateDetail and the first exception before interpreting a facet as a confirmed workload outage. Successful collection is not evidence that every workload is healthy.

### Microsoft references

[Microsoft Learn: hyper v start state access failures clustered standalone](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-start-state-access-failures-clustered-standalone)

[Microsoft Learn: hyper v virtual machine backup checkpoint storage](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-virtual-machine-backup-checkpoint-storage)


## Hyper-V checkpoint age {#hypervprivatecloud.host.checkpoints.monitor}

`HyperVPrivateCloud.Host.Checkpoints.Monitor`

Detects checkpoints older than the configured operational threshold.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.Fabric.Configuration.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.Fabric.Service.Configuration.Dependency.Monitor &gt; HyperVPrivateCloud.Service.Compute.Configuration.Dependency.Monitor &gt; HyperVPrivateCloud.Compute.Members.Configuration.Dependency.Monitor &gt; HyperVPrivateCloud.Host.Checkpoints.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

Detects checkpoints older than the configured operational threshold.

### Operator response

Confirm backup activity and checkpoint purpose, then merge or remove stale checkpoints using supported procedures.

### Support scope

Host-based Hyper-V workload or management evidence. A stopped VM must be compared with its intended state; inventory presence is not guest application monitoring.

Element: HyperVPrivateCloud.Host.Checkpoints.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HCSV2Library!HyperVPrivateCloud.HostRole. Parent health aspect: Health!System.Health.ConfigurationState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: (Property[@Name=&#39;CheckpointState&#39;] = Good OR Property[@Name=&#39;CheckpointState&#39;] = NotApplicable)

Warning [Warning]: Property[@Name=&#39;CheckpointState&#39;] = Warning

Error [Critical]: Property[@Name=&#39;CheckpointState&#39;] = Critical

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: CheckpointCriticalHours=336; CheckpointWarningHours=168; CpuCriticalPercent=90; CpuWarningPercent=80; IntervalSeconds=300; MemoryCriticalMB=2048; MemoryWarningMB=4096; PagesInputCriticalPerSecond=20; PagesInputWarningPerSecond=5; PropertyName=CheckpointState; SyncTime=; TimeoutSeconds=120 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Warning; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Run the matching read-only host/VM task. Match the stable VM ID and current owner, inspect Get-VM, attached disks, checkpoint chain and Hyper-V-VMMS/High-Availability logs. For management-service errors verify the named service and first failure rather than assuming every guest stopped.

### Corrective action and escalation

Restore the identified service, configuration, storage or VM dependency with the workload owner. Check intended shutdown and maintenance policy first. Never delete checkpoint files, force power operations or restart VMMS/hosts solely to clear an alert.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm the intended VM/service state, fresh host-derived evidence and the originating monitor. Guest application recovery requires a separate workload-level check.

### Probe-specific state reasons

Uses the oldest checkpoint age across host VMs, rounded to 0.1 hour. Critical at or above CheckpointCriticalHours; otherwise Warning at or above CheckpointWarningHours; otherwise Good. No checkpoints gives age zero. Verify retention intent, checkpoint owner and backing-volume headroom; use supported backup/Hyper-V cleanup, never manual AVHDX deletion.

Critical probe exceptions can also mark unevaluated facets Critical. Read PipelineStateDetail and the first exception before interpreting a facet as a confirmed workload outage. Successful collection is not evidence that every workload is healthy.

### Microsoft references

[Microsoft Learn: hyper v start state access failures clustered standalone](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-start-state-access-failures-clustered-standalone)

[Microsoft Learn: hyper v virtual machine backup checkpoint storage](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-virtual-machine-backup-checkpoint-storage)


## Hyper-V Replica health {#hypervprivatecloud.host.replication.monitor}

`HyperVPrivateCloud.Host.Replication.Monitor`

Tracks the worst Hyper-V Replica relationship health on the host.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.Fabric.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.Fabric.Service.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Service.Compute.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Compute.Members.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Host.Replication.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

Tracks the worst Hyper-V Replica relationship health on the host.

### Operator response

Inspect replication connectivity, authentication, backlog, storage, and last successful replication.

### Support scope

Host-observed replication state and disaster-recovery protection, not an application availability test inside the guest.

Element: HyperVPrivateCloud.Host.Replication.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HCSV2Library!HyperVPrivateCloud.HostRole. Parent health aspect: Health!System.Health.AvailabilityState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: (Property[@Name=&#39;ReplicationState&#39;] = Good OR Property[@Name=&#39;ReplicationState&#39;] = NotApplicable)

Warning [Warning]: Property[@Name=&#39;ReplicationState&#39;] = Warning

Error [Critical]: Property[@Name=&#39;ReplicationState&#39;] = Critical

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: CheckpointCriticalHours=336; CheckpointWarningHours=168; CpuCriticalPercent=90; CpuWarningPercent=80; IntervalSeconds=300; MemoryCriticalMB=2048; MemoryWarningMB=4096; PagesInputCriticalPerSecond=20; PagesInputWarningPerSecond=5; PropertyName=ReplicationState; SyncTime=; TimeoutSeconds=120 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Warning; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Use Get-VMReplication and Measure-VMReplication for the named VM on its owner. Inspect replication mode, primary/replica server, health, last replication time and backlog. For a cluster broker, follow network-name and broker resource dependencies. Distinguish planned pause, initial replication and unexpected loss of protection.

### Corrective action and escalation

Restore the actual authentication, certificate, broker, network or storage dependency. Coordinate resume or resynchronization with the recovery owner and verify bandwidth/storage impact. Never perform failover, reverse replication or remove/recreate protection solely to clear an alert.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm replication resumes and lag meets the agreed recovery-point objective. A healthy running primary VM alone does not establish healthy disaster recovery.

### Probe-specific state reasons

Critical if any returned replication relationship reports native Health=Critical; otherwise Warning if any reports Warning; otherwise Good. A host with no returned relationships is Good here and is not thereby protected. Inspect the specific VM relationship, lag and recovery objective.

Critical probe exceptions can also mark unevaluated facets Critical. Read PipelineStateDetail and the first exception before interpreting a facet as a confirmed workload outage. Successful collection is not evidence that every workload is healthy.

### Microsoft references

[Microsoft Learn: hyper v replica troubleshooting guide](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-replica-troubleshooting-guide)


## Hyper-V virtual switch health {#hypervprivatecloud.host.virtualswitches.monitor}

`HyperVPrivateCloud.Host.VirtualSwitches.Monitor`

Detects external virtual switches with no bound physical uplink.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.Fabric.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.Fabric.Service.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Service.Compute.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Compute.Members.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Host.VirtualSwitches.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

Detects external virtual switches with no bound physical uplink.

### Operator response

Review switch type, SET membership, physical adapter state, and recent network configuration changes.

### Support scope

Host network or external infrastructure evidence at the precise scope of the leaf. TCP reachability is not device hardware, firewall-policy or application health; linked vendor monitors retain their own authority.

Element: HyperVPrivateCloud.Host.VirtualSwitches.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HCSV2Library!HyperVPrivateCloud.HostRole. Parent health aspect: Health!System.Health.AvailabilityState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: (Property[@Name=&#39;VirtualSwitchState&#39;] = Good OR Property[@Name=&#39;VirtualSwitchState&#39;] = NotApplicable)

Warning [Warning]: Property[@Name=&#39;VirtualSwitchState&#39;] = Warning

Error [Critical]: Property[@Name=&#39;VirtualSwitchState&#39;] = Critical

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: CheckpointCriticalHours=336; CheckpointWarningHours=168; CpuCriticalPercent=90; CpuWarningPercent=80; IntervalSeconds=300; MemoryCriticalMB=2048; MemoryWarningMB=4096; PagesInputCriticalPerSecond=20; PagesInputWarningPerSecond=5; PropertyName=VirtualSwitchState; SyncTime=; TimeoutSeconds=120 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Error; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Identify the adapter, switch, port or configured endpoint and the actual observation source. Compare link state, negotiated speed and error/discard deltas with device-side evidence. Check routing and the intended port from the collector. An unreachable management endpoint does not by itself prove the data plane failed.

### Corrective action and escalation

Restore the specific path, cable/optic, approved switch configuration or device service with the network/hardware owner. Consult the vendor for proprietary device faults. Do not disable security controls, bounce all uplinks or reboot management devices based only on a failed TCP probe.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Repeat the original path test and confirm relevant native/vendor health. For cumulative errors, observe new deltas; do not expect historic totals to disappear.

### Probe-specific state reasons

Critical when an External virtual switch has no NetAdapterInterfaceDescriptions entries. Otherwise Good; no native Warning branch. This configuration check does not prove uplink link-state or forwarding health. Inspect the exact switch and physical adapter before an approved binding repair.

Critical probe exceptions can also mark unevaluated facets Critical. Read PipelineStateDetail and the first exception before interpreting a facet as a confirmed workload outage. Successful collection is not evidence that every workload is healthy.

### Microsoft references

[Microsoft Learn: troubleshoot tcp ip communication guidance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/networking/troubleshoot-tcp-ip-communication-guidance)


## Hyper-V virtual disk attachment health {#hypervprivatecloud.host.storageattachments.monitor}

`HyperVPrivateCloud.Host.StorageAttachments.Monitor`

Detects missing or unreadable VHD/VHDX attachments.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.Fabric.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.Fabric.Service.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Service.Compute.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Compute.Members.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Host.StorageAttachments.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

Detects missing or unreadable VHD/VHDX attachments.

### Operator response

Validate the VM disk path, storage availability, permissions, VHD chain, and active backup or merge operations.

### Support scope

Host-based Hyper-V workload or management evidence. A stopped VM must be compared with its intended state; inventory presence is not guest application monitoring.

Element: HyperVPrivateCloud.Host.StorageAttachments.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HCSV2Library!HyperVPrivateCloud.HostRole. Parent health aspect: Health!System.Health.AvailabilityState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: (Property[@Name=&#39;StorageAttachmentState&#39;] = Good OR Property[@Name=&#39;StorageAttachmentState&#39;] = NotApplicable)

Warning [Warning]: Property[@Name=&#39;StorageAttachmentState&#39;] = Warning

Error [Critical]: Property[@Name=&#39;StorageAttachmentState&#39;] = Critical

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: CheckpointCriticalHours=336; CheckpointWarningHours=168; CpuCriticalPercent=90; CpuWarningPercent=80; IntervalSeconds=300; MemoryCriticalMB=2048; MemoryWarningMB=4096; PagesInputCriticalPerSecond=20; PagesInputWarningPerSecond=5; PropertyName=StorageAttachmentState; SyncTime=; TimeoutSeconds=120 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Error; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Run the matching read-only host/VM task. Match the stable VM ID and current owner, inspect Get-VM, attached disks, checkpoint chain and Hyper-V-VMMS/High-Availability logs. For management-service errors verify the named service and first failure rather than assuming every guest stopped.

### Corrective action and escalation

Restore the identified service, configuration, storage or VM dependency with the workload owner. Check intended shutdown and maintenance policy first. Never delete checkpoint files, force power operations or restart VMMS/hosts solely to clear an alert.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm the intended VM/service state, fresh host-derived evidence and the originating monitor. Guest application recovery requires a separate workload-level check.

### Probe-specific state reasons

Critical when an enumerated VM disk with a path fails Test-Path -PathType Leaf or cannot be read by Get-VHD. Otherwise Good; no native Warning branch. Validate the path on the owner with the collector identity and storage provider before assuming data loss. This is attachment access, not a filesystem integrity check inside the guest.

Critical probe exceptions can also mark unevaluated facets Critical. Read PipelineStateDetail and the first exception before interpreting a facet as a confirmed workload outage. Successful collection is not evidence that every workload is healthy.

### Microsoft references

[Microsoft Learn: hyper v start state access failures clustered standalone](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-start-state-access-failures-clustered-standalone)

[Microsoft Learn: hyper v virtual machine backup checkpoint storage](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-virtual-machine-backup-checkpoint-storage)


## Active Directory domain and secure channel health {#hypervprivatecloud.host.domainhealth.monitor}

`HyperVPrivateCloud.Host.DomainHealth.Monitor`

Tracks Active Directory domain trust, secure channel, and domain controller reachability.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.ManagementStack.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.ManagementStack.Management.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Management.Members.Domain.Availability.Dependency.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

Tracks Active Directory domain trust, secure channel, and domain controller reachability.

### Operator response

Verify Active Directory domain join, secure channel with Test-ComputerSecureChannel, DNS server connectivity, and DC availability.

### Support scope

Host-observed domain and secure-channel dependency, not an exhaustive domain-controller replication or AD health assessment.

Element: HyperVPrivateCloud.Host.DomainHealth.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HCSV2Library!HyperVPrivateCloud.HostRole. Parent health aspect: Health!System.Health.AvailabilityState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: (Property[@Name=&#39;DomainHealthState&#39;] = Good OR Property[@Name=&#39;DomainHealthState&#39;] = NotApplicable)

Warning [Warning]: Property[@Name=&#39;DomainHealthState&#39;] = Warning

Error [Critical]: Property[@Name=&#39;DomainHealthState&#39;] = Critical

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: CheckpointCriticalHours=336; CheckpointWarningHours=168; CpuCriticalPercent=90; CpuWarningPercent=80; IntervalSeconds=300; MemoryCriticalMB=2048; MemoryWarningMB=4096; PagesInputCriticalPerSecond=20; PagesInputWarningPerSecond=5; PropertyName=DomainHealthState; SyncTime=; TimeoutSeconds=120 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Error; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Run the read-only domain diagnostic from the affected host. Verify DNS/DC discovery, time synchronization, network reachability and Test-ComputerSecureChannel without -Repair. Correlate NETLOGON errors with directory-team evidence.

### Corrective action and escalation

Restore DNS/time/connectivity first where indicated. If the machine account trust is genuinely broken, use the approved directory recovery procedure with the AD owner. Do not unjoin/rejoin a clustered host or reset machine passwords as a first response.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Repeat the secure-channel and domain discovery checks, verify normal authentication and fresh monitor recovery.

### Probe-specific state reasons

Good when the domain secure channel succeeds, or the computer is a workgroup member. Critical when the domain secure channel test returns false. Warning when domain evaluation throws. A workgroup Good result is not an AD health test; never repair trust or rejoin a cluster node without the directory owner.

Critical probe exceptions can also mark unevaluated facets Critical. Read PipelineStateDetail and the first exception before interpreting a facet as a confirmed workload outage. Successful collection is not evidence that every workload is healthy.

### Microsoft references

[Microsoft Learn: broken trust relationship domain joined device its domain secure channel issues](https://learn.microsoft.com/en-us/troubleshoot/windows-server/windows-security/broken-trust-relationship-domain-joined-device-its-domain-secure-channel-issues)


## DNS infrastructure resolution health {#hypervprivatecloud.host.dnshealth.monitor}

`HyperVPrivateCloud.Host.DnsHealth.Monitor`

Tracks Domain Name System resolution and configured server reachability.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.ManagementStack.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.ManagementStack.Management.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Management.Members.Dns.Availability.Dependency.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

Tracks Domain Name System resolution and configured server reachability.

### Operator response

Verify primary and secondary DNS server responsiveness, forward and reverse lookup, and domain SRV records.

### Support scope

DNS service or name-resolution dependency as tested by the configured probe, not proof that every zone or client is healthy.

Element: HyperVPrivateCloud.Host.DnsHealth.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HCSV2Library!HyperVPrivateCloud.HostRole. Parent health aspect: Health!System.Health.AvailabilityState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: (Property[@Name=&#39;DnsHealthState&#39;] = Good OR Property[@Name=&#39;DnsHealthState&#39;] = NotApplicable)

Warning [Warning]: Property[@Name=&#39;DnsHealthState&#39;] = Warning

Error [Critical]: Property[@Name=&#39;DnsHealthState&#39;] = Critical

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: CheckpointCriticalHours=336; CheckpointWarningHours=168; CpuCriticalPercent=90; CpuWarningPercent=80; IntervalSeconds=300; MemoryCriticalMB=2048; MemoryWarningMB=4096; PagesInputCriticalPerSecond=20; PagesInputWarningPerSecond=5; PropertyName=DnsHealthState; SyncTime=; TimeoutSeconds=120 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Error; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Run the DNS diagnostic on the affected host. Record queried name/type, configured resolver, response/error and forward/SRV results. Compare another resolver and another client to distinguish client configuration, path and authoritative-server failures.

### Corrective action and escalation

Correct the proven resolver, zone, record, forwarding or network issue with the DNS owner. Avoid global cache flushes or DNS-service restarts without a specific reason.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Repeat the same failing query from the original host and confirm fresh monitoring evidence, not merely a cached successful answer from another machine.

### Probe-specific state reasons

Good when the configured probe name resolves using the host resolver path. Critical when the resolution attempt fails. Warning when no DNS servers are configured on active adapters or DNS evaluation throws. Record the exact name, configured servers and collector; this does not test every DNS zone.

Critical probe exceptions can also mark unevaluated facets Critical. Read PipelineStateDetail and the first exception before interpreting a facet as a confirmed workload outage. Successful collection is not evidence that every workload is healthy.

### Microsoft references

[Microsoft Learn: troubleshoot dns guidance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/networking/troubleshoot-dns-guidance)

[Microsoft Learn: troubleshoot dns server](https://learn.microsoft.com/en-us/windows-server/networking/dns/troubleshoot/troubleshoot-dns-server)


## Bare-metal deployment service health {#hypervprivatecloud.host.deploymentservice.monitor}

`HyperVPrivateCloud.Host.DeploymentService.Monitor`

Tracks bare-metal provisioning and Windows Deployment Services state.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.ManagementStack.Configuration.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.ManagementStack.Management.Configuration.Dependency.Monitor &gt; HyperVPrivateCloud.Management.Members.Deployment.Configuration.Dependency.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

Tracks bare-metal provisioning and Windows Deployment Services state.

### Operator response

Verify the WDSServer service status, TFTP listener on port 69, and PXE boot provider configuration.

### Support scope

Host-based Hyper-V workload or management evidence. A stopped VM must be compared with its intended state; inventory presence is not guest application monitoring.

Element: HyperVPrivateCloud.Host.DeploymentService.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HCSV2Library!HyperVPrivateCloud.HostRole. Parent health aspect: Health!System.Health.ConfigurationState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: (Property[@Name=&#39;DeploymentServiceState&#39;] = Good OR Property[@Name=&#39;DeploymentServiceState&#39;] = NotApplicable)

Warning [Warning]: Property[@Name=&#39;DeploymentServiceState&#39;] = Warning

Error [Critical]: Property[@Name=&#39;DeploymentServiceState&#39;] = Critical

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: CheckpointCriticalHours=336; CheckpointWarningHours=168; CpuCriticalPercent=90; CpuWarningPercent=80; IntervalSeconds=300; MemoryCriticalMB=2048; MemoryWarningMB=4096; PagesInputCriticalPerSecond=20; PagesInputWarningPerSecond=5; PropertyName=DeploymentServiceState; SyncTime=; TimeoutSeconds=120 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Warning; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Run the matching read-only host/VM task. Match the stable VM ID and current owner, inspect Get-VM, attached disks, checkpoint chain and Hyper-V-VMMS/High-Availability logs. For management-service errors verify the named service and first failure rather than assuming every guest stopped.

### Corrective action and escalation

Restore the identified service, configuration, storage or VM dependency with the workload owner. Check intended shutdown and maintenance policy first. Never delete checkpoint files, force power operations or restart VMMS/hosts solely to clear an alert.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm the intended VM/service state, fresh host-derived evidence and the originating monitor. Guest application recovery requires a separate workload-level check.

### Probe-specific state reasons

Good when locally installed WDSServer is Running; Warning when installed but not Running. Absent WDS or an unprobeable optional WDS service yields NotApplicable. There is no ordinary Critical service-state branch. This local service check does not validate a complete PXE deployment transaction.

Critical probe exceptions can also mark unevaluated facets Critical. Read PipelineStateDetail and the first exception before interpreting a facet as a confirmed workload outage. Successful collection is not evidence that every workload is healthy.

### Microsoft references

[Microsoft Learn: hyper v start state access failures clustered standalone](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-start-state-access-failures-clustered-standalone)

[Microsoft Learn: hyper v virtual machine backup checkpoint storage](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-virtual-machine-backup-checkpoint-storage)


## Physical server chassis and hardware health {#hypervprivatecloud.host.physicalchassis.monitor}

`HyperVPrivateCloud.Host.PhysicalChassis.Monitor`

Tracks physical server hardware, chassis status, and BMC health.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.Fabric.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.Fabric.Service.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Service.Compute.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Compute.PhysicalChassis.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Host.PhysicalChassis.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

Tracks physical server hardware, chassis status, and BMC health.

### Operator response

Inspect physical chassis status via IPMI/Redfish or vendor management console, check power supplies, fans, and hardware event log.

### Support scope

Host network or external infrastructure evidence at the precise scope of the leaf. TCP reachability is not device hardware, firewall-policy or application health; linked vendor monitors retain their own authority.

Element: HyperVPrivateCloud.Host.PhysicalChassis.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HCSV2Library!HyperVPrivateCloud.PhysicalChassis. Parent health aspect: Health!System.Health.AvailabilityState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: Property[@Name=&#39;FabricDeviceState&#39;] = Good

Warning [Warning]: Property[@Name=&#39;FabricDeviceState&#39;] = Warning

Error [Critical]: Property[@Name=&#39;FabricDeviceState&#39;] = Critical

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: DeviceKind=PhysicalChassis; DeviceName=$Target/Property[Type=&quot;HCSV2Library!HyperVPrivateCloud.PhysicalChassis&quot;]/ChassisId$; IntervalSeconds=300; ManagementAddress=$Target/Property[Type=&quot;HCSV2Library!HyperVPrivateCloud.PhysicalChassis&quot;]/BmcIpv4Address$; ManagementPorts=; SyncTime=; TimeoutSeconds=120 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Error; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Identify the adapter, switch, port or configured endpoint and the actual observation source. Compare link state, negotiated speed and error/discard deltas with device-side evidence. Check routing and the intended port from the collector. An unreachable management endpoint does not by itself prove the data plane failed.

### Corrective action and escalation

Restore the specific path, cable/optic, approved switch configuration or device service with the network/hardware owner. Consult the vendor for proprietary device faults. Do not disable security controls, bounce all uplinks or reboot management devices based only on a failed TCP probe.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Repeat the original path test and confirm relevant native/vendor health. For cumulative errors, observe new deltas; do not expect historic totals to disappear.

### Probe-specific state reasons

Good when any configured management TCP port accepts a connection; Warning when only ICMP responds; Critical when neither responds or the probe throws. Missing management address yields NotApplicable. With local-ipmi, presence of a Microsoft_IPMI provider instance gives Good and absence gives Warning; no sensor readings are evaluated. These are management-path observations, not authenticated API, hardware-sensor or data-plane health. Check expected ports, ACLs, routing and vendor telemetry before diagnosing a device failure.

### Microsoft references

[Microsoft Learn: troubleshoot tcp ip communication guidance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/networking/troubleshoot-tcp-ip-communication-guidance)


## DHCP infrastructure service health {#hypervprivatecloud.host.dhcpservice.monitor}

`HyperVPrivateCloud.Host.DhcpService.Monitor`

Tracks DHCP server service status and UDP port 67 listener.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.ManagementStack.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.ManagementStack.Management.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Management.DhcpService.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Host.DhcpService.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

Tracks DHCP server service status and UDP port 67 listener.

### Operator response

Check the DHCPServer service status, scope activation, IP pool exhaustion, and DHCP event log.

### Support scope

Configured DHCP service reachability/health evidence. This is not an exhaustive lease, scope or client transaction monitor unless the leaf explicitly measures those facts.

Element: HyperVPrivateCloud.Host.DhcpService.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HCSV2Library!HyperVPrivateCloud.DhcpService. Parent health aspect: Health!System.Health.AvailabilityState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: (Property[@Name=&#39;DhcpServiceState&#39;] = Good OR Property[@Name=&#39;DhcpServiceState&#39;] = NotApplicable)

Warning [Warning]: Property[@Name=&#39;DhcpServiceState&#39;] = Warning

Error [Critical]: Property[@Name=&#39;DhcpServiceState&#39;] = Critical

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: CheckpointCriticalHours=336; CheckpointWarningHours=168; CpuCriticalPercent=90; CpuWarningPercent=80; IntervalSeconds=300; MemoryCriticalMB=2048; MemoryWarningMB=4096; PagesInputCriticalPerSecond=20; PagesInputWarningPerSecond=5; PropertyName=DhcpServiceState; SyncTime=; TimeoutSeconds=120 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Error; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Check the named DHCP endpoint, service status, authorization, applicable scope free leases and relay path with the DHCP owner. Compare a client on the server subnet with one behind the affected relay.

### Corrective action and escalation

Correct the proven service, scope or relay issue through approved network change control. Do not authorize unknown DHCP servers or change scope ranges to clear a reachability alarm.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm the configured probe and a representative lease transaction recover without address conflicts.

### Probe-specific state reasons

Good when the local DHCP Server service is Running; Warning when installed but not Running. An absent or unprobeable optional local DHCP service yields NotApplicable. There is no ordinary Critical service-state branch. Lease capacity, authorization and relay transactions require additional DHCP evidence.

Critical probe exceptions can also mark unevaluated facets Critical. Read PipelineStateDetail and the first exception before interpreting a facet as a confirmed workload outage. Successful collection is not evidence that every workload is healthy.

### Microsoft references

[Microsoft Learn: troubleshoot dhcp guidance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/networking/troubleshoot-dhcp-guidance)


## Out-of-band management switch reachability {#hypervprivatecloud.host.outofbandswitch.monitor}

`HyperVPrivateCloud.Host.OutOfBandSwitch.Monitor`

Tracks network reachability to the out-of-band management switch that carries BMC and console traffic.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.Fabric.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.Fabric.Service.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Service.Network.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Network.OutOfBandSwitch.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Host.OutOfBandSwitch.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

Tracks network reachability to the out-of-band management switch that carries BMC and console traffic.

### Operator response

Verify the out-of-band switch management address, its uplink, and that the declared management port is listening.

### Support scope

Host network or external infrastructure evidence at the precise scope of the leaf. TCP reachability is not device hardware, firewall-policy or application health; linked vendor monitors retain their own authority.

Element: HyperVPrivateCloud.Host.OutOfBandSwitch.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HCSV2Library!HyperVPrivateCloud.OutOfBandSwitch. Parent health aspect: Health!System.Health.AvailabilityState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: Property[@Name=&#39;FabricDeviceState&#39;] = Good

Warning [Warning]: Property[@Name=&#39;FabricDeviceState&#39;] = Warning

Error [Critical]: Property[@Name=&#39;FabricDeviceState&#39;] = Critical

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: DeviceKind=OutOfBandSwitch; DeviceName=$Target/Property[Type=&quot;HCSV2Library!HyperVPrivateCloud.OutOfBandSwitch&quot;]/SwitchName$; IntervalSeconds=300; ManagementAddress=$Target/Property[Type=&quot;HCSV2Library!HyperVPrivateCloud.OutOfBandSwitch&quot;]/ManagementIp$; ManagementPorts=; SyncTime=; TimeoutSeconds=120 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Warning; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Identify the adapter, switch, port or configured endpoint and the actual observation source. Compare link state, negotiated speed and error/discard deltas with device-side evidence. Check routing and the intended port from the collector. An unreachable management endpoint does not by itself prove the data plane failed.

### Corrective action and escalation

Restore the specific path, cable/optic, approved switch configuration or device service with the network/hardware owner. Consult the vendor for proprietary device faults. Do not disable security controls, bounce all uplinks or reboot management devices based only on a failed TCP probe.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Repeat the original path test and confirm relevant native/vendor health. For cumulative errors, observe new deltas; do not expect historic totals to disappear.

### Probe-specific state reasons

Good when any configured management TCP port accepts a connection; Warning when only ICMP responds; Critical when neither responds or the probe throws. Missing management address yields NotApplicable. With local-ipmi, presence of a Microsoft_IPMI provider instance gives Good and absence gives Warning; no sensor readings are evaluated. These are management-path observations, not authenticated API, hardware-sensor or data-plane health. Check expected ports, ACLs, routing and vendor telemetry before diagnosing a device failure.

### Microsoft references

[Microsoft Learn: troubleshoot tcp ip communication guidance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/networking/troubleshoot-tcp-ip-communication-guidance)


## Top-of-Rack data switch reachability {#hypervprivatecloud.host.topofrackswitch.monitor}

`HyperVPrivateCloud.Host.TopOfRackSwitch.Monitor`

Tracks network reachability to the connected Top-of-Rack data switch.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.Fabric.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.Fabric.Service.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Service.Network.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Network.TopOfRackSwitch.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Host.TopOfRackSwitch.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

Tracks network reachability to the connected Top-of-Rack data switch.

### Operator response

Verify physical link on host uplinks, LLDP neighbor discovery, and gateway/switch IP reachability.

### Support scope

Host network or external infrastructure evidence at the precise scope of the leaf. TCP reachability is not device hardware, firewall-policy or application health; linked vendor monitors retain their own authority.

Element: HyperVPrivateCloud.Host.TopOfRackSwitch.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HCSV2Library!HyperVPrivateCloud.TopOfRackSwitch. Parent health aspect: Health!System.Health.AvailabilityState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: Property[@Name=&#39;FabricDeviceState&#39;] = Good

Warning [Warning]: Property[@Name=&#39;FabricDeviceState&#39;] = Warning

Error [Critical]: Property[@Name=&#39;FabricDeviceState&#39;] = Critical

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: DeviceKind=TopOfRackSwitch; DeviceName=$Target/Property[Type=&quot;HCSV2Library!HyperVPrivateCloud.TopOfRackSwitch&quot;]/SwitchName$; IntervalSeconds=300; ManagementAddress=$Target/Property[Type=&quot;HCSV2Library!HyperVPrivateCloud.TopOfRackSwitch&quot;]/ManagementIp$; ManagementPorts=; SyncTime=; TimeoutSeconds=120 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Warning; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Identify the adapter, switch, port or configured endpoint and the actual observation source. Compare link state, negotiated speed and error/discard deltas with device-side evidence. Check routing and the intended port from the collector. An unreachable management endpoint does not by itself prove the data plane failed.

### Corrective action and escalation

Restore the specific path, cable/optic, approved switch configuration or device service with the network/hardware owner. Consult the vendor for proprietary device faults. Do not disable security controls, bounce all uplinks or reboot management devices based only on a failed TCP probe.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Repeat the original path test and confirm relevant native/vendor health. For cumulative errors, observe new deltas; do not expect historic totals to disappear.

### Probe-specific state reasons

Good when any configured management TCP port accepts a connection; Warning when only ICMP responds; Critical when neither responds or the probe throws. Missing management address yields NotApplicable. With local-ipmi, presence of a Microsoft_IPMI provider instance gives Good and absence gives Warning; no sensor readings are evaluated. These are management-path observations, not authenticated API, hardware-sensor or data-plane health. Check expected ports, ACLs, routing and vendor telemetry before diagnosing a device failure.

### Microsoft references

[Microsoft Learn: troubleshoot tcp ip communication guidance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/networking/troubleshoot-tcp-ip-communication-guidance)


## Edge perimeter firewall reachability {#hypervprivatecloud.host.edgefirewall.monitor}

`HyperVPrivateCloud.Host.EdgeFirewall.Monitor`

Tracks network reachability to the perimeter edge firewall or gateway.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.Fabric.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.Fabric.Service.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Service.Network.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Network.EdgeFirewall.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Host.EdgeFirewall.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

Tracks network reachability to the perimeter edge firewall or gateway.

### Operator response

Check default gateway connectivity, routing table, firewall status, and upstream WAN interface.

### Support scope

Host network or external infrastructure evidence at the precise scope of the leaf. TCP reachability is not device hardware, firewall-policy or application health; linked vendor monitors retain their own authority.

Element: HyperVPrivateCloud.Host.EdgeFirewall.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HCSV2Library!HyperVPrivateCloud.EdgeFirewall. Parent health aspect: Health!System.Health.AvailabilityState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: Property[@Name=&#39;FabricDeviceState&#39;] = Good

Warning [Warning]: Property[@Name=&#39;FabricDeviceState&#39;] = Warning

Error [Critical]: Property[@Name=&#39;FabricDeviceState&#39;] = Critical

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: DeviceKind=EdgeFirewall; DeviceName=$Target/Property[Type=&quot;HCSV2Library!HyperVPrivateCloud.EdgeFirewall&quot;]/DeviceName$; IntervalSeconds=300; ManagementAddress=$Target/Property[Type=&quot;HCSV2Library!HyperVPrivateCloud.EdgeFirewall&quot;]/ManagementIp$; ManagementPorts=; SyncTime=; TimeoutSeconds=120 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Warning; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Identify the adapter, switch, port or configured endpoint and the actual observation source. Compare link state, negotiated speed and error/discard deltas with device-side evidence. Check routing and the intended port from the collector. An unreachable management endpoint does not by itself prove the data plane failed.

### Corrective action and escalation

Restore the specific path, cable/optic, approved switch configuration or device service with the network/hardware owner. Consult the vendor for proprietary device faults. Do not disable security controls, bounce all uplinks or reboot management devices based only on a failed TCP probe.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Repeat the original path test and confirm relevant native/vendor health. For cumulative errors, observe new deltas; do not expect historic totals to disappear.

### Probe-specific state reasons

Good when any configured management TCP port accepts a connection; Warning when only ICMP responds; Critical when neither responds or the probe throws. Missing management address yields NotApplicable. With local-ipmi, presence of a Microsoft_IPMI provider instance gives Good and absence gives Warning; no sensor readings are evaluated. These are management-path observations, not authenticated API, hardware-sensor or data-plane health. Check expected ports, ACLs, routing and vendor telemetry before diagnosing a device failure.

### Microsoft references

[Microsoft Learn: troubleshoot tcp ip communication guidance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/networking/troubleshoot-tcp-ip-communication-guidance)


## Out-of-band console server reachability {#hypervprivatecloud.host.consoleserver.monitor}

`HyperVPrivateCloud.Host.ConsoleServer.Monitor`

Tracks reachability of out-of-band console server appliance (Opengear).

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.ManagementStack.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.ManagementStack.Management.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Management.ConsoleServer.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Host.ConsoleServer.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

Tracks reachability of out-of-band console server appliance (Opengear).

### Operator response

Check out-of-band management network reachability, console server power/IP, and cellular fallback.

### Support scope

Host network or external infrastructure evidence at the precise scope of the leaf. TCP reachability is not device hardware, firewall-policy or application health; linked vendor monitors retain their own authority.

Element: HyperVPrivateCloud.Host.ConsoleServer.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HCSV2Library!HyperVPrivateCloud.ConsoleServer. Parent health aspect: Health!System.Health.AvailabilityState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: Property[@Name=&#39;FabricDeviceState&#39;] = Good

Warning [Warning]: Property[@Name=&#39;FabricDeviceState&#39;] = Warning

Error [Critical]: Property[@Name=&#39;FabricDeviceState&#39;] = Critical

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: DeviceKind=ConsoleServer; DeviceName=$Target/Property[Type=&quot;HCSV2Library!HyperVPrivateCloud.ConsoleServer&quot;]/Hostname$; IntervalSeconds=300; ManagementAddress=$Target/Property[Type=&quot;HCSV2Library!HyperVPrivateCloud.ConsoleServer&quot;]/ManagementIp$; ManagementPorts=; SyncTime=; TimeoutSeconds=120 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Warning; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Identify the adapter, switch, port or configured endpoint and the actual observation source. Compare link state, negotiated speed and error/discard deltas with device-side evidence. Check routing and the intended port from the collector. An unreachable management endpoint does not by itself prove the data plane failed.

### Corrective action and escalation

Restore the specific path, cable/optic, approved switch configuration or device service with the network/hardware owner. Consult the vendor for proprietary device faults. Do not disable security controls, bounce all uplinks or reboot management devices based only on a failed TCP probe.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Repeat the original path test and confirm relevant native/vendor health. For cumulative errors, observe new deltas; do not expect historic totals to disappear.

### Probe-specific state reasons

Good when any configured management TCP port accepts a connection; Warning when only ICMP responds; Critical when neither responds or the probe throws. Missing management address yields NotApplicable. With local-ipmi, presence of a Microsoft_IPMI provider instance gives Good and absence gives Warning; no sensor readings are evaluated. These are management-path observations, not authenticated API, hardware-sensor or data-plane health. Check expected ports, ACLs, routing and vendor telemetry before diagnosing a device failure.

### Microsoft references

[Microsoft Learn: troubleshoot tcp ip communication guidance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/networking/troubleshoot-tcp-ip-communication-guidance)


## Hyper-V host monitoring pipeline health {#hypervprivatecloud.host.pipeline.monitor}

`HyperVPrivateCloud.Host.Pipeline.Monitor`

Tracks completion of the shared host health probe.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.ManagementStack.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.ManagementStack.Monitoring.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Monitoring.Members.Availability.Dependency.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

Tracks completion of the shared host health probe.

### Operator response

Review Operations Manager event 8201, workflow state, module availability, permissions, and timeout settings.

### Support scope

Monitoring capability, data collection or freshness. Failure means visibility is impaired; do not infer that the monitored workload itself is down or healthy.

Element: HyperVPrivateCloud.Host.Pipeline.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HCSV2Library!HyperVPrivateCloud.HostRole. Parent health aspect: Health!System.Health.AvailabilityState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: (Property[@Name=&#39;PipelineState&#39;] = Good OR Property[@Name=&#39;PipelineState&#39;] = NotApplicable)

Warning [Warning]: Property[@Name=&#39;PipelineState&#39;] = Warning

Error [Critical]: Property[@Name=&#39;PipelineState&#39;] = Critical

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: CheckpointCriticalHours=336; CheckpointWarningHours=168; CpuCriticalPercent=90; CpuWarningPercent=80; IntervalSeconds=300; MemoryCriticalMB=2048; MemoryWarningMB=4096; PagesInputCriticalPerSecond=20; PagesInputWarningPerSecond=5; PropertyName=PipelineState; SyncTime=; TimeoutSeconds=120 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Error; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Read the first probe error and Operations Manager event context. Verify HealthService availability, supported PowerShell runtime, required modules, Run As scope and agent proxy where cross-object discovery requires it. Compare last successful sample and discovery time.

### Corrective action and escalation

Correct the missing runtime/module, access or source defect. Preserve logs before any approved HealthService restart. Do not reset health or clear the agent cache as a substitute for understanding a repeatable script error.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Require a new successful discovery/sample and initialized leaf monitors. Old green values cannot establish recovery of a broken collector.

### Probe-specific state reasons

Good means the host probe reached completion and supplies its UTC completion time. Critical means the probe failed before this state was set. No native Warning branch. Facets already sampled can retain their actual result while later unevaluated facets report the exception; inspect the first error and require a fresh successful run.

Critical probe exceptions can also mark unevaluated facets Critical. Read PipelineStateDetail and the first exception before interpreting a facet as a confirmed workload outage. Successful collection is not evidence that every workload is healthy.

### Microsoft references

[Microsoft Learn: manage consoles overview healthexplorer](https://learn.microsoft.com/en-us/system-center/scom/manage-consoles-overview-healthexplorer?view=sc-om-2025)


## VM expected runtime state {#hypervprivatecloud.vmruntime.availability.monitor}

`HyperVPrivateCloud.VmRuntime.Availability.Monitor`

Tracks expected versus actual VM runtime state.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.Fabric.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.Fabric.Service.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Service.Availability.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Availability.Members.Availability.Dependency.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

Tracks expected versus actual VM runtime state.

### Operator response

Confirm the VM start policy, current owner, maintenance state, clustered role, and VMMS events.

### Support scope

Host-based Hyper-V workload or management evidence. A stopped VM must be compared with its intended state; inventory presence is not guest application monitoring.

Element: HyperVPrivateCloud.VmRuntime.Availability.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HCSV2Library!HyperVPrivateCloud.VirtualMachineRuntime. Parent health aspect: Health!System.Health.AvailabilityState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: (Property[@Name=&#39;VMId&#39;] = $Target/Property[Type=&quot;HCSV2Library!HyperVPrivateCloud.VirtualMachineRuntime&quot;]/VMId$ AND (Property[@Name=&#39;AvailabilityState&#39;] = Good OR Property[@Name=&#39;AvailabilityState&#39;] = NotApplicable))

Warning [Warning]: (Property[@Name=&#39;VMId&#39;] = $Target/Property[Type=&quot;HCSV2Library!HyperVPrivateCloud.VirtualMachineRuntime&quot;]/VMId$ AND Property[@Name=&#39;AvailabilityState&#39;] = Warning)

Error [Critical]: (Property[@Name=&#39;VMId&#39;] = $Target/Property[Type=&quot;HCSV2Library!HyperVPrivateCloud.VirtualMachineRuntime&quot;]/VMId$ AND Property[@Name=&#39;AvailabilityState&#39;] = Critical)

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: CheckpointCriticalHours=336; CheckpointWarningHours=168; IntervalSeconds=300; PropertyName=AvailabilityState; SyncTime=; TimeoutSeconds=240; VMId=$Target/Property[Type=&quot;HCSV2Library!HyperVPrivateCloud.VirtualMachineRuntime&quot;]/VMId$ Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Error; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Run the matching read-only host/VM task. Match the stable VM ID and current owner, inspect Get-VM, attached disks, checkpoint chain and Hyper-V-VMMS/High-Availability logs. For management-service errors verify the named service and first failure rather than assuming every guest stopped.

### Corrective action and escalation

Restore the identified service, configuration, storage or VM dependency with the workload owner. Check intended shutdown and maintenance policy first. Never delete checkpoint files, force power operations or restart VMMS/hosts solely to clear an alert.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm the intended VM/service state, fresh host-derived evidence and the originating monitor. Guest application recovery requires a separate workload-level check.

### Probe-specific state reasons

Critical for any Hyper-V VM state ending in Critical, regardless of expected power policy. Otherwise Critical if expected Running but actual state is not Running; Good when expected Running and actual Running. Other power policies yield NotApplicable. The all-VM collector derives expected Running from AutomaticStartAction=Start, currently-running StartIfRunning, or an Online clustered role (and a running clustered VM when role lookup is unavailable). No native Warning branch. Verify storage and intended power policy before starting or resuming a VM.

Critical probe exceptions can also mark unevaluated facets Critical. Read PipelineStateDetail and the first exception before interpreting a facet as a confirmed workload outage. Successful collection is not evidence that every workload is healthy.

### Microsoft references

[Microsoft Learn: hyper v start state access failures clustered standalone](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-start-state-access-failures-clustered-standalone)

[Microsoft Learn: hyper v virtual machine backup checkpoint storage](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-virtual-machine-backup-checkpoint-storage)


## VM heartbeat integration service {#hypervprivatecloud.vmruntime.heartbeat.monitor}

`HyperVPrivateCloud.VmRuntime.Heartbeat.Monitor`

Tracks guest heartbeat while the VM is running.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.Fabric.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.Fabric.Service.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Service.Availability.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Availability.Members.Heartbeat.Availability.Dependency.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

Tracks guest heartbeat while the VM is running.

### Operator response

Check guest OS state, integration services, CPU scheduling, storage latency, and guest event logs.

### Support scope

Hyper-V host-to-guest integration channel evidence. No guest SCOM agent is required, and this signal does not prove application health inside the VM.

Element: HyperVPrivateCloud.VmRuntime.Heartbeat.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HCSV2Library!HyperVPrivateCloud.VirtualMachineRuntime. Parent health aspect: Health!System.Health.AvailabilityState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: (Property[@Name=&#39;VMId&#39;] = $Target/Property[Type=&quot;HCSV2Library!HyperVPrivateCloud.VirtualMachineRuntime&quot;]/VMId$ AND (Property[@Name=&#39;HeartbeatState&#39;] = Good OR Property[@Name=&#39;HeartbeatState&#39;] = NotApplicable))

Warning [Warning]: (Property[@Name=&#39;VMId&#39;] = $Target/Property[Type=&quot;HCSV2Library!HyperVPrivateCloud.VirtualMachineRuntime&quot;]/VMId$ AND Property[@Name=&#39;HeartbeatState&#39;] = Warning)

Error [Critical]: (Property[@Name=&#39;VMId&#39;] = $Target/Property[Type=&quot;HCSV2Library!HyperVPrivateCloud.VirtualMachineRuntime&quot;]/VMId$ AND Property[@Name=&#39;HeartbeatState&#39;] = Critical)

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: CheckpointCriticalHours=336; CheckpointWarningHours=168; IntervalSeconds=300; PropertyName=HeartbeatState; SyncTime=; TimeoutSeconds=240; VMId=$Target/Property[Type=&quot;HCSV2Library!HyperVPrivateCloud.VirtualMachineRuntime&quot;]/VMId$ Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Error; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

On the current VM owner inspect Get-VMIntegrationService for the exact VM and its expected power state. Distinguish a disabled integration service, unsupported guest, starting guest and an unresponsive running guest. Engage the guest owner for guest-side service/log checks.

### Corrective action and escalation

Correct integration-service policy or supported guest components with the workload owner. Do not restart a guest or install a SCOM agent to satisfy this host-based monitor without separate authorization.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm the configured integration service reports its expected status and host-side monitoring recovers; validate application service separately through its own owner.

### Probe-specific state reasons

For a running VM: Warning when no enabled Heartbeat integration service is returned; Good when its PrimaryStatusDescription matches OK; otherwise Critical. A non-running VM yields NotApplicable. Check guest integration support and actual guest responsiveness with its owner; this is not an application transaction check and does not require a guest SCOM agent.

Critical probe exceptions can also mark unevaluated facets Critical. Read PipelineStateDetail and the first exception before interpreting a facet as a confirmed workload outage. Successful collection is not evidence that every workload is healthy.

### Microsoft references

[Microsoft Learn: manage hyper v integration services](https://learn.microsoft.com/en-us/windows-server/virtualization/hyper-v/manage/manage-hyper-v-integration-services)


## VM integration services health {#hypervprivatecloud.vmruntime.integrationservices.monitor}

`HyperVPrivateCloud.VmRuntime.IntegrationServices.Monitor`

Tracks enabled Hyper-V integration-service status.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.Fabric.Configuration.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.Fabric.Service.Configuration.Dependency.Monitor &gt; HyperVPrivateCloud.Service.VirtualMachines.Configuration.Dependency.Monitor &gt; HyperVPrivateCloud.VirtualMachines.Members.Configuration.Dependency.Monitor &gt; HyperVPrivateCloud.VmRuntime.IntegrationServices.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

Tracks enabled Hyper-V integration-service status.

### Operator response

Review guest integration components, supported guest version, service status, and VM configuration.

### Support scope

Hyper-V host-to-guest integration channel evidence. No guest SCOM agent is required, and this signal does not prove application health inside the VM.

Element: HyperVPrivateCloud.VmRuntime.IntegrationServices.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HCSV2Library!HyperVPrivateCloud.VirtualMachineRuntime. Parent health aspect: Health!System.Health.ConfigurationState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: (Property[@Name=&#39;VMId&#39;] = $Target/Property[Type=&quot;HCSV2Library!HyperVPrivateCloud.VirtualMachineRuntime&quot;]/VMId$ AND (Property[@Name=&#39;IntegrationServicesState&#39;] = Good OR Property[@Name=&#39;IntegrationServicesState&#39;] = NotApplicable))

Warning [Warning]: (Property[@Name=&#39;VMId&#39;] = $Target/Property[Type=&quot;HCSV2Library!HyperVPrivateCloud.VirtualMachineRuntime&quot;]/VMId$ AND Property[@Name=&#39;IntegrationServicesState&#39;] = Warning)

Error [Critical]: (Property[@Name=&#39;VMId&#39;] = $Target/Property[Type=&quot;HCSV2Library!HyperVPrivateCloud.VirtualMachineRuntime&quot;]/VMId$ AND Property[@Name=&#39;IntegrationServicesState&#39;] = Critical)

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: CheckpointCriticalHours=336; CheckpointWarningHours=168; IntervalSeconds=300; PropertyName=IntegrationServicesState; SyncTime=; TimeoutSeconds=240; VMId=$Target/Property[Type=&quot;HCSV2Library!HyperVPrivateCloud.VirtualMachineRuntime&quot;]/VMId$ Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Warning; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

On the current VM owner inspect Get-VMIntegrationService for the exact VM and its expected power state. Distinguish a disabled integration service, unsupported guest, starting guest and an unresponsive running guest. Engage the guest owner for guest-side service/log checks.

### Corrective action and escalation

Correct integration-service policy or supported guest components with the workload owner. Do not restart a guest or install a SCOM agent to satisfy this host-based monitor without separate authorization.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm the configured integration service reports its expected status and host-side monitoring recovers; validate application service separately through its own owner.

### Probe-specific state reasons

For a running VM: Warning if any enabled integration service has a PrimaryStatusDescription that does not match OK; otherwise Good. Non-running VMs yield NotApplicable. No ordinary Critical status branch. Identify the individual enabled service and its guest prerequisites; zero returned services alone is not an exhaustive healthy guest test.

Critical probe exceptions can also mark unevaluated facets Critical. Read PipelineStateDetail and the first exception before interpreting a facet as a confirmed workload outage. Successful collection is not evidence that every workload is healthy.

### Microsoft references

[Microsoft Learn: manage hyper v integration services](https://learn.microsoft.com/en-us/windows-server/virtualization/hyper-v/manage/manage-hyper-v-integration-services)


## VM checkpoint age {#hypervprivatecloud.vmruntime.checkpoints.monitor}

`HyperVPrivateCloud.VmRuntime.Checkpoints.Monitor`

Tracks checkpoint count and oldest age for this VM.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.Fabric.Configuration.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.Fabric.Service.Configuration.Dependency.Monitor &gt; HyperVPrivateCloud.Service.VirtualMachines.Configuration.Dependency.Monitor &gt; HyperVPrivateCloud.VirtualMachines.Members.Configuration.Dependency.Monitor &gt; HyperVPrivateCloud.VmRuntime.Checkpoints.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

Tracks checkpoint count and oldest age for this VM.

### Operator response

Confirm backup activity and checkpoint purpose before merging or removing stale checkpoints.

### Support scope

Host-based Hyper-V workload or management evidence. A stopped VM must be compared with its intended state; inventory presence is not guest application monitoring.

Element: HyperVPrivateCloud.VmRuntime.Checkpoints.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HCSV2Library!HyperVPrivateCloud.VirtualMachineRuntime. Parent health aspect: Health!System.Health.ConfigurationState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: (Property[@Name=&#39;VMId&#39;] = $Target/Property[Type=&quot;HCSV2Library!HyperVPrivateCloud.VirtualMachineRuntime&quot;]/VMId$ AND (Property[@Name=&#39;CheckpointState&#39;] = Good OR Property[@Name=&#39;CheckpointState&#39;] = NotApplicable))

Warning [Warning]: (Property[@Name=&#39;VMId&#39;] = $Target/Property[Type=&quot;HCSV2Library!HyperVPrivateCloud.VirtualMachineRuntime&quot;]/VMId$ AND Property[@Name=&#39;CheckpointState&#39;] = Warning)

Error [Critical]: (Property[@Name=&#39;VMId&#39;] = $Target/Property[Type=&quot;HCSV2Library!HyperVPrivateCloud.VirtualMachineRuntime&quot;]/VMId$ AND Property[@Name=&#39;CheckpointState&#39;] = Critical)

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: CheckpointCriticalHours=336; CheckpointWarningHours=168; IntervalSeconds=300; PropertyName=CheckpointState; SyncTime=; TimeoutSeconds=240; VMId=$Target/Property[Type=&quot;HCSV2Library!HyperVPrivateCloud.VirtualMachineRuntime&quot;]/VMId$ Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Warning; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Run the matching read-only host/VM task. Match the stable VM ID and current owner, inspect Get-VM, attached disks, checkpoint chain and Hyper-V-VMMS/High-Availability logs. For management-service errors verify the named service and first failure rather than assuming every guest stopped.

### Corrective action and escalation

Restore the identified service, configuration, storage or VM dependency with the workload owner. Check intended shutdown and maintenance policy first. Never delete checkpoint files, force power operations or restart VMMS/hosts solely to clear an alert.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm the intended VM/service state, fresh host-derived evidence and the originating monitor. Guest application recovery requires a separate workload-level check.

### Probe-specific state reasons

Uses the oldest checkpoint for this VM, rounded to 0.1 hour. Critical at or above CheckpointCriticalHours; otherwise Warning at or above CheckpointWarningHours; otherwise Good. No checkpoints gives age zero. Correlate checkpoint age with approved backup/retention policy and storage headroom before supported cleanup.

Critical probe exceptions can also mark unevaluated facets Critical. Read PipelineStateDetail and the first exception before interpreting a facet as a confirmed workload outage. Successful collection is not evidence that every workload is healthy.

### Microsoft references

[Microsoft Learn: hyper v start state access failures clustered standalone](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-start-state-access-failures-clustered-standalone)

[Microsoft Learn: hyper v virtual machine backup checkpoint storage](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-virtual-machine-backup-checkpoint-storage)


## VM Replica relationship health {#hypervprivatecloud.vmruntime.replication.monitor}

`HyperVPrivateCloud.VmRuntime.Replication.Monitor`

Tracks Replica health for this VM.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.Fabric.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.Fabric.Service.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Service.Availability.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Availability.Members.Replication.Availability.Dependency.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

Tracks Replica health for this VM.

### Operator response

Inspect authentication, network reachability, storage, backlog, and replication events.

### Support scope

Host-observed replication state and disaster-recovery protection, not an application availability test inside the guest.

Element: HyperVPrivateCloud.VmRuntime.Replication.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HCSV2Library!HyperVPrivateCloud.VirtualMachineRuntime. Parent health aspect: Health!System.Health.AvailabilityState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: (Property[@Name=&#39;VMId&#39;] = $Target/Property[Type=&quot;HCSV2Library!HyperVPrivateCloud.VirtualMachineRuntime&quot;]/VMId$ AND (Property[@Name=&#39;ReplicationState&#39;] = Good OR Property[@Name=&#39;ReplicationState&#39;] = NotApplicable))

Warning [Warning]: (Property[@Name=&#39;VMId&#39;] = $Target/Property[Type=&quot;HCSV2Library!HyperVPrivateCloud.VirtualMachineRuntime&quot;]/VMId$ AND Property[@Name=&#39;ReplicationState&#39;] = Warning)

Error [Critical]: (Property[@Name=&#39;VMId&#39;] = $Target/Property[Type=&quot;HCSV2Library!HyperVPrivateCloud.VirtualMachineRuntime&quot;]/VMId$ AND Property[@Name=&#39;ReplicationState&#39;] = Critical)

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: CheckpointCriticalHours=336; CheckpointWarningHours=168; IntervalSeconds=300; PropertyName=ReplicationState; SyncTime=; TimeoutSeconds=240; VMId=$Target/Property[Type=&quot;HCSV2Library!HyperVPrivateCloud.VirtualMachineRuntime&quot;]/VMId$ Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Warning; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Use Get-VMReplication and Measure-VMReplication for the named VM on its owner. Inspect replication mode, primary/replica server, health, last replication time and backlog. For a cluster broker, follow network-name and broker resource dependencies. Distinguish planned pause, initial replication and unexpected loss of protection.

### Corrective action and escalation

Restore the actual authentication, certificate, broker, network or storage dependency. Coordinate resume or resynchronization with the recovery owner and verify bandwidth/storage impact. Never perform failover, reverse replication or remove/recreate protection solely to clear an alert.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm replication resumes and lag meets the agreed recovery-point objective. A healthy running primary VM alone does not establish healthy disaster recovery.

### Probe-specific state reasons

Critical if any returned relationship for this VM reports native Health=Critical; otherwise Warning if any reports Warning; Good for remaining returned relationships. No relationship yields NotApplicable, not protected. Confirm current replication direction, lag, last success and the recovery objective before approved repair.

Critical probe exceptions can also mark unevaluated facets Critical. Read PipelineStateDetail and the first exception before interpreting a facet as a confirmed workload outage. Successful collection is not evidence that every workload is healthy.

### Microsoft references

[Microsoft Learn: hyper v replica troubleshooting guide](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-replica-troubleshooting-guide)


## VM virtual disk availability {#hypervprivatecloud.vmruntime.storage.monitor}

`HyperVPrivateCloud.VmRuntime.Storage.Monitor`

Tracks availability and readability of attached VHD/VHDX files.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.Fabric.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.Fabric.Service.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Service.Storage.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Storage.Members.Availability.Dependency.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

Tracks availability and readability of attached VHD/VHDX files.

### Operator response

Validate the disk path, storage fabric, permissions, VHD chain, and merge or backup operations.

### Support scope

Host-based Hyper-V workload or management evidence. A stopped VM must be compared with its intended state; inventory presence is not guest application monitoring.

Element: HyperVPrivateCloud.VmRuntime.Storage.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HCSV2Library!HyperVPrivateCloud.VirtualMachineRuntime. Parent health aspect: Health!System.Health.AvailabilityState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: (Property[@Name=&#39;VMId&#39;] = $Target/Property[Type=&quot;HCSV2Library!HyperVPrivateCloud.VirtualMachineRuntime&quot;]/VMId$ AND (Property[@Name=&#39;StorageState&#39;] = Good OR Property[@Name=&#39;StorageState&#39;] = NotApplicable))

Warning [Warning]: (Property[@Name=&#39;VMId&#39;] = $Target/Property[Type=&quot;HCSV2Library!HyperVPrivateCloud.VirtualMachineRuntime&quot;]/VMId$ AND Property[@Name=&#39;StorageState&#39;] = Warning)

Error [Critical]: (Property[@Name=&#39;VMId&#39;] = $Target/Property[Type=&quot;HCSV2Library!HyperVPrivateCloud.VirtualMachineRuntime&quot;]/VMId$ AND Property[@Name=&#39;StorageState&#39;] = Critical)

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: CheckpointCriticalHours=336; CheckpointWarningHours=168; IntervalSeconds=300; PropertyName=StorageState; SyncTime=; TimeoutSeconds=240; VMId=$Target/Property[Type=&quot;HCSV2Library!HyperVPrivateCloud.VirtualMachineRuntime&quot;]/VMId$ Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Error; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Run the matching read-only host/VM task. Match the stable VM ID and current owner, inspect Get-VM, attached disks, checkpoint chain and Hyper-V-VMMS/High-Availability logs. For management-service errors verify the named service and first failure rather than assuming every guest stopped.

### Corrective action and escalation

Restore the identified service, configuration, storage or VM dependency with the workload owner. Check intended shutdown and maintenance policy first. Never delete checkpoint files, force power operations or restart VMMS/hosts solely to clear an alert.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm the intended VM/service state, fresh host-derived evidence and the originating monitor. Guest application recovery requires a separate workload-level check.

### Probe-specific state reasons

Critical when an enumerated disk with a path is missing as a leaf file or Get-VHD cannot read it; otherwise Good. No ordinary Warning branch. Check the named attachment, owner, path, storage availability and collector access; never recreate a disk or remove a checkpoint chain merely to clear this state.

Critical probe exceptions can also mark unevaluated facets Critical. Read PipelineStateDetail and the first exception before interpreting a facet as a confirmed workload outage. Successful collection is not evidence that every workload is healthy.

### Microsoft references

[Microsoft Learn: hyper v start state access failures clustered standalone](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-start-state-access-failures-clustered-standalone)

[Microsoft Learn: hyper v virtual machine backup checkpoint storage](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-virtual-machine-backup-checkpoint-storage)


## VM virtual network connectivity {#hypervprivatecloud.vmruntime.network.monitor}

`HyperVPrivateCloud.VmRuntime.Network.Monitor`

Tracks VM adapters that are disconnected or unhealthy.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.Fabric.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.Fabric.Service.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Service.Network.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Network.Members.Availability.Dependency.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

Tracks VM adapters that are disconnected or unhealthy.

### Operator response

Check vNIC status, vSwitch binding, VLAN policy, port ACLs, and physical uplinks.

### Support scope

Host network or external infrastructure evidence at the precise scope of the leaf. TCP reachability is not device hardware, firewall-policy or application health; linked vendor monitors retain their own authority.

Element: HyperVPrivateCloud.VmRuntime.Network.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HCSV2Library!HyperVPrivateCloud.VirtualMachineRuntime. Parent health aspect: Health!System.Health.AvailabilityState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: (Property[@Name=&#39;VMId&#39;] = $Target/Property[Type=&quot;HCSV2Library!HyperVPrivateCloud.VirtualMachineRuntime&quot;]/VMId$ AND (Property[@Name=&#39;NetworkState&#39;] = Good OR Property[@Name=&#39;NetworkState&#39;] = NotApplicable))

Warning [Warning]: (Property[@Name=&#39;VMId&#39;] = $Target/Property[Type=&quot;HCSV2Library!HyperVPrivateCloud.VirtualMachineRuntime&quot;]/VMId$ AND Property[@Name=&#39;NetworkState&#39;] = Warning)

Error [Critical]: (Property[@Name=&#39;VMId&#39;] = $Target/Property[Type=&quot;HCSV2Library!HyperVPrivateCloud.VirtualMachineRuntime&quot;]/VMId$ AND Property[@Name=&#39;NetworkState&#39;] = Critical)

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: CheckpointCriticalHours=336; CheckpointWarningHours=168; IntervalSeconds=300; PropertyName=NetworkState; SyncTime=; TimeoutSeconds=240; VMId=$Target/Property[Type=&quot;HCSV2Library!HyperVPrivateCloud.VirtualMachineRuntime&quot;]/VMId$ Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Warning; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Identify the adapter, switch, port or configured endpoint and the actual observation source. Compare link state, negotiated speed and error/discard deltas with device-side evidence. Check routing and the intended port from the collector. An unreachable management endpoint does not by itself prove the data plane failed.

### Corrective action and escalation

Restore the specific path, cable/optic, approved switch configuration or device service with the network/hardware owner. Consult the vendor for proprietary device faults. Do not disable security controls, bounce all uplinks or reboot management devices based only on a failed TCP probe.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Repeat the original path test and confirm relevant native/vendor health. For cumulative errors, observe new deltas; do not expect historic totals to disappear.

### Probe-specific state reasons

Warning when a VM adapter has no SwitchName or its status is outside Ok, Degraded and the empty string. Otherwise Good; no ordinary Critical status branch. This probe explicitly tolerates Degraded and does not test guest IP or application connectivity. Validate intended disconnection and the exact virtual-switch mapping before changing it.

Critical probe exceptions can also mark unevaluated facets Critical. Read PipelineStateDetail and the first exception before interpreting a facet as a confirmed workload outage. Successful collection is not evidence that every workload is healthy.

### Microsoft references

[Microsoft Learn: troubleshoot tcp ip communication guidance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/networking/troubleshoot-tcp-ip-communication-guidance)


## VM Dynamic Memory pressure {#hypervprivatecloud.vmruntime.memorypressure.monitor}

`HyperVPrivateCloud.VmRuntime.MemoryPressure.Monitor`

Tracks reported Dynamic Memory pressure for running VMs. Disabled by default: superseded by HyperVPrivateCloud.VmRuntime.MemoryPressureRatio.Monitor, which evaluates the same signal with thresholds that can be overridden without breaking probe cookdown. Enable this monitor only if you disable the superseding one.

### Summary

Tracks reported Dynamic Memory pressure for running VMs. Disabled by default: superseded by HyperVPrivateCloud.VmRuntime.MemoryPressureRatio.Monitor, which evaluates the same signal with thresholds that can be overridden without breaking probe cookdown. Enable this monitor only if you disable the superseding one.

### Operator response

Review assigned and demanded memory, host reserve, guest workload, and Dynamic Memory limits.

### Support scope

Measured resource pressure or I/O delay. A warning is an opportunity to investigate headroom; a threshold crossing alone does not identify the defective component or predict a failure time.

Element: HyperVPrivateCloud.VmRuntime.MemoryPressure.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HCSV2Library!HyperVPrivateCloud.VirtualMachineRuntime. Parent health aspect: Health!System.Health.PerformanceState. Enabled by default: false. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: (Property[@Name=&#39;VMId&#39;] = $Target/Property[Type=&quot;HCSV2Library!HyperVPrivateCloud.VirtualMachineRuntime&quot;]/VMId$ AND (Property[@Name=&#39;MemoryPressureState&#39;] = Good OR Property[@Name=&#39;MemoryPressureState&#39;] = NotApplicable))

Warning [Warning]: (Property[@Name=&#39;VMId&#39;] = $Target/Property[Type=&quot;HCSV2Library!HyperVPrivateCloud.VirtualMachineRuntime&quot;]/VMId$ AND Property[@Name=&#39;MemoryPressureState&#39;] = Warning)

Error [Critical]: (Property[@Name=&#39;VMId&#39;] = $Target/Property[Type=&quot;HCSV2Library!HyperVPrivateCloud.VirtualMachineRuntime&quot;]/VMId$ AND Property[@Name=&#39;MemoryPressureState&#39;] = Critical)

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: CheckpointCriticalHours=336; CheckpointWarningHours=168; IntervalSeconds=300; PropertyName=MemoryPressureState; SyncTime=; TimeoutSeconds=240; VMId=$Target/Property[Type=&quot;HCSV2Library!HyperVPrivateCloud.VirtualMachineRuntime&quot;]/VMId$ Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Warning; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Record the named counter, measured value, units, sampling interval and effective thresholds. Compare a representative time series with workload changes, host placement and storage/network evidence. Separate host/root/guest CPU and assigned/demanded memory. Missing counters are a telemetry problem, not zero utilization.

### Corrective action and escalation

Address the identified contention, workload placement or failing path with its owner. Capacity changes require a headroom and failover-reserve check. Do not blindly increase thresholds, reboot hosts or reduce VM resources to suppress symptoms.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Observe the same metric over a representative load period, confirm sustained recovery and verify workload response independently. Product defaults require site-specific review and are not Microsoft service-level guarantees.

### Probe-specific state reasons

Only applies to a running VM with DynamicMemoryEnabled. MemoryStatus matching Low or Warning yields Warning; otherwise matching Critical yields Critical; otherwise Good. Other VMs yield NotApplicable. Compare assigned memory, demand, maximum and host reserve before changing allocation; the numeric memory-pressure monitors provide separate capacity signals.

Critical probe exceptions can also mark unevaluated facets Critical. Read PipelineStateDetail and the first exception before interpreting a facet as a confirmed workload outage. Successful collection is not evidence that every workload is healthy.

### Microsoft references

[Microsoft Learn: troubleshoot hyper v virtual machine performance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/troubleshoot-hyper-v-virtual-machine-performance)


## VM monitoring pipeline health {#hypervprivatecloud.vmruntime.pipeline.monitor}

`HyperVPrivateCloud.VmRuntime.Pipeline.Monitor`

Tracks completion of the per-VM health probe.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.Fabric.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.Fabric.Service.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Service.VirtualMachines.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.VirtualMachines.Members.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.VmRuntime.Pipeline.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

Tracks completion of the per-VM health probe.

### Operator response

Review Operations Manager event 8202, VM ownership, module availability, permissions, and timeouts.

### Support scope

Monitoring capability, data collection or freshness. Failure means visibility is impaired; do not infer that the monitored workload itself is down or healthy.

Element: HyperVPrivateCloud.VmRuntime.Pipeline.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HCSV2Library!HyperVPrivateCloud.VirtualMachineRuntime. Parent health aspect: Health!System.Health.AvailabilityState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: (Property[@Name=&#39;VMId&#39;] = $Target/Property[Type=&quot;HCSV2Library!HyperVPrivateCloud.VirtualMachineRuntime&quot;]/VMId$ AND (Property[@Name=&#39;PipelineState&#39;] = Good OR Property[@Name=&#39;PipelineState&#39;] = NotApplicable))

Warning [Warning]: (Property[@Name=&#39;VMId&#39;] = $Target/Property[Type=&quot;HCSV2Library!HyperVPrivateCloud.VirtualMachineRuntime&quot;]/VMId$ AND Property[@Name=&#39;PipelineState&#39;] = Warning)

Error [Critical]: (Property[@Name=&#39;VMId&#39;] = $Target/Property[Type=&quot;HCSV2Library!HyperVPrivateCloud.VirtualMachineRuntime&quot;]/VMId$ AND Property[@Name=&#39;PipelineState&#39;] = Critical)

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: CheckpointCriticalHours=336; CheckpointWarningHours=168; IntervalSeconds=300; PropertyName=PipelineState; SyncTime=; TimeoutSeconds=240; VMId=$Target/Property[Type=&quot;HCSV2Library!HyperVPrivateCloud.VirtualMachineRuntime&quot;]/VMId$ Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Error; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Read the first probe error and Operations Manager event context. Verify HealthService availability, supported PowerShell runtime, required modules, Run As scope and agent proxy where cross-object discovery requires it. Compare last successful sample and discovery time.

### Corrective action and escalation

Correct the missing runtime/module, access or source defect. Preserve logs before any approved HealthService restart. Do not reset health or clear the agent cache as a substitute for understanding a repeatable script error.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Require a new successful discovery/sample and initialized leaf monitors. Old green values cannot establish recovery of a broken collector.

### Probe-specific state reasons

Good means VM evaluation completed, including a benign no-longer-local result during migration. Critical means collection failed; no native Warning branch. The departed VM is NotApplicable for workload facets and should be rediscovered on its new owner. Match stable VMId and current runtime ownership before treating an old runtime as a workload failure.

Critical probe exceptions can also mark unevaluated facets Critical. Read PipelineStateDetail and the first exception before interpreting a facet as a confirmed workload outage. Successful collection is not evidence that every workload is healthy.

### Microsoft references

[Microsoft Learn: manage consoles overview healthexplorer](https://learn.microsoft.com/en-us/system-center/scom/manage-consoles-overview-healthexplorer?view=sc-om-2025)


## Hyper-V host logical processor utilization {#hypervprivatecloud.host.logicalprocessorutilization.monitor}

`HyperVPrivateCloud.Host.LogicalProcessorUtilization.Monitor`

Tracks total hypervisor logical-processor run time across the whole host. Warning at 80 percent and Critical at 92 percent of total run time; both thresholds are overridable.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.Fabric.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.Fabric.Service.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Service.Compute.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Compute.Members.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Host.LogicalProcessorUtilization.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

Tracks total hypervisor logical-processor run time across the whole host. Warning at 80 percent and Critical at 92 percent of total run time; both thresholds are overridable.

### Operator response

Identify the heaviest virtual processors, review NUMA placement and virtual-processor to logical-processor ratio, check interrupt and DPC time, then rebalance or live migrate workload.

### Tuning

Override WarningThreshold and CriticalThreshold on this monitor to match the storage, network, and consolidation profile of the target environment. Override IntervalSeconds and TimeoutSeconds identically across every monitor and rule that shares this probe so that cookdown is preserved.

### Support scope

Measured resource pressure or I/O delay. A warning is an opportunity to investigate headroom; a threshold crossing alone does not identify the defective component or predict a failure time.

Element: HyperVPrivateCloud.Host.LogicalProcessorUtilization.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HCSV2Library!HyperVPrivateCloud.HostRole. Parent health aspect: Health!System.Health.PerformanceState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: Property[@Name=&#39;HypervisorLogicalProcessorPercent&#39;] &lt; 80

Warning [Warning]: (Property[@Name=&#39;HypervisorLogicalProcessorPercent&#39;] &gt;= 80 AND Property[@Name=&#39;HypervisorLogicalProcessorPercent&#39;] &lt; 92)

Error [Critical]: Property[@Name=&#39;HypervisorLogicalProcessorPercent&#39;] &gt;= 92

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: CriticalThreshold=92; IntervalSeconds=300; PropertyName=HypervisorLogicalProcessorPercent; SyncTime=; TimeoutSeconds=120; WarningThreshold=80 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Error; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Record the named counter, measured value, units, sampling interval and effective thresholds. Compare a representative time series with workload changes, host placement and storage/network evidence. Separate host/root/guest CPU and assigned/demanded memory. Missing counters are a telemetry problem, not zero utilization.

### Corrective action and escalation

Address the identified contention, workload placement or failing path with its owner. Capacity changes require a headroom and failover-reserve check. Do not blindly increase thresholds, reboot hosts or reduce VM resources to suppress symptoms.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Observe the same metric over a representative load period, confirm sustained recovery and verify workload response independently. Product defaults require site-specific review and are not Microsoft service-level guarantees.

### Microsoft references

[Microsoft Learn: troubleshoot hyper v virtual machine performance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/troubleshoot-hyper-v-virtual-machine-performance)


## Hyper-V root partition virtual processor utilization {#hypervprivatecloud.host.rootvirtualprocessorutilization.monitor}

`HyperVPrivateCloud.Host.RootVirtualProcessorUtilization.Monitor`

Tracks run time in the management partition, which serves guest storage and network I/O. Warning at 70 percent and Critical at 85 percent of total run time; both thresholds are overridable.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.Fabric.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.Fabric.Service.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Service.Compute.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Compute.Members.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Host.RootVirtualProcessorUtilization.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

Tracks run time in the management partition, which serves guest storage and network I/O. Warning at 70 percent and Critical at 85 percent of total run time; both thresholds are overridable.

### Operator response

Root partition saturation starves every guest. Review VMQ and RSS distribution, storage filter drivers, backup agents, and antivirus exclusions on the host.

### Tuning

Override WarningThreshold and CriticalThreshold on this monitor to match the storage, network, and consolidation profile of the target environment. Override IntervalSeconds and TimeoutSeconds identically across every monitor and rule that shares this probe so that cookdown is preserved.

### Support scope

Measured resource pressure or I/O delay. A warning is an opportunity to investigate headroom; a threshold crossing alone does not identify the defective component or predict a failure time.

Element: HyperVPrivateCloud.Host.RootVirtualProcessorUtilization.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HCSV2Library!HyperVPrivateCloud.HostRole. Parent health aspect: Health!System.Health.PerformanceState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: Property[@Name=&#39;RootVirtualProcessorPercent&#39;] &lt; 70

Warning [Warning]: (Property[@Name=&#39;RootVirtualProcessorPercent&#39;] &gt;= 70 AND Property[@Name=&#39;RootVirtualProcessorPercent&#39;] &lt; 85)

Error [Critical]: Property[@Name=&#39;RootVirtualProcessorPercent&#39;] &gt;= 85

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: CriticalThreshold=85; IntervalSeconds=300; PropertyName=RootVirtualProcessorPercent; SyncTime=; TimeoutSeconds=120; WarningThreshold=70 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Warning; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Record the named counter, measured value, units, sampling interval and effective thresholds. Compare a representative time series with workload changes, host placement and storage/network evidence. Separate host/root/guest CPU and assigned/demanded memory. Missing counters are a telemetry problem, not zero utilization.

### Corrective action and escalation

Address the identified contention, workload placement or failing path with its owner. Capacity changes require a headroom and failover-reserve check. Do not blindly increase thresholds, reboot hosts or reduce VM resources to suppress symptoms.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Observe the same metric over a representative load period, confirm sustained recovery and verify workload response independently. Product defaults require site-specific review and are not Microsoft service-level guarantees.

### Microsoft references

[Microsoft Learn: troubleshoot hyper v virtual machine performance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/troubleshoot-hyper-v-virtual-machine-performance)


## Hyper-V aggregate guest virtual processor utilization {#hypervprivatecloud.host.guestvirtualprocessorutilization.monitor}

`HyperVPrivateCloud.Host.GuestVirtualProcessorUtilization.Monitor`

Tracks aggregate run time across every guest virtual processor on the host. Warning at 85 percent and Critical at 95 percent of total run time; both thresholds are overridable.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.Fabric.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.Fabric.Service.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Service.Compute.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Compute.Members.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Host.GuestVirtualProcessorUtilization.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

Tracks aggregate run time across every guest virtual processor on the host. Warning at 85 percent and Critical at 95 percent of total run time; both thresholds are overridable.

### Operator response

Compare against logical-processor utilization to confirm compute oversubscription, then rebalance virtual processor counts or live migrate the heaviest VMs.

### Tuning

Override WarningThreshold and CriticalThreshold on this monitor to match the storage, network, and consolidation profile of the target environment. Override IntervalSeconds and TimeoutSeconds identically across every monitor and rule that shares this probe so that cookdown is preserved.

### Support scope

Measured resource pressure or I/O delay. A warning is an opportunity to investigate headroom; a threshold crossing alone does not identify the defective component or predict a failure time.

Element: HyperVPrivateCloud.Host.GuestVirtualProcessorUtilization.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HCSV2Library!HyperVPrivateCloud.HostRole. Parent health aspect: Health!System.Health.PerformanceState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: Property[@Name=&#39;GuestVirtualProcessorPercent&#39;] &lt; 85

Warning [Warning]: (Property[@Name=&#39;GuestVirtualProcessorPercent&#39;] &gt;= 85 AND Property[@Name=&#39;GuestVirtualProcessorPercent&#39;] &lt; 95)

Error [Critical]: Property[@Name=&#39;GuestVirtualProcessorPercent&#39;] &gt;= 95

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: CriticalThreshold=95; IntervalSeconds=300; PropertyName=GuestVirtualProcessorPercent; SyncTime=; TimeoutSeconds=120; WarningThreshold=85 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Warning; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Record the named counter, measured value, units, sampling interval and effective thresholds. Compare a representative time series with workload changes, host placement and storage/network evidence. Separate host/root/guest CPU and assigned/demanded memory. Missing counters are a telemetry problem, not zero utilization.

### Corrective action and escalation

Address the identified contention, workload placement or failing path with its owner. Capacity changes require a headroom and failover-reserve check. Do not blindly increase thresholds, reboot hosts or reduce VM resources to suppress symptoms.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Observe the same metric over a representative load period, confirm sustained recovery and verify workload response independently. Product defaults require site-specific review and are not Microsoft service-level guarantees.

### Microsoft references

[Microsoft Learn: troubleshoot hyper v virtual machine performance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/troubleshoot-hyper-v-virtual-machine-performance)


## Hyper-V host available memory (absolute) {#hypervprivatecloud.host.availablememory.monitor}

`HyperVPrivateCloud.Host.AvailableMemory.Monitor`

Tracks absolute physical memory available to the host. Warning at or below 8192 MB and Critical at or below 4096 MB; both thresholds are overridable and should be raised on hosts with large VMs.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.Fabric.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.Fabric.Service.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Service.Compute.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Compute.Members.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Host.AvailableMemory.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

Tracks absolute physical memory available to the host. Warning at or below 8192 MB and Critical at or below 4096 MB; both thresholds are overridable and should be raised on hosts with large VMs.

### Operator response

Review Dynamic Memory demand and buffers, host memory reserve, and startup memory of pending VMs. Free capacity by live migrating VMs before starting more.

### Tuning

Override WarningThreshold and CriticalThreshold on this monitor to match the storage, network, and consolidation profile of the target environment. Override IntervalSeconds and TimeoutSeconds identically across every monitor and rule that shares this probe so that cookdown is preserved.

### Support scope

Measured resource pressure or I/O delay. A warning is an opportunity to investigate headroom; a threshold crossing alone does not identify the defective component or predict a failure time.

Element: HyperVPrivateCloud.Host.AvailableMemory.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HCSV2Library!HyperVPrivateCloud.HostRole. Parent health aspect: Health!System.Health.PerformanceState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: (Property[@Name=&#39;AvailableMemoryMB&#39;] &gt; 8192 OR Property[@Name=&#39;AvailableMemoryMB&#39;] &lt; 0)

Warning [Warning]: (Property[@Name=&#39;AvailableMemoryMB&#39;] &gt;= 0 AND (Property[@Name=&#39;AvailableMemoryMB&#39;] &lt;= 8192 AND Property[@Name=&#39;AvailableMemoryMB&#39;] &gt; 4096))

Error [Critical]: (Property[@Name=&#39;AvailableMemoryMB&#39;] &gt;= 0 AND Property[@Name=&#39;AvailableMemoryMB&#39;] &lt;= 4096)

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: CriticalThreshold=4096; IntervalSeconds=300; PropertyName=AvailableMemoryMB; SyncTime=; TimeoutSeconds=120; WarningThreshold=8192 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Error; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Record the named counter, measured value, units, sampling interval and effective thresholds. Compare a representative time series with workload changes, host placement and storage/network evidence. Separate host/root/guest CPU and assigned/demanded memory. Missing counters are a telemetry problem, not zero utilization.

### Corrective action and escalation

Address the identified contention, workload placement or failing path with its owner. Capacity changes require a headroom and failover-reserve check. Do not blindly increase thresholds, reboot hosts or reduce VM resources to suppress symptoms.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Observe the same metric over a representative load period, confirm sustained recovery and verify workload response independently. Product defaults require site-specific review and are not Microsoft service-level guarantees.

### Microsoft references

[Microsoft Learn: troubleshoot hyper v virtual machine performance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/troubleshoot-hyper-v-virtual-machine-performance)


## Hyper-V host available memory (proportional) {#hypervprivatecloud.host.availablememorypercent.monitor}

`HyperVPrivateCloud.Host.AvailableMemoryPercent.Monitor`

Tracks physical memory available to the host as a percentage of installed memory, so the same policy scales across differently sized hosts. Warning at or below 15 percent and Critical at or below 8 percent; both thresholds are overridable.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.Fabric.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.Fabric.Service.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Service.Compute.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Compute.Members.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Host.AvailableMemoryPercent.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

Tracks physical memory available to the host as a percentage of installed memory, so the same policy scales across differently sized hosts. Warning at or below 15 percent and Critical at or below 8 percent; both thresholds are overridable.

### Operator response

Correlate with the absolute available-memory monitor. Review Dynamic Memory maximums, memory buffer percentage, and cluster failover reserve before adding workload.

### Tuning

Override WarningThreshold and CriticalThreshold on this monitor to match the storage, network, and consolidation profile of the target environment. Override IntervalSeconds and TimeoutSeconds identically across every monitor and rule that shares this probe so that cookdown is preserved.

### Support scope

Measured resource pressure or I/O delay. A warning is an opportunity to investigate headroom; a threshold crossing alone does not identify the defective component or predict a failure time.

Element: HyperVPrivateCloud.Host.AvailableMemoryPercent.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HCSV2Library!HyperVPrivateCloud.HostRole. Parent health aspect: Health!System.Health.PerformanceState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: (Property[@Name=&#39;AvailableMemoryPercent&#39;] &gt; 15 OR Property[@Name=&#39;AvailableMemoryPercent&#39;] &lt; 0)

Warning [Warning]: (Property[@Name=&#39;AvailableMemoryPercent&#39;] &gt;= 0 AND (Property[@Name=&#39;AvailableMemoryPercent&#39;] &lt;= 15 AND Property[@Name=&#39;AvailableMemoryPercent&#39;] &gt; 8))

Error [Critical]: (Property[@Name=&#39;AvailableMemoryPercent&#39;] &gt;= 0 AND Property[@Name=&#39;AvailableMemoryPercent&#39;] &lt;= 8)

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: CriticalThreshold=8; IntervalSeconds=300; PropertyName=AvailableMemoryPercent; SyncTime=; TimeoutSeconds=120; WarningThreshold=15 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Warning; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Record the named counter, measured value, units, sampling interval and effective thresholds. Compare a representative time series with workload changes, host placement and storage/network evidence. Separate host/root/guest CPU and assigned/demanded memory. Missing counters are a telemetry problem, not zero utilization.

### Corrective action and escalation

Address the identified contention, workload placement or failing path with its owner. Capacity changes require a headroom and failover-reserve check. Do not blindly increase thresholds, reboot hosts or reduce VM resources to suppress symptoms.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Observe the same metric over a representative load period, confirm sustained recovery and verify workload response independently. Product defaults require site-specific review and are not Microsoft service-level guarantees.

### Microsoft references

[Microsoft Learn: troubleshoot hyper v virtual machine performance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/troubleshoot-hyper-v-virtual-machine-performance)


## Hyper-V host memory paging pressure {#hypervprivatecloud.host.memorypagespressure.monitor}

`HyperVPrivateCloud.Host.MemoryPagesPressure.Monitor`

Tracks total hard page faults per second serviced from disk, the clearest evidence that the host is short of physical memory. Warning at 1000 pages per second and Critical at 5000; both thresholds are overridable.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.Fabric.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.Fabric.Service.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Service.Compute.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Compute.Members.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Host.MemoryPagesPressure.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

Tracks total hard page faults per second serviced from disk, the clearest evidence that the host is short of physical memory. Warning at 1000 pages per second and Critical at 5000; both thresholds are overridable.

### Operator response

Correlate with available memory and physical disk latency. Reduce Dynamic Memory maximums, move VMs off the host, or add physical memory.

### Tuning

Override WarningThreshold and CriticalThreshold on this monitor to match the storage, network, and consolidation profile of the target environment. Override IntervalSeconds and TimeoutSeconds identically across every monitor and rule that shares this probe so that cookdown is preserved.

### Support scope

Measured resource pressure or I/O delay. A warning is an opportunity to investigate headroom; a threshold crossing alone does not identify the defective component or predict a failure time.

Element: HyperVPrivateCloud.Host.MemoryPagesPressure.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HCSV2Library!HyperVPrivateCloud.HostRole. Parent health aspect: Health!System.Health.PerformanceState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: Property[@Name=&#39;MemoryPagesPerSecond&#39;] &lt; 1000

Warning [Warning]: (Property[@Name=&#39;MemoryPagesPerSecond&#39;] &gt;= 1000 AND Property[@Name=&#39;MemoryPagesPerSecond&#39;] &lt; 5000)

Error [Critical]: Property[@Name=&#39;MemoryPagesPerSecond&#39;] &gt;= 5000

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: CriticalThreshold=5000; IntervalSeconds=300; PropertyName=MemoryPagesPerSecond; SyncTime=; TimeoutSeconds=120; WarningThreshold=1000 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Warning; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Record the named counter, measured value, units, sampling interval and effective thresholds. Compare a representative time series with workload changes, host placement and storage/network evidence. Separate host/root/guest CPU and assigned/demanded memory. Missing counters are a telemetry problem, not zero utilization.

### Corrective action and escalation

Address the identified contention, workload placement or failing path with its owner. Capacity changes require a headroom and failover-reserve check. Do not blindly increase thresholds, reboot hosts or reduce VM resources to suppress symptoms.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Observe the same metric over a representative load period, confirm sustained recovery and verify workload response independently. Product defaults require site-specific review and are not Microsoft service-level guarantees.

### Microsoft references

[Microsoft Learn: troubleshoot hyper v virtual machine performance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/troubleshoot-hyper-v-virtual-machine-performance)


## Hyper-V host physical disk read latency {#hypervprivatecloud.host.physicaldiskreadlatency.monitor}

`HyperVPrivateCloud.Host.PhysicalDiskReadLatency.Monitor`

Tracks the worst average read latency in milliseconds across every physical disk on the host, excluding the _Total instance. Warning at 25 ms and Critical at 50 ms; both thresholds are overridable and should be lowered on all-flash storage.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.Fabric.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.Fabric.Service.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Service.Compute.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Compute.Members.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Host.PhysicalDiskReadLatency.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

Tracks the worst average read latency in milliseconds across every physical disk on the host, excluding the _Total instance. Warning at 25 ms and Critical at 50 ms; both thresholds are overridable and should be lowered on all-flash storage.

### Operator response

Identify the slow disk or LUN, review queue depth, MPIO policy, storage fabric health, cache state, and firmware, then rebalance the VMs using that storage.

### Tuning

Override WarningThreshold and CriticalThreshold on this monitor to match the storage, network, and consolidation profile of the target environment. Override IntervalSeconds and TimeoutSeconds identically across every monitor and rule that shares this probe so that cookdown is preserved.

### Support scope

Measured resource pressure or I/O delay. A warning is an opportunity to investigate headroom; a threshold crossing alone does not identify the defective component or predict a failure time.

Element: HyperVPrivateCloud.Host.PhysicalDiskReadLatency.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HCSV2Library!HyperVPrivateCloud.HostRole. Parent health aspect: Health!System.Health.PerformanceState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: Property[@Name=&#39;PhysicalDiskReadLatencyMs&#39;] &lt; 25

Warning [Warning]: (Property[@Name=&#39;PhysicalDiskReadLatencyMs&#39;] &gt;= 25 AND Property[@Name=&#39;PhysicalDiskReadLatencyMs&#39;] &lt; 50)

Error [Critical]: Property[@Name=&#39;PhysicalDiskReadLatencyMs&#39;] &gt;= 50

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: CriticalThreshold=50; IntervalSeconds=300; PropertyName=PhysicalDiskReadLatencyMs; SyncTime=; TimeoutSeconds=120; WarningThreshold=25 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Error; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Record the named counter, measured value, units, sampling interval and effective thresholds. Compare a representative time series with workload changes, host placement and storage/network evidence. Separate host/root/guest CPU and assigned/demanded memory. Missing counters are a telemetry problem, not zero utilization.

### Corrective action and escalation

Address the identified contention, workload placement or failing path with its owner. Capacity changes require a headroom and failover-reserve check. Do not blindly increase thresholds, reboot hosts or reduce VM resources to suppress symptoms.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Observe the same metric over a representative load period, confirm sustained recovery and verify workload response independently. Product defaults require site-specific review and are not Microsoft service-level guarantees.

### Microsoft references

[Microsoft Learn: troubleshoot hyper v virtual machine performance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/troubleshoot-hyper-v-virtual-machine-performance)


## Hyper-V host physical disk write latency {#hypervprivatecloud.host.physicaldiskwritelatency.monitor}

`HyperVPrivateCloud.Host.PhysicalDiskWriteLatency.Monitor`

Tracks the worst average write latency in milliseconds across every physical disk on the host, excluding the _Total instance. Warning at 25 ms and Critical at 50 ms; both thresholds are overridable and should be lowered on all-flash storage.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.Fabric.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.Fabric.Service.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Service.Compute.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Compute.Members.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Host.PhysicalDiskWriteLatency.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

Tracks the worst average write latency in milliseconds across every physical disk on the host, excluding the _Total instance. Warning at 25 ms and Critical at 50 ms; both thresholds are overridable and should be lowered on all-flash storage.

### Operator response

Identify the slow disk or LUN, review write-cache and battery state, MPIO policy, storage fabric health, and any active VHDX merge or backup operation.

### Tuning

Override WarningThreshold and CriticalThreshold on this monitor to match the storage, network, and consolidation profile of the target environment. Override IntervalSeconds and TimeoutSeconds identically across every monitor and rule that shares this probe so that cookdown is preserved.

### Support scope

Measured resource pressure or I/O delay. A warning is an opportunity to investigate headroom; a threshold crossing alone does not identify the defective component or predict a failure time.

Element: HyperVPrivateCloud.Host.PhysicalDiskWriteLatency.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HCSV2Library!HyperVPrivateCloud.HostRole. Parent health aspect: Health!System.Health.PerformanceState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: Property[@Name=&#39;PhysicalDiskWriteLatencyMs&#39;] &lt; 25

Warning [Warning]: (Property[@Name=&#39;PhysicalDiskWriteLatencyMs&#39;] &gt;= 25 AND Property[@Name=&#39;PhysicalDiskWriteLatencyMs&#39;] &lt; 50)

Error [Critical]: Property[@Name=&#39;PhysicalDiskWriteLatencyMs&#39;] &gt;= 50

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: CriticalThreshold=50; IntervalSeconds=300; PropertyName=PhysicalDiskWriteLatencyMs; SyncTime=; TimeoutSeconds=120; WarningThreshold=25 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Error; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Record the named counter, measured value, units, sampling interval and effective thresholds. Compare a representative time series with workload changes, host placement and storage/network evidence. Separate host/root/guest CPU and assigned/demanded memory. Missing counters are a telemetry problem, not zero utilization.

### Corrective action and escalation

Address the identified contention, workload placement or failing path with its owner. Capacity changes require a headroom and failover-reserve check. Do not blindly increase thresholds, reboot hosts or reduce VM resources to suppress symptoms.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Observe the same metric over a representative load period, confirm sustained recovery and verify workload response independently. Product defaults require site-specific review and are not Microsoft service-level guarantees.

### Microsoft references

[Microsoft Learn: troubleshoot hyper v virtual machine performance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/troubleshoot-hyper-v-virtual-machine-performance)


## Hyper-V host physical disk queue depth {#hypervprivatecloud.host.physicaldiskqueuedepth.monitor}

`HyperVPrivateCloud.Host.PhysicalDiskQueueDepth.Monitor`

Tracks the worst current disk queue length across every physical disk on the host, excluding the _Total instance. Warning at 8 outstanding requests and Critical at 20; both thresholds are overridable and should scale with the number of spindles or the array queue depth.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.Fabric.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.Fabric.Service.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Service.Compute.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Compute.Members.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Host.PhysicalDiskQueueDepth.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

Tracks the worst current disk queue length across every physical disk on the host, excluding the _Total instance. Warning at 8 outstanding requests and Critical at 20; both thresholds are overridable and should scale with the number of spindles or the array queue depth.

### Operator response

Sustained queue depth with high latency indicates a saturated storage path. Review IOPS demand per VM, storage QoS policy, and the number of VMs sharing the volume.

### Tuning

Override WarningThreshold and CriticalThreshold on this monitor to match the storage, network, and consolidation profile of the target environment. Override IntervalSeconds and TimeoutSeconds identically across every monitor and rule that shares this probe so that cookdown is preserved.

### Support scope

Measured resource pressure or I/O delay. A warning is an opportunity to investigate headroom; a threshold crossing alone does not identify the defective component or predict a failure time.

Element: HyperVPrivateCloud.Host.PhysicalDiskQueueDepth.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HCSV2Library!HyperVPrivateCloud.HostRole. Parent health aspect: Health!System.Health.PerformanceState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: Property[@Name=&#39;PhysicalDiskQueueLength&#39;] &lt; 8

Warning [Warning]: (Property[@Name=&#39;PhysicalDiskQueueLength&#39;] &gt;= 8 AND Property[@Name=&#39;PhysicalDiskQueueLength&#39;] &lt; 20)

Error [Critical]: Property[@Name=&#39;PhysicalDiskQueueLength&#39;] &gt;= 20

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: CriticalThreshold=20; IntervalSeconds=300; PropertyName=PhysicalDiskQueueLength; SyncTime=; TimeoutSeconds=120; WarningThreshold=8 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Warning; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Record the named counter, measured value, units, sampling interval and effective thresholds. Compare a representative time series with workload changes, host placement and storage/network evidence. Separate host/root/guest CPU and assigned/demanded memory. Missing counters are a telemetry problem, not zero utilization.

### Corrective action and escalation

Address the identified contention, workload placement or failing path with its owner. Capacity changes require a headroom and failover-reserve check. Do not blindly increase thresholds, reboot hosts or reduce VM resources to suppress symptoms.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Observe the same metric over a representative load period, confirm sustained recovery and verify workload response independently. Product defaults require site-specific review and are not Microsoft service-level guarantees.

### Microsoft references

[Microsoft Learn: troubleshoot hyper v virtual machine performance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/troubleshoot-hyper-v-virtual-machine-performance)


## Hyper-V host network interface utilization {#hypervprivatecloud.host.networkutilization.monitor}

`HyperVPrivateCloud.Host.NetworkUtilization.Monitor`

Tracks the worst physical network interface utilization on the host, calculated from bytes per second against the negotiated link speed. Warning at 70 percent and Critical at 90 percent of link capacity; both thresholds are overridable.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.Fabric.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.Fabric.Service.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Service.Compute.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Compute.Members.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Host.NetworkUtilization.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

Tracks the worst physical network interface utilization on the host, calculated from bytes per second against the negotiated link speed. Warning at 70 percent and Critical at 90 percent of link capacity; both thresholds are overridable.

### Operator response

Identify the saturated adapter, confirm the negotiated link speed is correct, review SET team load distribution, live migration bandwidth limits, and per-VM bandwidth policy.

### Tuning

Override WarningThreshold and CriticalThreshold on this monitor to match the storage, network, and consolidation profile of the target environment. Override IntervalSeconds and TimeoutSeconds identically across every monitor and rule that shares this probe so that cookdown is preserved.

### Support scope

Measured resource pressure or I/O delay. A warning is an opportunity to investigate headroom; a threshold crossing alone does not identify the defective component or predict a failure time.

Element: HyperVPrivateCloud.Host.NetworkUtilization.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HCSV2Library!HyperVPrivateCloud.HostRole. Parent health aspect: Health!System.Health.PerformanceState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: Property[@Name=&#39;NetworkUtilizationPercent&#39;] &lt; 70

Warning [Warning]: (Property[@Name=&#39;NetworkUtilizationPercent&#39;] &gt;= 70 AND Property[@Name=&#39;NetworkUtilizationPercent&#39;] &lt; 90)

Error [Critical]: Property[@Name=&#39;NetworkUtilizationPercent&#39;] &gt;= 90

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: CriticalThreshold=90; IntervalSeconds=300; PropertyName=NetworkUtilizationPercent; SyncTime=; TimeoutSeconds=120; WarningThreshold=70 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Warning; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Record the named counter, measured value, units, sampling interval and effective thresholds. Compare a representative time series with workload changes, host placement and storage/network evidence. Separate host/root/guest CPU and assigned/demanded memory. Missing counters are a telemetry problem, not zero utilization.

### Corrective action and escalation

Address the identified contention, workload placement or failing path with its owner. Capacity changes require a headroom and failover-reserve check. Do not blindly increase thresholds, reboot hosts or reduce VM resources to suppress symptoms.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Observe the same metric over a representative load period, confirm sustained recovery and verify workload response independently. Product defaults require site-specific review and are not Microsoft service-level guarantees.

### Microsoft references

[Microsoft Learn: troubleshoot hyper v virtual machine performance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/troubleshoot-hyper-v-virtual-machine-performance)


## Hyper-V host network interface errors {#hypervprivatecloud.host.networkerrors.monitor}

`HyperVPrivateCloud.Host.NetworkErrors.Monitor`

Tracks the worst combined inbound and outbound packet error rate per second across the host physical adapters, sampled as a one-second delta. Warning at 1 error per second and Critical at 10; both thresholds are overridable.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.Fabric.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.Fabric.Service.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Service.Compute.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Compute.Members.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Host.NetworkErrors.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

Tracks the worst combined inbound and outbound packet error rate per second across the host physical adapters, sampled as a one-second delta. Warning at 1 error per second and Critical at 10; both thresholds are overridable.

### Operator response

Physical-layer errors corrupt guest traffic. Check cabling and transceivers, switch port counters, duplex and MTU consistency, driver and firmware versions, and offload settings.

### Tuning

Override WarningThreshold and CriticalThreshold on this monitor to match the storage, network, and consolidation profile of the target environment. Override IntervalSeconds and TimeoutSeconds identically across every monitor and rule that shares this probe so that cookdown is preserved.

### Support scope

Measured resource pressure or I/O delay. A warning is an opportunity to investigate headroom; a threshold crossing alone does not identify the defective component or predict a failure time.

Element: HyperVPrivateCloud.Host.NetworkErrors.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HCSV2Library!HyperVPrivateCloud.HostRole. Parent health aspect: Health!System.Health.PerformanceState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: Property[@Name=&#39;NetworkErrorsPerSecond&#39;] &lt; 1

Warning [Warning]: (Property[@Name=&#39;NetworkErrorsPerSecond&#39;] &gt;= 1 AND Property[@Name=&#39;NetworkErrorsPerSecond&#39;] &lt; 10)

Error [Critical]: Property[@Name=&#39;NetworkErrorsPerSecond&#39;] &gt;= 10

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: CriticalThreshold=10; IntervalSeconds=300; PropertyName=NetworkErrorsPerSecond; SyncTime=; TimeoutSeconds=120; WarningThreshold=1 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Error; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Record the named counter, measured value, units, sampling interval and effective thresholds. Compare a representative time series with workload changes, host placement and storage/network evidence. Separate host/root/guest CPU and assigned/demanded memory. Missing counters are a telemetry problem, not zero utilization.

### Corrective action and escalation

Address the identified contention, workload placement or failing path with its owner. Capacity changes require a headroom and failover-reserve check. Do not blindly increase thresholds, reboot hosts or reduce VM resources to suppress symptoms.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Observe the same metric over a representative load period, confirm sustained recovery and verify workload response independently. Product defaults require site-specific review and are not Microsoft service-level guarantees.

### Microsoft references

[Microsoft Learn: troubleshoot hyper v virtual machine performance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/troubleshoot-hyper-v-virtual-machine-performance)


## VM virtual processor saturation {#hypervprivatecloud.vmruntime.virtualprocessorsaturation.monitor}

`HyperVPrivateCloud.VmRuntime.VirtualProcessorSaturation.Monitor`

Tracks the average run time across all virtual processors assigned to this VM, which is the compute the VM is drawing from the host. Warning at 85 percent and Critical at 95 percent; both thresholds are overridable.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.Fabric.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.Fabric.Service.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Service.VirtualMachines.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.VirtualMachines.Members.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.VmRuntime.VirtualProcessorSaturation.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

Tracks the average run time across all virtual processors assigned to this VM, which is the compute the VM is drawing from the host. Warning at 85 percent and Critical at 95 percent; both thresholds are overridable.

### Operator response

Sustained saturation means the VM is undersized or the host is oversubscribed. Add virtual processors, raise the VM reserve, or move the VM to a less contended host. Guest workload internals are out of scope for this pack.

### Tuning

Override WarningThreshold and CriticalThreshold on this monitor to match the storage, network, and consolidation profile of the target environment. Override IntervalSeconds and TimeoutSeconds identically across every monitor and rule that shares this probe so that cookdown is preserved.

### Support scope

Measured resource pressure or I/O delay. A warning is an opportunity to investigate headroom; a threshold crossing alone does not identify the defective component or predict a failure time.

Element: HyperVPrivateCloud.VmRuntime.VirtualProcessorSaturation.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HCSV2Library!HyperVPrivateCloud.VirtualMachineRuntime. Parent health aspect: Health!System.Health.PerformanceState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: (Property[@Name=&#39;VMId&#39;] = $Target/Property[Type=&quot;HCSV2Library!HyperVPrivateCloud.VirtualMachineRuntime&quot;]/VMId$ AND Property[@Name=&#39;VirtualProcessorTotalRunTimePercent&#39;] &lt; 85)

Warning [Warning]: (Property[@Name=&#39;VMId&#39;] = $Target/Property[Type=&quot;HCSV2Library!HyperVPrivateCloud.VirtualMachineRuntime&quot;]/VMId$ AND (Property[@Name=&#39;VirtualProcessorTotalRunTimePercent&#39;] &gt;= 85 AND Property[@Name=&#39;VirtualProcessorTotalRunTimePercent&#39;] &lt; 95))

Error [Critical]: (Property[@Name=&#39;VMId&#39;] = $Target/Property[Type=&quot;HCSV2Library!HyperVPrivateCloud.VirtualMachineRuntime&quot;]/VMId$ AND Property[@Name=&#39;VirtualProcessorTotalRunTimePercent&#39;] &gt;= 95)

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: CheckpointCriticalHours=336; CheckpointWarningHours=168; CriticalThreshold=95; IntervalSeconds=300; PropertyName=VirtualProcessorTotalRunTimePercent; SyncTime=; TimeoutSeconds=240; VMId=$Target/Property[Type=&quot;HCSV2Library!HyperVPrivateCloud.VirtualMachineRuntime&quot;]/VMId$; WarningThreshold=85 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Warning; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Record the named counter, measured value, units, sampling interval and effective thresholds. Compare a representative time series with workload changes, host placement and storage/network evidence. Separate host/root/guest CPU and assigned/demanded memory. Missing counters are a telemetry problem, not zero utilization.

### Corrective action and escalation

Address the identified contention, workload placement or failing path with its owner. Capacity changes require a headroom and failover-reserve check. Do not blindly increase thresholds, reboot hosts or reduce VM resources to suppress symptoms.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Observe the same metric over a representative load period, confirm sustained recovery and verify workload response independently. Product defaults require site-specific review and are not Microsoft service-level guarantees.

### Microsoft references

[Microsoft Learn: troubleshoot hyper v virtual machine performance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/troubleshoot-hyper-v-virtual-machine-performance)


## VM virtual processor peak saturation {#hypervprivatecloud.vmruntime.virtualprocessorpeaksaturation.monitor}

`HyperVPrivateCloud.VmRuntime.VirtualProcessorPeakSaturation.Monitor`

Tracks the busiest single virtual processor of this VM, which exposes single-threaded bottlenecks that the average hides. Warning at 90 percent and Critical at 98 percent; both thresholds are overridable.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.Fabric.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.Fabric.Service.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Service.VirtualMachines.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.VirtualMachines.Members.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.VmRuntime.VirtualProcessorPeakSaturation.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

Tracks the busiest single virtual processor of this VM, which exposes single-threaded bottlenecks that the average hides. Warning at 90 percent and Critical at 98 percent; both thresholds are overridable.

### Operator response

One pinned virtual processor while others idle indicates a single-threaded bottleneck. Adding virtual processors will not help; review virtual processor reserve, weight, and NUMA topology.

### Tuning

Override WarningThreshold and CriticalThreshold on this monitor to match the storage, network, and consolidation profile of the target environment. Override IntervalSeconds and TimeoutSeconds identically across every monitor and rule that shares this probe so that cookdown is preserved.

### Support scope

Measured resource pressure or I/O delay. A warning is an opportunity to investigate headroom; a threshold crossing alone does not identify the defective component or predict a failure time.

Element: HyperVPrivateCloud.VmRuntime.VirtualProcessorPeakSaturation.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HCSV2Library!HyperVPrivateCloud.VirtualMachineRuntime. Parent health aspect: Health!System.Health.PerformanceState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: (Property[@Name=&#39;VMId&#39;] = $Target/Property[Type=&quot;HCSV2Library!HyperVPrivateCloud.VirtualMachineRuntime&quot;]/VMId$ AND Property[@Name=&#39;VirtualProcessorPeakRunTimePercent&#39;] &lt; 90)

Warning [Warning]: (Property[@Name=&#39;VMId&#39;] = $Target/Property[Type=&quot;HCSV2Library!HyperVPrivateCloud.VirtualMachineRuntime&quot;]/VMId$ AND (Property[@Name=&#39;VirtualProcessorPeakRunTimePercent&#39;] &gt;= 90 AND Property[@Name=&#39;VirtualProcessorPeakRunTimePercent&#39;] &lt; 98))

Error [Critical]: (Property[@Name=&#39;VMId&#39;] = $Target/Property[Type=&quot;HCSV2Library!HyperVPrivateCloud.VirtualMachineRuntime&quot;]/VMId$ AND Property[@Name=&#39;VirtualProcessorPeakRunTimePercent&#39;] &gt;= 98)

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: CheckpointCriticalHours=336; CheckpointWarningHours=168; CriticalThreshold=98; IntervalSeconds=300; PropertyName=VirtualProcessorPeakRunTimePercent; SyncTime=; TimeoutSeconds=240; VMId=$Target/Property[Type=&quot;HCSV2Library!HyperVPrivateCloud.VirtualMachineRuntime&quot;]/VMId$; WarningThreshold=90 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Warning; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Record the named counter, measured value, units, sampling interval and effective thresholds. Compare a representative time series with workload changes, host placement and storage/network evidence. Separate host/root/guest CPU and assigned/demanded memory. Missing counters are a telemetry problem, not zero utilization.

### Corrective action and escalation

Address the identified contention, workload placement or failing path with its owner. Capacity changes require a headroom and failover-reserve check. Do not blindly increase thresholds, reboot hosts or reduce VM resources to suppress symptoms.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Observe the same metric over a representative load period, confirm sustained recovery and verify workload response independently. Product defaults require site-specific review and are not Microsoft service-level guarantees.

### Microsoft references

[Microsoft Learn: troubleshoot hyper v virtual machine performance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/troubleshoot-hyper-v-virtual-machine-performance)


## VM memory pressure {#hypervprivatecloud.vmruntime.memorypressureratio.monitor}

`HyperVPrivateCloud.VmRuntime.MemoryPressureRatio.Monitor`

Tracks Hyper-V memory pressure for this VM, the ratio of memory demanded by the guest to memory currently assigned by the host. Warning at 90 percent and Critical at 100 percent, where demand has met or exceeded assigned memory; both thresholds are overridable.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.Fabric.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.Fabric.Service.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Service.VirtualMachines.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.VirtualMachines.Members.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.VmRuntime.MemoryPressureRatio.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

Tracks Hyper-V memory pressure for this VM, the ratio of memory demanded by the guest to memory currently assigned by the host. Warning at 90 percent and Critical at 100 percent, where demand has met or exceeded assigned memory; both thresholds are overridable.

### Operator response

Pressure at or above 100 percent means the guest wants more memory than it holds. Raise the Dynamic Memory maximum, increase the memory buffer, or free host memory. Not applicable while the VM is stopped.

### Tuning

Override WarningThreshold and CriticalThreshold on this monitor to match the storage, network, and consolidation profile of the target environment. Override IntervalSeconds and TimeoutSeconds identically across every monitor and rule that shares this probe so that cookdown is preserved.

### Support scope

Measured resource pressure or I/O delay. A warning is an opportunity to investigate headroom; a threshold crossing alone does not identify the defective component or predict a failure time.

Element: HyperVPrivateCloud.VmRuntime.MemoryPressureRatio.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HCSV2Library!HyperVPrivateCloud.VirtualMachineRuntime. Parent health aspect: Health!System.Health.PerformanceState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: (Property[@Name=&#39;VMId&#39;] = $Target/Property[Type=&quot;HCSV2Library!HyperVPrivateCloud.VirtualMachineRuntime&quot;]/VMId$ AND Property[@Name=&#39;MemoryPressurePercent&#39;] &lt; 90)

Warning [Warning]: (Property[@Name=&#39;VMId&#39;] = $Target/Property[Type=&quot;HCSV2Library!HyperVPrivateCloud.VirtualMachineRuntime&quot;]/VMId$ AND (Property[@Name=&#39;MemoryPressurePercent&#39;] &gt;= 90 AND Property[@Name=&#39;MemoryPressurePercent&#39;] &lt; 100))

Error [Critical]: (Property[@Name=&#39;VMId&#39;] = $Target/Property[Type=&quot;HCSV2Library!HyperVPrivateCloud.VirtualMachineRuntime&quot;]/VMId$ AND Property[@Name=&#39;MemoryPressurePercent&#39;] &gt;= 100)

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: CheckpointCriticalHours=336; CheckpointWarningHours=168; CriticalThreshold=100; IntervalSeconds=300; PropertyName=MemoryPressurePercent; SyncTime=; TimeoutSeconds=240; VMId=$Target/Property[Type=&quot;HCSV2Library!HyperVPrivateCloud.VirtualMachineRuntime&quot;]/VMId$; WarningThreshold=90 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Error; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Record the named counter, measured value, units, sampling interval and effective thresholds. Compare a representative time series with workload changes, host placement and storage/network evidence. Separate host/root/guest CPU and assigned/demanded memory. Missing counters are a telemetry problem, not zero utilization.

### Corrective action and escalation

Address the identified contention, workload placement or failing path with its owner. Capacity changes require a headroom and failover-reserve check. Do not blindly increase thresholds, reboot hosts or reduce VM resources to suppress symptoms.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Observe the same metric over a representative load period, confirm sustained recovery and verify workload response independently. Product defaults require site-specific review and are not Microsoft service-level guarantees.

### Microsoft references

[Microsoft Learn: troubleshoot hyper v virtual machine performance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/troubleshoot-hyper-v-virtual-machine-performance)


## VM memory demand headroom {#hypervprivatecloud.vmruntime.memorydemandheadroom.monitor}

`HyperVPrivateCloud.VmRuntime.MemoryDemandHeadroom.Monitor`

Tracks guest memory demand as a percentage of the configured Dynamic Memory maximum, giving early warning before the VM hits its ceiling. Warning at 85 percent and Critical at 95 percent of maximum memory; both thresholds are overridable.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.Fabric.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.Fabric.Service.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Service.VirtualMachines.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.VirtualMachines.Members.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.VmRuntime.MemoryDemandHeadroom.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

Tracks guest memory demand as a percentage of the configured Dynamic Memory maximum, giving early warning before the VM hits its ceiling. Warning at 85 percent and Critical at 95 percent of maximum memory; both thresholds are overridable.

### Operator response

The VM is approaching its configured memory ceiling. Raise the Dynamic Memory maximum for the VM and confirm the host has capacity to honour it.

### Tuning

Override WarningThreshold and CriticalThreshold on this monitor to match the storage, network, and consolidation profile of the target environment. Override IntervalSeconds and TimeoutSeconds identically across every monitor and rule that shares this probe so that cookdown is preserved.

### Support scope

Measured resource pressure or I/O delay. A warning is an opportunity to investigate headroom; a threshold crossing alone does not identify the defective component or predict a failure time.

Element: HyperVPrivateCloud.VmRuntime.MemoryDemandHeadroom.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HCSV2Library!HyperVPrivateCloud.VirtualMachineRuntime. Parent health aspect: Health!System.Health.PerformanceState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: (Property[@Name=&#39;VMId&#39;] = $Target/Property[Type=&quot;HCSV2Library!HyperVPrivateCloud.VirtualMachineRuntime&quot;]/VMId$ AND Property[@Name=&#39;MemoryDemandPercentOfMaximum&#39;] &lt; 85)

Warning [Warning]: (Property[@Name=&#39;VMId&#39;] = $Target/Property[Type=&quot;HCSV2Library!HyperVPrivateCloud.VirtualMachineRuntime&quot;]/VMId$ AND (Property[@Name=&#39;MemoryDemandPercentOfMaximum&#39;] &gt;= 85 AND Property[@Name=&#39;MemoryDemandPercentOfMaximum&#39;] &lt; 95))

Error [Critical]: (Property[@Name=&#39;VMId&#39;] = $Target/Property[Type=&quot;HCSV2Library!HyperVPrivateCloud.VirtualMachineRuntime&quot;]/VMId$ AND Property[@Name=&#39;MemoryDemandPercentOfMaximum&#39;] &gt;= 95)

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: CheckpointCriticalHours=336; CheckpointWarningHours=168; CriticalThreshold=95; IntervalSeconds=300; PropertyName=MemoryDemandPercentOfMaximum; SyncTime=; TimeoutSeconds=240; VMId=$Target/Property[Type=&quot;HCSV2Library!HyperVPrivateCloud.VirtualMachineRuntime&quot;]/VMId$; WarningThreshold=85 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Warning; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Record the named counter, measured value, units, sampling interval and effective thresholds. Compare a representative time series with workload changes, host placement and storage/network evidence. Separate host/root/guest CPU and assigned/demanded memory. Missing counters are a telemetry problem, not zero utilization.

### Corrective action and escalation

Address the identified contention, workload placement or failing path with its owner. Capacity changes require a headroom and failover-reserve check. Do not blindly increase thresholds, reboot hosts or reduce VM resources to suppress symptoms.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Observe the same metric over a representative load period, confirm sustained recovery and verify workload response independently. Product defaults require site-specific review and are not Microsoft service-level guarantees.

### Microsoft references

[Microsoft Learn: troubleshoot hyper v virtual machine performance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/troubleshoot-hyper-v-virtual-machine-performance)


## VM virtual storage device latency {#hypervprivatecloud.vmruntime.virtualstoragelatency.monitor}

`HyperVPrivateCloud.VmRuntime.VirtualStorageLatency.Monitor`

Tracks the worst virtual storage device latency in milliseconds across the virtual disks attached to this VM. Warning at 30 ms and Critical at 60 ms; both thresholds are overridable and should be lowered on all-flash storage.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.Fabric.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.Fabric.Service.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Service.Storage.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Storage.Members.Latency.Performance.Dependency.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

Tracks the worst virtual storage device latency in milliseconds across the virtual disks attached to this VM. Warning at 30 ms and Critical at 60 ms; both thresholds are overridable and should be lowered on all-flash storage.

### Operator response

Compare against host physical disk latency to separate a noisy neighbour from a slow back end. Review storage QoS policy, VHDX type and fragmentation, checkpoint chain depth, and any active merge or backup.

### Tuning

Override WarningThreshold and CriticalThreshold on this monitor to match the storage, network, and consolidation profile of the target environment. Override IntervalSeconds and TimeoutSeconds identically across every monitor and rule that shares this probe so that cookdown is preserved.

### Support scope

Measured resource pressure or I/O delay. A warning is an opportunity to investigate headroom; a threshold crossing alone does not identify the defective component or predict a failure time.

Element: HyperVPrivateCloud.VmRuntime.VirtualStorageLatency.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HCSV2Library!HyperVPrivateCloud.VirtualMachineRuntime. Parent health aspect: Health!System.Health.PerformanceState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: (Property[@Name=&#39;VMId&#39;] = $Target/Property[Type=&quot;HCSV2Library!HyperVPrivateCloud.VirtualMachineRuntime&quot;]/VMId$ AND Property[@Name=&#39;VirtualStorageLatencyMs&#39;] &lt; 30)

Warning [Warning]: (Property[@Name=&#39;VMId&#39;] = $Target/Property[Type=&quot;HCSV2Library!HyperVPrivateCloud.VirtualMachineRuntime&quot;]/VMId$ AND (Property[@Name=&#39;VirtualStorageLatencyMs&#39;] &gt;= 30 AND Property[@Name=&#39;VirtualStorageLatencyMs&#39;] &lt; 60))

Error [Critical]: (Property[@Name=&#39;VMId&#39;] = $Target/Property[Type=&quot;HCSV2Library!HyperVPrivateCloud.VirtualMachineRuntime&quot;]/VMId$ AND Property[@Name=&#39;VirtualStorageLatencyMs&#39;] &gt;= 60)

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: CheckpointCriticalHours=336; CheckpointWarningHours=168; CriticalThreshold=60; IntervalSeconds=300; PropertyName=VirtualStorageLatencyMs; SyncTime=; TimeoutSeconds=240; VMId=$Target/Property[Type=&quot;HCSV2Library!HyperVPrivateCloud.VirtualMachineRuntime&quot;]/VMId$; WarningThreshold=30 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Error; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Record the named counter, measured value, units, sampling interval and effective thresholds. Compare a representative time series with workload changes, host placement and storage/network evidence. Separate host/root/guest CPU and assigned/demanded memory. Missing counters are a telemetry problem, not zero utilization.

### Corrective action and escalation

Address the identified contention, workload placement or failing path with its owner. Capacity changes require a headroom and failover-reserve check. Do not blindly increase thresholds, reboot hosts or reduce VM resources to suppress symptoms.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Observe the same metric over a representative load period, confirm sustained recovery and verify workload response independently. Product defaults require site-specific review and are not Microsoft service-level guarantees.

### Microsoft references

[Microsoft Learn: troubleshoot hyper v virtual machine performance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/troubleshoot-hyper-v-virtual-machine-performance)


## VM virtual storage device queue length {#hypervprivatecloud.vmruntime.virtualstoragequeuelength.monitor}

`HyperVPrivateCloud.VmRuntime.VirtualStorageQueueLength.Monitor`

Tracks the worst virtual storage device queue length across the virtual disks attached to this VM. Warning at 8 outstanding requests and Critical at 20; both thresholds are overridable.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.Fabric.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.Fabric.Service.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Service.Storage.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Storage.Members.Queue.Performance.Dependency.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

Tracks the worst virtual storage device queue length across the virtual disks attached to this VM. Warning at 8 outstanding requests and Critical at 20; both thresholds are overridable.

### Operator response

A deep queue with acceptable latency means the VM is simply busy; a deep queue with high latency means the storage path is saturated. Review storage QoS minimum and maximum IOPS for this VM.

### Tuning

Override WarningThreshold and CriticalThreshold on this monitor to match the storage, network, and consolidation profile of the target environment. Override IntervalSeconds and TimeoutSeconds identically across every monitor and rule that shares this probe so that cookdown is preserved.

### Support scope

Measured resource pressure or I/O delay. A warning is an opportunity to investigate headroom; a threshold crossing alone does not identify the defective component or predict a failure time.

Element: HyperVPrivateCloud.VmRuntime.VirtualStorageQueueLength.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HCSV2Library!HyperVPrivateCloud.VirtualMachineRuntime. Parent health aspect: Health!System.Health.PerformanceState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: (Property[@Name=&#39;VMId&#39;] = $Target/Property[Type=&quot;HCSV2Library!HyperVPrivateCloud.VirtualMachineRuntime&quot;]/VMId$ AND Property[@Name=&#39;VirtualStorageQueueLength&#39;] &lt; 8)

Warning [Warning]: (Property[@Name=&#39;VMId&#39;] = $Target/Property[Type=&quot;HCSV2Library!HyperVPrivateCloud.VirtualMachineRuntime&quot;]/VMId$ AND (Property[@Name=&#39;VirtualStorageQueueLength&#39;] &gt;= 8 AND Property[@Name=&#39;VirtualStorageQueueLength&#39;] &lt; 20))

Error [Critical]: (Property[@Name=&#39;VMId&#39;] = $Target/Property[Type=&quot;HCSV2Library!HyperVPrivateCloud.VirtualMachineRuntime&quot;]/VMId$ AND Property[@Name=&#39;VirtualStorageQueueLength&#39;] &gt;= 20)

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: CheckpointCriticalHours=336; CheckpointWarningHours=168; CriticalThreshold=20; IntervalSeconds=300; PropertyName=VirtualStorageQueueLength; SyncTime=; TimeoutSeconds=240; VMId=$Target/Property[Type=&quot;HCSV2Library!HyperVPrivateCloud.VirtualMachineRuntime&quot;]/VMId$; WarningThreshold=8 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Warning; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Record the named counter, measured value, units, sampling interval and effective thresholds. Compare a representative time series with workload changes, host placement and storage/network evidence. Separate host/root/guest CPU and assigned/demanded memory. Missing counters are a telemetry problem, not zero utilization.

### Corrective action and escalation

Address the identified contention, workload placement or failing path with its owner. Capacity changes require a headroom and failover-reserve check. Do not blindly increase thresholds, reboot hosts or reduce VM resources to suppress symptoms.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Observe the same metric over a representative load period, confirm sustained recovery and verify workload response independently. Product defaults require site-specific review and are not Microsoft service-level guarantees.

### Microsoft references

[Microsoft Learn: troubleshoot hyper v virtual machine performance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/troubleshoot-hyper-v-virtual-machine-performance)


## Roll up Management availability {#hypervprivatecloud.service.management.availability.dependency.monitor}

`HyperVPrivateCloud.Service.Management.Availability.Dependency.Monitor`

Rolls the availability state of the Management branch into the Hyper-V Private Cloud Distributed Application.

### Support scope

A discovered identity, logical boundary, component group or health dependency in the private-cloud service model. Containment draws a diagram; only authored monitors and health dependencies determine its health.

Element: HyperVPrivateCloud.Service.Management.Availability.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.Service; relationship=HCSV2Library!HyperVPrivateCloud.ServiceContainsManagementComponent; member monitor=Health!System.Health.AvailabilityState; parent=Health!System.Health.AvailabilityState; algorithm=WorstOf; unavailable-member policy=Error. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Open Health Explorer from the unhealthy DA, follow the failing health aspect and dependency to the named leaf object, and read its state-change context and knowledge. Check whether the object is an inventory-only reference or an authoritative monitor target. Record the complete root-to-leaf path.

### Corrective action and escalation

Repair the originating leaf condition using its specific runbook and owner. Do not reset or edit a parent DA to conceal child health. Missing relationships or wrong aspect routing require a source change, tests and a new sealed MP version.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm fresh healthy leaf evidence and follow recovery through each dependency back to the solution root. Unknown/unmonitored objects and absent optional capabilities must not be described as fully monitored healthy services.

### Microsoft references

[Microsoft Learn: manage consoles overview healthexplorer](https://learn.microsoft.com/en-us/system-center/scom/manage-consoles-overview-healthexplorer?view=sc-om-2025)


## Roll up Management performance {#hypervprivatecloud.service.management.performance.dependency.monitor}

`HyperVPrivateCloud.Service.Management.Performance.Dependency.Monitor`

Rolls the performance state of the Management branch into the Hyper-V Private Cloud Distributed Application.

### Support scope

A discovered identity, logical boundary, component group or health dependency in the private-cloud service model. Containment draws a diagram; only authored monitors and health dependencies determine its health.

Element: HyperVPrivateCloud.Service.Management.Performance.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.Service; relationship=HCSV2Library!HyperVPrivateCloud.ServiceContainsManagementComponent; member monitor=Health!System.Health.PerformanceState; parent=Health!System.Health.PerformanceState; algorithm=WorstOf; unavailable-member policy=Error. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Open Health Explorer from the unhealthy DA, follow the failing health aspect and dependency to the named leaf object, and read its state-change context and knowledge. Check whether the object is an inventory-only reference or an authoritative monitor target. Record the complete root-to-leaf path.

### Corrective action and escalation

Repair the originating leaf condition using its specific runbook and owner. Do not reset or edit a parent DA to conceal child health. Missing relationships or wrong aspect routing require a source change, tests and a new sealed MP version.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm fresh healthy leaf evidence and follow recovery through each dependency back to the solution root. Unknown/unmonitored objects and absent optional capabilities must not be described as fully monitored healthy services.

### Microsoft references

[Microsoft Learn: manage consoles overview healthexplorer](https://learn.microsoft.com/en-us/system-center/scom/manage-consoles-overview-healthexplorer?view=sc-om-2025)


## Roll up Management configuration {#hypervprivatecloud.service.management.configuration.dependency.monitor}

`HyperVPrivateCloud.Service.Management.Configuration.Dependency.Monitor`

Rolls the configuration state of the Management branch into the Hyper-V Private Cloud Distributed Application.

### Support scope

A discovered identity, logical boundary, component group or health dependency in the private-cloud service model. Containment draws a diagram; only authored monitors and health dependencies determine its health.

Element: HyperVPrivateCloud.Service.Management.Configuration.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.Service; relationship=HCSV2Library!HyperVPrivateCloud.ServiceContainsManagementComponent; member monitor=Health!System.Health.ConfigurationState; parent=Health!System.Health.ConfigurationState; algorithm=WorstOf; unavailable-member policy=Error. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Open Health Explorer from the unhealthy DA, follow the failing health aspect and dependency to the named leaf object, and read its state-change context and knowledge. Check whether the object is an inventory-only reference or an authoritative monitor target. Record the complete root-to-leaf path.

### Corrective action and escalation

Repair the originating leaf condition using its specific runbook and owner. Do not reset or edit a parent DA to conceal child health. Missing relationships or wrong aspect routing require a source change, tests and a new sealed MP version.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm fresh healthy leaf evidence and follow recovery through each dependency back to the solution root. Unknown/unmonitored objects and absent optional capabilities must not be described as fully monitored healthy services.

### Microsoft references

[Microsoft Learn: manage consoles overview healthexplorer](https://learn.microsoft.com/en-us/system-center/scom/manage-consoles-overview-healthexplorer?view=sc-om-2025)


## Roll up Management security {#hypervprivatecloud.service.management.security.dependency.monitor}

`HyperVPrivateCloud.Service.Management.Security.Dependency.Monitor`

Rolls the security state of the Management branch into the Hyper-V Private Cloud Distributed Application.

### Support scope

A discovered identity, logical boundary, component group or health dependency in the private-cloud service model. Containment draws a diagram; only authored monitors and health dependencies determine its health.

Element: HyperVPrivateCloud.Service.Management.Security.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.Service; relationship=HCSV2Library!HyperVPrivateCloud.ServiceContainsManagementComponent; member monitor=Health!System.Health.SecurityState; parent=Health!System.Health.SecurityState; algorithm=WorstOf; unavailable-member policy=Error. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Open Health Explorer from the unhealthy DA, follow the failing health aspect and dependency to the named leaf object, and read its state-change context and knowledge. Check whether the object is an inventory-only reference or an authoritative monitor target. Record the complete root-to-leaf path.

### Corrective action and escalation

Repair the originating leaf condition using its specific runbook and owner. Do not reset or edit a parent DA to conceal child health. Missing relationships or wrong aspect routing require a source change, tests and a new sealed MP version.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm fresh healthy leaf evidence and follow recovery through each dependency back to the solution root. Unknown/unmonitored objects and absent optional capabilities must not be described as fully monitored healthy services.

### Microsoft references

[Microsoft Learn: manage consoles overview healthexplorer](https://learn.microsoft.com/en-us/system-center/scom/manage-consoles-overview-healthexplorer?view=sc-om-2025)


## Roll up Compute availability {#hypervprivatecloud.service.compute.availability.dependency.monitor}

`HyperVPrivateCloud.Service.Compute.Availability.Dependency.Monitor`

Rolls the availability state of the Compute branch into the Hyper-V Private Cloud Distributed Application.

### Support scope

A discovered identity, logical boundary, component group or health dependency in the private-cloud service model. Containment draws a diagram; only authored monitors and health dependencies determine its health.

Element: HyperVPrivateCloud.Service.Compute.Availability.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.Service; relationship=HCSV2Library!HyperVPrivateCloud.ServiceContainsComputeComponent; member monitor=Health!System.Health.AvailabilityState; parent=Health!System.Health.AvailabilityState; algorithm=WorstOf; unavailable-member policy=Error. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Open Health Explorer from the unhealthy DA, follow the failing health aspect and dependency to the named leaf object, and read its state-change context and knowledge. Check whether the object is an inventory-only reference or an authoritative monitor target. Record the complete root-to-leaf path.

### Corrective action and escalation

Repair the originating leaf condition using its specific runbook and owner. Do not reset or edit a parent DA to conceal child health. Missing relationships or wrong aspect routing require a source change, tests and a new sealed MP version.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm fresh healthy leaf evidence and follow recovery through each dependency back to the solution root. Unknown/unmonitored objects and absent optional capabilities must not be described as fully monitored healthy services.

### Microsoft references

[Microsoft Learn: manage consoles overview healthexplorer](https://learn.microsoft.com/en-us/system-center/scom/manage-consoles-overview-healthexplorer?view=sc-om-2025)


## Roll up Compute performance {#hypervprivatecloud.service.compute.performance.dependency.monitor}

`HyperVPrivateCloud.Service.Compute.Performance.Dependency.Monitor`

Rolls the performance state of the Compute branch into the Hyper-V Private Cloud Distributed Application.

### Support scope

A discovered identity, logical boundary, component group or health dependency in the private-cloud service model. Containment draws a diagram; only authored monitors and health dependencies determine its health.

Element: HyperVPrivateCloud.Service.Compute.Performance.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.Service; relationship=HCSV2Library!HyperVPrivateCloud.ServiceContainsComputeComponent; member monitor=Health!System.Health.PerformanceState; parent=Health!System.Health.PerformanceState; algorithm=WorstOf; unavailable-member policy=Error. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Open Health Explorer from the unhealthy DA, follow the failing health aspect and dependency to the named leaf object, and read its state-change context and knowledge. Check whether the object is an inventory-only reference or an authoritative monitor target. Record the complete root-to-leaf path.

### Corrective action and escalation

Repair the originating leaf condition using its specific runbook and owner. Do not reset or edit a parent DA to conceal child health. Missing relationships or wrong aspect routing require a source change, tests and a new sealed MP version.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm fresh healthy leaf evidence and follow recovery through each dependency back to the solution root. Unknown/unmonitored objects and absent optional capabilities must not be described as fully monitored healthy services.

### Microsoft references

[Microsoft Learn: manage consoles overview healthexplorer](https://learn.microsoft.com/en-us/system-center/scom/manage-consoles-overview-healthexplorer?view=sc-om-2025)


## Roll up Compute configuration {#hypervprivatecloud.service.compute.configuration.dependency.monitor}

`HyperVPrivateCloud.Service.Compute.Configuration.Dependency.Monitor`

Rolls the configuration state of the Compute branch into the Hyper-V Private Cloud Distributed Application.

### Support scope

A discovered identity, logical boundary, component group or health dependency in the private-cloud service model. Containment draws a diagram; only authored monitors and health dependencies determine its health.

Element: HyperVPrivateCloud.Service.Compute.Configuration.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.Service; relationship=HCSV2Library!HyperVPrivateCloud.ServiceContainsComputeComponent; member monitor=Health!System.Health.ConfigurationState; parent=Health!System.Health.ConfigurationState; algorithm=WorstOf; unavailable-member policy=Error. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Open Health Explorer from the unhealthy DA, follow the failing health aspect and dependency to the named leaf object, and read its state-change context and knowledge. Check whether the object is an inventory-only reference or an authoritative monitor target. Record the complete root-to-leaf path.

### Corrective action and escalation

Repair the originating leaf condition using its specific runbook and owner. Do not reset or edit a parent DA to conceal child health. Missing relationships or wrong aspect routing require a source change, tests and a new sealed MP version.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm fresh healthy leaf evidence and follow recovery through each dependency back to the solution root. Unknown/unmonitored objects and absent optional capabilities must not be described as fully monitored healthy services.

### Microsoft references

[Microsoft Learn: manage consoles overview healthexplorer](https://learn.microsoft.com/en-us/system-center/scom/manage-consoles-overview-healthexplorer?view=sc-om-2025)


## Roll up Compute security {#hypervprivatecloud.service.compute.security.dependency.monitor}

`HyperVPrivateCloud.Service.Compute.Security.Dependency.Monitor`

Rolls the security state of the Compute branch into the Hyper-V Private Cloud Distributed Application.

### Support scope

A discovered identity, logical boundary, component group or health dependency in the private-cloud service model. Containment draws a diagram; only authored monitors and health dependencies determine its health.

Element: HyperVPrivateCloud.Service.Compute.Security.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.Service; relationship=HCSV2Library!HyperVPrivateCloud.ServiceContainsComputeComponent; member monitor=Health!System.Health.SecurityState; parent=Health!System.Health.SecurityState; algorithm=WorstOf; unavailable-member policy=Error. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Open Health Explorer from the unhealthy DA, follow the failing health aspect and dependency to the named leaf object, and read its state-change context and knowledge. Check whether the object is an inventory-only reference or an authoritative monitor target. Record the complete root-to-leaf path.

### Corrective action and escalation

Repair the originating leaf condition using its specific runbook and owner. Do not reset or edit a parent DA to conceal child health. Missing relationships or wrong aspect routing require a source change, tests and a new sealed MP version.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm fresh healthy leaf evidence and follow recovery through each dependency back to the solution root. Unknown/unmonitored objects and absent optional capabilities must not be described as fully monitored healthy services.

### Microsoft references

[Microsoft Learn: manage consoles overview healthexplorer](https://learn.microsoft.com/en-us/system-center/scom/manage-consoles-overview-healthexplorer?view=sc-om-2025)


## Roll up VirtualMachines availability {#hypervprivatecloud.service.virtualmachines.availability.dependency.monitor}

`HyperVPrivateCloud.Service.VirtualMachines.Availability.Dependency.Monitor`

Rolls the availability state of the VirtualMachines branch into the Hyper-V Private Cloud Distributed Application.

### Support scope

Host-based Hyper-V workload or management evidence. A stopped VM must be compared with its intended state; inventory presence is not guest application monitoring.

Element: HyperVPrivateCloud.Service.VirtualMachines.Availability.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.Service; relationship=HCSV2Library!HyperVPrivateCloud.ServiceContainsVirtualMachineComponent; member monitor=Health!System.Health.AvailabilityState; parent=Health!System.Health.AvailabilityState; algorithm=WorstOf; unavailable-member policy=Error. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Run the matching read-only host/VM task. Match the stable VM ID and current owner, inspect Get-VM, attached disks, checkpoint chain and Hyper-V-VMMS/High-Availability logs. For management-service errors verify the named service and first failure rather than assuming every guest stopped.

### Corrective action and escalation

Restore the identified service, configuration, storage or VM dependency with the workload owner. Check intended shutdown and maintenance policy first. Never delete checkpoint files, force power operations or restart VMMS/hosts solely to clear an alert.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm the intended VM/service state, fresh host-derived evidence and the originating monitor. Guest application recovery requires a separate workload-level check.

### Microsoft references

[Microsoft Learn: hyper v start state access failures clustered standalone](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-start-state-access-failures-clustered-standalone)

[Microsoft Learn: hyper v virtual machine backup checkpoint storage](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-virtual-machine-backup-checkpoint-storage)


## Roll up VirtualMachines performance {#hypervprivatecloud.service.virtualmachines.performance.dependency.monitor}

`HyperVPrivateCloud.Service.VirtualMachines.Performance.Dependency.Monitor`

Rolls the performance state of the VirtualMachines branch into the Hyper-V Private Cloud Distributed Application.

### Support scope

Host-based Hyper-V workload or management evidence. A stopped VM must be compared with its intended state; inventory presence is not guest application monitoring.

Element: HyperVPrivateCloud.Service.VirtualMachines.Performance.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.Service; relationship=HCSV2Library!HyperVPrivateCloud.ServiceContainsVirtualMachineComponent; member monitor=Health!System.Health.PerformanceState; parent=Health!System.Health.PerformanceState; algorithm=WorstOf; unavailable-member policy=Error. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Run the matching read-only host/VM task. Match the stable VM ID and current owner, inspect Get-VM, attached disks, checkpoint chain and Hyper-V-VMMS/High-Availability logs. For management-service errors verify the named service and first failure rather than assuming every guest stopped.

### Corrective action and escalation

Restore the identified service, configuration, storage or VM dependency with the workload owner. Check intended shutdown and maintenance policy first. Never delete checkpoint files, force power operations or restart VMMS/hosts solely to clear an alert.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm the intended VM/service state, fresh host-derived evidence and the originating monitor. Guest application recovery requires a separate workload-level check.

### Microsoft references

[Microsoft Learn: hyper v start state access failures clustered standalone](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-start-state-access-failures-clustered-standalone)

[Microsoft Learn: hyper v virtual machine backup checkpoint storage](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-virtual-machine-backup-checkpoint-storage)


## Roll up VirtualMachines configuration {#hypervprivatecloud.service.virtualmachines.configuration.dependency.monitor}

`HyperVPrivateCloud.Service.VirtualMachines.Configuration.Dependency.Monitor`

Rolls the configuration state of the VirtualMachines branch into the Hyper-V Private Cloud Distributed Application.

### Support scope

Host-based Hyper-V workload or management evidence. A stopped VM must be compared with its intended state; inventory presence is not guest application monitoring.

Element: HyperVPrivateCloud.Service.VirtualMachines.Configuration.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.Service; relationship=HCSV2Library!HyperVPrivateCloud.ServiceContainsVirtualMachineComponent; member monitor=Health!System.Health.ConfigurationState; parent=Health!System.Health.ConfigurationState; algorithm=WorstOf; unavailable-member policy=Error. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Run the matching read-only host/VM task. Match the stable VM ID and current owner, inspect Get-VM, attached disks, checkpoint chain and Hyper-V-VMMS/High-Availability logs. For management-service errors verify the named service and first failure rather than assuming every guest stopped.

### Corrective action and escalation

Restore the identified service, configuration, storage or VM dependency with the workload owner. Check intended shutdown and maintenance policy first. Never delete checkpoint files, force power operations or restart VMMS/hosts solely to clear an alert.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm the intended VM/service state, fresh host-derived evidence and the originating monitor. Guest application recovery requires a separate workload-level check.

### Microsoft references

[Microsoft Learn: hyper v start state access failures clustered standalone](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-start-state-access-failures-clustered-standalone)

[Microsoft Learn: hyper v virtual machine backup checkpoint storage](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-virtual-machine-backup-checkpoint-storage)


## Roll up VirtualMachines security {#hypervprivatecloud.service.virtualmachines.security.dependency.monitor}

`HyperVPrivateCloud.Service.VirtualMachines.Security.Dependency.Monitor`

Rolls the security state of the VirtualMachines branch into the Hyper-V Private Cloud Distributed Application.

### Support scope

Host-based Hyper-V workload or management evidence. A stopped VM must be compared with its intended state; inventory presence is not guest application monitoring.

Element: HyperVPrivateCloud.Service.VirtualMachines.Security.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.Service; relationship=HCSV2Library!HyperVPrivateCloud.ServiceContainsVirtualMachineComponent; member monitor=Health!System.Health.SecurityState; parent=Health!System.Health.SecurityState; algorithm=WorstOf; unavailable-member policy=Error. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Run the matching read-only host/VM task. Match the stable VM ID and current owner, inspect Get-VM, attached disks, checkpoint chain and Hyper-V-VMMS/High-Availability logs. For management-service errors verify the named service and first failure rather than assuming every guest stopped.

### Corrective action and escalation

Restore the identified service, configuration, storage or VM dependency with the workload owner. Check intended shutdown and maintenance policy first. Never delete checkpoint files, force power operations or restart VMMS/hosts solely to clear an alert.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm the intended VM/service state, fresh host-derived evidence and the originating monitor. Guest application recovery requires a separate workload-level check.

### Microsoft references

[Microsoft Learn: hyper v start state access failures clustered standalone](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-start-state-access-failures-clustered-standalone)

[Microsoft Learn: hyper v virtual machine backup checkpoint storage](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-virtual-machine-backup-checkpoint-storage)


## Roll up Availability availability {#hypervprivatecloud.service.availability.availability.dependency.monitor}

`HyperVPrivateCloud.Service.Availability.Availability.Dependency.Monitor`

Rolls the availability state of the Availability branch into the Hyper-V Private Cloud Distributed Application.

### Support scope

A discovered identity, logical boundary, component group or health dependency in the private-cloud service model. Containment draws a diagram; only authored monitors and health dependencies determine its health.

Element: HyperVPrivateCloud.Service.Availability.Availability.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.Service; relationship=HCSV2Library!HyperVPrivateCloud.ServiceContainsAvailabilityComponent; member monitor=Health!System.Health.AvailabilityState; parent=Health!System.Health.AvailabilityState; algorithm=WorstOf; unavailable-member policy=Error. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Open Health Explorer from the unhealthy DA, follow the failing health aspect and dependency to the named leaf object, and read its state-change context and knowledge. Check whether the object is an inventory-only reference or an authoritative monitor target. Record the complete root-to-leaf path.

### Corrective action and escalation

Repair the originating leaf condition using its specific runbook and owner. Do not reset or edit a parent DA to conceal child health. Missing relationships or wrong aspect routing require a source change, tests and a new sealed MP version.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm fresh healthy leaf evidence and follow recovery through each dependency back to the solution root. Unknown/unmonitored objects and absent optional capabilities must not be described as fully monitored healthy services.

### Microsoft references

[Microsoft Learn: manage consoles overview healthexplorer](https://learn.microsoft.com/en-us/system-center/scom/manage-consoles-overview-healthexplorer?view=sc-om-2025)


## Roll up Availability performance {#hypervprivatecloud.service.availability.performance.dependency.monitor}

`HyperVPrivateCloud.Service.Availability.Performance.Dependency.Monitor`

Rolls the performance state of the Availability branch into the Hyper-V Private Cloud Distributed Application.

### Support scope

A discovered identity, logical boundary, component group or health dependency in the private-cloud service model. Containment draws a diagram; only authored monitors and health dependencies determine its health.

Element: HyperVPrivateCloud.Service.Availability.Performance.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.Service; relationship=HCSV2Library!HyperVPrivateCloud.ServiceContainsAvailabilityComponent; member monitor=Health!System.Health.PerformanceState; parent=Health!System.Health.PerformanceState; algorithm=WorstOf; unavailable-member policy=Error. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Open Health Explorer from the unhealthy DA, follow the failing health aspect and dependency to the named leaf object, and read its state-change context and knowledge. Check whether the object is an inventory-only reference or an authoritative monitor target. Record the complete root-to-leaf path.

### Corrective action and escalation

Repair the originating leaf condition using its specific runbook and owner. Do not reset or edit a parent DA to conceal child health. Missing relationships or wrong aspect routing require a source change, tests and a new sealed MP version.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm fresh healthy leaf evidence and follow recovery through each dependency back to the solution root. Unknown/unmonitored objects and absent optional capabilities must not be described as fully monitored healthy services.

### Microsoft references

[Microsoft Learn: manage consoles overview healthexplorer](https://learn.microsoft.com/en-us/system-center/scom/manage-consoles-overview-healthexplorer?view=sc-om-2025)


## Roll up Availability configuration {#hypervprivatecloud.service.availability.configuration.dependency.monitor}

`HyperVPrivateCloud.Service.Availability.Configuration.Dependency.Monitor`

Rolls the configuration state of the Availability branch into the Hyper-V Private Cloud Distributed Application.

### Support scope

A discovered identity, logical boundary, component group or health dependency in the private-cloud service model. Containment draws a diagram; only authored monitors and health dependencies determine its health.

Element: HyperVPrivateCloud.Service.Availability.Configuration.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.Service; relationship=HCSV2Library!HyperVPrivateCloud.ServiceContainsAvailabilityComponent; member monitor=Health!System.Health.ConfigurationState; parent=Health!System.Health.ConfigurationState; algorithm=WorstOf; unavailable-member policy=Error. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Open Health Explorer from the unhealthy DA, follow the failing health aspect and dependency to the named leaf object, and read its state-change context and knowledge. Check whether the object is an inventory-only reference or an authoritative monitor target. Record the complete root-to-leaf path.

### Corrective action and escalation

Repair the originating leaf condition using its specific runbook and owner. Do not reset or edit a parent DA to conceal child health. Missing relationships or wrong aspect routing require a source change, tests and a new sealed MP version.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm fresh healthy leaf evidence and follow recovery through each dependency back to the solution root. Unknown/unmonitored objects and absent optional capabilities must not be described as fully monitored healthy services.

### Microsoft references

[Microsoft Learn: manage consoles overview healthexplorer](https://learn.microsoft.com/en-us/system-center/scom/manage-consoles-overview-healthexplorer?view=sc-om-2025)


## Roll up Availability security {#hypervprivatecloud.service.availability.security.dependency.monitor}

`HyperVPrivateCloud.Service.Availability.Security.Dependency.Monitor`

Rolls the security state of the Availability branch into the Hyper-V Private Cloud Distributed Application.

### Support scope

A discovered identity, logical boundary, component group or health dependency in the private-cloud service model. Containment draws a diagram; only authored monitors and health dependencies determine its health.

Element: HyperVPrivateCloud.Service.Availability.Security.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.Service; relationship=HCSV2Library!HyperVPrivateCloud.ServiceContainsAvailabilityComponent; member monitor=Health!System.Health.SecurityState; parent=Health!System.Health.SecurityState; algorithm=WorstOf; unavailable-member policy=Error. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Open Health Explorer from the unhealthy DA, follow the failing health aspect and dependency to the named leaf object, and read its state-change context and knowledge. Check whether the object is an inventory-only reference or an authoritative monitor target. Record the complete root-to-leaf path.

### Corrective action and escalation

Repair the originating leaf condition using its specific runbook and owner. Do not reset or edit a parent DA to conceal child health. Missing relationships or wrong aspect routing require a source change, tests and a new sealed MP version.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm fresh healthy leaf evidence and follow recovery through each dependency back to the solution root. Unknown/unmonitored objects and absent optional capabilities must not be described as fully monitored healthy services.

### Microsoft references

[Microsoft Learn: manage consoles overview healthexplorer](https://learn.microsoft.com/en-us/system-center/scom/manage-consoles-overview-healthexplorer?view=sc-om-2025)


## Roll up Storage availability {#hypervprivatecloud.service.storage.availability.dependency.monitor}

`HyperVPrivateCloud.Service.Storage.Availability.Dependency.Monitor`

Rolls the availability state of the Storage branch into the Hyper-V Private Cloud Distributed Application.

### Support scope

A discovered identity, logical boundary, component group or health dependency in the private-cloud service model. Containment draws a diagram; only authored monitors and health dependencies determine its health.

Element: HyperVPrivateCloud.Service.Storage.Availability.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.Service; relationship=HCSV2Library!HyperVPrivateCloud.ServiceContainsStorageComponent; member monitor=Health!System.Health.AvailabilityState; parent=Health!System.Health.AvailabilityState; algorithm=WorstOf; unavailable-member policy=Error. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Open Health Explorer from the unhealthy DA, follow the failing health aspect and dependency to the named leaf object, and read its state-change context and knowledge. Check whether the object is an inventory-only reference or an authoritative monitor target. Record the complete root-to-leaf path.

### Corrective action and escalation

Repair the originating leaf condition using its specific runbook and owner. Do not reset or edit a parent DA to conceal child health. Missing relationships or wrong aspect routing require a source change, tests and a new sealed MP version.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm fresh healthy leaf evidence and follow recovery through each dependency back to the solution root. Unknown/unmonitored objects and absent optional capabilities must not be described as fully monitored healthy services.

### Microsoft references

[Microsoft Learn: manage consoles overview healthexplorer](https://learn.microsoft.com/en-us/system-center/scom/manage-consoles-overview-healthexplorer?view=sc-om-2025)


## Roll up Storage performance {#hypervprivatecloud.service.storage.performance.dependency.monitor}

`HyperVPrivateCloud.Service.Storage.Performance.Dependency.Monitor`

Rolls the performance state of the Storage branch into the Hyper-V Private Cloud Distributed Application.

### Support scope

A discovered identity, logical boundary, component group or health dependency in the private-cloud service model. Containment draws a diagram; only authored monitors and health dependencies determine its health.

Element: HyperVPrivateCloud.Service.Storage.Performance.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.Service; relationship=HCSV2Library!HyperVPrivateCloud.ServiceContainsStorageComponent; member monitor=Health!System.Health.PerformanceState; parent=Health!System.Health.PerformanceState; algorithm=WorstOf; unavailable-member policy=Error. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Open Health Explorer from the unhealthy DA, follow the failing health aspect and dependency to the named leaf object, and read its state-change context and knowledge. Check whether the object is an inventory-only reference or an authoritative monitor target. Record the complete root-to-leaf path.

### Corrective action and escalation

Repair the originating leaf condition using its specific runbook and owner. Do not reset or edit a parent DA to conceal child health. Missing relationships or wrong aspect routing require a source change, tests and a new sealed MP version.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm fresh healthy leaf evidence and follow recovery through each dependency back to the solution root. Unknown/unmonitored objects and absent optional capabilities must not be described as fully monitored healthy services.

### Microsoft references

[Microsoft Learn: manage consoles overview healthexplorer](https://learn.microsoft.com/en-us/system-center/scom/manage-consoles-overview-healthexplorer?view=sc-om-2025)


## Roll up Storage configuration {#hypervprivatecloud.service.storage.configuration.dependency.monitor}

`HyperVPrivateCloud.Service.Storage.Configuration.Dependency.Monitor`

Rolls the configuration state of the Storage branch into the Hyper-V Private Cloud Distributed Application.

### Support scope

A discovered identity, logical boundary, component group or health dependency in the private-cloud service model. Containment draws a diagram; only authored monitors and health dependencies determine its health.

Element: HyperVPrivateCloud.Service.Storage.Configuration.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.Service; relationship=HCSV2Library!HyperVPrivateCloud.ServiceContainsStorageComponent; member monitor=Health!System.Health.ConfigurationState; parent=Health!System.Health.ConfigurationState; algorithm=WorstOf; unavailable-member policy=Error. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Open Health Explorer from the unhealthy DA, follow the failing health aspect and dependency to the named leaf object, and read its state-change context and knowledge. Check whether the object is an inventory-only reference or an authoritative monitor target. Record the complete root-to-leaf path.

### Corrective action and escalation

Repair the originating leaf condition using its specific runbook and owner. Do not reset or edit a parent DA to conceal child health. Missing relationships or wrong aspect routing require a source change, tests and a new sealed MP version.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm fresh healthy leaf evidence and follow recovery through each dependency back to the solution root. Unknown/unmonitored objects and absent optional capabilities must not be described as fully monitored healthy services.

### Microsoft references

[Microsoft Learn: manage consoles overview healthexplorer](https://learn.microsoft.com/en-us/system-center/scom/manage-consoles-overview-healthexplorer?view=sc-om-2025)


## Roll up Storage security {#hypervprivatecloud.service.storage.security.dependency.monitor}

`HyperVPrivateCloud.Service.Storage.Security.Dependency.Monitor`

Rolls the security state of the Storage branch into the Hyper-V Private Cloud Distributed Application.

### Support scope

A discovered identity, logical boundary, component group or health dependency in the private-cloud service model. Containment draws a diagram; only authored monitors and health dependencies determine its health.

Element: HyperVPrivateCloud.Service.Storage.Security.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.Service; relationship=HCSV2Library!HyperVPrivateCloud.ServiceContainsStorageComponent; member monitor=Health!System.Health.SecurityState; parent=Health!System.Health.SecurityState; algorithm=WorstOf; unavailable-member policy=Error. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Open Health Explorer from the unhealthy DA, follow the failing health aspect and dependency to the named leaf object, and read its state-change context and knowledge. Check whether the object is an inventory-only reference or an authoritative monitor target. Record the complete root-to-leaf path.

### Corrective action and escalation

Repair the originating leaf condition using its specific runbook and owner. Do not reset or edit a parent DA to conceal child health. Missing relationships or wrong aspect routing require a source change, tests and a new sealed MP version.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm fresh healthy leaf evidence and follow recovery through each dependency back to the solution root. Unknown/unmonitored objects and absent optional capabilities must not be described as fully monitored healthy services.

### Microsoft references

[Microsoft Learn: manage consoles overview healthexplorer](https://learn.microsoft.com/en-us/system-center/scom/manage-consoles-overview-healthexplorer?view=sc-om-2025)


## Roll up Network availability {#hypervprivatecloud.service.network.availability.dependency.monitor}

`HyperVPrivateCloud.Service.Network.Availability.Dependency.Monitor`

Rolls the availability state of the Network branch into the Hyper-V Private Cloud Distributed Application.

### Support scope

Host network or external infrastructure evidence at the precise scope of the leaf. TCP reachability is not device hardware, firewall-policy or application health; linked vendor monitors retain their own authority.

Element: HyperVPrivateCloud.Service.Network.Availability.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.Service; relationship=HCSV2Library!HyperVPrivateCloud.ServiceContainsNetworkComponent; member monitor=Health!System.Health.AvailabilityState; parent=Health!System.Health.AvailabilityState; algorithm=WorstOf; unavailable-member policy=Error. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Identify the adapter, switch, port or configured endpoint and the actual observation source. Compare link state, negotiated speed and error/discard deltas with device-side evidence. Check routing and the intended port from the collector. An unreachable management endpoint does not by itself prove the data plane failed.

### Corrective action and escalation

Restore the specific path, cable/optic, approved switch configuration or device service with the network/hardware owner. Consult the vendor for proprietary device faults. Do not disable security controls, bounce all uplinks or reboot management devices based only on a failed TCP probe.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Repeat the original path test and confirm relevant native/vendor health. For cumulative errors, observe new deltas; do not expect historic totals to disappear.

### Microsoft references

[Microsoft Learn: troubleshoot tcp ip communication guidance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/networking/troubleshoot-tcp-ip-communication-guidance)


## Roll up Network performance {#hypervprivatecloud.service.network.performance.dependency.monitor}

`HyperVPrivateCloud.Service.Network.Performance.Dependency.Monitor`

Rolls the performance state of the Network branch into the Hyper-V Private Cloud Distributed Application.

### Support scope

Host network or external infrastructure evidence at the precise scope of the leaf. TCP reachability is not device hardware, firewall-policy or application health; linked vendor monitors retain their own authority.

Element: HyperVPrivateCloud.Service.Network.Performance.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.Service; relationship=HCSV2Library!HyperVPrivateCloud.ServiceContainsNetworkComponent; member monitor=Health!System.Health.PerformanceState; parent=Health!System.Health.PerformanceState; algorithm=WorstOf; unavailable-member policy=Error. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Identify the adapter, switch, port or configured endpoint and the actual observation source. Compare link state, negotiated speed and error/discard deltas with device-side evidence. Check routing and the intended port from the collector. An unreachable management endpoint does not by itself prove the data plane failed.

### Corrective action and escalation

Restore the specific path, cable/optic, approved switch configuration or device service with the network/hardware owner. Consult the vendor for proprietary device faults. Do not disable security controls, bounce all uplinks or reboot management devices based only on a failed TCP probe.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Repeat the original path test and confirm relevant native/vendor health. For cumulative errors, observe new deltas; do not expect historic totals to disappear.

### Microsoft references

[Microsoft Learn: troubleshoot tcp ip communication guidance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/networking/troubleshoot-tcp-ip-communication-guidance)


## Roll up Network configuration {#hypervprivatecloud.service.network.configuration.dependency.monitor}

`HyperVPrivateCloud.Service.Network.Configuration.Dependency.Monitor`

Rolls the configuration state of the Network branch into the Hyper-V Private Cloud Distributed Application.

### Support scope

Host network or external infrastructure evidence at the precise scope of the leaf. TCP reachability is not device hardware, firewall-policy or application health; linked vendor monitors retain their own authority.

Element: HyperVPrivateCloud.Service.Network.Configuration.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.Service; relationship=HCSV2Library!HyperVPrivateCloud.ServiceContainsNetworkComponent; member monitor=Health!System.Health.ConfigurationState; parent=Health!System.Health.ConfigurationState; algorithm=WorstOf; unavailable-member policy=Error. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Identify the adapter, switch, port or configured endpoint and the actual observation source. Compare link state, negotiated speed and error/discard deltas with device-side evidence. Check routing and the intended port from the collector. An unreachable management endpoint does not by itself prove the data plane failed.

### Corrective action and escalation

Restore the specific path, cable/optic, approved switch configuration or device service with the network/hardware owner. Consult the vendor for proprietary device faults. Do not disable security controls, bounce all uplinks or reboot management devices based only on a failed TCP probe.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Repeat the original path test and confirm relevant native/vendor health. For cumulative errors, observe new deltas; do not expect historic totals to disappear.

### Microsoft references

[Microsoft Learn: troubleshoot tcp ip communication guidance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/networking/troubleshoot-tcp-ip-communication-guidance)


## Roll up Network security {#hypervprivatecloud.service.network.security.dependency.monitor}

`HyperVPrivateCloud.Service.Network.Security.Dependency.Monitor`

Rolls the security state of the Network branch into the Hyper-V Private Cloud Distributed Application.

### Support scope

Host network or external infrastructure evidence at the precise scope of the leaf. TCP reachability is not device hardware, firewall-policy or application health; linked vendor monitors retain their own authority.

Element: HyperVPrivateCloud.Service.Network.Security.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.Service; relationship=HCSV2Library!HyperVPrivateCloud.ServiceContainsNetworkComponent; member monitor=Health!System.Health.SecurityState; parent=Health!System.Health.SecurityState; algorithm=WorstOf; unavailable-member policy=Error. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Identify the adapter, switch, port or configured endpoint and the actual observation source. Compare link state, negotiated speed and error/discard deltas with device-side evidence. Check routing and the intended port from the collector. An unreachable management endpoint does not by itself prove the data plane failed.

### Corrective action and escalation

Restore the specific path, cable/optic, approved switch configuration or device service with the network/hardware owner. Consult the vendor for proprietary device faults. Do not disable security controls, bounce all uplinks or reboot management devices based only on a failed TCP probe.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Repeat the original path test and confirm relevant native/vendor health. For cumulative errors, observe new deltas; do not expect historic totals to disappear.

### Microsoft references

[Microsoft Learn: troubleshoot tcp ip communication guidance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/networking/troubleshoot-tcp-ip-communication-guidance)


## Roll up Monitoring availability {#hypervprivatecloud.service.monitoring.availability.dependency.monitor}

`HyperVPrivateCloud.Service.Monitoring.Availability.Dependency.Monitor`

Rolls the availability state of the Monitoring branch into the Hyper-V Private Cloud Distributed Application.

### Support scope

A discovered identity, logical boundary, component group or health dependency in the private-cloud service model. Containment draws a diagram; only authored monitors and health dependencies determine its health.

Element: HyperVPrivateCloud.Service.Monitoring.Availability.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.Service; relationship=HCSV2Library!HyperVPrivateCloud.ServiceContainsMonitoringComponent; member monitor=Health!System.Health.AvailabilityState; parent=Health!System.Health.AvailabilityState; algorithm=WorstOf; unavailable-member policy=Error. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Open Health Explorer from the unhealthy DA, follow the failing health aspect and dependency to the named leaf object, and read its state-change context and knowledge. Check whether the object is an inventory-only reference or an authoritative monitor target. Record the complete root-to-leaf path.

### Corrective action and escalation

Repair the originating leaf condition using its specific runbook and owner. Do not reset or edit a parent DA to conceal child health. Missing relationships or wrong aspect routing require a source change, tests and a new sealed MP version.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm fresh healthy leaf evidence and follow recovery through each dependency back to the solution root. Unknown/unmonitored objects and absent optional capabilities must not be described as fully monitored healthy services.

### Microsoft references

[Microsoft Learn: manage consoles overview healthexplorer](https://learn.microsoft.com/en-us/system-center/scom/manage-consoles-overview-healthexplorer?view=sc-om-2025)


## Roll up Monitoring performance {#hypervprivatecloud.service.monitoring.performance.dependency.monitor}

`HyperVPrivateCloud.Service.Monitoring.Performance.Dependency.Monitor`

Rolls the performance state of the Monitoring branch into the Hyper-V Private Cloud Distributed Application.

### Support scope

A discovered identity, logical boundary, component group or health dependency in the private-cloud service model. Containment draws a diagram; only authored monitors and health dependencies determine its health.

Element: HyperVPrivateCloud.Service.Monitoring.Performance.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.Service; relationship=HCSV2Library!HyperVPrivateCloud.ServiceContainsMonitoringComponent; member monitor=Health!System.Health.PerformanceState; parent=Health!System.Health.PerformanceState; algorithm=WorstOf; unavailable-member policy=Error. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Open Health Explorer from the unhealthy DA, follow the failing health aspect and dependency to the named leaf object, and read its state-change context and knowledge. Check whether the object is an inventory-only reference or an authoritative monitor target. Record the complete root-to-leaf path.

### Corrective action and escalation

Repair the originating leaf condition using its specific runbook and owner. Do not reset or edit a parent DA to conceal child health. Missing relationships or wrong aspect routing require a source change, tests and a new sealed MP version.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm fresh healthy leaf evidence and follow recovery through each dependency back to the solution root. Unknown/unmonitored objects and absent optional capabilities must not be described as fully monitored healthy services.

### Microsoft references

[Microsoft Learn: manage consoles overview healthexplorer](https://learn.microsoft.com/en-us/system-center/scom/manage-consoles-overview-healthexplorer?view=sc-om-2025)


## Roll up Monitoring configuration {#hypervprivatecloud.service.monitoring.configuration.dependency.monitor}

`HyperVPrivateCloud.Service.Monitoring.Configuration.Dependency.Monitor`

Rolls the configuration state of the Monitoring branch into the Hyper-V Private Cloud Distributed Application.

### Support scope

A discovered identity, logical boundary, component group or health dependency in the private-cloud service model. Containment draws a diagram; only authored monitors and health dependencies determine its health.

Element: HyperVPrivateCloud.Service.Monitoring.Configuration.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.Service; relationship=HCSV2Library!HyperVPrivateCloud.ServiceContainsMonitoringComponent; member monitor=Health!System.Health.ConfigurationState; parent=Health!System.Health.ConfigurationState; algorithm=WorstOf; unavailable-member policy=Error. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Open Health Explorer from the unhealthy DA, follow the failing health aspect and dependency to the named leaf object, and read its state-change context and knowledge. Check whether the object is an inventory-only reference or an authoritative monitor target. Record the complete root-to-leaf path.

### Corrective action and escalation

Repair the originating leaf condition using its specific runbook and owner. Do not reset or edit a parent DA to conceal child health. Missing relationships or wrong aspect routing require a source change, tests and a new sealed MP version.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm fresh healthy leaf evidence and follow recovery through each dependency back to the solution root. Unknown/unmonitored objects and absent optional capabilities must not be described as fully monitored healthy services.

### Microsoft references

[Microsoft Learn: manage consoles overview healthexplorer](https://learn.microsoft.com/en-us/system-center/scom/manage-consoles-overview-healthexplorer?view=sc-om-2025)


## Roll up Monitoring security {#hypervprivatecloud.service.monitoring.security.dependency.monitor}

`HyperVPrivateCloud.Service.Monitoring.Security.Dependency.Monitor`

Rolls the security state of the Monitoring branch into the Hyper-V Private Cloud Distributed Application.

### Support scope

A discovered identity, logical boundary, component group or health dependency in the private-cloud service model. Containment draws a diagram; only authored monitors and health dependencies determine its health.

Element: HyperVPrivateCloud.Service.Monitoring.Security.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.Service; relationship=HCSV2Library!HyperVPrivateCloud.ServiceContainsMonitoringComponent; member monitor=Health!System.Health.SecurityState; parent=Health!System.Health.SecurityState; algorithm=WorstOf; unavailable-member policy=Error. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Open Health Explorer from the unhealthy DA, follow the failing health aspect and dependency to the named leaf object, and read its state-change context and knowledge. Check whether the object is an inventory-only reference or an authoritative monitor target. Record the complete root-to-leaf path.

### Corrective action and escalation

Repair the originating leaf condition using its specific runbook and owner. Do not reset or edit a parent DA to conceal child health. Missing relationships or wrong aspect routing require a source change, tests and a new sealed MP version.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm fresh healthy leaf evidence and follow recovery through each dependency back to the solution root. Unknown/unmonitored objects and absent optional capabilities must not be described as fully monitored healthy services.

### Microsoft references

[Microsoft Learn: manage consoles overview healthexplorer](https://learn.microsoft.com/en-us/system-center/scom/manage-consoles-overview-healthexplorer?view=sc-om-2025)


## Roll up Hyper-V Fabric availability {#hypervprivatecloud.enterprise.solution.fabric.availability.dependency.monitor}

`HyperVPrivateCloud.Enterprise.Solution.Fabric.Availability.Dependency.Monitor`

Rolls the availability state of every Hyper-V Fabric member into the Hyper-V Private Cloud solution.

### Support scope

A discovered identity, logical boundary, component group or health dependency in the private-cloud service model. Containment draws a diagram; only authored monitors and health dependencies determine its health.

Element: HyperVPrivateCloud.Enterprise.Solution.Fabric.Availability.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.Enterprise.Solution; relationship=HCSV2Library!HyperVPrivateCloud.SolutionContainsFabric; member monitor=Health!System.Health.AvailabilityState; parent=Health!System.Health.AvailabilityState; algorithm=WorstOf; unavailable-member policy=Success. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Open Health Explorer from the unhealthy DA, follow the failing health aspect and dependency to the named leaf object, and read its state-change context and knowledge. Check whether the object is an inventory-only reference or an authoritative monitor target. Record the complete root-to-leaf path.

### Corrective action and escalation

Repair the originating leaf condition using its specific runbook and owner. Do not reset or edit a parent DA to conceal child health. Missing relationships or wrong aspect routing require a source change, tests and a new sealed MP version.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm fresh healthy leaf evidence and follow recovery through each dependency back to the solution root. Unknown/unmonitored objects and absent optional capabilities must not be described as fully monitored healthy services.

### Microsoft references

[Microsoft Learn: manage consoles overview healthexplorer](https://learn.microsoft.com/en-us/system-center/scom/manage-consoles-overview-healthexplorer?view=sc-om-2025)


## Roll up Hyper-V Fabric performance {#hypervprivatecloud.enterprise.solution.fabric.performance.dependency.monitor}

`HyperVPrivateCloud.Enterprise.Solution.Fabric.Performance.Dependency.Monitor`

Rolls the performance state of every Hyper-V Fabric member into the Hyper-V Private Cloud solution.

### Support scope

A discovered identity, logical boundary, component group or health dependency in the private-cloud service model. Containment draws a diagram; only authored monitors and health dependencies determine its health.

Element: HyperVPrivateCloud.Enterprise.Solution.Fabric.Performance.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.Enterprise.Solution; relationship=HCSV2Library!HyperVPrivateCloud.SolutionContainsFabric; member monitor=Health!System.Health.PerformanceState; parent=Health!System.Health.PerformanceState; algorithm=WorstOf; unavailable-member policy=Success. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Open Health Explorer from the unhealthy DA, follow the failing health aspect and dependency to the named leaf object, and read its state-change context and knowledge. Check whether the object is an inventory-only reference or an authoritative monitor target. Record the complete root-to-leaf path.

### Corrective action and escalation

Repair the originating leaf condition using its specific runbook and owner. Do not reset or edit a parent DA to conceal child health. Missing relationships or wrong aspect routing require a source change, tests and a new sealed MP version.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm fresh healthy leaf evidence and follow recovery through each dependency back to the solution root. Unknown/unmonitored objects and absent optional capabilities must not be described as fully monitored healthy services.

### Microsoft references

[Microsoft Learn: manage consoles overview healthexplorer](https://learn.microsoft.com/en-us/system-center/scom/manage-consoles-overview-healthexplorer?view=sc-om-2025)


## Roll up Hyper-V Fabric configuration {#hypervprivatecloud.enterprise.solution.fabric.configuration.dependency.monitor}

`HyperVPrivateCloud.Enterprise.Solution.Fabric.Configuration.Dependency.Monitor`

Rolls the configuration state of every Hyper-V Fabric member into the Hyper-V Private Cloud solution.

### Support scope

A discovered identity, logical boundary, component group or health dependency in the private-cloud service model. Containment draws a diagram; only authored monitors and health dependencies determine its health.

Element: HyperVPrivateCloud.Enterprise.Solution.Fabric.Configuration.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.Enterprise.Solution; relationship=HCSV2Library!HyperVPrivateCloud.SolutionContainsFabric; member monitor=Health!System.Health.ConfigurationState; parent=Health!System.Health.ConfigurationState; algorithm=WorstOf; unavailable-member policy=Success. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Open Health Explorer from the unhealthy DA, follow the failing health aspect and dependency to the named leaf object, and read its state-change context and knowledge. Check whether the object is an inventory-only reference or an authoritative monitor target. Record the complete root-to-leaf path.

### Corrective action and escalation

Repair the originating leaf condition using its specific runbook and owner. Do not reset or edit a parent DA to conceal child health. Missing relationships or wrong aspect routing require a source change, tests and a new sealed MP version.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm fresh healthy leaf evidence and follow recovery through each dependency back to the solution root. Unknown/unmonitored objects and absent optional capabilities must not be described as fully monitored healthy services.

### Microsoft references

[Microsoft Learn: manage consoles overview healthexplorer](https://learn.microsoft.com/en-us/system-center/scom/manage-consoles-overview-healthexplorer?view=sc-om-2025)


## Roll up Hyper-V Fabric security {#hypervprivatecloud.enterprise.solution.fabric.security.dependency.monitor}

`HyperVPrivateCloud.Enterprise.Solution.Fabric.Security.Dependency.Monitor`

Rolls the security state of every Hyper-V Fabric member into the Hyper-V Private Cloud solution.

### Support scope

A discovered identity, logical boundary, component group or health dependency in the private-cloud service model. Containment draws a diagram; only authored monitors and health dependencies determine its health.

Element: HyperVPrivateCloud.Enterprise.Solution.Fabric.Security.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.Enterprise.Solution; relationship=HCSV2Library!HyperVPrivateCloud.SolutionContainsFabric; member monitor=Health!System.Health.SecurityState; parent=Health!System.Health.SecurityState; algorithm=WorstOf; unavailable-member policy=Success. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Open Health Explorer from the unhealthy DA, follow the failing health aspect and dependency to the named leaf object, and read its state-change context and knowledge. Check whether the object is an inventory-only reference or an authoritative monitor target. Record the complete root-to-leaf path.

### Corrective action and escalation

Repair the originating leaf condition using its specific runbook and owner. Do not reset or edit a parent DA to conceal child health. Missing relationships or wrong aspect routing require a source change, tests and a new sealed MP version.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm fresh healthy leaf evidence and follow recovery through each dependency back to the solution root. Unknown/unmonitored objects and absent optional capabilities must not be described as fully monitored healthy services.

### Microsoft references

[Microsoft Learn: manage consoles overview healthexplorer](https://learn.microsoft.com/en-us/system-center/scom/manage-consoles-overview-healthexplorer?view=sc-om-2025)


## Roll up Management Stack availability {#hypervprivatecloud.enterprise.solution.managementstack.availability.dependency.monitor}

`HyperVPrivateCloud.Enterprise.Solution.ManagementStack.Availability.Dependency.Monitor`

Rolls the availability state of every Management Stack member into the Hyper-V Private Cloud solution.

### Support scope

A discovered identity, logical boundary, component group or health dependency in the private-cloud service model. Containment draws a diagram; only authored monitors and health dependencies determine its health.

Element: HyperVPrivateCloud.Enterprise.Solution.ManagementStack.Availability.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.Enterprise.Solution; relationship=HCSV2Library!HyperVPrivateCloud.SolutionContainsManagementStack; member monitor=Health!System.Health.AvailabilityState; parent=Health!System.Health.AvailabilityState; algorithm=WorstOf; unavailable-member policy=Success. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Open Health Explorer from the unhealthy DA, follow the failing health aspect and dependency to the named leaf object, and read its state-change context and knowledge. Check whether the object is an inventory-only reference or an authoritative monitor target. Record the complete root-to-leaf path.

### Corrective action and escalation

Repair the originating leaf condition using its specific runbook and owner. Do not reset or edit a parent DA to conceal child health. Missing relationships or wrong aspect routing require a source change, tests and a new sealed MP version.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm fresh healthy leaf evidence and follow recovery through each dependency back to the solution root. Unknown/unmonitored objects and absent optional capabilities must not be described as fully monitored healthy services.

### Microsoft references

[Microsoft Learn: manage consoles overview healthexplorer](https://learn.microsoft.com/en-us/system-center/scom/manage-consoles-overview-healthexplorer?view=sc-om-2025)


## Roll up Management Stack performance {#hypervprivatecloud.enterprise.solution.managementstack.performance.dependency.monitor}

`HyperVPrivateCloud.Enterprise.Solution.ManagementStack.Performance.Dependency.Monitor`

Rolls the performance state of every Management Stack member into the Hyper-V Private Cloud solution.

### Support scope

A discovered identity, logical boundary, component group or health dependency in the private-cloud service model. Containment draws a diagram; only authored monitors and health dependencies determine its health.

Element: HyperVPrivateCloud.Enterprise.Solution.ManagementStack.Performance.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.Enterprise.Solution; relationship=HCSV2Library!HyperVPrivateCloud.SolutionContainsManagementStack; member monitor=Health!System.Health.PerformanceState; parent=Health!System.Health.PerformanceState; algorithm=WorstOf; unavailable-member policy=Success. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Open Health Explorer from the unhealthy DA, follow the failing health aspect and dependency to the named leaf object, and read its state-change context and knowledge. Check whether the object is an inventory-only reference or an authoritative monitor target. Record the complete root-to-leaf path.

### Corrective action and escalation

Repair the originating leaf condition using its specific runbook and owner. Do not reset or edit a parent DA to conceal child health. Missing relationships or wrong aspect routing require a source change, tests and a new sealed MP version.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm fresh healthy leaf evidence and follow recovery through each dependency back to the solution root. Unknown/unmonitored objects and absent optional capabilities must not be described as fully monitored healthy services.

### Microsoft references

[Microsoft Learn: manage consoles overview healthexplorer](https://learn.microsoft.com/en-us/system-center/scom/manage-consoles-overview-healthexplorer?view=sc-om-2025)


## Roll up Management Stack configuration {#hypervprivatecloud.enterprise.solution.managementstack.configuration.dependency.monitor}

`HyperVPrivateCloud.Enterprise.Solution.ManagementStack.Configuration.Dependency.Monitor`

Rolls the configuration state of every Management Stack member into the Hyper-V Private Cloud solution.

### Support scope

A discovered identity, logical boundary, component group or health dependency in the private-cloud service model. Containment draws a diagram; only authored monitors and health dependencies determine its health.

Element: HyperVPrivateCloud.Enterprise.Solution.ManagementStack.Configuration.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.Enterprise.Solution; relationship=HCSV2Library!HyperVPrivateCloud.SolutionContainsManagementStack; member monitor=Health!System.Health.ConfigurationState; parent=Health!System.Health.ConfigurationState; algorithm=WorstOf; unavailable-member policy=Success. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Open Health Explorer from the unhealthy DA, follow the failing health aspect and dependency to the named leaf object, and read its state-change context and knowledge. Check whether the object is an inventory-only reference or an authoritative monitor target. Record the complete root-to-leaf path.

### Corrective action and escalation

Repair the originating leaf condition using its specific runbook and owner. Do not reset or edit a parent DA to conceal child health. Missing relationships or wrong aspect routing require a source change, tests and a new sealed MP version.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm fresh healthy leaf evidence and follow recovery through each dependency back to the solution root. Unknown/unmonitored objects and absent optional capabilities must not be described as fully monitored healthy services.

### Microsoft references

[Microsoft Learn: manage consoles overview healthexplorer](https://learn.microsoft.com/en-us/system-center/scom/manage-consoles-overview-healthexplorer?view=sc-om-2025)


## Roll up Management Stack security {#hypervprivatecloud.enterprise.solution.managementstack.security.dependency.monitor}

`HyperVPrivateCloud.Enterprise.Solution.ManagementStack.Security.Dependency.Monitor`

Rolls the security state of every Management Stack member into the Hyper-V Private Cloud solution.

### Support scope

A discovered identity, logical boundary, component group or health dependency in the private-cloud service model. Containment draws a diagram; only authored monitors and health dependencies determine its health.

Element: HyperVPrivateCloud.Enterprise.Solution.ManagementStack.Security.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.Enterprise.Solution; relationship=HCSV2Library!HyperVPrivateCloud.SolutionContainsManagementStack; member monitor=Health!System.Health.SecurityState; parent=Health!System.Health.SecurityState; algorithm=WorstOf; unavailable-member policy=Success. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Open Health Explorer from the unhealthy DA, follow the failing health aspect and dependency to the named leaf object, and read its state-change context and knowledge. Check whether the object is an inventory-only reference or an authoritative monitor target. Record the complete root-to-leaf path.

### Corrective action and escalation

Repair the originating leaf condition using its specific runbook and owner. Do not reset or edit a parent DA to conceal child health. Missing relationships or wrong aspect routing require a source change, tests and a new sealed MP version.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm fresh healthy leaf evidence and follow recovery through each dependency back to the solution root. Unknown/unmonitored objects and absent optional capabilities must not be described as fully monitored healthy services.

### Microsoft references

[Microsoft Learn: manage consoles overview healthexplorer](https://learn.microsoft.com/en-us/system-center/scom/manage-consoles-overview-healthexplorer?view=sc-om-2025)


## Roll up private cloud boundary availability {#hypervprivatecloud.enterprise.fabric.service.availability.dependency.monitor}

`HyperVPrivateCloud.Enterprise.Fabric.Service.Availability.Dependency.Monitor`

Rolls the availability state of every private cloud boundary member into the Hyper-V Fabric.

### Support scope

A discovered identity, logical boundary, component group or health dependency in the private-cloud service model. Containment draws a diagram; only authored monitors and health dependencies determine its health.

Element: HyperVPrivateCloud.Enterprise.Fabric.Service.Availability.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.Enterprise.Fabric; relationship=HCSV2Library!HyperVPrivateCloud.FabricContainsService; member monitor=Health!System.Health.AvailabilityState; parent=Health!System.Health.AvailabilityState; algorithm=WorstOf; unavailable-member policy=Success. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Open Health Explorer from the unhealthy DA, follow the failing health aspect and dependency to the named leaf object, and read its state-change context and knowledge. Check whether the object is an inventory-only reference or an authoritative monitor target. Record the complete root-to-leaf path.

### Corrective action and escalation

Repair the originating leaf condition using its specific runbook and owner. Do not reset or edit a parent DA to conceal child health. Missing relationships or wrong aspect routing require a source change, tests and a new sealed MP version.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm fresh healthy leaf evidence and follow recovery through each dependency back to the solution root. Unknown/unmonitored objects and absent optional capabilities must not be described as fully monitored healthy services.

### Microsoft references

[Microsoft Learn: manage consoles overview healthexplorer](https://learn.microsoft.com/en-us/system-center/scom/manage-consoles-overview-healthexplorer?view=sc-om-2025)


## Roll up private cloud boundary performance {#hypervprivatecloud.enterprise.fabric.service.performance.dependency.monitor}

`HyperVPrivateCloud.Enterprise.Fabric.Service.Performance.Dependency.Monitor`

Rolls the performance state of every private cloud boundary member into the Hyper-V Fabric.

### Support scope

A discovered identity, logical boundary, component group or health dependency in the private-cloud service model. Containment draws a diagram; only authored monitors and health dependencies determine its health.

Element: HyperVPrivateCloud.Enterprise.Fabric.Service.Performance.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.Enterprise.Fabric; relationship=HCSV2Library!HyperVPrivateCloud.FabricContainsService; member monitor=Health!System.Health.PerformanceState; parent=Health!System.Health.PerformanceState; algorithm=WorstOf; unavailable-member policy=Success. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Open Health Explorer from the unhealthy DA, follow the failing health aspect and dependency to the named leaf object, and read its state-change context and knowledge. Check whether the object is an inventory-only reference or an authoritative monitor target. Record the complete root-to-leaf path.

### Corrective action and escalation

Repair the originating leaf condition using its specific runbook and owner. Do not reset or edit a parent DA to conceal child health. Missing relationships or wrong aspect routing require a source change, tests and a new sealed MP version.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm fresh healthy leaf evidence and follow recovery through each dependency back to the solution root. Unknown/unmonitored objects and absent optional capabilities must not be described as fully monitored healthy services.

### Microsoft references

[Microsoft Learn: manage consoles overview healthexplorer](https://learn.microsoft.com/en-us/system-center/scom/manage-consoles-overview-healthexplorer?view=sc-om-2025)


## Roll up private cloud boundary configuration {#hypervprivatecloud.enterprise.fabric.service.configuration.dependency.monitor}

`HyperVPrivateCloud.Enterprise.Fabric.Service.Configuration.Dependency.Monitor`

Rolls the configuration state of every private cloud boundary member into the Hyper-V Fabric.

### Support scope

A discovered identity, logical boundary, component group or health dependency in the private-cloud service model. Containment draws a diagram; only authored monitors and health dependencies determine its health.

Element: HyperVPrivateCloud.Enterprise.Fabric.Service.Configuration.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.Enterprise.Fabric; relationship=HCSV2Library!HyperVPrivateCloud.FabricContainsService; member monitor=Health!System.Health.ConfigurationState; parent=Health!System.Health.ConfigurationState; algorithm=WorstOf; unavailable-member policy=Success. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Open Health Explorer from the unhealthy DA, follow the failing health aspect and dependency to the named leaf object, and read its state-change context and knowledge. Check whether the object is an inventory-only reference or an authoritative monitor target. Record the complete root-to-leaf path.

### Corrective action and escalation

Repair the originating leaf condition using its specific runbook and owner. Do not reset or edit a parent DA to conceal child health. Missing relationships or wrong aspect routing require a source change, tests and a new sealed MP version.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm fresh healthy leaf evidence and follow recovery through each dependency back to the solution root. Unknown/unmonitored objects and absent optional capabilities must not be described as fully monitored healthy services.

### Microsoft references

[Microsoft Learn: manage consoles overview healthexplorer](https://learn.microsoft.com/en-us/system-center/scom/manage-consoles-overview-healthexplorer?view=sc-om-2025)


## Roll up private cloud boundary security {#hypervprivatecloud.enterprise.fabric.service.security.dependency.monitor}

`HyperVPrivateCloud.Enterprise.Fabric.Service.Security.Dependency.Monitor`

Rolls the security state of every private cloud boundary member into the Hyper-V Fabric.

### Support scope

A discovered identity, logical boundary, component group or health dependency in the private-cloud service model. Containment draws a diagram; only authored monitors and health dependencies determine its health.

Element: HyperVPrivateCloud.Enterprise.Fabric.Service.Security.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.Enterprise.Fabric; relationship=HCSV2Library!HyperVPrivateCloud.FabricContainsService; member monitor=Health!System.Health.SecurityState; parent=Health!System.Health.SecurityState; algorithm=WorstOf; unavailable-member policy=Success. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Open Health Explorer from the unhealthy DA, follow the failing health aspect and dependency to the named leaf object, and read its state-change context and knowledge. Check whether the object is an inventory-only reference or an authoritative monitor target. Record the complete root-to-leaf path.

### Corrective action and escalation

Repair the originating leaf condition using its specific runbook and owner. Do not reset or edit a parent DA to conceal child health. Missing relationships or wrong aspect routing require a source change, tests and a new sealed MP version.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm fresh healthy leaf evidence and follow recovery through each dependency back to the solution root. Unknown/unmonitored objects and absent optional capabilities must not be described as fully monitored healthy services.

### Microsoft references

[Microsoft Learn: manage consoles overview healthexplorer](https://learn.microsoft.com/en-us/system-center/scom/manage-consoles-overview-healthexplorer?view=sc-om-2025)


## Roll up host management availability {#hypervprivatecloud.enterprise.managementstack.management.availability.dependency.monitor}

`HyperVPrivateCloud.Enterprise.ManagementStack.Management.Availability.Dependency.Monitor`

Rolls the availability state of every host management member into the Management Stack.

### Support scope

A discovered identity, logical boundary, component group or health dependency in the private-cloud service model. Containment draws a diagram; only authored monitors and health dependencies determine its health.

Element: HyperVPrivateCloud.Enterprise.ManagementStack.Management.Availability.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.Enterprise.ManagementStack; relationship=HCSV2Library!HyperVPrivateCloud.ManagementStackContainsManagementComponent; member monitor=Health!System.Health.AvailabilityState; parent=Health!System.Health.AvailabilityState; algorithm=WorstOf; unavailable-member policy=Success. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Open Health Explorer from the unhealthy DA, follow the failing health aspect and dependency to the named leaf object, and read its state-change context and knowledge. Check whether the object is an inventory-only reference or an authoritative monitor target. Record the complete root-to-leaf path.

### Corrective action and escalation

Repair the originating leaf condition using its specific runbook and owner. Do not reset or edit a parent DA to conceal child health. Missing relationships or wrong aspect routing require a source change, tests and a new sealed MP version.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm fresh healthy leaf evidence and follow recovery through each dependency back to the solution root. Unknown/unmonitored objects and absent optional capabilities must not be described as fully monitored healthy services.

### Microsoft references

[Microsoft Learn: manage consoles overview healthexplorer](https://learn.microsoft.com/en-us/system-center/scom/manage-consoles-overview-healthexplorer?view=sc-om-2025)


## Roll up host management performance {#hypervprivatecloud.enterprise.managementstack.management.performance.dependency.monitor}

`HyperVPrivateCloud.Enterprise.ManagementStack.Management.Performance.Dependency.Monitor`

Rolls the performance state of every host management member into the Management Stack.

### Support scope

A discovered identity, logical boundary, component group or health dependency in the private-cloud service model. Containment draws a diagram; only authored monitors and health dependencies determine its health.

Element: HyperVPrivateCloud.Enterprise.ManagementStack.Management.Performance.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.Enterprise.ManagementStack; relationship=HCSV2Library!HyperVPrivateCloud.ManagementStackContainsManagementComponent; member monitor=Health!System.Health.PerformanceState; parent=Health!System.Health.PerformanceState; algorithm=WorstOf; unavailable-member policy=Success. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Open Health Explorer from the unhealthy DA, follow the failing health aspect and dependency to the named leaf object, and read its state-change context and knowledge. Check whether the object is an inventory-only reference or an authoritative monitor target. Record the complete root-to-leaf path.

### Corrective action and escalation

Repair the originating leaf condition using its specific runbook and owner. Do not reset or edit a parent DA to conceal child health. Missing relationships or wrong aspect routing require a source change, tests and a new sealed MP version.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm fresh healthy leaf evidence and follow recovery through each dependency back to the solution root. Unknown/unmonitored objects and absent optional capabilities must not be described as fully monitored healthy services.

### Microsoft references

[Microsoft Learn: manage consoles overview healthexplorer](https://learn.microsoft.com/en-us/system-center/scom/manage-consoles-overview-healthexplorer?view=sc-om-2025)


## Roll up host management configuration {#hypervprivatecloud.enterprise.managementstack.management.configuration.dependency.monitor}

`HyperVPrivateCloud.Enterprise.ManagementStack.Management.Configuration.Dependency.Monitor`

Rolls the configuration state of every host management member into the Management Stack.

### Support scope

A discovered identity, logical boundary, component group or health dependency in the private-cloud service model. Containment draws a diagram; only authored monitors and health dependencies determine its health.

Element: HyperVPrivateCloud.Enterprise.ManagementStack.Management.Configuration.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.Enterprise.ManagementStack; relationship=HCSV2Library!HyperVPrivateCloud.ManagementStackContainsManagementComponent; member monitor=Health!System.Health.ConfigurationState; parent=Health!System.Health.ConfigurationState; algorithm=WorstOf; unavailable-member policy=Success. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Open Health Explorer from the unhealthy DA, follow the failing health aspect and dependency to the named leaf object, and read its state-change context and knowledge. Check whether the object is an inventory-only reference or an authoritative monitor target. Record the complete root-to-leaf path.

### Corrective action and escalation

Repair the originating leaf condition using its specific runbook and owner. Do not reset or edit a parent DA to conceal child health. Missing relationships or wrong aspect routing require a source change, tests and a new sealed MP version.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm fresh healthy leaf evidence and follow recovery through each dependency back to the solution root. Unknown/unmonitored objects and absent optional capabilities must not be described as fully monitored healthy services.

### Microsoft references

[Microsoft Learn: manage consoles overview healthexplorer](https://learn.microsoft.com/en-us/system-center/scom/manage-consoles-overview-healthexplorer?view=sc-om-2025)


## Roll up host management security {#hypervprivatecloud.enterprise.managementstack.management.security.dependency.monitor}

`HyperVPrivateCloud.Enterprise.ManagementStack.Management.Security.Dependency.Monitor`

Rolls the security state of every host management member into the Management Stack.

### Support scope

A discovered identity, logical boundary, component group or health dependency in the private-cloud service model. Containment draws a diagram; only authored monitors and health dependencies determine its health.

Element: HyperVPrivateCloud.Enterprise.ManagementStack.Management.Security.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.Enterprise.ManagementStack; relationship=HCSV2Library!HyperVPrivateCloud.ManagementStackContainsManagementComponent; member monitor=Health!System.Health.SecurityState; parent=Health!System.Health.SecurityState; algorithm=WorstOf; unavailable-member policy=Success. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Open Health Explorer from the unhealthy DA, follow the failing health aspect and dependency to the named leaf object, and read its state-change context and knowledge. Check whether the object is an inventory-only reference or an authoritative monitor target. Record the complete root-to-leaf path.

### Corrective action and escalation

Repair the originating leaf condition using its specific runbook and owner. Do not reset or edit a parent DA to conceal child health. Missing relationships or wrong aspect routing require a source change, tests and a new sealed MP version.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm fresh healthy leaf evidence and follow recovery through each dependency back to the solution root. Unknown/unmonitored objects and absent optional capabilities must not be described as fully monitored healthy services.

### Microsoft references

[Microsoft Learn: manage consoles overview healthexplorer](https://learn.microsoft.com/en-us/system-center/scom/manage-consoles-overview-healthexplorer?view=sc-om-2025)


## Roll up monitoring pipeline availability {#hypervprivatecloud.enterprise.managementstack.monitoring.availability.dependency.monitor}

`HyperVPrivateCloud.Enterprise.ManagementStack.Monitoring.Availability.Dependency.Monitor`

Rolls the availability state of every monitoring pipeline member into the Management Stack.

### Support scope

A discovered identity, logical boundary, component group or health dependency in the private-cloud service model. Containment draws a diagram; only authored monitors and health dependencies determine its health.

Element: HyperVPrivateCloud.Enterprise.ManagementStack.Monitoring.Availability.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.Enterprise.ManagementStack; relationship=HCSV2Library!HyperVPrivateCloud.ManagementStackContainsMonitoringComponent; member monitor=Health!System.Health.AvailabilityState; parent=Health!System.Health.AvailabilityState; algorithm=WorstOf; unavailable-member policy=Success. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Open Health Explorer from the unhealthy DA, follow the failing health aspect and dependency to the named leaf object, and read its state-change context and knowledge. Check whether the object is an inventory-only reference or an authoritative monitor target. Record the complete root-to-leaf path.

### Corrective action and escalation

Repair the originating leaf condition using its specific runbook and owner. Do not reset or edit a parent DA to conceal child health. Missing relationships or wrong aspect routing require a source change, tests and a new sealed MP version.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm fresh healthy leaf evidence and follow recovery through each dependency back to the solution root. Unknown/unmonitored objects and absent optional capabilities must not be described as fully monitored healthy services.

### Microsoft references

[Microsoft Learn: manage consoles overview healthexplorer](https://learn.microsoft.com/en-us/system-center/scom/manage-consoles-overview-healthexplorer?view=sc-om-2025)


## Roll up monitoring pipeline performance {#hypervprivatecloud.enterprise.managementstack.monitoring.performance.dependency.monitor}

`HyperVPrivateCloud.Enterprise.ManagementStack.Monitoring.Performance.Dependency.Monitor`

Rolls the performance state of every monitoring pipeline member into the Management Stack.

### Support scope

A discovered identity, logical boundary, component group or health dependency in the private-cloud service model. Containment draws a diagram; only authored monitors and health dependencies determine its health.

Element: HyperVPrivateCloud.Enterprise.ManagementStack.Monitoring.Performance.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.Enterprise.ManagementStack; relationship=HCSV2Library!HyperVPrivateCloud.ManagementStackContainsMonitoringComponent; member monitor=Health!System.Health.PerformanceState; parent=Health!System.Health.PerformanceState; algorithm=WorstOf; unavailable-member policy=Success. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Open Health Explorer from the unhealthy DA, follow the failing health aspect and dependency to the named leaf object, and read its state-change context and knowledge. Check whether the object is an inventory-only reference or an authoritative monitor target. Record the complete root-to-leaf path.

### Corrective action and escalation

Repair the originating leaf condition using its specific runbook and owner. Do not reset or edit a parent DA to conceal child health. Missing relationships or wrong aspect routing require a source change, tests and a new sealed MP version.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm fresh healthy leaf evidence and follow recovery through each dependency back to the solution root. Unknown/unmonitored objects and absent optional capabilities must not be described as fully monitored healthy services.

### Microsoft references

[Microsoft Learn: manage consoles overview healthexplorer](https://learn.microsoft.com/en-us/system-center/scom/manage-consoles-overview-healthexplorer?view=sc-om-2025)


## Roll up monitoring pipeline configuration {#hypervprivatecloud.enterprise.managementstack.monitoring.configuration.dependency.monitor}

`HyperVPrivateCloud.Enterprise.ManagementStack.Monitoring.Configuration.Dependency.Monitor`

Rolls the configuration state of every monitoring pipeline member into the Management Stack.

### Support scope

A discovered identity, logical boundary, component group or health dependency in the private-cloud service model. Containment draws a diagram; only authored monitors and health dependencies determine its health.

Element: HyperVPrivateCloud.Enterprise.ManagementStack.Monitoring.Configuration.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.Enterprise.ManagementStack; relationship=HCSV2Library!HyperVPrivateCloud.ManagementStackContainsMonitoringComponent; member monitor=Health!System.Health.ConfigurationState; parent=Health!System.Health.ConfigurationState; algorithm=WorstOf; unavailable-member policy=Success. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Open Health Explorer from the unhealthy DA, follow the failing health aspect and dependency to the named leaf object, and read its state-change context and knowledge. Check whether the object is an inventory-only reference or an authoritative monitor target. Record the complete root-to-leaf path.

### Corrective action and escalation

Repair the originating leaf condition using its specific runbook and owner. Do not reset or edit a parent DA to conceal child health. Missing relationships or wrong aspect routing require a source change, tests and a new sealed MP version.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm fresh healthy leaf evidence and follow recovery through each dependency back to the solution root. Unknown/unmonitored objects and absent optional capabilities must not be described as fully monitored healthy services.

### Microsoft references

[Microsoft Learn: manage consoles overview healthexplorer](https://learn.microsoft.com/en-us/system-center/scom/manage-consoles-overview-healthexplorer?view=sc-om-2025)


## Roll up monitoring pipeline security {#hypervprivatecloud.enterprise.managementstack.monitoring.security.dependency.monitor}

`HyperVPrivateCloud.Enterprise.ManagementStack.Monitoring.Security.Dependency.Monitor`

Rolls the security state of every monitoring pipeline member into the Management Stack.

### Support scope

A discovered identity, logical boundary, component group or health dependency in the private-cloud service model. Containment draws a diagram; only authored monitors and health dependencies determine its health.

Element: HyperVPrivateCloud.Enterprise.ManagementStack.Monitoring.Security.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.Enterprise.ManagementStack; relationship=HCSV2Library!HyperVPrivateCloud.ManagementStackContainsMonitoringComponent; member monitor=Health!System.Health.SecurityState; parent=Health!System.Health.SecurityState; algorithm=WorstOf; unavailable-member policy=Success. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Open Health Explorer from the unhealthy DA, follow the failing health aspect and dependency to the named leaf object, and read its state-change context and knowledge. Check whether the object is an inventory-only reference or an authoritative monitor target. Record the complete root-to-leaf path.

### Corrective action and escalation

Repair the originating leaf condition using its specific runbook and owner. Do not reset or edit a parent DA to conceal child health. Missing relationships or wrong aspect routing require a source change, tests and a new sealed MP version.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm fresh healthy leaf evidence and follow recovery through each dependency back to the solution root. Unknown/unmonitored objects and absent optional capabilities must not be described as fully monitored healthy services.

### Microsoft references

[Microsoft Learn: manage consoles overview healthexplorer](https://learn.microsoft.com/en-us/system-center/scom/manage-consoles-overview-healthexplorer?view=sc-om-2025)


## Roll up Hyper-V management service (VMMS) availability into Management {#hypervprivatecloud.management.members.availability.dependency.monitor}

`HyperVPrivateCloud.Management.Members.Availability.Dependency.Monitor`

Dependency roll-up through the Management Component Contains Host Role relationship.

### Support scope

A discovered identity, logical boundary, component group or health dependency in the private-cloud service model. Containment draws a diagram; only authored monitors and health dependencies determine its health.

Element: HyperVPrivateCloud.Management.Members.Availability.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.ManagementComponent; relationship=HCSV2Library!HyperVPrivateCloud.ManagementComponentContainsHostRole; member monitor=HyperVPrivateCloud.Host.VMMS.Monitor; parent=Health!System.Health.AvailabilityState; algorithm=WorstOf; unavailable-member policy=Success. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Open Health Explorer from the unhealthy DA, follow the failing health aspect and dependency to the named leaf object, and read its state-change context and knowledge. Check whether the object is an inventory-only reference or an authoritative monitor target. Record the complete root-to-leaf path.

### Corrective action and escalation

Repair the originating leaf condition using its specific runbook and owner. Do not reset or edit a parent DA to conceal child health. Missing relationships or wrong aspect routing require a source change, tests and a new sealed MP version.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm fresh healthy leaf evidence and follow recovery through each dependency back to the solution root. Unknown/unmonitored objects and absent optional capabilities must not be described as fully monitored healthy services.

### Microsoft references

[Microsoft Learn: manage consoles overview healthexplorer](https://learn.microsoft.com/en-us/system-center/scom/manage-consoles-overview-healthexplorer?view=sc-om-2025)


## Roll up Host Compute Service availability into Management {#hypervprivatecloud.management.members.hostcompute.availability.dependency.monitor}

`HyperVPrivateCloud.Management.Members.HostCompute.Availability.Dependency.Monitor`

Dependency roll-up through the Management Component Contains Host Role relationship.

### Support scope

A discovered identity, logical boundary, component group or health dependency in the private-cloud service model. Containment draws a diagram; only authored monitors and health dependencies determine its health.

Element: HyperVPrivateCloud.Management.Members.HostCompute.Availability.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.ManagementComponent; relationship=HCSV2Library!HyperVPrivateCloud.ManagementComponentContainsHostRole; member monitor=HyperVPrivateCloud.Host.VmCompute.Monitor; parent=Health!System.Health.AvailabilityState; algorithm=WorstOf; unavailable-member policy=Success. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Open Health Explorer from the unhealthy DA, follow the failing health aspect and dependency to the named leaf object, and read its state-change context and knowledge. Check whether the object is an inventory-only reference or an authoritative monitor target. Record the complete root-to-leaf path.

### Corrective action and escalation

Repair the originating leaf condition using its specific runbook and owner. Do not reset or edit a parent DA to conceal child health. Missing relationships or wrong aspect routing require a source change, tests and a new sealed MP version.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm fresh healthy leaf evidence and follow recovery through each dependency back to the solution root. Unknown/unmonitored objects and absent optional capabilities must not be described as fully monitored healthy services.

### Microsoft references

[Microsoft Learn: manage consoles overview healthexplorer](https://learn.microsoft.com/en-us/system-center/scom/manage-consoles-overview-healthexplorer?view=sc-om-2025)


## Roll up hypervisor availability into Management {#hypervprivatecloud.management.members.hypervisor.availability.dependency.monitor}

`HyperVPrivateCloud.Management.Members.Hypervisor.Availability.Dependency.Monitor`

Dependency roll-up through the Management Component Contains Host Role relationship.

### Support scope

A discovered identity, logical boundary, component group or health dependency in the private-cloud service model. Containment draws a diagram; only authored monitors and health dependencies determine its health.

Element: HyperVPrivateCloud.Management.Members.Hypervisor.Availability.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.ManagementComponent; relationship=HCSV2Library!HyperVPrivateCloud.ManagementComponentContainsHostRole; member monitor=HyperVPrivateCloud.Host.Hypervisor.Monitor; parent=Health!System.Health.AvailabilityState; algorithm=WorstOf; unavailable-member policy=Success. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Open Health Explorer from the unhealthy DA, follow the failing health aspect and dependency to the named leaf object, and read its state-change context and knowledge. Check whether the object is an inventory-only reference or an authoritative monitor target. Record the complete root-to-leaf path.

### Corrective action and escalation

Repair the originating leaf condition using its specific runbook and owner. Do not reset or edit a parent DA to conceal child health. Missing relationships or wrong aspect routing require a source change, tests and a new sealed MP version.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm fresh healthy leaf evidence and follow recovery through each dependency back to the solution root. Unknown/unmonitored objects and absent optional capabilities must not be described as fully monitored healthy services.

### Microsoft references

[Microsoft Learn: manage consoles overview healthexplorer](https://learn.microsoft.com/en-us/system-center/scom/manage-consoles-overview-healthexplorer?view=sc-om-2025)


## Roll up Active Directory domain health into Management {#hypervprivatecloud.management.members.domain.availability.dependency.monitor}

`HyperVPrivateCloud.Management.Members.Domain.Availability.Dependency.Monitor`

Dependency roll-up through the Management Component Contains Host Role relationship.

### Support scope

A discovered identity, logical boundary, component group or health dependency in the private-cloud service model. Containment draws a diagram; only authored monitors and health dependencies determine its health.

Element: HyperVPrivateCloud.Management.Members.Domain.Availability.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.ManagementComponent; relationship=HCSV2Library!HyperVPrivateCloud.ManagementComponentContainsHostRole; member monitor=HyperVPrivateCloud.Host.DomainHealth.Monitor; parent=Health!System.Health.AvailabilityState; algorithm=WorstOf; unavailable-member policy=Success. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Open Health Explorer from the unhealthy DA, follow the failing health aspect and dependency to the named leaf object, and read its state-change context and knowledge. Check whether the object is an inventory-only reference or an authoritative monitor target. Record the complete root-to-leaf path.

### Corrective action and escalation

Repair the originating leaf condition using its specific runbook and owner. Do not reset or edit a parent DA to conceal child health. Missing relationships or wrong aspect routing require a source change, tests and a new sealed MP version.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm fresh healthy leaf evidence and follow recovery through each dependency back to the solution root. Unknown/unmonitored objects and absent optional capabilities must not be described as fully monitored healthy services.

### Microsoft references

[Microsoft Learn: manage consoles overview healthexplorer](https://learn.microsoft.com/en-us/system-center/scom/manage-consoles-overview-healthexplorer?view=sc-om-2025)


## Roll up DNS infrastructure resolution health into Management {#hypervprivatecloud.management.members.dns.availability.dependency.monitor}

`HyperVPrivateCloud.Management.Members.Dns.Availability.Dependency.Monitor`

Dependency roll-up through the Management Component Contains Host Role relationship.

### Support scope

DNS service or name-resolution dependency as tested by the configured probe, not proof that every zone or client is healthy.

Element: HyperVPrivateCloud.Management.Members.Dns.Availability.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.ManagementComponent; relationship=HCSV2Library!HyperVPrivateCloud.ManagementComponentContainsHostRole; member monitor=HyperVPrivateCloud.Host.DnsHealth.Monitor; parent=Health!System.Health.AvailabilityState; algorithm=WorstOf; unavailable-member policy=Success. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Run the DNS diagnostic on the affected host. Record queried name/type, configured resolver, response/error and forward/SRV results. Compare another resolver and another client to distinguish client configuration, path and authoritative-server failures.

### Corrective action and escalation

Correct the proven resolver, zone, record, forwarding or network issue with the DNS owner. Avoid global cache flushes or DNS-service restarts without a specific reason.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Repeat the same failing query from the original host and confirm fresh monitoring evidence, not merely a cached successful answer from another machine.

### Microsoft references

[Microsoft Learn: troubleshoot dns guidance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/networking/troubleshoot-dns-guidance)

[Microsoft Learn: troubleshoot dns server](https://learn.microsoft.com/en-us/windows-server/networking/dns/troubleshoot/troubleshoot-dns-server)


## Roll up bare-metal deployment service health into Management {#hypervprivatecloud.management.members.deployment.configuration.dependency.monitor}

`HyperVPrivateCloud.Management.Members.Deployment.Configuration.Dependency.Monitor`

Dependency roll-up through the Management Component Contains Host Role relationship.

### Support scope

A discovered identity, logical boundary, component group or health dependency in the private-cloud service model. Containment draws a diagram; only authored monitors and health dependencies determine its health.

Element: HyperVPrivateCloud.Management.Members.Deployment.Configuration.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.ManagementComponent; relationship=HCSV2Library!HyperVPrivateCloud.ManagementComponentContainsHostRole; member monitor=HyperVPrivateCloud.Host.DeploymentService.Monitor; parent=Health!System.Health.ConfigurationState; algorithm=WorstOf; unavailable-member policy=Success. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Open Health Explorer from the unhealthy DA, follow the failing health aspect and dependency to the named leaf object, and read its state-change context and knowledge. Check whether the object is an inventory-only reference or an authoritative monitor target. Record the complete root-to-leaf path.

### Corrective action and escalation

Repair the originating leaf condition using its specific runbook and owner. Do not reset or edit a parent DA to conceal child health. Missing relationships or wrong aspect routing require a source change, tests and a new sealed MP version.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm fresh healthy leaf evidence and follow recovery through each dependency back to the solution root. Unknown/unmonitored objects and absent optional capabilities must not be described as fully monitored healthy services.

### Microsoft references

[Microsoft Learn: manage consoles overview healthexplorer](https://learn.microsoft.com/en-us/system-center/scom/manage-consoles-overview-healthexplorer?view=sc-om-2025)


## Roll up Hyper-V host availability into Compute {#hypervprivatecloud.compute.members.availability.dependency.monitor}

`HyperVPrivateCloud.Compute.Members.Availability.Dependency.Monitor`

Dependency roll-up through the Compute Component Contains Host Role relationship.

### Support scope

A discovered identity, logical boundary, component group or health dependency in the private-cloud service model. Containment draws a diagram; only authored monitors and health dependencies determine its health.

Element: HyperVPrivateCloud.Compute.Members.Availability.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.ComputeComponent; relationship=HCSV2Library!HyperVPrivateCloud.ComputeComponentContainsHostRole; member monitor=Health!System.Health.AvailabilityState; parent=Health!System.Health.AvailabilityState; algorithm=WorstOf; unavailable-member policy=Error. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Open Health Explorer from the unhealthy DA, follow the failing health aspect and dependency to the named leaf object, and read its state-change context and knowledge. Check whether the object is an inventory-only reference or an authoritative monitor target. Record the complete root-to-leaf path.

### Corrective action and escalation

Repair the originating leaf condition using its specific runbook and owner. Do not reset or edit a parent DA to conceal child health. Missing relationships or wrong aspect routing require a source change, tests and a new sealed MP version.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm fresh healthy leaf evidence and follow recovery through each dependency back to the solution root. Unknown/unmonitored objects and absent optional capabilities must not be described as fully monitored healthy services.

### Microsoft references

[Microsoft Learn: manage consoles overview healthexplorer](https://learn.microsoft.com/en-us/system-center/scom/manage-consoles-overview-healthexplorer?view=sc-om-2025)


## Roll up Hyper-V host performance into Compute {#hypervprivatecloud.compute.members.performance.dependency.monitor}

`HyperVPrivateCloud.Compute.Members.Performance.Dependency.Monitor`

Dependency roll-up through the Compute Component Contains Host Role relationship.

### Support scope

A discovered identity, logical boundary, component group or health dependency in the private-cloud service model. Containment draws a diagram; only authored monitors and health dependencies determine its health.

Element: HyperVPrivateCloud.Compute.Members.Performance.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.ComputeComponent; relationship=HCSV2Library!HyperVPrivateCloud.ComputeComponentContainsHostRole; member monitor=Health!System.Health.PerformanceState; parent=Health!System.Health.PerformanceState; algorithm=WorstOf; unavailable-member policy=Success. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Open Health Explorer from the unhealthy DA, follow the failing health aspect and dependency to the named leaf object, and read its state-change context and knowledge. Check whether the object is an inventory-only reference or an authoritative monitor target. Record the complete root-to-leaf path.

### Corrective action and escalation

Repair the originating leaf condition using its specific runbook and owner. Do not reset or edit a parent DA to conceal child health. Missing relationships or wrong aspect routing require a source change, tests and a new sealed MP version.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm fresh healthy leaf evidence and follow recovery through each dependency back to the solution root. Unknown/unmonitored objects and absent optional capabilities must not be described as fully monitored healthy services.

### Microsoft references

[Microsoft Learn: manage consoles overview healthexplorer](https://learn.microsoft.com/en-us/system-center/scom/manage-consoles-overview-healthexplorer?view=sc-om-2025)


## Roll up Hyper-V host configuration into Compute {#hypervprivatecloud.compute.members.configuration.dependency.monitor}

`HyperVPrivateCloud.Compute.Members.Configuration.Dependency.Monitor`

Dependency roll-up through the Compute Component Contains Host Role relationship.

### Support scope

A discovered identity, logical boundary, component group or health dependency in the private-cloud service model. Containment draws a diagram; only authored monitors and health dependencies determine its health.

Element: HyperVPrivateCloud.Compute.Members.Configuration.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.ComputeComponent; relationship=HCSV2Library!HyperVPrivateCloud.ComputeComponentContainsHostRole; member monitor=Health!System.Health.ConfigurationState; parent=Health!System.Health.ConfigurationState; algorithm=WorstOf; unavailable-member policy=Success. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Open Health Explorer from the unhealthy DA, follow the failing health aspect and dependency to the named leaf object, and read its state-change context and knowledge. Check whether the object is an inventory-only reference or an authoritative monitor target. Record the complete root-to-leaf path.

### Corrective action and escalation

Repair the originating leaf condition using its specific runbook and owner. Do not reset or edit a parent DA to conceal child health. Missing relationships or wrong aspect routing require a source change, tests and a new sealed MP version.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm fresh healthy leaf evidence and follow recovery through each dependency back to the solution root. Unknown/unmonitored objects and absent optional capabilities must not be described as fully monitored healthy services.

### Microsoft references

[Microsoft Learn: manage consoles overview healthexplorer](https://learn.microsoft.com/en-us/system-center/scom/manage-consoles-overview-healthexplorer?view=sc-om-2025)


## Roll up virtual machine availability into Virtual Machines {#hypervprivatecloud.virtualmachines.members.availability.dependency.monitor}

`HyperVPrivateCloud.VirtualMachines.Members.Availability.Dependency.Monitor`

Dependency roll-up through the Virtual Machine Component Contains Runtime relationship.

### Support scope

Host-based Hyper-V workload or management evidence. A stopped VM must be compared with its intended state; inventory presence is not guest application monitoring.

Element: HyperVPrivateCloud.VirtualMachines.Members.Availability.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.VirtualMachineComponent; relationship=HCSV2Library!HyperVPrivateCloud.VirtualMachineComponentContainsRuntime; member monitor=Health!System.Health.AvailabilityState; parent=Health!System.Health.AvailabilityState; algorithm=Percentage; unavailable-member policy=Success. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Run the matching read-only host/VM task. Match the stable VM ID and current owner, inspect Get-VM, attached disks, checkpoint chain and Hyper-V-VMMS/High-Availability logs. For management-service errors verify the named service and first failure rather than assuming every guest stopped.

### Corrective action and escalation

Restore the identified service, configuration, storage or VM dependency with the workload owner. Check intended shutdown and maintenance policy first. Never delete checkpoint files, force power operations or restart VMMS/hosts solely to clear an alert.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm the intended VM/service state, fresh host-derived evidence and the originating monitor. Guest application recovery requires a separate workload-level check.

### Microsoft references

[Microsoft Learn: hyper v start state access failures clustered standalone](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-start-state-access-failures-clustered-standalone)

[Microsoft Learn: hyper v virtual machine backup checkpoint storage](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-virtual-machine-backup-checkpoint-storage)


## Roll up virtual machine performance into Virtual Machines {#hypervprivatecloud.virtualmachines.members.performance.dependency.monitor}

`HyperVPrivateCloud.VirtualMachines.Members.Performance.Dependency.Monitor`

Dependency roll-up through the Virtual Machine Component Contains Runtime relationship.

### Support scope

Host-based Hyper-V workload or management evidence. A stopped VM must be compared with its intended state; inventory presence is not guest application monitoring.

Element: HyperVPrivateCloud.VirtualMachines.Members.Performance.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.VirtualMachineComponent; relationship=HCSV2Library!HyperVPrivateCloud.VirtualMachineComponentContainsRuntime; member monitor=Health!System.Health.PerformanceState; parent=Health!System.Health.PerformanceState; algorithm=Percentage; unavailable-member policy=Success. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Run the matching read-only host/VM task. Match the stable VM ID and current owner, inspect Get-VM, attached disks, checkpoint chain and Hyper-V-VMMS/High-Availability logs. For management-service errors verify the named service and first failure rather than assuming every guest stopped.

### Corrective action and escalation

Restore the identified service, configuration, storage or VM dependency with the workload owner. Check intended shutdown and maintenance policy first. Never delete checkpoint files, force power operations or restart VMMS/hosts solely to clear an alert.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm the intended VM/service state, fresh host-derived evidence and the originating monitor. Guest application recovery requires a separate workload-level check.

### Microsoft references

[Microsoft Learn: hyper v start state access failures clustered standalone](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-start-state-access-failures-clustered-standalone)

[Microsoft Learn: hyper v virtual machine backup checkpoint storage](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-virtual-machine-backup-checkpoint-storage)


## Roll up virtual machine configuration into Virtual Machines {#hypervprivatecloud.virtualmachines.members.configuration.dependency.monitor}

`HyperVPrivateCloud.VirtualMachines.Members.Configuration.Dependency.Monitor`

Dependency roll-up through the Virtual Machine Component Contains Runtime relationship.

### Support scope

Host-based Hyper-V workload or management evidence. A stopped VM must be compared with its intended state; inventory presence is not guest application monitoring.

Element: HyperVPrivateCloud.VirtualMachines.Members.Configuration.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.VirtualMachineComponent; relationship=HCSV2Library!HyperVPrivateCloud.VirtualMachineComponentContainsRuntime; member monitor=Health!System.Health.ConfigurationState; parent=Health!System.Health.ConfigurationState; algorithm=Percentage; unavailable-member policy=Success. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Run the matching read-only host/VM task. Match the stable VM ID and current owner, inspect Get-VM, attached disks, checkpoint chain and Hyper-V-VMMS/High-Availability logs. For management-service errors verify the named service and first failure rather than assuming every guest stopped.

### Corrective action and escalation

Restore the identified service, configuration, storage or VM dependency with the workload owner. Check intended shutdown and maintenance policy first. Never delete checkpoint files, force power operations or restart VMMS/hosts solely to clear an alert.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm the intended VM/service state, fresh host-derived evidence and the originating monitor. Guest application recovery requires a separate workload-level check.

### Microsoft references

[Microsoft Learn: hyper v start state access failures clustered standalone](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-start-state-access-failures-clustered-standalone)

[Microsoft Learn: hyper v virtual machine backup checkpoint storage](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-virtual-machine-backup-checkpoint-storage)


## Roll up VM expected-state availability into Availability and Clustering {#hypervprivatecloud.availability.members.availability.dependency.monitor}

`HyperVPrivateCloud.Availability.Members.Availability.Dependency.Monitor`

Dependency roll-up through the Availability Component Contains Runtime relationship.

### Support scope

A discovered identity, logical boundary, component group or health dependency in the private-cloud service model. Containment draws a diagram; only authored monitors and health dependencies determine its health.

Element: HyperVPrivateCloud.Availability.Members.Availability.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.AvailabilityComponent; relationship=HCSV2Library!HyperVPrivateCloud.AvailabilityComponentContainsRuntime; member monitor=HyperVPrivateCloud.VmRuntime.Availability.Monitor; parent=Health!System.Health.AvailabilityState; algorithm=WorstOf; unavailable-member policy=Success. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Open Health Explorer from the unhealthy DA, follow the failing health aspect and dependency to the named leaf object, and read its state-change context and knowledge. Check whether the object is an inventory-only reference or an authoritative monitor target. Record the complete root-to-leaf path.

### Corrective action and escalation

Repair the originating leaf condition using its specific runbook and owner. Do not reset or edit a parent DA to conceal child health. Missing relationships or wrong aspect routing require a source change, tests and a new sealed MP version.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm fresh healthy leaf evidence and follow recovery through each dependency back to the solution root. Unknown/unmonitored objects and absent optional capabilities must not be described as fully monitored healthy services.

### Microsoft references

[Microsoft Learn: manage consoles overview healthexplorer](https://learn.microsoft.com/en-us/system-center/scom/manage-consoles-overview-healthexplorer?view=sc-om-2025)


## Roll up VM heartbeat into Availability and Clustering {#hypervprivatecloud.availability.members.heartbeat.availability.dependency.monitor}

`HyperVPrivateCloud.Availability.Members.Heartbeat.Availability.Dependency.Monitor`

Dependency roll-up through the Availability Component Contains Runtime relationship.

### Support scope

Hyper-V host-to-guest integration channel evidence. No guest SCOM agent is required, and this signal does not prove application health inside the VM.

Element: HyperVPrivateCloud.Availability.Members.Heartbeat.Availability.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.AvailabilityComponent; relationship=HCSV2Library!HyperVPrivateCloud.AvailabilityComponentContainsRuntime; member monitor=HyperVPrivateCloud.VmRuntime.Heartbeat.Monitor; parent=Health!System.Health.AvailabilityState; algorithm=WorstOf; unavailable-member policy=Success. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

On the current VM owner inspect Get-VMIntegrationService for the exact VM and its expected power state. Distinguish a disabled integration service, unsupported guest, starting guest and an unresponsive running guest. Engage the guest owner for guest-side service/log checks.

### Corrective action and escalation

Correct integration-service policy or supported guest components with the workload owner. Do not restart a guest or install a SCOM agent to satisfy this host-based monitor without separate authorization.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm the configured integration service reports its expected status and host-side monitoring recovers; validate application service separately through its own owner.

### Microsoft references

[Microsoft Learn: manage hyper v integration services](https://learn.microsoft.com/en-us/windows-server/virtualization/hyper-v/manage/manage-hyper-v-integration-services)


## Roll up Hyper-V Replica health into Availability and Clustering {#hypervprivatecloud.availability.members.replication.availability.dependency.monitor}

`HyperVPrivateCloud.Availability.Members.Replication.Availability.Dependency.Monitor`

Dependency roll-up through the Availability Component Contains Runtime relationship.

### Support scope

Host-observed replication state and disaster-recovery protection, not an application availability test inside the guest.

Element: HyperVPrivateCloud.Availability.Members.Replication.Availability.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.AvailabilityComponent; relationship=HCSV2Library!HyperVPrivateCloud.AvailabilityComponentContainsRuntime; member monitor=HyperVPrivateCloud.VmRuntime.Replication.Monitor; parent=Health!System.Health.AvailabilityState; algorithm=WorstOf; unavailable-member policy=Success. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Use Get-VMReplication and Measure-VMReplication for the named VM on its owner. Inspect replication mode, primary/replica server, health, last replication time and backlog. For a cluster broker, follow network-name and broker resource dependencies. Distinguish planned pause, initial replication and unexpected loss of protection.

### Corrective action and escalation

Restore the actual authentication, certificate, broker, network or storage dependency. Coordinate resume or resynchronization with the recovery owner and verify bandwidth/storage impact. Never perform failover, reverse replication or remove/recreate protection solely to clear an alert.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm replication resumes and lag meets the agreed recovery-point objective. A healthy running primary VM alone does not establish healthy disaster recovery.

### Microsoft references

[Microsoft Learn: hyper v replica troubleshooting guide](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-replica-troubleshooting-guide)


## Roll up VM virtual disk availability into Storage {#hypervprivatecloud.storage.members.availability.dependency.monitor}

`HyperVPrivateCloud.Storage.Members.Availability.Dependency.Monitor`

Dependency roll-up through the Storage Component Contains Runtime relationship.

### Support scope

A discovered identity, logical boundary, component group or health dependency in the private-cloud service model. Containment draws a diagram; only authored monitors and health dependencies determine its health.

Element: HyperVPrivateCloud.Storage.Members.Availability.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.StorageComponent; relationship=HCSV2Library!HyperVPrivateCloud.StorageComponentContainsRuntime; member monitor=HyperVPrivateCloud.VmRuntime.Storage.Monitor; parent=Health!System.Health.AvailabilityState; algorithm=WorstOf; unavailable-member policy=Success. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Open Health Explorer from the unhealthy DA, follow the failing health aspect and dependency to the named leaf object, and read its state-change context and knowledge. Check whether the object is an inventory-only reference or an authoritative monitor target. Record the complete root-to-leaf path.

### Corrective action and escalation

Repair the originating leaf condition using its specific runbook and owner. Do not reset or edit a parent DA to conceal child health. Missing relationships or wrong aspect routing require a source change, tests and a new sealed MP version.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm fresh healthy leaf evidence and follow recovery through each dependency back to the solution root. Unknown/unmonitored objects and absent optional capabilities must not be described as fully monitored healthy services.

### Microsoft references

[Microsoft Learn: manage consoles overview healthexplorer](https://learn.microsoft.com/en-us/system-center/scom/manage-consoles-overview-healthexplorer?view=sc-om-2025)


## Roll up VM virtual storage latency into Storage {#hypervprivatecloud.storage.members.latency.performance.dependency.monitor}

`HyperVPrivateCloud.Storage.Members.Latency.Performance.Dependency.Monitor`

Dependency roll-up through the Storage Component Contains Runtime relationship.

### Support scope

Measured resource pressure or I/O delay. A warning is an opportunity to investigate headroom; a threshold crossing alone does not identify the defective component or predict a failure time.

Element: HyperVPrivateCloud.Storage.Members.Latency.Performance.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.StorageComponent; relationship=HCSV2Library!HyperVPrivateCloud.StorageComponentContainsRuntime; member monitor=HyperVPrivateCloud.VmRuntime.VirtualStorageLatency.Monitor; parent=Health!System.Health.PerformanceState; algorithm=WorstOf; unavailable-member policy=Success. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Record the named counter, measured value, units, sampling interval and effective thresholds. Compare a representative time series with workload changes, host placement and storage/network evidence. Separate host/root/guest CPU and assigned/demanded memory. Missing counters are a telemetry problem, not zero utilization.

### Corrective action and escalation

Address the identified contention, workload placement or failing path with its owner. Capacity changes require a headroom and failover-reserve check. Do not blindly increase thresholds, reboot hosts or reduce VM resources to suppress symptoms.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Observe the same metric over a representative load period, confirm sustained recovery and verify workload response independently. Product defaults require site-specific review and are not Microsoft service-level guarantees.

### Microsoft references

[Microsoft Learn: troubleshoot hyper v virtual machine performance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/troubleshoot-hyper-v-virtual-machine-performance)


## Roll up VM virtual storage queue length into Storage {#hypervprivatecloud.storage.members.queue.performance.dependency.monitor}

`HyperVPrivateCloud.Storage.Members.Queue.Performance.Dependency.Monitor`

Dependency roll-up through the Storage Component Contains Runtime relationship.

### Support scope

A discovered identity, logical boundary, component group or health dependency in the private-cloud service model. Containment draws a diagram; only authored monitors and health dependencies determine its health.

Element: HyperVPrivateCloud.Storage.Members.Queue.Performance.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.StorageComponent; relationship=HCSV2Library!HyperVPrivateCloud.StorageComponentContainsRuntime; member monitor=HyperVPrivateCloud.VmRuntime.VirtualStorageQueueLength.Monitor; parent=Health!System.Health.PerformanceState; algorithm=WorstOf; unavailable-member policy=Success. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Open Health Explorer from the unhealthy DA, follow the failing health aspect and dependency to the named leaf object, and read its state-change context and knowledge. Check whether the object is an inventory-only reference or an authoritative monitor target. Record the complete root-to-leaf path.

### Corrective action and escalation

Repair the originating leaf condition using its specific runbook and owner. Do not reset or edit a parent DA to conceal child health. Missing relationships or wrong aspect routing require a source change, tests and a new sealed MP version.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm fresh healthy leaf evidence and follow recovery through each dependency back to the solution root. Unknown/unmonitored objects and absent optional capabilities must not be described as fully monitored healthy services.

### Microsoft references

[Microsoft Learn: manage consoles overview healthexplorer](https://learn.microsoft.com/en-us/system-center/scom/manage-consoles-overview-healthexplorer?view=sc-om-2025)


## Roll up VM virtual network connectivity into Networking {#hypervprivatecloud.network.members.availability.dependency.monitor}

`HyperVPrivateCloud.Network.Members.Availability.Dependency.Monitor`

Dependency roll-up through the Network Component Contains Runtime relationship.

### Support scope

Host network or external infrastructure evidence at the precise scope of the leaf. TCP reachability is not device hardware, firewall-policy or application health; linked vendor monitors retain their own authority.

Element: HyperVPrivateCloud.Network.Members.Availability.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.NetworkComponent; relationship=HCSV2Library!HyperVPrivateCloud.NetworkComponentContainsRuntime; member monitor=HyperVPrivateCloud.VmRuntime.Network.Monitor; parent=Health!System.Health.AvailabilityState; algorithm=WorstOf; unavailable-member policy=Success. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Identify the adapter, switch, port or configured endpoint and the actual observation source. Compare link state, negotiated speed and error/discard deltas with device-side evidence. Check routing and the intended port from the collector. An unreachable management endpoint does not by itself prove the data plane failed.

### Corrective action and escalation

Restore the specific path, cable/optic, approved switch configuration or device service with the network/hardware owner. Consult the vendor for proprietary device faults. Do not disable security controls, bounce all uplinks or reboot management devices based only on a failed TCP probe.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Repeat the original path test and confirm relevant native/vendor health. For cumulative errors, observe new deltas; do not expect historic totals to disappear.

### Microsoft references

[Microsoft Learn: troubleshoot tcp ip communication guidance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/networking/troubleshoot-tcp-ip-communication-guidance)


## Roll up host monitoring pipeline health into Monitoring Pipeline {#hypervprivatecloud.monitoring.members.availability.dependency.monitor}

`HyperVPrivateCloud.Monitoring.Members.Availability.Dependency.Monitor`

Dependency roll-up through the Monitoring Component Contains Host Role relationship.

### Support scope

A discovered identity, logical boundary, component group or health dependency in the private-cloud service model. Containment draws a diagram; only authored monitors and health dependencies determine its health.

Element: HyperVPrivateCloud.Monitoring.Members.Availability.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.MonitoringComponent; relationship=HCSV2Library!HyperVPrivateCloud.MonitoringComponentContainsHostRole; member monitor=HyperVPrivateCloud.Host.Pipeline.Monitor; parent=Health!System.Health.AvailabilityState; algorithm=WorstOf; unavailable-member policy=Success. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Open Health Explorer from the unhealthy DA, follow the failing health aspect and dependency to the named leaf object, and read its state-change context and knowledge. Check whether the object is an inventory-only reference or an authoritative monitor target. Record the complete root-to-leaf path.

### Corrective action and escalation

Repair the originating leaf condition using its specific runbook and owner. Do not reset or edit a parent DA to conceal child health. Missing relationships or wrong aspect routing require a source change, tests and a new sealed MP version.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm fresh healthy leaf evidence and follow recovery through each dependency back to the solution root. Unknown/unmonitored objects and absent optional capabilities must not be described as fully monitored healthy services.

### Microsoft references

[Microsoft Learn: manage consoles overview healthexplorer](https://learn.microsoft.com/en-us/system-center/scom/manage-consoles-overview-healthexplorer?view=sc-om-2025)


## Roll up Hyper-V monitoring capability into Monitoring Pipeline {#hypervprivatecloud.monitoring.members.capability.configuration.dependency.monitor}

`HyperVPrivateCloud.Monitoring.Members.Capability.Configuration.Dependency.Monitor`

Dependency roll-up through the Monitoring Component Contains Host Role relationship.

### Support scope

A discovered identity, logical boundary, component group or health dependency in the private-cloud service model. Containment draws a diagram; only authored monitors and health dependencies determine its health.

Element: HyperVPrivateCloud.Monitoring.Members.Capability.Configuration.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.MonitoringComponent; relationship=HCSV2Library!HyperVPrivateCloud.MonitoringComponentContainsHostRole; member monitor=HyperVPrivateCloud.Host.PowerShell.Monitor; parent=Health!System.Health.ConfigurationState; algorithm=WorstOf; unavailable-member policy=Success. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Open Health Explorer from the unhealthy DA, follow the failing health aspect and dependency to the named leaf object, and read its state-change context and knowledge. Check whether the object is an inventory-only reference or an authoritative monitor target. Record the complete root-to-leaf path.

### Corrective action and escalation

Repair the originating leaf condition using its specific runbook and owner. Do not reset or edit a parent DA to conceal child health. Missing relationships or wrong aspect routing require a source change, tests and a new sealed MP version.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm fresh healthy leaf evidence and follow recovery through each dependency back to the solution root. Unknown/unmonitored objects and absent optional capabilities must not be described as fully monitored healthy services.

### Microsoft references

[Microsoft Learn: manage consoles overview healthexplorer](https://learn.microsoft.com/en-us/system-center/scom/manage-consoles-overview-healthexplorer?view=sc-om-2025)


## Roll up physical chassis availability into Compute {#hypervprivatecloud.compute.physicalchassis.availability.dependency.monitor}

`HyperVPrivateCloud.Compute.PhysicalChassis.Availability.Dependency.Monitor`

Dependency roll-up through the Compute Component Contains Physical Chassis relationship.

### Support scope

Host network or external infrastructure evidence at the precise scope of the leaf. TCP reachability is not device hardware, firewall-policy or application health; linked vendor monitors retain their own authority.

Element: HyperVPrivateCloud.Compute.PhysicalChassis.Availability.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.ComputeComponent; relationship=HCSV2Library!HyperVPrivateCloud.ComputeComponentContainsPhysicalChassis; member monitor=Health!System.Health.AvailabilityState; parent=Health!System.Health.AvailabilityState; algorithm=WorstOf; unavailable-member policy=Success. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Identify the adapter, switch, port or configured endpoint and the actual observation source. Compare link state, negotiated speed and error/discard deltas with device-side evidence. Check routing and the intended port from the collector. An unreachable management endpoint does not by itself prove the data plane failed.

### Corrective action and escalation

Restore the specific path, cable/optic, approved switch configuration or device service with the network/hardware owner. Consult the vendor for proprietary device faults. Do not disable security controls, bounce all uplinks or reboot management devices based only on a failed TCP probe.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Repeat the original path test and confirm relevant native/vendor health. For cumulative errors, observe new deltas; do not expect historic totals to disappear.

### Microsoft references

[Microsoft Learn: troubleshoot tcp ip communication guidance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/networking/troubleshoot-tcp-ip-communication-guidance)


## Roll up physical chassis configuration into Compute {#hypervprivatecloud.compute.physicalchassis.configuration.dependency.monitor}

`HyperVPrivateCloud.Compute.PhysicalChassis.Configuration.Dependency.Monitor`

Dependency roll-up through the Compute Component Contains Physical Chassis relationship.

### Support scope

Host network or external infrastructure evidence at the precise scope of the leaf. TCP reachability is not device hardware, firewall-policy or application health; linked vendor monitors retain their own authority.

Element: HyperVPrivateCloud.Compute.PhysicalChassis.Configuration.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.ComputeComponent; relationship=HCSV2Library!HyperVPrivateCloud.ComputeComponentContainsPhysicalChassis; member monitor=Health!System.Health.ConfigurationState; parent=Health!System.Health.ConfigurationState; algorithm=WorstOf; unavailable-member policy=Success. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Identify the adapter, switch, port or configured endpoint and the actual observation source. Compare link state, negotiated speed and error/discard deltas with device-side evidence. Check routing and the intended port from the collector. An unreachable management endpoint does not by itself prove the data plane failed.

### Corrective action and escalation

Restore the specific path, cable/optic, approved switch configuration or device service with the network/hardware owner. Consult the vendor for proprietary device faults. Do not disable security controls, bounce all uplinks or reboot management devices based only on a failed TCP probe.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Repeat the original path test and confirm relevant native/vendor health. For cumulative errors, observe new deltas; do not expect historic totals to disappear.

### Microsoft references

[Microsoft Learn: troubleshoot tcp ip communication guidance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/networking/troubleshoot-tcp-ip-communication-guidance)


## Roll up Top-of-Rack data switch availability into Networking {#hypervprivatecloud.network.topofrackswitch.availability.dependency.monitor}

`HyperVPrivateCloud.Network.TopOfRackSwitch.Availability.Dependency.Monitor`

Dependency roll-up through the Network Component Contains Top Of Rack Switch relationship.

### Support scope

Host network or external infrastructure evidence at the precise scope of the leaf. TCP reachability is not device hardware, firewall-policy or application health; linked vendor monitors retain their own authority.

Element: HyperVPrivateCloud.Network.TopOfRackSwitch.Availability.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.NetworkComponent; relationship=HCSV2Library!HyperVPrivateCloud.NetworkComponentContainsTopOfRackSwitch; member monitor=Health!System.Health.AvailabilityState; parent=Health!System.Health.AvailabilityState; algorithm=WorstOf; unavailable-member policy=Success. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Identify the adapter, switch, port or configured endpoint and the actual observation source. Compare link state, negotiated speed and error/discard deltas with device-side evidence. Check routing and the intended port from the collector. An unreachable management endpoint does not by itself prove the data plane failed.

### Corrective action and escalation

Restore the specific path, cable/optic, approved switch configuration or device service with the network/hardware owner. Consult the vendor for proprietary device faults. Do not disable security controls, bounce all uplinks or reboot management devices based only on a failed TCP probe.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Repeat the original path test and confirm relevant native/vendor health. For cumulative errors, observe new deltas; do not expect historic totals to disappear.

### Microsoft references

[Microsoft Learn: troubleshoot tcp ip communication guidance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/networking/troubleshoot-tcp-ip-communication-guidance)


## Roll up Out-of-Band management switch availability into Networking {#hypervprivatecloud.network.outofbandswitch.availability.dependency.monitor}

`HyperVPrivateCloud.Network.OutOfBandSwitch.Availability.Dependency.Monitor`

Dependency roll-up through the Network Component Contains Out Of Band Switch relationship.

### Support scope

Host network or external infrastructure evidence at the precise scope of the leaf. TCP reachability is not device hardware, firewall-policy or application health; linked vendor monitors retain their own authority.

Element: HyperVPrivateCloud.Network.OutOfBandSwitch.Availability.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.NetworkComponent; relationship=HCSV2Library!HyperVPrivateCloud.NetworkComponentContainsOutOfBandSwitch; member monitor=Health!System.Health.AvailabilityState; parent=Health!System.Health.AvailabilityState; algorithm=WorstOf; unavailable-member policy=Success. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Identify the adapter, switch, port or configured endpoint and the actual observation source. Compare link state, negotiated speed and error/discard deltas with device-side evidence. Check routing and the intended port from the collector. An unreachable management endpoint does not by itself prove the data plane failed.

### Corrective action and escalation

Restore the specific path, cable/optic, approved switch configuration or device service with the network/hardware owner. Consult the vendor for proprietary device faults. Do not disable security controls, bounce all uplinks or reboot management devices based only on a failed TCP probe.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Repeat the original path test and confirm relevant native/vendor health. For cumulative errors, observe new deltas; do not expect historic totals to disappear.

### Microsoft references

[Microsoft Learn: troubleshoot tcp ip communication guidance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/networking/troubleshoot-tcp-ip-communication-guidance)


## Roll up edge perimeter firewall availability into Networking {#hypervprivatecloud.network.edgefirewall.availability.dependency.monitor}

`HyperVPrivateCloud.Network.EdgeFirewall.Availability.Dependency.Monitor`

Dependency roll-up through the Network Component Contains Edge Firewall relationship.

### Support scope

Host network or external infrastructure evidence at the precise scope of the leaf. TCP reachability is not device hardware, firewall-policy or application health; linked vendor monitors retain their own authority.

Element: HyperVPrivateCloud.Network.EdgeFirewall.Availability.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.NetworkComponent; relationship=HCSV2Library!HyperVPrivateCloud.NetworkComponentContainsEdgeFirewall; member monitor=Health!System.Health.AvailabilityState; parent=Health!System.Health.AvailabilityState; algorithm=WorstOf; unavailable-member policy=Success. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Identify the adapter, switch, port or configured endpoint and the actual observation source. Compare link state, negotiated speed and error/discard deltas with device-side evidence. Check routing and the intended port from the collector. An unreachable management endpoint does not by itself prove the data plane failed.

### Corrective action and escalation

Restore the specific path, cable/optic, approved switch configuration or device service with the network/hardware owner. Consult the vendor for proprietary device faults. Do not disable security controls, bounce all uplinks or reboot management devices based only on a failed TCP probe.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Repeat the original path test and confirm relevant native/vendor health. For cumulative errors, observe new deltas; do not expect historic totals to disappear.

### Microsoft references

[Microsoft Learn: troubleshoot tcp ip communication guidance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/networking/troubleshoot-tcp-ip-communication-guidance)


## Roll up out-of-band console server availability into Management {#hypervprivatecloud.management.consoleserver.availability.dependency.monitor}

`HyperVPrivateCloud.Management.ConsoleServer.Availability.Dependency.Monitor`

Dependency roll-up through the Management Component Contains Console Server relationship.

### Support scope

Host network or external infrastructure evidence at the precise scope of the leaf. TCP reachability is not device hardware, firewall-policy or application health; linked vendor monitors retain their own authority.

Element: HyperVPrivateCloud.Management.ConsoleServer.Availability.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.ManagementComponent; relationship=HCSV2Library!HyperVPrivateCloud.ManagementComponentContainsConsoleServer; member monitor=Health!System.Health.AvailabilityState; parent=Health!System.Health.AvailabilityState; algorithm=WorstOf; unavailable-member policy=Success. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Identify the adapter, switch, port or configured endpoint and the actual observation source. Compare link state, negotiated speed and error/discard deltas with device-side evidence. Check routing and the intended port from the collector. An unreachable management endpoint does not by itself prove the data plane failed.

### Corrective action and escalation

Restore the specific path, cable/optic, approved switch configuration or device service with the network/hardware owner. Consult the vendor for proprietary device faults. Do not disable security controls, bounce all uplinks or reboot management devices based only on a failed TCP probe.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Repeat the original path test and confirm relevant native/vendor health. For cumulative errors, observe new deltas; do not expect historic totals to disappear.

### Microsoft references

[Microsoft Learn: troubleshoot tcp ip communication guidance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/networking/troubleshoot-tcp-ip-communication-guidance)


## Roll up DHCP infrastructure service availability into Management {#hypervprivatecloud.management.dhcpservice.availability.dependency.monitor}

`HyperVPrivateCloud.Management.DhcpService.Availability.Dependency.Monitor`

Dependency roll-up through the Management Component Contains Dhcp Service relationship.

### Support scope

Configured DHCP service reachability/health evidence. This is not an exhaustive lease, scope or client transaction monitor unless the leaf explicitly measures those facts.

Element: HyperVPrivateCloud.Management.DhcpService.Availability.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.ManagementComponent; relationship=HCSV2Library!HyperVPrivateCloud.ManagementComponentContainsDhcpService; member monitor=Health!System.Health.AvailabilityState; parent=Health!System.Health.AvailabilityState; algorithm=WorstOf; unavailable-member policy=Success. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Check the named DHCP endpoint, service status, authorization, applicable scope free leases and relay path with the DHCP owner. Compare a client on the server subnet with one behind the affected relay.

### Corrective action and escalation

Correct the proven service, scope or relay issue through approved network change control. Do not authorize unknown DHCP servers or change scope ranges to clear a reachability alarm.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm the configured probe and a representative lease transaction recover without address conflicts.

### Microsoft references

[Microsoft Learn: troubleshoot dhcp guidance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/networking/troubleshoot-dhcp-guidance)
