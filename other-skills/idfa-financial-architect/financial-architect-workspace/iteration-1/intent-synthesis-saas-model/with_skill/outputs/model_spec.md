# IDFA Model Specification — 5-Year SaaS Revenue Model

**Model Name:** SaaS_Revenue_5Y
**Intent Statement:** Project a 5-year SaaS revenue model. Year 1 starts with 500
customers paying $200/month each. Customer base grows 20% year-over-year. Pricing
increases 5% annually. Monthly churn is 2%. Compute annual recurring revenue,
churned revenue, net revenue, and cumulative metrics for Years 1 through 5.

**IDFA Version:** 1.0
**Generated:** 2026-03-11
**Methodology:** Intent-Driven Financial Architecture (Panaversity)

---

## Architecture Overview

This model follows the IDFA Three-Layer structure:

- **Layer 1 (Assumptions):** All user-modifiable inputs, prefixed `Inp_`
- **Layer 2 (Calculations):** All formulas referencing Named Ranges only — zero cell addresses
- **Layer 3 (Output):** Display tables and charts reading from Layer 2 only

---

## Layer 1 — Assumptions (Inputs Only)

Every user-modifiable value lives here. No calculations occur in this layer.

| Named Range | Description | Value | Unit |
|---|---|---|---|
| `Inp_Customers_Y1` | Starting customer count at beginning of Year 1 | 500 | customers |
| `Inp_Price_Monthly_Y1` | Monthly subscription price per customer in Year 1 | 200 | $/month |
| `Inp_Customer_Growth_Rate` | Annual customer growth rate (YoY) | 0.20 | decimal (20%) |
| `Inp_Price_Increase_Rate` | Annual price increase rate | 0.05 | decimal (5%) |
| `Inp_Churn_Rate_Monthly` | Monthly customer churn rate | 0.02 | decimal (2%) |

**Total Layer 1 Named Ranges: 5**

---

## Layer 2 — Calculations (Logic Only)

All formulas reference Named Ranges exclusively. No hardcoded values. No cell-address
references. Every formula reads as a plain-English business rule.

### Section A: Monthly Price per Customer

The monthly subscription price grows 5% each year from the Year 1 base.

| Named Range | Formula | Business Rule |
|---|---|---|
| `Price_Monthly_Y1` | `= Inp_Price_Monthly_Y1` | Year 1 monthly price is the input assumption |
| `Price_Monthly_Y2` | `= Price_Monthly_Y1 * (1 + Inp_Price_Increase_Rate)` | Year 2 price is Year 1 price plus the annual increase |
| `Price_Monthly_Y3` | `= Price_Monthly_Y2 * (1 + Inp_Price_Increase_Rate)` | Year 3 price is Year 2 price plus the annual increase |
| `Price_Monthly_Y4` | `= Price_Monthly_Y3 * (1 + Inp_Price_Increase_Rate)` | Year 4 price is Year 3 price plus the annual increase |
| `Price_Monthly_Y5` | `= Price_Monthly_Y4 * (1 + Inp_Price_Increase_Rate)` | Year 5 price is Year 4 price plus the annual increase |

### Section B: Annual Price per Customer

| Named Range | Formula | Business Rule |
|---|---|---|
| `Price_Annual_Y1` | `= Price_Monthly_Y1 * 12` | Annual price is 12 months of monthly price |
| `Price_Annual_Y2` | `= Price_Monthly_Y2 * 12` | Annual price is 12 months of monthly price |
| `Price_Annual_Y3` | `= Price_Monthly_Y3 * 12` | Annual price is 12 months of monthly price |
| `Price_Annual_Y4` | `= Price_Monthly_Y4 * 12` | Annual price is 12 months of monthly price |
| `Price_Annual_Y5` | `= Price_Monthly_Y5 * 12` | Annual price is 12 months of monthly price |

**Note on the constant 12:** The value 12 (months per year) is a dimensional constant,
not a business assumption. It converts monthly to annual and cannot meaningfully change.
This is comparable to using 100 when converting between decimals and percentages. It does
not require extraction to Layer 1. If a future version of this model adds a
partial-year entry scenario (e.g., launching mid-year), that would be a new input
(`Inp_Months_Active_Y1`), not a modification of this constant.

### Section C: Beginning-of-Year (BoY) Customers

The customer count at the start of each year, before churn. Year 1 uses the input.
Subsequent years grow the prior year's end-of-year customer count.

| Named Range | Formula | Business Rule |
|---|---|---|
| `Customers_BoY_Y1` | `= Inp_Customers_Y1` | Year 1 starts with the input customer count |
| `Customers_BoY_Y2` | `= Customers_EoY_Y1 * (1 + Inp_Customer_Growth_Rate)` | Year 2 starts with Year 1 ending customers grown by the annual growth rate |
| `Customers_BoY_Y3` | `= Customers_EoY_Y2 * (1 + Inp_Customer_Growth_Rate)` | Year 3 starts with Year 2 ending customers grown by the annual growth rate |
| `Customers_BoY_Y4` | `= Customers_EoY_Y3 * (1 + Inp_Customer_Growth_Rate)` | Year 4 starts with Year 3 ending customers grown by the annual growth rate |
| `Customers_BoY_Y5` | `= Customers_EoY_Y4 * (1 + Inp_Customer_Growth_Rate)` | Year 5 starts with Year 4 ending customers grown by the annual growth rate |

