# Sealed 1.3.7.0 installation and runtime validation

September 6, 2026, HAAS-SDR. Fast-forwarded main from 573099c to 8fbb62e and imported
the immutable published assets from docs/public/downloads/hyper-v-private-cloud/1.3.7.0.
Import completed at 04:27:42 UTC (00:27:42 ET).

## Passed

- All 30 asset hashes, all 13 forced strong-name signatures, expected versions/token,
  dependencies, and extracted MP schemas pass. All 64 embedded PS bodies parse.
- Sealed VMM task, health, and fabric-discovery bodies match committed corrected source.
- SDK confirms all 13 installed MPs are sealed 1.3.7.0, token 54d0fb1159995c86.
- Actual installed diagnostic and Cluster Summary tasks pass on all four Hyper-V hosts:
  exit 0, empty stderr, no FAILED text, correct CSV usage output. Diagnostics report native
  x64 PowerShell 7.6.5; VMM/Cluster scripts retain their supported Windows PowerShell runtime.
- All four permanent topology discoveries pass. The actual installed VMM fabric discovery
  was triggered on demand and also reports SUCCESS.
- Actual installed VMM HostStatus, AgentVersions, LibraryStatus, and FailedJobs pass.
  AgentVersions succeeds on VMM02, the previously failing server, and lists all four hosts
  at 10.25.1439.0. Host maintenance/CPU and library status/version/ownership fields are populated.
- Repeat HostStatus, AgentVersions, and LibraryStatus all pass; each of those three tasks
  succeeded on BOTH VMM servers. Final result assertion verifies 22 positive outputs
  (15 product task runs, five discoveries, two sealed-health capture runs), plus the expected
  negative task failure. No previously reported defect reproduced.
- A deliberately oversized FailedJobs lookback returns SCOM Failed with process exit 1.
  This expected negative test confirms error-policy behavior, not a release regression.
- Two executions of the health script extracted from the sealed MP pass with the existing
  Run As profile and failure policy. AgentVersionDrift, host-group capacity, virtual-switch
  uplinks, service/agent communication, VM networks/bindings, and PRO tips report Good.
- Inventory remains 268 identical object/class identities. All four host and 38 VM pipeline
  monitors are Success. Customer overrides are unchanged. Of 63 unsealed packs, 62 are byte
  identical; the only difference is Dell OME's schedule timestamp advancing ten minutes.
- Temporary read-only health-capture MP removed. Both VMM servers have zero remaining
  HcsVmmTask-* compiler scratch directories. No guest agents or workload VM changes.

## Genuine environment conditions remain visible

The health payload still reports CloudCapacity Critical (cloud storage at its quota),
LogicalNetwork Warning (haas has no network site), and JobFailureRate Warning (one of eight
recent VMM jobs failed: 12.5%). These are not hidden or reset. Corresponding monitor states
agree. Other VMM capacity/uplink/version monitors remain Good.

Initial seven-server Operations Manager event check through 04:31 UTC found zero events
mentioning HyperVPrivateCloud. Other warnings/errors exist: NanoDiscovery non-remotable
warnings on cluster owners and Microsoft SQL monitoring timeouts/constructor/unload events
on SCOM01. They were not changed to manufacture an entirely green management group.

## Evidence and boundary

Local evidence: tmp/sealed-137/ contains import/version/signature logs, extracted XML,
script and source comparisons, actual task outputs/status logs, discovery responses,
two sealed-health payloads, before/after states and unsealed exports, inventory/override
comparisons, scratch cleanup, and event snapshots. Empty output for the expected negative
test must be read with its saved Failed status in vmm-task-status.tsv.

This is exact sealed import and bounded runtime validation, not a completed 24-hour soak
or an exhaustive certification of every optional capability and remediation action.
No product source or sealed binaries were changed in this step.
