# Prompt for the sealing-machine AI

You are on the machine with the approved SCOM Management Pack signing key and Microsoft VSAE
authoring tools. Finish sealing and packaging the Hyper-V Private Cloud Monitoring 1.3.5.0
candidate and update its documentation accurately.

Repository: `https://github.com/Hybrid-Solutions-Cloud/hybrid-health-monitoring`.
Read `AGENTS.md`, bootstrap the governance MCP, then read `.ai/state/CURRENT_TASK.md`,
`.ai/state/HANDOFF.md`, `.ai/state/RELEASE_READINESS.md` and the durable memory files. Pull the
latest `main` without overwriting local work. Require the source commit's GitHub Actions checks
to be green. The relevant changes are the agentless runtime/release-candidate fixes; do not seal
the older 1.3.4.0 source. Record the exact source SHA you build.

## Non-negotiable boundaries

- Do not install SCOM agents inside workload VMs. Monitoring runs from infrastructure hosts.
- PowerShell 7 is required where supported. Use Windows PowerShell for SCOM, Cluster or VMM
  components that require that supported runtime; do not invent a PS7-only blocker.
- Use the existing approved permanent signing identity. Its public key token is
  `54d0fb1159995c86`. Never generate a replacement key or expose/commit the private key, credentials
  or tokens. Obtain secrets only through the governed mechanism and keep the key outside the repo.
- Never overwrite an already published version with different bytes. Check whether 1.3.5.0 has
  since been published before proceeding; if occupied, choose the next unused version consistently.
- Do not weaken verification, skip VSAE in Release mode, disable tests, reset health, remove
  customer overrides, or fabricate runtime-certification receipts to obtain a green result.

## Work to complete

1. Inspect the actual release scripts and workflow before running them:
   `src/hyper-v/scom-mp/tools/New-HyperVPrivateCloudReleasePackage.ps1`,
   `src/hyper-v/scom-mp/tools/Test-HyperVPrivateCloudReleasePackage.ps1`,
   `tools/scom/SealManagementPack.proj`, and `.github/workflows/release-hyper-v.yml`.
   Locate the approved signing key and sealed Microsoft/vendor dependencies using the environment
   and governance configuration. Validate prerequisites rather than asking for information that
   is already available on the machine.
2. Review/update release notes and source-level documentation, run the full unit suite and docs
   build, and commit reviewed source before the release build. Release tooling requires a clean
   committed checkout. Keep generated outputs outside tracked source.
3. Build with all release verification enabled, using real approved external paths:

   ```powershell
   ./src/hyper-v/scom-mp/tools/New-HyperVPrivateCloudReleasePackage.ps1 `
       -Version 1.3.5.0 -OverrideVersion 1.3.5.0 `
       -SigningKeyPath '<approved external key path>' `
       -DependencyPath '<approved sealed dependency directory>' `
       -OutputPath '<new empty release directory>' `
       -BuildMode Release -ApprovedReleaseSigningIdentity
   ```

   Confirm all 13 product MPs have the correct version and permanent token, pass VSAE and
   strong-name verification, and contain the corrected source. Run the package validator with
   `-RequireReleaseEligible` using its actual parameter contract. Preserve exact validated bytes;
   do not rebuild or repackage them after producing hashes and then publish mismatching assets.
4. Update the release notes, relevant Hyper-V documentation, upgrade/troubleshooting guidance,
   and download/version/checksum references. Inspect current site structure to locate the real
   pages. Do not claim unpublished assets are downloadable or edit historical immutable assets.
   Publish assets only when authorized, through the governed release process. Keep the distinction
   between a verified sealed package and runtime release certification explicit.
5. Commit and push the documentation changes. Monitor the complete GitHub Actions run through
   successful MP tests, documentation build and Pages deployment. Fix actual failures and repeat
   until the checks for the final pushed commit are green; do not merely report a queued run.
6. Return the source SHA, docs SHA, version, signing public token, package paths/asset URLs,
   SHA-256 manifest, verification results and green Actions links. Update the session handoff.
   Provide the sealed artifacts for import and post-upgrade verification on the jump server.

## Evidence and documentation content

The jump-server run passed 241 tests with zero failures/skips; all 13 candidate XML files passed
schema validation; VitePress built successfully. Live tests used a disposable VM without a guest
SCOM agent and proved availability fault/recovery, network warning/recovery and DA rollup,
successful live migration, stable VM/NIC identity, host-runtime replacement, destination monitor
initialization and discovery cleanup. The VM and private switches were removed; normal inventory
returned to 38 VMs and 38 runtimes. Raw receipts and the private transfer ZIP are on the jump server,
not in Git; do not assume ignored `tmp/` or `out/` files arrived with a clone, and do not publish
private lab evidence. The committed readiness report records the findings.

Document these fixes: empty singleton discovery submissions rejected topology; diagnostic task
output was discarded; migration-start event 20413 was misclassified as failure; local cluster
queries and empty-event/no-CSV handling needed correction; VMM TotalMemory bytes and AvailableMemory
MiB were mixed; empty network-map dictionaries caused unused NICs to be mistaken for uplinks.
Corrected Cluster source passed through HealthService on all four Hyper-V nodes and a non-CSV
management cluster. Corrected VMM source passed under SCOM Run As while retaining genuine
cloud-quota and missing-network-site warnings.

Do not claim positive validation for absent Pure arrays, SDN controllers, iSCSI/SAN or SMB-backed
VM disks. Network ATC's PS7 check was incomplete, not proof of absence; any further ATC assessment
must use its supported runtime. Do not misrepresent the blank test VM's missing guest heartbeat
as a successful guest-OS health test.

The jump server still runs sealed 1.3.4.0 plus `Hcs.HyperVPrivateCloud.Topology.Hotfix`. Do not remove
that hotfix until the upgraded permanent discovery successfully rediscovers every host; then
remove only that hotfix and confirm topology persists. Exact sealed-upgrade behavior, customer
override preservation, applicable capability coverage and the planned 24-hour soak remain runtime
acceptance work. A verified signature, a green workflow, or the earlier source-side tests do not
replace those checks. A residual 4 MiB blank test disk/empty folders remains on the jump-server
environment because deletion was rejected; see HANDOFF.md for the exact path, and do not bypass
execution policy.
