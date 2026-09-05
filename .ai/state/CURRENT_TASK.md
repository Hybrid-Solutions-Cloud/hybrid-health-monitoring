# Current task

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
