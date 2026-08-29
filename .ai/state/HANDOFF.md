# Handoff

## Current session

- **V2 deployment profiles and public overrides authored and verified:** Added explicit tuning
  catalog schema 2.0, a capability-aware customer/public/example generator, and deterministic
  example updater. All 11 package profiles generate separate Lab/Standard/Strict Discovery and
  Monitoring MPs (66 committed `.xml.example` files) with independent customer/product versions,
  only selected capability references, fixed external Pure/S2D/VMM context identities, shared
  cookdown-safe values, and UTF-8 without BOM. Standard includes a worked dynamic all-hosts group
  defined in the same unsealed Monitoring Overrides MP. Custom profiles support class and same-MP
  group targeting and reject unknown schemas/capabilities and cross-MP groups. A new test suite
  builds all 13 product MPs, regenerates/byte-compares examples, and resolves every workflow,
  target, module, property, parameter, and alias. Microsoft VSAE caught child-element override
  syntax inherited from the old generator; v2 now correctly emits `Module` and `Parameter`
  attributes. A generated Standalone Standard pair passes OM2022 VSAE with only the expected
  unsealed group type-definition warning. Full Pester passes 110/110; PSScriptAnalyzer, JSON,
  `git diff --check`, and VitePress production build pass. Scratch VSAE evidence is
  `D:/tmp/hcs-v2-override-vsae-20260829/`. Documentation, ADR 0043, root plan, README, and changelog
  are updated. Representative SCOM runtime/import/export/upgrade/removal labs and governed release
  identity rendering remain; the PowerShell 7 execution-host proof is the next release blocker.

- **V2 VMM 2025 capability authored and offline verified:** Added `Capability.VMM` against the
  exact Microsoft VMM 2025 media identities: Library/Discovery/Monitoring `11.19.0.3` and PRO v2
  Library `10.25.1200.0`. The adapter creates a VMM-fabric DA root, relates exact Microsoft VMM
  management servers, hosts, clouds, and VM networks, projects only the verified logical-network
  and network-site gaps, queries failed jobs read-only through Microsoft's VMM Server Connection
  Run As profile, adds ten nonduplicate rollups, and provides 20 views. Microsoft retains all
  published VMM objects, leaf health, alerts, performance, dashboards, reports, SDK population,
  and remediation authority. OM2022 VSAE caught and drove fixes for Run As placement, presentation
  string-resource placement, dynamic `$MPElement` expressions, and StateView criteria. The final
  source passes VSAE using transiently re-signed copies extracted from Microsoft's VMM/SQL bundles,
  transient sealing, and `sn.exe -vf`. Combined Hyper-V Pester passes 93/93; five changed product
  scripts pass PSScriptAnalyzer; JSON contracts, `git diff --check`, and VitePress production build
  pass. ADR 0046, the dependency contract, guide, source README, plan, changelog, manifest, and
  navigation are updated. Scratch verification evidence is under
  `D:/tmp/hcs-hyperv-v2-vmm-verify-20260829/` and is not release-signed output. Representative VMM
  integration, Run As, topology, jobs, fault/recovery, coexistence, upgrade, and removal labs
  remain. Public v2 profiles and override MPs are next.

- **V2 Windows Server SDN capability authored:** Added `Capability.SDN` as a thin optional adapter
  over Microsoft's inspected `Microsoft.Windows.10.SDNMonitoring` `10.0.0.2` contract. Microsoft
  retains Network Controller REST discovery, Run As/certificate handling, its 22-class topology,
  leaf health, alerts, performance, and native views. HCS adds one hosted local HostBinding
  evidence class, ten Management/Networking relationships, one non-duplicating integration
  monitor, 11 dependency rollups including the verified missing controller-node SecurityState
  rollup, and 16 views. The adapter never calls Network Controller REST, uses the Microsoft Run As
  credential, fabricates a Microsoft SDN Host from the mismatched local InstanceId, remediates, or
  duplicates leaf alerts. Deterministic build emits 12 valid XML artifacts; combined Hyper-V
  Pester passes 85/85; changed PowerShell passes ScriptAnalyzer with no Warning/Error findings;
  dependency JSON parses; `git diff --check` and the VitePress production build pass. Direct
  OM2022 VSAE verification, transient sealing, and `sn.exe -vf` passed before the final no-schema
  cleanup. ADR 0045, the dependency contract, operator guide, source README, plan, and navigation
  are updated. Microsoft prerequisite setup and representative SDN topology, certificate,
  controller/gateway fault, ATC/VMM coexistence, lifecycle, and removal labs remain release gates.
  VMM is next.

- **Network authority corrected to layered coexistence:** Current Microsoft guidance proves
  Network ATC and Windows Server SDN can coexist: ATC may own host adapters/SET intent while
  Network Controller owns overlay policy and VMM orchestrates the fabric. Updated current design,
  DA, discovery, catalog, guide, and plan surfaces to prohibit duplicate object health paths
  without falsely treating Physical Network, ATC, SDN, and VMM capabilities as globally exclusive.

- **V2 Network ATC capability authored:** Added `Capability.NetworkATC` as a read-only optional
  adapter over Windows Server 2025 Network ATC. Stable intent, per-node status, and global-setting
  projections connect to the Network DA branch, HCS hosts, and exact Windows network adapters.
  Four unit monitors cover capability/authority, intent convergence, adapter symmetry/RDMA, and
  global convergence; four dependency rollups and seven views expose the resulting state. The pack
  never invokes Network ATC mutation or retry commands. Missing Network ATC remains Not Applicable
  unless explicitly required. Combined preview/v2 Pester passes 79/79; three changed PowerShell
  files pass ScriptAnalyzer; JSON contracts parse; `git diff --check` and the VitePress production
  build pass. OM2022 VSAE, transient sealing, and `sn.exe -vf` passed earlier in this session;
  representative SCOM lifecycle and fault labs remain release gates. ADR 0044 and the dependency,
  prerequisite, build, test, package, and navigation surfaces are updated. SDN is next, followed by
  VMM.

