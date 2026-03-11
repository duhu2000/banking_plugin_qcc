# 5-Year SaaS Revenue Model Specification

## 1. Model Overview

A bottoms-up SaaS revenue model projecting annual recurring revenue (ARR), monthly recurring revenue (MRR), net revenue after churn, and key SaaS metrics across a 5-year horizon (Year 1 through Year 5).

**Core Assumptions:**
- Starting customers (Year 1): 500
- Starting monthly price: $200
- Annual customer growth rate: 20%
- Annual price increase: 5%
- Monthly churn rate: 2%

---

## 2. Workbook Structure

The model uses a single-workbook, multi-sheet architecture:

| Sheet Name | Purpose |
|---|---|
| `Assumptions` | All input parameters (single source of truth) |
| `Customer_Model` | Customer acquisition, churn, and net customer counts |
| `Pricing_Model` | Price escalation schedule |
| `Revenue_Model` | MRR, ARR, and net revenue calculations |
| `SaaS_Metrics` | Derived KPIs (LTV, CAC payback context, net retention, etc.) |
| `Summary_Dashboard` | Executive view with key outputs |

---

## 3. Sheet 1: Assumptions

All hardcoded inputs live here. Every other sheet references these cells -- no magic numbers anywhere else.

### Named Ranges

| Named Range | Cell | Value | Description |
|---|---|---|---|
| `starting_customers` | B3 | 500 | Number of paying customers at start of Year 1 |
| `starting_monthly_price` | B4 | $200.00 | Monthly subscription price per customer in Year 1 |
| `annual_customer_growth_rate` | B5 | 20% | Year-over-year customer growth rate |
| `annual_price_increase_rate` | B6 | 5% | Annual price escalation applied at start of each new year |
| `monthly_churn_rate` | B7 | 2% | Percentage of customers lost per month |
| `model_years` | B8 | 5 | Number of projection years |
| `months_per_year` | B9 | 12 | Constant (months in a year) |

### Derived Assumption Calculations

| Named Range | Cell | Formula | Description |
|---|---|---|---|
| `annual_churn_rate` | B11 | `=1-(1-monthly_churn_rate)^months_per_year` | Annualized churn rate from monthly churn |
| `annual_retention_rate` | B12 | `=1-annual_churn_rate` | Annual customer retention rate |
| `implied_avg_lifetime_months` | B13 | `=1/monthly_churn_rate` | Average customer lifetime in months |

**Calculated values at 2% monthly churn:**
- `annual_churn_rate` = 1 - (1-0.02)^12 = 1 - 0.7847 = **21.53%**
- `annual_retention_rate` = **78.47%**
- `implied_avg_lifetime_months` = 1/0.02 = **50 months**

---

## 4. Sheet 2: Customer_Model

Projects customer counts on a **monthly basis** within each year, then summarizes annually.

### Layout

- **Row 1:** Headers
- **Row 2:** Year labels (Year 1 through Year 5)
- **Rows 4-15 per year block:** Monthly detail (Month 1 through Month 12)
- **Columns:** Month | BoM Customers | New Customers Added | Churned Customers | EoM Customers

For simplicity in specification, the annual summary table is defined below. The monthly granularity follows the same logic at 1-month intervals.

### Annual Summary Named Ranges

Column layout: A = Year Label, B through F = Year 1 through Year 5 (columns B-F, row 3 onward).

| Named Range | Applies To | Description |
|---|---|---|
| `bom_customers_Y[n]` | Row 3 | Beginning-of-year customer count |
| `gross_new_customers_Y[n]` | Row 4 | New customers acquired during the year |
| `churned_customers_Y[n]` | Row 5 | Customers lost to churn during the year |
| `eom_customers_Y[n]` | Row 6 | End-of-year customer count |
| `avg_customers_Y[n]` | Row 7 | Average customers during the year (for revenue calc) |

### Monthly Detail Formulas (within each year)

For Year `n`, Month `m` (m = 1 to 12):

| Field | Formula (Month 1 of Year n) | Formula (Months 2-12 of Year n) |
|---|---|---|
| BoM Customers | `=eom_customers_Y[n-1]` (or `starting_customers` for Y1M1) | `= Previous month EoM Customers` |
| New Customers This Month | `= BoM_Customers * (annual_customer_growth_rate / months_per_year)` | Same formula |
| Churned Customers This Month | `= BoM_Customers * monthly_churn_rate` | Same formula |
| EoM Customers | `= BoM_Customers + New_Customers - Churned_Customers` | Same formula |

