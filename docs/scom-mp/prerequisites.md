---
title: Prerequisites
description: What must be present in the management group and on the cluster before importing the Azure Local SCOM management packs.
---

# Prerequisites for the Azure Local SCOM Management Pack

Work through this page before importing the Azure Local management packs.

::: warning Lab preview
The Azure Local SCOM management packs are currently published as a **lab preview** and are not
sealed for production use. See the [downloads page](../downloads/scom-lab-preview.md) for the
current status and checksums. Treat everything below as preview guidance.
:::

The dependency tables on this page are **generated directly from the management pack source** by
`tools/scom/Export-MpDependencies.ps1`, so they cannot drift from what the packs actually require.

---

## Summary

| # | Prerequisite | Why it's needed | Blocking / Recommended |
|---|---|---|---|
| 1 | **SCOM 2019, 2022, or 2025** management group with the Operations console | Target platform. | Blocking |
| 2 | **Data Warehouse role** installed and healthy | The `Monitoring` and `Reporting` packs reference the data warehouse libraries. | Blocking |
| 3 | **SCOM agent deployed and healthy** on every Azure Local node to be monitored | Discovery is agent-hosted. | Blocking |
| 4 | **Base SCOM management packs** | Referenced by all packs in this solution. Present in any default installation. | Auto / no action |
| 5 | **Azure Local cluster deployed and operational** | The packs discover an existing cluster; they do not deploy or configure one. | Blocking |

---

## External management pack prerequisites

<!-- BEGIN GENERATED: external-dependencies -->
_No external management pack prerequisites. The packs in this solution depend only on management packs present in a default SCOM installation._
<!-- END GENERATED: external-dependencies -->

::: tip Nothing to download
Unlike the [Hyper-V solution](../hyper-v/prerequisites.md), the Azure Local packs reference only
management packs that ship with SCOM. There are no Microsoft or vendor packs to obtain separately —
provided your management group is a standard installation with the Data Warehouse role.
:::

---

## What each pack requires

<!-- BEGIN GENERATED: per-pack-dependencies -->
| # | Management pack | External prerequisites |
|---:|---|---|
| 1 | `HybridSolutionsCloud.AzureLocal.Library` | _none beyond the SCOM base packs_ |
| 2 | `HybridSolutionsCloud.AzureLocal.Discovery` | _none beyond the SCOM base packs_ |
| 3 | `HybridSolutionsCloud.AzureLocal.Monitoring` | _none beyond the SCOM base packs_ |
| 4 | `HybridSolutionsCloud.AzureLocal.Presentation` | _none beyond the SCOM base packs_ |
| 5 | `HybridSolutionsCloud.AzureLocal.Reporting` | _none beyond the SCOM base packs_ |
<!-- END GENERATED: per-pack-dependencies -->

---

## Import order

Import in this order so that no pack is imported before the packs it references.

<!-- BEGIN GENERATED: import-order -->
```text
 1. HybridSolutionsCloud.AzureLocal.Library
 2. HybridSolutionsCloud.AzureLocal.Discovery
 3. HybridSolutionsCloud.AzureLocal.Monitoring
 4. HybridSolutionsCloud.AzureLocal.Presentation
 5. HybridSolutionsCloud.AzureLocal.Reporting
```
<!-- END GENERATED: import-order -->

---

## Choosing between SCOM and Azure Monitor

Azure Local can be monitored through SCOM (this page) or through an Azure Monitor health model. The
two tracks have very different prerequisites — the Azure Monitor track requires Arc registration,
Insights, and a range of Azure-side configuration.

If you have not yet decided which track to use, read the
[Azure Monitor prerequisites](../azure-monitor/prerequisites.md) as well, then see the
[comparison](../comparison/index.md).

---

## Pre-flight checklist

- [ ] SCOM 2019, 2022, or 2025; Data Warehouse role healthy
- [ ] Agents deployed and healthy on all Azure Local nodes
- [ ] Azure Local cluster deployed and operational
- [ ] Lab-preview status understood — not for production management groups
- [ ] Checksums verified against the [downloads page](../downloads/scom-lab-preview.md)

---

## Next steps

Continue to the [management pack guide](management-pack-guide.md) for the import procedure.

## References

- [Download the SCOM management pack lab previews](../downloads/scom-lab-preview.md)
- [Azure Local management pack guide](management-pack-guide.md)
- [Azure Monitor prerequisites for Azure Local](../azure-monitor/prerequisites.md)