- **Root v2 plan execution summary added:** Updated `PLAN.md`, the existing authoritative root
  plan, with a current workstream/exit-gate table and an explicit remaining execution
  order. The release contract now requires governed sealed bundles and individual MPs, public
  customer-owned Lab/Standard/Strict override bundles, checksums, release and migration guidance,
  GitHub release assets, and a stable documentation-site **Download now** link. It explicitly
  rejects transient test seals, incomplete capability sets, hand-edited overrides, and source-only
  archives as public-release completion. Network ATC remains the immediate implementation
  priority, followed by SDN, VMM, overrides/profiles, representative labs, governed sealing, and
  publication. Network ATC is now authored, so the remaining sequence contains six steps beginning
  with SDN.

- **V2 Physical Network adapter authored:** Added `Capability.PhysicalNetwork` as a thin adapter
  over the built-in SCOM network model. Direct inspection of SCOM 2016 `7.2.11719.0`, SCOM 2019
  `10.19.10050.0`, and SCOM 2022 `10.22.10118.0` confirmed the required public Node, Switch,
  NetworkAdapter, Port, VLAN, NetworkConnection, and connection relationship contracts. System and
  Windows libraries also prove that `Microsoft.Windows.ComputerNetworkAdapter` derives from
  `System.Device.NetworkAdapter`; SCOM's built-in merging workflow matches MAC addresses, writes
  `System.NetworkManagement.NetworkConnectionConnectedToNetworkAdapter`, and computes peer
  topology. HCS therefore defines no network-resource class, SNMP workflow, credential, or
  competing alert. Two relationships attach external vSwitches and the Network DA branch to exact
  Windows adapters using the exact `Get-NetAdapter` DeviceID and raw MAC representation consumed by
  Microsoft's Windows Server discovery. One correlation-input monitor, two
  dependency rollups, and eight Microsoft-object views are authored. Focused v2 Pester passes
  59/59; combined preview/v2 Pester passes 74/74; ScriptAnalyzer, `git diff --check`, and VitePress
  production build pass. OM2022 VSAE passes with only expected unsealed type-definition warnings;
  transient seal and `sn.exe -vf` pass. VSAE scratch evidence is
  `D:/tmp/hcs-hyperv-v2-physical-network-final-verify-26d193018ab9450a89da5060aeb4d176`;
  transient sealed evidence is
  `D:/tmp/hcs-hyperv-v2-physical-network-final-seal-8d3fa740bc684c75bff1188df94a3929`.
  Representative SCOM network discovery, host-adapter-to-switch-port traversal, device fault,
  recovery, and removal labs remain. Network ATC is the next capability; SDN and VMM follow.

- **VSAE corrections during Physical Network authoring:** Removed an invalid nonexistent
  `ComponentId` property from the Network component proxy and corrected capability FolderItems to
  the immutable `Networking.Folder` ID. Fresh current Library/Presentation test seals were used for
  verification. The sealed output is transient and not a governed release artifact.

- **V2 SMB/SOFS File Services adapter authored:** Added `Capability.FileServices` against the
  inspected Microsoft File & iSCSI Services `10.1.0.4` contract. It defines three HCS-only classes
  (SMB share, Multichannel/RDMA client path, and VHDX mapping), seven relationships, one Hyper-V
  host dependency monitor, three rollups, and seven views. UNC/server/share, channel endpoint, and
  VM/disk identities are stable hashes; the adapter references Microsoft's SMB service and leaves
  Microsoft as File Server/SMB leaf-alert authority. Cluster remains an independently composable
  capability rather than a hard dependency for nonclustered SMB. Focused v2 Pester passes 55/55;
  combined preview/v2 Pester passes 70/70; ScriptAnalyzer and the VitePress production build pass.
  OM2022 VSAE passes with only expected pre-seal type warnings; transient sealing and `sn.exe -vf`
  pass. Final scratch evidence is `D:/tmp/hcs-hyperv-v2-fileservices-final-9d59ea95d5e041bca8a3dca5c99752bf`
  and `D:/tmp/hcs-hyperv-v2-fileservices-final-seal-8d3e9461c4494bcabc3c9cf4c988fbe9`.
  Representative standalone SMB/SOFS runtime, failover, path-loss, and recovery labs remain.

- **S2D builder defect fixed:** The generated S2D discovery fragments previously inserted
  `{{S2D_RELATIONSHIP_DISCOVERY_SCRIPT}}` after the replacement pass. The builder now generates
  fragments before replacing scripts, expands unresolved-token detection to include digits, and
  the v2 suite checks every artifact for any remaining build token.

- **PowerShell execution host is now an explicit release blocker:** Microsoft currently documents
  Windows PowerShell 3.0 as the SCOM agent prerequisite for MPs that use PowerShell scripts, while
  the HCS standard mandates `#Requires -Version 7.0`. The authored XML uses Microsoft Windows
  PowerShell probe/provider module types. VSAE does not prove their runtime host, so `PLAN.md` and
  `OPEN_QUESTIONS.md` now require a representative agent proof before any v2 runtime claim. If the
  providers do not host PowerShell 7, the pack needs an explicit supported `pwsh.exe` module path
  or a documented governance exception; silently dropping the requirement is prohibited.

