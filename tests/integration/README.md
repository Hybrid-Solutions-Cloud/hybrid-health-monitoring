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

Microsoft documents the underlying Operations Manager cmdlets in
[Get-SCOMManagementPack](https://learn.microsoft.com/en-us/powershell/module/operationsmanager/get-scmanagementpack),
[Get-SCOMClassInstance](https://learn.microsoft.com/en-us/powershell/module/operationsmanager/get-scomclassinstance),
[Get-SCOMMonitor](https://learn.microsoft.com/en-us/powershell/module/operationsmanager/get-scommonitor),
and [Get-SCOMTaskResult](https://learn.microsoft.com/en-us/powershell/module/operationsmanager/get-scomtaskresult).