### Section D: Annual Churn Rate (Derived)

Monthly churn compounds over 12 months. The annual retention rate is
`(1 - monthly_churn)^12`, and the annual churn rate is `1 - retention`.

| Named Range | Formula | Business Rule |
|---|---|---|
| `Retention_Rate_Annual` | `= (1 - Inp_Churn_Rate_Monthly) ^ 12` | Annual retention is monthly retention compounded over 12 months |
| `Churn_Rate_Annual` | `= 1 - Retention_Rate_Annual` | Annual churn is the complement of annual retention |

### Section E: Customers Lost to Churn

| Named Range | Formula | Business Rule |
|---|---|---|
| `Customers_Churned_Y1` | `= Customers_BoY_Y1 * Churn_Rate_Annual` | Customers lost in Year 1 is BoY count times the annual churn rate |
| `Customers_Churned_Y2` | `= Customers_BoY_Y2 * Churn_Rate_Annual` | Customers lost in Year 2 is BoY count times the annual churn rate |
| `Customers_Churned_Y3` | `= Customers_BoY_Y3 * Churn_Rate_Annual` | Customers lost in Year 3 is BoY count times the annual churn rate |
| `Customers_Churned_Y4` | `= Customers_BoY_Y4 * Churn_Rate_Annual` | Customers lost in Year 4 is BoY count times the annual churn rate |
| `Customers_Churned_Y5` | `= Customers_BoY_Y5 * Churn_Rate_Annual` | Customers lost in Year 5 is BoY count times the annual churn rate |

### Section F: End-of-Year (EoY) Customers

Customers remaining after churn. New customer acquisition (growth) is applied at the
start of the *next* year (Section C), not within the current year. This cleanly separates
retention from acquisition.

| Named Range | Formula | Business Rule |
|---|---|---|
| `Customers_EoY_Y1` | `= Customers_BoY_Y1 - Customers_Churned_Y1` | End-of-year customers = beginning minus churned |
| `Customers_EoY_Y2` | `= Customers_BoY_Y2 - Customers_Churned_Y2` | End-of-year customers = beginning minus churned |
| `Customers_EoY_Y3` | `= Customers_BoY_Y3 - Customers_Churned_Y3` | End-of-year customers = beginning minus churned |
| `Customers_EoY_Y4` | `= Customers_BoY_Y4 - Customers_Churned_Y4` | End-of-year customers = beginning minus churned |
| `Customers_EoY_Y5` | `= Customers_BoY_Y5 - Customers_Churned_Y5` | End-of-year customers = beginning minus churned |

### Section G: Average Customers During Year

For revenue calculation, we use the average of BoY and EoY customers to approximate
the subscriber base across the year (customers churn continuously, not all at once).

| Named Range | Formula | Business Rule |
|---|---|---|
| `Customers_Avg_Y1` | `= (Customers_BoY_Y1 + Customers_EoY_Y1) / 2` | Average customers is the midpoint of BoY and EoY |
| `Customers_Avg_Y2` | `= (Customers_BoY_Y2 + Customers_EoY_Y2) / 2` | Average customers is the midpoint of BoY and EoY |
| `Customers_Avg_Y3` | `= (Customers_BoY_Y3 + Customers_EoY_Y3) / 2` | Average customers is the midpoint of BoY and EoY |
| `Customers_Avg_Y4` | `= (Customers_BoY_Y4 + Customers_EoY_Y4) / 2` | Average customers is the midpoint of BoY and EoY |
| `Customers_Avg_Y5` | `= (Customers_BoY_Y5 + Customers_EoY_Y5) / 2` | Average customers is the midpoint of BoY and EoY |

### Section H: Gross Revenue (Before Churn Impact)

Gross revenue represents what annual revenue *would* be if all BoY customers paid for
the full year. This is the theoretical maximum.

| Named Range | Formula | Business Rule |
|---|---|---|
| `Revenue_Gross_Y1` | `= Customers_BoY_Y1 * Price_Annual_Y1` | Gross revenue is all BoY customers paying the full annual price |
| `Revenue_Gross_Y2` | `= Customers_BoY_Y2 * Price_Annual_Y2` | Gross revenue is all BoY customers paying the full annual price |
| `Revenue_Gross_Y3` | `= Customers_BoY_Y3 * Price_Annual_Y3` | Gross revenue is all BoY customers paying the full annual price |
| `Revenue_Gross_Y4` | `= Customers_BoY_Y4 * Price_Annual_Y4` | Gross revenue is all BoY customers paying the full annual price |
| `Revenue_Gross_Y5` | `= Customers_BoY_Y5 * Price_Annual_Y5` | Gross revenue is all BoY customers paying the full annual price |

