# Hyper-V Private Cloud Monitoring v2

Hyper-V Private Cloud Monitoring v2 is a modular SCOM solution for standalone and clustered
Hyper-V private clouds. The release contains four required core Management Packs, nine optional
capability Management Packs, and separate public Discovery and Monitoring override starters for
11 deployment profiles in Lab, Standard, and Strict tiers.

The core provides the `Hyper-V Private Cloud` console hierarchy, a native Distributed Application,
host and virtual-machine topology, health, alerts, performance, diagnostics, operational
knowledge, and views. Optional capabilities integrate Microsoft Failover Clustering and CSV,
Windows SAN storage, Microsoft Storage Spaces Direct, Pure Storage FlashArray, SMB/SOFS, physical
network discovery, Network ATC, Windows Server SDN, and System Center VMM.

Read `release-manifest.json` before import. It contains the exact product identity, prerequisite
IDs and minimum versions, publisher dependency evidence, artifact hashes, and public override
inventory. Import only the capability MPs selected for the deployment. Review starter overrides
and copy them into customer-owned unsealed MPs; never customize the Default Management Pack.

Use `SHA256SUMS.txt` to verify every downloaded asset. The complete, core, overrides, individual
MP, and deployment-profile assets are generated from the same approved source commit and signing
identity.