> **Design Note:** New customer additions are spread evenly across 12 months. This is a simplifying assumption -- the monthly new-add rate is `annual_customer_growth_rate / 12` applied to BoM customers. More precisely, to hit ~20% net growth *before churn*, we add `(annual_customer_growth_rate / 12) * BoM` each month. The interplay with churn means net growth will be lower than 20%.

### Annual Summary Formulas

| Field | Year 1 Formula | Year 2-5 Formula |
|---|---|---|
| `bom_customers_Y[n]` | `=starting_customers` | `=eom_customers_Y[n-1]` |
| `gross_new_customers_Y[n]` | `=SUM(monthly new customers, M1:M12)` | Same |
| `churned_customers_Y[n]` | `=SUM(monthly churned customers, M1:M12)` | Same |
| `eom_customers_Y[n]` | `= Month 12 EoM Customers` | Same |
| `avg_customers_Y[n]` | `=AVERAGE(all 12 monthly BoM values, EoM of Month 12) / 2` simplified as `=(bom_customers_Y[n] + eom_customers_Y[n]) / 2` | Same |

### Projected Customer Counts (Approximate)

Running the monthly model iteratively:

| Metric | Year 1 | Year 2 | Year 3 | Year 4 | Year 5 |
|---|---|---|---|---|---|
| BoM Customers | 500 | 490 | 480 | 471 | 462 |
| Monthly Growth Rate | 1.67% | 1.67% | 1.67% | 1.67% | 1.67% |
| Monthly Churn Rate | 2.00% | 2.00% | 2.00% | 2.00% | 2.00% |
| Net Monthly Rate | -0.33% | -0.33% | -0.33% | -0.33% | -0.33% |
| EoM Customers (approx) | ~490 | ~480 | ~471 | ~462 | ~453 |

> **Important Observation:** With 20% annual growth spread monthly (1.67%/mo) and 2% monthly churn, the net monthly rate is approximately -0.33%, meaning the customer base **slowly declines**. This is a critical finding: the specified growth rate does not overcome the churn rate. The model faithfully represents this dynamic. If the intent is 20% *net* growth, the gross acquisition rate must be higher (see SaaS_Metrics sheet for the required gross rate).

### Alternative Interpretation: 20% Net Growth (Gross Additions to Overcome Churn)

If the 20% growth is intended as *net* customer growth YoY, then new customer additions must compensate for churn:

| Named Range | Cell | Formula |
|---|---|---|
| `required_gross_monthly_add_rate` | Assumptions!B15 | `=monthly_churn_rate + (((1+annual_customer_growth_rate)^(1/12))-1)` |

This yields approximately: `0.02 + 0.01531 = 0.03531` or **3.53% of BoM per month** must be added as new customers.

**The model below implements BOTH interpretations as toggleable scenarios via a named range:**

| Named Range | Cell | Value | Description |
|---|---|---|---|
| `growth_interpretation` | Assumptions!B16 | 1 | 1 = Gross add rate (20% is the add rate), 2 = Net growth target (20% is the net outcome) |

---

## 5. Sheet 3: Pricing_Model

### Named Ranges

| Named Range | Applies To | Description |
|---|---|---|
| `monthly_price_Y[n]` | Row 3, Cols B-F | Monthly price per customer for Year n |
| `annual_price_Y[n]` | Row 4, Cols B-F | Annualized price per customer for Year n |

### Formulas

| Field | Year 1 | Year 2-5 |
|---|---|---|
| `monthly_price_Y1` | `=starting_monthly_price` | `=monthly_price_Y[n-1] * (1 + annual_price_increase_rate)` |
| `annual_price_Y[n]` | `=monthly_price_Y[n] * months_per_year` | Same |

### Projected Prices

| Metric | Year 1 | Year 2 | Year 3 | Year 4 | Year 5 |
|---|---|---|---|---|---|
| Monthly Price | $200.00 | $210.00 | $220.50 | $231.53 | $243.10 |
| Annual Price | $2,400.00 | $2,520.00 | $2,646.00 | $2,778.30 | $2,917.22 |

