# Ideal Customer Profile (ICP) & Anti-ICP
## AI-Powered Contract Review Tool — B2B SaaS

**Version:** 1.0
**Date:** 2026-03-11
**Basis:** Pattern analysis from first 30 closed deals
**Status:** Initial formalization — revisit after 75 deals

---

## Part 1: Ideal Customer Profile (ICP)

### 1.1 Firmographic Filters (Hard Criteria)

| Dimension | Tier 1 (Best Fit) | Tier 2 (Good Fit) |
|---|---|---|
| **Company Size** | 500–1,200 employees | 300–1,500 employees |
| **Revenue** | $100M–$350M | $50M–$500M |
| **Industry Vertical** | Fintech, Healthtech, B2B SaaS | Insurtech, Regtech, Medtech, Legaltech-adjacent |
| **Contract Volume** | 300+ contracts/month | 200–300 contracts/month |
| **Legal Team Size** | 4–6 people | 3–8 people |
| **Geography** | US, UK, Canada (English-language contracts) | EU (English-language contract subset) |

### 1.2 Situational Triggers (Timing Criteria)

These are the "why now" signals that compress sales cycles. Rank-ordered by observed close velocity:

1. **Post-Series B/C (within 6 months of close)** — Rapid vendor onboarding, new partnership agreements, employment contracts scaling. Legal team headcount hasn't caught up to business velocity. Pain is acute and budget is available.

2. **Post-M&A (within 12 months of deal close)** — Contract consolidation, duplicate vendor rationalization, inherited contract portfolios with unknown terms and renewal dates. Often driven by CFO mandate to reduce risk exposure.

3. **Regulatory compliance deadline approaching** — New data privacy, financial services, or healthcare regulations requiring contract clause audits across the entire portfolio (e.g., AI Act compliance, DORA, state privacy laws).

4. **Legal team attrition without backfill** — Team went from 6 to 4 people, volume didn't drop. Burnout signal. Champion is personally motivated.

5. **New GC or VP Legal Ops hired** — First 90 days, mandate to modernize. Looking for quick wins to demonstrate impact. Most receptive to new tooling.

### 1.3 Technographic Signals

| Signal | Interpretation |
|---|---|
| No CLM platform in place (or using SharePoint/Google Drive for contracts) | Low switching cost, high pain, fast adoption |
| Using a basic e-signature tool (DocuSign, HelloSign) but nothing upstream | Ready for the next layer of contract infrastructure |
| Slack/Teams-heavy culture | Likely to adopt modern SaaS tooling, collaboration-friendly |
| Already using AI tools elsewhere (Copilot, Jasper, etc.) | AI-receptive culture, lower internal education burden |

**Red flag technographics** (see Anti-ICP): Existing CLM with dedicated admin, custom-built contract workflows, enterprise legal tech stack (Kira, Luminance, Ironclad at scale).

### 1.4 Buying Committee

| Role | Function in Deal | What They Care About |
|---|---|---|
| **Champion: Senior Legal Counsel / VP Legal Ops** | Drives evaluation, builds internal case, owns day-to-day pain | Time saved per contract, accuracy, fewer revision cycles, reduced personal workload |
| **Economic Buyer: General Counsel** | Final sign-off on legal tool purchases | Risk reduction, team retention, coverage without headcount, board-reportable metrics |
| **Economic Buyer (alternate): CFO** | Signs off when positioned as cost avoidance | Cost per contract reviewed, avoided outside counsel spend, audit risk reduction |
| **Influencer: Head of Procurement** | Adjacent stakeholder, co-benefits | Vendor onboarding speed, contract turnaround SLA improvement |
| **Blocker: IT Security / InfoSec** | Security review gatekeeper | SOC 2 Type II, data residency, AI model data handling, SSO/SCIM |
| **Blocker: Existing CLM Admin** | Territorial if present | Integration compatibility, workflow disruption |

### 1.5 Quantified Pain Thresholds

The ICP company experiences these pain points at a level that justifies purchasing:

- **Contract review backlog:** 2+ week turnaround on standard vendor contracts (should be 2–3 days)
- **Outside counsel bleed:** $15K–$50K/month on overflow contract review that should be handled in-house
- **Missed obligations:** At least 1 renewal auto-renewed unfavorably in the past year, or 1 compliance clause missed
- **Hiring gap:** Open legal headcount for 3+ months with no viable candidates, or headcount request denied by finance
- **Manual process tax:** Legal team spending 60%+ of time on routine contract review vs. strategic legal work

### 1.6 ICP Scoring Model

Use this to score inbound leads and outbound target accounts. Max score: 100.

