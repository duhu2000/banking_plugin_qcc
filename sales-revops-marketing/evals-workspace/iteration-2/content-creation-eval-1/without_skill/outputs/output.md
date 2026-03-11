# Your Monitoring Dashboard Says Everything Is Fine. Your Data Disagrees.

*By Danielle Kwon, Head of Engineering at Arcline Analytics*

---

Last quarter, a former colleague at a Series C fintech spent three weeks tracking down a revenue reconciliation bug. Dashboards were green. Alerts were silent. Every system health metric looked pristine.

The problem? A schema change in a third-party payment processor had silently altered how currency codes were formatted. The data kept flowing. Pipelines kept running. But every number on the executive dashboard had been wrong for nineteen days before anyone noticed.

If you run data infrastructure at a mid-market SaaS company, I would wager you have your own version of this story.

## The Gap Between "Systems Up" and "Data Right"

Traditional monitoring was built to answer a specific question: *Is the system running?* CPU utilization, memory pressure, job completion status, latency percentiles -- these are operational health indicators, and they are genuinely important. But they share a blind spot that becomes more dangerous as your data footprint grows: they tell you nothing about whether the data moving through your pipelines is actually correct.

Consider what a typical monitoring stack catches versus what it misses.

**What traditional monitoring detects well:**
- Pipeline job failures and timeouts
- Infrastructure resource exhaustion
- API endpoint downtime
- Query performance degradation

**What it routinely misses:**
- Gradual distribution shifts in key metrics
- Schema drift from upstream sources you do not control
- Silent changes in data volume patterns
- Semantic corruption where values are syntactically valid but logically wrong
- Freshness decay in tables that downstream teams assume are current

The second list is where data quality incidents actually live. And if your organization is like most I have worked with, you discover these problems the same way: someone on the business side opens a dashboard and says, "These numbers don't look right."

That is not an engineering workflow. That is damage control.

## Why This Problem Gets Worse at Scale

At a 50-person startup, your data engineer probably built the pipeline and also consumes the output. The feedback loop is tight. When something looks off, the person who notices is often the person who can fix it.

At 200 to 1000 employees, that tight loop is gone. You have multiple teams producing data, multiple teams consuming it, and a growing mesh of dependencies that no single person fully understands. The data engineer who built the ingestion pipeline may have left the company two years ago. The analyst querying the output table has no visibility into upstream changes. The monitoring system sits between them, faithfully confirming that jobs completed on time, while saying nothing about whether the data those jobs produced is trustworthy.

This is the inflection point where monitoring alone stops being sufficient and observability becomes necessary.

## Monitoring vs. Observability: A Distinction That Matters for Data

In application engineering, the monitoring-to-observability shift is well understood. You move from predefined alerts on known failure modes to instrumented systems that let you ask novel questions about emergent behavior. The same shift applies to data infrastructure, but the specifics look different.

Data observability means treating your datasets, pipelines, and transformations as systems whose internal states should be continuously introspectable. In practice, this involves several layers:

**Profiling at ingestion.** Rather than simply confirming that a data load completed, you characterize the data that arrived. Row counts, null rates, value distributions, schema fingerprints. You build a statistical portrait of what "normal" looks like for each dataset, and you surface deviations as they happen -- not after they have propagated through six downstream tables.

**Lineage-aware context.** When a metric shifts, the first question is always "why?" Without lineage, answering that question means manually tracing dependencies across dbt models, orchestrator DAGs, and source system documentation that may or may not be current. With lineage built into your observability layer, you can trace an anomaly backward through the transformation graph to the point where the drift originated.

**Drift detection over threshold alerting.** Traditional monitoring relies on static thresholds: alert if row count drops below X, alert if null rate exceeds Y. These require you to know in advance what "bad" looks like. Drift detection learns the baseline behavior of each dataset and flags statistically significant departures. This catches the slow-moving problems -- the ones that would not trigger a threshold alert on any single day but that compound into material data quality failures over weeks.

**Freshness and volume as first-class signals.** A table that updates every hour for six months and then silently stops is not a failure traditional monitoring will catch. The ETL job may still run; it just is not finding new records. An observability-first approach treats freshness expectations as testable assertions, not assumptions.

## The Organizational Dimension

There is a technical architecture argument here, but there is also an organizational one that matters more for engineering leaders.

Data quality problems are expensive not primarily because of engineering time to fix them -- although that cost is real -- but because they erode trust. When the VP of Sales cannot trust the pipeline number, they build a shadow spreadsheet. When finance gets burned by a bad dashboard, they request manual data pulls. Every trust failure creates a bypass, and those bypasses represent permanent organizational drag.

An observability-first approach changes the conversation from reactive ("the numbers were wrong, please investigate") to proactive ("we detected drift in this source table at 3am, here is the impact radius, and here is the remediation"). That shift in posture is what rebuilds trust between data teams and their stakeholders.

## What I Would Prioritize Tomorrow

If I were advising an engineering leader dealing with recurring data quality incidents, I would suggest three starting points:

1. **Instrument your most critical datasets first.** You do not need full coverage on day one. Identify the ten tables that drive executive dashboards and revenue reporting, and start profiling them continuously.

2. **Connect lineage to alerting.** An alert without context is just noise. When you detect an anomaly, the alert should tell the recipient which upstream source changed and which downstream consumers are affected.

3. **Measure time-to-detection, not just uptime.** Your SLA should not be "pipelines ran successfully." It should be "we detected and communicated data quality issues within N minutes of occurrence." That is the metric that actually correlates with stakeholder trust.

## Moving Forward

The industry is moving toward treating data systems with the same observability rigor we apply to application systems. The tooling has matured enough that you do not need to build from scratch.

At Arcline Analytics, this is the problem space we work in every day -- helping engineering teams catch data drift before it reaches production dashboards. If these failure modes sound familiar, I would welcome a conversation about what we are seeing across the industry and where the practice is heading.

You can find me on LinkedIn or reach our team at [arclineanalytics.com](https://arclineanalytics.com).

---

*Danielle Kwon is Head of Engineering at Arcline Analytics, where she leads the team building data observability solutions for mid-market SaaS companies. She has spent fifteen years in data infrastructure roles and writes regularly about data quality, pipeline reliability, and the evolving relationship between data teams and business stakeholders.*
