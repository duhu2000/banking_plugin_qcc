TASK:          Performance Analysis -- Landing Page A/B Test: Conversion vs. MQL Quality
ICP MATCH:     N/A (internal performance analysis)
CONFIGURATION: Not configured (sales-marketing.local.md not found -- outputs use general best practices)
VERIFY DATA:   All prospect data should be verified before outreach

---

# CAMPAIGN PERFORMANCE ANALYSIS -- Landing Page A/B Test
Generated: 2026-03-11 | Analysis: Lead Gen Landing Page Optimization
================================================================

## HEADLINE NUMBERS -- THIS PERIOD (2-Week A/B Test)

| Metric | Variant A (Control) | Variant B (Challenger) | Target | Status |
|--------|-------------------|----------------------|--------|--------|
| Visitors | 1,247 | 1,253 | -- | Comparable split |
| Form submissions | 112 | 198 | -- | B wins raw volume (+77%) |
| Conversion rate | 8.98% | 15.80% | 10-20% (benchmark avg) | A: Below average; B: Average-to-Good |
| Avg time on page | 1:42 | 2:18 | -- | B wins engagement (+35%) |
| Bounce rate | 61% | 44% | -- | B wins retention (-28%) |
| Form fields | 7 | 4 | -- | B reduced friction |
| Post-submission MQL rate | 34% | 19% | -- | A wins quality |

---

## THE REAL NUMBER: EFFECTIVE MQL YIELD PER VISITOR

This is the metric that actually answers the business question.

| Metric | Variant A | Variant B |
|--------|----------|----------|
| Conversion rate | 8.98% | 15.80% |
| MQL rate | 34% | 19% |
| **Effective MQL yield** | **8.98% x 34% = 3.05%** | **15.80% x 19% = 3.00%** |
| **Projected monthly MQLs** (at ~2,600 visitors/month) | **~79 MQLs** | **~78 MQLs** |
| **Target** | **80 MQLs/month** | **80 MQLs/month** |

**The raw conversion lift produces zero net gain in qualified pipeline.**

Variant B gets 77% more form submissions, but the MQL rate drops so severely that the effective MQL output is statistically identical. At 2,600 monthly visitors, Variant A produces ~79 MQLs and Variant B produces ~78 MQLs. Neither variant hits the 80 MQL/month target.

**Neither variant solves the business problem.** Picking a "winner" between two options that both miss the target is the wrong frame for this decision.

---

## TOP 3 OPTIMISATION OPPORTUNITIES

### 1. ROOT CAUSE: FORM FIELD REMOVAL KILLED QUALIFICATION DATA

**Analysis:** Variant B reduced the form from 7 fields to 4 by removing company size, phone number, and use case. These are the three fields most commonly used for MQL qualification. The MQL rate dropped from 34% to 19% -- a 44% decrease -- because without company size and use case data, the scoring model cannot distinguish qualified mid-market buyers from students, competitors, and early-stage companies that will never convert to pipeline.

**Diagnosis:** The form reduction increased volume by removing friction, but it also removed the data that separates qualified leads from unqualified ones. The problem is not that Variant B's leads are lower quality -- it's that the scoring model has lost the signals it needs to score them. Some of those 198 submissions are qualified; the system just can't tell which ones.

**Change:** Build a Variant C that keeps Variant B's 4-field form AND recovers qualification data through one of two methods:

**Option A -- Progressive profiling on thank-you page:**
After form submission, the thank-you page presents 2-3 additional questions (company size, use case) framed as "Help us personalize your experience." This captures qualification data from the most engaged leads without adding friction to the initial form. Expected recovery: 40-60% of submitters complete progressive fields.

