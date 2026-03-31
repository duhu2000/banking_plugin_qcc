TASK:          Persona/ICP -- Streaming Data Product ICP & Anti-ICP for Meridian Data Systems
ICP MATCH:     N/A (ICP definition exercise)
CONFIGURATION: Not configured
VERIFY DATA:   All prospect data should be verified before outreach

---

# ICP & Anti-ICP: Real-Time Streaming Data Product

## Company Context
- **Vendor:** Meridian Data Systems -- $120M ARR, 400+ enterprise customers, 15 years in market
- **Existing product:** Enterprise batch ETL
- **Existing ICP:** Large enterprises (5,000+ employees), big data engineering teams
- **New product:** Real-time streaming data platform
- **Core problem to solve:** Sales team chases every inbound lead the same way. Senior AEs are burning cycles on accounts that are great batch ETL prospects but will never close for streaming.

---

## STREAMING PRODUCT ICP -- FIRMOGRAPHIC CRITERIA

### Company Size
- **Target range:** 200-2,000 employees
- **Reasoning:** Cloud-native and digital-first companies in this range are large enough to have real streaming use cases in production but small enough that they haven't built proprietary streaming infrastructure. Below 200, they likely don't have the data volume or team to justify a streaming platform. Above 2,000, they start overlapping with Meridian's existing enterprise batch ETL ICP and may already have built in-house streaming solutions.

### Revenue
- **Target range:** $20M-$500M ARR (or equivalent revenue)
- **Reasoning:** This range captures companies with enough revenue to invest in data infrastructure but not so large that they default to building rather than buying. Series B through Series D companies with strong growth trajectories are ideal.

### Industry Verticals (Candidate Segments with Reasoning)

| Vertical | Fit Rating | Reasoning |
|----------|-----------|-----------|
| **Cloud-native SaaS** | STRONG | These companies are built on event-driven architectures, produce high-velocity data streams from product usage, and need real-time analytics for product decisions. They are the most natural buyers for streaming data platforms because their entire infrastructure is already stream-oriented. |
| **Digital-first retail / e-commerce** | STRONG | Real-time inventory, pricing, recommendation engines, and customer behavior streams are core to their competitive advantage. They have urgent streaming use cases (real-time personalization, inventory sync across channels) with measurable revenue impact. |
| **Fintech** | STRONG | Fraud detection, real-time transaction monitoring, compliance event streams, and instant payment processing all require streaming infrastructure. Regulatory requirements create hard deadlines for data freshness that batch processing cannot meet. |
| **Logistics / supply chain tech** | MODERATE | IoT sensor data, real-time fleet tracking, and supply chain event streams create streaming demand, but adoption maturity varies widely. Better as a secondary vertical. |
| **Gaming / entertainment platforms** | MODERATE | Real-time player behavior, matchmaking, and in-game event streams are natural fits but the buying motion differs significantly from enterprise data infrastructure sales. |

**Primary verticals:** Cloud-native SaaS, digital-first retail, fintech
**Secondary verticals:** Logistics/supply chain tech, gaming/entertainment

### Geography
- **Primary:** North America, Western Europe (English-speaking markets where Meridian has existing sales infrastructure)
- **Note:** LATAM and APAC may be secondary markets for cloud-native companies; follow the ICP fit rather than restricting by geography.

### Technology Maturity
- **Minimum:** Company has at least one production application generating event streams or uses a message broker (Kafka, RabbitMQ, Pulsar, Kinesis, etc.) in their stack
- **Ideal:** Company is actively running or evaluating Apache Kafka, Apache Flink, Apache Spark Streaming, Amazon Kinesis, or similar streaming technologies
- **Differentiator from batch ETL ICP:** The batch ETL ICP runs scheduled jobs (Airflow, dbt, Informatica) with hours-to-days latency tolerance. The streaming ICP needs sub-minute latency on at least one critical data pipeline.

---

## STREAMING PRODUCT ICP vs. EXISTING BATCH ETL ICP -- Key Differences

| Dimension | Batch ETL ICP (Existing) | Streaming ICP (New Product) |
|-----------|-------------------------|---------------------------|
| Company size | 5,000+ employees | 200-2,000 employees |
| Data team structure | Large, specialized data engineering org (10+ data engineers) | Lean data/platform engineering team (3-10 engineers) |
| Architecture | Warehouse-centric, scheduled batch jobs | Event-driven, real-time pipelines |
| Latency tolerance | Hours to days | Sub-minute to minutes |
| Tech stack signals | Airflow, dbt, Informatica, Talend, traditional ETL tools | Kafka, Flink, Kinesis, Spark Streaming, event-driven microservices |
| Buying motion | Long enterprise cycle (6-12 months), procurement-driven | Faster evaluation (2-4 months), engineering-led with business sponsor |
| Budget source | IT/data engineering budget | Platform engineering or product engineering budget |

