# Remediation plan — Hyper-V Private Cloud Monitoring 1.3.0.0

> Created: September 3, 2026
> Supersedes the "all defects resolved" claim in `.ai/state/CURRENT_TASK.md` for 1.2.0.0.
> Driver: SCOM HAAS-SDR operational audit of the imported 1.2.0.0 suite.
> Work item: AB#7319 (new child items required — see §9).

---

## §0 Audit reconciliation — what is actually in the shipped 1.2.0.0

Both the audit **and** `.ai/state/CURRENT_TASK.md` are partly wrong. Neither was checked against the
bytes that shipped. This section is the corrected baseline; every task below hangs off it.

### Method (reproducible, and becomes a test in §1)

A sealed `.mp` is a .NET assembly holding one managed resource, `MPResources.resources`, whose
`ManagementPack` entry is **gzip-compressed UTF-16LE XML**. Plain `grep` on the `.mp` returns zero
matches for content that *is* present — this is why the 1.2.0.0 verification passed while shipping
defects, and why the audit could not distinguish "fixed" from "unfixed" statically.

```powershell
$asm = [System.Reflection.Assembly]::LoadFile($mp)
$rr  = [System.Resources.ResourceReader]::new($asm.GetManifestResourceStream('MPResources.resources'))
foreach ($e in $rr) { if ($e.Key -eq 'ManagementPack') { [IO.File]::WriteAllBytes($out, $e.Value) } }
# then: gzip -dc $out | iconv -f UTF-16LE -t UTF-8
```

### Verdict table

| # | Audit claim | Evidence from unsealed 1.2.0.0 | Verdict |
|---|---|---|---|
| 2 | Ten rules carry invalid `$Data/Params/Param[1]$` suppression; "remain present in 1.2.0.0" | `Monitoring.xml`: **10 occurrences in 1.0.7.0 → 0 in 1.2.0.0** | **Audit wrong — fixed** |
| — | "The eight capability packs are functionally identical to 1.0.7.0" | Normalized diff: Cluster **59**, FileServices **62**, NetworkATC **18**, VMM **93** changed lines. PhysicalNetwork, S2D, SDN, Storage (+PureStorage) **0** | **Half right** — 4 of 8 changed, 4 did not |
| 1 | File Services `$channels` null/`.Count` under StrictMode (Event 8702) | 3 `channels =` sites; only **1** wrapped as `@(if …)`. Two unfixed sites remain, incl. `channels = if ($hasMultichannel) { @(Get-SmbMultichannelConnection …) }` | **Confirmed — partially fixed** |
| 3 | Network ATC applicability logic wrong (Event 8903) | `$Mode -in @('Intent','Adapter','Global')` clause **removed**; guard is now `if ($RequireNetworkATC)` only. **But `RequireNetworkATC` defaults to `true` in 15 places, `false` in 1** | **Audit's diagnosis wrong, symptom real** — logic fixed, *default configuration* is the cause |
| 4 | Cluster PS7/FailoverClusters host incompatibility (Event 8301) | 1.2.0.0 added `Import-Module FailoverClusters -SkipEditionCheck` — the exact approach the audit proved fails with `Could not load type 'System.Diagnostics.Eventing.EventDescriptor'` | **Confirmed — "fix" is a no-op** |
| 5 | VMM amplification + weak error handling | `Get-SCVMMServer` ×**18**, `Import-Module` ×**10**, `Exception.Message` ×**19**, `Exception.ToString` ×**0** | **Confirmed** |
| 6 | SDN monitors applied where no SDN exists | `Capability.SDN.xml` is **byte-identical** to 1.0.7.0 after version normalization | **Confirmed — untouched** |
| 7 | Suite-wide failure amplification | Probes run as **one `pwsh.exe` process per workflow** (`System.CommandExecuterDiscoveryDataSource` → `%ProgramFiles%\PowerShell\7\pwsh.exe -File <script> <Mode>`), 32 `PropertyBagProbe` + 20 `DiscoveryProvider` consumers | **Confirmed — architectural** |
| 8 | New 360° classes incomplete | All 6 declared with a `DiscoveryClass` entry. **0 unit monitors target any of them.** `OutOfBandSwitch`, `EdgeFirewall`, `ConsoleServer` have **0 `MPElement` references anywhere in the suite** — nothing discovers, monitors, or displays them | **Confirmed** |
| 8b | Fail-open probes return Good | `"probe active."` ×8 in `Monitoring.xml` | **Confirmed** |

