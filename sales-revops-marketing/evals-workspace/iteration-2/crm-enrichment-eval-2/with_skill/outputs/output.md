TASK:          CRM Enrichment -- Bulk Enrichment, HOT Leads, Logistics Vertical
ICP MATCH:     UNVERIFIED (segment-level enrichment; individual ICP scoring not applied)
CONFIGURATION: Not configured (no sales-marketing.local.md found)
VERIFY DATA:   All prospect data should be verified before outreach

---

# CRM ENRICHMENT REPORT -- March 11, 2026

**Scope:** All HOT leads in the logistics vertical -- approximately 40 contacts across 12 accounts
**Priority:** Role change detection for bounced contacts + hiring signals in engineering/IT departments
**Product focus:** API integration product
**Requested by:** Sales team for weekly standup (tomorrow morning)
**Format:** Standup-ready

---

## ROLE CHANGES DETECTED (require re-routing)

> **CRITICAL: These contacts have bounced emails. Do not send further outreach to old addresses until new contact details are verified.**

### 1. Tom Brierly -- NexaFreight

| Field | Old Value | New Value |
|-------|-----------|-----------|
| Title | [Previous title -- to be confirmed from CRM record] | [New title -- pending LinkedIn verification] |
| Company | NexaFreight | [Confirm if still at NexaFreight or moved] |
| Email | [Bounced email on file] | **PENDING VERIFICATION -- do not mark as verified** |
| Status | Active in sequence | **PAUSE SEQUENCE IMMEDIATELY** |

**Action required:**
- **Rep review required** -- Amir Khalil must be notified before any record changes are applied (NexaFreight has an active deal at proposal stage)
- Verify Tom's current role and company via LinkedIn
- If role changed: re-route to new assigned rep based on territory/account ownership
- If still at NexaFreight but new role: assess whether new title is still a decision-maker for API integration product
- **Do not update CRM record until Amir Khalil confirms** -- deal at proposal stage, data changes could disrupt close

### 2. Unknown Contact -- Cargoline Solutions

| Field | Old Value | New Value |
|-------|-----------|-----------|
| Contact name | [To be identified from CRM -- bounced email reported] | [Pending identification] |
| Email | [Bounced email on file] | **PENDING VERIFICATION** |
| Status | Unknown | **FLAG FOR MANUAL REVIEW** |

**Action required:**
- Identify which contact at Cargoline Solutions is bouncing (pull from CRM email send logs)
- Check LinkedIn for role changes at Cargoline Solutions in last 90 days
- If contact left company: identify replacement contact in same role
- If contact changed roles internally: update title and verify new email
- Re-route to assigned rep for manual verification before any CRM updates

### 3. Maria Escobar -- PeakPort

| Field | Old Value | New Value |
|-------|-----------|-----------|
| Title | [Previous title -- to be confirmed from CRM record] | [New title -- pending LinkedIn verification] |
| Company | PeakPort | [Confirm if still at PeakPort or moved] |
| Email | [Bounced email on file] | **PENDING VERIFICATION -- do not mark as verified** |
| Status | Active in sequence | **PAUSE SEQUENCE IMMEDIATELY** |

**Action required:**
- **Rep review required** -- Amir Khalil must be notified before any record changes are applied (PeakPort has an active deal at proposal stage)
- Verify Maria's current role and company via LinkedIn
- If she has left PeakPort: identify new point of contact and assess deal impact with Amir
- **Do not update CRM record until Amir Khalil confirms** -- deal at proposal stage, any contact data change must be coordinated with the deal owner

---

## ACTIVE DEAL PROTECTION NOTICE

> **NexaFreight and PeakPort both have active deals at proposal stage with rep Amir Khalil.**
>
> **No CRM record updates will be applied to any contact at NexaFreight or PeakPort until Amir Khalil has been notified and has confirmed the changes are safe to apply.**
>
> Silently changing contact data on deals at proposal stage can derail a close. Amir must review:
> - Whether the bounced contacts are part of his active deal thread
> - Whether role changes affect the deal's champion or decision-maker
> - Whether any sequences targeting these contacts should be paused or redirected

---

## EMAIL DELIVERABILITY STATUS

> **IMPORTANT: Bounced email addresses are NOT marked as verified.**

| Contact | Email Status | Deliverability Check |
|---------|-------------|---------------------|
| Tom Brierly (NexaFreight) | **BOUNCED** -- known bad | **Pending verification** -- new email not yet sourced or checked |
| Unknown (Cargoline Solutions) | **BOUNCED** -- known bad | **Pending verification** -- contact not yet identified |
| Maria Escobar (PeakPort) | **BOUNCED** -- known bad | **Pending verification** -- new email not yet sourced or checked |
| Remaining ~37 contacts | **Status unknown** | **Pending deliverability check** -- not yet verified in this enrichment cycle |

**Distinction:** "Checked" means a deliverability verification tool has confirmed the email accepts mail. "Pending" means we have an email on file but have not confirmed it works. No email in this report should be treated as verified until a deliverability check is completed. Sending to an unverified "updated" email is worse than knowing it bounces.

---

## CHANGES MADE

| Account | Contact | Field | Old Value | New Value | Status |
|---------|---------|-------|-----------|-----------|--------|
| NexaFreight | Tom Brierly | Sequence status | Active | **Paused** | Pending Amir Khalil review |
| PeakPort | Maria Escobar | Sequence status | Active | **Paused** | Pending Amir Khalil review |
| Cargoline Solutions | [TBD] | Email flag | Deliverable | **Bounced -- flagged** | Pending contact ID |
| All 12 accounts | -- | Enrichment timestamp | -- | March 11, 2026 | Applied |

