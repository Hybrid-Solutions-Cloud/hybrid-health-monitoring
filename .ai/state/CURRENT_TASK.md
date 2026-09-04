# Current task

## ACTIVE — 1.3.0.0 remediation after SCOM HAAS-SDR operational audit

**Plan: [`PLAN-1.3.0.0-REMEDIATION.md`](../../PLAN-1.3.0.0-REMEDIATION.md) — read §0 first.**

### Correction to the previous entry

The previous entry asserted that all seven 1.2.0.0 runtime defects were resolved. **That claim was
not true of the packs that shipped.** The fixes were verified against source templates and a
positive-environment probe fixture, never against sealed-pack content and never against a negative
environment. 87/87 + 63/63 + 11/11 green was compatible with every defect surviving.

Verified by unsealing the published 1.2.0.0 `.mp` assets directly (assembly resource → gzip →
UTF-16LE; method in §0 of the plan):

| Defect | Actual state in shipped 1.2.0.0 |
|---|---|
| `$Data/Params/Param[1]$` ×10 | **Fixed** (10 in 1.0.7.0 → 0). Audit was wrong on this one. |
| File Services `.Count` on `$null` | **Partially fixed** — 1 of 3 `channels =` sites wrapped; 2 remain, plus ~50 unguarded `.Count` reads |
| Network ATC applicability | Logic **fixed**, but `RequireNetworkATC` still defaults `true` ×15 / `false` ×1 — that is why 8903 persists |
| Cluster PS7 host | **Not fixed** — `-SkipEditionCheck` is the exact approach the audit proved fails |
| VMM amplification/diagnostics | **Not fixed** — 18 connects, 10 module loads, 19 `Exception.Message`, 0 `ToString` |
| SDN false alerts | **Untouched** — pack byte-identical to 1.0.7.0 |
| 360° classes | **Not wired** — 0 monitors target the 6 new classes; `OutOfBandSwitch`/`EdgeFirewall`/`ConsoleServer` have 0 references anywhere |

Also wrong in the audit: "all eight capability packs are identical to 1.0.7.0". Four changed
(Cluster 59, FileServices 62, NetworkATC 18, VMM 93 normalized diff lines); four did not
(PhysicalNetwork, S2D, SDN, Storage — plus PureStorage).

### Known-stale artifact

`src/hyper-v/scom-mp/out/development/` is stale (13:35 vs the 21:38 seal) and still contains the 10
`Param[1]` defects. It is **not** what shipped. Task 1.6 adds a guard.

### Next

1. Build the §1 release gates — they block §2–§8. Gate 1.3 (negative-environment fixture) alone
   would have caught four of the seven defects.
2. Run the §5.1 `root\MSCluster` CIM spike as the HealthService account — blocks the cluster fix.
3. Complete §7.1 VMM Run As association — until then Event 8905 cannot be attributed to MP code.
4. Decide §5.3 (VMM PS7 exception vs off-agent collector) — recommendation is the documented ADR
   exception.

1.2.0.0 is sealed and published; it must not be republished under the same version. Ship 1.3.0.0.

---

## Completed — see git history

Prior entries for the 1.2.0.0 release, 360° build-out, management domain health, and the 2-pack
override architecture are preserved in git history. The 1.2.0.0 "all defects resolved" summary is
superseded by the correction above.
