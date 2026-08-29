# Current task

<!-- What is being worked on right now. Keep it short; update as work moves. -->

_Implement and publish Hyper-V Private Cloud Monitoring v2 as the active priority. Four core and
nine optional capability MPs are authored and offline verified. The capability-aware override
system is also authored: 11 deployment profiles, three tiers, 66 generated Discovery/Monitoring
examples, explicit schema, same-MP groups, semantic/drift/cookdown tests, and a VSAE-verified
Standard pair. Every first-party workflow now uses public SCOM command executors to launch the
PowerShell 7 MSI path explicitly. Governed release tooling now verifies/seals all 13 MPs through
Microsoft VSAE, handles official Microsoft/Pure `.mpb` dependencies with publisher provenance,
generates 66 overrides and 14 stable bundles, and passes the 125-test offline suite. A read-only
management-group collector is ready to capture exact imported identities, topology, workflows,
views, and recent HealthService diagnostic results. The active
release blocker is representative HealthService runtime and capability-module proof, followed by
lifecycle labs and provisioning the documented protected runner/OIDC/permanent-signing environment.
The production workflow is authored to publish GitHub assets and verify stable latest-download
URLs once those gates produce an approved evidence receipt._

<!--
  Optional advisory model hint the next tool should honour if available.
  Never overrides an explicit per-session model flag the operator has set.
  Example: suggested-model: opus
-->
<!-- suggested-model:  -->
