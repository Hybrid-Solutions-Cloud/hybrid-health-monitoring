# ADR 0044 — Hyper-V v2 Network ATC monitoring contract

**Status:** Accepted

**Date:** 2026-08-28

**Decision owners:** Repository owner and maintainers

## Context

Network ATC is an operating-system networking authority, not a SCOM Management Pack object model.
The Hyper-V v2 suite needs to show intent identity, participating adapters, per-node convergence,
global overrides, and private-cloud service impact without changing the configuration or making
Network ATC mandatory for manual, VMM-managed, or SDN-managed environments.

Microsoft documents `Get-NetIntent` for current standalone or cluster intent requests and
`Get-NetIntentStatus` for consolidated per-host status. The supported status surface includes
`IntentName`, `Host`, `ProvisioningStatus`, and `ConfigurationStatus`. Current Windows Server 2025
implementation inspection also proves intent types Compute, Storage, Management, Stretch, SDN,
and Switchless; goal states Provisioning, ProvisioningUpdate, Success, Retrying, Failed,
Validating, and Pending; and actionable error codes including `PhysicalAdapterNotFound`,
`PhysicalAdapterNotSymmetric`, `WindowsFeatureNotInstalled`, and `RdmaNotOperational`.

## Decision

Ship `HybridSolutionsCloud.HyperVPrivateCloud.Capability.NetworkATC` as an optional sealed
capability. It references only the matching v2 Library and Presentation MPs plus built-in SCOM
libraries. It has no Microsoft or vendor MP prerequisite because the authoritative Network ATC
contract is the local Windows feature and PowerShell module.

Model three HCS-owned concepts:

1. `NetworkIntent`, unhosted and keyed by private-cloud `BoundaryId` plus `IntentName`. This is the
   stable requested/expected configuration across clustered nodes.
2. `NetworkIntentNodeStatus`, hosted by the Windows computer and keyed by `IntentName`. This is the
   local actual/convergence state and execution target for per-node workflows.
3. `GlobalConfigurationStatus`, hosted by the Windows computer and keyed by `BoundaryId`. This
   records cluster/proxy override kinds and their convergence when present.

Relate the Network component to intents and global status; relate each intent to its per-node
status; relate the HCS host to its status objects; and relate node status to the exact
`Microsoft.Windows.ComputerNetworkAdapter` objects using Windows `DeviceID` and MAC values. Do not
create a second adapter, switch, or physical-network model.

Use these health semantics:

- `ConfigurationStatus = Success`, `ProvisioningStatus = Completed`, and no error is Healthy.
- Failed/error states are Critical.
- Validating, provisioning, pending, updating, or retrying is Warning during the configurable
  convergence window and Critical after the default 30-minute limit.
- An unrecognized state is Warning rather than inferred Healthy.
- Missing or down participating adapters are Critical.
- Storage-intent adapters require RDMA by default; nested or explicitly non-RDMA labs may override
  that policy.
- Missing Network ATC or no configured intent is Not Applicable when `RequireNetworkATC` is false.
  When the operator declares Network ATC authoritative by setting it true, the same condition is
  Critical and actionable.

The capability is strictly read-only. It may call `Get-NetIntent`, `Get-NetIntentStatus`,
`Get-NetAdapter`, and `Get-NetAdapterRdma`. It must never call Add/Set/Remove/Update-NetIntent,
`Set-NetIntentRetryState`, restart the Network Intent service, or mutate adapter, QoS, VLAN, DCB,
RDMA, switch, or cluster configuration.

## Options considered

### Treat Network ATC as mandatory whenever the pack is imported

Rejected. Optional capability import is not enough evidence that every host in a management group
uses Network ATC, and it would make manual, VMM, and SDN authority paths falsely Critical.

### Discover only one cluster-wide status object

Rejected. Microsoft reports convergence per host. A single merged status would hide asymmetric
adapter or node failures and would not supply an agent-hosted monitoring target.

### Monitor status but automatically retry failed intents

Rejected. SCOM monitoring must not change production networking. Retrying an intent can alter
switch, QoS, VLAN, RDMA, and adapter configuration and requires a separate approved remediation
workflow.

## Trade-off analysis

The public cmdlet documentation does not publish a formal .NET output schema for every release.
The discovery therefore consumes the documented property names first and narrowly supports known
compatible aliases. Missing or unknown fields surface as Warning or pipeline failure; they never
become Healthy by assumption. Representative Windows Server and SCOM labs remain the authority for
output-shape, cluster contribution, convergence-duration, and lifecycle behavior.

## Consequences

- Network ATC can be installed alongside the physical-network adapter without duplicating SCOM
  network-device monitoring.
- Clustered intents retain one stable logical identity while exposing independent health per node.
- Global and per-intent override *kinds* are visible without serializing potentially sensitive
  proxy values or configuration payloads into SCOM properties.
- The Network component rolls intent, node, adapter, and global-setting health into the private-
  cloud Distributed Application without duplicate dependency alerts.
- Release certification must test absent/manual authority, required-but-missing capability,
  successful convergence, prolonged validation, explicit failures, asymmetric/missing adapters,
  RDMA policy, drift correction, recovery, node addition/removal, and capability-pack removal.

## Related decisions

- [ADR 0025 — Hyper-V network-management authority](0025-hyper-v-network-management-authority.md)
- [ADR 0042 — Hyper-V v2 file services and physical network ownership](0042-hyper-v-v2-file-services-and-physical-network-ownership.md)
- [ADR 0043 — Hyper-V v2 package and deployment profile architecture](0043-hyper-v-v2-package-and-deployment-profile-architecture.md)

## Sources

- [Host networking with Network ATC](https://learn.microsoft.com/en-us/windows-server/networking/network-atc/network-atc)
- [`Get-NetIntent`](https://learn.microsoft.com/en-us/powershell/module/networkatc/get-netintent?view=windowsserver2025-ps)
- [`Get-NetIntentStatus`](https://learn.microsoft.com/en-us/powershell/module/networkatc/get-netintentstatus?view=windowsserver2025-ps)
- [Manage Network ATC](https://learn.microsoft.com/en-us/windows-server/networking/network-atc/manage-network-atc)
- [`Set-NetIntent`](https://learn.microsoft.com/en-us/powershell/module/networkatc/set-netintent?view=windowsserver2025-ps)
