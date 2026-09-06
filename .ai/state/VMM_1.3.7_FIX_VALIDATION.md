# VMM corrective source validation — 1.3.7.0 candidate

September 5 late evening, 2026. Installed product remains sealed 1.3.6.0. This report records
implemented and tested source corrections, not new sealed-artifact acceptance.

## Root cause and corrections

SCOM Run As executions on VMM02 reproduced the first module-import exception:
`Source file 'C:\WINDOWS\TEMP\<temporary-name>.0.cs' could not be found`.
The subsequent import retry failed with an existing Get-VMMServer alias, masking that first
compiler error. Evidence: `tmp/sealed-136/root-cause-1.xml` and `root-cause-2.xml`.

VMM tasks, health collection, and fabric discovery now create a unique task-owned compiler
directory within their workflow workspace, set process TEMP/TMP only during import, then restore
both variables and remove that exact directory. They import once and preserve the original
exception. Health's command check uses ListImported so it cannot autoload outside that scope.
No machine-wide TEMP, filesystem ACL, credentials, or service configuration was changed.

Live VMM object inspection established these mappings:

| Output | Native source |
| --- | --- |
| Host agent version | Agent.AgentVersion / ManagedComputer.AgentVersion |
| Host maintenance | MaintenanceHost |
| Host CPU utilization | CpuUtilization |
| Library server status | Status |
| Library agent version | ManagedComputer.AgentVersion |
| Library share ownership | LibraryServer.Name |

Tasks use these sources with explicit Unavailable for missing optional values and preserve
legitimate false/zero values. Library queries now use ErrorAction Stop. Shares are presented
as inventory, not invented health/placement eligibility. Embedded task knowledge was corrected.
Agent-version drift monitoring uses the same nested agent data rather than incorrectly reporting
NotApplicable. Regression fixtures prove that an older nested agent version yields Critical.

## Live verification

Temporary Hcs.HyperVPrivateCloud.ReleaseValidation versions 1.0.0.9/1.0.0.10 ran source copied
from the 1.3.7.0 candidate with the existing VMM Run As profile and production-equivalent
stderr/nonzero-exit failure policy enabled. Ten executions passed, all exit 0 and no FAILED text:
four AgentVersions, two LibraryStatus, one HostStatus, one FailedJobs, two AgentVersionDrift
health-probe executions. Both VMM01 and VMM02 executed corrected code; AgentVersions succeeded
on both. LibraryStatus and HostStatus succeeded on previously failing VMM02.

All four hosts report agent 10.25.1439.0. All three library servers report Responding and agent
10.25.1439.0, with three correctly associated share paths. Host maintenance and CPU columns are
populated. The health probe emits AgentVersionDriftState=Good with version 10.25.1439.0, replacing
the former missing-version path. Native WinPS execution was retained; no guest agents required.
Both servers had zero remaining HcsVmmTask-* directories after execution.

Evidence is under `tmp/sealed-136/fixed-*.xml` and `fixed-final-*.xml`; the temporary builder is
`tmp/New-Sealed136VmmDiagnostics.ps1`. Candidate build output: `tmp/operator-137/`.

## Release boundary

All 13 candidate MPs build and pass schema validation. Final selected tests: 179 passed,
zero failed/skipped (15 operator regressions, seven VMM runtime regressions, 92 build contracts,
65 embedded-script smoke cases). The temporary validation MP was removed successfully.
Fabric discovery's initializer has code/schema/smoke coverage; its complete corrected discovery
payload has not been submitted as a production discovery during this step. Installed sealed
1.3.6.0 has not been overwritten or silently patched. New sealing on the signing machine and
exact sealed upgrade/runtime acceptance are still required for 1.3.7.0.
