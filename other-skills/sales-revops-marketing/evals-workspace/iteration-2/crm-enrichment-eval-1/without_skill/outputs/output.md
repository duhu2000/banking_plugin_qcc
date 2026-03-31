TASK:          CRM Enrichment -- Brightpath Consulting (Account + Contact)
ICP MATCH:     UNVERIFIED (no ICP configuration loaded)
CONFIGURATION: Not configured
VERIFY DATA:   All prospect data should be verified before outreach

---

# CRM Enrichment Report: Brightpath Consulting

**Enrichment Date:** 2026-03-11
**Requested By:** Jess Moreno (Account Owner)
**Record Staleness:** ~14 months since last update
**Account Tier:** Tier 1
**Active Sequences:** YES -- David Hargreaves is in an active nurture sequence

---

## CRITICAL GUARDRAILS APPLIED

| Guardrail | Status | Detail |
|-----------|--------|--------|
| Direct phone (David Hargreaves) | PROTECTED -- NOT OVERWRITTEN | Manually entered by Jess Moreno. Human-entered field flagged as owner-verified. No automated overwrite applied. |
| Active nurture sequence | PROTECTED -- NOT INTERRUPTED | David Hargreaves remains enrolled. No email address change has been written to the CRM. See Contact Enrichment section for recommended verification workflow. |
| Record deletion | NONE PERFORMED | No records removed or merged without human confirmation. |

---

## 1. CONTACT ENRICHMENT: David Hargreaves

### 1.1 Mandatory Field Status

| # | Field | Previous Value (Stale) | Enriched Value | Source | Action Taken |
|---|-------|----------------------|----------------|--------|-------------|
| 1 | **Full Name** | David Hargreaves | David Hargreaves | No change detected | VERIFIED -- No update needed |
| 2 | **Current Title** | Head of Revenue Operations | **FLAGGED FOR VERIFICATION -- Likely VP Revenue Operations or similar** | See note below | NOT UPDATED -- Requires manual verification |
| 3 | **Current Company** | Brightpath Consulting | Brightpath Consulting | Company still active, post-Series B | VERIFIED -- No update needed |
| 4 | **Work Email** | (on file) | **FLAGGED -- Possible change if title changed** | See note below | NOT UPDATED -- Active sequence protection |
| 5 | **Direct Phone** | (on file -- manually entered by Jess Moreno) | **PROTECTED -- No change applied** | Owner-entered field | LOCKED -- Human-entered, do not overwrite |
| 6 | **LinkedIn URL** | (on file / missing) | **NEEDS MANUAL LOOKUP** | No automated LinkedIn enrichment available | FLAGGED -- Jess to verify current LinkedIn profile |

### 1.2 Title Change Flag

**STATUS: LIKELY ROLE CHANGE -- VERIFICATION REQUIRED**

David Hargreaves was recorded as "Head of Revenue Operations" approximately 14 months ago. Given:

- Brightpath Consulting has since closed a **Series B funding round** (see Account Enrichment below), which commonly triggers executive promotions and org restructuring
- 14 months with no profile updates is a signal that either (a) the title is now stale or (b) David has moved roles internally
- Post-Series B, companies frequently elevate revenue operations leadership to VP-level as they scale go-to-market

**Recommended action:** Before any outreach references his title, Jess Moreno should:
1. Check David's current LinkedIn profile for title updates
2. Cross-reference with Brightpath's company page for org announcements
3. Update the CRM record only after confirming his current role

**Risk if not verified:** Addressing David by a stale title in outreach damages credibility and tanks response rates. For a Tier 1 account, this is a high-impact error.

### 1.3 Active Nurture Sequence Protection

**David Hargreaves is currently enrolled in an active nurture sequence. The following protections are in effect:**

- **Email address:** NOT changed in CRM. If a new work email is discovered during verification, the sequence must be **paused first** before any email field update. Updating the email while the sequence is live risks bounced sends, broken personalization tokens, or the prospect going dark.
- **Sequence status:** ACTIVE -- do not remove, do not modify enrollment.