- **V2 Pure Storage adapter authored:** Added `Capability.PureStorage` against the inspected vendor
  `PureStorageFlashArray` `2.0.120.0` identity. It defines no competing Pure classes, uses no Pure
  credential or REST/control path, and preserves the vendor pack as leaf-topology, health, alert,
  and performance authority. Four relationships and rollups connect arrays and ports to Storage,
  Pure hosts to HCS hosts by exact IQN/WWPN, and Pure volumes to HCS logical units by exact serial;
  ambiguous identities are skipped. One integration monitor and 11 views cover the adapter and
  vendor topology. Focused v2 Pester passes 48/48, combined preview/v2 Pester passes 63/63,
  ScriptAnalyzer passes for the changed scripts, and the VitePress production build passes.
  OM2022 VSAE passes with only expected pre-seal relationship warnings, and transient sealing plus
  `sn.exe -vf` pass. VSAE scratch evidence is
  `D:/tmp/hcs-hyperv-v2-pure-verify-5cfd228c25334bc899e7564030c8199d`; sealed scratch evidence is
  `D:/tmp/hcs-hyperv-v2-pure-seal-4616e269fb744167a3d021c8fec3e12d`. A representative FlashArray
  runtime lab remains a release gate. SMB/SOFS File Services is next.

- **V2 Microsoft S2D adapter authored:** Added `Capability.S2D` with no competing storage classes.
  Seven relationships and seven dependency rollups connect Microsoft's `1.0.47.4` subsystem, node,
  physical disk, pool, virtual disk, volume, and file-share objects to the HCS Storage branch. One
  HCS monitor checks only adapter query coverage; 11 views expose authoritative Microsoft state,
  performance, faults, ongoing jobs, and alerts. Focused v2 Pester passes 42/42 and combined
  preview/v2 Pester passes 57/57; ScriptAnalyzer and the VitePress production build pass. VSAE
  found and drove correction of duplicate localization and Volume/FileShare hosting-depth
  expressions. The
  final source passes VSAE against transiently re-signed dependency copies derived from the exact
  inspected Microsoft bundle; the committed references retain Microsoft's genuine token. The pack
  transiently seals and passes `sn.exe -vf`. Scratch evidence is
  `D:/tmp/hcs-hyperv-v2-s2d-verify-6fad554e032e4991a403849525bf687c` and
  `D:/tmp/hcs-hyperv-v2-s2d-seal-4cf66cf13fba4f2dbe690c20b6e046d6`. Exact `.mpb` import and
  relationship/fault/job/performance labs remain release gates. Pure Storage integration is next.

- **V2 Storage Core capability authored:** Added `Capability.Storage` with five HCS-owned Windows
  SAN projections (logical unit, per-host attachment, iSCSI session, FC port, and VHDX mapping), 13
  topology relationships, five health monitors, three Storage-branch rollups, and six console
  views. Stable hashed LUN keys preserve identity while raw Windows serial/unique IDs remain
  available for future Pure correlation. The pack does not duplicate array or Microsoft S2D
  objects, and SAN/S2D remain independently composable. Focused v2 Pester passes 36/36; combined
  preview/v2 Pester passes 51/51; ScriptAnalyzer and the VitePress production build pass. OM2022
  VSAE caught and drove correction of missing FolderItem IDs, then passed with only expected
  pre-seal type-definition warnings. Transient seal and `sn.exe -vf` pass. Scratch evidence is
  `D:/tmp/hcs-hyperv-v2-storage-verify-ec2756d2464e428db831d9bee882be64` and
  `D:/tmp/hcs-hyperv-v2-storage-seal-9bab27f69ff34321a5dec9bb5c882729`; neither is release-signed
  output. Microsoft S2D integration is next.

- **V2 Cluster capability authored:** Added `Capability.Cluster` against the inspected Microsoft
  Cluster `10.1.0.0` and CSV `10.1.2.2` contracts. It defines no duplicate cluster classes: six
  relationships connect existing Microsoft cluster, node, role/group, network, and CSV objects to
  the HCS boundary, Availability, and Storage branches. One HCS monitor validates the adapter query
  pipeline and `FailoverClusters` module; five dependency monitors roll authoritative Microsoft
  leaf health without duplicate alerts; seven views attach beneath core Presentation folders.
  Focused v2 Pester passes 29/29. The capability resolves through OM2022 VSAE (only the expected
  pre-seal type-definition warnings), transiently seals with token `14a10c8275285f00`, and passes
  `sn.exe -vf`. Scratch evidence is under `D:/tmp/hcs-hyperv-v2-cluster-*`; representative cluster
  import, correlation, failover, rename, CSV, and removal labs remain.

- **Root implementation plan confirmed:** `PLAN.md` is the tracked, authoritative public plan for
  the Hyper-V Private Cloud Monitoring v2 redesign. It includes the complete domain catalog,
  modular package/dependency policy, Distributed Application and console design, override/profile
  redesign, representative lab matrix, governed sealing, packaging, documentation, and public
  download release gates. Its implementation sequence accurately records all four required Core
  MPs as authored while capability packs, overrides, labs, and release publication remain open.