---

## 6. Sheet 4: Revenue_Model

The core financial output sheet. Revenue is calculated monthly (price x customers) then rolled up annually.

### Monthly Detail Layout (per year block)

For Year `n`, Month `m`:

| Column | Named Pattern | Formula |
|---|---|---|
| A | Month label | "M1", "M2", ... "M12" |
| B | `customers_Y[n]_M[m]` | From Customer_Model monthly EoM (or BoM, depending on convention -- here we use **BoM** to be conservative) |
| C | `monthly_price_Y[n]` | From Pricing_Model (constant within a year) |
| D | `monthly_revenue_Y[n]_M[m]` | `= customers_Y[n]_M[m] * monthly_price_Y[n]` |

### Annual Summary Named Ranges

| Named Range | Row | Year 1 Formula | Year 2-5 Formula |
|---|---|---|---|
| `total_MRR_start_Y[n]` | 3 | `=starting_customers * starting_monthly_price` | `=eom_customers_Y[n-1] * monthly_price_Y[n]` |
| `total_MRR_end_Y[n]` | 4 | `=eom_customers_Y1 * monthly_price_Y1` | `=eom_customers_Y[n] * monthly_price_Y[n]` |
| `avg_MRR_Y[n]` | 5 | `=(total_MRR_start_Y[n] + total_MRR_end_Y[n]) / 2` | Same |
| `annual_revenue_Y[n]` | 6 | `=SUM(all 12 monthly revenues for Year n)` | Same |
| `ARR_start_Y[n]` | 7 | `=total_MRR_start_Y[n] * 12` | Same |
| `ARR_end_Y[n]` | 8 | `=total_MRR_end_Y[n] * 12` | Same |

### Revenue Decomposition (Annual)

| Named Range | Row | Formula | Description |
|---|---|---|---|
| `existing_customer_revenue_Y[n]` | 10 | `=SUM of (BoM customers each month * monthly_price)` considering only customers present at BoM of Year n | Revenue from customers who started the year |
| `expansion_revenue_Y[n]` | 11 | `=annual_revenue_Y[n] - annual_revenue_Y[n-1]` (Year 2+) | Net new revenue vs prior year |
| `churned_revenue_Y[n]` | 12 | `=churned_customers_Y[n] * monthly_price_Y[n] * avg_months_remaining` | Revenue lost to churn (estimated) |
| `new_customer_revenue_Y[n]` | 13 | `=SUM of (new customers each month * monthly_price * remaining_months)` | Revenue from newly acquired customers |
| `price_increase_revenue_Y[n]` | 14 | `=bom_customers_Y[n] * (monthly_price_Y[n] - monthly_price_Y[n-1]) * 12` (Year 2+) | Revenue uplift from price increases on existing base |

### Projected Annual Revenue (Scenario 1: Growth = Gross Add Rate)

| Metric | Year 1 | Year 2 | Year 3 | Year 4 | Year 5 |
|---|---|---|---|---|---|
| Starting MRR | $100,000 | ~$98,000 | ~$100,800 | ~$103,700 | ~$106,800 |
| Ending MRR | ~$98,000 | ~$100,800 | ~$103,700 | ~$106,800 | ~$109,900 |
| Annual Revenue (approx) | ~$1,188,000 | ~$1,191,000 | ~$1,225,000 | ~$1,261,000 | ~$1,298,000 |
| ARR (ending) | ~$1,176,000 | ~$1,209,600 | ~$1,244,400 | ~$1,281,600 | ~$1,318,800 |

### Projected Annual Revenue (Scenario 2: Growth = 20% Net Customer Growth Target)

| Metric | Year 1 | Year 2 | Year 3 | Year 4 | Year 5 |
|---|---|---|---|---|---|
| Starting MRR | $100,000 | $120,000 | $151,200 | $190,512 | $239,945 |
| Ending MRR | $120,000 | $151,200 | $190,512 | $239,945 | $302,331 |
| Annual Revenue (approx) | ~$1,296,000 | ~$1,632,960 | ~$2,057,530 | ~$2,592,487 | ~$3,266,534 |
| ARR (ending) | $1,440,000 | $1,814,400 | $2,286,144 | $2,879,340 | $3,627,966 |