### Root cause of the false "resolved" claim

The 1.2.0.0 fixes were verified against **source templates** and a **positive-environment** probe
smoke fixture. They were never verified against **shipped sealed-pack content**, and never against a
**negative environment** (no ATC, no SDN, no VMM, no FailoverClusters, no UNC-backed VHDs) — which is
precisely the audited environment. Consequences visible in the tree right now:

- `src/hyper-v/scom-mp/out/development/HyperVPrivateCloud.Monitoring.xml` is **stale** (13:35, seal was
  21:38) and still contains all 10 `Param[1]` defects. It is not what shipped, but nothing flags it.
- 87/87 + 63/63 + 11/11 green is compatible with every defect above surviving.

**This is the finding that matters.** Fixing the seven defects without fixing the verification gap
reproduces this audit at 1.3.0.0. §1 therefore gates §2.

### Out of scope, but same defect

`src/azure-local/scom-mp/fragments/monitoring/ManagementPack.xml.template` still carries the
`$Data/Params/Param[1]$` defect ×4 **in source**. Same fix, sibling MP — raise separately.

---

## §1 Release gates — build these before writing any product fix

No task in §2–§6 is complete until its named gate proves it on **shipped sealed-pack content**.

| Task | Description | Acceptance |
|---|---|---|
| **1.1** | Add `Test-HcsSealedManagementPackContent` helper: unseal → gunzip → UTF-16→UTF-8, returning parsed XML per sealed `.mp`. | Helper returns 13 packs from the 1.2.0.0 assets; unit-tested against a known string. |
| **1.2** | Extend `HyperVPrivateCloud.Release.Tests.ps1` with a **shipped-content assertion suite** driven by 1.1 — one assertion per §2 defect (see each task's gate below). | Suite runs against sealed output; **fails today on 1.2.0.0 assets** (prove it fails before trusting it). |
| **1.3** | Build a **negative-environment probe fixture**: no `NetworkATC`, no `FailoverClusters`, no `VirtualMachineManager`, no Network Controller agent, no MPIO, no UNC-backed VHDs. Every probe must return `NotApplicable`, throw zero exceptions, and write zero error events. | New Pester file; every capability probe green under the fixture. This single gate would have caught defects 1, 3, 4, 6. |
| **1.4** | **StrictMode static scan**: flag any `$x = if (…)` / `$x = foreach (…)` / pipeline assignment whose `.Count`, `.Length` or indexer is later read without `@()` normalization. | Scan is clean across all capability templates. Current hits to clear: `$required` ×14, `$selected` ×6, `$caProblems` ×6, `$witnessClients` ×4, `$unencryptedShares` ×4, `$missing` ×4, `$channels` ×4, `$values`, `$serviceProblems`, `$rdma`, `$problems` ×2 each. |
| **1.5** | **Fail-open scan**: no `catch` block may return a `Good`/`Success` health state. | Scan clean; the 8 `"probe active."` returns eliminated. |
| **1.6** | **Stale-artifact guard**: fail the build if `out/development` is older than the newest fragment template, or if any file under it differs from a fresh build. | Guard fails on the current tree (proving it works), then passes after rebuild. |
| **1.7** | **Default-configuration scan**: assert every `Require<Capability>` default is `false` unless the capability's participation class is discovered. | Catches the ATC `true` ×15 class of defect generally, not just this instance. |

---

## §2 Confirmed code defects

Sequencing note: **do §3 and §4 before re-doing the File Services, VMM and ATC probe internals**, or
those scripts get rewritten twice. Tasks 2.1/2.4 below are the minimal correctness fixes; the
structural rework lands in §3/§4.

| Task | Defect | Fix | Gate |
|---|---|---|---|
| **2.1** | File Services `.Count` on `$null` under StrictMode → Event 8702 → 10 false SMB facets | Wrap **all three** `channels =` sites as `$x = @(if (…) { … })`, then clear every hit from the 1.4 scan. Do not spot-fix. | 1.4 + 1.3 |
| **2.2** | File Services exception handler promotes 10 unevaluated facets `NotApplicable`→`Warning` | Remove the amplification cascade; an acquisition failure must mark **only** the acquisition facet unhealthy. | 1.3 |
| **2.3** | ATC Event 8903 despite correct logic | Flip `RequireNetworkATC` default to `false` in all 15 sites; make `true` reachable only via override or a discovered intent (§3). | 1.7 + 1.3 |
| **2.4** | Cluster `-SkipEditionCheck` does not work (type-load failure) | Replace with `root\MSCluster` CIM — see §5, which must resolve first. Remove the misleading "module is missing" message; report the real host-context failure. | 1.3 + §5 spike |
| **2.5** | VMM discards diagnostics | Log `Exception.ToString()` plus the full inner-exception chain (all 19 `Exception.Message` sites). | 1.2 |
| **2.6** | Fail-open `"probe active."` Good returns ×8 | Return `Uninitialized`/`NotApplicable` with detail, never `Good`, from a catch. | 1.5 |
| **2.7** | Regression lock for `Param[1]` | Already fixed; add the assertion so it cannot regress. Raise the Azure Local sibling (×4 in source) separately. | 1.2 |

---

## §3 Applicability model — stop instantiating capabilities that do not apply

The suite currently targets monitors at `HostRole` and relies on *runtime* checks to decide
applicability. That is why an unused capability produces alerts instead of silence. The fix is
**structural**: discovery decides, not the probe.

| Task | Capability | Participation evidence required before any monitor targets a host |
|---|---|---|
| **3.1** | Network ATC | ≥1 intent returned by `Get-NetIntent` |
| **3.2** | SDN | Network Controller Host Agent present **and** host registered with an NC — an imported Microsoft SDN prerequisite MP is **not** evidence |
| **3.3** | File Services | ≥1 UNC-backed VHD/VHDX in use |
| **3.4** | Storage (SAN/MPIO) | MPIO feature present **and** ≥1 claimed MPIO disk |
| **3.5** | Pure Storage | Array reachable and discovered |

**Pattern for each:** add a participation class, discover it only on qualifying evidence, and
**retarget that capability's unit monitors from `HostRole` onto the participation class**. Monitors
then simply do not exist where the capability does not apply.

> **Sealed-MP constraint — do not violate.** In-place upgrade of a sealed MP forbids removing
> `ClassType` and `RelationshipType` definitions. The six empty 360° classes **stay**. Implement them
> (§6) or document them as pending; never delete them to make a view tidy.

---

## §4 Cookdown — remove failure amplification

Today each monitor spawns its **own `pwsh.exe`**, loads its own modules, and queries the control
plane independently. One VMM initialization failure becomes 11 separate failing workflows. This is
the mechanism behind the 3,142 alert repeat count.

| Task | Description |
|---|---|
| **4.1** | One shared `DataSource` per capability emitting a **single property bag** covering all facets; monitors differ only by `ConditionDetection`. |
| **4.2** | Remove the per-facet `Mode`/`Action` argument from the shared DS config — **this parameter is what defeats cookdown today**, because SCOM only cooks down workflows whose DS configuration is byte-identical. Facet selection moves into the expression filter. |
| **4.3** | Apply to VMM (11 facets), File Services (10), Network ATC, Cluster, S2D, Storage. |
| **4.4** | Acceptance: on a host where a capability's control plane is down, exactly **one** acquisition workflow runs and **one** error event is written per interval — not one per facet. |

---

## §5 Execution model — resolve the governance conflict explicitly

**The conflict is real and must be decided, not worked around.** The HCS hard rule mandates
PowerShell 7 and forbids 5.1. `FailoverClusters` and `VirtualMachineManager` are Windows
PowerShell-only modules. The current `-SkipEditionCheck` approach is an implicit compatibility bridge
that works interactively and fails under the HealthService account — which is exactly the observed
behaviour.

| Task | Description |
|---|---|
| **5.1** | **Spike, blocking §2.4:** verify `Get-CimInstance -Namespace root\MSCluster -ClassName MSCluster_Cluster` returns from PS7 **as the HealthService account** on one host. CIM is native to PS7 and needs no module — this is the recommended cluster design, but confirm before locking it. |
| **5.2** | Port cluster probes, discovery and tasks to `root\MSCluster` CIM (contingent on 5.1). |
| **5.3** | **VMM decision — has no CIM equivalent.** Two options: **(a)** a documented ADR exception permitting a Windows PowerShell probe host for VMM workflows only, or **(b)** move VMM collection off-agent to a dedicated collector with a documented identity. **Recommendation: (a)** — narrower blast radius, no new deployment surface, and the exception is auditable. Requires sign-off. |
| **5.4** | Record the outcome as an ADR; update the scripting standard's PS7 rule with the named exception rather than leaving code silently non-conformant. |

---

## §6 The 360° object model — make the new classes real

| Task | Description |
|---|---|
| **6.1** | Adopt a **seed-based discovery pattern** for external devices: endpoints and credentials come from configuration (override-supplied seed), discovery creates instances from the seed, probes target the discovered object. This is the only workable pattern for kit that cannot self-report to an agent. |
| **6.2** | Implement discovery for `OutOfBandSwitch`, `EdgeFirewall`, `ConsoleServer` — currently **zero references anywhere in the suite**. |
| **6.3** | **Retarget the 12 new unit monitors from `HostRole` onto the six infrastructure classes** so instances actually receive their calculated health. |
| **6.4** | Replace shallow proxies with real checks, or withdraw the claim: host default gateway ≠ edge firewall; local LLDP ≠ ToR switch health; console-server health without a console-server object is meaningless; DHCP discovered only when running locally on a Hyper-V host misses the normal topology. |
| **6.5** | Document required endpoint configuration, credentials/Run As, and discovery ownership per object type. |
| **6.6** | Any class not implemented by release: document as **pending** in release notes and leave the view empty-but-explained. Empty views with no explanation are what triggered this audit finding. |

---

## §7 Environment prerequisites — configuration, not code

| Task | Description |
|---|---|
| **7.1** | Associate `HAAS\svc-scom-vmm` with `Microsoft.SystemCenter.VirtualMachineManager.2012.VMMServerConnectionRunAsProfile`. **Until this is done, Event 8905 cannot be attributed to MP code** — retest after. |
| **7.2** | Reconcile privilege: docs specify VMM **Read-Only Administrator** scoped to host groups/clouds/library servers; the account holds full **VMM Administrator**. Align one to the other and state which. |
| **7.3** | SDN Run As association — only if SDN is intended to be active. If not, §3.2 makes it moot. |
| **7.4** | Add a **prerequisite verification task/report** so a missing Run As association surfaces as an explicit prerequisite failure, not as an obscure type-initializer exception. |

---

## §8 Release and acceptance

1.2.0.0 is sealed and published; it **must not** be modified and republished under the same version.
Ship **1.3.0.0**.

| Task | Description |
|---|---|
| **8.1** | Rebuild, reseal, restage all 13 packs at 1.3.0.0 with a clean `out/development` (1.6 guard green). |
| **8.2** | **Structural acceptance:** all §1 gates green **against shipped sealed content**, not source. |
| **8.3** | **Runtime acceptance** in the audited environment. Exit criteria, using the audit's own metrics as the baseline: Error objects **22 → 0** for non-applicable capabilities; Uninitialized **13 → 0**; unresolved alerts **129 → only genuine findings**; alert repeat count flat, not climbing from 3,142; **zero** 8702/8903/8301/8905/5402 events across a 24-hour soak. |
| **8.4** | Publish release notes stating plainly what 1.2.0.0 claimed versus what it shipped. |

---

## §9 Immediate actions

1. **Rewrite `.ai/state/CURRENT_TASK.md`** — it currently asserts all seven defects resolved. Left
   standing, the next session inherits the false premise that produced this audit.
2. Raise child work items under AB#7319 for §1–§8; §1 blocks the rest.
3. Raise a separate item for the Azure Local `Param[1]` ×4 source defect.
4. Confirm the §5.3 VMM execution decision — it blocks the VMM rework.

## Critical path

```
§1 gates (1.2, 1.3, 1.4 first)
   └─> §5.1 cluster CIM spike ─┐
   └─> §3 applicability ───────┼─> §4 cookdown ─> §2 probe fixes ─> §8 release
   └─> §7.1 VMM Run As ────────┘
                                  §6 360° model (parallel)
```

§1 is not overhead. It is the task that keeps 1.3.0.0 from becoming the next audit.
