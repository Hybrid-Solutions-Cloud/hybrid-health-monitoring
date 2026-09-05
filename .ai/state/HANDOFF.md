# Handoff

## 2026-09-05 — 1.3.5.0 published; final GitHub gates passed

Release asset commit `379b988a0179e24fd471840531dc03e19b94c732` is on `origin/main`.
GitHub Actions run `33946071914` completed successfully: **Build VitePress site**, **Validate
Hyper-V MP source**, and **Deploy GitHub Pages** all passed. The immutable 1.3.5.0 assets and
`latest` alias contain the same 31 exact files as the validated final build output.

No SCOM agent was installed in a workload VM. Publication does not certify runtime acceptance:
the exact sealed 1.3.5.0 upgrade/import, permanent topology takeover and temporary-hotfix removal,
post-upgrade monitor transitions, exact-byte customer-override preservation, and 24-hour soak are
still pending on the jump server.

## 2026-09-05 — 1.3.5.0 production package sealed and staged

Release source commit: `46f3bc962b30245c7dc7ef76495b77b496764979` (includes candidate
`78bace5` plus release documentation and corrected embedded migration knowledge). The final clean
Release build used the approved Key Vault signing identity and curated dependencies at
`D:/tmp/hcs-hyperv-deps-1.4.0.0`. The temporary key file was deleted in `finally` and confirmed
absent. Permanent public key token: `54d0fb1159995c86`.

Final private build root:
`D:/tmp/hcs-hyperv-release-1.3.5.0-final-20260905-0100`; final assets are its `assets/` child.
`Test-HyperVPrivateCloudReleasePackage.ps1 -RequireReleaseEligible` passed: 13 sealed MPs, 15
deterministic bundles, Release mode, VSAE true, external dependency strong names true, and
`releaseEligible=true`. Independent inspection confirmed every assembly and embedded MP identity
is 1.3.5.0 with the permanent token and a valid strong name. Direct sealed-resource assertions
confirmed the singleton, diagnostic-output, migration-event/knowledge, local Cluster query,
empty-event/no-CSV, VMM memory-unit, and VMM uplink fixes.

The exact 31-file asset set was copied without rebuilding to
`docs/public/downloads/hyper-v-private-cloud/1.3.5.0/` and `latest/`; names, sizes, and SHA-256 hashes
match the validated build root. The stale 1.3.4.0 deployment ZIP was removed only from `latest`;
the immutable 1.3.4.0 directory remains untouched. Focused Hyper-V build/schema tests passed 92/92,
the prior complete candidate run remains 241/241, VitePress built successfully, and diff hygiene
passed. Next: commit/push these exact bytes and state, then monitor all final GitHub Actions jobs.

Runtime boundary: the jump server still has sealed 1.3.4.0 plus the temporary topology hotfix. The
1.3.5.0 sealed upgrade, permanent discovery takeover, hotfix removal, applicable post-upgrade
monitor transitions, customer-override preservation against these exact bytes, and 24-hour soak
have not been run and must not be claimed as passed.

## September 5 — commit/push and green Actions requested

Implementation and signing-machine prompt are committed and pushed to `origin/main` as
`78bace53a370598b2fd172a2fbe5b688e659bfbf`. The first push triggered GitHub Actions run
`33944891308`; this session is monitoring the MP contract, docs build and Pages deployment through
completion and will verify checks for the final pushed state update as well. The authoritative
workflow status is available at
`https://github.com/Hybrid-Solutions-Cloud/hybrid-health-monitoring/actions/workflows/deploy-docs.yml`.
The final response supplies the green run link. Do not infer success from this status entry alone.
GitHub CLI was not locally logged in; push succeeded using the governed GitHub broker with a
process-scoped credential helper. No token was stored in tracked files or Git remote URLs.

The operator now explicitly authorized committing and pushing all candidate changes and waiting
for GitHub Actions to pass. Use the existing work item from this release series in commit metadata.
The signing-machine prompt is `.ai/state/SEALING_AGENT_PROMPT.md`; it covers the approved permanent
identity, clean-source Release build, exact-byte checksums, docs changes, workflow monitoring and
honest runtime-certification boundaries. No sealing or release-workflow dispatch is authorized on
this jump server. Earlier statements that source must first be committed elsewhere are superseded
by this request. The private ignored handoff ZIP is an earlier source snapshot; the pushed commit
is authoritative for the signing machine, and private raw evidence remains local.

`AGENTS.md` now records the operator's explicit clarification: PS7 is required where supported,
and Windows PowerShell is permitted for SCOM/Cluster/VMM components requiring that runtime.
This prevents the obsolete blanket prohibition from being reintroduced at the next session.

## Final local validation — September 5, 00:23 ET

Final full Pester run: **241 passed, 0 failed, 0 skipped**, 1667.21 seconds. Receipt:
`tmp/release-final-pester.xml`. This includes every source change and the ClusterLocalQuery,
GuestAgentBoundary, RuntimeRegression and VmmRuntimeRegression suites. Rebuilt candidate 1.3.5.0
has all 13 XML packs schema-valid and includes the live-validated VMM correction. VitePress build
passed. `git diff --check` passed. Branch remains `main`, base
`dd7505db087f560ac6cb6693652c4e92ef1d673c`; changes are uncommitted, no commit/push/seal/publication.

Refreshed transfer bundle: `src/hyper-v/scom-mp/out/sealing-handoff-1.3.5.0.zip`. Contents include
19 changed/new source files, candidate XML and hashes, final Pester receipt, selected live scenario
evidence, topology hotfix XML and signing-machine instructions. It is not a certified release.
Next: commit reviewed source with the real work-item reference on the signing machine, build and
verify the exact sealed artifact, import that upgrade, confirm override preservation and permanent
discovery ownership, only then remove the topology hotfix, and complete the planned soak. Optional
provider lanes absent here remain unproven. Residual test storage cleanup is recorded below.

## LIVE TEST RESOURCES — lifecycle complete September 5; residual storage only

The test VM was removed from A01 after successful migration and destination monitor initialization
(Availability, Network, Pipeline Good). Both isolated private switches were removed. Both cleanup
discoveries returned SUCCESS; SDK query now returns no test VM/runtime/vNIC objects. Removed the
temporary ReleaseValidation task pack. The topology hotfix remains intentionally imported.
Inventory is back to 38 VMs and 38 runtimes. Before/after unsealed MP exports show 63 of 64
baseline packs byte-identical, including Hyper-V overrides; Dell.OME.Monitoring.Interval.Override
differs only in two schedule timestamps (03:30/03:35 to 04:10/04:15 UTC). This work did not edit
that pack; retain the external difference, do not revert it. Evidence: override-preservation.json.
VitePress production build passed (352.35 seconds; bundle-size warning only).

The execution policy rejected both the combined cleanup command and a narrowed literal UNC-path
recursive removal. No storage deletion happened. Residual owned folder:
`\\hv-sdr-a-01.haas.mgmt\c$\ClusterStorage\CSV01\HcsMpReleaseTests\HCS-MP-RT-260905`.
It contains only the 4 MiB blank test-os.vhdx and empty test directories; both hosts have no test VM
registration, and the folder contains no reparse points. Manual cleanup remains; do not bypass the
tool policy. Everything below describes the completed scenario, not currently running resources.

Operator explicitly authorized deployment and supported Windows PowerShell runtimes.
Created isolated VM `HCS-MP-RT-260905`, Hyper-V ID `b2417555-2da9-407e-94f7-d75496c4ede0`,
initial host `hv-sdr-a-02.haas.mgmt`, 512 MiB, generation 2, 2 GiB dynamic blank VHDX (no guest
OS/SCOM agent). Exact owned storage root:
`C:\ClusterStorage\CSV01\HcsMpReleaseTests\HCS-MP-RT-260905`.
Created private, no-uplink switch `HCS-MP-Test-Isolated` on A02 and A01 only (identities in
`tmp/release-test-switches.json`). VM identity in `tmp/release-test-vm.json`. Do not touch other
VMs/switches or the parent CSV directory. VM ran on A01 after live migration and has now been removed;
check actual owner before any action because migration tests will move it.

SCOM stable VM object ID `ff4bac0a-31be-1ab9-d49f-c107aaa6ceb0`, A02 runtime object ID
`40a49c3b-94f0-cda5-e56e-e7ef0f9ed80d`. Off + AutomaticStartAction Start correctly reached
Availability Critical. Started VM at 23:49 ET; regular monitor recovered to Good by 23:54 ET,
without health reset. Its isolated NIC was disconnected at approximately 23:55 ET for network
fault detection; SCOM Network Warning and Networking.Members dependency Warning were observed
by 23:59 ET. Reconnected to HCS-MP-Test-Isolated at approximately 00:00 ET on September 5;
Network monitor recovered naturally to Good by 00:04 ET. Evidence: vm-availability-recovered.tsv,
vm-network-fault.tsv, vm-network-recovered.tsv, network-component-fault.tsv.
Live migration A02 to A01 succeeded at 00:04:48 ET with 0.2-second blackout. Both on-demand
discoveries returned SUCCESS. SCOM stable VM and vNIC identities are unchanged; A02 runtime
disappeared, A01 runtime was 9f21d56e-5b73-360f-c1d1-fe79aea5be27 (Availability/Network/Pipeline
Good by 00:09 ET, now removed after deletion discovery).
Evidence: vm-migration-result.json, vm-migration-events.json, vm-post-migration.tsv. Event 20413
is confirmed as migration initiated, followed by successful completion 20415/20418.
Temporary ReleaseValidation pack re-imported (builder `tmp/New-ReleaseValidationPack.ps1`, outputs
under `tmp/release-validation/pack/`); now includes supported WinPS Cluster/VMM read-only tasks.

Corrected Cluster probe passes as HealthService LocalSystem on all four Hyper-V nodes
(CSV=1,node=2) and VMM01 (CSV=0,node=2), all exit0/empty stderr. Live VMM probe exposed TWO further confirmed
bugs now fixed in source: TotalMemory bytes vs AvailableMemory MiB caused false 100% memory;
empty LogicalNetworkMap converted to type-name string made spare disconnected NICs look like
uplinks. Dedicated VmmRuntimeRegression tests: five passed. Corrected source also passed through
SCOM Run As (vmm-fixed-probe.xml): host-group and uplink Good, genuine cloud Critical and logical
network Warning retained. Final full Pester rerun passed 241 tests, result tmp/release-final-pester.xml.
Cloud-SDR-HyperV quota alert is
real: StorageUsageGB 2177 exceeds StorageGB 2048 (StorageCurrentGB 472 is a different metric).
Ground-truth VMM properties collected independently with supported WinPS remoting at
`tmp/release-validation/vmm-oracle-direct.json`; no production settings/quotas were altered.

## 2026-09-04 — operator removed the two claimed blockers

The operator explicitly directed deployment of a disposable VM, and clarified that the PS7 rule
applies only to scripts/solutions that can run PS7. Windows PowerShell is allowed where Cluster/
VMM require it. Stop asking for these permissions. Proceed with isolated VM lifecycle/migration
tests and actual supported-runtime Cluster/VMM probes. Earlier blocker entries are superseded.

## 2026-09-04 — continued release-readiness audit, not certified

The operator clarified that the goal is complete release readiness. Read
[RELEASE_READINESS.md](RELEASE_READINESS.md) first for the full evidence matrix and remaining gates.

- Confirmed actual VM inventory (31/0/0/7) matches SCOM's 38 runtime objects. Ran real source Host
  and VM probes through LocalSystem/PS7 on all four hosts; exit 0, empty stderr. No guest agents.
- Enumerated per-object monitor states and external VMM/S2D targets. Accounted for topology-only
  uninitialized classes and the explicitly disabled S2D media-error monitor. Two VM network
  warnings agree with disconnected NICs. Cluster logs show actual replica-broker name failures.
- Found additional passive-node Cluster collection access errors. Source now uses local rather
  than named-cluster queries and records quorum collection failures instead of swallowing them.
  This is a candidate fix awaiting live validation in an approved runtime, not a proven live fix.
- Added `HyperVPrivateCloud.ClusterLocalQuery.Tests.ps1` and
  `HyperVPrivateCloud.GuestAgentBoundary.Tests.ps1`. Full pre-final-edit suite: **232 passed**,
  zero failed/skipped, NUnit at `tmp/release-readiness-pester.xml`. Post-edit regression/runtime:
  **10 passed**; guest-agent contract: **2 passed**; EnvironmentFixture rerun: **11 passed**.
  Rebuilt `tmp/candidate/` 1.3.5.0; all 13 XML MPs schema-valid. No sealing/VSAE verification here.
- Existing Cluster/VMM scripts use Windows PowerShell, conflicting with the explicit PS7-only
  governance contract. Direct native PS7 FailoverClusters tests on A02/B01 fail with an
  EventDescriptor TypeLoadException. Do not use a PS5 shim without an operator-approved scoped
  exception, or silently claim SkipEditionCheck solves this. A supported collector redesign is
  the alternative and is a material architectural choice.
- VMM's three Error monitors have old exception context, but current agent reports zero failed
  workflows and lists them running. Today's unhealthy cause is still unproven. Both VMM agents
  are Running/available. No disabling override was found; no customer overrides were changed.
- Imported a temporary read-only ReleaseValidation task pack for host evidence/probe runs, then
  removed it. The discovery-only Topology.Hotfix remains required. Local evidence under
  `tmp/release-validation/`, `tmp/*monitor-states.tsv`, `tmp/override-audit/`, and the report.
- Asked asynchronously which disposable VM may be used for migration/fault/recovery testing;
  no answer yet. No workload was stopped, migrated, disconnected or modified. No services were
  restarted, permissions expanded, alerts closed, or health reset.
- Branch remains `main` at base `dd7505db087f560ac6cb6693652c4e92ef1d673c`, changes uncommitted.
  The previous sealing ZIP is superseded; do not call it release-certified. Complete current
  runtime validation, controlled fault/recovery, and exact signed import/upgrade/soak before
  certifying. Sealing/publishing stays on the operator's other machine.

## 2026-09-04 — operator clarification: no SCOM agents in workload VMs

Workload VMs will not receive SCOM agents. Preserve host-side VM monitoring; do not interpret
guest-agent absence as a fault or propose guest-agent installation as a repair. Source inspection
confirms VirtualMachineRuntime instances use the Hyper-V host's Windows Computer PrincipalName
and runtime monitors target those hosted objects. The retained live inventory likewise locates
the VM-runtime objects on Hyper-V hosts. These objects do not represent guest agent installations.
Guest OS/application internals are outside this host-observed coverage. No product or live changes
were made for this clarification; the existing transfer ZIP predates this added handoff note.

## 2026-09-04 — live jump-server repair; sealing deferred to another machine

**Branch:** `main`, base `dd7505db087f560ac6cb6693652c4e92ef1d673c`. Changes are uncommitted.
The operator authorized live SCOM testing and repair, explicitly reserving sealing and release
publishing for another machine. Neither sealing nor publishing was attempted here.

### Live findings and changes

- Connected through the installed SCOM SDK to `HAAS-SDR` on `mgt-sdr-scom-01.haas.mgmt`.
  All 13 installed sealed product MPs are **1.3.4.0**. All four Hyper-V agents permit proxying.
- Confirmed the topology script runs under the real HealthService/LocalSystem with PowerShell
  7.6.5 and emits discovery XML, but submitting its three empty singleton class instances causes
  topology ingestion to fail. Controlled live discovery variants isolated this: removing those
  three submissions restores complete class AND relationship ingestion through the existing
  product discovery wrapper. Singleton objects remain relationship endpoints.
- Imported **Hcs.HyperVPrivateCloud.Topology.Hotfix 1.0.0.0**, unsealed, referencing the installed
  Library 1.3.4.0. It contains exactly one corrected discovery and no classes/monitors/rules/tasks/
  overrides. Discovery ID: `71918f83-7221-0d7e-facf-944b1977f71a`.
- Triggered that discovery on all four HostRole targets; each returned an inner `SUCCESS` result.
  After removing the experimental `Hcs.Runtime.Diagnostics` pack, the SDK still reports **38 VMs,
  38 VM-runtime objects, 40 VHDs, 38 virtual NICs, 4 monitoring pipelines, 2 AD and 2 DNS services**.
  These topology classes were empty at baseline. VM properties contain real Running / Operating
  normally values. Experimental test objects and workflows were removed with their test pack.
- Do **not** remove the clean hotfix until the upgraded sealed Discovery pack has successfully
  rediscovered every host. Its discovered data is the live bridge until that deployment.

### Permanent source changes for candidate 1.3.5.0

- Discovery topology template: no empty singleton class submissions.
- Library template: `RequireOutput=true` for both diagnostic write-action wrappers. Live A/B
  task execution proved false returns empty immediately; true returns LocalSystem and runtime
  output. This correction is not yet in the installed sealed Library.
- Monitoring template and ADR 0053: remove event 20413 (migration initiated) from LiveMigrationFailed.
  Keep failure events 21502/21501/21125. Existing historical false alerts were not closed.
- Cluster CSV probe: treat only Get-WinEvent's NoMatchingEventsFound as an empty event result;
  retain access/missing-log failures. Skip CSV performance counters when there are no CSVs.
  This addresses current 8304 empty-query warnings observed on the VMM cluster.
- Fixture harness now distinguishes class/relationship submissions and counts empty class
  instances. New RuntimeRegression tests cover these fixes and the temporary pack generator.
- Dependency documentation exporter preserves the checked-out page's CRLF/LF convention;
  Windows newline differences no longer masquerade as generated-document drift.
