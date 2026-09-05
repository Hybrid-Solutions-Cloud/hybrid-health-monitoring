# Hyper-V 1.3.5.0 release-readiness audit

Status: **pre-sealing live scenarios passed; final sealed release not certified**.
Updated 2026-09-05 from live HAAS-SDR testing on the jump server.
The operator's finish line is release readiness, not merely XML ready for sealing. Workload VMs
must not require SCOM agents. Sealing and publication remain reserved for another machine.

## Evidence completed

| Check | Result |
|---|---|
| Installed identity | All 13 sealed product MPs are 1.3.4.0; candidate XML is 1.3.5.0 |
| Live topology | Corrected discovery succeeds on all four hosts through the discovery-only hotfix |
| Inventory comparison | Actual Hyper-V: A01 31 VMs, A02 0, B01 0, B02 7; SCOM 38 VMs and runtime objects |
| Real probe execution | Host and VM probes ran through HealthService/LocalSystem on all four hosts using 64-bit PowerShell 7.6.5; exit 0 and empty stderr |
| Empty hosts | VM inventory emits one summary bag on each empty host; nonempty hosts emit VM bags plus summary |
| Guest-agent boundary | Runtime instances hosted on Hyper-V computers; host-side Get-VM and integration-service queries, no guest remoting |
| Host signals | Host pipeline, domain, DNS, hypervisor, VMMS, compute, storage attachment, CPU/memory/paging probes report Good on all four hosts |
| VM network warnings | RussIsCool and TimsLinux have disconnected virtual NICs; direct inventory agrees with probe warnings |
| Cluster fault evidence | Replica-broker network-name resource failures and repeated role-failover events exist in actual cluster event logs |
| S2D | Two discovered Microsoft storage subsystems; enabled HCS S2D monitors report Success. MediaErrors is explicitly disabled by default, explaining its uninitialized state |
| SAN/SMB scope | No iSCSI sessions or UNC-hosted VM disks in the four-host sample; storage is Spaces/local. This does not certify SAN/SMB integrations in a positive environment |
| Optional providers | No discovered Pure arrays or SDN controller group; ATC command unavailable in the PS7 sample. Positive integration testing is not established for those lanes |
| Final full unit/contract/smoke run | 241 passed, 0 failed, 0 skipped, 1667.21 seconds; saved NUnit result at tmp/release-final-pester.xml |
| Added regression checks | Cluster-local/quorum plus prior runtime suite: 10 passed. No-guest-agent tests: 2 passed. VMM runtime regressions: 5 passed |
| Final cluster fixture rerun | EnvironmentFixture suite after the local-query edits: 11 passed, 0 failed |
| Candidate XML | Rebuilt after cluster and VMM corrections; all 13 MPs pass the vendored SCOM schema |
| Supported Cluster runtime | Corrected source passes through HealthService LocalSystem on all four Hyper-V nodes and the non-CSV VMM cluster; no permission changes |
| Supported VMM runtime | Corrected source passes through SCOM Run As; false host-group memory and spare-NIC uplink faults are gone; genuine cloud/site faults remain |
| Lifecycle cleanup | Stable VM/vNIC identity across migration; old runtime removed; destination Availability/Network/Pipeline Good; deleted VM disappears from SCOM; inventory returns to 38 VMs/runtimes |
| Override preservation | 63 of 64 baseline unsealed MPs byte-identical, including customer Hyper-V overrides. Dell OME interval pack differs only in two scheduled timestamp values; no Dell changes made by this work |
| Documentation | VitePress production build passed; bundle-size warning only |

The final full test run includes the cluster-local and VMM fixes and all new regression tests.
The earlier 232-test receipt is historical; use release-final-pester.xml for this candidate.

## Additional source fixes made during this audit

- Cluster CSV queries now omit the explicit cluster network name and query the local node.
  Existing named queries fail with cluster-admin access errors on passive nodes A02/B01. The local
  query change is now proven through HealthService LocalSystem in supported Windows PowerShell
  on A02/B01 (one CSV, two nodes) and VMM01 (no CSV, two nodes), exit 0 and empty stderr.
- Quorum collection now records failure with the same incomplete-collection warning as other
  queries instead of silently swallowing the exception and potentially reporting healthy.
- Added ClusterLocalQuery and GuestAgentBoundary regression suites. No privileges, workload
  settings, customer overrides, alert resolutions or health states were changed to manufacture green.

