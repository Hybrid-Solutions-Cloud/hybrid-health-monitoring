# Implementation plan — Hybrid Infrastructure Health Monitoring

> Last updated: August 29, 2026
>
> Status: Azure Local is under development. The published Hyper-V `0.1` lab preview is a
> superseded host-centric baseline, not the complete private-cloud monitoring product. Active
> priority is the clean-sheet Hyper-V Private Cloud Monitoring v2 research, architecture,
> implementation, and representative-lab certification program defined below.
> Published roadmap: <https://labs.hybridsolutions.cloud/hybrid-health-monitoring/project/roadmap>

## Objective

Deliver infrastructure health monitoring for **Hyper-V** and **Azure Local**, organized by
platform first and monitoring surface second:

| Platform | SCOM Management Pack | Azure Monitor Health Models |
|---|---|---|
| **Azure Local** | Under development; not the active delivery priority | Under development |
| **Hyper-V** | V2 redesign is the active priority; `0.1` is a superseded lab preview | Constrained development through Azure Arc-enabled SCVMM and Arc-enabled Servers |

The product can reuse research, health terminology, authoring knowledge, and non-runtime engineering
tooling. Azure Local and Hyper-V remain completely independent SCOM runtime products; they do not
share classes, binaries, Distributed Applications, namespaces, dependencies, packages, versions,
or support lifecycles.

## Execution status and immediate priorities

This file is the authoritative implementation and release plan. Completion means a publicly usable,
sealed, documented, tested, and downloadable product—not merely generated source XML or locally
test-sealed binaries.

| Workstream | Current state | Exit condition |
|---|---|---|
| Core Library, Discovery, Monitoring, and Presentation | Authored; offline contract, OM2022 VSAE/SDK, transient sealing, and strong-name checks pass | Representative SCOM runtime and lifecycle gates pass |
| Cluster and CSV | Capability pack authored against Microsoft Cluster/CSV objects | Cluster discovery, failover, CSV fault/recovery, migration, and removal labs pass |
| Common SAN storage | Capability pack authored | MPIO, path loss/recovery, mapping, capacity, and mixed-storage labs pass |
| Pure Storage FlashArray | Capability pack authored against the vendor MP contract | Representative FlashArray topology, health, failure, recovery, and removal labs pass |
| Storage Spaces Direct | Capability pack authored against Microsoft S2D objects | Fault, repair, job, capacity, performance-history, coexistence, and removal labs pass |
| SMB and Scale-Out File Server | Capability pack authored | Standalone SMB and clustered SOFS/RDMA lifecycle and fault labs pass |
| Physical network integration | Capability pack authored against built-in SCOM network objects | Adapter-to-switch-port correlation, device fault, recovery, and removal labs pass |
| Network ATC | Capability pack authored; offline contracts, OM2022 VSAE, transient sealing, and strong-name checks pass | Representative intent convergence, drift, adapter symmetry/RDMA, authority, lifecycle, and removal labs pass |
| Windows Server SDN | Capability pack authored; offline contracts, OM2022 VSAE, transient sealing, and strong-name checks pass | Microsoft prerequisite setup, topology, certificate/security, controller/gateway fault, coexistence, lifecycle, and removal labs pass |
| Virtual Machine Manager | VMM 2025 adapter authored; offline contracts, OM2022 VSAE, transient sealing, and strong-name checks pass | Microsoft integration, fabric/host/cloud/logical-network/site/job behavior, outage, coexistence, upgrade, and removal labs pass |
| Distributed Application and console | Core DA, diagram, folders, and views authored; capability integration remains | Complete enabled topology is navigable and verified health propagates without duplicate alerts |
| Customer overrides and deployment profiles | Authored: 11 profiles, three tiers, 66 generated Discovery/Monitoring examples; semantic resolution, drift, cookdown, version separation, invalid-profile, same-MP group, and VSAE gates pass | Governed release packaging emits import-ready XML with the signed product version/token, then representative import/export/upgrade/removal labs pass |
| Runtime certification | Explicit public command-executor wrappers now launch the PowerShell 7 MSI path; SCOM 2016/2022 library contracts and static workflow tests pass | HealthService task evidence and every embedded/capability script run under the declared PowerShell 7 contract on every claimed SCOM/Windows Server pair |
| Governed release and public download | VSAE `SealMp` release packager and independent validator authored; a full transient end-to-end run authenticates official S2D, Pure, and VMM `.mpb` dependencies through Microsoft's SDK, transitively resolves them through VSAE, and emits 13 sealed MPs, 66 public overrides, 14 bundles, publisher dependency evidence, manifests, and checksums with `releaseEligible=false` | Proposed ADR 0048 is approved, the permanent identity is provisioned, runtime evidence is approved, then governed signing, clean import, release notes, GitHub assets, and stable site download links are published |

Execute the remaining work in this order:

1. Run the complete automated suite and representative SCOM topology, fault, recovery, scale,
   upgrade, migration, coexistence, and removal labs, including the PowerShell execution-host gate.
2. Seal every release artifact with the governed signing identity, assemble deterministic packages,
   and verify clean imports into supported SCOM versions.
3. Publish the release and make it directly consumable from both surfaces:
   - GitHub release assets contain the complete sealed MP bundle, individual sealed MPs, public
     override starter bundles, checksums, release notes, and installation/migration documentation;
   - the documentation site exposes an obvious **Download now** action using a stable `latest`
     release URL rather than a version-specific or source-tree link; and
   - every download page clearly distinguishes the supported Hyper-V v2 release from the
     superseded `0.1` lab preview and the Azure Local product that remains under development.

No transient signing key, locally sealed output, incomplete capability set, hand-edited override,
or source-only archive satisfies the release requirement.

## Product hierarchy

Azure DevOps is the delivery system of record:

```text
Epic — Deliver Azure Local health monitoring
├── Feature — Deliver the Azure Local SCOM Management Pack
│   ├── Story — Define independent SCOM packaging and coexistence contract
│   ├── Story — Author Azure Local SCOM classes and discoveries
│   │   └── Task — Author Azure Local DA classes and membership
│   ├── Story — Author Azure Local SCOM monitoring and overrides
│   │   └── Task — Author Azure Local DA rollups and operator surfaces
│   └── Story — Validate, package, and document the release
└── Feature — Deliver Azure Monitor health models for Azure Local
    ├── Story — Validate APIs and signal contracts
    ├── Story — Author entities and signals
    ├── Story — Implement deployment, alerts, and workbooks
    └── Story — Validate and document the release

Epic — Deliver Hyper-V health monitoring
├── Feature — Deliver the Hyper-V SCOM Management Pack
│   ├── Story — Research and define the Hyper-V SCOM monitoring catalog
│   │   ├── Tasks — Scope, raw inventories, and prior-MP research inputs
│   │   ├── Tasks — SCOM workflow and threshold engineering
│   │   ├── Task — Lab and fault validation
│   │   ├── Task — Curate the authoring-ready default catalog
│   │   └── Task — Validate the comprehensive MP and DA architecture
│   ├── Story — Author Hyper-V SCOM classes and discoveries
│   │   └── Task — Author Hyper-V DA classes and membership
│   ├── Story — Author Hyper-V SCOM monitoring and separate Discovery/Monitoring overrides
│   │   └── Task — Author Hyper-V DA rollups and operator surfaces
│   └── Story — Validate, package, and document the release
└── Feature — Evaluate Azure Monitor through Arc-enabled SCVMM
    ├── Story — Research inventory and guest management
    ├── Story — Prove telemetry and Health Models feasibility
    ├── Story — Decide go, defer, or no-go
    └── Story — Plan conditional implementation after a go decision
```

Parent-child and predecessor links in Azure DevOps enforce the research and implementation gates.

## Reusable research and engineering practices

### Reuse across both platforms

- SCOM health dimensions and state semantics;
- unit, aggregate, and dependency monitor patterns;
- stable class-key and relationship principles;
- discovery cookdown, fixture, and test patterns;
- alert-versus-health-state separation;
- upgrade-safe override strategy and threshold tiers;
- signing, validation, packaging, and release gates;
- self-observability for the monitoring pipeline; and
- documentation and optional dashboard patterns.

These are design and engineering practices, not shared Management Pack runtime elements.

### Keep platform-specific

- entity and class inventory;
- discovery APIs and topology rules;
- signal sources, thresholds, and support evidence;
- product prerequisites and supported-version matrix;
- Azure resource and identity dependencies;
- artifacts, namespaces, sealed libraries, monitoring packs, override packs, Distributed
  Applications, signing identities, versions, and support lifecycles; and
- release cadence where platform dependencies differ.

Accepted [ADR 0022](docs/design/decisions/0022-scom-management-pack-packaging-boundaries.md)
prohibits cross-product runtime dependencies. Similar implementation source may exist in both
products when that is safer than coupling their public contracts.

## Architecture decision plan

| ADR | Status | Purpose | Gate |
|---|---|---|---|
| [0021](docs/design/decisions/0021-platform-and-delivery-track-architecture.md) | Accepted | Establish platform-first planning with separate delivery surfaces | Repository-owner decision |
| [0022](docs/design/decisions/0022-scom-management-pack-packaging-boundaries.md) | Accepted | Require independent Azure Local and Hyper-V SCOM runtime products | Packaging validation |
| [0023](docs/design/decisions/0023-hyper-v-azure-monitor-through-arc-enabled-scvmm.md) | Accepted — constrained go | Require SCVMM inventory plus Arc-enabled host telemetry and explicit parity gaps | Live inventory and telemetry validation |
| Hyper-V scope and topology | Planned after spike | Lock supported topology, entity inventory, exclusions, and version matrix | Support and topology research |
| Hyper-V SCOM discovery strategy | Planned after spike | Select supported discovery providers and hosting relationships | Workflow research |
| Hyper-V signal and rollup policy | Planned after spike | Lock signal catalog, thresholds, defaults, and exceptions | Signal, threshold, and lab research |
| [0026](docs/design/decisions/0026-platform-owned-scom-distributed-applications.md) | Accepted | Require a separate platform-owned DA in each SCOM product | Repository-owner decision; refined through platform authoring/research |
| [0027](docs/design/decisions/0027-hyper-v-scom-management-pack-decomposition.md) | Accepted | Define modular sealed Hyper-V MPs, separate customer Discovery/Monitoring overrides, and optional tuning templates | Implemented; packaging certification pending |
| [0028](docs/design/decisions/0028-hyper-v-object-and-discovery-architecture.md) | Accepted | Define stable identities, relationships, staged discovery, execution, and cookdown | Implemented; lab lifecycle validation pending |
| [0029](docs/design/decisions/0029-hyper-v-health-alert-and-da-rollup.md) | Accepted | Define evidence-driven health, alerting, monitoring freshness, and DA rollup | Implemented; threshold and DA lab validation pending |
| [0032](docs/design/decisions/0032-azure-local-scom-local-runtime-boundary.md) | Accepted | Keep the core Azure Local SCOM product useful without Azure connectivity | Implemented; outage validation pending |
| [0033](docs/design/decisions/0033-azure-local-scom-management-pack-decomposition.md) | Accepted | Define five Azure Local product artifacts and separate customer override MPs | Implemented; SDK and sealing gates pending |
| [0034](docs/design/decisions/0034-azure-local-object-discovery-and-da-architecture.md) | Accepted | Define Azure Local objects, staged discovery, relationships, and six-branch DA | Implemented; lab reconciliation pending |
| [0035](docs/design/decisions/0035-azure-local-health-alert-and-rollup-architecture.md) | Accepted | Define local health, curated alerts, performance/events, and domain rollup | Implemented; threshold and fault validation pending |
| [0036](docs/design/decisions/0036-azure-local-azure-monitor-health-model-v1.md) | Accepted | Define the current Azure Local preview Health Model baseline | Implemented; live validation pending |
| [0037](docs/design/decisions/0037-hyper-v-azure-monitor-health-model-architecture.md) | Accepted | Define the constrained SCVMM inventory plus Arc-enabled host Health Model | Implemented; live validation and parity review pending |

Accepted ADRs 0001–0020 continue to govern the Azure Local baseline unless a successor ADR explicitly
supersedes one. They must not be silently generalized to Hyper-V.