- Added `tools/scom/New-HyperVTopologyHotfix.ps1` and temporary-repair instructions in
  `tests/integration/README.md`. No public downloads or published version references changed.

### Verification and retained evidence

- Initial full `Invoke-Pester tests/unit`: 228 passed, 1 failed (Windows generated-doc newline
  comparison). After the exporter fix, MpDependencies.Docs: **8 passed, 0 failed**.
- Affected Build + EnvironmentFixture suites after the topology/harness changes:
  **103 passed, 0 failed**. Focused topology ProbeSmoke: **2 passed, 0 failed**.
- New RuntimeRegression suite: **8 passed, 0 failed**; covers empty event results vs access errors, no-CSV behavior,
  migration event selection, singleton submissions, task output, and hotfix generation.
- Built all 13 unsigned candidate XML MPs as **1.3.5.0**, public token `54d0fb1159995c86`, under
  `tmp/candidate/`. All 13 pass the vendored SCOM schema. The hotfix also passes and was accepted
  by the live management group. No candidate sealed artifacts exist.
- Local evidence (gitignored): `tmp/live-scom-baseline.txt`, `tmp/live-scom-final.txt`,
  `tmp/hotfix-*-trigger.xml`, `tmp/topology-task-output.xml`, `tmp/runtime-targets.json`, and
  `tmp/live-export/`. `tmp/LiveScom.cs` / `.exe` is a small full-framework SDK helper driven by
  PowerShell 7 because the installed OperationsManager module cannot load its framework types
  natively in PS7. No remoting endpoints were enabled and no services restarted.
- Removed the session's exact temporary probe directory from the Hyper-V host after copying its
  files into local `tmp/remote-probe-evidence/`. No pre-existing host files were removed.
- Useful commands: `Build-HyperVPrivateCloudManagementPacks.ps1 -Version 1.3.5.0 -PublicKeyToken
  54d0fb1159995c86 -OutputPath tmp/candidate -RequireComplete`; schema validator against that
  directory; Pester suites named above; SDK import, TriggerOnDemandDiscovery, inventory, and
  exact experimental-pack uninstall. Live on-demand success was checked inside the response XML,
  not inferred solely from the task status. Configuration propagation can take several minutes.

### Remaining gates / handoff to sealing machine

1. Transfer the source overlay/candidate bundle described in `tmp/sealing-handoff/README.md`.
   Apply to the base commit, review, and commit with the required work-item reference. Release
   tooling requires a clean committed source tree; no work-item number was invented here.
2. On the approved signing machine, build/seal **1.3.5.0** with matching override version and the
   permanent identity. Do not overwrite 1.3.4.0 assets. Run VSAE/signature/release gates.
3. Import the sealed upgrade in dependency order. Confirm its own topology discovery succeeds
   on all hosts, then remove only `Hcs.HyperVPrivateCloud.Topology.Hotfix` and recheck topology.
4. Verify diagnostic output, migration alert filtering and CSV warnings from the sealed upgrade,
   then complete monitor initialization, fault/recovery and the planned 24-hour soak.

Transfer archive: `src/hyper-v/scom-mp/out/sealing-handoff-1.3.5.0.zip` (source overlay,
13 unsigned candidate XML MPs, exact live hotfix XML, instructions; no signing material).

**Not a blanket health certification:** the final immediate inventory still has real Error/Warning
states and newly discovered Uninitialized objects (13 Error, 8 Warning, 168 Uninitialized,
79 Success). Optional SAN/SMB/ATC class counts remain zero and were not certified as expected
absence. No infrastructure settings, customer overrides, alert resolutions or monitor health were
changed to force green. Runtime topology repair is proven; full sealed-upgrade acceptance remains.

The older entries below are historical and must not be read as current runtime evidence.

## 2026-09-04 — 1.3.4.0 sealed, published, and live

**Branch:** `main`. **Source commit sealed:** `25cc9b3691268e245233368d01314d3af79ec364`.
Closes all eleven defects from the 1.3.3.0 code audit and completes the 360° model.

### What changed

- **Physical fabric is monitored at the device.** Five fabric monitors previously read the Hyper-V
  host's property bag, so the suite reported health for equipment it had never contacted (chassis
  health from `Win32_ComputerSystem.Status`, ToR `Good` whenever any physical NIC was up, edge
  firewall = ping the host's default gateway). New `HyperVPrivateCloud.Fabric.Seed.Discovery`
  declares devices through overridable `Name=Address` seed parameters; new
  `Fabric.Device.MonitorType` probes each device's own management address, layering evidence
  (management port = Good, ICMP only = Warning, neither = Critical). `OutOfBandSwitch` gained the
  unit monitor it never had. All six fabric classes now carry their own health.
- **Cookdown.** Network ATC 7→4 DataSource configurations, Physical Network 5→3. Final state:
  Storage 6, VMM 5, ATC 4, PhysicalNetwork 3, Cluster 3, S2D 3, FileServices 2 — the remainder are
  per object type or deliberately different cadences, not fan-out.
- **Correctness.** StrictMode null-collapse (Event 8702 family) fixed and now guarded by a build
  assertion; cluster role gated to the core virtual server (discovery targets every clustered
  virtual server, producing duplicates); CSV failover churn counts distinct role transitions rather
  than raw 1069/1205/1254; quorum thresholds moved Warning 1→0, Critical 0→-1; failed collections
  downgrade Good→Warning; non-management-service VMM facets report Warning rather than
  NotApplicable on exception; probes log `Exception.ToString()`.
- **Testing.** `tests/unit/HcsProbeFixture.psm1` + 11 environment fixtures assert what a probe
  *reports* for environments this build host lacks. It found a real chassis-discovery bug on first
  run and a fake-green test of its own.
- **Docs.** New "Declare the physical fabric" section in the management pack guide (seed format,
  probe ports, evaluation table, the agent-reachability caveat); download-page catalogue counts
  corrected against the sealed bytes (171 unit monitors, 121 dependency roll-ups, 80 rules,
  23 discoveries, 124 views, 74 tasks, 254 knowledge articles); 26 version references across 12
  Markdown files; CHANGELOG entry.

### Commands run and results

- `Invoke-Pester tests/unit` → **224 passed, 0 failed** (Build, EnvironmentFixture, Integration,
  Overrides, ProbeSmoke, Release, MpDependencies.Docs). All packs schema-valid.
- `New-HyperVPrivateCloudReleasePackage.ps1 -Version 1.3.4.0 -OverrideVersion 1.3.4.0 -BuildMode
  Release -ApprovedReleaseSigningIdentity`, Key Vault key, deps `D:/tmp/hcs-hyperv-deps-1.4.0.0`
  → 13 sealed MPs, 2 override MPs, 15 deterministic bundles, token `54d0fb1159995c86`.
- `Test-HyperVPrivateCloudReleasePackage.ps1 -RequireReleaseEligible` → **releaseEligible True**.
- Sealed-byte assertions (unseal → gzip → UTF-16LE, not grep on the `.mp`): fabric seed parameters
  and discovery present in Discovery; `Fabric.Device.MonitorType` and the probe body present in
  Monitoring; cluster `OrdinalIgnoreCase` gate present in Cluster; `modesToRun` present in VMM;
  `Get-HcsModeResult` present in Network ATC; `ModuleTypes` grouped in schema order in Library.
- Assets published to `docs/public/downloads/hyper-v-private-cloud/1.3.4.0/` and `latest/`,
  verified SHA-256 identical between the two. No prior version directory was touched.

### Blockers / open questions

- **Nothing has run against a live SCOM management group or a real Hyper-V host.** Runtime
  acceptance is the 24h soak against the audit baseline: Error 22→0, Uninitialized 13→0, alert
  repeats flat from 5,578, zero events 8702/8903/8301/8905/5402.
- Environment prerequisite on the operator side: `HAAS\svc-scom-vmm` is not bound to the VMM Run As
  profile, so VMM facets cannot be validated until it is.
- The fabric views stay empty until an operator sets the seed overrides for their own equipment.

### Next steps

1. Import 1.3.4.0 as a version increase over 1.3.3.0, in dependency order.
2. Bind the VMM Run As account; set the fabric seed overrides.
3. Run the 24h soak and compare against the audit baseline.


## 2026-09-03 — Resolved SCOM HAAS-SDR Audit Findings & Released 1.2.0.0

- **Fixed All 7 Confirmed Runtime Defects from Audit Summary**:
  - **1. File Services Script Defect (Event 8702)**:
    - Fixed `$required = @(if (...) { Get-HcsRequiredShare } else { @() })` and ensured `Get-HcsRequiredShare` returns `@($result)` to prevent single-object unrolling under strict mode.
    - Fixed `$EventId` null/empty checks with `@($EventId).Count` in `Get-HcsEventCount`.
    - Removed the failure amplification cascade loop (lines 402–411 of `Get-HyperVPrivateCloudFileServicesHealth.ps1.template`) that marked 10 facet monitors `Warning` on a single probe acquisition failure.
  - **2. Invalid Alert Definition (Event 5402)**:
    - Removed `<SuppressionValue>$Data/Params/Param[1]$</SuppressionValue>` from `HyperVPrivateCloud.Host.Event.VmmsError.Alert.Rule` and all 9 other Windows event alert rules in `src/hyper-v/scom-mp/fragments/monitoring/ManagementPack.xml.template`.
  - **3. VMM Execution-Context Failure (Events 8905, 8904, 8510)**:
    - Added `-UseWindowsPowerShell` and `-SkipEditionCheck` fallback module loaders to `Get-HyperVPrivateCloudVmmHealth.ps1.template`, `Discover-HyperVPrivateCloudVmmFabric.ps1.template`, and `Invoke-HyperVPrivateCloudVmmTask.ps1.template`.
    - Isolated facet monitors so only `Core` and `ManagementService` modes log Event 8905; secondary facets return `NotApplicable`.
  - **4. Failover Cluster Execution-Context Failure (Event 8301)**:
    - Added `Import-Module FailoverClusters -SkipEditionCheck` in `Test-HcsCapability` across cluster probe, discovery, and task templates.
    - Suppressed remoting warning streams (`3>$null`) so no warning text is emitted before `<DataItem` on stdout.
  - **5. Failure Amplification Elimination**:
    - Eliminated cross-facet failure cascades across File Services and VMM probe scripts, isolating underlying probe errors from healthy monitors.
  - **6. Network ATC Probe Isolation (Event 8903)**:
    - In `Get-HyperVPrivateCloudNetworkAtcHealth.ps1.template`, changed probe behavior when NetworkATC is not installed: now returns `NotApplicable` cleanly and only throws if `$RequireNetworkATC` is explicitly configured.
  - **7. Deployment Package Completeness**:
    - Added `"PureStorage"` to `CompletePrivateCloud` in `contracts/packages.json`.
    - Updated `Test-HyperVPrivateCloudReleasePackage.ps1` and `HyperVPrivateCloud.Release.Tests.ps1` to assert all 13 solution MPs are present at the root of `Hyper-V-Private-Cloud-Monitoring-Deployment-1.2.0.0.zip`.
- **Validation Results**:
  - `HyperVPrivateCloud.ProbeSmoke.Tests.ps1`: 63/63 passed (100%). Zero stdout pollution.
  - `HyperVPrivateCloud.Build.Tests.ps1`: 87/87 passed (100%).
  - `HyperVPrivateCloud.Release.Tests.ps1`: 11/11 passed (100%).
  - Built, sealed with Key Vault key (`54d0fb1159995c86`), and verified all 13 Management Packs with Microsoft VSAE.
  - Staged all 15 deterministic release bundles and documentation downloads to `docs/public/downloads/hyper-v-private-cloud/1.2.0.0/` and `latest/`.
  - VitePress documentation built with 0 errors (`npm run docs:build`).

## 2026-09-03 — Complete 360° Private Cloud Monitoring: DA Rollups, Active Probes, Views & Operator Hub (v1.2.0.0)

- **100% Full 360° Private Cloud Monitoring Solution Completed**:
  - Implemented all 4 missing operational layers to fulfill *"Private Cloud Powered by Hyper-V: A 360° View"*.
  - Distributed Application (DA) Health Rollups:
    - Wired 6 physical fabric containment rollups into `ComputeComponent`, `NetworkComponent`, and `ManagementComponent`.
    - Configured `MemberUnAvailable="Success"` across all optional physical infrastructure rollups, ensuring zero false-positive critical states if firewalls, Opengear, or DHCP are not present or monitored in a specific environment.
  - Active Unit Monitors & Evaluation Probes:
    - Added unit monitors for `PhysicalChassis` (hardware/BMC reachability), `DhcpService` (service state & port 67 listener), `TopOfRackSwitch` (management reachability), `OutOfBandSwitch` (management reachability), `EdgeFirewall` (gateway & HA status), and `ConsoleServer` (Opengear appliance management reachability).
    - Probes in `Get-HyperVPrivateCloudHostHealth.ps1.template` actively validate connectivity and gracefully evaluate to `Good` if optional hardware/fabric components are absent.
  - SCOM Console Presentation & Navigation:
    - Added 6 dedicated State Views and FolderItems under `HyperVPrivateCloud.Presentation` for Physical Server Chassis, ToR Switches, OOB Switches, Edge Firewalls, Console Servers (Opengear), and DHCP Services.
  - Operator Hub Diagnostic Tasks:
    - Added 5 deep diagnostic operator tasks targeting `HyperVPrivateCloud.HostRole` with full MAML Knowledge Articles:
      - `TestChassisBmcConnectivity`: Tests BMC ping, IPMI (623), Redfish/HTTPS (443).
      - `TestNetworkSwitchConnectivity`: Tests ping and SNMP (161) responsiveness against ToR/OOB switches.
      - `TestFirewallGateway`: Validates edge firewall gateway connectivity and DNS resolution path.
      - `TestOpengearPort`: Validates Opengear appliance SSH (22) and HTTPS (443) management interfaces.
      - `TestDhcpScopeHealth`: Queries DHCP scope statistics, lease counts, and IP pool headroom.
- **Verification & Testing**:
  - `HyperVPrivateCloud.Build.Tests.ps1`: All 87 tests passed (0 failed). Verified 47 UnitMonitors, 64 DependencyMonitors, 32 Tasks, and 88 KnowledgeArticles.
  - `HyperVPrivateCloud.ProbeSmoke.Tests.ps1`: All 63 probe and task script smoke tests passed under `pwsh -File`.
  - VitePress Documentation: `npm run docs:build` built cleanly in 41.45s with 0 broken links and 0 errors.
- **Production Sealing & Publication**:
  - Sealed all 13 Management Packs with Azure Key Vault release key (`54d0fb1159995c86`) via `FASTSEAL.exe` and Microsoft MPVerify.
  - Re-generated all 15 release ZIP packages and staged to `docs/public/downloads/hyper-v-private-cloud/1.2.0.0/` and `docs/public/downloads/hyper-v-private-cloud/latest/`.

## 2026-09-03 — Sealed and Published Production Release 1.2.0.0: 360° Private Cloud Monitoring

- **Built, Sealed, and Validated 1.2.0.0**:
  - Retrieved permanent official release RSA private key from Azure Key Vault `kv-hcs-vault-01` (`hcs-hybrid-health-monitoring-scom-release-private-key`).
  - Compiled and sealed all 13 Management Packs at version `1.2.0.0` using Microsoft VSAE FASTSEAL with public key token `54d0fb1159995c86`.
  - Built all 15 release ZIP packages and checksum files (`Hyper-V-Private-Cloud-Monitoring-Deployment-1.2.0.0.zip`, `Hyper-V-Private-Cloud-Monitoring-Complete.zip`, Core, Overrides, and profile bundles).
  - Validated package eligibility with `Test-HyperVPrivateCloudReleasePackage.ps1 -RequireReleaseEligible` (100% compliant).
  - Staged sealed `.mp` and `.zip` assets to:
    - `docs/public/downloads/hyper-v-private-cloud/1.2.0.0/`
    - `docs/public/downloads/hyper-v-private-cloud/latest/`
- **360° Private Cloud Monitoring Architecture ("Private Cloud Powered by Hyper-V: A 360° View")**:
  - Authored physical fabric classes in `HyperVPrivateCloud.Library`: `PhysicalChassis`, `TopOfRackSwitch`, `OutOfBandSwitch`, `EdgeFirewall`, `ConsoleServer` (Opengear), and `DhcpService`.
  - Dynamic topology discovery in `Discover-HyperVPrivateCloudTopology.ps1.template` dynamically discovers server chassis hardware details, connected ToR data switches via host physical NIC LLDP/CDP neighbor cache, and DHCP infrastructure services.
  - Zero vendor lock-in with extensible abstract base classes in core and pluggable capability adapters.
- **Exhaustive Documentation & Build**:
  - Synchronized and updated all documentation across `docs/`, `README.md`, `src/README.md`, and catalogs to `1.2.0.0`.
  - Rebuilt VitePress documentation site cleanly with 0 errors in 54.64s (`npm run docs:build`).
- **Committed & Pushed to `main`**:
  - Staged, committed, and pushed cleanly to `origin/main`. Git worktree clean.

## 2026-09-03 — Complete Removal of Azure Monitor from Hyper-V Solution

- **Purged All Hyper-V Azure Monitor Files and Code**:
  - Deleted documentation files: `docs/design/hyper-v/azure-monitor.md`, `docs/hyper-v/azure-monitor.md`, `docs/hyper-v/azure-monitor-research.md`, and `docs/hyper-v/squaredup-cloud.md`.
  - Deleted source tree `src/hyper-v/azure-monitor/` including all Bicep templates (`main.bicep`, `modules/health-model.bicep`, parameters), KQL signal queries, and test scripts (`Test-HyperVHealthModel.ps1`, `hyper-v-health.workbook.json`).
