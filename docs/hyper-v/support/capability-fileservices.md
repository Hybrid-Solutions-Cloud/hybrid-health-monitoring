# Hyper-V Private Cloud Monitoring - SMB and SOFS Integration

Generated support reference. [All capabilities](catalog.md) · [Day-2 triage](index.md).

Default conditions below come from the compiled candidate source, not the effective overrides in your management group. Read the monitor-specific knowledge together with the common safety and verification guidance. Microsoft links explain the underlying technology; product thresholds are not Microsoft recommendations.

## Hyper-V Host SMB Storage Participation {#hypervprivatecloud.capability.fileservices.hostparticipation}

`HyperVPrivateCloud.Capability.FileServices.HostParticipation`

Host participation in SMB-backed VM storage. It gates SMB monitoring to relevant hosts and separates absent capability from a failed SMB query.

### Support scope

Hyper-V storage over SMB: client/server participation, share and VHDX mappings, sessions, security policy, continuous availability, witness and multichannel resilience.

Element: HyperVPrivateCloud.Capability.FileServices.HostParticipation. Kind: ClassType.

### Identity and monitoring ownership

Base class=Windows!Microsoft.Windows.LocalApplication; hosted=true; singleton=false; declared properties=ParticipationId, UncBackedDiskCount, ShareCount. Inherited properties also apply. Inspect the exact instance and its monitoring path; inventory-only classes do not acquire health merely by appearing in a diagram.

### Read-only investigation

Identify the client host and exact server/share path. Inspect Get-SmbConnection, Get-SmbMultichannelConnection and the matching share on its server; compare negotiated signing, encryption and continuous-availability properties with policy. Correlate SMBClient/SMBServer event channels, latency and transport errors. A client-side test alone cannot prove the server service is stopped.

### Corrective action and escalation

Restore the affected SMB service, path or network after impact review; correct share permissions and authentication with the file-services team. Preserve security requirements. Never enable SMB1, disable signing/encryption or disconnect all SMB sessions to make a monitor green.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Verify the intended share and VM disk are reachable, required security and redundancy are negotiated, errors stop and representative I/O recovers.

### What this object represents

Host participation in SMB-backed VM storage. It gates SMB monitoring to relevant hosts and separates absent capability from a failed SMB query.

### Microsoft references

[Microsoft Learn: troubleshoot smb guidance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/networking/troubleshoot-smb-guidance)

[Microsoft Learn: storage issues in hyper v and windows server failover clusters](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/storage-issues-in-hyper-v-and-windows-server-failover-clusters)


## File Services Smb Share {#hypervprivatecloud.capability.fileservices.smbshare}

`HyperVPrivateCloud.Capability.FileServices.SmbShare`

SMB share identity used by the private-cloud topology. Match server and share, and distinguish client-observed access from native file-server service health.

### Support scope

Hyper-V storage over SMB: client/server participation, share and VHDX mappings, sessions, security policy, continuous availability, witness and multichannel resilience.

Element: HyperVPrivateCloud.Capability.FileServices.SmbShare. Kind: ClassType.

### Identity and monitoring ownership

Base class=System!System.LogicalEntity; hosted=false; singleton=false; declared properties=BoundaryId, ShareId, UncPath, ServerName, ShareName, Dialect, ContinuouslyAvailable. Inherited properties also apply. Inspect the exact instance and its monitoring path; inventory-only classes do not acquire health merely by appearing in a diagram.

### Read-only investigation

Identify the client host and exact server/share path. Inspect Get-SmbConnection, Get-SmbMultichannelConnection and the matching share on its server; compare negotiated signing, encryption and continuous-availability properties with policy. Correlate SMBClient/SMBServer event channels, latency and transport errors. A client-side test alone cannot prove the server service is stopped.

### Corrective action and escalation

Restore the affected SMB service, path or network after impact review; correct share permissions and authentication with the file-services team. Preserve security requirements. Never enable SMB1, disable signing/encryption or disconnect all SMB sessions to make a monitor green.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Verify the intended share and VM disk are reachable, required security and redundancy are negotiated, errors stop and representative I/O recovers.

### What this object represents

SMB share identity used by the private-cloud topology. Match server and share, and distinguish client-observed access from native file-server service health.

### Microsoft references

[Microsoft Learn: troubleshoot smb guidance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/networking/troubleshoot-smb-guidance)

[Microsoft Learn: storage issues in hyper v and windows server failover clusters](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/storage-issues-in-hyper-v-and-windows-server-failover-clusters)


## File Services Smb Client Path {#hypervprivatecloud.capability.fileservices.smbclientpath}

`HyperVPrivateCloud.Capability.FileServices.SmbClientPath`

Client-to-SMB-server storage path. Its identity helps correlate sessions and multichannel paths; inspect the actual monitor target before treating a host-wide count as a path-specific failure.

### Support scope

Hyper-V storage over SMB: client/server participation, share and VHDX mappings, sessions, security policy, continuous availability, witness and multichannel resilience.

Element: HyperVPrivateCloud.Capability.FileServices.SmbClientPath. Kind: ClassType.

### Identity and monitoring ownership

Base class=System!System.LogicalEntity; hosted=false; singleton=false; declared properties=BoundaryId, PathId, ShareId, HostId, ClientIPAddress, ServerIPAddress, ClientInterfaceIndex, ServerInterfaceIndex, ClientRdmaCapable, ServerRdmaCapable, Selected, State. Inherited properties also apply. Inspect the exact instance and its monitoring path; inventory-only classes do not acquire health merely by appearing in a diagram.

### Read-only investigation

Identify the client host and exact server/share path. Inspect Get-SmbConnection, Get-SmbMultichannelConnection and the matching share on its server; compare negotiated signing, encryption and continuous-availability properties with policy. Correlate SMBClient/SMBServer event channels, latency and transport errors. A client-side test alone cannot prove the server service is stopped.

### Corrective action and escalation

Restore the affected SMB service, path or network after impact review; correct share permissions and authentication with the file-services team. Preserve security requirements. Never enable SMB1, disable signing/encryption or disconnect all SMB sessions to make a monitor green.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Verify the intended share and VM disk are reachable, required security and redundancy are negotiated, errors stop and representative I/O recovers.

### What this object represents

Client-to-SMB-server storage path. Its identity helps correlate sessions and multichannel paths; inspect the actual monitor target before treating a host-wide count as a path-specific failure.

### Microsoft references

[Microsoft Learn: troubleshoot smb guidance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/networking/troubleshoot-smb-guidance)

[Microsoft Learn: storage issues in hyper v and windows server failover clusters](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/storage-issues-in-hyper-v-and-windows-server-failover-clusters)


## File Services Smb Vhdx Mapping {#hypervprivatecloud.capability.fileservices.smbvhdxmapping}

`HyperVPrivateCloud.Capability.FileServices.SmbVhdxMapping`

Inventory mapping from VM virtual disk storage to an SMB path. It provides impact correlation, not an independent filesystem or guest-disk health probe.

### Support scope

Hyper-V storage over SMB: client/server participation, share and VHDX mappings, sessions, security policy, continuous availability, witness and multichannel resilience.

Element: HyperVPrivateCloud.Capability.FileServices.SmbVhdxMapping. Kind: ClassType.

### Identity and monitoring ownership

Base class=System!System.LogicalEntity; hosted=false; singleton=false; declared properties=BoundaryId, MappingId, ShareId, VMId, DiskId, VhdPath. Inherited properties also apply. Inspect the exact instance and its monitoring path; inventory-only classes do not acquire health merely by appearing in a diagram.

### Read-only investigation

Identify the client host and exact server/share path. Inspect Get-SmbConnection, Get-SmbMultichannelConnection and the matching share on its server; compare negotiated signing, encryption and continuous-availability properties with policy. Correlate SMBClient/SMBServer event channels, latency and transport errors. A client-side test alone cannot prove the server service is stopped.

### Corrective action and escalation

Restore the affected SMB service, path or network after impact review; correct share permissions and authentication with the file-services team. Preserve security requirements. Never enable SMB1, disable signing/encryption or disconnect all SMB sessions to make a monitor green.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Verify the intended share and VM disk are reachable, required security and redundancy are negotiated, errors stop and representative I/O recovers.

### What this object represents

Inventory mapping from VM virtual disk storage to an SMB path. It provides impact correlation, not an independent filesystem or guest-disk health probe.

### Microsoft references

[Microsoft Learn: troubleshoot smb guidance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/networking/troubleshoot-smb-guidance)

[Microsoft Learn: storage issues in hyper v and windows server failover clusters](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/storage-issues-in-hyper-v-and-windows-server-failover-clusters)


## Collect SMB client read throughput {#hypervprivatecloud.capability.fileservices.smbclientreadbytes.collection.rule}

`HyperVPrivateCloud.Capability.FileServices.SmbClientReadBytes.Collection.Rule`

Collects SMB Client Shares\Read Bytes/sec for every connected share every 300 seconds.

### Support scope

Hyper-V storage over SMB: client/server participation, share and VHDX mappings, sessions, security policy, continuous availability, witness and multichannel resilience.

Element: HyperVPrivateCloud.Capability.FileServices.SmbClientReadBytes.Collection.Rule. Kind: Rule.

### Alert versus health

Target=HCSV2Library!HyperVPrivateCloud.HostRole; enabled=true; category=PerformanceCollection. Rules collect data or raise event alerts; they do not themselves create unit-monitor health transitions. Repeated or unresolved rule alerts do not by themselves explain a red DA. Correlate with current leaf monitors and event timestamps before closure.

### Read-only investigation

Identify the client host and exact server/share path. Inspect Get-SmbConnection, Get-SmbMultichannelConnection and the matching share on its server; compare negotiated signing, encryption and continuous-availability properties with policy. Correlate SMBClient/SMBServer event channels, latency and transport errors. A client-side test alone cannot prove the server service is stopped.

### Corrective action and escalation

Restore the affected SMB service, path or network after impact review; correct share permissions and authentication with the file-services team. Preserve security requirements. Never enable SMB1, disable signing/encryption or disconnect all SMB sessions to make a monitor green.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Verify the intended share and VM disk are reachable, required security and redundancy are negotiated, errors stop and representative I/O recovers.

### Microsoft references

[Microsoft Learn: troubleshoot smb guidance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/networking/troubleshoot-smb-guidance)

[Microsoft Learn: storage issues in hyper v and windows server failover clusters](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/storage-issues-in-hyper-v-and-windows-server-failover-clusters)


## Collect SMB client write throughput {#hypervprivatecloud.capability.fileservices.smbclientwritebytes.collection.rule}

`HyperVPrivateCloud.Capability.FileServices.SmbClientWriteBytes.Collection.Rule`

