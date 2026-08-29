# Hyper-V Private Cloud Monitoring v2 source

This is the clean v2 authoring root. It is intentionally separate from the published `0.1`
preview source one directory above it. V2 uses the immutable element namespace
`HybridSolutionsCloud.HyperVPrivateCloud` and the console-facing product name **Hyper-V Private
Cloud Monitoring**.

The build manifest records an explicit implementation status for every required artifact. Build
automation refuses to treat a planned artifact as authored, preventing an incomplete source tree
from being packaged as the complete core. Library, Discovery, Monitoring, Presentation, all nine
capability packs, and the profile-aware override generator are authored. This source tree is not a
public release: representative labs, governed signing, packaging, and publication remain.

Core Discovery includes the VMMS registry seed plus staged topology for stable standalone/cluster
boundaries, hosts, VMs, VHDs, VM adapters, virtual switches, Replica relationships, monitoring
pipelines, and all seven Distributed Application branches. Optional Cluster/CSV, SAN/Pure, S2D,
File Services, physical network, Network ATC, SDN, and VMM topology remains isolated in capability
MPs.

Core Monitoring currently provides 13 host unit monitors, nine agent-hosted per-VM runtime unit
monitors, 14 DA dependency rollups, 12 performance rules, a diagnostic task, and operational
knowledge for every unit monitor. The runtime projection lets workflows execute on the VM's
current host while preserving a separate logical VM identity through migration.

All first-party script workflows launch the machine-wide PowerShell 7 MSI executable at
`%ProgramFiles%\PowerShell\7\pwsh.exe` through public SCOM command-executor modules. PowerShell 7
at that exact path is a prerequisite on every workflow host. The diagnostic task reports the
actual process, edition, version, home, automation assembly, and bitness so representative SCOM
labs can prove the execution boundary. See
[ADR 0047](../../../../docs/design/decisions/0047-hyper-v-v2-explicit-powershell-7-execution.md).

Core Presentation provides the operator-facing **Hyper-V Private Cloud** console root, eight
domain folders, 17 localized health, diagram, alert, event, inventory, and performance views, and
a native SCOM Distributed Application diagram targeted at the service class. Capability packs add
their own domain views beneath this public root without modifying the sealed core Presentation MP.

The nine optional capabilities are also authored:

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
- `Capability.SDN` requires Microsoft's `Microsoft.Windows.10.SDNMonitoring` `10.0.0.2` MP and
  leaves Network Controller REST discovery, credentials, topology, leaf health, alerts,
  performance, and native views with Microsoft. One hosted HCS binding records local HostId and
  host-agent evidence without fabricating a Microsoft SDN Host identity. Ten relationships, one
  integration monitor, 11 dependency rollups, and 16 views attach authoritative Microsoft SDN
  health to the private-cloud Management and Networking branches.
- `Capability.VMM` is pinned to the exact inspected System Center 2025 VMM contract: Library,
  Discovery, and Monitoring `11.19.0.3`, plus PRO v2 Library `10.25.1200.0`. It reuses Microsoft's
  SDK-populated fabric objects, leaf health, alerts, performance, dashboards, and reports. HCS adds
  only a VMM-fabric DA root, exact server/host/cloud relationships, two missing logical-network and
  network-site projection classes, a read-only failed-job monitor, ten targeted rollups, and 20
  views. Queries use Microsoft's VMM Server Connection Run As profile with at least a scoped VMM
  Read-Only Administrator account and never read SQL or perform remediation.

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
intents require RDMA by default. `RequireNetworkATC` remains false until enabled for the intended
host groups. Network ATC may coexist with SDN or VMM when they own different networking layers;
the product prevents duplicate object health paths rather than disabling legitimate coexistence.

The SDN capability requires both Microsoft SDN MPs to be imported and fully configured first,
including agentless Network Controller nodes, Microsoft's SDN Monitoring Account Run As profile,
and Network Controller REST certificate trust. The HCS adapter never uses that credential or calls
Network Controller REST. It reads only the local `NcHostAgent` HostId and `NcHostAgent`/
`SlbHostAgent` service states and relies on Microsoft for all authoritative SDN objects and alerts.

