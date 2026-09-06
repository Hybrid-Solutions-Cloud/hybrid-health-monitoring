# Current task

## September 6 — sealed 1.3.8.0 staged for publication

Clean release source `fd356e266dad446be1ba872bb9474a3f4764786d` produced all 13 sealed
MPs at 1.3.8.0 with permanent token `54d0fb1159995c86`. Release-mode VSAE/SDK, dependency,
strong-name, identity, package, checksum, sealed knowledge, and exact sealed health-graph checks
pass: 522/522 supported elements have knowledge and all 159 enabled unit monitors reach the root.
The temporary private key was deleted and confirmed absent. Stage the exact 31-file assets in new
immutable 1.3.8.0 and `latest`, then commit/push and verify CI and deployed bytes. Exact sealed
upgrade/import and runtime soak remain untested.

## September 6 — seal and publish day-2 release 1.3.8.0

Pulled clean `origin/main` from `8fbb62e` to `42c9e93`. The upstream source/fixture commits are
green in Actions run `34050218756` and define the unused candidate version 1.3.8.0. Release
documentation now targets 1.3.8.0 and preserves 1.3.7.0 as immutable history. The production docs
build passes; the fresh complete local suite passes 272/272, including all 13 schemas. Commit this
clean release source, then seal all 13 MPs with the permanent identity. Exact sealed 1.3.8.0
upgrade/import and runtime soak have not been run and must not be claimed as passed.

## Latest — day-2 support and 360-degree health review

Committed/pushed in `631bc9f` with a test-fixture-only CI correction in `3dbd44d`. GitHub Actions
run `34050218756` passed MP validation, documentation build and Pages deployment. Source is ready
for the separate sealing/release-validation step; installed sealed MPs remain at 1.3.7.0.

Source changes implemented for complete object/monitor support knowledge, Microsoft references,
traceable aspect-correct health rollups and named unhealthy-state evidence. Installed 1.3.7.0
remains untouched. Source work is complete: 239 full product tests, 107 supplemental tests,
13 latest support tests and 31 other unit tests passed with no failures; schemas, SDK source checks,
documentation build and safe live probes passed. See `DAY2_SUPPORT_VALIDATION.md` and the newest
HANDOFF entry. Existing live critical cluster-role incidents have been diagnosed
read-only; they have not been remediated or cleared. Sealing/import remains a later deployment gate.

## Latest — sealed 1.3.7.0 installed and tested

All 13 MPs imported after pulling main to 8fbb62e. Twenty-two positive live task/discovery
results pass, plus the intentional negative task test. Corrected VMM tasks each pass on both
VMM servers; inventory/customer overrides preserved, 42 pipeline monitors healthy. No previously
reported bug reproduced. See SEALED_1.3.7_VALIDATION.md and newest HANDOFF entry. Temporary
health-capture MP removed. A 24-hour soak remains outside this bounded acceptance check.


## September 6 — 1.3.7.0 published and green

Release asset commit `ec85690ef1d7fdf0768b6f17518c04b45558484b` is on `origin/main`.
GitHub Actions run `34010765042` passed MP validation, the VitePress build, and Pages deployment.
All 31 files downloaded from the live immutable 1.3.7.0 path match the signed build output byte for
byte, and all 30 catalogued checksums pass. Remote main is current. The remaining acceptance work is
the exact sealed 1.3.7.0 upgrade/import and runtime soak; neither is claimed as passed.

## September 6 — sealed 1.3.7.0 staged for publication

Release source commit `6ffdcffc972d8ffc048102ca92d34e50daabb55c` produced all 13 sealed
MPs at 1.3.7.0 with permanent token `54d0fb1159995c86`. Release-mode VSAE/SDK, approved-key,
external-dependency, strong-name, identity, sealed VMM correction, 15-bundle content, and all 30
catalogued checksum validations pass. The temporary signing-key file was deleted and confirmed
absent. Exact assets are staged in new immutable `1.3.7.0` and refreshed `latest` trees; 1.3.6.0
is unchanged. Commit, push, green Actions, and live-site byte verification remain. Exact sealed
upgrade/import and runtime soak are still untested.