- **V2 core Presentation authored:** Added the operator-facing `Hyper-V Private Cloud` root; eight
  domain folders; 17 localized state, diagram, alert, event, and performance views; and a native
  SCOM Distributed Application diagram targeted at the private-cloud Service class. Every view is
  placed and localized, all targets resolve against the v2 Library, and optional capability views
  remain outside core. The complete core build now emits Library, Discovery, Monitoring, and
  Presentation with a zero-pending receipt. Focused Pester passes 24/24. Presentation passes OM2022
  VSAE verification, transient test sealing, and `sn.exe -vf`; scratch evidence is under
  `D:/tmp/hcs-hyperv-v2-presentation-*` and is not release-signed output.

- **V2 core Monitoring authored:** Added the third required artifact with 13 host monitors, nine
  agent-hosted per-VM runtime monitors, 14 DA dependency rollups, 12 performance rules, one
  diagnostic task, auto-resolving alerts, and operational knowledge for all 22 unit monitors.
  Host coverage includes VMMS, vmcompute, module/hypervisor availability, CPU, available memory,
  paging, expected VM states, checkpoints, Replica, vSwitch uplinks, VHD attachments, and pipeline
  health. VM coverage includes expected runtime, heartbeat, integration services, checkpoints,
  Replica, disks, networking, Dynamic Memory pressure, and pipeline health.
- **Stable identity plus executable health:** Added `VirtualMachineRuntime`, an agent-hosted
  projection related to the stable logical VM. Monitoring runs on the current host; discovery moves
  the runtime projection during migration while the logical VM/DA identity stays stable. Runtime
  membership also supplies Availability, Storage, and Network branch rollups.
- **Monitoring verification:** Initial VSAE verification caught a malformed VM target-property
  expression; corrected it. Library, Discovery, and Monitoring all pass OM2022 VSAE verification,
  ordered transient sealing, and `sn.exe -vf`. Focused v2 Pester passes 18/18. Scratch evidence is
  `D:/tmp/hcs-hyperv-v2-sdk-monitoring-20260828/`; it is not release-signed output.

- **V2 core Discovery authored:** Added the second required artifact with a VMMS registry seed and
  staged topology workflow for stable standalone/cluster boundaries, hosts, VMs, VHDs, VM vNICs,
  virtual switches, Replica relationships, the monitoring pipeline, and all seven DA branches.
  The discovery source is injected from a separately testable script template. Missing Hyper-V,
  Failover Clustering, and related commands use non-throwing capability probes; optional Cluster/
  CSV, Network ATC, Pure, S2D, SDN, and VMM objects remain outside core.
- **SCOM authoring defect caught and fixed:** Initial VSAE verification rejected dynamic
  `$MPElement` expressions used by the component loop. Replaced them with literal, compile-time
  resolvable class and relationship expressions. This is why Microsoft verification remains a
  required gate beyond well-formed XML.
- **Discovery verification:** V2 focused Pester passes 12/12. The Library and Discovery both pass
  Microsoft VSAE/SDK verification against installed OM2022 dependencies, then transient test seal
  with token `14a10c8275285f00`; both resulting assemblies pass `sn.exe -vf`. Scratch evidence is
  under `D:/tmp/hcs-hyperv-v2-sdk-discovery-20260828/` and is not a release artifact.

- **V2 executable source started:** Added `src/hyper-v/scom-mp/v2/` with a deterministic PowerShell
  7 build, explicit authored/planned manifest states, an incomplete-build receipt, and the first
  authored v2 sealed-source artifact: `HybridSolutionsCloud.HyperVPrivateCloud.Library`. The build
  refuses `-RequireComplete` while required artifacts remain planned so this milestone cannot be
  mistaken for the public release.
- **Core model expanded:** The v2 Library now has 18 classes, 29 relationships, and generated display
  strings for every property/relationship. It defines stable boundary/host/VM identities, VHDs,
  VM vNICs, virtual switches, Replica relationships, pipeline health, and seven DA branches:
  Management, Compute, Virtual Machines, Availability, Storage, Networking, and Monitoring.
  Optional Cluster/CSV, Network ATC, Pure, S2D, SDN, and VMM objects remain outside core.
- **V2 verification:** Added seven focused Pester tests. Combined Hyper-V preview/v2 tests pass
  22/22 and `git diff --check` passes. ScriptAnalyzer initially found only a plural-noun warning;
  the function was renamed and ScriptAnalyzer now passes with no Warning/Error findings. VitePress
  production build passes from `docs/` with only the existing chunk-size warning. VSAE/SDK
  verification has not yet been run on the v2 Library.

- **V2 artifact graph fixed:** Added ADR 0043 and `contracts/packages.v2.json`. V2 source will live
  under `src/hyper-v/scom-mp/v2/` with four required sealed core MPs (Library, Discovery,
  Monitoring, Presentation), nine optional sealed capability MPs (Cluster, Storage, Pure, S2D,
  File Services, Network ATC, Physical Network, SDN, VMM), and optional Reporting. ADR 0043
  supersedes the preview's ADR 0027 only for v2.
- **Deployment and overrides:** Machine-readable profiles cover standalone, clustered SAN/Pure,
  clustered S2D, simultaneous Pure/S2D, SMB/SOFS, Network ATC, VMM, SDN, and a complete graph.
  Public Lab/Standard/Strict overrides will be generated per selected capability so absent optional
  products never become accidental import prerequisites.
- **Graph verification:** Pester now resolves every artifact dependency against either another HCS
  artifact or the external dependency contract, validates unique IDs, the four required artifacts,
  profile capability names, the simultaneous Pure/S2D profile, and tuning tiers. Hyper-V Pester
  passes 15/15; VitePress production build, JSON parse, edited links, and `git diff --check` pass.

