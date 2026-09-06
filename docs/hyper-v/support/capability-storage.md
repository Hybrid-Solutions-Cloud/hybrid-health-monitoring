# Hyper-V Private Cloud Monitoring - SAN and Storage Integration

Generated support reference. [All capabilities](catalog.md) · [Day-2 triage](index.md).

Default conditions below come from the compiled candidate source, not the effective overrides in your management group. Read the monitor-specific knowledge together with the common safety and verification guidance. Microsoft links explain the underlying technology; product thresholds are not Microsoft recommendations.

## Hyper-V Host SAN Storage Participation {#hypervprivatecloud.capability.storage.hostparticipation}

`HyperVPrivateCloud.Capability.Storage.HostParticipation`

Host participation in SAN/storage monitoring. It gates host-side storage workflows and helps distinguish unsupported or absent storage providers from failing storage.

### Support scope

Host-visible SAN LUNs, host attachments, iSCSI sessions, Fibre Channel ports and VM disk mappings. Host paths and array-side volume health are distinct sources.

Element: HyperVPrivateCloud.Capability.Storage.HostParticipation. Kind: ClassType.

### Identity and monitoring ownership

Base class=Windows!Microsoft.Windows.LocalApplication; hosted=true; singleton=false; declared properties=ParticipationId, MpioDiskCount, IscsiSessionCount, FibreChannelPortCount. Inherited properties also apply. Inspect the exact instance and its monitoring path; inventory-only classes do not acquire health merely by appearing in a diagram.

### Read-only investigation

Match stable disk/LUN and initiator identifiers before comparing Get-Disk, Get-IscsiSession, Get-IscsiConnection and MPIO path reports. For FC, retain HBA port identity and vendor driver counters. Correlate host System storage errors with switch zoning, masking and array events. Separate loss of one redundant path from complete I/O loss.

### Corrective action and escalation

Restore the identified fabric path or approved MPIO configuration with the storage and network teams. Use compatible HBA/NIC/array firmware guidance. Capacity remediation needs array and filesystem planning. Do not initialize, format, offline or reset a shared disk, or remove active sessions, as generic remediation.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm expected path count, stable sessions and LUN identity, normal I/O and recovered redundancy. Compare counter deltas after repair; historical cumulative counters may not reset.

### What this object represents

Host participation in SAN/storage monitoring. It gates host-side storage workflows and helps distinguish unsupported or absent storage providers from failing storage.

### Microsoft references

