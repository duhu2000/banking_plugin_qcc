# Legacy Financial Model Audit Report

**File:** `legacy_model.xlsx`
**Date:** 2026-03-11
**Auditor:** Claude Opus 4.6 (automated audit, no skill template)

---

## 1. Model Overview

The workbook contains a single sheet ("Model") with 16 rows and 5 columns covering:

- **Rows 1-4:** Assumptions (base revenue, growth rate, COGS percentage)
- **Rows 6-8:** A 3-year income statement projection (Revenue, COGS, Gross Profit)
- **Rows 10-16:** Capital structure and WACC calculation

### Assumptions

| Cell | Label | Value |
|------|-------|-------|
| B2 | Revenue (base) | 10,000,000 |
| B3 | Revenue Growth | 10.0% |
| B4 | COGS % | 60.0% |
| B10 | Equity | 5,000,000 |
| B11 | Debt | 3,000,000 |
| B12 | Total Capital | 8,000,000 (hardcoded) |
| B13 | Cost of Equity | 12.0% |
| B14 | Cost of Debt | 6.0% |
| B15 | Tax Rate | 25.0% |

### Formula Map

| Cell | Formula | Purpose |
|------|---------|---------|
| C6 | `=B2` | Y1 Revenue |
| D6 | `=C6*(1+B3)` | Y2 Revenue |
| E6 | `=D6*(1+B3)` | Y3 Revenue |
| C7 | `=C6*B4` | Y1 COGS |
| D7 | `=D6*0.59` | Y2 COGS (ERROR) |
| E7 | `=E6*0.58` | Y3 COGS (ERROR) |
| C8 | `=C6-C7` | Y1 Gross Profit |
| D8 | `=D6-D7` | Y2 Gross Profit |
| E8 | `=E6-E7` | Y3 Gross Profit |
| B16 | `=($B$10/$B$12)*$B$13+($B$11/$B$12)*$B$14*(1-$B$15)` | WACC |

---

## 2. Errors Found

### ERROR 1 (Critical): Hardcoded COGS Percentages in Y2 and Y3

**Location:** Cells D7 and E7

**Problem:** The COGS assumption in B4 is 60%, and Y1 correctly references it (`=C6*B4`). However, Y2 and Y3 use hardcoded values instead of referencing the assumption cell:

- **D7** uses `=D6*0.59` (59%) instead of `=D6*$B$4` (60%)
- **E7** uses `=E6*0.58` (58%) instead of `=E6*$B$4` (60%)

**Impact:** This causes two distinct problems:

1. **Incorrect values now:** COGS is understated, inflating gross profit by $110,000 in Y2 and $242,000 in Y3.
2. **Broken assumption linkage:** Changing the COGS % assumption in B4 will only affect Y1, leaving Y2 and Y3 unchanged. This defeats the purpose of having a centralized assumption cell and will silently produce wrong results if anyone updates the model.

| Year | Actual COGS % | Expected COGS % | Revenue | COGS Error | Gross Profit Error |
|------|---------------|------------------|---------|------------|--------------------|
| Y1 | 60.0% | 60.0% | 10,000,000 | -- | -- |
| Y2 | 59.0% | 60.0% | 11,000,000 | -110,000 understated | +110,000 overstated |
| Y3 | 58.0% | 60.0% | 12,100,000 | -242,000 understated | +242,000 overstated |

**Fix:** Replace the hardcoded formulas:
- D7: change `=D6*0.59` to `=D6*$B$4`
- E7: change `=E6*0.58` to `=E6*$B$4`

---

### ERROR 2 (Medium): Total Capital Is Hardcoded, Not Calculated

**Location:** Cell B12

**Problem:** Total Capital is entered as the literal value `8,000,000` rather than computed as `=B10+B11`. Currently, 5,000,000 + 3,000,000 = 8,000,000, so the value happens to be correct. However, if Equity (B10) or Debt (B11) is changed, B12 will not update, causing the WACC calculation to silently use stale data.

**Impact:** Any future change to capital structure will produce an incorrect WACC without any visible error.

**Fix:** Replace the hardcoded value in B12 with `=B10+B11`.

---

## 3. Structural and Best-Practice Issues

### ISSUE 3: No Year Labels for Y2 and Y3

Column B contains "Y1" labels for rows 6-8, but there are no corresponding "Y2" or "Y3" labels in columns C, D, or E (or in a header row above). The label "Y1" in column B is also oddly placed -- it acts as a row label where a column header would be more natural.

**Fix:** Add a header row (e.g., row 5) with labels: B5="Y1", C5 or D5="Y2", E5="Y3". Remove the repeated "Y1" text from column B of rows 6-8.

### ISSUE 4: WACC Computed but Never Used

The WACC is calculated in B16 (approximately 9.19%), but it is not referenced by any other cell. There is no DCF, NPV, or enterprise value calculation. The WACC section appears disconnected from the income projection.

**Recommendation:** Either build out the DCF model that uses WACC as a discount rate, or document its intended purpose.

### ISSUE 5: Incomplete Income Statement

The model stops at Gross Profit. A usable financial model would typically include:
- Operating Expenses (SGA, R&D, D&A)
- EBIT / Operating Income
- Interest Expense (especially since there is a debt structure defined)
- Taxes
- Net Income
- Free Cash Flow

### ISSUE 6: No Named Ranges

None of the assumption cells use named ranges. Named ranges (e.g., `RevenueGrowth` for B3, `COGSPct` for B4) make formulas self-documenting and reduce the risk of errors when the model expands.

### ISSUE 7: No Input Validation or Protection

There are no data validation rules on assumption cells (e.g., ensuring growth rate is between -100% and 100%, or that COGS % is between 0% and 100%). There is no sheet protection to prevent accidental overwriting of formulas.

### ISSUE 8: No Sensitivity or Scenario Analysis

For a model with growth and cost assumptions, there is no scenario table, data table, or sensitivity analysis showing how outputs change with different inputs.

---

## 4. Summary of Required Fixes

| Priority | Cell(s) | Issue | Fix |
|----------|---------|-------|-----|
| Critical | D7 | Hardcoded COGS 0.59 | Change to `=D6*$B$4` |
| Critical | E7 | Hardcoded COGS 0.58 | Change to `=E6*$B$4` |
| Medium | B12 | Hardcoded Total Capital | Change to `=B10+B11` |
| Low | Row 5 | Missing year headers | Add Y1/Y2/Y3 column headers |
| Advisory | B16 | WACC unused | Build DCF or document purpose |
| Advisory | All | No named ranges | Define named ranges for assumptions |
| Advisory | All | No validation | Add data validation rules |
| Advisory | All | Incomplete P&L | Extend through Net Income and FCF |

---

## 5. Corrected Values After Fixes

After applying the critical fixes, the model would produce:

| | Y1 | Y2 | Y3 |
|---|---|---|---|
| Revenue | 10,000,000 | 11,000,000 | 12,100,000 |
| COGS (60%) | 6,000,000 | 6,600,000 | 7,260,000 |
| Gross Profit | 4,000,000 | 4,400,000 | 4,840,000 |
| Gross Margin | 40.0% | 40.0% | 40.0% |

**WACC** (unchanged): 9.19%

The gross margin would be a consistent 40% across all three years, correctly reflecting the 60% COGS assumption, instead of the current erroneous 40% / 41% / 42% trajectory.