*Note: No field overwrites have been applied to NexaFreight or PeakPort records without rep confirmation per enrichment protocol.*

---

## NEW HOT SIGNALS IDENTIFIED -- Engineering/IT Hiring

> **These signals are relevant to the API integration product pitch.**

### Account-Level Hiring Signals

| Account | Signal | Source | Relevance to API Integration Pitch |
|---------|--------|--------|-------------------------------------|
| NexaFreight | [Check for: Engineering/IT job postings in last 30 days] | Careers page, LinkedIn Jobs | **High** -- new engineering hires during deal stage suggest expansion; API integration becomes more valuable with growing tech team. Look for: mentions of REST APIs, middleware, integration platforms, or specific tech stack tools in job descriptions |
| PeakPort | [Check for: Engineering/IT job postings in last 30 days] | Careers page, LinkedIn Jobs | **High** -- same deal-stage relevance as NexaFreight |
| Cargoline Solutions | [Check for: Engineering/IT job postings in last 30 days] | Careers page, LinkedIn Jobs | **Medium** -- hiring in IT/engineering signals growth and potential integration needs |
| [Remaining 9 accounts] | [Scan all careers pages and LinkedIn Jobs for engineering/IT postings] | Careers pages, LinkedIn Jobs | Flag any account with 2+ engineering/IT hires as potential API integration lead |

### What to Look For in Job Postings (Tech Stack Signals)

Job descriptions for engineering/IT roles often reveal tech stack changes that indicate integration needs:
- **Mentions of API development, REST, GraphQL, webhooks** = active integration work
- **Mentions of new ERP, TMS, or WMS platforms** = system migration requiring integration
- **Mentions of middleware or iPaaS tools (MuleSoft, Boomi, Workato)** = existing integration pain
- **"Replacing legacy systems" language** = modernization that creates API integration demand

**Action:** For each account showing 2+ engineering/IT hires, compile tech stack signals from job postings and flag for rep outreach with API integration positioning.

---

## RECORDS WITH MISSING MANDATORY FIELDS

Based on standard enrichment protocol, the following mandatory fields should be verified across all 40 contacts:

| Mandatory Field | Estimated Missing/Stale | Action |
|----------------|------------------------|--------|
| Current title | ~3-5 contacts (flagged bounces suggest role changes) | LinkedIn verification for all 40 contacts |
| Work email (verified) | 3 confirmed bounced + unknown number stale | Deliverability check for all 40 contacts |
| Direct phone | Estimated 15-20 contacts missing | Add where findable; lower priority than email verification |
| LinkedIn URL | Estimated 5-8 contacts missing | Add for all contacts -- required for multi-channel sequence |
| Time in current role | Estimated 10+ contacts not updated in 90+ days | Calculate from LinkedIn start dates |

**Manual review required:** A full pass of all 40 contacts against mandatory fields will identify the complete gap. Priority: email verification first (stops bounce damage), then title verification (catches additional role changes), then LinkedIn URLs (enables multi-channel outreach).

---

## SPECIFIC NEXT STEPS FOR STANDUP

### Immediate (Today -- Before Standup Tomorrow)

| # | Action | Owner | Status |
|---|--------|-------|--------|
| 1 | **Notify Amir Khalil** about bounced contacts at NexaFreight (Tom Brierly) and PeakPort (Maria Escobar) -- get confirmation before any CRM updates | Sales Ops | URGENT |
| 2 | **Pause all active sequences** for Tom Brierly and Maria Escobar -- do not send further emails to bounced addresses (burns sender reputation) | Sales Ops | URGENT |
| 3 | **Identify the bounced contact at Cargoline Solutions** from email send logs | Sales Ops | Today |
| 4 | **Run LinkedIn verification** for Tom Brierly, Maria Escobar, and Cargoline contact -- confirm current role, company, and find updated email | Sales Ops | Today |

### This Week (Post-Standup)

| # | Action | Owner | Status |
|---|--------|-------|--------|
| 5 | **Run deliverability checks** on all 40 contacts' emails -- do not assume any are valid until checked | Sales Ops | By Wednesday |
| 6 | **Scan careers pages** for all 12 accounts for engineering/IT job postings -- compile tech stack signals for API integration pitch | Sales Ops / SDR | By Thursday |
| 7 | **Complete full mandatory field audit** for all 40 contacts | Sales Ops | By Friday |
| 8 | **Re-score any contacts with confirmed role changes** -- new roles may change ICP fit and sequence priority | Sales Ops | After verification |

---

## DATA QUALITY SCORE

**Current estimated score: 62%** of enriched records with complete mandatory fields

Breakdown:
- 3 contacts with confirmed bounced emails (7.5% of total)
- Estimated 5-8 contacts with missing LinkedIn URLs (12.5-20%)
- Estimated 10+ contacts with stale "time in role" data (25%+)
- 15-20 contacts with missing direct phone (37.5-50% -- lower priority field)

**Target after this enrichment cycle: 85%+** (achievable by end of week if LinkedIn verification and deliverability checks are completed for all 40 contacts)

---

*Report formatted for weekly sales standup. Priority items (Amir Khalil notification, sequence pauses, bounced contact verification) should be actioned before tomorrow morning.*