[Microsoft Learn: iscsi storage connectivity troubleshooting](https://learn.microsoft.com/en-us/troubleshoot/windows-server/backup-and-storage/iscsi-storage-connectivity-troubleshooting)

[Microsoft Learn: troubleshoot data corruption and disk errors](https://learn.microsoft.com/en-us/troubleshoot/windows-server/backup-and-storage/troubleshoot-data-corruption-and-disk-errors)


## Storage Logical Unit {#hypervprivatecloud.capability.storage.logicalunit}

`HyperVPrivateCloud.Capability.Storage.LogicalUnit`

Host-visible logical storage unit with stable storage identity. Correlate the LUN with array volume, host attachment and VM consumers; do not equate a host-view LUN with an independently monitored physical drive.

### Support scope

Host-visible SAN LUNs, host attachments, iSCSI sessions, Fibre Channel ports and VM disk mappings. Host paths and array-side volume health are distinct sources.

Element: HyperVPrivateCloud.Capability.Storage.LogicalUnit. Kind: ClassType.

### Identity and monitoring ownership

Base class=System!System.LogicalEntity; hosted=false; singleton=false; declared properties=BoundaryId, StorageId, FriendlyName, SerialNumber, UniqueId, BusType, SizeBytes. Inherited properties also apply. Inspect the exact instance and its monitoring path; inventory-only classes do not acquire health merely by appearing in a diagram.

### Read-only investigation

Match stable disk/LUN and initiator identifiers before comparing Get-Disk, Get-IscsiSession, Get-IscsiConnection and MPIO path reports. For FC, retain HBA port identity and vendor driver counters. Correlate host System storage errors with switch zoning, masking and array events. Separate loss of one redundant path from complete I/O loss.

### Corrective action and escalation

Restore the identified fabric path or approved MPIO configuration with the storage and network teams. Use compatible HBA/NIC/array firmware guidance. Capacity remediation needs array and filesystem planning. Do not initialize, format, offline or reset a shared disk, or remove active sessions, as generic remediation.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm expected path count, stable sessions and LUN identity, normal I/O and recovered redundancy. Compare counter deltas after repair; historical cumulative counters may not reset.

### What this object represents

Host-visible logical storage unit with stable storage identity. Correlate the LUN with array volume, host attachment and VM consumers; do not equate a host-view LUN with an independently monitored physical drive.

### Microsoft references

[Microsoft Learn: iscsi storage connectivity troubleshooting](https://learn.microsoft.com/en-us/troubleshoot/windows-server/backup-and-storage/iscsi-storage-connectivity-troubleshooting)

[Microsoft Learn: troubleshoot data corruption and disk errors](https://learn.microsoft.com/en-us/troubleshoot/windows-server/backup-and-storage/troubleshoot-data-corruption-and-disk-errors)


## Storage Host Attachment {#hypervprivatecloud.capability.storage.hostattachment}

`HyperVPrivateCloud.Capability.Storage.HostAttachment`

A host attachment to a logical unit, including the host-side path and redundancy context. One host can lose a path while the same LUN remains accessible elsewhere.

### Support scope

Host-visible SAN LUNs, host attachments, iSCSI sessions, Fibre Channel ports and VM disk mappings. Host paths and array-side volume health are distinct sources.

Element: HyperVPrivateCloud.Capability.Storage.HostAttachment. Kind: ClassType.

### Identity and monitoring ownership

Base class=Windows!Microsoft.Windows.LocalApplication; hosted=true; singleton=false; declared properties=AttachmentId, BoundaryId, StorageId, DiskNumber, BusType, PathCount, DsmName, HealthStatus, OperationalStatus, IsOffline, IsReadOnly. Inherited properties also apply. Inspect the exact instance and its monitoring path; inventory-only classes do not acquire health merely by appearing in a diagram.

### Read-only investigation

Match stable disk/LUN and initiator identifiers before comparing Get-Disk, Get-IscsiSession, Get-IscsiConnection and MPIO path reports. For FC, retain HBA port identity and vendor driver counters. Correlate host System storage errors with switch zoning, masking and array events. Separate loss of one redundant path from complete I/O loss.

### Corrective action and escalation

Restore the identified fabric path or approved MPIO configuration with the storage and network teams. Use compatible HBA/NIC/array firmware guidance. Capacity remediation needs array and filesystem planning. Do not initialize, format, offline or reset a shared disk, or remove active sessions, as generic remediation.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm expected path count, stable sessions and LUN identity, normal I/O and recovered redundancy. Compare counter deltas after repair; historical cumulative counters may not reset.

### What this object represents

A host attachment to a logical unit, including the host-side path and redundancy context. One host can lose a path while the same LUN remains accessible elsewhere.

### Microsoft references

[Microsoft Learn: iscsi storage connectivity troubleshooting](https://learn.microsoft.com/en-us/troubleshoot/windows-server/backup-and-storage/iscsi-storage-connectivity-troubleshooting)

[Microsoft Learn: troubleshoot data corruption and disk errors](https://learn.microsoft.com/en-us/troubleshoot/windows-server/backup-and-storage/troubleshoot-data-corruption-and-disk-errors)


## Storage Iscsi Session {#hypervprivatecloud.capability.storage.iscsisession}

`HyperVPrivateCloud.Capability.Storage.IscsiSession`

Host initiator session to an iSCSI target. Preserve session/target identity when evaluating connectivity, authentication and connection counts; avoid disrupting healthy peer sessions.

### Support scope

Host-visible SAN LUNs, host attachments, iSCSI sessions, Fibre Channel ports and VM disk mappings. Host paths and array-side volume health are distinct sources.

Element: HyperVPrivateCloud.Capability.Storage.IscsiSession. Kind: ClassType.

### Identity and monitoring ownership

Base class=Windows!Microsoft.Windows.LocalApplication; hosted=true; singleton=false; declared properties=SessionId, InitiatorNodeAddress, TargetNodeAddress, Connections, IsPersistent. Inherited properties also apply. Inspect the exact instance and its monitoring path; inventory-only classes do not acquire health merely by appearing in a diagram.

### Read-only investigation

Match stable disk/LUN and initiator identifiers before comparing Get-Disk, Get-IscsiSession, Get-IscsiConnection and MPIO path reports. For FC, retain HBA port identity and vendor driver counters. Correlate host System storage errors with switch zoning, masking and array events. Separate loss of one redundant path from complete I/O loss.

### Corrective action and escalation

Restore the identified fabric path or approved MPIO configuration with the storage and network teams. Use compatible HBA/NIC/array firmware guidance. Capacity remediation needs array and filesystem planning. Do not initialize, format, offline or reset a shared disk, or remove active sessions, as generic remediation.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm expected path count, stable sessions and LUN identity, normal I/O and recovered redundancy. Compare counter deltas after repair; historical cumulative counters may not reset.

### What this object represents

Host initiator session to an iSCSI target. Preserve session/target identity when evaluating connectivity, authentication and connection counts; avoid disrupting healthy peer sessions.

### Microsoft references

[Microsoft Learn: iscsi storage connectivity troubleshooting](https://learn.microsoft.com/en-us/troubleshoot/windows-server/backup-and-storage/iscsi-storage-connectivity-troubleshooting)

[Microsoft Learn: troubleshoot data corruption and disk errors](https://learn.microsoft.com/en-us/troubleshoot/windows-server/backup-and-storage/troubleshoot-data-corruption-and-disk-errors)


## Storage Fibre Channel Port {#hypervprivatecloud.capability.storage.fibrechannelport}

`HyperVPrivateCloud.Capability.Storage.FibreChannelPort`

Host HBA Fibre Channel port identity and supported provider observations. Correlate link/login/errors with the exact switch and array port before changing zoning or hardware.

### Support scope

Host-visible SAN LUNs, host attachments, iSCSI sessions, Fibre Channel ports and VM disk mappings. Host paths and array-side volume health are distinct sources.

Element: HyperVPrivateCloud.Capability.Storage.FibreChannelPort. Kind: ClassType.

### Identity and monitoring ownership

Base class=Windows!Microsoft.Windows.LocalApplication; hosted=true; singleton=false; declared properties=PortId, InstanceName, WWPN, WWNN, PortState, PortSpeed, HbaStatus. Inherited properties also apply. Inspect the exact instance and its monitoring path; inventory-only classes do not acquire health merely by appearing in a diagram.

### Read-only investigation

Match stable disk/LUN and initiator identifiers before comparing Get-Disk, Get-IscsiSession, Get-IscsiConnection and MPIO path reports. For FC, retain HBA port identity and vendor driver counters. Correlate host System storage errors with switch zoning, masking and array events. Separate loss of one redundant path from complete I/O loss.

### Corrective action and escalation

Restore the identified fabric path or approved MPIO configuration with the storage and network teams. Use compatible HBA/NIC/array firmware guidance. Capacity remediation needs array and filesystem planning. Do not initialize, format, offline or reset a shared disk, or remove active sessions, as generic remediation.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm expected path count, stable sessions and LUN identity, normal I/O and recovered redundancy. Compare counter deltas after repair; historical cumulative counters may not reset.

### What this object represents

Host HBA Fibre Channel port identity and supported provider observations. Correlate link/login/errors with the exact switch and array port before changing zoning or hardware.

### Microsoft references

[Microsoft Learn: iscsi storage connectivity troubleshooting](https://learn.microsoft.com/en-us/troubleshoot/windows-server/backup-and-storage/iscsi-storage-connectivity-troubleshooting)

[Microsoft Learn: troubleshoot data corruption and disk errors](https://learn.microsoft.com/en-us/troubleshoot/windows-server/backup-and-storage/troubleshoot-data-corruption-and-disk-errors)


## Storage Virtual Disk Mapping {#hypervprivatecloud.capability.storage.virtualdiskmapping}

`HyperVPrivateCloud.Capability.Storage.VirtualDiskMapping`

Inventory relationship connecting a VM disk to host-visible storage. It enables impact tracing; health must come from the relevant runtime, attachment/LUN or vendor monitor.

### Support scope

Host-visible SAN LUNs, host attachments, iSCSI sessions, Fibre Channel ports and VM disk mappings. Host paths and array-side volume health are distinct sources.

Element: HyperVPrivateCloud.Capability.Storage.VirtualDiskMapping. Kind: ClassType.

### Identity and monitoring ownership

Base class=System!System.LogicalEntity; hosted=false; singleton=false; declared properties=BoundaryId, MappingId, VMId, DiskId, VhdPath, StorageId, VolumeId. Inherited properties also apply. Inspect the exact instance and its monitoring path; inventory-only classes do not acquire health merely by appearing in a diagram.

### Read-only investigation

Match stable disk/LUN and initiator identifiers before comparing Get-Disk, Get-IscsiSession, Get-IscsiConnection and MPIO path reports. For FC, retain HBA port identity and vendor driver counters. Correlate host System storage errors with switch zoning, masking and array events. Separate loss of one redundant path from complete I/O loss.

### Corrective action and escalation

Restore the identified fabric path or approved MPIO configuration with the storage and network teams. Use compatible HBA/NIC/array firmware guidance. Capacity remediation needs array and filesystem planning. Do not initialize, format, offline or reset a shared disk, or remove active sessions, as generic remediation.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm expected path count, stable sessions and LUN identity, normal I/O and recovered redundancy. Compare counter deltas after repair; historical cumulative counters may not reset.

### What this object represents

Inventory relationship connecting a VM disk to host-visible storage. It enables impact tracing; health must come from the relevant runtime, attachment/LUN or vendor monitor.

### Microsoft references

[Microsoft Learn: iscsi storage connectivity troubleshooting](https://learn.microsoft.com/en-us/troubleshoot/windows-server/backup-and-storage/iscsi-storage-connectivity-troubleshooting)

[Microsoft Learn: troubleshoot data corruption and disk errors](https://learn.microsoft.com/en-us/troubleshoot/windows-server/backup-and-storage/troubleshoot-data-corruption-and-disk-errors)


## Collect physical disk reads per second {#hypervprivatecloud.capability.storage.physicaldiskreadspersec.collection.rule}

`HyperVPrivateCloud.Capability.Storage.PhysicalDiskReadsPerSec.Collection.Rule`

Collects PhysicalDisk\Disk Reads/sec for every disk instance on the host every 300 seconds.

### Support scope

Host-visible SAN LUNs, host attachments, iSCSI sessions, Fibre Channel ports and VM disk mappings. Host paths and array-side volume health are distinct sources.

Element: HyperVPrivateCloud.Capability.Storage.PhysicalDiskReadsPerSec.Collection.Rule. Kind: Rule.

### Alert versus health

Target=HCSV2Library!HyperVPrivateCloud.HostRole; enabled=true; category=PerformanceCollection. Rules collect data or raise event alerts; they do not themselves create unit-monitor health transitions. Repeated or unresolved rule alerts do not by themselves explain a red DA. Correlate with current leaf monitors and event timestamps before closure.

### Read-only investigation

Match stable disk/LUN and initiator identifiers before comparing Get-Disk, Get-IscsiSession, Get-IscsiConnection and MPIO path reports. For FC, retain HBA port identity and vendor driver counters. Correlate host System storage errors with switch zoning, masking and array events. Separate loss of one redundant path from complete I/O loss.

### Corrective action and escalation

Restore the identified fabric path or approved MPIO configuration with the storage and network teams. Use compatible HBA/NIC/array firmware guidance. Capacity remediation needs array and filesystem planning. Do not initialize, format, offline or reset a shared disk, or remove active sessions, as generic remediation.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm expected path count, stable sessions and LUN identity, normal I/O and recovered redundancy. Compare counter deltas after repair; historical cumulative counters may not reset.

### Microsoft references

[Microsoft Learn: iscsi storage connectivity troubleshooting](https://learn.microsoft.com/en-us/troubleshoot/windows-server/backup-and-storage/iscsi-storage-connectivity-troubleshooting)

[Microsoft Learn: troubleshoot data corruption and disk errors](https://learn.microsoft.com/en-us/troubleshoot/windows-server/backup-and-storage/troubleshoot-data-corruption-and-disk-errors)


## Collect physical disk writes per second {#hypervprivatecloud.capability.storage.physicaldiskwritespersec.collection.rule}

`HyperVPrivateCloud.Capability.Storage.PhysicalDiskWritesPerSec.Collection.Rule`

Collects PhysicalDisk\Disk Writes/sec for every disk instance on the host every 300 seconds.

### Support scope

Host-visible SAN LUNs, host attachments, iSCSI sessions, Fibre Channel ports and VM disk mappings. Host paths and array-side volume health are distinct sources.

Element: HyperVPrivateCloud.Capability.Storage.PhysicalDiskWritesPerSec.Collection.Rule. Kind: Rule.

### Alert versus health

Target=HCSV2Library!HyperVPrivateCloud.HostRole; enabled=true; category=PerformanceCollection. Rules collect data or raise event alerts; they do not themselves create unit-monitor health transitions. Repeated or unresolved rule alerts do not by themselves explain a red DA. Correlate with current leaf monitors and event timestamps before closure.

### Read-only investigation

Match stable disk/LUN and initiator identifiers before comparing Get-Disk, Get-IscsiSession, Get-IscsiConnection and MPIO path reports. For FC, retain HBA port identity and vendor driver counters. Correlate host System storage errors with switch zoning, masking and array events. Separate loss of one redundant path from complete I/O loss.

### Corrective action and escalation

Restore the identified fabric path or approved MPIO configuration with the storage and network teams. Use compatible HBA/NIC/array firmware guidance. Capacity remediation needs array and filesystem planning. Do not initialize, format, offline or reset a shared disk, or remove active sessions, as generic remediation.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm expected path count, stable sessions and LUN identity, normal I/O and recovered redundancy. Compare counter deltas after repair; historical cumulative counters may not reset.

### Microsoft references

[Microsoft Learn: iscsi storage connectivity troubleshooting](https://learn.microsoft.com/en-us/troubleshoot/windows-server/backup-and-storage/iscsi-storage-connectivity-troubleshooting)

[Microsoft Learn: troubleshoot data corruption and disk errors](https://learn.microsoft.com/en-us/troubleshoot/windows-server/backup-and-storage/troubleshoot-data-corruption-and-disk-errors)


## Collect physical disk throughput {#hypervprivatecloud.capability.storage.physicaldiskbytespersec.collection.rule}

`HyperVPrivateCloud.Capability.Storage.PhysicalDiskBytesPerSec.Collection.Rule`

Collects PhysicalDisk\Disk Bytes/sec for every disk instance on the host every 300 seconds.

### Support scope

Host-visible SAN LUNs, host attachments, iSCSI sessions, Fibre Channel ports and VM disk mappings. Host paths and array-side volume health are distinct sources.

Element: HyperVPrivateCloud.Capability.Storage.PhysicalDiskBytesPerSec.Collection.Rule. Kind: Rule.

### Alert versus health

Target=HCSV2Library!HyperVPrivateCloud.HostRole; enabled=true; category=PerformanceCollection. Rules collect data or raise event alerts; they do not themselves create unit-monitor health transitions. Repeated or unresolved rule alerts do not by themselves explain a red DA. Correlate with current leaf monitors and event timestamps before closure.

### Read-only investigation

Match stable disk/LUN and initiator identifiers before comparing Get-Disk, Get-IscsiSession, Get-IscsiConnection and MPIO path reports. For FC, retain HBA port identity and vendor driver counters. Correlate host System storage errors with switch zoning, masking and array events. Separate loss of one redundant path from complete I/O loss.

### Corrective action and escalation

Restore the identified fabric path or approved MPIO configuration with the storage and network teams. Use compatible HBA/NIC/array firmware guidance. Capacity remediation needs array and filesystem planning. Do not initialize, format, offline or reset a shared disk, or remove active sessions, as generic remediation.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm expected path count, stable sessions and LUN identity, normal I/O and recovered redundancy. Compare counter deltas after repair; historical cumulative counters may not reset.

### Microsoft references

[Microsoft Learn: iscsi storage connectivity troubleshooting](https://learn.microsoft.com/en-us/troubleshoot/windows-server/backup-and-storage/iscsi-storage-connectivity-troubleshooting)

[Microsoft Learn: troubleshoot data corruption and disk errors](https://learn.microsoft.com/en-us/troubleshoot/windows-server/backup-and-storage/troubleshoot-data-corruption-and-disk-errors)


## Collect physical disk current queue length {#hypervprivatecloud.capability.storage.physicaldiskcurrentqueuelength.collection.rule}

`HyperVPrivateCloud.Capability.Storage.PhysicalDiskCurrentQueueLength.Collection.Rule`

Collects PhysicalDisk\Current Disk Queue Length for every disk instance on the host every 300 seconds.

### Support scope

Host-visible SAN LUNs, host attachments, iSCSI sessions, Fibre Channel ports and VM disk mappings. Host paths and array-side volume health are distinct sources.

Element: HyperVPrivateCloud.Capability.Storage.PhysicalDiskCurrentQueueLength.Collection.Rule. Kind: Rule.

### Alert versus health

Target=HCSV2Library!HyperVPrivateCloud.HostRole; enabled=true; category=PerformanceCollection. Rules collect data or raise event alerts; they do not themselves create unit-monitor health transitions. Repeated or unresolved rule alerts do not by themselves explain a red DA. Correlate with current leaf monitors and event timestamps before closure.

### Read-only investigation

Match stable disk/LUN and initiator identifiers before comparing Get-Disk, Get-IscsiSession, Get-IscsiConnection and MPIO path reports. For FC, retain HBA port identity and vendor driver counters. Correlate host System storage errors with switch zoning, masking and array events. Separate loss of one redundant path from complete I/O loss.

### Corrective action and escalation

Restore the identified fabric path or approved MPIO configuration with the storage and network teams. Use compatible HBA/NIC/array firmware guidance. Capacity remediation needs array and filesystem planning. Do not initialize, format, offline or reset a shared disk, or remove active sessions, as generic remediation.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm expected path count, stable sessions and LUN identity, normal I/O and recovered redundancy. Compare counter deltas after repair; historical cumulative counters may not reset.

### Microsoft references

[Microsoft Learn: iscsi storage connectivity troubleshooting](https://learn.microsoft.com/en-us/troubleshoot/windows-server/backup-and-storage/iscsi-storage-connectivity-troubleshooting)

[Microsoft Learn: troubleshoot data corruption and disk errors](https://learn.microsoft.com/en-us/troubleshoot/windows-server/backup-and-storage/troubleshoot-data-corruption-and-disk-errors)


## Collect physical disk percent idle time {#hypervprivatecloud.capability.storage.physicaldiskidletime.collection.rule}

`HyperVPrivateCloud.Capability.Storage.PhysicalDiskIdleTime.Collection.Rule`

Collects PhysicalDisk\% Idle Time for every disk instance on the host every 300 seconds.

### Support scope

Host-visible SAN LUNs, host attachments, iSCSI sessions, Fibre Channel ports and VM disk mappings. Host paths and array-side volume health are distinct sources.

Element: HyperVPrivateCloud.Capability.Storage.PhysicalDiskIdleTime.Collection.Rule. Kind: Rule.

### Alert versus health

Target=HCSV2Library!HyperVPrivateCloud.HostRole; enabled=true; category=PerformanceCollection. Rules collect data or raise event alerts; they do not themselves create unit-monitor health transitions. Repeated or unresolved rule alerts do not by themselves explain a red DA. Correlate with current leaf monitors and event timestamps before closure.

### Read-only investigation

Match stable disk/LUN and initiator identifiers before comparing Get-Disk, Get-IscsiSession, Get-IscsiConnection and MPIO path reports. For FC, retain HBA port identity and vendor driver counters. Correlate host System storage errors with switch zoning, masking and array events. Separate loss of one redundant path from complete I/O loss.

### Corrective action and escalation

Restore the identified fabric path or approved MPIO configuration with the storage and network teams. Use compatible HBA/NIC/array firmware guidance. Capacity remediation needs array and filesystem planning. Do not initialize, format, offline or reset a shared disk, or remove active sessions, as generic remediation.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm expected path count, stable sessions and LUN identity, normal I/O and recovered redundancy. Compare counter deltas after repair; historical cumulative counters may not reset.

### Microsoft references

[Microsoft Learn: iscsi storage connectivity troubleshooting](https://learn.microsoft.com/en-us/troubleshoot/windows-server/backup-and-storage/iscsi-storage-connectivity-troubleshooting)

[Microsoft Learn: troubleshoot data corruption and disk errors](https://learn.microsoft.com/en-us/troubleshoot/windows-server/backup-and-storage/troubleshoot-data-corruption-and-disk-errors)


## Collect physical disk split IO per second {#hypervprivatecloud.capability.storage.physicaldisksplitiopersec.collection.rule}

`HyperVPrivateCloud.Capability.Storage.PhysicalDiskSplitIoPerSec.Collection.Rule`

Collects PhysicalDisk\Split IO/Sec for every disk instance on the host. Disabled by default.

### Support scope

Host-visible SAN LUNs, host attachments, iSCSI sessions, Fibre Channel ports and VM disk mappings. Host paths and array-side volume health are distinct sources.

Element: HyperVPrivateCloud.Capability.Storage.PhysicalDiskSplitIoPerSec.Collection.Rule. Kind: Rule.

### Alert versus health

Target=HCSV2Library!HyperVPrivateCloud.HostRole; enabled=false; category=PerformanceCollection. Rules collect data or raise event alerts; they do not themselves create unit-monitor health transitions. Repeated or unresolved rule alerts do not by themselves explain a red DA. Correlate with current leaf monitors and event timestamps before closure.

### Read-only investigation

Match stable disk/LUN and initiator identifiers before comparing Get-Disk, Get-IscsiSession, Get-IscsiConnection and MPIO path reports. For FC, retain HBA port identity and vendor driver counters. Correlate host System storage errors with switch zoning, masking and array events. Separate loss of one redundant path from complete I/O loss.

### Corrective action and escalation

Restore the identified fabric path or approved MPIO configuration with the storage and network teams. Use compatible HBA/NIC/array firmware guidance. Capacity remediation needs array and filesystem planning. Do not initialize, format, offline or reset a shared disk, or remove active sessions, as generic remediation.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm expected path count, stable sessions and LUN identity, normal I/O and recovered redundancy. Compare counter deltas after repair; historical cumulative counters may not reset.

### Microsoft references

[Microsoft Learn: iscsi storage connectivity troubleshooting](https://learn.microsoft.com/en-us/troubleshoot/windows-server/backup-and-storage/iscsi-storage-connectivity-troubleshooting)

[Microsoft Learn: troubleshoot data corruption and disk errors](https://learn.microsoft.com/en-us/troubleshoot/windows-server/backup-and-storage/troubleshoot-data-corruption-and-disk-errors)


## Collect physical disk average bytes per transfer {#hypervprivatecloud.capability.storage.physicaldiskavgbytespertransfer.collection.rule}

`HyperVPrivateCloud.Capability.Storage.PhysicalDiskAvgBytesPerTransfer.Collection.Rule`

Collects PhysicalDisk\Avg. Disk Bytes/Transfer for every disk instance on the host. Disabled by default.

### Support scope

Host-visible SAN LUNs, host attachments, iSCSI sessions, Fibre Channel ports and VM disk mappings. Host paths and array-side volume health are distinct sources.

Element: HyperVPrivateCloud.Capability.Storage.PhysicalDiskAvgBytesPerTransfer.Collection.Rule. Kind: Rule.

### Alert versus health

Target=HCSV2Library!HyperVPrivateCloud.HostRole; enabled=false; category=PerformanceCollection. Rules collect data or raise event alerts; they do not themselves create unit-monitor health transitions. Repeated or unresolved rule alerts do not by themselves explain a red DA. Correlate with current leaf monitors and event timestamps before closure.

### Read-only investigation

Match stable disk/LUN and initiator identifiers before comparing Get-Disk, Get-IscsiSession, Get-IscsiConnection and MPIO path reports. For FC, retain HBA port identity and vendor driver counters. Correlate host System storage errors with switch zoning, masking and array events. Separate loss of one redundant path from complete I/O loss.

### Corrective action and escalation

Restore the identified fabric path or approved MPIO configuration with the storage and network teams. Use compatible HBA/NIC/array firmware guidance. Capacity remediation needs array and filesystem planning. Do not initialize, format, offline or reset a shared disk, or remove active sessions, as generic remediation.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm expected path count, stable sessions and LUN identity, normal I/O and recovered redundancy. Compare counter deltas after repair; historical cumulative counters may not reset.

### Microsoft references

[Microsoft Learn: iscsi storage connectivity troubleshooting](https://learn.microsoft.com/en-us/troubleshoot/windows-server/backup-and-storage/iscsi-storage-connectivity-troubleshooting)

[Microsoft Learn: troubleshoot data corruption and disk errors](https://learn.microsoft.com/en-us/troubleshoot/windows-server/backup-and-storage/troubleshoot-data-corruption-and-disk-errors)


## Show MPIO path report {#hypervprivatecloud.capability.storage.multipathreport.task}

`HyperVPrivateCloud.Capability.Storage.MultipathReport.Task`

mpclaim -s -d, DSM defaults and claim rules, MPIO settings and per-disk path counts.

### Summary

Show MPIO path report

### What it runs

mpclaim -s -d, DSM defaults and claim rules, MPIO settings and per-disk path counts.

### Impact

Read-only. The task runs the query on the agent and returns text; it changes nothing.

### Support scope

Host-visible SAN LUNs, host attachments, iSCSI sessions, Fibre Channel ports and VM disk mappings. Host paths and array-side volume health are distinct sources.

Element: HyperVPrivateCloud.Capability.Storage.MultipathReport.Task. Kind: Task.

### Execution safety

Target=HCSV2Library!HyperVPrivateCloud.HostRole; enabled=true; timeout=180. Read the task&#39;s original knowledge and parameters before execution. A Remediation task changes state and requires approval; do not execute it solely because the object is red. Even a diagnostic can generate logs or files; review its documented impact.

### Read-only investigation

Match stable disk/LUN and initiator identifiers before comparing Get-Disk, Get-IscsiSession, Get-IscsiConnection and MPIO path reports. For FC, retain HBA port identity and vendor driver counters. Correlate host System storage errors with switch zoning, masking and array events. Separate loss of one redundant path from complete I/O loss.

### Corrective action and escalation

Restore the identified fabric path or approved MPIO configuration with the storage and network teams. Use compatible HBA/NIC/array firmware guidance. Capacity remediation needs array and filesystem planning. Do not initialize, format, offline or reset a shared disk, or remove active sessions, as generic remediation.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm expected path count, stable sessions and LUN identity, normal I/O and recovered redundancy. Compare counter deltas after repair; historical cumulative counters may not reset.

### Microsoft references

[Microsoft Learn: iscsi storage connectivity troubleshooting](https://learn.microsoft.com/en-us/troubleshoot/windows-server/backup-and-storage/iscsi-storage-connectivity-troubleshooting)

[Microsoft Learn: troubleshoot data corruption and disk errors](https://learn.microsoft.com/en-us/troubleshoot/windows-server/backup-and-storage/troubleshoot-data-corruption-and-disk-errors)


## Show iSCSI initiator report {#hypervprivatecloud.capability.storage.iscsireport.task}

`HyperVPrivateCloud.Capability.Storage.IscsiReport.Task`

Initiator service, target portals, targets, sessions, connections and recent iScsiPrt errors.

### Summary

Show iSCSI initiator report

### What it runs

Initiator service, target portals, targets, sessions, connections and recent iScsiPrt errors.

### Impact

Read-only. The task runs the query on the agent and returns text; it changes nothing.

### Support scope

Host-visible SAN LUNs, host attachments, iSCSI sessions, Fibre Channel ports and VM disk mappings. Host paths and array-side volume health are distinct sources.

Element: HyperVPrivateCloud.Capability.Storage.IscsiReport.Task. Kind: Task.

### Execution safety

Target=HCSV2Library!HyperVPrivateCloud.HostRole; enabled=true; timeout=180. Read the task&#39;s original knowledge and parameters before execution. A Remediation task changes state and requires approval; do not execute it solely because the object is red. Even a diagnostic can generate logs or files; review its documented impact.

### Read-only investigation

Match stable disk/LUN and initiator identifiers before comparing Get-Disk, Get-IscsiSession, Get-IscsiConnection and MPIO path reports. For FC, retain HBA port identity and vendor driver counters. Correlate host System storage errors with switch zoning, masking and array events. Separate loss of one redundant path from complete I/O loss.

### Corrective action and escalation

Restore the identified fabric path or approved MPIO configuration with the storage and network teams. Use compatible HBA/NIC/array firmware guidance. Capacity remediation needs array and filesystem planning. Do not initialize, format, offline or reset a shared disk, or remove active sessions, as generic remediation.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm expected path count, stable sessions and LUN identity, normal I/O and recovered redundancy. Compare counter deltas after repair; historical cumulative counters may not reset.

### Microsoft references

[Microsoft Learn: iscsi storage connectivity troubleshooting](https://learn.microsoft.com/en-us/troubleshoot/windows-server/backup-and-storage/iscsi-storage-connectivity-troubleshooting)

[Microsoft Learn: troubleshoot data corruption and disk errors](https://learn.microsoft.com/en-us/troubleshoot/windows-server/backup-and-storage/troubleshoot-data-corruption-and-disk-errors)


## Show Fibre Channel port report {#hypervprivatecloud.capability.storage.fibrechannelreport.task}

`HyperVPrivateCloud.Capability.Storage.FibreChannelReport.Task`

Initiator ports, HBA port attributes and statistics, adapter driver and firmware versions.

### Summary

Show Fibre Channel port report

### What it runs

Initiator ports, HBA port attributes and statistics, adapter driver and firmware versions.

### Impact

Read-only. The task runs the query on the agent and returns text; it changes nothing.

### Support scope

Host-visible SAN LUNs, host attachments, iSCSI sessions, Fibre Channel ports and VM disk mappings. Host paths and array-side volume health are distinct sources.

Element: HyperVPrivateCloud.Capability.Storage.FibreChannelReport.Task. Kind: Task.

### Execution safety

Target=HCSV2Library!HyperVPrivateCloud.HostRole; enabled=true; timeout=180. Read the task&#39;s original knowledge and parameters before execution. A Remediation task changes state and requires approval; do not execute it solely because the object is red. Even a diagnostic can generate logs or files; review its documented impact.

### Read-only investigation

Match stable disk/LUN and initiator identifiers before comparing Get-Disk, Get-IscsiSession, Get-IscsiConnection and MPIO path reports. For FC, retain HBA port identity and vendor driver counters. Correlate host System storage errors with switch zoning, masking and array events. Separate loss of one redundant path from complete I/O loss.

### Corrective action and escalation

Restore the identified fabric path or approved MPIO configuration with the storage and network teams. Use compatible HBA/NIC/array firmware guidance. Capacity remediation needs array and filesystem planning. Do not initialize, format, offline or reset a shared disk, or remove active sessions, as generic remediation.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm expected path count, stable sessions and LUN identity, normal I/O and recovered redundancy. Compare counter deltas after repair; historical cumulative counters may not reset.

### Microsoft references

[Microsoft Learn: iscsi storage connectivity troubleshooting](https://learn.microsoft.com/en-us/troubleshoot/windows-server/backup-and-storage/iscsi-storage-connectivity-troubleshooting)

[Microsoft Learn: troubleshoot data corruption and disk errors](https://learn.microsoft.com/en-us/troubleshoot/windows-server/backup-and-storage/troubleshoot-data-corruption-and-disk-errors)


## Show SAN disks and latency {#hypervprivatecloud.capability.storage.logicalunitreport.task}

`HyperVPrivateCloud.Capability.Storage.LogicalUnitReport.Task`

SAN-attached disks with state, health and size plus current physical disk latency and queue counters.

### Summary

Show SAN disks and latency

### What it runs

SAN-attached disks with state, health and size plus current physical disk latency and queue counters.

### Impact

Read-only. The task runs the query on the agent and returns text; it changes nothing.

### Support scope

Host-visible SAN LUNs, host attachments, iSCSI sessions, Fibre Channel ports and VM disk mappings. Host paths and array-side volume health are distinct sources.

Element: HyperVPrivateCloud.Capability.Storage.LogicalUnitReport.Task. Kind: Task.

### Execution safety

Target=HCSV2Library!HyperVPrivateCloud.HostRole; enabled=true; timeout=180. Read the task&#39;s original knowledge and parameters before execution. A Remediation task changes state and requires approval; do not execute it solely because the object is red. Even a diagnostic can generate logs or files; review its documented impact.

### Read-only investigation

Match stable disk/LUN and initiator identifiers before comparing Get-Disk, Get-IscsiSession, Get-IscsiConnection and MPIO path reports. For FC, retain HBA port identity and vendor driver counters. Correlate host System storage errors with switch zoning, masking and array events. Separate loss of one redundant path from complete I/O loss.

### Corrective action and escalation

Restore the identified fabric path or approved MPIO configuration with the storage and network teams. Use compatible HBA/NIC/array firmware guidance. Capacity remediation needs array and filesystem planning. Do not initialize, format, offline or reset a shared disk, or remove active sessions, as generic remediation.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm expected path count, stable sessions and LUN identity, normal I/O and recovered redundancy. Compare counter deltas after repair; historical cumulative counters may not reset.

### Microsoft references

[Microsoft Learn: iscsi storage connectivity troubleshooting](https://learn.microsoft.com/en-us/troubleshoot/windows-server/backup-and-storage/iscsi-storage-connectivity-troubleshooting)

[Microsoft Learn: troubleshoot data corruption and disk errors](https://learn.microsoft.com/en-us/troubleshoot/windows-server/backup-and-storage/troubleshoot-data-corruption-and-disk-errors)


## Remediation: Rescan storage {#hypervprivatecloud.capability.storage.rescanstorage.task}

`HyperVPrivateCloud.Capability.Storage.RescanStorage.Task`

Update-HostStorageCache so newly presented LUNs and path changes are picked up.

### Summary

Rescan storage

### What it runs

Update-HostStorageCache so newly presented LUNs and path changes are picked up.

### Impact

This task changes the state of the target. The console asks for confirmation before it runs; use the read-only tasks first to confirm the diagnosis, and run it inside a change window where the environment requires one. The task output reports the resulting state.

### Support scope

Host-visible SAN LUNs, host attachments, iSCSI sessions, Fibre Channel ports and VM disk mappings. Host paths and array-side volume health are distinct sources.

Element: HyperVPrivateCloud.Capability.Storage.RescanStorage.Task. Kind: Task.

### Execution safety

Target=HCSV2Library!HyperVPrivateCloud.HostRole; enabled=true; timeout=300. Read the task&#39;s original knowledge and parameters before execution. A Remediation task changes state and requires approval; do not execute it solely because the object is red. Even a diagnostic can generate logs or files; review its documented impact.

### Read-only investigation

Match stable disk/LUN and initiator identifiers before comparing Get-Disk, Get-IscsiSession, Get-IscsiConnection and MPIO path reports. For FC, retain HBA port identity and vendor driver counters. Correlate host System storage errors with switch zoning, masking and array events. Separate loss of one redundant path from complete I/O loss.

### Corrective action and escalation

Restore the identified fabric path or approved MPIO configuration with the storage and network teams. Use compatible HBA/NIC/array firmware guidance. Capacity remediation needs array and filesystem planning. Do not initialize, format, offline or reset a shared disk, or remove active sessions, as generic remediation.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm expected path count, stable sessions and LUN identity, normal I/O and recovered redundancy. Compare counter deltas after repair; historical cumulative counters may not reset.

### Microsoft references

[Microsoft Learn: iscsi storage connectivity troubleshooting](https://learn.microsoft.com/en-us/troubleshoot/windows-server/backup-and-storage/iscsi-storage-connectivity-troubleshooting)

[Microsoft Learn: troubleshoot data corruption and disk errors](https://learn.microsoft.com/en-us/troubleshoot/windows-server/backup-and-storage/troubleshoot-data-corruption-and-disk-errors)


## Remediation: Reconnect an iSCSI target {#hypervprivatecloud.capability.storage.reconnectiscsitarget.task}

`HyperVPrivateCloud.Capability.Storage.ReconnectIscsiTarget.Task`

Connect-IscsiTarget -IsPersistent -IsMultipathEnabled. Parameter = target IQN.

### Summary

Reconnect an iSCSI target

### What it runs

Connect-IscsiTarget -IsPersistent -IsMultipathEnabled. Parameter = target IQN.

### Impact

This task changes the state of the target. The console asks for confirmation before it runs; use the read-only tasks first to confirm the diagnosis, and run it inside a change window where the environment requires one. The task output reports the resulting state.

### Support scope

Host-visible SAN LUNs, host attachments, iSCSI sessions, Fibre Channel ports and VM disk mappings. Host paths and array-side volume health are distinct sources.

Element: HyperVPrivateCloud.Capability.Storage.ReconnectIscsiTarget.Task. Kind: Task.

### Execution safety

Target=HCSV2Library!HyperVPrivateCloud.HostRole; enabled=true; timeout=300. Read the task&#39;s original knowledge and parameters before execution. A Remediation task changes state and requires approval; do not execute it solely because the object is red. Even a diagnostic can generate logs or files; review its documented impact.

### Read-only investigation

Match stable disk/LUN and initiator identifiers before comparing Get-Disk, Get-IscsiSession, Get-IscsiConnection and MPIO path reports. For FC, retain HBA port identity and vendor driver counters. Correlate host System storage errors with switch zoning, masking and array events. Separate loss of one redundant path from complete I/O loss.

### Corrective action and escalation

Restore the identified fabric path or approved MPIO configuration with the storage and network teams. Use compatible HBA/NIC/array firmware guidance. Capacity remediation needs array and filesystem planning. Do not initialize, format, offline or reset a shared disk, or remove active sessions, as generic remediation.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm expected path count, stable sessions and LUN identity, normal I/O and recovered redundancy. Compare counter deltas after repair; historical cumulative counters may not reset.

### Microsoft references

[Microsoft Learn: iscsi storage connectivity troubleshooting](https://learn.microsoft.com/en-us/troubleshoot/windows-server/backup-and-storage/iscsi-storage-connectivity-troubleshooting)

[Microsoft Learn: troubleshoot data corruption and disk errors](https://learn.microsoft.com/en-us/troubleshoot/windows-server/backup-and-storage/troubleshoot-data-corruption-and-disk-errors)


## Fibre Channel port link state {#hypervprivatecloud.capability.storage.fibrechannelportlinkstate.monitor}

`HyperVPrivateCloud.Capability.Storage.FibreChannelPortLinkState.Monitor`

Tracks HBA operational status and the Fibre Channel port link state reported by MSFC_FibrePortHBAAttributes.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.Fabric.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.Fabric.Service.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Service.Storage.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.Storage.FibreChannelPort.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.Storage.FibreChannelPortLinkState.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

Tracks HBA operational status and the Fibre Channel port link state reported by MSFC_FibrePortHBAAttributes.

### Operator response

Check the HBA port, cable, SFP, and fabric switch port. Confirm the port is enabled and the fabric is reachable.

### Support scope

Host-visible SAN LUNs, host attachments, iSCSI sessions, Fibre Channel ports and VM disk mappings. Host paths and array-side volume health are distinct sources.

Element: HyperVPrivateCloud.Capability.Storage.FibreChannelPortLinkState.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HyperVPrivateCloud.Capability.Storage.FibreChannelPort. Parent health aspect: Health!System.Health.AvailabilityState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: (Property[@Name=&#39;InstanceKey&#39;] = $Target/Property[Type=&quot;HyperVPrivateCloud.Capability.Storage.FibreChannelPort&quot;]/PortId$ AND (Property[@Name=&#39;LinkState&#39;] = Good OR Property[@Name=&#39;LinkState&#39;] = NotApplicable))

Warning [Warning]: (Property[@Name=&#39;InstanceKey&#39;] = $Target/Property[Type=&quot;HyperVPrivateCloud.Capability.Storage.FibreChannelPort&quot;]/PortId$ AND Property[@Name=&#39;LinkState&#39;] = Warning)

Error [Critical]: (Property[@Name=&#39;InstanceKey&#39;] = $Target/Property[Type=&quot;HyperVPrivateCloud.Capability.Storage.FibreChannelPort&quot;]/PortId$ AND Property[@Name=&#39;LinkState&#39;] = Critical)

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: CapacityUsedCriticalPercent=90; CapacityUsedWarningPercent=80; ComputerName=$Target/Host/Property[Type=&quot;Windows!Microsoft.Windows.Computer&quot;]/PrincipalName$; CrcErrorRatePerHourCritical=25; CrcErrorRatePerHourWarning=5; CriticalPathCount=1; InstanceKey=$Target/Property[Type=&quot;HyperVPrivateCloud.Capability.Storage.FibreChannelPort&quot;]/PortId$; IntervalSeconds=300; LinkFailureRatePerHourCritical=5; LinkFailureRatePerHourWarning=1; LossOfSignalRatePerHourCritical=5; LossOfSignalRatePerHourWarning=1; LossOfSyncRatePerHourCritical=5; LossOfSyncRatePerHourWarning=1; MinimumLinkSpeedGbps=8; MinimumPathCount=2; MinimumSessionsPerTarget=2; PathImbalancePercentCritical=70; PathImbalancePercentWarning=40; PropertyName=LinkState; QueueDepthCritical=64; QueueDepthWarning=32; ReadLatencyCriticalMs=50; ReadLatencyWarningMs=20; SyncTime=; TimeoutSeconds=180; WriteLatencyCriticalMs=50; WriteLatencyWarningMs=20 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Error; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Match stable disk/LUN and initiator identifiers before comparing Get-Disk, Get-IscsiSession, Get-IscsiConnection and MPIO path reports. For FC, retain HBA port identity and vendor driver counters. Correlate host System storage errors with switch zoning, masking and array events. Separate loss of one redundant path from complete I/O loss.

### Corrective action and escalation

Restore the identified fabric path or approved MPIO configuration with the storage and network teams. Use compatible HBA/NIC/array firmware guidance. Capacity remediation needs array and filesystem planning. Do not initialize, format, offline or reset a shared disk, or remove active sessions, as generic remediation.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm expected path count, stable sessions and LUN identity, normal I/O and recovered redundancy. Compare counter deltas after repair; historical cumulative counters may not reset.

### Microsoft references

[Microsoft Learn: iscsi storage connectivity troubleshooting](https://learn.microsoft.com/en-us/troubleshoot/windows-server/backup-and-storage/iscsi-storage-connectivity-troubleshooting)

[Microsoft Learn: troubleshoot data corruption and disk errors](https://learn.microsoft.com/en-us/troubleshoot/windows-server/backup-and-storage/troubleshoot-data-corruption-and-disk-errors)


## Fibre Channel port link speed {#hypervprivatecloud.capability.storage.fibrechannelportlinkspeed.monitor}

`HyperVPrivateCloud.Capability.Storage.FibreChannelPortLinkSpeed.Monitor`

Detects a port negotiating below the required minimum link speed. The MinimumLinkSpeedGbps override defaults to 8 Gbps and is capped by the adapter maximum.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.Fabric.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.Fabric.Service.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Service.Storage.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.Storage.FibreChannelPort.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.Storage.FibreChannelPortLinkSpeed.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

Detects a port negotiating below the required minimum link speed. The MinimumLinkSpeedGbps override defaults to 8 Gbps and is capped by the adapter maximum.

### Operator response

Confirm the negotiated speed matches the fabric switch port and SFP capability. Investigate auto-negotiation and cabling if the link trained below the expected rate.

### Support scope

Host-visible SAN LUNs, host attachments, iSCSI sessions, Fibre Channel ports and VM disk mappings. Host paths and array-side volume health are distinct sources.

Element: HyperVPrivateCloud.Capability.Storage.FibreChannelPortLinkSpeed.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HyperVPrivateCloud.Capability.Storage.FibreChannelPort. Parent health aspect: Health!System.Health.PerformanceState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: (Property[@Name=&#39;InstanceKey&#39;] = $Target/Property[Type=&quot;HyperVPrivateCloud.Capability.Storage.FibreChannelPort&quot;]/PortId$ AND (Property[@Name=&#39;LinkSpeedState&#39;] = Good OR Property[@Name=&#39;LinkSpeedState&#39;] = NotApplicable))

Warning [Warning]: (Property[@Name=&#39;InstanceKey&#39;] = $Target/Property[Type=&quot;HyperVPrivateCloud.Capability.Storage.FibreChannelPort&quot;]/PortId$ AND Property[@Name=&#39;LinkSpeedState&#39;] = Warning)

Error [Critical]: (Property[@Name=&#39;InstanceKey&#39;] = $Target/Property[Type=&quot;HyperVPrivateCloud.Capability.Storage.FibreChannelPort&quot;]/PortId$ AND Property[@Name=&#39;LinkSpeedState&#39;] = Critical)

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: CapacityUsedCriticalPercent=90; CapacityUsedWarningPercent=80; ComputerName=$Target/Host/Property[Type=&quot;Windows!Microsoft.Windows.Computer&quot;]/PrincipalName$; CrcErrorRatePerHourCritical=25; CrcErrorRatePerHourWarning=5; CriticalPathCount=1; InstanceKey=$Target/Property[Type=&quot;HyperVPrivateCloud.Capability.Storage.FibreChannelPort&quot;]/PortId$; IntervalSeconds=300; LinkFailureRatePerHourCritical=5; LinkFailureRatePerHourWarning=1; LossOfSignalRatePerHourCritical=5; LossOfSignalRatePerHourWarning=1; LossOfSyncRatePerHourCritical=5; LossOfSyncRatePerHourWarning=1; MinimumLinkSpeedGbps=8; MinimumPathCount=2; MinimumSessionsPerTarget=2; PathImbalancePercentCritical=70; PathImbalancePercentWarning=40; PropertyName=LinkSpeedState; QueueDepthCritical=64; QueueDepthWarning=32; ReadLatencyCriticalMs=50; ReadLatencyWarningMs=20; SyncTime=; TimeoutSeconds=180; WriteLatencyCriticalMs=50; WriteLatencyWarningMs=20 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Warning; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Match stable disk/LUN and initiator identifiers before comparing Get-Disk, Get-IscsiSession, Get-IscsiConnection and MPIO path reports. For FC, retain HBA port identity and vendor driver counters. Correlate host System storage errors with switch zoning, masking and array events. Separate loss of one redundant path from complete I/O loss.

### Corrective action and escalation

Restore the identified fabric path or approved MPIO configuration with the storage and network teams. Use compatible HBA/NIC/array firmware guidance. Capacity remediation needs array and filesystem planning. Do not initialize, format, offline or reset a shared disk, or remove active sessions, as generic remediation.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm expected path count, stable sessions and LUN identity, normal I/O and recovered redundancy. Compare counter deltas after repair; historical cumulative counters may not reset.

### Microsoft references

[Microsoft Learn: iscsi storage connectivity troubleshooting](https://learn.microsoft.com/en-us/troubleshoot/windows-server/backup-and-storage/iscsi-storage-connectivity-troubleshooting)

[Microsoft Learn: troubleshoot data corruption and disk errors](https://learn.microsoft.com/en-us/troubleshoot/windows-server/backup-and-storage/troubleshoot-data-corruption-and-disk-errors)


## Fibre Channel link failure rate {#hypervprivatecloud.capability.storage.fibrechannelportlinkfailurerate.monitor}

`HyperVPrivateCloud.Capability.Storage.FibreChannelPortLinkFailureRate.Monitor`

Tracks growth of the HBA link failure counter per hour. LinkFailureRatePerHourWarning defaults to 1 and LinkFailureRatePerHourCritical defaults to 5.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.Fabric.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.Fabric.Service.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Service.Storage.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.Storage.FibreChannelPort.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.Storage.FibreChannelPortLinkFailureRate.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

Tracks growth of the HBA link failure counter per hour. LinkFailureRatePerHourWarning defaults to 1 and LinkFailureRatePerHourCritical defaults to 5.

### Operator response

Investigate cabling, SFP health, and fabric switch port errors. A sustained link-failure rate usually indicates a failing optic or cable.

### Support scope

Host-visible SAN LUNs, host attachments, iSCSI sessions, Fibre Channel ports and VM disk mappings. Host paths and array-side volume health are distinct sources.

Element: HyperVPrivateCloud.Capability.Storage.FibreChannelPortLinkFailureRate.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HyperVPrivateCloud.Capability.Storage.FibreChannelPort. Parent health aspect: Health!System.Health.PerformanceState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: (Property[@Name=&#39;InstanceKey&#39;] = $Target/Property[Type=&quot;HyperVPrivateCloud.Capability.Storage.FibreChannelPort&quot;]/PortId$ AND (Property[@Name=&#39;LinkFailureState&#39;] = Good OR Property[@Name=&#39;LinkFailureState&#39;] = NotApplicable))

Warning [Warning]: (Property[@Name=&#39;InstanceKey&#39;] = $Target/Property[Type=&quot;HyperVPrivateCloud.Capability.Storage.FibreChannelPort&quot;]/PortId$ AND Property[@Name=&#39;LinkFailureState&#39;] = Warning)

Error [Critical]: (Property[@Name=&#39;InstanceKey&#39;] = $Target/Property[Type=&quot;HyperVPrivateCloud.Capability.Storage.FibreChannelPort&quot;]/PortId$ AND Property[@Name=&#39;LinkFailureState&#39;] = Critical)

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: CapacityUsedCriticalPercent=90; CapacityUsedWarningPercent=80; ComputerName=$Target/Host/Property[Type=&quot;Windows!Microsoft.Windows.Computer&quot;]/PrincipalName$; CrcErrorRatePerHourCritical=25; CrcErrorRatePerHourWarning=5; CriticalPathCount=1; InstanceKey=$Target/Property[Type=&quot;HyperVPrivateCloud.Capability.Storage.FibreChannelPort&quot;]/PortId$; IntervalSeconds=300; LinkFailureRatePerHourCritical=5; LinkFailureRatePerHourWarning=1; LossOfSignalRatePerHourCritical=5; LossOfSignalRatePerHourWarning=1; LossOfSyncRatePerHourCritical=5; LossOfSyncRatePerHourWarning=1; MinimumLinkSpeedGbps=8; MinimumPathCount=2; MinimumSessionsPerTarget=2; PathImbalancePercentCritical=70; PathImbalancePercentWarning=40; PropertyName=LinkFailureState; QueueDepthCritical=64; QueueDepthWarning=32; ReadLatencyCriticalMs=50; ReadLatencyWarningMs=20; SyncTime=; TimeoutSeconds=180; WriteLatencyCriticalMs=50; WriteLatencyWarningMs=20 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Warning; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Match stable disk/LUN and initiator identifiers before comparing Get-Disk, Get-IscsiSession, Get-IscsiConnection and MPIO path reports. For FC, retain HBA port identity and vendor driver counters. Correlate host System storage errors with switch zoning, masking and array events. Separate loss of one redundant path from complete I/O loss.

### Corrective action and escalation

Restore the identified fabric path or approved MPIO configuration with the storage and network teams. Use compatible HBA/NIC/array firmware guidance. Capacity remediation needs array and filesystem planning. Do not initialize, format, offline or reset a shared disk, or remove active sessions, as generic remediation.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm expected path count, stable sessions and LUN identity, normal I/O and recovered redundancy. Compare counter deltas after repair; historical cumulative counters may not reset.

### Microsoft references

[Microsoft Learn: iscsi storage connectivity troubleshooting](https://learn.microsoft.com/en-us/troubleshoot/windows-server/backup-and-storage/iscsi-storage-connectivity-troubleshooting)

[Microsoft Learn: troubleshoot data corruption and disk errors](https://learn.microsoft.com/en-us/troubleshoot/windows-server/backup-and-storage/troubleshoot-data-corruption-and-disk-errors)


## Fibre Channel loss of signal rate {#hypervprivatecloud.capability.storage.fibrechannelportlossofsignalrate.monitor}

`HyperVPrivateCloud.Capability.Storage.FibreChannelPortLossOfSignalRate.Monitor`

Tracks growth of the HBA loss-of-signal counter per hour. LossOfSignalRatePerHourWarning defaults to 1 and LossOfSignalRatePerHourCritical defaults to 5.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.Fabric.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.Fabric.Service.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Service.Storage.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.Storage.FibreChannelPort.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.Storage.FibreChannelPortLossOfSignalRate.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

Tracks growth of the HBA loss-of-signal counter per hour. LossOfSignalRatePerHourWarning defaults to 1 and LossOfSignalRatePerHourCritical defaults to 5.

### Operator response

Inspect the optic and cable for the affected port. Loss of signal normally means the physical path is degraded or disconnected.

### Support scope

Host-visible SAN LUNs, host attachments, iSCSI sessions, Fibre Channel ports and VM disk mappings. Host paths and array-side volume health are distinct sources.

Element: HyperVPrivateCloud.Capability.Storage.FibreChannelPortLossOfSignalRate.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HyperVPrivateCloud.Capability.Storage.FibreChannelPort. Parent health aspect: Health!System.Health.PerformanceState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: (Property[@Name=&#39;InstanceKey&#39;] = $Target/Property[Type=&quot;HyperVPrivateCloud.Capability.Storage.FibreChannelPort&quot;]/PortId$ AND (Property[@Name=&#39;LossOfSignalState&#39;] = Good OR Property[@Name=&#39;LossOfSignalState&#39;] = NotApplicable))

Warning [Warning]: (Property[@Name=&#39;InstanceKey&#39;] = $Target/Property[Type=&quot;HyperVPrivateCloud.Capability.Storage.FibreChannelPort&quot;]/PortId$ AND Property[@Name=&#39;LossOfSignalState&#39;] = Warning)

Error [Critical]: (Property[@Name=&#39;InstanceKey&#39;] = $Target/Property[Type=&quot;HyperVPrivateCloud.Capability.Storage.FibreChannelPort&quot;]/PortId$ AND Property[@Name=&#39;LossOfSignalState&#39;] = Critical)

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: CapacityUsedCriticalPercent=90; CapacityUsedWarningPercent=80; ComputerName=$Target/Host/Property[Type=&quot;Windows!Microsoft.Windows.Computer&quot;]/PrincipalName$; CrcErrorRatePerHourCritical=25; CrcErrorRatePerHourWarning=5; CriticalPathCount=1; InstanceKey=$Target/Property[Type=&quot;HyperVPrivateCloud.Capability.Storage.FibreChannelPort&quot;]/PortId$; IntervalSeconds=300; LinkFailureRatePerHourCritical=5; LinkFailureRatePerHourWarning=1; LossOfSignalRatePerHourCritical=5; LossOfSignalRatePerHourWarning=1; LossOfSyncRatePerHourCritical=5; LossOfSyncRatePerHourWarning=1; MinimumLinkSpeedGbps=8; MinimumPathCount=2; MinimumSessionsPerTarget=2; PathImbalancePercentCritical=70; PathImbalancePercentWarning=40; PropertyName=LossOfSignalState; QueueDepthCritical=64; QueueDepthWarning=32; ReadLatencyCriticalMs=50; ReadLatencyWarningMs=20; SyncTime=; TimeoutSeconds=180; WriteLatencyCriticalMs=50; WriteLatencyWarningMs=20 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Warning; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Match stable disk/LUN and initiator identifiers before comparing Get-Disk, Get-IscsiSession, Get-IscsiConnection and MPIO path reports. For FC, retain HBA port identity and vendor driver counters. Correlate host System storage errors with switch zoning, masking and array events. Separate loss of one redundant path from complete I/O loss.

### Corrective action and escalation

Restore the identified fabric path or approved MPIO configuration with the storage and network teams. Use compatible HBA/NIC/array firmware guidance. Capacity remediation needs array and filesystem planning. Do not initialize, format, offline or reset a shared disk, or remove active sessions, as generic remediation.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm expected path count, stable sessions and LUN identity, normal I/O and recovered redundancy. Compare counter deltas after repair; historical cumulative counters may not reset.

### Microsoft references

[Microsoft Learn: iscsi storage connectivity troubleshooting](https://learn.microsoft.com/en-us/troubleshoot/windows-server/backup-and-storage/iscsi-storage-connectivity-troubleshooting)

[Microsoft Learn: troubleshoot data corruption and disk errors](https://learn.microsoft.com/en-us/troubleshoot/windows-server/backup-and-storage/troubleshoot-data-corruption-and-disk-errors)


## Fibre Channel loss of sync rate {#hypervprivatecloud.capability.storage.fibrechannelportlossofsyncrate.monitor}

`HyperVPrivateCloud.Capability.Storage.FibreChannelPortLossOfSyncRate.Monitor`

Tracks growth of the HBA loss-of-sync counter per hour. LossOfSyncRatePerHourWarning defaults to 1 and LossOfSyncRatePerHourCritical defaults to 5.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.Fabric.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.Fabric.Service.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Service.Storage.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.Storage.FibreChannelPort.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.Storage.FibreChannelPortLossOfSyncRate.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

Tracks growth of the HBA loss-of-sync counter per hour. LossOfSyncRatePerHourWarning defaults to 1 and LossOfSyncRatePerHourCritical defaults to 5.

### Operator response

Check for speed mismatch, marginal optics, or fabric instability on the affected port.

### Support scope

Host-visible SAN LUNs, host attachments, iSCSI sessions, Fibre Channel ports and VM disk mappings. Host paths and array-side volume health are distinct sources.

Element: HyperVPrivateCloud.Capability.Storage.FibreChannelPortLossOfSyncRate.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HyperVPrivateCloud.Capability.Storage.FibreChannelPort. Parent health aspect: Health!System.Health.PerformanceState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: (Property[@Name=&#39;InstanceKey&#39;] = $Target/Property[Type=&quot;HyperVPrivateCloud.Capability.Storage.FibreChannelPort&quot;]/PortId$ AND (Property[@Name=&#39;LossOfSyncState&#39;] = Good OR Property[@Name=&#39;LossOfSyncState&#39;] = NotApplicable))

Warning [Warning]: (Property[@Name=&#39;InstanceKey&#39;] = $Target/Property[Type=&quot;HyperVPrivateCloud.Capability.Storage.FibreChannelPort&quot;]/PortId$ AND Property[@Name=&#39;LossOfSyncState&#39;] = Warning)

Error [Critical]: (Property[@Name=&#39;InstanceKey&#39;] = $Target/Property[Type=&quot;HyperVPrivateCloud.Capability.Storage.FibreChannelPort&quot;]/PortId$ AND Property[@Name=&#39;LossOfSyncState&#39;] = Critical)

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: CapacityUsedCriticalPercent=90; CapacityUsedWarningPercent=80; ComputerName=$Target/Host/Property[Type=&quot;Windows!Microsoft.Windows.Computer&quot;]/PrincipalName$; CrcErrorRatePerHourCritical=25; CrcErrorRatePerHourWarning=5; CriticalPathCount=1; InstanceKey=$Target/Property[Type=&quot;HyperVPrivateCloud.Capability.Storage.FibreChannelPort&quot;]/PortId$; IntervalSeconds=300; LinkFailureRatePerHourCritical=5; LinkFailureRatePerHourWarning=1; LossOfSignalRatePerHourCritical=5; LossOfSignalRatePerHourWarning=1; LossOfSyncRatePerHourCritical=5; LossOfSyncRatePerHourWarning=1; MinimumLinkSpeedGbps=8; MinimumPathCount=2; MinimumSessionsPerTarget=2; PathImbalancePercentCritical=70; PathImbalancePercentWarning=40; PropertyName=LossOfSyncState; QueueDepthCritical=64; QueueDepthWarning=32; ReadLatencyCriticalMs=50; ReadLatencyWarningMs=20; SyncTime=; TimeoutSeconds=180; WriteLatencyCriticalMs=50; WriteLatencyWarningMs=20 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Warning; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Match stable disk/LUN and initiator identifiers before comparing Get-Disk, Get-IscsiSession, Get-IscsiConnection and MPIO path reports. For FC, retain HBA port identity and vendor driver counters. Correlate host System storage errors with switch zoning, masking and array events. Separate loss of one redundant path from complete I/O loss.

### Corrective action and escalation

Restore the identified fabric path or approved MPIO configuration with the storage and network teams. Use compatible HBA/NIC/array firmware guidance. Capacity remediation needs array and filesystem planning. Do not initialize, format, offline or reset a shared disk, or remove active sessions, as generic remediation.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm expected path count, stable sessions and LUN identity, normal I/O and recovered redundancy. Compare counter deltas after repair; historical cumulative counters may not reset.

### Microsoft references

[Microsoft Learn: iscsi storage connectivity troubleshooting](https://learn.microsoft.com/en-us/troubleshoot/windows-server/backup-and-storage/iscsi-storage-connectivity-troubleshooting)

[Microsoft Learn: troubleshoot data corruption and disk errors](https://learn.microsoft.com/en-us/troubleshoot/windows-server/backup-and-storage/troubleshoot-data-corruption-and-disk-errors)


## Fibre Channel CRC error rate {#hypervprivatecloud.capability.storage.fibrechannelportcrcerrorrate.monitor}

`HyperVPrivateCloud.Capability.Storage.FibreChannelPortCrcErrorRate.Monitor`

Tracks growth of the HBA invalid-CRC counter per hour. CrcErrorRatePerHourWarning defaults to 5 and CrcErrorRatePerHourCritical defaults to 25.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.Fabric.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.Fabric.Service.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Service.Storage.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.Storage.FibreChannelPort.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.Storage.FibreChannelPortCrcErrorRate.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

Tracks growth of the HBA invalid-CRC counter per hour. CrcErrorRatePerHourWarning defaults to 5 and CrcErrorRatePerHourCritical defaults to 25.

### Operator response

CRC errors indicate frame corruption on the path. Inspect cabling, optics, and switch port statistics, and clean or replace suspect connectors.

### Support scope

Host-visible SAN LUNs, host attachments, iSCSI sessions, Fibre Channel ports and VM disk mappings. Host paths and array-side volume health are distinct sources.

Element: HyperVPrivateCloud.Capability.Storage.FibreChannelPortCrcErrorRate.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HyperVPrivateCloud.Capability.Storage.FibreChannelPort. Parent health aspect: Health!System.Health.PerformanceState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: (Property[@Name=&#39;InstanceKey&#39;] = $Target/Property[Type=&quot;HyperVPrivateCloud.Capability.Storage.FibreChannelPort&quot;]/PortId$ AND (Property[@Name=&#39;CrcErrorState&#39;] = Good OR Property[@Name=&#39;CrcErrorState&#39;] = NotApplicable))

Warning [Warning]: (Property[@Name=&#39;InstanceKey&#39;] = $Target/Property[Type=&quot;HyperVPrivateCloud.Capability.Storage.FibreChannelPort&quot;]/PortId$ AND Property[@Name=&#39;CrcErrorState&#39;] = Warning)

Error [Critical]: (Property[@Name=&#39;InstanceKey&#39;] = $Target/Property[Type=&quot;HyperVPrivateCloud.Capability.Storage.FibreChannelPort&quot;]/PortId$ AND Property[@Name=&#39;CrcErrorState&#39;] = Critical)

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: CapacityUsedCriticalPercent=90; CapacityUsedWarningPercent=80; ComputerName=$Target/Host/Property[Type=&quot;Windows!Microsoft.Windows.Computer&quot;]/PrincipalName$; CrcErrorRatePerHourCritical=25; CrcErrorRatePerHourWarning=5; CriticalPathCount=1; InstanceKey=$Target/Property[Type=&quot;HyperVPrivateCloud.Capability.Storage.FibreChannelPort&quot;]/PortId$; IntervalSeconds=300; LinkFailureRatePerHourCritical=5; LinkFailureRatePerHourWarning=1; LossOfSignalRatePerHourCritical=5; LossOfSignalRatePerHourWarning=1; LossOfSyncRatePerHourCritical=5; LossOfSyncRatePerHourWarning=1; MinimumLinkSpeedGbps=8; MinimumPathCount=2; MinimumSessionsPerTarget=2; PathImbalancePercentCritical=70; PathImbalancePercentWarning=40; PropertyName=CrcErrorState; QueueDepthCritical=64; QueueDepthWarning=32; ReadLatencyCriticalMs=50; ReadLatencyWarningMs=20; SyncTime=; TimeoutSeconds=180; WriteLatencyCriticalMs=50; WriteLatencyWarningMs=20 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Warning; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Match stable disk/LUN and initiator identifiers before comparing Get-Disk, Get-IscsiSession, Get-IscsiConnection and MPIO path reports. For FC, retain HBA port identity and vendor driver counters. Correlate host System storage errors with switch zoning, masking and array events. Separate loss of one redundant path from complete I/O loss.

### Corrective action and escalation

Restore the identified fabric path or approved MPIO configuration with the storage and network teams. Use compatible HBA/NIC/array firmware guidance. Capacity remediation needs array and filesystem planning. Do not initialize, format, offline or reset a shared disk, or remove active sessions, as generic remediation.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm expected path count, stable sessions and LUN identity, normal I/O and recovered redundancy. Compare counter deltas after repair; historical cumulative counters may not reset.

### Microsoft references

[Microsoft Learn: iscsi storage connectivity troubleshooting](https://learn.microsoft.com/en-us/troubleshoot/windows-server/backup-and-storage/iscsi-storage-connectivity-troubleshooting)

[Microsoft Learn: troubleshoot data corruption and disk errors](https://learn.microsoft.com/en-us/troubleshoot/windows-server/backup-and-storage/troubleshoot-data-corruption-and-disk-errors)


## Fibre Channel fabric login state {#hypervprivatecloud.capability.storage.fibrechannelportfabriclogin.monitor}

`HyperVPrivateCloud.Capability.Storage.FibreChannelPortFabricLogin.Monitor`

Detects an online port that has not completed fabric login, which usually means a zoning or name-server problem.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.Fabric.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.Fabric.Service.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Service.Storage.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.Storage.FibreChannelPort.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.Storage.FibreChannelPortFabricLogin.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

Detects an online port that has not completed fabric login, which usually means a zoning or name-server problem.

### Operator response

Confirm the port has completed fabric login. Check zoning, switch port state, and HBA driver status.

### Support scope

Host-visible SAN LUNs, host attachments, iSCSI sessions, Fibre Channel ports and VM disk mappings. Host paths and array-side volume health are distinct sources.

Element: HyperVPrivateCloud.Capability.Storage.FibreChannelPortFabricLogin.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HyperVPrivateCloud.Capability.Storage.FibreChannelPort. Parent health aspect: Health!System.Health.AvailabilityState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: (Property[@Name=&#39;InstanceKey&#39;] = $Target/Property[Type=&quot;HyperVPrivateCloud.Capability.Storage.FibreChannelPort&quot;]/PortId$ AND (Property[@Name=&#39;FabricLoginState&#39;] = Good OR Property[@Name=&#39;FabricLoginState&#39;] = NotApplicable))

Warning [Warning]: (Property[@Name=&#39;InstanceKey&#39;] = $Target/Property[Type=&quot;HyperVPrivateCloud.Capability.Storage.FibreChannelPort&quot;]/PortId$ AND Property[@Name=&#39;FabricLoginState&#39;] = Warning)

Error [Critical]: (Property[@Name=&#39;InstanceKey&#39;] = $Target/Property[Type=&quot;HyperVPrivateCloud.Capability.Storage.FibreChannelPort&quot;]/PortId$ AND Property[@Name=&#39;FabricLoginState&#39;] = Critical)

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: CapacityUsedCriticalPercent=90; CapacityUsedWarningPercent=80; ComputerName=$Target/Host/Property[Type=&quot;Windows!Microsoft.Windows.Computer&quot;]/PrincipalName$; CrcErrorRatePerHourCritical=25; CrcErrorRatePerHourWarning=5; CriticalPathCount=1; InstanceKey=$Target/Property[Type=&quot;HyperVPrivateCloud.Capability.Storage.FibreChannelPort&quot;]/PortId$; IntervalSeconds=300; LinkFailureRatePerHourCritical=5; LinkFailureRatePerHourWarning=1; LossOfSignalRatePerHourCritical=5; LossOfSignalRatePerHourWarning=1; LossOfSyncRatePerHourCritical=5; LossOfSyncRatePerHourWarning=1; MinimumLinkSpeedGbps=8; MinimumPathCount=2; MinimumSessionsPerTarget=2; PathImbalancePercentCritical=70; PathImbalancePercentWarning=40; PropertyName=FabricLoginState; QueueDepthCritical=64; QueueDepthWarning=32; ReadLatencyCriticalMs=50; ReadLatencyWarningMs=20; SyncTime=; TimeoutSeconds=180; WriteLatencyCriticalMs=50; WriteLatencyWarningMs=20 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Error; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Match stable disk/LUN and initiator identifiers before comparing Get-Disk, Get-IscsiSession, Get-IscsiConnection and MPIO path reports. For FC, retain HBA port identity and vendor driver counters. Correlate host System storage errors with switch zoning, masking and array events. Separate loss of one redundant path from complete I/O loss.

### Corrective action and escalation

Restore the identified fabric path or approved MPIO configuration with the storage and network teams. Use compatible HBA/NIC/array firmware guidance. Capacity remediation needs array and filesystem planning. Do not initialize, format, offline or reset a shared disk, or remove active sessions, as generic remediation.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm expected path count, stable sessions and LUN identity, normal I/O and recovered redundancy. Compare counter deltas after repair; historical cumulative counters may not reset.

### Microsoft references

[Microsoft Learn: iscsi storage connectivity troubleshooting](https://learn.microsoft.com/en-us/troubleshoot/windows-server/backup-and-storage/iscsi-storage-connectivity-troubleshooting)

[Microsoft Learn: troubleshoot data corruption and disk errors](https://learn.microsoft.com/en-us/troubleshoot/windows-server/backup-and-storage/troubleshoot-data-corruption-and-disk-errors)


## iSCSI session connected state {#hypervprivatecloud.capability.storage.iscsisessionconnectedstate.monitor}

`HyperVPrivateCloud.Capability.Storage.IscsiSessionConnectedState.Monitor`

Tracks whether the discovered iSCSI session is still established and carrying at least one connection.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.Fabric.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.Fabric.Service.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Service.Storage.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.Storage.IscsiSession.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.Storage.IscsiSessionConnectedState.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

Tracks whether the discovered iSCSI session is still established and carrying at least one connection.

### Operator response

Verify the iSCSI target is reachable, the initiator is configured, and the session has not been dropped by the array or network.

### Support scope

Host-visible SAN LUNs, host attachments, iSCSI sessions, Fibre Channel ports and VM disk mappings. Host paths and array-side volume health are distinct sources.

Element: HyperVPrivateCloud.Capability.Storage.IscsiSessionConnectedState.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HyperVPrivateCloud.Capability.Storage.IscsiSession. Parent health aspect: Health!System.Health.AvailabilityState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: (Property[@Name=&#39;InstanceKey&#39;] = $Target/Property[Type=&quot;HyperVPrivateCloud.Capability.Storage.IscsiSession&quot;]/SessionId$ AND (Property[@Name=&#39;ConnectedState&#39;] = Good OR Property[@Name=&#39;ConnectedState&#39;] = NotApplicable))

Warning [Warning]: (Property[@Name=&#39;InstanceKey&#39;] = $Target/Property[Type=&quot;HyperVPrivateCloud.Capability.Storage.IscsiSession&quot;]/SessionId$ AND Property[@Name=&#39;ConnectedState&#39;] = Warning)

Error [Critical]: (Property[@Name=&#39;InstanceKey&#39;] = $Target/Property[Type=&quot;HyperVPrivateCloud.Capability.Storage.IscsiSession&quot;]/SessionId$ AND Property[@Name=&#39;ConnectedState&#39;] = Critical)

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: CapacityUsedCriticalPercent=90; CapacityUsedWarningPercent=80; ComputerName=$Target/Host/Property[Type=&quot;Windows!Microsoft.Windows.Computer&quot;]/PrincipalName$; CrcErrorRatePerHourCritical=25; CrcErrorRatePerHourWarning=5; CriticalPathCount=1; InstanceKey=$Target/Property[Type=&quot;HyperVPrivateCloud.Capability.Storage.IscsiSession&quot;]/SessionId$; IntervalSeconds=300; LinkFailureRatePerHourCritical=5; LinkFailureRatePerHourWarning=1; LossOfSignalRatePerHourCritical=5; LossOfSignalRatePerHourWarning=1; LossOfSyncRatePerHourCritical=5; LossOfSyncRatePerHourWarning=1; MinimumLinkSpeedGbps=8; MinimumPathCount=2; MinimumSessionsPerTarget=2; PathImbalancePercentCritical=70; PathImbalancePercentWarning=40; PropertyName=ConnectedState; QueueDepthCritical=64; QueueDepthWarning=32; ReadLatencyCriticalMs=50; ReadLatencyWarningMs=20; SyncTime=; TimeoutSeconds=180; WriteLatencyCriticalMs=50; WriteLatencyWarningMs=20 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Error; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Match stable disk/LUN and initiator identifiers before comparing Get-Disk, Get-IscsiSession, Get-IscsiConnection and MPIO path reports. For FC, retain HBA port identity and vendor driver counters. Correlate host System storage errors with switch zoning, masking and array events. Separate loss of one redundant path from complete I/O loss.

### Corrective action and escalation

Restore the identified fabric path or approved MPIO configuration with the storage and network teams. Use compatible HBA/NIC/array firmware guidance. Capacity remediation needs array and filesystem planning. Do not initialize, format, offline or reset a shared disk, or remove active sessions, as generic remediation.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm expected path count, stable sessions and LUN identity, normal I/O and recovered redundancy. Compare counter deltas after repair; historical cumulative counters may not reset.

### Microsoft references

[Microsoft Learn: iscsi storage connectivity troubleshooting](https://learn.microsoft.com/en-us/troubleshoot/windows-server/backup-and-storage/iscsi-storage-connectivity-troubleshooting)

[Microsoft Learn: troubleshoot data corruption and disk errors](https://learn.microsoft.com/en-us/troubleshoot/windows-server/backup-and-storage/troubleshoot-data-corruption-and-disk-errors)


## iSCSI session count per target {#hypervprivatecloud.capability.storage.iscsitargetsessioncount.monitor}

`HyperVPrivateCloud.Capability.Storage.IscsiTargetSessionCount.Monitor`

Tracks the number of established sessions to the target that backs this session. MinimumSessionsPerTarget defaults to 2.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.Fabric.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.Fabric.Service.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Service.Storage.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.Storage.IscsiSession.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.Storage.IscsiTargetSessionCount.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

Tracks the number of established sessions to the target that backs this session. MinimumSessionsPerTarget defaults to 2.

### Operator response

Fewer sessions than expected reduces redundancy. Confirm all initiator portals and target portals are configured and reachable.

### Support scope

Host-visible SAN LUNs, host attachments, iSCSI sessions, Fibre Channel ports and VM disk mappings. Host paths and array-side volume health are distinct sources.

Element: HyperVPrivateCloud.Capability.Storage.IscsiTargetSessionCount.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HyperVPrivateCloud.Capability.Storage.IscsiSession. Parent health aspect: Health!System.Health.AvailabilityState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: (Property[@Name=&#39;InstanceKey&#39;] = $Target/Property[Type=&quot;HyperVPrivateCloud.Capability.Storage.IscsiSession&quot;]/SessionId$ AND (Property[@Name=&#39;SessionCountState&#39;] = Good OR Property[@Name=&#39;SessionCountState&#39;] = NotApplicable))

Warning [Warning]: (Property[@Name=&#39;InstanceKey&#39;] = $Target/Property[Type=&quot;HyperVPrivateCloud.Capability.Storage.IscsiSession&quot;]/SessionId$ AND Property[@Name=&#39;SessionCountState&#39;] = Warning)

Error [Critical]: (Property[@Name=&#39;InstanceKey&#39;] = $Target/Property[Type=&quot;HyperVPrivateCloud.Capability.Storage.IscsiSession&quot;]/SessionId$ AND Property[@Name=&#39;SessionCountState&#39;] = Critical)

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: CapacityUsedCriticalPercent=90; CapacityUsedWarningPercent=80; ComputerName=$Target/Host/Property[Type=&quot;Windows!Microsoft.Windows.Computer&quot;]/PrincipalName$; CrcErrorRatePerHourCritical=25; CrcErrorRatePerHourWarning=5; CriticalPathCount=1; InstanceKey=$Target/Property[Type=&quot;HyperVPrivateCloud.Capability.Storage.IscsiSession&quot;]/SessionId$; IntervalSeconds=300; LinkFailureRatePerHourCritical=5; LinkFailureRatePerHourWarning=1; LossOfSignalRatePerHourCritical=5; LossOfSignalRatePerHourWarning=1; LossOfSyncRatePerHourCritical=5; LossOfSyncRatePerHourWarning=1; MinimumLinkSpeedGbps=8; MinimumPathCount=2; MinimumSessionsPerTarget=2; PathImbalancePercentCritical=70; PathImbalancePercentWarning=40; PropertyName=SessionCountState; QueueDepthCritical=64; QueueDepthWarning=32; ReadLatencyCriticalMs=50; ReadLatencyWarningMs=20; SyncTime=; TimeoutSeconds=180; WriteLatencyCriticalMs=50; WriteLatencyWarningMs=20 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Warning; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Match stable disk/LUN and initiator identifiers before comparing Get-Disk, Get-IscsiSession, Get-IscsiConnection and MPIO path reports. For FC, retain HBA port identity and vendor driver counters. Correlate host System storage errors with switch zoning, masking and array events. Separate loss of one redundant path from complete I/O loss.

### Corrective action and escalation

Restore the identified fabric path or approved MPIO configuration with the storage and network teams. Use compatible HBA/NIC/array firmware guidance. Capacity remediation needs array and filesystem planning. Do not initialize, format, offline or reset a shared disk, or remove active sessions, as generic remediation.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm expected path count, stable sessions and LUN identity, normal I/O and recovered redundancy. Compare counter deltas after repair; historical cumulative counters may not reset.

### Microsoft references

[Microsoft Learn: iscsi storage connectivity troubleshooting](https://learn.microsoft.com/en-us/troubleshoot/windows-server/backup-and-storage/iscsi-storage-connectivity-troubleshooting)

[Microsoft Learn: troubleshoot data corruption and disk errors](https://learn.microsoft.com/en-us/troubleshoot/windows-server/backup-and-storage/troubleshoot-data-corruption-and-disk-errors)


## iSCSI connection error and retry rate {#hypervprivatecloud.capability.storage.iscsiconnectionerrorrate.monitor}

`HyperVPrivateCloud.Capability.Storage.IscsiConnectionErrorRate.Monitor`

Counts iScsiPrt connection error and retry events per hour. IscsiConnectionErrorRatePerHourWarning defaults to 3 and IscsiConnectionErrorRatePerHourCritical defaults to 12.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.Fabric.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.Fabric.Service.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Service.Storage.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.Storage.Participation.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.Storage.IscsiConnectionErrorRate.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

Counts iScsiPrt connection error and retry events per hour. IscsiConnectionErrorRatePerHourWarning defaults to 3 and IscsiConnectionErrorRatePerHourCritical defaults to 12.

### Operator response

Investigate network stability, MTU and jumbo-frame consistency, and array-side connection limits.

### Support scope

Host-visible SAN LUNs, host attachments, iSCSI sessions, Fibre Channel ports and VM disk mappings. Host paths and array-side volume health are distinct sources.

Element: HyperVPrivateCloud.Capability.Storage.IscsiConnectionErrorRate.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HyperVPrivateCloud.Capability.Storage.HostParticipation. Parent health aspect: Health!System.Health.PerformanceState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: (Property[@Name=&#39;ConnectionErrorState&#39;] = Good OR Property[@Name=&#39;ConnectionErrorState&#39;] = NotApplicable)

Warning [Warning]: Property[@Name=&#39;ConnectionErrorState&#39;] = Warning

Error [Critical]: Property[@Name=&#39;ConnectionErrorState&#39;] = Critical

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: FailoverEventCriticalCount=5; FailoverEventWarningCount=1; FailoverEventWindowMinutes=60; IntervalSeconds=300; IscsiAuthFailureWarningCount=1; IscsiAuthFailureWindowMinutes=60; IscsiConnectionErrorRatePerHourCritical=12; IscsiConnectionErrorRatePerHourWarning=3; PropertyName=ConnectionErrorState; SyncTime=; TimeoutSeconds=120 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Warning; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Match stable disk/LUN and initiator identifiers before comparing Get-Disk, Get-IscsiSession, Get-IscsiConnection and MPIO path reports. For FC, retain HBA port identity and vendor driver counters. Correlate host System storage errors with switch zoning, masking and array events. Separate loss of one redundant path from complete I/O loss.

### Corrective action and escalation

Restore the identified fabric path or approved MPIO configuration with the storage and network teams. Use compatible HBA/NIC/array firmware guidance. Capacity remediation needs array and filesystem planning. Do not initialize, format, offline or reset a shared disk, or remove active sessions, as generic remediation.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm expected path count, stable sessions and LUN identity, normal I/O and recovered redundancy. Compare counter deltas after repair; historical cumulative counters may not reset.

### Microsoft references

[Microsoft Learn: iscsi storage connectivity troubleshooting](https://learn.microsoft.com/en-us/troubleshoot/windows-server/backup-and-storage/iscsi-storage-connectivity-troubleshooting)

[Microsoft Learn: troubleshoot data corruption and disk errors](https://learn.microsoft.com/en-us/troubleshoot/windows-server/backup-and-storage/troubleshoot-data-corruption-and-disk-errors)


## iSCSI authentication failure detection {#hypervprivatecloud.capability.storage.iscsiauthenticationfailure.monitor}

`HyperVPrivateCloud.Capability.Storage.IscsiAuthenticationFailure.Monitor`

Detects CHAP and mutual CHAP failures logged by iScsiPrt. IscsiAuthFailureWindowMinutes defaults to 60 and IscsiAuthFailureWarningCount defaults to 1.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.Fabric.Security.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.Fabric.Service.Security.Dependency.Monitor &gt; HyperVPrivateCloud.Service.Storage.Security.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.Storage.Participation.Security.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.Storage.IscsiAuthenticationFailure.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

Detects CHAP and mutual CHAP failures logged by iScsiPrt. IscsiAuthFailureWindowMinutes defaults to 60 and IscsiAuthFailureWarningCount defaults to 1.

### Operator response

Check CHAP credentials on both initiator and target, and confirm the initiator IQN is still permitted by the array.

### Support scope

Host-visible SAN LUNs, host attachments, iSCSI sessions, Fibre Channel ports and VM disk mappings. Host paths and array-side volume health are distinct sources.

Element: HyperVPrivateCloud.Capability.Storage.IscsiAuthenticationFailure.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HyperVPrivateCloud.Capability.Storage.HostParticipation. Parent health aspect: Health!System.Health.SecurityState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: (Property[@Name=&#39;AuthenticationState&#39;] = Good OR Property[@Name=&#39;AuthenticationState&#39;] = NotApplicable)

Warning [Warning]: Property[@Name=&#39;AuthenticationState&#39;] = Warning

Error [Critical]: Property[@Name=&#39;AuthenticationState&#39;] = Critical

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: FailoverEventCriticalCount=5; FailoverEventWarningCount=1; FailoverEventWindowMinutes=60; IntervalSeconds=300; IscsiAuthFailureWarningCount=1; IscsiAuthFailureWindowMinutes=60; IscsiConnectionErrorRatePerHourCritical=12; IscsiConnectionErrorRatePerHourWarning=3; PropertyName=AuthenticationState; SyncTime=; TimeoutSeconds=120 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Error; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Match stable disk/LUN and initiator identifiers before comparing Get-Disk, Get-IscsiSession, Get-IscsiConnection and MPIO path reports. For FC, retain HBA port identity and vendor driver counters. Correlate host System storage errors with switch zoning, masking and array events. Separate loss of one redundant path from complete I/O loss.

### Corrective action and escalation

Restore the identified fabric path or approved MPIO configuration with the storage and network teams. Use compatible HBA/NIC/array firmware guidance. Capacity remediation needs array and filesystem planning. Do not initialize, format, offline or reset a shared disk, or remove active sessions, as generic remediation.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm expected path count, stable sessions and LUN identity, normal I/O and recovered redundancy. Compare counter deltas after repair; historical cumulative counters may not reset.

### Microsoft references

[Microsoft Learn: iscsi storage connectivity troubleshooting](https://learn.microsoft.com/en-us/troubleshoot/windows-server/backup-and-storage/iscsi-storage-connectivity-troubleshooting)

[Microsoft Learn: troubleshoot data corruption and disk errors](https://learn.microsoft.com/en-us/troubleshoot/windows-server/backup-and-storage/troubleshoot-data-corruption-and-disk-errors)


## MPIO path count per logical unit {#hypervprivatecloud.capability.storage.multipathpathcount.monitor}

`HyperVPrivateCloud.Capability.Storage.MultipathPathCount.Monitor`

Compares live MPIO path count against the expected minimum. MinimumPathCount defaults to 2 and CriticalPathCount defaults to 1.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.Fabric.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.Fabric.Service.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Service.Storage.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.Storage.Attachment.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.Storage.MultipathPathCount.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

Compares live MPIO path count against the expected minimum. MinimumPathCount defaults to 2 and CriticalPathCount defaults to 1.

### Operator response

Fewer paths than the configured minimum removes redundancy. Check HBA ports, fabric zoning, array host mappings, and the MPIO DSM.

### Support scope

Host-visible SAN LUNs, host attachments, iSCSI sessions, Fibre Channel ports and VM disk mappings. Host paths and array-side volume health are distinct sources.

Element: HyperVPrivateCloud.Capability.Storage.MultipathPathCount.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HyperVPrivateCloud.Capability.Storage.HostAttachment. Parent health aspect: Health!System.Health.AvailabilityState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: (Property[@Name=&#39;InstanceKey&#39;] = $Target/Property[Type=&quot;HyperVPrivateCloud.Capability.Storage.HostAttachment&quot;]/StorageId$ AND (Property[@Name=&#39;PathCountState&#39;] = Good OR Property[@Name=&#39;PathCountState&#39;] = NotApplicable))

Warning [Warning]: (Property[@Name=&#39;InstanceKey&#39;] = $Target/Property[Type=&quot;HyperVPrivateCloud.Capability.Storage.HostAttachment&quot;]/StorageId$ AND Property[@Name=&#39;PathCountState&#39;] = Warning)

Error [Critical]: (Property[@Name=&#39;InstanceKey&#39;] = $Target/Property[Type=&quot;HyperVPrivateCloud.Capability.Storage.HostAttachment&quot;]/StorageId$ AND Property[@Name=&#39;PathCountState&#39;] = Critical)

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: CapacityUsedCriticalPercent=90; CapacityUsedWarningPercent=80; ComputerName=$Target/Host/Property[Type=&quot;Windows!Microsoft.Windows.Computer&quot;]/PrincipalName$; CrcErrorRatePerHourCritical=25; CrcErrorRatePerHourWarning=5; CriticalPathCount=1; InstanceKey=$Target/Property[Type=&quot;HyperVPrivateCloud.Capability.Storage.HostAttachment&quot;]/StorageId$; IntervalSeconds=300; LinkFailureRatePerHourCritical=5; LinkFailureRatePerHourWarning=1; LossOfSignalRatePerHourCritical=5; LossOfSignalRatePerHourWarning=1; LossOfSyncRatePerHourCritical=5; LossOfSyncRatePerHourWarning=1; MinimumLinkSpeedGbps=8; MinimumPathCount=2; MinimumSessionsPerTarget=2; PathImbalancePercentCritical=70; PathImbalancePercentWarning=40; PropertyName=PathCountState; QueueDepthCritical=64; QueueDepthWarning=32; ReadLatencyCriticalMs=50; ReadLatencyWarningMs=20; SyncTime=; TimeoutSeconds=180; WriteLatencyCriticalMs=50; WriteLatencyWarningMs=20 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Warning; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Match stable disk/LUN and initiator identifiers before comparing Get-Disk, Get-IscsiSession, Get-IscsiConnection and MPIO path reports. For FC, retain HBA port identity and vendor driver counters. Correlate host System storage errors with switch zoning, masking and array events. Separate loss of one redundant path from complete I/O loss.

### Corrective action and escalation

Restore the identified fabric path or approved MPIO configuration with the storage and network teams. Use compatible HBA/NIC/array firmware guidance. Capacity remediation needs array and filesystem planning. Do not initialize, format, offline or reset a shared disk, or remove active sessions, as generic remediation.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm expected path count, stable sessions and LUN identity, normal I/O and recovered redundancy. Compare counter deltas after repair; historical cumulative counters may not reset.

### Microsoft references

[Microsoft Learn: iscsi storage connectivity troubleshooting](https://learn.microsoft.com/en-us/troubleshoot/windows-server/backup-and-storage/iscsi-storage-connectivity-troubleshooting)

[Microsoft Learn: troubleshoot data corruption and disk errors](https://learn.microsoft.com/en-us/troubleshoot/windows-server/backup-and-storage/troubleshoot-data-corruption-and-disk-errors)


## MPIO path loss detection {#hypervprivatecloud.capability.storage.multipathpathloss.monitor}

`HyperVPrivateCloud.Capability.Storage.MultipathPathLoss.Monitor`

Compares live MPIO path count against the highest count previously observed for the device and reports lost paths.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.Fabric.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.Fabric.Service.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Service.Storage.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.Storage.Attachment.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.Storage.MultipathPathLoss.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

Compares live MPIO path count against the highest count previously observed for the device and reports lost paths.

### Operator response

A previously observed path is no longer present. Investigate the fabric, array host mapping, and the affected HBA port before the remaining paths are lost.

### Support scope

Host-visible SAN LUNs, host attachments, iSCSI sessions, Fibre Channel ports and VM disk mappings. Host paths and array-side volume health are distinct sources.

Element: HyperVPrivateCloud.Capability.Storage.MultipathPathLoss.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HyperVPrivateCloud.Capability.Storage.HostAttachment. Parent health aspect: Health!System.Health.AvailabilityState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: (Property[@Name=&#39;InstanceKey&#39;] = $Target/Property[Type=&quot;HyperVPrivateCloud.Capability.Storage.HostAttachment&quot;]/StorageId$ AND (Property[@Name=&#39;PathLossState&#39;] = Good OR Property[@Name=&#39;PathLossState&#39;] = NotApplicable))

Warning [Warning]: (Property[@Name=&#39;InstanceKey&#39;] = $Target/Property[Type=&quot;HyperVPrivateCloud.Capability.Storage.HostAttachment&quot;]/StorageId$ AND Property[@Name=&#39;PathLossState&#39;] = Warning)

Error [Critical]: (Property[@Name=&#39;InstanceKey&#39;] = $Target/Property[Type=&quot;HyperVPrivateCloud.Capability.Storage.HostAttachment&quot;]/StorageId$ AND Property[@Name=&#39;PathLossState&#39;] = Critical)

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: CapacityUsedCriticalPercent=90; CapacityUsedWarningPercent=80; ComputerName=$Target/Host/Property[Type=&quot;Windows!Microsoft.Windows.Computer&quot;]/PrincipalName$; CrcErrorRatePerHourCritical=25; CrcErrorRatePerHourWarning=5; CriticalPathCount=1; InstanceKey=$Target/Property[Type=&quot;HyperVPrivateCloud.Capability.Storage.HostAttachment&quot;]/StorageId$; IntervalSeconds=300; LinkFailureRatePerHourCritical=5; LinkFailureRatePerHourWarning=1; LossOfSignalRatePerHourCritical=5; LossOfSignalRatePerHourWarning=1; LossOfSyncRatePerHourCritical=5; LossOfSyncRatePerHourWarning=1; MinimumLinkSpeedGbps=8; MinimumPathCount=2; MinimumSessionsPerTarget=2; PathImbalancePercentCritical=70; PathImbalancePercentWarning=40; PropertyName=PathLossState; QueueDepthCritical=64; QueueDepthWarning=32; ReadLatencyCriticalMs=50; ReadLatencyWarningMs=20; SyncTime=; TimeoutSeconds=180; WriteLatencyCriticalMs=50; WriteLatencyWarningMs=20 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Warning; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Match stable disk/LUN and initiator identifiers before comparing Get-Disk, Get-IscsiSession, Get-IscsiConnection and MPIO path reports. For FC, retain HBA port identity and vendor driver counters. Correlate host System storage errors with switch zoning, masking and array events. Separate loss of one redundant path from complete I/O loss.

### Corrective action and escalation

Restore the identified fabric path or approved MPIO configuration with the storage and network teams. Use compatible HBA/NIC/array firmware guidance. Capacity remediation needs array and filesystem planning. Do not initialize, format, offline or reset a shared disk, or remove active sessions, as generic remediation.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm expected path count, stable sessions and LUN identity, normal I/O and recovered redundancy. Compare counter deltas after repair; historical cumulative counters may not reset.

### Microsoft references

[Microsoft Learn: iscsi storage connectivity troubleshooting](https://learn.microsoft.com/en-us/troubleshoot/windows-server/backup-and-storage/iscsi-storage-connectivity-troubleshooting)

[Microsoft Learn: troubleshoot data corruption and disk errors](https://learn.microsoft.com/en-us/troubleshoot/windows-server/backup-and-storage/troubleshoot-data-corruption-and-disk-errors)


## MPIO path state imbalance {#hypervprivatecloud.capability.storage.multipathpathimbalance.monitor}

`HyperVPrivateCloud.Capability.Storage.MultipathPathImbalance.Monitor`

Reports the percentage of the known path set that is not currently active. Disabled by default. PathImbalancePercentWarning defaults to 40 and PathImbalancePercentCritical defaults to 70.

### Summary

Reports the percentage of the known path set that is not currently active. Disabled by default. PathImbalancePercentWarning defaults to 40 and PathImbalancePercentCritical defaults to 70.

### Operator response

Path load is uneven. Review the MPIO load-balancing policy and vendor DSM configuration. This monitor is disabled by default because the available data is aggregate only.

### Support scope

Host-visible SAN LUNs, host attachments, iSCSI sessions, Fibre Channel ports and VM disk mappings. Host paths and array-side volume health are distinct sources.

Element: HyperVPrivateCloud.Capability.Storage.MultipathPathImbalance.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HyperVPrivateCloud.Capability.Storage.HostAttachment. Parent health aspect: Health!System.Health.PerformanceState. Enabled by default: false. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: (Property[@Name=&#39;InstanceKey&#39;] = $Target/Property[Type=&quot;HyperVPrivateCloud.Capability.Storage.HostAttachment&quot;]/StorageId$ AND (Property[@Name=&#39;PathBalanceState&#39;] = Good OR Property[@Name=&#39;PathBalanceState&#39;] = NotApplicable))

Warning [Warning]: (Property[@Name=&#39;InstanceKey&#39;] = $Target/Property[Type=&quot;HyperVPrivateCloud.Capability.Storage.HostAttachment&quot;]/StorageId$ AND Property[@Name=&#39;PathBalanceState&#39;] = Warning)

Error [Critical]: (Property[@Name=&#39;InstanceKey&#39;] = $Target/Property[Type=&quot;HyperVPrivateCloud.Capability.Storage.HostAttachment&quot;]/StorageId$ AND Property[@Name=&#39;PathBalanceState&#39;] = Critical)

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: CapacityUsedCriticalPercent=90; CapacityUsedWarningPercent=80; ComputerName=$Target/Host/Property[Type=&quot;Windows!Microsoft.Windows.Computer&quot;]/PrincipalName$; CrcErrorRatePerHourCritical=25; CrcErrorRatePerHourWarning=5; CriticalPathCount=1; InstanceKey=$Target/Property[Type=&quot;HyperVPrivateCloud.Capability.Storage.HostAttachment&quot;]/StorageId$; IntervalSeconds=300; LinkFailureRatePerHourCritical=5; LinkFailureRatePerHourWarning=1; LossOfSignalRatePerHourCritical=5; LossOfSignalRatePerHourWarning=1; LossOfSyncRatePerHourCritical=5; LossOfSyncRatePerHourWarning=1; MinimumLinkSpeedGbps=8; MinimumPathCount=2; MinimumSessionsPerTarget=2; PathImbalancePercentCritical=70; PathImbalancePercentWarning=40; PropertyName=PathBalanceState; QueueDepthCritical=64; QueueDepthWarning=32; ReadLatencyCriticalMs=50; ReadLatencyWarningMs=20; SyncTime=; TimeoutSeconds=180; WriteLatencyCriticalMs=50; WriteLatencyWarningMs=20 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Warning; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Match stable disk/LUN and initiator identifiers before comparing Get-Disk, Get-IscsiSession, Get-IscsiConnection and MPIO path reports. For FC, retain HBA port identity and vendor driver counters. Correlate host System storage errors with switch zoning, masking and array events. Separate loss of one redundant path from complete I/O loss.

### Corrective action and escalation

Restore the identified fabric path or approved MPIO configuration with the storage and network teams. Use compatible HBA/NIC/array firmware guidance. Capacity remediation needs array and filesystem planning. Do not initialize, format, offline or reset a shared disk, or remove active sessions, as generic remediation.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm expected path count, stable sessions and LUN identity, normal I/O and recovered redundancy. Compare counter deltas after repair; historical cumulative counters may not reset.

### Microsoft references

[Microsoft Learn: iscsi storage connectivity troubleshooting](https://learn.microsoft.com/en-us/troubleshoot/windows-server/backup-and-storage/iscsi-storage-connectivity-troubleshooting)

[Microsoft Learn: troubleshoot data corruption and disk errors](https://learn.microsoft.com/en-us/troubleshoot/windows-server/backup-and-storage/troubleshoot-data-corruption-and-disk-errors)


## MPIO failover event detection {#hypervprivatecloud.capability.storage.multipathfailoverevent.monitor}

`HyperVPrivateCloud.Capability.Storage.MultipathFailoverEvent.Monitor`

Counts MPIO path failover events in a rolling window. FailoverEventWindowMinutes defaults to 60, FailoverEventWarningCount to 1, and FailoverEventCriticalCount to 5.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.Fabric.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.Fabric.Service.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Service.Storage.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.Storage.Participation.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.Storage.MultipathFailoverEvent.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

Counts MPIO path failover events in a rolling window. FailoverEventWindowMinutes defaults to 60, FailoverEventWarningCount to 1, and FailoverEventCriticalCount to 5.

### Operator response

Repeated failover indicates an unstable path. Correlate with fabric and array logs to find the flapping component.

### Support scope

Host-visible SAN LUNs, host attachments, iSCSI sessions, Fibre Channel ports and VM disk mappings. Host paths and array-side volume health are distinct sources.

Element: HyperVPrivateCloud.Capability.Storage.MultipathFailoverEvent.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HyperVPrivateCloud.Capability.Storage.HostParticipation. Parent health aspect: Health!System.Health.AvailabilityState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: (Property[@Name=&#39;FailoverState&#39;] = Good OR Property[@Name=&#39;FailoverState&#39;] = NotApplicable)

Warning [Warning]: Property[@Name=&#39;FailoverState&#39;] = Warning

Error [Critical]: Property[@Name=&#39;FailoverState&#39;] = Critical

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: FailoverEventCriticalCount=5; FailoverEventWarningCount=1; FailoverEventWindowMinutes=60; IntervalSeconds=300; IscsiAuthFailureWarningCount=1; IscsiAuthFailureWindowMinutes=60; IscsiConnectionErrorRatePerHourCritical=12; IscsiConnectionErrorRatePerHourWarning=3; PropertyName=FailoverState; SyncTime=; TimeoutSeconds=120 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Warning; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Match stable disk/LUN and initiator identifiers before comparing Get-Disk, Get-IscsiSession, Get-IscsiConnection and MPIO path reports. For FC, retain HBA port identity and vendor driver counters. Correlate host System storage errors with switch zoning, masking and array events. Separate loss of one redundant path from complete I/O loss.

### Corrective action and escalation

Restore the identified fabric path or approved MPIO configuration with the storage and network teams. Use compatible HBA/NIC/array firmware guidance. Capacity remediation needs array and filesystem planning. Do not initialize, format, offline or reset a shared disk, or remove active sessions, as generic remediation.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm expected path count, stable sessions and LUN identity, normal I/O and recovered redundancy. Compare counter deltas after repair; historical cumulative counters may not reset.

### Microsoft references

[Microsoft Learn: iscsi storage connectivity troubleshooting](https://learn.microsoft.com/en-us/troubleshoot/windows-server/backup-and-storage/iscsi-storage-connectivity-troubleshooting)

[Microsoft Learn: troubleshoot data corruption and disk errors](https://learn.microsoft.com/en-us/troubleshoot/windows-server/backup-and-storage/troubleshoot-data-corruption-and-disk-errors)


## SAN logical unit operational status {#hypervprivatecloud.capability.storage.logicalunitoperationalstatus.monitor}

`HyperVPrivateCloud.Capability.Storage.LogicalUnitOperationalStatus.Monitor`

Tracks the Windows health and operational status reported for the logical unit behind this attachment.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.Fabric.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.Fabric.Service.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Service.Storage.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.Storage.Attachment.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.Storage.LogicalUnitOperationalStatus.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

Tracks the Windows health and operational status reported for the logical unit behind this attachment.

### Operator response

Check the array-side status of the logical unit and the host attachment. A degraded LUN normally reflects an array or path condition.

### Support scope

Host-visible SAN LUNs, host attachments, iSCSI sessions, Fibre Channel ports and VM disk mappings. Host paths and array-side volume health are distinct sources.

Element: HyperVPrivateCloud.Capability.Storage.LogicalUnitOperationalStatus.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HyperVPrivateCloud.Capability.Storage.HostAttachment. Parent health aspect: Health!System.Health.AvailabilityState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: (Property[@Name=&#39;InstanceKey&#39;] = $Target/Property[Type=&quot;HyperVPrivateCloud.Capability.Storage.HostAttachment&quot;]/StorageId$ AND (Property[@Name=&#39;OperationalState&#39;] = Good OR Property[@Name=&#39;OperationalState&#39;] = NotApplicable))

Warning [Warning]: (Property[@Name=&#39;InstanceKey&#39;] = $Target/Property[Type=&quot;HyperVPrivateCloud.Capability.Storage.HostAttachment&quot;]/StorageId$ AND Property[@Name=&#39;OperationalState&#39;] = Warning)

Error [Critical]: (Property[@Name=&#39;InstanceKey&#39;] = $Target/Property[Type=&quot;HyperVPrivateCloud.Capability.Storage.HostAttachment&quot;]/StorageId$ AND Property[@Name=&#39;OperationalState&#39;] = Critical)

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: CapacityUsedCriticalPercent=90; CapacityUsedWarningPercent=80; ComputerName=$Target/Host/Property[Type=&quot;Windows!Microsoft.Windows.Computer&quot;]/PrincipalName$; CrcErrorRatePerHourCritical=25; CrcErrorRatePerHourWarning=5; CriticalPathCount=1; InstanceKey=$Target/Property[Type=&quot;HyperVPrivateCloud.Capability.Storage.HostAttachment&quot;]/StorageId$; IntervalSeconds=300; LinkFailureRatePerHourCritical=5; LinkFailureRatePerHourWarning=1; LossOfSignalRatePerHourCritical=5; LossOfSignalRatePerHourWarning=1; LossOfSyncRatePerHourCritical=5; LossOfSyncRatePerHourWarning=1; MinimumLinkSpeedGbps=8; MinimumPathCount=2; MinimumSessionsPerTarget=2; PathImbalancePercentCritical=70; PathImbalancePercentWarning=40; PropertyName=OperationalState; QueueDepthCritical=64; QueueDepthWarning=32; ReadLatencyCriticalMs=50; ReadLatencyWarningMs=20; SyncTime=; TimeoutSeconds=180; WriteLatencyCriticalMs=50; WriteLatencyWarningMs=20 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Error; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Match stable disk/LUN and initiator identifiers before comparing Get-Disk, Get-IscsiSession, Get-IscsiConnection and MPIO path reports. For FC, retain HBA port identity and vendor driver counters. Correlate host System storage errors with switch zoning, masking and array events. Separate loss of one redundant path from complete I/O loss.

### Corrective action and escalation

Restore the identified fabric path or approved MPIO configuration with the storage and network teams. Use compatible HBA/NIC/array firmware guidance. Capacity remediation needs array and filesystem planning. Do not initialize, format, offline or reset a shared disk, or remove active sessions, as generic remediation.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm expected path count, stable sessions and LUN identity, normal I/O and recovered redundancy. Compare counter deltas after repair; historical cumulative counters may not reset.

### Microsoft references

[Microsoft Learn: iscsi storage connectivity troubleshooting](https://learn.microsoft.com/en-us/troubleshoot/windows-server/backup-and-storage/iscsi-storage-connectivity-troubleshooting)

[Microsoft Learn: troubleshoot data corruption and disk errors](https://learn.microsoft.com/en-us/troubleshoot/windows-server/backup-and-storage/troubleshoot-data-corruption-and-disk-errors)


## SAN logical unit capacity used {#hypervprivatecloud.capability.storage.logicalunitcapacityused.monitor}

`HyperVPrivateCloud.Capability.Storage.LogicalUnitCapacityUsed.Monitor`

Tracks used capacity across every Windows volume carved from the logical unit. CapacityUsedWarningPercent defaults to 80 and CapacityUsedCriticalPercent defaults to 90.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.Fabric.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.Fabric.Service.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Service.Storage.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.Storage.Attachment.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.Storage.LogicalUnitCapacityUsed.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

Tracks used capacity across every Windows volume carved from the logical unit. CapacityUsedWarningPercent defaults to 80 and CapacityUsedCriticalPercent defaults to 90.

### Operator response

Reclaim space, extend the logical unit, or migrate workloads. Investigate growth trends before the volume fills.

### Support scope

Host-visible SAN LUNs, host attachments, iSCSI sessions, Fibre Channel ports and VM disk mappings. Host paths and array-side volume health are distinct sources.

Element: HyperVPrivateCloud.Capability.Storage.LogicalUnitCapacityUsed.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HyperVPrivateCloud.Capability.Storage.HostAttachment. Parent health aspect: Health!System.Health.PerformanceState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: (Property[@Name=&#39;InstanceKey&#39;] = $Target/Property[Type=&quot;HyperVPrivateCloud.Capability.Storage.HostAttachment&quot;]/StorageId$ AND (Property[@Name=&#39;CapacityState&#39;] = Good OR Property[@Name=&#39;CapacityState&#39;] = NotApplicable))

Warning [Warning]: (Property[@Name=&#39;InstanceKey&#39;] = $Target/Property[Type=&quot;HyperVPrivateCloud.Capability.Storage.HostAttachment&quot;]/StorageId$ AND Property[@Name=&#39;CapacityState&#39;] = Warning)

Error [Critical]: (Property[@Name=&#39;InstanceKey&#39;] = $Target/Property[Type=&quot;HyperVPrivateCloud.Capability.Storage.HostAttachment&quot;]/StorageId$ AND Property[@Name=&#39;CapacityState&#39;] = Critical)

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: CapacityUsedCriticalPercent=90; CapacityUsedWarningPercent=80; ComputerName=$Target/Host/Property[Type=&quot;Windows!Microsoft.Windows.Computer&quot;]/PrincipalName$; CrcErrorRatePerHourCritical=25; CrcErrorRatePerHourWarning=5; CriticalPathCount=1; InstanceKey=$Target/Property[Type=&quot;HyperVPrivateCloud.Capability.Storage.HostAttachment&quot;]/StorageId$; IntervalSeconds=300; LinkFailureRatePerHourCritical=5; LinkFailureRatePerHourWarning=1; LossOfSignalRatePerHourCritical=5; LossOfSignalRatePerHourWarning=1; LossOfSyncRatePerHourCritical=5; LossOfSyncRatePerHourWarning=1; MinimumLinkSpeedGbps=8; MinimumPathCount=2; MinimumSessionsPerTarget=2; PathImbalancePercentCritical=70; PathImbalancePercentWarning=40; PropertyName=CapacityState; QueueDepthCritical=64; QueueDepthWarning=32; ReadLatencyCriticalMs=50; ReadLatencyWarningMs=20; SyncTime=; TimeoutSeconds=180; WriteLatencyCriticalMs=50; WriteLatencyWarningMs=20 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Warning; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Match stable disk/LUN and initiator identifiers before comparing Get-Disk, Get-IscsiSession, Get-IscsiConnection and MPIO path reports. For FC, retain HBA port identity and vendor driver counters. Correlate host System storage errors with switch zoning, masking and array events. Separate loss of one redundant path from complete I/O loss.

### Corrective action and escalation

Restore the identified fabric path or approved MPIO configuration with the storage and network teams. Use compatible HBA/NIC/array firmware guidance. Capacity remediation needs array and filesystem planning. Do not initialize, format, offline or reset a shared disk, or remove active sessions, as generic remediation.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm expected path count, stable sessions and LUN identity, normal I/O and recovered redundancy. Compare counter deltas after repair; historical cumulative counters may not reset.

### Microsoft references

[Microsoft Learn: iscsi storage connectivity troubleshooting](https://learn.microsoft.com/en-us/troubleshoot/windows-server/backup-and-storage/iscsi-storage-connectivity-troubleshooting)

[Microsoft Learn: troubleshoot data corruption and disk errors](https://learn.microsoft.com/en-us/troubleshoot/windows-server/backup-and-storage/troubleshoot-data-corruption-and-disk-errors)


## SAN logical unit read latency {#hypervprivatecloud.capability.storage.logicalunitreadlatency.monitor}

`HyperVPrivateCloud.Capability.Storage.LogicalUnitReadLatency.Monitor`

Tracks average read latency for the logical unit. ReadLatencyWarningMs defaults to 20 and ReadLatencyCriticalMs defaults to 50.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.Fabric.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.Fabric.Service.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Service.Storage.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.Storage.Attachment.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.Storage.LogicalUnitReadLatency.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

Tracks average read latency for the logical unit. ReadLatencyWarningMs defaults to 20 and ReadLatencyCriticalMs defaults to 50.

### Operator response

Investigate array-side contention, path health, and queue depth. Sustained read latency degrades virtual machine performance.

### Support scope

Host-visible SAN LUNs, host attachments, iSCSI sessions, Fibre Channel ports and VM disk mappings. Host paths and array-side volume health are distinct sources.

Element: HyperVPrivateCloud.Capability.Storage.LogicalUnitReadLatency.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HyperVPrivateCloud.Capability.Storage.HostAttachment. Parent health aspect: Health!System.Health.PerformanceState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: (Property[@Name=&#39;InstanceKey&#39;] = $Target/Property[Type=&quot;HyperVPrivateCloud.Capability.Storage.HostAttachment&quot;]/StorageId$ AND (Property[@Name=&#39;ReadLatencyState&#39;] = Good OR Property[@Name=&#39;ReadLatencyState&#39;] = NotApplicable))

Warning [Warning]: (Property[@Name=&#39;InstanceKey&#39;] = $Target/Property[Type=&quot;HyperVPrivateCloud.Capability.Storage.HostAttachment&quot;]/StorageId$ AND Property[@Name=&#39;ReadLatencyState&#39;] = Warning)

Error [Critical]: (Property[@Name=&#39;InstanceKey&#39;] = $Target/Property[Type=&quot;HyperVPrivateCloud.Capability.Storage.HostAttachment&quot;]/StorageId$ AND Property[@Name=&#39;ReadLatencyState&#39;] = Critical)

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: CapacityUsedCriticalPercent=90; CapacityUsedWarningPercent=80; ComputerName=$Target/Host/Property[Type=&quot;Windows!Microsoft.Windows.Computer&quot;]/PrincipalName$; CrcErrorRatePerHourCritical=25; CrcErrorRatePerHourWarning=5; CriticalPathCount=1; InstanceKey=$Target/Property[Type=&quot;HyperVPrivateCloud.Capability.Storage.HostAttachment&quot;]/StorageId$; IntervalSeconds=300; LinkFailureRatePerHourCritical=5; LinkFailureRatePerHourWarning=1; LossOfSignalRatePerHourCritical=5; LossOfSignalRatePerHourWarning=1; LossOfSyncRatePerHourCritical=5; LossOfSyncRatePerHourWarning=1; MinimumLinkSpeedGbps=8; MinimumPathCount=2; MinimumSessionsPerTarget=2; PathImbalancePercentCritical=70; PathImbalancePercentWarning=40; PropertyName=ReadLatencyState; QueueDepthCritical=64; QueueDepthWarning=32; ReadLatencyCriticalMs=50; ReadLatencyWarningMs=20; SyncTime=; TimeoutSeconds=180; WriteLatencyCriticalMs=50; WriteLatencyWarningMs=20 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Warning; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Match stable disk/LUN and initiator identifiers before comparing Get-Disk, Get-IscsiSession, Get-IscsiConnection and MPIO path reports. For FC, retain HBA port identity and vendor driver counters. Correlate host System storage errors with switch zoning, masking and array events. Separate loss of one redundant path from complete I/O loss.

### Corrective action and escalation

Restore the identified fabric path or approved MPIO configuration with the storage and network teams. Use compatible HBA/NIC/array firmware guidance. Capacity remediation needs array and filesystem planning. Do not initialize, format, offline or reset a shared disk, or remove active sessions, as generic remediation.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm expected path count, stable sessions and LUN identity, normal I/O and recovered redundancy. Compare counter deltas after repair; historical cumulative counters may not reset.

### Microsoft references

[Microsoft Learn: iscsi storage connectivity troubleshooting](https://learn.microsoft.com/en-us/troubleshoot/windows-server/backup-and-storage/iscsi-storage-connectivity-troubleshooting)

[Microsoft Learn: troubleshoot data corruption and disk errors](https://learn.microsoft.com/en-us/troubleshoot/windows-server/backup-and-storage/troubleshoot-data-corruption-and-disk-errors)


## SAN logical unit write latency {#hypervprivatecloud.capability.storage.logicalunitwritelatency.monitor}

`HyperVPrivateCloud.Capability.Storage.LogicalUnitWriteLatency.Monitor`

Tracks average write latency for the logical unit. WriteLatencyWarningMs defaults to 20 and WriteLatencyCriticalMs defaults to 50.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.Fabric.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.Fabric.Service.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Service.Storage.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.Storage.Attachment.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.Storage.LogicalUnitWriteLatency.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

Tracks average write latency for the logical unit. WriteLatencyWarningMs defaults to 20 and WriteLatencyCriticalMs defaults to 50.

### Operator response

Investigate array-side contention, cache state, and path health. Sustained write latency degrades virtual machine performance.

### Support scope

Host-visible SAN LUNs, host attachments, iSCSI sessions, Fibre Channel ports and VM disk mappings. Host paths and array-side volume health are distinct sources.

Element: HyperVPrivateCloud.Capability.Storage.LogicalUnitWriteLatency.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HyperVPrivateCloud.Capability.Storage.HostAttachment. Parent health aspect: Health!System.Health.PerformanceState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: (Property[@Name=&#39;InstanceKey&#39;] = $Target/Property[Type=&quot;HyperVPrivateCloud.Capability.Storage.HostAttachment&quot;]/StorageId$ AND (Property[@Name=&#39;WriteLatencyState&#39;] = Good OR Property[@Name=&#39;WriteLatencyState&#39;] = NotApplicable))

Warning [Warning]: (Property[@Name=&#39;InstanceKey&#39;] = $Target/Property[Type=&quot;HyperVPrivateCloud.Capability.Storage.HostAttachment&quot;]/StorageId$ AND Property[@Name=&#39;WriteLatencyState&#39;] = Warning)

Error [Critical]: (Property[@Name=&#39;InstanceKey&#39;] = $Target/Property[Type=&quot;HyperVPrivateCloud.Capability.Storage.HostAttachment&quot;]/StorageId$ AND Property[@Name=&#39;WriteLatencyState&#39;] = Critical)

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: CapacityUsedCriticalPercent=90; CapacityUsedWarningPercent=80; ComputerName=$Target/Host/Property[Type=&quot;Windows!Microsoft.Windows.Computer&quot;]/PrincipalName$; CrcErrorRatePerHourCritical=25; CrcErrorRatePerHourWarning=5; CriticalPathCount=1; InstanceKey=$Target/Property[Type=&quot;HyperVPrivateCloud.Capability.Storage.HostAttachment&quot;]/StorageId$; IntervalSeconds=300; LinkFailureRatePerHourCritical=5; LinkFailureRatePerHourWarning=1; LossOfSignalRatePerHourCritical=5; LossOfSignalRatePerHourWarning=1; LossOfSyncRatePerHourCritical=5; LossOfSyncRatePerHourWarning=1; MinimumLinkSpeedGbps=8; MinimumPathCount=2; MinimumSessionsPerTarget=2; PathImbalancePercentCritical=70; PathImbalancePercentWarning=40; PropertyName=WriteLatencyState; QueueDepthCritical=64; QueueDepthWarning=32; ReadLatencyCriticalMs=50; ReadLatencyWarningMs=20; SyncTime=; TimeoutSeconds=180; WriteLatencyCriticalMs=50; WriteLatencyWarningMs=20 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Warning; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Match stable disk/LUN and initiator identifiers before comparing Get-Disk, Get-IscsiSession, Get-IscsiConnection and MPIO path reports. For FC, retain HBA port identity and vendor driver counters. Correlate host System storage errors with switch zoning, masking and array events. Separate loss of one redundant path from complete I/O loss.

### Corrective action and escalation

Restore the identified fabric path or approved MPIO configuration with the storage and network teams. Use compatible HBA/NIC/array firmware guidance. Capacity remediation needs array and filesystem planning. Do not initialize, format, offline or reset a shared disk, or remove active sessions, as generic remediation.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm expected path count, stable sessions and LUN identity, normal I/O and recovered redundancy. Compare counter deltas after repair; historical cumulative counters may not reset.

### Microsoft references

[Microsoft Learn: iscsi storage connectivity troubleshooting](https://learn.microsoft.com/en-us/troubleshoot/windows-server/backup-and-storage/iscsi-storage-connectivity-troubleshooting)

[Microsoft Learn: troubleshoot data corruption and disk errors](https://learn.microsoft.com/en-us/troubleshoot/windows-server/backup-and-storage/troubleshoot-data-corruption-and-disk-errors)


## SAN logical unit queue depth {#hypervprivatecloud.capability.storage.logicalunitqueuedepth.monitor}

`HyperVPrivateCloud.Capability.Storage.LogicalUnitQueueDepth.Monitor`

Tracks the current disk queue length for the logical unit. QueueDepthWarning defaults to 32 and QueueDepthCritical defaults to 64.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.Fabric.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.Fabric.Service.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Service.Storage.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.Storage.Attachment.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.Storage.LogicalUnitQueueDepth.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

Tracks the current disk queue length for the logical unit. QueueDepthWarning defaults to 32 and QueueDepthCritical defaults to 64.

### Operator response

A persistently deep queue indicates the storage path is saturated. Review workload placement, queue-depth settings, and array capability.

### Support scope

Host-visible SAN LUNs, host attachments, iSCSI sessions, Fibre Channel ports and VM disk mappings. Host paths and array-side volume health are distinct sources.

Element: HyperVPrivateCloud.Capability.Storage.LogicalUnitQueueDepth.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HyperVPrivateCloud.Capability.Storage.HostAttachment. Parent health aspect: Health!System.Health.PerformanceState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: (Property[@Name=&#39;InstanceKey&#39;] = $Target/Property[Type=&quot;HyperVPrivateCloud.Capability.Storage.HostAttachment&quot;]/StorageId$ AND (Property[@Name=&#39;QueueDepthState&#39;] = Good OR Property[@Name=&#39;QueueDepthState&#39;] = NotApplicable))

Warning [Warning]: (Property[@Name=&#39;InstanceKey&#39;] = $Target/Property[Type=&quot;HyperVPrivateCloud.Capability.Storage.HostAttachment&quot;]/StorageId$ AND Property[@Name=&#39;QueueDepthState&#39;] = Warning)

Error [Critical]: (Property[@Name=&#39;InstanceKey&#39;] = $Target/Property[Type=&quot;HyperVPrivateCloud.Capability.Storage.HostAttachment&quot;]/StorageId$ AND Property[@Name=&#39;QueueDepthState&#39;] = Critical)

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: CapacityUsedCriticalPercent=90; CapacityUsedWarningPercent=80; ComputerName=$Target/Host/Property[Type=&quot;Windows!Microsoft.Windows.Computer&quot;]/PrincipalName$; CrcErrorRatePerHourCritical=25; CrcErrorRatePerHourWarning=5; CriticalPathCount=1; InstanceKey=$Target/Property[Type=&quot;HyperVPrivateCloud.Capability.Storage.HostAttachment&quot;]/StorageId$; IntervalSeconds=300; LinkFailureRatePerHourCritical=5; LinkFailureRatePerHourWarning=1; LossOfSignalRatePerHourCritical=5; LossOfSignalRatePerHourWarning=1; LossOfSyncRatePerHourCritical=5; LossOfSyncRatePerHourWarning=1; MinimumLinkSpeedGbps=8; MinimumPathCount=2; MinimumSessionsPerTarget=2; PathImbalancePercentCritical=70; PathImbalancePercentWarning=40; PropertyName=QueueDepthState; QueueDepthCritical=64; QueueDepthWarning=32; ReadLatencyCriticalMs=50; ReadLatencyWarningMs=20; SyncTime=; TimeoutSeconds=180; WriteLatencyCriticalMs=50; WriteLatencyWarningMs=20 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Warning; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Match stable disk/LUN and initiator identifiers before comparing Get-Disk, Get-IscsiSession, Get-IscsiConnection and MPIO path reports. For FC, retain HBA port identity and vendor driver counters. Correlate host System storage errors with switch zoning, masking and array events. Separate loss of one redundant path from complete I/O loss.

### Corrective action and escalation

Restore the identified fabric path or approved MPIO configuration with the storage and network teams. Use compatible HBA/NIC/array firmware guidance. Capacity remediation needs array and filesystem planning. Do not initialize, format, offline or reset a shared disk, or remove active sessions, as generic remediation.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm expected path count, stable sessions and LUN identity, normal I/O and recovered redundancy. Compare counter deltas after repair; historical cumulative counters may not reset.

### Microsoft references

[Microsoft Learn: iscsi storage connectivity troubleshooting](https://learn.microsoft.com/en-us/troubleshoot/windows-server/backup-and-storage/iscsi-storage-connectivity-troubleshooting)

[Microsoft Learn: troubleshoot data corruption and disk errors](https://learn.microsoft.com/en-us/troubleshoot/windows-server/backup-and-storage/troubleshoot-data-corruption-and-disk-errors)


## Windows SAN integration health {#hypervprivatecloud.capability.storage.integrationhealth.monitor}

`HyperVPrivateCloud.Capability.Storage.IntegrationHealth.Monitor`

Verifies Windows Storage, iSCSI, Fibre Channel, and MPIO query coverage.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.Fabric.Configuration.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.Fabric.Service.Configuration.Dependency.Monitor &gt; HyperVPrivateCloud.Service.Storage.Configuration.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.Storage.Participation.Configuration.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.Storage.IntegrationHealth.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

Verifies Windows Storage, iSCSI, Fibre Channel, and MPIO query coverage.

### Operator response

Install the required management tools, validate DSM claims and redundant paths, then review Operations Manager event 8403.

### Support scope

Host-visible SAN LUNs, host attachments, iSCSI sessions, Fibre Channel ports and VM disk mappings. Host paths and array-side volume health are distinct sources.

Element: HyperVPrivateCloud.Capability.Storage.IntegrationHealth.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HyperVPrivateCloud.Capability.Storage.HostParticipation. Parent health aspect: Health!System.Health.ConfigurationState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: (Property[@Name=&#39;StorageIntegrationState&#39;] = Good OR Property[@Name=&#39;StorageIntegrationState&#39;] = NotApplicable)

Warning [Warning]: Property[@Name=&#39;StorageIntegrationState&#39;] = Warning

Error [Critical]: Property[@Name=&#39;StorageIntegrationState&#39;] = Critical

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: ComputerName=$Target/Host/Property[Type=&quot;Windows!Microsoft.Windows.Computer&quot;]/PrincipalName$; IntervalSeconds=300; SyncTime=; TimeoutSeconds=120 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Error; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Match stable disk/LUN and initiator identifiers before comparing Get-Disk, Get-IscsiSession, Get-IscsiConnection and MPIO path reports. For FC, retain HBA port identity and vendor driver counters. Correlate host System storage errors with switch zoning, masking and array events. Separate loss of one redundant path from complete I/O loss.

### Corrective action and escalation

Restore the identified fabric path or approved MPIO configuration with the storage and network teams. Use compatible HBA/NIC/array firmware guidance. Capacity remediation needs array and filesystem planning. Do not initialize, format, offline or reset a shared disk, or remove active sessions, as generic remediation.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm expected path count, stable sessions and LUN identity, normal I/O and recovered redundancy. Compare counter deltas after repair; historical cumulative counters may not reset.

### Microsoft references

[Microsoft Learn: iscsi storage connectivity troubleshooting](https://learn.microsoft.com/en-us/troubleshoot/windows-server/backup-and-storage/iscsi-storage-connectivity-troubleshooting)

[Microsoft Learn: troubleshoot data corruption and disk errors](https://learn.microsoft.com/en-us/troubleshoot/windows-server/backup-and-storage/troubleshoot-data-corruption-and-disk-errors)


## SAN disk attachment availability {#hypervprivatecloud.capability.storage.attachmentavailability.monitor}

`HyperVPrivateCloud.Capability.Storage.AttachmentAvailability.Monitor`

Tracks Windows-visible SAN disk state and writability. Disabled by default: superseded by HyperVPrivateCloud.Capability.Storage.LogicalUnitOperationalStatus.Monitor, which evaluates the same condition with overridable thresholds; enable this monitor only if you disable the superseding one.

### Summary

Tracks Windows-visible SAN disk state and writability. Disabled by default: superseded by HyperVPrivateCloud.Capability.Storage.LogicalUnitOperationalStatus.Monitor, which evaluates the same condition with overridable thresholds; enable this monitor only if you disable the superseding one.

### Operator response

Validate the array presentation, fabric, Windows disk state, DSM, and recent storage events before returning the disk to service.

### Support scope

Host-visible SAN LUNs, host attachments, iSCSI sessions, Fibre Channel ports and VM disk mappings. Host paths and array-side volume health are distinct sources.

Element: HyperVPrivateCloud.Capability.Storage.AttachmentAvailability.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HyperVPrivateCloud.Capability.Storage.HostAttachment. Parent health aspect: Health!System.Health.AvailabilityState. Enabled by default: false. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: (Property[@Name=&#39;ObjectState&#39;] = Good OR Property[@Name=&#39;ObjectState&#39;] = NotApplicable)

Warning [Warning]: Property[@Name=&#39;ObjectState&#39;] = Warning

Error [Critical]: Property[@Name=&#39;ObjectState&#39;] = Critical

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: BusType=$Target/Property[Type=&quot;HyperVPrivateCloud.Capability.Storage.HostAttachment&quot;]/BusType$; DiskNumber=$Target/Property[Type=&quot;HyperVPrivateCloud.Capability.Storage.HostAttachment&quot;]/DiskNumber$; Identity=; IntervalSeconds=300; MinimumPathCount=2; ObjectKind=Attachment; PropertyName=ObjectState; StorageId=$Target/Property[Type=&quot;HyperVPrivateCloud.Capability.Storage.HostAttachment&quot;]/StorageId$; SyncTime=; TimeoutSeconds=120 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Error; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Match stable disk/LUN and initiator identifiers before comparing Get-Disk, Get-IscsiSession, Get-IscsiConnection and MPIO path reports. For FC, retain HBA port identity and vendor driver counters. Correlate host System storage errors with switch zoning, masking and array events. Separate loss of one redundant path from complete I/O loss.

### Corrective action and escalation

Restore the identified fabric path or approved MPIO configuration with the storage and network teams. Use compatible HBA/NIC/array firmware guidance. Capacity remediation needs array and filesystem planning. Do not initialize, format, offline or reset a shared disk, or remove active sessions, as generic remediation.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm expected path count, stable sessions and LUN identity, normal I/O and recovered redundancy. Compare counter deltas after repair; historical cumulative counters may not reset.

### Microsoft references

[Microsoft Learn: iscsi storage connectivity troubleshooting](https://learn.microsoft.com/en-us/troubleshoot/windows-server/backup-and-storage/iscsi-storage-connectivity-troubleshooting)

[Microsoft Learn: troubleshoot data corruption and disk errors](https://learn.microsoft.com/en-us/troubleshoot/windows-server/backup-and-storage/troubleshoot-data-corruption-and-disk-errors)


## SAN MPIO path redundancy {#hypervprivatecloud.capability.storage.attachmentredundancy.monitor}

`HyperVPrivateCloud.Capability.Storage.AttachmentRedundancy.Monitor`

Tracks MPIO path count for iSCSI and Fibre Channel disks. Disabled by default: superseded by HyperVPrivateCloud.Capability.Storage.MultipathPathCount.Monitor, which evaluates the same condition with overridable thresholds; enable this monitor only if you disable the superseding one.

### Summary

Tracks MPIO path count for iSCSI and Fibre Channel disks. Disabled by default: superseded by HyperVPrivateCloud.Capability.Storage.MultipathPathCount.Monitor, which evaluates the same condition with overridable thresholds; enable this monitor only if you disable the superseding one.

### Operator response

Inspect HBA or NIC links, switches, target ports, MPIO policy, and vendor DSM state. Do not change claiming policy without vendor guidance.

### Support scope

Host-visible SAN LUNs, host attachments, iSCSI sessions, Fibre Channel ports and VM disk mappings. Host paths and array-side volume health are distinct sources.

Element: HyperVPrivateCloud.Capability.Storage.AttachmentRedundancy.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HyperVPrivateCloud.Capability.Storage.HostAttachment. Parent health aspect: Health!System.Health.AvailabilityState. Enabled by default: false. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: (Property[@Name=&#39;RedundancyState&#39;] = Good OR Property[@Name=&#39;RedundancyState&#39;] = NotApplicable)

Warning [Warning]: Property[@Name=&#39;RedundancyState&#39;] = Warning

Error [Critical]: Property[@Name=&#39;RedundancyState&#39;] = Critical

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: BusType=$Target/Property[Type=&quot;HyperVPrivateCloud.Capability.Storage.HostAttachment&quot;]/BusType$; DiskNumber=$Target/Property[Type=&quot;HyperVPrivateCloud.Capability.Storage.HostAttachment&quot;]/DiskNumber$; Identity=; IntervalSeconds=300; MinimumPathCount=2; ObjectKind=Attachment; PropertyName=RedundancyState; StorageId=$Target/Property[Type=&quot;HyperVPrivateCloud.Capability.Storage.HostAttachment&quot;]/StorageId$; SyncTime=; TimeoutSeconds=120 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Warning; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Match stable disk/LUN and initiator identifiers before comparing Get-Disk, Get-IscsiSession, Get-IscsiConnection and MPIO path reports. For FC, retain HBA port identity and vendor driver counters. Correlate host System storage errors with switch zoning, masking and array events. Separate loss of one redundant path from complete I/O loss.

### Corrective action and escalation

Restore the identified fabric path or approved MPIO configuration with the storage and network teams. Use compatible HBA/NIC/array firmware guidance. Capacity remediation needs array and filesystem planning. Do not initialize, format, offline or reset a shared disk, or remove active sessions, as generic remediation.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm expected path count, stable sessions and LUN identity, normal I/O and recovered redundancy. Compare counter deltas after repair; historical cumulative counters may not reset.

### Microsoft references

[Microsoft Learn: iscsi storage connectivity troubleshooting](https://learn.microsoft.com/en-us/troubleshoot/windows-server/backup-and-storage/iscsi-storage-connectivity-troubleshooting)

[Microsoft Learn: troubleshoot data corruption and disk errors](https://learn.microsoft.com/en-us/troubleshoot/windows-server/backup-and-storage/troubleshoot-data-corruption-and-disk-errors)


## iSCSI session availability {#hypervprivatecloud.capability.storage.iscsisessionavailability.monitor}

`HyperVPrivateCloud.Capability.Storage.IscsiSessionAvailability.Monitor`

Tracks established iSCSI sessions and active connections. Disabled by default: superseded by HyperVPrivateCloud.Capability.Storage.IscsiSessionConnectedState.Monitor, which evaluates the same condition with overridable thresholds; enable this monitor only if you disable the superseding one.

### Summary

Tracks established iSCSI sessions and active connections. Disabled by default: superseded by HyperVPrivateCloud.Capability.Storage.IscsiSessionConnectedState.Monitor, which evaluates the same condition with overridable thresholds; enable this monitor only if you disable the superseding one.

### Operator response

Check initiator service state, target reachability, VLAN and MPIO design, authentication, and persistent-target configuration.

### Support scope

Host-visible SAN LUNs, host attachments, iSCSI sessions, Fibre Channel ports and VM disk mappings. Host paths and array-side volume health are distinct sources.

Element: HyperVPrivateCloud.Capability.Storage.IscsiSessionAvailability.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HyperVPrivateCloud.Capability.Storage.IscsiSession. Parent health aspect: Health!System.Health.AvailabilityState. Enabled by default: false. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: (Property[@Name=&#39;ObjectState&#39;] = Good OR Property[@Name=&#39;ObjectState&#39;] = NotApplicable)

Warning [Warning]: Property[@Name=&#39;ObjectState&#39;] = Warning

Error [Critical]: Property[@Name=&#39;ObjectState&#39;] = Critical

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: BusType=iSCSI; DiskNumber=0; Identity=$Target/Property[Type=&quot;HyperVPrivateCloud.Capability.Storage.IscsiSession&quot;]/SessionId$; IntervalSeconds=300; MinimumPathCount=1; ObjectKind=IscsiSession; PropertyName=ObjectState; StorageId=; SyncTime=; TimeoutSeconds=120 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Error; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Match stable disk/LUN and initiator identifiers before comparing Get-Disk, Get-IscsiSession, Get-IscsiConnection and MPIO path reports. For FC, retain HBA port identity and vendor driver counters. Correlate host System storage errors with switch zoning, masking and array events. Separate loss of one redundant path from complete I/O loss.

### Corrective action and escalation

Restore the identified fabric path or approved MPIO configuration with the storage and network teams. Use compatible HBA/NIC/array firmware guidance. Capacity remediation needs array and filesystem planning. Do not initialize, format, offline or reset a shared disk, or remove active sessions, as generic remediation.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm expected path count, stable sessions and LUN identity, normal I/O and recovered redundancy. Compare counter deltas after repair; historical cumulative counters may not reset.

### Microsoft references

[Microsoft Learn: iscsi storage connectivity troubleshooting](https://learn.microsoft.com/en-us/troubleshoot/windows-server/backup-and-storage/iscsi-storage-connectivity-troubleshooting)

[Microsoft Learn: troubleshoot data corruption and disk errors](https://learn.microsoft.com/en-us/troubleshoot/windows-server/backup-and-storage/troubleshoot-data-corruption-and-disk-errors)


## Fibre Channel port availability {#hypervprivatecloud.capability.storage.fibrechannelportavailability.monitor}

`HyperVPrivateCloud.Capability.Storage.FibreChannelPortAvailability.Monitor`

Tracks HBA provider and Fibre Channel port operational state. Disabled by default: superseded by HyperVPrivateCloud.Capability.Storage.FibreChannelPortLinkState.Monitor, which evaluates the same condition with overridable thresholds; enable this monitor only if you disable the superseding one.

### Summary

Tracks HBA provider and Fibre Channel port operational state. Disabled by default: superseded by HyperVPrivateCloud.Capability.Storage.FibreChannelPortLinkState.Monitor, which evaluates the same condition with overridable thresholds; enable this monitor only if you disable the superseding one.

### Operator response

Inspect HBA, driver, firmware, optic, cable, switch port, zoning, and array target-port state.

### Support scope

Host-visible SAN LUNs, host attachments, iSCSI sessions, Fibre Channel ports and VM disk mappings. Host paths and array-side volume health are distinct sources.

Element: HyperVPrivateCloud.Capability.Storage.FibreChannelPortAvailability.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HyperVPrivateCloud.Capability.Storage.FibreChannelPort. Parent health aspect: Health!System.Health.AvailabilityState. Enabled by default: false. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: (Property[@Name=&#39;ObjectState&#39;] = Good OR Property[@Name=&#39;ObjectState&#39;] = NotApplicable)

Warning [Warning]: Property[@Name=&#39;ObjectState&#39;] = Warning

Error [Critical]: Property[@Name=&#39;ObjectState&#39;] = Critical

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: BusType=Fibre Channel; DiskNumber=0; Identity=$Target/Property[Type=&quot;HyperVPrivateCloud.Capability.Storage.FibreChannelPort&quot;]/PortId$; IntervalSeconds=300; MinimumPathCount=1; ObjectKind=FibreChannelPort; PropertyName=ObjectState; StorageId=; SyncTime=; TimeoutSeconds=120 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Error; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Match stable disk/LUN and initiator identifiers before comparing Get-Disk, Get-IscsiSession, Get-IscsiConnection and MPIO path reports. For FC, retain HBA port identity and vendor driver counters. Correlate host System storage errors with switch zoning, masking and array events. Separate loss of one redundant path from complete I/O loss.

### Corrective action and escalation

Restore the identified fabric path or approved MPIO configuration with the storage and network teams. Use compatible HBA/NIC/array firmware guidance. Capacity remediation needs array and filesystem planning. Do not initialize, format, offline or reset a shared disk, or remove active sessions, as generic remediation.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm expected path count, stable sessions and LUN identity, normal I/O and recovered redundancy. Compare counter deltas after repair; historical cumulative counters may not reset.

### Microsoft references

[Microsoft Learn: iscsi storage connectivity troubleshooting](https://learn.microsoft.com/en-us/troubleshoot/windows-server/backup-and-storage/iscsi-storage-connectivity-troubleshooting)

[Microsoft Learn: troubleshoot data corruption and disk errors](https://learn.microsoft.com/en-us/troubleshoot/windows-server/backup-and-storage/troubleshoot-data-corruption-and-disk-errors)


## Roll up host attachment health to the logical unit {#hypervprivatecloud.capability.storage.logicalunit.attachment.dependency.monitor}

`HyperVPrivateCloud.Capability.Storage.LogicalUnit.Attachment.Dependency.Monitor`

Rolls the worst host-attachment availability state up to the SAN logical unit.

### Support scope

Host-visible SAN LUNs, host attachments, iSCSI sessions, Fibre Channel ports and VM disk mappings. Host paths and array-side volume health are distinct sources.

Element: HyperVPrivateCloud.Capability.Storage.LogicalUnit.Attachment.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HyperVPrivateCloud.Capability.Storage.LogicalUnit; relationship=HyperVPrivateCloud.Capability.Storage.LogicalUnitContainsAttachment; member monitor=Health!System.Health.AvailabilityState; parent=Health!System.Health.AvailabilityState; algorithm=WorstOf; unavailable-member policy=Success. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Match stable disk/LUN and initiator identifiers before comparing Get-Disk, Get-IscsiSession, Get-IscsiConnection and MPIO path reports. For FC, retain HBA port identity and vendor driver counters. Correlate host System storage errors with switch zoning, masking and array events. Separate loss of one redundant path from complete I/O loss.

### Corrective action and escalation

Restore the identified fabric path or approved MPIO configuration with the storage and network teams. Use compatible HBA/NIC/array firmware guidance. Capacity remediation needs array and filesystem planning. Do not initialize, format, offline or reset a shared disk, or remove active sessions, as generic remediation.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm expected path count, stable sessions and LUN identity, normal I/O and recovered redundancy. Compare counter deltas after repair; historical cumulative counters may not reset.

### Microsoft references

[Microsoft Learn: iscsi storage connectivity troubleshooting](https://learn.microsoft.com/en-us/troubleshoot/windows-server/backup-and-storage/iscsi-storage-connectivity-troubleshooting)

[Microsoft Learn: troubleshoot data corruption and disk errors](https://learn.microsoft.com/en-us/troubleshoot/windows-server/backup-and-storage/troubleshoot-data-corruption-and-disk-errors)


## Host attachment health rollup {#hypervprivatecloud.capability.storage.attachment.dependency.monitor}

`HyperVPrivateCloud.Capability.Storage.Attachment.Dependency.Monitor`

Rolls the health of each host storage attachment into the private-cloud storage component.

### Support scope

Host-visible SAN LUNs, host attachments, iSCSI sessions, Fibre Channel ports and VM disk mappings. Host paths and array-side volume health are distinct sources.

Element: HyperVPrivateCloud.Capability.Storage.Attachment.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.StorageComponent; relationship=HyperVPrivateCloud.Capability.Storage.ComponentContainsAttachment; member monitor=Health!System.Health.AvailabilityState; parent=Health!System.Health.AvailabilityState; algorithm=WorstOf; unavailable-member policy=Success. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Match stable disk/LUN and initiator identifiers before comparing Get-Disk, Get-IscsiSession, Get-IscsiConnection and MPIO path reports. For FC, retain HBA port identity and vendor driver counters. Correlate host System storage errors with switch zoning, masking and array events. Separate loss of one redundant path from complete I/O loss.

### Corrective action and escalation

Restore the identified fabric path or approved MPIO configuration with the storage and network teams. Use compatible HBA/NIC/array firmware guidance. Capacity remediation needs array and filesystem planning. Do not initialize, format, offline or reset a shared disk, or remove active sessions, as generic remediation.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm expected path count, stable sessions and LUN identity, normal I/O and recovered redundancy. Compare counter deltas after repair; historical cumulative counters may not reset.

### Microsoft references

[Microsoft Learn: iscsi storage connectivity troubleshooting](https://learn.microsoft.com/en-us/troubleshoot/windows-server/backup-and-storage/iscsi-storage-connectivity-troubleshooting)

[Microsoft Learn: troubleshoot data corruption and disk errors](https://learn.microsoft.com/en-us/troubleshoot/windows-server/backup-and-storage/troubleshoot-data-corruption-and-disk-errors)


## iSCSI session health rollup {#hypervprivatecloud.capability.storage.iscsisession.dependency.monitor}

`HyperVPrivateCloud.Capability.Storage.IscsiSession.Dependency.Monitor`

Rolls the health of each discovered iSCSI session into the private-cloud storage component.

### Support scope

Host-visible SAN LUNs, host attachments, iSCSI sessions, Fibre Channel ports and VM disk mappings. Host paths and array-side volume health are distinct sources.

Element: HyperVPrivateCloud.Capability.Storage.IscsiSession.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.StorageComponent; relationship=HyperVPrivateCloud.Capability.Storage.ComponentContainsIscsiSession; member monitor=Health!System.Health.AvailabilityState; parent=Health!System.Health.AvailabilityState; algorithm=WorstOf; unavailable-member policy=Success. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Match stable disk/LUN and initiator identifiers before comparing Get-Disk, Get-IscsiSession, Get-IscsiConnection and MPIO path reports. For FC, retain HBA port identity and vendor driver counters. Correlate host System storage errors with switch zoning, masking and array events. Separate loss of one redundant path from complete I/O loss.

### Corrective action and escalation

Restore the identified fabric path or approved MPIO configuration with the storage and network teams. Use compatible HBA/NIC/array firmware guidance. Capacity remediation needs array and filesystem planning. Do not initialize, format, offline or reset a shared disk, or remove active sessions, as generic remediation.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm expected path count, stable sessions and LUN identity, normal I/O and recovered redundancy. Compare counter deltas after repair; historical cumulative counters may not reset.

### Microsoft references

[Microsoft Learn: iscsi storage connectivity troubleshooting](https://learn.microsoft.com/en-us/troubleshoot/windows-server/backup-and-storage/iscsi-storage-connectivity-troubleshooting)

[Microsoft Learn: troubleshoot data corruption and disk errors](https://learn.microsoft.com/en-us/troubleshoot/windows-server/backup-and-storage/troubleshoot-data-corruption-and-disk-errors)


## Fibre Channel port health rollup {#hypervprivatecloud.capability.storage.fibrechannelport.dependency.monitor}

`HyperVPrivateCloud.Capability.Storage.FibreChannelPort.Dependency.Monitor`

Rolls the health of each discovered Fibre Channel port into the private-cloud storage component.

### Support scope

Host-visible SAN LUNs, host attachments, iSCSI sessions, Fibre Channel ports and VM disk mappings. Host paths and array-side volume health are distinct sources.

Element: HyperVPrivateCloud.Capability.Storage.FibreChannelPort.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.StorageComponent; relationship=HyperVPrivateCloud.Capability.Storage.ComponentContainsFibreChannelPort; member monitor=Health!System.Health.AvailabilityState; parent=Health!System.Health.AvailabilityState; algorithm=WorstOf; unavailable-member policy=Success. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Match stable disk/LUN and initiator identifiers before comparing Get-Disk, Get-IscsiSession, Get-IscsiConnection and MPIO path reports. For FC, retain HBA port identity and vendor driver counters. Correlate host System storage errors with switch zoning, masking and array events. Separate loss of one redundant path from complete I/O loss.

### Corrective action and escalation

Restore the identified fabric path or approved MPIO configuration with the storage and network teams. Use compatible HBA/NIC/array firmware guidance. Capacity remediation needs array and filesystem planning. Do not initialize, format, offline or reset a shared disk, or remove active sessions, as generic remediation.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm expected path count, stable sessions and LUN identity, normal I/O and recovered redundancy. Compare counter deltas after repair; historical cumulative counters may not reset.

### Microsoft references

[Microsoft Learn: iscsi storage connectivity troubleshooting](https://learn.microsoft.com/en-us/troubleshoot/windows-server/backup-and-storage/iscsi-storage-connectivity-troubleshooting)

[Microsoft Learn: troubleshoot data corruption and disk errors](https://learn.microsoft.com/en-us/troubleshoot/windows-server/backup-and-storage/troubleshoot-data-corruption-and-disk-errors)


## Roll up Performance through Storage.ComponentContainsAttachment {#hypervprivatecloud.capability.storage.attachment.performance.dependency.monitor}

`HyperVPrivateCloud.Capability.Storage.Attachment.Performance.Dependency.Monitor`

Preserves the originating health aspect through this domain dependency. Open the unhealthy member monitor for the actual cause; this rollup does not create a second incident.

### Support scope

Host-visible SAN LUNs, host attachments, iSCSI sessions, Fibre Channel ports and VM disk mappings. Host paths and array-side volume health are distinct sources.

Element: HyperVPrivateCloud.Capability.Storage.Attachment.Performance.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.StorageComponent; relationship=HyperVPrivateCloud.Capability.Storage.ComponentContainsAttachment; member monitor=Health!System.Health.PerformanceState; parent=Health!System.Health.PerformanceState; algorithm=WorstOf; unavailable-member policy=Success. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Match stable disk/LUN and initiator identifiers before comparing Get-Disk, Get-IscsiSession, Get-IscsiConnection and MPIO path reports. For FC, retain HBA port identity and vendor driver counters. Correlate host System storage errors with switch zoning, masking and array events. Separate loss of one redundant path from complete I/O loss.

### Corrective action and escalation

Restore the identified fabric path or approved MPIO configuration with the storage and network teams. Use compatible HBA/NIC/array firmware guidance. Capacity remediation needs array and filesystem planning. Do not initialize, format, offline or reset a shared disk, or remove active sessions, as generic remediation.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm expected path count, stable sessions and LUN identity, normal I/O and recovered redundancy. Compare counter deltas after repair; historical cumulative counters may not reset.

### Microsoft references

[Microsoft Learn: iscsi storage connectivity troubleshooting](https://learn.microsoft.com/en-us/troubleshoot/windows-server/backup-and-storage/iscsi-storage-connectivity-troubleshooting)

[Microsoft Learn: troubleshoot data corruption and disk errors](https://learn.microsoft.com/en-us/troubleshoot/windows-server/backup-and-storage/troubleshoot-data-corruption-and-disk-errors)


## Roll up Performance through Storage.ComponentContainsFibreChannelPort {#hypervprivatecloud.capability.storage.fibrechannelport.performance.dependency.monitor}

`HyperVPrivateCloud.Capability.Storage.FibreChannelPort.Performance.Dependency.Monitor`

Preserves the originating health aspect through this domain dependency. Open the unhealthy member monitor for the actual cause; this rollup does not create a second incident.

### Support scope

Host-visible SAN LUNs, host attachments, iSCSI sessions, Fibre Channel ports and VM disk mappings. Host paths and array-side volume health are distinct sources.

Element: HyperVPrivateCloud.Capability.Storage.FibreChannelPort.Performance.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.StorageComponent; relationship=HyperVPrivateCloud.Capability.Storage.ComponentContainsFibreChannelPort; member monitor=Health!System.Health.PerformanceState; parent=Health!System.Health.PerformanceState; algorithm=WorstOf; unavailable-member policy=Success. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Match stable disk/LUN and initiator identifiers before comparing Get-Disk, Get-IscsiSession, Get-IscsiConnection and MPIO path reports. For FC, retain HBA port identity and vendor driver counters. Correlate host System storage errors with switch zoning, masking and array events. Separate loss of one redundant path from complete I/O loss.

### Corrective action and escalation

Restore the identified fabric path or approved MPIO configuration with the storage and network teams. Use compatible HBA/NIC/array firmware guidance. Capacity remediation needs array and filesystem planning. Do not initialize, format, offline or reset a shared disk, or remove active sessions, as generic remediation.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm expected path count, stable sessions and LUN identity, normal I/O and recovered redundancy. Compare counter deltas after repair; historical cumulative counters may not reset.

### Microsoft references

[Microsoft Learn: iscsi storage connectivity troubleshooting](https://learn.microsoft.com/en-us/troubleshoot/windows-server/backup-and-storage/iscsi-storage-connectivity-troubleshooting)

[Microsoft Learn: troubleshoot data corruption and disk errors](https://learn.microsoft.com/en-us/troubleshoot/windows-server/backup-and-storage/troubleshoot-data-corruption-and-disk-errors)


## Roll up Availability through Storage.ComponentContainsHostParticipation {#hypervprivatecloud.capability.storage.participation.availability.dependency.monitor}

`HyperVPrivateCloud.Capability.Storage.Participation.Availability.Dependency.Monitor`

Preserves the originating health aspect through this domain dependency. Open the unhealthy member monitor for the actual cause; this rollup does not create a second incident.

### Support scope

Host-visible SAN LUNs, host attachments, iSCSI sessions, Fibre Channel ports and VM disk mappings. Host paths and array-side volume health are distinct sources.

Element: HyperVPrivateCloud.Capability.Storage.Participation.Availability.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.StorageComponent; relationship=HyperVPrivateCloud.Capability.Storage.ComponentContainsHostParticipation; member monitor=Health!System.Health.AvailabilityState; parent=Health!System.Health.AvailabilityState; algorithm=WorstOf; unavailable-member policy=Success. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Match stable disk/LUN and initiator identifiers before comparing Get-Disk, Get-IscsiSession, Get-IscsiConnection and MPIO path reports. For FC, retain HBA port identity and vendor driver counters. Correlate host System storage errors with switch zoning, masking and array events. Separate loss of one redundant path from complete I/O loss.

### Corrective action and escalation

Restore the identified fabric path or approved MPIO configuration with the storage and network teams. Use compatible HBA/NIC/array firmware guidance. Capacity remediation needs array and filesystem planning. Do not initialize, format, offline or reset a shared disk, or remove active sessions, as generic remediation.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm expected path count, stable sessions and LUN identity, normal I/O and recovered redundancy. Compare counter deltas after repair; historical cumulative counters may not reset.

### Microsoft references

[Microsoft Learn: iscsi storage connectivity troubleshooting](https://learn.microsoft.com/en-us/troubleshoot/windows-server/backup-and-storage/iscsi-storage-connectivity-troubleshooting)

[Microsoft Learn: troubleshoot data corruption and disk errors](https://learn.microsoft.com/en-us/troubleshoot/windows-server/backup-and-storage/troubleshoot-data-corruption-and-disk-errors)


## Roll up Performance through Storage.ComponentContainsHostParticipation {#hypervprivatecloud.capability.storage.participation.performance.dependency.monitor}

`HyperVPrivateCloud.Capability.Storage.Participation.Performance.Dependency.Monitor`

Preserves the originating health aspect through this domain dependency. Open the unhealthy member monitor for the actual cause; this rollup does not create a second incident.

### Support scope

Host-visible SAN LUNs, host attachments, iSCSI sessions, Fibre Channel ports and VM disk mappings. Host paths and array-side volume health are distinct sources.

Element: HyperVPrivateCloud.Capability.Storage.Participation.Performance.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.StorageComponent; relationship=HyperVPrivateCloud.Capability.Storage.ComponentContainsHostParticipation; member monitor=Health!System.Health.PerformanceState; parent=Health!System.Health.PerformanceState; algorithm=WorstOf; unavailable-member policy=Success. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Match stable disk/LUN and initiator identifiers before comparing Get-Disk, Get-IscsiSession, Get-IscsiConnection and MPIO path reports. For FC, retain HBA port identity and vendor driver counters. Correlate host System storage errors with switch zoning, masking and array events. Separate loss of one redundant path from complete I/O loss.

### Corrective action and escalation

Restore the identified fabric path or approved MPIO configuration with the storage and network teams. Use compatible HBA/NIC/array firmware guidance. Capacity remediation needs array and filesystem planning. Do not initialize, format, offline or reset a shared disk, or remove active sessions, as generic remediation.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm expected path count, stable sessions and LUN identity, normal I/O and recovered redundancy. Compare counter deltas after repair; historical cumulative counters may not reset.

### Microsoft references

[Microsoft Learn: iscsi storage connectivity troubleshooting](https://learn.microsoft.com/en-us/troubleshoot/windows-server/backup-and-storage/iscsi-storage-connectivity-troubleshooting)

[Microsoft Learn: troubleshoot data corruption and disk errors](https://learn.microsoft.com/en-us/troubleshoot/windows-server/backup-and-storage/troubleshoot-data-corruption-and-disk-errors)


## Roll up Configuration through Storage.ComponentContainsHostParticipation {#hypervprivatecloud.capability.storage.participation.configuration.dependency.monitor}

`HyperVPrivateCloud.Capability.Storage.Participation.Configuration.Dependency.Monitor`

Preserves the originating health aspect through this domain dependency. Open the unhealthy member monitor for the actual cause; this rollup does not create a second incident.

### Support scope

Host-visible SAN LUNs, host attachments, iSCSI sessions, Fibre Channel ports and VM disk mappings. Host paths and array-side volume health are distinct sources.

Element: HyperVPrivateCloud.Capability.Storage.Participation.Configuration.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.StorageComponent; relationship=HyperVPrivateCloud.Capability.Storage.ComponentContainsHostParticipation; member monitor=Health!System.Health.ConfigurationState; parent=Health!System.Health.ConfigurationState; algorithm=WorstOf; unavailable-member policy=Success. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Match stable disk/LUN and initiator identifiers before comparing Get-Disk, Get-IscsiSession, Get-IscsiConnection and MPIO path reports. For FC, retain HBA port identity and vendor driver counters. Correlate host System storage errors with switch zoning, masking and array events. Separate loss of one redundant path from complete I/O loss.

### Corrective action and escalation

Restore the identified fabric path or approved MPIO configuration with the storage and network teams. Use compatible HBA/NIC/array firmware guidance. Capacity remediation needs array and filesystem planning. Do not initialize, format, offline or reset a shared disk, or remove active sessions, as generic remediation.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm expected path count, stable sessions and LUN identity, normal I/O and recovered redundancy. Compare counter deltas after repair; historical cumulative counters may not reset.

### Microsoft references

[Microsoft Learn: iscsi storage connectivity troubleshooting](https://learn.microsoft.com/en-us/troubleshoot/windows-server/backup-and-storage/iscsi-storage-connectivity-troubleshooting)

[Microsoft Learn: troubleshoot data corruption and disk errors](https://learn.microsoft.com/en-us/troubleshoot/windows-server/backup-and-storage/troubleshoot-data-corruption-and-disk-errors)


## Roll up Security through Storage.ComponentContainsHostParticipation {#hypervprivatecloud.capability.storage.participation.security.dependency.monitor}

`HyperVPrivateCloud.Capability.Storage.Participation.Security.Dependency.Monitor`

Preserves the originating health aspect through this domain dependency. Open the unhealthy member monitor for the actual cause; this rollup does not create a second incident.

### Support scope

Host-visible SAN LUNs, host attachments, iSCSI sessions, Fibre Channel ports and VM disk mappings. Host paths and array-side volume health are distinct sources.

Element: HyperVPrivateCloud.Capability.Storage.Participation.Security.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.StorageComponent; relationship=HyperVPrivateCloud.Capability.Storage.ComponentContainsHostParticipation; member monitor=Health!System.Health.SecurityState; parent=Health!System.Health.SecurityState; algorithm=WorstOf; unavailable-member policy=Success. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Match stable disk/LUN and initiator identifiers before comparing Get-Disk, Get-IscsiSession, Get-IscsiConnection and MPIO path reports. For FC, retain HBA port identity and vendor driver counters. Correlate host System storage errors with switch zoning, masking and array events. Separate loss of one redundant path from complete I/O loss.

### Corrective action and escalation

Restore the identified fabric path or approved MPIO configuration with the storage and network teams. Use compatible HBA/NIC/array firmware guidance. Capacity remediation needs array and filesystem planning. Do not initialize, format, offline or reset a shared disk, or remove active sessions, as generic remediation.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Confirm expected path count, stable sessions and LUN identity, normal I/O and recovered redundancy. Compare counter deltas after repair; historical cumulative counters may not reset.

### Microsoft references

[Microsoft Learn: iscsi storage connectivity troubleshooting](https://learn.microsoft.com/en-us/troubleshoot/windows-server/backup-and-storage/iscsi-storage-connectivity-troubleshooting)

[Microsoft Learn: troubleshoot data corruption and disk errors](https://learn.microsoft.com/en-us/troubleshoot/windows-server/backup-and-storage/troubleshoot-data-corruption-and-disk-errors)
