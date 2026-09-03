# Current task

## Active correction — 2026-09-02 Hyper-V Private Cloud 1.0.3.0

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
