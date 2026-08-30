---
title: Hyper-V Private Cloud v2 dependency and ownership contract
description: Evidence-backed ownership and dependency rules for Microsoft, vendor, and HCS objects in the Hyper-V Private Cloud Monitoring v2 Management Pack suite.
---

# Hyper-V Private Cloud v2 dependency and ownership contract

This contract implements
[ADR 0040](../decisions/0040-hyper-v-v2-microsoft-s2d-and-sdn-ownership.md), which supersedes the
pre-inspection assumptions in ADR 0039.

## Decision summary

Hyper-V Private Cloud Monitoring v2 reuses stable, public objects from supported sealed Microsoft
and vendor Management Packs when those packs already own the resource. HCS owns the private-cloud
service projection, missing domain objects, cross-domain correlations, and service-impact
relationships. It does not create a second cluster, cluster node, cluster network, cluster resource,
or Cluster Shared Volume identity merely to place that object in an HCS view.

The console product name is **Hyper-V Private Cloud Monitoring** and its monitoring root is
**Hyper-V Private Cloud**. Internal IDs use the new `HyperVPrivateCloud`
namespace. The public `HybridSolutionsCloud.HyperV` preview remains a separate compatibility
surface; v2 does not rename or repurpose its released element IDs.

## Verified Microsoft contracts

The following inventory was produced from the sealed, Microsoft-published packages, not inferred
from display names or documentation screenshots.

| Package inspected | Published version | Public contract relevant to v2 |
|---|---:|---|
| Operations Manager built-in Windows Cluster Library | `7.0.8447.6` in the OM2022 authoring reference set | `Microsoft.Windows.Cluster`, `Microsoft.Windows.Cluster.Service`, and `Microsoft.Windows.Cluster.VirtualServer`; no public CSV class |
| Windows Server Cluster 2016 and above | `10.1.0.0` | Public cluster component, node, node role, group, hosted group, network, resource, monitoring-service, and containment/hosting relationships |
| Windows Server Operating System 2016 and above | `10.1.2.2` | Public Windows Server computer, operating-system, disk, adapter, processor, and group model |
| Windows Server Cluster Shared Volume Monitoring | `10.1.2.2` | Public CSV and cluster-disk classes, CSV discovery, free-space monitors, performance collection, and dashboards |
| Storage Spaces Direct | `1.0.47.4` | Public storage subsystem, node, physical disk, pool, virtual disk, volume, file-share, group, and topology relationships; discovery, health, performance, and presentation |
| Windows Server SDN | `10.0.0.2` | Public stamp, controller-node, host, virtual-network, ACL, network-interface, MUX, virtual-gateway, connection, BGP, gateway-pool, and gateway model; discovery, health, collection, and views |

Microsoft's current SCOM guidance also says that the Windows Server Operating System Management
Pack provides CSV discovery and monitoring. That makes an HCS-owned parallel CSV identity an
integration defect for v2, not added coverage.

The inspected CSV MP exposes `Microsoft.Windows.Server.ClusterSharedVolumeMonitoring.`
`ClusterSharedVolume` with `ClusterSharedVolumeName` as its key and discovers it beneath the
Microsoft cluster virtual-server identity. The inspected Cluster MP exposes public containment from
`Microsoft.Windows.Cluster` to node, group, and network and hosting from hosted groups to cluster
resources. These are suitable endpoints for HCS-owned reference and service-membership
relationships. The S2D base library uses `UniqueID` keys for its public storage resources. The SDN
pack uses public `Id` keys for its non-singleton resources. These stable public identities are
suitable relationship endpoints and must not be duplicated by v2.

## Required and optional dependency boundary