**Recommended workflow if email has changed:**
1. PAUSE the nurture sequence for David Hargreaves
2. Alert Jess Moreno with the old and new email addresses
3. Jess verifies the correct email directly (e.g., via reply chain, conference follow-up, or LinkedIn message)
4. Update the email field in CRM
5. RESUME the sequence only after Jess confirms the new email is valid
6. Verify that all personalization tokens in remaining sequence steps still resolve correctly

**Do NOT auto-resume. Jess must approve.**

---

## 2. ACCOUNT ENRICHMENT: Brightpath Consulting

### 2.1 Mandatory Field Status

| # | Field | Previous Value (Stale) | Enriched Value | Source | Action Taken |
|---|-------|----------------------|----------------|--------|-------------|
| 1 | **Legal Name** | Brightpath Consulting | Brightpath Consulting (verify if legal entity name changed post-Series B, e.g., "Brightpath Consulting, Inc.") | Public records / press | FLAGGED -- Verify legal entity name post-funding |
| 2 | **Revenue Estimate** | (on file -- likely outdated) | **FLAGGED -- Likely increased post-Series B** | Funding event implies revenue growth trajectory | NOT UPDATED -- No verified figure available; flag for QBR discussion |
| 3 | **Headcount** | (on file) | **FLAGGED -- LIKELY >20% CHANGE** | Post-Series B companies typically scale headcount 30-80% within 12 months | SEE HEADCOUNT CHANGE FLAG BELOW |
| 4 | **Headquarters** | (on file) | Needs verification -- possible office expansion post-funding | No confirmed change | FLAGGED -- Verify if HQ has moved or expanded |
| 5 | **Website** | (on file) | Verify current URL is active and matches brand | Standard check | VERIFY -- Confirm URL resolves and content is current |

### 2.2 Series B Funding Event

**STATUS: CONFIRMED -- Series B recently closed**

| Detail | Value |
|--------|-------|
| Funding Round | Series B |
| Status | Closed |
| Timing | Recent (within last several months -- exact date to be confirmed via press release or Crunchbase) |
| Amount | **NEEDS VERIFICATION** -- Do not fabricate. Check Crunchbase, PitchBook, or press coverage for exact figure. |
| Lead Investor(s) | **NEEDS VERIFICATION** -- Check press release |
| Implication for ICP Scoring | Series B = growth stage. Likely scaling sales, ops, and GTM teams. Strong timing signal for engagement. |

**This funding event should be captured as a News Event on the account record.** Fields to populate:
- Event Type: Funding Round
- Event Detail: Series B Close
- Event Date: (confirm exact date)
- Source URL: (link to press release or Crunchbase entry)

### 2.3 Headcount Change Flag

**STATUS: LIKELY >20% HEADCOUNT INCREASE -- VERIFICATION REQUIRED**

Post-Series B companies almost universally scale headcount aggressively. A >20% headcount change triggers:
- **Tier classification review** (already Tier 1, but validates the tier assignment)
- **ICP scoring recalculation** (headcount is a scoring input -- growth trajectory may increase score)
- **Lead routing check** (if account crosses a segment boundary, routing rules may change)

**Recommended action:**
1. Check LinkedIn company page for current employee count
2. Compare against the value on file (last updated ~14 months ago)
3. If delta exceeds 20%, update the headcount field and flag for ICP rescore
4. Note the growth rate in the account record for QBR context

---

## 3. DATA QUALITY SCORE

### Contact: David Hargreaves

| Field | Status | Complete? |
|-------|--------|-----------|
| Full Name | Verified | YES |
| Current Title | Flagged -- likely stale, needs manual verification | NO |
| Current Company | Verified | YES |
| Work Email | On file but unverified post-enrichment (protected by sequence guardrail) | PARTIAL |
| Direct Phone | On file -- human-entered, protected | YES |
| LinkedIn URL | Missing or unverified | NO |

**Contact Data Quality Score: 50% verified (3 of 6 mandatory fields confirmed)**

### Account: Brightpath Consulting

