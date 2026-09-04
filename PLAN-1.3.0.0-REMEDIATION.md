# Remediation plan — Hyper-V Private Cloud Monitoring 1.3.0.0

> Created: September 3, 2026
> Supersedes the "all defects resolved" claim in `.ai/state/CURRENT_TASK.md` for 1.2.0.0.
> Driver: SCOM HAAS-SDR operational audit of the imported 1.2.0.0 suite.
> Work item: AB#7319 (new child items required — see §9).

---

## §0 Audit reconciliation — the audit is correct, and understated the problem

**Headline: version 1.2.0.0 was published three times with different content.** The fixes exist, but
they are stranded in a republish that SCOM will never load. The environment is running the original
bytes.

| Publish commit | `Monitoring.mp` SHA-256 (first 16) | `Param[1]` defects |
|---|---|---|
| `94c245f` — original publish | `221a3a07de440083…` | **10** |
| `e0a1d9e` — restage | `3676a824a1a71acb…` | **10** |
| `ce51a8e` — "with scom audit fixes" | `3387a8e867418616…` | **0** |

All 13 sealed packs were rewritten in each of the three commits, all under the unchanged version
`1.2.0.0`. `docs/public/downloads/.../latest/` currently serves the third build.

**SCOM will not import a sealed management pack whose version already exists in the management
group.** The audited environment therefore imported the original (`94c245f`) content and is still
running it. That is the entire explanation for "workflow errors resumed immediately" and for the
audit finding capability packs identical to 1.0.7.0. Nothing mysterious happened.

### Verdict table — against the bytes that were actually imported (`94c245f`)

Normalized diff (version strings collapsed) of original 1.2.0.0 against 1.0.7.0:

| Pack | Changed lines |
|---|---|
| Cluster, FileServices, NetworkATC, PhysicalNetwork, PureStorage, S2D, SDN, Storage, VMM | **0 — byte-identical** |
| Monitoring, Presentation | **0 — byte-identical** |
| `Discovery` | 72 |
| `Library` | 243 |

| # | Audit claim | Verified against imported 1.2.0.0 | Verdict |
|---|---|---|---|
| — | "The eight capability packs are functionally identical to 1.0.7.0" | **Nine** capability packs are identical, and so are `Monitoring` and `Presentation`. Only `Discovery` and `Library` changed — the 360° class *declarations*, nothing else | **Correct, and understated** |
| 1 | File Services `.Count` on `$null` under StrictMode (8702) | Both `channels =` sites unguarded, as described | **Confirmed** |
| 2 | Ten rules carry `$Data/Params/Param[1]$` | 10 present, unchanged from 1.0.7.0 | **Confirmed** |
| 3 | Network ATC applicability logic | `$Mode -in @('Intent','Adapter','Global')` present exactly as quoted | **Confirmed** |
| 4 | Cluster PS7/FailoverClusters host incompatibility (8301) | Pack unchanged | **Confirmed** |
| 5 | VMM amplification + `Exception.Message` only | Pack unchanged | **Confirmed** |
| 6 | SDN monitors applied where no SDN exists | Pack unchanged | **Confirmed** |
| 7 | Suite-wide failure amplification | Probes run one `pwsh.exe` per workflow (`System.CommandExecuterDiscoveryDataSource` → `%ProgramFiles%\PowerShell\7\pwsh.exe -File <script> <Mode>`), 32 `PropertyBagProbe` + 20 `DiscoveryProvider` consumers | **Confirmed — architectural** |
| 8 | New 360° classes have no discovery, and monitors target `HostRole` | All six declared in `Library`; **0 unit monitors target any of them**; `OutOfBandSwitch`, `EdgeFirewall`, `ConsoleServer` have **0 `MPElement` references anywhere** | **Confirmed** |
| 8b | Fail-open probes return Good | `"probe active."` ×8 | **Confirmed** |

### What the third publish (`ce51a8e`) actually contains

