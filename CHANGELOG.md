# Changelog

## [1.3.2.0] — 2026-09-04

Corrective release resolving every runtime defect found in the SCOM operational audit of 1.2.0.0, plus
the applicability and cookdown work that audit exposed. All 13 sealed product MPs carry version
`1.3.2.0`, signed with public key token `54d0fb1159995c86`.

**Runtime defects fixed**

- File Services no longer raises `The property 'Count' cannot be found on this object` (Event 8702).
  Ten StrictMode null-collapse sites were fixed across File Services, Network ATC, Physical Network
  and VMM, and the cascade that marked ten unevaluated SMB facets `Warning` on a single probe failure
  was removed.
- Ten Windows event rules no longer carry the invalid `$Data/Params/Param[1]$` suppression (Event 5402).
- Network ATC no longer throws on hosts without ATC (Event 8903): `RequireNetworkATC` defaulted to
  `true` in fifteen unit monitors and is now `false`.
- Failover Cluster and VMM workflows run on the Windows PowerShell host, because `FailoverClusters` and
  `VirtualMachineManager` ship only as Windows PowerShell modules. The `-SkipEditionCheck` and
  `-UseWindowsPowerShell` workarounds are removed; both are PowerShell 7 parameters that raise
  `ParameterBindingException` under 5.1 (Event 8301).
- SDN no longer reports a host as SDN-enabled because an in-box `NcHostAgent` service exists. Detection
  now requires a populated Network Controller `HostId` **and** a host agent that is not absent,
  disabled or unreadable, in both the discovery and the health workflow.
- VMM events 8510/8511/8512/8904/8905 log the full exception chain instead of `Exception.Message`.
- Nine probes no longer return `Good` from a `catch` block or claim health they never measured.

**Applicability**

Every capability monitor now targets the object it describes rather than the Hyper-V host. File
Services and Storage gained participation classes discovered only where UNC-backed virtual disks or
SAN-attached storage actually exist; Cluster, Network ATC and SDN monitors moved onto their existing
discovery-gated classes. Capabilities that are not deployed no longer instantiate at all.

**360° model**

The physical chassis, DHCP, top-of-rack switch, edge firewall and console-server monitors target their
own infrastructure classes instead of the Hyper-V host, so those objects carry their own health.
Edge firewall, console server and out-of-band switch have no discovery yet and are documented as
pending; their classes remain because a sealed management pack upgrade cannot remove class types.

**Performance**

The eleven VMM fabric monitors share one data source configuration and one VMM connection instead of
eleven, so a single initialization failure no longer produces eleven failing workflows.

## [1.3.2.0] — 2026-09-04

Corrective release resolving every runtime defect found in the SCOM operational audit of 1.2.0.0, plus
the applicability and cookdown work that audit exposed. All 13 sealed product MPs carry version
`1.3.2.0`, signed with public key token `54d0fb1159995c86`.

**Runtime defects fixed**

- File Services no longer raises `The property 'Count' cannot be found on this object` (Event 8702).
  Ten StrictMode null-collapse sites were fixed across File Services, Network ATC, Physical Network
  and VMM, and the cascade that marked ten unevaluated SMB facets `Warning` on a single probe failure
  was removed.
- Ten Windows event rules no longer carry the invalid `$Data/Params/Param[1]$` suppression (Event 5402).
- Network ATC no longer throws on hosts without ATC (Event 8903): `RequireNetworkATC` defaulted to
  `true` in fifteen unit monitors and is now `false`.
- Failover Cluster and VMM workflows run on the Windows PowerShell host, because `FailoverClusters` and
  `VirtualMachineManager` ship only as Windows PowerShell modules. The `-SkipEditionCheck` and
  `-UseWindowsPowerShell` workarounds are removed; both are PowerShell 7 parameters that raise
  `ParameterBindingException` under 5.1 (Event 8301).
- SDN no longer reports a host as SDN-enabled because an in-box `NcHostAgent` service exists. Detection
  now requires a populated Network Controller `HostId` **and** a host agent that is not absent,
  disabled or unreadable, in both the discovery and the health workflow.
- VMM events 8510/8511/8512/8904/8905 log the full exception chain instead of `Exception.Message`.
- Nine probes no longer return `Good` from a `catch` block or claim health they never measured.