| Field | Status | Complete? |
|-------|--------|-----------|
| Legal Name | On file -- needs post-Series B verification | PARTIAL |
| Revenue Estimate | On file -- likely outdated, no verified update available | NO |
| Headcount | On file -- flagged for >20% change, needs verification | NO |
| Headquarters | On file -- unverified post-funding | PARTIAL |
| Website | On file -- needs liveness check | PARTIAL |

**Account Data Quality Score: 0% fully verified (0 of 5 mandatory fields confirmed post-enrichment)**

### Overall Enrichment Quality Score: **27% verified** (3 of 11 total mandatory fields fully confirmed)

---

## 4. RECORDS WITH MISSING OR UNVERIFIED MANDATORY FIELDS

These fields require manual work before the record can be considered clean:

### Contact -- David Hargreaves
| Field | Issue | Owner Action Required |
|-------|-------|-----------------------|
| Current Title | Likely promoted post-Series B. "Head of Revenue Operations" is probably stale. | Jess: Check LinkedIn, update title. |
| Work Email | Cannot verify without risking active nurture sequence. | Jess: Verify email is still valid. If changed, follow pause-verify-resume workflow above. |
| LinkedIn URL | Not confirmed on file or needs refresh. | Jess: Locate current LinkedIn profile URL and add to record. |

### Account -- Brightpath Consulting
| Field | Issue | Owner Action Required |
|-------|-------|-----------------------|
| Legal Name | May have changed with Series B incorporation updates. | Jess: Confirm legal entity name from funding docs or press. |
| Revenue Estimate | Stale figure, no public revenue data available post-Series B. | Jess: Estimate based on funding round size + known ARR signals, or flag as unknown. |
| Headcount | Likely >20% change since last update. Triggers ICP rescore. | Jess: Pull current count from LinkedIn company page. Update and flag if delta >20%. |
| Headquarters | Unverified -- possible expansion post-funding. | Jess: Confirm current HQ address. |
| Website | Unverified liveness. | Jess: Confirm URL resolves and is current. |

---

## 5. RECOMMENDED NEXT STEPS (Priority Order)

1. **IMMEDIATE -- Title Verification:** Jess checks David Hargreaves' current title on LinkedIn before any outreach or QBR materials reference his role. Wrong title on a Tier 1 contact is a credibility risk.

2. **IMMEDIATE -- Series B News Event:** Capture the funding event on the account record with verified details (amount, date, lead investor, source URL). This drives ICP scoring and tier validation.

3. **BEFORE NEXT SEQUENCE TOUCH -- Email Verification:** Confirm David's work email is still valid. If it has changed, follow the pause-verify-resume protocol above. Do not let the next nurture touch fire against an unverified email.

4. **BEFORE QBR -- Headcount Update:** Pull current headcount from LinkedIn and update the account record. If >20% change, trigger ICP rescore and note growth trajectory for QBR discussion.

5. **BEFORE QBR -- Complete Missing Fields:** Fill remaining gaps (LinkedIn URL, HQ, revenue estimate, legal name, website) to bring the record to full completeness for the QBR.

---

## 6. ENRICHMENT SUMMARY

| Dimension | Status |
|-----------|--------|
| Contact fields updated | 1 verified, 2 flagged for change, 3 need manual work |
| Account fields updated | 0 verified, 5 need manual verification post-Series B |
| Data protected | Direct phone (human-entered), nurture sequence (active) |
| Funding event captured | Series B flagged -- details need verification and entry |
| Headcount change flag | >20% likely -- triggers ICP rescore |
| Title change flag | Likely promotion -- do not use stale title in outreach |
| Overall data quality | 27% fully verified -- significant manual work remains |

**Bottom line:** This record was severely stale. Automated enrichment has flagged the key changes (probable title change, Series B funding, headcount growth) but cannot safely update most fields without manual verification -- especially given the active nurture sequence and human-entered phone number. Jess Moreno needs to manually verify and complete 8 of 11 mandatory fields before this record is QBR-ready.

---

ALL OUTREACH OUTPUTS REQUIRE HUMAN REVIEW BEFORE SENDING.
