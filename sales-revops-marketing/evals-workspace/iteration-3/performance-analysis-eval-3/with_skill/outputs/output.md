TASK:          Performance Analysis -- Landing Page A/B Test Results (2-Week Test)
ICP MATCH:     UNVERIFIED
CONFIGURATION: Not configured
VERIFY DATA:   All prospect data should be verified before outreach

================================================================
CAMPAIGN PERFORMANCE ANALYSIS -- Landing Page A/B Test Review
Generated: 2026-03-12 | Test: Lead Gen Landing Page, Variant A vs. Variant B
================================================================

## HEADLINE NUMBERS -- TEST RESULTS

| Metric | Variant A (Control) | Variant B (Challenger) | Benchmark |
|--------|-------------------|----------------------|-----------|
| Visitors | 1,247 | 1,253 | -- |
| Form Submissions | 112 | 198 | -- |
| Conversion Rate | 8.98% | 15.80% | 10-20% average |
| Avg Time on Page | 1:42 | 2:18 | -- |
| Bounce Rate | 61% | 44% | -- |
| Form Fields | 7 | 4 | -- |
| Post-Submission MQL Rate | 34% | 19% | -- |

### THE NUMBER THAT ACTUALLY MATTERS: MQL YIELD PER VISITOR

- **Variant A:** 8.98% conversion x 34% MQL rate = **3.05% effective MQL yield** = ~79 MQLs/month at 2,600 visitors
- **Variant B:** 15.80% conversion x 19% MQL rate = **3.00% effective MQL yield** = ~78 MQLs/month at 2,600 visitors
- **Target:** 80 MQLs/month

**Neither variant hits the 80 MQL/month target.** The raw conversion lift in Variant B produces zero net gain in qualified pipeline. The team is debating which winner to ship from two losing options.

================================================================

## LAYER 1 -- ARE WE ON TRACK?

### Conversion Rate vs. Benchmark

- **Variant A (8.98%):** Below average tier. Benchmark: 10-20% average. Variant A sits below the average floor and is approaching the <5% poor tier. This page is underperforming.
- **Variant B (15.80%):** Average-to-good tier. Benchmark: 10-20% average, 25% good. Variant B sits solidly within the average range, approaching good tier. The UX redesign genuinely improved conversion performance.

**Classification:** Variant B is a real improvement on conversion rate, moving the page from below-average to mid-average. This is not a vanity metric improvement -- it reflects genuine UX gains.

### MQL Target

- **Target:** 80 MQLs/month from this page
- **Variant A projection:** 2,600 visitors x 8.98% x 34% = **79.4 MQLs/month** -- AT RISK (just barely below target, no margin)
- **Variant B projection:** 2,600 visitors x 15.80% x 19% = **78.2 MQLs/month** -- AT RISK (further below target despite higher conversion)

**Both variants are AT RISK for the 80 MQL target.** Variant A technically gets closer (79.4 vs. 78.2) but neither provides any buffer. A single bad traffic week puts either variant below target.

### The Decision Framework

The team is asking the wrong question. "Which variant should we ship?" assumes one of the two options is the answer. Neither is. The correct question is: **"How do we get the conversion gains of Variant B without losing the qualification signal of Variant A?"**

================================================================

## LAYER 2 -- WHY? (Root Cause Analysis)

### 1. WHY DID VARIANT B'S MQL RATE DROP FROM 34% TO 19%?

**Pattern:** Variant B removed 3 form fields: phone, company size, and use case. Conversion rate nearly doubled (8.98% to 15.80%). MQL rate dropped by 44% (34% to 19%).

**Root Cause:** The three removed fields -- phone, company size, and use case -- served a dual purpose. They were not just data collection fields; they were **qualification filters**. Specifically:

- **Company size:** This field directly maps to ICP fit. A prospect who enters "15 employees" is immediately identifiable as outside a mid-market ICP. Without this field, all company sizes convert equally, and the MQL scoring system loses a critical input. Leads that would have self-selected out (or been scored low instantly) are now flowing into the MQL pipeline.

