# Next-session prompt — finish the 1.3.0.0 management pack

Paste this whole file as the opening prompt of a fresh session, or point a session at it.

---

## Context you are inheriting

Repo: `D:\git\hybrid-solutions-cloud\hybrid-health-monitoring`, branch `main`, clean.
Read `.ai/state/CURRENT_TASK.md` and `PLAN-1.3.0.0-REMEDIATION.md` §0 before touching anything.

A SCOM operational audit of the imported 1.2.0.0 suite found seven runtime defects. Two things went
wrong before you arrived, and you must not repeat either:

1. **1.2.0.0 was published three times under the same version number** (`94c245f`, `e0a1d9e`,
   `ce51a8e`), each with different sealed content. SCOM refuses to import a sealed MP whose version
   already exists, so the environment still runs the original bytes and every later fix is stranded.
2. **Fixes were verified against source templates and a positive-environment test fixture**, never
   against sealed-pack content and never on a host lacking the capabilities. 87/87 + 63/63 + 11/11
   green was compatible with every defect surviving.

Commit `456a8a0` already fixed, in source only: the ATC `RequireNetworkATC` default (15 sites),
10 StrictMode null-collapse sites, 9 fail-open probes, and VMM exception logging. Nothing has been
built or sealed since. Your job is the structural half plus the release.

## Hard constraints — violating any of these makes the work worthless

- **Ship as 1.3.0.0. Never write into `docs/public/downloads/hyper-v-private-cloud/1.2.0.0/` or any
  existing published version directory.**
- **A sealed-MP in-place upgrade cannot remove `ClassType` or `RelationshipType` definitions.** The six
  empty 360° classes stay. Implement them or document them as pending — never delete them.
- **Verify against unsealed sealed-pack content, not source.** A sealed `.mp` is a .NET assembly whose
  `MPResources.resources` holds a `ManagementPack` entry of **gzip-compressed UTF-16LE XML**. `grep` on
  a `.mp` returns zero matches for content that is present. Recipe in `PLAN-1.3.0.0-REMEDIATION.md` §0.
- **Parse-check every scripted edit against its git baseline before writing.** Build the new text in
  memory, run
  `[System.Management.Automation.Language.Parser]::ParseInput($t,[ref]$null,[ref]$errs)`, compare the
  count to `git show HEAD:<path>`, and only then write. Two bulk edits silently corrupted templates
  last session (one swapped every `$` for `a`); `git status` and targeted `grep` did not reveal it.
- PowerShell 7 only (`#Requires -Version 7.0`, `Set-StrictMode -Version Latest`,
  `$ErrorActionPreference = 'Stop'`), Markdown docs only, commits as
  `type(scope): description AB#7319`.
- Confirm before any Azure write, any `az` state change, or installing anything.

---

## Task A — Cluster: replace the PowerShell-host dependency with CIM

**Defect (Event 8301):** the cluster probes report "FailoverClusters PowerShell is unavailable" while
`FailoverClusters 2.0.0.0` is installed, `Get-Cluster` works interactively, both clusters are online,
and agent proxy is enabled. The real problem is the execution host: workflows run under
`%ProgramFiles%\PowerShell\7\pwsh.exe`, and `FailoverClusters` is a Windows PowerShell module whose
WinPSCompat bridge does not reliably initialize under the HealthService account. 1.2.0.0 "fixed" this
by adding `Import-Module FailoverClusters -SkipEditionCheck`, which the audit proved fails with
`Could not load type 'System.Diagnostics.Eventing.EventDescriptor' from assembly 'System.Core'`.

**A1 — Spike first; everything else in this task depends on it.** On one Hyper-V host, running **as
the HealthService account, not interactively as an admin**, confirm:

```powershell
Get-CimInstance -Namespace root\MSCluster -ClassName MSCluster_Cluster
Get-CimInstance -Namespace root\MSCluster -ClassName MSCluster_Node
Get-CimInstance -Namespace root\MSCluster -ClassName MSCluster_ClusterSharedVolume
Get-CimInstance -Namespace root\MSCluster -ClassName MSCluster_Resource
Get-CimInstance -Namespace root\MSCluster -ClassName MSCluster_Network
```

CIM is native to PS7 and needs no module, which is why it is the recommended design — but confirm it
returns under the service identity before committing to it. `root\MSCluster` may require the cluster
CIM provider and elevated rights; if it does not return, say so and stop rather than inventing a
workaround. **Report the actual output.**

