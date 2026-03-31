# How Meridian Logistics Cut Pipeline Detection Time from 6 Hours to 8 Minutes with Arcline Analytics

## Challenge

Meridian Logistics is a $340M revenue freight brokerage with 1,200 employees and a 14-person data engineering team. Like many companies at their scale, they rely on a complex data infrastructure -- ERP systems feeding into Fivetran connectors, dbt transformation models, and downstream BI dashboards that the executive team uses to make revenue decisions every week.

The problem started when Meridian began a series of upstream ERP migrations. Each migration introduced schema changes at the source level -- columns renamed, data types shifted, tables restructured. These schema changes silently broke 23 dbt models in their warehouse pipeline. "Silently" is the key word: there were no alerts, no warnings, no flags.

The breakage manifested as stale revenue numbers on BI dashboards. On average, each incident left dashboards showing incorrect data for **6 hours** before anyone noticed. And "anyone" was typically the CFO, opening her Monday morning board report and seeing numbers that were obviously wrong.

The data engineering team would then scramble to diagnose the issue -- tracing back through dbt models, checking connector logs, and identifying which schema change in which upstream ERP migration had caused the cascade failure. Every incident cost hours of engineering time and, more importantly, eroded executive trust in the data.

For a Director of Data Engineering managing ERP migrations, this is a familiar nightmare: upstream changes that break downstream pipelines with no observability layer in between.

## Why They Chose Arcline

Meridian's data engineering team evaluated three platforms: **Arcline Analytics**, **Monte Carlo**, and **Bigeye**.

The evaluation came down to one critical architectural distinction. Monte Carlo and Bigeye both monitor data quality within the warehouse -- they detect anomalies after data has already landed. For Meridian's specific problem, that was too late. By the time warehouse-level monitors flagged an issue, stale data had already propagated to dashboards.

**Arcline was the only tool that could monitor schema changes at the source connector level -- before data entered the warehouse.** This meant Arcline agents could detect an ERP schema change at the Fivetran connector layer, flag the impacted dbt models, and alert the engineering team before broken data ever reached a dashboard.

For a team in the middle of ongoing ERP migrations, this source-connector-level monitoring was the difference between reactive firefighting and proactive detection.

## Implementation

Arcline deployed in a focused 3-week rollout:

- **Week 1:** Arcline agents installed on **4 Fivetran connectors** linked to Meridian's primary ERP sources. Baseline schema fingerprints captured for each connector.
- **Week 2:** Agents extended to monitor **38 dbt models** downstream, mapping the dependency chain from connector to model to dashboard. Alert routing configured to notify the data engineering team via Slack and PagerDuty.
- **Week 3:** End-to-end testing with simulated schema changes. Fine-tuning of alert sensitivity to minimize false positives while catching real breakage.

The deployment required no changes to Meridian's existing Fivetran or dbt configurations. Arcline operated as an observability layer on top of their current stack.

## Results

In the 90 days following deployment, Meridian Logistics measured three key outcomes:

| Metric | Before Arcline | After Arcline |
|--------|---------------|---------------|
| Mean time to detect pipeline breakage | **6 hours** | **8 minutes** |
| False positive rate | N/A (no monitoring) | **4%** |
| Stale-dashboard incidents | Multiple per month | **Zero in 90 days** |

**Detection time dropped from 6 hours to 8 minutes** -- a 98% reduction. Schema changes in upstream ERP migrations were now caught at the connector level within minutes, before broken data could propagate to dashboards.

The **4% false positive rate** meant the engineering team could trust the alerts without drowning in noise. Out of every 100 alerts, 96 were legitimate issues that needed attention.

And the metric that mattered most to the executive team: **zero stale-dashboard incidents in 90 days**. The Monday morning scramble was over.

## Quote

> "I used to start every Monday checking whether the numbers were real. Now I just read them."
>
> -- **CFO, Meridian Logistics**

## Next Steps

If you are a Director of Data Engineering managing ERP migrations and dealing with silent pipeline breakage, here is what we recommend:

1. **Assess your exposure:** How many dbt models sit downstream of ERP sources currently undergoing migration? That is your blast radius.
2. **Audit your detection layer:** Are you monitoring data quality only inside the warehouse, or are you catching schema changes at the source connector level before data lands?
3. **See Arcline in your environment:** We offer a scoped pilot deployment on your highest-risk connectors. In 30 minutes, we can map your ERP-to-dashboard dependency chain and show you exactly where Arcline agents would sit.

**Book a 30-minute pipeline observability assessment:** [Schedule Here]

Arcline Analytics helps data engineering teams catch pipeline breakage before it reaches dashboards. If your team is managing ERP migrations and tired of discovering broken data after the CFO does, let's talk.