| Criterion | Points | How to Verify |
|---|---|---|
| **Firmographic fit (Tier 1)** | 20 | LinkedIn, Crunchbase, company website |
| **Firmographic fit (Tier 2)** | 12 | Same |
| **Contract volume 200+/month** | 15 | Discovery call question |
| **Legal team 3–8 people** | 10 | LinkedIn headcount search |
| **Active situational trigger** | 25 | Crunchbase (funding), press (M&A), LinkedIn (new GC hire) |
| **No existing CLM** | 10 | Technographic data (BuiltWith, 6sense, or discovery) |
| **Champion identified at Sr. Legal Counsel+ level** | 10 | LinkedIn, intro source |
| **Budget confirmed or implied (recent fundraise, stated initiative)** | 10 | Crunchbase, earnings calls, champion confirmation |

**Routing thresholds:**

| Score | Action |
|---|---|
| 70–100 | **Tier 1 — AE-ready.** Immediate outreach, personalized sequence, executive engagement. |
| 50–69 | **Tier 2 — BDR nurtured.** Targeted outreach with trigger-based messaging. Worth 3–5 touches. |
| 30–49 | **Tier 3 — Marketing nurture only.** Add to content programs, revisit if trigger fires. |
| 0–29 | **Disqualify.** Do not pursue. See Anti-ICP. |

---

## Part 2: Anti-ICP (Disqualification Profile)

### 2.1 Hard Disqualifiers — Stop Immediately

These characteristics mean the account should be removed from all active outbound sequences. No exceptions without VP Sales override.

| Anti-Pattern | Why It Fails | Observed Signal |
|---|---|---|
| **Fortune 500 / Enterprise (5,000+ employees)** with dedicated Legal Ops + CLM team | Evaluation cycles 9–18 months. Existing workflows are "good enough." Internal politics dominate. Even if they close, CAC destroys unit economics. | Ironclad/Agiloft/Icertis in tech stack, "Legal Operations Manager" on LinkedIn, RFP-driven procurement |
| **Pre-seed / Seed-stage startups (<50 employees)** | 0–1 lawyer, contract volume too low to justify spend, budget constrained, founder reviews contracts personally | Sub-$5M revenue, <30 employees, no legal title on LinkedIn |
| **Solo practitioner or fractional GC model** | No team to adopt the tool, no internal champion with daily pain, decision-maker is also the user and has workarounds | 1 legal person on LinkedIn, "fractional" or "advisor" title |
| **Companies with <100 contracts/month** | ROI math doesn't close. Time savings don't justify the subscription at current pricing. | Small vendor base, low-complexity business model |
| **Government / public sector** | Procurement cycles incompatible with startup sales motion. Compliance requirements (FedRAMP etc.) you likely don't have yet. | .gov domain, public sector vertical tags |

### 2.2 Soft Disqualifiers — Proceed With Caution

These don't automatically disqualify but should lower priority and increase scrutiny. Require at least two Tier 1 positive signals to offset.

| Anti-Pattern | Risk | Mitigation |
|---|---|---|
| **"Innovation theater" buyer** — wants to pilot AI for PR/board optics, not to solve a real workflow problem | Long pilot, no expansion, likely to churn at renewal | Qualify for specific pain metric in discovery. If they can't quantify the problem, walk. |
| **Heavy custom workflow requirements** | Implementation cost balloons, time-to-value extends, CSM burden increases | Scope customization in discovery. If >20% of their use case requires custom work, deprioritize. |
| **Buyer is mid-level (Contracts Manager or below) with no exec sponsor identified** | Deal stalls. No budget authority. Champion can't navigate internal procurement. | Ask in first call: "Who else would need to be involved in a decision like this?" If answer is vague, coach or qualify out. |
| **Company in active cost-cutting / layoffs** | Budget frozen, legal headcount being reduced (so fewer users), survival mode | Check recent press. If RIF happened in last 6 months, deprioritize unless M&A trigger offsets. |
| **Non-English contract portfolio (>50%)** | Product-market fit gap if your NLP is English-optimized | Ask about contract languages in discovery. |

### 2.3 Time-Waster Patterns for BDR Team

Specific behaviors that signal a deal is going nowhere. Train the BDR team to recognize these:

1. **"Send me some materials and I'll review internally"** — No next meeting booked. Translation: polite rejection. **Action:** Offer a specific follow-up date. If declined, move to nurture.

2. **3+ reschedules on discovery call** — Champion doesn't have organizational support or personal urgency. **Action:** After 2nd reschedule, send a breakup email.

3. **"We're evaluating 5+ tools"** — Bake-off with no clear decision criteria. Usually means no internal champion. **Action:** Ask who is leading the evaluation and what the decision timeline is. If no clear answer, deprioritize.