---

## NEGATIVE FIT SIGNALS / ANTI-ICP

**Purpose:** Prevent senior AEs from burning cycles on accounts that look like pipeline but will never close for the streaming product. These signals can be checked by a BDR in under 5 minutes.

### Hard Disqualifiers (Route to Batch ETL Team Instead)

| Signal | Where to Check | What It Means | Action |
|--------|---------------|---------------|--------|
| Company runs only scheduled batch jobs (Airflow, dbt cron jobs) with no streaming infrastructure | Job postings on LinkedIn/careers page; tech blog; StackShare | They need batch ETL, not streaming. Great prospect for Meridian's existing product, wrong product. | **Route to batch ETL sales team** |
| "Data warehouse modernization" or "cloud migration" language with no mention of real-time | Website, press releases, job postings | They're modernizing batch infrastructure. Streaming is not on their roadmap. | **Route to batch ETL sales team** |
| 5,000+ employees with an established data platform team that builds in-house | LinkedIn headcount, Glassdoor | Large enterprises with big data teams typically build streaming infrastructure internally. Low likelihood of buying a streaming platform. | **Route to batch ETL sales team** (existing ICP) |
| No engineering job postings mentioning streaming, events, Kafka, or real-time | LinkedIn jobs page | If they're not hiring for it, they're not investing in it. | **Deprioritize -- add to nurture** |

### Soft Disqualifiers (Deprioritize, Don't Route)

| Signal | Where to Check | What It Means | Action |
|--------|---------------|---------------|--------|
| Company is pre-revenue or pre-product | Crunchbase, website | Too early for data infrastructure investment. Will evaluate when they have data volume. | **Add to nurture -- revisit in 6-12 months** |
| Fewer than 3 engineers on the team | LinkedIn, careers page | Cannot implement and maintain a streaming platform. | **Add to nurture** |
| Primary tech stack is no-code/low-code (Zapier, Make, Retool only) | Job postings, tech blog | Architecture is not compatible with streaming data platform. | **Do not pursue** |
| Company in heavily regulated industry with data residency requirements Meridian cannot meet | Website, compliance page | Deal will stall on compliance even if product fit is strong. | **Flag for legal review before pursuing** |

---

## TIMING SIGNALS -- HOT (Outreach Within 48 Hours)

These signals indicate the buying window is open NOW. BDRs should act immediately.

| Signal | Where to Find It | Why It's Hot |
|--------|-----------------|-------------|
| **Job posting for "Streaming Engineer," "Platform Engineer (Kafka/Flink)," or "Real-Time Data Engineer"** | LinkedIn Jobs, company careers page | They are actively building or expanding streaming infrastructure. Hiring = budget allocated. |
| **Press release or blog post announcing migration from batch to streaming architecture** | Company blog, PR newswires, tech publications | Public commitment to streaming means evaluation is underway or imminent. |
| **Recent funding round (Series B-D) at a cloud-native company in a target vertical** | Crunchbase, TechCrunch, LinkedIn | Fresh capital + growth mandate = infrastructure investment cycle. Streaming platforms are a common post-funding purchase. |
| **Kafka/Flink/streaming tech mentioned in recent conference talk or engineering blog by a company leader** | YouTube (conference recordings), Medium/dev.to, company engineering blog | Engineering leadership is publicly invested in streaming. Internal buy-in already exists. |
| **Prospect posts on LinkedIn about real-time data challenges or streaming evaluation** | LinkedIn activity monitoring | Direct buying signal from the individual -- they are actively thinking about and evaluating streaming solutions. |
| **Competitor's streaming product mentioned in prospect's job postings or tech radar** | Job postings, ThoughtWorks Tech Radar contributions | They're already evaluating or using a competitor's streaming product -- Meridian can enter the evaluation. |

---

## TIMING SIGNALS -- WARM (Outreach Within 2 Weeks)

These signals indicate interest is building but the buying window is not yet open. BDRs should initiate contact and begin nurturing.

