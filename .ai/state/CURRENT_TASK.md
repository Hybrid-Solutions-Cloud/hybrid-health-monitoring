# Current task

<!-- What is being worked on right now. Keep it short; update as work moves. -->

_Implement and publish Hyper-V Private Cloud Monitoring v2 as the active priority. Four core and
nine optional capability MPs are authored and offline verified. The capability-aware override
system is also authored: 11 deployment profiles, three tiers, 66 generated Discovery/Monitoring
examples, explicit schema, same-MP groups, semantic/drift/cookdown tests, and a VSAE-verified
Standard pair. Every first-party workflow now uses public SCOM command executors to launch the
PowerShell 7 MSI path explicitly; current source passes the complete offline suite and VSAE. The
active release blocker is representative HealthService runtime and capability-module proof,
followed by lifecycle labs, governed signing, packaging, publication, and stable latest-download
updates._

<!--
  Optional advisory model hint the next tool should honour if available.
  Never overrides an explicit per-session model flag the operator has set.
  Example: suggested-model: opus
-->
<!-- suggested-model:  -->