4. **Asks for free pilot before any discovery conversation** — Looking for free labor, not a solution. **Action:** Offer a structured 30-day pilot with defined success criteria and executive check-in, or decline.

5. **IT/Security review initiated before business case is agreed** — Premature process, no champion pushing. **Action:** Pause security review, redirect to business value conversation with economic buyer.

---

## Part 3: ICP-Aligned Outbound Targeting Playbook

### 3.1 Account Sourcing Criteria

Where to build your target account list:

| Source | Filter Logic |
|---|---|
| **Crunchbase** | Series B/C raised in last 6 months, $50M–$500M valuation, fintech/healthtech/B2B SaaS tags |
| **LinkedIn Sales Navigator** | Companies with 300–1,500 employees + "Legal Counsel," "VP Legal Ops," or "General Counsel" in headcount + recent legal team job postings |
| **M&A databases (PitchBook, Crunchbase Acquisitions)** | Acquirers in target verticals with deals closed in last 12 months |
| **Job boards (Ashby, Lever, Greenhouse scrapers)** | Companies posting for legal roles (signal: growing team, or backfilling churn) |
| **G2/Capterra intent signals** | Companies researching "contract management," "contract review," "legal automation" |

### 3.2 Trigger-Based Outreach Templates

| Trigger | Opening Angle |
|---|---|
| **Series B/C announced** | "Congrats on the round. When [similar company] raised their Series C, their contract volume tripled in 90 days — their legal team hit a wall at month 2. Happy to share how they handled it." |
| **M&A announced** | "Post-acquisition contract consolidation is one of the highest-stress projects a legal team faces. We helped [reference] get through 3,000 inherited contracts in 6 weeks instead of 6 months." |
| **New GC/VP Legal Ops hired** | "First 90 days in a new legal leadership role — you're probably auditing the current stack and process. Here's what other new GCs have prioritized first." |
| **Legal team job posting live for 60+ days** | "Looks like you've been hiring for [role] for a while. Tough market for legal talent. Some of our customers solved the capacity gap differently — curious if that's relevant." |

---

## Part 4: Validation & Iteration Plan

This ICP is based on 30 deals. That's enough to see patterns but not enough to be statistically confident. Here's the plan to sharpen it:

### 4.1 Data to Track From Deal 31 Onward

For every closed-won AND closed-lost deal, capture:

- All firmographic dimensions above
- Which situational trigger was present (if any)
- Sales cycle length (days from first meeting to close)
- Champion title and seniority
- Economic buyer title
- Whether an existing CLM was in place
- Win/loss reason (primary and secondary)
- Contract volume (self-reported)
- ACV

### 4.2 Quarterly ICP Review Cadence

| Milestone | Action |
|---|---|
| **50 deals** | First statistical review. Validate or adjust firmographic ranges. Identify any new vertical patterns. |
| **75 deals** | Add conversion rate by ICP score band. Calibrate scoring weights. |
| **100 deals** | Full ICP v2.0 with cohort analysis by trigger type, vertical, and company size. Build predictive model if data supports it. |
| **Every quarter thereafter** | Review win/loss data, adjust scoring, add/remove anti-ICP patterns based on new closed-lost analysis. |

### 4.3 Signals That the ICP Needs Updating

- Win rate drops below 20% for Tier 1 scored accounts
- A new vertical appears in 3+ consecutive closed-won deals
- Average sales cycle lengthens by 30%+ without product changes
- Churn concentrates in a specific firmographic segment (means ICP is right for closing but wrong for retention)

---

## Part 5: One-Page BDR Reference Card

*Print this. Pin it to the wall. Refer to it before every outreach.*

### PURSUE (Green Light)

- Mid-market (300–1,500 employees, $50M–$500M revenue)
- Fintech, healthtech, or B2B SaaS
- 200+ contracts/month
- Legal team of 3–8 people
- Just raised Series B/C OR just did M&A
- No CLM platform in place
- Champion is Sr. Legal Counsel or VP Legal Ops

### PAUSE (Yellow Light)

- Right size but wrong vertical (unknown fit)
- Right profile but no active trigger
- Champion is mid-level with no exec sponsor yet
- Company in cost-cutting mode

### PASS (Red Light)

- Fortune 500 with dedicated Legal Ops team and CLM
- Pre-seed/seed startup with 0–1 lawyers
- <100 contracts/month
- Government/public sector
- Buyer wants free pilot before discovery
- 3+ evaluation reschedules

---

*This document should be treated as a living artifact. Update it as deal volume increases and patterns sharpen.*
