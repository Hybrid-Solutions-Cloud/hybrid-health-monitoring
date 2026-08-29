# ADR 0047 — Hyper-V v2 explicit PowerShell 7 execution

- **Status:** Accepted
- **Date:** 2026-08-28
- **Decision owners:** Hybrid Solutions Cloud maintainers

## Context

The HCS scripting standard requires PowerShell 7, strict mode, and terminating-error behavior for
every first-party script. Operations Manager's documented agent prerequisites still describe
Windows PowerShell for Management Pack scripts, and Microsoft's standard PowerShell probe and
discovery module types execute in an in-process Windows PowerShell host. VSAE validation proves an
MP's schema and reference contract; it does not prove which PowerShell engine executes a script on
an agent.

Silently weakening `#Requires -Version 7.0` would violate the repository standard and allow scripts
to run under an engine the product does not test. Depending on private SCOM implementation types or
shipping a custom binary host would create a larger compatibility and security burden.

Inspection of the public `System.Library` contract from Operations Manager 2016 and 2022 confirmed
three supported command-executor module types:

- `System.CommandExecuterDiscoveryDataSource`;
- `System.CommandExecuterProbePropertyBagBase`; and
- `System.CommandExecuter`.

These types can stage an embedded script, launch an explicit executable, and parse the discovery or
property-bag XML written by `MOM.ScriptAPI.Return`.

Microsoft recommends the MSI package for Windows Server and enterprise deployment. Its stable
default executable is `%ProgramFiles%\PowerShell\7\pwsh.exe`; Store/MSIX installation paths are not
a suitable service-workflow contract.

## Decision

All first-party Hyper-V Private Cloud v2 discovery, monitor-probe, and task scripts execute through
public wrapper module types defined in the sealed core Library:

| HCS wrapper | Public SCOM base |
|---|---|
| `HybridSolutionsCloud.HyperVPrivateCloud.Pwsh.DiscoveryProvider` | `System.CommandExecuterDiscoveryDataSource` |
| `HybridSolutionsCloud.HyperVPrivateCloud.Pwsh.PropertyBagProbe` | `System.CommandExecuterProbePropertyBagBase` |
| `HybridSolutionsCloud.HyperVPrivateCloud.Pwsh.WriteAction` | `System.CommandExecuter` |

Each wrapper launches `%ProgramFiles%\PowerShell\7\pwsh.exe` with
`-NoLogo -NoProfile -NonInteractive -ExecutionPolicy Bypass -File`. Scripts remain embedded sealed-MP
content, declare `#Requires -Version 7.0`, enable strict mode, and set terminating-error behavior.
Discovery and property-bag scripts return native SCOM XML through `MOM.ScriptAPI.Return`.

PowerShell 7 installed from the Microsoft MSI at its default machine-wide path is therefore a hard
prerequisite on every agent or management server that runs an HCS v2 PowerShell workflow. A Store,
MSIX, ZIP, user-scoped, or relocated installation does not satisfy the first-release contract.

The public **Collect Hyper-V diagnostic and PowerShell runtime summary** task returns the executing
edition, version, process path, `PSHOME`, automation assembly location/version, and process bitness.
Representative certification must capture this task output from every supported SCOM and Windows
Server lane and prove `PSEdition = Core` and the declared MSI path before runtime support is claimed.

## Consequences

- The PowerShell engine is explicit and independently observable instead of being inferred from a
  Microsoft PowerShell module type.
- The Library contract works against the inspected SCOM 2016 and 2022 `System.Library` floors
  without private module IDs or a custom DLL.
- Missing or relocated PowerShell 7 causes the command executor workflow to fail visibly; it cannot
  fall back silently to Windows PowerShell.
- `ExecutionPolicy Bypass` is scoped to the child process. It avoids machine-policy ambiguity for
  the temporary embedded script but does not weaken the sealing, source-review, least-privilege, or
  runtime-account requirements.
- PowerShell modules invoked by a capability must themselves load and work under PowerShell 7.
  Exact Hyper-V, clustering, storage, networking, SDN, and VMM module behavior remains a
  representative-lab release gate.
- PowerShell 7 servicing becomes an operator prerequisite. Administrators must maintain a supported
  Microsoft release and preserve the default MSI path during upgrades.

## Rejected alternatives

### Use the standard Microsoft PowerShell probe/provider types

Rejected because they do not establish the required PowerShell 7 process boundary and VSAE cannot
turn their in-process Windows PowerShell host into runtime proof.

### Remove the PowerShell 7 requirement

Rejected because it violates the HCS standard and would make current syntax and module behavior
dependent on an untested legacy engine.

### Depend on private command-executor implementation types

Rejected because private element IDs are not a supported public MP contract and may change across
Operations Manager releases.

### Ship a custom managed module or executable host

Rejected for the first release because the public SCOM command-executor contract already supplies
the required process boundary. A custom binary would add code-signing, servicing, security-review,
and cross-version certification obligations without a proven benefit.

## Validation gates

1. Resolve the wrapper types against every claimed SCOM `System.Library` version.
2. Build every product MP and prove no first-party workflow references the legacy Microsoft
   PowerShell discovery, probe, or write-action module types.
3. Prove every embedded script declares PowerShell 7 and strict mode and every discovery or
   property-bag workflow returns native SCOM data through `MOM.ScriptAPI.Return`.
4. Run the diagnostic task through HealthService on every claimed SCOM/Windows Server lane and
   retain the process and engine fields as release evidence.
5. Prove normal output, timeout, missing-executable, access-denied, malformed-output, module-missing,
   and recovery behavior in a representative management group.
6. Prove every capability-specific Windows or System Center module loads and executes under the
   explicit PowerShell 7 host before that capability is listed as supported.

## Sources

- [Installing PowerShell on Windows](https://learn.microsoft.com/en-us/powershell/scripting/install/install-powershell-on-windows)
- [Operations Manager system requirements](https://learn.microsoft.com/en-us/system-center/scom/system-requirements)
- [Management Pack lifecycle](https://learn.microsoft.com/en-us/system-center/scom/manage-mp-lifecycle)
