# Open questions

<!-- Unresolved questions or deferred decisions for the next session or tool to pick up. -->

- Remove the superseded clone at `D:/git/azurelocal/azurelocal-scom-mp` after the current process
  releases its Windows working-directory handle.
- Which Windows Server, SCOM, Failover Cluster, and optional SCVMM versions and topology fixtures
  form the first-release support matrix, including Network ATC eligibility and SCVMM/SDN-managed
  alternatives? Resolve in the research program.
- Which candidate thresholds are safe defaults after duration, recovery, dependency, and lab
  evidence are included? Resolve in the research program.
- Beyond the verified SCOM 2022 dependency set, which exact sealed dependency-MP versions should
  the first release support? Export them from each additional target SCOM release and run
  `Test-HyperVManagementPacksWithSdk.ps1`.
- **Release blocker:** SCOM's published agent requirement names Windows PowerShell 3.0 for MPs that
  use PowerShell scripts, while the HCS standard mandates `#Requires -Version 7.0`. Does each
  selected SCOM module type actually launch a PowerShell 7-compatible host? Prove it immediately
  in a representative agent lab. If not, author and validate an explicit `pwsh.exe` execution
  module or obtain a documented governance exception before claiming any v2 runtime support.
- Do stable VM identity, multi-node topology contributions, DA population/rollup, maintenance,
  migration/failover, recovery, upgrade, and removal behave as designed in SCOM?
- Does representative SCOM network discovery connect every HCS external-vSwitch Windows adapter
  to the expected physical switch port, propagate device/port faults through the intended diagram
  and health path, and remove relationships cleanly when an uplink or capability pack is removed?
- Does representative Windows Server 2025 Network ATC discovery preserve intent and per-node
  identity through convergence, drift, adapter changes, RDMA failure/recovery, VMM/SDN authority,
  cluster-node removal, and capability-pack removal without invoking remediation?
- Does the exact VMM 2025 integration populate the authored fabric, server, host, private-cloud,
  logical-network, network-site, and VM-network relationships under the scoped Microsoft Run As
  profile, and do failed-job detection/recovery, management-server failover, `ClusterNames`
  mapping, Network ATC/SDN coexistence, upgrade, and removal behave as designed?
- Does the Microsoft Windows Server SDN `10.0.0.2` prerequisite configure and discover correctly
  in every claimed SCOM/Windows Server pair, and do HCS controller-security, management/network
  branch, gateway, local host-binding, Network ATC/VMM coexistence, fault/recovery, and removal
  behaviors match the authored offline contract?
- What release signing identity and governed sealing pipeline will produce the first signed bundle?
- Beyond the verified SCOM 2022 dependency set, which official sealed dependency-MP versions should
  the first Azure Local release support, and does the suite pass VSAE verification against each?
- In the representative Azure subscription, do the preview Health Model resources deploy with the
  documented Azure Local metrics, identities, dimensions, and state transitions used by the Bicep
  baselines?
- For Hyper-V Azure Monitor, which supported SCVMM/Arc/AMA matrix supplies enough inventory and
  telemetry coverage, and how will DCR associations be governed at scale?
- Which ServiceNow release and SCOM version pair will be used for the connector lab, and will
  ServiceNow confirm SCOM 2025 support before that pair is claimed?
- Should the ServiceNow SCOM Metrics connector remain disabled permanently, or is there a licensed
  Metric Intelligence use case that justifies separate data-warehouse access and validation?