> **Note:** Scenario 2 reflects the compounding power of 20% net growth + 5% price increases, yielding ~2.5x revenue growth over 5 years.

---

## 7. Sheet 5: SaaS_Metrics

Key SaaS performance indicators derived from the Customer and Revenue models.

### Named Ranges and Formulas

| Named Range | Formula | Description |
|---|---|---|
| `net_revenue_retention_Y[n]` | `=(annual_revenue_Y[n] from Y[n-1] cohort + price_increase_revenue_Y[n]) / annual_revenue_Y[n-1]` | NRR -- revenue from prior-year customers as % of prior-year revenue |
| `gross_revenue_retention_Y[n]` | `=(annual_revenue_Y[n-1] - churned_revenue_Y[n]) / annual_revenue_Y[n-1]` | GRR -- revenue retained before expansion |
| `logo_retention_rate_Y[n]` | `=1 - (churned_customers_Y[n] / bom_customers_Y[n])` | Customer (logo) retention rate |
| `customer_lifetime_value` | `= (starting_monthly_price / monthly_churn_rate)` | LTV in revenue terms (simplified) |
| `avg_revenue_per_customer_Y[n]` | `=annual_revenue_Y[n] / avg_customers_Y[n]` | ARPC for the year |
| `MRR_growth_rate_Y[n]` | `=(total_MRR_end_Y[n] - total_MRR_start_Y[n]) / total_MRR_start_Y[n]` | MRR growth within the year |
| `yoy_revenue_growth_Y[n]` | `=(annual_revenue_Y[n] - annual_revenue_Y[n-1]) / annual_revenue_Y[n-1]` | Year-over-year revenue growth |
| `cumulative_revenue_Y[n]` | `=SUM(annual_revenue_Y1 : annual_revenue_Y[n])` | Running total revenue |
| `required_gross_add_rate_for_net_target` | `=monthly_churn_rate + ((1+annual_customer_growth_rate)^(1/12) - 1)` | Monthly gross add rate needed to achieve 20% net growth after churn |
| `implied_annual_churn_rate` | `=1 - (1 - monthly_churn_rate)^12` | Annualized churn from monthly rate |
| `monthly_net_growth_rate_Y[n]` | `=(eom_customers_Y[n] / bom_customers_Y[n])^(1/12) - 1` | Implied monthly net growth |

### Projected Key Metrics (Scenario 2: Net Growth Interpretation)

| Metric | Year 1 | Year 2 | Year 3 | Year 4 | Year 5 |
|---|---|---|---|---|---|
| YoY Revenue Growth | -- | ~26.0% | ~26.0% | ~26.0% | ~26.0% |
| Net Revenue Retention | -- | ~105% | ~105% | ~105% | ~105% |
| Gross Revenue Retention | -- | ~78.5% | ~78.5% | ~78.5% | ~78.5% |
| Customer LTV | $10,000 | $10,000 | $10,000 | $10,000 | $10,000 |
| Avg Revenue Per Customer | $2,400 | $2,520 | $2,646 | $2,778 | $2,917 |
| Cumulative Revenue | ~$1.3M | ~$2.9M | ~$5.0M | ~$7.6M | ~$10.8M |

> **Note:** YoY revenue growth of ~26% comes from the compounding of 20% customer growth and 5% price increases: `(1.20 * 1.05) - 1 = 26%`.

---

## 8. Sheet 6: Summary_Dashboard

Executive-level view consolidating the most important outputs.

### Layout

| Row | Content | Source |
|---|---|---|
| 1 | Title: "5-Year SaaS Revenue Model -- Executive Summary" | Static |
| 3-8 | **Key Assumptions Panel** | Links to Assumptions sheet |
| 10-16 | **Annual Revenue Summary Table** | Links to Revenue_Model |
| 18-24 | **Customer Count Summary Table** | Links to Customer_Model |
| 26-32 | **SaaS Metrics Table** | Links to SaaS_Metrics |
| 34+ | **Charts placeholder** (MRR trend, customer count, revenue waterfall) | -- |

### Key Assumptions Panel