**Applicability**

Every capability monitor now targets the object it describes rather than the Hyper-V host. File
Services and Storage gained participation classes discovered only where UNC-backed virtual disks or
SAN-attached storage actually exist; Cluster, Network ATC and SDN monitors moved onto their existing
discovery-gated classes. Capabilities that are not deployed no longer instantiate at all.

**360° model**

The physical chassis, DHCP, top-of-rack switch, edge firewall and console-server monitors target their
own infrastructure classes instead of the Hyper-V host, so those objects carry their own health.
Edge firewall, console server and out-of-band switch have no discovery yet and are documented as
pending; their classes remain because a sealed management pack upgrade cannot remove class types.

**Performance**

The eleven VMM fabric monitors share one data source configuration and one VMM connection instead of
eleven, so a single initialization failure no longer produces eleven failing workflows.

## [1.0.5.0] — 2026-09-03

Version-increased corrective upgrade from `1.0.4.0`. All 13 sealed product MPs now carry version
`1.0.5.0`, ensuring SCOM recognizes the display-name corrections and removal of the empty lowercase
`Failover clusters` view as an upgrade. The working `Failover Clusters` view targeting Microsoft's
authoritative cluster class remains. No customer-owned overrides, capability scope, proxy setting,
or discovery interval is changed.

## [1.0.4.0] — 2026-09-03

Console-quality corrective upgrade from `1.0.3.0`. All capability MPs now have friendly pack-level
display names instead of exposing dotted internal IDs in SCOM Administration. The empty duplicate
lowercase `Failover clusters` state view was removed from Availability; the working `Failover
Clusters` view targeting Microsoft's authoritative cluster class remains. Regression coverage now
requires friendly display strings for every product MP and user-facing element and forbids the
duplicate cluster view.

## [1.0.3.0] — 2026-09-02

Corrective in-place upgrade from `1.0.2.0` after live SCOM certification. The registry seed can
now create `HyperVPrivateCloud.HostRole` before the topology
discovery supplies its authoritative boundary: the non-key `BoundaryId` property is optional at
seed time instead of invalidating every seed instance. Successful S2D and VMM host-relationship
discoveries now terminate `pwsh.exe` explicitly with exit code zero after submitting their valid
`System.DiscoveryData` payloads, preventing CommandExecuter from discarding the payload during
process termination. Regression coverage requires valid discovery output to have both an empty
stderr stream and a zero process exit code.

## [1.0.2.0] — 2026-09-01

Corrective in-place upgrade from `1.0.1.0` after live SCOM 2025 certification. Discovery and
property-bag workflows now accept multiline `<DataItem>` XML emitted by the SCOM script API;
previously the command-executor event policy dropped otherwise valid output and raised workflow
initialization alerts. The S2D object-health probe now preserves empty and singleton query results
as arrays under strict mode, preventing `$null.Count` failures when no storage job or another
optional S2D object is present. Both runtime contracts are covered by regression tests.
The diagnostic-summary task now returns PowerShell runtime and Hyper-V query failure evidence when
the management path is unavailable instead of terminating without operator-readable output.
Release packaging now reuses an already loaded matching SCOM SDK identity and reads sealed loose-MP
resources without rebinding the SDK, allowing multi-bundle verification under PowerShell 7. Its
release provenance gate now captures native Git success directly instead of assuming the optional
`$LASTEXITCODE` variable has been initialized.

## [1.0.1.0] — 2026-08-31

First field-test cut, additive over 1.0.0.0 (in-place upgrade; existing override pairs keep
importing). Three nested enterprise Distributed Applications — **Hyper-V Private Cloud** (the
whole solution) containing **Hyper-V Fabric** (every cluster and standalone host across all sites)
and **Management Stack** (host management services, VMM, SDN, monitoring pipeline) — with 15
availability/performance/configuration roll-ups, a Solution Health view and three diagram views
leading the Overview folder. The CompletePrivateCloud tuning profile no longer requires the Pure
Storage pack (it means everything supportable on SCOM 2025; ClusteredPure and HybridPureAndS2D
remain the explicit Pure profiles). Also shipped alongside: the one-command prerequisite and
override installers and the operations guides. 13 sealed MPs, 66 override packs, 14 bundles:
162 unit monitors, 111 dependency roll-ups, 80 rules, 22 discoveries, 116 views.