### Section I: Net Revenue (Churn-Adjusted)

Net revenue uses the average customer count to reflect that churned customers paid for
part of the year, not the full year.

| Named Range | Formula | Business Rule |
|---|---|---|
| `Revenue_Net_Y1` | `= Customers_Avg_Y1 * Price_Annual_Y1` | Net revenue is average customers times the annual price |
| `Revenue_Net_Y2` | `= Customers_Avg_Y2 * Price_Annual_Y2` | Net revenue is average customers times the annual price |
| `Revenue_Net_Y3` | `= Customers_Avg_Y3 * Price_Annual_Y3` | Net revenue is average customers times the annual price |
| `Revenue_Net_Y4` | `= Customers_Avg_Y4 * Price_Annual_Y4` | Net revenue is average customers times the annual price |
| `Revenue_Net_Y5` | `= Customers_Avg_Y5 * Price_Annual_Y5` | Net revenue is average customers times the annual price |

### Section J: Churned Revenue (Revenue Lost to Churn)

The revenue difference between the theoretical maximum (gross) and the realized (net).

| Named Range | Formula | Business Rule |
|---|---|---|
| `Revenue_Churned_Y1` | `= Revenue_Gross_Y1 - Revenue_Net_Y1` | Churned revenue is the difference between gross and net |
| `Revenue_Churned_Y2` | `= Revenue_Gross_Y2 - Revenue_Net_Y2` | Churned revenue is the difference between gross and net |
| `Revenue_Churned_Y3` | `= Revenue_Gross_Y3 - Revenue_Net_Y3` | Churned revenue is the difference between gross and net |
| `Revenue_Churned_Y4` | `= Revenue_Gross_Y4 - Revenue_Net_Y4` | Churned revenue is the difference between gross and net |
| `Revenue_Churned_Y5` | `= Revenue_Gross_Y5 - Revenue_Net_Y5` | Churned revenue is the difference between gross and net |

### Section K: Year-over-Year Revenue Growth Rate

| Named Range | Formula | Business Rule |
|---|---|---|
| `Revenue_Growth_Pct_Y2` | `= (Revenue_Net_Y2 - Revenue_Net_Y1) / Revenue_Net_Y1` | YoY net revenue growth rate from Year 1 to Year 2 |
| `Revenue_Growth_Pct_Y3` | `= (Revenue_Net_Y3 - Revenue_Net_Y2) / Revenue_Net_Y2` | YoY net revenue growth rate from Year 2 to Year 3 |
| `Revenue_Growth_Pct_Y4` | `= (Revenue_Net_Y4 - Revenue_Net_Y3) / Revenue_Net_Y3` | YoY net revenue growth rate from Year 3 to Year 4 |
| `Revenue_Growth_Pct_Y5` | `= (Revenue_Net_Y5 - Revenue_Net_Y4) / Revenue_Net_Y4` | YoY net revenue growth rate from Year 4 to Year 5 |

### Section L: Cumulative Totals

| Named Range | Formula | Business Rule |
|---|---|---|
| `Revenue_Net_Total` | `= Revenue_Net_Y1 + Revenue_Net_Y2 + Revenue_Net_Y3 + Revenue_Net_Y4 + Revenue_Net_Y5` | Sum of all 5 years of net revenue |
| `Revenue_Churned_Total` | `= Revenue_Churned_Y1 + Revenue_Churned_Y2 + Revenue_Churned_Y3 + Revenue_Churned_Y4 + Revenue_Churned_Y5` | Sum of all 5 years of churned revenue |
| `Customers_Churned_Total` | `= Customers_Churned_Y1 + Customers_Churned_Y2 + Customers_Churned_Y3 + Customers_Churned_Y4 + Customers_Churned_Y5` | Sum of all 5 years of churned customers |

### Section M: Key SaaS Metrics

