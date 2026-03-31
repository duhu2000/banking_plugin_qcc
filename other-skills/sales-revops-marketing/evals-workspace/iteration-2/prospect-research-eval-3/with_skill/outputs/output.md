TASK:          Prospect Research -- Raj Patel / Komodo Health
ICP MATCH:     STRONG
CONFIGURATION: Not configured (no sales-marketing.local.md found -- outputs use general best practices)
VERIFY DATA:   All prospect data should be verified before outreach

---

# PROSPECT RESEARCH BRIEF

**Prospect:** Raj Patel, Director of Platform Engineering | Komodo Health | San Francisco, CA (estimated -- HQ location)
**Prepared:** 2026-03-12 | **Confidence:** HIGH (based on user-provided signals; web verification recommended for company financials)
**ICP Match:** STRONG

---

## -- WHO IS RAJ PATEL? --

**Career:**
Director of Platform Engineering at Komodo Health. Title suggests he owns the infrastructure and developer tooling layer for the engineering organization -- this includes observability, CI/CD, service mesh, and internal platform products that engineering teams consume. At a company running hundreds of microservices, this role is directly responsible for infrastructure cost management and tooling decisions.

Time in role: Not independently verified. However, the volume and specificity of his LinkedIn posting on observability challenges suggests he is actively grappling with a current, high-priority initiative -- consistent with either a relatively new leader establishing his platform strategy or an established leader hitting a scaling inflection point.

**Role Scope:**
- Owns platform engineering function -- infrastructure tooling, observability stack, developer experience
- Directly responsible for observability vendor selection and budget
- Team size: estimated 10-30 engineers at a company of 500-800 headcount with an engineering-heavy profile (healthcare data analytics)
- Decision-maker or primary influencer on observability tooling -- this is his domain

**Activity (LinkedIn -- last 30 days):**
Based on user-provided intelligence:
- 4-5 posts over the last 3 weeks -- this is a high posting cadence, indicating someone who is actively processing a problem in public
- **Themes identified across posts:**
  - Observability challenges at scale (volume of telemetry data from hundreds of microservices)
  - Cost of running Datadog across a large microservices fleet (pricing pain at scale)
  - Team actively evaluating alternatives to current observability stack
  - Open-source-first philosophy as a guiding principle for tooling decisions
- **Key post (~10 days ago, 200+ reactions):** Specifically mentioned wanting "open-source-first observability that doesn't bankrupt the engineering budget" -- this post had significant engagement (200+ reactions), indicating resonance with his network and likely attracting vendor attention
- Posting cadence and engagement levels suggest Raj is a respected voice in his professional network on infrastructure topics

**Signal Interpretation:**
- **Active LinkedIn poster on your exact problem area:** This is a **HOT** signal per classification criteria -- prospect posted about your problem area within the last 14 days
- The 200+ reaction post is particularly significant: it signals that Raj is publicly committed to this position (open-source-first, cost-conscious), which means he will be receptive to approaches that validate this worldview
- 4-5 posts in 3 weeks is not casual commentary -- this is someone actively building a case for change, likely socializing the decision internally as well as externally
- The fact that he is posting about evaluation suggests the buying process is **in progress now** -- this is not future intent, this is current activity

---

## -- WHAT IS KOMODO HEALTH? --

**Model:**
Komodo Health is a healthcare data analytics company that builds a comprehensive view of the patient journey using real-world clinical data. Their platform (the Healthcare Map) aggregates and analyzes clinical encounters, insurance claims, and other healthcare data points to help life sciences companies, payers, and providers make data-driven decisions. Revenue model is SaaS/platform licensing to enterprise healthcare and life sciences clients.

**Revenue:** Late-stage venture-backed (Series D or E per user intel). Estimated annual revenue in the $100M-$250M range based on stage and headcount (estimate -- unverified). Crunchbase and press should be checked for exact funding total.

**Headcount:** 500-800 (per user intel). This is consistent with a late-stage healthcare data company. Engineering-heavy organization given the data analytics core of the business.