## [1.0.0.0] — 2026-08-31

**The first release of Hyper-V Private Cloud Monitoring.** 13 permanently sealed Management Packs
(token `54d0fb1159995c86`), 66 public override packs, 14 deterministic bundles, manifests and
SHA-256 checksums under `docs/public/downloads/hyper-v-private-cloud/1.0.0.0/` and `latest/`:
162 unit monitors, 96 dependency roll-ups, 80 rules, 22 discoveries, 112 views, 63 agent tasks,
4 console tasks and 234 knowledge articles.

This release consolidates everything below. The sealed builds published briefly during
2026-08-30/31 under versions `1.0.0.0`–`1.4.0.0` were engineering iterations that were never
deployed to any management group; they were withdrawn and their download artifacts removed
([ADR 0054](docs/design/decisions/0054-the-real-1000-version-reset.md)). The source tree also lost
its misleading `v2` directory: the product lives at `src/hyper-v/scom-mp/`, with the abandoned
pre-rename pack source under `archive/hyperv-scom-mp-legacy/`.

Highlights on top of the section below: cluster-wide facts evaluated once per cluster on a
cluster-hosted role; host-wide facts (iSCSI/MPIO event counts, ATC ETS/QoS) once per host; **one
probe run per host** feeding every per-VM, per-LUN, per-session, per-port and per-intent monitor
and collection rule (cookdown restored across the board); Physical Network link monitors scoped to
vSwitch-uplink and intent adapters by default; the File Services link to Microsoft's SMB service
objects as an opt-in discovery; a 63-task operator catalogue; and a probe smoke test that runs
every embedded script under `pwsh -File` before a release can be cut.

## Withdrawn: engineering build — 2026-08-30 (never deployed; see ADR 0054)

First release of Hyper-V Private Cloud Monitoring under its own product-named identity.

### Changed

* **BREAKING.** Management Pack identities are named for the product rather than the publisher:
  `HybridSolutionsCloud.HyperVPrivateCloud.*` becomes `HyperVPrivateCloud.*`. Publisher attribution
  moves to the sealed pack `Company`/`Copyright` metadata and the documentation. SCOM treats a
  renamed Management Pack as an unrelated pack, so there is **no in-place upgrade** from `2.0.0.0`:
  the old packs must be removed before these are imported, discarding stored overrides and
  accumulated health state. See ADR 0049.
* **BREAKING.** The version line restarts at `1.0.0.0`. The new identity has no prior release, and
  no `1.0` was ever officially released under the old one.
* Published override starters drop the organization prefix and are named
  `HyperVPrivateCloud.Overrides.<Profile>.<Tier>.<Kind>`. Customer-generated overrides keep the
  conventional `<Org>.HyperVPrivateCloud.Overrides.*` form from `-OrganizationId`.

### Added

* Generated prerequisite documentation: `tools/scom/Export-MpDependencies.ps1` extracts every
  `<References>` block from Management Pack source, classifies each dependency, and renders it into
  the prerequisite pages. `tests/unit/MpDependencies.Docs.Tests.ps1` fails the build on drift, so
  the documented dependencies can no longer diverge from the packs.
* Operator prerequisite pages for Hyper-V and Azure Local SCOM, plus a `start-here` entry point.

### Fixed

* Documented the external Microsoft and vendor Management Packs each capability requires — the most
  common cause of a failed import — including `Microsoft.Windows.Cluster.Library` `6.0.6278.0`, the
  two File Services packs at two distinct versions, and Pure Storage's separate publisher token and
  lack of SCOM 2025 support.

### Documentation

* Azure Local documentation nested under `docs/azure-local/{scom,azure-monitor}/`, with redirects
  from the previous `/scom-mp/` and `/azure-monitor/` URLs.
* Navigation restructured task-first; architecture decision records moved to their own themed
  section.

## Consolidated engineering notes (2026-08-30/31, released as 1.0.0.0 above)

* Move the project to `Hybrid-Solutions-Cloud/hybrid-health-monitoring` and publish documentation
  at `https://labs.hybridsolutions.cloud/hybrid-health-monitoring/`.

### Fixed