## Research plan

All spikes follow the evidence contract in
[`docs/design/research-spikes.md`](docs/design/research-spikes.md).

### Spike A — Independent SCOM packaging contract

Deliver:

- independent class, relationship, namespace, artifact, signing, and version ownership;
- dependency graphs proving no cross-product runtime reference;
- side-by-side import, upgrade, coexistence, and removal analysis;
- allowed non-runtime research and tooling reuse; and
- evidence that each platform owns its Distributed Application and complete support contract.

### Spike B — Hyper-V SCOM monitoring catalog

Deliver:

- Windows Server, Hyper-V, Failover Clustering, SCOM, and optional SCVMM support matrix;
- topology for standalone hosts, clusters, virtual switches, storage, replica, and VMs;
- supported PowerShell, CIM/WMI, event, service, and performance sources;
- layered physical, Network ATC, VMM, and SDN authority, including supported coexistence;
- useful signal and monitor concepts from the Microsoft Hyper-V 2019 MP, treated as research only
  with no package, class, or runtime dependency;
- lab fixtures and negative cases;
- stable standalone-host and cluster DA keys, component membership, and rollup inputs; and
- proposed scope, discovery, signal/rollup, and DA-refinement ADRs.

This is the active umbrella research workstream. Its bounded tasks cover source inventories,
workflow and threshold engineering, lab validation, catalog synthesis, and architecture review. The work
first inventories everything observable, then maps acquisition and threshold behavior, validates it
in the lab, and finally classifies each candidate as Must monitor, Should monitor, Could monitor,
collect only, diagnostic, or excluded. The detailed contract is published in
[`docs/hyper-v/monitoring-research.md`](docs/hyper-v/monitoring-research.md).

### Spike C — Azure Local Health Models revalidation

Deliver:

- current API versions and regional or preview limits;
- current Service Group, identity, RBAC, DCR, LAW/AMW, and Resource Graph contract;
- signal availability delta against the Azure Local catalog; and
- successor ADRs for any material change.

### Spike D — Arc-enabled SCVMM inventory and guest management

Deliver:

- ARM resource map for SCVMM clouds, clusters, hosts, networks, and VMs;
- distinction between inventory projection and Arc-enabled Servers guest management;
- Arc Resource Bridge, agent, identity, RBAC, network, and version prerequisites; and
- repeatable lab onboarding and inventory evidence.

### Spike E — Hyper-V telemetry and Health Models feasibility

Deliver:

- minimum viable Hyper-V entity graph;
- supported metric, log, Resource Graph, and Resource Health signals;
- AMA, DCR, LAW/AMW, Service Group, identity, and health-objective proof;
- fault-injection results;
- latency, cost, scale, lifecycle, and preview-risk assessment; and
- recommendation for ADR 0023.

## Delivery plan

### Azure Local SCOM Management Pack

1. Apply the independent product boundary in ADR 0022. **Complete.**
2. Author the Azure Local library, relationships, discoveries, DA classes, and dynamic membership.
   **Functional development baseline complete.**
3. Author monitors, rules, DA rollups, operator views, reporting surface, operational knowledge,
   diagnostics, and override tiers. **Functional development baseline complete.**
4. Run offline contract and Pester tests, then verify against the Microsoft SDK after the official
   sealed dependency MPs are supplied. **Contract tests complete; remaining gates pending.**
5. Validate with a pre-production SCOM management group, including DA
   population, state propagation, coexistence, upgrade, and removal.
6. Seal, sign, version, package, document, and release independently.

### Azure Local Azure Monitor

1. Revalidate current APIs, limits, prerequisites, and signals. **Initial desk research complete.**
2. Author entities, relationships, health objectives, documented metrics, and research KQL.
   **Preview development baseline complete.**
3. Implement Bicep modules, parameter tiers, state alerts, identity, and workbook.
   **Preview development baseline complete and compiling.**
4. Validate live metric definitions, Log Analytics schemas, Service Group discovery, lint, what-if,
   deployment, identity/RBAC, fault propagation, scale, cost, and teardown.
5. Version, document, and release with preview limitations stated explicitly.

### Hyper-V SCOM Management Pack