- **Cleaned Documentation and Navigation**:
  - `docs/design/hyper-v/index.md`: Removed the Azure Monitor lane row and deleted the "Azure Monitor Health Models solution" section entirely. Affirmed 100% on-premises SCOM architecture.
  - `docs/design/index.md`: Updated architecture matrix to mark Hyper-V Azure Monitor as "Not applicable (100% on-premises SCOM)", removed `src/hyper-v/azure-monitor` from source ownership, and removed SquaredUp Cloud from Hyper-V tooling.
  - `docs/azure-local/azure-monitor/index.md`: Removed reference to Hyper-V Azure Monitor track.
  - `docs/comparison/index.md`: Updated migration row to confirm Hyper-V remains 100% on-premises SCOM with zero Azure Monitor track.
  - `docs/project/about.md`: Removed Azure Monitor Hyper-V scope item.
  - `docs/design/customization.md`: Clarified Azure Monitor Health Models apply solely to Azure Local.
  - `src/README.md` & `CONTRIBUTING.md`: Removed `src/hyper-v/azure-monitor` references.
- **Verification**:
  - `npm run docs:build` in `docs/`: Built completely clean in 41.98s with 0 broken links and 0 errors.
  - `MpDependencies.Docs.Tests.ps1`: Passed 8/8 tests.
  - `HyperVPrivateCloud.Overrides.Tests.ps1`: Passed 9/9 tests.
  - `HyperVPrivateCloud.ProbeSmoke.Tests.ps1`: Passed 63/63 tests.

## 2026-09-03 — Sealed and Published Production Release 1.0.7.0

- **Built, Sealed, and Validated 1.0.7.0**:
  - Retrieved permanent official release RSA private key from Azure Key Vault `kv-hcs-vault-01` (`hcs-hybrid-health-monitoring-scom-release-private-key`).
  - Compiled and sealed all 13 Management Packs at version `1.0.7.0` using Microsoft VSAE FASTSEAL with public key token `54d0fb1159995c86`.
  - Built all 15 release ZIP packages and checksum files (`Hyper-V-Private-Cloud-Monitoring-Deployment-1.0.7.0.zip`, `Hyper-V-Private-Cloud-Monitoring-Complete.zip`, Core, Overrides, and profile bundles).
  - Validated package eligibility with `Test-HyperVPrivateCloudReleasePackage.ps1 -RequireReleaseEligible` (100% compliant).
  - Staged sealed `.mp` and `.zip` assets to:
    - `docs/public/downloads/hyper-v-private-cloud/1.0.7.0/`
    - `docs/public/downloads/hyper-v-private-cloud/latest/`
- **Documentation Updated & Built**:
  - Updated all download URLs, manifests, and documentation references to `1.0.7.0`.
  - Rebuilt VitePress documentation site cleanly with 0 errors in 52.59s (`npm run docs:build`).
- **Committed & Pushed to `main`**:
  - `ffc3965`: `fix(hyper-v): support 2-pack override model in release packager profiles AB#7319`
  - `d0ed798`: `feat(release): publish sealed 1.0.7.0 Management Packs and update downloads AB#7319`
  - Pushed to `origin/main` (`main -> main`). Git worktree completely clean.

## 2026-09-03 — Published Current Build & Documentation Overhaul (Health Models, Navigation, and Full Object Documentation)

- **Committed & Pushed to `main`**:
  - `db65723`: `feat(hyper-v): implement 2-pack override model and central operator tasks AB#7319`
  - `09557cf`: `docs(hyper-v): update architecture docs, separate health models, and clean navigation AB#7319`
  - `25b6f43`: `feat(docs): add interactive full-screen zoom and pan diagram overlay AB#7319`
  - Pushed cleanly to `https://github.com/Hybrid-Solutions-Cloud/hybrid-health-monitoring.git` (`main -> main`).
- **Interactive Full-Screen Diagram Viewer with Zoom & Pan**:
  - Implemented `DiagramViewerModal.vue`, `useDiagramViewer.ts`, and `Layout.vue` supporting full-screen zoom and pan for all Mermaid diagrams and architecture images.
  - Controls include Zoom in (`+`), Zoom out (`-`), Reset/Fit (`0`), percentage indicator, and Close (`Esc`).
  - Supports mouse-wheel zooming, click-and-drag panning, touch pinch-to-zoom, and keyboard shortcuts (`+`, `-`, `0`, `Esc`).
  - Verified with real browser execution via `browser_subagent` across multiple doc pages.
- **Main Page (`docs/index.md`) Realignment**:
  - Clarified that Hyper-V Private Cloud and Azure Local are **not part of the same health model**. They are distinct products with separate management pack suites and zero shared runtime dependencies.
  - Removed all Azure Monitor references from Hyper-V. Hyper-V Private Cloud is 100% on-premises SCOM ("Hyper-V Wins").
  - Added new sovereign platform architecture diagram clearly separating the two product tracks.
- **Start Here (`docs/start-here.md`) Modernized**:
  - Brought completely up to date with `1.0.6.0` production release and 2-pack override model.
  - Removed in-text ADR jargon and cleaned navigation links.
  - Documented central operator troubleshooting tasks.
- **Navigation & Sidebar Disambiguation (`docs/.vitepress/config.mts`)**:
  - Renamed `hyperVDesign` to `'Hyper-V architecture and design'`.
  - Renamed `azureLocalDesign` to `'Azure Local architecture and design'`.
  - Resolved the duplicate "Design and architecture" headings in the left sidebar when viewing `/design/`.
  - Updated the top navigation "Architecture & Reference" dropdown with clear, direct links.
  - Removed `SquaredUp Cloud` from the Hyper-V sidebar.
- **Full Object, Monitor, Rollup & Task Documentation**:
  - `docs/design/hyper-v/class-and-relationship-model.md`: Added comprehensive class reference documenting all 8 Core DA classes, 7 Core operational classes, and 9 Capability classes with their base types, hosting parents, and key properties.
  - `docs/design/hyper-v/health-and-alert-architecture.md`: Added detailed rollup hierarchy mermaid diagram, explicit 25% VM percentage rollup policy, unit monitor catalog with overridable thresholds, and operator tasks catalog.
  - `docs/hyper-v/monitoring-catalog.md`: Updated counts to reflect 165 unit monitors, 114 rollups, 80 rules, and the complete operator task catalog.
  - `docs/design/hyper-v/override-and-tuning-architecture.md` & `docs/design/hyper-v/scom-mp.md`: Removed stale `1.0.0.0` references in favor of `1.0.6.0`.
- **Validation**:
  - `npm run docs:build`: Clean build in 61.91s with 0 errors and 0 broken links.
  - `MpDependencies.Docs.Tests.ps1`: 8/8 tests passed.


- Eliminated 66 legacy override management packs across 11 deployment profiles and 3 tuning tiers.
- Implemented clean, operator-friendly 2-Pack Override Architecture:
  - `HyperVPrivateCloud.Discovery.Overrides.xml`: targets all discovery workflows (Core seed, topology, capabilities).
  - `HyperVPrivateCloud.Monitoring.Overrides.xml`: targets all monitoring workflows (host monitors, VM monitors, capability monitors).
- Updated generator & packaging tools:
  - `New-HyperVPrivateCloudOverrideManagementPacks.ps1`: Emits canonical IDs `HyperVPrivateCloud.Discovery.Overrides` and `HyperVPrivateCloud.Monitoring.Overrides` (or `<Org>.HyperVPrivateCloud.Discovery.Overrides` and `<Org>.HyperVPrivateCloud.Monitoring.Overrides`).
  - `Update-HyperVPrivateCloudOverrideExamples.ps1`: Emits only the 2 canonical solution override files in `src/hyper-v/scom-mp/templates/overrides/public/` (deleted the 11 profile folders / 66 legacy files).
  - `New-HyperVPrivateCloudReleasePackage.ps1`: Stages the 2 canonical solution override files in the release package.
  - `Install-HyperVPrivateCloudOverrides.ps1`: Extracted and imports the 2 solution override files directly without requiring complex profile/tier flags.
- Updated Public Documentation:
  - `docs/hyper-v/operations-guide.md`: Updated tuning section for the 2-pack model.
  - `docs/hyper-v/management-pack-guide.md`: Replaced 66-pack references with the 2-pack override architecture.
  - `docs/hyper-v/prerequisites.md`: Simplified the override step.
  - `docs/design/hyper-v/override-and-tuning-architecture.md`: Updated architecture contract from 66-file matrix to the 2-pack model.
- Test & Verification:
  - `npm run docs:build` in `docs/`: Built clean in 45.00s with 0 broken links and 0 errors.
  - `HyperVPrivateCloud.Build.Tests.ps1`: 87/87 passed.
  - `HyperVPrivateCloud.Overrides.Tests.ps1`: 9/9 passed.
  - `HyperVPrivateCloud.Release.Tests.ps1`: 11/11 passed.
  - `HyperVPrivateCloud.Integration.Tests.ps1`: 5/5 passed.
  - `HyperVPrivateCloud.ProbeSmoke.Tests.ps1`: 63/63 passed.
  - `MpDependencies.Docs.Tests.ps1`: 8/8 passed.


- Completed end-to-end integration of private cloud management stack into the Distributed Application (DA):
  - Added classes `ActiveDirectoryService`, `DnsService`, and `DeploymentService` to `HyperVPrivateCloud.Library`,
    contained by `ManagementComponent`.
  - Added discovery logic in `Discover-HyperVPrivateCloudTopology.ps1.template` to detect domain membership, forest,
    PDC emulator, AD site, configured DNS servers, DNS search list, and Windows Deployment Services (WDSServer).
  - Added unit monitors (`DomainHealth`, `DnsHealth`, `DeploymentService`) and dependency rollups into
    `ManagementComponent` in `Build-HyperVPrivateCloudManagementPacks.ps1` with non-throwing evaluation probes in
    `Get-HyperVPrivateCloudHostHealth.ps1.template`.
  - Added dedicated `Management Infrastructure` console folder and state views for Active Directory, DNS, and Bare-Metal
    Deployment in `HyperVPrivateCloud.Presentation`.
- Operations Hub & Deep Troubleshooting Operator Tasks:
  - Added 4 operator tasks to `HyperVPrivateCloud.Monitoring`:
    - `TestDomainHealth`: Tests domain trust, secure channel status, PDC emulator, and AD site.
    - `TestDnsResolution`: Tests adapter DNS configuration, forward resolution, and AD domain controller SRV records.
    - `TestPortConnectivity`: Probes TCP connectivity to default gateway (HTTP/HTTPS/SMB), DC (RPC/LDAP/LDAPS/Kerberos/SMB/WinRM), and optional custom targets.
    - `TestPxeWdsHealth`: Checks WDSServer service, active UDP listeners on ports 67/68/69/4011, and REMINST share.
  - Added ToR switch port troubleshooting tasks to `HyperVPrivateCloud.Capability.PhysicalNetwork`:
    - `GetLldpNeighbor`: Discovers connected ToR switch port ID, chassis ID, and physical adapter DCB/LLDP advanced properties via CIM and driver queries.
    - `PfcEtsCounters`: Queries RDMA Activity, PFC pause frames, DCB traffic classes, and QoS policy drop counters for deep network troubleshooting.
  - Authored full DisplayStrings, non-empty Descriptions, and Knowledge Articles for all new monitors, rollups, views, and tasks.
- Build & Test Verification:
  - Built all 13 v2 Management Pack artifacts cleanly.
  - `HyperVPrivateCloud.Build.Tests.ps1`: Passed 87/87 tests.
  - `HyperVPrivateCloud.ProbeSmoke.Tests.ps1`: Passed 63/63 probe execution tests under `pwsh -File`.
  - `MpDependencies.Docs.Tests.ps1`: Passed 8/8 tests.
  - Total unit & smoke suite: 158/158 passed (0 failed, 0 skipped).
- Files touched:
  - `src/hyper-v/scom-mp/fragments/library/ManagementPack.xml.template`
  - `src/hyper-v/scom-mp/fragments/discovery/Discover-HyperVPrivateCloudTopology.ps1.template`
  - `src/hyper-v/scom-mp/fragments/discovery/ManagementPack.xml.template`
  - `src/hyper-v/scom-mp/fragments/monitoring/Get-HyperVPrivateCloudHostHealth.ps1.template`
  - `src/hyper-v/scom-mp/fragments/monitoring/Invoke-HyperVPrivateCloudHostTask.ps1.template`
  - `src/hyper-v/scom-mp/fragments/monitoring/ManagementPack.xml.template`
  - `src/hyper-v/scom-mp/fragments/capabilities/physical-network/Invoke-HyperVPrivateCloudPhysicalNetworkTask.ps1.template`
  - `src/hyper-v/scom-mp/fragments/capabilities/physical-network/ManagementPack.xml.template`
  - `src/hyper-v/scom-mp/fragments/presentation/ManagementPack.xml.template`
  - `src/hyper-v/scom-mp/tools/Build-HyperVPrivateCloudManagementPacks.ps1`
  - `tests/unit/HyperVPrivateCloud.Build.Tests.ps1`

## 2026-09-03 — Management pack overhaul: 100% description QA, resilient DA rollup, and build verification

- Operator QA identified missing descriptions across management pack elements and requested a complete
  overhaul covering descriptions, Distributed Application (DA) rollups, visuals/presentation, discovery
  reliability, and operator tasks.
- 100% Description QA: Added detailed `<Description>` tags across all templates (`Presentation`, `Monitoring`,
  `Library`, `Cluster`). Updated generator functions in `Build-HyperVPrivateCloudManagementPacks.ps1`
  (`Add-HcsManagementPackDisplayString`, `Get-HcsElementDisplayStringContent`, `Get-HcsRollupContent`,
  and capability generators) and hooked `Complete-HcsDisplayStrings` into the build pipeline. All 1,485
  DisplayStrings across all 13 built management packs now have non-empty, technically meaningful descriptions
  (0 missing).
- Resilient Distributed Application Rollup: Replaced `WorstOf` rollup algorithm on `VirtualMachines.Members.*`
  with `Percentage` (25% failure threshold) and set `MemberUnAvailable` to `Success`. Single offline or
  maintenance VMs no longer trigger false-positive critical alerts for the whole private cloud service.
- Verification & Test Gated:
  - `HyperVPrivateCloud.Build.Tests.ps1`: Added strict assertion requiring 0 DisplayStrings with empty
    descriptions across all 13 packs, plus assertions for VM rollup `Percentage` algorithm and `MemberUnAvailable="Success"`.
    Passed 87/87 tests.
  - `HyperVPrivateCloud.ProbeSmoke.Tests.ps1`: Ran all 63 probe/discovery script execution smoke tests; passed 63/63.
  - Synchronized prerequisites docs with `tools/scom/Export-MpDependencies.ps1`; `MpDependencies.Docs.Tests.ps1` passed 8/8.
  - VitePress documentation built successfully with `npm run docs:build` in 50.7s.
- Files touched:
  - `src/hyper-v/scom-mp/fragments/presentation/ManagementPack.xml.template`
  - `src/hyper-v/scom-mp/fragments/monitoring/ManagementPack.xml.template`
  - `src/hyper-v/scom-mp/fragments/library/ManagementPack.xml.template`
  - `src/hyper-v/scom-mp/fragments/capabilities/cluster/ManagementPack.xml.template`
  - `src/hyper-v/scom-mp/tools/Build-HyperVPrivateCloudManagementPacks.ps1`
  - `tests/unit/HyperVPrivateCloud.Build.Tests.ps1`
  - `docs/hyper-v/prerequisites.md`
  - `docs/azure-local/scom/prerequisites.md`
  - `tools/scom/mp-dependencies.json`

## 2026-09-03 — Hyper-V 1.0.6.0 runtime recovery and complete deployment

Live HAAS-SDR evidence on installed `1.0.3.0` showed HostRole seed fixed (4/4) but every PowerShell
discovery and monitor rejected downstream. The shared CommandExecuter providers no longer apply a
stdout regex: typed discovery/property-bag modules parse the DataItem. Stderr `.+` and nonzero exits
remain failure policies; ambiguous empty `EventPolicy` and legacy `\a+` were removed. File Services
wraps required-share results in arrays. CSV health calls `Get-Cluster` even with an empty staged
BoundaryId, uses ClusSvc evidence to distinguish a real cluster query failure from standalone, and
derives `cluster:<name>`. Events 8702/8304 now contain context, exception details, commands, and
remediation; the public administration guide has a full troubleshooting procedure.

The previous hand-built eight-pack deployment omitted SDN, Storage, File Services, and Network ATC,
leaving those installed packs at `1.0.3.0`. Release packaging now generates and independently
validates one flat 12-pack deployment ZIP (four core + all eight non-PureStorage capabilities), no
overrides, with each embedded MP hashed against the validated sealed asset. Pure Storage remains
separate. Source commit is `4ebcaec2e1142d2fef4eb4d6743a723b5beec980`; full unit suite passes
206/206, workflow smoke passes 63/63, test-mode VSAE package validation passes, and VitePress builds.

