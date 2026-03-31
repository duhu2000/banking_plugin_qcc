TASK:          CRM Enrichment -- Brightpath Consulting (Tier 1 Account)
ICP MATCH:     UNVERIFIED
CONFIGURATION: Not configured
VERIFY DATA:   All prospect data should be verified before outreach

---

# CRM ENRICHMENT REPORT -- 2026-03-11

Scope: Single Tier 1 account -- Brightpath Consulting (UK, mid-market fintech). Contact: Gemma Hargreaves.
Total: 1 account, 1 contact processed

---

## ACCOUNT-LEVEL ENRICHMENT: Brightpath Consulting

### Mandatory Fields

| Field | CRM Value (Last Updated Nov) | Enrichment Finding | Status |
|---|---|---|---|
| Legal company name | Brightpath Consulting | Multiple UK entities found: **BRIGHTPATH CONSULTING LIMITED** (Co. 10783072, Hampshire, est. 2017), **BRIGHTPATH CONSULTING SERVICES LTD** (Co. 15993318, Milton Keynes, est. Oct 2024), **BRIGHTPATH UK CONSULTING LTD** (Co. 11910292, Leeds, est. 2019). None are identifiable as mid-market fintech firms. | REQUIRES MANUAL VERIFICATION |
| Industry | Mid-market fintech | The LinkedIn entity "BrightPath Consulting Services" (Milton Keynes) specialises in **telecoms, network transformation, AI network services, and cloud** -- not fintech. SIC codes across all Companies House entities are "Management consultancy" and "IT consultancy" -- no fintech SIC codes registered. | DISCREPANCY -- FLAG FOR REP REVIEW |
| Revenue estimate | Not in CRM | No public revenue data found. BRIGHTPATH CONSULTING LIMITED accounts are overdue (period ending May 2025). | MISSING -- MANUAL RESEARCH REQUIRED |
| Headcount | ~200 (CRM estimate) | The LinkedIn company page for BrightPath Consulting Services shows **51 employees** and references "12 Partners with 240+ combined years of experience". This is significantly below the 200-employee estimate in CRM (>74% variance). However, this may be a different entity. | DISCREPANCY -- FLAG FOR REP REVIEW |
| Headquarters | UK | Multiple registered addresses found: Hampshire (SO50 7LP), Milton Keynes (MK15 0AY), Leeds. LinkedIn entity headquartered in **Milton Keynes**. | REQUIRES CLARIFICATION -- WHICH ENTITY? |
| Website | Not verified | Candidates: brightpath-consulting.com (returned 404), brightpathconsulting.co.uk (coach/bus sector -- wrong industry). LinkedIn page: uk.linkedin.com/company/brightpath-consulting-services | REQUIRES MANUAL VERIFICATION |

### Intelligence Fields

| Signal | Finding |
|---|---|
| News events (last 30 days) | No news coverage found for any Brightpath Consulting entity in the last 30 days. No funding rounds, M&A, or contract announcements identified. |
| Hiring signal | No active job postings found specifically for Brightpath Consulting in fintech-related roles. |
| Tech stack changes | No data available. |
| Financial signals | BRIGHTPATH CONSULTING LIMITED (Co. 10783072) has **overdue accounts** at Companies House -- next accounts were due 28 Feb 2026 for period ending 31 May 2025. This is a potential financial health flag. |
| Timing signal | Insufficient data to reclassify. Recommend maintaining current classification pending manual verification of correct entity. |

### Critical Account-Level Finding

There is a **significant identity ambiguity** with this account. No UK entity named "Brightpath Consulting" matches the profile of a "mid-market fintech with ~200 employees." The closest match by headcount is a telecoms/network consultancy with 51 employees. This suggests one of:

1. The company name in CRM may be slightly different from the legal name (e.g., a trading name)
2. The industry classification in CRM may be incorrect (consulting TO fintech, not a fintech company itself)
3. The company may have rebranded, been acquired, or changed its operating model since last enrichment

**Action required:** Priya (assigned rep) should confirm the correct legal entity and website before QBR.

---

## CONTACT-LEVEL ENRICHMENT: Gemma Hargreaves

### Mandatory Fields

| Field | CRM Value | Enrichment Finding | Status |
|---|---|---|---|
| Full name | Gemma Hargreaves | Name confirmed. A LinkedIn profile exists for "Gemma Hargreaves" but she is listed as a **Global Marketing Director at The Bicester Collection** (luxury retail), based in Royal Tunbridge Wells. This does not match the CRM record. | POSSIBLE ROLE/COMPANY CHANGE -- SEE BELOW |
| Current title | Head of Partnerships | Could not verify this title at any Brightpath entity. The only publicly visible Gemma Hargreaves on LinkedIn holds a marketing director role in luxury retail, not fintech partnerships. | UNVERIFIED |
| Current company | Brightpath Consulting | Could not confirm association. No Gemma Hargreaves appears in any publicly available Brightpath team listing or company page. | UNVERIFIED |
| Work email | Not in CRM / not provided | No work email found. Cannot verify deliverability without a candidate address. | MISSING |
| Direct phone | 077-XXXX (manually entered by BDR Marcus from conference badge) | Cannot verify phone number validity without the full number. **Per SKILL.md rules: DO NOT overwrite this field.** Marcus manually entered it -- human-entered data may be more current than web data. | FLAGGED -- DO NOT MODIFY (see below) |
| LinkedIn URL | Not in CRM | Candidate: linkedin.com/in/gemma-hargreaves-94486481 -- but this profile shows a different role/company. May be wrong person. | REQUIRES MANUAL VERIFICATION |