The VMM capability initially supports only the exact inspected System Center 2025 VMM Management
Pack set. VMM integration and Microsoft object discovery must be healthy first. Configure the
public VMM Server Connection Run As profile with a dedicated, scoped VMM Read-Only Administrator
account. Build-matched VMM 2019, 2022, future 2025 updates, VMM service failover, logical-network
and network-site lifecycle, failed-job recovery, cloud-to-cluster mapping, coexistence, and removal
remain representative-lab certification gates.

## Deployment profiles and overrides

The v2 generator composes the four-pack core with only the capability MPs selected by one of the
11 deployment profiles in `../contracts/packages.v2.json`. Each profile has separate Lab,
Standard, and Strict Discovery/Monitoring override MPs, producing 66 committed examples. The
examples are generated from `templates/overrides/tuning-catalog.json`; they are not hand-edited.

Generate customer-owned overrides with an independent customer version and the exact installed
sealed-product version and token:

```powershell
./tools/New-HyperVPrivateCloudOverrideManagementPacks.ps1 `
  -DeploymentProfile ClusteredS2D `
  -TuningTier Standard `
  -OrganizationId Contoso `
  -OrganizationName 'Contoso' `
  -Version 1.0.0.0 `
  -ProductVersion 2.0.0.0 `
  -PublicKeyToken 0123456789abcdef `
  -OutputPath ./out/contoso-overrides
```

`ProductVersion` and `PublicKeyToken` have no defaults because guessing either creates an
unimportable MP. Standard examples include an all-hosts dynamic group in the same unsealed
Monitoring Overrides MP as the group-targeted core host monitor and performance-rule overrides.
Custom schema-2.0 profiles may define their own Discovery or Monitoring groups; the generator
rejects a group reference that crosses the two unsealed MPs.

Regenerate the public example matrix after any catalog, profile, or generator change:

```powershell
./tools/Update-HyperVPrivateCloudOverrideExamples.ps1
```

CI builds the 13 product MPs, regenerates all examples, byte-compares them, and resolves every
override workflow, target, module, property, and parameter against the built product XML. Release
packaging replaces `{{VERSION}}`, `{{PRODUCT_VERSION}}`, and `{{PUBLIC_KEY_TOKEN}}` with governed
release facts; `.xml.example` files themselves are not import-ready release assets.

Build the currently authored artifacts with PowerShell 7:

```powershell
./tools/Build-HyperVPrivateCloudManagementPacks.ps1 `
  -Version 2.0.0.0 `
  -PublicKeyToken 0123456789abcdef
```

Development XML is written to `out/development/`. Release sealing remains a separate governed
step and requires the repository signing identity.

## Release packaging

`tools/New-HyperVPrivateCloudReleasePackage.ps1` is the only supported v2 sealing and package
entry point. It derives the product token from the supplied key, builds all 13 authored MPs,
optionally performs ordered VSAE verification, seals through Microsoft VSAE `SealMp`, verifies the
strong names, generates all 66 public override MPs, and creates complete, core, override, and
deployment-profile ZIPs with stable filenames. The output also contains individual sealed MPs,
the prerequisite/release manifest, publisher dependency filenames/hashes/identities, an asset
catalog, and SHA-256 checksums. Publisher `.mpb` prerequisite identities are inspected with
Microsoft's packaging SDK and their Authenticode status is recorded; transient token-remapped copies used only to satisfy VSAE reference
resolution remain in the working directory and are never published.

Use `BuildMode Test` with a transient key for package engineering. Test output is always marked
`releaseEligible=false`. `BuildMode Release` cannot skip VSAE and requires an approved permanent
signing assertion plus a version-matched runtime evidence receipt. Validate final output with:

```powershell
./tools/Test-HyperVPrivateCloudReleasePackage.ps1 `
  -PackagePath D:/release/hyper-v-private-cloud-v2 `
  -RequireReleaseEligible
```

Public release execution is restricted to `.github/workflows/release-hyper-v-v2.yml` on the
protected `hyper-v-scom-production-release` environment. See the
[governed release runbook](../../../../docs/design/hyper-v/release-runbook.md) for runner,
workload-identity, evidence, Key Vault, and publication requirements.

The signing key must remain outside the repository and is never copied into output. See
[ADR 0048](../../../../docs/design/decisions/0048-hyper-v-v2-governed-sealing-and-release-assets.md).
