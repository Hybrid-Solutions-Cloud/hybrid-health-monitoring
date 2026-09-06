---
title: Day-2 support and health tracing
description: Trace private-cloud health to its originating monitor, distinguish warnings from outages, and investigate safely with object-specific support knowledge.
---

# Day-2 support and health tracing

Start with the **Hyper-V Private Cloud** solution diagram, then follow the unhealthy health aspect
through its service boundary and component to the originating monitor. The
[object and monitor reference](catalog.md) documents each authored object type, unit monitor,
dependency, rule and task. It is generated from source; candidate improvements require a new
sealed release before they appear in an installed console.

## Read the health path, not just the alert count

In Health Explorer, expand the unhealthy dependency and open its member monitor. Capture the
root, branch, leaf object, monitor name and state-change time. A red parent means a dependency
evaluated unhealthy; it does not mean every member of that parent failed. Several alerts can be
consequences of one resource failure. Conversely, unresolved event-rule alerts may remain after
the corresponding condition has recovered. [Microsoft: Health Explorer](https://learn.microsoft.com/en-us/system-center/scom/manage-consoles-overview-healthexplorer?view=sc-om-2025).

| Layer | What to establish |
|---|---|
| Solution / fabric / management stack | Which boundary or shared management dependency contributes the state? |
| Service boundary | Which aspect and component are unhealthy: availability, performance, configuration or security? |
| Component dependency | Which named member and monitor supply the state? Containment alone is not health propagation. |
| Leaf monitor | What actual value, state, error and effective policy triggered it? |
| Native evidence | Does a fresh platform query confirm the condition, and what is its first failing dependency? |

The VMM fabric must be linked into the main solution, including its management component. Security
must propagate from SDN certificate/controller monitors through component, service and enterprise
levels. These links are part of source validation, not manual console edits.

The source graph validator checks every enabled product unit monitor for a path to the root.
The reference includes a representative path for each reachable leaf. It does not claim to verify
vendor-internal dependencies or live discovery membership; those require the installed/native
management pack and runtime evidence. Inventory-only objects are described explicitly instead of
being assigned synthetic green health.

Health Explorer can also show inherited Microsoft service-designer monitors such as **All Contained
Objects** alongside the product's named dependencies. They can represent an additional path for the
same incident. Inspect their member monitor and unavailable-member policy rather than assuming every
rollup has the same behavior. Do not count two paths to one failed role as two separate outages.

## Warning, critical and missing evidence

- **Warning:** investigate reduced headroom, degraded redundancy, approaching expiry or an accumulating
  error trend according to the exact leaf. It does not automatically imply an outage is imminent.
- **Critical:** a critical condition or threshold is met. Establish the affected service and impact;
  quota exhaustion, replication protection loss and stopped compute workloads have different impacts.
- **Unknown / unmonitored / out of contact:** do not interpret missing evidence as green. Check the
  Monitoring Pipeline and collector freshness before relying on previously recorded leaf values.
- **Not applicable:** an optional technology is absent or out of scope. It is not a successful test
  of that technology. Do not install an unused capability just to satisfy monitoring.

The generated reference shows exact compiled detection expressions and configuration. Always check
effective overrides. A monitor can show Warning without generating an alert if its alert threshold
is Error. Equal warning and critical thresholds provide no intermediate numeric warning band.
Sampling every five minutes does not imply five minutes of persistence or multiple bad samples.

Prioritize falling CSV/pool capacity, reduced storage paths, disk predictive faults, certificate
expiry, sustained performance pressure and repeated role failures. These are measured leading
indicators where supported—not a universal prediction engine. Review thresholds against real
workload behavior, failover reserve and the agreed service objective.

Examples from the candidate defaults (these describe **health states**, not notification subscriptions):

| Signal | Warning band | Critical band | Day-2 response before an outage |
|---|---|---|---|
| Lowest CSV free space | More than 8% and at most 15% | At most 8% | Identify the named volume, growth source, checkpoint/backup activity and expansion lead time. |
| Lowest S2D pool free capacity | More than 10% and at most 20% | At most 10% | Check repair reserve, pool growth and approved capacity plans. |
| SDN certificate lifetime | More than 14 and at most 30 days | At most 14 days | Identify the certificate, owning service and supported renewal/rotation workflow. |
| Oldest VM checkpoint | At least 168 but less than 336 hours | At least 336 hours | Confirm retention intent, backup ownership and merge headroom before supported cleanup. |

These are authored product defaults, not Microsoft-prescribed thresholds. Check the matching
monitor in the reference and its effective overrides before taking action. A rapid outage can cross
directly into Critical between samples. Monitor thresholds alone provide no guaranteed advance notice.

## Incident evidence and safe response

Record the stable object identity, current owner, UTC sample and event times, state-change context,
actual metric and units, effective thresholds, collection window, first error and recent changes.
Use the relevant diagnostic task or native read-only query. Old alert descriptions can contain
the original failure rather than the latest sample, so retain both and label their times.

Only perform a corrective action after the affected service owner agrees to the impact and recovery
plan. Do not reset parent health, disable a monitor, delete a role, restart a host, force quorum,
delete checkpoint files or weaken security to make the diagram green. Customer tuning belongs in
customer-owned override packs. Product defects belong in MP source, tests and a new sealed version.

## Cluster role example

A resource failure can produce event 1069, role failure 1205 and exhausted attempts 1254. These are
not three independent VM migrations. Match the named role/resource fields and inspect the earliest
error. The cluster failure-episode metric groups local events by role and five-minute window;
it is not an exact count of failovers and can remain elevated until its lookback window expires.

For a failed VM Configuration resource, match its VmId with registered VMs on every possible owner
and check the configuration path. An absent VM can indicate an orphaned role or missing registration;
do not delete it until ownership and recoverability are established. For a failed Replica Broker
Network Name, inspect its AD object and the cluster account's delegated permissions before retrying.
An intentionally stopped VM and an empty Available Storage group need intent-aware interpretation.
[Microsoft: VM accessibility failures](https://learn.microsoft.com/en-us/troubleshoot/windows-server/virtualization/hyper-v-start-state-access-failures-clustered-standalone),
[Microsoft: cluster computer objects](https://learn.microsoft.com/en-us/windows-server/failover-clustering/prestage-cluster-adds).

## Verify recovery and escalate

Require fresh native evidence and a recovered originating monitor; then follow the dependencies
back up to the solution. Allow documented lookback and discovery intervals. Do not close an incident
solely because the dashboard was reset or the old alert was acknowledged. Escalation should include
the complete health path and evidence above, plus the relevant runbook and diagnostic output.

No workload-VM SCOM agent is required by this solution. Host power state, integration heartbeat and
replication evidence do not establish that an application inside the guest is healthy. External
switches, firewalls, chassis and storage arrays require their native/vendor monitoring for depth;
a configured TCP endpoint test proves only that tested path and port.

## Maintaining this support model

Object descriptions and reviewed operational guidance live in
`src/hyper-v/scom-mp/support/support-catalog.psd1`. The builder adds this guidance to console knowledge;
`Export-HyperVPrivateCloudSupportGuide.ps1` exports the same knowledge to this reference. Edit those
sources, then rebuild and regenerate the pages. Do not hand-edit the generated capability pages.

`Test-HyperVPrivateCloudHealthGraph.ps1 -Path <compiled-pack-directory> -FailOnMissing` must find a
root path for every enabled product unit monitor. The day-2 regression tests also check knowledge
coverage, exact state explanations, valid Microsoft links, unique display identities, participation
gating and VMM enterprise discovery payloads. Run schema and SDK validation as separate gates: the
schema alone does not catch every SDK identity error.

After sealing elsewhere, import the complete compatible set through the normal deployment process.
Verify the **installed version**, fresh discovery membership and actual leaf-to-root recovery in
Health Explorer. A source graph pass is not proof that a sealed update has been imported or that
every optional vendor technology has been exercised in a live environment.
