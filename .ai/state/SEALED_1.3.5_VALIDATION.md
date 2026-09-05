# Sealed 1.3.5.0 installation and runtime checks

September 5, 2026, HAAS-SDR. Operator authorized installation of the 13 MPs from the downloaded
`Hyper-V-Private-Cloud-Monitoring-Deployment-1.3.5.0` directory. The upgrade completed around
18:35 ET. This report distinguishes successful installation/monitoring from remaining task defects.

## Passed

- All 13 downloaded MP SHA-256 values match the published release manifest; Release package
  validation passes. Release source SHA is `46f3bc962b30245c7dc7ef76495b77b496764979`.
- All 13 forced strong-name checks pass, all versions are 1.3.5.0, and all public key tokens are
  `54d0fb1159995c86`. No verification bypass, key change, or MP-file modification was used.
- All 13 embedded XML documents are equivalent to rebuilt committed release source after only
  removing the XML-declaration difference and normalizing CDATA to ordinary text nodes.
- All embedded XML passes the SCOM schema; all 64 embedded PowerShell script bodies parse.
- All live dependencies resolve. All 13 product MPs imported and are confirmed sealed 1.3.5.0.
- Actual upgraded diagnostic tasks on all four Hyper-V hosts return nonempty stdout, exit 0 and
  empty stderr. They report 64-bit PowerShell 7.6.5. No guest SCOM agents were installed.
- Permanent topology discovery returned SUCCESS on all four hosts. The temporary topology hotfix
  was removed. VM inventory remained at 38 VMs and 38 runtimes. B01's pipeline descriptor briefly
  disappeared after removal; rerunning permanent discovery restored it without a hotfix. All four
  pipelines are present again. Record this takeover timing issue; task SUCCESS alone does not prove
  all discovery data has already been ingested.
- Actual VMM HostGroupCapacity monitor recovered naturally from Error to Success/Good.
- Actual VMM VirtualSwitchUplink monitor also recovered naturally to Success/Good by 18:42 ET.
- All four Host Pipeline monitors and all 38 VM Runtime Pipeline monitors are Success.
- All 268 object/class identities match the pre-upgrade snapshot after permanent-discovery retry;
  no object identity changes remain after retiring the hotfix.
- Supported Windows PowerShell inspection confirms NetworkATC/Get-NetIntent is not installed on
  any of the four Hyper-V nodes; this replaces the earlier incomplete PS7-only assessment.
- Of 63 remaining baseline unsealed packs, 62 are byte-identical, including customer Hyper-V
  overrides. Dell OME's interval pack differs only in two schedule timestamps. This work did not
  change it. Only the explicitly retired topology hotfix was removed.
- Initial post-import warning/error queries on all four hosts and both VMM servers returned zero
  Operations Manager warnings/errors since import. This is a bounded check, not a completed soak.
- The final 18:42 ET check also included the SCOM management server: zero Operations Manager
  warnings/errors on all seven checked servers since upgrade completion at approximately 18:35 ET.

## Confirmed remaining operator-task defects

### VMM Host Status task does not use the VMM profile

Actual task `HyperVPrivateCloud.Capability.VMM.HostStatus.Task` returns a body beginning `FAILED`
with insufficient privileges connecting to the VMM management server. The sealed VMM task definitions
and task write-action chain omit the VMM Run As binding used by the working VMM discoveries and
monitors. All five VMM operator tasks share that write action; only the read-only HostStatus task
was executed for this check. No permission grants, credential changes or service actions were used.

Inspect `src/hyper-v/scom-mp/fragments/capabilities/vmm/ManagementPack.xml.template`, module
`HyperVPrivateCloud.Capability.VMM.Task.WriteAction`. A source fix needs the intended existing VMM
profile binding and a regression test, followed by a new sealed version; do not alter published
1.3.5.0 bytes. Evidence: `tmp/sealed-135/vmm-host-status.xml`.

### Cluster Summary task reads a nonexistent property

Actual `HyperVPrivateCloud.Capability.Cluster.Summary.Task` reaches the CSV section, then fails
because `Partition.PercentUsed` does not exist under StrictMode. Native cluster inspection shows
`PercentFree`, `Size`, `FreeSpace` and `UsedSpace`, but no `PercentUsed`. Calculate used percent
from valid values with appropriate missing/zero-size handling.

Inspect `src/hyper-v/scom-mp/fragments/capabilities/cluster/Invoke-HyperVPrivateCloudClusterTask.ps1.template`,
the CSV projection at line 37. A corrected task requires a regression test and new sealed version.
Evidence: `tmp/sealed-135/a02-cluster-summary.xml` and `cluster-partition-properties.json`.

Both tasks report SCOM task status Succeeded/exit 0 despite `FAILED` in stdout. Task result bodies
must be inspected; exit status alone is insufficient. These findings are separate from the working
Cluster/VMM monitor probes. No product-source fix or resealing was performed in this install/check
step, and no production infrastructure was changed to hide the failures.

## Remaining observation

Both VMM virtual-switch uplink and host-group capacity recovered naturally to Good by 18:42 ET.
Their configured intervals are 600 and 900 seconds respectively; the earlier Error observation was
not the final outcome. Cloud quota remains Critical and the missing logical-network site remains
Warning, matching independently confirmed conditions; they were not cleared to manufacture green.
Final sealed-runtime fault/recovery coverage and the planned 24-hour soak are not completed by
these initial checks. The two operator-task failures above remain unresolved.

Local evidence directory: `tmp/sealed-135/`. It contains signatures, hashes/source comparisons,
import logs, before/after states and override exports, diagnostic outputs and discovery responses.
The initial signature-tool HRESULT 0x80131701 was corrected by configuring the local helper's
legacy CLR activation path; forced verification then passed. The sealed files were not defective.
