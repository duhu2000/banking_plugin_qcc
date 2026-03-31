# IDFA-Compliant 5-Year SaaS Revenue Model — Full Specification

**Methodology:** Intent-Driven Financial Architecture (IDFA), Panaversity
**Date:** 2026-03-11
**Task:** Build a 5-year SaaS revenue model from scratch
**Status:** Specification complete — ready for Excel implementation

---

## Intent Statement

> "Build a 5-year SaaS revenue model. Year 1 begins with 500 customers paying
> $200/month each. Customer base grows 20% year-over-year. Prices increase 5%
> annually. Monthly churn is 2%. The model must separate customer dynamics
> (acquisition, retention, churn) from revenue calculations, and follow all
> four IDFA guardrails."

---

## Model Architecture — Three Layers

### Layer 1: Assumptions (Inputs Only)

All user-modifiable inputs. No calculations. Every value has a Named Range
prefixed with `Inp_`.

### Layer 2: Calculations (Logic Only)

All formulas reference Named Ranges exclusively — zero cell-address references.
Organized into four calculation blocks:
1. Customer Dynamics (churn, retention, growth, acquisition)
2. Pricing
3. Revenue
4. Summary Metrics

### Layer 3: Output (Presentation Only)

Dashboard tables and charts that read from Layer 2. No calculations. Not
specified here — the Layer 2 Named Ranges are the complete data source.

---

## Modeling Decision: Churn Mechanics

Monthly churn of 2% is structurally significant. Over 12 months, the
annual retention rate is:

$$R_{annual} = (1 - c_{monthly})^{12} = (1 - 0.02)^{12} \approx 0.7847$$

This means only ~78.5% of beginning-of-year customers survive to year-end
through retention alone. The 20% YoY customer growth target applies to the
**ending customer count** — meaning the business must acquire enough new
customers to both replace churned customers AND achieve 20% net growth.

**Customer count for revenue purposes:** Because customers churn continuously
throughout the year, using either beginning-of-year or end-of-year counts
would over- or under-state revenue. The model uses the **average of beginning
and ending customers** for each year as the basis for Monthly Recurring
Revenue (MRR) calculations. This is a standard SaaS modeling convention.

**Year 1 baseline:** The 500 customers is treated as the beginning-of-year
count. End-of-Year 1 customers are determined by the 20% growth target
applied to this starting base (i.e., EOY1 = 500 * 1.20 = 600).

---

## Layer 1 — Assumptions (Named Ranges)

| # | Named Range | Value | Description |
|---|-------------|-------|-------------|
| 1 | `Inp_Customers_Start` | 500 | Starting customer count (beginning of Year 1) |
| 2 | `Inp_Price_Monthly_Start` | 200 | Monthly subscription price per customer (Year 1, in $) |
| 3 | `Inp_Customer_Growth_Rate` | 0.20 | Annual customer growth rate (YoY, applied to ending count) |
| 4 | `Inp_Price_Increase_Rate` | 0.05 | Annual price increase rate |
| 5 | `Inp_Churn_Monthly` | 0.02 | Monthly customer churn rate |
| 6 | `Inp_Months_Per_Year` | 12 | Months in a year (structural constant) |

**Count:** 6 input assumptions. All constants live here — no hardcoded values
anywhere in Layer 2.

---

## Layer 2 — Calculations (Named Ranges and Formulas)

### Block A: Retention Dynamics

These derived rates are calculated once and reused across all years.

| # | Named Range | Formula | Intent |
|---|-------------|---------|--------|
| 7 | `Retention_Monthly` | `= 1 - Inp_Churn_Monthly` | Monthly retention rate (complement of churn) |
| 8 | `Retention_Annual` | `= Retention_Monthly ^ Inp_Months_Per_Year` | Annual retention rate — probability a customer survives 12 months |
| 9 | `Churn_Annual` | `= 1 - Retention_Annual` | Annual churn rate (complement of annual retention) |

**LaTeX Verification:**

$$r_{monthly} = 1 - c_{monthly}$$

