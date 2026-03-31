# What-If Sensitivity Analysis: Year 3 EBITDA

**Source Model:** `idfa_compliant_model.xlsx`
**Date:** 2026-03-11

---

## Model Structure

The financial model uses a 3-year projection with the following assumptions driving calculations:

| Assumption | Base Value |
|---|---|
| Revenue Year 1 | $10,000,000 |
| Revenue Growth Rate | 10% |
| COGS % Year 1 | 60% |
| COGS Efficiency Gain/yr | 1% (COGS % decreases by 1pp each year) |
| OpEx Year 1 | $2,000,000 |
| OpEx Growth Rate | 5% |

**Calculation Logic (from Excel formulas):**
- Revenue compounds at the growth rate each year
- COGS % decreases linearly by the efficiency gain each year
- COGS $ = Revenue x COGS %
- Gross Profit = Revenue - COGS
- OpEx compounds at 5% per year
- EBITDA = Gross Profit - OpEx

---

## Scenarios Tested

| # | Scenario | Revenue Growth | COGS Efficiency Gain/yr |
|---|---|---|---|
| 0 | **Base Case** | 10% | 1.0% |
| A | Revenue growth drop | **5%** | 1.0% |
| B | Revenue growth drop + weaker COGS improvement | **5%** | **0.5%** |

---

## Full Projections

### Base Case (Rev Growth 10%, COGS Efficiency 1%/yr)

| Metric | Year 1 | Year 2 | Year 3 |
|---|---:|---:|---:|
| Revenue | $10,000,000 | $11,000,000 | $12,100,000 |
| COGS % | 60.0% | 59.0% | 58.0% |
| COGS | $6,000,000 | $6,490,000 | $7,018,000 |
| Gross Profit | $4,000,000 | $4,510,000 | $5,082,000 |
| OpEx | $2,000,000 | $2,100,000 | $2,205,000 |
| **EBITDA** | **$2,000,000** | **$2,410,000** | **$2,877,000** |

### Scenario A: Revenue Growth Drops to 5% (COGS efficiency unchanged at 1%/yr)

| Metric | Year 1 | Year 2 | Year 3 |
|---|---:|---:|---:|
| Revenue | $10,000,000 | $10,500,000 | $11,025,000 |
| COGS % | 60.0% | 59.0% | 58.0% |
| COGS | $6,000,000 | $6,195,000 | $6,394,500 |
| Gross Profit | $4,000,000 | $4,305,000 | $4,630,500 |
| OpEx | $2,000,000 | $2,100,000 | $2,205,000 |
| **EBITDA** | **$2,000,000** | **$2,205,000** | **$2,425,500** |

### Scenario B: Revenue Growth 5% + COGS Efficiency Drops to 0.5%/yr

| Metric | Year 1 | Year 2 | Year 3 |
|---|---:|---:|---:|
| Revenue | $10,000,000 | $10,500,000 | $11,025,000 |
| COGS % | 60.0% | 59.5% | 59.0% |
| COGS | $6,000,000 | $6,247,500 | $6,504,750 |
| Gross Profit | $4,000,000 | $4,252,500 | $4,520,250 |
| OpEx | $2,000,000 | $2,100,000 | $2,205,000 |
| **EBITDA** | **$2,000,000** | **$2,152,500** | **$2,315,250** |

---

## Year 3 EBITDA Sensitivity Summary

| Metric | Base Case | Scenario A | Scenario B |
|---|---:|---:|---:|
| **Year 3 EBITDA** | **$2,877,000** | **$2,425,500** | **$2,315,250** |
| Delta vs Base | -- | -$451,500 | -$561,750 |
| % Change vs Base | -- | -15.7% | -19.5% |
| EBITDA Margin (Y3) | 23.8% | 22.0% | 21.0% |

### Decomposition of Impact

| Driver | Y3 EBITDA Impact | Explanation |
|---|---:|---|
| Revenue growth: 10% to 5% | **-$451,500** | Lower revenue compounds across years; since COGS is proportional, the gross profit delta is (Revenue delta x Gross Margin). OpEx is unchanged. |
| COGS efficiency: 1% to 0.5%/yr (incremental) | **-$110,250** | With 0.5% less COGS improvement per year, Y3 COGS % is 59.0% instead of 58.0%. Applied to $11,025,000 revenue = $110,250 additional cost. |
| **Combined total impact** | **-$561,750** | Y3 EBITDA falls from $2,877,000 to $2,315,250 -- a 19.5% decline. |

---

## Key Takeaways

1. **Revenue growth is the dominant sensitivity lever.** Cutting revenue growth in half (10% to 5%) alone destroys $451,500 of Year 3 EBITDA -- 80% of the total combined impact.

2. **COGS efficiency is a meaningful but secondary lever.** Halving the annual COGS improvement (1% to 0.5%) adds another $110,250 of EBITDA erosion -- 20% of the combined impact.

3. **The combined scenario is not catastrophic but material.** Year 3 EBITDA of $2,315,250 is still positive and growing year-over-year, but represents a 19.5% decline from the base case. EBITDA margin compresses from 23.8% to 21.0%.

4. **OpEx is a fixed drag in this model.** Because OpEx grows at 5% regardless of revenue, lower revenue growth means OpEx consumes a larger share of gross profit. This is the structural reason the revenue growth sensitivity is so pronounced.