Not wasted work — but not deliverable either, and not complete. Verified in that build:

- `Param[1]`: 10 → **0**. Genuinely fixed.
- ATC: the `$Mode -in (…)` clause **removed** — but `RequireNetworkATC` still defaults **`true` in 15
  places** and `false` in 1, so the throw would still fire on non-ATC hosts. **Fixing the logic did
  not fix the symptom**; the default configuration is the live cause.
- File Services: **1 of 3** `channels =` sites wrapped as `@(if …)`. Two remain, alongside ~50
  unguarded `.Count` reads (`$required` ×14, `$selected` ×6, `$caProblems` ×6, `$witnessClients` ×4,
  `$unencryptedShares` ×4, `$missing` ×4, `$channels` ×4, and others).
- Cluster: added `Import-Module FailoverClusters -SkipEditionCheck` — **the exact approach the audit
  proved fails** with `Could not load type 'System.Diagnostics.Eventing.EventDescriptor'`. A no-op.
- VMM: still 18 `Get-SCVMMServer`, 10 `Import-Module`, 19 `Exception.Message`, **0** `Exception.ToString`.
- SDN, Storage, S2D, PhysicalNetwork, PureStorage: **still untouched**.
- 360° classes: still 0 monitors targeting them; three classes still referenced nowhere.

So even the stranded build fixes roughly one and a half of the seven defects. **Rebasing it onto a new
version number is not a release.**

### Root cause — two failures, in order

1. **A sealed, published management pack was republished under an unchanged version, three times.**
   This is the precise act the audit's closing paragraph warned against. The consequence is not
   cosmetic: every fix is invisible to SCOM, and the published SHA-256 manifest for `1.2.0.0` now has
   three mutually contradictory values. Any operator who verified a download against the manifest
   would get a different answer depending on the day.
2. **Fixes were verified against source templates and a positive-environment probe fixture** — never
   against sealed-pack content, and never against a negative environment (no ATC, no SDN, no VMM, no
   FailoverClusters, no UNC-backed VHDs), which is the audited environment. 87/87 + 63/63 + 11/11
   green was compatible with every defect surviving. Corroborating evidence in the tree:
   `src/hyper-v/scom-mp/out/development/HyperVPrivateCloud.Monitoring.xml` still contains all 10
   `Param[1]` defects while the source template contains none — build output and source disagree and
   nothing flags it.

**This is the finding that matters.** Fixing the seven defects without fixing (1) and (2) reproduces
this audit at 1.3.0.0. §1 therefore gates §2.

### Inspection method (reproducible; becomes gate 1.1)

A sealed `.mp` is a .NET assembly holding one managed resource, `MPResources.resources`, whose
`ManagementPack` entry is **gzip-compressed UTF-16LE XML**. Plain `grep` on a `.mp` returns zero
matches for content that *is* present — which is why static verification could not tell "fixed" from
"unfixed", and why this reconciliation was not possible until now.

```powershell
$asm = [System.Reflection.Assembly]::LoadFile($mp)
$rr  = [System.Resources.ResourceReader]::new($asm.GetManifestResourceStream('MPResources.resources'))
foreach ($e in $rr) { if ($e.Key -eq 'ManagementPack') { [IO.File]::WriteAllBytes($out, $e.Value) } }
# then: gzip -dc $out | iconv -f UTF-16LE -t UTF-8
```

### Out of scope, but the same defect

`src/azure-local/scom-mp/fragments/monitoring/ManagementPack.xml.template` still carries
`$Data/Params/Param[1]$` ×4 **in source**. Same fix, sibling MP — raise separately.

---

## §1 Release gates — build these before writing any product fix

No task in §2–§6 is complete until its named gate proves it on **shipped sealed-pack content**.