* Full line-by-line review of the thirteen Hyper-V Private Cloud packs ([ADR 0053](docs/design/decisions/0053-management-pack-review-and-runtime-correctness.md)).
  The shipped `1.0.0.0` could not have monitored a real host: a non-existent `VMHost.HyperVVersion`
  property aborted topology discovery on every host, 20 of 27 scripts constructed the script API as a
  .NET type that does not exist in `pwsh.exe`, nine `[bool]` parameters could not bind the string
  arguments `pwsh -File` passes, and the generator garbled every property and relationship display
  name. All four are corrected and guarded by tests.
* Corrected runtime behaviour found by the same review: CSV objects keyed as Microsoft's CSV pack
  keys them, quorum vote margin defaults that were permanently Critical on 2–4 node clusters,
  Dynamic Memory ratios on static-memory VMs, nine Critical states per VM after every live migration,
  S2D boot-disk false alerts, SAS/RAID multipath warnings, Network ATC blank provisioning status,
  SDN certificate selection and endpoint counting, VMM agent-drift comparison and cloud capacity
  cmdlets, alert and performance views targeted at classes that never carried the packs' data, and
  cookdown broken by mixed intervals inside one data source.
* Schema faults that only Microsoft VSAE reports: `<Monitors>` child ordering in all nine capability
  packs and the performance mapper referenced under the wrong alias in the networking packs. All 13
  packs now verify and seal.

### Added

* Publish Hyper-V Private Cloud Monitoring `1.4.0.0`: 13 permanently sealed MPs (token
  `54d0fb1159995c86`), 66 public override packs, 14 bundles, manifests and SHA-256 checksums under
  `docs/public/downloads/hyper-v-private-cloud/1.4.0.0/` and `latest/`: 162 unit monitors, 96
  dependency roll-ups, 80 rules, 22 discoveries, 112 views, 63 agent tasks, 4 console tasks and
  234 knowledge articles. `1.3.0.0`, `1.2.0.0` and `1.1.0.0` (same day, before the cluster role and the task
  catalogue respectively) and `1.0.0.0` (non-functional, ADR 0053) are retained as evidence only;
  `1.0.0.0` is marked not for deployment.
* Operator task catalogue: 63 agent tasks across the Monitoring, Cluster, S2D, Storage, File
  Services, Network ATC, Physical Network, VMM and SDN packs (read-only diagnostics plus clearly
  labelled remediation tasks, each with knowledge), 4 console tasks (Remote Desktop, Hyper-V
  Manager, Failover Cluster Manager, VM Connect), a VM-health diagnostic on the expected-state
  monitor and two recoveries that ship disabled (restart VMMS, resume a paused VM).
* Probe smoke test that runs every embedded script under `pwsh -File` with its real arguments
  against a `MOM.ScriptAPI` shim (47 cases) — the layer whose absence let 1.0.0.0 ship.
* Distributed Application roll-ups redesigned so each branch reflects its own domain (Storage,
  Networking, Availability, Management, Monitoring Pipeline) with Performance and Configuration
  roll-ups at both levels; Hyper-V event collection (8 channels) and alert rules (10) with operator
  knowledge; a product-wide `Hyper-V Private Cloud Objects` group with an All Active Alerts view;
  SDN host-binding roll-ups and alerting; 41 knowledge articles for Cluster, S2D and File Services
  monitors that had none; Lab/Standard/Strict tiers for the SDN host-side monitors.

### Changed

* Host-wide facts are evaluated once per host. The storage iSCSI connection-error, iSCSI
  authentication-failure and MPIO path-failover monitors target the host role through a shared
  `HostEvents` monitor type with cookdown-identical configuration (one probe run feeds all three);
  the Network ATC ETS and QoS traffic-class monitors target the host role (`Get-NetQosTrafficClass`
  is host-global). Previously each iSCSI session, each LUN and each intent raised the same alert.
* Physical Network link-state and link-speed monitors evaluate only external-vSwitch uplinks and
  Network ATC intent adapters by default; the new `IncludeNonUplinkAdapters` override restores the
  old behaviour. A dark port on a multi-port NIC no longer holds the host Warning forever.