## September 6 — prepare and publish sealed 1.3.7.0

Pulled corrected VMM source commit `573099c` from `origin/main`. Release documentation now targets
the unused version 1.3.7.0. The complete local suite passes 258/258, all 13 management-pack schemas
pass, dependency-document validation passes, and the VitePress production build passes. The next
step is a clean release-source commit, followed by sealing all 13 MPs with the approved permanent
identity and publishing the exact validated assets. Exact sealed 1.3.7.0 upgrade/import and runtime
soak have not been run and must not be claimed as passed.

## Current — VMM source corrections implemented for 1.3.7.0

Fixed compiler temporary-directory initialization across VMM task/health/discovery scripts and
corrected native VMM property mappings, including agent-version drift monitoring. Ten live
SCOM executions pass across both VMM servers. See VMM_1.3.7_FIX_VALIDATION.md and latest HANDOFF.
Published/installed 1.3.6.0 is unchanged; corrected source requires new sealing. Older findings
below describe the pre-fix checkpoint, not the current source status.


## Latest — sealed 1.3.6.0 imported and runtime-tested

All 13 MPs upgraded. Original Cluster Summary and VMM HostStatus tests pass, as do four host
diagnostics and permanent discoveries. Inventory and overrides unchanged. Broader VMM testing
found recurring AgentVersions/LibraryStatus task failures and blank selected fields on successful
diagnostic runs. See SEALED_1.3.6_VALIDATION.md; full acceptance is NOT green. Source unchanged.


## September 5 — seal and publish operator-task corrective release 1.3.6.0

Pulled `1fa10f0`, which fixes the Cluster Summary capacity calculation, binds all five VMM tasks
to the VMM Run As profile, and makes Cluster/VMM task failures return exit 1. The two corrected
tasks already passed live source-coupled SCOM validation. Release documentation now targets
1.3.6.0, and the stale generic probe-smoke expectation was corrected to accept an intentional
controlled platform-task failure when its module/target is absent. Focused tests, every remaining
unit test, dependency-document checks, all 13 schemas, and the VitePress production build pass.

Release source is committed as `35caf7c`. All 13 MPs were sealed as 1.3.6.0 with the permanent
identity; independent package, strong-name, identity, sealed-correction, bundle, and checksum gates
pass. Exact validated bytes were published by `a17382a`; Actions run `34001447037` passed MP
validation, the docs build, and Pages deployment. All 31 live-site files match the signed output and
all 30 catalogued checksums pass. Immutable 1.3.5.0 remains untouched. The remaining work is exact
sealed 1.3.6.0 runtime upgrade/soak acceptance, which has not been run.

## September 5 19:25 ET — requested operator task fixes

Source fixes implemented after `git pull --ff-only` (already current). Eight regression tests
pass; all 13 candidate 1.3.6.0 MPs build and pass schemas. Corrected Cluster Summary and VMM
HostStatus both pass real SCOM task execution using a source-coupled temporary validation pack,
now removed. Installed sealed 1.3.5.0 remains unchanged; new sealing/import is still required.
See newest HANDOFF.md entry. Previous install-only checkpoint below is historical.


## ACTIVE September 5 evening — install and validate exact sealed 1.3.5.0