| Task | Description | Acceptance |
|---|---|---|
| **1.1** | Add `Test-HcsSealedManagementPackContent` helper: unseal → gunzip → UTF-16→UTF-8, returning parsed XML per sealed `.mp`. | Returns 13 packs; unit-tested against a known string. |
| **1.2** | Extend `HyperVPrivateCloud.Release.Tests.ps1` with a **shipped-content assertion suite** driven by 1.1 — one assertion per §2 defect. | Suite **fails against the original 1.2.0.0 assets** (prove it fails before trusting it) and passes on 1.3.0.0. |
| **1.3** | **Negative-environment probe fixture**: no `NetworkATC`, no `FailoverClusters`, no `VirtualMachineManager`, no NC host agent, no MPIO, no UNC-backed VHDs. Every probe returns `NotApplicable`, throws nothing, writes no error events. | Every capability probe green. **This gate alone would have caught defects 1, 3, 4 and 6.** |
| **1.4** | **StrictMode static scan**: flag any `$x = if (…)` / `$x = foreach (…)` / pipeline assignment whose `.Count`, `.Length` or indexer is later read without `@()` normalization. | Clean across all capability templates (~50 current hits, listed in §0). |
| **1.5** | **Fail-open scan**: no `catch` may return `Good`/`Success`. | Clean; the 8 `"probe active."` returns eliminated. |
| **1.6** | **Stale-artifact guard**: fail the build if `out/development` differs from a fresh build of current source. | Fails on the current tree (proving it works), then passes after rebuild. |
| **1.7** | **Default-configuration scan**: every `Require<Capability>` default is `false` unless the participation class is discovered. | Catches the ATC `true` ×15 class of defect generally. |
| **1.8** | **Immutable published version guard** — the fix for root cause (1). The release tool must **refuse** to write into a published version directory that already exists, and `SHA256SUMS.txt` for a published version must be treated as immutable. Add a CI check that a published `SHA256SUMS.txt` is never modified by a later commit. | Guard rejects a re-publish of 1.2.0.0; CI flags the three existing 1.2.0.0 hash rewrites. |

---

## §2 Confirmed code defects

Sequencing: **do §3 and §4 before re-doing the File Services, VMM and ATC probe internals**, or those
scripts get rewritten twice. The `ce51a8e` work is a starting point for 2.1/2.3/2.7 only — treat it
as an unreviewed patch, not as done.

| Task | Defect | Fix | Gate |
|---|---|---|---|
| **2.1** | File Services `.Count` on `$null` → Event 8702 → 10 false SMB facets | Wrap **all three** `channels =` sites as `$x = @(if (…) { … })`, then clear every hit from the 1.4 scan. Do not spot-fix. | 1.4 + 1.3 |
| **2.2** | File Services handler promotes 10 unevaluated facets `NotApplicable`→`Warning` | Remove the cascade; an acquisition failure marks **only** the acquisition facet unhealthy. | 1.3 |
| **2.3** | ATC 8903 | Remove the `$Mode -in` clause **and** flip `RequireNetworkATC` to `false` in all 15 sites; `true` reachable only via override or a discovered intent (§3.1). | 1.7 + 1.3 |
| **2.4** | Cluster `-SkipEditionCheck` does not work (type-load failure) | Replace with `root\MSCluster` CIM — §5 must resolve first. Remove the misleading "module is missing" message; report the real host-context failure. | 1.3 + §5.1 |
| **2.5** | VMM discards diagnostics | Log `Exception.ToString()` plus the full inner-exception chain (all 19 sites). | 1.2 |
| **2.6** | Fail-open `"probe active."` ×8 | Return `Uninitialized`/`NotApplicable` with detail; never `Good` from a catch. | 1.5 |
| **2.7** | `Param[1]` ×10 | Carry forward the `ce51a8e` fix and lock it with the 1.2 assertion. Raise the Azure Local sibling separately. | 1.2 |

---

## §3 Applicability model — stop instantiating capabilities that do not apply

The suite targets monitors at `HostRole` and relies on *runtime* checks to decide applicability. That
is why an unused capability produces alerts instead of silence. The fix is **structural**: discovery
decides, not the probe.