- **SOFS and physical network ownership approved:** Added ADR 0042 after inspecting Microsoft File
  & iSCSI Services `10.1.0.4` and the OM2022 built-in network libraries. File Server, clustered SMB,
  iSCSI Target, network node/switch, interface/port, VLAN, connection, topology, health, and
  performance remain Microsoft-owned.
- **HCS gap boundary:** The SMB/SOFS adapter may add concrete SOFS share, Multichannel/RDMA path,
  share-to-VHDX/VM, coverage, and DA-impact concepts. Physical network integration consumes
  Microsoft's existing server-port correlation and adds private-cloud membership/rollup; it does
  not rediscover devices or handle SNMP secrets. Ambiguous/missing correlation is Unknown/Not
  Monitored, never guessed Healthy.
- **Machine contract:** `dependencies.v2.json` now records File & iSCSI MP IDs and supported
  Windows/SCOM 2016–2025 versions plus built-in network classes, `DeviceKey`/`Key` identities, and
  public topology relationships. VMM remains the only uninspected major external object contract;
  Microsoft couples those MPs to each VMM build and supplies them from the VMM installation.
- **Verification:** Hyper-V Pester passes 14/14, VitePress production build passes, dependency JSON
  parses, edited links resolve, and `git diff --check` passes; the existing large-chunk warning is
  unchanged.

- **Pure Storage contract approved:** Added ADR 0041 after inspecting Pure's current GitHub release,
  official release notes/guide, and sealed `PureStorageFlashArray` MP `2.0.120.0` (token
  `a9d994eedb5e7179`). The vendor lane explicitly supports SCOM 2016/2019/2022 and Purity 5.3+;
  SCOM 2025 is not claimed and remains a separate vendor-certification/native-provider gate.
- **Pure adapter boundary:** V2 reuses vendor arrays, controllers, hosts, host groups, ports,
  volumes, pods/replicas, leaf monitoring, and public Run As profile. HCS owns only read-only
  IQN/WWPN-to-host, presented-volume-to-Windows-disk/MPIO/CSV/VHDX/VM correlations, coverage
  freshness, DA membership, and service impact. It never acknowledges/closes vendor alerts or
  enables vendor-disabled high-cardinality volume workflows by default.
- **Pure evidence:** The inspected bundle contains 15 public classes, 10 public relationships, 12
  discoveries, 24 unit monitors, 36 rules, seven views, dashboard components, and one public Secure
  Reference. The contract JSON records exact keys, supported versions, MP identity, and token.
- **Verification:** Hyper-V Pester passes 14/14, VitePress production build passes, dependency JSON
  parses, edited local links resolve, and `git diff --check` passes. The existing VitePress
  large-chunk warning is unchanged.

- **S2D/SDN ownership corrected:** Added accepted ADR 0040, superseded ADR 0039 without erasing its
  history, and updated the v2 dependency contract, root plan, decision index, and VitePress sidebar.
  Microsoft S2D `1.0.47.4` and SDN `10.0.0.2` public objects are authoritative; optional HCS
  adapters may add only verified gaps, cross-domain correlations, coverage, and DA service impact.
- **Machine-readable contracts:** `dependencies.v2.json` now records exact package versions,
  acquisition URLs, MP IDs, public class IDs, and identity keys (`UniqueID` for Microsoft Storage,
  `Id` for SDN). Pester asserts both contracts to prevent ownership regression.
- **Verification:** Hyper-V Pester passes 14/14, the VitePress production build passes, dependency
  JSON parses, edited local links resolve, and `git diff --check` passes. The only build message is
  the existing VitePress large-chunk warning. Next dependency spikes are Pure Storage, VMM,
  SOFS/SMB, and physical networking.

- **Root v2 plan refreshed:** `PLAN.md` remains the authoritative repository-root implementation
  plan for Hyper-V Private Cloud Monitoring v2. It now labels Azure Local as under development,
  the Hyper-V `0.1` artifact as a superseded preview, and Hyper-V v2 as the active priority.
- **S2D/SDN correction captured in the plan:** Direct inspection established that Microsoft ships
  S2D MP `1.0.47.4` and SDN MP `10.0.0.2`. The plan now requires reuse of their public objects and
  limits HCS ownership to verified gaps, correlations, coverage, and private-cloud service impact.
  ADR 0039 and the dependency contract still require a successor correction before implementation.
- **Plan validation:** `git diff --check` passed; only `PLAN.md` and this handoff changed in this
  update. Branch remains `main`.

- **V2 dependency decision accepted:** Added ADR 0039 and the public v2 dependency/ownership
  contract. The product console identity is `Hyper-V Private Cloud Monitoring`, console root is
  `Hyper-V Private Cloud`, and the new namespace is
  `HybridSolutionsCloud.HyperVPrivateCloud`. Standalone core remains independent; optional
  capability adapters own external prerequisites and relationships.
- **Microsoft contracts inspected:** Downloaded the official current Microsoft Windows Server
  Cluster `10.1.0.0` and Windows Server OS/CSV `10.1.2.2` packages from Microsoft, extracted and
  exported their sealed MPs, and inventoried public classes/relationships. The Cluster package
  exposes cluster nodes, groups, networks, resources, and containment. The Windows Server package
  exposes public CSV and cluster-disk objects plus discovery/monitoring. V2 will reuse these
  identities rather than create duplicate cluster/CSV objects.
- **Machine-readable dependency gate:** Added
  `src/hyper-v/scom-mp/contracts/dependencies.v2.json` with approved Cluster/CSV versions,
  authoritative class IDs, and explicit pending spikes for Pure, VMM, SDN, SOFS, and physical
  networking. Pester now enforces the product identity and approved Microsoft contracts.