| Cell | Label | Formula |
|---|---|---|
| B4 | Starting Customers | `=starting_customers` |
| B5 | Starting Monthly Price | `=starting_monthly_price` |
| B6 | Annual Growth Rate | `=annual_customer_growth_rate` |
| B7 | Annual Price Increase | `=annual_price_increase_rate` |
| B8 | Monthly Churn Rate | `=monthly_churn_rate` |

### Annual Revenue Summary Table (Row 10+)

| Column | Year 1 | Year 2 | Year 3 | Year 4 | Year 5 |
|---|---|---|---|---|---|
| ARR (End of Year) | `=ARR_end_Y1` | `=ARR_end_Y2` | `=ARR_end_Y3` | `=ARR_end_Y4` | `=ARR_end_Y5` |
| Total Annual Revenue | `=annual_revenue_Y1` | `=annual_revenue_Y2` | `=annual_revenue_Y3` | `=annual_revenue_Y4` | `=annual_revenue_Y5` |
| YoY Growth | `="N/A"` | `=yoy_revenue_growth_Y2` | `=yoy_revenue_growth_Y3` | `=yoy_revenue_growth_Y4` | `=yoy_revenue_growth_Y5` |

---

## 9. Complete Named Range Registry

Master list of all named ranges in the workbook for auditing and cross-referencing.

### Global Input Ranges (Assumptions Sheet)

| # | Named Range | Sheet!Cell | Type |
|---|---|---|---|
| 1 | `starting_customers` | Assumptions!B3 | Input |
| 2 | `starting_monthly_price` | Assumptions!B4 | Input |
| 3 | `annual_customer_growth_rate` | Assumptions!B5 | Input |
| 4 | `annual_price_increase_rate` | Assumptions!B6 | Input |
| 5 | `monthly_churn_rate` | Assumptions!B7 | Input |
| 6 | `model_years` | Assumptions!B8 | Input |
| 7 | `months_per_year` | Assumptions!B9 | Constant |
| 8 | `annual_churn_rate` | Assumptions!B11 | Derived |
| 9 | `annual_retention_rate` | Assumptions!B12 | Derived |
| 10 | `implied_avg_lifetime_months` | Assumptions!B13 | Derived |
| 11 | `growth_interpretation` | Assumptions!B16 | Input (toggle) |
| 12 | `required_gross_monthly_add_rate` | Assumptions!B15 | Derived |

### Customer Model Ranges

| # | Named Range | Sheet!Cell Range | Type |
|---|---|---|---|
| 13 | `bom_customers_Y1` | Customer_Model!B3 | Calculated |
| 14 | `bom_customers_Y2` | Customer_Model!C3 | Calculated |
| 15 | `bom_customers_Y3` | Customer_Model!D3 | Calculated |
| 16 | `bom_customers_Y4` | Customer_Model!E3 | Calculated |
| 17 | `bom_customers_Y5` | Customer_Model!F3 | Calculated |
| 18 | `eom_customers_Y1` | Customer_Model!B6 | Calculated |
| 19 | `eom_customers_Y2` | Customer_Model!C6 | Calculated |
| 20 | `eom_customers_Y3` | Customer_Model!D6 | Calculated |
| 21 | `eom_customers_Y4` | Customer_Model!E6 | Calculated |
| 22 | `eom_customers_Y5` | Customer_Model!F6 | Calculated |
| 23 | `gross_new_customers_Y1` | Customer_Model!B4 | Calculated |
| 24 | `gross_new_customers_Y2` | Customer_Model!C4 | Calculated |
| 25 | `gross_new_customers_Y3` | Customer_Model!D4 | Calculated |
| 26 | `gross_new_customers_Y4` | Customer_Model!E4 | Calculated |
| 27 | `gross_new_customers_Y5` | Customer_Model!F4 | Calculated |
| 28 | `churned_customers_Y1` | Customer_Model!B5 | Calculated |
| 29 | `churned_customers_Y2` | Customer_Model!C5 | Calculated |
| 30 | `churned_customers_Y3` | Customer_Model!D5 | Calculated |
| 31 | `churned_customers_Y4` | Customer_Model!E5 | Calculated |
| 32 | `churned_customers_Y5` | Customer_Model!F5 | Calculated |
| 33 | `avg_customers_Y1` | Customer_Model!B7 | Calculated |
| 34 | `avg_customers_Y2` | Customer_Model!C7 | Calculated |
| 35 | `avg_customers_Y3` | Customer_Model!D7 | Calculated |
| 36 | `avg_customers_Y4` | Customer_Model!E7 | Calculated |
| 37 | `avg_customers_Y5` | Customer_Model!F7 | Calculated |

