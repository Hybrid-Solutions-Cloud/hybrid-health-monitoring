# Current task

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