| Task | Capability | Participation evidence required before any monitor targets a host |
|---|---|---|
| **3.1** | Network ATC | ≥1 intent returned by `Get-NetIntent` |
| **3.2** | SDN | NC Host Agent present **and** host registered with a Network Controller — an imported Microsoft SDN prerequisite MP is **not** evidence |
| **3.3** | File Services | ≥1 UNC-backed VHD/VHDX in use |
| **3.4** | Storage (SAN/MPIO) | MPIO feature present **and** ≥1 claimed MPIO disk |
| **3.5** | Pure Storage | Array reachable and discovered |

**Pattern for each:** add a participation class, discover it only on qualifying evidence, and
**retarget that capability's unit monitors from `HostRole` onto the participation class**. Monitors
then do not exist where the capability does not apply.

> **Sealed-MP constraint — do not violate.** In-place upgrade of a sealed MP forbids removing
> `ClassType` and `RelationshipType` definitions. The six empty 360° classes **stay**. Implement them
> (§6) or document them as pending; never delete them to tidy a view.

---

## §4 Cookdown — remove failure amplification

Each monitor spawns its **own `pwsh.exe`**, loads its own modules, and queries the control plane
independently. One VMM initialization failure becomes 11 failing workflows. This is the mechanism
behind the 3,142 alert repeat count.

| Task | Description |
|---|---|
| **4.1** | One shared `DataSource` per capability emitting a **single property bag** covering all facets; monitors differ only by `ConditionDetection`. |
| **4.2** | Remove the per-facet `Mode`/`Action` argument from the shared DS config — **this parameter is what defeats cookdown today**, because SCOM only cooks down workflows whose DS configuration is byte-identical. Facet selection moves into the expression filter. |
| **4.3** | Apply to VMM (11 facets), File Services (10), Network ATC, Cluster, S2D, Storage. |
| **4.4** | Acceptance: where a capability's control plane is down, exactly **one** acquisition workflow runs and **one** error event is written per interval — not one per facet. |

---

## §5 Execution model — resolve the governance conflict explicitly

**The conflict is real and must be decided, not worked around.** The HCS hard rule mandates
PowerShell 7 and forbids 5.1. `FailoverClusters` and `VirtualMachineManager` are Windows
PowerShell-only modules. `-SkipEditionCheck` is an implicit compatibility bridge that works
interactively and fails under the HealthService account — exactly the observed behaviour.

| Task | Description |
|---|---|
| **5.1** | **Spike, blocking §2.4:** verify `Get-CimInstance -Namespace root\MSCluster -ClassName MSCluster_Cluster` returns from PS7 **as the HealthService account** on one host. CIM is native to PS7 and needs no module — the recommended cluster design, but confirm before locking it. |
| **5.2** | Port cluster probes, discovery and tasks to `root\MSCluster` CIM (contingent on 5.1). |
| **5.3** | **VMM decision — no CIM equivalent exists.** Either **(a)** a documented ADR exception permitting a Windows PowerShell probe host for VMM workflows only, or **(b)** move VMM collection off-agent to a dedicated collector with a documented identity. **Recommendation: (a)** — narrower blast radius, no new deployment surface, auditable exception. Requires sign-off. |
| **5.4** | Record the outcome as an ADR; amend the scripting standard's PS7 rule with the named exception rather than leaving code silently non-conformant. |

---

## §6 The 360° object model — make the new classes real

