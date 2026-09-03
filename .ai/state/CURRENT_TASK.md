# Current task

## Completed — Full Production Suite & Documentation Published (Release 1.0.6.0)

- All 13 sealed product Management Packs, 2 canonical solution override templates, and full suite compiled and sealed with permanent signing token `54d0fb1159995c86`.
- 100% test pass rate across all test suites: 175/175 Pester unit & smoke tests, 8/8 prerequisite doc sync tests.
- Complete documentation overhaul: separated Hyper-V and Azure Local health models, updated Start Here guide, removed ADR references from operator docs, cleaned navigation sidebars, and exhaustively documented all classes, monitors, rollups, thresholds, and tasks.
- Interactive full-screen zoom and pan diagram overlay implemented for all Mermaid diagrams and architecture SVG imagery.
- VitePress documentation compiled cleanly with 0 broken links and 0 errors (`npm run docs:build`).
- All commits pushed to `origin/main` (`main -> main`). Git working tree completely clean.

## Completed — Management Domain Health, DNS, PXE/WDS, and Operator Hub Diagnostics

- Management domain infrastructure added to Distributed Application:
  - `ActiveDirectoryService`, `DnsService`, and `DeploymentService` added to `HyperVPrivateCloud.Library`.
  - Topology discovery in `Discover-HyperVPrivateCloudTopology.ps1.template` maps these services under `ManagementComponent`.
  - Probes in `Get-HyperVPrivateCloudHostHealth.ps1.template` monitor AD secure channel, DNS resolution, and WDS.
  - Unit monitors and rollups configured in `Build-HyperVPrivateCloudManagementPacks.ps1`.
  - Dedicated `Management Infrastructure` folder and 3 State Views added to `HyperVPrivateCloud.Presentation`.
- Central Operations Hub & Deep Troubleshooting Operator Tasks:
  - Host tasks: `TestDomainHealth`, `TestDnsResolution`, `TestPortConnectivity`, `TestPxeWdsHealth`.
  - Physical network tasks: `GetLldpNeighbor` (ToR port/chassis discovery) and `PfcEtsCounters` (PFC/ETS/RDMA pause/drop analysis).
  - All tasks accompanied by complete DisplayStrings, Descriptions, and MAML Knowledge Articles.
- Fully verified with 100% test pass rate across build (87/87) and probe smoke/override/docs (71/71).

## Completed — 2-Pack Override Architecture and Elimination of 66 Legacy Packs

- Removed 66 legacy override management packs across 11 deployment profiles and 3 tiers.
- Delivered the clean 2-pack override architecture:
  - `HyperVPrivateCloud.Discovery.Overrides`: Governs discovery frequencies and scopes.
  - `HyperVPrivateCloud.Monitoring.Overrides`: Governs monitoring thresholds, rules, and alerts.
- Updated generator tools, release packaging, installation scripts, documentation, and unit tests.
- All unit test suites passed 100% (Build: 87/87, Overrides: 9/9, Release: 11/11, Integration: 5/5).
- VitePress documentation built clean in 45s with 0 broken links and 0 errors.

## Roadmap: Optional Capability Packs (Fortinet & Dell OME)

- Architecture for optional capabilities:
  - `HyperVPrivateCloud.Capability.Fortinet`: Standalone pack for Fortinet firewall gateway and DHCP monitoring; correlates into `NetworkComponent` when deployed, zero dependency on core when absent.
  - `HyperVPrivateCloud.Capability.DellOME`: Standalone pack integrating Dell OpenManage Enterprise MP health into `ComputeComponent`.

## Active correction — 2026-09-03 Hyper-V Private Cloud 1.0.6.0

- Live SCOM 2025 validation of `1.0.3.0` proved HostRole seed recovery but showed all PowerShell
  discovery/property-bag workflows rejected by CommandExecuter's stdout event-policy regex.
  Canonical providers now leave stdout validation to the typed SCOM parser, classify stderr and
  nonzero exits, and contain neither the empty `EventPolicy` nor the `\a+` sentinel.
