# Pre-Call Brief: Ironclad Distribution

**Call Date:** Tomorrow, 2:00 PM ET (Discovery Call)
**Contact:** Natalie Reeves, VP of Supply Chain
**Company:** Ironclad Distribution (Memphis, TN)
**Our Product:** PredictFlow (AI Demand Forecasting Platform)

---

## Company Snapshot

| Field | Detail |
|---|---|
| Industry | Third-Party Logistics (3PL) |
| Segment | Mid-market |
| Employees | ~600 |
| Revenue | ~$180M |
| HQ | Memphis, TN |
| ERP | SAP |
| WMS | Blue Yonder |

---

## What We Know (Intel Summary)

**Inbound signal:** Natalie submitted a demo request via website after attending our AI-powered demand forecasting webinar. Form note: "evaluating demand planning tools for Q3 implementation."

**Organizational signals:**
- Hired a Chief Digital Officer ~2 months ago. This signals executive-level mandate for digital transformation and likely budget allocation for technology initiatives.
- A new CDO typically has a 90-day mandate to identify quick wins and strategic bets. We are inside that window.

**Pain signals (public):**
- Missed fill rates on two major retail accounts in Q3 last year (per earnings call). For a 3PL, missed fill rates are existential -- they directly threaten contract renewals and margin.
- A Memphis-based 3PL serving retail accounts likely handles seasonal demand spikes (back-to-school, holiday). Q3 misses suggest their current forecasting could not handle demand volatility.

**Tech environment:**
- SAP ERP + Blue Yonder WMS is a common but rigid stack. Demand planning is often the weakest link -- SAP's native forecasting (SAP IBP or legacy APO) is notoriously difficult to tune and slow to adapt. Blue Yonder has demand planning modules, but if they were working, Natalie would not be on our website.
- Integration story matters: PredictFlow needs to play nicely with SAP data feeds and potentially push forecasts into Blue Yonder for execution.

---

## Buyer Profile: Natalie Reeves

**Title:** VP of Supply Chain
**Role in deal:** Likely the business champion and budget influencer. As VP of Supply Chain at a mid-market company, she probably owns or co-owns the demand planning function. She may need CDO sign-off (technical validation) and CFO/CEO approval for budget.

**Likely motivations:**
- She is personally accountable for fill rates. Last year's Q3 miss was likely a career-defining bad quarter. She needs a solution before this Q3.
- "Q3 implementation" language suggests urgency -- she has a hard deadline, probably wanting to be live before peak season.
- Attended the webinar first, then submitted a form. This is a self-educated buyer. She is past awareness and into active evaluation.

**Likely concerns:**
- Implementation timeline -- can PredictFlow be live before Q3?
- Integration with SAP and Blue Yonder -- she does not want a rip-and-replace.
- Accuracy proof -- she needs to believe AI forecasting is materially better than what they have.
- Change management -- her planning team will need to trust the new tool.

---

## Key Hypotheses to Validate on the Call

1. **What broke in Q3?** Was it a demand sensing failure (they did not see the spike), a planning process failure (they saw it but could not react), or an execution failure (plan was right but warehouse/transport could not deliver)? PredictFlow solves the first two, not the third. We need to confirm the problem is in our strike zone.

2. **Who else is evaluating?** "Evaluating demand planning tools" (plural) means we are likely in a competitive bake-off. Probable competitors: Blue Yonder's own demand planning module (expand existing vendor), SAP IBP (same), Kinaxis, o9 Solutions, possibly Anaplan.

3. **Who is the CDO and what is their role in this decision?** A new CDO may be the executive sponsor, or they may be a gatekeeper who wants to run their own evaluation process. We need to know if the CDO is an accelerator or a bottleneck.

4. **What does "Q3 implementation" actually mean?** Does she mean contract signed by Q3, live in production by Q3, or showing measurable results by Q3? The answer changes our entire deal timeline.

5. **What is the buying process?** Mid-market 3PL at $180M revenue -- is there a formal procurement process, or can Natalie and the CDO move fast with CFO approval?

6. **What data do they have?** AI forecasting is only as good as the historical data. What granularity of demand data do they have in SAP? How far back? How clean?

