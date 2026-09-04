---
title: Start here
description: Pick the solution that matches your infrastructure and follow the numbered path from prerequisites to a working deployment.
---

# Start here

This site covers two independent monitoring solutions. They are completely separate platforms with distinct operational boundaries, separate management packs, and independent prerequisites:
- **Hyper-V Private Cloud**: Sovereign, 100% on-premises enterprise monitoring delivered through System Center Operations Manager (SCOM).
- **Azure Local**: Independent SCOM and cloud-native Azure Monitor tracks for Azure Local (formerly Azure Stack HCI).

Follow the path below that matches your infrastructure.

---

## Which solution do I need?

| If your infrastructure is… | Solution to use | Delivered through |
|---|---|---|
| **Hyper-V Private Cloud** — standalone or clustered hosts, SAN, S2D, SMB, SDN, SCVMM, or AD/DNS management infrastructure | **[Hyper-V Private Cloud Monitoring](#path-hyper-v-with-scom)** *(Flagship)* | SCOM 2019 / 2022 / 2025 |
| **Azure Local** (formerly Azure Stack HCI), and you run SCOM | **[Azure Local SCOM Management Pack](#path-azure-local-with-scom)** | SCOM 2022 / 2025 (Lab Preview) |
| **Azure Local**, and you want cloud-native monitoring | **[Azure Local Azure Monitor Health Model](#path-azure-local-with-azure-monitor)** | Azure Monitor & Azure Arc |

::: tip Independent deployments
Hyper-V and Azure Local are separate products with separate management packs and different health models. If your environment hosts both, deploy them independently.
:::

---

## Path: Hyper-V with SCOM (Flagship Solution) {#path-hyper-v-with-scom}

This is the fully realized, production-ready flagship solution. It consists of four core packs plus optional capability packs based on your infrastructure (Clustering, Storage, S2D, File Services, Physical Network, Network ATC, SDN, VMM, and Pure Storage).

1. **[Check the prerequisites](/hyper-v/prerequisites)**: Ensure required Microsoft base packs (Windows Server, Cluster, IIS/PowerShell) are imported.
2. **[Download the release](/downloads/hyper-v-private-cloud)**: Download the sealed production 12-pack bundle (`Hyper-V-Private-Cloud-Monitoring-Deployment-1.2.0.0.zip`).
3. **[Follow the administration guide](/hyper-v/management-pack-guide)**:
   - Import the sealed `.mp` packs into SCOM.
   - Configure agent proxying on all cluster nodes and Hyper-V hosts.
4. **[Apply the 2-Pack Override Solution](/hyper-v/operations-guide#tuning-overrides)**:
   - Apply [`HyperVPrivateCloud.Discovery.Overrides.xml`](/hyper-v/operations-guide#tuning-overrides) to set discovery schedules and scopes.
   - Apply [`HyperVPrivateCloud.Monitoring.Overrides.xml`](/hyper-v/operations-guide#tuning-overrides) for baseline monitor thresholds, rules, and alert settings.
5. **[Leverage the Central Operations Hub](/hyper-v/operations-guide)**:
   - Run built-in operator diagnostic tasks directly from the SCOM console:
     - `TestDomainHealth`: Validate Active Directory secure channel and domain controllers.
     - `TestDnsResolution`: Verify host DNS records and SRV registrations.
     - `TestPortConnectivity`: Run deep fabric port tests across gateways and domain controllers.
     - `TestPxeWdsHealth`: Check bare-metal deployment services and TFTP/PXE listeners.
     - `GetLldpNeighbor`: Discover connected Top-of-Rack switch ports and chassis IDs.
     - `PfcEtsCounters`: Inspect RDMA PFC pause frames and QoS priority drop counters.

---

## Path: Azure Local with SCOM {#path-azure-local-with-scom}

::: warning Lab preview
The Azure Local SCOM packs remain under active development in the lab and are not yet released for general production.
:::

1. **[Read the prerequisites](/azure-local/scom/prerequisites)** — lists the built-in SCOM dependencies.
2. **[Follow the management pack guide](/azure-local/scom/management-pack-guide)** — development and validation guidance.
3. **[Review the monitoring catalog](/azure-local/scom/monitoring-catalog)**.

---

## Path: Azure Local with Azure Monitor {#path-azure-local-with-azure-monitor}

Cloud-native monitoring for Azure Local clusters using Azure Arc, Azure Monitor Insights, and native Resource Health.

1. **[Read the cloud prerequisites](/azure-local/azure-monitor/prerequisites)** — Arc registration, Insights enablement, DCRs, and Azure RBAC assignments.
2. **[Understand the entity model](/azure-local/azure-monitor/diagrams/entity-graph)**.
3. **[Read the health model overview](/azure-local/azure-monitor/)**.

---

## SCOM vs. Azure Monitor (Azure Local Only)

For **Azure Local**, operators can choose between on-premises SCOM and cloud-native Azure Monitor:
- **[SCOM → Azure Monitor comparison](/comparison/)**: Detailed comparison of architecture, costs, and alerting semantics.
- **[Concept mapping](/design/concept-mapping)**: How SCOM classes, health states, and rollups map to Azure Monitor entities.

*Note: For **Hyper-V Private Cloud**, SCOM is the sole authoritative monitoring platform; there is no Azure Monitor dependency.*

---

## Where to find documentation

| If you want to… | Go to |
|---|---|
| **Deploy Hyper-V monitoring** | [Hyper-V Prerequisites](/hyper-v/prerequisites) and [Administration Guide](/hyper-v/management-pack-guide) |
| **Download management packs** | [Hyper-V Downloads](/downloads/hyper-v-private-cloud) |
| **Operate and troubleshoot** | [Operations & Troubleshooting Hub](/hyper-v/operations-guide) |
| **Understand thresholds and tuning** | [Monitoring Catalog Policy](/hyper-v/monitoring-catalog) |
| **Review architecture and design** | [Architecture & Reference Overview](/design/) |
| **Connect alerts to ServiceNow** | [Integrations](/integrations/) |
| **View project roadmap** | [Roadmap](/project/roadmap) |