**A2** — If A1 succeeds, port these to CIM:
`fragments/capabilities/cluster/Get-HyperVPrivateCloudClusterCsvHealth.ps1.template`,
`Get-HyperVPrivateCloudClusterIntegrationHealth.ps1.template`,
`Discover-HyperVPrivateCloudClusterRelationships.ps1.template`,
`Invoke-HyperVPrivateCloudClusterTask.ps1.template`.
Remove `-SkipEditionCheck` and the `3>$null` warning suppression that hides the real failure.

**A3** — Replace the misleading "the FailoverClusters PowerShell module is missing" message. If a
query fails, report the actual host-context error, not a false prerequisite claim.

**A4** — Map the property surface honestly. `MSCluster_*` field names differ from the cmdlet output
(for example `MSCluster_Node.State` is an integer, not `Up`/`Down`). Do not guess the enumerations —
verify each against the returned objects in A1 and write the mapping into the script as a comment.

---

## Task B — Applicability: stop monitoring what is not deployed

**Correct a mistaken framing before you start.** The audit implied every capability alerts where it
does not apply. That is not what the shipped packs do — measured monitor targets in 1.2.0.0:

| Capability | Monitors | Target | Status |
|---|---|---|---|
| S2D | 16 | Microsoft `…StorageSpacesDirect.StorageSubSystem` | **Already correctly gated — do not touch** |
| VMM | 13 | Microsoft `…VirtualMachineManager.Discovery.VMMManagementServer` | **Already correctly gated — do not touch** |
| SDN | 14 | `HyperVPrivateCloud.Capability.SDN.HostBinding` | Gated, but the gate is wrong — **B1** |
| File Services | 12 | `HyperVPrivateCloud.HostRole` | **Ungated — B2** |
| Storage | 4 of 25 | `HyperVPrivateCloud.HostRole` | Partially ungated — **B3** |
| Network ATC | 3 of 16 | `HyperVPrivateCloud.HostRole` | Partially ungated — **B3** |
| Cluster | 3 of 16 | `HyperVPrivateCloud.HostRole` | Partially ungated — **B3** |

**B1 — SDN: the gate exists but is too permissive and fails open.** In
`fragments/capabilities/sdn/Discover-HyperVPrivateCloudSdnRelationships.ps1.template`:

```powershell
$sdnDetected = -not [string]::IsNullOrWhiteSpace($hostId) -or $ncState -ne 'NotInstalled' -or $slbState -ne 'NotInstalled'
```

Two problems. It is an **OR of three weak signals**, so a present-but-stopped in-box `NcHostAgent`
service is enough to instantiate 14 SDN monitors. And `Get-HcsServiceState` returns `'Unknown'` from
its `catch`, which is `-ne 'NotInstalled'` — so **a failed service query also enables SDN monitoring**.
Replace with evidence of actual SDN participation: a non-empty `HostId` **and** `NcHostAgent` actually
present and configured. Treat `'Unknown'` as not-detected. Confirm against the environment, which has
no Network Controller deployed — the correct result there is zero SDN instances.

**B2 — File Services: all 12 monitors target `HostRole`, so they run on every host.** The environment
has no UNC-hosted virtual disks, so the correct state is NotApplicable and instead it produces false
SMB alerts. Add a participation class discovered only when ≥1 Hyper-V VHD/VHDX actually resides on a
UNC path, and retarget all 12 monitors onto it. Note `Capability.FileServices.SmbShare`,
`SmbClientPath` and `SmbVhdxMapping` classes already exist — check whether one of them is the right
target before creating a new class.

**B3 — Retarget the remaining `HostRole` monitors** (Storage ×4, ATC ×3, Cluster ×3) onto their
capability's participation class. For Storage, gate on the MPIO feature being present **and** ≥1
claimed MPIO disk. For ATC, gate on ≥1 discovered intent — commit `456a8a0` already flipped the
`RequireNetworkATC` default, so this is the structural half of the same fix.

**Follow the existing pattern.** `Capability.Cluster.ClusterRole`, `Capability.SDN.HostBinding` and
`Capability.NetworkATC.NetworkIntent` are all discovery-gated instance classes. Reuse that shape
rather than inventing a new one.

---

## Task C — Cookdown: remove failure amplification