* The File Services discovery no longer emits a Microsoft SMB service instance for the file servers
  it sees — that emission rejected the whole discovery batch (event 10801) when the file server's
  computer object was not in the management group, and created a phantom SMB service where it was.
  The reference ships as a separate `MicrosoftSmbLink` discovery, disabled by default, for
  deployments whose SMB file servers are SCOM-managed.
* Cluster-wide facts are evaluated once per cluster. The 13 cluster-scoped monitors (CSV state,
  free space and redirected access, quorum, node, network and group state), the two CSV capacity
  rules and the cluster relationship discovery now target
  `HyperVPrivateCloud.Capability.Cluster.ClusterRole`, hosted by the cluster core virtual server
  (`Microsoft.Windows.Cluster.VirtualServer`) so they run on the core-group owner and fail over with
  it; only the node-local CSV latency and queue monitors remain on the host role. Requires agent
  proxy on cluster nodes, as the Microsoft Cluster pack already does. Tuning-catalog context class
  updated accordingly.
* The four original storage availability monitors (attachment availability/redundancy, iSCSI
  session availability, Fibre Channel port availability) ship disabled as superseded by the depth
  monitors; the VLAN-mismatch monitor ships disabled because Windows exposes no LLDP neighbour data.
  Element IDs are preserved.
* Run every Hyper-V Private Cloud v2 first-party script through public SCOM command-executor
  wrappers that launch the machine-wide PowerShell 7 MSI path explicitly; add operator-visible
  runtime evidence, the common installation prerequisite, static contract tests, and ADR 0047.
* Correct both SCOM Distributed Application component class bases to the verified Service Designer
  `ServiceComponentGroup` type and run SDK verification through Visual Studio 2022's
  full-framework VSAE host.
* Remove SCOM expression-namespace collisions from both discovery scripts, correct MAML knowledge
  sections and three-state health mappings, and test-seal both complete five-MP dependency chains.
* Split the Design and platform sidebars into four solution-owned navigation groups so Azure Local
  and Hyper-V SCOM designs are visibly separate from their Azure Monitor Health Models designs.
* Expose solution-owned SquaredUp Dashboard Server and SquaredUp Cloud documentation in the
  sidebars and add the missing Hyper-V placeholders.
* Clarify that Migration means on-premises SCOM monitoring to Azure Monitor Health Models rather
  than workload or platform migration.
* Remove internal work-item identifiers and direct board links from public documentation and
  repository Markdown.
* Migrate the documentation site and deployment pipelines from MkDocs to VitePress while preserving the project logo, banner, and favicon.
* Rename the public site to Hybrid Infrastructure Health Monitoring and organize it by Azure Local and Hyper-V platform tracks.
* Replace the phase-only roadmap with Azure DevOps-backed platform Epics, delivery Features, research spikes, and architecture gates.

### Added

* Publish Hyper-V Private Cloud Monitoring `2.0.0.0` in the repository: 13 permanently sealed MPs,
  66 import-ready public override MPs, 14 bundles, immutable/current manifests and SHA-256
  checksums, direct documentation-site downloads, and public key token `54d0fb1159995c86`.
* Add the governed Hyper-V v2 sealing and release-package path: Microsoft VSAE `SealMp`, permanent
  signing-identity and clean-source gates, compatible dependency preflight, 13 individual sealed MP
  assets, 66 import-ready public override MPs, core/complete/override and 11 profile bundles,
  publisher `.mpb` identity/Authenticode inspection and transitive VSAE dependency remapping, publisher dependency
  provenance, manifests, SHA-256 checksums, an independent validator, tests, and accepted ADR 0048.
* Add the protected Hyper-V v2 production-release workflow and public runbook: Azure OIDC retrieves
  the permanent key from Key Vault only into runner temp, Release-mode eligibility is enforced,
  exact assets are retained, existing releases cannot be overwritten, and stable latest-download
  URLs are verified after publication.
* Add a read-only SCOM management-group certification collector and core standalone expectation.
  It verifies imported identities, overrides, topology, workflow and view inventory, Distributed
  Application presence, and recent HealthService diagnostic evidence while keeping destructive and
  lifecycle gates explicitly pending for human-reviewed labs.
* Accept ADR 0048, provision the permanent Hyper-V v2 signing identity with public token
  `54d0fb1159995c86`, make the repository the canonical binary distribution surface, and move SCOM
  runtime certification after publication while retaining fail-closed VSAE, strong-name,
  dependency, source-commit, archive, and checksum gates.
