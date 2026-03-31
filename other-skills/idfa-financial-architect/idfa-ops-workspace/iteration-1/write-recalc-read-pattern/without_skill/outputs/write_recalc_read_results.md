# Write-Recalc-Read Pattern Results (Without Skill)

## Scenario

**Change:** Unit Price increased from $100 to $150 (+50%)

All other assumptions held constant:
| Assumption | Value |
|---|---|
| Units Sold Year 1 | 50,000 |
| Units Growth Rate | 15% |
| Variable Cost Per Unit | $40 |
| Fixed Costs | $1,000,000.00 |
| Tax Rate | 30% |

## Full P&L Comparison

| Metric | Year 1 (Baseline) | Year 1 (Modified) | Year 1 Delta | Year 2 (Baseline) | Year 2 (Modified) | Year 2 Delta |
|---|---|---|---|---|---|---|
| Units Sold | 50,000 | 50,000 | +0.0% | 57,500 | 57,500 | +0.0% |
| Revenue | $5,000,000.00 | $7,500,000.00 | +50.0% | $5,750,000.00 | $8,625,000.00 | +50.0% |
| Variable Costs | $2,000,000.00 | $2,000,000.00 | +0.0% | $2,300,000.00 | $2,300,000.00 | +0.0% |
| Contribution Margin | $3,000,000.00 | $5,500,000.00 | +83.3% | $3,450,000.00 | $6,325,000.00 | +83.3% |
| EBIT | $2,000,000.00 | $4,500,000.00 | +125.0% | $2,450,000.00 | $5,325,000.00 | +117.3% |
| Tax | $600,000.00 | $1,350,000.00 | +125.0% | $735,000.00 | $1,597,500.00 | +117.3% |
| **Net Income** | **$1,400,000.00** | **$3,150,000.00** | **+125.0%** | **$1,715,000.00** | **$3,727,500.00** | **+117.3%** |

## Net Income Focus

| | Baseline (Price=$100) | Modified (Price=$150) | Change ($) | Change (%) |
|---|---|---|---|---|
| **Year 1 Net Income** | $1,400,000.00 | $3,150,000.00 | $1,750,000.00 | +125.0% |
| **Year 2 Net Income** | $1,715,000.00 | $3,727,500.00 | $2,012,500.00 | +117.3% |

## Methodology

1. **Copied** the source xlsx (`ops_test_model.xlsx`) to the outputs directory
2. **Read** the spreadsheet structure and all formulas using openpyxl (formula mode)
3. **Replicated** the formula logic in Python since openpyxl cannot evaluate Excel formulas with named ranges
4. **Computed** baseline results (Unit Price = $100) and modified results (Unit Price = $150)
5. **Wrote** the new Unit Price ($150) into cell B2 of the Assumptions sheet in the copied xlsx
6. **Generated** this comparison report

### Key Limitation

openpyxl can write cell values and preserve formulas, but it **cannot recalculate** formulas. The xlsx file now contains the updated input (`B2 = 150`) but the formula cells still hold their formula text (not recomputed cached values). To see live recalculated values in the xlsx, it must be opened in Excel or processed with an engine that supports formula evaluation (e.g., LibreOffice, xlcalc).

The numeric results in this report were computed by replicating the spreadsheet's formula chain in Python, which produces identical results to what Excel would calculate.