| HCS v2 capability pack | External dependency | Policy |
|---|---|---|
| Core library, compute, and base presentation | Operations Manager built-in System, Windows, System Center, Health, Performance, and Service Designer libraries | Required; retain the lowest verified reference versions that contain the used types |
| Failover Cluster Integration | Microsoft Windows Server Cluster 2016 and above MPs, minimum package `10.1.0.0` | Optional for standalone; mandatory before importing the HCS cluster capability |
| CSV Integration | Microsoft Windows Server Operating System 2016 and above including `Microsoft.Windows.Server.ClusterSharedVolumeMonitoring`, minimum package `10.1.2.2` | Optional for standalone; mandatory before importing the HCS CSV/service-impact adapter |
| S2D Integration | Microsoft Storage Spaces Direct MP, minimum package `1.0.47.4`, plus its declared Microsoft Storage library | Never a core dependency; reuse Microsoft S2D objects and add only verified gaps, cluster/CSV/VM correlations, coverage, and service impact |
| SAN Core | Windows Server storage, MPIO, iSCSI, Fibre Channel, SMB, and cluster contracts | HCS owns common path/LUN/mapping projections only where no supported sealed MP owns them |
| Pure Storage Integration | Pure Storage FlashArray MP `2.0.120.0` for SCOM 2016/2019/2022 and Purity 5.3+ | Never a core dependency; reuse Pure arrays, controllers, hosts, host groups, ports, volumes, and pods; HCS adds the SAN-to-VM correlation chain and DA impact only |
| VMM Integration | Matching Microsoft VMM Management Packs for the supported VMM/SCOM version pair | Never a core dependency; reference VMM clouds, host groups, logical networks, logical switches, storage, and jobs instead of rediscovering them |
| SDN Integration | Microsoft Windows Server SDN MP, minimum package `10.0.0.2` | Never a core dependency; Microsoft owns REST discovery, credentials, topology, leaf health, alerts, and performance; HCS adds read-only host-binding evidence, verified missing rollups, correlations, and service impact |
| SMB/SOFS Integration | Microsoft Windows Server File & iSCSI Services package `10.1.0.4` plus matching Cluster MPs for SOFS | Reuse Microsoft File Server, clustered SMB, iSCSI Target, cluster role/resource, and leaf health; HCS owns only missing share/path/VHDX/VM mappings and service impact |
| Physical Network Integration | Built-in SCOM network libraries matching the installed SCOM version | Reuse nodes, switches, ports/interfaces, VLANs, connections, server-port correlation, health, and performance; HCS adds private-cloud membership, coverage, and service impact |
| Network ATC | Windows Server NetworkATC feature and PowerShell module; no external MP dependency | HCS owns stable intent and per-node status projections, read-only status/adapter health, override-kind inventory, and Network-branch service impact; it may coexist with SDN or VMM when those products own a different layer |

An optional capability's presentation and Distributed Application population are packaged with or
behind that capability. The base presentation MP must not take every optional dependency and turn a
standalone installation into an all-or-nothing import.

## Object ownership rules

1. A supported sealed Microsoft or vendor class remains the authoritative identity when it
   represents the same real resource and exposes stable public keys.
2. HCS may define a relationship whose endpoint is an external public class. That is the normal
   mechanism for traversal into the private-cloud DA, diagram, state, alert, and performance views.
3. HCS defines a new class only for a missing concept, an HCS-owned service projection, or a
   materially different lifecycle/identity that cannot safely specialize the external class.
4. Discovery never submits a competing external object with guessed keys. Correlation must use the
   documented external keys and be proven in standalone, failover, rename, migration, and removal
   tests.
5. External leaf monitors remain the leaf alert authority. HCS dependency monitors roll their
   health into service impact without creating duplicate symptom alerts.
6. Optional dependencies are isolated in adapter MPs. Core compute remains importable and useful
   without Cluster, CSV, S2D, Pure, VMM, or SDN packs.

## SAN Core contract

`Capability.Storage` owns only the Windows-host projection that is not supplied as an equivalent
supported sealed model: a stable logical unit, its per-host attachment, iSCSI sessions, Fibre
Channel ports, and the VHDX-to-Windows-volume/disk/LUN mapping. Discovery uses `Get-Disk`, the
Storage volume/partition commands, `Get-IscsiSession`, `MPIO_DISK_INFO`, and
`MSFC_FibrePortHBAAttributes`. LUN keys are SHA-256 projections of the Windows unique ID or serial;
the raw identifiers remain properties for read-only vendor correlation.

The pack monitors Windows disk availability and writability, MPIO minimum path count, iSCSI session
connections, FC port state, and query-pipeline coverage. It does not configure MPIO claiming, DSM
policy, iSCSI targets, zoning, or array state. Pure owns FlashArray objects and alerts. Microsoft
owns S2D objects and alerts. Their optional adapters relate those authoritative objects to SAN Core
and the private-cloud DA; SAN and S2D discovery are independent and may be enabled together.

## S2D adapter contract

`Capability.S2D` defines no storage resource class. It relates the seven public Microsoft S2D
families—storage subsystem, node, physical disk, pool, virtual disk, volume, and file share—to the
private-cloud Storage component using their inherited `UniqueID` keys and complete hosting chains.
Seven dependency monitors roll `System.Health.AvailabilityState`; unavailable members are Success
so an absent optional family does not make a SAN-only or partially populated deployment unhealthy.