- **Use case:** This field revealed intent quality. A prospect who writes "just researching" or "academic project" is qualitatively different from one who writes "evaluating vendors for Q2 implementation." Removing this field eliminates the clearest signal of purchase intent available at the form level.

- **Phone number:** This field acted as a **friction-based quality filter.** Prospects willing to provide a phone number are signaling higher commitment to a conversation. Those who abandon at the phone field are disproportionately lower-intent. By removing it, Variant B captured the entire low-intent cohort that Variant A's friction filtered out.

**The core insight:** Variant A's lower conversion rate was partly a feature, not a bug. The form friction was doing qualification work. Variant B removed the friction and the qualification simultaneously. The result is a volume increase that exactly offsets the quality decrease -- producing identical MQL output.

### 2. WHY IS VARIANT B'S BOUNCE RATE LOWER AND TIME-ON-PAGE HIGHER?

**Pattern:** Variant B bounce rate: 44% vs. Variant A: 61%. Variant B time-on-page: 2:18 vs. Variant A: 1:42.

**Root Cause:** These improvements reflect genuine UX and design gains in Variant B, independent of the form field question. Possible contributors:

- Better visual hierarchy and page layout that encourages scrolling
- More compelling above-the-fold content that reduces immediate exits
- Clearer value proposition that holds attention longer
- Shorter form that is visible without scrolling, reducing the "I'll come back later" abandonment

These are real engagement improvements. The Variant B design is objectively better at capturing and holding visitor attention. **This is worth preserving regardless of which form configuration we choose.**

### 3. WHY NEITHER VARIANT HITS 80 MQLs

**Pattern:** At 2,600 monthly visitors, the math requires a 3.08% effective MQL yield (80 / 2,600) to hit target. Variant A delivers 3.05%. Variant B delivers 3.00%. Both are within rounding error of the target but neither provides margin.

**Root Cause:** The page is traffic-constrained and yield-constrained simultaneously. At current traffic levels, even a perfect conversion rate cannot compensate for a low MQL rate (and vice versa). The fundamental constraint is that **the page needs either more qualified traffic or a higher MQL yield per conversion -- preferably both.**

================================================================

## LAYER 3 -- WHAT TO DO (Specific Recommendations)

### TOP 3 OPTIMISATION OPPORTUNITIES

### 1. BUILD VARIANT C: VARIANT B'S DESIGN + PROGRESSIVE PROFILING

**Analysis:** Variant B's UX is superior (lower bounce, higher time-on-page, higher conversion). But the 4-field form loses the qualification data that drives MQL scoring. Shipping either A or B as-is fails to hit 80 MQLs/month.

**Diagnosis:** The form field trade-off is a false binary. The solution is to capture the UX gains of Variant B's short form while recovering the qualification data through a mechanism that does not add front-end friction.

**Change:** Build Variant C with the following specific design:

**Front-end form (4 fields -- same as Variant B):**
- Name
- Work email
- Company
- Job title

**Post-submission progressive profiling (thank-you page or inline after submission):**
Immediately after form submission, display a single-screen follow-up: "Help us prepare for your demo -- two quick questions:" with:
- Company size (dropdown: 1-50, 51-200, 201-1000, 1001-5000, 5000+)
- Primary use case (dropdown: 3-4 options reflecting actual ICP use cases + "Other")

Frame these as "help us personalise your experience" rather than mandatory qualification. Make them optional but prominent. Industry data shows 40-60% of post-submission respondents complete progressive profiling when it is framed as personalisation.

**Backend enrichment (for the 40-60% who skip progressive profiling):**
Integrate Clearbit Reveal, ZoomInfo, or equivalent on form submission trigger. Use the work email domain to auto-populate:
- Company size (from firmographic database)
- Industry
- Revenue range
- Technology stack (if relevant to ICP)

