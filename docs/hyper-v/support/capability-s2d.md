# Hyper-V Private Cloud Monitoring - Storage Spaces Direct Integration

Generated support reference. [All capabilities](catalog.md) · [Day-2 triage](index.md).

Default conditions below come from the compiled candidate source, not the effective overrides in your management group. Read the monitor-specific knowledge together with the common safety and verification guidance. Microsoft links explain the underlying technology; product thresholds are not Microsoft recommendations.

## Collect Storage Spaces Direct pool capacity used percent {#hypervprivatecloud.capability.s2d.poolcapacityusedpercent.collection.rule}

`HyperVPrivateCloud.Capability.S2D.PoolCapacityUsedPercent.Collection.Rule`

Collects the used capacity percentage of the most heavily allocated clustered storage pool every 300 seconds. IntervalSeconds and TimeoutSeconds are overridable.

### Support scope

Storage Spaces Direct pool, virtual disk, physical disk, cache, repair or Health Service evidence. Degraded resiliency and predictive drive faults deserve action before data becomes unavailable.

Element: HyperVPrivateCloud.Capability.S2D.PoolCapacityUsedPercent.Collection.Rule. Kind: Rule.

### Alert versus health

Target=S2D!Microsoft.Windows.Server.10.0.Storage.StorageSpacesDirect.StorageSubSystem; enabled=true; category=PerformanceCollection. Rules collect data or raise event alerts; they do not themselves create unit-monitor health transitions. Repeated or unresolved rule alerts do not by themselves explain a red DA. Correlate with current leaf monitors and event timestamps before closure.

### Read-only investigation

Inspect Get-StoragePool, Get-VirtualDisk, Get-PhysicalDisk and Get-StorageJob, recording both HealthStatus and OperationalStatus. Run Get-StorageSubSystem Cluster* &#124; Debug-StorageSubSystem and retain the fault identifier, severity, reason, recommendation and physical location. Compare repair progress over time.

### Corrective action and escalation

Follow the specific storage fault recommendation after confirming remaining resiliency and the correct physical device. Coordinate replacement, repair or expansion with the storage owner. Do not reset disks, remove pool members, change read-only flags or delete virtual disks as generic troubleshooting.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm the fault disappears from native Health Service, repair progresses or completes, intended redundancy returns and free pool capacity remains adequate.

### Microsoft references

