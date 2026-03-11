# WARM Sequence: David Chen, Director of Revenue Operations -- Lumen Health

## Sequence Overview

| Field | Value |
|-------|-------|
| **Prospect** | David Chen, Director of Revenue Operations |
| **Company** | Lumen Health (mid-market healthtech SaaS, $28M ARR, 180 employees) |
| **Product** | EHR integration middleware for regional hospital networks |
| **Our Product** | DataBridge -- RevOps data unification platform |
| **Sequence Type** | WARM (indirect signal engagement, no direct interaction yet) |
| **Warm Signals** | Liked VP Marketing's CRM data hygiene post; Top 50 Healthtech list; Salesforce background; hiring SDRs + Marketing Ops Manager |
| **Goal** | 20-minute intro call |
| **Total Touches** | 5 |
| **Cadence** | 35 days |
| **Social Proof Asset** | MedSync case study (healthtech, similar ARR, 4 data sources consolidated, 34% forecast accuracy improvement) |

---

## Touch 1 -- Day 1 | LinkedIn Connection Request

**Channel:** LinkedIn
**Purpose:** Open the relationship with a personalized connection referencing David's specific situation. No pitch.

**Connection Note (300 characters max):**

> David -- saw Lumen Health on the Top 50 Healthtech to Watch list. Congrats. Also noticed you joined from Salesforce about 5 months ago. Always interested to connect with RevOps leaders building from the ground up at growth-stage healthtech companies.

**Intent:** Establish a connection based on his specific signals (Top 50 list + career move). No mention of DataBridge. No ask. The goal is acceptance, not a meeting.

---

## Touch 2 -- Day 5 | Email

**Channel:** Email
**Purpose:** Reference a different signal (hiring activity) and connect it to a challenge David likely faces. No pitch, no ask.

**Subject:** Lumen's growth push

**Body:**

David,

Noticed Lumen is hiring 3 SDRs and a Marketing Ops Manager -- that's a meaningful growth push for a 180-person company.

From what I've seen working with RevOps leaders at healthtech companies in a similar growth phase, that kind of team expansion usually surfaces a specific challenge: the data infrastructure that worked for a 40-person go-to-market team starts breaking when you double it. Reports that used to take 10 minutes take 45. Forecast accuracy drifts because inputs come from different systems with different update cadences.

Not pitching anything here -- just something I've seen enough times to flag. If you're already ahead of it, ignore me.

Best,
[Your Name]

**Intent:** Demonstrate understanding of his situation based on verifiable signals (careers page hiring data). Plant the seed of the data infrastructure scaling problem without naming DataBridge or making an ask.

---

## Touch 3 -- Day 14 | LinkedIn Message

**Channel:** LinkedIn
**Purpose:** Share a problem insight relevant to David's situation. Value-first, no pitch, no ask.

**Message:**

> David -- one pattern I keep seeing with RevOps teams at healthtech companies scaling past $25M ARR: forecast accuracy drops when your data lives in 3-4 different systems and each one updates on a different schedule. The ops team compensates by manually reconciling before every forecast review, which works until the team doubles.
>
> Given Lumen's growth trajectory, curious whether this resonates or if you've already solved it.

**Intent:** Touch 3 is the value-building touch. The insight (forecast accuracy degradation from multi-system data fragmentation) is directly relevant to David's role and company stage. The framing ("curious whether this resonates") invites a response without creating pressure. No mention of DataBridge. No ask for a meeting.

---

## Touch 4 -- Day 24 | Email

**Channel:** Email
**Purpose:** Deploy social proof with the MedSync case study. This is the first touch where DataBridge is mentioned, and it's through a peer example, not a pitch.

**Subject:** How a healthtech RevOps team fixed their forecast accuracy problem

**Body:**

David,

Wanted to share something relevant to the data scaling challenge we discussed.

MedSync -- a healthtech company at a similar ARR to Lumen -- was running their RevOps reporting across 4 different data sources. Their forecast reviews had become manual reconciliation exercises, and accuracy had drifted to the point where leadership didn't trust the numbers.

They used DataBridge to consolidate those 4 sources into a single RevOps dashboard. Result: **34% improvement in forecast accuracy** within one quarter.

Given that Lumen is scaling the go-to-market team and adding new data inputs (new SDRs, new Marketing Ops function), this might be worth a look.