Collects SMB Client Shares\Write Bytes/sec for every connected share every 300 seconds.

### Support scope

Hyper-V storage over SMB: client/server participation, share and VHDX mappings, sessions, security policy, continuous availability, witness and multichannel resilience.

Element: HyperVPrivateCloud.Capability.FileServices.SmbClientWriteBytes.Collection.Rule. Kind: Rule.

### Alert versus health

Target=HCSV2Library!HyperVPrivateCloud.HostRole; enabled=true; category=PerformanceCollection. Rules collect data or raise event alerts; they do not themselves create unit-monitor health transitions. Repeated or unresolved rule alerts do not by themselves explain a red DA. Correlate with current leaf monitors and event timestamps before closure.

### Read-only investigation

Identify the client host and exact server/share path. Inspect Get-SmbConnection, Get-SmbMultichannelConnection and the matching share on its server; compare negotiated signing, encryption and continuous-availability properties with policy. Correlate SMBClient/SMBServer event channels, latency and transport errors. A client-side test alone cannot prove the server service is stopped.

### Corrective action and escalation

Restore the affected SMB service, path or network after impact review; correct share permissions and authentication with the file-services team. Preserve security requirements. Never enable SMB1, disable signing/encryption or disconnect all SMB sessions to make a monitor green.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Verify the intended share and VM disk are reachable, required security and redundancy are negotiated, errors stop and representative I/O recovers.

### Microsoft references

[Microsoft Learn: troubleshoot smb guidance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/networking/troubleshoot-smb-guidance)

[Microsoft Learn: storage issues in hyper v and windows server failover clusters](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/storage-issues-in-hyper-v-and-windows-server-failover-clusters)


## Collect SMB client read latency {#hypervprivatecloud.capability.fileservices.smbclientreadlatency.collection.rule}

`HyperVPrivateCloud.Capability.FileServices.SmbClientReadLatency.Collection.Rule`

Collects SMB Client Shares\Avg. sec/Read for every connected share every 300 seconds.

### Support scope

Hyper-V storage over SMB: client/server participation, share and VHDX mappings, sessions, security policy, continuous availability, witness and multichannel resilience.

Element: HyperVPrivateCloud.Capability.FileServices.SmbClientReadLatency.Collection.Rule. Kind: Rule.

### Alert versus health

Target=HCSV2Library!HyperVPrivateCloud.HostRole; enabled=true; category=PerformanceCollection. Rules collect data or raise event alerts; they do not themselves create unit-monitor health transitions. Repeated or unresolved rule alerts do not by themselves explain a red DA. Correlate with current leaf monitors and event timestamps before closure.

### Read-only investigation

Identify the client host and exact server/share path. Inspect Get-SmbConnection, Get-SmbMultichannelConnection and the matching share on its server; compare negotiated signing, encryption and continuous-availability properties with policy. Correlate SMBClient/SMBServer event channels, latency and transport errors. A client-side test alone cannot prove the server service is stopped.

### Corrective action and escalation

Restore the affected SMB service, path or network after impact review; correct share permissions and authentication with the file-services team. Preserve security requirements. Never enable SMB1, disable signing/encryption or disconnect all SMB sessions to make a monitor green.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Verify the intended share and VM disk are reachable, required security and redundancy are negotiated, errors stop and representative I/O recovers.

### Microsoft references

[Microsoft Learn: troubleshoot smb guidance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/networking/troubleshoot-smb-guidance)

[Microsoft Learn: storage issues in hyper v and windows server failover clusters](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/storage-issues-in-hyper-v-and-windows-server-failover-clusters)


## Collect SMB client write latency {#hypervprivatecloud.capability.fileservices.smbclientwritelatency.collection.rule}

`HyperVPrivateCloud.Capability.FileServices.SmbClientWriteLatency.Collection.Rule`

Collects SMB Client Shares\Avg. sec/Write for every connected share every 300 seconds.

### Support scope

Hyper-V storage over SMB: client/server participation, share and VHDX mappings, sessions, security policy, continuous availability, witness and multichannel resilience.

Element: HyperVPrivateCloud.Capability.FileServices.SmbClientWriteLatency.Collection.Rule. Kind: Rule.

### Alert versus health

Target=HCSV2Library!HyperVPrivateCloud.HostRole; enabled=true; category=PerformanceCollection. Rules collect data or raise event alerts; they do not themselves create unit-monitor health transitions. Repeated or unresolved rule alerts do not by themselves explain a red DA. Correlate with current leaf monitors and event timestamps before closure.

### Read-only investigation

Identify the client host and exact server/share path. Inspect Get-SmbConnection, Get-SmbMultichannelConnection and the matching share on its server; compare negotiated signing, encryption and continuous-availability properties with policy. Correlate SMBClient/SMBServer event channels, latency and transport errors. A client-side test alone cannot prove the server service is stopped.

### Corrective action and escalation

Restore the affected SMB service, path or network after impact review; correct share permissions and authentication with the file-services team. Preserve security requirements. Never enable SMB1, disable signing/encryption or disconnect all SMB sessions to make a monitor green.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Verify the intended share and VM disk are reachable, required security and redundancy are negotiated, errors stop and representative I/O recovers.

### Microsoft references

[Microsoft Learn: troubleshoot smb guidance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/networking/troubleshoot-smb-guidance)

[Microsoft Learn: storage issues in hyper v and windows server failover clusters](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/storage-issues-in-hyper-v-and-windows-server-failover-clusters)


## Collect SMB client data queue length {#hypervprivatecloud.capability.fileservices.smbclientqueuelength.collection.rule}

`HyperVPrivateCloud.Capability.FileServices.SmbClientQueueLength.Collection.Rule`

Collects SMB Client Shares\Avg. Data Queue Length for every connected share every 300 seconds.

### Support scope

Hyper-V storage over SMB: client/server participation, share and VHDX mappings, sessions, security policy, continuous availability, witness and multichannel resilience.

Element: HyperVPrivateCloud.Capability.FileServices.SmbClientQueueLength.Collection.Rule. Kind: Rule.

### Alert versus health

Target=HCSV2Library!HyperVPrivateCloud.HostRole; enabled=true; category=PerformanceCollection. Rules collect data or raise event alerts; they do not themselves create unit-monitor health transitions. Repeated or unresolved rule alerts do not by themselves explain a red DA. Correlate with current leaf monitors and event timestamps before closure.

### Read-only investigation

Identify the client host and exact server/share path. Inspect Get-SmbConnection, Get-SmbMultichannelConnection and the matching share on its server; compare negotiated signing, encryption and continuous-availability properties with policy. Correlate SMBClient/SMBServer event channels, latency and transport errors. A client-side test alone cannot prove the server service is stopped.

### Corrective action and escalation

Restore the affected SMB service, path or network after impact review; correct share permissions and authentication with the file-services team. Preserve security requirements. Never enable SMB1, disable signing/encryption or disconnect all SMB sessions to make a monitor green.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Verify the intended share and VM disk are reachable, required security and redundancy are negotiated, errors stop and representative I/O recovers.

### Microsoft references

[Microsoft Learn: troubleshoot smb guidance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/networking/troubleshoot-smb-guidance)

[Microsoft Learn: storage issues in hyper v and windows server failover clusters](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/storage-issues-in-hyper-v-and-windows-server-failover-clusters)


## Collect SMB server received throughput {#hypervprivatecloud.capability.fileservices.smbserverreceivedbytes.collection.rule}

`HyperVPrivateCloud.Capability.FileServices.SmbServerReceivedBytes.Collection.Rule`

Collects SMB Server Shares\Received Bytes/sec for every served share every 300 seconds.

### Support scope

Hyper-V storage over SMB: client/server participation, share and VHDX mappings, sessions, security policy, continuous availability, witness and multichannel resilience.

Element: HyperVPrivateCloud.Capability.FileServices.SmbServerReceivedBytes.Collection.Rule. Kind: Rule.

### Alert versus health

Target=HCSV2Library!HyperVPrivateCloud.HostRole; enabled=true; category=PerformanceCollection. Rules collect data or raise event alerts; they do not themselves create unit-monitor health transitions. Repeated or unresolved rule alerts do not by themselves explain a red DA. Correlate with current leaf monitors and event timestamps before closure.

### Read-only investigation

Identify the client host and exact server/share path. Inspect Get-SmbConnection, Get-SmbMultichannelConnection and the matching share on its server; compare negotiated signing, encryption and continuous-availability properties with policy. Correlate SMBClient/SMBServer event channels, latency and transport errors. A client-side test alone cannot prove the server service is stopped.

### Corrective action and escalation

Restore the affected SMB service, path or network after impact review; correct share permissions and authentication with the file-services team. Preserve security requirements. Never enable SMB1, disable signing/encryption or disconnect all SMB sessions to make a monitor green.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Verify the intended share and VM disk are reachable, required security and redundancy are negotiated, errors stop and representative I/O recovers.

### Microsoft references

[Microsoft Learn: troubleshoot smb guidance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/networking/troubleshoot-smb-guidance)

[Microsoft Learn: storage issues in hyper v and windows server failover clusters](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/storage-issues-in-hyper-v-and-windows-server-failover-clusters)


## Collect SMB server sent throughput {#hypervprivatecloud.capability.fileservices.smbserversentbytes.collection.rule}

`HyperVPrivateCloud.Capability.FileServices.SmbServerSentBytes.Collection.Rule`

Collects SMB Server Shares\Sent Bytes/sec for every served share every 300 seconds.

### Support scope

Hyper-V storage over SMB: client/server participation, share and VHDX mappings, sessions, security policy, continuous availability, witness and multichannel resilience.

Element: HyperVPrivateCloud.Capability.FileServices.SmbServerSentBytes.Collection.Rule. Kind: Rule.

### Alert versus health

Target=HCSV2Library!HyperVPrivateCloud.HostRole; enabled=true; category=PerformanceCollection. Rules collect data or raise event alerts; they do not themselves create unit-monitor health transitions. Repeated or unresolved rule alerts do not by themselves explain a red DA. Correlate with current leaf monitors and event timestamps before closure.

### Read-only investigation

Identify the client host and exact server/share path. Inspect Get-SmbConnection, Get-SmbMultichannelConnection and the matching share on its server; compare negotiated signing, encryption and continuous-availability properties with policy. Correlate SMBClient/SMBServer event channels, latency and transport errors. A client-side test alone cannot prove the server service is stopped.

### Corrective action and escalation

Restore the affected SMB service, path or network after impact review; correct share permissions and authentication with the file-services team. Preserve security requirements. Never enable SMB1, disable signing/encryption or disconnect all SMB sessions to make a monitor green.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Verify the intended share and VM disk are reachable, required security and redundancy are negotiated, errors stop and representative I/O recovers.

