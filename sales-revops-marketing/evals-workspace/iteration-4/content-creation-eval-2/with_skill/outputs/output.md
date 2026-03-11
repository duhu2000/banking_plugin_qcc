TASK:          Content Creation -- Case Study (Meridian Logistics / Arcline Analytics)
ICP MATCH:     STRONG (Director of Data Engineering at companies doing ERP migrations)
CONFIGURATION: Not configured (no sales-marketing.local.md found; using default brand voice: direct, confident, practical)
VERIFY DATA:   All prospect data should be verified before outreach

---

# How Meridian Logistics Cut Pipeline Breakage Detection from 6 Hours to 8 Minutes During an ERP Migration

---

## The Challenge

Meridian Logistics is a $340M revenue freight brokerage with 1,200 employees and a 14-person data engineering team. In mid-2025, they were in the middle of a multi-phase ERP migration -- the kind of project where upstream schemas change weekly and downstream dependencies break in ways nobody predicted.

The problem was specific and measurable: **schema changes from the ERP migration were silently breaking their dbt models, and nobody knew until the numbers looked wrong on a dashboard.**

Here is what that looked like in practice:

- Upstream ERP schema changes -- column renames, type coercions, dropped fields -- propagated through Fivetran connectors into the warehouse without any alert.
- **23 dbt models** broke silently across the dependency graph. They did not error out. They produced numbers that looked plausible but were wrong.
- BI dashboards showed **stale revenue numbers for an average of 6 hours per incident** before a human noticed.
- The detection method was not automated. It was the CFO's Monday morning board report. When the numbers looked obviously wrong, the CFO flagged it. The data team then spent hours tracing the breakage upstream.

For a Director of Data Engineering managing an ERP migration, this is the nightmare scenario: your migration is introducing schema changes faster than your monitoring can catch them, and the people discovering the breakages are your executive stakeholders, not your pipeline.

---

## Why They Chose Arcline Over Monte Carlo and Bigeye

Meridian's data engineering team evaluated three data observability platforms: Arcline Analytics, Monte Carlo, and Bigeye.

The decision came down to one technical differentiator:

**Arcline was the only tool that could monitor schema changes at the source connector level -- before data entered the warehouse.**

Monte Carlo and Bigeye both monitored data quality at the warehouse layer. For Meridian, that meant detection happened *after* broken data had already propagated through the pipeline and reached dashboards. During an active ERP migration where upstream schemas changed weekly, warehouse-level monitoring was always reactive. By the time it flagged an anomaly, the stale data had already been served to stakeholders.

Arcline's architecture monitors schema shape at the Fivetran connector level. When a source system changes a column name, drops a field, or coerces a type, Arcline detects it before the sync completes -- and maps the blast radius across every downstream dbt model and dashboard that will be affected.

For a team managing an ERP migration, this was the difference between "we detect breakages before they propagate" and "we detect breakages after the CFO calls."

---

## Implementation

Meridian deployed Arcline over a **3-week rollout** with no disruption to active pipelines:

- **Week 1:** Connected Arcline monitoring agents to **4 Fivetran connectors** handling the highest-change ERP data sources.
- **Week 2:** Mapped **38 dbt models** in the dependency graph, establishing lineage from source connector through to downstream dashboards.
- **Week 3:** Configured alerting thresholds, tuned false positive suppression, and ran parallel monitoring against the existing manual detection process to validate accuracy.

The data engineering team did not need to modify their existing dbt models or Fivetran configurations. Arcline operated as an observability layer on top of the existing stack.

---

## Results

The results were measured over the 90 days following full deployment:

| Metric | Before Arcline | After Arcline |
|---|---|---|
| Mean time to detect pipeline breakage | **6 hours** | **8 minutes** |
| False positive rate | N/A (no automated detection) | **4%** |
| Stale-dashboard incidents (90-day window) | Multiple per month | **Zero** |

**Detection time dropped by 97.8%.** Schema changes that previously went unnoticed for half a business day were now flagged and mapped within minutes of the source change.

The 4% false positive rate was deliberate -- Meridian's team tuned the sensitivity to favor over-alerting during the active ERP migration phase, preferring to investigate a few false flags rather than miss a real breakage. They plan to tighten the threshold once the migration stabilises.

The most significant result: **zero stale-dashboard incidents in 90 days.** Not a reduction. Zero.

---

## In Their Words

> *"I used to start every Monday checking whether the numbers were real. Now I just read them."*
>
> -- **CFO, Meridian Logistics**

That single sentence captures the shift. The data team moved from defending their outputs to delivering them. The CFO moved from interrogating reports to acting on them.

---

## Next Steps: For Directors of Data Engineering Managing ERP Migrations

If your team is in the middle of an ERP migration and your current monitoring only watches the warehouse layer, you are discovering breakages too late. The schema changes are happening upstream, and by the time warehouse-level checks flag an issue, stale data has already reached your stakeholders.

**Arcline runs a 30-minute technical assessment for data engineering teams mid-migration.** We will map your current Fivetran or Airbyte connector topology, identify which source systems are generating the most schema drift, and show you the blast radius of unmonitored changes across your dbt dependency graph.

No sales pitch. Just a lineage map of where your pipeline is exposed.

[Book a 30-minute migration risk assessment with Arcline's data engineering team.]
