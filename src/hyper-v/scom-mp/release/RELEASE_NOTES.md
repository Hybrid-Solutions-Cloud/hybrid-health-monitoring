# Hyper-V Private Cloud Monitoring

Hyper-V Private Cloud Monitoring is a modular SCOM solution for standalone and clustered
Hyper-V private clouds. The release contains four required core Management Packs, nine optional
capability Management Packs, and separate public Discovery and Monitoring override starters for
11 deployment profiles in Lab, Standard, and Strict tiers.

## Management pack identities changed in this release

Management Packs are now named for the product rather than the publisher. The namespace is
`HyperVPrivateCloud.*` — for example `HyperVPrivateCloud.Library` and
`HyperVPrivateCloud.Capability.Cluster`. Publisher attribution is carried in the sealed pack
`Company` and `Copyright` metadata and in the documentation.

The version line restarts at `1.0.0.0`. This is the first release under this identity; the earlier
`2.0.0.0` package used the previous `HybridSolutionsCloud.HyperVPrivateCloud.*` identities and no
`1.0` was ever officially released under them.

**There is no in-place upgrade from `2.0.0.0`.** SCOM treats a renamed Management Pack as an
unrelated pack, so the earlier packs must be removed before these are imported. Removing them
discards any stored overrides and accumulated health state. See the prerequisites page and
ADR 0049 before upgrading.

Published override starters are named `HyperVPrivateCloud.Overrides.<Profile>.<Tier>.<Kind>` with
no organization prefix. Do not customize them in place — they are unsealed, so the console permits
it, but a later release republishes the same pack IDs and discards those edits. Create
customer-owned override Management Packs instead, which carry your own organization prefix.

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