Every monitor currently spawns **its own `pwsh.exe`** via
`HCSV2Library!HyperVPrivateCloud.Pwsh.PropertyBagProbe` (32 consumers) and `Pwsh.DiscoveryProvider`
(20), built on `System.CommandExecuterDiscoveryDataSource` with
`-File "$Config/ScriptName$" $Config/Arguments$`. One VMM initialization failure therefore becomes 11
separate failing workflows, which is what drove the alert repeat count from 2,995 to 3,142.

**C1** — One shared `DataSource` per capability emitting a **single property bag** covering every
facet; monitors then differ only in their `ConditionDetection` expression filter.

**C2 — The blocking design constraint:** SCOM only cooks down workflows whose DataSource configuration
is **byte-identical**. The per-facet `Mode`/`Action` argument passed in `$Config/Arguments$` is
precisely what makes each monitor's config unique, so it defeats cookdown today. Facet selection must
move out of the script argument and into the expression filter. Until that changes, nothing else in
this task works.

**C3** — Apply to VMM (11 facets), File Services (10), Network ATC, Cluster, S2D, Storage.

**C4 — Acceptance:** on a host where a capability's control plane is unavailable, exactly **one**
acquisition workflow runs and **one** error event is written per interval — not one per facet.

**Sequencing:** do Task B and Task C **before** revisiting the File Services / VMM / ATC probe
internals, or those scripts get rewritten twice.

---

## Task D — The 360° object model

Six classes were added in 1.2.0.0: `PhysicalChassis`, `TopOfRackSwitch`, `OutOfBandSwitch`,
`EdgeFirewall`, `ConsoleServer`, `DhcpService`. All are declared in `HyperVPrivateCloud.Library` with a
`DiscoveryClass` entry, and all have **zero instances**. Measured in the shipped pack:

- **Zero unit monitors target any of the six.** The 12 "new" monitors target `HostRole` and write
  states into the host property bag, so the class instances never receive the calculated health.
- `OutOfBandSwitch`, `EdgeFirewall` and `ConsoleServer` have **zero `MPElement` references anywhere in
  the suite** — nothing discovers, monitors or displays them.

**D1** — Adopt a **seed-based discovery pattern**: endpoints and credentials come from configuration
(override-supplied seed), discovery creates instances from the seed, probes target the discovered
object. This is the only workable pattern for devices that cannot host an agent.

**D2** — Implement discovery for `OutOfBandSwitch`, `EdgeFirewall`, `ConsoleServer`.

**D3** — Retarget the 12 new unit monitors from `HostRole` onto the six infrastructure classes.

**D4** — Replace shallow proxies or withdraw the claim. Currently: the host's default gateway is
treated as the edge firewall; local LLDP is treated as full ToR switch health; DHCP is discovered only
when the DHCP service runs locally on a Hyper-V host, which misses the normal topology. Commit
`456a8a0` already stopped these from reporting a fabricated `Good`, but the checks themselves are
still not what the view names claim.

**D5** — Document required endpoint configuration, credentials/Run As, and discovery ownership per
object type.

**D6** — Anything not implemented by release: document as **pending** in the release notes and leave
the view empty-but-explained. Unexplained empty views are what produced this audit finding.

---

## Task E — Release gates (build these; they are why the last release shipped broken)

Add to `tests/unit/HyperVPrivateCloud.Release.Tests.ps1` and the build tooling:

- **E1** `Test-HcsSealedManagementPackContent` — unseal → gunzip → UTF-16→UTF-8, returning parsed XML
  per sealed `.mp`.
- **E2** A shipped-content assertion suite driven by E1, one assertion per defect. **Prove it fails
  against the original 1.2.0.0 assets before trusting it** (`git show 94c245f:<path>`).
- **E3** A **negative-environment probe fixture**: no `NetworkATC`, no `FailoverClusters`, no
  `VirtualMachineManager`, no NC host agent, no MPIO, no UNC-backed VHDs. Every probe must return
  `NotApplicable`, throw nothing, and write no error events. **This gate alone would have caught four
  of the seven defects.**
- **E4** StrictMode scan: any `$x = if (…)` / `foreach` / `switch` assignment whose `.Count`,
  `.Length` or indexer is later read without `@()` normalization. Beware hashtable cases — an `@()`
  wrap breaks them; they need a null guard instead.