* Add the Hyper-V Private Cloud Monitoring v2 override system: 11 composable deployment profiles,
  Lab/Standard/Strict tiers, 66 generated Discovery/Monitoring examples, explicit workflow and
  context schema, independent customer/product versions, same-MP group targeting, semantic and
  drift tests, cookdown checks, invalid-profile rejection, and Microsoft VSAE verification.
* Add the Hyper-V v2 VMM 2025 capability against the exact shipped Microsoft VMM MP identities,
  with a VMM-fabric Distributed Application root, exact server/host/cloud relationships, missing
  logical-network and network-site projections, read-only failed-job monitoring, targeted service
  rollups, 20 console views, dependency evidence, operator guidance, tests, and ADR 0046.

* Add a preview-gated Azure Local Azure Monitor Health Model baseline with Bicep-defined identity,
  entities, relationships, documented platform metric signals, state alerts, development
  parameters, research KQL, a starter workbook, contract validation, research, and ADR 0036.
* Accept a constrained Hyper-V Azure Monitor go and add an independent Bicep-compiling Health Model
  baseline with Arc-enabled SCVMM inventory, Arc-enabled host entities, Windows DCR, heartbeat,
  hypervisor CPU, cluster-event and telemetry-coverage signals, state alerts, research KQL,
  workbook, contract validation, and ADR 0037.
* Add the SCOM-to-ServiceNow development integration with separate Azure Local and Hyper-V
  connector profiles, an event/identity/lifecycle mapping contract, offline validation against both
  authored MPs, public administration guidance, and ADR 0038. The integration configures
  ServiceNow's existing SCOM Events connector; live MID Server certification remains.
* Implement the functional Azure Local SCOM MP baseline as five independent artifacts with 17
  classes, 28 relationships, staged discovery, a six-branch Distributed Application, 14 unit
  monitors, six domain aggregates, 12 dependency rollups, curated alerts, performance and event
  rules, diagnostics, operational knowledge, and 14 operator views.
* Add separate Azure Local Discovery and Monitoring override MPs, provisional Lab, Standard, and
  Strict starter templates, deterministic contract and Pester tests, SDK verification tooling, an
  administration guide, and release-gate documentation.
* Add Azure Local SCOM research, monitoring catalog, architecture, package, class, workflow,
  health, tuning, and validation documentation with editable draw.io sources and published SVGs.
* Accept ADRs 0032–0035 for the Azure Local local-runtime boundary, MP decomposition, object and DA
  architecture, and health/alert/rollup contract.
* Add separate customer-owned Hyper-V Discovery and Monitoring override contracts, optional Lab,
  Standard, and Strict starter templates, and a public Management Pack administration guide.
* Implement the functional Hyper-V MP development baseline with 13 classes, 20 relationships,
  staged discovery, a platform-owned Distributed Application, 9 health monitors, 10 dependency
  rollups, 12 performance rules, 4 event-alert rules, operational knowledge, a diagnostic task,
  and 10 operator views.
* Add deterministic build and contract checks, Microsoft SDK verification tooling, complete public
  element localization, and Pester coverage for topology, workflows, views, and product boundaries.
* Generate separate customer-owned Hyper-V Discovery and Monitoring override MPs for Lab,
  Standard, and Strict starter profiles, and accept ADRs 0027–0029 and 0031.
* Add a ServiceNow integration roadmap covering separate SCOM and Azure Monitor paths, secure
  webhook modernization, dual-source authority, research gates, and proof-of-concept outcomes.
* Add the committed Hyper-V SCOM Management Pack track and conditional Azure Monitor track through Arc-enabled SCVMM.
* Add ADRs 0021–0023 for the platform split, SCOM packaging boundary, and Hyper-V Azure Monitor go/no-go gate.
* Add the phase-one Hyper-V SCOM monitoring research plan, exhaustive inventory schema, threshold
  policy, and bounded research spikes.
* Treat Network ATC as the preferred baseline for eligible Windows Server 2025 Datacenter Hyper-V
  clusters, with separate manual and SCVMM/SDN-managed networking paths.