| Named Range | Formula | Business Rule |
|---|---|---|
| `ARPU_Monthly_Y1` | `= Price_Monthly_Y1` | Average revenue per user per month in Year 1 (equals price in single-tier model) |
| `ARPU_Monthly_Y2` | `= Price_Monthly_Y2` | Average revenue per user per month in Year 2 |
| `ARPU_Monthly_Y3` | `= Price_Monthly_Y3` | Average revenue per user per month in Year 3 |
| `ARPU_Monthly_Y4` | `= Price_Monthly_Y4` | Average revenue per user per month in Year 4 |
| `ARPU_Monthly_Y5` | `= Price_Monthly_Y5` | Average revenue per user per month in Year 5 |
| `MRR_BoY_Y1` | `= Customers_BoY_Y1 * Price_Monthly_Y1` | Monthly Recurring Revenue at start of Year 1 |
| `MRR_BoY_Y2` | `= Customers_BoY_Y2 * Price_Monthly_Y2` | Monthly Recurring Revenue at start of Year 2 |
| `MRR_BoY_Y3` | `= Customers_BoY_Y3 * Price_Monthly_Y3` | Monthly Recurring Revenue at start of Year 3 |
| `MRR_BoY_Y4` | `= Customers_BoY_Y4 * Price_Monthly_Y4` | Monthly Recurring Revenue at start of Year 4 |
| `MRR_BoY_Y5` | `= Customers_BoY_Y5 * Price_Monthly_Y5` | Monthly Recurring Revenue at start of Year 5 |
| `ARR_BoY_Y1` | `= MRR_BoY_Y1 * 12` | Annual Recurring Revenue at start of Year 1 |
| `ARR_BoY_Y2` | `= MRR_BoY_Y2 * 12` | Annual Recurring Revenue at start of Year 2 |
| `ARR_BoY_Y3` | `= MRR_BoY_Y3 * 12` | Annual Recurring Revenue at start of Year 3 |
| `ARR_BoY_Y4` | `= MRR_BoY_Y4 * 12` | Annual Recurring Revenue at start of Year 4 |
| `ARR_BoY_Y5` | `= MRR_BoY_Y5 * 12` | Annual Recurring Revenue at start of Year 5 |
| `Net_Revenue_Retention_Pct_Y2` | `= Revenue_Net_Y2 / Revenue_Gross_Y1` | Net Revenue Retention: this year's net revenue from the prior year's cohort relative to prior year's gross potential (a simplification assuming single cohort) |
| `Net_Revenue_Retention_Pct_Y3` | `= Revenue_Net_Y3 / Revenue_Gross_Y2` | Net Revenue Retention Year 3 |
| `Net_Revenue_Retention_Pct_Y4` | `= Revenue_Net_Y4 / Revenue_Gross_Y3` | Net Revenue Retention Year 4 |
| `Net_Revenue_Retention_Pct_Y5` | `= Revenue_Net_Y5 / Revenue_Gross_Y4` | Net Revenue Retention Year 5 |
| `Customer_Lifetime_Months` | `= 1 / Inp_Churn_Rate_Monthly` | Expected customer lifetime in months (inverse of monthly churn) |
| `LTV_Per_Customer` | `= Customer_Lifetime_Months * Inp_Price_Monthly_Y1` | Lifetime value per customer using Year 1 price (simplified; does not account for price increases) |

**Total Layer 2 Named Ranges: 75**

---

## Layer 3 — Output (Presentation Only)

Layer 3 reads from Layer 2 only. It performs no calculations. The following tables
define the output layout.

### Output Table 1: Customer Waterfall

| Row Label | Year 1 | Year 2 | Year 3 | Year 4 | Year 5 |
|---|---|---|---|---|---|
| Customers (BoY) | `Customers_BoY_Y1` | `Customers_BoY_Y2` | `Customers_BoY_Y3` | `Customers_BoY_Y4` | `Customers_BoY_Y5` |
| Customers Churned | `Customers_Churned_Y1` | `Customers_Churned_Y2` | `Customers_Churned_Y3` | `Customers_Churned_Y4` | `Customers_Churned_Y5` |
| Customers (EoY) | `Customers_EoY_Y1` | `Customers_EoY_Y2` | `Customers_EoY_Y3` | `Customers_EoY_Y4` | `Customers_EoY_Y5` |
| Customers (Avg) | `Customers_Avg_Y1` | `Customers_Avg_Y2` | `Customers_Avg_Y3` | `Customers_Avg_Y4` | `Customers_Avg_Y5` |

### Output Table 2: Pricing

| Row Label | Year 1 | Year 2 | Year 3 | Year 4 | Year 5 |
|---|---|---|---|---|---|
| Monthly Price | `Price_Monthly_Y1` | `Price_Monthly_Y2` | `Price_Monthly_Y3` | `Price_Monthly_Y4` | `Price_Monthly_Y5` |
| Annual Price | `Price_Annual_Y1` | `Price_Annual_Y2` | `Price_Annual_Y3` | `Price_Annual_Y4` | `Price_Annual_Y5` |

### Output Table 3: Revenue Summary

| Row Label | Year 1 | Year 2 | Year 3 | Year 4 | Year 5 | Total |
|---|---|---|---|---|---|---|
| Gross Revenue | `Revenue_Gross_Y1` | `Revenue_Gross_Y2` | `Revenue_Gross_Y3` | `Revenue_Gross_Y4` | `Revenue_Gross_Y5` | — |
| Churned Revenue | `Revenue_Churned_Y1` | `Revenue_Churned_Y2` | `Revenue_Churned_Y3` | `Revenue_Churned_Y4` | `Revenue_Churned_Y5` | `Revenue_Churned_Total` |
| **Net Revenue** | `Revenue_Net_Y1` | `Revenue_Net_Y2` | `Revenue_Net_Y3` | `Revenue_Net_Y4` | `Revenue_Net_Y5` | `Revenue_Net_Total` |
| YoY Growth % | — | `Revenue_Growth_Pct_Y2` | `Revenue_Growth_Pct_Y3` | `Revenue_Growth_Pct_Y4` | `Revenue_Growth_Pct_Y5` | — |