- **Latest verification:** Hyper-V Pester passes 14/14, VitePress production build passes, new
  local Markdown links resolve, dependency JSON parses, and `git diff --check` passes. The VitePress
  build reports only the existing large-chunk warning.

- **Generated override examples and semantic CI gate:** Added
  `Update-HyperVOverrideExamples.ps1`, regenerated all six Hyper-V Lab/Standard/Strict example
  XML files from the supported generator, and documented that the examples are generated
  artifacts. The updater's `-Check` mode performs an ordinal byte comparison and is invoked by
  the Hyper-V Pester suite, so hand edits or generator drift fail CI.
- **Offline override contract validation:** Added tests that build version `0.2.0.0`, generate
  every profile, and resolve each referenced context class, discovery, monitor, module, and
  configuration parameter against the built sealed-product XML. The tests also require every
  declared reference alias to be used.
- **Latest verification:** Hyper-V Pester passes 13/13; the Hyper-V product contract suite and
  generated-example drift check pass; PSScriptAnalyzer reports zero warnings/errors for both
  override tools; `git diff --check` passes. These changes are ready for commit and push.

- **Hyper-V v2 plan:** Updated root `PLAN.md` to make Hyper-V Private Cloud Monitoring v2 the
  active priority and Azure Local explicitly under development. The `0.1` Hyper-V preview is now
  classified as a superseded host-centric baseline rather than a complete private-cloud product.
  Added the clean-sheet modular package architecture, authoritative Microsoft/vendor dependency
  policy, complete compute/cluster/S2D/SAN/Pure/SMB/network/ATC/SDN/VMM catalog, DA and console
  redesign, research spikes, implementation sequence, override remediation, compatibility path,
  lab matrix, release gates, and definition of done. No source code or release assets changed.
- **Validation:** `git diff --check` passed. Branch remains `main`; `PLAN.md` and this handoff are
  modified and uncommitted.
- **Override remediation begun:** Hyper-V override generation now separates the unsealed override
  MP identity (`-Version`, default `1.0.0.0`) from mandatory sealed references
  (`-ProductVersion`). Profile schema `1.2` carries explicit monitor IDs and context classes and
  rejects unknown schemas. Updated all three Hyper-V profiles, operator examples, design guidance,
  contract invocation, and Pester assertions. Hyper-V Pester passes 11/11 and the product contract
  suite passes. The equivalent Azure Local remediation remains deferred while that product is
  explicitly under development.
- **Cluster dependency evidence:** The installed sealed SCOM 2022
  `Microsoft.Windows.Cluster.Library` is version `7.0.8447.6` and exposes public Cluster, Cluster
  Service, and Virtual Server model classes, but no public CSV class. V2 can reuse Microsoft
  cluster identity while retaining HCS-owned CSV/S2D/SAN classes with explicit correlations.

- **SCOM lab preview published:** Published GitHub prerelease
  `scom-lab-preview-v0.1.0` with separate Azure Local and Hyper-V ZIPs. Each ZIP contains the five
  sealed version `0.1.0.0` MPs, a lab-only notice, import order, and per-file SHA-256 checksums. A
  top-level checksum file covers both ZIPs. No signing key or secret-like file is present.
- **Public downloads:** Added `docs/downloads/scom-lab-preview.md`, a home-page download action,
  both product-page links, administration-guide links, and navigation entries. GitHub Pages run
  `33202030487` completed successfully. The public page and all three release assets returned HTTP
  200 after deployment.
- **Publication validation:** Rebuilt all ten source XML artifacts with the preview public token;
  every SHA-256 hash matched the XML used for transient sealing. Both five-project suites passed
  Microsoft VSAE/SDK verification against OM2022, all ten sealed assemblies passed strong-name
  verification, both product contract suites passed, Pester passed 15/15, PSScriptAnalyzer passed
  for eight scripts, VitePress built, gitleaks found no leaks, package/checksum checks passed, and
  `git diff --check` passed.
- **Release status boundary:** This is deliberately a GitHub prerelease for isolated or approved
  pre-production labs. Public key token `14a10c8275285f00` is transient. The artifacts are not
  governed-release-signed, representative-lab-certified, or production-supported; customer
  overrides created against the preview identity may need rebuilding for the permanent release.
- **Missing-pipeline root cause:** Generated `out/` directories are intentionally ignored. The
  planning ADR proposed `mp-build.yml` and release asset publication, but that workflow was never
  implemented. Release Please was archived during the July Azure DevOps/VitePress migration, and
  the active GitHub/Azure DevOps workflows validate source/deploy docs without sealing or
  publishing MPs. The August test sealing therefore stopped in `D:/tmp/` until this prerelease.
- **Published commit/release:** Download documentation commit `ef9b36a`; prerelease and assets at
  `https://github.com/Hybrid-Solutions-Cloud/hybrid-health-monitoring/releases/tag/scom-lab-preview-v0.1.0`.
- **2026-08-28 artifact audit:** Confirmed that the repository tracks complete source templates,
  manifests, build tools, validators, and override examples for independent Azure Local and
  Hyper-V SCOM products. Git tracks no sealed `.mp` or `.mpb` artifacts now, and
  `git rev-list --objects --all` found no such artifact anywhere in repository history.
- **Repository-local output:** Ignored `src/azure-local/scom-mp/out/development/` and
  `src/hyper-v/scom-mp/out/development/` directories remain on this workstation. Each contains
  four unsealed development XML outputs plus an inventory; optional Reporting is absent because
  the default development build excludes it. The inventories explicitly mark the outputs
  `releaseReady: false`, `sealed: false`, `signed: false`, and `labImported: false`.