Would 20 minutes make sense to see if DataBridge is relevant to what you're building at Lumen?

[Your Name]

**Intent:** The MedSync case study is deployed at Touch 4 -- after David has received value and context in Touches 1-3. The case study mirrors his situation (healthtech, similar ARR, multi-source data problem, forecast accuracy). The ask (20 minutes) is specific and singular. This is the conversion touch.

---

## Touch 5 -- Day 35 | LinkedIn Message

**Channel:** LinkedIn
**Purpose:** Graceful close. Short, respectful, no ask. Leave the door open for future re-engagement.

**Message:**

> David -- I've shared a few thoughts over the past few weeks on scaling RevOps data at growth-stage healthtech companies. If the timing isn't right, completely understand. No need to respond.
>
> If Lumen's data infrastructure becomes a priority down the line, I'm easy to find here. Wishing you and the team continued momentum.

**Intent:** Touch 5 closes the sequence with respect. It is short, contains no ask, no pressure, no "just checking in." It acknowledges that timing may not be right and explicitly removes the obligation to respond. A warm lead who receives a respectful close is significantly more likely to respond to a re-engagement sequence in 90 days than one who received a pressuring final touch.

---

## Sequence Summary

| Touch | Day | Channel | Purpose | Ask? | DataBridge Mentioned? |
|-------|-----|---------|---------|------|----------------------|
| 1 | Day 1 | LinkedIn | Connection -- Top 50 list + Salesforce background | No | No |
| 2 | Day 5 | Email | Signal-based insight -- hiring ramp + data scaling challenge | No | No |
| 3 | Day 14 | LinkedIn | Problem insight -- forecast accuracy + multi-system data | No | No |
| 4 | Day 24 | Email | Social proof -- MedSync case study + 20-min meeting ask | Yes (20 min) | Yes |
| 5 | Day 35 | LinkedIn | Graceful close -- no ask, leave door open | No | No |

**Channels used:** 2 (LinkedIn and Email)
**Channel pattern:** LinkedIn > Email > LinkedIn > Email > LinkedIn (alternating, no consecutive same-channel within 3-day window)

---

## Branching Rules

### Reply-Exit Rule
**ANY reply at ANY touch immediately exits the sequence and alerts the rep.**

If David responds at any point -- even a "not interested right now" -- the automated sequence stops. The rep takes over manually. Sending an automated follow-up after a prospect has replied destroys trust and signals that you're not actually paying attention.

| Trigger | Action |
|---------|--------|
| Reply received (any touch) | EXIT sequence immediately |
| Reply received (any touch) | Alert rep via CRM notification + Slack |
| Reply received (any touch) | Rep manually handles all subsequent communication |
| Positive reply (meeting interest) | Rep books the 20-minute intro call directly |
| Negative reply (not interested) | Rep acknowledges respectfully; log outcome in CRM; do NOT re-sequence for 90 days |
| Neutral reply (timing not right) | Rep acknowledges; add to 90-day re-engagement queue |

### LinkedIn Connection Not Accepted (Touch 1)
If David does not accept the LinkedIn connection within 3 days:
- Touch 2 proceeds as planned (email -- does not depend on LinkedIn acceptance)
- Touch 3 converts from LinkedIn message to email (cannot message without connection)
- Touch 5 converts from LinkedIn message to email

### Out-of-Office / Bounce
- Out-of-office reply: Pause sequence, resume when OOO period ends
- Email bounce: Flag for data verification, attempt alternate email, do not continue emailing a bounced address

---

## Sequence Completion

### If David Responds (Any Touch)
- Sequence exits immediately
- Rep manages relationship manually
- CRM updated with response type and next steps

### If No Response After Touch 5 (Day 35)
| Action | Detail |
|--------|--------|
| Move to cultivate nurture cadence | Monthly value-add touchpoints (industry content, relevant insights) -- no pitch, no meeting ask |
| CRM logging | Log sequence completion: "WARM 5-touch completed, no response, moved to cultivate" |
| Re-engagement eligibility | Eligible for new sequence after 90-day cooling period |
| Re-engagement trigger | New signal (funding round, leadership change, product launch, tech stack change) can trigger early re-engagement before 90 days |

---

ALL OUTREACH OUTPUTS REQUIRE HUMAN REVIEW BEFORE SENDING.