One HCS monitor checks only the local Storage query path on a Microsoft-discovered subsystem. The
Microsoft pack remains responsible for Health Service faults/actions, ongoing jobs, physical-disk
telemetry, subsystem/node/pool/volume/file-share health, alerts, and performance collection. HCS
views expose those authoritative objects and signals under the private-cloud Storage console root.
The adapter's sealed references use the lowest compatible `1.0.0.0` identity while the supported
installation floor remains the inspected Microsoft package `1.0.47.4`.

## v2 service graph

```mermaid
flowchart LR
    ROOT[Hyper-V Private Cloud service] --> COMPUTE[HCS compute projection]
    ROOT --> CLUSTER[Cluster service branch]
    ROOT --> STORAGE[Storage service branch]
    ROOT --> NETWORK[Network service branch]
    ROOT --> MGMT[Management plane branch]

    CLUSTER --> MSCLUSTER[Microsoft cluster and node objects]
    STORAGE --> MSCSV[Microsoft CSV objects]
    STORAGE --> S2D[Microsoft S2D objects]
    STORAGE --> SAN[HCS SAN mapping objects]
    SAN --> PURE[Pure Storage objects or adapter]
    NETWORK --> SWITCH[HCS Hyper-V switch and adapter correlations]
    MGMT --> VMM[Microsoft VMM objects]
    MGMT --> SDN[Microsoft SDN objects]
```

S2D and SAN branches are independent and may both populate the same private-cloud service. No
capability-detection path is allowed to disable the other.

## Pure Storage contract

[ADR 0041](../decisions/0041-hyper-v-v2-pure-storage-integration.md) approves the vendor-integrated
Pure lane for SCOM 2016, 2019, and 2022. The inspected sealed bundle is
`PureStorageFlashArray` `2.0.120.0`, public key token `a9d994eedb5e7179`. Its public model exposes:

- `PureStorage.FlashArray.PureArray`, keyed by `ArrayId`;
- `PureStorage.FlashArray.PureController`, `PureHost`, `PureHostgroup`, `PurePort`, and
  `PureVolume`, keyed within their hosting path by `Name`;
- `PureStorage.FlashArray.Pod`, keyed by `PodId`, and hosted `PodReplica`, keyed by `PodName`; and
- public array-hosting/containment relationships and the public
  `PureStorage.FlashArray.FlashArrayAdminAccount` Secure Reference.

The vendor pack remains responsible for leaf topology, alerts, capacity, performance, and
ActiveCluster pod/mediator health. The authored HCS adapter defines no competing Pure class and
uses no Pure Run As credential or REST control path. It correlates Pure host IQN/WWN values to
Windows iSCSI/FC initiators and Pure volume serials to HCS logical units only when the identity has
exactly one match. It then adds Pure arrays and ports to the private-cloud Storage branch and rolls
authoritative vendor availability health through four relationships. Existing HCS Storage and
core topology carries that impact onward to attached disks, VHDX files, hosts, VMs, and the DA.
The adapter does not acknowledge or close array alerts and does not enable vendor-disabled
high-cardinality volume performance workflows.

Pure's published support evidence does not include SCOM 2025. The v2 preflight therefore rejects
that combination until either Pure publishes support or a mutually exclusive HCS Purity REST 2.x
provider passes its own security, scale, migration, and representative-array gates.

## SMB/SOFS and physical network contracts

[ADR 0042](../decisions/0042-hyper-v-v2-file-services-and-physical-network-ownership.md) makes
Microsoft's File & iSCSI and built-in SCOM network objects authoritative. File & iSCSI Services
package `10.1.0.4` supports Windows Server and SCOM 2016, 2019, 2022, and 2025. The inspected public
model includes File Server, File Server service, SMB service, clustered SMB service, and iSCSI
Target service classes. HCS may add missing concrete SOFS share, Multichannel/RDMA path,
share-to-VHDX/VM correlation, coverage, and service-impact concepts.

The authored `Capability.FileServices` implements this boundary with three HCS-only projections:
an SMB share used by Hyper-V, a client Multichannel/RDMA path, and a share-to-VHDX mapping. Stable
SHA-256 identities are derived from normalized UNC, host/interface endpoints, and VM/disk keys.
Seven relationships attach these projections to the private-cloud Storage branch, Hyper-V hosts,
VMs/disks, and the exact Microsoft SMB service host identity. One HCS monitor validates only the
client-side dependency that Microsoft does not own: required connection presence, continuous
availability, and optionally RDMA. The pack defines no File Server or SMB service class and emits
no duplicate Microsoft leaf alert.

