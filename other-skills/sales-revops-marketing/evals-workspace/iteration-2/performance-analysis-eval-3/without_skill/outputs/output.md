TASK:          Performance Analysis -- Landing Page A/B Test: Conversion vs. MQL Yield
ICP MATCH:     N/A (internal performance analysis)
CONFIGURATION: Not configured
VERIFY DATA:   All prospect data should be verified before outreach

---

# Landing Page A/B Test Analysis

## Executive Summary

The team is split because they're looking at the wrong metric. When you calculate the metric that actually matters -- **MQL yield per visitor** -- both variants produce nearly identical results. Neither variant hits the 80 MQL/month target. The recommendation is not to pick a winner from two losing options, but to build a Variant C that combines Variant B's UX improvements with a qualification data recovery mechanism.

---

## 1. The Metric That Matters: Effective MQL Yield

Raw conversion rate is a vanity metric when MQL rate differs between variants. The metric that connects to pipeline is **effective MQL yield per visitor** -- the percentage of all visitors who ultimately become MQLs.

| Metric | Variant A (Control) | Variant B (Challenger) |
|--------|-------------------|----------------------|
| Visitors | 1,247 | 1,253 |
| Form submissions | 112 | 198 |
| Conversion rate | 8.98% | 15.80% |
| Post-submission MQL rate | 34% | 19% |
| **Effective MQL yield** | **8.98% x 34% = 3.05%** | **15.80% x 19% = 3.00%** |
| MQLs from test period | ~38 | ~38 |
| **Projected monthly MQLs (2,600 visitors)** | **~79 MQLs** | **~78 MQLs** |

**The raw conversion lift of +76% (8.98% to 15.80%) produces zero net gain in qualified pipeline.** Variant B gets nearly twice the form submissions, but only about half of them qualify. The MQL yield per visitor is effectively identical: 3.05% vs. 3.00%.

---

## 2. Target Assessment: Neither Variant Hits 80 MQLs/Month

| Variant | Projected Monthly MQLs | Target | Gap |
|---------|----------------------|--------|-----|
| A | ~79 | 80 | -1 (borderline miss) |
| B | ~78 | 80 | -2 (borderline miss) |

Both variants fall marginally short of the 80 MQL/month target at current traffic levels (~2,600 visitors/month). **Neither variant solves the business problem.** Picking either one and shipping it means accepting that the page will consistently miss target, and the team will be back here in a month asking why.

The decision should not be "A or B?" It should be: "How do we build something that actually hits 80?"

---

## 3. Root Cause Analysis: Why the MQL Rate Dropped

Variant B reduced the form from 7 fields to 4, removing:
- **Company size** (removed)
- **Use case** (removed)
- **Phone** (removed)

The conversion rate increase is a direct result of lower form friction -- fewer fields means more people complete the form. This is a well-documented UX pattern.

**The MQL rate drop is also a direct result of the field reduction.** Company size and use case are the two fields that carry the strongest qualification signal. Without them:
- Leads that would have self-disqualified by revealing they're too small or outside ICP now submit freely
- The MQL scoring model loses two of its most predictive inputs
- The team must either qualify leads manually (adding SDR cost) or accept a lower MQL rate

The form reduction increased volume but removed the data that separates qualified from unqualified leads. The conversion lift is real, but it's capturing low-quality volume that doesn't convert downstream.

---

## 4. Industry Benchmark Context

Landing page conversion rate benchmarks (B2B lead gen): **10-20% is average to good.**

| Variant | Conversion Rate | Benchmark Classification |
|---------|----------------|------------------------|
| A (Control) | 8.98% | **Below average** -- underperforming the 10% floor |
| B (Challenger) | 15.80% | **Average to good** -- solid performance within the benchmark range |

This context matters: Variant B's conversion rate improvement is real and meaningful. The page design, copy, and UX changes that lifted conversion from below-average to mid-range are genuine improvements -- the problem is not the conversion rate, it's the loss of qualification data.

---

## 5. UX Gains Worth Preserving