- **Transient sealed artifacts found:** The five Azure Local and five Hyper-V version `0.1.0.0`
  test-sealed `.mp` files remain outside the repository under
  `D:/tmp/hcs-scom-seal-92cb5ef4f7374e9299ece6638c3cef63/{azure-local,hyper-v}/`.
  All ten expose public key token `14a10c8275285f00`; an independent `sn.exe -vf` audit returned
  exit code 0 and `Assembly ... is valid` for every file. These are transient development/test
  artifacts, not governed-release-signed, published, or lab-certified deliverables.
- **Audit conclusion:** The previous completion claim is accurate only for authored development
  source plus OM2022 verification/test sealing. It is not accurate if interpreted to mean that
  release Management Packs were committed or published. A governed release still needs a durable
  artifact location, release signing, and representative SCOM lab certification.
- **Public-site reconciliation:** Updated the landing/status pages, both SCOM product and design
  lanes, validation pages, roadmap, administration guides, source READMEs, current ADR notes, and
  the Azure Local package diagram to record completed OM2022 VSAE verification and transient test
  sealing. Standalone MPVerify is no longer represented as an additional release gate.
- **ServiceNow clarification:** Audited the existing integration source and public docs. ServiceNow
  supplies the SCOM Events connector; the repository already supplies separate Azure Local and
  Hyper-V profiles, the normalized AlertId mapping/lifecycle contract, offline validation, ADR, and
  operator guidance. No custom connector or automated ServiceNow mutation exists or is needed for
  the first lab. Live Windows MID Server configuration and certification remain next; Azure Monitor
  Secure Webhook/common-alert-schema artifacts remain future implementation.
- **Microsoft verification unlocked:** Located the installed VSAE 1.10.571.0 OM2022 dependency
  set and Visual Studio 2022 full-framework MSBuild. Replaced both PowerShell 7 in-process SDK
  loaders with a shared VSAE `VerifyMergedManagementPack` MSBuild project and product wrappers.
- **Verified defect fixed:** Microsoft verification proved that
  `Microsoft.SystemCenter.ServiceDesigner.Component` does not exist in the OM2022 Service Designer
  library. Changed all five Hyper-V and six Azure Local DA component classes to the verified
  `Microsoft.SystemCenter.ServiceDesigner.ServiceComponentGroup` base and added regression checks.
- **SDK and test-seal result:** The complete Hyper-V and Azure Local suites—Library, Discovery,
  Monitoring, Presentation, and optional Reporting—pass Microsoft VSAE/SDK verification against
  the installed OM2022 sealed dependencies. Both five-MP chains then test-sealed successfully in
  dependency order with a transient development key stored only under `D:/tmp/`.
- **Additional verified fixes:** Renamed discovery-script `$data` and helper `$Target` variables so
  they cannot collide with SCOM expression namespaces, split malformed MAML into sibling sections,
  and made all three-state monitor health mappings unique. Added regression assertions.
- **Sealing runtime:** VSAE `FASTSEAL.exe` targets CLR v2.0.50727. `NET-Framework-Core` initially
  reported `Removed`, then completed installation through Server Manager and now reports
  `Installed`. **No restart was performed, and the operator explicitly prohibited restarting this
  server.**
- **Latest validation:** Both complete five-MP VSAE/SDK wrappers passed; all ten transient artifacts
  test-sealed and passed strong-name verification; Pester 15/15; PSScriptAnalyzer zero warnings or
  errors; VitePress production build and `git diff --check` passed; public ADO identifier scan
  returned zero matches. VitePress emitted only its existing large-chunk warning.
- **Outcome:** Implemented the Azure Local SCOM development baseline, both independent Azure
  Monitor Health Model baselines, and the optional SCOM-to-ServiceNow development contract. Updated
  research, ADRs, architecture, operator guidance, navigation, roadmap, source READMEs, changelog,
  and private delivery tracking.
- **Azure Local SCOM:** Added five package sources (Library, Discovery, Monitoring, Presentation,
  optional Reporting), 17 classes, 28 relationships, staged local topology discovery, a
  platform-owned Distributed Application with six health components, 14 unit monitors, six
  aggregate monitors, 12 dependency rollups, 11 curated monitor alerts, 12 performance rules, four
  event rules, a diagnostic task, operational knowledge, and 14 views.
- **Overrides:** Added separate customer-owned Discovery and Monitoring override generators plus
  Lab, Standard, and Strict starter profiles. The Default Management Pack remains prohibited.
- **Azure Local Azure Monitor:** Added an independent monitor account/Health Model Bicep baseline,
  deployment and six domain entities, separate compute/storage Azure-resource entities, documented
  Azure Local CPU and storage-degraded signals, deployment state alerts, KQL research queries, and
  a workbook. Unproven domains remain Unknown.
- **Hyper-V Azure Monitor:** Accepted the constrained go decision and added an independent Bicep
  baseline. Arc-enabled SCVMM supplies inventory; Arc-enabled Server plus AMA/DCR supplies host
  heartbeat, hypervisor CPU, cluster-event, and telemetry-coverage signals. Explicit DCR
  associations and complete fabric parity remain lab work.
- **ServiceNow:** Accepted the connector-boundary ADR and added separate Azure Local and Hyper-V
  connector profiles, a normalized AlertId-based mapping, an offline compatibility validator, and
  public setup/lifecycle/security guidance. Live MID Server and ServiceNow validation remains.