### Microsoft references

[Microsoft Learn: troubleshoot smb guidance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/networking/troubleshoot-smb-guidance)

[Microsoft Learn: storage issues in hyper v and windows server failover clusters](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/storage-issues-in-hyper-v-and-windows-server-failover-clusters)


## Collect SMB server read latency {#hypervprivatecloud.capability.fileservices.smbserverreadlatency.collection.rule}

`HyperVPrivateCloud.Capability.FileServices.SmbServerReadLatency.Collection.Rule`

Collects SMB Server Shares\Avg. sec/Read for every served share every 300 seconds.

### Support scope

Hyper-V storage over SMB: client/server participation, share and VHDX mappings, sessions, security policy, continuous availability, witness and multichannel resilience.

Element: HyperVPrivateCloud.Capability.FileServices.SmbServerReadLatency.Collection.Rule. Kind: Rule.

### Alert versus health

Target=HCSV2Library!HyperVPrivateCloud.HostRole; enabled=true; category=PerformanceCollection. Rules collect data or raise event alerts; they do not themselves create unit-monitor health transitions. Repeated or unresolved rule alerts do not by themselves explain a red DA. Correlate with current leaf monitors and event timestamps before closure.

### Read-only investigation

Identify the client host and exact server/share path. Inspect Get-SmbConnection, Get-SmbMultichannelConnection and the matching share on its server; compare negotiated signing, encryption and continuous-availability properties with policy. Correlate SMBClient/SMBServer event channels, latency and transport errors. A client-side test alone cannot prove the server service is stopped.

### Corrective action and escalation

Restore the affected SMB service, path or network after impact review; correct share permissions and authentication with the file-services team. Preserve security requirements. Never enable SMB1, disable signing/encryption or disconnect all SMB sessions to make a monitor green.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Verify the intended share and VM disk are reachable, required security and redundancy are negotiated, errors stop and representative I/O recovers.

### Microsoft references

[Microsoft Learn: troubleshoot smb guidance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/networking/troubleshoot-smb-guidance)

[Microsoft Learn: storage issues in hyper v and windows server failover clusters](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/storage-issues-in-hyper-v-and-windows-server-failover-clusters)


## Collect SMB server write latency {#hypervprivatecloud.capability.fileservices.smbserverwritelatency.collection.rule}

`HyperVPrivateCloud.Capability.FileServices.SmbServerWriteLatency.Collection.Rule`

Collects SMB Server Shares\Avg. sec/Write for every served share every 300 seconds.

### Support scope

Hyper-V storage over SMB: client/server participation, share and VHDX mappings, sessions, security policy, continuous availability, witness and multichannel resilience.

Element: HyperVPrivateCloud.Capability.FileServices.SmbServerWriteLatency.Collection.Rule. Kind: Rule.

### Alert versus health

Target=HCSV2Library!HyperVPrivateCloud.HostRole; enabled=true; category=PerformanceCollection. Rules collect data or raise event alerts; they do not themselves create unit-monitor health transitions. Repeated or unresolved rule alerts do not by themselves explain a red DA. Correlate with current leaf monitors and event timestamps before closure.

### Read-only investigation

Identify the client host and exact server/share path. Inspect Get-SmbConnection, Get-SmbMultichannelConnection and the matching share on its server; compare negotiated signing, encryption and continuous-availability properties with policy. Correlate SMBClient/SMBServer event channels, latency and transport errors. A client-side test alone cannot prove the server service is stopped.

### Corrective action and escalation

Restore the affected SMB service, path or network after impact review; correct share permissions and authentication with the file-services team. Preserve security requirements. Never enable SMB1, disable signing/encryption or disconnect all SMB sessions to make a monitor green.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Verify the intended share and VM disk are reachable, required security and redundancy are negotiated, errors stop and representative I/O recovers.

### Microsoft references

[Microsoft Learn: troubleshoot smb guidance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/networking/troubleshoot-smb-guidance)

[Microsoft Learn: storage issues in hyper v and windows server failover clusters](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/storage-issues-in-hyper-v-and-windows-server-failover-clusters)


## Show SMB client and share report {#hypervprivatecloud.capability.fileservices.smbreport.task}

`HyperVPrivateCloud.Capability.FileServices.SmbReport.Task`

SMB services, client connections with dialect and CA state, multichannel paths and RDMA capability, witness registrations, signing/encryption posture, local shares and VHDX files on UNC paths.

### Summary

Show SMB client and share report

### What it runs

SMB services, client connections with dialect and CA state, multichannel paths and RDMA capability, witness registrations, signing/encryption posture, local shares and VHDX files on UNC paths.

### Impact

Read-only. The task runs the query on the agent and returns text; it changes nothing.

### Support scope

Hyper-V storage over SMB: client/server participation, share and VHDX mappings, sessions, security policy, continuous availability, witness and multichannel resilience.

Element: HyperVPrivateCloud.Capability.FileServices.SmbReport.Task. Kind: Task.

### Execution safety

Target=HCSV2Library!HyperVPrivateCloud.HostRole; enabled=true; timeout=180. Read the task&#39;s original knowledge and parameters before execution. A Remediation task changes state and requires approval; do not execute it solely because the object is red. Even a diagnostic can generate logs or files; review its documented impact.

### Read-only investigation

Identify the client host and exact server/share path. Inspect Get-SmbConnection, Get-SmbMultichannelConnection and the matching share on its server; compare negotiated signing, encryption and continuous-availability properties with policy. Correlate SMBClient/SMBServer event channels, latency and transport errors. A client-side test alone cannot prove the server service is stopped.

### Corrective action and escalation

Restore the affected SMB service, path or network after impact review; correct share permissions and authentication with the file-services team. Preserve security requirements. Never enable SMB1, disable signing/encryption or disconnect all SMB sessions to make a monitor green.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Verify the intended share and VM disk are reachable, required security and redundancy are negotiated, errors stop and representative I/O recovers.

### Microsoft references

[Microsoft Learn: troubleshoot smb guidance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/networking/troubleshoot-smb-guidance)

[Microsoft Learn: storage issues in hyper v and windows server failover clusters](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/storage-issues-in-hyper-v-and-windows-server-failover-clusters)


## Show SMB client latency and connectivity events {#hypervprivatecloud.capability.fileservices.smblatency.task}

`HyperVPrivateCloud.Capability.FileServices.SmbLatency.Task`

SMB Client Shares latency, queue and credit-stall counters plus the latest SMB client connectivity events.

### Summary

Show SMB client latency and connectivity events

### What it runs

SMB Client Shares latency, queue and credit-stall counters plus the latest SMB client connectivity events.

### Impact

Read-only. The task runs the query on the agent and returns text; it changes nothing.

### Support scope

Hyper-V storage over SMB: client/server participation, share and VHDX mappings, sessions, security policy, continuous availability, witness and multichannel resilience.

Element: HyperVPrivateCloud.Capability.FileServices.SmbLatency.Task. Kind: Task.

### Execution safety

Target=HCSV2Library!HyperVPrivateCloud.HostRole; enabled=true; timeout=180. Read the task&#39;s original knowledge and parameters before execution. A Remediation task changes state and requires approval; do not execute it solely because the object is red. Even a diagnostic can generate logs or files; review its documented impact.

### Read-only investigation

Identify the client host and exact server/share path. Inspect Get-SmbConnection, Get-SmbMultichannelConnection and the matching share on its server; compare negotiated signing, encryption and continuous-availability properties with policy. Correlate SMBClient/SMBServer event channels, latency and transport errors. A client-side test alone cannot prove the server service is stopped.

### Corrective action and escalation

Restore the affected SMB service, path or network after impact review; correct share permissions and authentication with the file-services team. Preserve security requirements. Never enable SMB1, disable signing/encryption or disconnect all SMB sessions to make a monitor green.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Verify the intended share and VM disk are reachable, required security and redundancy are negotiated, errors stop and representative I/O recovers.

### Microsoft references

[Microsoft Learn: troubleshoot smb guidance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/networking/troubleshoot-smb-guidance)

[Microsoft Learn: storage issues in hyper v and windows server failover clusters](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/storage-issues-in-hyper-v-and-windows-server-failover-clusters)


## Hyper-V over SMB health {#hypervprivatecloud.capability.fileservices.health.monitor}

`HyperVPrivateCloud.Capability.FileServices.Health.Monitor`

Validates required SMB connections, continuous availability, and optional RDMA paths.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.Fabric.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.Fabric.Service.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Service.Storage.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.FileServices.Participation.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.FileServices.Health.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

Validates every SMB share that backs an attached Hyper-V virtual hard disk. Continuous availability is required; RDMA is optional unless overridden.

### Operator response

Validate SMB client connections, share continuous-availability configuration, Multichannel paths, DNS, file-server cluster health, and the Microsoft File Services MP object.

### Support scope

Hyper-V storage over SMB: client/server participation, share and VHDX mappings, sessions, security policy, continuous availability, witness and multichannel resilience.

