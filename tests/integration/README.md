# Hyper-V SCOM integration certification

Run these checks only against an isolated pre-production SCOM management group using sealed
artifacts and the matching unsealed override MPs. Development XML is not a certifiable input.

`Get-HyperVPrivateCloudCertificationSnapshot.ps1` performs the repeatable, read-only portion of a
certification lane. It verifies product version/signing identity, imported override MPs, expected
class instances, required workflows and views, Distributed Application presence, and a recent
HealthService result from the diagnostic task. It writes:

- `management-group-snapshot.json`, containing the collected facts and individual checks; and
- `release-evidence.draft.json`, which is always unapproved and leaves destructive or multi-phase
  gates pending.

Start with `expectations/core-standalone.example.json`, copy it outside the repository for a lab
run, and set minimum instance counts to the lane's approved topology. Capability lanes must add
their capability MP and class expectations rather than weakening the core lane.

```powershell
./tests/integration/Get-HyperVPrivateCloudCertificationSnapshot.ps1 `
    -ManagementServer 'scom-ms.example.test' `
    -ProductVersion '1.0.0.0' `
    -PublicKeyToken '<PERMANENT_PRODUCT_TOKEN>' `
    -ExpectationPath ./tests/integration/expectations/core-standalone.example.json `
    -OutputPath D:/evidence/hyper-v-v2/core-standalone
```

Before collecting the snapshot, run **Collect Hyper-V diagnostic and PowerShell runtime summary**
against every representative host and retain the task output. A snapshot does not replace injected
fault/recovery, scale, upgrade/override, removal, or before/after Default Management Pack tests.
Those evidence locations are added to the final receipt only after human review.

## Temporary topology repair while sealing elsewhere

The 1.3.4.0 topology discovery submits three empty singleton class instances. Live testing found
that SCOM drops the resulting topology; the corrected source uses those singleton objects only
as relationship endpoints. An operator can bridge the gap until a sealed upgrade with a narrowly
scoped unsealed pack built from that corrected discovery:

```powershell
./tools/scom/New-HyperVTopologyHotfix.ps1 -LibraryVersion '1.3.4.0' `
    -PublicKeyToken '54d0fb1159995c86' `
    -OutputPath ./src/hyper-v/scom-mp/out/live-validation/Hcs.HyperVPrivateCloud.Topology.Hotfix.xml
./src/hyper-v/scom-mp/tools/Test-HyperVPrivateCloudSchema.ps1 `
    -Path ./src/hyper-v/scom-mp/out/live-validation
```

Import that XML through the SCOM console. It references the **installed** sealed Library and
contains one discovery, with no new classes, monitors, rules, tasks, or overrides. Allow agent
configuration distribution, then run its discovery against every Hyper-V HostRole. Check the
on-demand response contains `SUCCESS` and confirm VM, runtime, and monitoring-pipeline objects
in the SDK or console. A task status of Succeeded alone does not establish discovery success.

This is a repair bridge, not a certified release. It does not fix the sealed Library's blank task
output, the monitoring rule's migration-start false alerts, or the Cluster probe's empty-query
warnings. Those source corrections require the sealed upgrade.

Keep `Hcs.HyperVPrivateCloud.Topology.Hotfix` imported until the upgraded sealed Discovery pack
has successfully rediscovered **every host**. Then remove only that temporary pack and verify
that topology remains. Removing it sooner can remove its discovered objects. Do not remove
customer overrides or reset health/close alerts to manufacture acceptance evidence.

Microsoft documents the underlying Operations Manager cmdlets in
[Get-SCOMManagementPack](https://learn.microsoft.com/en-us/powershell/module/operationsmanager/get-scmanagementpack),
[Get-SCOMClassInstance](https://learn.microsoft.com/en-us/powershell/module/operationsmanager/get-scomclassinstance),
[Get-SCOMMonitor](https://learn.microsoft.com/en-us/powershell/module/operationsmanager/get-scommonitor),
and [Get-SCOMTaskResult](https://learn.microsoft.com/en-us/powershell/module/operationsmanager/get-scomtaskresult).
