---
title: Start here
description: Pick the solution that matches your infrastructure and follow the numbered path from prerequisites to a working deployment.
---

# Start here

This site covers two independent monitoring solutions. They share design vocabulary but ship
separately, install separately, and have different prerequisites.

Work out which one you need, then follow its numbered path.

---

## Which solution do I need?

| If your infrastructure is… | Use | Delivered through |
|---|---|---|
| **Hyper-V hosts** — standalone or failover-clustered, with SAN, S2D, SMB, SDN, or VMM | [Hyper-V Private Cloud Monitoring](#path-hyper-v-with-scom) | SCOM |
| **Azure Local** (formerly Azure Stack HCI), and you already run SCOM | [Azure Local SCOM management pack](#path-azure-local-with-scom) | SCOM |
| **Azure Local**, and you want cloud-native monitoring | [Azure Local Azure Monitor health model](#path-azure-local-with-azure-monitor) | Azure Monitor |

::: tip Running both?
Hyper-V and Azure Local are separate products with separate management packs. If you run both, deploy
them independently — start with whichever is more urgent and repeat the other path afterwards. See
[why they are separate](/design/decisions/0021-platform-and-delivery-track-architecture).
:::

---

## Path: Hyper-V with SCOM {#path-hyper-v-with-scom}

The most complete solution on this site. Four required packs plus nine optional capability packs you
choose from based on what your environment actually runs.

1. **[Read the prerequisites](/hyper-v/prerequisites)** — do this first. Most failed imports are a
   missing Microsoft or vendor management pack, and this page lists every one of them with exact
   versions and download links.
2. **[Choose your capabilities](/hyper-v/prerequisites#choose-your-capabilities)** — decide which of
   the nine optional packs apply so you only obtain the prerequisites you actually need.
3. **[Download the release](/downloads/hyper-v-private-cloud)** — take the sealed bundle that
   matches your deployment profile.
4. **[Follow the administration guide](/hyper-v/management-pack-guide)** — import, verify, and tune.
5. **[Review the monitoring catalog policy](/hyper-v/monitoring-catalog)** — understand what is
   monitored out of the box and what is opt-in.

**Time to first health data:** allow a working day if you need to obtain Microsoft prerequisite packs
and configure Run As profiles for VMM, SDN, or Pure Storage.

---

## Path: Azure Local with SCOM {#path-azure-local-with-scom}

::: warning Lab preview
These packs remain under development and are not publicly downloadable.
:::

1. **[Read the prerequisites](/azure-local/scom/prerequisites)** — shorter than the Hyper-V list; these packs
   reference only management packs that ship with SCOM.
2. **[Follow the management pack guide](/azure-local/scom/management-pack-guide)** — development and validation guidance only.
3. **[Review the monitoring catalog](/azure-local/scom/monitoring-catalog)**.

---

## Path: Azure Local with Azure Monitor {#path-azure-local-with-azure-monitor}

Cloud-native. No management packs — this is Azure-side configuration, and the prerequisites are
substantial.

1. **[Read the prerequisites](/azure-local/azure-monitor/prerequisites)** — sixteen items, most of them blocking.
   Budget real time for Arc registration, Insights enablement, and RBAC.
2. **[Understand the entity model](/azure-local/azure-monitor/diagrams/entity-graph)**.
3. **[Read the health model overview](/azure-local/azure-monitor/)**.

---

## SCOM vs. Azure Monitor (Azure Local Only)

For **Azure Local**, you have a choice between on-premises SCOM and cloud-native Azure Monitor. The two tracks differ in prerequisites, cost model, and deployment requirements:

- [SCOM → Azure Monitor comparison](/comparison/)
- [Concept mapping](/design/concept-mapping) — how SCOM classes, health states, and rollups correspond to Azure Monitor entities

For **Hyper-V Private Cloud**, SCOM is the definitive, authoritative monitoring engine. Hyper-V has no dependency on Azure Arc or Azure Monitor.

---

## Where things live

| I want… | Go to |
|---|---|
| To install something | The prerequisites page for your solution, then its guide |
| To know what is monitored | The monitoring catalog for your solution |
| To understand a design choice | [Architecture decisions](/design/decisions/) |
| To see the architecture | [Design and architecture](/design/) |
| To wire alerts into ServiceNow | [Integrations](/integrations/) |
| To know what is shipping when | [Roadmap](/project/roadmap) |