### Output Table 4: SaaS KPIs

| Row Label | Year 1 | Year 2 | Year 3 | Year 4 | Year 5 |
|---|---|---|---|---|---|
| ARPU (Monthly) | `ARPU_Monthly_Y1` | `ARPU_Monthly_Y2` | `ARPU_Monthly_Y3` | `ARPU_Monthly_Y4` | `ARPU_Monthly_Y5` |
| MRR (BoY) | `MRR_BoY_Y1` | `MRR_BoY_Y2` | `MRR_BoY_Y3` | `MRR_BoY_Y4` | `MRR_BoY_Y5` |
| ARR (BoY) | `ARR_BoY_Y1` | `ARR_BoY_Y2` | `ARR_BoY_Y3` | `ARR_BoY_Y4` | `ARR_BoY_Y5` |
| Net Revenue Retention % | — | `Net_Revenue_Retention_Pct_Y2` | `Net_Revenue_Retention_Pct_Y3` | `Net_Revenue_Retention_Pct_Y4` | `Net_Revenue_Retention_Pct_Y5` |

### Output Scalar Metrics

| Metric | Named Range |
|---|---|
| Annual Churn Rate (derived) | `Churn_Rate_Annual` |
| Annual Retention Rate | `Retention_Rate_Annual` |
| Customer Lifetime (months) | `Customer_Lifetime_Months` |
| LTV per Customer | `LTV_Per_Customer` |
| 5-Year Cumulative Net Revenue | `Revenue_Net_Total` |
| 5-Year Cumulative Churned Revenue | `Revenue_Churned_Total` |
| 5-Year Cumulative Customers Churned | `Customers_Churned_Total` |

---

## LaTeX Verification (Guardrail 2)

### Price Escalation

$$P_n = P_{n-1} \times (1 + p)$$

Where $P_n$ is the monthly price in year $n$ and $p$ is the annual price increase rate.

Verification: `Price_Monthly_Y2 = Price_Monthly_Y1 * (1 + Inp_Price_Increase_Rate)` matches the LaTeX form. Confirmed correct.

### Customer Growth (BoY)

$$C^{BoY}_n = C^{EoY}_{n-1} \times (1 + g)$$

Where $C^{BoY}_n$ is the beginning-of-year customer count in year $n$, $C^{EoY}_{n-1}$ is the end-of-year count from the prior year, and $g$ is the annual customer growth rate.

Verification: `Customers_BoY_Y2 = Customers_EoY_Y1 * (1 + Inp_Customer_Growth_Rate)` matches. Confirmed correct.

### Annual Churn from Monthly Churn (Compounding)

$$r_{annual} = 1 - (1 - r_{monthly})^{12}$$

Where $r_{annual}$ is the annual churn rate and $r_{monthly}$ is the monthly churn rate.

This is a multi-step calculation requiring verification. With $r_{monthly} = 0.02$:

$$r_{annual} = 1 - (1 - 0.02)^{12} = 1 - 0.98^{12} = 1 - 0.7847 = 0.2153$$

So approximately 21.53% annual churn from 2% monthly churn. This is correct — simple
addition (2% x 12 = 24%) would overstate churn by ignoring compounding.

Verification:
- `Retention_Rate_Annual = (1 - Inp_Churn_Rate_Monthly) ^ 12` matches $(1 - r_{monthly})^{12}$
- `Churn_Rate_Annual = 1 - Retention_Rate_Annual` matches $1 - (1 - r_{monthly})^{12}$

Confirmed correct.

### End-of-Year Customers

$$C^{EoY}_n = C^{BoY}_n - (C^{BoY}_n \times r_{annual}) = C^{BoY}_n \times (1 - r_{annual})$$

Verification: `Customers_EoY_Y1 = Customers_BoY_Y1 - Customers_Churned_Y1` where
`Customers_Churned_Y1 = Customers_BoY_Y1 * Churn_Rate_Annual`. This is equivalent
to $C^{BoY}_n \times (1 - r_{annual})$. Confirmed correct.

### Average Customers

$$C^{Avg}_n = \frac{C^{BoY}_n + C^{EoY}_n}{2}$$

Verification: `Customers_Avg_Y1 = (Customers_BoY_Y1 + Customers_EoY_Y1) / 2`. Matches. Confirmed correct.

### Net Revenue

$$Rev^{Net}_n = C^{Avg}_n \times P_n \times 12$$