### Monthly Detail Ranges (per year -- using Year 1 as template)

| # | Named Range Pattern | Sheet!Cell Range | Type |
|---|---|---|---|
| 38-49 | `customers_Y1_M[1-12]` | Customer_Model!B20:B31 | Calculated |
| 50-61 | `new_customers_Y1_M[1-12]` | Customer_Model!C20:C31 | Calculated |
| 62-73 | `churned_customers_Y1_M[1-12]` | Customer_Model!D20:D31 | Calculated |
| 74-85 | `eom_customers_Y1_M[1-12]` | Customer_Model!E20:E31 | Calculated |

> Repeat pattern for Y2 (rows 34-45), Y3 (rows 48-59), Y4 (rows 62-73), Y5 (rows 76-87).

### Pricing Model Ranges

| # | Named Range | Sheet!Cell | Type |
|---|---|---|---|
| 86 | `monthly_price_Y1` | Pricing_Model!B3 | Calculated |
| 87 | `monthly_price_Y2` | Pricing_Model!C3 | Calculated |
| 88 | `monthly_price_Y3` | Pricing_Model!D3 | Calculated |
| 89 | `monthly_price_Y4` | Pricing_Model!E3 | Calculated |
| 90 | `monthly_price_Y5` | Pricing_Model!F3 | Calculated |
| 91 | `annual_price_Y1` | Pricing_Model!B4 | Calculated |
| 92 | `annual_price_Y2` | Pricing_Model!C4 | Calculated |
| 93 | `annual_price_Y3` | Pricing_Model!D4 | Calculated |
| 94 | `annual_price_Y4` | Pricing_Model!E4 | Calculated |
| 95 | `annual_price_Y5` | Pricing_Model!F4 | Calculated |

### Revenue Model Ranges