* Define the Microsoft Hyper-V 2019 Management Pack as research evidence only, with no import,
  extension, override, or runtime dependency in the new Hyper-V MP.
* Split the design documentation into explicit Azure Local and Hyper-V platform sections, each
  separated into SCOM and Azure Monitor design lanes.
* Add ADR 0025 for Hyper-V network-management authority and the Network ATC, SCVMM/SDN, and manual
  networking variants.
* Accept ADR 0022 with completely independent Azure Local and Hyper-V SCOM runtime packaging.
* Add ADR 0026 plus explicit Azure Local and Hyper-V Distributed Application design contracts,
  implementation tasks, dynamic membership, rollup, views, reports, dashboards,
  SLO targets, and validation requirements.
* Add the comprehensive Hyper-V SCOM architecture set with Vue-rendered component, class,
  sequence, state, dependency, discovery, alert, security, test, and release diagrams.
* Propose ADRs 0027–0029 for Hyper-V MP decomposition, object/discovery architecture, and
  evidence-driven health, alert, and DA rollup behavior.
* Restructure `src/` by Azure Local and Hyper-V platform, then SCOM and Azure Monitor solution;
  accept ADR 0030 as the source-path authority and nest optional SquaredUp artifacts by owner.

## [0.2.1](https://github.com/AzureLocal/azurelocal-scom-mp/compare/azurelocal-scom-mp-v0.2.0...azurelocal-scom-mp-v0.2.1) (2026-05-05)

### Bug Fixes