Element: HyperVPrivateCloud.Capability.FileServices.Health.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HyperVPrivateCloud.Capability.FileServices.HostParticipation. Parent health aspect: Health!System.Health.AvailabilityState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: (Property[@Name=&#39;FileServicesState&#39;] = Good OR Property[@Name=&#39;FileServicesState&#39;] = NotApplicable)

Warning [Warning]: Property[@Name=&#39;FileServicesState&#39;] = Warning

Error [Critical]: Property[@Name=&#39;FileServicesState&#39;] = Critical

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: IntervalSeconds=300; RequireRdma=false; SyncTime=; TimeoutSeconds=120 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Error; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Identify the client host and exact server/share path. Inspect Get-SmbConnection, Get-SmbMultichannelConnection and the matching share on its server; compare negotiated signing, encryption and continuous-availability properties with policy. Correlate SMBClient/SMBServer event channels, latency and transport errors. A client-side test alone cannot prove the server service is stopped.

### Corrective action and escalation

Restore the affected SMB service, path or network after impact review; correct share permissions and authentication with the file-services team. Preserve security requirements. Never enable SMB1, disable signing/encryption or disconnect all SMB sessions to make a monitor green.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Verify the intended share and VM disk are reachable, required security and redundancy are negotiated, errors stop and representative I/O recovers.

### Microsoft references

[Microsoft Learn: troubleshoot smb guidance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/networking/troubleshoot-smb-guidance)

[Microsoft Learn: storage issues in hyper v and windows server failover clusters](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/storage-issues-in-hyper-v-and-windows-server-failover-clusters)


## SMB service state {#hypervprivatecloud.capability.fileservices.smbservicestate.monitor}

`HyperVPrivateCloud.Capability.FileServices.SmbServiceState.Monitor`

Tracks the LanmanWorkstation SMB client service, and the LanmanServer SMB server service where it is installed and not disabled by policy.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.Fabric.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.Fabric.Service.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Service.Storage.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.FileServices.Participation.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.FileServices.SmbServiceState.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

The SMB client service (LanmanWorkstation) or, where installed and not disabled by policy, the SMB server service (LanmanServer) is not running on this Hyper-V host. Hyper-V over SMB, live migration over SMB and Scale-Out File Server access all depend on these services.

### Causes

Service stopped manually or failed to start after patching.

Dependency failure (NetBT, mrxsmb, srv2 drivers).

Hardening policy disabled LanmanServer on a host that still serves shares.

### Resolutions

Get-Service LanmanWorkstation,LanmanServer and the System log for Service Control Manager 7000/7031 events explain the failure.

Start-Service after fixing the dependency; verify SMB connections return with Get-SmbConnection.

If LanmanServer is deliberately disabled, this monitor treats it as not applicable only when the service is disabled; a manual stop still alerts.

### Support scope

Hyper-V storage over SMB: client/server participation, share and VHDX mappings, sessions, security policy, continuous availability, witness and multichannel resilience.

Element: HyperVPrivateCloud.Capability.FileServices.SmbServiceState.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HyperVPrivateCloud.Capability.FileServices.HostParticipation. Parent health aspect: Health!System.Health.AvailabilityState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: (Property[@Name=&#39;ServiceState&#39;] = Good OR Property[@Name=&#39;ServiceState&#39;] = NotApplicable)

Warning [Warning]: Property[@Name=&#39;ServiceState&#39;] = Warning

Error [Critical]: Property[@Name=&#39;ServiceState&#39;] = Critical

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: ClientSessionErrorCriticalCount=20; ClientSessionErrorWarningCount=5; IntervalSeconds=300; MinimumMultichannelPaths=2; PropertyName=ServiceState; RequireContinuousAvailability=true; RequireEncryption=false; RequireSigning=false; RequireWitness=false; ServerSessionErrorCriticalCount=20; ServerSessionErrorWarningCount=5; SessionErrorWindowMinutes=60; SmbReadLatencyCriticalMs=50; SmbReadLatencyWarningMs=20; SmbWriteLatencyCriticalMs=50; SmbWriteLatencyWarningMs=20; SyncTime=; TimeoutSeconds=120 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Error; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Identify the client host and exact server/share path. Inspect Get-SmbConnection, Get-SmbMultichannelConnection and the matching share on its server; compare negotiated signing, encryption and continuous-availability properties with policy. Correlate SMBClient/SMBServer event channels, latency and transport errors. A client-side test alone cannot prove the server service is stopped.

### Corrective action and escalation

Restore the affected SMB service, path or network after impact review; correct share permissions and authentication with the file-services team. Preserve security requirements. Never enable SMB1, disable signing/encryption or disconnect all SMB sessions to make a monitor green.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Verify the intended share and VM disk are reachable, required security and redundancy are negotiated, errors stop and representative I/O recovers.

### Microsoft references

[Microsoft Learn: troubleshoot smb guidance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/networking/troubleshoot-smb-guidance)

[Microsoft Learn: storage issues in hyper v and windows server failover clusters](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/storage-issues-in-hyper-v-and-windows-server-failover-clusters)


## SMB share availability {#hypervprivatecloud.capability.fileservices.smbshareavailability.monitor}

`HyperVPrivateCloud.Capability.FileServices.SmbShareAvailability.Monitor`

Verifies that every UNC path backing a Hyper-V virtual hard disk on this host has an active SMB client connection.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.Fabric.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.Fabric.Service.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Service.Storage.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.FileServices.Participation.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.FileServices.SmbShareAvailability.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

A UNC path that backs a Hyper-V virtual hard disk on this host has no active SMB client connection. The VM will pause with a critical storage error if the share cannot be reached when I/O is issued.

### Causes

File server or Scale-Out File Server cluster role offline.

Share permissions, Kerberos constrained delegation or SMB security settings changed.

Network path between host and file server down; SMB Multichannel paths all failed.

### Resolutions

Get-SmbConnection and Test-NetConnection &lt;fileserver&gt; -Port 445 from the host; Get-SmbShare / Get-ClusterGroup on the file server side.

Restore the share or the SOFS role, then confirm VMs resume (Resume-VM) and that Get-SmbConnection shows the path.

Check the SMBClient Connectivity and Security event logs on the host for the specific failure reason (30803-30809, 31001 series).

This monitor is an outage signal and should remain enabled.

### Support scope

Hyper-V storage over SMB: client/server participation, share and VHDX mappings, sessions, security policy, continuous availability, witness and multichannel resilience.

Element: HyperVPrivateCloud.Capability.FileServices.SmbShareAvailability.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HyperVPrivateCloud.Capability.FileServices.HostParticipation. Parent health aspect: Health!System.Health.AvailabilityState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: (Property[@Name=&#39;ShareAvailabilityState&#39;] = Good OR Property[@Name=&#39;ShareAvailabilityState&#39;] = NotApplicable)

Warning [Warning]: Property[@Name=&#39;ShareAvailabilityState&#39;] = Warning

Error [Critical]: Property[@Name=&#39;ShareAvailabilityState&#39;] = Critical

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: ClientSessionErrorCriticalCount=20; ClientSessionErrorWarningCount=5; IntervalSeconds=300; MinimumMultichannelPaths=2; PropertyName=ShareAvailabilityState; RequireContinuousAvailability=true; RequireEncryption=false; RequireSigning=false; RequireWitness=false; ServerSessionErrorCriticalCount=20; ServerSessionErrorWarningCount=5; SessionErrorWindowMinutes=60; SmbReadLatencyCriticalMs=50; SmbReadLatencyWarningMs=20; SmbWriteLatencyCriticalMs=50; SmbWriteLatencyWarningMs=20; SyncTime=; TimeoutSeconds=120 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Error; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Identify the client host and exact server/share path. Inspect Get-SmbConnection, Get-SmbMultichannelConnection and the matching share on its server; compare negotiated signing, encryption and continuous-availability properties with policy. Correlate SMBClient/SMBServer event channels, latency and transport errors. A client-side test alone cannot prove the server service is stopped.

### Corrective action and escalation

Restore the affected SMB service, path or network after impact review; correct share permissions and authentication with the file-services team. Preserve security requirements. Never enable SMB1, disable signing/encryption or disconnect all SMB sessions to make a monitor green.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Verify the intended share and VM disk are reachable, required security and redundancy are negotiated, errors stop and representative I/O recovers.

### Microsoft references

[Microsoft Learn: troubleshoot smb guidance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/networking/troubleshoot-smb-guidance)

[Microsoft Learn: storage issues in hyper v and windows server failover clusters](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/storage-issues-in-hyper-v-and-windows-server-failover-clusters)


## SMB client session errors {#hypervprivatecloud.capability.fileservices.smbclientsessionerrors.monitor}

`HyperVPrivateCloud.Capability.FileServices.SmbClientSessionErrors.Monitor`

Counts SMB client connectivity errors in a rolling window. SessionErrorWindowMinutes defaults to 60, ClientSessionErrorWarningCount to 5, and ClientSessionErrorCriticalCount to 20.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.Fabric.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.Fabric.Service.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Service.Storage.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.FileServices.Participation.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.FileServices.SmbClientSessionErrors.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

The count of SMB client connectivity and security errors on this host in the rolling SessionErrorWindowMinutes window has reached the configured threshold. Intermittent SMB client errors precede VM storage pauses on Hyper-V over SMB.

### Causes

Flapping network path or RDMA adapter resets between host and file server.

Authentication or signing failures after account/policy changes.

File server overload causing session timeouts or transparent failover events.

### Resolutions

Review the Microsoft-Windows-SMBClient/Connectivity and /Security event logs on the host for the counted errors and their target server.

Check SMB Multichannel path health (Get-SmbMultichannelConnection) and the network adapters involved.

Correlate with the SMB server session errors monitor on the file server if HCS monitors it.

Tune SessionErrorWindowMinutes and the Warning/Critical counts to the environment&#39;s baseline noise.

### Support scope

Hyper-V storage over SMB: client/server participation, share and VHDX mappings, sessions, security policy, continuous availability, witness and multichannel resilience.

Element: HyperVPrivateCloud.Capability.FileServices.SmbClientSessionErrors.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HyperVPrivateCloud.Capability.FileServices.HostParticipation. Parent health aspect: Health!System.Health.PerformanceState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: (Property[@Name=&#39;ClientSessionErrorState&#39;] = Good OR Property[@Name=&#39;ClientSessionErrorState&#39;] = NotApplicable)

Warning [Warning]: Property[@Name=&#39;ClientSessionErrorState&#39;] = Warning

Error [Critical]: Property[@Name=&#39;ClientSessionErrorState&#39;] = Critical

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: ClientSessionErrorCriticalCount=20; ClientSessionErrorWarningCount=5; IntervalSeconds=300; MinimumMultichannelPaths=2; PropertyName=ClientSessionErrorState; RequireContinuousAvailability=true; RequireEncryption=false; RequireSigning=false; RequireWitness=false; ServerSessionErrorCriticalCount=20; ServerSessionErrorWarningCount=5; SessionErrorWindowMinutes=60; SmbReadLatencyCriticalMs=50; SmbReadLatencyWarningMs=20; SmbWriteLatencyCriticalMs=50; SmbWriteLatencyWarningMs=20; SyncTime=; TimeoutSeconds=120 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Warning; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Identify the client host and exact server/share path. Inspect Get-SmbConnection, Get-SmbMultichannelConnection and the matching share on its server; compare negotiated signing, encryption and continuous-availability properties with policy. Correlate SMBClient/SMBServer event channels, latency and transport errors. A client-side test alone cannot prove the server service is stopped.

### Corrective action and escalation

Restore the affected SMB service, path or network after impact review; correct share permissions and authentication with the file-services team. Preserve security requirements. Never enable SMB1, disable signing/encryption or disconnect all SMB sessions to make a monitor green.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Verify the intended share and VM disk are reachable, required security and redundancy are negotiated, errors stop and representative I/O recovers.

### Microsoft references

[Microsoft Learn: troubleshoot smb guidance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/networking/troubleshoot-smb-guidance)

[Microsoft Learn: storage issues in hyper v and windows server failover clusters](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/storage-issues-in-hyper-v-and-windows-server-failover-clusters)


## SMB server session errors {#hypervprivatecloud.capability.fileservices.smbserversessionerrors.monitor}

`HyperVPrivateCloud.Capability.FileServices.SmbServerSessionErrors.Monitor`

Counts SMB server operational errors in a rolling window. SessionErrorWindowMinutes defaults to 60, ServerSessionErrorWarningCount to 5, and ServerSessionErrorCriticalCount to 20.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.Fabric.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.Fabric.Service.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Service.Storage.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.FileServices.Participation.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.FileServices.SmbServerSessionErrors.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

The count of SMB server operational errors on this host in the rolling SessionErrorWindowMinutes window has reached the configured threshold. On a Hyper-V host this indicates clients (other hosts, backup, live migration) are failing against shares served from here.

### Causes

Clients disconnecting abnormally (network faults, reboots).

Share ACL or SMB security (signing/encryption) mismatch with clients.

Server overload or storage latency causing request timeouts.

### Resolutions

Review the Microsoft-Windows-SMBServer/Operational and /Security logs for the counted events (1020-1025, 1031 series).

Identify the failing client from the event data and check its connectivity.

Confirm storage under the share is healthy (CSV / S2D monitors).

Tune the window and thresholds to baseline.

### Support scope

Hyper-V storage over SMB: client/server participation, share and VHDX mappings, sessions, security policy, continuous availability, witness and multichannel resilience.

Element: HyperVPrivateCloud.Capability.FileServices.SmbServerSessionErrors.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HyperVPrivateCloud.Capability.FileServices.HostParticipation. Parent health aspect: Health!System.Health.PerformanceState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: (Property[@Name=&#39;ServerSessionErrorState&#39;] = Good OR Property[@Name=&#39;ServerSessionErrorState&#39;] = NotApplicable)

Warning [Warning]: Property[@Name=&#39;ServerSessionErrorState&#39;] = Warning

Error [Critical]: Property[@Name=&#39;ServerSessionErrorState&#39;] = Critical

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: ClientSessionErrorCriticalCount=20; ClientSessionErrorWarningCount=5; IntervalSeconds=300; MinimumMultichannelPaths=2; PropertyName=ServerSessionErrorState; RequireContinuousAvailability=true; RequireEncryption=false; RequireSigning=false; RequireWitness=false; ServerSessionErrorCriticalCount=20; ServerSessionErrorWarningCount=5; SessionErrorWindowMinutes=60; SmbReadLatencyCriticalMs=50; SmbReadLatencyWarningMs=20; SmbWriteLatencyCriticalMs=50; SmbWriteLatencyWarningMs=20; SyncTime=; TimeoutSeconds=120 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Warning; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Identify the client host and exact server/share path. Inspect Get-SmbConnection, Get-SmbMultichannelConnection and the matching share on its server; compare negotiated signing, encryption and continuous-availability properties with policy. Correlate SMBClient/SMBServer event channels, latency and transport errors. A client-side test alone cannot prove the server service is stopped.

### Corrective action and escalation

Restore the affected SMB service, path or network after impact review; correct share permissions and authentication with the file-services team. Preserve security requirements. Never enable SMB1, disable signing/encryption or disconnect all SMB sessions to make a monitor green.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Verify the intended share and VM disk are reachable, required security and redundancy are negotiated, errors stop and representative I/O recovers.

### Microsoft references

[Microsoft Learn: troubleshoot smb guidance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/networking/troubleshoot-smb-guidance)

[Microsoft Learn: storage issues in hyper v and windows server failover clusters](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/storage-issues-in-hyper-v-and-windows-server-failover-clusters)


## SMB signing state {#hypervprivatecloud.capability.fileservices.smbsigningstate.monitor}

`HyperVPrivateCloud.Capability.FileServices.SmbSigningState.Monitor`

Reports whether SMB signing is required on the SMB server and the SMB client. RequireSigning defaults to false, so the monitor reports posture without alerting until it is overridden to true.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.Fabric.Security.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.Fabric.Service.Security.Dependency.Monitor &gt; HyperVPrivateCloud.Service.Storage.Security.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.FileServices.Participation.Security.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.FileServices.SmbSigningState.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

Reports whether SMB signing is required on this host&#39;s SMB server and client configuration. With RequireSigning left at the default of false the monitor records posture only; when overridden to true it alerts if signing is not required, which matters for hosts exposed to untrusted networks.

### Causes

Group Policy or Set-SmbServerConfiguration/Set-SmbClientConfiguration changed RequireSecuritySignature.

Signing disabled to recover performance on RDMA/SMB Direct paths (signing disables RDMA offload).

### Resolutions

Get-SmbServerConfiguration &#124; Select RequireSecuritySignature and Get-SmbClientConfiguration &#124; Select RequireSecuritySignature.

Set the required posture per your security baseline; note that requiring signing or encryption on Hyper-V storage traffic prevents SMB Direct (RDMA) from being used.

Set RequireSigning to true by override only for hosts where the baseline demands it.

### Support scope

Hyper-V storage over SMB: client/server participation, share and VHDX mappings, sessions, security policy, continuous availability, witness and multichannel resilience.

Element: HyperVPrivateCloud.Capability.FileServices.SmbSigningState.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HyperVPrivateCloud.Capability.FileServices.HostParticipation. Parent health aspect: Health!System.Health.SecurityState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: (Property[@Name=&#39;SigningState&#39;] = Good OR Property[@Name=&#39;SigningState&#39;] = NotApplicable)

Warning [Warning]: Property[@Name=&#39;SigningState&#39;] = Warning

Error [Critical]: Property[@Name=&#39;SigningState&#39;] = Critical

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: ClientSessionErrorCriticalCount=20; ClientSessionErrorWarningCount=5; IntervalSeconds=300; MinimumMultichannelPaths=2; PropertyName=SigningState; RequireContinuousAvailability=true; RequireEncryption=false; RequireSigning=false; RequireWitness=false; ServerSessionErrorCriticalCount=20; ServerSessionErrorWarningCount=5; SessionErrorWindowMinutes=60; SmbReadLatencyCriticalMs=50; SmbReadLatencyWarningMs=20; SmbWriteLatencyCriticalMs=50; SmbWriteLatencyWarningMs=20; SyncTime=; TimeoutSeconds=120 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Warning; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Identify the client host and exact server/share path. Inspect Get-SmbConnection, Get-SmbMultichannelConnection and the matching share on its server; compare negotiated signing, encryption and continuous-availability properties with policy. Correlate SMBClient/SMBServer event channels, latency and transport errors. A client-side test alone cannot prove the server service is stopped.

### Corrective action and escalation

Restore the affected SMB service, path or network after impact review; correct share permissions and authentication with the file-services team. Preserve security requirements. Never enable SMB1, disable signing/encryption or disconnect all SMB sessions to make a monitor green.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Verify the intended share and VM disk are reachable, required security and redundancy are negotiated, errors stop and representative I/O recovers.

### Microsoft references

[Microsoft Learn: troubleshoot smb guidance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/networking/troubleshoot-smb-guidance)

[Microsoft Learn: storage issues in hyper v and windows server failover clusters](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/storage-issues-in-hyper-v-and-windows-server-failover-clusters)


## SMB encryption state {#hypervprivatecloud.capability.fileservices.smbencryptionstate.monitor}

`HyperVPrivateCloud.Capability.FileServices.SmbEncryptionState.Monitor`

Reports whether SMB data encryption is enabled on the server default and on local shares. RequireEncryption defaults to false, so the monitor reports posture without alerting until it is overridden to true.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.Fabric.Security.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.Fabric.Service.Security.Dependency.Monitor &gt; HyperVPrivateCloud.Service.Storage.Security.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.FileServices.Participation.Security.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.FileServices.SmbEncryptionState.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

Reports whether SMB encryption is enabled on the server default and on local shares. With RequireEncryption left at the default of false the monitor records posture only; when overridden to true it alerts if encryption is not enforced.

### Causes

EncryptData not set on the server configuration or on shares carrying sensitive data.

Encryption disabled to retain SMB Direct (RDMA) performance for Hyper-V storage traffic.

### Resolutions

Get-SmbServerConfiguration &#124; Select EncryptData,RejectUnencryptedAccess and Get-SmbShare &#124; Select Name,EncryptData.

Enable encryption per baseline with Set-SmbServerConfiguration -EncryptData $true or per share; understand the RDMA trade-off first.

Set RequireEncryption to true by override where the baseline demands it.

### Support scope

Hyper-V storage over SMB: client/server participation, share and VHDX mappings, sessions, security policy, continuous availability, witness and multichannel resilience.

Element: HyperVPrivateCloud.Capability.FileServices.SmbEncryptionState.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HyperVPrivateCloud.Capability.FileServices.HostParticipation. Parent health aspect: Health!System.Health.SecurityState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: (Property[@Name=&#39;EncryptionState&#39;] = Good OR Property[@Name=&#39;EncryptionState&#39;] = NotApplicable)

Warning [Warning]: Property[@Name=&#39;EncryptionState&#39;] = Warning

Error [Critical]: Property[@Name=&#39;EncryptionState&#39;] = Critical

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: ClientSessionErrorCriticalCount=20; ClientSessionErrorWarningCount=5; IntervalSeconds=300; MinimumMultichannelPaths=2; PropertyName=EncryptionState; RequireContinuousAvailability=true; RequireEncryption=false; RequireSigning=false; RequireWitness=false; ServerSessionErrorCriticalCount=20; ServerSessionErrorWarningCount=5; SessionErrorWindowMinutes=60; SmbReadLatencyCriticalMs=50; SmbReadLatencyWarningMs=20; SmbWriteLatencyCriticalMs=50; SmbWriteLatencyWarningMs=20; SyncTime=; TimeoutSeconds=120 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Warning; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Identify the client host and exact server/share path. Inspect Get-SmbConnection, Get-SmbMultichannelConnection and the matching share on its server; compare negotiated signing, encryption and continuous-availability properties with policy. Correlate SMBClient/SMBServer event channels, latency and transport errors. A client-side test alone cannot prove the server service is stopped.

### Corrective action and escalation

Restore the affected SMB service, path or network after impact review; correct share permissions and authentication with the file-services team. Preserve security requirements. Never enable SMB1, disable signing/encryption or disconnect all SMB sessions to make a monitor green.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Verify the intended share and VM disk are reachable, required security and redundancy are negotiated, errors stop and representative I/O recovers.

### Microsoft references

[Microsoft Learn: troubleshoot smb guidance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/networking/troubleshoot-smb-guidance)

[Microsoft Learn: storage issues in hyper v and windows server failover clusters](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/storage-issues-in-hyper-v-and-windows-server-failover-clusters)


## SMB continuous availability state {#hypervprivatecloud.capability.fileservices.smbcontinuousavailability.monitor}

`HyperVPrivateCloud.Capability.FileServices.SmbContinuousAvailability.Monitor`

Verifies that Scale-Out File Server shares carrying Hyper-V workloads are continuously available so transparent failover works. RequireContinuousAvailability defaults to true.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.Fabric.Configuration.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.Fabric.Service.Configuration.Dependency.Monitor &gt; HyperVPrivateCloud.Service.Storage.Configuration.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.FileServices.Participation.Configuration.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.FileServices.SmbContinuousAvailability.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

A Scale-Out File Server share carrying Hyper-V workloads is not continuously available (CA). Without CA, transparent failover does not work and a file-server node failure pauses or crashes the VMs using the share instead of a brief I/O stall.

### Causes

Share created without the ContinuouslyAvailable flag or with it later removed.

Share hosted on a general-purpose file server role rather than SOFS.

Cluster role for the share not online.

### Resolutions

Get-SmbShare &#124; Select Name,ContinuouslyAvailable,ScopeName on the file server; Get-SmbConnection on the host shows which shares VHDX files use.

Set-SmbShare -ContinuouslyAvailable $true on SOFS shares used for Hyper-V storage.

If the share is intentionally not CA, set RequireContinuousAvailability to false by override for that host.

### Support scope

Hyper-V storage over SMB: client/server participation, share and VHDX mappings, sessions, security policy, continuous availability, witness and multichannel resilience.

Element: HyperVPrivateCloud.Capability.FileServices.SmbContinuousAvailability.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HyperVPrivateCloud.Capability.FileServices.HostParticipation. Parent health aspect: Health!System.Health.ConfigurationState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: (Property[@Name=&#39;ContinuousAvailabilityState&#39;] = Good OR Property[@Name=&#39;ContinuousAvailabilityState&#39;] = NotApplicable)

Warning [Warning]: Property[@Name=&#39;ContinuousAvailabilityState&#39;] = Warning

Error [Critical]: Property[@Name=&#39;ContinuousAvailabilityState&#39;] = Critical

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: ClientSessionErrorCriticalCount=20; ClientSessionErrorWarningCount=5; IntervalSeconds=300; MinimumMultichannelPaths=2; PropertyName=ContinuousAvailabilityState; RequireContinuousAvailability=true; RequireEncryption=false; RequireSigning=false; RequireWitness=false; ServerSessionErrorCriticalCount=20; ServerSessionErrorWarningCount=5; SessionErrorWindowMinutes=60; SmbReadLatencyCriticalMs=50; SmbReadLatencyWarningMs=20; SmbWriteLatencyCriticalMs=50; SmbWriteLatencyWarningMs=20; SyncTime=; TimeoutSeconds=120 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Error; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Identify the client host and exact server/share path. Inspect Get-SmbConnection, Get-SmbMultichannelConnection and the matching share on its server; compare negotiated signing, encryption and continuous-availability properties with policy. Correlate SMBClient/SMBServer event channels, latency and transport errors. A client-side test alone cannot prove the server service is stopped.

### Corrective action and escalation

Restore the affected SMB service, path or network after impact review; correct share permissions and authentication with the file-services team. Preserve security requirements. Never enable SMB1, disable signing/encryption or disconnect all SMB sessions to make a monitor green.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Verify the intended share and VM disk are reachable, required security and redundancy are negotiated, errors stop and representative I/O recovers.

### Microsoft references

[Microsoft Learn: troubleshoot smb guidance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/networking/troubleshoot-smb-guidance)

[Microsoft Learn: storage issues in hyper v and windows server failover clusters](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/storage-issues-in-hyper-v-and-windows-server-failover-clusters)


## SMB Witness registration state {#hypervprivatecloud.capability.fileservices.smbwitnessstate.monitor}

`HyperVPrivateCloud.Capability.FileServices.SmbWitnessState.Monitor`

Reports active SMB Witness registrations, which drive fast transparent failover for Scale-Out File Server. RequireWitness defaults to false.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.Fabric.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.Fabric.Service.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Service.Storage.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.FileServices.Participation.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.FileServices.SmbWitnessState.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

Reports whether this host has active SMB Witness registrations for its Scale-Out File Server connections. The witness service notifies the client to move immediately when a file-server node fails, giving fast transparent failover; without it the client waits for TCP timeouts. RequireWitness defaults to false (posture only).

### Causes

Witness registration failed because the SMB Witness service is stopped on the file server or blocked by a firewall (RPC).

Connections to non-clustered file servers (no witness expected).

### Resolutions

Get-SmbWitnessClient on the host lists registrations and their state; the SMBWitnessClient event logs record registration failures.

On the SOFS nodes confirm the SMB Witness service is running and RPC is allowed.

Set RequireWitness to true by override on hosts that only use SOFS shares so lost registrations alert.

### Support scope

Hyper-V storage over SMB: client/server participation, share and VHDX mappings, sessions, security policy, continuous availability, witness and multichannel resilience.

Element: HyperVPrivateCloud.Capability.FileServices.SmbWitnessState.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HyperVPrivateCloud.Capability.FileServices.HostParticipation. Parent health aspect: Health!System.Health.AvailabilityState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: (Property[@Name=&#39;WitnessState&#39;] = Good OR Property[@Name=&#39;WitnessState&#39;] = NotApplicable)

Warning [Warning]: Property[@Name=&#39;WitnessState&#39;] = Warning

Error [Critical]: Property[@Name=&#39;WitnessState&#39;] = Critical

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: ClientSessionErrorCriticalCount=20; ClientSessionErrorWarningCount=5; IntervalSeconds=300; MinimumMultichannelPaths=2; PropertyName=WitnessState; RequireContinuousAvailability=true; RequireEncryption=false; RequireSigning=false; RequireWitness=false; ServerSessionErrorCriticalCount=20; ServerSessionErrorWarningCount=5; SessionErrorWindowMinutes=60; SmbReadLatencyCriticalMs=50; SmbReadLatencyWarningMs=20; SmbWriteLatencyCriticalMs=50; SmbWriteLatencyWarningMs=20; SyncTime=; TimeoutSeconds=120 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Warning; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Identify the client host and exact server/share path. Inspect Get-SmbConnection, Get-SmbMultichannelConnection and the matching share on its server; compare negotiated signing, encryption and continuous-availability properties with policy. Correlate SMBClient/SMBServer event channels, latency and transport errors. A client-side test alone cannot prove the server service is stopped.

### Corrective action and escalation

Restore the affected SMB service, path or network after impact review; correct share permissions and authentication with the file-services team. Preserve security requirements. Never enable SMB1, disable signing/encryption or disconnect all SMB sessions to make a monitor green.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Verify the intended share and VM disk are reachable, required security and redundancy are negotiated, errors stop and representative I/O recovers.

### Microsoft references

[Microsoft Learn: troubleshoot smb guidance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/networking/troubleshoot-smb-guidance)

[Microsoft Learn: storage issues in hyper v and windows server failover clusters](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/storage-issues-in-hyper-v-and-windows-server-failover-clusters)


## SMB Multichannel path count {#hypervprivatecloud.capability.fileservices.smbmultichannelpathcount.monitor}

`HyperVPrivateCloud.Capability.FileServices.SmbMultichannelPathCount.Monitor`

Tracks selected SMB Multichannel paths against the expected minimum. MinimumMultichannelPaths defaults to 2.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.Fabric.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.Fabric.Service.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Service.Storage.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.FileServices.Participation.Availability.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.FileServices.SmbMultichannelPathCount.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

The number of selected SMB Multichannel paths to a share is below MinimumMultichannelPaths (default 2). A single path means no network fault tolerance for Hyper-V over SMB storage traffic and reduced throughput.

### Causes

A storage NIC or RDMA adapter down, misconfigured or with a different RSS/RDMA capability so SMB will not use it.

Subnet or VLAN misconfiguration making one path unreachable.

Multichannel disabled on client or server.

### Resolutions

Get-SmbMultichannelConnection and Get-SmbClientNetworkInterface show which interfaces are selected and why others are not (RSS/RDMA capable flags).

Repair the failed adapter or path; verify Get-NetAdapterRdma and Get-NetAdapterRss are consistent across storage NICs.

Confirm Get-SmbClientConfiguration EnableMultiChannel is true.

Set MinimumMultichannelPaths to match the host design (2 for dual-NIC, higher for four-port designs).

### Support scope

Hyper-V storage over SMB: client/server participation, share and VHDX mappings, sessions, security policy, continuous availability, witness and multichannel resilience.

Element: HyperVPrivateCloud.Capability.FileServices.SmbMultichannelPathCount.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HyperVPrivateCloud.Capability.FileServices.HostParticipation. Parent health aspect: Health!System.Health.AvailabilityState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: (Property[@Name=&#39;MultichannelPathState&#39;] = Good OR Property[@Name=&#39;MultichannelPathState&#39;] = NotApplicable)

Warning [Warning]: Property[@Name=&#39;MultichannelPathState&#39;] = Warning

Error [Critical]: Property[@Name=&#39;MultichannelPathState&#39;] = Critical

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: ClientSessionErrorCriticalCount=20; ClientSessionErrorWarningCount=5; IntervalSeconds=300; MinimumMultichannelPaths=2; PropertyName=MultichannelPathState; RequireContinuousAvailability=true; RequireEncryption=false; RequireSigning=false; RequireWitness=false; ServerSessionErrorCriticalCount=20; ServerSessionErrorWarningCount=5; SessionErrorWindowMinutes=60; SmbReadLatencyCriticalMs=50; SmbReadLatencyWarningMs=20; SmbWriteLatencyCriticalMs=50; SmbWriteLatencyWarningMs=20; SyncTime=; TimeoutSeconds=120 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Warning; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Identify the client host and exact server/share path. Inspect Get-SmbConnection, Get-SmbMultichannelConnection and the matching share on its server; compare negotiated signing, encryption and continuous-availability properties with policy. Correlate SMBClient/SMBServer event channels, latency and transport errors. A client-side test alone cannot prove the server service is stopped.

### Corrective action and escalation

Restore the affected SMB service, path or network after impact review; correct share permissions and authentication with the file-services team. Preserve security requirements. Never enable SMB1, disable signing/encryption or disconnect all SMB sessions to make a monitor green.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Verify the intended share and VM disk are reachable, required security and redundancy are negotiated, errors stop and representative I/O recovers.

### Microsoft references

[Microsoft Learn: troubleshoot smb guidance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/networking/troubleshoot-smb-guidance)

[Microsoft Learn: storage issues in hyper v and windows server failover clusters](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/storage-issues-in-hyper-v-and-windows-server-failover-clusters)


## SMB client read latency {#hypervprivatecloud.capability.fileservices.smbclientreadlatency.monitor}

`HyperVPrivateCloud.Capability.FileServices.SmbClientReadLatency.Monitor`

Tracks average SMB client read latency across connected shares. SmbReadLatencyWarningMs defaults to 20 and SmbReadLatencyCriticalMs defaults to 50.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.Fabric.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.Fabric.Service.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Service.Storage.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.FileServices.Participation.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.FileServices.SmbClientReadLatency.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

Average SMB client read latency across connected shares has reached SmbReadLatencyWarningMs / SmbReadLatencyCriticalMs. Read latency on SMB storage is felt directly as guest disk latency by every VM on those shares.

### Causes

File server storage saturation or S2D repair on the SOFS side.

Storage network congestion, PFC/ETS misconfiguration for RDMA, or Multichannel down to one path.

A noisy VM or backup issuing a read storm.

### Resolutions

Use the SMB Client Shares performance counters (Avg. sec/Read, Data Requests/sec) in the SMB performance view to identify the share and time window.

Check the file server volume latency and the storage-network adapters (RDMA counters, PFC pause frames).

Rebalance or throttle the offending VM with Storage QoS.

Lower the thresholds on all-flash SOFS designs; raise them on hybrid storage.

### Support scope

Hyper-V storage over SMB: client/server participation, share and VHDX mappings, sessions, security policy, continuous availability, witness and multichannel resilience.

Element: HyperVPrivateCloud.Capability.FileServices.SmbClientReadLatency.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HyperVPrivateCloud.Capability.FileServices.HostParticipation. Parent health aspect: Health!System.Health.PerformanceState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: (Property[@Name=&#39;ReadLatencyState&#39;] = Good OR Property[@Name=&#39;ReadLatencyState&#39;] = NotApplicable)

Warning [Warning]: Property[@Name=&#39;ReadLatencyState&#39;] = Warning

Error [Critical]: Property[@Name=&#39;ReadLatencyState&#39;] = Critical

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: ClientSessionErrorCriticalCount=20; ClientSessionErrorWarningCount=5; IntervalSeconds=300; MinimumMultichannelPaths=2; PropertyName=ReadLatencyState; RequireContinuousAvailability=true; RequireEncryption=false; RequireSigning=false; RequireWitness=false; ServerSessionErrorCriticalCount=20; ServerSessionErrorWarningCount=5; SessionErrorWindowMinutes=60; SmbReadLatencyCriticalMs=50; SmbReadLatencyWarningMs=20; SmbWriteLatencyCriticalMs=50; SmbWriteLatencyWarningMs=20; SyncTime=; TimeoutSeconds=120 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Warning; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Identify the client host and exact server/share path. Inspect Get-SmbConnection, Get-SmbMultichannelConnection and the matching share on its server; compare negotiated signing, encryption and continuous-availability properties with policy. Correlate SMBClient/SMBServer event channels, latency and transport errors. A client-side test alone cannot prove the server service is stopped.

### Corrective action and escalation

Restore the affected SMB service, path or network after impact review; correct share permissions and authentication with the file-services team. Preserve security requirements. Never enable SMB1, disable signing/encryption or disconnect all SMB sessions to make a monitor green.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Verify the intended share and VM disk are reachable, required security and redundancy are negotiated, errors stop and representative I/O recovers.

### Microsoft references

[Microsoft Learn: troubleshoot smb guidance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/networking/troubleshoot-smb-guidance)

[Microsoft Learn: storage issues in hyper v and windows server failover clusters](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/storage-issues-in-hyper-v-and-windows-server-failover-clusters)


## SMB client write latency {#hypervprivatecloud.capability.fileservices.smbclientwritelatency.monitor}

`HyperVPrivateCloud.Capability.FileServices.SmbClientWriteLatency.Monitor`

Tracks average SMB client write latency across connected shares. SmbWriteLatencyWarningMs defaults to 20 and SmbWriteLatencyCriticalMs defaults to 50.

### Representative root health path

Solution &gt; HyperVPrivateCloud.Enterprise.Solution.Fabric.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Enterprise.Fabric.Service.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Service.Storage.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.FileServices.Participation.Performance.Dependency.Monitor &gt; HyperVPrivateCloud.Capability.FileServices.SmbClientWriteLatency.Monitor

This is one authored monitor path, not proof of current instance membership. Shared dependencies can have additional paths. Use Health Explorer to resolve the actual affected objects.

### Summary

Average SMB client write latency across connected shares has reached SmbWriteLatencyWarningMs / SmbWriteLatencyCriticalMs. Write latency on Hyper-V over SMB storage is the most common cause of guest application timeouts and VM pause events.

### Causes

File server write cache exhausted or storage repair in progress.

Storage network congestion or loss of SMB Direct (falling back to TCP).

Checkpoint merges, storage migrations or backups saturating the share.

### Resolutions

Use the SMB Client Shares counters (Avg. sec/Write) and correlate with the SOFS node&#39;s storage monitors.

Verify SMB Direct is in use (Get-SmbMultichannelConnection shows RDMA capable/current) and that PFC/ETS are configured on the storage NICs.

Move or throttle the heavy writer.

Tune thresholds to the storage design latency.

### Support scope

Hyper-V storage over SMB: client/server participation, share and VHDX mappings, sessions, security policy, continuous availability, witness and multichannel resilience.

Element: HyperVPrivateCloud.Capability.FileServices.SmbClientWriteLatency.Monitor. Kind: UnitMonitor.

### Target and health path

Target class: HyperVPrivateCloud.Capability.FileServices.HostParticipation. Parent health aspect: Health!System.Health.PerformanceState. Enabled by default: true. Follow this leaf through Health Explorer dependencies to identify which component and service inherit its state.

### Why warning or critical

Success [Good]: (Property[@Name=&#39;WriteLatencyState&#39;] = Good OR Property[@Name=&#39;WriteLatencyState&#39;] = NotApplicable)

Warning [Warning]: Property[@Name=&#39;WriteLatencyState&#39;] = Warning

Error [Critical]: Property[@Name=&#39;WriteLatencyState&#39;] = Critical

These are compiled default detection conditions, not effective overrides. For state-valued properties, the probe evaluates the condition described in the original knowledge above and supplies the actual cause in state-change context. NotApplicable is not a successful test of an absent capability.

### Sampling and effective policy

Compiled configuration: ClientSessionErrorCriticalCount=20; ClientSessionErrorWarningCount=5; IntervalSeconds=300; MinimumMultichannelPaths=2; PropertyName=WriteLatencyState; RequireContinuousAvailability=true; RequireEncryption=false; RequireSigning=false; RequireWitness=false; ServerSessionErrorCriticalCount=20; ServerSessionErrorWarningCount=5; SessionErrorWindowMinutes=60; SmbReadLatencyCriticalMs=50; SmbReadLatencyWarningMs=20; SmbWriteLatencyCriticalMs=50; SmbWriteLatencyWarningMs=20; SyncTime=; TimeoutSeconds=120 Check effective overrides before comparing a live value with these defaults. Interval is not persistence: do not assume consecutive samples or hysteresis unless explicitly configured. Increasing thresholds can conceal lost redundancy. Use customer-owned override packs, never the Default Management Pack.

### Alert and recovery behavior

Alert starts at Warning; severity=MatchMonitorHealth; AutoResolve=true. A warning health state may be visible without a warning alert when AlertOnState is Error. Alert descriptions can retain the original incident details; compare the latest Health Explorer state-change context and a fresh diagnostic.

### Read-only investigation

Identify the client host and exact server/share path. Inspect Get-SmbConnection, Get-SmbMultichannelConnection and the matching share on its server; compare negotiated signing, encryption and continuous-availability properties with policy. Correlate SMBClient/SMBServer event channels, latency and transport errors. A client-side test alone cannot prove the server service is stopped.

### Corrective action and escalation

Restore the affected SMB service, path or network after impact review; correct share permissions and authentication with the file-services team. Preserve security requirements. Never enable SMB1, disable signing/encryption or disconnect all SMB sessions to make a monitor green.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Verify the intended share and VM disk are reachable, required security and redundancy are negotiated, errors stop and representative I/O recovers.

### Microsoft references

[Microsoft Learn: troubleshoot smb guidance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/networking/troubleshoot-smb-guidance)

[Microsoft Learn: storage issues in hyper v and windows server failover clusters](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/storage-issues-in-hyper-v-and-windows-server-failover-clusters)


## Roll up SMB share health into Storage {#hypervprivatecloud.capability.fileservices.storageshare.dependency.monitor}

`HyperVPrivateCloud.Capability.FileServices.StorageShare.Dependency.Monitor`

Rolls the health of SMB share health into Storage into the private cloud Distributed Application.

### Support scope

Hyper-V storage over SMB: client/server participation, share and VHDX mappings, sessions, security policy, continuous availability, witness and multichannel resilience.

Element: HyperVPrivateCloud.Capability.FileServices.StorageShare.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.StorageComponent; relationship=HyperVPrivateCloud.Capability.FileServices.StorageContainsSmbShare; member monitor=Health!System.Health.AvailabilityState; parent=Health!System.Health.AvailabilityState; algorithm=WorstOf; unavailable-member policy=Success. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Identify the client host and exact server/share path. Inspect Get-SmbConnection, Get-SmbMultichannelConnection and the matching share on its server; compare negotiated signing, encryption and continuous-availability properties with policy. Correlate SMBClient/SMBServer event channels, latency and transport errors. A client-side test alone cannot prove the server service is stopped.

### Corrective action and escalation

Restore the affected SMB service, path or network after impact review; correct share permissions and authentication with the file-services team. Preserve security requirements. Never enable SMB1, disable signing/encryption or disconnect all SMB sessions to make a monitor green.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Verify the intended share and VM disk are reachable, required security and redundancy are negotiated, errors stop and representative I/O recovers.

### Microsoft references

[Microsoft Learn: troubleshoot smb guidance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/networking/troubleshoot-smb-guidance)

[Microsoft Learn: storage issues in hyper v and windows server failover clusters](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/storage-issues-in-hyper-v-and-windows-server-failover-clusters)


## Roll up SMB share health into Hyper-V hosts {#hypervprivatecloud.capability.fileservices.hostshare.dependency.monitor}

`HyperVPrivateCloud.Capability.FileServices.HostShare.Dependency.Monitor`

Rolls the health of SMB share health into Hyper-V hosts into the private cloud Distributed Application.

### Support scope

Hyper-V storage over SMB: client/server participation, share and VHDX mappings, sessions, security policy, continuous availability, witness and multichannel resilience.

Element: HyperVPrivateCloud.Capability.FileServices.HostShare.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.HostRole; relationship=HyperVPrivateCloud.Capability.FileServices.HostRoleUsesSmbShare; member monitor=Health!System.Health.AvailabilityState; parent=Health!System.Health.AvailabilityState; algorithm=WorstOf; unavailable-member policy=Success. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Identify the client host and exact server/share path. Inspect Get-SmbConnection, Get-SmbMultichannelConnection and the matching share on its server; compare negotiated signing, encryption and continuous-availability properties with policy. Correlate SMBClient/SMBServer event channels, latency and transport errors. A client-side test alone cannot prove the server service is stopped.

### Corrective action and escalation

Restore the affected SMB service, path or network after impact review; correct share permissions and authentication with the file-services team. Preserve security requirements. Never enable SMB1, disable signing/encryption or disconnect all SMB sessions to make a monitor green.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Verify the intended share and VM disk are reachable, required security and redundancy are negotiated, errors stop and representative I/O recovers.

### Microsoft references

[Microsoft Learn: troubleshoot smb guidance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/networking/troubleshoot-smb-guidance)

[Microsoft Learn: storage issues in hyper v and windows server failover clusters](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/storage-issues-in-hyper-v-and-windows-server-failover-clusters)


## Roll up Microsoft SMB service health into shares {#hypervprivatecloud.capability.fileservices.microsoftsmb.dependency.monitor}

`HyperVPrivateCloud.Capability.FileServices.MicrosoftSmb.Dependency.Monitor`

Rolls the health of Microsoft SMB service health into shares into the private cloud Distributed Application.

### Support scope

Hyper-V storage over SMB: client/server participation, share and VHDX mappings, sessions, security policy, continuous availability, witness and multichannel resilience.

Element: HyperVPrivateCloud.Capability.FileServices.MicrosoftSmb.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HyperVPrivateCloud.Capability.FileServices.SmbShare; relationship=HyperVPrivateCloud.Capability.FileServices.SmbShareReferencesMicrosoftSmbService; member monitor=Health!System.Health.AvailabilityState; parent=Health!System.Health.AvailabilityState; algorithm=WorstOf; unavailable-member policy=Success. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Identify the client host and exact server/share path. Inspect Get-SmbConnection, Get-SmbMultichannelConnection and the matching share on its server; compare negotiated signing, encryption and continuous-availability properties with policy. Correlate SMBClient/SMBServer event channels, latency and transport errors. A client-side test alone cannot prove the server service is stopped.

### Corrective action and escalation

Restore the affected SMB service, path or network after impact review; correct share permissions and authentication with the file-services team. Preserve security requirements. Never enable SMB1, disable signing/encryption or disconnect all SMB sessions to make a monitor green.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Verify the intended share and VM disk are reachable, required security and redundancy are negotiated, errors stop and representative I/O recovers.

### Microsoft references

[Microsoft Learn: troubleshoot smb guidance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/networking/troubleshoot-smb-guidance)

[Microsoft Learn: storage issues in hyper v and windows server failover clusters](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/storage-issues-in-hyper-v-and-windows-server-failover-clusters)


## Roll up Availability through FileServices.StorageContainsHostParticipation {#hypervprivatecloud.capability.fileservices.participation.availability.dependency.monitor}

`HyperVPrivateCloud.Capability.FileServices.Participation.Availability.Dependency.Monitor`

Preserves the originating health aspect through this domain dependency. Open the unhealthy member monitor for the actual cause; this rollup does not create a second incident.

### Support scope

Hyper-V storage over SMB: client/server participation, share and VHDX mappings, sessions, security policy, continuous availability, witness and multichannel resilience.

Element: HyperVPrivateCloud.Capability.FileServices.Participation.Availability.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.StorageComponent; relationship=HyperVPrivateCloud.Capability.FileServices.StorageContainsHostParticipation; member monitor=Health!System.Health.AvailabilityState; parent=Health!System.Health.AvailabilityState; algorithm=WorstOf; unavailable-member policy=Success. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Identify the client host and exact server/share path. Inspect Get-SmbConnection, Get-SmbMultichannelConnection and the matching share on its server; compare negotiated signing, encryption and continuous-availability properties with policy. Correlate SMBClient/SMBServer event channels, latency and transport errors. A client-side test alone cannot prove the server service is stopped.

### Corrective action and escalation

Restore the affected SMB service, path or network after impact review; correct share permissions and authentication with the file-services team. Preserve security requirements. Never enable SMB1, disable signing/encryption or disconnect all SMB sessions to make a monitor green.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Verify the intended share and VM disk are reachable, required security and redundancy are negotiated, errors stop and representative I/O recovers.

### Microsoft references

[Microsoft Learn: troubleshoot smb guidance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/networking/troubleshoot-smb-guidance)

[Microsoft Learn: storage issues in hyper v and windows server failover clusters](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/storage-issues-in-hyper-v-and-windows-server-failover-clusters)


## Roll up Performance through FileServices.StorageContainsHostParticipation {#hypervprivatecloud.capability.fileservices.participation.performance.dependency.monitor}

`HyperVPrivateCloud.Capability.FileServices.Participation.Performance.Dependency.Monitor`

Preserves the originating health aspect through this domain dependency. Open the unhealthy member monitor for the actual cause; this rollup does not create a second incident.

### Support scope

Hyper-V storage over SMB: client/server participation, share and VHDX mappings, sessions, security policy, continuous availability, witness and multichannel resilience.

Element: HyperVPrivateCloud.Capability.FileServices.Participation.Performance.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.StorageComponent; relationship=HyperVPrivateCloud.Capability.FileServices.StorageContainsHostParticipation; member monitor=Health!System.Health.PerformanceState; parent=Health!System.Health.PerformanceState; algorithm=WorstOf; unavailable-member policy=Success. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Identify the client host and exact server/share path. Inspect Get-SmbConnection, Get-SmbMultichannelConnection and the matching share on its server; compare negotiated signing, encryption and continuous-availability properties with policy. Correlate SMBClient/SMBServer event channels, latency and transport errors. A client-side test alone cannot prove the server service is stopped.

### Corrective action and escalation

Restore the affected SMB service, path or network after impact review; correct share permissions and authentication with the file-services team. Preserve security requirements. Never enable SMB1, disable signing/encryption or disconnect all SMB sessions to make a monitor green.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Verify the intended share and VM disk are reachable, required security and redundancy are negotiated, errors stop and representative I/O recovers.

### Microsoft references

[Microsoft Learn: troubleshoot smb guidance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/networking/troubleshoot-smb-guidance)

[Microsoft Learn: storage issues in hyper v and windows server failover clusters](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/storage-issues-in-hyper-v-and-windows-server-failover-clusters)


## Roll up Configuration through FileServices.StorageContainsHostParticipation {#hypervprivatecloud.capability.fileservices.participation.configuration.dependency.monitor}

`HyperVPrivateCloud.Capability.FileServices.Participation.Configuration.Dependency.Monitor`

Preserves the originating health aspect through this domain dependency. Open the unhealthy member monitor for the actual cause; this rollup does not create a second incident.

### Support scope

Hyper-V storage over SMB: client/server participation, share and VHDX mappings, sessions, security policy, continuous availability, witness and multichannel resilience.

Element: HyperVPrivateCloud.Capability.FileServices.Participation.Configuration.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.StorageComponent; relationship=HyperVPrivateCloud.Capability.FileServices.StorageContainsHostParticipation; member monitor=Health!System.Health.ConfigurationState; parent=Health!System.Health.ConfigurationState; algorithm=WorstOf; unavailable-member policy=Success. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Identify the client host and exact server/share path. Inspect Get-SmbConnection, Get-SmbMultichannelConnection and the matching share on its server; compare negotiated signing, encryption and continuous-availability properties with policy. Correlate SMBClient/SMBServer event channels, latency and transport errors. A client-side test alone cannot prove the server service is stopped.

### Corrective action and escalation

Restore the affected SMB service, path or network after impact review; correct share permissions and authentication with the file-services team. Preserve security requirements. Never enable SMB1, disable signing/encryption or disconnect all SMB sessions to make a monitor green.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Verify the intended share and VM disk are reachable, required security and redundancy are negotiated, errors stop and representative I/O recovers.

### Microsoft references

[Microsoft Learn: troubleshoot smb guidance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/networking/troubleshoot-smb-guidance)

[Microsoft Learn: storage issues in hyper v and windows server failover clusters](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/storage-issues-in-hyper-v-and-windows-server-failover-clusters)


## Roll up Security through FileServices.StorageContainsHostParticipation {#hypervprivatecloud.capability.fileservices.participation.security.dependency.monitor}

`HyperVPrivateCloud.Capability.FileServices.Participation.Security.Dependency.Monitor`

Preserves the originating health aspect through this domain dependency. Open the unhealthy member monitor for the actual cause; this rollup does not create a second incident.

### Support scope

Hyper-V storage over SMB: client/server participation, share and VHDX mappings, sessions, security policy, continuous availability, witness and multichannel resilience.

Element: HyperVPrivateCloud.Capability.FileServices.Participation.Security.Dependency.Monitor. Kind: DependencyMonitor.

### Why warning or critical

Target=HCSV2Library!HyperVPrivateCloud.StorageComponent; relationship=HyperVPrivateCloud.Capability.FileServices.StorageContainsHostParticipation; member monitor=Health!System.Health.SecurityState; parent=Health!System.Health.SecurityState; algorithm=WorstOf; unavailable-member policy=Success. The parent inherits the evaluated member state; it does not independently diagnose that member. Open the unhealthy member monitor to see the originating condition. Unavailable-member handling is not evidence of healthy telemetry and is distinct from an empty or unmonitored relationship.

### Read-only investigation

Identify the client host and exact server/share path. Inspect Get-SmbConnection, Get-SmbMultichannelConnection and the matching share on its server; compare negotiated signing, encryption and continuous-availability properties with policy. Correlate SMBClient/SMBServer event channels, latency and transport errors. A client-side test alone cannot prove the server service is stopped.

### Corrective action and escalation

Restore the affected SMB service, path or network after impact review; correct share permissions and authentication with the file-services team. Preserve security requirements. Never enable SMB1, disable signing/encryption or disconnect all SMB sessions to make a monitor green.

Capture object identity, owner, UTC timestamps, actual value/state, effective threshold, first error, relevant event IDs and recent changes. Escalate with that evidence when the cause remains uncertain. Disruptive or security-changing actions require the service owner and a recovery plan.

### Verify recovery

Verify the intended share and VM disk are reachable, required security and redundancy are negotiated, errors stop and representative I/O recovers.

### Microsoft references

[Microsoft Learn: troubleshoot smb guidance](https://learn.microsoft.com/en-us/troubleshoot/windows-server/networking/troubleshoot-smb-guidance)

[Microsoft Learn: storage issues in hyper v and windows server failover clusters](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/storage-issues-in-hyper-v-and-windows-server-failover-clusters)