The built-in network libraries expose `System.NetworkManagement.Node`/`Switch`, hosted
`NetworkAdapter`/`Interface`/`Port`, `VLAN`, and `NetworkConnection`. Nodes use `DeviceKey`; hosted
adapters use `Key`. Public topology includes node-to-adapter, VLAN-to-adapter, adapter-peer, and
network-connection-to-`System.NetworkAdapter` relationships. HCS consumes those objects and
Microsoft's server-port correlation rather than rediscovering devices or handling SNMP secrets.

The authored `Capability.PhysicalNetwork` uses the public contract already present in the SCOM
2016 `System.NetworkManagement.Library` `7.2.11719.0`; the same required objects and relationship
were verified in the SCOM 2019 and 2022 libraries. `Microsoft.Windows.ComputerNetworkAdapter`
derives from `System.Device.NetworkAdapter` and carries the exact `DeviceID` key plus MAC address.
SCOM's built-in merging workflow matches `System.Device.NetworkAdapter` instances by MAC, writes
`System.NetworkManagement.NetworkConnectionConnectedToNetworkAdapter`, and computes peer topology.

HCS therefore defines only two relationships: the private-cloud Network branch contains the
participating Windows physical adapters, and each external Hyper-V virtual switch references its
Windows physical uplinks. It adds one local correlation-input health monitor, two dependency
rollups, and eight views. It does not define a network resource class, discover a switch or port,
read an SNMP credential, or emit a competing network-device alert. The local monitor proves the
identity inputs, not management-group topology completeness; the resulting SCOM network diagram is
a representative-lab and deployment verification gate.

## Network ATC contract

[ADR 0044](../decisions/0044-hyper-v-v2-network-atc-monitoring-contract.md) defines the optional,
read-only Network ATC adapter. A cluster-floating request is represented by one unhosted
`NetworkIntent`, keyed by `BoundaryId` and `IntentName`; each Windows computer contributes a hosted
`NetworkIntentNodeStatus` for the actual per-node convergence state. A hosted
`GlobalConfigurationStatus` records cluster/proxy override kinds and convergence without storing
proxy values or complete override payloads.

Six relationships attach intents and global settings to the private-cloud Network component,
connect each logical intent to its node status, connect HCS hosts to their local status objects,
and connect node status to exact `Microsoft.Windows.ComputerNetworkAdapter` identities. Four unit
monitors cover selected authority/capability presence, intent convergence, adapter readiness, and
global-setting convergence. Four dependency monitors roll adapter-to-node-to-intent health and
then Network-branch service impact without alerts on the aggregate monitors.

Healthy convergence requires `ConfigurationStatus = Success`, `ProvisioningStatus = Completed`,
and no error. Failed/error states and convergence that exceeds the configurable 30-minute default
are Critical; active convergence and unrecognized states are Warning. Storage intents require
RDMA by default. Missing Network ATC or no intent is Not Applicable unless `RequireNetworkATC` is
overridden to true. The implementation never invokes any Network ATC, adapter, switch, QoS, DCB,
VLAN, or service mutation command.

Network ATC and Windows Server SDN are not globally exclusive authorities. Network ATC can own
physical adapters, SET switches, and host intent while Network Controller owns overlay policy and
SDN resources. VMM can orchestrate either layer. Capability coexistence is therefore supported
when ownership is explicit; the same object must still have only one canonical health path.

## Windows Server SDN adapter contract

[ADR 0045](../decisions/0045-hyper-v-v2-windows-server-sdn-integration-contract.md) defines the
optional `Capability.SDN` adapter against Microsoft's signed
`Microsoft.Windows.10.SDNMonitoring` `10.0.0.2` contract. The inspected Microsoft pack exposes 22
classes, 20 relationships, two discoveries, 78 unit monitors, 22 dependency monitors, 45 rules,
15 views, and the `Microsoft.Windows.10.SDNMonitoring.NCRunAsProfile` Secure Reference. Microsoft
remains authoritative for Network Controller REST discovery, credentials, certificates, stamp and
leaf identities, monitors, alerts, performance, and native views.