- **E5** Fail-open scan: no `catch` may return `Good`/`Success`.
- **E6** Stale-artifact guard: fail if `out/development` differs from a fresh build of current source.
  It is currently stale and still contains the 10 `Param[1]` defects.
- **E7 — highest priority.** Immutable published version: the release tool must **refuse** to write
  into an existing published version directory, and a published `SHA256SUMS.txt` must never be
  modified by a later commit. This is the failure that hid the other six.
- **E8** Default-configuration scan: every `Require<Capability>` default is `false` unless the
  participation class is discovered.
- **E9** PowerShell parse-check of every `*.ps1.template` as a build step, compared against baseline.

---

## Task F — Build, seal and ship 1.3.0.0

- **F1** Rebuild all 13 packs at 1.3.0.0 with `tools/Build-HyperVPrivateCloudManagementPacks.ps1`
  from a clean `out/development`.
- **F2** Seal and package with `tools/New-HyperVPrivateCloudReleasePackage.ps1` (needs
  `-DependencyPath`, `-OutputPath`, `-MsBuildPath`; signing key from Key Vault `kv-hcs-vault-01`,
  secret `hcs-hybrid-health-monitoring-scom-release-private-key`, expected public key token
  `54d0fb1159995c86`). **Confirm with the operator before any Key Vault or Azure operation.**
- **F3** Validate with `tools/Test-HyperVPrivateCloudReleasePackage.ps1 -RequireReleaseEligible`.
- **F4** Stage to `docs/public/downloads/hyper-v-private-cloud/1.3.0.0/` and update `latest/`.
  **Do not touch `1.2.0.0/`.**
- **F5** Release notes must state plainly that 1.2.0.0 was published three times under one version,
  which SHA-256 corresponds to which build, and that only 1.3.0.0 carries the fixes.
- **F6** Ask the operator whether to restore `1.2.0.0/` to its original `94c245f` bytes so the
  published hash matches what was actually released and imported. This is their call, not yours.

---

## Runtime acceptance — the only definition of done

Import 1.3.0.0 into the audited management group in dependency order, then measure against the audit's
own baseline:

| Metric | Audited 1.2.0.0 | Required |
|---|---|---|
| Custom objects in Error | 22 | 0 for non-applicable capabilities |
| Uninitialized | 13 | 0 |
| Unresolved alerts | 129 | Only genuine findings |
| Alert repeat count | 3,142 and climbing | Flat |
| Events 8702 / 8903 / 8301 / 8905 / 5402 | Continuous | Zero across a 24-hour soak |

Before interpreting **any** retest, confirm which build is actually loaded:

```powershell
Get-SCOMManagementPack -Name HyperVPrivateCloud.* | Select-Object Name, Version, TimeCreated
```

---

## Environment prerequisites — not code, but they block attribution

- **Associate `HAAS\svc-scom-vmm` with
  `Microsoft.SystemCenter.VirtualMachineManager.2012.VMMServerConnectionRunAsProfile`.** The account
  exists, is distributed, and holds VMM rights, but is not bound to the profile. **Until this is done,
  Event 8905 cannot be attributed to MP code** — do not claim the VMM defect is fixed before retesting
  with the association in place.
- Reconcile privilege: the docs specify VMM **Read-Only Administrator** scoped to host groups, clouds
  and library servers; the account holds full **VMM Administrator**. Align one to the other.
- Add a prerequisite verification task so a missing Run As association surfaces as an explicit
  prerequisite failure rather than an obscure type-initializer exception.

---

## Two decisions that need the operator, not you

1. **VMM execution model.** PS7-only is a hard rule, but `VirtualMachineManager` is a Windows
   PowerShell module with no CIM equivalent. Either (a) a documented ADR exception permitting a Windows
   PowerShell probe host for VMM workflows only, or (b) move VMM collection off-agent to a dedicated
   collector with a documented identity. **Recommendation: (a)** — narrower blast radius, no new
   deployment surface, and the exception is auditable. Record the outcome as an ADR and amend the
   scripting standard rather than leaving code silently non-conformant.
2. **Whether SDN is intended to be active at all.** If not, B1 makes the SDN Run As question moot.

## How to report back

State what you changed, what you verified and how, and what you could not verify. If a spike fails or a
gate cannot be satisfied, say so plainly and stop rather than working around it — a workaround here is
what produced the audit. Do not claim a defect is fixed on the strength of a green Pester run; the only
evidence that counts is unsealed shipped content plus the negative-environment fixture.