## Uninitialized is not synonymous with a failed probe

SDK monitor-state enumeration found no direct HCS monitors on the VM/disk/NIC inventory objects,
boundaries, AD/DNS service descriptors, monitoring-pipeline descriptors, VMM logical networks/sites,
replication descriptors or product group. Their inventory-only state must not be counted as a
guest-agent failure. Actual VM health runs on VirtualMachineRuntime; host domain/DNS/pipeline
checks run on HostRole. Remaining uninitialized dependency monitors need their relationship and
applicability checked; empty optional branches must not be falsely marked healthy.

## Readiness gate status

1. **Supported runtime is settled, not a blocker.** The operator clarified PS7 applies where
   supported; Windows PowerShell is permitted for Cluster/VMM. Do not request this again.
2. **Cluster coverage.** Corrected local CSV/quorum queries pass on all four Hyper-V nodes and
   the non-CSV VMM cluster without permission changes. Final sealed upgrade remains separate.
3. **VMM sealed-monitor recovery.** Source defects fixed: AvailableMemory MiB must be converted
   before subtracting from TotalMemory bytes; an empty LogicalNetworkMap is not an uplink name.
   Five new regression tests pass. Actual corrected source executed through SCOM Run As reports
   HostGroupCapacity Good and VirtualSwitchUplink Good (exit 0, empty stderr). Cloud storage quota
   Critical and the logical network without a site Warning are genuine and remain visible.
   Evidence: tmp/release-validation/vmm-fixed-probe.xml and vmm-oracle-direct.json. Final sealed
   monitor transitions still require the new sealed build; sidecar results are not those transitions.
4. **Fault/recovery, migration and topology ownership.** Disposable VM HCS-MP-RT-260905 deployed
   on A02 with an isolated private switch, no guest OS or SCOM agent. Availability reached Critical
   while Off and recovered naturally to Good after Start. Network disconnect reached Warning
   and the Networking dependency rollup; reconnect recovered naturally to Good. Live migration
   A02 to A01 succeeded (0.2-second blackout), preserving SCOM VM/vNIC identities, replacing the
   host runtime, and removing the old runtime after successful discoveries. Destination Availability,
   Network and Pipeline initialized Good. VM registration, switches, SCOM objects and temporary task
   pack removed. Tool policy rejected deletion of the residual 4 MiB blank disk/empty directories;
   exact path is recorded in HANDOFF.md. Existing workloads are untouched. Blank firmware cannot demonstrate
   successful guest heartbeat; its running heartbeat Critical is expected.
5. **Exact candidate integration.** Library output, Monitoring event selection and Cluster fixes
   require integrated candidate runtime validation. Sidecar tasks prove source execution, not
   final sealed upgrade compatibility or complete monitor state transitions.
6. **Final package/upgrade/soak.** VSAE/signature verification, clean committed source, exact sealed
   import, override preservation, hotfix removal after permanent discovery takes over, and the
   planned 24-hour soak remain. No signing tools or keys were used on this server.

## Local evidence and temporary changes

- `tmp/live-scom-release-readiness.txt`: product inventory and initial alert snapshot.
- `tmp/live-monitor-states.tsv`: per-object HCS monitor state enumeration.
- `tmp/external-monitor-states.tsv`: HCS monitors targeting Microsoft VMM/S2D and optional providers.
- `tmp/release-validation/*-evidence.xml`: independent host inventory under LocalSystem.
- `tmp/release-validation/*-vmprobe.xml` and `*-hostprobe.xml`: actual source probe property bags.
- `tmp/release-validation/*-cluster-local.xml`: native PS7 FailoverClusters compatibility evidence.
- `tmp/vmm-alert-evidence.txt`: VMM alert context, retained locally, not for public distribution.
- `tmp/override-audit/`: read-only exports of existing unsealed MPs; no overrides changed.
- `Hcs.HyperVPrivateCloud.ReleaseValidation`: temporary read-only task pack removed after checks.
- `Hcs.HyperVPrivateCloud.Topology.Hotfix`: keep until the sealed replacement successfully
  rediscovers every host. Never remove early simply to clean up test artifacts.

The refreshed sealing-handoff-1.3.5.0.zip contains this audit, final test receipt, candidate XML,
source overlay, hashes and selected live evidence. It supersedes the earlier bundle but remains
an unsigned transfer bundle, not an approved release package. Source is still uncommitted on main;
no release was sealed or published.