| Signal | Where to Find It | Why It's Warm (Not Hot) |
|--------|-----------------|----------------------|
| **Attendance at streaming-focused conferences** (Kafka Summit, Flink Forward, Current) | Conference attendee lists, LinkedIn posts about attending | Shows interest in streaming technology but doesn't confirm active evaluation. May be educational/exploratory. |
| **Content downloads on real-time analytics, event-driven architecture, or streaming topics** | Your own content engagement tracking, website visitor identification | Prospect is researching the space. Not yet in active evaluation but building internal case. |
| **Early-stage data modernization initiative announced** (without specific streaming mention) | Company blog, press releases, job postings for "Data Platform" or "Data Infrastructure" roles | Modernization projects often evolve to include streaming. Worth monitoring and engaging early. |
| **CTO/VP Engineering new hire at a target-segment company** | LinkedIn, press announcements | New technical leadership often reevaluates infrastructure. Streaming may be on their 90-day agenda. |
| **Company doubled engineering headcount in last 12 months** | LinkedIn headcount trends | Rapid engineering growth creates data infrastructure pressure. Streaming need often follows scale. |

---

## POSITIVE FIT SIGNALS (Researchable Indicators)

These signals confirm the account is a genuine streaming fit, not just a batch ETL customer who happens to mention data. Reps should verify at least 2 of these before the first call.

| Signal | Where to Find It | What It Confirms |
|--------|-----------------|-----------------|
| **Existing streaming infrastructure in production** (Kafka, Kinesis, Flink, Pulsar) | Job postings, engineering blog, StackShare, GitHub repos | Company already operates streaming pipelines -- they understand the space and have real use cases |
| **Real-time use cases in their product** (live dashboards, instant notifications, real-time pricing) | Product website, demo videos, customer-facing documentation | Their product depends on real-time data, making streaming a revenue-critical investment, not a nice-to-have |
| **Event-driven architecture patterns** (microservices, event sourcing, CQRS) | Engineering blog, conference talks, job postings mentioning event-driven patterns | Architecture is already stream-compatible -- integration friction will be low |
| **Data team that reports to engineering** (not IT or BI) | LinkedIn org chart, job posting reporting lines | Engineering-led data teams make faster purchasing decisions and are more likely to evaluate streaming products |
| **Budget line item for "platform engineering" or "data infrastructure"** (not "BI" or "analytics") | Job postings, leadership interviews | Budget is allocated to infrastructure, not just reporting -- streaming fits this budget category |

---

## BDR ROUTING FRAMEWORK

### Decision Tree: What to Do with Every Inbound Lead

```
STEP 1: Does the lead mention streaming, real-time, Kafka, Flink, or event-driven?
  |
  YES --> Go to Step 2
  |
  NO --> Does the lead mention batch ETL, data warehouse, scheduled pipelines, dbt, Airflow?
          |
          YES --> ROUTE TO BATCH ETL TEAM (existing ICP, great prospect, wrong product)
          |
          NO --> Go to Step 2 (could be either -- need more info)

STEP 2: Check company firmographics (< 5 minutes)
  - Employee count (LinkedIn company page)
  - Industry vertical
  - Tech stack signals (1-2 recent job postings)
  |
  200-2,000 employees + target vertical + streaming tech signals?
    |
    YES --> STREAMING FIT. Check timing signals.
    |
    NO (5,000+ employees, batch-only tech stack)?
    |    --> ROUTE TO BATCH ETL TEAM
    |
    NO (< 200 employees, no streaming signals)?
         --> ADD TO NURTURE. Revisit in 6 months.

STEP 3: Check timing signals
  |
  HOT signal present (job posting, migration announcement, funding, LinkedIn activity)?
    |
    YES --> CALL THIS WEEK. Assign to streaming AE. Priority outreach within 48 hours.
    |
    NO, but WARM signal present (conference, content download, new hire)?
    |
    YES --> ADD TO 2-WEEK OUTREACH QUEUE. BDR sends initial touch within 2 weeks.
    |
    NO timing signals?
         --> ADD TO NURTURE. Monitor for timing signals quarterly.
```

### Summary Table

| Routing Decision | Criteria | Action | Owner |
|-----------------|----------|--------|-------|
| **Call this week** | Streaming ICP fit + HOT timing signal | Priority outreach within 48 hours | Streaming AE |
| **Outreach within 2 weeks** | Streaming ICP fit + WARM timing signal | BDR initial touch, qualify, route to AE if confirmed | BDR |
| **Add to nurture** | Streaming ICP fit but no timing signals, or too early stage | Automated nurture cadence, quarterly review | Marketing |
| **Route to batch ETL team** | Batch-only tech stack, 5,000+ employees, no streaming signals | Hand off to existing enterprise sales team immediately | BDR routes to batch ETL AE |
| **Do not pursue** | Anti-ICP signals (pre-revenue, no-code stack, <3 engineers) | No outreach, no nurture | N/A |

---

ALL OUTREACH OUTPUTS REQUIRE HUMAN REVIEW BEFORE SENDING.
