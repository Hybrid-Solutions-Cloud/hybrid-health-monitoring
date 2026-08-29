# Hyper-V Private Cloud Monitoring v2 source

This is the clean v2 authoring root. It is intentionally separate from the published `0.1`
preview source one directory above it. V2 uses the immutable element namespace
`HybridSolutionsCloud.HyperVPrivateCloud` and the console-facing product name **Hyper-V Private
Cloud Monitoring**.

The build manifest records an explicit implementation status for every required artifact. Build
automation refuses to treat a planned artifact as authored, preventing an incomplete source tree
from being packaged as the complete core. Library, Discovery, Monitoring, and Presentation are
authored. This four-pack core is not the complete public product: optional capability packs,
customer override MPs, representative labs, governed signing, packaging, and publication remain.

Core Discovery includes the VMMS registry seed plus staged topology for stable standalone/cluster
boundaries, hosts, VMs, VHDs, VM adapters, virtual switches, Replica relationships, monitoring
pipelines, and all seven Distributed Application branches. Optional Cluster/CSV, SAN/Pure, S2D,
File Services, physical network, Network ATC, SDN, and VMM topology remains isolated in capability
MPs.

Core Monitoring currently provides 13 host unit monitors, nine agent-hosted per-VM runtime unit
monitors, 14 DA dependency rollups, 12 performance rules, a diagnostic task, and operational
knowledge for every unit monitor. The runtime projection lets workflows execute on the VM's
current host while preserving a separate logical VM identity through migration.

Core Presentation provides the operator-facing **Hyper-V Private Cloud** console root, eight
domain folders, 17 localized health, diagram, alert, event, inventory, and performance views, and
a native SCOM Distributed Application diagram targeted at the service class. Capability packs add
their own domain views beneath this public root without modifying the sealed core Presentation MP.

The first seven optional capabilities are also authored:

- `Capability.Cluster` references Microsoft Failover Cluster `10.1.0.0` and Cluster Shared Volume
  `10.1.2.2` objects rather than rediscovering them. It adds six service-impact relationships, one
  HCS integration-pipeline monitor, five leaf-health rollups, and seven cluster/CSV console views.
  Microsoft remains the cluster and CSV leaf-alert authority.
- `Capability.Storage` discovers Windows-visible SAN logical units, host attachments, MPIO path
  state, iSCSI sessions, Fibre Channel ports, and VHDX-to-LUN mappings. It adds five health
  monitors, three Storage-branch rollups, and six console views. Stable hashed HCS keys preserve
  identity while the raw Windows serial and unique IDs remain available for vendor correlation.
- `Capability.S2D` reuses the seven public object families in Microsoft's S2D package `1.0.47.4`:
  subsystem, node, physical disk, pool, virtual disk, volume, and file share. It adds seven
  private-cloud Storage relationships and rollups, one HCS integration-pipeline monitor, and 11
  console views for state, performance, faults, jobs, and alerts. Microsoft remains the leaf-alert
  and performance-collection authority.
- `Capability.PureStorage` requires Pure's `PureStorageFlashArray` `2.0.120.0` MP and reuses its
  arrays, controllers, hosts, host groups, ports, volumes, pods, leaf health, alerts, and
  performance data. It adds four HCS service relationships, four dependency rollups, one
  integration-pipeline monitor, and 11 console views. Correlation is read-only and exact:
  IQN/WWPN joins Pure hosts to Windows SAN initiators, and serial numbers join Pure volumes to HCS
  logical units. Ambiguous or missing identities are left uncorrelated rather than guessed.
- `Capability.FileServices` requires Microsoft's File & iSCSI Services `10.1.0.4` package. It
  discovers only Hyper-V virtual disks on UNC paths and adds stable SMB share, Multichannel/RDMA
  path, and VHDX mapping projections. Seven relationships connect shares to Storage, hosts, VMs,
  disks, and the authoritative Microsoft SMB service; one host monitor validates required
  connections and continuous availability, with RDMA opt-in by override. Seven views expose the
  combined HCS/Microsoft topology without duplicating Microsoft file-server alerts.
- `Capability.PhysicalNetwork` references the SCOM 2016 public network-contract floor and remains
  compatible with matching later built-in network libraries. It defines no device, switch, port,
  VLAN, connection, SNMP workflow, or duplicate alert. Two relationships attach external Hyper-V
  switches and the private-cloud Network branch to the exact Microsoft Windows physical-adapter
  objects used by SCOM's MAC-based topology merge. One input-health monitor, two dependency
  rollups, and eight network views expose the integration while SCOM retains authoritative device
  discovery, topology, leaf health, alerts, and performance.
- `Capability.NetworkATC` models a stable boundary-level intent plus hosted per-node and global
  configuration status. Six relationships connect intents, hosts, exact Windows adapters, and the
  Network DA branch. Four read-only unit monitors cover authority/capability presence, convergence,
  adapter readiness, and global settings; four dependency rollups and seven views expose service
  impact. Missing ATC is Not Applicable unless explicitly required, and the pack never retries or
  changes an intent.

Storage Core does not model arrays and does not duplicate Microsoft S2D objects. Pure Storage and
S2D remain independent adapter packs; installing both will populate the same private-cloud Storage
branch without either discovery path disabling the other.

The Cluster capability requires the Microsoft Cluster and Windows Server/CSV MPs plus the
`FailoverClusters` PowerShell module on participating nodes. It is optional and has no effect on a
standalone core installation.

The Storage capability requires the Windows `Storage` module. MPIO monitoring requires the
Multipath-IO feature and a correctly configured Microsoft or vendor DSM. iSCSI monitoring requires
the Windows iSCSI module; Fibre Channel monitoring requires an HBA driver that exposes the standard
`MSFC_FibrePortHBAAttributes` WMI provider.

The Pure Storage capability is supported only on the vendor MP's documented SCOM 2016, 2019, and
2022 lane. Pure's MP must discover the FlashArray before this adapter can add relationships. The
adapter does not use the vendor Run As profile, call the FlashArray REST API, or modify the array.

The File Services capability requires the complete Microsoft Windows Server File & iSCSI Services
`10.1.0.4` bundle and the Windows `SmbShare` and Hyper-V PowerShell modules on compute hosts. The
Cluster capability remains independently optional: install it for SOFS cluster/role service impact,
but a nonclustered Hyper-V-over-SMB deployment does not acquire a hard Cluster MP dependency.

The Physical Network capability requires SCOM network discovery to be configured for the relevant
switches and the matching built-in `System.NetworkManagement.Library`. HCS never reads or stores
SNMP community strings. The local probe validates only the stable DeviceID and MAC inputs supplied
to Microsoft's correlation engine; operators must confirm the resulting computer-adapter-to-port
path in the SCOM network diagram before treating physical-switch service impact as certified.

The Network ATC capability initially targets supported Windows Server 2025 Hyper-V clusters. Each
participating node requires the NetworkATC, Hyper-V, Failover-Clustering, Data-Center-Bridging, and
FS-SMBBW features with management tools, plus symmetric Up physical adapters. Successful intent
health requires ConfigurationStatus Success, ProvisioningStatus Completed, and no error. Storage
intents require RDMA by default. `RequireNetworkATC` remains false for manual, VMM, SDN, and other
external networking authorities.

Build the currently authored artifacts with PowerShell 7:

```powershell
./tools/Build-HyperVPrivateCloudManagementPacks.ps1 `
  -Version 2.0.0.0 `
  -PublicKeyToken 0123456789abcdef
```

Development XML is written to `out/development/`. Release sealing remains a separate governed
step and requires the repository signing identity.
