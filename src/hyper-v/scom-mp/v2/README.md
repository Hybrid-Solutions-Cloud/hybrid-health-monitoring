# Hyper-V Private Cloud Monitoring v2 source

This is the clean v2 authoring root. It is intentionally separate from the published `0.1`
preview source one directory above it. V2 uses the immutable element namespace
`HybridSolutionsCloud.HyperVPrivateCloud` and the console-facing product name **Hyper-V Private
Cloud Monitoring**.

The build manifest records an explicit implementation status for every required artifact. Build
automation refuses to treat a planned artifact as authored, preventing an incomplete source tree
from being packaged as the complete product. The Library, Discovery, and Monitoring artifacts are
currently authored; Presentation is still recorded as planned.

Core Discovery includes the VMMS registry seed plus staged topology for stable standalone/cluster
boundaries, hosts, VMs, VHDs, VM adapters, virtual switches, Replica relationships, monitoring
pipelines, and all seven Distributed Application branches. Optional Cluster/CSV, SAN/Pure, S2D,
Network ATC, physical network, SDN, and VMM topology remains isolated in capability MPs.

Core Monitoring currently provides 13 host unit monitors, nine agent-hosted per-VM runtime unit
monitors, 14 DA dependency rollups, 12 performance rules, a diagnostic task, and operational
knowledge for every unit monitor. The runtime projection lets workflows execute on the VM's
current host while preserving a separate logical VM identity through migration.

Build the currently authored artifacts with PowerShell 7:

```powershell
./tools/Build-HyperVPrivateCloudManagementPacks.ps1 `
  -Version 2.0.0.0 `
  -PublicKeyToken 0123456789abcdef
```

Development XML is written to `out/development/`. Release sealing remains a separate governed
step and requires the repository signing identity.