This gives the MQL scoring system the same data inputs it had with Variant A's 7-field form, without any of the front-end friction.

**Owner:** Marketing Ops (form build), Web Team (UX), RevOps (enrichment integration)

**Deadline:** Variant C spec completed within 3 days. Built and live within 10 days. Run as an A/B/C test or replace Variant B directly.

**Expected:**
- Conversion rate: 14-16% (preserving Variant B's UX gains, slight possible drop from progressive profiling prompt)
- MQL rate: 28-32% (recovering most of Variant A's qualification signal through enrichment + progressive profiling)
- Effective MQL yield: 14.5% x 30% = **4.35% = ~113 MQLs/month** -- well above the 80 MQL target
- Even at conservative estimates (13% conversion x 26% MQL rate = 3.38% yield = ~88 MQLs/month), Variant C exceeds target with margin

---

### 2. TRAFFIC QUALITY AUDIT -- ENSURE UPSTREAM SOURCES SEND ICP-FIT VISITORS

**Analysis:** At 2,600 monthly visitors, both variants are at the mathematical limit of their MQL yield. Increasing traffic quality (higher percentage of ICP-fit visitors) would improve MQL rates for any variant.

**Diagnosis:** If a significant portion of the 2,600 monthly visitors are non-ICP (wrong industry, wrong company size, wrong title), they convert on the form but never become MQLs. This dilutes the MQL rate regardless of form design.

**Change:** Audit the traffic sources feeding this landing page:
- What percentage of visitors come from LinkedIn ads (presumably targeted to ICP)?
- What percentage come from organic search (less targeted)?
- What percentage come from email campaigns (presumably to known contacts)?
- What percentage come from other/unknown sources?

For each source, calculate the source-specific conversion rate AND MQL rate. If organic search visitors have a 20% conversion rate but a 5% MQL rate, that traffic is inflating conversion metrics while dragging down MQL yield. The fix is to either: (a) create a separate landing page for non-ICP traffic with different qualification criteria, or (b) add targeting parameters to upstream campaigns to filter non-ICP visitors before they reach the page.

**Owner:** Demand Gen / Marketing Analytics

**Deadline:** Traffic audit completed within 1 week

**Expected:** Identifying and redirecting or filtering non-ICP traffic could improve MQL rate by 3-5 percentage points for both variants, adding 5-10 MQLs/month with zero additional spend.

---

### 3. A/B TEST THE PROGRESSIVE PROFILING STEP SEPARATELY

**Analysis:** The progressive profiling recommendation in Variant C introduces a new variable. If the profiling step is poorly designed, it could hurt conversion or provide low-quality data.

**Diagnosis:** Progressive profiling completion rates vary widely (40-80%) depending on design, framing, and timing. The specific design choices matter.

**Change:** Once Variant C is live, run a nested A/B test on the progressive profiling step:
- **Profiling Version 1:** Immediate inline display after form submission (same page, below confirmation message)
- **Profiling Version 2:** Separate thank-you page with profiling questions before the confirmation/resource delivery
- **Profiling Version 3:** Email-based profiling -- send a one-question email within 1 hour of submission ("Quick question to prepare for your demo: what's your team size?")

Track: profiling completion rate, data accuracy (compare self-reported company size vs. enrichment data), and whether the profiling step causes any drop in downstream engagement (demo show rate, email open rate).

**Owner:** Marketing Ops

**Deadline:** Nested test designed alongside Variant C, launched 1 week after Variant C goes live

**Expected:** Identifying the highest-completion profiling method optimises the MQL rate recovery. Target: >55% profiling completion rate.

================================================================

## WHAT IS WORKING -- DO NOT CHANGE

### 1. Variant B's Page Design and UX -- PRESERVE IN ANY FUTURE VARIANT
Variant B's lower bounce rate (44% vs. 61%) and higher time-on-page (2:18 vs. 1:42) represent genuine engagement improvements that are independent of the form field question. The page design, visual hierarchy, above-the-fold content, and layout should carry forward into Variant C and all future iterations. **Do not revert to Variant A's page design.** The UX improvements are real and measurable.

### 2. Variant B's 4-Field Front-End Form -- PRESERVE AS THE PRIMARY CONVERSION MECHANISM
The 4-field form (name, work email, company, title) is the right front-end experience. It reduces friction, increases conversion, and captures the minimum viable data for a first touch. **Do not add fields back to the front-end form.** Recover qualification data through progressive profiling and backend enrichment, not front-end friction.

### 3. Variant A's MQL Scoring Logic -- PRESERVE THE QUALIFICATION CRITERIA
Variant A's 34% MQL rate reflects a scoring model that correctly identifies qualified leads. The scoring criteria are not the problem -- the data input to the scoring model is the problem (missing company size and use case). **Do not lower MQL scoring thresholds** to artificially increase MQL rates on Variant B's leads. That would push unqualified leads to sales and damage the MQL-to-SAL conversion rate.

### 4. The A/B Testing Discipline -- PRESERVE THE PROCESS
The team ran a well-structured A/B test: similar sample sizes (1,247 vs. 1,253), 2-week duration, clear metrics tracked. The fact that the team is debating the results rather than blindly shipping the "winner" shows good analytical instinct. **Do not skip testing for Variant C.** Run it as a proper test with defined success criteria before full deployment.

### 5. Traffic Volume (2,600/month) -- PRESERVE CURRENT TRAFFIC GENERATION
At 2,600 monthly visitors, the page has enough traffic to run meaningful tests and generate near-target MQL volume. **Do not reduce upstream marketing activity** while optimising the page. The page optimisation and traffic generation should run in parallel, not sequentially.

================================================================

## DECISION RECOMMENDATION

**Do not ship either Variant A or Variant B.** Neither hits the 80 MQL/month target. Instead:

1. **Keep Variant B live as the default** (it has better UX metrics and nearly identical MQL yield to Variant A -- no reason to revert to the worse user experience)
2. **Build Variant C** (Variant B design + progressive profiling + backend enrichment) within 10 days
3. **Run Variant C as the new challenger** against Variant B for 2 weeks
4. **Success criteria for Variant C:** conversion rate >13%, MQL rate >26%, effective MQL yield >3.4% (= >88 MQLs/month)

The projected math for Variant C:
- Conservative: 13% conversion x 26% MQL = 3.38% yield = **88 MQLs/month** (exceeds target by 10%)
- Expected: 14.5% conversion x 30% MQL = 4.35% yield = **113 MQLs/month** (exceeds target by 41%)
- Optimistic: 15.5% conversion x 33% MQL = 5.12% yield = **133 MQLs/month** (exceeds target by 66%)

Even the conservative estimate exceeds the 80 MQL target with margin, making Variant C the clear path forward.

================================================================

## ACTION PLAN

- [ ] Keep Variant B live as default page -- Marketing Ops -- effective immediately
- [ ] Spec Variant C: Variant B design + post-submission progressive profiling + backend enrichment integration -- Marketing Ops / Web Team -- by end of Day 3
- [ ] Select and configure enrichment provider (Clearbit Reveal, ZoomInfo, or equivalent) for form submission trigger -- RevOps -- by end of Day 5
- [ ] Build Variant C progressive profiling UX (dropdown company size + use case on thank-you page) -- Web Team -- by end of Day 7
- [ ] QA and launch Variant C as challenger to Variant B -- Marketing Ops -- by Day 10
- [ ] Audit traffic sources feeding the landing page (source-specific conversion + MQL rates) -- Marketing Analytics -- by end of Week 1
- [ ] Design nested A/B test for progressive profiling variants -- Marketing Ops -- by Day 10 (launch Day 14)
- [ ] Report Variant C results after 2-week test period -- Demand Gen -- Day 24

================================================================