---

## Recommended Call Structure (30-min Discovery)

### Opening (3 min)
- Thank her for attending the webinar and submitting the request.
- Set the agenda: "I'd love to understand what's driving the evaluation so I can make sure our time together is useful. Mind if I ask some questions about your current setup and goals before we dive into PredictFlow specifics?"
- Confirm time and who else might be joining.

### Discovery (18 min)

**Start with the business problem (not technology):**
- "You mentioned evaluating demand planning tools for Q3 implementation -- what's driving the urgency on the timeline?"
- "Can you walk me through what happened with fill rates last year? What was the root cause as you see it?"
- "How are you doing demand forecasting today? What tools and processes does that involve?"

**Understand the current state:**
- "How does the forecast flow from planning into execution in your SAP and Blue Yonder environment?"
- "Who owns the forecast today -- is it a central planning team, or is it distributed across account managers?"
- "What does a good forecast look like for you in terms of accuracy? Where are you today versus where you need to be?"

**Map the buying process:**
- "You mentioned evaluating tools -- where are you in that process? Are you looking at other solutions as well?"
- "Who else is involved in this decision? I noticed you recently brought on a Chief Digital Officer -- are they part of this initiative?"
- "What does the approval process look like for a project like this?"

**Establish urgency and timeline:**
- "When you say Q3 implementation, what does success look like by that date?"
- "Is there a specific event or deadline driving the Q3 target -- like a contract renewal with one of those retail accounts?"

### Bridge to PredictFlow (5 min)
- Based on what she shared, give a brief, tailored overview -- not a full demo. Focus on:
  - SAP integration capabilities (we pull data from SAP, not replace it).
  - Time to value -- how fast can we get to a proof of concept.
  - A relevant 3PL or distribution customer example if we have one.
- If fill rate misses were demand sensing failures: emphasize PredictFlow's real-time signal ingestion and anomaly detection.
- If they were planning process failures: emphasize workflow automation and scenario planning.

### Close and Next Steps (4 min)
- "Based on what you've shared, I think there's a strong fit. Here's what I'd recommend as a next step..."
- Propose a technical deep-dive with her planning team (and ideally the CDO) where we can show PredictFlow against their actual data.
- Confirm: "What would you need to see to feel confident moving forward?"
- Lock the next meeting before hanging up.

---

## Competitive Positioning Notes

| Competitor | Their Angle | Our Counter |
|---|---|---|
| **Blue Yonder Demand Planning** | "You already have us for WMS, just expand." | Incumbent WMS vendor bundling demand planning is a different competency. If their forecasting worked, fill rates would not have missed. PredictFlow is purpose-built for forecasting accuracy. |
| **SAP IBP** | "Stay in the SAP ecosystem." | SAP IBP is powerful but implementation timelines are 9-12+ months. She said Q3. We can get to POC in weeks, not quarters. |
| **Kinaxis / o9 Solutions** | Full supply chain planning suite. | Heavier implementation, broader scope than she needs. If the problem is forecasting accuracy, a focused AI forecasting tool delivers faster ROI than a full platform re-architecture. |

---

## Red Flags to Watch For

- If the CDO wants to run a 6-month formal RFP process, the Q3 timeline is dead and the deal could stall.
- If the real problem was warehouse execution (not demand forecasting), PredictFlow does not solve it and we should qualify out early.
- If she has no budget yet and is "just exploring," this is an early-stage lead, not an active deal. Adjust follow-up cadence accordingly.
- If SAP data is fragmented or low-quality, implementation will be harder than expected. Probe data readiness early.

---

## Three Things to Remember Walking In

1. **She came to us.** This is an inbound, self-educated buyer with a specific timeline. Match her urgency. Do not over-qualify or slow her down with unnecessary process.

2. **The Q3 miss is the emotional center of this deal.** She lived through that failure. Acknowledge it without dwelling on it. Position PredictFlow as the thing that makes sure it never happens again.

3. **The CDO hire is your executive sponsor path.** A new CDO needs visible wins. An AI demand forecasting deployment is exactly the kind of project a CDO wants to champion in their first year. Find out if the CDO is engaged and, if so, get a meeting with them as fast as possible.