### Intelligence Fields

| Signal | Finding |
|---|---|
| Time in current role | Cannot calculate -- role at Brightpath not confirmed on LinkedIn. |
| Recent public activity | User reported LinkedIn has been "dead quiet for months" -- confirmed. No recent posts, articles, or public activity found for any Gemma Hargreaves matching this profile. |
| New pain signals | None identified. |
| Career change flag | **HIGH RISK.** The only Gemma Hargreaves found on LinkedIn is at The Bicester Collection (luxury retail), not Brightpath Consulting. Combined with no LinkedIn activity, this strongly suggests either: (a) she has left Brightpath and the LinkedIn profile is a different person, or (b) she has left Brightpath and has not updated her LinkedIn. Either way, the contact record is unreliable. |

### Critical Contact-Level Finding

Per SKILL.md: "NEVER assume a contact is still at a company if LinkedIn shows no updates in >12 months -- flag for manual verification."

Gemma Hargreaves's continued presence at Brightpath Consulting **cannot be confirmed**. The record is flagged for manual verification by Priya before any outreach or QBR discussion.

---

## PHONE NUMBER: Marcus's Conference Badge Entry

Per SKILL.md: "NEVER overwrite a manually entered field without flagging the change to the record owner."

The phone number (077-XXXX partial) was manually entered by BDR Marcus from a conference badge. Actions taken:

- **The phone number has NOT been modified or overwritten.**
- The number cannot be verified without the full digits and without contacting Gemma directly.
- UK mobile numbers starting with 077 are valid UK mobile prefixes (O2, Vodafone, others).
- **Recommendation:** Marcus should be asked to confirm the full number. If Gemma's employment at Brightpath cannot be confirmed, the number may still be her personal mobile -- but outreach to a personal number for someone who may no longer be at the target company raises compliance concerns.
- **Do not call this number until Gemma's current employment is verified.**

---

## DEAL STAGE COMPLIANCE

Per SKILL.md: "NEVER enrich and update a record that is in an active deal stage without notifying the assigned rep."

This deal is in **Proposal Sent** stage with **Priya** as assigned rep. All findings in this report are flagged for Priya's review before any CRM fields are updated. No CRM writes have been made.

**Priya must be notified of:**
1. Account identity ambiguity (which Brightpath entity is this?)
2. Contact reliability concern (Gemma may no longer be there)
3. Headcount and industry discrepancies
4. The overdue Companies House filing for Brightpath Consulting Limited

---

## ROLE CHANGES DETECTED (require re-routing)

Gemma Hargreaves -- **possible** change from Head of Partnerships at Brightpath Consulting to unknown role -- CRM record flagged for rep review. Cannot confirm new role/company. If she has departed, Priya needs to identify a new champion at the account before QBR.

---

## NEW HOT SIGNALS IDENTIFIED

None. No positive buying signals detected. The overdue Companies House filing for one Brightpath entity is a **negative** signal worth monitoring.

---

## RECORDS WITH MISSING MANDATORY FIELDS

1 contact record missing:
- Verified current title
- Verified current company
- Work email
- LinkedIn URL (confirmed)
- Full/verified phone number

1 account record missing:
- Confirmed legal entity name
- Revenue estimate
- Verified headquarters address
- Verified website
- Confirmed headcount

---

# DATA QUALITY SCORE: 15% of enriched records now complete

Of the combined mandatory fields across account (5 fields) and contact (6 fields) = 11 total mandatory fields, only the contact's full name and the account's country (UK) could be confirmed = approximately 2/11.

---

## PRE-QBR ACTION ITEMS (Before Thursday)

| Priority | Action | Owner | Deadline |
|---|---|---|---|
| P0 | Confirm which legal entity is the actual customer (name, company number, website) | Priya | Before QBR |
| P0 | Verify whether Gemma Hargreaves is still at Brightpath -- call, email, or ask Marcus if he has recent contact | Priya + Marcus | Before QBR |
| P1 | If Gemma has left, identify new champion/contact at Brightpath | Priya | Before QBR |
| P1 | Confirm industry classification -- is this a fintech company or a consultancy serving fintech? | Priya | Before QBR |
| P2 | Ask Marcus to confirm the full 077 phone number and when he last used it | Priya | Before QBR |
| P2 | Verify headcount -- is it ~200 or ~51? Check with internal records or ask the account directly | Priya | Before QBR |
| P3 | Monitor Companies House for overdue accounts filing (Brightpath Consulting Ltd, Co. 10783072) | RevOps | Ongoing |

---

## Sources

- [Brightpath Consulting Limited -- Companies House](https://find-and-update.company-information.service.gov.uk/company/10783072)
- [Brightpath Consulting Services Ltd -- Companies House](https://find-and-update.company-information.service.gov.uk/company/15993318)
- [Brightpath UK Consulting Ltd -- Companies House](https://find-and-update.company-information.service.gov.uk/company/11910292)
- [BrightPath Consulting -- LinkedIn](https://uk.linkedin.com/company/brightpath-consulting-services)
- [Gemma Hargreaves -- LinkedIn](https://www.linkedin.com/in/gemma-hargreaves-94486481/)
- [Brightpath Consulting -- Tracxn Profile](https://tracxn.com/d/companies/brightpath-consulting/__szTuPVmWVvxGqOPZWYw1JDegdpFQHyLSXYnRhhdu6Ec)

ALL ENRICHMENT FINDINGS REQUIRE REP REVIEW BEFORE CRM UPDATES ARE APPLIED.