The `0.1` lab preview proved source generation, Microsoft verification, and test sealing. It did
not deliver the complete private-cloud topology or monitoring depth required for public release.
It is superseded as the product design baseline by the v2 program in
[Hyper-V Private Cloud Monitoring v2](#hyper-v-private-cloud-monitoring-v2).

The console-facing product name for v2 is **Hyper-V Private Cloud Monitoring**. The console root is
**Hyper-V Private Cloud**. `Hybrid Solutions Cloud` remains publisher metadata and may remain in
internal element namespaces, but it is not the primary operator-facing product name.

No v2 release may be described as complete until its supported compute, availability, storage,
network, management, and optional orchestration domains pass the release gates below.

### Hyper-V Azure Monitor through Arc-enabled SCVMM

ADR 0023 records a constrained go and the first Bicep-compiling development baseline is complete.
Arc-enabled SCVMM supplies management-plane inventory; Arc-enabled Server, AMA, and the solution DCR
supply participating host telemetry. The next work is live inventory/schema, DCR association,
identity, fault/recovery, scale, cost, and teardown validation. The solution must not promise SCOM
parity where supported Azure telemetry does not exist.

### SCOM to ServiceNow integration

1. Research the ServiceNow SCOM Events/Metrics connector split, MID Server prerequisites, supported
   SCOM versions, lifecycle behavior, security, and SCOM product-connector filtering. **Complete.**
2. Accept the connector-neutral MP boundary and initial unidirectional lifecycle policy in ADR
   0038. **Complete.**
3. Define separate Azure Local and Hyper-V allow-list profiles plus a common event, identity,
   severity, CI, correlation, and lifecycle contract. **Development baseline complete.**
4. Validate both authored MPs for auto-resolving monitor alerts, localized event alerts, and
   suppression keys. **Offline contract complete.**
5. In a ServiceNow/SCOM lab, validate installed-release licensing/version support, MID Server and
   assemblies, least privilege, connector filters, CMDB binding, deduplication, maintenance,
   outage/replay, close/reopen/ticket behavior, upgrade, rollback, and removal.
6. Keep the separate SCOM Metrics connector disabled unless Metric Intelligence licensing, Data
   Warehouse access, value, cost, and scale are explicitly approved.

## Hyper-V Private Cloud Monitoring v2

### Product outcome

Deliver a modular SCOM suite that models and monitors a real Windows Server Hyper-V private cloud,
not only the state of individual hosts. The product must provide connected topology, health,
capacity, performance, alerts, operational knowledge, diagnostics, reports, and a navigable
Distributed Application across every supported and enabled capability.

The design must support these deployment modes independently and in combination:

- standalone Hyper-V;
- Hyper-V failover clusters;
- SAN-backed clusters, beginning with Pure Storage FlashArray;
- Storage Spaces Direct clusters;
- environments using SAN and S2D at the same time;
- Hyper-V over SMB and Scale-Out File Server where supported;
- Network ATC and manually or externally managed host networking;
- Windows Server Software Defined Networking; and
- optional System Center Virtual Machine Manager-managed fabrics.

Capability packs are additive. Detecting S2D must not disable SAN monitoring, and detecting VMM or
SDN must not remove the underlying host, cluster, storage, or network health model.

### Current-preview disposition

The version `0.1` preview contains a useful but incomplete host-centric baseline: 13 classes, 20
relationships, two discoveries, nine generated host-level health monitors, ten dependency
rollups, twelve performance rules, four cluster-event rules, ten basic views, and five broad DA
component groups. Its single topology discovery and consolidated host probe do not constitute a
complete private-cloud product.

Before v2 authoring begins, diagnose the currently installed preview:

1. Export all installed product and override MPs.
2. Record their versions, public key tokens, references, and effective overrides.
3. Confirm whether the service and component instances were discovered.
4. Collect relevant Operations Manager event-log failures from monitored hosts and management
   servers.
5. Confirm that Library, Discovery, Monitoring, and Presentation were imported in order.
6. Record every missing object, health state, view, relationship, and DA branch.
7. Publish a preview-disposition note that states what is retained, replaced, or deprecated.

Treat `0.1` as a superseded preview rather than attempting a destructive in-place model rewrite.
The v2 compatibility design must preserve historical data where practical, provide preflight and
migration guidance, and define side-by-side and uninstall restrictions explicitly.

### Authoritative ownership and dependency policy

The authoritative v2 decision is recorded in
[ADR 0040](docs/design/decisions/0040-hyper-v-v2-microsoft-s2d-and-sdn-ownership.md), which
supersedes [ADR 0039](docs/design/decisions/0039-hyper-v-v2-external-object-ownership.md), and the
[dependency and ownership contract](docs/design/hyper-v/v2-dependency-and-ownership-contract.md).
Package inspection proved that Microsoft publishes supported Cluster, CSV, S2D, and SDN MPs. The
plan is to consume authoritative Microsoft Cluster `10.1.0.0`, Windows Server/CSV `10.1.2.2`, S2D
`1.0.47.4`, and SDN `10.0.0.2` objects through optional adapters instead of creating competing
copies. The base standalone product retains only built-in SCOM dependencies.

Reuse stable public objects from sealed Microsoft and vendor MPs when they represent the same
managed resource. Do not create disconnected duplicate Windows computer, cluster, storage-array,
network-device, or VMM-fabric identities.

| Domain | Authoritative model | v2 responsibility |
|---|---|---|
| Windows Server | Microsoft Windows Server MPs | Relate host foundation health; add only virtualization-specific context |
| Physical server hardware | Supported hardware-vendor MPs | Relate chassis and component health to hosts and the DA |
| Failover Clustering | Microsoft Failover Cluster MPs | Reuse or specialize cluster objects and add Hyper-V-specific relationships and health |
| Hyper-V | Hyper-V Private Cloud v2 | Own virtualization-specific discovery, monitoring, knowledge, and presentation |
| VMM fabric | Microsoft VMM MPs | Integrate clouds, host groups, networks, storage, compliance, and jobs without duplication |
| Physical network | SCOM network monitoring and vendor MPs | Correlate host adapters to switches, ports, VLANs, and network health |
| Pure Storage | Pure Storage FlashArray MP `2.0.120.0` on its supported SCOM 2016/2019/2022 lane | Reuse vendor arrays, controllers, hosts, host groups, ports, volumes, and pods; add read-only SAN-to-VM mapping and DA service impact only |
| S2D | Microsoft Storage and Storage Spaces Direct MPs | Reuse Microsoft subsystem, pool, node, disk, virtual-disk, volume, and share objects; add only verified gaps, correlations, and private-cloud service impact |
| SDN | Microsoft Windows Server SDN MP | Reuse Microsoft stamp, controller, host, virtual-network, ACL, NIC, MUX, gateway, connection, and BGP objects; add correlations, coverage, and private-cloud service impact |

For every external dependency, record the exact MP ID, minimum compatible version, public
elements used, import order, supported SCOM/Windows matrix, licensing or redistribution boundary,
upgrade behavior, and removal impact. Reference the lowest version that supplies the required
stable public contract.

### Package architecture

The target suite is modular so customers install only applicable capability packs while retaining
one connected health model. [ADR 0043](docs/design/decisions/0043-hyper-v-v2-package-and-deployment-profile-architecture.md)
fixes the implementation boundary at four required core MPs plus one sealed MP per optional
capability; generated overrides and release manifests are scoped to the selected capability set.

| Sealed artifact | Requirement | Responsibility |
|---|---|---|
| `Library` | Required | Stable core classes, relationships, DA branch contracts, Run As profiles, and localization |
| `Discovery` | Required | Standalone-safe Hyper-V seeds and core topology discovery |
| `Monitoring` | Required | Core Windows/Hyper-V/VM/replica health, performance, events, tasks, and knowledge |
| `Presentation` | Required | Console root, core views, complete DA shell, diagrams, and operator tasks |
| `Capability.Cluster` | Optional; required for clusters | Microsoft Cluster/CSV relationships, cluster service impact, capability monitoring, and views |
| `Capability.Storage` | Optional | Common SAN, MPIO, iSCSI/FC, path/LUN/VHDX correlation, health, and views |
| `Capability.PureStorage` | Optional | Pure MP object reuse, FlashArray-to-host/volume/VM correlations, service impact, and views |
| `Capability.S2D` | Optional | Microsoft S2D object reuse, gap monitoring, service impact, and views |
| `Capability.FileServices` | Optional | Microsoft File/iSCSI object reuse plus SOFS share, SMB path, and VM/VHDX correlations |
| `Capability.NetworkATC` | Optional | Intents, participating adapters, status, drift, override inventory, symmetry, and read-only health |
| `Capability.PhysicalNetwork` | Optional | Built-in SCOM network-object reuse and host-adapter-to-switch-port/VLAN service impact |
| `Capability.SDN` | Optional | Microsoft SDN object reuse, verified gap monitoring, correlations, service impact, and views |
| `Capability.VMM` | Optional | Matching-version Microsoft VMM object reuse, fabric correlation, service impact, and views |
| `Reporting` | Optional | Availability, capacity, performance, configuration, and forecast reports |

Customer customization remains in separate unsealed Discovery and Monitoring override MPs. Never
write customer configuration to the Default Management Pack.

### Complete topology and monitoring catalog

#### Windows and physical foundation

- Windows computer, OS availability, SCOM agent, and HealthService health;
- system volume, page file, time, DNS/domain reachability, WinRM, WMI/CIM, PowerShell, and required
  feature/module availability where these are prerequisites for virtualization monitoring;
- relevant WHEA, system, driver, and hardware events;
- supported vendor hardware objects including chassis, processor, memory, power, cooling,
  controller, firmware, and network components; and
- explicit relationships from hardware and Windows health to the Hyper-V host and private-cloud DA.

Do not reproduce complete Windows, Active Directory, DNS, or hardware-vendor monitoring. Consume
and relate their authoritative health where the corresponding MPs are installed.

#### Hyper-V compute

- role and hypervisor launch state, VMMS, Host Compute Service where applicable, worker-process
  failures, operational event channels, configuration, and Best Practices Analyzer findings;
- logical, root, and guest virtual processor usage, NUMA, interrupts/DPC, oversubscription, and
  capacity headroom;
- available memory, Dynamic Memory demand/pressure, host reserve, paging, and capacity;
- VM storage and network I/O, migration configuration and failures, maintenance/drain state, and
  monitoring-pipeline health;
- Hyper-V Replica broker, relationship health, backlog, last success, authentication, and recovery
  readiness; and
- duration, recovery, hysteresis, suppression, and topology-aware threshold behavior.

#### Virtual machines

- stable VM identity across migration and owner changes;
- expected versus actual state, clustered-role state, current owner, configuration version,
  automatic start/stop policy, checkpoints, replica, migration, and backup/checkpoint failures;
- heartbeat, shutdown, time synchronization, KVP, VSS, guest service, and PowerShell Direct
  integration components as applicable;
- vCPU, assigned/demand memory, pressure, virtual disks, vNICs, and host/storage/network
  relationships; and
- correlation to guest OS and workload health without replacing their product MPs.

#### Failover Clustering

- cluster, service, nodes, membership, isolation/quarantine, pause/drain, groups, roles, resources,
  dependencies, ownership, and repeated failover behavior;
- quorum mode, witness, dynamic quorum/witness, functional level, validation currency, and
  Cluster-Aware Updating where deployed;
- cluster networks, roles, metrics, heartbeat, live-migration eligibility, and communication
  failures;
- CSV ownership, online/paused/redirected state, redirected-I/O reason, capacity, cache, latency,
  and relevant operational channels; and
- Microsoft Cluster MP relationships, Health Explorer integration, and duplicate-alert analysis.

#### Common storage and SAN

- provider, array/system, controller, pool, volume/LUN, host group, initiator, target, path,
  CSV/share, VHDX, and VM mappings;
- iSCSI and Fibre Channel configuration, sessions, portals, HBAs, MPIO/DSM, path count, path state,
  and consistent LUN visibility across cluster nodes;
- capacity, thin-provisioning exposure, latency, IOPS, throughput, queueing, errors, repair/rebuild,
  replication, and Storage QoS; and
- end-to-end service-impact mapping from array and path through CSV/VHDX to affected VMs.

#### Pure Storage FlashArray

Pure's current FlashArray SCOM MP `2.0.120.0` is the authoritative model on its stated SCOM
2016/2019/2022 and Purity 5.3+ support lane. Create an optional integration pack around it. Use
direct REST or PowerShell collection only for verified correlation gaps; do not claim SCOM 2025
Pure support until the vendor certifies it or a separate native provider passes its release gates.

Required topology and health include arrays, controllers, hardware, ports, hosts/host groups,
volumes, protection groups, replication, pods/ActiveCluster where licensed, capacity, latency,
IOPS, bandwidth, connectivity, protection status, API/certificate health, and mappings through
Windows disks and CSVs to VMs. Use a least-privilege Run As profile; never store credentials in MP
configuration or source.

#### Storage Spaces Direct

- storage subsystem, S2D cluster, pools, physical disks, tiers, cache, virtual disks, volumes,
  CSVs, enclosures/fault domains where exposed, jobs, and Health Service;
- pool/disk/virtual-disk/volume health and operational states, resiliency, capacity, abnormal
  latency, endurance where exposed, cache, repair, regeneration, and firmware/driver consistency;
- Health Service faults and autonomous actions;
- Cluster Performance History availability, collection health, capacity, latency, IOPS,
  throughput, and `ClusterPerformanceHistory` volume health; and
- mixed SAN/S2D operation with independent discovery, targeting, views, and rollup.

#### SMB and Scale-Out File Server

- SOFS role and cluster health, continuously available shares, SMB Multichannel, SMB Direct/RDMA,
  authentication, share availability, path redundancy, and Storage QoS;
- mappings from share to VM configuration/VHDX and affected VMs; and
- separate compute-cluster and file-server-cluster relationships where Hyper-V over SMB is used.

#### Host and physical networking

- physical adapters, SET/teams, Hyper-V switches, host/management vNICs, VM vNICs, VLAN/MTU,
  QoS, RSS/vRSS, VMQ/VMMQ, RDMA, SMB Direct, DCB/PFC where applicable, and switch extensions;
- management, cluster, live-migration, storage, replica, provider, and tenant network purpose;
- link state, speed, driver/firmware consistency, errors, discards, drops, saturation, symmetry,
  and configuration drift; and
- SCOM network-device relationships to physical switches, ports, interfaces, and VLANs.

#### Network ATC

- intent, scope, type, participating adapters, provisioning/configuration status, global and
  per-intent overrides, expected/actual state, remediation, and cluster consistency;
- failed/prolonged provisioning, adapter symmetry, missing or unsuitable adapters, drift, failed
  remediation, invalid overrides, and required RDMA/DCB capabilities; and
- explicit Not Applicable handling where manual, VMM, SDN, or another authority owns networking.

#### Software Defined Networking

- Network Controller cluster, replicas, services, REST endpoint, host agents, policy distribution,
  SLB Manager, MUXes, gateways, pools, HNV policies, virtual networks/subnets, VIP/DIP, ACLs, BGP,
  and certificates;
- controller quorum, control-plane availability, host connectivity, policy consistency, SLB and
  gateway availability/capacity, BGP peers, certificate expiry, performance counters, and
  control/data-plane mismatch; and
- separate optional discovery and Run As requirements with secure credential distribution.

#### Virtual Machine Manager integration

Reuse the Microsoft VMM MPs and correlate, rather than duplicate, VMM management servers/services,
clouds, host groups, hosts, VMs, libraries, logical networks, network sites, VM networks, IP pools,
logical switches, uplink profiles, port classifications, storage providers/classifications, pools,
LUNs, shares, compliance, failed jobs, maintenance integration, and PRO where enabled.

V2 must operate without VMM and must not infer VMM ownership merely because VMM classes exist.

### Distributed Application and health model

Create one private-cloud service instance per supported boundary: standalone deployment, Hyper-V
failover cluster, or explicitly selected VMM private cloud/host group. The DA must be dynamically
populated and must remain stable through host ownership and VM migration changes.

```text
Hyper-V Private Cloud
├── Management
├── Compute
├── Virtual Machines
├── Availability and Clustering
├── Storage
│   ├── CSV and common storage
│   ├── Storage Spaces Direct
│   ├── SAN and Pure Storage
│   └── SMB and Scale-Out File Server
├── Networking
│   ├── Physical and host networking
│   ├── Network ATC
│   └── VMM logical networking
└── Software Defined Networking
```

Provide dynamic membership, explicit relationships, diagram views, contextual tasks, Health
Explorer rollup, maintenance behavior, Unknown and Not Applicable semantics, leaf-level actionable
alerts, and dependency-aware symptom suppression. Aggregate and dependency monitors should not
generate duplicate alerts when a leaf monitor already identifies the cause.

### Console and operator experience

Replace the current generic view set with these console areas:

- Overview: private-cloud health, DAs, critical alerts, and monitoring coverage;
- Compute: hosts, hypervisor services, hardware, performance, and capacity;
- Virtual Machines: state, integration services, checkpoints, replica, and performance;
- Clustering: clusters, nodes, quorum/witness, roles/resources, networks, CSVs, and events;
- Storage: common overview, S2D, SAN, Pure Storage, MPIO, SMB/SOFS, capacity, and performance;
- Networking: adapters, physical switches, SET/teams, vSwitches, Network ATC, VMM logical
  networks, and performance;
- SDN: Network Controller, SLB/MUX, gateways, virtual networks, and alerts;
- VMM: management health, clouds, host groups, fabric compliance, and failed jobs; and
- Operations: alerts, events, performance, discovery/workflow health, diagnostics, and
  configuration.

Each health-bearing class requires an appropriate state view. Each collected performance family
requires a useful scoped performance view or report. Provide an actual DA diagram experience, not
only a state view targeted at the service class.

### Research and architecture work packages

Complete these evidence-backed spikes before locking v2 authoring. Cluster/CSV, S2D, and SDN
package inventories and optional adapter implementations are complete at the public-contract and
offline-verification level; representative lab behavior remains open.

1. **Installed-preview diagnosis** — explain missing discoveries, views, and DA instances.
2. **Support matrix** — Windows Server, SCOM, Cluster MP, VMM, S2D, Network ATC, SDN, Pure
   Purity/FlashArray, protocols, and topology combinations.
3. **Microsoft MP inventory** — public Cluster, Windows, VMM, network, storage, and Service Designer
   classes, relationships, discoveries, modules, and version contracts.
4. **Hyper-V capability catalog** — every observable object and signal classified as must, should,
   could, collection-only, diagnostic, or excluded.
5. **S2D spike** — inventory completed for Microsoft S2D MP `1.0.47.4`; finish Health Service
   fault/action, job, performance-history, coexistence, failure-injection, and scale gap analysis.
6. **SAN/Pure spike** — vendor MP `2.0.120.0` public-contract and SCOM 2016/2019/2022 support
   inventory completed; finish SAN mappings, MPIO, REST gap, SCOM 2025, ActiveCluster, and
   representative-array validation.
7. **Networking spike** — physical/virtual networking, SET, RDMA/DCB, Network ATC, physical switch
   public-contract inventory completed; finish virtual networking, SET, RDMA/DCB, Network ATC,
   authority selection, correlation failure, and fault injection.
8. **SDN spike** — Microsoft SDN MP `10.0.0.2` inventory and adapter authoring complete. Microsoft
   remains REST/credential/topology/leaf-alert authority; HCS adds local binding evidence, verified
   missing rollups, private-cloud service impact, and views. Certificate, controller/gateway fault,
   scale, Network ATC/VMM coexistence, lifecycle, and removal labs remain.
9. **VMM spike** — System Center 2025 official MP model, build-coupled integration, clouds, fabric
   networks/storage, logical-network/network-site gaps, scoped Run As, and failed-job cmdlets are
   inspected; `Capability.VMM` is authored against Library/Discovery/Monitoring `11.19.0.3` and
   PRO v2 Library `10.25.1200.0`. VMM 2025 representative topology, failure, coexistence,
   upgrade, and removal labs remain. Older/newer VMM lanes require separate contract inspection.
10. **DA and presentation spike** — stable boundaries, membership, rollup, diagram/dashboard
    behavior, maintenance, migration, and operator usability.

Every catalog entry must record source, acquisition method, target, interval, timeout, cardinality,
permissions, health role, threshold/duration/recovery, alert/suppression behavior, supported
versions, cost, and required fixture.

### Implementation sequence

1. Diagnose and formally supersede the `0.1` preview. **Preview is formally superseded; installed
   management-group diagnosis awaits the operator export and event evidence listed above.**
2. Approve the v2 product contract, naming, support matrix, and dependency policy. **Complete.**
3. Complete raw capability inventories and the ten research spikes. **Authoritative package and
   ownership contracts are complete; representative fault/scale labs remain release gates.**
4. Approve successor ADRs for topology, Microsoft/vendor dependencies, packaging, identity,
   storage modes, networking authority, DA, health/alert policy, and migration. **Core dependency,
   ownership, and packaging decisions complete; implementation-specific successors remain additive.**
5. Author the Core Library and verified external-object relationships. **Core Library source passes
   OM2022 VSAE/SDK verification and transient test sealing; optional capability relationships
   remain.**
6. Implement lightweight capability seeds and staged discovery with independent pipeline health.
   **Core VMMS seed and staged topology are authored, SDK-verified, and test-sealed; capability
   discoveries remain.**
7. Implement Compute and VM monitoring. **Core baseline authored: 13 host and nine agent-hosted
   per-VM runtime monitors, 12 performance rules, a diagnostic task, operational knowledge, and 14
   DA rollups pass OM2022 VSAE/SDK verification and transient test sealing. Curated event rules,
   deeper performance families, and representative fault/scale validation remain.**
8. Implement Failover Cluster integration and CSV monitoring. **Capability.Cluster is authored,
   resolves against the inspected Microsoft Cluster `10.1.0.0` and CSV `10.1.2.2` contracts,
   rolls authoritative leaf health into the Availability and Storage branches, and passes OM2022
   verification plus transient sealing; representative cluster lifecycle/fault labs remain.**
9. Implement Storage Core, then S2D, SAN, Pure, and SMB/SOFS packs. **Storage Core is authored with
   five Windows SAN projection classes, 13 topology relationships, five health monitors, three DA
   rollups, and six console views. It passes 36 focused offline tests, OM2022 VSAE verification,
   transient sealing, and strong-name verification. The S2D adapter is also authored without
   duplicate resource classes: seven Microsoft object families receive DA relationships/rollups,
   one HCS pipeline monitor, and 11 views. It passes 42 focused tests, VSAE verification against a
   transiently remapped copy of the inspected `1.0.47.4` bundle, transient sealing, and strong-name
   verification. The Pure Storage adapter is also authored against the vendor's exact
   `PureStorageFlashArray` `2.0.120.0` identity without duplicating vendor classes or alerts. It
   adds exact IQN/WWPN and volume-serial correlations, four relationships and rollups, one
   integration monitor, and 11 views; 48 focused tests, OM2022 VSAE verification, transient
   sealing, and strong-name verification pass. Representative FlashArray validation, combined
   SAN/Pure/S2D lifecycle and fault labs remain. The SMB/SOFS adapter is authored with three stable
   Hyper-V-specific projections (share, Multichannel/RDMA path, and VHDX mapping), seven topology
   relationships, Microsoft SMB leaf-health reuse, one client dependency monitor, and seven views.
   It passes focused offline and OM2022 VSAE verification plus transient sealing; representative
   standalone SMB and clustered SOFS lifecycle/fault labs remain.**
10. Implement Networking, Network ATC, SDN, and VMM integration packs. **Capability.PhysicalNetwork
    is authored against the verified public SCOM 2016/2019/2022 network contract. It defines no
    duplicate device classes or SNMP workflows; external Hyper-V switches and the Network DA branch
    attach to exact Windows computer-adapter identities used by SCOM's MAC-based topology merge.
    One correlation-input monitor, two dependency rollups, and eight Microsoft-object views pass
    focused offline tests. Representative switch/port topology and fault validation remain. The
    Network ATC capability is also authored with stable intent, per-node, and global-setting
    projections; six relationships to the Network branch, hosts, and exact Windows adapters; four
    read-only unit monitors; four dependency rollups; and seven views. It passes focused offline
    tests, OM2022 VSAE verification, transient sealing, and strong-name verification. Network ATC
    never changes or retries an intent and treats an absent capability as Not Applicable unless
    explicitly required. Representative convergence, drift, symmetry/RDMA, authority, lifecycle,
    and removal labs remain. Capability.SDN is also authored against the exact Microsoft
    `10.0.0.2` contract. It adds one local binding class, ten relationships, one integration
    monitor, 11 dependency rollups, and 16 views without using the Microsoft Run As credential,
    calling Network Controller REST, fabricating Host identity, or duplicating leaf alerts. OM2022
    VSAE verification, transient sealing, strong-name verification, and focused offline tests pass;
    Microsoft prerequisite setup, topology, controller/certificate/gateway faults, ATC/VMM
    coexistence, lifecycle, and removal labs remain. `Capability.VMM` is also authored against the
    exact System Center 2025 VMM MP identities, with VMM-fabric DA membership, exact server/host/
    cloud relationships, logical-network and network-site gap projections, read-only failed-job
    monitoring, selected non-duplicate rollups, and 20 views. The complete 93-test Hyper-V suite,
    OM2022 VSAE verification, transient sealing, strong-name verification, PowerShell analysis, and
    documentation build pass; representative VMM labs remain.**
11. Implement the complete DA, console hierarchy, diagrams, tasks, knowledge, dashboards, and
    reports. **Core Presentation is authored and OM2022-verified with the operator-facing root,
    eight folders, 17 localized views, and a native DA diagram; capability-specific views,
    dashboards, and reports remain.**
12. Implement composable deployment profiles and corrected override generation. **Complete for
    source and offline verification: schema 2.0 explicitly declares every target; 11 capability
    profiles and three tiers generate 66 Discovery/Monitoring examples; Standard includes a
    same-MP group pattern; CI resolves workflows, contexts, modules, properties, parameters, and
    aliases against all 13 built MPs; version separation, drift, cookdown, unknown schema/
    capability, cross-MP group rejection, UTF-8, and Default MP gates pass. A generated Standard
    pair also passes OM2022 VSAE. Import/export/upgrade/removal lab evidence and governed
    release-identity rendering remain under steps 13–14.**
13. Run automated verification, representative topology labs, fault injection, performance/scale,
    upgrade/migration, security, and removal tests.
14. Seal with the governed identity, package, publish checksums and guides, and release only after
    every claimed domain passes its gate.

### Override and profile redesign

Profiles compose capabilities instead of imposing one universal threshold set. Provide reviewed
starting points for standalone, clustered SAN, clustered S2D, hybrid SAN/S2D, VMM-managed,
Network ATC, and SDN-enabled environments, plus Lab, Standard, and Strict tuning levels.

Correct the generator before v2 publication:

- separate customer override MP version from sealed product reference version;
- generate committed examples and fail CI on drift;
- resolve every class, workflow, module, reference, and override parameter against built MPs;
- use explicit workflow/context schema rather than constructed IDs;
- support class and same-MP group targeting; and
- reject unknown schemas, cross-unsealed-MP group references, and invalid capabilities.

### V2 validation and definition of done

Automated gates include deterministic build, schema validation, VSAE/SDK verification, dependency
resolution, test sealing, reference and override resolution, example drift, cookdown, discovery
fixtures, cardinality/performance budgets, documentation consistency, upgrade compatibility, and
secret scanning.

**Release-blocking PowerShell host gate:** ADR 0047 replaces the implicit in-process Windows
PowerShell providers with public `System.Library` command-executor wrappers that launch
`%ProgramFiles%\PowerShell\7\pwsh.exe` explicitly. The contract validates against inspected SCOM
2016 and 2022 libraries, and static tests reject legacy PowerShell module types. Before any v2
build is called usable, run the diagnostic task through HealthService in every claimed lane and
retain its process path, Core edition, version, `PSHOME`, automation assembly, and bitness. Then
prove every capability-specific module and failure/recovery path inside that process. VSAE and
offline execution do not satisfy this runtime gate.

Representative labs must cover standalone Hyper-V; clustered SAN; Pure Storage; S2D; combined SAN
and S2D; Hyper-V over SMB where supported; Network ATC; VMM; SDN; and configurations where optional
capabilities are absent. Exercise maintenance, migration, failover, quorum/witness loss, node
isolation, CSV redirection, storage path loss, disk failure and repair, array/controller or API
failure, switch/NIC failure, Network ATC drift, VMM outage, SDN control-plane failure, missing
modules, credential failure, recovery, upgrade, migration from preview, and dependency-safe
removal.

V2 is complete only when:

- every promised domain has an explicit implemented, integrated, deferred, or unsupported
  disposition;
- all supported topology combinations discover and reconcile correctly;
- every embedded script executes under its declared PowerShell 7 requirement on every supported
  SCOM/Windows Server pair;
- SAN and S2D operate simultaneously;
- the DA is visible, navigable, stable, and rolls up verified service impact;
- required missing capabilities are actionable failures while optional absent capabilities are Not
  Applicable;
- duplicate Microsoft/vendor monitoring has been removed or deliberately tuned;
- Pure integration passes against a representative FlashArray;
- S2D faults, jobs, repairs, and performance history pass representative tests;
- VMM-managed and non-VMM deployments both work;
- public guides accurately list objects, monitors, rules, views, reports, dependencies, defaults,
  disabled workflows, permissions, and limitations; and
- governed signing, clean import, checksums, migration, upgrade, rollback, and removal evidence is
  approved.

## Planned repository shape

The source layout preserves the independent runtime boundary:

```text
docs/
├── design/                 # Shared principles, research, and ADRs
├── azure-local/            # Azure Local platform entry point
├── hyper-v/                # Hyper-V platform entry point
├── scom-mp/                # Existing Azure Local SCOM implementation docs
└── azure-monitor/          # Existing Azure Local Azure Monitor implementation docs

src/
├── azure-local/
│   ├── scom-mp/
│   └── azure-monitor/
├── hyper-v/
    ├── scom-mp/
    └── azure-monitor/      # Constrained SCVMM + Arc-enabled host development solution
└── integrations/
    └── servicenow/scom/    # Optional secret-free connector profiles, mappings, and validation

tools/                      # Non-runtime build and validation automation only
```

Research remains in documentation and evidence artifacts. No shared Management Pack runtime source
tree or sealed library is planned. Accepted ADR 0030 is the current source-path authority.

## Validation gates

### Documentation

- `npm ci`
- `npm run docs:build`
- all navigation targets and internal links resolve;
- Mermaid diagrams render without syntax errors;
- published GitHub Pages workflow succeeds; and
- representative Azure Local, Hyper-V, ADR, and roadmap pages return HTTP 200.

### SCOM

- schema and Management Pack verification;
- best-practice analysis with reviewed warnings;
- Pester discovery and workflow fixtures;
- clean import, discovery, health-state transition, upgrade, and removal tests;
- deterministic DA population, relationship, rollup, view, report, and SLO tests;
- side-by-side installation with no cross-product classes, references, or dependencies;
- no unexpected Health Service Modules events; and
- signed artifacts and reproducible package contents.

### Azure Monitor

- Bicep lint, build, and what-if;
- clean lab deployment and teardown;
- least-privilege identity and RBAC verification;
- signal freshness and Unknown-state behavior;
- fault-injection and propagation tests;
- documented API, region, preview, cost, and scale constraints; and
- no credentials or tenant identifiers in source or artifacts.

## Sequencing and capacity

The functional development baselines are authored sequentially. Release capacity now focuses on
dependency, SDK, lab, identity, telemetry, fault, cost, and lifecycle evidence for each independent
solution.

## Out of scope

- application and guest-workload monitoring;
- production deployment into customer environments;
- unsupported or undocumented telemetry collection;
- a guarantee of Azure Monitor parity for Hyper-V;
- renaming the GitHub repository or Azure DevOps project before dependency and release impacts are
  understood; and
- claiming Hyper-V Azure Monitor parity before the remaining supported telemetry gaps are closed.