| # | Named Range | Sheet!Cell | Type |
|---|---|---|---|
| 96 | `total_MRR_start_Y1` | Revenue_Model!B3 | Calculated |
| 97 | `total_MRR_start_Y2` | Revenue_Model!C3 | Calculated |
| 98 | `total_MRR_start_Y3` | Revenue_Model!D3 | Calculated |
| 99 | `total_MRR_start_Y4` | Revenue_Model!E3 | Calculated |
| 100 | `total_MRR_start_Y5` | Revenue_Model!F3 | Calculated |
| 101 | `total_MRR_end_Y1` | Revenue_Model!B4 | Calculated |
| 102 | `total_MRR_end_Y2` | Revenue_Model!C4 | Calculated |
| 103 | `total_MRR_end_Y3` | Revenue_Model!D4 | Calculated |
| 104 | `total_MRR_end_Y4` | Revenue_Model!E4 | Calculated |
| 105 | `total_MRR_end_Y5` | Revenue_Model!F4 | Calculated |
| 106 | `avg_MRR_Y1` | Revenue_Model!B5 | Calculated |
| 107 | `avg_MRR_Y2` | Revenue_Model!C5 | Calculated |
| 108 | `avg_MRR_Y3` | Revenue_Model!D5 | Calculated |
| 109 | `avg_MRR_Y4` | Revenue_Model!E5 | Calculated |
| 110 | `avg_MRR_Y5` | Revenue_Model!F5 | Calculated |
| 111 | `annual_revenue_Y1` | Revenue_Model!B6 | Calculated |
| 112 | `annual_revenue_Y2` | Revenue_Model!C6 | Calculated |
| 113 | `annual_revenue_Y3` | Revenue_Model!D6 | Calculated |
| 114 | `annual_revenue_Y4` | Revenue_Model!E6 | Calculated |
| 115 | `annual_revenue_Y5` | Revenue_Model!F6 | Calculated |
| 116 | `ARR_start_Y1` | Revenue_Model!B7 | Calculated |
| 117 | `ARR_start_Y2` | Revenue_Model!C7 | Calculated |
| 118 | `ARR_start_Y3` | Revenue_Model!D7 | Calculated |
| 119 | `ARR_start_Y4` | Revenue_Model!E7 | Calculated |
| 120 | `ARR_start_Y5` | Revenue_Model!F7 | Calculated |
| 121 | `ARR_end_Y1` | Revenue_Model!B8 | Calculated |
| 122 | `ARR_end_Y2` | Revenue_Model!C8 | Calculated |
| 123 | `ARR_end_Y3` | Revenue_Model!D8 | Calculated |
| 124 | `ARR_end_Y4` | Revenue_Model!E8 | Calculated |
| 125 | `ARR_end_Y5` | Revenue_Model!F8 | Calculated |
| 126 | `expansion_revenue_Y2` | Revenue_Model!C11 | Calculated |
| 127 | `expansion_revenue_Y3` | Revenue_Model!D11 | Calculated |
| 128 | `expansion_revenue_Y4` | Revenue_Model!E11 | Calculated |
| 129 | `expansion_revenue_Y5` | Revenue_Model!F11 | Calculated |
| 130 | `churned_revenue_Y1` | Revenue_Model!B12 | Calculated |
| 131 | `churned_revenue_Y2` | Revenue_Model!C12 | Calculated |
| 132 | `churned_revenue_Y3` | Revenue_Model!D12 | Calculated |
| 133 | `churned_revenue_Y4` | Revenue_Model!E12 | Calculated |
| 134 | `churned_revenue_Y5` | Revenue_Model!F12 | Calculated |
| 135 | `new_customer_revenue_Y1` | Revenue_Model!B13 | Calculated |
| 136 | `new_customer_revenue_Y2` | Revenue_Model!C13 | Calculated |
| 137 | `new_customer_revenue_Y3` | Revenue_Model!D13 | Calculated |
| 138 | `new_customer_revenue_Y4` | Revenue_Model!E13 | Calculated |
| 139 | `new_customer_revenue_Y5` | Revenue_Model!F13 | Calculated |
| 140 | `price_increase_revenue_Y2` | Revenue_Model!C14 | Calculated |
| 141 | `price_increase_revenue_Y3` | Revenue_Model!D14 | Calculated |
| 142 | `price_increase_revenue_Y4` | Revenue_Model!E14 | Calculated |
| 143 | `price_increase_revenue_Y5` | Revenue_Model!F14 | Calculated |

### SaaS Metrics Ranges

| # | Named Range | Sheet!Cell | Type |
|---|---|---|---|
| 144 | `net_revenue_retention_Y2` | SaaS_Metrics!C3 | Calculated |
| 145 | `net_revenue_retention_Y3` | SaaS_Metrics!D3 | Calculated |
| 146 | `net_revenue_retention_Y4` | SaaS_Metrics!E3 | Calculated |
| 147 | `net_revenue_retention_Y5` | SaaS_Metrics!F3 | Calculated |
| 148 | `gross_revenue_retention_Y2` | SaaS_Metrics!C4 | Calculated |
| 149 | `gross_revenue_retention_Y3` | SaaS_Metrics!D4 | Calculated |
| 150 | `gross_revenue_retention_Y4` | SaaS_Metrics!E4 | Calculated |
| 151 | `gross_revenue_retention_Y5` | SaaS_Metrics!F4 | Calculated |
| 152 | `customer_lifetime_value` | SaaS_Metrics!B6 | Calculated |
| 153 | `yoy_revenue_growth_Y2` | SaaS_Metrics!C8 | Calculated |
| 154 | `yoy_revenue_growth_Y3` | SaaS_Metrics!D8 | Calculated |
| 155 | `yoy_revenue_growth_Y4` | SaaS_Metrics!E8 | Calculated |
| 156 | `yoy_revenue_growth_Y5` | SaaS_Metrics!F8 | Calculated |
| 157 | `cumulative_revenue_Y1` | SaaS_Metrics!B9 | Calculated |
| 158 | `cumulative_revenue_Y2` | SaaS_Metrics!C9 | Calculated |
| 159 | `cumulative_revenue_Y3` | SaaS_Metrics!D9 | Calculated |
| 160 | `cumulative_revenue_Y4` | SaaS_Metrics!E9 | Calculated |
| 161 | `cumulative_revenue_Y5` | SaaS_Metrics!F9 | Calculated |

