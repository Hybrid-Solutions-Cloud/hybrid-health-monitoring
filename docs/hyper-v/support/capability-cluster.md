# Hyper-V Private Cloud Monitoring - Failover Cluster and CSV Integration

Generated support reference. [All capabilities](catalog.md) · [Day-2 triage](index.md).

Default conditions below come from the compiled candidate source, not the effective overrides in your management group. Read the monitor-specific knowledge together with the common safety and verification guidance. Microsoft links explain the underlying technology; product thresholds are not Microsoft recommendations.

## Hyper-V Failover Cluster {#hypervprivatecloud.capability.cluster.clusterrole}

`HyperVPrivateCloud.Capability.Cluster.ClusterRole`

Cluster-wide collector identity hosted through the cluster core-group ownership path. It gathers node/quorum/network/group/CSV summaries; Microsoft cluster objects remain authoritative for their own resource-level health.

### Support scope

Cluster membership, quorum, witness, inter-node network or collector health. Loss of redundancy can precede an outage even while VMs remain running.

Element: HyperVPrivateCloud.Capability.Cluster.ClusterRole. Kind: ClassType.

### Identity and monitoring ownership

Base class=System!System.LogicalEntity; hosted=true; singleton=false; declared properties=BoundaryId, ClusterName. Inherited properties also apply. Inspect the exact instance and its monitoring path; inventory-only classes do not acquire health merely by appearing in a diagram.

### Read-only investigation

Run Get-ClusterNode, Get-ClusterQuorum and Get-ClusterNetwork locally on a cluster node. Identify paused versus down nodes, configured and current votes, witness state and partitioned networks. Review maintenance and the first cluster event. For collection errors, verify the supported Windows PowerShell runtime and FailoverClusters module before interpreting zero counts.

### Corrective action and escalation

Restore the failed node, witness or network with the platform owner. Resume intentionally paused nodes only after maintenance is complete. Do not force quorum, change node weights or restart all nodes to clear a monitor. Repair collector access separately from workload health.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm expected membership, quorum resilience and network state, then verify fresh collector results and the originating monitor before the parent DA.

### What this object represents

Cluster-wide collector identity hosted through the cluster core-group ownership path. It gathers node/quorum/network/group/CSV summaries; Microsoft cluster objects remain authoritative for their own resource-level health.

### Microsoft references

