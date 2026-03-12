TASK:          Persona / ICP -- Real-Time Streaming Data Product ICP + Anti-ICP for Meridian Data Systems
ICP MATCH:     N/A (ICP definition task -- building the profile, not matching against one)
CONFIGURATION: Not configured (sales-marketing.local.md not found -- outputs use general best practices)
VERIFY DATA:   All prospect data should be verified before outreach

---

# IDEAL CUSTOMER PROFILE -- Meridian Data Systems (Real-Time Streaming Product)

**Important:** This ICP is for the **new real-time streaming data product only** -- it is explicitly differentiated from the existing batch ETL ICP. The two ICPs should be operated as separate pipeline tracks with distinct routing, scoring, and comp plans.

---

## FIRMOGRAPHIC CRITERIA

| Criterion | Streaming Product ICP | Existing Batch ETL ICP (reference) | Why They Differ |
|-----------|----------------------|-----------------------------------|----------------|
| Company size | 200-2,000 employees | 5,000+ employees | Streaming buyers are cloud-native companies that move fast at smaller scale; traditional batch ETL buyers are large enterprises with legacy data warehouses |
| Revenue range | $20M-$500M ARR (or equivalent) | $500M+ | Streaming-first companies are typically growth-stage or established mid-market; they spend on infrastructure differently than F500 |
| Stage | Series B+ growth through established mid-market | Established enterprise | Streaming adoption requires infrastructure budget that pre-Series B companies typically don't have, but it doesn't require the multi-year procurement cycles of enterprise |
| Geography | Primary: US, UK, EU (English-speaking engineering orgs with cloud infrastructure). Secondary: India, Singapore, Brazil (emerging cloud-native hubs) | Global enterprise | Cloud-native streaming companies are concentrated in tech hubs; geographical targeting is more focused |
| Industry verticals | See evaluation below | Manufacturing, financial services, healthcare (traditional data-heavy industries) | Streaming buyers are in industries where real-time data creates immediate business value, not where batch processing is the established norm |

### INDUSTRY VERTICAL EVALUATION

**Tier 1 -- Highest fit for streaming product:**

**Fintech / Financial Services (Real-Time):** Strong fit. Real-time data is a regulatory and competitive requirement: fraud detection, transaction monitoring, real-time risk scoring, market data feeds. These companies have engineering teams that already think in events and streams. Budget exists because real-time is a product requirement, not an infrastructure luxury. Conversion path: pain-led (latency costs money).

**Cloud-Native SaaS (Product Analytics / Observability):** Strong fit. Companies that build products on streaming data (real-time analytics dashboards, observability platforms, product telemetry) need streaming infrastructure as a core capability. They're already using Kafka, Flink, or similar and hitting scaling pain points. Conversion path: capability-led (they need what you build).

**Digital-First Retail / E-Commerce:** Moderate-to-strong fit. Real-time inventory, personalization, pricing, and supply chain visibility create direct revenue impact. The streaming use case is clear (real-time customer events, inventory feeds, pricing updates), but not every retailer has the engineering maturity to operate streaming infrastructure. Qualifying signal: dedicated data engineering team, not just a data analyst team.

**Tier 2 -- Evaluate case by case:**

**IoT / Connected Devices / Logistics:** Moderate fit. Sensor data, fleet tracking, and supply chain telemetry generate streaming data volumes, but many IoT companies use specialized platforms (AWS IoT, Azure IoT Hub) rather than general-purpose streaming infrastructure. Qualifying signal: company is outgrowing a managed IoT platform and needs custom streaming pipelines.

**Gaming / Media Streaming:** Moderate fit. Real-time player analytics, content delivery optimization, and live event processing create streaming use cases, but the market is niche and sales cycles can be long due to build-vs-buy culture in gaming engineering.

---

## TECHNOLOGY MATURITY PROFILE

The streaming product buyer is a **cloud-native mid-tech-to-high-tech** organization:
- Running on AWS, GCP, or Azure (not on-prem data centers)
- Already using or evaluating: Apache Kafka, Apache Flink, Spark Streaming, Confluent, Amazon Kinesis, or Google Pub/Sub
- Has a dedicated data engineering or platform engineering team (not data analysts operating SQL warehouses)
- Current pain: scaling existing streaming infrastructure, managing operational complexity of open-source streaming tools, or migrating from batch to streaming for specific use cases
- NOT suitable: companies whose entire data architecture is batch ETL on a traditional data warehouse with no streaming use cases in production or in planning

---

## POSITIVE FIT SIGNALS (look for these)