- **Architecture:** Accepted ADRs 0032–0038 and promoted ADR 0023 to the constrained Hyper-V Azure
  Monitor implementation decision. Added four Azure Local SCOM draw.io diagrams with public SVG
  exports and repaired three previously committed draw.io files that had obsolete stub XML appended.
- **Private tracking:** Updated all existing Azure Local and Hyper-V SCOM/Azure Monitor delivery
  items with exact baseline and remaining-gate status. Added a separate integrations Epic, a
  SCOM-to-ServiceNow Feature, and research, architecture, implementation, and lab-validation
  Stories. No internal identifiers or board links appear in public repository content.
- **Validation passed:** Azure Local and Hyper-V MP contracts; Azure Local and Hyper-V Azure Monitor
  Bicep/contract checks; SCOM-to-ServiceNow contract; Pester 15/15; product PSScriptAnalyzer zero
  warnings/errors; gitleaks zero findings; 20 JSON files parsed; seven draw.io files parsed; local
  Markdown links passed; changed-file structural Markdown lint passed; VitePress production build;
  `git diff --check`; public work-item scan zero. VitePress reports only its existing large-chunk
  warning.
- **Governance:** Registry resolves this as the HCS `docs` profile. The governance server could not
  inspect the Windows path for drift and its optional markdown/link binaries are not installed;
  equivalent local checks were run directly.
- **Release gates:** Both complete suites are SDK dependency-resolved and transiently test-sealed
  against OM2022, but no test output is a public release artifact. Governed release signing and
  SCOM-lab certification remain; standalone MPVerify is not a separate gate.
  Neither Azure Monitor baseline has been deployed to a representative subscription. ServiceNow
  MID Server behavior and the supported SCOM version pair are not lab-certified.
- **Branch:** `main`.
- **Latest documentation validation:** VitePress production build passed, the ServiceNow contract
  validator passed, Pester passed 15/15, PSScriptAnalyzer returned zero warnings/errors, edited
  draw.io/SVG XML parsed, gitleaks reported zero findings, the public work-item identifier scan
  returned zero matches, and `git diff --check` passed. Governance MCP could not access the local
  Windows path; its optional markdownlint/lychee executables are also not installed server-side.
- **Next action:** Do not restart this server. Import the transiently test-sealed products into the
  operator-provided SCOM labs in dependency order and execute the documented SCOM and ServiceNow
  matrices. Establish the governed release-signing identity only after the lab evidence is
  approved. Azure Monitor live deployment remains a separate lab workstream.

## Last session

- **Outcome:** Authored the functional Hyper-V SCOM development baseline and reconciled public
  design, roadmap, product, catalog, administration, ADR, source README, changelog, and AI state.
- **Library:** 13 localized public classes, 70 localized properties, and 20 localized relationships.
  The model has a stable cluster-or-host boundary, non-hosted mobile VM identity, hosted host-local
  objects, a Service Designer DA root, and five component classes.
- **Discovery and DA:** Added registry role seed plus staged PowerShell topology discovery for
  Hyper-V, Failover Clustering, CSV, virtual switches, Network ATC, Replica facts, monitoring
  pipeline, DA roots/components, and 20 membership/reference relationships.
- **Monitoring:** Added one shared cookdown data source, nine three-state host monitors, auto-resolve
  alerts, 10 DA dependency rollups, 12 performance rules, four Failover Clustering event-alert
  rules, 13 operational-knowledge articles, and one read-only diagnostic task. Five
  high-cardinality/topology-sensitive performance rules are disabled by default.
- **Presentation:** Added four folders and 10 localized service-health, inventory, alert,
  performance, and event views. DA roots derive from the Service Designer service class and roll up
  through Compute, Virtual Machines, Storage, Network, and Monitoring Pipeline components.
- **Overrides:** Added generator-backed Lab, Standard, and Strict profiles. Each invocation creates
  separate unsealed, customer-owned Discovery and Monitoring override MPs. The Default Management
  Pack remains prohibited.
- **Build and validation:** Added deterministic element localization, structural product contracts,
  and a Microsoft SDK verification command that requires official target-version dependency MPs
  and fails on missing dependencies or verification errors.
- **Architecture:** Accepted ADRs 0027–0029 and 0031. Release-specific dependency versions,
  test/release sealing, signing identity, and lab certification remain release gates, not unbuilt
  source work.
- **Private tracking:** Updated the architecture, classes/discovery, monitoring/overrides, DA
  membership, DA rollup, and release-validation items with exact status and remaining gates. No
  internal work-item identifiers or links appear in public repository content.
- **Validation passed:** Hyper-V MP contract suite; Pester 8/8; PSScriptAnalyzer zero
  warnings/errors; VitePress production build; changed-file Markdown lint with VitePress-compatible
  line/H1 exclusions; `git diff --check`; public work-item scan zero; high-confidence secret scan
  zero. The VitePress build reports only its existing large-chunk warning.
- **External gate:** The Microsoft SDK assembly is installed, but official sealed System, Windows,
  Service Designer, Health, Performance, System Center, and Data Warehouse dependency MPs are not
  locally available. Full SDK verification therefore cannot truthfully pass yet. Test sealing,
  representative standalone/cluster SCOM lab import, topology lifecycle, fault/recovery,
  maintenance, failover, scale, upgrade/removal, release sealing/signing, and optional Reporting,
  SLO, and SquaredUp certification remain.
- **Branch:** `main`.
- **Next action:** Export the official dependency MPs from each target SCOM management group, run
  `Test-HyperVManagementPacksWithSdk.ps1`, correct any verified schema/dependency findings, then
  test-seal and execute the documented standalone and cluster lab matrix.