$$r_{annual} = r_{monthly}^{12} = (1 - c_{monthly})^{12}$$

$$c_{annual} = 1 - r_{annual}$$

---

### Block B: Customer Dynamics (Years 1-5)

Customer flow per year: Beginning customers survive churn, new customers are
acquired to hit the growth target, and the average is used for revenue.

#### Year 1

| # | Named Range | Formula | Intent |
|---|-------------|---------|--------|
| 10 | `Customers_BOY_Y1` | `= Inp_Customers_Start` | Beginning-of-year customers, Year 1 |
| 11 | `Customers_EOY_Y1` | `= Customers_BOY_Y1 * (1 + Inp_Customer_Growth_Rate)` | End-of-year customers, Year 1 (20% growth target) |
| 12 | `Customers_Retained_Y1` | `= Customers_BOY_Y1 * Retention_Annual` | Customers from BOY cohort surviving 12 months of churn |
| 13 | `Customers_New_Y1` | `= Customers_EOY_Y1 - Customers_Retained_Y1` | New customers acquired during Year 1 to hit EOY target |
| 14 | `Customers_Avg_Y1` | `= (Customers_BOY_Y1 + Customers_EOY_Y1) / 2` | Average customer count for revenue calculation |

#### Year 2

| # | Named Range | Formula | Intent |
|---|-------------|---------|--------|
| 15 | `Customers_BOY_Y2` | `= Customers_EOY_Y1` | Beginning-of-year = prior year's ending count |
| 16 | `Customers_EOY_Y2` | `= Customers_BOY_Y2 * (1 + Inp_Customer_Growth_Rate)` | End-of-year customers, Year 2 |
| 17 | `Customers_Retained_Y2` | `= Customers_BOY_Y2 * Retention_Annual` | Retained from BOY cohort after 12 months |
| 18 | `Customers_New_Y2` | `= Customers_EOY_Y2 - Customers_Retained_Y2` | New customers required in Year 2 |
| 19 | `Customers_Avg_Y2` | `= (Customers_BOY_Y2 + Customers_EOY_Y2) / 2` | Average customers, Year 2 |

#### Year 3

| # | Named Range | Formula | Intent |
|---|-------------|---------|--------|
| 20 | `Customers_BOY_Y3` | `= Customers_EOY_Y2` | Beginning-of-year = prior year's ending count |
| 21 | `Customers_EOY_Y3` | `= Customers_BOY_Y3 * (1 + Inp_Customer_Growth_Rate)` | End-of-year customers, Year 3 |
| 22 | `Customers_Retained_Y3` | `= Customers_BOY_Y3 * Retention_Annual` | Retained from BOY cohort after 12 months |
| 23 | `Customers_New_Y3` | `= Customers_EOY_Y3 - Customers_Retained_Y3` | New customers required in Year 3 |
| 24 | `Customers_Avg_Y3` | `= (Customers_BOY_Y3 + Customers_EOY_Y3) / 2` | Average customers, Year 3 |

#### Year 4

| # | Named Range | Formula | Intent |
|---|-------------|---------|--------|
| 25 | `Customers_BOY_Y4` | `= Customers_EOY_Y3` | Beginning-of-year = prior year's ending count |
| 26 | `Customers_EOY_Y4` | `= Customers_BOY_Y4 * (1 + Inp_Customer_Growth_Rate)` | End-of-year customers, Year 4 |
| 27 | `Customers_Retained_Y4` | `= Customers_BOY_Y4 * Retention_Annual` | Retained from BOY cohort after 12 months |
| 28 | `Customers_New_Y4` | `= Customers_EOY_Y4 - Customers_Retained_Y4` | New customers required in Year 4 |
| 29 | `Customers_Avg_Y4` | `= (Customers_BOY_Y4 + Customers_EOY_Y4) / 2` | Average customers, Year 4 |

#### Year 5