| Signal | Where to Find It | What It Means |
|--------|------------------|---------------|
| Job postings mentioning Kafka, Flink, Spark Streaming, Confluent, or Kinesis | LinkedIn job postings, company careers page | They're building or scaling streaming infrastructure -- active investment signal |
| "Streaming" or "real-time" in engineering blog posts | Company engineering blog, Medium, Dev.to | Engineering team is publicly working on streaming problems -- likely open to tooling that helps |
| Dedicated "Platform Engineering" or "Data Infrastructure" team | LinkedIn company page, job postings | Organizational investment in infrastructure (vs. outsourcing to a managed service or doing it ad hoc) |
| Conference attendance or talks at Kafka Summit, Flink Forward, Current (Confluent event) | LinkedIn, event speaker lists | Active participation in the streaming ecosystem -- high awareness, likely in evaluation mode |
| GitHub repos with streaming-related projects | GitHub, GitLab | Engineering team has hands-on streaming experience -- they understand the problem space and can evaluate your product technically |
| Recent migration from batch to streaming mentioned in any public content | Blog posts, LinkedIn posts, press releases | Active transition = active buying window |

---

## NEGATIVE FIT SIGNALS (avoid these companies -- ANTI-ICP)

**Critical: These signals identify companies that look like streaming prospects but are actually batch ETL customers. This is where your senior AEs are burning cycles.**

| Anti-ICP Signal | Where to Check It (BDR 5-minute check) | What It Means | Routing Action |
|----------------|----------------------------------------|---------------|---------------|
| All data engineering job postings mention SQL, dbt, Snowflake, BigQuery, Redshift -- zero mentions of Kafka, Flink, or streaming tools | LinkedIn job postings (check last 5 postings -- takes 3 minutes) | This is a batch-first data team with no streaming infrastructure or plans. They may be a great batch ETL customer, but the streaming product has no entry point. | **Route to batch ETL team.** Do NOT assign to streaming AE. |
| Company describes their data architecture as "modern data stack" centered on ELT + cloud warehouse | Engineering blog, job postings, company about page | "Modern data stack" in the current market typically means batch ELT (Fivetran/Airbyte -> Snowflake/BigQuery -> dbt). This is Meridian's batch ETL sweet spot, not streaming. | **Route to batch ETL team.** Flag for streaming re-evaluation if they post streaming roles in the future. |
| No engineering blog, no streaming conference attendance, no streaming-related job titles | LinkedIn, company website, event speaker lists | No public evidence of streaming investment or interest. Outbound to these accounts is cold on a problem they may not have. | **Add to nurture.** Do not invest AE time. Monitor for signals quarterly. |
| Company has <5 engineers total | LinkedIn company page headcount filter | Too small to operate streaming infrastructure. They need a managed service or a batch pipeline, not a streaming platform. | **Disqualify.** Not a fit for streaming or batch ETL at this scale. |
| Data team is entirely analysts (no engineers) | LinkedIn -- check data team titles: "Data Analyst" vs. "Data Engineer" vs. "Platform Engineer" | Analyst-led data teams operate SQL on warehouses. They don't build or operate streaming pipelines. The streaming product requires an engineering buyer. | **Route to batch ETL team** or disqualify if no engineering function exists. |
| Company is a large enterprise (5,000+ employees) with a massive existing batch ETL installation | CRM records, LinkedIn company size | This is your existing batch ETL ICP. They may eventually need streaming, but the sales motion is fundamentally different (enterprise expansion sell vs. new-product acquisition). | **Route to batch ETL farming team** for potential cross-sell conversation -- not to streaming hunting team. |

---

## TIMING SIGNALS -- HOT (act within 48 hours)

| Trigger Event | Where to Find It | Why It's HOT |
|--------------|------------------|--------------|
| Job posting for "Streaming Engineer," "Kafka Engineer," "Flink Developer," or "Real-Time Data Engineer" | LinkedIn job postings, company careers page | They're actively hiring for the capability your product provides -- budget is allocated, timeline is now |
| Public announcement of migration from batch to streaming | Press release, engineering blog, LinkedIn posts | Active architectural transition = buying window is open. They're making decisions about tooling right now. |
| Kafka/Flink/streaming mentioned in recent engineering blog post as a scaling challenge | Company engineering blog, Medium | Engineering team is publicly stating they're hitting the pain you solve. This is a warm introduction disguised as a content signal. |
| Series B+ funding announcement (last 30 days) at a cloud-native company matching firmographic criteria | Crunchbase, TechCrunch, press releases | Fresh capital + cloud-native profile = infrastructure investment budget available. Streaming infrastructure is a common post-funding investment. |
| New VP/Director of Data Engineering or Platform Engineering (<6 months in role) | LinkedIn profile | New leader = new priorities = new budget. New data leaders often invest in streaming as a "modern infrastructure" mandate. |

---

## TIMING SIGNALS -- WARM (act within 2 weeks)

| Signal | Where to Find It | Why It's WARM |
|--------|------------------|---------------|
| Attendance at Kafka Summit, Flink Forward, or Current conference | Event registration lists, LinkedIn posts about attending | Interest in the streaming ecosystem confirmed, but no confirmed buying intent yet |
| Content download on real-time analytics, streaming architecture, or event-driven design | Your content analytics, HubSpot/Salesforce activity | Research-stage interest -- they're learning, not yet buying |
| Early-stage "data modernization initiative" announced | Press release, LinkedIn, CIO/CTO interview | Modernization could include streaming, but scope is broad -- needs qualification to determine if streaming is in scope |
| General engineering team growth (10+ hires in data/platform in last 90 days) | LinkedIn headcount trends | Growing team suggests growing data needs, but direction (batch vs. streaming) is unconfirmed |
| Industry event where real-time data was a keynote theme | Event recap blogs, speaker announcements | Awareness-level signal -- industry is moving toward streaming, but no company-specific intent |