| Task | Description |
|---|---|
| **6.1** | Adopt a **seed-based discovery pattern** for external devices: endpoints and credentials come from configuration (override-supplied seed), discovery creates instances from the seed, probes target the discovered object. The only workable pattern for kit that cannot self-report to an agent. |
| **6.2** | Implement discovery for `OutOfBandSwitch`, `EdgeFirewall`, `ConsoleServer` — currently **zero references anywhere in the suite**. |
| **6.3** | **Retarget the 12 new unit monitors from `HostRole` onto the six infrastructure classes** so instances receive their calculated health. |
| **6.4** | Replace shallow proxies or withdraw the claim: host default gateway ≠ edge firewall; local LLDP ≠ ToR switch health; console-server health without a console-server object is meaningless; DHCP discovered only when running locally on a Hyper-V host misses the normal topology. |
| **6.5** | Document required endpoint configuration, credentials/Run As, and discovery ownership per object type. |
| **6.6** | Any class not implemented by release: document as **pending** in release notes and leave the view empty-but-explained. Unexplained empty views are what produced this audit finding. |

---

## §7 Environment prerequisites — configuration, not code

| Task | Description |
|---|---|
| **7.1** | Associate `HAAS\svc-scom-vmm` with `Microsoft.SystemCenter.VirtualMachineManager.2012.VMMServerConnectionRunAsProfile`. **Until this is done, Event 8905 cannot be attributed to MP code** — retest after. |
| **7.2** | Reconcile privilege: docs specify VMM **Read-Only Administrator** scoped to host groups/clouds/library servers; the account holds full **VMM Administrator**. Align one to the other and state which. |
| **7.3** | SDN Run As association — only if SDN is intended to be active. If not, §3.2 makes it moot. |
| **7.4** | Add a **prerequisite verification task/report** so a missing Run As association surfaces as an explicit prerequisite failure, not an obscure type-initializer exception. |

---

## §8 Release and acceptance

1.2.0.0 must not be republished again under the same version — it already was, three times. Ship
**1.3.0.0**, and treat every published version directory as immutable from that point (gate 1.8).

| Task | Description |
|---|---|
| **8.1** | Rebuild, reseal and restage all 13 packs at 1.3.0.0 from a clean `out/development` (1.6 green). |
| **8.2** | **Structural acceptance:** all §1 gates green **against shipped sealed content**, not source. |
| **8.3** | **Runtime acceptance** in the audited environment, using the audit's own metrics as the baseline: Error objects **22 → 0** for non-applicable capabilities; Uninitialized **13 → 0**; unresolved alerts **129 → only genuine findings**; alert repeat count flat, not climbing from 3,142; **zero** 8702/8903/8301/8905/5402 events across a 24-hour soak. |
| **8.4** | Publish release notes stating plainly that 1.2.0.0 was published three times under one version, which build each SHA-256 corresponds to, and that only 1.3.0.0 carries the fixes. |
| **8.5** | Decide the disposition of the published 1.2.0.0 directory — recommended: restore it to the original `94c245f` bytes so the published hash matches what was actually released and imported, and let 1.3.0.0 carry every fix. |

---

## §9 Immediate actions

0. **Confirm which build is live before interpreting any retest.** Run
   `Get-SCOMManagementPack -Name HyperVPrivateCloud.* | Select-Object Name, Version, TimeCreated` and
   match against the three published SHA-256 values in §0. Expected: the `94c245f` build. Every
   runtime conclusion depends on this.
1. **Rewrite `.ai/state/CURRENT_TASK.md`** — done in this change; it previously asserted all seven
   defects resolved and would otherwise have handed the next session the false premise.
2. Raise child work items under AB#7319 for §1–§8; §1 blocks the rest, and **1.8 is the highest
   priority single task** because it is the failure that hid everything else.
3. Raise a separate item for the Azure Local `Param[1]` ×4 source defect.
4. Confirm the §5.3 VMM execution decision — it blocks the VMM rework.

## Critical path

```
§1.8 immutable-version guard  (do first — it is the root failure)
§1 gates (1.2, 1.3, 1.4 next)
   └─> §5.1 cluster CIM spike ─┐
   └─> §3 applicability ───────┼─> §4 cookdown ─> §2 probe fixes ─> §8 release
   └─> §7.1 VMM Run As ────────┘
                                  §6 360° model (parallel)
```

§1 is not overhead. It is the set of tasks that keeps 1.3.0.0 from becoming the next audit.
