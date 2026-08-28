# ADR 0041 — Hyper-V v2 Pure Storage integration

**Status:** Accepted

**Date:** 2026-08-28

**Decision owners:** Repository owner and maintainers

## Context

Hyper-V Private Cloud Monitoring v2 must map SAN failures to affected clusters, CSVs, VHDX files,
and virtual machines. Pure Storage FlashArray is the first supported array family. The design must
avoid duplicating supported vendor topology, must not store credentials in source or MP
configuration, and must state an evidence-based SCOM/Purity support boundary.

Pure's current public release is `PureStorageFlashArray` `2.0.120.0`, sealed with public key token
`a9d994eedb5e7179`. Its release notes support SCOM 2016, 2019, and 2022 and Purity 5.3 or later; they
do not claim SCOM 2025. Direct bundle inspection found 15 public classes, 10 public relationships,
12 discoveries, 24 unit monitors, 36 rules, seven views, dashboard components, and one public Run
As profile.

The vendor pack already owns arrays, controllers, hosts, host groups, ports, volumes, ActiveCluster
pods/replicas, array alerts, capacity, and performance. It does not expose the complete
host-to-volume-to-Windows-disk-to-CSV-to-VHDX-to-VM relationship chain required for private-cloud
service impact.

## Decision

Create an optional **Pure Storage Integration** adapter for the initial SCOM 2016/2019/2022 support
lane. It requires Pure Storage FlashArray MP `2.0.120.0` and reuses its public objects, keys,
relationships, endpoint property, and `PureStorage.FlashArray.FlashArrayAdminAccount` Secure
Reference.

The HCS adapter owns only these additions:

- read-only discovery of attachment and correlation facts missing from the vendor object graph;
- relationships from Windows iSCSI IQNs and Fibre Channel WWPNs to Pure hosts;
- relationships from Pure hosts/host groups to presented Pure volumes;
- correlation from Pure volume serials to Windows disks, MPIO paths, CSVs or SMB/SOFS storage,
  VHDX files, and affected VMs;
- monitoring-coverage and correlation-freshness health; and
- Pure branch membership and dependency rollup in the private-cloud DA.

Pure remains the leaf alert authority for array, controller, port, volume, pod, capacity, and
performance health. HCS rollups do not duplicate those alerts. HCS may alert only for HCS-owned
correlation/coverage failures or a verified missing condition that the vendor pack does not
monitor.

The adapter is not supported on SCOM 2025 until either Pure publishes a supported build or an HCS
read-only Purity REST 2.x provider passes API, security, scale, upgrade, and representative-array
labs. The product must fail preflight with a clear support message rather than silently importing
an unverified dependency. A future native provider must be mutually exclusive with the vendor
adapter to prevent duplicate Pure objects.

## Options considered

### Reimplement all Pure monitoring through REST

| Dimension | Assessment |
|---|---|
| Coverage control | High |
| Duplicate topology/alerts | High where the vendor MP is installed |
| Engineering and support burden | High |
| Recommendation | Rejected for the initial supported lane |

### Consume only generic SNMP or SCOM network monitoring

| Dimension | Assessment |
|---|---|
| Array-specific topology | Insufficient |
| Capacity, performance, protection, and pod health | Incomplete |
| Recommendation | Rejected |

### Integrate vendor objects and fill correlation gaps

| Dimension | Assessment |
|---|---|
| Authoritative identity | Preserved |
| Duplicate monitoring | Avoided |
| End-to-end SAN service impact | Added by HCS relationships |
| Supported SCOM lane | 2016, 2019, and 2022 |
| Recommendation | Accepted |

## Trade-off analysis

Depending on the vendor pack limits the first Pure adapter to Pure's stated support matrix, but it
preserves vendor-owned health and reduces security and maintenance risk. The HCS work is focused on
the private-cloud correlation chain that customers cannot obtain from either product alone.

## Consequences

- The Pure adapter is an optional sealed MP and is never a core prerequisite.
- Pure's sealed MP must be imported and configured before the HCS adapter.
- Run As distribution remains more-secure and limited to the resource pool/management servers that
  execute Pure workflows.
- HCS correlation discovery is read-only and must never acknowledge or close Pure array alerts.
- Pure volume performance workflows that are disabled by vendor default remain disabled unless the
  customer explicitly enables them in an unsealed override MP.
- SCOM 2025 Pure support remains an explicit release gap, not an implied compatibility claim.

## Action items

1. Encode the vendor MP identity, support boundary, public classes, keys, and Secure Reference.
2. Define SAN-core initiator, path, disk, CSV/VHDX, and VM correlation contracts.
3. Author Pure adapter relationships without rediscovering vendor objects.
4. Validate iSCSI, Fibre Channel, MPIO, ActiveCluster, failover, rename, credential failure,
   endpoint loss, and simultaneous S2D/SAN operation on a representative FlashArray.
5. Research and separately decide the SCOM 2025 Pure path.

## References

- [Pure Storage FlashArray SCOM Management Pack](https://github.com/PureStorage-Connect/SCOM-Management-Pack)
- [Pure Storage FlashArray SCOM MP 2.0.120.0 release](https://github.com/PureStorage-Connect/SCOM-Management-Pack/releases/tag/v2.0.120.0)
- [Pure Storage FlashArray PowerShell SDK 2](https://github.com/PureStorage-Connect/PowerShellSDK2)
- [V2 dependency and ownership contract](../hyper-v/v2-dependency-and-ownership-contract.md)

## Related decisions

- [ADR 0022 — SCOM Management Pack packaging boundaries](0022-scom-management-pack-packaging-boundaries.md)
- [ADR 0040 — Hyper-V v2 Microsoft S2D and SDN object ownership](0040-hyper-v-v2-microsoft-s2d-and-sdn-ownership.md)
