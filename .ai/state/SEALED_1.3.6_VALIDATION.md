# Sealed 1.3.6.0 runtime acceptance

September 5, 2026, approximately 23:06–23:15 ET, management group HAAS-SDR.
Operator explicitly requested import and verification, not merely a repository pull.

## Installed and verified

- All 13 published MPs imported in dependency order and SDK-confirmed sealed 1.3.6.0,
  public key token 54d0fb1159995c86. All signatures were forcibly verified; all dependencies
  resolved. All 30 published asset hashes were checked during the preceding pull.
- All 13 extracted schemas pass; all 64 embedded PowerShell bodies parse without errors.
- Sealed content contains the native CSV Size/FreeSpace calculation, failure exits, and
  all five VMM task Run As bindings.
- Actual product Cluster Summary and diagnostic tasks pass on all four Hyper-V hosts:
  nonempty stdout, empty stderr, exit 0. Cluster output includes CSV usage without PercentUsed
  exceptions. Diagnostics run in x64 PowerShell 7.6.5; Cluster/VMM tasks use Windows PowerShell.
- All four permanent topology discoveries report SUCCESS. All 268 object/class identities
  match the immediate pre-upgrade baseline. No state changes in the captured HCS-class monitor
  comparison; all four host and 38 VM pipeline monitors remain Success.
- All 63 baseline unsealed packs are byte-identical after import, including customer overrides.
- Actual sealed VMM HostStatus returns all four hosts OK/Responding. FailedJobs returns its
  read-only job list. Oversized numeric lookback triggers actual task Failed with exit-policy
  code 1, confirming the former false-success behavior is corrected. No remediation was run.
- Actual VMM HostGroupCapacity and VirtualSwitchUplink monitors remain Good. CloudCapacity
  remains Critical and LogicalNetworkAvailability Warning, as before; neither was reset.

## Remaining VMM task defects — acceptance is not fully green

Actual sealed AgentVersions and LibraryStatus tasks failed on initial execution AND a repeat,
with SCOM event-policy failure -2130771918 for process exit 1. SCOM discards stdout from the
failed task result, so a temporary read-only diagnostic pack copied the sealed script and
existing Run As binding, omitting only the diagnostic command's event-policy filter to retain
raw stdout and exit code. The production MPs and their failure policy were not changed.

Captured AgentVersions execution on VMM02 reports:
`FAILED: The alias is not allowed, because an alias with the name 'Get-VMMServer' already exists.`
The script retries module import after its first exception; that retry can obscure the original
import error. Ordinary administrator remoting can import the VMM module on both servers, so
that check does not reproduce the SCOM Run As execution context and is not proof of a fix.

Diagnostic reruns on VMM01 of LibraryStatus and AgentVersions succeed, demonstrating this is
not consistently resolved. Successful AgentVersions output shows server 10.25.1439.0 but groups
all four hosts under a blank AgentVersion. Library output likewise has blank selected status
columns. These output-contract gaps need investigation against actual VMM object properties;
do not substitute invented versions or call the tasks validated solely because they exit 0.

## Event-log observation

The seven-server post-import query captured zero warnings/errors on A02, B01, and VMM02;
five each on A01/B02, ten on VMM01, and 502 on SCOM01 at the initial snapshot. Agent events
were Microsoft NanoDiscovery non-remotable warnings (1207). SCOM01 events were Microsoft SQL
module timeouts/constructor failures and workflow-unload summaries (4221/4509/1103). No event
message in that snapshot matched HyperVPrivateCloud. These unrelated workflow errors were not
changed or dismissed as healthy. This short observation is not a 24-hour soak.

## Evidence and next work

Local evidence: `tmp/sealed-136/`: import.tsv, packs-after.tsv, signatures.txt, xml/,
script-parsing.json, *-cluster.xml, *-diagnostics.xml, *-discovery.xml, vmm-*.xml,
capture-*.xml, states-before/after.tsv, external-after.tsv, overrides-comparison.json,
object-diff.json, state-changes.json, and events.json. An empty VMM task output file is NOT
success; see the task result's event-policy error and captured diagnostic output.

Product source and published binaries were not edited during this import/verification step.
Temporary Hcs.HyperVPrivateCloud.ReleaseValidation diagnostic pack was removed after capture.
No guest agents, workload VM modifications, permissions changes, or override changes.
Next: resolve VMM module initialization and displayed-property compatibility, add regression
coverage, then seal a new corrective version on the signing machine. Do not overwrite 1.3.6.0
or claim all bugs are fixed. Full sealed fault/recovery testing and a 24-hour soak remain pending.