[Microsoft Learn: health service faults](https://learn.microsoft.com/en-us/windows-server/failover-clustering/health-service-faults)

[Microsoft Learn: storage spaces states](https://learn.microsoft.com/en-us/windows-server/storage/storage-spaces/storage-spaces-states)

[Microsoft Learn: troubleshooting storage spaces](https://learn.microsoft.com/en-us/windows-server/storage/storage-spaces/troubleshooting-storage-spaces)


## Collect Storage Spaces Direct pool free capacity percent {#hypervprivatecloud.capability.s2d.poolfreecapacitypercent.collection.rule}

`HyperVPrivateCloud.Capability.S2D.PoolFreeCapacityPercent.Collection.Rule`

Collects the free capacity percentage of the most heavily allocated clustered storage pool every 300 seconds. IntervalSeconds and TimeoutSeconds are overridable.

### Support scope

Storage Spaces Direct pool, virtual disk, physical disk, cache, repair or Health Service evidence. Degraded resiliency and predictive drive faults deserve action before data becomes unavailable.

Element: HyperVPrivateCloud.Capability.S2D.PoolFreeCapacityPercent.Collection.Rule. Kind: Rule.

### Alert versus health

Target=S2D!Microsoft.Windows.Server.10.0.Storage.StorageSpacesDirect.StorageSubSystem; enabled=true; category=PerformanceCollection. Rules collect data or raise event alerts; they do not themselves create unit-monitor health transitions. Repeated or unresolved rule alerts do not by themselves explain a red DA. Correlate with current leaf monitors and event timestamps before closure.

### Read-only investigation

Inspect Get-StoragePool, Get-VirtualDisk, Get-PhysicalDisk and Get-StorageJob, recording both HealthStatus and OperationalStatus. Run Get-StorageSubSystem Cluster* &#124; Debug-StorageSubSystem and retain the fault identifier, severity, reason, recommendation and physical location. Compare repair progress over time.

### Corrective action and escalation

Follow the specific storage fault recommendation after confirming remaining resiliency and the correct physical device. Coordinate replacement, repair or expansion with the storage owner. Do not reset disks, remove pool members, change read-only flags or delete virtual disks as generic troubleshooting.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm the fault disappears from native Health Service, repair progresses or completes, intended redundancy returns and free pool capacity remains adequate.

### Microsoft references

[Microsoft Learn: health service faults](https://learn.microsoft.com/en-us/windows-server/failover-clustering/health-service-faults)

[Microsoft Learn: storage spaces states](https://learn.microsoft.com/en-us/windows-server/storage/storage-spaces/storage-spaces-states)

[Microsoft Learn: troubleshooting storage spaces](https://learn.microsoft.com/en-us/windows-server/storage/storage-spaces/troubleshooting-storage-spaces)


## Collect Storage Spaces Direct virtual disk read latency {#hypervprivatecloud.capability.s2d.virtualdiskreadlatency.collection.rule}

`HyperVPrivateCloud.Capability.S2D.VirtualDiskReadLatency.Collection.Rule`

Collects the worst virtual disk maximum read latency in milliseconds every 300 seconds, falling back to physical disk reliability counters where virtual disk counters are unavailable. IntervalSeconds and TimeoutSeconds are overridable.

### Support scope

Storage Spaces Direct pool, virtual disk, physical disk, cache, repair or Health Service evidence. Degraded resiliency and predictive drive faults deserve action before data becomes unavailable.

Element: HyperVPrivateCloud.Capability.S2D.VirtualDiskReadLatency.Collection.Rule. Kind: Rule.

### Alert versus health

Target=S2D!Microsoft.Windows.Server.10.0.Storage.StorageSpacesDirect.StorageSubSystem; enabled=false; category=PerformanceCollection. Rules collect data or raise event alerts; they do not themselves create unit-monitor health transitions. Repeated or unresolved rule alerts do not by themselves explain a red DA. Correlate with current leaf monitors and event timestamps before closure.

### Read-only investigation

Inspect Get-StoragePool, Get-VirtualDisk, Get-PhysicalDisk and Get-StorageJob, recording both HealthStatus and OperationalStatus. Run Get-StorageSubSystem Cluster* &#124; Debug-StorageSubSystem and retain the fault identifier, severity, reason, recommendation and physical location. Compare repair progress over time.

### Corrective action and escalation

Follow the specific storage fault recommendation after confirming remaining resiliency and the correct physical device. Coordinate replacement, repair or expansion with the storage owner. Do not reset disks, remove pool members, change read-only flags or delete virtual disks as generic troubleshooting.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm the fault disappears from native Health Service, repair progresses or completes, intended redundancy returns and free pool capacity remains adequate.

### Microsoft references

[Microsoft Learn: health service faults](https://learn.microsoft.com/en-us/windows-server/failover-clustering/health-service-faults)

[Microsoft Learn: storage spaces states](https://learn.microsoft.com/en-us/windows-server/storage/storage-spaces/storage-spaces-states)

[Microsoft Learn: troubleshooting storage spaces](https://learn.microsoft.com/en-us/windows-server/storage/storage-spaces/troubleshooting-storage-spaces)


## Collect Storage Spaces Direct virtual disk write latency {#hypervprivatecloud.capability.s2d.virtualdiskwritelatency.collection.rule}

`HyperVPrivateCloud.Capability.S2D.VirtualDiskWriteLatency.Collection.Rule`

Collects the worst virtual disk maximum write latency in milliseconds every 300 seconds, falling back to physical disk reliability counters where virtual disk counters are unavailable. IntervalSeconds and TimeoutSeconds are overridable.

### Support scope

Storage Spaces Direct pool, virtual disk, physical disk, cache, repair or Health Service evidence. Degraded resiliency and predictive drive faults deserve action before data becomes unavailable.

Element: HyperVPrivateCloud.Capability.S2D.VirtualDiskWriteLatency.Collection.Rule. Kind: Rule.

### Alert versus health

Target=S2D!Microsoft.Windows.Server.10.0.Storage.StorageSpacesDirect.StorageSubSystem; enabled=false; category=PerformanceCollection. Rules collect data or raise event alerts; they do not themselves create unit-monitor health transitions. Repeated or unresolved rule alerts do not by themselves explain a red DA. Correlate with current leaf monitors and event timestamps before closure.

### Read-only investigation

Inspect Get-StoragePool, Get-VirtualDisk, Get-PhysicalDisk and Get-StorageJob, recording both HealthStatus and OperationalStatus. Run Get-StorageSubSystem Cluster* &#124; Debug-StorageSubSystem and retain the fault identifier, severity, reason, recommendation and physical location. Compare repair progress over time.

### Corrective action and escalation

Follow the specific storage fault recommendation after confirming remaining resiliency and the correct physical device. Coordinate replacement, repair or expansion with the storage owner. Do not reset disks, remove pool members, change read-only flags or delete virtual disks as generic troubleshooting.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm the fault disappears from native Health Service, repair progresses or completes, intended redundancy returns and free pool capacity remains adequate.

### Microsoft references

[Microsoft Learn: health service faults](https://learn.microsoft.com/en-us/windows-server/failover-clustering/health-service-faults)

[Microsoft Learn: storage spaces states](https://learn.microsoft.com/en-us/windows-server/storage/storage-spaces/storage-spaces-states)

[Microsoft Learn: troubleshooting storage spaces](https://learn.microsoft.com/en-us/windows-server/storage/storage-spaces/troubleshooting-storage-spaces)


## Collect Storage Spaces Direct repair job progress {#hypervprivatecloud.capability.s2d.repairjobprogress.collection.rule}

`HyperVPrivateCloud.Capability.S2D.RepairJobProgress.Collection.Rule`

Collects the completion percentage of the active repair, regeneration, rebalance or resync storage job every 300 seconds. Reports 100 when no such job is running. IntervalSeconds and TimeoutSeconds are overridable.

### Support scope

Storage Spaces Direct pool, virtual disk, physical disk, cache, repair or Health Service evidence. Degraded resiliency and predictive drive faults deserve action before data becomes unavailable.

Element: HyperVPrivateCloud.Capability.S2D.RepairJobProgress.Collection.Rule. Kind: Rule.

### Alert versus health

Target=S2D!Microsoft.Windows.Server.10.0.Storage.StorageSpacesDirect.StorageSubSystem; enabled=true; category=PerformanceCollection. Rules collect data or raise event alerts; they do not themselves create unit-monitor health transitions. Repeated or unresolved rule alerts do not by themselves explain a red DA. Correlate with current leaf monitors and event timestamps before closure.

### Read-only investigation

Inspect Get-StoragePool, Get-VirtualDisk, Get-PhysicalDisk and Get-StorageJob, recording both HealthStatus and OperationalStatus. Run Get-StorageSubSystem Cluster* &#124; Debug-StorageSubSystem and retain the fault identifier, severity, reason, recommendation and physical location. Compare repair progress over time.

### Corrective action and escalation

Follow the specific storage fault recommendation after confirming remaining resiliency and the correct physical device. Coordinate replacement, repair or expansion with the storage owner. Do not reset disks, remove pool members, change read-only flags or delete virtual disks as generic troubleshooting.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm the fault disappears from native Health Service, repair progresses or completes, intended redundancy returns and free pool capacity remains adequate.

### Microsoft references

[Microsoft Learn: health service faults](https://learn.microsoft.com/en-us/windows-server/failover-clustering/health-service-faults)

[Microsoft Learn: storage spaces states](https://learn.microsoft.com/en-us/windows-server/storage/storage-spaces/storage-spaces-states)

[Microsoft Learn: troubleshooting storage spaces](https://learn.microsoft.com/en-us/windows-server/storage/storage-spaces/troubleshooting-storage-spaces)


## Show S2D health report and faults {#hypervprivatecloud.capability.s2d.healthreport.task}

`HyperVPrivateCloud.Capability.S2D.HealthReport.Task`

Subsystem health, Debug-StorageSubSystem faults with recommended actions, storage health report, pools, virtual disks and unhealthy or retired physical disks.

### Summary

Show S2D health report and faults

### What it runs

Subsystem health, Debug-StorageSubSystem faults with recommended actions, storage health report, pools, virtual disks and unhealthy or retired physical disks.

### Impact

Read-only. The task runs the query on the agent and returns text; it changes nothing.

### Support scope

Storage Spaces Direct pool, virtual disk, physical disk, cache, repair or Health Service evidence. Degraded resiliency and predictive drive faults deserve action before data becomes unavailable.

Element: HyperVPrivateCloud.Capability.S2D.HealthReport.Task. Kind: Task.

### Execution safety

Target=S2D!Microsoft.Windows.Server.10.0.Storage.StorageSpacesDirect.StorageSubSystem; enabled=true; timeout=300. Read the task&#39;s original knowledge and parameters before execution. A Remediation task changes state and requires approval; do not execute it solely because the object is red. Even a diagnostic can generate logs or files; review its documented impact.

### Read-only investigation

Inspect Get-StoragePool, Get-VirtualDisk, Get-PhysicalDisk and Get-StorageJob, recording both HealthStatus and OperationalStatus. Run Get-StorageSubSystem Cluster* &#124; Debug-StorageSubSystem and retain the fault identifier, severity, reason, recommendation and physical location. Compare repair progress over time.

### Corrective action and escalation

Follow the specific storage fault recommendation after confirming remaining resiliency and the correct physical device. Coordinate replacement, repair or expansion with the storage owner. Do not reset disks, remove pool members, change read-only flags or delete virtual disks as generic troubleshooting.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm the fault disappears from native Health Service, repair progresses or completes, intended redundancy returns and free pool capacity remains adequate.

### Microsoft references

[Microsoft Learn: health service faults](https://learn.microsoft.com/en-us/windows-server/failover-clustering/health-service-faults)

[Microsoft Learn: storage spaces states](https://learn.microsoft.com/en-us/windows-server/storage/storage-spaces/storage-spaces-states)

[Microsoft Learn: troubleshooting storage spaces](https://learn.microsoft.com/en-us/windows-server/storage/storage-spaces/troubleshooting-storage-spaces)


## Show storage jobs {#hypervprivatecloud.capability.s2d.storagejobs.task}

`HyperVPrivateCloud.Capability.S2D.StorageJobs.Task`

Get-StorageJob with state, percent complete, bytes processed and elapsed time.

### Summary

Show storage jobs

### What it runs

Get-StorageJob with state, percent complete, bytes processed and elapsed time.

### Impact

Read-only. The task runs the query on the agent and returns text; it changes nothing.

### Support scope

Storage Spaces Direct pool, virtual disk, physical disk, cache, repair or Health Service evidence. Degraded resiliency and predictive drive faults deserve action before data becomes unavailable.

Element: HyperVPrivateCloud.Capability.S2D.StorageJobs.Task. Kind: Task.

### Execution safety

Target=S2D!Microsoft.Windows.Server.10.0.Storage.StorageSpacesDirect.StorageSubSystem; enabled=true; timeout=180. Read the task&#39;s original knowledge and parameters before execution. A Remediation task changes state and requires approval; do not execute it solely because the object is red. Even a diagnostic can generate logs or files; review its documented impact.

### Read-only investigation

Inspect Get-StoragePool, Get-VirtualDisk, Get-PhysicalDisk and Get-StorageJob, recording both HealthStatus and OperationalStatus. Run Get-StorageSubSystem Cluster* &#124; Debug-StorageSubSystem and retain the fault identifier, severity, reason, recommendation and physical location. Compare repair progress over time.

### Corrective action and escalation

Follow the specific storage fault recommendation after confirming remaining resiliency and the correct physical device. Coordinate replacement, repair or expansion with the storage owner. Do not reset disks, remove pool members, change read-only flags or delete virtual disks as generic troubleshooting.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm the fault disappears from native Health Service, repair progresses or completes, intended redundancy returns and free pool capacity remains adequate.

### Microsoft references

[Microsoft Learn: health service faults](https://learn.microsoft.com/en-us/windows-server/failover-clustering/health-service-faults)

[Microsoft Learn: storage spaces states](https://learn.microsoft.com/en-us/windows-server/storage/storage-spaces/storage-spaces-states)

[Microsoft Learn: troubleshooting storage spaces](https://learn.microsoft.com/en-us/windows-server/storage/storage-spaces/troubleshooting-storage-spaces)


## Show physical disk reliability counters {#hypervprivatecloud.capability.s2d.diskreliability.task}

`HyperVPrivateCloud.Capability.S2D.DiskReliability.Task`

Temperature, wear, uncorrected read/write errors and power-on hours per physical disk.

### Summary

Show physical disk reliability counters

### What it runs

Temperature, wear, uncorrected read/write errors and power-on hours per physical disk.

### Impact

Read-only. The task runs the query on the agent and returns text; it changes nothing.

### Support scope

Storage Spaces Direct pool, virtual disk, physical disk, cache, repair or Health Service evidence. Degraded resiliency and predictive drive faults deserve action before data becomes unavailable.

Element: HyperVPrivateCloud.Capability.S2D.DiskReliability.Task. Kind: Task.

### Execution safety

Target=S2D!Microsoft.Windows.Server.10.0.Storage.StorageSpacesDirect.StorageSubSystem; enabled=true; timeout=600. Read the task&#39;s original knowledge and parameters before execution. A Remediation task changes state and requires approval; do not execute it solely because the object is red. Even a diagnostic can generate logs or files; review its documented impact.

### Read-only investigation

Inspect Get-StoragePool, Get-VirtualDisk, Get-PhysicalDisk and Get-StorageJob, recording both HealthStatus and OperationalStatus. Run Get-StorageSubSystem Cluster* &#124; Debug-StorageSubSystem and retain the fault identifier, severity, reason, recommendation and physical location. Compare repair progress over time.

### Corrective action and escalation

Follow the specific storage fault recommendation after confirming remaining resiliency and the correct physical device. Coordinate replacement, repair or expansion with the storage owner. Do not reset disks, remove pool members, change read-only flags or delete virtual disks as generic troubleshooting.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm the fault disappears from native Health Service, repair progresses or completes, intended redundancy returns and free pool capacity remains adequate.

### Microsoft references

[Microsoft Learn: health service faults](https://learn.microsoft.com/en-us/windows-server/failover-clustering/health-service-faults)

[Microsoft Learn: storage spaces states](https://learn.microsoft.com/en-us/windows-server/storage/storage-spaces/storage-spaces-states)

[Microsoft Learn: troubleshooting storage spaces](https://learn.microsoft.com/en-us/windows-server/storage/storage-spaces/troubleshooting-storage-spaces)


## Show pool and volume capacity {#hypervprivatecloud.capability.s2d.capacity.task}

`HyperVPrivateCloud.Capability.S2D.Capacity.Task`

Pool size, allocated and free percent; volume size, free percent and health.

### Summary

Show pool and volume capacity

### What it runs

Pool size, allocated and free percent; volume size, free percent and health.

### Impact

Read-only. The task runs the query on the agent and returns text; it changes nothing.

### Support scope

Storage Spaces Direct pool, virtual disk, physical disk, cache, repair or Health Service evidence. Degraded resiliency and predictive drive faults deserve action before data becomes unavailable.

Element: HyperVPrivateCloud.Capability.S2D.Capacity.Task. Kind: Task.

### Execution safety

Target=S2D!Microsoft.Windows.Server.10.0.Storage.StorageSpacesDirect.StorageSubSystem; enabled=true; timeout=180. Read the task&#39;s original knowledge and parameters before execution. A Remediation task changes state and requires approval; do not execute it solely because the object is red. Even a diagnostic can generate logs or files; review its documented impact.

### Read-only investigation

Inspect Get-StoragePool, Get-VirtualDisk, Get-PhysicalDisk and Get-StorageJob, recording both HealthStatus and OperationalStatus. Run Get-StorageSubSystem Cluster* &#124; Debug-StorageSubSystem and retain the fault identifier, severity, reason, recommendation and physical location. Compare repair progress over time.

### Corrective action and escalation

Follow the specific storage fault recommendation after confirming remaining resiliency and the correct physical device. Coordinate replacement, repair or expansion with the storage owner. Do not reset disks, remove pool members, change read-only flags or delete virtual disks as generic troubleshooting.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm the fault disappears from native Health Service, repair progresses or completes, intended redundancy returns and free pool capacity remains adequate.

### Microsoft references

[Microsoft Learn: health service faults](https://learn.microsoft.com/en-us/windows-server/failover-clustering/health-service-faults)

[Microsoft Learn: storage spaces states](https://learn.microsoft.com/en-us/windows-server/storage/storage-spaces/storage-spaces-states)

[Microsoft Learn: troubleshooting storage spaces](https://learn.microsoft.com/en-us/windows-server/storage/storage-spaces/troubleshooting-storage-spaces)


## Remediation: Repair a virtual disk {#hypervprivatecloud.capability.s2d.repairvirtualdisk.task}

`HyperVPrivateCloud.Capability.S2D.RepairVirtualDisk.Task`

Repair-VirtualDisk -AsJob. Parameter = virtual disk friendly name.

### Summary

Repair a virtual disk

### What it runs

Repair-VirtualDisk -AsJob. Parameter = virtual disk friendly name.

### Impact

This task changes the state of the target. The console asks for confirmation before it runs; use the read-only tasks first to confirm the diagnosis, and run it inside a change window where the environment requires one. The task output reports the resulting state.

### Support scope

Storage Spaces Direct pool, virtual disk, physical disk, cache, repair or Health Service evidence. Degraded resiliency and predictive drive faults deserve action before data becomes unavailable.

Element: HyperVPrivateCloud.Capability.S2D.RepairVirtualDisk.Task. Kind: Task.

### Execution safety

Target=S2D!Microsoft.Windows.Server.10.0.Storage.StorageSpacesDirect.StorageSubSystem; enabled=true; timeout=300. Read the task&#39;s original knowledge and parameters before execution. A Remediation task changes state and requires approval; do not execute it solely because the object is red. Even a diagnostic can generate logs or files; review its documented impact.

### Read-only investigation

Inspect Get-StoragePool, Get-VirtualDisk, Get-PhysicalDisk and Get-StorageJob, recording both HealthStatus and OperationalStatus. Run Get-StorageSubSystem Cluster* &#124; Debug-StorageSubSystem and retain the fault identifier, severity, reason, recommendation and physical location. Compare repair progress over time.

### Corrective action and escalation

Follow the specific storage fault recommendation after confirming remaining resiliency and the correct physical device. Coordinate replacement, repair or expansion with the storage owner. Do not reset disks, remove pool members, change read-only flags or delete virtual disks as generic troubleshooting.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm the fault disappears from native Health Service, repair progresses or completes, intended redundancy returns and free pool capacity remains adequate.

### Microsoft references

[Microsoft Learn: health service faults](https://learn.microsoft.com/en-us/windows-server/failover-clustering/health-service-faults)

[Microsoft Learn: storage spaces states](https://learn.microsoft.com/en-us/windows-server/storage/storage-spaces/storage-spaces-states)

[Microsoft Learn: troubleshooting storage spaces](https://learn.microsoft.com/en-us/windows-server/storage/storage-spaces/troubleshooting-storage-spaces)


## Remediation: Retire a physical disk {#hypervprivatecloud.capability.s2d.retirephysicaldisk.task}

`HyperVPrivateCloud.Capability.S2D.RetirePhysicalDisk.Task`

Set-PhysicalDisk -Usage Retired to start evacuation before replacement. Parameter = disk serial number.

### Summary

Retire a physical disk

### What it runs

Set-PhysicalDisk -Usage Retired to start evacuation before replacement. Parameter = disk serial number.

### Impact

This task changes the state of the target. The console asks for confirmation before it runs; use the read-only tasks first to confirm the diagnosis, and run it inside a change window where the environment requires one. The task output reports the resulting state.

### Support scope

Storage Spaces Direct pool, virtual disk, physical disk, cache, repair or Health Service evidence. Degraded resiliency and predictive drive faults deserve action before data becomes unavailable.

Element: HyperVPrivateCloud.Capability.S2D.RetirePhysicalDisk.Task. Kind: Task.

### Execution safety

Target=S2D!Microsoft.Windows.Server.10.0.Storage.StorageSpacesDirect.StorageSubSystem; enabled=true; timeout=300. Read the task&#39;s original knowledge and parameters before execution. A Remediation task changes state and requires approval; do not execute it solely because the object is red. Even a diagnostic can generate logs or files; review its documented impact.

### Read-only investigation

Inspect Get-StoragePool, Get-VirtualDisk, Get-PhysicalDisk and Get-StorageJob, recording both HealthStatus and OperationalStatus. Run Get-StorageSubSystem Cluster* &#124; Debug-StorageSubSystem and retain the fault identifier, severity, reason, recommendation and physical location. Compare repair progress over time.

### Corrective action and escalation

Follow the specific storage fault recommendation after confirming remaining resiliency and the correct physical device. Coordinate replacement, repair or expansion with the storage owner. Do not reset disks, remove pool members, change read-only flags or delete virtual disks as generic troubleshooting.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm the fault disappears from native Health Service, repair progresses or completes, intended redundancy returns and free pool capacity remains adequate.

### Microsoft references

[Microsoft Learn: health service faults](https://learn.microsoft.com/en-us/windows-server/failover-clustering/health-service-faults)

[Microsoft Learn: storage spaces states](https://learn.microsoft.com/en-us/windows-server/storage/storage-spaces/storage-spaces-states)

[Microsoft Learn: troubleshooting storage spaces](https://learn.microsoft.com/en-us/windows-server/storage/storage-spaces/troubleshooting-storage-spaces)


## Remediation: Enable storage maintenance mode on a node {#hypervprivatecloud.capability.s2d.enablemaintenancemode.task}

`HyperVPrivateCloud.Capability.S2D.EnableMaintenanceMode.Task`

Enable-StorageMaintenanceMode on the node scale unit. Parameter = node name (default: this node).

### Summary

Enable storage maintenance mode on a node

### What it runs

Enable-StorageMaintenanceMode on the node scale unit. Parameter = node name (default: this node).

### Impact

This task changes the state of the target. The console asks for confirmation before it runs; use the read-only tasks first to confirm the diagnosis, and run it inside a change window where the environment requires one. The task output reports the resulting state.

### Support scope

Storage Spaces Direct pool, virtual disk, physical disk, cache, repair or Health Service evidence. Degraded resiliency and predictive drive faults deserve action before data becomes unavailable.

Element: HyperVPrivateCloud.Capability.S2D.EnableMaintenanceMode.Task. Kind: Task.

### Execution safety

Target=S2D!Microsoft.Windows.Server.10.0.Storage.StorageSpacesDirect.StorageSubSystem; enabled=true; timeout=600. Read the task&#39;s original knowledge and parameters before execution. A Remediation task changes state and requires approval; do not execute it solely because the object is red. Even a diagnostic can generate logs or files; review its documented impact.

### Read-only investigation

Inspect Get-StoragePool, Get-VirtualDisk, Get-PhysicalDisk and Get-StorageJob, recording both HealthStatus and OperationalStatus. Run Get-StorageSubSystem Cluster* &#124; Debug-StorageSubSystem and retain the fault identifier, severity, reason, recommendation and physical location. Compare repair progress over time.

### Corrective action and escalation

Follow the specific storage fault recommendation after confirming remaining resiliency and the correct physical device. Coordinate replacement, repair or expansion with the storage owner. Do not reset disks, remove pool members, change read-only flags or delete virtual disks as generic troubleshooting.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm the fault disappears from native Health Service, repair progresses or completes, intended redundancy returns and free pool capacity remains adequate.

### Microsoft references

[Microsoft Learn: health service faults](https://learn.microsoft.com/en-us/windows-server/failover-clustering/health-service-faults)

[Microsoft Learn: storage spaces states](https://learn.microsoft.com/en-us/windows-server/storage/storage-spaces/storage-spaces-states)

[Microsoft Learn: troubleshooting storage spaces](https://learn.microsoft.com/en-us/windows-server/storage/storage-spaces/troubleshooting-storage-spaces)


## Remediation: Disable storage maintenance mode on a node {#hypervprivatecloud.capability.s2d.disablemaintenancemode.task}

`HyperVPrivateCloud.Capability.S2D.DisableMaintenanceMode.Task`

Disable-StorageMaintenanceMode on the node scale unit. Parameter = node name (default: this node).

### Summary

Disable storage maintenance mode on a node

### What it runs

Disable-StorageMaintenanceMode on the node scale unit. Parameter = node name (default: this node).

### Impact

This task changes the state of the target. The console asks for confirmation before it runs; use the read-only tasks first to confirm the diagnosis, and run it inside a change window where the environment requires one. The task output reports the resulting state.

### Support scope

Storage Spaces Direct pool, virtual disk, physical disk, cache, repair or Health Service evidence. Degraded resiliency and predictive drive faults deserve action before data becomes unavailable.

Element: HyperVPrivateCloud.Capability.S2D.DisableMaintenanceMode.Task. Kind: Task.

### Execution safety

Target=S2D!Microsoft.Windows.Server.10.0.Storage.StorageSpacesDirect.StorageSubSystem; enabled=true; timeout=600. Read the task&#39;s original knowledge and parameters before execution. A Remediation task changes state and requires approval; do not execute it solely because the object is red. Even a diagnostic can generate logs or files; review its documented impact.

### Read-only investigation

Inspect Get-StoragePool, Get-VirtualDisk, Get-PhysicalDisk and Get-StorageJob, recording both HealthStatus and OperationalStatus. Run Get-StorageSubSystem Cluster* &#124; Debug-StorageSubSystem and retain the fault identifier, severity, reason, recommendation and physical location. Compare repair progress over time.

### Corrective action and escalation

Follow the specific storage fault recommendation after confirming remaining resiliency and the correct physical device. Coordinate replacement, repair or expansion with the storage owner. Do not reset disks, remove pool members, change read-only flags or delete virtual disks as generic troubleshooting.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm the fault disappears from native Health Service, repair progresses or completes, intended redundancy returns and free pool capacity remains adequate.

### Microsoft references

[Microsoft Learn: health service faults](https://learn.microsoft.com/en-us/windows-server/failover-clustering/health-service-faults)

[Microsoft Learn: storage spaces states](https://learn.microsoft.com/en-us/windows-server/storage/storage-spaces/storage-spaces-states)

[Microsoft Learn: troubleshooting storage spaces](https://learn.microsoft.com/en-us/windows-server/storage/storage-spaces/troubleshooting-storage-spaces)


## Remediation: Reattach a detached virtual disk {#hypervprivatecloud.capability.s2d.connectvirtualdisk.task}

`HyperVPrivateCloud.Capability.S2D.ConnectVirtualDisk.Task`

Connect-VirtualDisk. Parameter = virtual disk friendly name. Follow Microsoft guidance for detached virtual disks first.

### Summary

Reattach a detached virtual disk

### What it runs

Connect-VirtualDisk. Parameter = virtual disk friendly name. Follow Microsoft guidance for detached virtual disks first.

### Impact

This task changes the state of the target. The console asks for confirmation before it runs; use the read-only tasks first to confirm the diagnosis, and run it inside a change window where the environment requires one. The task output reports the resulting state.

### Support scope

Storage Spaces Direct pool, virtual disk, physical disk, cache, repair or Health Service evidence. Degraded resiliency and predictive drive faults deserve action before data becomes unavailable.

Element: HyperVPrivateCloud.Capability.S2D.ConnectVirtualDisk.Task. Kind: Task.

### Execution safety

Target=S2D!Microsoft.Windows.Server.10.0.Storage.StorageSpacesDirect.StorageSubSystem; enabled=true; timeout=600. Read the task&#39;s original knowledge and parameters before execution. A Remediation task changes state and requires approval; do not execute it solely because the object is red. Even a diagnostic can generate logs or files; review its documented impact.

### Read-only investigation

Inspect Get-StoragePool, Get-VirtualDisk, Get-PhysicalDisk and Get-StorageJob, recording both HealthStatus and OperationalStatus. Run Get-StorageSubSystem Cluster* &#124; Debug-StorageSubSystem and retain the fault identifier, severity, reason, recommendation and physical location. Compare repair progress over time.

### Corrective action and escalation

Follow the specific storage fault recommendation after confirming remaining resiliency and the correct physical device. Coordinate replacement, repair or expansion with the storage owner. Do not reset disks, remove pool members, change read-only flags or delete virtual disks as generic troubleshooting.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm the fault disappears from native Health Service, repair progresses or completes, intended redundancy returns and free pool capacity remains adequate.

### Microsoft references

[Microsoft Learn: health service faults](https://learn.microsoft.com/en-us/windows-server/failover-clustering/health-service-faults)

[Microsoft Learn: storage spaces states](https://learn.microsoft.com/en-us/windows-server/storage/storage-spaces/storage-spaces-states)

[Microsoft Learn: troubleshooting storage spaces](https://learn.microsoft.com/en-us/windows-server/storage/storage-spaces/troubleshooting-storage-spaces)


## S2D integration pipeline health {#hypervprivatecloud.capability.s2d.integrationhealth.monitor}

`HyperVPrivateCloud.Capability.S2D.IntegrationHealth.Monitor`

Verifies the HCS query path without duplicating Microsoft S2D leaf monitoring.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.Fabric.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.Fabric.Service.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Service.Storage.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.S2D.StorageSubSystem.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.S2D.IntegrationHealth.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

Verifies that the Windows Storage query path used by the HCS S2D adapter is operational. Microsoft S2D workflows remain the leaf-alert authority.

### Operator response

Validate the Storage module, HealthService account permissions, Microsoft S2D discovery, and Operations Manager event 8503.

### Support scope

Storage Spaces Direct pool, virtual disk, physical disk, cache, repair or Health Service evidence. Degraded resiliency and predictive drive faults deserve action before data becomes unavailable.

Element: HyperVPrivateCloud.Capability.S2D.IntegrationHealth.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: S2D!Microsoft.Windows.Server.10.0.Storage.StorageSpacesDirect.StorageSubSystem. Parent health aspect: Health!System.Health.AvailabilityState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: Property[@Name=&#39;S2DIntegrationState&#39;] = Good

Warning [Warning]: Property[@Name=&#39;S2DIntegrationState&#39;] = Warning

Error [Critical]: Property[@Name=&#39;S2DIntegrationState&#39;] = Critical

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: ComputerName=$Target/Host/Property[Type=&quot;Windows!Microsoft.Windows.Computer&quot;]/PrincipalName$; IntervalSeconds=300; SyncTime=; TimeoutSeconds=120 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Error; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Inspect Get-StoragePool, Get-VirtualDisk, Get-PhysicalDisk and Get-StorageJob, recording both HealthStatus and OperationalStatus. Run Get-StorageSubSystem Cluster* &#124; Debug-StorageSubSystem and retain the fault identifier, severity, reason, recommendation and physical location. Compare repair progress over time.

### Corrective action and escalation

Follow the specific storage fault recommendation after confirming remaining resiliency and the correct physical device. Coordinate replacement, repair or expansion with the storage owner. Do not reset disks, remove pool members, change read-only flags or delete virtual disks as generic troubleshooting.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm the fault disappears from native Health Service, repair progresses or completes, intended redundancy returns and free pool capacity remains adequate.

### Microsoft references

[Microsoft Learn: health service faults](https://learn.microsoft.com/en-us/windows-server/failover-clustering/health-service-faults)

[Microsoft Learn: storage spaces states](https://learn.microsoft.com/en-us/windows-server/storage/storage-spaces/storage-spaces-states)

[Microsoft Learn: troubleshooting storage spaces](https://learn.microsoft.com/en-us/windows-server/storage/storage-spaces/troubleshooting-storage-spaces)


## Storage pool free capacity {#hypervprivatecloud.capability.s2d.storagepool.freecapacity.monitor}

`HyperVPrivateCloud.Capability.S2D.StoragePool.FreeCapacity.Monitor`

Raises a warning when the worst clustered storage pool free capacity falls to or below WarningThreshold (default 20 percent) and an error at or below CriticalThreshold (default 10 percent). Both thresholds are overridable.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.Fabric.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.Fabric.Service.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Service.Storage.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.S2D.StorageSubSystem.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.S2D.StoragePool.FreeCapacity.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

The worst clustered storage pool free capacity has fallen to or below the configured percentage. Storage Spaces Direct needs reserve capacity (at least one capacity drive per server) to repair after a drive or node failure; below that, resiliency cannot be restored and volumes cannot be extended.

### Causes

Volumes created or extended beyond the pool capacity plan.

Thin-provisioned volumes growing as VMs write data.

Failed or retired drives removed from the pool reducing total capacity.

Reserve capacity not planned for (Microsoft recommends leaving one capacity drive per node unallocated).

### Resolutions

Get-StoragePool -IsPrimordial $false &#124; Select FriendlyName,Size,AllocatedSize and Get-VirtualDisk show where capacity went.

Reclaim space by deleting unused volumes/checkpoints, or add drives/nodes to the pool.

Replace failed drives so their capacity returns to the pool.

Do not lower CriticalThreshold below the reserve required for a full repair; the 10 percent default is a general-purpose floor.

### Support scope

Storage Spaces Direct pool, virtual disk, physical disk, cache, repair or Health Service evidence. Degraded resiliency and predictive drive faults deserve action before data becomes unavailable.

Element: HyperVPrivateCloud.Capability.S2D.StoragePool.FreeCapacity.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: S2D!Microsoft.Windows.Server.10.0.Storage.StorageSpacesDirect.StorageSubSystem. Parent health aspect: Health!System.Health.PerformanceState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: Property[@Name=&#39;PoolWorstFreePercent&#39;] &gt; 20

Warning [Warning]: (Property[@Name=&#39;PoolWorstFreePercent&#39;] &lt;= 20 AND Property[@Name=&#39;PoolWorstFreePercent&#39;] &gt; 10)

Error [Critical]: Property[@Name=&#39;PoolWorstFreePercent&#39;] &lt;= 10

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: ComputerName=$Target/Host/Property[Type=&quot;Windows!Microsoft.Windows.Computer&quot;]/PrincipalName$; CriticalThreshold=10; IntervalSeconds=300; PropertyName=PoolWorstFreePercent; SyncTime=; TimeoutSeconds=120; WarningThreshold=20 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Warning; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Inspect Get-StoragePool, Get-VirtualDisk, Get-PhysicalDisk and Get-StorageJob, recording both HealthStatus and OperationalStatus. Run Get-StorageSubSystem Cluster* &#124; Debug-StorageSubSystem and retain the fault identifier, severity, reason, recommendation and physical location. Compare repair progress over time.

### Corrective action and escalation

Follow the specific storage fault recommendation after confirming remaining resiliency and the correct physical device. Coordinate replacement, repair or expansion with the storage owner. Do not reset disks, remove pool members, change read-only flags or delete virtual disks as generic troubleshooting.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm the fault disappears from native Health Service, repair progresses or completes, intended redundancy returns and free pool capacity remains adequate.

### Microsoft references

[Microsoft Learn: health service faults](https://learn.microsoft.com/en-us/windows-server/failover-clustering/health-service-faults)

[Microsoft Learn: storage spaces states](https://learn.microsoft.com/en-us/windows-server/storage/storage-spaces/storage-spaces-states)

[Microsoft Learn: troubleshooting storage spaces](https://learn.microsoft.com/en-us/windows-server/storage/storage-spaces/troubleshooting-storage-spaces)


## Storage pool health {#hypervprivatecloud.capability.s2d.storagepool.health.monitor}

`HyperVPrivateCloud.Capability.S2D.StoragePool.Health.Monitor`

Raises an error when the count of non-healthy clustered storage pools reaches CriticalThreshold (default 1). WarningThreshold (default 1) is overridable and may be lowered relative to CriticalThreshold to create a warning band.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.Fabric.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.Fabric.Service.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Service.Storage.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.S2D.StorageSubSystem.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.S2D.StoragePool.Health.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

A clustered storage pool is reporting a non-healthy HealthStatus (Warning or Unhealthy). Pool health summarises the drives and virtual disks inside it; an unhealthy pool usually means lost or failing physical disks or a virtual disk that cannot be repaired.

### Causes

Physical disk failure, lost communication or predictive failure.

Virtual disk detached or with incomplete redundancy.

Pool metadata quorum lost after multiple simultaneous drive/node failures.

### Resolutions

Get-StoragePool &#124; Get-PhysicalDisk and Get-VirtualDisk show the unhealthy members; Get-StorageSubSystem *Cluster* &#124; Debug-StorageSubSystem lists the health faults with recommended actions.

Replace failed drives, then confirm repair jobs complete (Get-StorageJob).

Review Get-HealthFault output in the S2D Faults view for the exact fault type and recommendation.

Thresholds are counts of non-healthy pools.

### Support scope

Storage Spaces Direct pool, virtual disk, physical disk, cache, repair or Health Service evidence. Degraded resiliency and predictive drive faults deserve action before data becomes unavailable.

Element: HyperVPrivateCloud.Capability.S2D.StoragePool.Health.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: S2D!Microsoft.Windows.Server.10.0.Storage.StorageSpacesDirect.StorageSubSystem. Parent health aspect: Health!System.Health.AvailabilityState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: Property[@Name=&#39;PoolUnhealthyCount&#39;] &lt; 1

Warning [Warning]: (Property[@Name=&#39;PoolUnhealthyCount&#39;] &gt;= 1 AND Property[@Name=&#39;PoolUnhealthyCount&#39;] &lt; 1)

Error [Critical]: Property[@Name=&#39;PoolUnhealthyCount&#39;] &gt;= 1

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

Warning and critical thresholds are equal: this configuration has no intermediate numeric warning band. This can be intentional for discrete outages; do not claim an early warning is provided by this monitor.

### Sampling and effective policy

Compiled configuration: ComputerName=$Target/Host/Property[Type=&quot;Windows!Microsoft.Windows.Computer&quot;]/PrincipalName$; CriticalThreshold=1; IntervalSeconds=300; PropertyName=PoolUnhealthyCount; SyncTime=; TimeoutSeconds=120; WarningThreshold=1 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Warning; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Inspect Get-StoragePool, Get-VirtualDisk, Get-PhysicalDisk and Get-StorageJob, recording both HealthStatus and OperationalStatus. Run Get-StorageSubSystem Cluster* &#124; Debug-StorageSubSystem and retain the fault identifier, severity, reason, recommendation and physical location. Compare repair progress over time.

### Corrective action and escalation

Follow the specific storage fault recommendation after confirming remaining resiliency and the correct physical device. Coordinate replacement, repair or expansion with the storage owner. Do not reset disks, remove pool members, change read-only flags or delete virtual disks as generic troubleshooting.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm the fault disappears from native Health Service, repair progresses or completes, intended redundancy returns and free pool capacity remains adequate.

### Microsoft references

[Microsoft Learn: health service faults](https://learn.microsoft.com/en-us/windows-server/failover-clustering/health-service-faults)

[Microsoft Learn: storage spaces states](https://learn.microsoft.com/en-us/windows-server/storage/storage-spaces/storage-spaces-states)

[Microsoft Learn: troubleshooting storage spaces](https://learn.microsoft.com/en-us/windows-server/storage/storage-spaces/troubleshooting-storage-spaces)


## Storage pool read-only state {#hypervprivatecloud.capability.s2d.storagepool.readonly.monitor}

`HyperVPrivateCloud.Capability.S2D.StoragePool.ReadOnly.Monitor`

Raises an error when the count of read-only clustered storage pools reaches CriticalThreshold (default 1). WarningThreshold defaults to 1 and both are overridable.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.Fabric.Configuration.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.Fabric.Service.Configuration.Dependency.Monitor &gt; HyperVPrivateCloud.Service.Storage.Configuration.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.S2D.StorageSubSystem.Configuration.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.S2D.StoragePool.ReadOnly.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

A clustered storage pool is read-only. No new virtual disks can be created or extended, and repair jobs cannot run, so any degraded volume stays degraded until the pool is writable again.

### Causes

Pool metadata lost quorum after too many drives or nodes failed at once.

Pool set read-only manually (Set-StoragePool -IsReadOnly $true) during maintenance.

Storage Spaces detected corruption and protected the pool.

### Resolutions

Get-StoragePool &#124; Select FriendlyName,IsReadOnly,HealthStatus and Get-StorageSubSystem &#124; Debug-StorageSubSystem for the reason.

Restore the failed drives or nodes so the pool metadata regains quorum, then Set-StoragePool -IsReadOnly $false if it does not clear automatically.

Engage Microsoft support before forcing a read-only pool writable if corruption is reported.

Keep CriticalThreshold at 1.

### Support scope

Storage Spaces Direct pool, virtual disk, physical disk, cache, repair or Health Service evidence. Degraded resiliency and predictive drive faults deserve action before data becomes unavailable.

Element: HyperVPrivateCloud.Capability.S2D.StoragePool.ReadOnly.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: S2D!Microsoft.Windows.Server.10.0.Storage.StorageSpacesDirect.StorageSubSystem. Parent health aspect: Health!System.Health.ConfigurationState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: Property[@Name=&#39;PoolReadOnlyCount&#39;] &lt; 1

Warning [Warning]: (Property[@Name=&#39;PoolReadOnlyCount&#39;] &gt;= 1 AND Property[@Name=&#39;PoolReadOnlyCount&#39;] &lt; 1)

Error [Critical]: Property[@Name=&#39;PoolReadOnlyCount&#39;] &gt;= 1

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

Warning and critical thresholds are equal: this configuration has no intermediate numeric warning band. This can be intentional for discrete outages; do not claim an early warning is provided by this monitor.

### Sampling and effective policy

Compiled configuration: ComputerName=$Target/Host/Property[Type=&quot;Windows!Microsoft.Windows.Computer&quot;]/PrincipalName$; CriticalThreshold=1; IntervalSeconds=300; PropertyName=PoolReadOnlyCount; SyncTime=; TimeoutSeconds=120; WarningThreshold=1 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Warning; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Inspect Get-StoragePool, Get-VirtualDisk, Get-PhysicalDisk and Get-StorageJob, recording both HealthStatus and OperationalStatus. Run Get-StorageSubSystem Cluster* &#124; Debug-StorageSubSystem and retain the fault identifier, severity, reason, recommendation and physical location. Compare repair progress over time.

### Corrective action and escalation

Follow the specific storage fault recommendation after confirming remaining resiliency and the correct physical device. Coordinate replacement, repair or expansion with the storage owner. Do not reset disks, remove pool members, change read-only flags or delete virtual disks as generic troubleshooting.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm the fault disappears from native Health Service, repair progresses or completes, intended redundancy returns and free pool capacity remains adequate.

### Microsoft references

[Microsoft Learn: health service faults](https://learn.microsoft.com/en-us/windows-server/failover-clustering/health-service-faults)

[Microsoft Learn: storage spaces states](https://learn.microsoft.com/en-us/windows-server/storage/storage-spaces/storage-spaces-states)

[Microsoft Learn: troubleshooting storage spaces](https://learn.microsoft.com/en-us/windows-server/storage/storage-spaces/troubleshooting-storage-spaces)


## Virtual disk degraded operational status {#hypervprivatecloud.capability.s2d.virtualdisk.degraded.monitor}

`HyperVPrivateCloud.Capability.S2D.VirtualDisk.Degraded.Monitor`

Raises a warning when the count of degraded clustered virtual disks reaches WarningThreshold (default 1) and an error at CriticalThreshold (default 2). Both thresholds are overridable.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.Fabric.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.Fabric.Service.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Service.Storage.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.S2D.StorageSubSystem.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.S2D.VirtualDisk.Degraded.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

One or more clustered virtual disks report a Degraded operational status. The volume is online but has lost a copy of its data on at least one fault domain; another failure before repair completes can take it offline.

### Causes

A physical disk or node failed, or a node is in storage maintenance mode.

Repair job pending because the pool lacks reserve capacity.

Node offline for patching longer than the repair could be deferred.

### Resolutions

Get-VirtualDisk &#124; Select FriendlyName,OperationalStatus,HealthStatus and Get-StorageJob show the disk and whether a repair is running or pending.

Bring the node back or replace the drive; repair starts automatically after a grace period. Run Repair-VirtualDisk if it does not.

If repair is blocked by capacity, free or add capacity first (see the pool free-capacity monitor).

WarningThreshold 1 gives early notice; CriticalThreshold 2 marks multiple volumes at risk.

### Support scope

Storage Spaces Direct pool, virtual disk, physical disk, cache, repair or Health Service evidence. Degraded resiliency and predictive drive faults deserve action before data becomes unavailable.

Element: HyperVPrivateCloud.Capability.S2D.VirtualDisk.Degraded.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: S2D!Microsoft.Windows.Server.10.0.Storage.StorageSpacesDirect.StorageSubSystem. Parent health aspect: Health!System.Health.AvailabilityState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: Property[@Name=&#39;VirtualDiskDegradedCount&#39;] &lt; 1

Warning [Warning]: (Property[@Name=&#39;VirtualDiskDegradedCount&#39;] &gt;= 1 AND Property[@Name=&#39;VirtualDiskDegradedCount&#39;] &lt; 2)

Error [Critical]: Property[@Name=&#39;VirtualDiskDegradedCount&#39;] &gt;= 2

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: ComputerName=$Target/Host/Property[Type=&quot;Windows!Microsoft.Windows.Computer&quot;]/PrincipalName$; CriticalThreshold=2; IntervalSeconds=300; PropertyName=VirtualDiskDegradedCount; SyncTime=; TimeoutSeconds=120; WarningThreshold=1 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Warning; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Inspect Get-StoragePool, Get-VirtualDisk, Get-PhysicalDisk and Get-StorageJob, recording both HealthStatus and OperationalStatus. Run Get-StorageSubSystem Cluster* &#124; Debug-StorageSubSystem and retain the fault identifier, severity, reason, recommendation and physical location. Compare repair progress over time.

### Corrective action and escalation

Follow the specific storage fault recommendation after confirming remaining resiliency and the correct physical device. Coordinate replacement, repair or expansion with the storage owner. Do not reset disks, remove pool members, change read-only flags or delete virtual disks as generic troubleshooting.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm the fault disappears from native Health Service, repair progresses or completes, intended redundancy returns and free pool capacity remains adequate.

### Microsoft references

[Microsoft Learn: health service faults](https://learn.microsoft.com/en-us/windows-server/failover-clustering/health-service-faults)

[Microsoft Learn: storage spaces states](https://learn.microsoft.com/en-us/windows-server/storage/storage-spaces/storage-spaces-states)

[Microsoft Learn: troubleshooting storage spaces](https://learn.microsoft.com/en-us/windows-server/storage/storage-spaces/troubleshooting-storage-spaces)


## Virtual disk repair or regeneration activity {#hypervprivatecloud.capability.s2d.virtualdisk.repair.monitor}

`HyperVPrivateCloud.Capability.S2D.VirtualDisk.Repair.Monitor`

Raises a warning when the count of clustered virtual disks in repair, regeneration or resync reaches WarningThreshold (default 1) and an error at CriticalThreshold (default 4). Both thresholds are overridable.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.Fabric.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.Fabric.Service.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Service.Storage.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.S2D.StorageSubSystem.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.S2D.VirtualDisk.Repair.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

The number of clustered virtual disks currently in repair, regeneration or resync has reached the configured threshold. Repair is normal after a failure or maintenance, but many simultaneous repairs consume the pool&#39;s I/O headroom and slow every VM.

### Causes

A node returning from maintenance or reboot triggering resync of all its slabs.

Drive replacement triggering rebuilds.

Repeated node reboots causing repairs to restart.

### Resolutions

Get-StorageJob shows progress, bytes remaining and elapsed time; Get-VirtualDisk shows which volumes are affected.

Avoid further maintenance until repairs finish; monitor the S2D repair-progress performance rule.

If repair is slow, check for physical disk media errors or a degraded storage network (RDMA/SMB Direct).

Raise WarningThreshold if your cluster routinely has several volumes and every maintenance window resyncs all of them.

### Support scope

Storage Spaces Direct pool, virtual disk, physical disk, cache, repair or Health Service evidence. Degraded resiliency and predictive drive faults deserve action before data becomes unavailable.

Element: HyperVPrivateCloud.Capability.S2D.VirtualDisk.Repair.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: S2D!Microsoft.Windows.Server.10.0.Storage.StorageSpacesDirect.StorageSubSystem. Parent health aspect: Health!System.Health.PerformanceState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: Property[@Name=&#39;VirtualDiskInRepairCount&#39;] &lt; 2

Warning [Warning]: (Property[@Name=&#39;VirtualDiskInRepairCount&#39;] &gt;= 2 AND Property[@Name=&#39;VirtualDiskInRepairCount&#39;] &lt; 4)

Error [Critical]: Property[@Name=&#39;VirtualDiskInRepairCount&#39;] &gt;= 4

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: ComputerName=$Target/Host/Property[Type=&quot;Windows!Microsoft.Windows.Computer&quot;]/PrincipalName$; CriticalThreshold=4; IntervalSeconds=300; PropertyName=VirtualDiskInRepairCount; SyncTime=; TimeoutSeconds=120; WarningThreshold=2 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Warning; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Inspect Get-StoragePool, Get-VirtualDisk, Get-PhysicalDisk and Get-StorageJob, recording both HealthStatus and OperationalStatus. Run Get-StorageSubSystem Cluster* &#124; Debug-StorageSubSystem and retain the fault identifier, severity, reason, recommendation and physical location. Compare repair progress over time.

### Corrective action and escalation

Follow the specific storage fault recommendation after confirming remaining resiliency and the correct physical device. Coordinate replacement, repair or expansion with the storage owner. Do not reset disks, remove pool members, change read-only flags or delete virtual disks as generic troubleshooting.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm the fault disappears from native Health Service, repair progresses or completes, intended redundancy returns and free pool capacity remains adequate.

### Microsoft references

[Microsoft Learn: health service faults](https://learn.microsoft.com/en-us/windows-server/failover-clustering/health-service-faults)

[Microsoft Learn: storage spaces states](https://learn.microsoft.com/en-us/windows-server/storage/storage-spaces/storage-spaces-states)

[Microsoft Learn: troubleshooting storage spaces](https://learn.microsoft.com/en-us/windows-server/storage/storage-spaces/troubleshooting-storage-spaces)


## Virtual disk detached state {#hypervprivatecloud.capability.s2d.virtualdisk.detached.monitor}

`HyperVPrivateCloud.Capability.S2D.VirtualDisk.Detached.Monitor`

Raises an error when the count of detached clustered virtual disks reaches CriticalThreshold (default 1). WarningThreshold defaults to 1 and both are overridable.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.Fabric.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.Fabric.Service.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Service.Storage.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.S2D.StorageSubSystem.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.S2D.VirtualDisk.Detached.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

A clustered virtual disk is Detached. The volume is offline and every VM whose files live on it has lost its storage. S2D detaches a virtual disk when it can no longer guarantee data integrity, most often after simultaneous failures exceeding the resiliency level.

### Causes

More drives or nodes failed at once than the mirror/parity resiliency tolerates.

Dirty region tracking (DRT) or metadata inconsistency after an unclean shutdown.

Manual detach for maintenance.

### Resolutions

Get-VirtualDisk &#124; Where OperationalStatus -eq Detached identifies the volume; Get-StorageSubSystem &#124; Debug-StorageSubSystem explains why.

Restore failed nodes/drives, then Connect-VirtualDisk to reattach; if it refuses, follow the Microsoft procedure for detached virtual disks before considering data recovery.

Bring the CSV online (Start-ClusterResource) and resume affected VMs.

Keep CriticalThreshold at 1.

### Support scope

Storage Spaces Direct pool, virtual disk, physical disk, cache, repair or Health Service evidence. Degraded resiliency and predictive drive faults deserve action before data becomes unavailable.

Element: HyperVPrivateCloud.Capability.S2D.VirtualDisk.Detached.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: S2D!Microsoft.Windows.Server.10.0.Storage.StorageSpacesDirect.StorageSubSystem. Parent health aspect: Health!System.Health.AvailabilityState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: Property[@Name=&#39;VirtualDiskDetachedCount&#39;] &lt; 1

Warning [Warning]: (Property[@Name=&#39;VirtualDiskDetachedCount&#39;] &gt;= 1 AND Property[@Name=&#39;VirtualDiskDetachedCount&#39;] &lt; 1)

Error [Critical]: Property[@Name=&#39;VirtualDiskDetachedCount&#39;] &gt;= 1

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

Warning and critical thresholds are equal: this configuration has no intermediate numeric warning band. This can be intentional for discrete outages; do not claim an early warning is provided by this monitor.

### Sampling and effective policy

Compiled configuration: ComputerName=$Target/Host/Property[Type=&quot;Windows!Microsoft.Windows.Computer&quot;]/PrincipalName$; CriticalThreshold=1; IntervalSeconds=300; PropertyName=VirtualDiskDetachedCount; SyncTime=; TimeoutSeconds=120; WarningThreshold=1 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Warning; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Inspect Get-StoragePool, Get-VirtualDisk, Get-PhysicalDisk and Get-StorageJob, recording both HealthStatus and OperationalStatus. Run Get-StorageSubSystem Cluster* &#124; Debug-StorageSubSystem and retain the fault identifier, severity, reason, recommendation and physical location. Compare repair progress over time.

### Corrective action and escalation

Follow the specific storage fault recommendation after confirming remaining resiliency and the correct physical device. Coordinate replacement, repair or expansion with the storage owner. Do not reset disks, remove pool members, change read-only flags or delete virtual disks as generic troubleshooting.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm the fault disappears from native Health Service, repair progresses or completes, intended redundancy returns and free pool capacity remains adequate.

### Microsoft references

[Microsoft Learn: health service faults](https://learn.microsoft.com/en-us/windows-server/failover-clustering/health-service-faults)

[Microsoft Learn: storage spaces states](https://learn.microsoft.com/en-us/windows-server/storage/storage-spaces/storage-spaces-states)

[Microsoft Learn: troubleshooting storage spaces](https://learn.microsoft.com/en-us/windows-server/storage/storage-spaces/troubleshooting-storage-spaces)


## Virtual disk incomplete redundancy {#hypervprivatecloud.capability.s2d.virtualdisk.incompleteredundancy.monitor}

`HyperVPrivateCloud.Capability.S2D.VirtualDisk.IncompleteRedundancy.Monitor`

Raises an error when the count of clustered virtual disks reporting incomplete redundancy reaches CriticalThreshold (default 1). WarningThreshold defaults to 1 and both are overridable.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.Fabric.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.Fabric.Service.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Service.Storage.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.S2D.StorageSubSystem.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.S2D.VirtualDisk.IncompleteRedundancy.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

A clustered virtual disk reports Incomplete redundancy: it is online but cannot currently be repaired to its full resiliency (for example because a fault domain is missing or the pool has no reserve capacity). It remains at risk until repair completes.

### Causes

A node or drive is missing and there is no spare capacity elsewhere to rebuild the lost copy.

Not enough fault domains for the configured resiliency after a node was removed.

Repair job failed or is suspended.

### Resolutions

Get-VirtualDisk &#124; Select FriendlyName,OperationalStatus,HealthStatus,DetachedReason and Get-StorageJob for repair status.

Return the missing node or replace the drive; if capacity is the limit, add capacity or reduce allocation.

Run Repair-VirtualDisk after the fault domain is restored.

Keep CriticalThreshold at 1.

### Support scope

Storage Spaces Direct pool, virtual disk, physical disk, cache, repair or Health Service evidence. Degraded resiliency and predictive drive faults deserve action before data becomes unavailable.

Element: HyperVPrivateCloud.Capability.S2D.VirtualDisk.IncompleteRedundancy.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: S2D!Microsoft.Windows.Server.10.0.Storage.StorageSpacesDirect.StorageSubSystem. Parent health aspect: Health!System.Health.AvailabilityState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: Property[@Name=&#39;VirtualDiskIncompleteCount&#39;] &lt; 1

Warning [Warning]: (Property[@Name=&#39;VirtualDiskIncompleteCount&#39;] &gt;= 1 AND Property[@Name=&#39;VirtualDiskIncompleteCount&#39;] &lt; 1)

Error [Critical]: Property[@Name=&#39;VirtualDiskIncompleteCount&#39;] &gt;= 1

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

Warning and critical thresholds are equal: this configuration has no intermediate numeric warning band. This can be intentional for discrete outages; do not claim an early warning is provided by this monitor.

### Sampling and effective policy

Compiled configuration: ComputerName=$Target/Host/Property[Type=&quot;Windows!Microsoft.Windows.Computer&quot;]/PrincipalName$; CriticalThreshold=1; IntervalSeconds=300; PropertyName=VirtualDiskIncompleteCount; SyncTime=; TimeoutSeconds=120; WarningThreshold=1 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Warning; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Inspect Get-StoragePool, Get-VirtualDisk, Get-PhysicalDisk and Get-StorageJob, recording both HealthStatus and OperationalStatus. Run Get-StorageSubSystem Cluster* &#124; Debug-StorageSubSystem and retain the fault identifier, severity, reason, recommendation and physical location. Compare repair progress over time.

### Corrective action and escalation

Follow the specific storage fault recommendation after confirming remaining resiliency and the correct physical device. Coordinate replacement, repair or expansion with the storage owner. Do not reset disks, remove pool members, change read-only flags or delete virtual disks as generic troubleshooting.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm the fault disappears from native Health Service, repair progresses or completes, intended redundancy returns and free pool capacity remains adequate.

### Microsoft references

[Microsoft Learn: health service faults](https://learn.microsoft.com/en-us/windows-server/failover-clustering/health-service-faults)

[Microsoft Learn: storage spaces states](https://learn.microsoft.com/en-us/windows-server/storage/storage-spaces/storage-spaces-states)

[Microsoft Learn: troubleshooting storage spaces](https://learn.microsoft.com/en-us/windows-server/storage/storage-spaces/troubleshooting-storage-spaces)


## Physical disk failure {#hypervprivatecloud.capability.s2d.physicaldisk.failed.monitor}

`HyperVPrivateCloud.Capability.S2D.PhysicalDisk.Failed.Monitor`

Raises an error when the count of physical disks reporting an unhealthy health status reaches CriticalThreshold (default 1). WarningThreshold defaults to 1 and both are overridable.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.Fabric.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.Fabric.Service.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Service.Storage.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.S2D.StorageSubSystem.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.S2D.PhysicalDisk.Failed.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

A physical disk in the S2D pool reports an unhealthy HealthStatus. Volumes using that drive are degraded until it is retired and the data is rebuilt elsewhere.

### Causes

Media failure, firmware fault or a drive that stopped responding.

Backplane, HBA or cable fault presenting as a failed disk.

Drive pulled without being retired first.

### Resolutions

Get-PhysicalDisk &#124; Where HealthStatus -ne Healthy &#124; Select FriendlyName,SerialNumber,OperationalStatus,HealthStatus and Get-StorageReliabilityCounter for error history.

Retire and physically replace the drive using the vendor procedure (Set-PhysicalDisk -Usage Retired, Remove-PhysicalDisk, replace, then verify auto-pooling).

Confirm the repair job completes and the S2D storage jobs view returns to idle.

Keep CriticalThreshold at 1; one failed drive already reduces resiliency.

### Support scope

Storage Spaces Direct pool, virtual disk, physical disk, cache, repair or Health Service evidence. Degraded resiliency and predictive drive faults deserve action before data becomes unavailable.

Element: HyperVPrivateCloud.Capability.S2D.PhysicalDisk.Failed.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: S2D!Microsoft.Windows.Server.10.0.Storage.StorageSpacesDirect.StorageSubSystem. Parent health aspect: Health!System.Health.AvailabilityState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: Property[@Name=&#39;PhysicalDiskFailedCount&#39;] &lt; 1

Warning [Warning]: (Property[@Name=&#39;PhysicalDiskFailedCount&#39;] &gt;= 1 AND Property[@Name=&#39;PhysicalDiskFailedCount&#39;] &lt; 1)

Error [Critical]: Property[@Name=&#39;PhysicalDiskFailedCount&#39;] &gt;= 1

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

Warning and critical thresholds are equal: this configuration has no intermediate numeric warning band. This can be intentional for discrete outages; do not claim an early warning is provided by this monitor.

### Sampling and effective policy

Compiled configuration: ComputerName=$Target/Host/Property[Type=&quot;Windows!Microsoft.Windows.Computer&quot;]/PrincipalName$; CriticalThreshold=1; IntervalSeconds=300; PropertyName=PhysicalDiskFailedCount; SyncTime=; TimeoutSeconds=120; WarningThreshold=1 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Warning; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Inspect Get-StoragePool, Get-VirtualDisk, Get-PhysicalDisk and Get-StorageJob, recording both HealthStatus and OperationalStatus. Run Get-StorageSubSystem Cluster* &#124; Debug-StorageSubSystem and retain the fault identifier, severity, reason, recommendation and physical location. Compare repair progress over time.

### Corrective action and escalation

Follow the specific storage fault recommendation after confirming remaining resiliency and the correct physical device. Coordinate replacement, repair or expansion with the storage owner. Do not reset disks, remove pool members, change read-only flags or delete virtual disks as generic troubleshooting.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm the fault disappears from native Health Service, repair progresses or completes, intended redundancy returns and free pool capacity remains adequate.

### Microsoft references

[Microsoft Learn: health service faults](https://learn.microsoft.com/en-us/windows-server/failover-clustering/health-service-faults)

[Microsoft Learn: storage spaces states](https://learn.microsoft.com/en-us/windows-server/storage/storage-spaces/storage-spaces-states)

[Microsoft Learn: troubleshooting storage spaces](https://learn.microsoft.com/en-us/windows-server/storage/storage-spaces/troubleshooting-storage-spaces)


## Physical disk predictive failure {#hypervprivatecloud.capability.s2d.physicaldisk.predictivefailure.monitor}

`HyperVPrivateCloud.Capability.S2D.PhysicalDisk.PredictiveFailure.Monitor`

Raises a warning when the count of physical disks reporting predictive failure reaches WarningThreshold (default 1) and an error at CriticalThreshold (default 3). Both thresholds are overridable.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.Fabric.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.Fabric.Service.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Service.Storage.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.S2D.StorageSubSystem.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.S2D.PhysicalDisk.PredictiveFailure.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

One or more physical disks report Predictive Failure (SMART / reliability counters indicate the drive is likely to fail). Replace proactively before the drive fails and forces an unplanned repair.

### Causes

Wear-out on SSD/NVMe media (percentage used, spare blocks) or reallocated sectors on HDD.

Rising temperature or uncorrectable error trends.

### Resolutions

Get-PhysicalDisk &#124; Where OperationalStatus -like &quot;*Predictive*&quot; and Get-StorageReliabilityCounter show wear, temperature and error counts.

Schedule a proactive retire-and-replace during a maintenance window (Set-PhysicalDisk -Usage Retired starts data movement before removal).

Check firmware advisories from the hardware vendor if several drives of the same model report together.

WarningThreshold 1 is a maintenance signal; CriticalThreshold 3 indicates a batch failure pattern.

### Support scope

Storage Spaces Direct pool, virtual disk, physical disk, cache, repair or Health Service evidence. Degraded resiliency and predictive drive faults deserve action before data becomes unavailable.

Element: HyperVPrivateCloud.Capability.S2D.PhysicalDisk.PredictiveFailure.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: S2D!Microsoft.Windows.Server.10.0.Storage.StorageSpacesDirect.StorageSubSystem. Parent health aspect: Health!System.Health.AvailabilityState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: Property[@Name=&#39;PhysicalDiskPredictiveFailureCount&#39;] &lt; 1

Warning [Warning]: (Property[@Name=&#39;PhysicalDiskPredictiveFailureCount&#39;] &gt;= 1 AND Property[@Name=&#39;PhysicalDiskPredictiveFailureCount&#39;] &lt; 3)

Error [Critical]: Property[@Name=&#39;PhysicalDiskPredictiveFailureCount&#39;] &gt;= 3

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: ComputerName=$Target/Host/Property[Type=&quot;Windows!Microsoft.Windows.Computer&quot;]/PrincipalName$; CriticalThreshold=3; IntervalSeconds=300; PropertyName=PhysicalDiskPredictiveFailureCount; SyncTime=; TimeoutSeconds=120; WarningThreshold=1 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Warning; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Inspect Get-StoragePool, Get-VirtualDisk, Get-PhysicalDisk and Get-StorageJob, recording both HealthStatus and OperationalStatus. Run Get-StorageSubSystem Cluster* &#124; Debug-StorageSubSystem and retain the fault identifier, severity, reason, recommendation and physical location. Compare repair progress over time.

### Corrective action and escalation

Follow the specific storage fault recommendation after confirming remaining resiliency and the correct physical device. Coordinate replacement, repair or expansion with the storage owner. Do not reset disks, remove pool members, change read-only flags or delete virtual disks as generic troubleshooting.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm the fault disappears from native Health Service, repair progresses or completes, intended redundancy returns and free pool capacity remains adequate.

### Microsoft references

[Microsoft Learn: health service faults](https://learn.microsoft.com/en-us/windows-server/failover-clustering/health-service-faults)

[Microsoft Learn: storage spaces states](https://learn.microsoft.com/en-us/windows-server/storage/storage-spaces/storage-spaces-states)

[Microsoft Learn: troubleshooting storage spaces](https://learn.microsoft.com/en-us/windows-server/storage/storage-spaces/troubleshooting-storage-spaces)


## Physical disk uncorrected media errors {#hypervprivatecloud.capability.s2d.physicaldisk.mediaerrors.monitor}

`HyperVPrivateCloud.Capability.S2D.PhysicalDisk.MediaErrors.Monitor`

Raises a warning when the worst per-disk uncorrected read plus write error count reaches WarningThreshold (default 1) and an error at CriticalThreshold (default 10). Both thresholds are overridable.

### Summary

The worst per-disk count of uncorrected read plus write errors has reached the configured threshold. Uncorrected media errors mean the drive returned bad data or failed an I/O, which Storage Spaces has had to repair from another copy.

### Causes

Failing media or firmware defect on the drive.

Cable/backplane errors surfacing as I/O errors.

Drive running hot or beyond endurance.

### Resolutions

Get-StorageReliabilityCounter -PhysicalDisk (Get-PhysicalDisk &lt;name&gt;) shows ReadErrorsUncorrected / WriteErrorsUncorrected and temperature.

If counts keep rising, retire and replace the drive proactively.

Correlate with S2D health faults and vendor diagnostics.

The default Warning of 1 error surfaces the first uncorrected error; raise it only if your drives are known to report benign uncorrected counts.

### Support scope

Storage Spaces Direct pool, virtual disk, physical disk, cache, repair or Health Service evidence. Degraded resiliency and predictive drive faults deserve action before data becomes unavailable.

Element: HyperVPrivateCloud.Capability.S2D.PhysicalDisk.MediaErrors.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: S2D!Microsoft.Windows.Server.10.0.Storage.StorageSpacesDirect.StorageSubSystem. Parent health aspect: Health!System.Health.PerformanceState. Enabled by default: false. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: Property[@Name=&#39;PhysicalDiskMaxMediaErrors&#39;] &lt; 1

Warning [Warning]: (Property[@Name=&#39;PhysicalDiskMaxMediaErrors&#39;] &gt;= 1 AND Property[@Name=&#39;PhysicalDiskMaxMediaErrors&#39;] &lt; 10)

Error [Critical]: Property[@Name=&#39;PhysicalDiskMaxMediaErrors&#39;] &gt;= 10

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: ComputerName=$Target/Host/Property[Type=&quot;Windows!Microsoft.Windows.Computer&quot;]/PrincipalName$; CriticalThreshold=10; IntervalSeconds=300; PropertyName=PhysicalDiskMaxMediaErrors; SyncTime=; TimeoutSeconds=120; WarningThreshold=1 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Warning; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Inspect Get-StoragePool, Get-VirtualDisk, Get-PhysicalDisk and Get-StorageJob, recording both HealthStatus and OperationalStatus. Run Get-StorageSubSystem Cluster* &#124; Debug-StorageSubSystem and retain the fault identifier, severity, reason, recommendation and physical location. Compare repair progress over time.

### Corrective action and escalation

Follow the specific storage fault recommendation after confirming remaining resiliency and the correct physical device. Coordinate replacement, repair or expansion with the storage owner. Do not reset disks, remove pool members, change read-only flags or delete virtual disks as generic troubleshooting.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm the fault disappears from native Health Service, repair progresses or completes, intended redundancy returns and free pool capacity remains adequate.

### Microsoft references

[Microsoft Learn: health service faults](https://learn.microsoft.com/en-us/windows-server/failover-clustering/health-service-faults)

[Microsoft Learn: storage spaces states](https://learn.microsoft.com/en-us/windows-server/storage/storage-spaces/storage-spaces-states)

[Microsoft Learn: troubleshooting storage spaces](https://learn.microsoft.com/en-us/windows-server/storage/storage-spaces/troubleshooting-storage-spaces)


## Physical disk lost communication {#hypervprivatecloud.capability.s2d.physicaldisk.lostcommunication.monitor}

`HyperVPrivateCloud.Capability.S2D.PhysicalDisk.LostCommunication.Monitor`

Raises an error when the count of physical disks reporting lost communication, removal from pool or maintenance start reaches CriticalThreshold (default 1). WarningThreshold defaults to 1 and both are overridable.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.Fabric.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.Fabric.Service.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Service.Storage.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.S2D.StorageSubSystem.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.S2D.PhysicalDisk.LostCommunication.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

A physical disk reports Lost Communication, Removed From Pool or Starting Maintenance Mode. The pool cannot reach the drive, so its slabs are unavailable and volumes are degraded until it returns or is retired.

### Causes

Node offline or in storage maintenance mode (expected during patching).

Drive unplugged, backplane/HBA/enclosure failure, or NVMe device reset.

Storage bus (SBL) connectivity loss over the storage network between nodes.

### Resolutions

Get-PhysicalDisk &#124; Where OperationalStatus -like &quot;*Lost*&quot; shows the drives; Get-StorageFaultDomain groups them by node/enclosure to spot a node-wide loss.

If a whole node&#39;s drives are missing, fix the node or its storage-network connectivity first.

For an individual drive reseat or replace it; retire if it does not return.

This monitor also fires during planned maintenance mode; put the node in SCOM maintenance mode during patching to suppress it.

### Support scope

Storage Spaces Direct pool, virtual disk, physical disk, cache, repair or Health Service evidence. Degraded resiliency and predictive drive faults deserve action before data becomes unavailable.

Element: HyperVPrivateCloud.Capability.S2D.PhysicalDisk.LostCommunication.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: S2D!Microsoft.Windows.Server.10.0.Storage.StorageSpacesDirect.StorageSubSystem. Parent health aspect: Health!System.Health.AvailabilityState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: Property[@Name=&#39;PhysicalDiskLostCommunicationCount&#39;] &lt; 1

Warning [Warning]: (Property[@Name=&#39;PhysicalDiskLostCommunicationCount&#39;] &gt;= 1 AND Property[@Name=&#39;PhysicalDiskLostCommunicationCount&#39;] &lt; 1)

Error [Critical]: Property[@Name=&#39;PhysicalDiskLostCommunicationCount&#39;] &gt;= 1

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

Warning and critical thresholds are equal: this configuration has no intermediate numeric warning band. This can be intentional for discrete outages; do not claim an early warning is provided by this monitor.

### Sampling and effective policy

Compiled configuration: ComputerName=$Target/Host/Property[Type=&quot;Windows!Microsoft.Windows.Computer&quot;]/PrincipalName$; CriticalThreshold=1; IntervalSeconds=300; PropertyName=PhysicalDiskLostCommunicationCount; SyncTime=; TimeoutSeconds=120; WarningThreshold=1 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Warning; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Inspect Get-StoragePool, Get-VirtualDisk, Get-PhysicalDisk and Get-StorageJob, recording both HealthStatus and OperationalStatus. Run Get-StorageSubSystem Cluster* &#124; Debug-StorageSubSystem and retain the fault identifier, severity, reason, recommendation and physical location. Compare repair progress over time.

### Corrective action and escalation

Follow the specific storage fault recommendation after confirming remaining resiliency and the correct physical device. Coordinate replacement, repair or expansion with the storage owner. Do not reset disks, remove pool members, change read-only flags or delete virtual disks as generic troubleshooting.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm the fault disappears from native Health Service, repair progresses or completes, intended redundancy returns and free pool capacity remains adequate.

### Microsoft references

[Microsoft Learn: health service faults](https://learn.microsoft.com/en-us/windows-server/failover-clustering/health-service-faults)

[Microsoft Learn: storage spaces states](https://learn.microsoft.com/en-us/windows-server/storage/storage-spaces/storage-spaces-states)

[Microsoft Learn: troubleshooting storage spaces](https://learn.microsoft.com/en-us/windows-server/storage/storage-spaces/troubleshooting-storage-spaces)


## Physical disk retired usage {#hypervprivatecloud.capability.s2d.physicaldisk.retired.monitor}

`HyperVPrivateCloud.Capability.S2D.PhysicalDisk.Retired.Monitor`

Raises a warning when the count of retired physical disks reaches WarningThreshold (default 1) and an error at CriticalThreshold (default 2). Both thresholds are overridable.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.Fabric.Configuration.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.Fabric.Service.Configuration.Dependency.Monitor &gt; HyperVPrivateCloud.Service.Storage.Configuration.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.S2D.StorageSubSystem.Configuration.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.S2D.PhysicalDisk.Retired.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

One or more physical disks have Usage set to Retired. A retired drive is being evacuated or has been evacuated and should be physically removed; retired drives left in the pool consume slots and confuse capacity planning.

### Causes

Administrator retired a failing drive but has not yet replaced it.

S2D automatically retired a drive after repeated failures.

### Resolutions

Get-PhysicalDisk &#124; Where Usage -eq Retired &#124; Select FriendlyName,SerialNumber,Size and confirm Get-StorageJob shows no data movement still pending.

Physically replace the drive and verify the replacement auto-pools (Get-PhysicalDisk -CanPool $true should be empty).

Remove the retired object with Remove-PhysicalDisk once evacuation is complete.

Thresholds are counts of retired drives.

### Support scope

Storage Spaces Direct pool, virtual disk, physical disk, cache, repair or Health Service evidence. Degraded resiliency and predictive drive faults deserve action before data becomes unavailable.

Element: HyperVPrivateCloud.Capability.S2D.PhysicalDisk.Retired.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: S2D!Microsoft.Windows.Server.10.0.Storage.StorageSpacesDirect.StorageSubSystem. Parent health aspect: Health!System.Health.ConfigurationState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: Property[@Name=&#39;PhysicalDiskRetiredCount&#39;] &lt; 1

Warning [Warning]: (Property[@Name=&#39;PhysicalDiskRetiredCount&#39;] &gt;= 1 AND Property[@Name=&#39;PhysicalDiskRetiredCount&#39;] &lt; 2)

Error [Critical]: Property[@Name=&#39;PhysicalDiskRetiredCount&#39;] &gt;= 2

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: ComputerName=$Target/Host/Property[Type=&quot;Windows!Microsoft.Windows.Computer&quot;]/PrincipalName$; CriticalThreshold=2; IntervalSeconds=300; PropertyName=PhysicalDiskRetiredCount; SyncTime=; TimeoutSeconds=120; WarningThreshold=1 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Warning; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Inspect Get-StoragePool, Get-VirtualDisk, Get-PhysicalDisk and Get-StorageJob, recording both HealthStatus and OperationalStatus. Run Get-StorageSubSystem Cluster* &#124; Debug-StorageSubSystem and retain the fault identifier, severity, reason, recommendation and physical location. Compare repair progress over time.

### Corrective action and escalation

Follow the specific storage fault recommendation after confirming remaining resiliency and the correct physical device. Coordinate replacement, repair or expansion with the storage owner. Do not reset disks, remove pool members, change read-only flags or delete virtual disks as generic troubleshooting.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm the fault disappears from native Health Service, repair progresses or completes, intended redundancy returns and free pool capacity remains adequate.

### Microsoft references

[Microsoft Learn: health service faults](https://learn.microsoft.com/en-us/windows-server/failover-clustering/health-service-faults)

[Microsoft Learn: storage spaces states](https://learn.microsoft.com/en-us/windows-server/storage/storage-spaces/storage-spaces-states)

[Microsoft Learn: troubleshooting storage spaces](https://learn.microsoft.com/en-us/windows-server/storage/storage-spaces/troubleshooting-storage-spaces)


## Cache device failure {#hypervprivatecloud.capability.s2d.cachedevice.failed.monitor}

`HyperVPrivateCloud.Capability.S2D.CacheDevice.Failed.Monitor`

Raises an error when the count of non-healthy Storage Spaces Direct cache devices reaches CriticalThreshold (default 1). WarningThreshold defaults to 1 and both are overridable.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.Fabric.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.Fabric.Service.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Service.Storage.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.S2D.StorageSubSystem.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.S2D.CacheDevice.Failed.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

A Storage Spaces Direct cache device (Usage = Journal) is not healthy. The capacity drives bound to that cache device lose their cache and fall back to slower direct I/O or, if the cache held unflushed writes, become unavailable until rebinding completes.

### Causes

NVMe/SSD cache device failure or wear-out.

Firmware fault or device reset on the cache drive.

Backplane or slot fault.

### Resolutions

Get-PhysicalDisk &#124; Where Usage -eq Journal &#124; Where HealthStatus -ne Healthy identifies the device; Get-StorageSubSystem &#124; Debug-StorageSubSystem lists the cache fault and affected capacity drives.

Replace the cache device following the vendor procedure; S2D rebinds capacity drives automatically after replacement.

Watch the S2D repair jobs until complete.

Keep CriticalThreshold at 1.

### Support scope

Storage Spaces Direct pool, virtual disk, physical disk, cache, repair or Health Service evidence. Degraded resiliency and predictive drive faults deserve action before data becomes unavailable.

Element: HyperVPrivateCloud.Capability.S2D.CacheDevice.Failed.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: S2D!Microsoft.Windows.Server.10.0.Storage.StorageSpacesDirect.StorageSubSystem. Parent health aspect: Health!System.Health.AvailabilityState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: Property[@Name=&#39;CacheDeviceFailedCount&#39;] &lt; 1

Warning [Warning]: (Property[@Name=&#39;CacheDeviceFailedCount&#39;] &gt;= 1 AND Property[@Name=&#39;CacheDeviceFailedCount&#39;] &lt; 1)

Error [Critical]: Property[@Name=&#39;CacheDeviceFailedCount&#39;] &gt;= 1

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

Warning and critical thresholds are equal: this configuration has no intermediate numeric warning band. This can be intentional for discrete outages; do not claim an early warning is provided by this monitor.

### Sampling and effective policy

Compiled configuration: ComputerName=$Target/Host/Property[Type=&quot;Windows!Microsoft.Windows.Computer&quot;]/PrincipalName$; CriticalThreshold=1; IntervalSeconds=300; PropertyName=CacheDeviceFailedCount; SyncTime=; TimeoutSeconds=120; WarningThreshold=1 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Warning; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Inspect Get-StoragePool, Get-VirtualDisk, Get-PhysicalDisk and Get-StorageJob, recording both HealthStatus and OperationalStatus. Run Get-StorageSubSystem Cluster* &#124; Debug-StorageSubSystem and retain the fault identifier, severity, reason, recommendation and physical location. Compare repair progress over time.

### Corrective action and escalation

Follow the specific storage fault recommendation after confirming remaining resiliency and the correct physical device. Coordinate replacement, repair or expansion with the storage owner. Do not reset disks, remove pool members, change read-only flags or delete virtual disks as generic troubleshooting.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm the fault disappears from native Health Service, repair progresses or completes, intended redundancy returns and free pool capacity remains adequate.

### Microsoft references

[Microsoft Learn: health service faults](https://learn.microsoft.com/en-us/windows-server/failover-clustering/health-service-faults)

[Microsoft Learn: storage spaces states](https://learn.microsoft.com/en-us/windows-server/storage/storage-spaces/storage-spaces-states)

[Microsoft Learn: troubleshooting storage spaces](https://learn.microsoft.com/en-us/windows-server/storage/storage-spaces/troubleshooting-storage-spaces)


## Storage job running beyond expected duration {#hypervprivatecloud.capability.s2d.storagejob.stalled.monitor}

`HyperVPrivateCloud.Capability.S2D.StorageJob.Stalled.Monitor`

Raises a warning when the longest running storage job exceeds WarningThreshold minutes (default 240) and an error beyond CriticalThreshold minutes (default 720). Both thresholds are overridable.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.Fabric.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.Fabric.Service.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Service.Storage.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.S2D.StorageSubSystem.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.S2D.StorageJob.Stalled.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

The longest-running S2D storage job has exceeded the configured duration in minutes. Repair and regeneration jobs normally complete in minutes to a few hours; a job that runs far longer, or shows no progress, usually indicates a blocked repair.

### Causes

Repair waiting on capacity that is not available.

A node still down or in maintenance mode so the job cannot finish.

Storage network (SMB Direct/RDMA) degraded, slowing resync dramatically.

Very large volumes after a full-node resync (legitimately long).

### Resolutions

Get-StorageJob &#124; Select Name,JobState,PercentComplete,BytesProcessed,BytesTotal,ElapsedTime shows progress; compare with the S2D repair-progress performance rule to see whether it is moving.

Resolve the blocking condition (return the node, free capacity, fix the storage network).

If a job is truly stuck, Microsoft support guidance covers suspend/resume of the repair.

Raise WarningThreshold / CriticalThreshold for very large capacity nodes where multi-hour resyncs are expected.

### Support scope

Storage Spaces Direct pool, virtual disk, physical disk, cache, repair or Health Service evidence. Degraded resiliency and predictive drive faults deserve action before data becomes unavailable.

Element: HyperVPrivateCloud.Capability.S2D.StorageJob.Stalled.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: S2D!Microsoft.Windows.Server.10.0.Storage.StorageSpacesDirect.StorageSubSystem. Parent health aspect: Health!System.Health.PerformanceState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: Property[@Name=&#39;StorageJobMaxElapsedMinutes&#39;] &lt; 240

Warning [Warning]: (Property[@Name=&#39;StorageJobMaxElapsedMinutes&#39;] &gt;= 240 AND Property[@Name=&#39;StorageJobMaxElapsedMinutes&#39;] &lt; 720)

Error [Critical]: Property[@Name=&#39;StorageJobMaxElapsedMinutes&#39;] &gt;= 720

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: ComputerName=$Target/Host/Property[Type=&quot;Windows!Microsoft.Windows.Computer&quot;]/PrincipalName$; CriticalThreshold=720; IntervalSeconds=300; PropertyName=StorageJobMaxElapsedMinutes; SyncTime=; TimeoutSeconds=120; WarningThreshold=240 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Warning; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Inspect Get-StoragePool, Get-VirtualDisk, Get-PhysicalDisk and Get-StorageJob, recording both HealthStatus and OperationalStatus. Run Get-StorageSubSystem Cluster* &#124; Debug-StorageSubSystem and retain the fault identifier, severity, reason, recommendation and physical location. Compare repair progress over time.

### Corrective action and escalation

Follow the specific storage fault recommendation after confirming remaining resiliency and the correct physical device. Coordinate replacement, repair or expansion with the storage owner. Do not reset disks, remove pool members, change read-only flags or delete virtual disks as generic troubleshooting.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm the fault disappears from native Health Service, repair progresses or completes, intended redundancy returns and free pool capacity remains adequate.

### Microsoft references

[Microsoft Learn: health service faults](https://learn.microsoft.com/en-us/windows-server/failover-clustering/health-service-faults)

[Microsoft Learn: storage spaces states](https://learn.microsoft.com/en-us/windows-server/storage/storage-spaces/storage-spaces-states)

[Microsoft Learn: troubleshooting storage spaces](https://learn.microsoft.com/en-us/windows-server/storage/storage-spaces/troubleshooting-storage-spaces)


## Storage subsystem health {#hypervprivatecloud.capability.s2d.subsystem.health.monitor}

`HyperVPrivateCloud.Capability.S2D.SubSystem.Health.Monitor`

Raises an error when the count of non-healthy clustered storage subsystems reaches CriticalThreshold (default 1). WarningThreshold defaults to 1 and both are overridable.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.Fabric.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.Fabric.Service.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Service.Storage.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.S2D.StorageSubSystem.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.S2D.SubSystem.Health.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

The clustered storage subsystem (Clustered Windows Storage) reports a non-healthy HealthStatus. This is the top-level S2D health roll-up produced by the Health Service and summarises all active health faults.

### Causes

Any active S2D health fault: drives, volumes, pool capacity, storage network, firmware or configuration.

Health Service resource offline in the cluster.

### Resolutions

Get-StorageSubSystem *Cluster* &#124; Get-StorageHealthReport and Get-StorageSubSystem *Cluster* &#124; Debug-StorageSubSystem list every active fault with a recommended action.

Address the leaf faults (see the S2D Faults view and the specific S2D monitors) and confirm the subsystem returns to Healthy.

Verify the Health cluster resource is online (Get-ClusterResource Health).

Keep CriticalThreshold at 1.

### Support scope

Storage Spaces Direct pool, virtual disk, physical disk, cache, repair or Health Service evidence. Degraded resiliency and predictive drive faults deserve action before data becomes unavailable.

Element: HyperVPrivateCloud.Capability.S2D.SubSystem.Health.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: S2D!Microsoft.Windows.Server.10.0.Storage.StorageSpacesDirect.StorageSubSystem. Parent health aspect: Health!System.Health.AvailabilityState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: Property[@Name=&#39;SubSystemUnhealthyCount&#39;] &lt; 1

Warning [Warning]: (Property[@Name=&#39;SubSystemUnhealthyCount&#39;] &gt;= 1 AND Property[@Name=&#39;SubSystemUnhealthyCount&#39;] &lt; 1)

Error [Critical]: Property[@Name=&#39;SubSystemUnhealthyCount&#39;] &gt;= 1

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

Warning and critical thresholds are equal: this configuration has no intermediate numeric warning band. This can be intentional for discrete outages; do not claim an early warning is provided by this monitor.

### Sampling and effective policy

Compiled configuration: ComputerName=$Target/Host/Property[Type=&quot;Windows!Microsoft.Windows.Computer&quot;]/PrincipalName$; CriticalThreshold=1; IntervalSeconds=300; PropertyName=SubSystemUnhealthyCount; SyncTime=; TimeoutSeconds=120; WarningThreshold=1 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Warning; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Inspect Get-StoragePool, Get-VirtualDisk, Get-PhysicalDisk and Get-StorageJob, recording both HealthStatus and OperationalStatus. Run Get-StorageSubSystem Cluster* &#124; Debug-StorageSubSystem and retain the fault identifier, severity, reason, recommendation and physical location. Compare repair progress over time.

### Corrective action and escalation

Follow the specific storage fault recommendation after confirming remaining resiliency and the correct physical device. Coordinate replacement, repair or expansion with the storage owner. Do not reset disks, remove pool members, change read-only flags or delete virtual disks as generic troubleshooting.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm the fault disappears from native Health Service, repair progresses or completes, intended redundancy returns and free pool capacity remains adequate.

### Microsoft references

[Microsoft Learn: health service faults](https://learn.microsoft.com/en-us/windows-server/failover-clustering/health-service-faults)

[Microsoft Learn: storage spaces states](https://learn.microsoft.com/en-us/windows-server/storage/storage-spaces/storage-spaces-states)

[Microsoft Learn: troubleshooting storage spaces](https://learn.microsoft.com/en-us/windows-server/storage/storage-spaces/troubleshooting-storage-spaces)


## Roll up S2D storage subsystems health {#hypervprivatecloud.capability.s2d.storagesubsystem.dependency.monitor}

`HyperVPrivateCloud.Capability.S2D.StorageSubSystem.Dependency.Monitor`

Rolls the health of S2D storage subsystems into the private cloud Storage component.

### Support scope

Storage Spaces Direct pool, virtual disk, physical disk, cache, repair or Health Service evidence. Degraded resiliency and predictive drive faults deserve action before data becomes unavailable.

Element: HyperVPrivateCloud.Capability.S2D.StorageSubSystem.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.StorageComponent; relationship=HyperVPrivateCloud.Capability.S2D.StorageContainsStorageSubSystem; member monitor=Health!System.Health.AvailabilityState; parent=Health!System.Health.AvailabilityState; algorithm=WorstOf; unavailable-member policy=Success. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Inspect Get-StoragePool, Get-VirtualDisk, Get-PhysicalDisk and Get-StorageJob, recording both HealthStatus and OperationalStatus. Run Get-StorageSubSystem Cluster* &#124; Debug-StorageSubSystem and retain the fault identifier, severity, reason, recommendation and physical location. Compare repair progress over time.

### Corrective action and escalation

Follow the specific storage fault recommendation after confirming remaining resiliency and the correct physical device. Coordinate replacement, repair or expansion with the storage owner. Do not reset disks, remove pool members, change read-only flags or delete virtual disks as generic troubleshooting.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm the fault disappears from native Health Service, repair progresses or completes, intended redundancy returns and free pool capacity remains adequate.

### Microsoft references

[Microsoft Learn: health service faults](https://learn.microsoft.com/en-us/windows-server/failover-clustering/health-service-faults)

[Microsoft Learn: storage spaces states](https://learn.microsoft.com/en-us/windows-server/storage/storage-spaces/storage-spaces-states)

[Microsoft Learn: troubleshooting storage spaces](https://learn.microsoft.com/en-us/windows-server/storage/storage-spaces/troubleshooting-storage-spaces)


## Roll up S2D storage nodes health {#hypervprivatecloud.capability.s2d.storagenode.dependency.monitor}

`HyperVPrivateCloud.Capability.S2D.StorageNode.Dependency.Monitor`

Rolls the health of S2D storage nodes into the private cloud Storage component.

### Support scope

Storage Spaces Direct pool, virtual disk, physical disk, cache, repair or Health Service evidence. Degraded resiliency and predictive drive faults deserve action before data becomes unavailable.

Element: HyperVPrivateCloud.Capability.S2D.StorageNode.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.StorageComponent; relationship=HyperVPrivateCloud.Capability.S2D.StorageContainsStorageNode; member monitor=Health!System.Health.AvailabilityState; parent=Health!System.Health.AvailabilityState; algorithm=WorstOf; unavailable-member policy=Success. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Inspect Get-StoragePool, Get-VirtualDisk, Get-PhysicalDisk and Get-StorageJob, recording both HealthStatus and OperationalStatus. Run Get-StorageSubSystem Cluster* &#124; Debug-StorageSubSystem and retain the fault identifier, severity, reason, recommendation and physical location. Compare repair progress over time.

### Corrective action and escalation

Follow the specific storage fault recommendation after confirming remaining resiliency and the correct physical device. Coordinate replacement, repair or expansion with the storage owner. Do not reset disks, remove pool members, change read-only flags or delete virtual disks as generic troubleshooting.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm the fault disappears from native Health Service, repair progresses or completes, intended redundancy returns and free pool capacity remains adequate.

### Microsoft references

[Microsoft Learn: health service faults](https://learn.microsoft.com/en-us/windows-server/failover-clustering/health-service-faults)

[Microsoft Learn: storage spaces states](https://learn.microsoft.com/en-us/windows-server/storage/storage-spaces/storage-spaces-states)

[Microsoft Learn: troubleshooting storage spaces](https://learn.microsoft.com/en-us/windows-server/storage/storage-spaces/troubleshooting-storage-spaces)


## Roll up S2D physical disks health {#hypervprivatecloud.capability.s2d.physicaldisk.dependency.monitor}

`HyperVPrivateCloud.Capability.S2D.PhysicalDisk.Dependency.Monitor`

Rolls the health of S2D physical disks into the private cloud Storage component.

### Support scope

Storage Spaces Direct pool, virtual disk, physical disk, cache, repair or Health Service evidence. Degraded resiliency and predictive drive faults deserve action before data becomes unavailable.

Element: HyperVPrivateCloud.Capability.S2D.PhysicalDisk.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.StorageComponent; relationship=HyperVPrivateCloud.Capability.S2D.StorageContainsPhysicalDisk; member monitor=Health!System.Health.AvailabilityState; parent=Health!System.Health.AvailabilityState; algorithm=WorstOf; unavailable-member policy=Success. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Inspect Get-StoragePool, Get-VirtualDisk, Get-PhysicalDisk and Get-StorageJob, recording both HealthStatus and OperationalStatus. Run Get-StorageSubSystem Cluster* &#124; Debug-StorageSubSystem and retain the fault identifier, severity, reason, recommendation and physical location. Compare repair progress over time.

### Corrective action and escalation

Follow the specific storage fault recommendation after confirming remaining resiliency and the correct physical device. Coordinate replacement, repair or expansion with the storage owner. Do not reset disks, remove pool members, change read-only flags or delete virtual disks as generic troubleshooting.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm the fault disappears from native Health Service, repair progresses or completes, intended redundancy returns and free pool capacity remains adequate.

### Microsoft references

[Microsoft Learn: health service faults](https://learn.microsoft.com/en-us/windows-server/failover-clustering/health-service-faults)

[Microsoft Learn: storage spaces states](https://learn.microsoft.com/en-us/windows-server/storage/storage-spaces/storage-spaces-states)

[Microsoft Learn: troubleshooting storage spaces](https://learn.microsoft.com/en-us/windows-server/storage/storage-spaces/troubleshooting-storage-spaces)


## Roll up S2D storage pools health {#hypervprivatecloud.capability.s2d.storagepool.dependency.monitor}

`HyperVPrivateCloud.Capability.S2D.StoragePool.Dependency.Monitor`

Rolls the health of S2D storage pools into the private cloud Storage component.

### Support scope

Storage Spaces Direct pool, virtual disk, physical disk, cache, repair or Health Service evidence. Degraded resiliency and predictive drive faults deserve action before data becomes unavailable.

Element: HyperVPrivateCloud.Capability.S2D.StoragePool.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.StorageComponent; relationship=HyperVPrivateCloud.Capability.S2D.StorageContainsStoragePool; member monitor=Health!System.Health.AvailabilityState; parent=Health!System.Health.AvailabilityState; algorithm=WorstOf; unavailable-member policy=Success. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Inspect Get-StoragePool, Get-VirtualDisk, Get-PhysicalDisk and Get-StorageJob, recording both HealthStatus and OperationalStatus. Run Get-StorageSubSystem Cluster* &#124; Debug-StorageSubSystem and retain the fault identifier, severity, reason, recommendation and physical location. Compare repair progress over time.

### Corrective action and escalation

Follow the specific storage fault recommendation after confirming remaining resiliency and the correct physical device. Coordinate replacement, repair or expansion with the storage owner. Do not reset disks, remove pool members, change read-only flags or delete virtual disks as generic troubleshooting.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm the fault disappears from native Health Service, repair progresses or completes, intended redundancy returns and free pool capacity remains adequate.

### Microsoft references

[Microsoft Learn: health service faults](https://learn.microsoft.com/en-us/windows-server/failover-clustering/health-service-faults)

[Microsoft Learn: storage spaces states](https://learn.microsoft.com/en-us/windows-server/storage/storage-spaces/storage-spaces-states)

[Microsoft Learn: troubleshooting storage spaces](https://learn.microsoft.com/en-us/windows-server/storage/storage-spaces/troubleshooting-storage-spaces)


## Roll up S2D virtual disks health {#hypervprivatecloud.capability.s2d.virtualdisk.dependency.monitor}

`HyperVPrivateCloud.Capability.S2D.VirtualDisk.Dependency.Monitor`

Rolls the health of S2D virtual disks into the private cloud Storage component.

### Support scope

Storage Spaces Direct pool, virtual disk, physical disk, cache, repair or Health Service evidence. Degraded resiliency and predictive drive faults deserve action before data becomes unavailable.

Element: HyperVPrivateCloud.Capability.S2D.VirtualDisk.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.StorageComponent; relationship=HyperVPrivateCloud.Capability.S2D.StorageContainsVirtualDisk; member monitor=Health!System.Health.AvailabilityState; parent=Health!System.Health.AvailabilityState; algorithm=WorstOf; unavailable-member policy=Success. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Inspect Get-StoragePool, Get-VirtualDisk, Get-PhysicalDisk and Get-StorageJob, recording both HealthStatus and OperationalStatus. Run Get-StorageSubSystem Cluster* &#124; Debug-StorageSubSystem and retain the fault identifier, severity, reason, recommendation and physical location. Compare repair progress over time.

### Corrective action and escalation

Follow the specific storage fault recommendation after confirming remaining resiliency and the correct physical device. Coordinate replacement, repair or expansion with the storage owner. Do not reset disks, remove pool members, change read-only flags or delete virtual disks as generic troubleshooting.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm the fault disappears from native Health Service, repair progresses or completes, intended redundancy returns and free pool capacity remains adequate.

### Microsoft references

[Microsoft Learn: health service faults](https://learn.microsoft.com/en-us/windows-server/failover-clustering/health-service-faults)

[Microsoft Learn: storage spaces states](https://learn.microsoft.com/en-us/windows-server/storage/storage-spaces/storage-spaces-states)

[Microsoft Learn: troubleshooting storage spaces](https://learn.microsoft.com/en-us/windows-server/storage/storage-spaces/troubleshooting-storage-spaces)


## Roll up S2D volumes health {#hypervprivatecloud.capability.s2d.volume.dependency.monitor}

`HyperVPrivateCloud.Capability.S2D.Volume.Dependency.Monitor`

Rolls the health of S2D volumes into the private cloud Storage component.

### Support scope

Storage Spaces Direct pool, virtual disk, physical disk, cache, repair or Health Service evidence. Degraded resiliency and predictive drive faults deserve action before data becomes unavailable.

Element: HyperVPrivateCloud.Capability.S2D.Volume.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.StorageComponent; relationship=HyperVPrivateCloud.Capability.S2D.StorageContainsVolume; member monitor=Health!System.Health.AvailabilityState; parent=Health!System.Health.AvailabilityState; algorithm=WorstOf; unavailable-member policy=Success. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Inspect Get-StoragePool, Get-VirtualDisk, Get-PhysicalDisk and Get-StorageJob, recording both HealthStatus and OperationalStatus. Run Get-StorageSubSystem Cluster* &#124; Debug-StorageSubSystem and retain the fault identifier, severity, reason, recommendation and physical location. Compare repair progress over time.

### Corrective action and escalation

Follow the specific storage fault recommendation after confirming remaining resiliency and the correct physical device. Coordinate replacement, repair or expansion with the storage owner. Do not reset disks, remove pool members, change read-only flags or delete virtual disks as generic troubleshooting.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm the fault disappears from native Health Service, repair progresses or completes, intended redundancy returns and free pool capacity remains adequate.

### Microsoft references

[Microsoft Learn: health service faults](https://learn.microsoft.com/en-us/windows-server/failover-clustering/health-service-faults)

[Microsoft Learn: storage spaces states](https://learn.microsoft.com/en-us/windows-server/storage/storage-spaces/storage-spaces-states)

[Microsoft Learn: troubleshooting storage spaces](https://learn.microsoft.com/en-us/windows-server/storage/storage-spaces/troubleshooting-storage-spaces)


## Roll up S2D file shares health {#hypervprivatecloud.capability.s2d.fileshare.dependency.monitor}

`HyperVPrivateCloud.Capability.S2D.FileShare.Dependency.Monitor`

Rolls the health of S2D file shares into the private cloud Storage component.

### Support scope

Storage Spaces Direct pool, virtual disk, physical disk, cache, repair or Health Service evidence. Degraded resiliency and predictive drive faults deserve action before data becomes unavailable.

Element: HyperVPrivateCloud.Capability.S2D.FileShare.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.StorageComponent; relationship=HyperVPrivateCloud.Capability.S2D.StorageContainsFileShare; member monitor=Health!System.Health.AvailabilityState; parent=Health!System.Health.AvailabilityState; algorithm=WorstOf; unavailable-member policy=Success. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Inspect Get-StoragePool, Get-VirtualDisk, Get-PhysicalDisk and Get-StorageJob, recording both HealthStatus and OperationalStatus. Run Get-StorageSubSystem Cluster* &#124; Debug-StorageSubSystem and retain the fault identifier, severity, reason, recommendation and physical location. Compare repair progress over time.

### Corrective action and escalation

Follow the specific storage fault recommendation after confirming remaining resiliency and the correct physical device. Coordinate replacement, repair or expansion with the storage owner. Do not reset disks, remove pool members, change read-only flags or delete virtual disks as generic troubleshooting.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm the fault disappears from native Health Service, repair progresses or completes, intended redundancy returns and free pool capacity remains adequate.

### Microsoft references

[Microsoft Learn: health service faults](https://learn.microsoft.com/en-us/windows-server/failover-clustering/health-service-faults)

[Microsoft Learn: storage spaces states](https://learn.microsoft.com/en-us/windows-server/storage/storage-spaces/storage-spaces-states)

[Microsoft Learn: troubleshooting storage spaces](https://learn.microsoft.com/en-us/windows-server/storage/storage-spaces/troubleshooting-storage-spaces)


## Roll up Performance through S2D.StorageContainsStorageSubSystem {#hypervprivatecloud.capability.s2d.storagesubsystem.performance.dependency.monitor}

`HyperVPrivateCloud.Capability.S2D.StorageSubSystem.Performance.Dependency.Monitor`

Preserves the originating health aspect through this domain dependency. Open the unhealthy member monitor for the actual cause; this rollup does not create a second incident.

### Support scope

Storage Spaces Direct pool, virtual disk, physical disk, cache, repair or Health Service evidence. Degraded resiliency and predictive drive faults deserve action before data becomes unavailable.

Element: HyperVPrivateCloud.Capability.S2D.StorageSubSystem.Performance.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.StorageComponent; relationship=HyperVPrivateCloud.Capability.S2D.StorageContainsStorageSubSystem; member monitor=Health!System.Health.PerformanceState; parent=Health!System.Health.PerformanceState; algorithm=WorstOf; unavailable-member policy=Success. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Inspect Get-StoragePool, Get-VirtualDisk, Get-PhysicalDisk and Get-StorageJob, recording both HealthStatus and OperationalStatus. Run Get-StorageSubSystem Cluster* &#124; Debug-StorageSubSystem and retain the fault identifier, severity, reason, recommendation and physical location. Compare repair progress over time.

### Corrective action and escalation

Follow the specific storage fault recommendation after confirming remaining resiliency and the correct physical device. Coordinate replacement, repair or expansion with the storage owner. Do not reset disks, remove pool members, change read-only flags or delete virtual disks as generic troubleshooting.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm the fault disappears from native Health Service, repair progresses or completes, intended redundancy returns and free pool capacity remains adequate.

### Microsoft references

[Microsoft Learn: health service faults](https://learn.microsoft.com/en-us/windows-server/failover-clustering/health-service-faults)

[Microsoft Learn: storage spaces states](https://learn.microsoft.com/en-us/windows-server/storage/storage-spaces/storage-spaces-states)

[Microsoft Learn: troubleshooting storage spaces](https://learn.microsoft.com/en-us/windows-server/storage/storage-spaces/troubleshooting-storage-spaces)


## Roll up Configuration through S2D.StorageContainsStorageSubSystem {#hypervprivatecloud.capability.s2d.storagesubsystem.configuration.dependency.monitor}

`HyperVPrivateCloud.Capability.S2D.StorageSubSystem.Configuration.Dependency.Monitor`

Preserves the originating health aspect through this domain dependency. Open the unhealthy member monitor for the actual cause; this rollup does not create a second incident.

### Support scope

Storage Spaces Direct pool, virtual disk, physical disk, cache, repair or Health Service evidence. Degraded resiliency and predictive drive faults deserve action before data becomes unavailable.

Element: HyperVPrivateCloud.Capability.S2D.StorageSubSystem.Configuration.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.StorageComponent; relationship=HyperVPrivateCloud.Capability.S2D.StorageContainsStorageSubSystem; member monitor=Health!System.Health.ConfigurationState; parent=Health!System.Health.ConfigurationState; algorithm=WorstOf; unavailable-member policy=Success. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Inspect Get-StoragePool, Get-VirtualDisk, Get-PhysicalDisk and Get-StorageJob, recording both HealthStatus and OperationalStatus. Run Get-StorageSubSystem Cluster* &#124; Debug-StorageSubSystem and retain the fault identifier, severity, reason, recommendation and physical location. Compare repair progress over time.

### Corrective action and escalation

Follow the specific storage fault recommendation after confirming remaining resiliency and the correct physical device. Coordinate replacement, repair or expansion with the storage owner. Do not reset disks, remove pool members, change read-only flags or delete virtual disks as generic troubleshooting.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm the fault disappears from native Health Service, repair progresses or completes, intended redundancy returns and free pool capacity remains adequate.

### Microsoft references

[Microsoft Learn: health service faults](https://learn.microsoft.com/en-us/windows-server/failover-clustering/health-service-faults)

[Microsoft Learn: storage spaces states](https://learn.microsoft.com/en-us/windows-server/storage/storage-spaces/storage-spaces-states)

[Microsoft Learn: troubleshooting storage spaces](https://learn.microsoft.com/en-us/windows-server/storage/storage-spaces/troubleshooting-storage-spaces)
