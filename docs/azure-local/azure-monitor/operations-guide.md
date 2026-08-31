---
title: Operations guide
description: Deploying and operating the Azure Local Azure Monitor Health Model preview - deployment, health states, alerts, the workbook, and what preview means day to day.
---

# Operating the Azure Local health model

This page covers using the Azure Monitor Health Model for Azure Local: deploying it, reading it,
and what to do when it changes state. Work through the [prerequisites](prerequisites.md) first —
**the model collects nothing itself**; it consumes signals that HCI Insights, the Azure Monitor
Agent, and Resource Health must already be producing.

::: warning Preview service, preview baseline
Azure Monitor Health Models are a preview Azure service, and this implementation is a
development baseline: entity graph, two evidence-backed metric signals, alerts, parameters and a
starter workbook. Expect the service APIs, and therefore this deployment, to change before GA.
:::

## Deploy

The deployment is one Bicep stack at resource-group scope:

```powershell
# 1. Copy and fill a parameter file (lab.bicepparam or standard.bicepparam):
#    - monitorAccountName, healthModelName
#    - azureLocalClusterResourceId  (the Microsoft.AzureStackHCI/clusters resource ID)
#    - actionGroupIds               (who gets paged on Degraded/Unhealthy)
# 2. Deploy:
az deployment group create `
  --resource-group <rg> `
  --template-file src/azure-local/azure-monitor/bicep/main.bicep `
  --parameters src/azure-local/azure-monitor/bicep/parameters/standard.bicepparam

# 3. Validate the deployed model against the compile-time contract:
./src/azure-local/azure-monitor/scripts/Test-AzureLocalHealthModel.ps1
```

The stack creates the Azure Monitor account and the Health Model with a system-assigned managed
identity; grant that identity the reader roles the [prerequisites](prerequisites.md#10-rbac-and-identity-prerequisites-cumulative)
list, or signal evaluation stays empty.

- **Lab** parameters loosen the development thresholds; **Standard** mirrors the documented
  defaults (CPU Degraded 80 / Unhealthy 90, storage-fault counts 1 / 2). Both are development
  values — tune them per estate with your own `.bicepparam`.
- Redeploying the same stack with changed parameters is the supported way to retune; the model is
  declarative, so treat your parameter file as the source of truth and keep it in change control.

## Reading health

The model's entity graph is: **Deployment** at the top, six domain entities (compute, storage,
networking, Azure integration, lifecycle, monitoring) beneath it, and the Azure Local cluster's
Azure resource entity feeding them. Health propagates upward — the Deployment entity is the one
number to watch, and its state is what the alerts fire on:

- **Degraded** — a domain crossed its warning-level threshold (for example sustained CPU above the
  Degraded threshold). Investigate; nothing is assumed down.
- **Unhealthy** — the unhealthy threshold or a hard fault signal. Treat as an incident.

Signals are deliberately few in the preview: two evidence-backed Azure Local platform metrics.
The KQL under `kql/signals/` is **research-only** — it is not attached to the model until each
query's target schema is validated against a live estate, so absence of a signal is not proof of
health. For anything the model does not yet cover, the SCOM pack remains the deep on-premises
truth; the health model is the Azure-side rollup.

## Day-two flow

1. Alert (via your action group) or the Deployment entity turns Degraded/Unhealthy.
2. Open the **Azure Local investigation workbook** (`workbooks/azure-local-health.workbook.json`,
   import into Azure Monitor Workbooks) — it pivots the cluster's Insights and metric data around
   the failing domain.
3. Cross-check **Resource Health** and the **Activity Log** for the cluster resource: platform
   events (registration, agent, service outages) explain most Azure-integration state changes.
4. If the on-premises side needs eyes, pivot to the SCOM pack's
   [operations guide](../scom/operations-guide.md) — same domains, deeper signals.
5. After remediation the model re-evaluates on its own; there is nothing to reset.

## Known preview edges

- Health evaluation stops silently if the managed identity loses its read permissions — recheck
  RBAC first when everything goes grey.
- Region support for the Health Models preview is limited; the deployment's `location` must be a
  supported region even if the cluster lives elsewhere.
- Signal latency follows the underlying pipelines (Insights/metrics), so expect minutes, not
  seconds, between a fault and a state change.