| # | Named Range | Formula | Intent |
|---|-------------|---------|--------|
| 30 | `Customers_BOY_Y5` | `= Customers_EOY_Y4` | Beginning-of-year = prior year's ending count |
| 31 | `Customers_EOY_Y5` | `= Customers_BOY_Y5 * (1 + Inp_Customer_Growth_Rate)` | End-of-year customers, Year 5 |
| 32 | `Customers_Retained_Y5` | `= Customers_BOY_Y5 * Retention_Annual` | Retained from BOY cohort after 12 months |
| 33 | `Customers_New_Y5` | `= Customers_EOY_Y5 - Customers_Retained_Y5` | New customers required in Year 5 |
| 34 | `Customers_Avg_Y5` | `= (Customers_BOY_Y5 + Customers_EOY_Y5) / 2` | Average customers, Year 5 |

**LaTeX Verification — Customer Dynamics:**

$$BOY_n = EOY_{n-1}, \quad BOY_1 = C_0$$

$$EOY_n = BOY_n \times (1 + g)$$

$$Retained_n = BOY_n \times r_{annual} = BOY_n \times (1 - c_{monthly})^{12}$$

$$New_n = EOY_n - Retained_n$$

$$\overline{C}_n = \frac{BOY_n + EOY_n}{2}$$

All verified: customer identities hold (EOY = Retained + New). Growth rate
applies to total ending count. Average is arithmetic mean of endpoints.

---

### Block C: Pricing (Years 1-5)

Monthly subscription price, compounding 5% annually.

| # | Named Range | Formula | Intent |
|---|-------------|---------|--------|
| 35 | `Price_Monthly_Y1` | `= Inp_Price_Monthly_Start` | Monthly price, Year 1 |
| 36 | `Price_Monthly_Y2` | `= Price_Monthly_Y1 * (1 + Inp_Price_Increase_Rate)` | Monthly price, Year 2 (5% increase) |
| 37 | `Price_Monthly_Y3` | `= Price_Monthly_Y2 * (1 + Inp_Price_Increase_Rate)` | Monthly price, Year 3 |
| 38 | `Price_Monthly_Y4` | `= Price_Monthly_Y3 * (1 + Inp_Price_Increase_Rate)` | Monthly price, Year 4 |
| 39 | `Price_Monthly_Y5` | `= Price_Monthly_Y4 * (1 + Inp_Price_Increase_Rate)` | Monthly price, Year 5 |

**LaTeX Verification:**

$$P_n = P_{n-1} \times (1 + i), \quad P_1 = P_0$$

Where $i$ = `Inp_Price_Increase_Rate`. Compound growth, verified.

---

### Block D: Revenue (Years 1-5)

Revenue = Average Customers * Monthly Price * 12 months. This is the Annual
Recurring Revenue (ARR) approximation using average customer counts.

| # | Named Range | Formula | Intent |
|---|-------------|---------|--------|
| 40 | `MRR_Y1` | `= Customers_Avg_Y1 * Price_Monthly_Y1` | Monthly Recurring Revenue, Year 1 (avg month) |
| 41 | `MRR_Y2` | `= Customers_Avg_Y2 * Price_Monthly_Y2` | Monthly Recurring Revenue, Year 2 |
| 42 | `MRR_Y3` | `= Customers_Avg_Y3 * Price_Monthly_Y3` | Monthly Recurring Revenue, Year 3 |
| 43 | `MRR_Y4` | `= Customers_Avg_Y4 * Price_Monthly_Y4` | Monthly Recurring Revenue, Year 4 |
| 44 | `MRR_Y5` | `= Customers_Avg_Y5 * Price_Monthly_Y5` | Monthly Recurring Revenue, Year 5 |
| 45 | `ARR_Y1` | `= MRR_Y1 * Inp_Months_Per_Year` | Annual Recurring Revenue, Year 1 |
| 46 | `ARR_Y2` | `= MRR_Y2 * Inp_Months_Per_Year` | Annual Recurring Revenue, Year 2 |
| 47 | `ARR_Y3` | `= MRR_Y3 * Inp_Months_Per_Year` | Annual Recurring Revenue, Year 3 |
| 48 | `ARR_Y4` | `= MRR_Y4 * Inp_Months_Per_Year` | Annual Recurring Revenue, Year 4 |
| 49 | `ARR_Y5` | `= MRR_Y5 * Inp_Months_Per_Year` | Annual Recurring Revenue, Year 5 |