**Total Named Ranges: 161**

---

## 10. Formula Dependency Map

```
Assumptions (Inputs)
  |
  +---> Pricing_Model
  |       monthly_price_Y[n] = f(starting_monthly_price, annual_price_increase_rate)
  |       annual_price_Y[n] = f(monthly_price_Y[n])
  |
  +---> Customer_Model
  |       Monthly loop: BoM -> +New -Churn -> EoM
  |       f(starting_customers, annual_customer_growth_rate, monthly_churn_rate)
  |       |
  |       +---> Annual summaries (bom, eom, gross_new, churned, avg)
  |
  +---> Revenue_Model
          f(Customer_Model, Pricing_Model)
          |
          +---> MRR = customers * monthly_price
          +---> ARR = MRR * 12
          +---> Annual Revenue = SUM(monthly revenues)
          +---> Revenue decomposition (new, churned, expansion, price increase)
          |
          +---> SaaS_Metrics
                  f(Revenue_Model, Customer_Model)
                  |
                  +---> NRR, GRR, LTV, YoY Growth, Cumulative
                  |
                  +---> Summary_Dashboard
                          f(all sheets -- display only, no new calculations)
```

---

## 11. Formatting Specifications

| Element | Format |
|---|---|
| Currency values | `$#,##0` (no decimals for large figures) or `$#,##0.00` (for per-unit prices) |
| Percentages | `0.0%` or `0.00%` |
| Customer counts | `#,##0` (whole numbers, comma-separated) |
| Input cells | Light blue fill (`#DCE6F1`), black font, thin border |
| Calculated cells | No fill, black font |
| Output/summary cells | Bold font |
| Negative values (churn) | Red font, parentheses: `($#,##0)` |
| Sheet tab colors | Assumptions=Blue, Customer=Green, Pricing=Orange, Revenue=Dark Blue, Metrics=Purple, Dashboard=Black |

---

## 12. Validation Rules

| Rule | Implementation |
|---|---|
| Churn rate bounds | `monthly_churn_rate` must be between 0% and 100% (Data Validation) |
| Growth rate bounds | `annual_customer_growth_rate` must be between 0% and 500% |
| Price floor | `starting_monthly_price` must be > 0 |
| Customer floor | `starting_customers` must be >= 1 (integer) |
| Balance check | For each month: `EoM = BoM + New - Churned` (tolerance < $0.01) |
| Revenue cross-check | `annual_revenue_Y[n]` must equal `SUM(12 monthly revenues)` exactly |
| ARR consistency | `ARR_end_Y[n]` must equal `total_MRR_end_Y[n] * 12` exactly |

---

## 13. Scenario Analysis Framework

The model supports sensitivity analysis by varying key assumptions:

| Scenario | Monthly Churn | Annual Growth | Price Increase |
|---|---|---|---|
| Base Case | 2.0% | 20% | 5% |
| Optimistic | 1.5% | 30% | 7% |
| Pessimistic | 3.0% | 10% | 3% |
| High Growth / High Churn | 2.5% | 40% | 5% |
| Stable / Low Growth | 1.0% | 10% | 3% |

These can be implemented via Excel Data Tables (one-variable or two-variable) referencing the Assumptions sheet inputs, or via a scenario selector dropdown that overwrites the assumption cells using `INDEX/MATCH` against a scenario table.

---

## 14. Critical Model Insight

**The tension between 20% annual growth and 2% monthly churn is the central dynamic of this model.**

- 2% monthly churn annualizes to ~21.53% customer loss per year
- If "20% growth" means gross customer additions = 20% of BoM, then net customer change is approximately -1.53% per year (customer base shrinks)
- If "20% growth" means net customer growth of 20%, then gross additions must be ~42.4% of BoM annually (3.53% monthly) to overcome churn

The model is designed to expose this tension explicitly rather than hide it. The `growth_interpretation` toggle on the Assumptions sheet lets the user choose which interpretation to model, and the SaaS_Metrics sheet shows the `required_gross_monthly_add_rate` needed to achieve the net growth target under either interpretation.

This is the single most important analytical insight the model provides: **at 2% monthly churn, customer acquisition must be aggressive just to maintain the base, let alone grow it.**
