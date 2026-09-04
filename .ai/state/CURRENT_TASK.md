# Current task

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