Update 18:42 ET: all 13 MPs installed; all four permanent discoveries and diagnostics passed.
Topology hotfix removed. B01's temporarily missing pipeline returned after permanent-discovery
retry; all 268 object/class identities now match baseline. VMM capacity and uplinks recovered
naturally to Good. Two actual operator-task defects remain (missing VMM task Run As binding and
Cluster Summary's nonexistent PercentUsed property); see SEALED_1.3.5_VALIDATION.md. No production
source fix/reseal was made during this install/check task. Earlier "import in progress" text below
is the chronological initial checkpoint, superseded by this result.

Operator supplied `C:/Users/kristopher.turner/Downloads/Hyper-V-Private-Cloud-Monitoring-Deployment-1.3.5.0`
and authorized import and code/runtime checks. Local checkout fast-forwarded to `9e6b760`, which
includes the signing machine's release source `46f3bc9` and published exact artifacts. All 13
downloaded MP hashes match the release manifest; forced strong-name verification, identity/token,
schema, and prerequisite checks passed. All 13 embedded XML documents match rebuilt release source
after only normalizing XML declaration/CDATA representation. All 64 embedded PS bodies parse.
Import is in progress. Preserve topology hotfix until permanent discovery succeeds on every host.
Evidence and import progress: `tmp/sealed-135/`; SDK helper `tmp/SealedUpgrade2.exe`.

## September 5 — 1.3.5.0 sealed, published, and green

Version 1.3.5.0 was built in Release mode from clean source commit `46f3bc9`, using the permanent
signing identity and the same curated sealed dependencies as 1.3.4.0. All 13 sealed MPs passed VSAE,
strong-name, identity, sealed-byte correction, package-content, and checksum validation. The exact
validated assets are published in the immutable 1.3.5.0 and `latest` download trees by commit
`379b988`. GitHub Actions run `33946071914` passed the MP tests, docs build, and Pages deployment.

The remaining task is post-publication runtime acceptance on the jump server. Do not claim the
sealed upgrade, permanent topology takeover/hotfix removal, or 24-hour soak passed.

## September 5 — source pushed; monitor Actions and hand off sealing

All implementation changes and `.ai/state/SEALING_AGENT_PROMPT.md` were committed and pushed to
`origin/main` in `78bace53a370598b2fd172a2fbe5b688e659bfbf`. The current task is to confirm the final
pushed commit's MP contract, documentation build and Pages deployment jobs are green, then give
the operator the committed prompt for the other AI. Do not dispatch the separate sealing/release
workflow from this jump server. Earlier references to uncommitted source are historical.

## September 5 checkpoint — live pre-sealing scenarios complete

Availability and network fault/recovery, dependency rollup, live migration, stable VM/NIC identity,
runtime ownership replacement, destination monitor initialization and deletion discovery all passed
using an isolated VM with no guest SCOM agent. Corrected Cluster source passed on four Hyper-V nodes
and the non-CSV VMM cluster; corrected VMM source passed under SCOM Run As. Candidate 1.3.5.0 XML
rebuilt and all 13 packs schema-valid. Final full regression run: 241 passed, 0 failed, 0 skipped
(1667.21 seconds), including all source fixes and new regression files.

Test VM registration, private switches, SCOM objects and temporary validation task pack removed.
Retain the topology hotfix until the sealed upgrade takes over. Tool policy rejected cleanup of the
4 MiB blank test disk/empty directories; exact residual path is in HANDOFF.md. No existing workload
VMs were modified. AGENTS.md now explicitly records the supported-runtime clarification.

Remaining release gates concern the exact sealed artifact, source commit, upgrade and soak—not
PS7 permission or authorization to create a disposable VM. Sealing/publication remain on the
operator's other machine. Do not mislabel the unsigned transfer bundle as a certified release.

## ACTIVE — release certification, not merely sealing handoff

The operator clarified that all release-readiness work must be completed. Latest live findings,
source fixes, passed checks and explicit blockers are in [RELEASE_READINESS.md](RELEASE_READINESS.md).
No workload-VM SCOM agents. No sealing/publication on this machine. Do not describe the previous
handoff ZIP as release-certified. The operator explicitly authorized deploying a disposable VM
and clarified PS7 is required only where supported; use Windows PowerShell for Cluster/VMM when
required. These are not blockers. Continue live tests without modifying existing workloads.

## ACTIVE — 2026-09-04 live repair and 1.3.5.0 sealing handoff

This entry supersedes the older 1.3.0.0 task below. Live SCOM is running 13 sealed 1.3.4.0 MPs.
Topology ingestion was repaired with a temporary unsealed discovery-only hotfix on all four
Hyper-V hosts. Permanent discovery, diagnostic-output, migration-event and CSV-query corrections
are in source. Sealing and release publication must happen on the operator's other machine.
See the newest [HANDOFF.md](HANDOFF.md) entry for evidence, tests and safe hotfix removal order.
Do not remove the topology hotfix before the upgraded sealed discovery has rediscovered all hosts.

## ACTIVE — 1.3.0.0 remediation after SCOM HAAS-SDR operational audit

**Plan: [`PLAN-1.3.0.0-REMEDIATION.md`](../../PLAN-1.3.0.0-REMEDIATION.md) — read §0 first.**

### Correction to the previous entry

The previous entry asserted that all seven 1.2.0.0 runtime defects were resolved. **That was not true
of the packs the environment imported.** The audit is correct on every claim, and understated the
problem.

**Version 1.2.0.0 was published three times with different content**, all under the unchanged version
number:

| Publish commit | `Monitoring.mp` SHA-256 (first 16) | `Param[1]` defects |
|---|---|---|
| `94c245f` — original | `221a3a07de440083…` | **10** |
| `e0a1d9e` — restage | `3676a824a1a71acb…` | **10** |
| `ce51a8e` — "with scom audit fixes" | `3387a8e867418616…` | **0** |

**SCOM will not import a sealed MP whose version already exists.** The environment therefore runs the
original `94c245f` bytes, and every fix in `ce51a8e` is stranded. `latest/` currently serves the third
build, so the published SHA-256 manifest for 1.2.0.0 has three contradictory values.

Verified by unsealing each published build directly (assembly resource → gzip → UTF-16LE; method in
§0 of the plan). Against the imported `94c245f` build, normalized-diffed vs 1.0.7.0:

- **All nine capability packs are byte-identical to 1.0.7.0** — as are `Monitoring` and
  `Presentation`. Only `Discovery` (72 lines) and `Library` (243) changed: the 360° class
  *declarations* and nothing else. The audit said eight packs; it was nine, plus two more.
- Every defect the audit listed — 8702, 5402 ×10, 8903, 8301, 8905, SDN false alerts, fail-open
  probes, 0 monitors on the 6 new classes — is present exactly as described.

The stranded `ce51a8e` build fixes roughly one and a half of the seven defects: `Param[1]` genuinely
fixed; ATC logic fixed but `RequireNetworkATC` still defaults `true` ×15 so the symptom would persist;
File Services 1 of 3 sites; Cluster "fixed" with the `-SkipEditionCheck` approach the audit proved
fails; VMM, SDN, Storage, S2D and the 360° wiring untouched. **Rebasing it onto a new version number
is not a release.**

### Root cause

1. A sealed, published MP was republished under an unchanged version — three times. This is the exact
   act the audit warned against, and it made every subsequent fix invisible to SCOM.
2. Fixes were verified against source templates and a positive-environment probe fixture, never
   against sealed-pack content or a negative environment. 87/87 + 63/63 + 11/11 green was compatible
   with every defect surviving. `src/hyper-v/scom-mp/out/development/HyperVPrivateCloud.Monitoring.xml`
   still contains all 10 `Param[1]` defects while the source template contains none — build output and
   source disagree and nothing flags it.

### Next

0. **Confirm which build is live before interpreting any retest** —
   `Get-SCOMManagementPack -Name HyperVPrivateCloud.* | Select Name, Version, TimeCreated`, matched
   against the three SHA-256 values above. Every runtime conclusion depends on this.
1. Build gate **§1.8 (immutable published version)** first — it is the failure that hid the others.
2. Then the remaining §1 gates. Gate 1.3 (negative-environment fixture) alone would have caught four
   of the seven defects.
3. Run the §5.1 `root\MSCluster` CIM spike as the HealthService account — blocks the cluster fix.
4. Complete §7.1 VMM Run As association — until then Event 8905 cannot be attributed to MP code.
5. Decide §5.3 (VMM PS7 ADR exception vs off-agent collector) — recommendation is the ADR exception.

Ship **1.3.0.0**. Do not republish 1.2.0.0 again.

---

## Completed — see git history

Prior entries for the 1.2.0.0 release, 360° build-out, management domain health, and the 2-pack
override architecture are preserved in git history. The 1.2.0.0 "all defects resolved" summary is
superseded by the correction above.

---

## Progress — 2026-09-03, first fix commit (`456a8a0`)

**Fixed in source** (ships in 1.3.0.0; not yet built or sealed):

- **ATC 8903** — `RequireNetworkATC` default `true` → `false` in all 15 unit monitors. This, not the
  guard logic, was the live cause.
- **StrictMode null-collapse (8702)** — scanned all 85 conditional assignments; 15 use the result as a
  collection; 10 genuinely unsafe, all fixed (File Services ×3, ATC ×2, PhysicalNetwork ×3, VMM ×2).
  Confirmed empirically under pwsh 7 that the old pattern yields `$null` and `.Count` throws
  `PropertyNotFoundException` — the exact Event 8702 text. PhysicalNetwork `$rates` is a hashtable and
  got a null guard, **not** an `@()` wrap.
- **Fail-open probes** — 9 sites returning `Good` from a catch or not-applicable branch now return
  `NotApplicable` with the real reason. The console-server probe had no probe at all and claimed
  "is verified"; now honest.
- **VMM diagnostics** — events 8510/8511/8512/8904/8905 now log `Exception.ToString()`.

Every modified template parses clean against its HEAD baseline (checked with the PowerShell parser).

**Not yet done:** Cluster `root\MSCluster` CIM (needs the §5.1 spike on a real host as the
HealthService account); SDN/Storage/S2D applicability classes; cookdown; 360° monitor targeting; the
§1 release gates; build/seal/stage 1.3.0.0.

**Process note:** two mid-session edits corrupted files (a flattened array made `.Replace()` swap every
`$` for `a`; a here-string insertion broke three templates). Both were caught by parse-checking against
the git baseline and reverted. **Parse-check every generated edit against baseline before writing** —
`git status` alone does not reveal this.

## Handoff prompt for the remaining work

**[`.ai/state/NEXT-SESSION-PROMPT.md`](NEXT-SESSION-PROMPT.md)** — paste as the opening prompt of a
fresh session. Covers Tasks A–F: Cluster CIM port (spike-gated), applicability, cookdown, the 360°
model, release gates, and shipping 1.3.0.0.

**Measured corrections to the audit's framing**, from the unsealed 1.2.0.0 packs:

- **S2D (16 monitors) and VMM (13)** already hang off Microsoft's own discoveries
  (`…StorageSpacesDirect.StorageSubSystem`, `…VirtualMachineManager.Discovery.VMMManagementServer`).
  They are correctly gated — **do not "fix" them.** VMM's problem is the Run As association plus
  amplification and diagnostics, not applicability.
- **File Services is the real applicability defect** — 12 of 12 monitors target `HostRole`.
  Storage (4 of 25), ATC (3 of 16) and Cluster (3 of 16) are partially ungated.
- **SDN has a gate, but it is too permissive and fails open.**
  `$sdnDetected = -not [string]::IsNullOrWhiteSpace($hostId) -or $ncState -ne 'NotInstalled' -or $slbState -ne 'NotInstalled'`
  — an OR of three weak signals, and `Get-HcsServiceState` returns `'Unknown'` from its catch, which is
  `-ne 'NotInstalled'`, so a failed service query *enables* SDN monitoring.
- **Cookdown blocker identified precisely:** probes run one `pwsh.exe` per workflow via
  `System.CommandExecuterDiscoveryDataSource`; SCOM cooks down only byte-identical DataSource config,
  and the per-facet `Mode` value in `$Config/Arguments$` is what makes each unique. Facet selection
  must move into the ConditionDetection filter.