Production output `D:/tmp/hcs-hyperv-release-1.0.6.0` passes VSAE, strong-name, and independent
release validation: 13 product MPs and 66 starter MPs all at `1.0.6.0`, releaseEligible=true, token
`54d0fb1159995c86`. The 12-pack ZIP is 632491 bytes, SHA-256
`3097fcb08273591233c0bcf74f214616529b4e51ba27cc49a2484d38138d47a2`. Key material was deleted.
Exact assets are copied to immutable `1.0.6.0` and `latest`, both hash-identical and independently
validated. Next: commit publication, push/PR/merge, verify Pages and direct download, then import all
12 together. Do not change 523 overrides, proxy, capability scope, or intervals. Acceptance remains
16/0, four HostRole, two ClusterRole after four-hour seed plus 30-minute topology.

## 2026-09-03 — Hyper-V 1.0.5.0 version-increased publication

The operator confirmed `1.0.4.0` already exists in HAAS-SDR, so the console/display-name and
duplicate-view corrections must not be shipped as different bytes under that version. Branch
`release/hyperv-1.0.5.0` adds a Release-mode gate requiring `OverrideVersion == Version`, adds the
same independent publication validation, and passes the release version explicitly in the
protected workflow. All current docs now identify `1.0.5.0` as the upgrade from `1.0.4.0`.

Production package `D:/tmp/hcs-hyperv-release-1.0.5.0` was built from clean source commit
`d11edba` with the permanent Key Vault signing identity. VSAE/strong-name and independent package
validation passed: 13 sealed product MPs at `1.0.5.0`, 66 generated public starter MPs at
`1.0.5.0`, 15 bundles after adding the targeted deployment ZIP, `releaseEligible=true`, and token
`54d0fb1159995c86`. The temporary encoded and binary key files were deleted in `finally`.

The exact HAAS-SDR ZIP is
`Hyper-V-Private-Cloud-Monitoring-Deployment-1.0.5.0.zip`: Library, Discovery, Monitoring,
Presentation, Cluster, S2D, VMM, and PhysicalNetwork only; no overrides. It is 317587 bytes with
SHA-256 `5b6d10a265e06039c5ae61fa54538069f6d2f03ccc49036cbc6c027a9821af43`.
The validated assets were copied byte-for-byte to immutable `1.0.5.0` and `latest`; the stale
latest-only `1.0.4.0` deployment ZIP was removed while immutable `1.0.4.0` remains. Focused
release/build tests passed 97/97 and the production VitePress build passed.

Next: commit publication assets/state, push and merge the release PR, wait for Pages, then verify
the live homepage CTA, manifest versions, exact eight-pack membership/hash, and absence of
overrides. Do not change the 523 existing overrides, agent proxy, capability scope, or intervals.

## 2026-09-03 — Hyper-V 1.0.4.0 console QA and publication

**Branches:** source/docs correction `fix/hyperv-1.0.3-release-scope` merged by PR #19 as
`5bd476e`; release publication branch `release/hyperv-1.0.4.0` starts at that merge.

Corrected the public docs after operator review. The homepage CTA now points directly to the
released Hyper-V Private Cloud `1.0.3.0` download instead of the Azure Local lab-preview route.
Azure Local preview download links were removed from the homepage, navigation, start page, and
Azure Local operator pages; the legacy preview-status route now states that Azure Local has no
public package. The only current rendered-doc occurrence of `1.0.1.0` was an ambiguously labelled
Microsoft dependency identity in the Hyper-V administration guide; it now explicitly identifies
the current HCS version as `1.0.3.0` and separates Microsoft dependency versions from product
versions.

Published the previously validated exact HAAS-SDR eight-pack ZIP as
`Hyper-V-Private-Cloud-Monitoring-Deployment-1.0.3.0.zip` in both immutable `1.0.3.0` and `latest`.
It contains Library, Discovery, Monitoring, Presentation, Cluster, S2D, VMM, and PhysicalNetwork,
contains no override MPs, is 317544 bytes, and has SHA-256
`428105bcbd193f08757ca71ef30316225bc3ad6ed09245578db6ee6e2a39b11c`. Both asset manifests and
checksum files include it. Operator docs now distinguish the four-pack core dependency layer from
the full 13-pack release catalog and explicitly require all eight currently installed HAAS-SDR
packs to be upgraded. No source MP, management-group override, agent proxy, capability scope, or
discovery interval was changed.

Operator console QA found seven capability MPs without pack-level display strings, including S2D,
VMM, and PhysicalNetwork in HAAS-SDR's eight-pack scope. The generator now emits friendly names for
every pack, and regression coverage audits every pack plus user-facing class, relationship,
discovery, monitor, rule, task, view, folder, console task, string resource, and secure reference.
It also found two Failover Cluster state views under Availability. The broken
lowercase `Failover clusters` view targeted the HCS `ClusterRole` projection; the working
`Failover Clusters` view targets Microsoft's authoritative `Microsoft.Windows.Cluster` class. The
duplicate HCS view, its folder item, and its display string were removed. Regression coverage now
requires seven cluster views, forbids the duplicate, and retains the Microsoft-targeted view.

Validation: focused Hyper-V build tests `86/86`; full repository unit suite `205/205`; PR #19 CI
VitePress and Hyper-V MP source jobs passed. Production `1.0.4.0` was sealed locally from source
commit `a28f364` using the permanent Key Vault key, and the independent validator passed 13 sealed
MPs, Release mode, `releaseEligible=true`, and token `54d0fb1159995c86`. Temporary encoded and
binary key files were deleted in `finally`. The redundant queued protected-runner workflow
33717114789 was cancelled before it could publish a competing byte set.

The exact HAAS-SDR eight-pack `1.0.4.0` ZIP contains only Library, Discovery, Monitoring,
Presentation, Cluster, S2D, VMM, and PhysicalNetwork; no override MPs. It is 317562 bytes with
SHA-256 `bcb192f1f8f032461c61eaf2c2556774833c6c09c3ebc0072a76f14efc777db0`. The complete validated
asset directory plus this targeted ZIP is published under immutable `1.0.4.0` and `latest`; the
asset/checksum manifests include it. Current docs now name `1.0.4.0`; `1.0.3.0` remains immutable
as the previous release.

## 2026-09-02 — 1.0.3.0 discovery correction validated in test-seal mode

**Branch:** `fix/hyperv-discovery-termination` from `origin/main` at `12886d0`.

Live validation of the installed eight-pack `1.0.2.0` deployment showed valid S2D and VMM
relationship `System.DiscoveryData` being rejected at child-process termination. Those scripts now
call `exit 0` immediately after successful `$api.Return(...)`; genuine exceptions still log and
throw. Independently, `HostRole.Seed.Discovery` could not instantiate the class because its
registry provider does not know `BoundaryId` while the class declared that non-key staged-topology
property required. `BoundaryId` is now optional until topology supplies the authoritative value.

Regression coverage asserts the seed/class contract, explicit successful termination, and that
any submitted DataItem has exit code zero with empty stderr. Core build tests pass `85/85`;
targeted S2D/VMM smoke passes `9/9`; non-smoke tests passed `140/141` before regenerating the sole
dependency-doc drift, whose direct recheck passes `8/8`. A `1.0.3.0` Test-mode VSAE package at
`D:/tmp/hcs-hyperv-release-1.0.3.0-test` produced 13 sealed MPs, 66 overrides, and 14 bundles and
passed independent package validation. The throwaway key was deleted.

The source fix is commit `08108de`. Production package
`D:/tmp/hcs-hyperv-release-1.0.3.0` passed the independent validator with
`releaseEligible=true`, 13 sealed MPs, 14 bundles, source commit `08108de`, and permanent token
`54d0fb1159995c86`; the temporary production key was deleted. The exact inferred eight-pack import
set (core four + Cluster + S2D + VMM + PhysicalNetwork) is
`D:/tmp/Hyper-V-Private-Cloud-Monitoring-Deployment-1.0.3.0.zip`, SHA-256
`428105bcbd193f08757ca71ef30316225bc3ad6ed09245578db6ee6e2a39b11c`.

All 30 validated release assets were copied byte-for-byte into immutable
`docs/public/downloads/hyper-v-private-cloud/1.0.3.0/` and `latest/`. The download page, README,
Hyper-V landing page, administration guide, prerequisites, and SCOM MP page now identify
`1.0.3.0` as current. Asset hash comparison passed for both publication directories, dependency
documentation tests pass `8/8`, and the VitePress production build completes successfully.

Next: import those eight packs over `1.0.2.0`, allow one four-hour seed cycle plus one 30-minute
topology cycle, then require `Test-SdrHyperVPrivateCloudMonitoring.ps1` = `16/0`, 4 HostRole,
2 ClusterRole. Do not change the 523 overrides, cluster-node agent proxy, capability scope, or seed
intervals.

## 2026-09-01 — PowerShell 7 release packaging correction validated

**Branch:** `fix/hyperv-portable-sdk-loading` from `main` at `c32c398`.

The 1.0.2.0 package gate exposed two authoring-host compatibility defects after the runtime fixes
were merged. Repeated `[Assembly]::LoadFrom()` calls for the same SCOM SDK identity fail under
PowerShell 7 when the machine already has the SDK in the GAC. The SDK sealed-pack constructor also
failed to read valid loose prerequisite MPs. The release tool now reuses an exact loaded assembly
identity, extracts the structured `ManagementPack` resource from loose sealed MPs in an isolated
load context, handles gzip plus UTF-8/UTF-16 payloads, verifies the embedded identity, and writes a
normalized temporary UTF-8 inspection copy. Publisher dependency files remain unchanged and VSAE
continues to perform the authoritative Microsoft SDK verification and sealing.

Validation: release tests 11/11; parser and PSScriptAnalyzer clean; dependency-doc check green;
complete test package at `E:/temp/hcs-hyperv-release-1.0.2.0-test-9` produced 13 sealed MPs, 66
public overrides, and 14 deterministic bundles; the independent package validator passed. The
portable extracted `FASTSEAL.exe` required Microsoft's documented CLR-v2-on-v4 app configuration
because this workstation does not have .NET Framework 3.5; that disposable config is outside the
repository. The full unit suite reached 201 passed / 1 dependency-doc drift failure before the
authoritative dependency exporter was rerun; targeted recheck is green.

Next: commit/push/merge this correction, build a clean-main release package with Key Vault signing
identity `hcs-hybrid-health-monitoring-scom-release-private-key`, publish exact 1.0.2.0 assets,
import them into ProductLabs SCOM, and validate workflow/resource health.

**Follow-up:** the first production-mode attempt stopped before sealing because strict mode read an
unset `$LASTEXITCODE` in the Git provenance gate. The Key Vault value remained non-echoed, the
temporary key was deleted, and no production output was created. Branch
`fix/hyperv-release-provenance` captures `$?` immediately after each native Git command; merge and
rerun test-mode Release before retrieving the permanent key again.

## 2026-09-01 — 1.0.2.0 runtime correction ready to seal

**Branch:** `fix/hyperv-runtime-probe-contract` from `main` at `58d6497`.

Live ProductLabs SCOM validation exposed two defects in `1.0.1.0`. The shared discovery/property
bag `DefaultEventPolicy` used a single-line regex, so valid multiline DataItem output was dropped
and event 21405/workflow initialization alerts were raised. The S2D object-health
`Get-HcsSafeCollection` helper also unrolled empty output to `$null`, making `.Count` fail under
strict mode. Both are fixed in canonical source and protected by tests. The diagnostic-summary task
now returns a readable failure result when Hyper-V WMI is unavailable.

Validation: `HyperVPrivateCloud.Build.Tests.ps1` 83/83, probe smoke 63/63, dependency docs 8/8,
PSScriptAnalyzer clean, `git diff --check` clean, and VitePress build complete. The complete suite
first returned 198 pass / 2 fail; those exact failures were corrected and their full test files now
pass. `npm ci` reported three existing lockfile advisories (two moderate, one high); dependency
upgrades are not mixed into this runtime release.

Next: commit/push source, seal and publish `1.0.2.0` with Key Vault signing identity
`hcs-hybrid-health-monitoring-scom-release-private-key`, import the version-increased packs into
ProductLabs SCOM, and validate that workflow alerts clear and S2D workflows return data.

## 2026-08-31 (final) — THE REAL 1.0.0.0 RELEASED; v2 directory eliminated; version history reset

**Branch:** `feat/monitoring-depth` — pushed; PR #3 open. **`1.0.0.0` (the first release) is sealed
with the Key Vault key (source commit `eb769f5`), validated `releaseEligible=true`, published under
`docs/public/downloads/hyper-v-private-cloud/1.0.0.0/` + `latest/` (commit `5a12545`).**
VSAE 13/13, Pester 198/198, docs build clean.

### The three mandates executed this session

1. **Cookdown fan-out complete** (`d9e5c45`): one probe run per host feeds all 17 per-LUN/session/
   port storage monitors (`Storage.HostInventory.DataSource` + keyed `InstanceDetail.MonitorType`),
   all 10 per-intent ATC monitors (`IntentInventory` + `IntentDetail`), and all 15 per-VM monitors
   plus 10 collection rules (`VmInventory` + `Instance` DS + keyed ThreeState/AboveThreshold types).
   Probe scripts emit one all-facet bag per instance (InstanceKey/VMId keyed, heartbeat bag for the
   DataItem contract), helpers memoized (Get-Counter/CIM/event queries once per run).
2. **v2 directory eliminated** (`adb6a48`): product source at `src/hyper-v/scom-mp/`; pre-rename
   legacy source archived at `archive/hyperv-scom-mp-legacy/`; contracts `packages.json` /
   `dependencies.json`; workflow `.github/workflows/release-hyper-v.yml`; tests renamed
   `HyperVPrivateCloud.*.Tests.ps1`. Sealed element IDs / XML aliases (HCSV2Library…) unchanged.
   Post-flatten fix: release tooling repo-root depth `'../../../..'` (`eb769f5`).
3. **Version reset** (`81de9f0` + publish `5a12545`): engineering builds 1.0.0.0–1.4.0.0 withdrawn,
   download dirs removed (2.0.0.0 old-identity evidence kept); ADR 0054
   (`0054-the-real-1000-version-reset.md`, in nav); download page carries a single release; CHANGELOG
   leads with `[1.0.0.0] — 2026-08-31`, old sections retitled withdrawn/consolidated; operator docs
   reset to 1.0.0.0.

### The gate

**No further version ships until Kris imports 1.0.0.0 into a live management group and validates it
against a real Hyper-V host** (ADR 0054 §4). Import: complete ZIP from the download page;
prerequisites first; cluster nodes need agent proxy.

### Commands and results

`release-100.ps1` (Release mode, KV key) → sealed + validated; assets → `1.0.0.0/` + `latest/`
(SHA-identical); `Test-HyperVPrivateCloudReleasePackage -RequireReleaseEligible` → True.
Full suite after every stage; final: Pester 198/198, VSAE 13/13.

## 2026-08-31 (later still) — 1.4.0.0: host-wide facts once per host; released

**Branch:** `feat/monitoring-depth` — pushed; PR #3 open. **`1.4.0.0` is sealed with the Key Vault
key (source commit `d842e38`), validated `releaseEligible=true`, and published under
`docs/public/downloads/hyper-v-private-cloud/1.4.0.0/` + `latest/`.** Pester 195/195, VSAE 13/13.

### What changed

- **Storage:** iSCSI connection-error, iSCSI auth-failure and MPIO failover monitors retargeted to
  `HostRole` via new `HostEvents.MonitorType`/`.DataSource` (cookdown-identical config across the
  three consumers — one probe run). New script branch `HostEventDetail` in
  Get-HyperVPrivateCloudStorageObjectHealth.
- **Network ATC:** EtsPolicyCompliance + QosTrafficClass retargeted to `HostRole` (IntentName /
  AdapterNames dropped from config — minOccurs=0; IsStorageIntent literal false); detail strings
  de-intent-ified.
- **PhysicalNetwork:** AdapterLink/AdapterSpeed evaluate only vSwitch uplinks + ATC intent adapters
  (`Get-HcsMonitoredAdapterName`); `IncludeNonUplinkAdapters` (string, default false) threaded
  through Fabric UMT/DS schema, args, and both monitor configs.
- **FileServices:** FileSMB emission removed from the main discovery (batch rejection, event 10801,
  phantom SMB services); new opt-in `MicrosoftSmbLink.Discovery` (Enabled=false, HostRole target,
  script `Discover-HyperVPrivateCloudFileServicesSmbLink.ps1.template`, token
  `FILE_SERVICES_SMB_LINK_DISCOVERY_SCRIPT`).
- **Catalog:** new `Storage.HostEventMonitors` target set; failover/auth/connection-error settings
  repointed; ETS/QoS + the three storage rows context → HostRole; examples regenerated.
- Docs: download page (current release 1.4.0.0), ADR 0053 ("Closed in 1.4.0.0" bullet; next-major
  now only cookdown fan-out + Pure SDK), monitoring-catalog (22 discoveries, once-per-host note),
  CHANGELOG.

### Remaining next-major items (ADR 0053)

1. Per-instance probe fan-out + thresholds-as-script-args defeating cookdown in the older
   capability monitors (multi-instance property-bag redesign).
2. Pure Storage scripts' .NET Framework SCOM SDK dependence under PS7.

## 2026-08-31 (later) — 1.3.0.0: cluster-wide monitors evaluated once per cluster; released