---

## BDR ROUTING FRAMEWORK

When an inbound lead arrives or a BDR is researching an outbound target, apply this decision tree:

### Step 1: Check for streaming signals (3 minutes)

Search LinkedIn job postings for streaming-related tools (Kafka, Flink, Spark Streaming, Kinesis, Confluent). Check company engineering blog for streaming content.

- **Streaming signals found** -> Proceed to Step 2
- **No streaming signals, BUT batch ETL signals present (SQL, dbt, Snowflake)** -> **Route to batch ETL team.** Log in CRM: "Streaming not indicated; strong batch ETL fit."
- **No signals of any kind** -> **Add to nurture.** Do not invest rep time. Set 90-day re-evaluation.

### Step 2: Check firmographic fit (2 minutes)

- Company size: 200-2,000 employees? Revenue $20M-$500M? Cloud-native infrastructure?
- **Yes to all** -> Proceed to Step 3
- **5,000+ employees with existing batch ETL contract** -> **Route to batch ETL farming team** for cross-sell conversation
- **<200 employees or <$20M revenue** -> **Add to nurture.** Too early for streaming platform investment. Re-evaluate at next funding round.

### Step 3: Check timing signals (3 minutes)

- **HOT signal present** (streaming job posting, batch-to-streaming migration, funding in last 30 days) -> **Call this week.** Route to streaming AE. Priority queue.
- **WARM signal present** (conference attendance, content download, general growth) -> **Add to nurture.** Enroll in streaming-specific content sequence. Monitor for HOT signal upgrade.
- **No timing signal** -> **Add to nurture.** Firmographic fit confirmed but no urgency. Quarterly check.

**Total BDR qualification time: 5-8 minutes per lead.**

---

## BUYER PERSONA: The Streaming Infrastructure Buyer

**Role:** VP Data Engineering, Director of Platform Engineering, Head of Data Infrastructure
================================================================

**WHO THEY ARE**
Mid-career engineering leader (8-15 years experience) who has progressed through hands-on data engineering into people and platform management. They've built batch pipelines before and understand the architectural shift to streaming. They're measured on infrastructure reliability, team velocity, and cost efficiency. They think in systems, not features.

**WHAT THEY WANT**
Primary goal: Deliver reliable, scalable streaming infrastructure that their internal customers (product teams, analytics teams, ML teams) can depend on without their team becoming a permanent bottleneck.
Secondary goal: Reduce operational overhead of managing open-source streaming tools (Kafka cluster management, Flink job debugging, connector maintenance) so their team can focus on building, not babysitting infrastructure.

**WHAT THEY FEAR**
Primary fear: Adopting a vendor platform that creates lock-in and removes the control they have with open-source. They chose Kafka for a reason -- they want to keep that control.
Risk aversion: Downtime during migration. Any streaming infrastructure change that causes data loss or processing delays is a career-limiting event.

**HOW THEY BUY**
Discovery: Engineering blogs, conference talks, GitHub repos, peer recommendations from other data engineering leaders. They do NOT discover tools through LinkedIn ads or marketing emails.
Evaluation: Proof of concept (PoC) with their own data. They will not sign a contract based on slides. They need to see latency, throughput, and connector compatibility on their actual workload.
Decision: Director signs off on budget; VP/CTO approves architecture decisions. Procurement involved for contracts >$50K.
Blocker: "We can build this ourselves with open-source." This is the most common objection and must be addressed with total-cost-of-ownership (TCO) analysis, not feature comparison.

**HOW TO COMMUNICATE WITH THEM**
Tone: Peer-level, technical. They can smell marketing language instantly.
Language: Kafka, Flink, connectors, exactly-once semantics, throughput, latency, partitions, consumer groups. Speak their language or lose credibility in the first sentence.
Avoid: "Platform," "dashboard," "insights," "AI-powered," "enterprise-grade." These words signal that you're marketing to executives, not engineers.
Lead with: TCO comparison (open-source self-managed vs. your platform), specific throughput/latency benchmarks, architecture diagrams, customer case studies from similar-scale companies.

**WHERE TO REACH THEM**
Primary: Engineering blog content, GitHub presence, conference talks, direct referral from a peer. LinkedIn DM only if you reference something technical they've posted.
Content: Hacker News, Engineering blogs (Netflix, Uber, LinkedIn engineering blogs), specific Kafka/Flink community forums, Data Engineering Weekly newsletter.
Timing: After they've hit a scaling pain point (usually visible through job postings or blog posts about infrastructure challenges). Cold outreach before the pain point is visible gets ignored.

================================================================