Before importing HCS SDN, operators must import both Microsoft SDN MPs and complete Microsoft's
setup: add Network Controller nodes as agentless-managed computers, configure a Run As account in
the Network Controller Clients Kerberos Security Group, associate it to the SDN Monitoring Account
profile, and trust the Network Controller REST certificate on the SCOM management server. HCS does
not receive or use that credential and does not call Network Controller REST.

The HCS adapter defines only one hosted `HostBinding` evidence class. It reads the local
`NcHostAgent` `HostId` plus `NcHostAgent` and `SlbHostAgent` service states. The registry value
matches Network Controller server `InstanceId`, whereas Microsoft's SDN Host class is keyed by
resource `ResourceId`; the adapter deliberately does not invent a direct host-to-Microsoft-Host
relationship. It relates the HCS Management and Networking branches to Microsoft's authoritative
fixed-key stamp and groups instead.

One integration monitor reports missing or degraded local binding prerequisites without raising a
duplicate Microsoft SDN leaf alert. Eleven dependency monitors add private-cloud branch impact and
fill the verified missing Network Controller node `SecurityState` rollup. Sixteen views expose the
Microsoft topology, health, alerts, and performance beneath **Hyper-V Private Cloud > Networking >
Software Defined Networking**. Representative SCOM labs must still prove Microsoft setup,
discovery, controller certificate failure/recovery, gateway and overlay faults, service impact,
coexistence with Network ATC/VMM, and clean adapter removal.

## Virtual Machine Manager adapter contract

[ADR 0046](../decisions/0046-hyper-v-v2-virtual-machine-manager-integration-contract.md) defines
the optional `Capability.VMM` adapter. Microsoft documents VMM Management Packs as coupled to the
installed VMM build, so the first support lane is the exact System Center 2025 media contract:
VMM Library, Discovery, and Monitoring `11.19.0.3`, plus PRO v2 Library `10.25.1200.0`, all signed
with Microsoft's `31bf3856ad364e35` token. Similar element IDs in another VMM release are not proof
of compatibility.

Microsoft remains authoritative for VMM management servers, private clouds, host groups, host
clusters, Hyper-V hosts, VMs, VM networks, switches and ports, storage, SDK population, leaf
health, alerts, performance, dashboards, reports, maintenance integration, and PRO. HCS creates no
competing instance or leaf alert. The adapter creates a VMM-fabric service root, attaches exact
Microsoft objects to its DA branches and matching local Hyper-V boundaries, and rolls up Microsoft
server/cloud health plus only the VMM-specific host WinRM and agent-version monitors.

Direct inspection verified that VMM 2025 does not publish logical networks, network sites, or jobs
as SCOM objects or workflows. HCS therefore owns two bounded read-only gap classes—`LogicalNetwork`
and `NetworkSite`, keyed by VMM server plus VMM GUID—and relates them to Microsoft's VM Network
objects. A separate monitor queries `Get-SCJob` for `Failed` jobs in an overrideable 24-hour window.
All VMM queries use Microsoft's public VMM Server Connection Run As profile and require at least a
VMM Read-Only Administrator account scoped across the monitored fabric. The adapter never reads
the VMM database directly and performs no remediation.

Representative SCOM/VMM 2025 labs must still prove Microsoft integration, Run As distribution,
server/host/cloud/logical-network/site topology, failed-job fault and recovery, `ClusterNames`
correlation, management-server failover, Network ATC/SDN coexistence, upgrade, and removal. Direct
HCS-to-VMM VM identity merging remains prohibited until a lab proves that the two product keys are
stable and equal.

## Preview migration boundary

The `0.1` preview is not upgraded by renaming its public elements. The v2 installer and guide must:

- detect the preview before import;
- prevent both products from actively monitoring the same workflows by default;
- preserve preview history for the documented retention/migration window;
- provide explicit disable/remove steps and dependency ordering; and
- state that preview overrides cannot be assumed compatible with the v2 namespace.

## Remaining contract spikes

The following dependency is not approved until its exact public contract is inspected and
recorded in this page:

- the SCOM 2025 Pure Storage path, either vendor-certified or a separately approved read-only
  Purity REST 2.x provider.

## Sources