**LaTeX Verification:**

$$MRR_n = \overline{C}_n \times P_n$$

$$ARR_n = MRR_n \times 12$$

Dimensional analysis: (customers) * ($/customer/month) * (months/year) = $/year. Correct.

---

### Block E: Growth and Summary Metrics

Year-over-year growth rates, cumulative revenue, and customer lifetime value.

| # | Named Range | Formula | Intent |
|---|-------------|---------|--------|
| 50 | `ARR_Growth_Pct_Y2` | `= (ARR_Y2 - ARR_Y1) / ARR_Y1` | ARR growth rate, Year 1 to Year 2 |
| 51 | `ARR_Growth_Pct_Y3` | `= (ARR_Y3 - ARR_Y2) / ARR_Y2` | ARR growth rate, Year 2 to Year 3 |
| 52 | `ARR_Growth_Pct_Y4` | `= (ARR_Y4 - ARR_Y3) / ARR_Y3` | ARR growth rate, Year 3 to Year 4 |
| 53 | `ARR_Growth_Pct_Y5` | `= (ARR_Y5 - ARR_Y4) / ARR_Y4` | ARR growth rate, Year 4 to Year 5 |
| 54 | `Revenue_Total_5Yr` | `= ARR_Y1 + ARR_Y2 + ARR_Y3 + ARR_Y4 + ARR_Y5` | Cumulative 5-year revenue |
| 55 | `Customers_New_Total` | `= Customers_New_Y1 + Customers_New_Y2 + Customers_New_Y3 + Customers_New_Y4 + Customers_New_Y5` | Total new customers acquired over 5 years |
| 56 | `Avg_Revenue_Per_Customer_Y1` | `= ARR_Y1 / Customers_Avg_Y1` | Average annual revenue per customer, Year 1 |
| 57 | `Avg_Revenue_Per_Customer_Y5` | `= ARR_Y5 / Customers_Avg_Y5` | Average annual revenue per customer, Year 5 |
| 58 | `Customer_Lifetime_Months` | `= 1 / Inp_Churn_Monthly` | Expected customer lifetime in months (inverse of monthly churn) |
| 59 | `LTV_Y1` | `= Price_Monthly_Y1 * Customer_Lifetime_Months` | Customer Lifetime Value based on Year 1 pricing |

**LaTeX Verification — LTV:**

$$Lifetime = \frac{1}{c_{monthly}}$$

$$LTV = P_1 \times \frac{1}{c_{monthly}}$$

This is the simple LTV formula (no discount rate). At 2% monthly churn:
Lifetime = 1/0.02 = 50 months. LTV = $200 * 50 = $10,000. Verified.

---

## Named Range Registry — Complete Index