* Resolve 3 mkdocs strict-mode link errors ([52d9251](https://github.com/AzureLocal/azurelocal-scom-mp/commit/52d9251e4fc0f94ad610672cb7bf107f08222573))

## [0.2.0](https://github.com/AzureLocal/azurelocal-scom-mp/compare/azurelocal-scom-mp-v0.1.0...azurelocal-scom-mp-v0.2.0) (2026-05-05)

### Features

* Add logo, favicon, and banner SVG assets ([811def0](https://github.com/AzureLocal/azurelocal-scom-mp/commit/811def0098dcc74e791880e49e78a1a05614915c))
* Complete Phase 1 - diagram stubs ([5bd3575](https://github.com/AzureLocal/azurelocal-scom-mp/commit/5bd357562729cc5ea850fc3d6a4f15e64633c09d))
* Initial repo scaffold and platform compliance ([ab51f12](https://github.com/AzureLocal/azurelocal-scom-mp/commit/ab51f1268469606a906719339791f4a7445fa495))
* Phase 2 kickoff - infra scope, customization, ADR 0001 ([067c5c8](https://github.com/AzureLocal/azurelocal-scom-mp/commit/067c5c8eb625266fbba838152b526fef1245664b))
* **phase-2:** Complete Phase 2 sign-off — ADRs accepted, drawio diagrams, SquaredUp, Mermaid refinement ([d17595b](https://github.com/AzureLocal/azurelocal-scom-mp/commit/d17595baa2ea6d7a05015e23ec4a1020603fc290))
* **phase-2:** Docs reorg — promote Design to top-level section + author ADRs 0002-0010 ([de266cb](https://github.com/AzureLocal/azurelocal-scom-mp/commit/de266cb668d8c6ff63f7ec697e773841b99b653d))

## Changelog

## [1.3.2.0] — 2026-09-04

Corrective release resolving every runtime defect found in the SCOM operational audit of 1.2.0.0, plus
the applicability and cookdown work that audit exposed. All 13 sealed product MPs carry version
`1.3.2.0`, signed with public key token `54d0fb1159995c86`.

**Runtime defects fixed**

- File Services no longer raises `The property 'Count' cannot be found on this object` (Event 8702).
  Ten StrictMode null-collapse sites were fixed across File Services, Network ATC, Physical Network
  and VMM, and the cascade that marked ten unevaluated SMB facets `Warning` on a single probe failure
  was removed.
- Ten Windows event rules no longer carry the invalid `$Data/Params/Param[1]$` suppression (Event 5402).
- Network ATC no longer throws on hosts without ATC (Event 8903): `RequireNetworkATC` defaulted to
  `true` in fifteen unit monitors and is now `false`.
- Failover Cluster and VMM workflows run on the Windows PowerShell host, because `FailoverClusters` and
  `VirtualMachineManager` ship only as Windows PowerShell modules. The `-SkipEditionCheck` and
  `-UseWindowsPowerShell` workarounds are removed; both are PowerShell 7 parameters that raise
  `ParameterBindingException` under 5.1 (Event 8301).
- SDN no longer reports a host as SDN-enabled because an in-box `NcHostAgent` service exists. Detection
  now requires a populated Network Controller `HostId` **and** a host agent that is not absent,
  disabled or unreadable, in both the discovery and the health workflow.
- VMM events 8510/8511/8512/8904/8905 log the full exception chain instead of `Exception.Message`.
- Nine probes no longer return `Good` from a `catch` block or claim health they never measured.

**Applicability**

Every capability monitor now targets the object it describes rather than the Hyper-V host. File
Services and Storage gained participation classes discovered only where UNC-backed virtual disks or
SAN-attached storage actually exist; Cluster, Network ATC and SDN monitors moved onto their existing
discovery-gated classes. Capabilities that are not deployed no longer instantiate at all.

**360° model**

The physical chassis, DHCP, top-of-rack switch, edge firewall and console-server monitors target their
own infrastructure classes instead of the Hyper-V host, so those objects carry their own health.
Edge firewall, console server and out-of-band switch have no discovery yet and are documented as
pending; their classes remain because a sealed management pack upgrade cannot remove class types.

**Performance**

The eleven VMM fabric monitors share one data source configuration and one VMM connection instead of
eleven, so a single initialization failure no longer produces eleven failing workflows.

## [1.3.2.0] — 2026-09-04

Corrective release resolving every runtime defect found in the SCOM operational audit of 1.2.0.0, plus
the applicability and cookdown work that audit exposed. All 13 sealed product MPs carry version
`1.3.2.0`, signed with public key token `54d0fb1159995c86`.

**Runtime defects fixed**

- File Services no longer raises `The property 'Count' cannot be found on this object` (Event 8702).
  Ten StrictMode null-collapse sites were fixed across File Services, Network ATC, Physical Network
  and VMM, and the cascade that marked ten unevaluated SMB facets `Warning` on a single probe failure
  was removed.
- Ten Windows event rules no longer carry the invalid `$Data/Params/Param[1]$` suppression (Event 5402).
- Network ATC no longer throws on hosts without ATC (Event 8903): `RequireNetworkATC` defaulted to
  `true` in fifteen unit monitors and is now `false`.
- Failover Cluster and VMM workflows run on the Windows PowerShell host, because `FailoverClusters` and
  `VirtualMachineManager` ship only as Windows PowerShell modules. The `-SkipEditionCheck` and
  `-UseWindowsPowerShell` workarounds are removed; both are PowerShell 7 parameters that raise
  `ParameterBindingException` under 5.1 (Event 8301).
- SDN no longer reports a host as SDN-enabled because an in-box `NcHostAgent` service exists. Detection
  now requires a populated Network Controller `HostId` **and** a host agent that is not absent,
  disabled or unreadable, in both the discovery and the health workflow.
- VMM events 8510/8511/8512/8904/8905 log the full exception chain instead of `Exception.Message`.
- Nine probes no longer return `Good` from a `catch` block or claim health they never measured.

**Applicability**

Every capability monitor now targets the object it describes rather than the Hyper-V host. File
Services and Storage gained participation classes discovered only where UNC-backed virtual disks or
SAN-attached storage actually exist; Cluster, Network ATC and SDN monitors moved onto their existing
discovery-gated classes. Capabilities that are not deployed no longer instantiate at all.

**360° model**

The physical chassis, DHCP, top-of-rack switch, edge firewall and console-server monitors target their
own infrastructure classes instead of the Hyper-V host, so those objects carry their own health.
Edge firewall, console server and out-of-band switch have no discovery yet and are documented as
pending; their classes remain because a sealed management pack upgrade cannot remove class types.

**Performance**

The eleven VMM fabric monitors share one data source configuration and one VMM connection instead of
eleven, so a single initialization failure no longer produces eleven failing workflows.

All notable changes to Hybrid Infrastructure Health Monitoring are documented here.

The format follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/)
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

Release notes are generated automatically by
[release-please](https://github.com/googleapis/release-please).