- File Services preserves singleton required-share output as an array. CSV health detects local
  Failover Cluster membership when the staged HostRole BoundaryId is empty and emits detailed
  events 8702/8304 with reproduction and remediation guidance.
- The generated deployment ZIP now contains exactly 12 non-PureStorage solution MPs, including
  SDN, Storage, File Services, and Network ATC; no overrides. Independent validation hashes every
  embedded MP against the sealed release asset.
- Source commit `4ebcaec`; unit tests `206/206`; workflow smoke `63/63`; VitePress build passes.
  Production sealing and independent validation pass for 13 product MPs and 66 starter MPs at
  `1.0.6.0`, token `54d0fb1159995c86`. Deployment ZIP SHA-256 is
  `3097fcb08273591233c0bcf74f214616529b4e51ba27cc49a2484d38138d47a2`.
- Next: commit the exact immutable/latest assets, push and merge, wait for Pages, and verify the
  public 12-pack download. Then import all 12 packs together and run the stated 16/0 acceptance
  after one four-hour seed plus one 30-minute topology cycle.

## Active correction — 2026-09-03 Hyper-V Private Cloud 1.0.5.0

- `1.0.4.0` already existed in the operator management group, so the console/view correction is
  being republished as the required version-increased upgrade `1.0.5.0`; sealed MP bytes are never
  replaced under an existing version.
- All 13 sealed product MPs and all 66 generated public starter MPs now carry `1.0.5.0`. Release
  mode and the independent publication validator both fail if product and public override versions
  differ. The HAAS-SDR deployment ZIP still contains exactly eight sealed product MPs and no
  overrides; existing customer-owned overrides remain untouched.
- Production `1.0.5.0` passed VSAE sealing and independent validation with token
  `54d0fb1159995c86`. The eight-pack is 317587 bytes with SHA-256
  `5b6d10a265e06039c5ae61fa54538069f6d2f03ccc49036cbc6c027a9821af43`.

- Operator console QA found seven capability MPs without pack-level display strings; three are in
  the HAAS-SDR eight-pack deployment (S2D, VMM, and PhysicalNetwork). The generator now supplies
  friendly names for every capability MP, and a comprehensive display-string regression gate
  covers all packs and user-facing elements.
- The empty lowercase `Failover clusters` view targeting the HCS ClusterRole projection was removed
  from Availability. The working `Failover Clusters` view targeting Microsoft's authoritative
  cluster class remains.
- Focused build tests pass `86/86`; the repository unit suite passed `205/205` before the duplicate
  view removal, and the affected build suite was rerun successfully afterward.
- PR #19 merged as `5bd476e`; the subsequent same-version `1.0.4.0` publication is superseded by
  this version-increased `1.0.5.0` correction.
- Next: complete the `1.0.5.0` publication PR, deploy the site, and verify the live
  homepage/download/manifest.
  Then import all eight packs over the installed version and run the acceptance validator after
  the required discovery cycles. Do not change the 523 overrides, proxy settings, capability
  scope, or intervals.

## Prior correction — 2026-09-02 Hyper-V Private Cloud 1.0.3.0

- Live SCOM 2025 certification of `1.0.2.0` found two independent discovery blockers. The
  `HostRole` registry seed omitted its required non-key `BoundaryId`, so every seed instance was
  invalid. S2D and VMM host-relationship scripts returned valid discovery XML but did not
  explicitly normalize their successful child-process exit status.
- Canonical source now allows `BoundaryId` to be populated by staged topology and explicitly exits
  zero after the two relationship scripts submit discovery data. The runtime smoke contract now
  requires submitted data to have exit code zero and empty stderr.
- Validation: core build `85/85`; targeted S2D/VMM termination smoke `9/9`; other unit files
  `140/141` initially, with the sole generated dependency-doc drift corrected and rechecked `8/8`;
  VSAE test seal produced 13 MPs, 66 override MPs, and 14 bundles; independent package validation
  passed.