Regardless of which variant ships, Variant B demonstrated clear engagement improvements that should carry forward:

| Metric | Variant A | Variant B | Improvement |
|--------|-----------|-----------|-------------|
| Bounce rate | 61% | 44% | -17 percentage points (28% relative improvement) |
| Avg time on page | 1:42 | 2:18 | +36 seconds (35% relative improvement) |

These are significant engagement signals:
- **Lower bounce rate (44% vs. 61%):** More visitors are engaging with the page rather than leaving immediately. This indicates better above-the-fold messaging, clearer value proposition, or improved page design.
- **Higher time on page (2:18 vs. 1:42):** Visitors are spending more time reading and considering the offer. This suggests the content is more compelling.

These UX improvements are real design wins and should be preserved in any future variant.

---

## 6. Recommendation: Build Variant C

**Variant C specification:** Variant B's 4-field form (name, work email, company, title) combined with a qualification data recovery mechanism.

### Option 1: Progressive Profiling on Thank-You Page (Recommended)

After the 4-field form submission, the thank-you page asks 2 optional questions:
- "How many employees at your company?" (company size)
- "What's your primary use case?" (use case dropdown)

Frame these as "help us personalize your experience" rather than mandatory qualification. Expected completion rate on post-submission progressive profiling: 40-60% (visitors who just converted are in a compliant state).

**Projected MQL yield:**
- Base conversion rate: 15.80% (Variant B's proven rate)
- Progressive profiling completion: ~50% (conservative estimate)
- MQL rate on profiled leads: ~34% (matching Variant A, since you now have qualification data)
- MQL rate on unprofiled leads: ~19% (matching Variant B)
- Blended MQL rate: (50% x 34%) + (50% x 19%) = 26.5%
- **Effective MQL yield: 15.80% x 26.5% = 4.19%**
- **Projected monthly MQLs: 2,600 x 4.19% = ~109 MQLs**

This exceeds the 80 MQL target by 36%.

### Option 2: Backend Enrichment (Clearbit / ZoomInfo / Apollo)

Enrich company size and use case signal automatically via a third-party data enrichment tool after form submission. No additional form friction for the visitor.

**Projected MQL yield:**
- Base conversion rate: 15.80%
- Enrichment match rate: ~70-80% on work emails
- MQL rate on enriched leads: ~30-34% (slightly lower than self-reported because enrichment misses use case intent)
- MQL rate on unenriched leads: ~19%
- Blended MQL rate: (75% x 32%) + (25% x 19%) = 28.75%
- **Effective MQL yield: 15.80% x 28.75% = 4.54%**
- **Projected monthly MQLs: 2,600 x 4.54% = ~118 MQLs**

**Cost consideration:** Enrichment tools typically cost $0.10-0.50 per record lookup. At ~411 form submissions/month (15.80% of 2,600), that's $41-$206/month -- easily justified against the pipeline value of 30+ additional MQLs.

### Recommendation: Implement Option 1 (progressive profiling) first, add Option 2 (backend enrichment) for any leads that skip the progressive profiling questions. This belt-and-suspenders approach maximizes MQL recovery while preserving the low-friction form that drives Variant B's conversion rate.

---

## 7. What NOT to Do

- **Do not ship Variant A.** Its conversion rate is below industry average (8.98% vs. 10-20% benchmark), and it barely hits the MQL target. There is no margin for traffic fluctuation.
- **Do not ship Variant B as-is.** The MQL rate drop exactly offsets the conversion gain. You'd be shipping a nicer-looking page that produces the same pipeline output.
- **Do not add fields back to Variant B's form.** This would regress the conversion and engagement improvements. The goal is to keep the low-friction form and recover qualification data through other means.
- **Do not increase traffic to compensate.** At ~3.0% MQL yield, you'd need ~2,667 visitors/month just to hit 80 MQLs -- only marginally above current traffic. The math doesn't work with either variant; you need a higher MQL yield, not more visitors at the same yield.

---

ALL OUTREACH OUTPUTS REQUIRE HUMAN REVIEW BEFORE SENDING.