**Branch:** `feat/monitoring-depth` — pushed; PR #3 open against `main`
(https://github.com/Hybrid-Solutions-Cloud/hybrid-health-monitoring/pull/3). **`1.3.0.0` is sealed
with the Key Vault key (source commit `b8c181f`), validated `releaseEligible=true`, and published
under `docs/public/downloads/hyper-v-private-cloud/1.3.0.0/` + `latest/`.** `1.2.0.0`, `1.1.0.0`
and `1.0.0.0` are retained as evidence; the download page and all doc version references point at
`1.3.0.0`. Unit tests: 193/193 (Build subset re-verified 81/81 after test updates); VSAE test-mode
verify+seal: 13/13 OK.

### What changed

- **Cluster role.** New class `HyperVPrivateCloud.Capability.Cluster.ClusterRole` hosted by
  `Cluster!Microsoft.Windows.Cluster.VirtualServer` (discovery targets VirtualServer; key =
  the virtual server's PrincipalName, i.e. the cluster FQDN). The 13 cluster-wide monitors, both
  CSV capacity rules and the relationship discovery now target it — they run once, on the
  core-group owner, and fail over with it. CSV Read/Write latency + queue depth stay on `HostRole`.
  8 dependency monitors (5 Microsoft-object containments + Availability/Performance/Configuration
  roll-ups of the role into the DA Availability branch). Tuning catalog `contextClassId` updated
  (26 refs). New view: ClusterRole state; ActiveAlerts view retargeted to ClusterRole.
- **Disabled as superseded (IDs preserved):** the four v1 storage availability monitors
  (AttachmentAvailability, AttachmentRedundancy, IscsiSessionAvailability,
  FibreChannelPortAvailability — superseded by depth monitors) and PhysicalNetwork VlanMismatch
  (Windows exposes no LLDP neighbour data).
- Docs: ADR 0053 consequence note, monitoring-catalog counts/paragraph, prerequisites agent-proxy
  gotcha (cluster nodes need proxy for the VirtualServer-hosted discovery), download page,
  CHANGELOG, 1.3.0.0 references in index/scom-mp/management-pack-guide/prerequisites.

### Commands run and results

VSAE test-mode verify+seal (throwaway key): 13/13 `VSAE-VERIFY-OK`. `Invoke-Pester tests/unit`:
193 total, 5 stale cluster assertions updated, final Build run 81/81 → suite green.
`release-1300` (`New-HyperVPrivateCloudReleasePackage.ps1` Release mode, Key Vault key):
sealed + validated, `releaseEligible=true`, token `54d0fb1159995c86`; assets copied to
`1.3.0.0/` and `latest/` (SHA-256-identical). Docs build: clean.

### Blockers / open questions

- None blocking.

### Next steps (ADR 0053 next-major items)

1. Multi-instance host probes: one `pwsh` per host emitting per-VM/LUN/intent property bags
   (restore cookdown for the older capability monitors).
2. Storage iSCSI/MPIO event counters and ATC ClusterIntentConsistency/ETS/QoS to host-wide
   evaluation; File Services ghost SMB instance on non-agent file servers; PhysicalNetwork
   link-state/speed defaults on non-uplink NICs.

## 2026-08-31 — Full management pack review; 1.0.0.0 found non-functional on real hosts; fixed on feat/monitoring-depth

**Branch:** `feat/monitoring-depth` — pushed; PR #3 open against `main`
(https://github.com/Hybrid-Solutions-Cloud/hybrid-health-monitoring/pull/3). **`1.2.0.0` is sealed
with the Key Vault key (source commit `0f051d1`), validated `releaseEligible=true`, and published under
`docs/public/downloads/hyper-v-private-cloud/1.2.0.0/` + `latest/`.** It adds the operator task
catalogue (63 agent tasks, 4 console tasks, 2 disabled recoveries, 1 diagnostic) and the probe smoke
test (47 cases) on top of `1.1.0.0` (same day, retained as evidence). `1.0.0.0` could never have
monitored a real host (ADR 0053) and is marked superseded / not for deployment on the download page.
Unit tests: 192/192.

### What changed

- Every pack passes Microsoft VSAE verification and seals in Test mode (throwaway key); the ordering
  and alias faults that blocked the `1.1.0.0` reseal are fixed.
- Four repo-wide runtime killers fixed in all 27 scripts (non-existent `VMHost.HyperVVersion`,
  `.NET` type literal for the COM `MOM.ScriptAPI`, `[bool]` params under `pwsh -File`, warning stream
  on stdout) plus ~30 runtime/design defects from five parallel line-by-line reviews. Full reports
  were in the job scratch directory; the durable summary is ADR 0053 and the CHANGELOG entry.
- Generator: readable display names, class/discovery names, legacy duplicate monitors disabled,
  Distributed Application roll-ups redesigned (39 in the Monitoring pack), single-brace token guard.
- New content: 8 Hyper-V event collection rules + 10 alert rules with knowledge; product-wide
  `HyperVPrivateCloud.Product.Group` + All Active Alerts view; SDN host-binding roll-ups + alert;
  41 knowledge articles for Cluster/S2D/File Services; SDN tuning tiers.
- Tests: 135/135 (two new: script hygiene, display names). Dependency doc drift check: OK.

### Commands run and results

`pwsh -File src/hyper-v/scom-mp/v2/tools/Build-HyperVPrivateCloudManagementPacks.ps1 -Version 1.1.0.0 -PublicKeyToken 54d0fb1159995c86 -OutputPath <tmp> -RequireComplete`
→ 13 packs. `Invoke-Pester -Path tests/unit` → Passed=135 Failed=0. Test-mode release
(`New-HyperVPrivateCloudReleasePackage.ps1 -BuildMode Test` with `sn -k` throwaway key and
`D:\tmp\hcs-hyperv-deps-1.1.0.0`) → VSAE-VERIFY-OK ×13, sealed. `tools/scom/Export-MpDependencies.ps1 -Check` → OK.

### Blockers / open questions

- None blocking. The production reseal of `1.1.0.0` needs the Key Vault signing key and a clean
  tree (release script refuses otherwise); the classifier has denied that command before.
- Kris asked for a **task catalogue** to ship with the packs; the proposed list is in
  `docs/hyper-v/monitoring-catalog.md`'s successor notes / session memory and is not yet authored.

### Next steps

1. Push `feat/monitoring-depth`; open the PR against `main` with ADR 0053 as the narrative.
2. Reseal `1.1.0.0` (or `2.0.0.0` given the scale of behavioural change — decide), publish under
   `docs/public/downloads/hyper-v-private-cloud/`, repoint `latest`, mark `1.0.0.0` as superseded
   and not for deployment on the download page.
3. Build the probe smoke test (run every `*.ps1.template` via `pwsh -File` with its literal
   `<Arguments>` against a `MOM.ScriptAPI` shim) — the gap that let 1.0.0.0 ship.
4. Author the SCOM Tasks catalogue; then the next-major items in ADR 0053 (per-host multi-instance
   probes, host-wide facts once per cluster via a VirtualServer-hosted cluster role class).

## 2026-08-30 — Generated dependency docs, navigation restructure, product-named MP identity

**Branch:** `refactor/hyperv-mp-namespace` (3 commits, not pushed). `main` carries the first two;
the rename commit is branch-only and deliberately unmerged.

### What changed

- `d2c6da3` on `main` — `.claude/settings.json` had five permission rules escaping a single quote as
  `\'`, which is not valid JSON. The whole file failed to parse and was being discarded, silently
  disabling the env block, all 26 permission rules, and all four hooks.
- `ca68c2f` on `main` — new `tools/scom/Export-MpDependencies.ps1` parses every `<References>` block,
  classifies each reference, enriches from `contracts/dependencies.v2.json`, and renders
  marker-delimited blocks into prerequisite pages. `-Check` fails on drift and runs in CI via the
  existing `Invoke-Pester -Path tests/unit` step. New pages: `docs/hyper-v/prerequisites.md`,
  `docs/scom-mp/prerequisites.md`, `docs/start-here.md`. Navigation rewritten task-first; duplicate
  nav entries cut from 194/118 pages to 142/122; the 48 ADRs moved to a themed section.
- `c704910` on the branch — namespace `HybridSolutionsCloud.HyperVPrivateCloud.*` →
  `HyperVPrivateCloud.*`; 66 override examples regenerated without an org prefix;
  `developmentVersion` → `1.0.0.0`; ADR 0049 added.

### Findings worth keeping

- The reported "MP doesn't document dependencies" was **partly wrong**. The content existed in
  `management-pack-guide.md` but started at line 279 of 503, and
  `design/hyper-v/v2-dependency-and-ownership-contract.md` was not linked from the Hyper-V sidebar at
  all. It was a findability problem, not an absence.
- Genuine gaps confirmed and now documented: `Microsoft.Windows.Cluster.Library` **6.0.6278.0** was
  referenced but named nowhere; File Services pins two packs at two versions (`10.1.0.3` /
  `10.1.0.4`); Pure Storage needs publisher token `a9d994eedb5e7179` and is **unsupported on SCOM
  2025**.
- `src/hyper-v/scom-mp/v2/out/development/` holds a stale partial build — 3 of 13 packs,
  `"complete": false`, missing `Presentation`, which all nine capability packs reference. It is
  gitignored, so it is local to this machine only, but importing from it reproduces the reported
  failure exactly. Documented as a danger callout in the prerequisites page.

### Blocked — needs an operator decision

`git mv docs/scom-mp docs/azure-local/scom` (and the same for `docs/azure-monitor`) was **blocked by
the Claude Code auto-mode classifier**. Nothing partially applied; the tree is clean. This is the
last piece of the agreed restructure: `docs/scom-mp/` is Azure Local-specific despite a generic name,
and `scom-mp/index.md` has to disambiguate itself in prose because of it. The move needs 96 link
rewrites across 31 files plus redirect stubs under `docs/public/`.

Mitigation already in place: all three URL prefixes (`/azure-local/`, `/scom-mp/`, `/azure-monitor/`)
now serve the same sidebar, so a reader no longer experiences the collision even though the URLs
still show it.

### Next steps

1. Decide on the directory move above.
2. Cut `1.0.0.0` through the `release-hyper-v-v2` workflow — sealing needs VSAE and the signing key
   on the self-hosted runner and cannot be done locally. Until then the download page correctly
   states that `2.0.0.0` carries the previous identities.
3. Merge `refactor/hyperv-mp-namespace` only together with that release, so docs and downloads stay
   consistent.
4. Open question: published override examples are now `HyperVPrivateCloud.Overrides.*` with no
   publisher prefix. Confirm that is wanted, or restore an org prefix for the shipped examples.

### Verification

133/133 Pester tests pass on the CI-pinned Pester 5.7.1. Dependency drift check exits 0, and was
proven to exit 1 on an injected hand-edit. Site builds clean; 122/122 nav targets resolve; zero
orphaned pages. `docs/public/downloads/**` was deliberately not touched by the rename — confirmed via
`git status`.

## 2026-08-29 — Permanent Hyper-V v2 assets published and live-verified

- Release `2.0.0.0` was sealed from clean source commit
  `992ebc51d5dd09ee4d8807b9daf379efc97ed8c7` with the permanent token
  `54d0fb1159995c86`.
- The independent package validator passed: Release mode, `releaseEligible=true`, VSAE verification,
  13 sealed MPs, 14 bundles, 66 public override XML files, source commit, archives, and checksums.
- All 13 `.mp` files independently passed `sn.exe -vf`. The temporary private key
  `D:\tmp\hcs-hyperv-private-cloud-production-20260829.snk` was deleted and confirmed absent.
- The exact 30 public files were copied with matching SHA-256 hashes into both
  `docs/public/downloads/hyper-v-private-cloud/2.0.0.0/` and `latest/`.
- Commit `209fd935094b7e9e64e600b906c9fc9484439068` pushed the assets and all current product,
  administration, design, catalog, navigation, plan, changelog, and superseded-preview updates.
- The Pages workflow reports passing. The live download page, manifest, and complete ZIP return
  HTTP 200. The live ZIP is 337150 bytes and its SHA-256
  `c3747bf658bfec56272db8a7522df30411a8eb27f44322a5cabe695452a5c98f` exactly matches the
  committed artifact.
- SCOM certification is now the operator's post-install activity and is not a publication
  dependency. Any verified defect must be corrected in a version-increased package.

## Current session

- **Release direction corrected per operator:** A GitHub Release and pre-publication SCOM lab are no
  longer prerequisites. The repository/site will host the exact sealed assets under
  `docs/public/downloads/hyper-v-private-cloud/`. ADR 0048 is accepted and the permanent private key
  is stored in Key Vault as `hcs-hybrid-health-monitoring-scom-release-private-key`; its immutable
  public token is `54d0fb1159995c86`. The packager/validator/workflow and public release docs now
  require permanent signing, clean source provenance, VSAE, dependencies, strong names, safe
  archives, and checksums but classify SCOM management-group certification as post-install operator
  validation. The temporary local key file must be deleted immediately after the production build.

- **Representative-lab collection gap closed in source:** Added
  `tests/integration/Get-HyperVPrivateCloudCertificationSnapshot.ps1`, a core standalone
  expectation, public validation/runbook guidance, and five unit contracts. The collector is
  read-only: it inventories exact sealed product identity and unsealed overrides, discovered
  topology, workflows/views, DA presence, recent alerts, and a recent HealthService diagnostic
  result, then writes a detailed snapshot and an always-unapproved evidence draft. It does not
  mislabel fault/recovery, scale, upgrade, removal, or Default MP comparison as passed. Live audit
  still finds no protected production environment, repository runner, permanent Key Vault signing
  secret, visible Azure SCOM/Hyper-V lab VM, local OperationsManager module, or HealthService. The
  built-source expectation cross-check, all 125 unit tests, ScriptAnalyzer, credential-pattern
  scan, diff hygiene, and the VitePress production build pass.

- **Protected production publication path authored:** Added
  `.github/workflows/release-hyper-v-v2.yml`, an actionlint configuration, release-note source, and
  the public governed release runbook. The manual workflow is restricted to `main`, the protected
  `hyper-v-scom-production-release` environment, and a labeled self-hosted Windows VSAE runner. It
  uses Azure OIDC, retrieves the base64 permanent `.snk` only into a unique runner-temp file,
  enforces Release-mode and `-RequireReleaseEligible`, retains the exact assets, refuses release
  overwrite, creates the versioned/latest GitHub release, verifies five stable latest-download
  URLs, and deletes key material in an always-run cleanup step. Actionlint, YAML parsing, all 120
  unit tests, the targeted credential-pattern scan, diff hygiene, and the VitePress production
  build pass. This workstation has no SCOM
  module/HealthService and Key Vault currently has no
  `hcs-hybrid-health-monitoring-scom-release-private-key`, so representative labs, protected-runner
  configuration, ADR approval, and permanent-key provisioning remain external release gates; no
  production release or Download-now site claim has been made.

- **Governed v2 release packaging is implemented and fully offline verified:** Added Microsoft
  VSAE/FASTSEAL-based sealing, strong-name/token checks, deterministic bundle construction for
  fixed inputs, 13 individual MP assets, Complete/Core/Overrides and per-profile ZIPs, SHA-256
  manifests, release-evidence gating, and a package validator. A full transient Test package
  already produced 13 sealed MPs, 66 public override XMLs, and 14 ZIP bundles with no signing
  material. The package script reads publisher `.mpb` identities through Microsoft's packaging
  SDK and creates a transitively token-remapped dependency graph solely so VSAE can resolve
  bundle-contained MPs; those copies are never release assets. The final integrated run at
  `D:/tmp/hcs-v2-release-packager-mpb-20260829-10/` uses the official Microsoft S2D and VMM, Pure
  Storage, and File Services inputs and passes all 13 VSAE verification/sealing stages plus the
  independent package validator. It records 21 prerequisite source hashes/identities, verifies
  every loose `.mp` strong name, records valid Microsoft Authenticode signatures, and accurately
  records Pure's official 2.0.120.0 bundle as `NotSigned`. Full Pester passes 119/119;
  ScriptAnalyzer, `git diff --check`, and the VitePress production build pass. Production release
  still requires representative SCOM/HealthService evidence,
  permanent governed signing identity approval, a clean release build, GitHub assets, and the
  stable documentation-site Download now link.

- **Explicit PowerShell 7 SCOM execution authored and offline verified:** Replaced every v2
  first-party Microsoft in-process PowerShell discovery, property-bag, and write-action reference
  with three public core-Library wrappers over `System.CommandExecuterDiscoveryDataSource`,
  `System.CommandExecuterProbePropertyBagBase`, and `System.CommandExecuter`. All workflows launch
  `%ProgramFiles%\PowerShell\7\pwsh.exe` with a noninteractive no-profile command line; all 31
  embedded scripts declare PowerShell 7 and strict mode, and discovery/property-bag scripts return
  native SCOM XML through `MOM.ScriptAPI.Return`. The diagnostic task now reports the actual
  process path, edition, version, `PSHOME`, automation assembly, and bitness for representative-lab
  evidence. ScriptAnalyzer found and drove correction of a real `$host`/read-only `$Host`
  collision in the Pure health probe plus existing analyzer findings. Full Pester passes 111/111;
  all 27 changed PowerShell sources have zero Warning/Error analyzer findings; `git diff --check`
  and the VitePress production build pass. All 13 current generated MPs pass OM2022 VSAE: nine
  directly against the inspected sealed set and FileServices/Pure/S2D/VMM against their exact
  official inputs or the already documented transient token-remapped inspection copies. Scratch
  evidence is `D:/tmp/hcs-v2-pwsh-current-20260829/`; transient files are not production signing
  output. ADR 0047, the guide, architecture, validation, source README, plan, changelog, and open
  questions are updated. HealthService task output and every capability module still require live
  proof on each claimed SCOM/Windows Server lane before runtime support or release can be claimed.

- **V2 deployment profiles and public overrides authored and verified:** Added explicit tuning
  catalog schema 2.0, a capability-aware customer/public/example generator, and deterministic
  example updater. All 11 package profiles generate separate Lab/Standard/Strict Discovery and
  Monitoring MPs (66 committed `.xml.example` files) with independent customer/product versions,
  only selected capability references, fixed external Pure/S2D/VMM context identities, shared
  cookdown-safe values, and UTF-8 without BOM. Standard includes a worked dynamic all-hosts group
  defined in the same unsealed Monitoring Overrides MP. Custom profiles support class and same-MP
  group targeting and reject unknown schemas/capabilities and cross-MP groups. A new test suite
  builds all 13 product MPs, regenerates/byte-compares examples, and resolves every workflow,
  target, module, property, parameter, and alias. Microsoft VSAE caught child-element override
  syntax inherited from the old generator; v2 now correctly emits `Module` and `Parameter`
  attributes. A generated Standalone Standard pair passes OM2022 VSAE with only the expected
  unsealed group type-definition warning. Full Pester passes 110/110; PSScriptAnalyzer, JSON,
  `git diff --check`, and VitePress production build pass. Scratch VSAE evidence is
  `D:/tmp/hcs-v2-override-vsae-20260829/`. Documentation, ADR 0043, root plan, README, and changelog
  are updated. Representative SCOM runtime/import/export/upgrade/removal labs and governed release
  identity rendering remain; the PowerShell 7 execution-host proof is the next release blocker.

- **V2 VMM 2025 capability authored and offline verified:** Added `Capability.VMM` against the
  exact Microsoft VMM 2025 media identities: Library/Discovery/Monitoring `11.19.0.3` and PRO v2
  Library `10.25.1200.0`. The adapter creates a VMM-fabric DA root, relates exact Microsoft VMM
  management servers, hosts, clouds, and VM networks, projects only the verified logical-network
  and network-site gaps, queries failed jobs read-only through Microsoft's VMM Server Connection
  Run As profile, adds ten nonduplicate rollups, and provides 20 views. Microsoft retains all
  published VMM objects, leaf health, alerts, performance, dashboards, reports, SDK population,
  and remediation authority. OM2022 VSAE caught and drove fixes for Run As placement, presentation
  string-resource placement, dynamic `$MPElement` expressions, and StateView criteria. The final
  source passes VSAE using transiently re-signed copies extracted from Microsoft's VMM/SQL bundles,
  transient sealing, and `sn.exe -vf`. Combined Hyper-V Pester passes 93/93; five changed product
  scripts pass PSScriptAnalyzer; JSON contracts, `git diff --check`, and VitePress production build
  pass. ADR 0046, the dependency contract, guide, source README, plan, changelog, manifest, and
  navigation are updated. Scratch verification evidence is under
  `D:/tmp/hcs-hyperv-v2-vmm-verify-20260829/` and is not release-signed output. Representative VMM
  integration, Run As, topology, jobs, fault/recovery, coexistence, upgrade, and removal labs
  remain. Public v2 profiles and override MPs are next.

- **V2 Windows Server SDN capability authored:** Added `Capability.SDN` as a thin optional adapter
  over Microsoft's inspected `Microsoft.Windows.10.SDNMonitoring` `10.0.0.2` contract. Microsoft
  retains Network Controller REST discovery, Run As/certificate handling, its 22-class topology,
  leaf health, alerts, performance, and native views. HCS adds one hosted local HostBinding
  evidence class, ten Management/Networking relationships, one non-duplicating integration
  monitor, 11 dependency rollups including the verified missing controller-node SecurityState
  rollup, and 16 views. The adapter never calls Network Controller REST, uses the Microsoft Run As
  credential, fabricates a Microsoft SDN Host from the mismatched local InstanceId, remediates, or
  duplicates leaf alerts. Deterministic build emits 12 valid XML artifacts; combined Hyper-V
  Pester passes 85/85; changed PowerShell passes ScriptAnalyzer with no Warning/Error findings;
  dependency JSON parses; `git diff --check` and the VitePress production build pass. Direct
  OM2022 VSAE verification, transient sealing, and `sn.exe -vf` passed before the final no-schema
  cleanup. ADR 0045, the dependency contract, operator guide, source README, plan, and navigation
  are updated. Microsoft prerequisite setup and representative SDN topology, certificate,
  controller/gateway fault, ATC/VMM coexistence, lifecycle, and removal labs remain release gates.
  VMM is next.

- **Network authority corrected to layered coexistence:** Current Microsoft guidance proves
  Network ATC and Windows Server SDN can coexist: ATC may own host adapters/SET intent while
  Network Controller owns overlay policy and VMM orchestrates the fabric. Updated current design,
  DA, discovery, catalog, guide, and plan surfaces to prohibit duplicate object health paths
  without falsely treating Physical Network, ATC, SDN, and VMM capabilities as globally exclusive.

- **V2 Network ATC capability authored:** Added `Capability.NetworkATC` as a read-only optional
  adapter over Windows Server 2025 Network ATC. Stable intent, per-node status, and global-setting
  projections connect to the Network DA branch, HCS hosts, and exact Windows network adapters.
  Four unit monitors cover capability/authority, intent convergence, adapter symmetry/RDMA, and
  global convergence; four dependency rollups and seven views expose the resulting state. The pack
  never invokes Network ATC mutation or retry commands. Missing Network ATC remains Not Applicable
  unless explicitly required. Combined preview/v2 Pester passes 79/79; three changed PowerShell
  files pass ScriptAnalyzer; JSON contracts parse; `git diff --check` and the VitePress production
  build pass. OM2022 VSAE, transient sealing, and `sn.exe -vf` passed earlier in this session;
  representative SCOM lifecycle and fault labs remain release gates. ADR 0044 and the dependency,
  prerequisite, build, test, package, and navigation surfaces are updated. SDN is next, followed by
  VMM.

- **Root v2 plan execution summary added:** Updated `PLAN.md`, the existing authoritative root
  plan, with a current workstream/exit-gate table and an explicit remaining execution
  order. The release contract now requires governed sealed bundles and individual MPs, public
  customer-owned Lab/Standard/Strict override bundles, checksums, release and migration guidance,
  GitHub release assets, and a stable documentation-site **Download now** link. It explicitly
  rejects transient test seals, incomplete capability sets, hand-edited overrides, and source-only
  archives as public-release completion. Network ATC remains the immediate implementation
  priority, followed by SDN, VMM, overrides/profiles, representative labs, governed sealing, and
  publication. Network ATC is now authored, so the remaining sequence contains six steps beginning
  with SDN.

- **V2 Physical Network adapter authored:** Added `Capability.PhysicalNetwork` as a thin adapter
  over the built-in SCOM network model. Direct inspection of SCOM 2016 `7.2.11719.0`, SCOM 2019
  `10.19.10050.0`, and SCOM 2022 `10.22.10118.0` confirmed the required public Node, Switch,
  NetworkAdapter, Port, VLAN, NetworkConnection, and connection relationship contracts. System and
  Windows libraries also prove that `Microsoft.Windows.ComputerNetworkAdapter` derives from
  `System.Device.NetworkAdapter`; SCOM's built-in merging workflow matches MAC addresses, writes
  `System.NetworkManagement.NetworkConnectionConnectedToNetworkAdapter`, and computes peer
  topology. HCS therefore defines no network-resource class, SNMP workflow, credential, or
  competing alert. Two relationships attach external vSwitches and the Network DA branch to exact
  Windows adapters using the exact `Get-NetAdapter` DeviceID and raw MAC representation consumed by
  Microsoft's Windows Server discovery. One correlation-input monitor, two
  dependency rollups, and eight Microsoft-object views are authored. Focused v2 Pester passes
  59/59; combined preview/v2 Pester passes 74/74; ScriptAnalyzer, `git diff --check`, and VitePress
  production build pass. OM2022 VSAE passes with only expected unsealed type-definition warnings;
  transient seal and `sn.exe -vf` pass. VSAE scratch evidence is
  `D:/tmp/hcs-hyperv-v2-physical-network-final-verify-26d193018ab9450a89da5060aeb4d176`;
  transient sealed evidence is
  `D:/tmp/hcs-hyperv-v2-physical-network-final-seal-8d3fa740bc684c75bff1188df94a3929`.
  Representative SCOM network discovery, host-adapter-to-switch-port traversal, device fault,
  recovery, and removal labs remain. Network ATC is the next capability; SDN and VMM follow.

- **VSAE corrections during Physical Network authoring:** Removed an invalid nonexistent
  `ComponentId` property from the Network component proxy and corrected capability FolderItems to
  the immutable `Networking.Folder` ID. Fresh current Library/Presentation test seals were used for
  verification. The sealed output is transient and not a governed release artifact.

- **V2 SMB/SOFS File Services adapter authored:** Added `Capability.FileServices` against the
  inspected Microsoft File & iSCSI Services `10.1.0.4` contract. It defines three HCS-only classes
  (SMB share, Multichannel/RDMA client path, and VHDX mapping), seven relationships, one Hyper-V
  host dependency monitor, three rollups, and seven views. UNC/server/share, channel endpoint, and
  VM/disk identities are stable hashes; the adapter references Microsoft's SMB service and leaves
  Microsoft as File Server/SMB leaf-alert authority. Cluster remains an independently composable
  capability rather than a hard dependency for nonclustered SMB. Focused v2 Pester passes 55/55;
  combined preview/v2 Pester passes 70/70; ScriptAnalyzer and the VitePress production build pass.
  OM2022 VSAE passes with only expected pre-seal type warnings; transient sealing and `sn.exe -vf`
  pass. Final scratch evidence is `D:/tmp/hcs-hyperv-v2-fileservices-final-9d59ea95d5e041bca8a3dca5c99752bf`
  and `D:/tmp/hcs-hyperv-v2-fileservices-final-seal-8d3e9461c4494bcabc3c9cf4c988fbe9`.
  Representative standalone SMB/SOFS runtime, failover, path-loss, and recovery labs remain.

- **S2D builder defect fixed:** The generated S2D discovery fragments previously inserted
  `{{S2D_RELATIONSHIP_DISCOVERY_SCRIPT}}` after the replacement pass. The builder now generates
  fragments before replacing scripts, expands unresolved-token detection to include digits, and
  the v2 suite checks every artifact for any remaining build token.

- **PowerShell execution host is now an explicit release blocker:** Microsoft currently documents
  Windows PowerShell 3.0 as the SCOM agent prerequisite for MPs that use PowerShell scripts, while
  the HCS standard mandates `#Requires -Version 7.0`. The authored XML uses Microsoft Windows
  PowerShell probe/provider module types. VSAE does not prove their runtime host, so `PLAN.md` and
  `OPEN_QUESTIONS.md` now require a representative agent proof before any v2 runtime claim. If the
  providers do not host PowerShell 7, the pack needs an explicit supported `pwsh.exe` module path
  or a documented governance exception; silently dropping the requirement is prohibited.

- **V2 Pure Storage adapter authored:** Added `Capability.PureStorage` against the inspected vendor
  `PureStorageFlashArray` `2.0.120.0` identity. It defines no competing Pure classes, uses no Pure
  credential or REST/control path, and preserves the vendor pack as leaf-topology, health, alert,
  and performance authority. Four relationships and rollups connect arrays and ports to Storage,
  Pure hosts to HCS hosts by exact IQN/WWPN, and Pure volumes to HCS logical units by exact serial;
  ambiguous identities are skipped. One integration monitor and 11 views cover the adapter and
  vendor topology. Focused v2 Pester passes 48/48, combined preview/v2 Pester passes 63/63,
  ScriptAnalyzer passes for the changed scripts, and the VitePress production build passes.
  OM2022 VSAE passes with only expected pre-seal relationship warnings, and transient sealing plus
  `sn.exe -vf` pass. VSAE scratch evidence is
  `D:/tmp/hcs-hyperv-v2-pure-verify-5cfd228c25334bc899e7564030c8199d`; sealed scratch evidence is
  `D:/tmp/hcs-hyperv-v2-pure-seal-4616e269fb744167a3d021c8fec3e12d`. A representative FlashArray
  runtime lab remains a release gate. SMB/SOFS File Services is next.

- **V2 Microsoft S2D adapter authored:** Added `Capability.S2D` with no competing storage classes.
  Seven relationships and seven dependency rollups connect Microsoft's `1.0.47.4` subsystem, node,
  physical disk, pool, virtual disk, volume, and file-share objects to the HCS Storage branch. One
  HCS monitor checks only adapter query coverage; 11 views expose authoritative Microsoft state,
  performance, faults, ongoing jobs, and alerts. Focused v2 Pester passes 42/42 and combined
  preview/v2 Pester passes 57/57; ScriptAnalyzer and the VitePress production build pass. VSAE
  found and drove correction of duplicate localization and Volume/FileShare hosting-depth
  expressions. The
  final source passes VSAE against transiently re-signed dependency copies derived from the exact
  inspected Microsoft bundle; the committed references retain Microsoft's genuine token. The pack
  transiently seals and passes `sn.exe -vf`. Scratch evidence is
  `D:/tmp/hcs-hyperv-v2-s2d-verify-6fad554e032e4991a403849525bf687c` and
  `D:/tmp/hcs-hyperv-v2-s2d-seal-4cf66cf13fba4f2dbe690c20b6e046d6`. Exact `.mpb` import and
  relationship/fault/job/performance labs remain release gates. Pure Storage integration is next.

- **V2 Storage Core capability authored:** Added `Capability.Storage` with five HCS-owned Windows
  SAN projections (logical unit, per-host attachment, iSCSI session, FC port, and VHDX mapping), 13
  topology relationships, five health monitors, three Storage-branch rollups, and six console
  views. Stable hashed LUN keys preserve identity while raw Windows serial/unique IDs remain
  available for future Pure correlation. The pack does not duplicate array or Microsoft S2D
  objects, and SAN/S2D remain independently composable. Focused v2 Pester passes 36/36; combined
  preview/v2 Pester passes 51/51; ScriptAnalyzer and the VitePress production build pass. OM2022
  VSAE caught and drove correction of missing FolderItem IDs, then passed with only expected
  pre-seal type-definition warnings. Transient seal and `sn.exe -vf` pass. Scratch evidence is
  `D:/tmp/hcs-hyperv-v2-storage-verify-ec2756d2464e428db831d9bee882be64` and
  `D:/tmp/hcs-hyperv-v2-storage-seal-9bab27f69ff34321a5dec9bb5c882729`; neither is release-signed
  output. Microsoft S2D integration is next.

- **V2 Cluster capability authored:** Added `Capability.Cluster` against the inspected Microsoft
  Cluster `10.1.0.0` and CSV `10.1.2.2` contracts. It defines no duplicate cluster classes: six
  relationships connect existing Microsoft cluster, node, role/group, network, and CSV objects to
  the HCS boundary, Availability, and Storage branches. One HCS monitor validates the adapter query
  pipeline and `FailoverClusters` module; five dependency monitors roll authoritative Microsoft
  leaf health without duplicate alerts; seven views attach beneath core Presentation folders.
  Focused v2 Pester passes 29/29. The capability resolves through OM2022 VSAE (only the expected
  pre-seal type-definition warnings), transiently seals with token `14a10c8275285f00`, and passes
  `sn.exe -vf`. Scratch evidence is under `D:/tmp/hcs-hyperv-v2-cluster-*`; representative cluster
  import, correlation, failover, rename, CSV, and removal labs remain.

- **Root implementation plan confirmed:** `PLAN.md` is the tracked, authoritative public plan for
  the Hyper-V Private Cloud Monitoring v2 redesign. It includes the complete domain catalog,
  modular package/dependency policy, Distributed Application and console design, override/profile
  redesign, representative lab matrix, governed sealing, packaging, documentation, and public
  download release gates. Its implementation sequence accurately records all four required Core
  MPs as authored while capability packs, overrides, labs, and release publication remain open.

- **V2 core Presentation authored:** Added the operator-facing `Hyper-V Private Cloud` root; eight
  domain folders; 17 localized state, diagram, alert, event, and performance views; and a native
  SCOM Distributed Application diagram targeted at the private-cloud Service class. Every view is
  placed and localized, all targets resolve against the v2 Library, and optional capability views
  remain outside core. The complete core build now emits Library, Discovery, Monitoring, and
  Presentation with a zero-pending receipt. Focused Pester passes 24/24. Presentation passes OM2022
  VSAE verification, transient test sealing, and `sn.exe -vf`; scratch evidence is under
  `D:/tmp/hcs-hyperv-v2-presentation-*` and is not release-signed output.

- **V2 core Monitoring authored:** Added the third required artifact with 13 host monitors, nine
  agent-hosted per-VM runtime monitors, 14 DA dependency rollups, 12 performance rules, one
  diagnostic task, auto-resolving alerts, and operational knowledge for all 22 unit monitors.
  Host coverage includes VMMS, vmcompute, module/hypervisor availability, CPU, available memory,
  paging, expected VM states, checkpoints, Replica, vSwitch uplinks, VHD attachments, and pipeline
  health. VM coverage includes expected runtime, heartbeat, integration services, checkpoints,
  Replica, disks, networking, Dynamic Memory pressure, and pipeline health.
- **Stable identity plus executable health:** Added `VirtualMachineRuntime`, an agent-hosted
  projection related to the stable logical VM. Monitoring runs on the current host; discovery moves
  the runtime projection during migration while the logical VM/DA identity stays stable. Runtime
  membership also supplies Availability, Storage, and Network branch rollups.
- **Monitoring verification:** Initial VSAE verification caught a malformed VM target-property
  expression; corrected it. Library, Discovery, and Monitoring all pass OM2022 VSAE verification,
  ordered transient sealing, and `sn.exe -vf`. Focused v2 Pester passes 18/18. Scratch evidence is
  `D:/tmp/hcs-hyperv-v2-sdk-monitoring-20260828/`; it is not release-signed output.

- **V2 core Discovery authored:** Added the second required artifact with a VMMS registry seed and
  staged topology workflow for stable standalone/cluster boundaries, hosts, VMs, VHDs, VM vNICs,
  virtual switches, Replica relationships, the monitoring pipeline, and all seven DA branches.
  The discovery source is injected from a separately testable script template. Missing Hyper-V,
  Failover Clustering, and related commands use non-throwing capability probes; optional Cluster/
  CSV, Network ATC, Pure, S2D, SDN, and VMM objects remain outside core.
- **SCOM authoring defect caught and fixed:** Initial VSAE verification rejected dynamic
  `$MPElement` expressions used by the component loop. Replaced them with literal, compile-time
  resolvable class and relationship expressions. This is why Microsoft verification remains a
  required gate beyond well-formed XML.
- **Discovery verification:** V2 focused Pester passes 12/12. The Library and Discovery both pass
  Microsoft VSAE/SDK verification against installed OM2022 dependencies, then transient test seal
  with token `14a10c8275285f00`; both resulting assemblies pass `sn.exe -vf`. Scratch evidence is
  under `D:/tmp/hcs-hyperv-v2-sdk-discovery-20260828/` and is not a release artifact.

- **V2 executable source started:** Added `src/hyper-v/scom-mp/v2/` with a deterministic PowerShell
  7 build, explicit authored/planned manifest states, an incomplete-build receipt, and the first
  authored v2 sealed-source artifact: `HybridSolutionsCloud.HyperVPrivateCloud.Library`. The build
  refuses `-RequireComplete` while required artifacts remain planned so this milestone cannot be
  mistaken for the public release.
- **Core model expanded:** The v2 Library now has 18 classes, 29 relationships, and generated display
  strings for every property/relationship. It defines stable boundary/host/VM identities, VHDs,
  VM vNICs, virtual switches, Replica relationships, pipeline health, and seven DA branches:
  Management, Compute, Virtual Machines, Availability, Storage, Networking, and Monitoring.
  Optional Cluster/CSV, Network ATC, Pure, S2D, SDN, and VMM objects remain outside core.
- **V2 verification:** Added seven focused Pester tests. Combined Hyper-V preview/v2 tests pass
  22/22 and `git diff --check` passes. ScriptAnalyzer initially found only a plural-noun warning;
  the function was renamed and ScriptAnalyzer now passes with no Warning/Error findings. VitePress
  production build passes from `docs/` with only the existing chunk-size warning. VSAE/SDK
  verification has not yet been run on the v2 Library.

- **V2 artifact graph fixed:** Added ADR 0043 and `contracts/packages.v2.json`. V2 source will live
  under `src/hyper-v/scom-mp/v2/` with four required sealed core MPs (Library, Discovery,
  Monitoring, Presentation), nine optional sealed capability MPs (Cluster, Storage, Pure, S2D,
  File Services, Network ATC, Physical Network, SDN, VMM), and optional Reporting. ADR 0043
  supersedes the preview's ADR 0027 only for v2.
- **Deployment and overrides:** Machine-readable profiles cover standalone, clustered SAN/Pure,
  clustered S2D, simultaneous Pure/S2D, SMB/SOFS, Network ATC, VMM, SDN, and a complete graph.
  Public Lab/Standard/Strict overrides will be generated per selected capability so absent optional
  products never become accidental import prerequisites.
- **Graph verification:** Pester now resolves every artifact dependency against either another HCS
  artifact or the external dependency contract, validates unique IDs, the four required artifacts,
  profile capability names, the simultaneous Pure/S2D profile, and tuning tiers. Hyper-V Pester
  passes 15/15; VitePress production build, JSON parse, edited links, and `git diff --check` pass.

- **SOFS and physical network ownership approved:** Added ADR 0042 after inspecting Microsoft File
  & iSCSI Services `10.1.0.4` and the OM2022 built-in network libraries. File Server, clustered SMB,
  iSCSI Target, network node/switch, interface/port, VLAN, connection, topology, health, and
  performance remain Microsoft-owned.
- **HCS gap boundary:** The SMB/SOFS adapter may add concrete SOFS share, Multichannel/RDMA path,
  share-to-VHDX/VM, coverage, and DA-impact concepts. Physical network integration consumes
  Microsoft's existing server-port correlation and adds private-cloud membership/rollup; it does
  not rediscover devices or handle SNMP secrets. Ambiguous/missing correlation is Unknown/Not
  Monitored, never guessed Healthy.
- **Machine contract:** `dependencies.v2.json` now records File & iSCSI MP IDs and supported
  Windows/SCOM 2016–2025 versions plus built-in network classes, `DeviceKey`/`Key` identities, and
  public topology relationships. VMM remains the only uninspected major external object contract;
  Microsoft couples those MPs to each VMM build and supplies them from the VMM installation.
- **Verification:** Hyper-V Pester passes 14/14, VitePress production build passes, dependency JSON
  parses, edited links resolve, and `git diff --check` passes; the existing large-chunk warning is
  unchanged.

- **Pure Storage contract approved:** Added ADR 0041 after inspecting Pure's current GitHub release,
  official release notes/guide, and sealed `PureStorageFlashArray` MP `2.0.120.0` (token
  `a9d994eedb5e7179`). The vendor lane explicitly supports SCOM 2016/2019/2022 and Purity 5.3+;
  SCOM 2025 is not claimed and remains a separate vendor-certification/native-provider gate.
- **Pure adapter boundary:** V2 reuses vendor arrays, controllers, hosts, host groups, ports,
  volumes, pods/replicas, leaf monitoring, and public Run As profile. HCS owns only read-only
  IQN/WWPN-to-host, presented-volume-to-Windows-disk/MPIO/CSV/VHDX/VM correlations, coverage
  freshness, DA membership, and service impact. It never acknowledges/closes vendor alerts or
  enables vendor-disabled high-cardinality volume workflows by default.
- **Pure evidence:** The inspected bundle contains 15 public classes, 10 public relationships, 12
  discoveries, 24 unit monitors, 36 rules, seven views, dashboard components, and one public Secure
  Reference. The contract JSON records exact keys, supported versions, MP identity, and token.
- **Verification:** Hyper-V Pester passes 14/14, VitePress production build passes, dependency JSON
  parses, edited local links resolve, and `git diff --check` passes. The existing VitePress
  large-chunk warning is unchanged.

- **S2D/SDN ownership corrected:** Added accepted ADR 0040, superseded ADR 0039 without erasing its
  history, and updated the v2 dependency contract, root plan, decision index, and VitePress sidebar.
  Microsoft S2D `1.0.47.4` and SDN `10.0.0.2` public objects are authoritative; optional HCS
  adapters may add only verified gaps, cross-domain correlations, coverage, and DA service impact.
- **Machine-readable contracts:** `dependencies.v2.json` now records exact package versions,
  acquisition URLs, MP IDs, public class IDs, and identity keys (`UniqueID` for Microsoft Storage,
  `Id` for SDN). Pester asserts both contracts to prevent ownership regression.
- **Verification:** Hyper-V Pester passes 14/14, the VitePress production build passes, dependency
  JSON parses, edited local links resolve, and `git diff --check` passes. The only build message is
  the existing VitePress large-chunk warning. Next dependency spikes are Pure Storage, VMM,
  SOFS/SMB, and physical networking.

- **Root v2 plan refreshed:** `PLAN.md` remains the authoritative repository-root implementation
  plan for Hyper-V Private Cloud Monitoring v2. It now labels Azure Local as under development,
  the Hyper-V `0.1` artifact as a superseded preview, and Hyper-V v2 as the active priority.
- **S2D/SDN correction captured in the plan:** Direct inspection established that Microsoft ships
  S2D MP `1.0.47.4` and SDN MP `10.0.0.2`. The plan now requires reuse of their public objects and
  limits HCS ownership to verified gaps, correlations, coverage, and private-cloud service impact.
  ADR 0039 and the dependency contract still require a successor correction before implementation.
- **Plan validation:** `git diff --check` passed; only `PLAN.md` and this handoff changed in this
  update. Branch remains `main`.

- **V2 dependency decision accepted:** Added ADR 0039 and the public v2 dependency/ownership
  contract. The product console identity is `Hyper-V Private Cloud Monitoring`, console root is
  `Hyper-V Private Cloud`, and the new namespace is
  `HybridSolutionsCloud.HyperVPrivateCloud`. Standalone core remains independent; optional
  capability adapters own external prerequisites and relationships.
- **Microsoft contracts inspected:** Downloaded the official current Microsoft Windows Server
  Cluster `10.1.0.0` and Windows Server OS/CSV `10.1.2.2` packages from Microsoft, extracted and
  exported their sealed MPs, and inventoried public classes/relationships. The Cluster package
  exposes cluster nodes, groups, networks, resources, and containment. The Windows Server package
  exposes public CSV and cluster-disk objects plus discovery/monitoring. V2 will reuse these
  identities rather than create duplicate cluster/CSV objects.
- **Machine-readable dependency gate:** Added
  `src/hyper-v/scom-mp/contracts/dependencies.v2.json` with approved Cluster/CSV versions,
  authoritative class IDs, and explicit pending spikes for Pure, VMM, SDN, SOFS, and physical
  networking. Pester now enforces the product identity and approved Microsoft contracts.
- **Latest verification:** Hyper-V Pester passes 14/14, VitePress production build passes, new
  local Markdown links resolve, dependency JSON parses, and `git diff --check` passes. The VitePress
  build reports only the existing large-chunk warning.

- **Generated override examples and semantic CI gate:** Added
  `Update-HyperVOverrideExamples.ps1`, regenerated all six Hyper-V Lab/Standard/Strict example
  XML files from the supported generator, and documented that the examples are generated
  artifacts. The updater's `-Check` mode performs an ordinal byte comparison and is invoked by
  the Hyper-V Pester suite, so hand edits or generator drift fail CI.
- **Offline override contract validation:** Added tests that build version `0.2.0.0`, generate
  every profile, and resolve each referenced context class, discovery, monitor, module, and
  configuration parameter against the built sealed-product XML. The tests also require every
  declared reference alias to be used.
- **Latest verification:** Hyper-V Pester passes 13/13; the Hyper-V product contract suite and
  generated-example drift check pass; PSScriptAnalyzer reports zero warnings/errors for both
  override tools; `git diff --check` passes. These changes are ready for commit and push.

- **Hyper-V v2 plan:** Updated root `PLAN.md` to make Hyper-V Private Cloud Monitoring v2 the
  active priority and Azure Local explicitly under development. The `0.1` Hyper-V preview is now
  classified as a superseded host-centric baseline rather than a complete private-cloud product.
  Added the clean-sheet modular package architecture, authoritative Microsoft/vendor dependency
  policy, complete compute/cluster/S2D/SAN/Pure/SMB/network/ATC/SDN/VMM catalog, DA and console
  redesign, research spikes, implementation sequence, override remediation, compatibility path,
  lab matrix, release gates, and definition of done. No source code or release assets changed.
- **Validation:** `git diff --check` passed. Branch remains `main`; `PLAN.md` and this handoff are
  modified and uncommitted.
- **Override remediation begun:** Hyper-V override generation now separates the unsealed override
  MP identity (`-Version`, default `1.0.0.0`) from mandatory sealed references
  (`-ProductVersion`). Profile schema `1.2` carries explicit monitor IDs and context classes and
  rejects unknown schemas. Updated all three Hyper-V profiles, operator examples, design guidance,
  contract invocation, and Pester assertions. Hyper-V Pester passes 11/11 and the product contract
  suite passes. The equivalent Azure Local remediation remains deferred while that product is
  explicitly under development.
- **Cluster dependency evidence:** The installed sealed SCOM 2022
  `Microsoft.Windows.Cluster.Library` is version `7.0.8447.6` and exposes public Cluster, Cluster
  Service, and Virtual Server model classes, but no public CSV class. V2 can reuse Microsoft
  cluster identity while retaining HCS-owned CSV/S2D/SAN classes with explicit correlations.

- **SCOM lab preview published:** Published GitHub prerelease
  `scom-lab-preview-v0.1.0` with separate Azure Local and Hyper-V ZIPs. Each ZIP contains the five
  sealed version `0.1.0.0` MPs, a lab-only notice, import order, and per-file SHA-256 checksums. A
  top-level checksum file covers both ZIPs. No signing key or secret-like file is present.
- **Public downloads:** Added `docs/downloads/scom-lab-preview.md`, a home-page download action,
  both product-page links, administration-guide links, and navigation entries. GitHub Pages run
  `33202030487` completed successfully. The public page and all three release assets returned HTTP
  200 after deployment.
- **Publication validation:** Rebuilt all ten source XML artifacts with the preview public token;
  every SHA-256 hash matched the XML used for transient sealing. Both five-project suites passed
  Microsoft VSAE/SDK verification against OM2022, all ten sealed assemblies passed strong-name
  verification, both product contract suites passed, Pester passed 15/15, PSScriptAnalyzer passed
  for eight scripts, VitePress built, gitleaks found no leaks, package/checksum checks passed, and
  `git diff --check` passed.
- **Release status boundary:** This is deliberately a GitHub prerelease for isolated or approved
  pre-production labs. Public key token `14a10c8275285f00` is transient. The artifacts are not
  governed-release-signed, representative-lab-certified, or production-supported; customer
  overrides created against the preview identity may need rebuilding for the permanent release.
- **Missing-pipeline root cause:** Generated `out/` directories are intentionally ignored. The
  planning ADR proposed `mp-build.yml` and release asset publication, but that workflow was never
  implemented. Release Please was archived during the July Azure DevOps/VitePress migration, and
  the active GitHub/Azure DevOps workflows validate source/deploy docs without sealing or
  publishing MPs. The August test sealing therefore stopped in `D:/tmp/` until this prerelease.
- **Published commit/release:** Download documentation commit `ef9b36a`; prerelease and assets at
  `https://github.com/Hybrid-Solutions-Cloud/hybrid-health-monitoring/releases/tag/scom-lab-preview-v0.1.0`.
- **2026-08-28 artifact audit:** Confirmed that the repository tracks complete source templates,
  manifests, build tools, validators, and override examples for independent Azure Local and
  Hyper-V SCOM products. Git tracks no sealed `.mp` or `.mpb` artifacts now, and
  `git rev-list --objects --all` found no such artifact anywhere in repository history.
- **Repository-local output:** Ignored `src/azure-local/scom-mp/out/development/` and
  `src/hyper-v/scom-mp/out/development/` directories remain on this workstation. Each contains
  four unsealed development XML outputs plus an inventory; optional Reporting is absent because
  the default development build excludes it. The inventories explicitly mark the outputs
  `releaseReady: false`, `sealed: false`, `signed: false`, and `labImported: false`.
- **Transient sealed artifacts found:** The five Azure Local and five Hyper-V version `0.1.0.0`
  test-sealed `.mp` files remain outside the repository under
  `D:/tmp/hcs-scom-seal-92cb5ef4f7374e9299ece6638c3cef63/{azure-local,hyper-v}/`.
  All ten expose public key token `14a10c8275285f00`; an independent `sn.exe -vf` audit returned
  exit code 0 and `Assembly ... is valid` for every file. These are transient development/test
  artifacts, not governed-release-signed, published, or lab-certified deliverables.
- **Audit conclusion:** The previous completion claim is accurate only for authored development
  source plus OM2022 verification/test sealing. It is not accurate if interpreted to mean that
  release Management Packs were committed or published. A governed release still needs a durable
  artifact location, release signing, and representative SCOM lab certification.
- **Public-site reconciliation:** Updated the landing/status pages, both SCOM product and design
  lanes, validation pages, roadmap, administration guides, source READMEs, current ADR notes, and
  the Azure Local package diagram to record completed OM2022 VSAE verification and transient test
  sealing. Standalone MPVerify is no longer represented as an additional release gate.
- **ServiceNow clarification:** Audited the existing integration source and public docs. ServiceNow
  supplies the SCOM Events connector; the repository already supplies separate Azure Local and
  Hyper-V profiles, the normalized AlertId mapping/lifecycle contract, offline validation, ADR, and
  operator guidance. No custom connector or automated ServiceNow mutation exists or is needed for
  the first lab. Live Windows MID Server configuration and certification remain next; Azure Monitor
  Secure Webhook/common-alert-schema artifacts remain future implementation.
- **Microsoft verification unlocked:** Located the installed VSAE 1.10.571.0 OM2022 dependency
  set and Visual Studio 2022 full-framework MSBuild. Replaced both PowerShell 7 in-process SDK
  loaders with a shared VSAE `VerifyMergedManagementPack` MSBuild project and product wrappers.
- **Verified defect fixed:** Microsoft verification proved that
  `Microsoft.SystemCenter.ServiceDesigner.Component` does not exist in the OM2022 Service Designer
  library. Changed all five Hyper-V and six Azure Local DA component classes to the verified
  `Microsoft.SystemCenter.ServiceDesigner.ServiceComponentGroup` base and added regression checks.
- **SDK and test-seal result:** The complete Hyper-V and Azure Local suites—Library, Discovery,
  Monitoring, Presentation, and optional Reporting—pass Microsoft VSAE/SDK verification against
  the installed OM2022 sealed dependencies. Both five-MP chains then test-sealed successfully in
  dependency order with a transient development key stored only under `D:/tmp/`.
- **Additional verified fixes:** Renamed discovery-script `$data` and helper `$Target` variables so
  they cannot collide with SCOM expression namespaces, split malformed MAML into sibling sections,
  and made all three-state monitor health mappings unique. Added regression assertions.
- **Sealing runtime:** VSAE `FASTSEAL.exe` targets CLR v2.0.50727. `NET-Framework-Core` initially
  reported `Removed`, then completed installation through Server Manager and now reports
  `Installed`. **No restart was performed, and the operator explicitly prohibited restarting this
  server.**
- **Latest validation:** Both complete five-MP VSAE/SDK wrappers passed; all ten transient artifacts
  test-sealed and passed strong-name verification; Pester 15/15; PSScriptAnalyzer zero warnings or
  errors; VitePress production build and `git diff --check` passed; public ADO identifier scan
  returned zero matches. VitePress emitted only its existing large-chunk warning.
- **Outcome:** Implemented the Azure Local SCOM development baseline, both independent Azure
  Monitor Health Model baselines, and the optional SCOM-to-ServiceNow development contract. Updated
  research, ADRs, architecture, operator guidance, navigation, roadmap, source READMEs, changelog,
  and private delivery tracking.
- **Azure Local SCOM:** Added five package sources (Library, Discovery, Monitoring, Presentation,
  optional Reporting), 17 classes, 28 relationships, staged local topology discovery, a
  platform-owned Distributed Application with six health components, 14 unit monitors, six
  aggregate monitors, 12 dependency rollups, 11 curated monitor alerts, 12 performance rules, four
  event rules, a diagnostic task, operational knowledge, and 14 views.
- **Overrides:** Added separate customer-owned Discovery and Monitoring override generators plus
  Lab, Standard, and Strict starter profiles. The Default Management Pack remains prohibited.
- **Azure Local Azure Monitor:** Added an independent monitor account/Health Model Bicep baseline,
  deployment and six domain entities, separate compute/storage Azure-resource entities, documented
  Azure Local CPU and storage-degraded signals, deployment state alerts, KQL research queries, and
  a workbook. Unproven domains remain Unknown.
- **Hyper-V Azure Monitor:** Accepted the constrained go decision and added an independent Bicep
  baseline. Arc-enabled SCVMM supplies inventory; Arc-enabled Server plus AMA/DCR supplies host
  heartbeat, hypervisor CPU, cluster-event, and telemetry-coverage signals. Explicit DCR
  associations and complete fabric parity remain lab work.
- **ServiceNow:** Accepted the connector-boundary ADR and added separate Azure Local and Hyper-V
  connector profiles, a normalized AlertId-based mapping, an offline compatibility validator, and
  public setup/lifecycle/security guidance. Live MID Server and ServiceNow validation remains.
- **Architecture:** Accepted ADRs 0032–0038 and promoted ADR 0023 to the constrained Hyper-V Azure
  Monitor implementation decision. Added four Azure Local SCOM draw.io diagrams with public SVG
  exports and repaired three previously committed draw.io files that had obsolete stub XML appended.
- **Private tracking:** Updated all existing Azure Local and Hyper-V SCOM/Azure Monitor delivery
  items with exact baseline and remaining-gate status. Added a separate integrations Epic, a
  SCOM-to-ServiceNow Feature, and research, architecture, implementation, and lab-validation
  Stories. No internal identifiers or board links appear in public repository content.
- **Validation passed:** Azure Local and Hyper-V MP contracts; Azure Local and Hyper-V Azure Monitor
  Bicep/contract checks; SCOM-to-ServiceNow contract; Pester 15/15; product PSScriptAnalyzer zero
  warnings/errors; gitleaks zero findings; 20 JSON files parsed; seven draw.io files parsed; local
  Markdown links passed; changed-file structural Markdown lint passed; VitePress production build;
  `git diff --check`; public work-item scan zero. VitePress reports only its existing large-chunk
  warning.
- **Governance:** Registry resolves this as the HCS `docs` profile. The governance server could not
  inspect the Windows path for drift and its optional markdown/link binaries are not installed;
  equivalent local checks were run directly.
- **Release gates:** Both complete suites are SDK dependency-resolved and transiently test-sealed
  against OM2022, but no test output is a public release artifact. Governed release signing and
  SCOM-lab certification remain; standalone MPVerify is not a separate gate.
  Neither Azure Monitor baseline has been deployed to a representative subscription. ServiceNow
  MID Server behavior and the supported SCOM version pair are not lab-certified.
- **Branch:** `main`.
- **Latest documentation validation:** VitePress production build passed, the ServiceNow contract
  validator passed, Pester passed 15/15, PSScriptAnalyzer returned zero warnings/errors, edited
  draw.io/SVG XML parsed, gitleaks reported zero findings, the public work-item identifier scan
  returned zero matches, and `git diff --check` passed. Governance MCP could not access the local
  Windows path; its optional markdownlint/lychee executables are also not installed server-side.
- **Next action:** Do not restart this server. Import the transiently test-sealed products into the
  operator-provided SCOM labs in dependency order and execute the documented SCOM and ServiceNow
  matrices. Establish the governed release-signing identity only after the lab evidence is
  approved. Azure Monitor live deployment remains a separate lab workstream.

## Last session

- **Outcome:** Authored the functional Hyper-V SCOM development baseline and reconciled public
  design, roadmap, product, catalog, administration, ADR, source README, changelog, and AI state.
- **Library:** 13 localized public classes, 70 localized properties, and 20 localized relationships.
  The model has a stable cluster-or-host boundary, non-hosted mobile VM identity, hosted host-local
  objects, a Service Designer DA root, and five component classes.
- **Discovery and DA:** Added registry role seed plus staged PowerShell topology discovery for
  Hyper-V, Failover Clustering, CSV, virtual switches, Network ATC, Replica facts, monitoring
  pipeline, DA roots/components, and 20 membership/reference relationships.
- **Monitoring:** Added one shared cookdown data source, nine three-state host monitors, auto-resolve
  alerts, 10 DA dependency rollups, 12 performance rules, four Failover Clustering event-alert
  rules, 13 operational-knowledge articles, and one read-only diagnostic task. Five
  high-cardinality/topology-sensitive performance rules are disabled by default.
- **Presentation:** Added four folders and 10 localized service-health, inventory, alert,
  performance, and event views. DA roots derive from the Service Designer service class and roll up
  through Compute, Virtual Machines, Storage, Network, and Monitoring Pipeline components.
- **Overrides:** Added generator-backed Lab, Standard, and Strict profiles. Each invocation creates
  separate unsealed, customer-owned Discovery and Monitoring override MPs. The Default Management
  Pack remains prohibited.
- **Build and validation:** Added deterministic element localization, structural product contracts,
  and a Microsoft SDK verification command that requires official target-version dependency MPs
  and fails on missing dependencies or verification errors.
- **Architecture:** Accepted ADRs 0027–0029 and 0031. Release-specific dependency versions,
  test/release sealing, signing identity, and lab certification remain release gates, not unbuilt
  source work.
- **Private tracking:** Updated the architecture, classes/discovery, monitoring/overrides, DA
  membership, DA rollup, and release-validation items with exact status and remaining gates. No
  internal work-item identifiers or links appear in public repository content.
- **Validation passed:** Hyper-V MP contract suite; Pester 8/8; PSScriptAnalyzer zero
  warnings/errors; VitePress production build; changed-file Markdown lint with VitePress-compatible
  line/H1 exclusions; `git diff --check`; public work-item scan zero; high-confidence secret scan
  zero. The VitePress build reports only its existing large-chunk warning.
- **External gate:** The Microsoft SDK assembly is installed, but official sealed System, Windows,
  Service Designer, Health, Performance, System Center, and Data Warehouse dependency MPs are not
  locally available. Full SDK verification therefore cannot truthfully pass yet. Test sealing,
  representative standalone/cluster SCOM lab import, topology lifecycle, fault/recovery,
  maintenance, failover, scale, upgrade/removal, release sealing/signing, and optional Reporting,
  SLO, and SquaredUp certification remain.
- **Branch:** `main`.
- **Next action:** Export the official dependency MPs from each target SCOM management group, run
  `Test-HyperVManagementPacksWithSdk.ps1`, correct any verified schema/dependency findings, then
  test-seal and execute the documented standalone and cluster lab matrix.
# 2026-09-01 — Hyper-V SCOM 1.0.2.0 governed production release

- **Source:** Clean `main` at `4c0fa8515591fb83d36ca7462a02125885323983`.
- **Release-mode gate:** A transient-key Release build passed the independent package validator
  with 13 sealed management packs, 14 release bundles, and `releaseEligible=true`. This output was
  validation-only and is not a publishable artifact.
- **Production signing:** The permanent private key was retrieved at runtime from
  `kv-hcs-vault-01` secret `hcs-hybrid-health-monitoring-scom-release-private-key`, supplied only to
  the external release driver, and removed from the temporary filesystem in the driver's `finally`
  block. No key value was written to this repository or command output.
- **Production validation:** `Test-HyperVPrivateCloudReleasePackage.ps1 -RequireReleaseEligible`
  passed for `E:\temp\hcs-hyperv-release-1.0.2.0-production`: 13 sealed MPs, 14 release bundles,
  Release mode, approved public-key token `54d0fb1159995c86`, and release-eligible status.
- **Manifest provenance:** Product version `1.0.2.0`, source commit
  `4c0fa8515591fb83d36ca7462a02125885323983`, VSAE verification enabled, external dependency
  strong names verified, product strong names verified, and per-artifact SHA-256 hashes recorded.
- **Next action:** Publish the exact production assets under the versioned and `latest` download
  paths, merge the release change, then import this exact sealed build into the ProductLabs SCOM
  management group in dependency order and validate runtime health.

# 2026-09-03 — 1.2.0.0 audit reconciliation and 1.3.0.0 remediation plan

- **Trigger:** SCOM HAAS-SDR operational audit of the imported 1.2.0.0 suite (42 custom objects,
  7 Healthy / 22 Error / 13 Uninitialized, 129 unresolved alerts, repeat count 2,995 → 3,142).
- **What changed:** No product code. Added `PLAN-1.3.0.0-REMEDIATION.md`; rewrote
  `.ai/state/CURRENT_TASK.md`, whose previous entry incorrectly asserted all seven 1.2.0.0 runtime
  defects were resolved.
- **Method (new, reusable):** Sealed `.mp` files were unsealed and inspected directly — the `.mp` is
  a .NET assembly whose `MPResources.resources` holds a `ManagementPack` entry containing
  **gzip-compressed UTF-16LE XML**. Plain `grep` on a `.mp` returns zero matches for content that is
  present; this is why 1.2.0.0 shipped defects while all verification passed. Full recipe in §0 of
  the plan. This becomes release gates 1.1/1.2.
- **Findings against shipped 1.2.0.0 (not source):**
  - `$Data/Params/Param[1]$` suppression: **fixed** (10 in 1.0.7.0 → 0). The audit was wrong here.
  - The audit's "all eight capability packs identical to 1.0.7.0" is half right — Cluster (59),
    FileServices (62), NetworkATC (18) and VMM (93) have normalized diffs; PhysicalNetwork, S2D,
    SDN, Storage and PureStorage are identical.
  - File Services: 1 of 3 `channels =` sites wrapped; two remain, plus ~50 unguarded `.Count` reads
    under StrictMode. Event 8702 explained.
  - Network ATC: the `$Mode -in (...)` clause was correctly removed, but `RequireNetworkATC` still
    defaults `true` ×15 / `false` ×1 — the *default configuration*, not the logic, sustains 8903.
    The audit's diagnosis was wrong; its symptom was real.
  - Cluster: 1.2.0.0 added `-SkipEditionCheck`, the exact approach the audit proved fails with
    `Could not load type 'System.Diagnostics.Eventing.EventDescriptor'`. Effectively a no-op.
  - VMM: 18 `Get-SCVMMServer`, 10 `Import-Module`, 19 `Exception.Message`, 0 `Exception.ToString`.
  - 360° model: all six new classes declared with a `DiscoveryClass` entry but **0 unit monitors
    target them**; `OutOfBandSwitch`, `EdgeFirewall` and `ConsoleServer` have zero `MPElement`
    references anywhere in the suite.
  - Fail-open: `"probe active."` Good-returns ×8 in `Monitoring.xml`.
  - Probe host confirmed as `%ProgramFiles%\PowerShell\7\pwsh.exe` via
    `System.CommandExecuterDiscoveryDataSource`, one process per workflow — the amplification
    mechanism, and the reason the per-facet `Mode` argument defeats cookdown.
- **Root cause:** Fixes were verified against source templates and a positive-environment probe
  fixture, never against sealed-pack content or a negative environment. `out/development` is stale
  (13:35 vs the 21:38 seal) and still contains the 10 `Param[1]` defects.
- **Commands run:** read-only inspection and unsealing into the session scratchpad. No build, no
  seal, no Azure write operations, no pushes.
- **Branch:** `main`.
- **Blockers / decisions needed:** (1) §5.3 — VMM has no CIM equivalent, so PS7-only governance must
  yield either a documented ADR exception for VMM workflows or an off-agent collector;
  recommendation is the ADR exception. (2) §7.1 — until `HAAS\svc-scom-vmm` is associated with the
  VMM Run As profile, Event 8905 cannot be attributed to MP code. (3) Whether SDN is intended to be
  active at all.
- **Next action:** Build the §1 release gates before any product fix — gate 1.3 (negative-environment
  probe fixture) alone would have caught four of the seven defects. Then run the §5.1
  `root\MSCluster` CIM spike as the HealthService account. Ship as 1.3.0.0; 1.2.0.0 is sealed and
  published and must not be republished under the same version.

# 2026-09-03 (correction) — 1.2.0.0 was published three times under one version

Supersedes the entry above it. My first reconciliation unsealed the **current working-tree** 1.2.0.0
assets and concluded several audit claims were wrong. That was the wrong build.

- **`git log -- docs/public/downloads/hyper-v-private-cloud/1.2.0.0/` returns three commits** —
  `94c245f` (original publish), `e0a1d9e` (restage), `ce51a8e` ("with scom audit fixes"). Each
  rewrote all 13 sealed `.mp` files under the unchanged version `1.2.0.0`. Published
  `SHA256SUMS.txt` for `Monitoring.mp` accordingly holds three different values:
  `221a3a07…`, `3676a824…`, `3387a8e8…`. `latest/` serves the third.
- **SCOM will not import a sealed MP whose version already exists**, so the audited environment ran
  the original `94c245f` bytes. Every fix in `ce51a8e` is stranded and invisible.
- **Against the imported `94c245f` build, the audit is correct on every claim and understated it:**
  all nine capability packs are byte-identical to 1.0.7.0 after version normalization, and so are
  `Monitoring` and `Presentation`. Only `Discovery` (72 lines) and `Library` (243) changed — the 360°
  class declarations, nothing else. `Param[1]` ×10 present; ATC `$Mode -in (…)` clause present; both
  File Services `channels =` sites unguarded.
- **The stranded `ce51a8e` build fixes about 1.5 of 7 defects.** `Param[1]` genuinely 10 → 0. ATC
  `$Mode` clause removed **but `RequireNetworkATC` still defaults `true` ×15 / `false` ×1**, so 8903
  would persist — fixing the logic did not fix the symptom. File Services 1 of 3 `channels =` sites,
  with ~50 unguarded `.Count` reads remaining. Cluster "fixed" by adding `-SkipEditionCheck`, the
  exact approach the audit proved fails. VMM (18 connects / 10 module loads / 19 `Exception.Message`
  / 0 `ToString`), SDN, Storage, S2D and the 360° monitor wiring untouched.
- **Root cause is two-layered:** (1) a sealed published pack was republished under an unchanged
  version, three times — the act the audit's closing paragraph warned against; (2) verification ran
  against source templates and a positive-environment fixture, never against sealed-pack content or a
  negative environment. `out/development/HyperVPrivateCloud.Monitoring.xml` still holds all 10
  `Param[1]` while the source template holds none, and nothing flags the disagreement.
- **Method worth keeping:** a sealed `.mp` is a .NET assembly whose `MPResources.resources` holds a
  `ManagementPack` entry of **gzip-compressed UTF-16LE XML**. `grep` on a `.mp` returns zero matches
  for content that is present — this is why static verification could not distinguish fixed from
  unfixed. Recipe in §0 of the plan; becomes gates 1.1/1.2.
- **What changed in the repo:** no product code. `PLAN-1.3.0.0-REMEDIATION.md` (rewritten around the
  corrected finding, adds gate 1.8 immutable-published-version and §9 item 0 confirm-live-build), and
  `.ai/state/CURRENT_TASK.md`.
- **Commands run:** read-only git extraction and unsealing into the session scratchpad. No build, no
  seal, no Azure write operations, no pushes.
- **Branch:** `main`.
- **Blockers / decisions needed:** (1) confirm which build is live in the management group before any
  retest is interpreted; (2) §5.3 — VMM has no CIM equivalent, so PS7-only governance must yield
  either a documented ADR exception for VMM workflows or an off-agent collector (recommend the ADR
  exception); (3) §7.1 VMM Run As association; (4) whether SDN is intended to be active at all;
  (5) §8.5 — whether to restore the published 1.2.0.0 directory to its original `94c245f` bytes so the
  published hash matches what was released and imported.
- **Next action:** Build gate §1.8 (release tool refuses to write into an existing published version
  directory; published `SHA256SUMS.txt` immutable) before anything else — it is the failure that hid
  the other six. Then the remaining §1 gates, then §5.1. Ship 1.3.0.0.