Total Named Ranges: **59**
- Layer 1 (Assumptions): 6 ranges (#1-6)
- Layer 2 (Calculations): 53 ranges (#7-59)

| # | Named Range | Layer | Block |
|---|-------------|-------|-------|
| 1 | `Inp_Customers_Start` | L1 | Assumptions |
| 2 | `Inp_Price_Monthly_Start` | L1 | Assumptions |
| 3 | `Inp_Customer_Growth_Rate` | L1 | Assumptions |
| 4 | `Inp_Price_Increase_Rate` | L1 | Assumptions |
| 5 | `Inp_Churn_Monthly` | L1 | Assumptions |
| 6 | `Inp_Months_Per_Year` | L1 | Assumptions |
| 7 | `Retention_Monthly` | L2 | A: Retention |
| 8 | `Retention_Annual` | L2 | A: Retention |
| 9 | `Churn_Annual` | L2 | A: Retention |
| 10-14 | `Customers_BOY_Y1` ... `Customers_Avg_Y1` | L2 | B: Customers Y1 |
| 15-19 | `Customers_BOY_Y2` ... `Customers_Avg_Y2` | L2 | B: Customers Y2 |
| 20-24 | `Customers_BOY_Y3` ... `Customers_Avg_Y3` | L2 | B: Customers Y3 |
| 25-29 | `Customers_BOY_Y4` ... `Customers_Avg_Y4` | L2 | B: Customers Y4 |
| 30-34 | `Customers_BOY_Y5` ... `Customers_Avg_Y5` | L2 | B: Customers Y5 |
| 35-39 | `Price_Monthly_Y1` ... `Price_Monthly_Y5` | L2 | C: Pricing |
| 40-44 | `MRR_Y1` ... `MRR_Y5` | L2 | D: Revenue (MRR) |
| 45-49 | `ARR_Y1` ... `ARR_Y5` | L2 | D: Revenue (ARR) |
| 50-53 | `ARR_Growth_Pct_Y2` ... `ARR_Growth_Pct_Y5` | L2 | E: Growth |
| 54 | `Revenue_Total_5Yr` | L2 | E: Summary |
| 55 | `Customers_New_Total` | L2 | E: Summary |
| 56 | `Avg_Revenue_Per_Customer_Y1` | L2 | E: Summary |
| 57 | `Avg_Revenue_Per_Customer_Y5` | L2 | E: Summary |
| 58 | `Customer_Lifetime_Months` | L2 | E: Summary |
| 59 | `LTV_Y1` | L2 | E: Summary |

---

## Guardrail Compliance Checklist

### Guardrail 1 — Named Range Priority

**Status: COMPLIANT**

Every formula in Layer 2 references only Named Ranges. Zero cell-coordinate
references (A1, B8, $C$10) appear in any formula. Every business variable has
a Named Range. The model can be read as plain English:

> `ARR_Y3 = MRR_Y3 * Inp_Months_Per_Year`
>
> "Annual Recurring Revenue in Year 3 equals Monthly Recurring Revenue in
> Year 3 times the number of months per year."

### Guardrail 2 — LaTeX Verification

**Status: COMPLIANT**

All multi-step formulas verified in LaTeX before specification:
- Annual retention from monthly churn: $(1 - c)^{12}$
- Customer dynamics: BOY/EOY/Retained/New identities
- Compound pricing: $P_n = P_{n-1}(1+i)$
- Revenue: dimensional analysis confirms $/year
- LTV: $P \times (1/c)$

No WACC, IRR, NPV, or DCF formulas in this model (pure revenue model).

### Guardrail 3 — Audit-Ready Intent Notes

**Status: SPECIFIED**

Every formula in this specification includes its Intent description. When
written to Excel, each cell must carry an Excel Note in this format:

```
INTENT:      [From the "Intent" column in the tables above]
FORMULA:     [LaTeX expression from verification sections]
ASSUMPTIONS: [Named Ranges referenced by this formula]
GENERATED:   2026-03-11 / IDFA Financial Architect
MODIFIED:    [To be updated on each change]
```

### Guardrail 4 — Delegated Calculation

**Status: APPLICABLE AT IMPLEMENTATION**

This specification contains no computed results. When the model is built in
Excel and values are needed, all arithmetic will be delegated to the
spreadsheet engine via the `idfa-ops` write-recalculate-read pattern. The
expected values below are provided for validation purposes only and are
clearly labeled as such.

---

## Expected Values (For Validation Only)

These values are computed here solely to validate that the formula chain is
internally consistent. When the model is implemented in Excel, the actual
values MUST be obtained via the spreadsheet engine (Guardrail 4).

**Label: Computed via formula tracing (not model-verified)**

### Derived Constants

| Metric | Value |
|--------|-------|
| Monthly retention rate | 0.98 |
| Annual retention rate | 0.7847 (= 0.98^12) |
| Annual churn rate | 0.2153 |
| Customer lifetime | 50 months |

### Customer Dynamics

| Metric | Year 1 | Year 2 | Year 3 | Year 4 | Year 5 |
|--------|--------|--------|--------|--------|--------|
| BOY Customers | 500 | 600 | 720 | 864 | 1,037 |
| EOY Customers | 600 | 720 | 864 | 1,037 | 1,244 |
| Retained (from BOY) | 392 | 471 | 565 | 678 | 813 |
| New Acquired | 208 | 249 | 299 | 359 | 431 |
| Average Customers | 550 | 660 | 792 | 951 | 1,140 |

*Note: EOY values are rounded to the nearest whole number for presentation.
The Excel model should retain full decimal precision in formulas.*

### Pricing

| Metric | Year 1 | Year 2 | Year 3 | Year 4 | Year 5 |
|--------|--------|--------|--------|--------|--------|
| Monthly Price | $200.00 | $210.00 | $220.50 | $231.53 | $243.10 |

### Revenue

| Metric | Year 1 | Year 2 | Year 3 | Year 4 | Year 5 |
|--------|--------|--------|--------|--------|--------|
| MRR (avg month) | $110,000 | $138,600 | $174,636 | $219,981 | $277,176 |
| ARR | $1,320,000 | $1,663,200 | $2,095,632 | $2,639,774 | $3,326,115 |
| ARR Growth % | — | 26.0% | 26.0% | 26.0% | 26.0% |

**Key insight:** Although customer growth is 20% and price increases are 5%,
the compounded ARR growth rate is approximately 26% per year
(1.20 * 1.05 = 1.26). This is the multiplicative interaction of the two
growth drivers — not additive (25%). The formula chain correctly captures
this because customer averages grow at ~20% and prices grow at ~5%
independently.

### Summary

| Metric | Value |
|--------|-------|
| Cumulative 5-Year Revenue | ~$11,044,721 |
| Total New Customers (5 years) | ~1,546 |
| Revenue/Customer Y1 | $2,400/yr |
| Revenue/Customer Y5 | $2,917/yr |
| LTV (at Y1 pricing) | $10,000 |

---

## Excel Sheet Layout Recommendation

### Sheet 1: "Assumptions" (Layer 1)

```
Row 1:  [Header] SaaS Revenue Model — Input Assumptions
Row 3:  Inp_Customers_Start           500
Row 4:  Inp_Price_Monthly_Start       200
Row 5:  Inp_Customer_Growth_Rate      0.20
Row 6:  Inp_Price_Increase_Rate       0.05
Row 7:  Inp_Churn_Monthly             0.02
Row 8:  Inp_Months_Per_Year           12
```

Column A: Label (descriptive text). Column B: Named Range name. Column C: Value (Named Range points here).

### Sheet 2: "Calculations" (Layer 2)

Organized in blocks A-E as specified above. Each row contains one Named Range
and its formula. Columns:

- Column A: Named Range name (label)
- Column B: Formula (this is where the Named Range points)
- Column C: Intent description (human-readable note)

### Sheet 3: "Dashboard" (Layer 3)

Presentation tables and charts reading exclusively from Layer 2 Named Ranges.
No calculations. Suggested views:

1. Customer waterfall chart (BOY / Retained / New / EOY per year)
2. ARR growth bar chart
3. Pricing escalation line
4. Summary KPI cards (Total Revenue, LTV, Total New Customers)

---

## Intent Notes — Full Template for All Formulas

Below are the Intent Notes to be attached as Excel comments when the model
is built. Grouped by block.

### Block A: Retention Dynamics

**Retention_Monthly**
```
INTENT:      Monthly retention rate — the complement of monthly churn
FORMULA:     r = 1 - c
ASSUMPTIONS: Inp_Churn_Monthly
GENERATED:   2026-03-11 / IDFA Financial Architect
MODIFIED:    —
```

**Retention_Annual**
```
INTENT:      Annual retention rate — probability a customer survives 12 consecutive months
FORMULA:     r_annual = (1 - c_monthly)^12
ASSUMPTIONS: Retention_Monthly, Inp_Months_Per_Year
GENERATED:   2026-03-11 / IDFA Financial Architect
MODIFIED:    —
```

**Churn_Annual**
```
INTENT:      Annual churn rate — complement of annual retention
FORMULA:     c_annual = 1 - r_annual
ASSUMPTIONS: Retention_Annual
GENERATED:   2026-03-11 / IDFA Financial Architect
MODIFIED:    —
```

### Block B: Customer Dynamics (template for each year)

**Customers_BOY_Yn** (n > 1)
```
INTENT:      Beginning-of-year customer count equals prior year's ending count
FORMULA:     BOY_n = EOY_{n-1}
ASSUMPTIONS: Customers_EOY_Y{n-1}
GENERATED:   2026-03-11 / IDFA Financial Architect
MODIFIED:    —
```

**Customers_EOY_Yn**
```
INTENT:      End-of-year customer count — beginning count grown by annual growth rate
FORMULA:     EOY_n = BOY_n * (1 + g)
ASSUMPTIONS: Customers_BOY_Yn, Inp_Customer_Growth_Rate
GENERATED:   2026-03-11 / IDFA Financial Architect
MODIFIED:    —
```

**Customers_Retained_Yn**
```
INTENT:      Customers from beginning-of-year cohort who survive 12 months of churn
FORMULA:     Retained_n = BOY_n * r_annual
ASSUMPTIONS: Customers_BOY_Yn, Retention_Annual
GENERATED:   2026-03-11 / IDFA Financial Architect
MODIFIED:    —
```

**Customers_New_Yn**
```
INTENT:      New customers acquired during the year to reach EOY target
FORMULA:     New_n = EOY_n - Retained_n
ASSUMPTIONS: Customers_EOY_Yn, Customers_Retained_Yn
GENERATED:   2026-03-11 / IDFA Financial Architect
MODIFIED:    —
```

**Customers_Avg_Yn**
```
INTENT:      Average customer count for revenue calculation (midpoint of BOY and EOY)
FORMULA:     Avg_n = (BOY_n + EOY_n) / 2
ASSUMPTIONS: Customers_BOY_Yn, Customers_EOY_Yn
GENERATED:   2026-03-11 / IDFA Financial Architect
MODIFIED:    —
```

### Block C: Pricing

**Price_Monthly_Yn** (n > 1)
```
INTENT:      Monthly subscription price, compounded annually by price increase rate
FORMULA:     P_n = P_{n-1} * (1 + i)
ASSUMPTIONS: Price_Monthly_Y{n-1}, Inp_Price_Increase_Rate
GENERATED:   2026-03-11 / IDFA Financial Architect
MODIFIED:    —
```

### Block D: Revenue

**MRR_Yn**
```
INTENT:      Monthly Recurring Revenue — average customers times monthly price
FORMULA:     MRR_n = Avg_n * P_n
ASSUMPTIONS: Customers_Avg_Yn, Price_Monthly_Yn
GENERATED:   2026-03-11 / IDFA Financial Architect
MODIFIED:    —
```

**ARR_Yn**
```
INTENT:      Annual Recurring Revenue — MRR annualized over 12 months
FORMULA:     ARR_n = MRR_n * 12
ASSUMPTIONS: MRR_Yn, Inp_Months_Per_Year
GENERATED:   2026-03-11 / IDFA Financial Architect
MODIFIED:    —
```

### Block E: Summary Metrics

**ARR_Growth_Pct_Yn** (n >= 2)
```
INTENT:      Year-over-year ARR growth rate
FORMULA:     g_n = (ARR_n - ARR_{n-1}) / ARR_{n-1}
ASSUMPTIONS: ARR_Yn, ARR_Y{n-1}
GENERATED:   2026-03-11 / IDFA Financial Architect
MODIFIED:    —
```

**Revenue_Total_5Yr**
```
INTENT:      Cumulative revenue across all five years
FORMULA:     Total = sum(ARR_1..ARR_5)
ASSUMPTIONS: ARR_Y1, ARR_Y2, ARR_Y3, ARR_Y4, ARR_Y5
GENERATED:   2026-03-11 / IDFA Financial Architect
MODIFIED:    —
```

**Customer_Lifetime_Months**
```
INTENT:      Expected customer lifetime in months (inverse of monthly churn)
FORMULA:     L = 1 / c_monthly
ASSUMPTIONS: Inp_Churn_Monthly
GENERATED:   2026-03-11 / IDFA Financial Architect
MODIFIED:    —
```

**LTV_Y1**
```
INTENT:      Simple Customer Lifetime Value at Year 1 pricing (no discount rate)
FORMULA:     LTV = P_1 * L
ASSUMPTIONS: Price_Monthly_Y1, Customer_Lifetime_Months
GENERATED:   2026-03-11 / IDFA Financial Architect
MODIFIED:    —
```

---

## Dependency Graph

```
Inp_Customers_Start
  └─> Customers_BOY_Y1
        ├─> Customers_EOY_Y1 ──> Customers_BOY_Y2 ──> ... (chain through Y5)
        ├─> Customers_Retained_Y1 ──> Customers_New_Y1
        └─> Customers_Avg_Y1 ──> MRR_Y1 ──> ARR_Y1

Inp_Price_Monthly_Start
  └─> Price_Monthly_Y1 ──> Price_Monthly_Y2 ──> ... (chain through Y5)
        └─> MRR_Y1 ──> ARR_Y1

Inp_Customer_Growth_Rate
  └─> Customers_EOY_Y1 ... Customers_EOY_Y5

Inp_Price_Increase_Rate
  └─> Price_Monthly_Y2 ... Price_Monthly_Y5

Inp_Churn_Monthly
  └─> Retention_Monthly ──> Retention_Annual ──> Churn_Annual
        └─> Customers_Retained_Y1 ... Customers_Retained_Y5
  └─> Customer_Lifetime_Months ──> LTV_Y1

Inp_Months_Per_Year
  └─> Retention_Annual
  └─> ARR_Y1 ... ARR_Y5

ARR_Y1 ... ARR_Y5
  └─> ARR_Growth_Pct_Y2 ... ARR_Growth_Pct_Y5
  └─> Revenue_Total_5Yr
  └─> Avg_Revenue_Per_Customer_Y1, Avg_Revenue_Per_Customer_Y5
```

---

## What-If Scenarios Enabled by This Model

Because every assumption is a Named Range, the following what-if analyses
require changing only one input value each:

| Scenario | Change | Named Range |
|----------|--------|-------------|
| Higher churn | Set monthly churn to 3% | `Inp_Churn_Monthly = 0.03` |
| Faster growth | Set customer growth to 30% | `Inp_Customer_Growth_Rate = 0.30` |
| Price sensitivity | Set price increase to 0% | `Inp_Price_Increase_Rate = 0.00` |
| Larger starting base | Set starting customers to 1000 | `Inp_Customers_Start = 1000` |
| Premium pricing | Set starting price to $500/mo | `Inp_Price_Monthly_Start = 500` |

Each scenario: write the new assumption via `idfa_ops.py write`, recalculate
via `recalc_bridge.py`, read results via `idfa_ops.py read`.

---

## Implementation Notes

1. **No circular references.** The dependency graph is a DAG (directed acyclic
   graph). Every formula references only previously-defined Named Ranges.

2. **Rounding.** Customer counts should display as integers in Layer 3 but
   retain full precision in Layer 2 formulas. Do not apply ROUND() in Layer 2
   — that would introduce rounding error that compounds across years.

3. **Extensibility.** To add COGS, OpEx, or EBITDA, create new Layer 1
   assumptions (e.g., `Inp_COGS_Pct_Y1`) and new Layer 2 calculations
   referencing `ARR_Yn` — the existing Named Ranges remain unchanged.

4. **Monthly granularity upgrade.** If monthly detail is later required,
   the annual Named Ranges become rollup formulas (SUM of 12 monthly ranges).
   The Layer 1 inputs and Layer 3 outputs remain structurally identical.

---

*Specification produced by the IDFA Financial Architect agent using the
Intent-Driven Financial Architecture methodology, developed by the
Panaversity team (https://panaversity.org).*