**Tech Stack Signals:**
- Running hundreds of microservices (per Raj's LinkedIn posts) -- indicates a cloud-native, distributed architecture
- Currently using Datadog for observability (per Raj's LinkedIn posts) -- this is the incumbent vendor being evaluated for replacement
- Microservices at this scale typically implies: Kubernetes or equivalent orchestration, cloud infrastructure (AWS/GCP/Azure), likely a service mesh, CI/CD pipelines generating significant telemetry
- Healthcare data analytics suggests: significant data pipeline infrastructure, compliance requirements (HIPAA), high availability requirements

**Position:**
Market leader / strong challenger in healthcare data analytics. Komodo Health's "Healthcare Map" is well-known in the life sciences data space. Competes with companies like Flatiron Health, Aetion, and Veeva Systems in different segments. Well-funded, growing, and operating in a regulated industry that generates massive data volumes.

**Geographic Footprint:**
Headquartered in San Francisco, CA. Likely distributed/hybrid workforce given company size and industry norms post-2020.

---

## -- WHAT IS HAPPENING NOW? --

**HOT:**
- **Raj Patel actively posting about observability pain and evaluating alternatives** -- LinkedIn, last 3 weeks. This is the primary signal. He is describing your exact product category as his desired solution.
- **"Open-source-first observability" post with 200+ reactions** -- LinkedIn, ~10 days ago. Public declaration of buying criteria that maps directly to your product positioning.
- **Active evaluation in progress** -- Raj has stated his team is evaluating alternatives. This means a shortlist is forming or already formed. Window to enter the evaluation is narrowing.

**WARM:**
- **Hundreds of microservices at scale** -- signals significant and growing infrastructure complexity, which creates compounding observability cost pressure under per-host/per-container pricing models (Datadog's model)
- **Late-stage funding (Series D/E)** -- company has capital but is likely under board pressure for efficient growth and cost optimization, which aligns with the move away from expensive vendor tooling
- Check for: open job postings in platform engineering or observability roles at Komodo Health -- if they are hiring for observability-specific engineers, this corroborates that the initiative is organizationally funded, not just one person's frustration
- Check for: recent engineering blog posts from Komodo Health about their architecture -- this would provide additional technical context

**WATCH:**
- Healthcare data analytics sector is growing but under scrutiny for data handling practices -- any regulatory news affecting Komodo Health could shift priorities
- General trend of enterprises moving from proprietary to open-source observability stacks (Datadog-to-OSS migration is a known industry pattern in 2025-2026)

---

## -- THE SPECIFIC PAIN --

Komodo Health runs hundreds of microservices generating massive telemetry data volumes (logs, metrics, traces). At this scale, Datadog's per-host and per-container pricing model creates non-linear cost growth -- every new service, every new pod, every scaling event increases the observability bill disproportionately to the value delivered. Raj's platform engineering team is caught between two pressures: engineering teams need comprehensive observability to operate reliable systems in a healthcare context (where downtime has patient-data implications), but the budget to provide that observability is scaling faster than the infrastructure it monitors. The solution he has publicly articulated -- open-source-first observability -- addresses both the cost problem (no per-host licensing) and the control problem (the team owns the stack, can customize telemetry pipelines, and avoids vendor lock-in on their most critical operational data).

---

## -- THE HOOK --

Raj has been publicly writing about the tension between comprehensive observability and unsustainable tooling costs at scale -- his recent post about wanting open-source-first observability that doesn't break the engineering budget resonated widely (200+ reactions), which tells you this is a conviction, not a passing thought. Reference the theme of his public commentary on observability economics at microservices scale -- show that you have been following his thinking on this, not that you found him in a lead list.

---

## -- PRODUCT FIT --

**Fit:** STRONG

**Positioning:** "Open-source observability platform (logs, metrics, traces) that gives platform engineering teams full-stack visibility across hundreds of microservices without per-host pricing -- you own the stack, control the data pipeline, and scale observability costs linearly with infrastructure, not exponentially."

Rationale for STRONG fit:
- Product category is an exact match to what Raj has publicly stated he wants (open-source-first observability)
- Product capabilities (logs, metrics, traces) cover the three pillars of observability he needs
- Open-source model directly addresses the cost objection that is driving the evaluation
- Healthcare data company running microservices at scale is a high-value use case for an observability platform
- Director of Platform Engineering is the ideal buyer persona -- this is his direct responsibility

---

## -- RECOMMENDED FIRST TOUCH --

**Channel:** LinkedIn

Reasoning: Raj is highly active on LinkedIn (4-5 posts in 3 weeks with high engagement). This is where he is publicly processing his observability decision. A LinkedIn message will feel natural and contextual. Email risks feeling cold and disconnected from where the conversation is actually happening.

**Tone:** Peer-level / practitioner

Reasoning: Raj is a Director of Platform Engineering posting technical content. He will respond to someone who demonstrates genuine understanding of the observability-at-scale problem, not a sales pitch. The approach should feel like one practitioner reaching out to another about a shared problem area.

**Timing:** Within 24-48 hours -- URGENT

Reasoning: Raj has stated his team is actively evaluating alternatives. Evaluations at this stage typically produce a shortlist within 2-4 weeks. His posting cadence (4-5 posts in 3 weeks) suggests the evaluation has been underway for at least that long. The window to be included in the evaluation is closing. Every day of delay increases the risk of being excluded from the shortlist entirely.

**Goal:** Enter the active evaluation

Reasoning: This is not a cold outreach situation -- this is a prospect who has already self-identified as being in-market for your exact product category. The goal is not to educate or nurture. The goal is to get your platform into the evaluation that is already happening. Aim for a technical conversation (not a discovery call) where Raj can evaluate whether your platform meets his requirements.

See /outreach for personalised message draft.

---

ALL OUTREACH OUTPUTS REQUIRE HUMAN REVIEW BEFORE SENDING.