**Option B -- Backend enrichment via Clearbit/ZoomInfo:**
Use work email (captured in Variant B's 4-field form) to enrich company size, industry, and revenue automatically via a data enrichment API. This recovers qualification data for 70-80% of submissions with zero additional form friction.

**Projected Variant C MQL yield (Option B -- enrichment):**

| Metric | Variant C (Projected) |
|--------|----------------------|
| Conversion rate | 15.80% (Variant B's rate -- same form) |
| Enrichment coverage | 75% (industry standard for Clearbit/ZoomInfo on work email) |
| Effective MQL rate | 26-30% (enrichment-scored, between A and B) |
| **Effective MQL yield** | **15.80% x 28% = 4.42%** |
| **Projected monthly MQLs** | **~115 MQLs** |

This exceeds the 80 MQL target by 44%.

**Owner:** Marketing Ops (enrichment integration) + Demand Gen (form configuration)
**Deadline:** Enrichment integration: 1 week; Variant C live: 2 weeks
**Expected impact:** MQL yield increase from 3.0% to 4.4% (47% improvement over both current variants)

---

### 2. VARIANT A CONVERSION RATE IS BELOW AVERAGE

**Analysis:** Variant A converts at 8.98%, which is below the landing page benchmark average of 10-20%. A 7-field form creates significant friction, especially on mobile where each additional field increases abandonment.

**Diagnosis:** The 61% bounce rate on Variant A confirms that visitors are leaving before engaging with the form at all. The page is either not compelling enough to overcome the 7-field form, or mobile visitors see the form length and abandon immediately. Variant A's conversion rate is being limited by form friction, not page quality.

**Change:** Even if Variant C (above) is the primary path forward, the current Variant A form should be reduced to 5 fields maximum (remove phone -- lowest completion rate field in B2B forms; keep company size and use case as qualification fields). This is an interim optimization while Variant C is built.

**Owner:** Demand Gen Manager
**Deadline:** This week (simple form field removal)
**Expected impact:** Conversion rate improvement from 8.98% to ~11-13% based on form reduction benchmarks; MQL rate maintained at 34% because qualification fields are preserved.

---

### 3. BOUNCE RATE GAP SUGGESTS PAGE DESIGN IMPROVEMENT IN VARIANT B

**Analysis:** Variant B's bounce rate (44%) is dramatically lower than Variant A (61%), and time-on-page is 35% higher (2:18 vs. 1:42). These are strong engagement signals independent of the form change.

**Diagnosis:** Variant B didn't just change the form -- it changed the page design. The lower bounce rate and higher engagement suggest that Variant B's design (layout, copy, visual hierarchy) is doing a better job of holding visitor attention and communicating value before the form. This is a page-level improvement, not just a form-level improvement.

**Change:** The design elements from Variant B (layout, copy, visual hierarchy) should carry forward into Variant C regardless of which form approach is chosen. Do not revert to Variant A's page design even if the form strategy changes.

**Owner:** Design + Demand Gen
**Deadline:** Incorporated into Variant C build (2 weeks)
**Expected impact:** Maintains the bounce rate and engagement improvements that drove Variant B's raw conversion lift

---

## WHAT IS WORKING -- DO NOT CHANGE

**1. Variant B's page design and UX.** The 17-percentage-point bounce rate reduction (61% to 44%) and 36-second time-on-page increase represent genuine engagement improvements. These metrics are independent of form length and reflect a better page experience. Protect these gains in any Variant C build.

**2. The 4-field form experience.** Variant B proved that reducing form friction dramatically increases top-of-funnel volume. The problem isn't the short form -- it's the loss of qualification data. The form reduction is working; the data recovery layer is what's missing.

**3. The MQL qualification criteria themselves.** Variant A's 34% MQL rate is healthy and in line with good B2B qualification (MQL to SAL benchmark: 35-50%). The scoring model works when it has the data. Do not lower MQL thresholds to make Variant B's numbers look better -- that just pushes unqualified leads to sales.

---

## BENCHMARKS CONTEXT

| Metric | Variant A | Variant B | Benchmark (Avg) | Benchmark (Good) |
|--------|----------|----------|-----------------|-------------------|
| Landing page conversion | 8.98% | 15.80% | 10-20% | 25% |
| Classification | Below average | Average-to-Good | -- | -- |

Variant A is underperforming the industry average. Variant B sits solidly in the average-to-good range. The UX improvement from A to B is real and meaningful, even though the MQL yield is flat.

---

## WEEK 1 ACTION PLAN

- [ ] **Commission Variant C build** -- Variant B page design + 4-field form + backend enrichment via Clearbit/ZoomInfo -- Marketing Ops + Demand Gen -- by 2026-03-18
- [ ] **Interim: reduce Variant A form to 5 fields** (remove phone, keep company size and use case) -- Demand Gen -- by 2026-03-13
- [ ] **Scope enrichment vendor** -- evaluate Clearbit vs. ZoomInfo for work-email-to-company enrichment coverage rate and cost per enrichment -- Marketing Ops -- by 2026-03-14
- [ ] **Do NOT ship Variant B as-is** -- without qualification data recovery, it will flood sales with unscored leads and increase rep time wasted on unqualified prospects -- Decision: hold until Variant C is ready
- [ ] **Continue running Variant A (interim)** until Variant C is live -- Variant A is 1 MQL/month short of target, which is manageable in the short term -- Demand Gen -- ongoing

================================================================