- Production package `D:/tmp/hcs-hyperv-release-1.0.3.0` is independently validated as
  `releaseEligible=true` with permanent token `54d0fb1159995c86`; the exact eight-pack deployment
  ZIP is `D:/tmp/Hyper-V-Private-Cloud-Monitoring-Deployment-1.0.3.0.zip`.
- The same validated 30 release assets are published byte-for-byte under
  `docs/public/downloads/hyper-v-private-cloud/1.0.3.0/` and `latest/`; public download and operator
  documentation identifies `1.0.3.0` as current, and the VitePress production build passes.
- Next: import the eight-pack deployment into the live management group, allow one four-hour seed
  plus one 30-minute topology cycle, and require `Test-SdrHyperVPrivateCloudMonitoring.ps1` to
  report `16/0`, 4 HostRole, and 2 ClusterRole.

## Active release — 2026-09-01 Hyper-V Private Cloud 1.0.2.0 production seal

- Corrected the PowerShell 7 release packager to reuse an exact loaded SCOM SDK assembly identity,
  inspect multiple MPB files without duplicate loads, and extract gzip-compressed UTF-8/UTF-16
  loose-MP resources without invoking the failing SDK sealed-pack constructor.
- A complete test-mode package passed Microsoft VSAE verification and sealing for all 13 product
  MPs, strong-name checks, 66 override generation, 14 bundle generation, and the independent
  package validator. Release tests pass 11/11 and PSScriptAnalyzer is clean.
- Next: merge the release-tool correction, produce the release-eligible package with the permanent
  Key Vault signing identity, publish the exact assets, import 1.0.2.0 into ProductLabs SCOM, and
  validate runtime recovery.

## Active correction — 2026-09-01 Hyper-V Private Cloud 1.0.2.0

- Live SCOM 2025 certification of `1.0.1.0` found two product defects: the shared command-executor
  stdout policy rejected multiline SCOM `DataItem` XML, and the S2D object-health helper returned
  `$null` for an empty query under strict mode.
- Canonical source now uses a multiline-safe, anchored DataItem policy and preserves empty and
  singleton S2D query results as arrays. The diagnostic-summary task also returns useful runtime
  evidence when the Hyper-V query path is unavailable instead of terminating without output.
- Regression coverage passes: core build 83/83, probe smoke 63/63, dependency docs 8/8, and the
  VitePress site builds. The earlier full run was 198 passed / 2 failed before both failing cases
  were corrected and independently re-run green.
- Next: commit and push the clean corrective source, seal and publish `1.0.2.0`, import it into the
  live SCOM management group, and verify workflow/resource health.

<!-- What is being worked on right now. Keep it short; update as work moves. -->

_Hyper-V Private Cloud Monitoring `1.0.0.0` is released and repository-published. Management Packs
are named for the product — the `HyperVPrivateCloud.*` namespace — with publisher attribution in the
sealed pack metadata rather than the pack ID (ADR 0049). The version line restarts at `1.0.0.0`
because that identity has no prior release; the superseded `2.0.0.0` assets are retained unchanged
as release evidence and are not for new deployments._

_The release contains 13 sealed MPs, 66 public override packs, and 14 deterministic bundles, sealed
with public token `54d0fb1159995c86`, VSAE-verified, strong-name checked, and validated as
`releaseEligible=true`. Because no runner carrying the `scom-mp-release` label is currently
registered, it was sealed on an authoring workstation rather than through the `release-hyper-v-v2`
workflow; registering that runner is outstanding so future releases follow the governed path._

_Prerequisite documentation is now generated from Management Pack source by
`tools/scom/Export-MpDependencies.ps1` and guarded against drift by a unit test, so the documented
external dependencies cannot diverge from the packs again._

_Remaining active work: operator post-installation SCOM runtime and lifecycle certification, a
version-increased correction for any verified defect, and re-registering the release runner._

<!--
  Optional advisory model hint the next tool should honour if available.
  Never overrides an explicit per-session model flag the operator has set.
  Example: suggested-model: opus
-->
<!-- suggested-model:  -->