- [Microsoft Management Packs](https://learn.microsoft.com/en-us/system-center/scom/management-pack-list?view=sc-om-2025)
- [Monitoring Failover Cluster with Operations Manager](https://learn.microsoft.com/en-us/system-center/scom/manage-monitor-clusters-overview?view=sc-om-2025)
- [Windows Server Cluster 2016 and above MP 10.1.0.0](https://www.microsoft.com/en-us/download/details.aspx?id=54701)
- [Windows Server Operating System 2016 and above MP 10.1.2.2](https://www.microsoft.com/en-us/download/details.aspx?id=54303)
- [Storage Spaces Direct MP 1.0.47.4](https://www.microsoft.com/en-us/download/details.aspx?id=100782)
- [Windows Server SDN MP 10.0.0.2](https://www.microsoft.com/en-us/download/details.aspx?id=54300)
- [Troubleshoot the Windows Server SDN stack](https://learn.microsoft.com/en-us/troubleshoot/windows-server/software-defined-networking/troubleshoot-windows-server-software-defined-networking-stack)
- [Deploy an SDN infrastructure in VMM](https://learn.microsoft.com/en-us/system-center/vmm/deploy-sdn?view=sc-vmm-2025)
- [Integrate VMM with Operations Manager](https://learn.microsoft.com/en-us/system-center/vmm/monitors-ops-manager?view=sc-vmm-2025)
- [Manage VMM roles and permissions](https://learn.microsoft.com/en-us/system-center/vmm/manage-account?view=sc-vmm-2025)
- [`Get-SCJob`](https://learn.microsoft.com/en-us/powershell/module/virtualmachinemanager/get-scjob?view=systemcenter-ps-2025)
- [`Get-SCLogicalNetwork`](https://learn.microsoft.com/en-us/powershell/module/virtualmachinemanager/get-sclogicalnetwork?view=systemcenter-ps-2025)
- [`Get-SCLogicalNetworkDefinition`](https://learn.microsoft.com/en-us/powershell/module/virtualmachinemanager/get-sclogicalnetworkdefinition?view=systemcenter-ps-2025)
- [What is in an Operations Manager Management Pack?](https://learn.microsoft.com/en-us/system-center/scom/manage-overview-management-pack?view=sc-om-2025)
- [Pure Storage FlashArray PowerShell SDK 2](https://github.com/PureStorage-Connect/PowerShellSDK2)
- [Pure Storage FlashArray SCOM MP 2.0.120.0](https://github.com/PureStorage-Connect/SCOM-Management-Pack/releases/tag/v2.0.120.0)
- [Windows Server File & iSCSI Services MP 10.1.0.4](https://www.microsoft.com/en-us/download/details.aspx?id=57594)
- [Monitoring networks by using Operations Manager](https://learn.microsoft.com/en-us/system-center/scom/manage-monitor-networkdevice-overview?view=sc-om-2025)
- [MPIO WMI classes](https://learn.microsoft.com/en-us/windows-hardware/drivers/storage/mpio-wmi-classes)
- [`MPIO_DISK_INFO` WMI class](https://learn.microsoft.com/en-us/windows-hardware/drivers/storage/mpio-disk-info-wmi-class)
- [`MPIO_DRIVE_INFO` WMI class](https://learn.microsoft.com/en-us/windows-hardware/drivers/storage/mpio-drive-info-wmi-class)
- [`Get-Disk`](https://learn.microsoft.com/en-us/powershell/module/storage/get-disk?view=windowsserver2022-ps)
- [iSCSI PowerShell module](https://learn.microsoft.com/en-us/powershell/module/iscsi/?view=windowsserver2025-ps)
- [`MSFC_FibrePortHBAAttributes` WMI class](https://learn.microsoft.com/en-us/windows-hardware/drivers/storage/msfc-fibreporthbaattributes-wmi-class)
- [Fibre Channel HBA port-state values](https://learn.microsoft.com/en-us/windows-hardware/drivers/storage/msfc-hbaportattributesresults-wmi-class)
- [Host networking with Network ATC](https://learn.microsoft.com/en-us/windows-server/networking/network-atc/network-atc)
- [Windows Server 2025 Azure Stack HCI networking test](https://learn.microsoft.com/en-us/windows-hardware/test/hlk/testref/device.network.lan.azurestack-testing-server-2025)
- [`Get-NetIntent`](https://learn.microsoft.com/en-us/powershell/module/networkatc/get-netintent?view=windowsserver2025-ps)
- [`Get-NetIntentStatus`](https://learn.microsoft.com/en-us/powershell/module/networkatc/get-netintentstatus?view=windowsserver2025-ps)
- [Manage Network ATC](https://learn.microsoft.com/en-us/windows-server/networking/network-atc/manage-network-atc)