[Microsoft Learn: what is quorum witness](https://learn.microsoft.com/en-us/windows-server/failover-clustering/what-is-quorum-witness)

[Microsoft Learn: quorum](https://learn.microsoft.com/en-us/windows-server/storage/storage-spaces/quorum)

[Microsoft Learn: nf clusapi pauseclusternode](https://learn.microsoft.com/en-us/windows/win32/api/clusapi/nf-clusapi-pauseclusternode)

[Microsoft Learn: failover cluster accounts overview](https://learn.microsoft.com/en-us/windows-server/failover-clustering/failover-cluster-accounts-overview)

[Microsoft Learn: hyper v cluster connectivity management configuration](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-cluster-connectivity-management-configuration)


## Collect Cluster Shared Volume free space percent {#hypervprivatecloud.capability.cluster.csv.freespacepercent.collection.rule}

`HyperVPrivateCloud.Capability.Cluster.CSV.FreeSpacePercent.Collection.Rule`

Collects the free space percentage of the fullest Cluster Shared Volume every 300 seconds. IntervalSeconds and TimeoutSeconds are overridable.

### Support scope

Cluster Shared Volume accessibility, capacity or I/O pressure, as observed by the cluster collector; worst-volume metrics summarize multiple CSVs.

Element: HyperVPrivateCloud.Capability.Cluster.CSV.FreeSpacePercent.Collection.Rule. Kind: Rule.

### Alert versus health

Target=HyperVPrivateCloud.Capability.Cluster.ClusterRole; enabled=true; category=PerformanceCollection. Rules collect data or raise event alerts; they do not themselves create unit-monitor health transitions. Repeated or unresolved rule alerts do not by themselves explain a red DA. Correlate with current leaf monitors and event timestamps before closure.

### Read-only investigation

Run Get-ClusterSharedVolume and inspect SharedVolumeInfo, owner, state and partition free space for each volume. Correlate redirected or paused access with backup activity, storage-path health, System events and CSV performance samples. Compare all nodes before assuming the coordinator is the failing storage device.

### Corrective action and escalation

For unexpected redirection or offline storage, restore the failed storage/network dependency with the storage team. For low free space, stop unapproved growth and plan supported capacity expansion or owner-approved cleanup. Never delete VHDX/AVHDX files or force storage online as a generic alert response.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm every affected CSV is accessible from its intended nodes, expected direct access returns after maintenance, capacity headroom is restored, and latency stays below policy over a representative workload period.

### Microsoft references

[Microsoft Learn: failover cluster manage cluster shared volumes](https://learn.microsoft.com/en-us/windows-server/failover-clustering/failover-cluster-manage-cluster-shared-volumes)

[Microsoft Learn: storage issues in hyper v and windows server failover clusters](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/storage-issues-in-hyper-v-and-windows-server-failover-clusters)


## Collect Cluster Shared Volume used space percent {#hypervprivatecloud.capability.cluster.csv.usedspacepercent.collection.rule}

`HyperVPrivateCloud.Capability.Cluster.CSV.UsedSpacePercent.Collection.Rule`

Collects the used space percentage of the fullest Cluster Shared Volume every 300 seconds. IntervalSeconds and TimeoutSeconds are overridable.

### Support scope

Cluster Shared Volume accessibility, capacity or I/O pressure, as observed by the cluster collector; worst-volume metrics summarize multiple CSVs.

Element: HyperVPrivateCloud.Capability.Cluster.CSV.UsedSpacePercent.Collection.Rule. Kind: Rule.

### Alert versus health

Target=HyperVPrivateCloud.Capability.Cluster.ClusterRole; enabled=true; category=PerformanceCollection. Rules collect data or raise event alerts; they do not themselves create unit-monitor health transitions. Repeated or unresolved rule alerts do not by themselves explain a red DA. Correlate with current leaf monitors and event timestamps before closure.

### Read-only investigation

Run Get-ClusterSharedVolume and inspect SharedVolumeInfo, owner, state and partition free space for each volume. Correlate redirected or paused access with backup activity, storage-path health, System events and CSV performance samples. Compare all nodes before assuming the coordinator is the failing storage device.

### Corrective action and escalation

For unexpected redirection or offline storage, restore the failed storage/network dependency with the storage team. For low free space, stop unapproved growth and plan supported capacity expansion or owner-approved cleanup. Never delete VHDX/AVHDX files or force storage online as a generic alert response.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm every affected CSV is accessible from its intended nodes, expected direct access returns after maintenance, capacity headroom is restored, and latency stays below policy over a representative workload period.

### Microsoft references

[Microsoft Learn: failover cluster manage cluster shared volumes](https://learn.microsoft.com/en-us/windows-server/failover-clustering/failover-cluster-manage-cluster-shared-volumes)

[Microsoft Learn: storage issues in hyper v and windows server failover clusters](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/storage-issues-in-hyper-v-and-windows-server-failover-clusters)


## Collect Cluster Shared Volume read latency {#hypervprivatecloud.capability.cluster.csv.readlatency.collection.rule}

`HyperVPrivateCloud.Capability.Cluster.CSV.ReadLatency.Collection.Rule`

Collects the worst Cluster Shared Volume read latency in milliseconds every 300 seconds. IntervalSeconds and TimeoutSeconds are overridable.

### Support scope

Cluster Shared Volume accessibility, capacity or I/O pressure, as observed by the cluster collector; worst-volume metrics summarize multiple CSVs.

Element: HyperVPrivateCloud.Capability.Cluster.CSV.ReadLatency.Collection.Rule. Kind: Rule.

### Alert versus health

Target=HCSV2Library!HyperVPrivateCloud.HostRole; enabled=true; category=PerformanceCollection. Rules collect data or raise event alerts; they do not themselves create unit-monitor health transitions. Repeated or unresolved rule alerts do not by themselves explain a red DA. Correlate with current leaf monitors and event timestamps before closure.

### Read-only investigation

Run Get-ClusterSharedVolume and inspect SharedVolumeInfo, owner, state and partition free space for each volume. Correlate redirected or paused access with backup activity, storage-path health, System events and CSV performance samples. Compare all nodes before assuming the coordinator is the failing storage device.

### Corrective action and escalation

For unexpected redirection or offline storage, restore the failed storage/network dependency with the storage team. For low free space, stop unapproved growth and plan supported capacity expansion or owner-approved cleanup. Never delete VHDX/AVHDX files or force storage online as a generic alert response.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm every affected CSV is accessible from its intended nodes, expected direct access returns after maintenance, capacity headroom is restored, and latency stays below policy over a representative workload period.

### Microsoft references

[Microsoft Learn: failover cluster manage cluster shared volumes](https://learn.microsoft.com/en-us/windows-server/failover-clustering/failover-cluster-manage-cluster-shared-volumes)

[Microsoft Learn: storage issues in hyper v and windows server failover clusters](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/storage-issues-in-hyper-v-and-windows-server-failover-clusters)


## Collect Cluster Shared Volume write latency {#hypervprivatecloud.capability.cluster.csv.writelatency.collection.rule}

`HyperVPrivateCloud.Capability.Cluster.CSV.WriteLatency.Collection.Rule`

Collects the worst Cluster Shared Volume write latency in milliseconds every 300 seconds. IntervalSeconds and TimeoutSeconds are overridable.

### Support scope

Cluster Shared Volume accessibility, capacity or I/O pressure, as observed by the cluster collector; worst-volume metrics summarize multiple CSVs.

Element: HyperVPrivateCloud.Capability.Cluster.CSV.WriteLatency.Collection.Rule. Kind: Rule.

### Alert versus health

Target=HCSV2Library!HyperVPrivateCloud.HostRole; enabled=true; category=PerformanceCollection. Rules collect data or raise event alerts; they do not themselves create unit-monitor health transitions. Repeated or unresolved rule alerts do not by themselves explain a red DA. Correlate with current leaf monitors and event timestamps before closure.

### Read-only investigation

Run Get-ClusterSharedVolume and inspect SharedVolumeInfo, owner, state and partition free space for each volume. Correlate redirected or paused access with backup activity, storage-path health, System events and CSV performance samples. Compare all nodes before assuming the coordinator is the failing storage device.

### Corrective action and escalation

For unexpected redirection or offline storage, restore the failed storage/network dependency with the storage team. For low free space, stop unapproved growth and plan supported capacity expansion or owner-approved cleanup. Never delete VHDX/AVHDX files or force storage online as a generic alert response.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm every affected CSV is accessible from its intended nodes, expected direct access returns after maintenance, capacity headroom is restored, and latency stays below policy over a representative workload period.

### Microsoft references

[Microsoft Learn: failover cluster manage cluster shared volumes](https://learn.microsoft.com/en-us/windows-server/failover-clustering/failover-cluster-manage-cluster-shared-volumes)

[Microsoft Learn: storage issues in hyper v and windows server failover clusters](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/storage-issues-in-hyper-v-and-windows-server-failover-clusters)


## Collect Cluster Shared Volume queue depth {#hypervprivatecloud.capability.cluster.csv.queuedepth.collection.rule}

`HyperVPrivateCloud.Capability.Cluster.CSV.QueueDepth.Collection.Rule`

Collects the worst Cluster Shared Volume I/O queue length every 300 seconds. IntervalSeconds and TimeoutSeconds are overridable.

### Support scope

Cluster Shared Volume accessibility, capacity or I/O pressure, as observed by the cluster collector; worst-volume metrics summarize multiple CSVs.

Element: HyperVPrivateCloud.Capability.Cluster.CSV.QueueDepth.Collection.Rule. Kind: Rule.

### Alert versus health

Target=HCSV2Library!HyperVPrivateCloud.HostRole; enabled=true; category=PerformanceCollection. Rules collect data or raise event alerts; they do not themselves create unit-monitor health transitions. Repeated or unresolved rule alerts do not by themselves explain a red DA. Correlate with current leaf monitors and event timestamps before closure.

### Read-only investigation

Run Get-ClusterSharedVolume and inspect SharedVolumeInfo, owner, state and partition free space for each volume. Correlate redirected or paused access with backup activity, storage-path health, System events and CSV performance samples. Compare all nodes before assuming the coordinator is the failing storage device.

### Corrective action and escalation

For unexpected redirection or offline storage, restore the failed storage/network dependency with the storage team. For low free space, stop unapproved growth and plan supported capacity expansion or owner-approved cleanup. Never delete VHDX/AVHDX files or force storage online as a generic alert response.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm every affected CSV is accessible from its intended nodes, expected direct access returns after maintenance, capacity headroom is restored, and latency stays below policy over a representative workload period.

### Microsoft references

[Microsoft Learn: failover cluster manage cluster shared volumes](https://learn.microsoft.com/en-us/windows-server/failover-clustering/failover-cluster-manage-cluster-shared-volumes)

[Microsoft Learn: storage issues in hyper v and windows server failover clusters](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/storage-issues-in-hyper-v-and-windows-server-failover-clusters)


## Show cluster summary {#hypervprivatecloud.capability.cluster.summary.task}

`HyperVPrivateCloud.Capability.Cluster.Summary.Task`

Cluster, quorum, node votes, networks and interfaces not Up, roles not Online, CSV state with free space, redirected access and fault state.

### Summary

Show cluster summary

### What it runs

Cluster, quorum, node votes, networks and interfaces not Up, roles not Online, CSV state with free space, redirected access and fault state.

### Impact

Read-only. The task runs the query on the agent and returns text; it changes nothing.

### Support scope

Cluster membership, quorum, witness, inter-node network or collector health. Loss of redundancy can precede an outage even while VMs remain running.

Element: HyperVPrivateCloud.Capability.Cluster.Summary.Task. Kind: Task.

### Execution safety

Target=HCSV2Library!HyperVPrivateCloud.HostRole; enabled=true; timeout=180. Read the task&#39;s original knowledge and parameters before execution. A Remediation task changes state and requires approval; do not execute it solely because the object is red. Even a diagnostic can generate logs or files; review its documented impact.

### Read-only investigation

Run Get-ClusterNode, Get-ClusterQuorum and Get-ClusterNetwork locally on a cluster node. Identify paused versus down nodes, configured and current votes, witness state and partitioned networks. Review maintenance and the first cluster event. For collection errors, verify the supported Windows PowerShell runtime and FailoverClusters module before interpreting zero counts.

### Corrective action and escalation

Restore the failed node, witness or network with the platform owner. Resume intentionally paused nodes only after maintenance is complete. Do not force quorum, change node weights or restart all nodes to clear a monitor. Repair collector access separately from workload health.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm expected membership, quorum resilience and network state, then verify fresh collector results and the originating monitor before the parent DA.

### Microsoft references

[Microsoft Learn: what is quorum witness](https://learn.microsoft.com/en-us/windows-server/failover-clustering/what-is-quorum-witness)

[Microsoft Learn: quorum](https://learn.microsoft.com/en-us/windows-server/storage/storage-spaces/quorum)

[Microsoft Learn: nf clusapi pauseclusternode](https://learn.microsoft.com/en-us/windows/win32/api/clusapi/nf-clusapi-pauseclusternode)

[Microsoft Learn: failover cluster accounts overview](https://learn.microsoft.com/en-us/windows-server/failover-clustering/failover-cluster-accounts-overview)

[Microsoft Learn: hyper v cluster connectivity management configuration](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-cluster-connectivity-management-configuration)


## Generate the cluster log {#hypervprivatecloud.capability.cluster.log.task}

`HyperVPrivateCloud.Capability.Cluster.Log.Task`

Get-ClusterLog for the last N minutes (Parameter, default 30) into ProgramData\HyperVPrivateCloud\ClusterLogs on every node.

### Summary

Generate the cluster log

### What it runs

Get-ClusterLog for the last N minutes (Parameter, default 30) into ProgramData\HyperVPrivateCloud\ClusterLogs on every node.

### Impact

Read-only. The task runs the query on the agent and returns text; it changes nothing.

### Support scope

Cluster membership, quorum, witness, inter-node network or collector health. Loss of redundancy can precede an outage even while VMs remain running.

Element: HyperVPrivateCloud.Capability.Cluster.Log.Task. Kind: Task.

### Execution safety

Target=HCSV2Library!HyperVPrivateCloud.HostRole; enabled=true; timeout=600. Read the task&#39;s original knowledge and parameters before execution. A Remediation task changes state and requires approval; do not execute it solely because the object is red. Even a diagnostic can generate logs or files; review its documented impact.

### Read-only investigation

Run Get-ClusterNode, Get-ClusterQuorum and Get-ClusterNetwork locally on a cluster node. Identify paused versus down nodes, configured and current votes, witness state and partitioned networks. Review maintenance and the first cluster event. For collection errors, verify the supported Windows PowerShell runtime and FailoverClusters module before interpreting zero counts.

### Corrective action and escalation

Restore the failed node, witness or network with the platform owner. Resume intentionally paused nodes only after maintenance is complete. Do not force quorum, change node weights or restart all nodes to clear a monitor. Repair collector access separately from workload health.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm expected membership, quorum resilience and network state, then verify fresh collector results and the originating monitor before the parent DA.

### Microsoft references

[Microsoft Learn: what is quorum witness](https://learn.microsoft.com/en-us/windows-server/failover-clustering/what-is-quorum-witness)

[Microsoft Learn: quorum](https://learn.microsoft.com/en-us/windows-server/storage/storage-spaces/quorum)

[Microsoft Learn: nf clusapi pauseclusternode](https://learn.microsoft.com/en-us/windows/win32/api/clusapi/nf-clusapi-pauseclusternode)

[Microsoft Learn: failover cluster accounts overview](https://learn.microsoft.com/en-us/windows-server/failover-clustering/failover-cluster-accounts-overview)

[Microsoft Learn: hyper v cluster connectivity management configuration](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-cluster-connectivity-management-configuration)


## Validate cluster network (and S2D) {#hypervprivatecloud.capability.cluster.validate.task}

`HyperVPrivateCloud.Capability.Cluster.Validate.Task`

Test-Cluster -Include Network (and Storage Spaces Direct when enabled). Read-only but takes several minutes.

### Summary

Validate cluster network (and S2D)

### What it runs

Test-Cluster -Include Network (and Storage Spaces Direct when enabled). Read-only but takes several minutes.

### Impact

Read-only. The task runs the query on the agent and returns text; it changes nothing.

### Support scope

Cluster membership, quorum, witness, inter-node network or collector health. Loss of redundancy can precede an outage even while VMs remain running.

Element: HyperVPrivateCloud.Capability.Cluster.Validate.Task. Kind: Task.

### Execution safety

Target=HCSV2Library!HyperVPrivateCloud.HostRole; enabled=true; timeout=1800. Read the task&#39;s original knowledge and parameters before execution. A Remediation task changes state and requires approval; do not execute it solely because the object is red. Even a diagnostic can generate logs or files; review its documented impact.

### Read-only investigation

Run Get-ClusterNode, Get-ClusterQuorum and Get-ClusterNetwork locally on a cluster node. Identify paused versus down nodes, configured and current votes, witness state and partitioned networks. Review maintenance and the first cluster event. For collection errors, verify the supported Windows PowerShell runtime and FailoverClusters module before interpreting zero counts.

### Corrective action and escalation

Restore the failed node, witness or network with the platform owner. Resume intentionally paused nodes only after maintenance is complete. Do not force quorum, change node weights or restart all nodes to clear a monitor. Repair collector access separately from workload health.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm expected membership, quorum resilience and network state, then verify fresh collector results and the originating monitor before the parent DA.

### Microsoft references

[Microsoft Learn: what is quorum witness](https://learn.microsoft.com/en-us/windows-server/failover-clustering/what-is-quorum-witness)

[Microsoft Learn: quorum](https://learn.microsoft.com/en-us/windows-server/storage/storage-spaces/quorum)

[Microsoft Learn: nf clusapi pauseclusternode](https://learn.microsoft.com/en-us/windows/win32/api/clusapi/nf-clusapi-pauseclusternode)

[Microsoft Learn: failover cluster accounts overview](https://learn.microsoft.com/en-us/windows-server/failover-clustering/failover-cluster-accounts-overview)

[Microsoft Learn: hyper v cluster connectivity management configuration](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-cluster-connectivity-management-configuration)


## Remediation: Move a CSV coordinator {#hypervprivatecloud.capability.cluster.movecsvcoordinator.task}

`HyperVPrivateCloud.Capability.Cluster.MoveCsvCoordinator.Task`

Move-ClusterSharedVolume. Parameter = CSV resource name.

### Summary

Move a CSV coordinator

### What it runs

Move-ClusterSharedVolume. Parameter = CSV resource name.

### Impact

This task changes the state of the target. The console asks for confirmation before it runs; use the read-only tasks first to confirm the diagnosis, and run it inside a change window where the environment requires one. The task output reports the resulting state.

### Support scope

Cluster membership, quorum, witness, inter-node network or collector health. Loss of redundancy can precede an outage even while VMs remain running.

Element: HyperVPrivateCloud.Capability.Cluster.MoveCsvCoordinator.Task. Kind: Task.

### Execution safety

Target=HCSV2Library!HyperVPrivateCloud.HostRole; enabled=true; timeout=300. Read the task&#39;s original knowledge and parameters before execution. A Remediation task changes state and requires approval; do not execute it solely because the object is red. Even a diagnostic can generate logs or files; review its documented impact.

### Read-only investigation

Run Get-ClusterNode, Get-ClusterQuorum and Get-ClusterNetwork locally on a cluster node. Identify paused versus down nodes, configured and current votes, witness state and partitioned networks. Review maintenance and the first cluster event. For collection errors, verify the supported Windows PowerShell runtime and FailoverClusters module before interpreting zero counts.

### Corrective action and escalation

Restore the failed node, witness or network with the platform owner. Resume intentionally paused nodes only after maintenance is complete. Do not force quorum, change node weights or restart all nodes to clear a monitor. Repair collector access separately from workload health.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm expected membership, quorum resilience and network state, then verify fresh collector results and the originating monitor before the parent DA.

### Microsoft references

[Microsoft Learn: what is quorum witness](https://learn.microsoft.com/en-us/windows-server/failover-clustering/what-is-quorum-witness)

[Microsoft Learn: quorum](https://learn.microsoft.com/en-us/windows-server/storage/storage-spaces/quorum)

[Microsoft Learn: nf clusapi pauseclusternode](https://learn.microsoft.com/en-us/windows/win32/api/clusapi/nf-clusapi-pauseclusternode)

[Microsoft Learn: failover cluster accounts overview](https://learn.microsoft.com/en-us/windows-server/failover-clustering/failover-cluster-accounts-overview)

[Microsoft Learn: hyper v cluster connectivity management configuration](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-cluster-connectivity-management-configuration)


## Remediation: Drain this node {#hypervprivatecloud.capability.cluster.drainnode.task}

`HyperVPrivateCloud.Capability.Cluster.DrainNode.Task`

Suspend-ClusterNode -Drain (live migrates roles away). Parameter = node name (default: this node).

### Summary

Drain this node

### What it runs

Suspend-ClusterNode -Drain (live migrates roles away). Parameter = node name (default: this node).

### Impact

This task changes the state of the target. The console asks for confirmation before it runs; use the read-only tasks first to confirm the diagnosis, and run it inside a change window where the environment requires one. The task output reports the resulting state.

### Support scope

Cluster membership, quorum, witness, inter-node network or collector health. Loss of redundancy can precede an outage even while VMs remain running.

Element: HyperVPrivateCloud.Capability.Cluster.DrainNode.Task. Kind: Task.

### Execution safety

Target=HCSV2Library!HyperVPrivateCloud.HostRole; enabled=true; timeout=1800. Read the task&#39;s original knowledge and parameters before execution. A Remediation task changes state and requires approval; do not execute it solely because the object is red. Even a diagnostic can generate logs or files; review its documented impact.

### Read-only investigation

Run Get-ClusterNode, Get-ClusterQuorum and Get-ClusterNetwork locally on a cluster node. Identify paused versus down nodes, configured and current votes, witness state and partitioned networks. Review maintenance and the first cluster event. For collection errors, verify the supported Windows PowerShell runtime and FailoverClusters module before interpreting zero counts.

### Corrective action and escalation

Restore the failed node, witness or network with the platform owner. Resume intentionally paused nodes only after maintenance is complete. Do not force quorum, change node weights or restart all nodes to clear a monitor. Repair collector access separately from workload health.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm expected membership, quorum resilience and network state, then verify fresh collector results and the originating monitor before the parent DA.

### Microsoft references

[Microsoft Learn: what is quorum witness](https://learn.microsoft.com/en-us/windows-server/failover-clustering/what-is-quorum-witness)

[Microsoft Learn: quorum](https://learn.microsoft.com/en-us/windows-server/storage/storage-spaces/quorum)

[Microsoft Learn: nf clusapi pauseclusternode](https://learn.microsoft.com/en-us/windows/win32/api/clusapi/nf-clusapi-pauseclusternode)

[Microsoft Learn: failover cluster accounts overview](https://learn.microsoft.com/en-us/windows-server/failover-clustering/failover-cluster-accounts-overview)

[Microsoft Learn: hyper v cluster connectivity management configuration](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-cluster-connectivity-management-configuration)


## Remediation: Resume this node with failback {#hypervprivatecloud.capability.cluster.resumenode.task}

`HyperVPrivateCloud.Capability.Cluster.ResumeNode.Task`

Resume-ClusterNode -Failback Immediate. Parameter = node name (default: this node).

### Summary

Resume this node with failback

### What it runs

Resume-ClusterNode -Failback Immediate. Parameter = node name (default: this node).

### Impact

This task changes the state of the target. The console asks for confirmation before it runs; use the read-only tasks first to confirm the diagnosis, and run it inside a change window where the environment requires one. The task output reports the resulting state.

### Support scope

Cluster membership, quorum, witness, inter-node network or collector health. Loss of redundancy can precede an outage even while VMs remain running.

Element: HyperVPrivateCloud.Capability.Cluster.ResumeNode.Task. Kind: Task.

### Execution safety

Target=HCSV2Library!HyperVPrivateCloud.HostRole; enabled=true; timeout=900. Read the task&#39;s original knowledge and parameters before execution. A Remediation task changes state and requires approval; do not execute it solely because the object is red. Even a diagnostic can generate logs or files; review its documented impact.

### Read-only investigation

Run Get-ClusterNode, Get-ClusterQuorum and Get-ClusterNetwork locally on a cluster node. Identify paused versus down nodes, configured and current votes, witness state and partitioned networks. Review maintenance and the first cluster event. For collection errors, verify the supported Windows PowerShell runtime and FailoverClusters module before interpreting zero counts.

### Corrective action and escalation

Restore the failed node, witness or network with the platform owner. Resume intentionally paused nodes only after maintenance is complete. Do not force quorum, change node weights or restart all nodes to clear a monitor. Repair collector access separately from workload health.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm expected membership, quorum resilience and network state, then verify fresh collector results and the originating monitor before the parent DA.

### Microsoft references

[Microsoft Learn: what is quorum witness](https://learn.microsoft.com/en-us/windows-server/failover-clustering/what-is-quorum-witness)

[Microsoft Learn: quorum](https://learn.microsoft.com/en-us/windows-server/storage/storage-spaces/quorum)

[Microsoft Learn: nf clusapi pauseclusternode](https://learn.microsoft.com/en-us/windows/win32/api/clusapi/nf-clusapi-pauseclusternode)

[Microsoft Learn: failover cluster accounts overview](https://learn.microsoft.com/en-us/windows-server/failover-clustering/failover-cluster-accounts-overview)

[Microsoft Learn: hyper v cluster connectivity management configuration](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-cluster-connectivity-management-configuration)


## Remediation: Clear node quarantine {#hypervprivatecloud.capability.cluster.clearquarantine.task}

`HyperVPrivateCloud.Capability.Cluster.ClearQuarantine.Task`

Start-ClusterNode -ClearQuarantine. Parameter = node name (default: this node).

### Summary

Clear node quarantine

### What it runs

Start-ClusterNode -ClearQuarantine. Parameter = node name (default: this node).

### Impact

This task changes the state of the target. The console asks for confirmation before it runs; use the read-only tasks first to confirm the diagnosis, and run it inside a change window where the environment requires one. The task output reports the resulting state.

### Support scope

Cluster membership, quorum, witness, inter-node network or collector health. Loss of redundancy can precede an outage even while VMs remain running.

Element: HyperVPrivateCloud.Capability.Cluster.ClearQuarantine.Task. Kind: Task.

### Execution safety

Target=HCSV2Library!HyperVPrivateCloud.HostRole; enabled=true; timeout=300. Read the task&#39;s original knowledge and parameters before execution. A Remediation task changes state and requires approval; do not execute it solely because the object is red. Even a diagnostic can generate logs or files; review its documented impact.

### Read-only investigation

Run Get-ClusterNode, Get-ClusterQuorum and Get-ClusterNetwork locally on a cluster node. Identify paused versus down nodes, configured and current votes, witness state and partitioned networks. Review maintenance and the first cluster event. For collection errors, verify the supported Windows PowerShell runtime and FailoverClusters module before interpreting zero counts.

### Corrective action and escalation

Restore the failed node, witness or network with the platform owner. Resume intentionally paused nodes only after maintenance is complete. Do not force quorum, change node weights or restart all nodes to clear a monitor. Repair collector access separately from workload health.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm expected membership, quorum resilience and network state, then verify fresh collector results and the originating monitor before the parent DA.

### Microsoft references

[Microsoft Learn: what is quorum witness](https://learn.microsoft.com/en-us/windows-server/failover-clustering/what-is-quorum-witness)

[Microsoft Learn: quorum](https://learn.microsoft.com/en-us/windows-server/storage/storage-spaces/quorum)

[Microsoft Learn: nf clusapi pauseclusternode](https://learn.microsoft.com/en-us/windows/win32/api/clusapi/nf-clusapi-pauseclusternode)

[Microsoft Learn: failover cluster accounts overview](https://learn.microsoft.com/en-us/windows-server/failover-clustering/failover-cluster-accounts-overview)

[Microsoft Learn: hyper v cluster connectivity management configuration](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-cluster-connectivity-management-configuration)


## Remediation: Start a failed cluster role {#hypervprivatecloud.capability.cluster.startgroup.task}

`HyperVPrivateCloud.Capability.Cluster.StartGroup.Task`

Start-ClusterGroup. Parameter = role (group) name.

### Summary

Start a failed cluster role

### What it runs

Start-ClusterGroup. Parameter = role (group) name.

### Impact

This task changes the state of the target. The console asks for confirmation before it runs; use the read-only tasks first to confirm the diagnosis, and run it inside a change window where the environment requires one. The task output reports the resulting state.

### Support scope

Cluster membership, quorum, witness, inter-node network or collector health. Loss of redundancy can precede an outage even while VMs remain running.

Element: HyperVPrivateCloud.Capability.Cluster.StartGroup.Task. Kind: Task.

### Execution safety

Target=HCSV2Library!HyperVPrivateCloud.HostRole; enabled=true; timeout=600. Read the task&#39;s original knowledge and parameters before execution. A Remediation task changes state and requires approval; do not execute it solely because the object is red. Even a diagnostic can generate logs or files; review its documented impact.

### Read-only investigation

Run Get-ClusterNode, Get-ClusterQuorum and Get-ClusterNetwork locally on a cluster node. Identify paused versus down nodes, configured and current votes, witness state and partitioned networks. Review maintenance and the first cluster event. For collection errors, verify the supported Windows PowerShell runtime and FailoverClusters module before interpreting zero counts.

### Corrective action and escalation

Restore the failed node, witness or network with the platform owner. Resume intentionally paused nodes only after maintenance is complete. Do not force quorum, change node weights or restart all nodes to clear a monitor. Repair collector access separately from workload health.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm expected membership, quorum resilience and network state, then verify fresh collector results and the originating monitor before the parent DA.

### Microsoft references

[Microsoft Learn: what is quorum witness](https://learn.microsoft.com/en-us/windows-server/failover-clustering/what-is-quorum-witness)

[Microsoft Learn: quorum](https://learn.microsoft.com/en-us/windows-server/storage/storage-spaces/quorum)

[Microsoft Learn: nf clusapi pauseclusternode](https://learn.microsoft.com/en-us/windows/win32/api/clusapi/nf-clusapi-pauseclusternode)

[Microsoft Learn: failover cluster accounts overview](https://learn.microsoft.com/en-us/windows-server/failover-clustering/failover-cluster-accounts-overview)

[Microsoft Learn: hyper v cluster connectivity management configuration](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-cluster-connectivity-management-configuration)


## Failover Cluster integration pipeline health {#hypervprivatecloud.capability.cluster.integrationhealth.monitor}

`HyperVPrivateCloud.Capability.Cluster.IntegrationHealth.Monitor`

Verifies the FailoverClusters PowerShell prerequisite and the queries required to populate HCS service-impact relationships.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.Fabric.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.Fabric.Service.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Service.Availability.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.Cluster.Availability.ClusterRole.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.Cluster.IntegrationHealth.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

Checks the adapter query path used to connect HCS private-cloud objects to Microsoft Failover Cluster and CSV objects.

### Operator response

Install RSAT-Clustering-PowerShell, verify HealthService permissions and cluster connectivity, confirm the Microsoft Cluster and CSV MPs are imported, then review Operations Manager events 8301 through 8303.

### Support scope

Cluster membership, quorum, witness, inter-node network or collector health. Loss of redundancy can precede an outage even while VMs remain running.

Element: HyperVPrivateCloud.Capability.Cluster.IntegrationHealth.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HyperVPrivateCloud.Capability.Cluster.ClusterRole. Parent health aspect: Health!System.Health.AvailabilityState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: (Property[@Name=&#39;ClusterIntegrationState&#39;] = Good OR Property[@Name=&#39;ClusterIntegrationState&#39;] = NotApplicable)

Warning [Warning]: Property[@Name=&#39;ClusterIntegrationState&#39;] = Warning

Error [Critical]: Property[@Name=&#39;ClusterIntegrationState&#39;] = Critical

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: BoundaryId=$Target/Property[Type=&quot;HyperVPrivateCloud.Capability.Cluster.ClusterRole&quot;]/BoundaryId$; ComputerName=$Target/Host/Property[Type=&quot;Windows!Microsoft.Windows.Computer&quot;]/PrincipalName$; IntervalSeconds=300; SyncTime=; TimeoutSeconds=120 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Error; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Run Get-ClusterNode, Get-ClusterQuorum and Get-ClusterNetwork locally on a cluster node. Identify paused versus down nodes, configured and current votes, witness state and partitioned networks. Review maintenance and the first cluster event. For collection errors, verify the supported Windows PowerShell runtime and FailoverClusters module before interpreting zero counts.

### Corrective action and escalation

Restore the failed node, witness or network with the platform owner. Resume intentionally paused nodes only after maintenance is complete. Do not force quorum, change node weights or restart all nodes to clear a monitor. Repair collector access separately from workload health.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm expected membership, quorum resilience and network state, then verify fresh collector results and the originating monitor before the parent DA.

### Microsoft references

[Microsoft Learn: what is quorum witness](https://learn.microsoft.com/en-us/windows-server/failover-clustering/what-is-quorum-witness)

[Microsoft Learn: quorum](https://learn.microsoft.com/en-us/windows-server/storage/storage-spaces/quorum)

[Microsoft Learn: nf clusapi pauseclusternode](https://learn.microsoft.com/en-us/windows/win32/api/clusapi/nf-clusapi-pauseclusternode)

[Microsoft Learn: failover cluster accounts overview](https://learn.microsoft.com/en-us/windows-server/failover-clustering/failover-cluster-accounts-overview)

[Microsoft Learn: hyper v cluster connectivity management configuration](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-cluster-connectivity-management-configuration)


## Cluster Shared Volume free space {#hypervprivatecloud.capability.cluster.csv.freespace.monitor}

`HyperVPrivateCloud.Capability.Cluster.CSV.FreeSpace.Monitor`

Measures the lowest percentage of free partition capacity among the collected Cluster Shared Volumes. The detail identifies the worst volume. Low free capacity threatens growth of VM disks, checkpoint chains and replication/backup files; the specific impact depends on the consumers and their disk behavior.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.Fabric.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.Fabric.Service.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Service.Availability.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.Cluster.Availability.ClusterRole.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.Cluster.CSV.FreeSpace.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

Measures the lowest percentage of free partition capacity among the collected Cluster Shared Volumes. The detail identifies the worst volume. Low free capacity threatens growth of VM disks, checkpoint chains and replication/backup files; the specific impact depends on the consumers and their disk behavior.

### Causes

Actual data growth, dynamic virtual disks, checkpoint chains, backup retention or replication backlog can consume free space. A thin-provisioned array or storage pool can also have a separate capacity constraint not represented by CSV filesystem free percentage.

### Resolution

Use the named CSV and owner to identify its consumers and compare filesystem, pool and array capacity. Arrange supported expansion or owner-approved workload/storage placement changes. Checkpoint cleanup must use supported Hyper-V or backup workflows with the chain and recovery implications reviewed; never manually delete AVHDX files. Investigate replication backlog rather than resetting replication merely because HRL files are large. Verify headroom and the latest monitor sample after the approved change.

### Support scope

Cluster Shared Volume accessibility, capacity or I/O pressure, as observed by the cluster collector; worst-volume metrics summarize multiple CSVs.

Element: HyperVPrivateCloud.Capability.Cluster.CSV.FreeSpace.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HyperVPrivateCloud.Capability.Cluster.ClusterRole. Parent health aspect: Health!System.Health.PerformanceState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: Property[@Name=&#39;CsvWorstFreePercent&#39;] &gt; 15

Warning [Warning]: (Property[@Name=&#39;CsvWorstFreePercent&#39;] &lt;= 15 AND Property[@Name=&#39;CsvWorstFreePercent&#39;] &gt; 8)

Error [Critical]: Property[@Name=&#39;CsvWorstFreePercent&#39;] &lt;= 8

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: BoundaryId=$Target/Property[Type=&quot;HyperVPrivateCloud.Capability.Cluster.ClusterRole&quot;]/BoundaryId$; ComputerName=$Target/Host/Property[Type=&quot;Windows!Microsoft.Windows.Computer&quot;]/PrincipalName$; CriticalThreshold=8; FailoverWindowHours=24; IntervalSeconds=300; PropertyName=CsvWorstFreePercent; SyncTime=; TimeoutSeconds=120; WarningThreshold=15 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Warning; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Run Get-ClusterSharedVolume and inspect SharedVolumeInfo, owner, state and partition free space for each volume. Correlate redirected or paused access with backup activity, storage-path health, System events and CSV performance samples. Compare all nodes before assuming the coordinator is the failing storage device.

### Corrective action and escalation

For unexpected redirection or offline storage, restore the failed storage/network dependency with the storage team. For low free space, stop unapproved growth and plan supported capacity expansion or owner-approved cleanup. Never delete VHDX/AVHDX files or force storage online as a generic alert response.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm every affected CSV is accessible from its intended nodes, expected direct access returns after maintenance, capacity headroom is restored, and latency stays below policy over a representative workload period.

### Microsoft references

[Microsoft Learn: failover cluster manage cluster shared volumes](https://learn.microsoft.com/en-us/windows-server/failover-clustering/failover-cluster-manage-cluster-shared-volumes)

[Microsoft Learn: storage issues in hyper v and windows server failover clusters](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/storage-issues-in-hyper-v-and-windows-server-failover-clusters)


## Cluster Shared Volume redirected access {#hypervprivatecloud.capability.cluster.csv.redirectedaccess.monitor}

`HyperVPrivateCloud.Capability.Cluster.CSV.RedirectedAccess.Monitor`

Raises a warning when the count of Cluster Shared Volumes in redirected access mode reaches WarningThreshold (default 1) and an error at CriticalThreshold (default 2). Both thresholds are overridable.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.Fabric.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.Fabric.Service.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Service.Availability.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.Cluster.Availability.ClusterRole.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.Cluster.CSV.RedirectedAccess.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

One or more Cluster Shared Volumes are in redirected access mode, so all I/O from non-coordinator nodes is forwarded over the cluster network to the coordinator instead of going direct to storage. Redirected mode is expected briefly during backups and volume maintenance; sustained redirected mode degrades virtual machine storage performance on every non-coordinator node.

### Causes

A backup application holding a CSV software snapshot (backup-induced redirected access).

Loss of direct storage connectivity from a node (SAN path, iSCSI session or S2D SBL failure) forcing redirected I/O for that node.

Filter drivers (antivirus, third-party replication, dedup) or ReFS volumes forcing file-system redirected mode.

Manual Suspend-ClusterResource or maintenance mode left in place.

### Resolutions

Run Get-ClusterSharedVolumeState to see which nodes are redirected and the StateInfo reason (FileSystemRedirected vs BlockRedirected, backup, no direct IO).

For BlockRedirected, repair that node&#39;s storage connectivity (MPIO paths, iSCSI sessions, HBA links) then verify I/O returns to direct mode.

For backup-induced redirection, confirm the backup job completes; if it never clears, remove the orphaned CSV snapshot with the backup vendor procedure.

Threshold values are counts of redirected CSVs; raise CriticalThreshold only if a documented design uses persistent redirected mode.

### Support scope

Cluster Shared Volume accessibility, capacity or I/O pressure, as observed by the cluster collector; worst-volume metrics summarize multiple CSVs.

Element: HyperVPrivateCloud.Capability.Cluster.CSV.RedirectedAccess.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HyperVPrivateCloud.Capability.Cluster.ClusterRole. Parent health aspect: Health!System.Health.PerformanceState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: Property[@Name=&#39;CsvRedirectedCount&#39;] &lt; 1

Warning [Warning]: (Property[@Name=&#39;CsvRedirectedCount&#39;] &gt;= 1 AND Property[@Name=&#39;CsvRedirectedCount&#39;] &lt; 2)

Error [Critical]: Property[@Name=&#39;CsvRedirectedCount&#39;] &gt;= 2

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: BoundaryId=$Target/Property[Type=&quot;HyperVPrivateCloud.Capability.Cluster.ClusterRole&quot;]/BoundaryId$; ComputerName=$Target/Host/Property[Type=&quot;Windows!Microsoft.Windows.Computer&quot;]/PrincipalName$; CriticalThreshold=2; FailoverWindowHours=24; IntervalSeconds=300; PropertyName=CsvRedirectedCount; SyncTime=; TimeoutSeconds=120; WarningThreshold=1 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Warning; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Run Get-ClusterSharedVolume and inspect SharedVolumeInfo, owner, state and partition free space for each volume. Correlate redirected or paused access with backup activity, storage-path health, System events and CSV performance samples. Compare all nodes before assuming the coordinator is the failing storage device.

### Corrective action and escalation

For unexpected redirection or offline storage, restore the failed storage/network dependency with the storage team. For low free space, stop unapproved growth and plan supported capacity expansion or owner-approved cleanup. Never delete VHDX/AVHDX files or force storage online as a generic alert response.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm every affected CSV is accessible from its intended nodes, expected direct access returns after maintenance, capacity headroom is restored, and latency stays below policy over a representative workload period.

### Microsoft references

[Microsoft Learn: failover cluster manage cluster shared volumes](https://learn.microsoft.com/en-us/windows-server/failover-clustering/failover-cluster-manage-cluster-shared-volumes)

[Microsoft Learn: storage issues in hyper v and windows server failover clusters](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/storage-issues-in-hyper-v-and-windows-server-failover-clusters)


## Cluster Shared Volume offline or failed {#hypervprivatecloud.capability.cluster.csv.offline.monitor}

`HyperVPrivateCloud.Capability.Cluster.CSV.Offline.Monitor`

Raises an error when the count of offline or failed Cluster Shared Volumes reaches CriticalThreshold (default 1). WarningThreshold defaults to 1 and both are overridable.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.Fabric.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.Fabric.Service.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Service.Availability.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.Cluster.Availability.ClusterRole.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.Cluster.CSV.Offline.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

At least one Cluster Shared Volume is offline or failed. Every virtual machine whose configuration or virtual hard disks live on that volume loses storage access and will be paused or fail.

### Causes

The underlying storage (LUN, S2D virtual disk, SAN) is unavailable or was removed.

The Physical Disk resource failed after exhausting restart attempts (FailoverClustering events 1069/1205).

Volume corruption requiring chkdsk / ReFS repair, or the disk went read-only.

Administrative Stop-ClusterResource or maintenance not completed.

### Resolutions

Get-ClusterSharedVolume and Get-ClusterResource -Name &quot;Cluster Disk *&quot; show the failed resource and owner; open the FailoverClustering-Manager and System event logs on that owner for the failure reason.

Restore storage presentation and paths, then Start-ClusterResource. For S2D, check Get-VirtualDisk and Get-StorageJob before bringing the CSV back.

Verify affected VMs (Get-VM &#124; Where State -ne Running) and resume them once the volume is online.

This monitor is intended to alert on the first offline CSV; do not raise CriticalThreshold above 1 in production.

### Support scope

Cluster Shared Volume accessibility, capacity or I/O pressure, as observed by the cluster collector; worst-volume metrics summarize multiple CSVs.

Element: HyperVPrivateCloud.Capability.Cluster.CSV.Offline.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HyperVPrivateCloud.Capability.Cluster.ClusterRole. Parent health aspect: Health!System.Health.AvailabilityState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: Property[@Name=&#39;CsvOfflineCount&#39;] &lt; 1

Warning [Warning]: (Property[@Name=&#39;CsvOfflineCount&#39;] &gt;= 1 AND Property[@Name=&#39;CsvOfflineCount&#39;] &lt; 1)

Error [Critical]: Property[@Name=&#39;CsvOfflineCount&#39;] &gt;= 1

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

Warning and critical thresholds are equal: this configuration has no intermediate numeric warning band. This can be intentional for discrete outages; do not claim an early warning is provided by this monitor.

### Sampling and effective policy

Compiled configuration: BoundaryId=$Target/Property[Type=&quot;HyperVPrivateCloud.Capability.Cluster.ClusterRole&quot;]/BoundaryId$; ComputerName=$Target/Host/Property[Type=&quot;Windows!Microsoft.Windows.Computer&quot;]/PrincipalName$; CriticalThreshold=1; FailoverWindowHours=24; IntervalSeconds=300; PropertyName=CsvOfflineCount; SyncTime=; TimeoutSeconds=120; WarningThreshold=1 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Warning; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Run Get-ClusterSharedVolume and inspect SharedVolumeInfo, owner, state and partition free space for each volume. Correlate redirected or paused access with backup activity, storage-path health, System events and CSV performance samples. Compare all nodes before assuming the coordinator is the failing storage device.

### Corrective action and escalation

For unexpected redirection or offline storage, restore the failed storage/network dependency with the storage team. For low free space, stop unapproved growth and plan supported capacity expansion or owner-approved cleanup. Never delete VHDX/AVHDX files or force storage online as a generic alert response.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm every affected CSV is accessible from its intended nodes, expected direct access returns after maintenance, capacity headroom is restored, and latency stays below policy over a representative workload period.

### Microsoft references

[Microsoft Learn: failover cluster manage cluster shared volumes](https://learn.microsoft.com/en-us/windows-server/failover-clustering/failover-cluster-manage-cluster-shared-volumes)

[Microsoft Learn: storage issues in hyper v and windows server failover clusters](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/storage-issues-in-hyper-v-and-windows-server-failover-clusters)


## Cluster Shared Volume paused {#hypervprivatecloud.capability.cluster.csv.paused.monitor}

`HyperVPrivateCloud.Capability.Cluster.CSV.Paused.Monitor`

Raises a warning when the count of paused Cluster Shared Volumes reaches WarningThreshold (default 1) and an error at CriticalThreshold (default 2). Both thresholds are overridable.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.Fabric.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.Fabric.Service.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Service.Availability.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.Cluster.Availability.ClusterRole.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.Cluster.CSV.Paused.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

One or more Cluster Shared Volumes are paused. A paused CSV holds I/O while the cluster recovers the volume or the coordinator moves; if the pause persists, virtual machines on the volume stall and eventually pause with critical storage errors (FailoverClustering event 5120/5142).

### Causes

Coordinator node failure or CSV ownership move in progress.

Storage latency or SMB/cluster-network interruption between nodes (event 5120 STATUS_IO_TIMEOUT / STATUS_CONNECTION_DISCONNECTED).

CSV filter or storage stack hang; excessive I/O on a single volume.

### Resolutions

Check Get-ClusterSharedVolumeState and the FailoverClustering-CsvFs operational log on the coordinator for 5120/5142 events and their NT status codes.

Investigate cluster network health (Get-ClusterNetwork, Test-Cluster network tests) and storage latency on the coordinator.

If the pause does not clear within minutes, move the CSV coordinator (Move-ClusterSharedVolume) to a healthy node and check whether I/O resumes.

Threshold values are counts of paused CSVs.

### Support scope

Cluster Shared Volume accessibility, capacity or I/O pressure, as observed by the cluster collector; worst-volume metrics summarize multiple CSVs.

Element: HyperVPrivateCloud.Capability.Cluster.CSV.Paused.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HyperVPrivateCloud.Capability.Cluster.ClusterRole. Parent health aspect: Health!System.Health.AvailabilityState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: Property[@Name=&#39;CsvPausedCount&#39;] &lt; 1

Warning [Warning]: (Property[@Name=&#39;CsvPausedCount&#39;] &gt;= 1 AND Property[@Name=&#39;CsvPausedCount&#39;] &lt; 2)

Error [Critical]: Property[@Name=&#39;CsvPausedCount&#39;] &gt;= 2

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: BoundaryId=$Target/Property[Type=&quot;HyperVPrivateCloud.Capability.Cluster.ClusterRole&quot;]/BoundaryId$; ComputerName=$Target/Host/Property[Type=&quot;Windows!Microsoft.Windows.Computer&quot;]/PrincipalName$; CriticalThreshold=2; FailoverWindowHours=24; IntervalSeconds=300; PropertyName=CsvPausedCount; SyncTime=; TimeoutSeconds=120; WarningThreshold=1 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Warning; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Run Get-ClusterSharedVolume and inspect SharedVolumeInfo, owner, state and partition free space for each volume. Correlate redirected or paused access with backup activity, storage-path health, System events and CSV performance samples. Compare all nodes before assuming the coordinator is the failing storage device.

### Corrective action and escalation

For unexpected redirection or offline storage, restore the failed storage/network dependency with the storage team. For low free space, stop unapproved growth and plan supported capacity expansion or owner-approved cleanup. Never delete VHDX/AVHDX files or force storage online as a generic alert response.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm every affected CSV is accessible from its intended nodes, expected direct access returns after maintenance, capacity headroom is restored, and latency stays below policy over a representative workload period.

### Microsoft references

[Microsoft Learn: failover cluster manage cluster shared volumes](https://learn.microsoft.com/en-us/windows-server/failover-clustering/failover-cluster-manage-cluster-shared-volumes)

[Microsoft Learn: storage issues in hyper v and windows server failover clusters](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/storage-issues-in-hyper-v-and-windows-server-failover-clusters)


## Cluster Shared Volume read latency {#hypervprivatecloud.capability.cluster.csv.readlatency.monitor}

`HyperVPrivateCloud.Capability.Cluster.CSV.ReadLatency.Monitor`

Raises a warning when the worst Cluster Shared Volume read latency reaches WarningThreshold milliseconds (default 25) and an error at CriticalThreshold milliseconds (default 50). Both thresholds are overridable.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.Fabric.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.Fabric.Service.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Service.Availability.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.Cluster.Availability.ClusterRole.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.Cluster.CSV.ReadLatency.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

The worst Cluster Shared Volume read latency across the cluster has reached the configured threshold in milliseconds. Sustained CSV read latency directly appears as guest disk latency inside every VM on that volume.

### Causes

Storage array or S2D pool saturation, cache misses or a rebuild/resync job consuming IOPS.

Redirected access mode adding a network hop to every read.

A noisy-neighbour VM, backup or antivirus scan generating a read storm.

Degraded MPIO or iSCSI paths reducing effective bandwidth.

### Resolutions

Correlate with the CSV performance views (Max Read Latency) and with the host physical disk latency monitors to see whether the array or the CSV layer is slow.

Identify top consumers with Get-StorageQoSFlow or Measure-VM / Hyper-V Virtual Storage Device counters and rebalance or throttle them (Storage QoS policies).

Check Get-ClusterSharedVolumeState for redirected access and repair direct I/O paths.

On all-flash storage lower WarningThreshold / CriticalThreshold; on hybrid or spinning media raise them to match the array design latency.

### Support scope

Cluster Shared Volume accessibility, capacity or I/O pressure, as observed by the cluster collector; worst-volume metrics summarize multiple CSVs.

Element: HyperVPrivateCloud.Capability.Cluster.CSV.ReadLatency.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HyperVPrivateCloud.Capability.Cluster.ClusterRole. Parent health aspect: Health!System.Health.PerformanceState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: Property[@Name=&#39;CsvMaxReadLatencyMs&#39;] &lt; 25

Warning [Warning]: (Property[@Name=&#39;CsvMaxReadLatencyMs&#39;] &gt;= 25 AND Property[@Name=&#39;CsvMaxReadLatencyMs&#39;] &lt; 50)

Error [Critical]: Property[@Name=&#39;CsvMaxReadLatencyMs&#39;] &gt;= 50

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: BoundaryId=$Target/Property[Type=&quot;HyperVPrivateCloud.Capability.Cluster.ClusterRole&quot;]/BoundaryId$; ComputerName=$Target/Host/Property[Type=&quot;Windows!Microsoft.Windows.Computer&quot;]/PrincipalName$; CriticalThreshold=50; FailoverWindowHours=24; IntervalSeconds=300; PropertyName=CsvMaxReadLatencyMs; SyncTime=; TimeoutSeconds=120; WarningThreshold=25 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Warning; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Run Get-ClusterSharedVolume and inspect SharedVolumeInfo, owner, state and partition free space for each volume. Correlate redirected or paused access with backup activity, storage-path health, System events and CSV performance samples. Compare all nodes before assuming the coordinator is the failing storage device.

### Corrective action and escalation

For unexpected redirection or offline storage, restore the failed storage/network dependency with the storage team. For low free space, stop unapproved growth and plan supported capacity expansion or owner-approved cleanup. Never delete VHDX/AVHDX files or force storage online as a generic alert response.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm every affected CSV is accessible from its intended nodes, expected direct access returns after maintenance, capacity headroom is restored, and latency stays below policy over a representative workload period.

### Microsoft references

[Microsoft Learn: failover cluster manage cluster shared volumes](https://learn.microsoft.com/en-us/windows-server/failover-clustering/failover-cluster-manage-cluster-shared-volumes)

[Microsoft Learn: storage issues in hyper v and windows server failover clusters](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/storage-issues-in-hyper-v-and-windows-server-failover-clusters)


## Cluster Shared Volume write latency {#hypervprivatecloud.capability.cluster.csv.writelatency.monitor}

`HyperVPrivateCloud.Capability.Cluster.CSV.WriteLatency.Monitor`

Raises a warning when the worst Cluster Shared Volume write latency reaches WarningThreshold milliseconds (default 25) and an error at CriticalThreshold milliseconds (default 50). Both thresholds are overridable.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.Fabric.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.Fabric.Service.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Service.Availability.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.Cluster.Availability.ClusterRole.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.Cluster.CSV.WriteLatency.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

The worst Cluster Shared Volume write latency across the cluster has reached the configured threshold in milliseconds. Write latency on a CSV is felt by every VM on the volume and is the most common cause of guest application timeouts.

### Causes

Write cache exhausted or disabled on the array or S2D cache tier; mirror resync or repair in progress.

Redirected access mode forcing writes over the cluster network.

Backup, checkpoint merge or storage migration traffic on the volume.

Path degradation (MPIO, iSCSI, RDMA) reducing write bandwidth.

### Resolutions

Review the CSV write-latency performance view and the S2D / SAN capability alerts raised at the same time.

Use Get-StorageQoSFlow or Hyper-V Virtual Storage Device counters to find the writer generating the load; move or throttle it.

Verify Get-ClusterSharedVolumeState shows direct I/O and that storage jobs (Get-StorageJob) are not running an unplanned repair.

Tune WarningThreshold / CriticalThreshold to the storage design latency; the defaults assume general-purpose hybrid storage.

### Support scope

Cluster Shared Volume accessibility, capacity or I/O pressure, as observed by the cluster collector; worst-volume metrics summarize multiple CSVs.

Element: HyperVPrivateCloud.Capability.Cluster.CSV.WriteLatency.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HyperVPrivateCloud.Capability.Cluster.ClusterRole. Parent health aspect: Health!System.Health.PerformanceState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: Property[@Name=&#39;CsvMaxWriteLatencyMs&#39;] &lt; 25

Warning [Warning]: (Property[@Name=&#39;CsvMaxWriteLatencyMs&#39;] &gt;= 25 AND Property[@Name=&#39;CsvMaxWriteLatencyMs&#39;] &lt; 50)

Error [Critical]: Property[@Name=&#39;CsvMaxWriteLatencyMs&#39;] &gt;= 50

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: BoundaryId=$Target/Property[Type=&quot;HyperVPrivateCloud.Capability.Cluster.ClusterRole&quot;]/BoundaryId$; ComputerName=$Target/Host/Property[Type=&quot;Windows!Microsoft.Windows.Computer&quot;]/PrincipalName$; CriticalThreshold=50; FailoverWindowHours=24; IntervalSeconds=300; PropertyName=CsvMaxWriteLatencyMs; SyncTime=; TimeoutSeconds=120; WarningThreshold=25 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Warning; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Run Get-ClusterSharedVolume and inspect SharedVolumeInfo, owner, state and partition free space for each volume. Correlate redirected or paused access with backup activity, storage-path health, System events and CSV performance samples. Compare all nodes before assuming the coordinator is the failing storage device.

### Corrective action and escalation

For unexpected redirection or offline storage, restore the failed storage/network dependency with the storage team. For low free space, stop unapproved growth and plan supported capacity expansion or owner-approved cleanup. Never delete VHDX/AVHDX files or force storage online as a generic alert response.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm every affected CSV is accessible from its intended nodes, expected direct access returns after maintenance, capacity headroom is restored, and latency stays below policy over a representative workload period.

### Microsoft references

[Microsoft Learn: failover cluster manage cluster shared volumes](https://learn.microsoft.com/en-us/windows-server/failover-clustering/failover-cluster-manage-cluster-shared-volumes)

[Microsoft Learn: storage issues in hyper v and windows server failover clusters](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/storage-issues-in-hyper-v-and-windows-server-failover-clusters)


## Cluster Shared Volume queue depth {#hypervprivatecloud.capability.cluster.csv.queuedepth.monitor}

`HyperVPrivateCloud.Capability.Cluster.CSV.QueueDepth.Monitor`

Raises a warning when the worst Cluster Shared Volume I/O queue length reaches WarningThreshold (default 32) and an error at CriticalThreshold (default 64). Both thresholds are overridable.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.Fabric.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.Fabric.Service.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Service.Availability.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.Cluster.Availability.ClusterRole.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.Cluster.CSV.QueueDepth.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

The worst Cluster Shared Volume I/O queue length has reached the configured threshold. A sustained deep queue means the volume is receiving more I/O than the storage beneath it can service, and latency will follow.

### Causes

Aggregate VM demand on a single CSV exceeding the LUN or virtual disk performance.

Storage rebuild, deduplication or backup job competing for the same spindles or SSDs.

Redirected access mode adding queueing at the coordinator.

### Resolutions

Identify the CSV in the performance view, then list VMs on it (Get-VM &#124; Get-VMHardDiskDrive &#124; Where Path -like &quot;*&lt;volume&gt;*&quot;).

Spread busy VMs across volumes with Move-VMStorage or apply Storage QoS limits to the offenders.

Confirm the array or S2D pool is healthy and not running an unplanned repair.

Thresholds are outstanding I/O counts; scale them with the number of spindles or the array queue depth.

### Support scope

Cluster Shared Volume accessibility, capacity or I/O pressure, as observed by the cluster collector; worst-volume metrics summarize multiple CSVs.

Element: HyperVPrivateCloud.Capability.Cluster.CSV.QueueDepth.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HyperVPrivateCloud.Capability.Cluster.ClusterRole. Parent health aspect: Health!System.Health.PerformanceState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: Property[@Name=&#39;CsvMaxQueueDepth&#39;] &lt; 32

Warning [Warning]: (Property[@Name=&#39;CsvMaxQueueDepth&#39;] &gt;= 32 AND Property[@Name=&#39;CsvMaxQueueDepth&#39;] &lt; 64)

Error [Critical]: Property[@Name=&#39;CsvMaxQueueDepth&#39;] &gt;= 64

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: BoundaryId=$Target/Property[Type=&quot;HyperVPrivateCloud.Capability.Cluster.ClusterRole&quot;]/BoundaryId$; ComputerName=$Target/Host/Property[Type=&quot;Windows!Microsoft.Windows.Computer&quot;]/PrincipalName$; CriticalThreshold=64; FailoverWindowHours=24; IntervalSeconds=300; PropertyName=CsvMaxQueueDepth; SyncTime=; TimeoutSeconds=120; WarningThreshold=32 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Warning; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Run Get-ClusterSharedVolume and inspect SharedVolumeInfo, owner, state and partition free space for each volume. Correlate redirected or paused access with backup activity, storage-path health, System events and CSV performance samples. Compare all nodes before assuming the coordinator is the failing storage device.

### Corrective action and escalation

For unexpected redirection or offline storage, restore the failed storage/network dependency with the storage team. For low free space, stop unapproved growth and plan supported capacity expansion or owner-approved cleanup. Never delete VHDX/AVHDX files or force storage online as a generic alert response.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm every affected CSV is accessible from its intended nodes, expected direct access returns after maintenance, capacity headroom is restored, and latency stays below policy over a representative workload period.

### Microsoft references

[Microsoft Learn: failover cluster manage cluster shared volumes](https://learn.microsoft.com/en-us/windows-server/failover-clustering/failover-cluster-manage-cluster-shared-volumes)

[Microsoft Learn: storage issues in hyper v and windows server failover clusters](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/storage-issues-in-hyper-v-and-windows-server-failover-clusters)


## Cluster node not up {#hypervprivatecloud.capability.cluster.node.down.monitor}

`HyperVPrivateCloud.Capability.Cluster.Node.Down.Monitor`

Raises a warning when the count of cluster nodes that are not in the Up state reaches WarningThreshold (default 1) and an error at CriticalThreshold (default 2). Both thresholds are overridable.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.Fabric.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.Fabric.Service.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Service.Availability.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.Cluster.Availability.ClusterRole.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.Cluster.Node.Down.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

One or more cluster nodes are not in the Up state (Down, Joining or Quarantined). Capacity and resilience are reduced; virtual machines that were on the node have failed over or are offline, and quorum may be at risk.

### Causes

Unplanned host failure, reboot or power loss.

Cluster service stopped, or network isolation causing the node to be evicted from membership (FailoverClustering event 1135).

Node quarantined after repeatedly leaving and rejoining (event 1177/1200 series).

Planned maintenance where the node was not paused first.

### Resolutions

Get-ClusterNode shows the node state; check the System and FailoverClustering-Manager logs on the affected node and the current coordinator (events 1135, 1177, 1146).

Restore the host, start the Cluster Service, or Start-ClusterNode -ClearQuarantine once the underlying network or hardware issue is fixed.

Verify VM placement afterwards (Get-ClusterGroup) and rebalance.

WarningThreshold is the first node down; CriticalThreshold defaults to 2 because losing two nodes usually threatens quorum or S2D resiliency.

### Support scope

Cluster membership, quorum, witness, inter-node network or collector health. Loss of redundancy can precede an outage even while VMs remain running.

Element: HyperVPrivateCloud.Capability.Cluster.Node.Down.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HyperVPrivateCloud.Capability.Cluster.ClusterRole. Parent health aspect: Health!System.Health.AvailabilityState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: Property[@Name=&#39;NodeDownCount&#39;] &lt; 1

Warning [Warning]: (Property[@Name=&#39;NodeDownCount&#39;] &gt;= 1 AND Property[@Name=&#39;NodeDownCount&#39;] &lt; 2)

Error [Critical]: Property[@Name=&#39;NodeDownCount&#39;] &gt;= 2

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: BoundaryId=$Target/Property[Type=&quot;HyperVPrivateCloud.Capability.Cluster.ClusterRole&quot;]/BoundaryId$; ComputerName=$Target/Host/Property[Type=&quot;Windows!Microsoft.Windows.Computer&quot;]/PrincipalName$; CriticalThreshold=2; FailoverWindowHours=24; IntervalSeconds=300; PropertyName=NodeDownCount; SyncTime=; TimeoutSeconds=120; WarningThreshold=1 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Warning; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Run Get-ClusterNode, Get-ClusterQuorum and Get-ClusterNetwork locally on a cluster node. Identify paused versus down nodes, configured and current votes, witness state and partitioned networks. Review maintenance and the first cluster event. For collection errors, verify the supported Windows PowerShell runtime and FailoverClusters module before interpreting zero counts.

### Corrective action and escalation

Restore the failed node, witness or network with the platform owner. Resume intentionally paused nodes only after maintenance is complete. Do not force quorum, change node weights or restart all nodes to clear a monitor. Repair collector access separately from workload health.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm expected membership, quorum resilience and network state, then verify fresh collector results and the originating monitor before the parent DA.

### Microsoft references

[Microsoft Learn: what is quorum witness](https://learn.microsoft.com/en-us/windows-server/failover-clustering/what-is-quorum-witness)

[Microsoft Learn: quorum](https://learn.microsoft.com/en-us/windows-server/storage/storage-spaces/quorum)

[Microsoft Learn: nf clusapi pauseclusternode](https://learn.microsoft.com/en-us/windows/win32/api/clusapi/nf-clusapi-pauseclusternode)

[Microsoft Learn: failover cluster accounts overview](https://learn.microsoft.com/en-us/windows-server/failover-clustering/failover-cluster-accounts-overview)

[Microsoft Learn: hyper v cluster connectivity management configuration](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-cluster-connectivity-management-configuration)


## Cluster node paused {#hypervprivatecloud.capability.cluster.node.paused.monitor}

`HyperVPrivateCloud.Capability.Cluster.Node.Paused.Monitor`

Raises a warning when the count of paused cluster nodes reaches WarningThreshold (default 1) and an error at CriticalThreshold (default 3). Both thresholds are overridable.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.Fabric.Configuration.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.Fabric.Service.Configuration.Dependency.Monitor &gt; HyperVPrivateCloud.Service.Availability.Configuration.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.Cluster.Availability.ClusterRole.Configuration.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.Cluster.Node.Paused.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

One or more cluster nodes are paused. A paused node hosts no roles and is normally a deliberate maintenance state (Cluster-Aware Updating, patching, hardware work). Nodes left paused reduce capacity and, for S2D, delay repair jobs.

### Causes

Planned maintenance (Suspend-ClusterNode, CAU run, drain) not yet resumed.

Failed drain-on-shutdown or CAU run that stopped mid-way.

S2D storage maintenance mode still enabled on the node.

### Resolutions

Get-ClusterNode and Get-StorageFaultDomain -Type StorageScaleUnit show paused nodes and storage maintenance mode.

If maintenance is complete run Resume-ClusterNode -Failback Immediate and Disable-StorageMaintenanceMode where applicable.

Review the CAU run history if the pause was automated.

Thresholds are node counts; raise WarningThreshold if your patching design pauses more than one node at a time.

### Support scope

Cluster membership, quorum, witness, inter-node network or collector health. Loss of redundancy can precede an outage even while VMs remain running.

Element: HyperVPrivateCloud.Capability.Cluster.Node.Paused.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HyperVPrivateCloud.Capability.Cluster.ClusterRole. Parent health aspect: Health!System.Health.ConfigurationState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: Property[@Name=&#39;NodePausedCount&#39;] &lt; 2

Warning [Warning]: (Property[@Name=&#39;NodePausedCount&#39;] &gt;= 2 AND Property[@Name=&#39;NodePausedCount&#39;] &lt; 3)

Error [Critical]: Property[@Name=&#39;NodePausedCount&#39;] &gt;= 3

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: BoundaryId=$Target/Property[Type=&quot;HyperVPrivateCloud.Capability.Cluster.ClusterRole&quot;]/BoundaryId$; ComputerName=$Target/Host/Property[Type=&quot;Windows!Microsoft.Windows.Computer&quot;]/PrincipalName$; CriticalThreshold=3; FailoverWindowHours=24; IntervalSeconds=300; PropertyName=NodePausedCount; SyncTime=; TimeoutSeconds=120; WarningThreshold=2 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Warning; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Run Get-ClusterNode, Get-ClusterQuorum and Get-ClusterNetwork locally on a cluster node. Identify paused versus down nodes, configured and current votes, witness state and partitioned networks. Review maintenance and the first cluster event. For collection errors, verify the supported Windows PowerShell runtime and FailoverClusters module before interpreting zero counts.

### Corrective action and escalation

Restore the failed node, witness or network with the platform owner. Resume intentionally paused nodes only after maintenance is complete. Do not force quorum, change node weights or restart all nodes to clear a monitor. Repair collector access separately from workload health.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm expected membership, quorum resilience and network state, then verify fresh collector results and the originating monitor before the parent DA.

### Microsoft references

[Microsoft Learn: what is quorum witness](https://learn.microsoft.com/en-us/windows-server/failover-clustering/what-is-quorum-witness)

[Microsoft Learn: quorum](https://learn.microsoft.com/en-us/windows-server/storage/storage-spaces/quorum)

[Microsoft Learn: nf clusapi pauseclusternode](https://learn.microsoft.com/en-us/windows/win32/api/clusapi/nf-clusapi-pauseclusternode)

[Microsoft Learn: failover cluster accounts overview](https://learn.microsoft.com/en-us/windows-server/failover-clustering/failover-cluster-accounts-overview)

[Microsoft Learn: hyper v cluster connectivity management configuration](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-cluster-connectivity-management-configuration)


## Cluster quorum witness state {#hypervprivatecloud.capability.cluster.quorum.witness.monitor}

`HyperVPrivateCloud.Capability.Cluster.Quorum.Witness.Monitor`

Raises an error when the configured quorum witness resource is not online, that is when the witness failure count reaches CriticalThreshold (default 1). WarningThreshold defaults to 1 and both are overridable.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.Fabric.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.Fabric.Service.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Service.Availability.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.Cluster.Availability.ClusterRole.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.Cluster.Quorum.Witness.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

The configured quorum witness (disk, file share or cloud witness) is not online. Without the witness, the cluster loses its tie-breaking vote and an even-node split or a further node loss can take the whole cluster offline.

### Causes

File share witness server or share unavailable, permissions changed, or SMB signing/encryption mismatch.

Cloud witness storage account key rotated, expired or blocked by a proxy/firewall change.

Disk witness LUN unpresented or failed.

Witness resource failed repeatedly and was left offline (event 1069 for the witness resource).

### Resolutions

Get-ClusterQuorum and Get-ClusterResource -Name &quot;*Witness*&quot; show the witness type and state; the FailoverClustering-Manager log gives the failure reason (1558/1562/1564 series).

Restore access to the witness share, storage account or LUN, then Start-ClusterResource on the witness.

For cloud witness rotate the key with Set-ClusterQuorum -CloudWitness -AccountName ... -AccessKey ....

This monitor should stay at CriticalThreshold 1; the witness is either available or not.

### Support scope

Cluster membership, quorum, witness, inter-node network or collector health. Loss of redundancy can precede an outage even while VMs remain running.

Element: HyperVPrivateCloud.Capability.Cluster.Quorum.Witness.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HyperVPrivateCloud.Capability.Cluster.ClusterRole. Parent health aspect: Health!System.Health.AvailabilityState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: Property[@Name=&#39;QuorumWitnessFailedCount&#39;] &lt; 1

Warning [Warning]: (Property[@Name=&#39;QuorumWitnessFailedCount&#39;] &gt;= 1 AND Property[@Name=&#39;QuorumWitnessFailedCount&#39;] &lt; 1)

Error [Critical]: Property[@Name=&#39;QuorumWitnessFailedCount&#39;] &gt;= 1

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

Warning and critical thresholds are equal: this configuration has no intermediate numeric warning band. This can be intentional for discrete outages; do not claim an early warning is provided by this monitor.

### Sampling and effective policy

Compiled configuration: BoundaryId=$Target/Property[Type=&quot;HyperVPrivateCloud.Capability.Cluster.ClusterRole&quot;]/BoundaryId$; ComputerName=$Target/Host/Property[Type=&quot;Windows!Microsoft.Windows.Computer&quot;]/PrincipalName$; CriticalThreshold=1; FailoverWindowHours=24; IntervalSeconds=300; PropertyName=QuorumWitnessFailedCount; SyncTime=; TimeoutSeconds=120; WarningThreshold=1 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Warning; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Run Get-ClusterNode, Get-ClusterQuorum and Get-ClusterNetwork locally on a cluster node. Identify paused versus down nodes, configured and current votes, witness state and partitioned networks. Review maintenance and the first cluster event. For collection errors, verify the supported Windows PowerShell runtime and FailoverClusters module before interpreting zero counts.

### Corrective action and escalation

Restore the failed node, witness or network with the platform owner. Resume intentionally paused nodes only after maintenance is complete. Do not force quorum, change node weights or restart all nodes to clear a monitor. Repair collector access separately from workload health.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm expected membership, quorum resilience and network state, then verify fresh collector results and the originating monitor before the parent DA.

### Microsoft references

[Microsoft Learn: what is quorum witness](https://learn.microsoft.com/en-us/windows-server/failover-clustering/what-is-quorum-witness)

[Microsoft Learn: quorum](https://learn.microsoft.com/en-us/windows-server/storage/storage-spaces/quorum)

[Microsoft Learn: nf clusapi pauseclusternode](https://learn.microsoft.com/en-us/windows/win32/api/clusapi/nf-clusapi-pauseclusternode)

[Microsoft Learn: failover cluster accounts overview](https://learn.microsoft.com/en-us/windows-server/failover-clustering/failover-cluster-accounts-overview)

[Microsoft Learn: hyper v cluster connectivity management configuration](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-cluster-connectivity-management-configuration)


## Cluster quorum vote margin {#hypervprivatecloud.capability.cluster.quorum.votemargin.monitor}

`HyperVPrivateCloud.Capability.Cluster.Quorum.VoteMargin.Monitor`

Tracks how many further quorum votes may be lost before the cluster loses quorum. Raises a warning at or below WarningThreshold votes (default 2) and an error at or below CriticalThreshold votes (default 1). Both thresholds are overridable.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.Fabric.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.Fabric.Service.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Service.Availability.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.Cluster.Availability.ClusterRole.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.Cluster.Quorum.VoteMargin.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

The cluster can lose only the reported number of further quorum votes before it loses quorum and stops. Vote margin counts current voting members (nodes plus witness) against the majority needed under dynamic quorum.

### Causes

Nodes down or paused reducing the number of votes.

Witness offline (see the quorum witness monitor).

Dynamic quorum has already adjusted votes after previous failures; NodeWeight set to 0 on nodes by design or accident.

### Resolutions

Get-ClusterNode &#124; Select Name,State,NodeWeight,DynamicWeight and Get-ClusterQuorum show where votes were lost.

Restore failed nodes or the witness first; only then revisit NodeWeight settings.

Avoid maintenance on additional nodes while the margin is at the Warning value.

CriticalThreshold is pinned to 1 vote in every tuning tier because losing quorum is never a warning-level condition.

### Support scope

Cluster membership, quorum, witness, inter-node network or collector health. Loss of redundancy can precede an outage even while VMs remain running.

Element: HyperVPrivateCloud.Capability.Cluster.Quorum.VoteMargin.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HyperVPrivateCloud.Capability.Cluster.ClusterRole. Parent health aspect: Health!System.Health.AvailabilityState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: Property[@Name=&#39;QuorumVoteMarginCount&#39;] &gt; 0

Warning [Warning]: (Property[@Name=&#39;QuorumVoteMarginCount&#39;] &lt;= 0 AND Property[@Name=&#39;QuorumVoteMarginCount&#39;] &gt; -1)

Error [Critical]: Property[@Name=&#39;QuorumVoteMarginCount&#39;] &lt;= -1

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: BoundaryId=$Target/Property[Type=&quot;HyperVPrivateCloud.Capability.Cluster.ClusterRole&quot;]/BoundaryId$; ComputerName=$Target/Host/Property[Type=&quot;Windows!Microsoft.Windows.Computer&quot;]/PrincipalName$; CriticalThreshold=-1; FailoverWindowHours=24; IntervalSeconds=300; PropertyName=QuorumVoteMarginCount; SyncTime=; TimeoutSeconds=120; WarningThreshold=0 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Warning; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Run Get-ClusterNode, Get-ClusterQuorum and Get-ClusterNetwork locally on a cluster node. Identify paused versus down nodes, configured and current votes, witness state and partitioned networks. Review maintenance and the first cluster event. For collection errors, verify the supported Windows PowerShell runtime and FailoverClusters module before interpreting zero counts.

### Corrective action and escalation

Restore the failed node, witness or network with the platform owner. Resume intentionally paused nodes only after maintenance is complete. Do not force quorum, change node weights or restart all nodes to clear a monitor. Repair collector access separately from workload health.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm expected membership, quorum resilience and network state, then verify fresh collector results and the originating monitor before the parent DA.

### Microsoft references

[Microsoft Learn: what is quorum witness](https://learn.microsoft.com/en-us/windows-server/failover-clustering/what-is-quorum-witness)

[Microsoft Learn: quorum](https://learn.microsoft.com/en-us/windows-server/storage/storage-spaces/quorum)

[Microsoft Learn: nf clusapi pauseclusternode](https://learn.microsoft.com/en-us/windows/win32/api/clusapi/nf-clusapi-pauseclusternode)

[Microsoft Learn: failover cluster accounts overview](https://learn.microsoft.com/en-us/windows-server/failover-clustering/failover-cluster-accounts-overview)

[Microsoft Learn: hyper v cluster connectivity management configuration](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-cluster-connectivity-management-configuration)


## Cluster network partitioned {#hypervprivatecloud.capability.cluster.network.partitioned.monitor}

`HyperVPrivateCloud.Capability.Cluster.Network.Partitioned.Monitor`

Raises an error when the count of partitioned cluster networks reaches CriticalThreshold (default 1). WarningThreshold defaults to 1 and both are overridable.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.Fabric.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.Fabric.Service.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Service.Availability.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.Cluster.Availability.ClusterRole.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.Cluster.Network.Partitioned.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

A cluster network is partitioned: some nodes can reach each other on it and others cannot. Partitioned networks break live migration, CSV redirected I/O and S2D SBL traffic and are a common precursor to node eviction.

### Causes

Physical switch, VLAN or trunk misconfiguration affecting a subset of nodes.

NIC or SET team member failure on one or more nodes; RDMA/DCB misconfiguration.

Firewall or IPsec policy blocking cluster heartbeat (UDP 3343) between some nodes.

Network ATC intent drift or a node that missed a configuration update.

### Resolutions

Get-ClusterNetwork and Get-ClusterNetworkInterface show which interfaces are Unreachable/Failed per node.

Test connectivity between the affected nodes on that subnet (Test-NetConnection, Test-Cluster -Include Network).

Repair the switch/VLAN/NIC fault; on Network ATC clusters run Get-NetIntentStatus and remediate the drifted host.

This monitor defaults to CriticalThreshold 1 partitioned network.

### Support scope

Cluster membership, quorum, witness, inter-node network or collector health. Loss of redundancy can precede an outage even while VMs remain running.

Element: HyperVPrivateCloud.Capability.Cluster.Network.Partitioned.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HyperVPrivateCloud.Capability.Cluster.ClusterRole. Parent health aspect: Health!System.Health.AvailabilityState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: Property[@Name=&#39;NetworkPartitionedCount&#39;] &lt; 1

Warning [Warning]: (Property[@Name=&#39;NetworkPartitionedCount&#39;] &gt;= 1 AND Property[@Name=&#39;NetworkPartitionedCount&#39;] &lt; 1)

Error [Critical]: Property[@Name=&#39;NetworkPartitionedCount&#39;] &gt;= 1

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

Warning and critical thresholds are equal: this configuration has no intermediate numeric warning band. This can be intentional for discrete outages; do not claim an early warning is provided by this monitor.

### Sampling and effective policy

Compiled configuration: BoundaryId=$Target/Property[Type=&quot;HyperVPrivateCloud.Capability.Cluster.ClusterRole&quot;]/BoundaryId$; ComputerName=$Target/Host/Property[Type=&quot;Windows!Microsoft.Windows.Computer&quot;]/PrincipalName$; CriticalThreshold=1; FailoverWindowHours=24; IntervalSeconds=300; PropertyName=NetworkPartitionedCount; SyncTime=; TimeoutSeconds=120; WarningThreshold=1 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Warning; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Run Get-ClusterNode, Get-ClusterQuorum and Get-ClusterNetwork locally on a cluster node. Identify paused versus down nodes, configured and current votes, witness state and partitioned networks. Review maintenance and the first cluster event. For collection errors, verify the supported Windows PowerShell runtime and FailoverClusters module before interpreting zero counts.

### Corrective action and escalation

Restore the failed node, witness or network with the platform owner. Resume intentionally paused nodes only after maintenance is complete. Do not force quorum, change node weights or restart all nodes to clear a monitor. Repair collector access separately from workload health.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm expected membership, quorum resilience and network state, then verify fresh collector results and the originating monitor before the parent DA.

### Microsoft references

[Microsoft Learn: what is quorum witness](https://learn.microsoft.com/en-us/windows-server/failover-clustering/what-is-quorum-witness)

[Microsoft Learn: quorum](https://learn.microsoft.com/en-us/windows-server/storage/storage-spaces/quorum)

[Microsoft Learn: nf clusapi pauseclusternode](https://learn.microsoft.com/en-us/windows/win32/api/clusapi/nf-clusapi-pauseclusternode)

[Microsoft Learn: failover cluster accounts overview](https://learn.microsoft.com/en-us/windows-server/failover-clustering/failover-cluster-accounts-overview)

[Microsoft Learn: hyper v cluster connectivity management configuration](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-cluster-connectivity-management-configuration)


## Cluster network down {#hypervprivatecloud.capability.cluster.network.down.monitor}

`HyperVPrivateCloud.Capability.Cluster.Network.Down.Monitor`

Raises a warning when the count of cluster networks in the Down state reaches WarningThreshold (default 1) and an error at CriticalThreshold (default 2). Both thresholds are overridable.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.Fabric.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.Fabric.Service.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Service.Availability.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.Cluster.Availability.ClusterRole.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.Cluster.Network.Down.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

One or more cluster networks are in the Down state, meaning the cluster cannot use that network on any node. If it was a live-migration, storage or management network the corresponding traffic has failed over to another network or stopped.

### Causes

Switch or uplink outage taking the whole subnet down.

The network&#39;s role was set to None and it is no longer used by the cluster (expected for isolated networks such as backup).

All NICs on that subnet disabled or unplugged during maintenance.

### Resolutions

Get-ClusterNetwork shows the Down network and its role; Get-ClusterNetworkInterface shows the per-node interface state.

Restore the physical network and confirm interfaces return to Up.

If the network is intentionally unused, remove it from cluster use rather than leaving it Down, so this monitor reflects real faults.

Thresholds are counts of Down networks.

### Support scope

Cluster membership, quorum, witness, inter-node network or collector health. Loss of redundancy can precede an outage even while VMs remain running.

Element: HyperVPrivateCloud.Capability.Cluster.Network.Down.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HyperVPrivateCloud.Capability.Cluster.ClusterRole. Parent health aspect: Health!System.Health.AvailabilityState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: Property[@Name=&#39;NetworkDownCount&#39;] &lt; 1

Warning [Warning]: (Property[@Name=&#39;NetworkDownCount&#39;] &gt;= 1 AND Property[@Name=&#39;NetworkDownCount&#39;] &lt; 2)

Error [Critical]: Property[@Name=&#39;NetworkDownCount&#39;] &gt;= 2

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: BoundaryId=$Target/Property[Type=&quot;HyperVPrivateCloud.Capability.Cluster.ClusterRole&quot;]/BoundaryId$; ComputerName=$Target/Host/Property[Type=&quot;Windows!Microsoft.Windows.Computer&quot;]/PrincipalName$; CriticalThreshold=2; FailoverWindowHours=24; IntervalSeconds=300; PropertyName=NetworkDownCount; SyncTime=; TimeoutSeconds=120; WarningThreshold=1 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Warning; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Run Get-ClusterNode, Get-ClusterQuorum and Get-ClusterNetwork locally on a cluster node. Identify paused versus down nodes, configured and current votes, witness state and partitioned networks. Review maintenance and the first cluster event. For collection errors, verify the supported Windows PowerShell runtime and FailoverClusters module before interpreting zero counts.

### Corrective action and escalation

Restore the failed node, witness or network with the platform owner. Resume intentionally paused nodes only after maintenance is complete. Do not force quorum, change node weights or restart all nodes to clear a monitor. Repair collector access separately from workload health.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm expected membership, quorum resilience and network state, then verify fresh collector results and the originating monitor before the parent DA.

### Microsoft references

[Microsoft Learn: what is quorum witness](https://learn.microsoft.com/en-us/windows-server/failover-clustering/what-is-quorum-witness)

[Microsoft Learn: quorum](https://learn.microsoft.com/en-us/windows-server/storage/storage-spaces/quorum)

[Microsoft Learn: nf clusapi pauseclusternode](https://learn.microsoft.com/en-us/windows/win32/api/clusapi/nf-clusapi-pauseclusternode)

[Microsoft Learn: failover cluster accounts overview](https://learn.microsoft.com/en-us/windows-server/failover-clustering/failover-cluster-accounts-overview)

[Microsoft Learn: hyper v cluster connectivity management configuration](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-cluster-connectivity-management-configuration)


## Cluster role failure episodes {#hypervprivatecloud.capability.cluster.group.failover.monitor}

`HyperVPrivateCloud.Capability.Cluster.Group.Failover.Monitor`

Counts local role failure episodes from System provider Microsoft-Windows-FailoverClustering events 1069, 1205 and 1254 within FailoverWindowHours. Named ResourceGroup fields correlate resource failures with their owning role; each role/five-minute bucket counts once. This is an approximate retry/failure indicator, not a count of ownership changes, VM migrations or cluster failovers. Event 1177 is not included.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.Fabric.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.Fabric.Service.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Service.Availability.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.Cluster.Availability.ClusterRole.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.Cluster.Group.Failover.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

Counts local role failure episodes from System provider Microsoft-Windows-FailoverClustering events 1069, 1205 and 1254 within FailoverWindowHours. Named ResourceGroup fields correlate resource failures with their owning role; each role/five-minute bucket counts once. This is an approximate retry/failure indicator, not a count of ownership changes, VM migrations or cluster failovers. Event 1177 is not included.

### Causes

A resource can repeatedly fail without ever moving. Examples include a missing VM configuration path, an inaccessible storage dependency, or a Replica Broker network name that cannot create its AD computer object. A five-minute bucket is an aggregation policy, not an assertion that each bucket contains exactly one incident. Only events retained on the current collector node are counted; owner changes and log retention can change observed coverage.

### Resolution

Use GroupDetail to identify the role, current owner, recent resource error and UTC evidence. Inspect the first failing dependency before considering recovery. Preserve configured identity and thresholds. After the cause is repaired, current resource health can recover before the rolling failure count drops below its thresholds.

### Support scope

Clustered role failure and retry evidence. A role may contain several resources; locate the first failed dependency rather than treating every alert as a separate outage.

Element: HyperVPrivateCloud.Capability.Cluster.Group.Failover.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HyperVPrivateCloud.Capability.Cluster.ClusterRole. Parent health aspect: Health!System.Health.AvailabilityState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: Property[@Name=&#39;GroupFailoverEventCount&#39;] &lt; 3

Warning [Warning]: (Property[@Name=&#39;GroupFailoverEventCount&#39;] &gt;= 3 AND Property[@Name=&#39;GroupFailoverEventCount&#39;] &lt; 6)

Error [Critical]: Property[@Name=&#39;GroupFailoverEventCount&#39;] &gt;= 6

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: BoundaryId=$Target/Property[Type=&quot;HyperVPrivateCloud.Capability.Cluster.ClusterRole&quot;]/BoundaryId$; ComputerName=$Target/Host/Property[Type=&quot;Windows!Microsoft.Windows.Computer&quot;]/PrincipalName$; CriticalThreshold=6; FailoverWindowHours=24; IntervalSeconds=300; PropertyName=GroupFailoverEventCount; SyncTime=; TimeoutSeconds=120; WarningThreshold=3 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Warning; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

On the current owner, run Get-ClusterGroup and pipe the affected group to Get-ClusterResource. Read the local System log provider Microsoft-Windows-FailoverClustering, including 1069, 1194, 1205 and 1254. Match named ResourceGroup and ResourceName fields, timestamp and error code. For VM configuration failures, compare VmId with Get-VM on every possible owner and verify the configuration path exists.

### Corrective action and escalation

Restore the specific missing dependency with its owning team. A Network Name creation failure needs the directory team to validate the cluster name account, destination container permissions, quota and any prestaged virtual computer object. A missing VM configuration needs backup/storage and VMM inventory reconciliation. Remove an orphaned role only after its owner confirms retirement and recoverability. Do not repeatedly restart a role or increase failover thresholds to hide the cause.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Verify resources and intended workloads are online, new failure events stop, and native and SCOM leaf states recover. Failure-window monitors can remain elevated until old episodes age out. An intentionally stopped VM or empty Available Storage group is not by itself evidence of a cluster outage.

### Microsoft references

[Microsoft Learn: prestage cluster adds](https://learn.microsoft.com/en-us/windows-server/failover-clustering/prestage-cluster-adds)

[Microsoft Learn: hyper v start state access failures clustered standalone](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-start-state-access-failures-clustered-standalone)


## Cluster role failed or partially online {#hypervprivatecloud.capability.cluster.group.failed.monitor}

`HyperVPrivateCloud.Capability.Cluster.Group.Failed.Monitor`

Counts cluster groups whose group-level state is Failed or PartialOnline. Offline is reported separately in detail and is not included in this count. A group can be Offline while one of its configuration resources is Failed; inspect native resource health and the Microsoft Cluster leaf monitors as well.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.Fabric.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.Fabric.Service.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Service.Availability.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.Cluster.Availability.ClusterRole.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.Cluster.Group.Failed.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

Counts cluster groups whose group-level state is Failed or PartialOnline. Offline is reported separately in detail and is not included in this count. A group can be Offline while one of its configuration resources is Failed; inspect native resource health and the Microsoft Cluster leaf monitors as well.

### Causes

A dependent resource failed, a VM configuration or storage path is missing, or restart/failover attempts were exhausted. The parent group state alone does not identify which resource caused the problem.

### Resolution

Run Get-ClusterGroup -Name &lt;role&gt; &#124; Get-ClusterResource on a cluster node, inspect the failed resource and its first error, and coordinate the specific repair. Do not use the unsupported Get-ClusterResource -Group syntax. Starting a group changes workload state and requires owner approval. Verify intended resource and workload state afterwards.

### Support scope

Clustered role failure and retry evidence. A role may contain several resources; locate the first failed dependency rather than treating every alert as a separate outage.

Element: HyperVPrivateCloud.Capability.Cluster.Group.Failed.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HyperVPrivateCloud.Capability.Cluster.ClusterRole. Parent health aspect: Health!System.Health.AvailabilityState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: Property[@Name=&#39;GroupFailedCount&#39;] &lt; 1

Warning [Warning]: (Property[@Name=&#39;GroupFailedCount&#39;] &gt;= 1 AND Property[@Name=&#39;GroupFailedCount&#39;] &lt; 1)

Error [Critical]: Property[@Name=&#39;GroupFailedCount&#39;] &gt;= 1

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

Warning and critical thresholds are equal: this configuration has no intermediate numeric warning band. This can be intentional for discrete outages; do not claim an early warning is provided by this monitor.

### Sampling and effective policy

Compiled configuration: BoundaryId=$Target/Property[Type=&quot;HyperVPrivateCloud.Capability.Cluster.ClusterRole&quot;]/BoundaryId$; ComputerName=$Target/Host/Property[Type=&quot;Windows!Microsoft.Windows.Computer&quot;]/PrincipalName$; CriticalThreshold=1; FailoverWindowHours=24; IntervalSeconds=300; PropertyName=GroupFailedCount; SyncTime=; TimeoutSeconds=120; WarningThreshold=1 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Warning; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

On the current owner, run Get-ClusterGroup and pipe the affected group to Get-ClusterResource. Read the local System log provider Microsoft-Windows-FailoverClustering, including 1069, 1194, 1205 and 1254. Match named ResourceGroup and ResourceName fields, timestamp and error code. For VM configuration failures, compare VmId with Get-VM on every possible owner and verify the configuration path exists.

### Corrective action and escalation

Restore the specific missing dependency with its owning team. A Network Name creation failure needs the directory team to validate the cluster name account, destination container permissions, quota and any prestaged virtual computer object. A missing VM configuration needs backup/storage and VMM inventory reconciliation. Remove an orphaned role only after its owner confirms retirement and recoverability. Do not repeatedly restart a role or increase failover thresholds to hide the cause.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Verify resources and intended workloads are online, new failure events stop, and native and SCOM leaf states recover. Failure-window monitors can remain elevated until old episodes age out. An intentionally stopped VM or empty Available Storage group is not by itself evidence of a cluster outage.

### Microsoft references

[Microsoft Learn: prestage cluster adds](https://learn.microsoft.com/en-us/windows-server/failover-clustering/prestage-cluster-adds)

[Microsoft Learn: hyper v start state access failures clustered standalone](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-start-state-access-failures-clustered-standalone)


## Roll up Microsoft cluster health {#hypervprivatecloud.capability.cluster.availability.cluster.dependency.monitor}

`HyperVPrivateCloud.Capability.Cluster.Availability.Cluster.Dependency.Monitor`

Rolls up health from Microsoft cluster service objects into Availability and Clustering.

### Support scope

Cluster membership, quorum, witness, inter-node network or collector health. Loss of redundancy can precede an outage even while VMs remain running.

Element: HyperVPrivateCloud.Capability.Cluster.Availability.Cluster.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.AvailabilityComponent; relationship=HyperVPrivateCloud.Capability.Cluster.AvailabilityContainsMicrosoftCluster; member monitor=Health!System.Health.AvailabilityState; parent=Health!System.Health.AvailabilityState; algorithm=WorstOf; unavailable-member policy=Success. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Run Get-ClusterNode, Get-ClusterQuorum and Get-ClusterNetwork locally on a cluster node. Identify paused versus down nodes, configured and current votes, witness state and partitioned networks. Review maintenance and the first cluster event. For collection errors, verify the supported Windows PowerShell runtime and FailoverClusters module before interpreting zero counts.

### Corrective action and escalation

Restore the failed node, witness or network with the platform owner. Resume intentionally paused nodes only after maintenance is complete. Do not force quorum, change node weights or restart all nodes to clear a monitor. Repair collector access separately from workload health.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm expected membership, quorum resilience and network state, then verify fresh collector results and the originating monitor before the parent DA.

### Microsoft references

[Microsoft Learn: what is quorum witness](https://learn.microsoft.com/en-us/windows-server/failover-clustering/what-is-quorum-witness)

[Microsoft Learn: quorum](https://learn.microsoft.com/en-us/windows-server/storage/storage-spaces/quorum)

[Microsoft Learn: nf clusapi pauseclusternode](https://learn.microsoft.com/en-us/windows/win32/api/clusapi/nf-clusapi-pauseclusternode)

[Microsoft Learn: failover cluster accounts overview](https://learn.microsoft.com/en-us/windows-server/failover-clustering/failover-cluster-accounts-overview)

[Microsoft Learn: hyper v cluster connectivity management configuration](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-cluster-connectivity-management-configuration)


## Roll up Microsoft cluster node health {#hypervprivatecloud.capability.cluster.availability.node.dependency.monitor}

`HyperVPrivateCloud.Capability.Cluster.Availability.Node.Dependency.Monitor`

Rolls up health from Microsoft cluster node objects into Availability and Clustering.

### Support scope

Cluster membership, quorum, witness, inter-node network or collector health. Loss of redundancy can precede an outage even while VMs remain running.

Element: HyperVPrivateCloud.Capability.Cluster.Availability.Node.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.AvailabilityComponent; relationship=HyperVPrivateCloud.Capability.Cluster.AvailabilityContainsMicrosoftClusterNode; member monitor=Health!System.Health.AvailabilityState; parent=Health!System.Health.AvailabilityState; algorithm=WorstOf; unavailable-member policy=Success. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Run Get-ClusterNode, Get-ClusterQuorum and Get-ClusterNetwork locally on a cluster node. Identify paused versus down nodes, configured and current votes, witness state and partitioned networks. Review maintenance and the first cluster event. For collection errors, verify the supported Windows PowerShell runtime and FailoverClusters module before interpreting zero counts.

### Corrective action and escalation

Restore the failed node, witness or network with the platform owner. Resume intentionally paused nodes only after maintenance is complete. Do not force quorum, change node weights or restart all nodes to clear a monitor. Repair collector access separately from workload health.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm expected membership, quorum resilience and network state, then verify fresh collector results and the originating monitor before the parent DA.

### Microsoft references

[Microsoft Learn: what is quorum witness](https://learn.microsoft.com/en-us/windows-server/failover-clustering/what-is-quorum-witness)

[Microsoft Learn: quorum](https://learn.microsoft.com/en-us/windows-server/storage/storage-spaces/quorum)

[Microsoft Learn: nf clusapi pauseclusternode](https://learn.microsoft.com/en-us/windows/win32/api/clusapi/nf-clusapi-pauseclusternode)

[Microsoft Learn: failover cluster accounts overview](https://learn.microsoft.com/en-us/windows-server/failover-clustering/failover-cluster-accounts-overview)

[Microsoft Learn: hyper v cluster connectivity management configuration](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-cluster-connectivity-management-configuration)


## Roll up Microsoft cluster role health {#hypervprivatecloud.capability.cluster.availability.group.dependency.monitor}

`HyperVPrivateCloud.Capability.Cluster.Availability.Group.Dependency.Monitor`

Rolls up health from Microsoft cluster resource group objects into Availability and Clustering.

### Support scope

Cluster membership, quorum, witness, inter-node network or collector health. Loss of redundancy can precede an outage even while VMs remain running.

Element: HyperVPrivateCloud.Capability.Cluster.Availability.Group.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.AvailabilityComponent; relationship=HyperVPrivateCloud.Capability.Cluster.AvailabilityContainsMicrosoftClusterGroup; member monitor=Health!System.Health.AvailabilityState; parent=Health!System.Health.AvailabilityState; algorithm=WorstOf; unavailable-member policy=Success. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Run Get-ClusterNode, Get-ClusterQuorum and Get-ClusterNetwork locally on a cluster node. Identify paused versus down nodes, configured and current votes, witness state and partitioned networks. Review maintenance and the first cluster event. For collection errors, verify the supported Windows PowerShell runtime and FailoverClusters module before interpreting zero counts.

### Corrective action and escalation

Restore the failed node, witness or network with the platform owner. Resume intentionally paused nodes only after maintenance is complete. Do not force quorum, change node weights or restart all nodes to clear a monitor. Repair collector access separately from workload health.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm expected membership, quorum resilience and network state, then verify fresh collector results and the originating monitor before the parent DA.

### Microsoft references

[Microsoft Learn: what is quorum witness](https://learn.microsoft.com/en-us/windows-server/failover-clustering/what-is-quorum-witness)

[Microsoft Learn: quorum](https://learn.microsoft.com/en-us/windows-server/storage/storage-spaces/quorum)

[Microsoft Learn: nf clusapi pauseclusternode](https://learn.microsoft.com/en-us/windows/win32/api/clusapi/nf-clusapi-pauseclusternode)

[Microsoft Learn: failover cluster accounts overview](https://learn.microsoft.com/en-us/windows-server/failover-clustering/failover-cluster-accounts-overview)

[Microsoft Learn: hyper v cluster connectivity management configuration](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-cluster-connectivity-management-configuration)


## Roll up Microsoft cluster network health {#hypervprivatecloud.capability.cluster.availability.network.dependency.monitor}

`HyperVPrivateCloud.Capability.Cluster.Availability.Network.Dependency.Monitor`

Rolls up health from Microsoft cluster network objects into Availability and Clustering.

### Support scope

Cluster membership, quorum, witness, inter-node network or collector health. Loss of redundancy can precede an outage even while VMs remain running.

Element: HyperVPrivateCloud.Capability.Cluster.Availability.Network.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.AvailabilityComponent; relationship=HyperVPrivateCloud.Capability.Cluster.AvailabilityContainsMicrosoftClusterNetwork; member monitor=Health!System.Health.AvailabilityState; parent=Health!System.Health.AvailabilityState; algorithm=WorstOf; unavailable-member policy=Success. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Run Get-ClusterNode, Get-ClusterQuorum and Get-ClusterNetwork locally on a cluster node. Identify paused versus down nodes, configured and current votes, witness state and partitioned networks. Review maintenance and the first cluster event. For collection errors, verify the supported Windows PowerShell runtime and FailoverClusters module before interpreting zero counts.

### Corrective action and escalation

Restore the failed node, witness or network with the platform owner. Resume intentionally paused nodes only after maintenance is complete. Do not force quorum, change node weights or restart all nodes to clear a monitor. Repair collector access separately from workload health.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm expected membership, quorum resilience and network state, then verify fresh collector results and the originating monitor before the parent DA.

### Microsoft references

[Microsoft Learn: what is quorum witness](https://learn.microsoft.com/en-us/windows-server/failover-clustering/what-is-quorum-witness)

[Microsoft Learn: quorum](https://learn.microsoft.com/en-us/windows-server/storage/storage-spaces/quorum)

[Microsoft Learn: nf clusapi pauseclusternode](https://learn.microsoft.com/en-us/windows/win32/api/clusapi/nf-clusapi-pauseclusternode)

[Microsoft Learn: failover cluster accounts overview](https://learn.microsoft.com/en-us/windows-server/failover-clustering/failover-cluster-accounts-overview)

[Microsoft Learn: hyper v cluster connectivity management configuration](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-cluster-connectivity-management-configuration)


## Roll up Microsoft CSV health {#hypervprivatecloud.capability.cluster.storage.csv.dependency.monitor}

`HyperVPrivateCloud.Capability.Cluster.Storage.CSV.Dependency.Monitor`

Rolls up health from Microsoft Cluster Shared Volume objects into Storage.

### Support scope

Cluster membership, quorum, witness, inter-node network or collector health. Loss of redundancy can precede an outage even while VMs remain running.

Element: HyperVPrivateCloud.Capability.Cluster.Storage.CSV.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.StorageComponent; relationship=HyperVPrivateCloud.Capability.Cluster.StorageContainsMicrosoftClusterSharedVolume; member monitor=Health!System.Health.AvailabilityState; parent=Health!System.Health.AvailabilityState; algorithm=WorstOf; unavailable-member policy=Success. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Run Get-ClusterNode, Get-ClusterQuorum and Get-ClusterNetwork locally on a cluster node. Identify paused versus down nodes, configured and current votes, witness state and partitioned networks. Review maintenance and the first cluster event. For collection errors, verify the supported Windows PowerShell runtime and FailoverClusters module before interpreting zero counts.

### Corrective action and escalation

Restore the failed node, witness or network with the platform owner. Resume intentionally paused nodes only after maintenance is complete. Do not force quorum, change node weights or restart all nodes to clear a monitor. Repair collector access separately from workload health.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm expected membership, quorum resilience and network state, then verify fresh collector results and the originating monitor before the parent DA.

### Microsoft references

[Microsoft Learn: what is quorum witness](https://learn.microsoft.com/en-us/windows-server/failover-clustering/what-is-quorum-witness)

[Microsoft Learn: quorum](https://learn.microsoft.com/en-us/windows-server/storage/storage-spaces/quorum)

[Microsoft Learn: nf clusapi pauseclusternode](https://learn.microsoft.com/en-us/windows/win32/api/clusapi/nf-clusapi-pauseclusternode)

[Microsoft Learn: failover cluster accounts overview](https://learn.microsoft.com/en-us/windows-server/failover-clustering/failover-cluster-accounts-overview)

[Microsoft Learn: hyper v cluster connectivity management configuration](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-cluster-connectivity-management-configuration)


## Roll up failover cluster availability into Availability and Clustering {#hypervprivatecloud.capability.cluster.availability.clusterrole.availability.dependency.monitor}

`HyperVPrivateCloud.Capability.Cluster.Availability.ClusterRole.Availability.Dependency.Monitor`

Rolls up availability health of the failover cluster role into Availability and Clustering.

### Support scope

Cluster membership, quorum, witness, inter-node network or collector health. Loss of redundancy can precede an outage even while VMs remain running.

Element: HyperVPrivateCloud.Capability.Cluster.Availability.ClusterRole.Availability.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.AvailabilityComponent; relationship=HyperVPrivateCloud.Capability.Cluster.AvailabilityContainsClusterRole; member monitor=Health!System.Health.AvailabilityState; parent=Health!System.Health.AvailabilityState; algorithm=WorstOf; unavailable-member policy=Success. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Run Get-ClusterNode, Get-ClusterQuorum and Get-ClusterNetwork locally on a cluster node. Identify paused versus down nodes, configured and current votes, witness state and partitioned networks. Review maintenance and the first cluster event. For collection errors, verify the supported Windows PowerShell runtime and FailoverClusters module before interpreting zero counts.

### Corrective action and escalation

Restore the failed node, witness or network with the platform owner. Resume intentionally paused nodes only after maintenance is complete. Do not force quorum, change node weights or restart all nodes to clear a monitor. Repair collector access separately from workload health.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm expected membership, quorum resilience and network state, then verify fresh collector results and the originating monitor before the parent DA.

### Microsoft references

[Microsoft Learn: what is quorum witness](https://learn.microsoft.com/en-us/windows-server/failover-clustering/what-is-quorum-witness)

[Microsoft Learn: quorum](https://learn.microsoft.com/en-us/windows-server/storage/storage-spaces/quorum)

[Microsoft Learn: nf clusapi pauseclusternode](https://learn.microsoft.com/en-us/windows/win32/api/clusapi/nf-clusapi-pauseclusternode)

[Microsoft Learn: failover cluster accounts overview](https://learn.microsoft.com/en-us/windows-server/failover-clustering/failover-cluster-accounts-overview)

[Microsoft Learn: hyper v cluster connectivity management configuration](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-cluster-connectivity-management-configuration)


## Roll up failover cluster performance into Availability and Clustering {#hypervprivatecloud.capability.cluster.availability.clusterrole.performance.dependency.monitor}

`HyperVPrivateCloud.Capability.Cluster.Availability.ClusterRole.Performance.Dependency.Monitor`

Rolls up performance health of the failover cluster role into Availability and Clustering.

### Support scope

Cluster membership, quorum, witness, inter-node network or collector health. Loss of redundancy can precede an outage even while VMs remain running.

Element: HyperVPrivateCloud.Capability.Cluster.Availability.ClusterRole.Performance.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.AvailabilityComponent; relationship=HyperVPrivateCloud.Capability.Cluster.AvailabilityContainsClusterRole; member monitor=Health!System.Health.PerformanceState; parent=Health!System.Health.PerformanceState; algorithm=WorstOf; unavailable-member policy=Success. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Run Get-ClusterNode, Get-ClusterQuorum and Get-ClusterNetwork locally on a cluster node. Identify paused versus down nodes, configured and current votes, witness state and partitioned networks. Review maintenance and the first cluster event. For collection errors, verify the supported Windows PowerShell runtime and FailoverClusters module before interpreting zero counts.

### Corrective action and escalation

Restore the failed node, witness or network with the platform owner. Resume intentionally paused nodes only after maintenance is complete. Do not force quorum, change node weights or restart all nodes to clear a monitor. Repair collector access separately from workload health.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm expected membership, quorum resilience and network state, then verify fresh collector results and the originating monitor before the parent DA.

### Microsoft references

[Microsoft Learn: what is quorum witness](https://learn.microsoft.com/en-us/windows-server/failover-clustering/what-is-quorum-witness)

[Microsoft Learn: quorum](https://learn.microsoft.com/en-us/windows-server/storage/storage-spaces/quorum)

[Microsoft Learn: nf clusapi pauseclusternode](https://learn.microsoft.com/en-us/windows/win32/api/clusapi/nf-clusapi-pauseclusternode)

[Microsoft Learn: failover cluster accounts overview](https://learn.microsoft.com/en-us/windows-server/failover-clustering/failover-cluster-accounts-overview)

[Microsoft Learn: hyper v cluster connectivity management configuration](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-cluster-connectivity-management-configuration)


## Roll up failover cluster configuration into Availability and Clustering {#hypervprivatecloud.capability.cluster.availability.clusterrole.configuration.dependency.monitor}

`HyperVPrivateCloud.Capability.Cluster.Availability.ClusterRole.Configuration.Dependency.Monitor`

Rolls up configuration health of the failover cluster role into Availability and Clustering.

### Support scope

Cluster membership, quorum, witness, inter-node network or collector health. Loss of redundancy can precede an outage even while VMs remain running.

Element: HyperVPrivateCloud.Capability.Cluster.Availability.ClusterRole.Configuration.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.AvailabilityComponent; relationship=HyperVPrivateCloud.Capability.Cluster.AvailabilityContainsClusterRole; member monitor=Health!System.Health.ConfigurationState; parent=Health!System.Health.ConfigurationState; algorithm=WorstOf; unavailable-member policy=Success. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Run Get-ClusterNode, Get-ClusterQuorum and Get-ClusterNetwork locally on a cluster node. Identify paused versus down nodes, configured and current votes, witness state and partitioned networks. Review maintenance and the first cluster event. For collection errors, verify the supported Windows PowerShell runtime and FailoverClusters module before interpreting zero counts.

### Corrective action and escalation

Restore the failed node, witness or network with the platform owner. Resume intentionally paused nodes only after maintenance is complete. Do not force quorum, change node weights or restart all nodes to clear a monitor. Repair collector access separately from workload health.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm expected membership, quorum resilience and network state, then verify fresh collector results and the originating monitor before the parent DA.

### Microsoft references

[Microsoft Learn: what is quorum witness](https://learn.microsoft.com/en-us/windows-server/failover-clustering/what-is-quorum-witness)

[Microsoft Learn: quorum](https://learn.microsoft.com/en-us/windows-server/storage/storage-spaces/quorum)

[Microsoft Learn: nf clusapi pauseclusternode](https://learn.microsoft.com/en-us/windows/win32/api/clusapi/nf-clusapi-pauseclusternode)

[Microsoft Learn: failover cluster accounts overview](https://learn.microsoft.com/en-us/windows-server/failover-clustering/failover-cluster-accounts-overview)

[Microsoft Learn: hyper v cluster connectivity management configuration](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-cluster-connectivity-management-configuration)