Verification: `Revenue_Net_Y1 = Customers_Avg_Y1 * Price_Annual_Y1` where
`Price_Annual_Y1 = Price_Monthly_Y1 * 12`. This expands to
$C^{Avg}_n \times P_n \times 12$. Confirmed correct.

### Customer Lifetime

$$L = \frac{1}{r_{monthly}}$$

Verification: `Customer_Lifetime_Months = 1 / Inp_Churn_Rate_Monthly`. With 2% monthly
churn, expected lifetime = 50 months. Confirmed correct.

### Lifetime Value

$$LTV = L \times P_1$$

Where $P_1$ is the monthly price in Year 1 (simplified model — does not account for
price increases over the customer's lifetime).

Verification: `LTV_Per_Customer = Customer_Lifetime_Months * Inp_Price_Monthly_Y1`.
With 50 months at $200/month = $10,000 LTV. Confirmed correct.

---

## Intent Notes (Guardrail 3)

Every formula in this specification carries an Intent Note. The following are the
formal audit-ready Intent Notes for each calculation section.

### Intent Note — Price Escalation (Section A & B)

```
INTENT:      Monthly subscription price increases by a fixed percentage each year.
             Annual price is 12 months of the monthly price.
FORMULA:     P_n = P_{n-1} * (1 + p); P_annual = P_monthly * 12
ASSUMPTIONS: Inp_Price_Monthly_Y1, Inp_Price_Increase_Rate
GENERATED:   2026-03-11
MODIFIED:    2026-03-11 (initial specification)
```

### Intent Note — Customer Count (Sections C, E, F, G)

```
INTENT:      Track customer headcount across each year. Customers at the start of
             each year = prior year's end-of-year count grown by the annual growth
             rate. Customers churn during the year at the compounded annual churn
             rate. Average customers approximates the mid-year subscriber base.
FORMULA:     C_BoY_n = C_EoY_{n-1} * (1 + g)
             C_Churned_n = C_BoY_n * r_annual
             C_EoY_n = C_BoY_n - C_Churned_n
             C_Avg_n = (C_BoY_n + C_EoY_n) / 2
ASSUMPTIONS: Inp_Customers_Y1, Inp_Customer_Growth_Rate, Inp_Churn_Rate_Monthly
GENERATED:   2026-03-11
MODIFIED:    2026-03-11 (initial specification)
```

### Intent Note — Annual Churn Derivation (Section D)

```
INTENT:      Derive the annual churn rate from the monthly churn rate by compounding.
             Monthly churn of 2% does not equal 24% annual — it compounds to ~21.53%.
FORMULA:     Retention_Annual = (1 - r_monthly)^12; Churn_Annual = 1 - Retention_Annual
ASSUMPTIONS: Inp_Churn_Rate_Monthly
GENERATED:   2026-03-11
MODIFIED:    2026-03-11 (initial specification)
```

### Intent Note — Revenue (Sections H, I, J, K, L)

```
INTENT:      Gross revenue is the theoretical maximum if all BoY customers paid for
             the full year. Net revenue uses average customers to account for mid-year
             churn. Churned revenue is the difference. YoY growth tracks the net
             revenue trajectory.
FORMULA:     Rev_Gross_n = C_BoY_n * P_annual_n
             Rev_Net_n = C_Avg_n * P_annual_n
             Rev_Churned_n = Rev_Gross_n - Rev_Net_n
             Growth_n = (Rev_Net_n - Rev_Net_{n-1}) / Rev_Net_{n-1}
ASSUMPTIONS: All customer count Named Ranges, all pricing Named Ranges
GENERATED:   2026-03-11
MODIFIED:    2026-03-11 (initial specification)
```

### Intent Note — SaaS KPIs (Section M)

```
INTENT:      Standard SaaS operating metrics. ARPU equals price in a single-tier
             model. MRR and ARR are point-in-time metrics measured at the start of
             each year. Customer Lifetime and LTV are simplified (no price escalation
             in LTV; assumes constant monthly price at Year 1 rate).
FORMULA:     ARPU = Price_Monthly; MRR = Customers_BoY * Price_Monthly;
             ARR = MRR * 12; Lifetime = 1 / r_monthly; LTV = Lifetime * P_1
ASSUMPTIONS: All BoY customer counts, all monthly prices, Inp_Churn_Rate_Monthly
GENERATED:   2026-03-11
MODIFIED:    2026-03-11 (initial specification)
```

---

## Dependency Map

The following shows the calculation dependency chain from inputs to outputs.

```
Layer 1 (Inputs)
├── Inp_Customers_Y1
│   └── Customers_BoY_Y1
│       ├── Customers_Churned_Y1 ← (also depends on Churn_Rate_Annual)
│       │   └── Customers_EoY_Y1
│       │       ├── Customers_Avg_Y1 ← (also depends on Customers_BoY_Y1)
│       │       │   └── Revenue_Net_Y1 ← (also depends on Price_Annual_Y1)
│       │       │       ├── Revenue_Churned_Y1 ← (also depends on Revenue_Gross_Y1)
│       │       │       ├── Revenue_Growth_Pct_Y2 ← (also depends on Revenue_Net_Y2)
│       │       │       └── Revenue_Net_Total
│       │       └── Customers_BoY_Y2 ← (also depends on Inp_Customer_Growth_Rate)
│       │           └── [... cascades through Y3, Y4, Y5]
│       ├── Revenue_Gross_Y1 ← (also depends on Price_Annual_Y1)
│       └── MRR_BoY_Y1 ← (also depends on Price_Monthly_Y1)
│           └── ARR_BoY_Y1
│
├── Inp_Price_Monthly_Y1
│   └── Price_Monthly_Y1
│       ├── Price_Annual_Y1 (→ Revenue calculations)
│       ├── Price_Monthly_Y2 ← (also depends on Inp_Price_Increase_Rate)
│       │   └── Price_Annual_Y2 (→ Revenue calculations)
│       │       └── Price_Monthly_Y3 → ... → Y5
│       ├── ARPU_Monthly_Y1
│       └── LTV_Per_Customer ← (also depends on Customer_Lifetime_Months)
│
├── Inp_Customer_Growth_Rate
│   └── Customers_BoY_Y2 through Customers_BoY_Y5
│
├── Inp_Price_Increase_Rate
│   └── Price_Monthly_Y2 through Price_Monthly_Y5
│
└── Inp_Churn_Rate_Monthly
    ├── Retention_Rate_Annual
    │   └── Churn_Rate_Annual
    │       └── Customers_Churned_Y1 through Y5
    └── Customer_Lifetime_Months
        └── LTV_Per_Customer
```

---

## Complete Named Range Registry

### Layer 1 — Assumptions (5 ranges)

| # | Named Range | Type |
|---|---|---|
| 1 | `Inp_Customers_Y1` | Input |
| 2 | `Inp_Price_Monthly_Y1` | Input |
| 3 | `Inp_Customer_Growth_Rate` | Input |
| 4 | `Inp_Price_Increase_Rate` | Input |
| 5 | `Inp_Churn_Rate_Monthly` | Input |

### Layer 2 — Calculations (75 ranges)

| # | Named Range | Section |
|---|---|---|
| 6 | `Price_Monthly_Y1` | A |
| 7 | `Price_Monthly_Y2` | A |
| 8 | `Price_Monthly_Y3` | A |
| 9 | `Price_Monthly_Y4` | A |
| 10 | `Price_Monthly_Y5` | A |
| 11 | `Price_Annual_Y1` | B |
| 12 | `Price_Annual_Y2` | B |
| 13 | `Price_Annual_Y3` | B |
| 14 | `Price_Annual_Y4` | B |
| 15 | `Price_Annual_Y5` | B |
| 16 | `Customers_BoY_Y1` | C |
| 17 | `Customers_BoY_Y2` | C |
| 18 | `Customers_BoY_Y3` | C |
| 19 | `Customers_BoY_Y4` | C |
| 20 | `Customers_BoY_Y5` | C |
| 21 | `Retention_Rate_Annual` | D |
| 22 | `Churn_Rate_Annual` | D |
| 23 | `Customers_Churned_Y1` | E |
| 24 | `Customers_Churned_Y2` | E |
| 25 | `Customers_Churned_Y3` | E |
| 26 | `Customers_Churned_Y4` | E |
| 27 | `Customers_Churned_Y5` | E |
| 28 | `Customers_EoY_Y1` | F |
| 29 | `Customers_EoY_Y2` | F |
| 30 | `Customers_EoY_Y3` | F |
| 31 | `Customers_EoY_Y4` | F |
| 32 | `Customers_EoY_Y5` | F |
| 33 | `Customers_Avg_Y1` | G |
| 34 | `Customers_Avg_Y2` | G |
| 35 | `Customers_Avg_Y3` | G |
| 36 | `Customers_Avg_Y4` | G |
| 37 | `Customers_Avg_Y5` | G |
| 38 | `Revenue_Gross_Y1` | H |
| 39 | `Revenue_Gross_Y2` | H |
| 40 | `Revenue_Gross_Y3` | H |
| 41 | `Revenue_Gross_Y4` | H |
| 42 | `Revenue_Gross_Y5` | H |
| 43 | `Revenue_Net_Y1` | I |
| 44 | `Revenue_Net_Y2` | I |
| 45 | `Revenue_Net_Y3` | I |
| 46 | `Revenue_Net_Y4` | I |
| 47 | `Revenue_Net_Y5` | I |
| 48 | `Revenue_Churned_Y1` | J |
| 49 | `Revenue_Churned_Y2` | J |
| 50 | `Revenue_Churned_Y3` | J |
| 51 | `Revenue_Churned_Y4` | J |
| 52 | `Revenue_Churned_Y5` | J |
| 53 | `Revenue_Growth_Pct_Y2` | K |
| 54 | `Revenue_Growth_Pct_Y3` | K |
| 55 | `Revenue_Growth_Pct_Y4` | K |
| 56 | `Revenue_Growth_Pct_Y5` | K |
| 57 | `Revenue_Net_Total` | L |
| 58 | `Revenue_Churned_Total` | L |
| 59 | `Customers_Churned_Total` | L |
| 60 | `ARPU_Monthly_Y1` | M |
| 61 | `ARPU_Monthly_Y2` | M |
| 62 | `ARPU_Monthly_Y3` | M |
| 63 | `ARPU_Monthly_Y4` | M |
| 64 | `ARPU_Monthly_Y5` | M |
| 65 | `MRR_BoY_Y1` | M |
| 66 | `MRR_BoY_Y2` | M |
| 67 | `MRR_BoY_Y3` | M |
| 68 | `MRR_BoY_Y4` | M |
| 69 | `MRR_BoY_Y5` | M |
| 70 | `ARR_BoY_Y1` | M |
| 71 | `ARR_BoY_Y2` | M |
| 72 | `ARR_BoY_Y3` | M |
| 73 | `ARR_BoY_Y4` | M |
| 74 | `ARR_BoY_Y5` | M |
| 75 | `Net_Revenue_Retention_Pct_Y2` | M |
| 76 | `Net_Revenue_Retention_Pct_Y3` | M |
| 77 | `Net_Revenue_Retention_Pct_Y4` | M |
| 78 | `Net_Revenue_Retention_Pct_Y5` | M |
| 79 | `Customer_Lifetime_Months` | M |
| 80 | `LTV_Per_Customer` | M |

**Grand Total: 80 Named Ranges (5 inputs + 75 calculations)**

---

## IDFA Compliance Checklist

| Guardrail | Status | Evidence |
|---|---|---|
| **1. Named Range Priority** | PASS | All 75 calculation formulas reference Named Ranges exclusively. Zero cell-address references (A1, B8, $C$10). Every formula reads as a plain-English business rule. |
| **2. LaTeX Verification** | PASS | All multi-step formulas verified: price escalation, customer growth, churn compounding, average customers, revenue calculations, customer lifetime, LTV. LaTeX expressions match Named Range formulas. |
| **3. Audit-Ready Intent Notes** | PASS | Intent Notes provided for all 13 formula sections (A through M), each containing INTENT, FORMULA, ASSUMPTIONS, GENERATED, and MODIFIED fields. |
| **4. Delegated Calculation** | N/A | This is a specification document. When implemented in Excel, all arithmetic will be performed by the spreadsheet engine. No internal agent calculation will be used to produce reported values. |

---

## Design Decisions and Assumptions

1. **Growth applied to EoY, not BoY:** New customers (from the 20% growth rate) join at
   the start of the next year, after churn has occurred. This means growth is applied to
   the surviving customer base, not the starting base. Alternative: apply growth to BoY
   before churn. The chosen approach is more conservative and more common in SaaS modeling.

2. **Churn compounding:** Monthly churn of 2% compounds to ~21.53% annually, not 24%.
   The model uses the compounded rate. This is mathematically correct and industry standard.

3. **Average customers for revenue:** Using the average of BoY and EoY customers
   approximates the continuous churn that occurs throughout the year. This is a standard
   simplification. A monthly-granularity model would be more precise but is not required
   for a 5-year projection.

4. **Single pricing tier:** All customers pay the same price. ARPU equals the
   subscription price. If multiple tiers are introduced later, ARPU formulas would need
   to be weighted averages instead of direct price references.

5. **LTV simplification:** LTV uses Year 1 price only. A more sophisticated model would
   incorporate price increases over the customer's expected lifetime. This is flagged in
   the Intent Note for Section M.

6. **No expansion revenue:** This model does not include upsell, cross-sell, or
   usage-based expansion revenue. Net Revenue Retention could exceed 100% if expansion
   revenue were added.

---

## What-If Scenarios Enabled by This Model

With this specification implemented, the following what-if analyses are immediately
available by modifying Layer 1 inputs:

| Scenario | Input to Change | Question Answered |
|---|---|---|
| Pricing sensitivity | `Inp_Price_Increase_Rate` | What if we raise prices 10% instead of 5%? |
| Growth acceleration | `Inp_Customer_Growth_Rate` | What if marketing doubles customer growth to 40%? |
| Churn reduction | `Inp_Churn_Rate_Monthly` | What if product improvements cut churn to 1%? |
| Market size | `Inp_Customers_Y1` | What if we launch with 1,000 customers instead of 500? |
| Premium pricing | `Inp_Price_Monthly_Y1` | What if we charge $300/month instead of $200? |

All scenarios require only a single input change. The model recalculates deterministically.
No formula modifications needed.

---

_IDFA Model Specification v1.0 — Generated by IDFA Financial Architect Agent_
_Methodology: Intent-Driven Financial Architecture (Panaversity, https://panaversity.org)_
