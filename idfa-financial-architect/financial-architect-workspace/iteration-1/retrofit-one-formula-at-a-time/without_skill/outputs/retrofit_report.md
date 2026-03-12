# Retrofit Report: Legacy Model Formula Conversion (Iteration 1)

**Date:** 2026-03-11
**Source:** `legacy_model.xlsx`
**Method:** Manual conversion using openpyxl (no skill files used)
**Scope:** First 3 of 9 formulas converted

---

## Model Overview

The legacy model is a single-sheet workbook (`Model`) with:
- **Rows 1-4:** Assumptions (Revenue base, growth rate, COGS %)
- **Rows 6-8:** 3-year Income Statement (Revenue, COGS, Gross Profit)
- **Rows 10-16:** Capital structure and WACC calculation

### Complete Formula Inventory (9 formulas total)

| Cell | Original Formula | Purpose |
|------|-----------------|---------|
| C6 | `=B2` | Revenue Y1 |
| D6 | `=C6*(1+B3)` | Revenue Y2 |
| E6 | `=D6*(1+B3)` | Revenue Y3 |
| C7 | `=C6*B4` | COGS Y1 |
| D7 | `=D6*0.59` | COGS Y2 **[HARDCODED BUG]** |
| E7 | `=E6*0.58` | COGS Y3 **[HARDCODED BUG]** |
| C8 | `=C6-C7` | Gross Profit Y1 |
| D8 | `=D6-D7` | Gross Profit Y2 |
| E8 | `=E6-E7` | Gross Profit Y3 |
| B16 | `=($B$10/$B$12)*$B$13+($B$11/$B$12)*$B$14*(1-$B$15)` | WACC |

---

## Issues Found

### Bug: Hardcoded COGS percentages in D7 and E7

- **C7** correctly references the COGS % assumption in B4 (`=C6*B4`, where B4 = 0.60)
- **D7** uses a hardcoded `0.59` instead of `B4` (`=D6*0.59`)
- **E7** uses a hardcoded `0.58` instead of `B4` (`=E6*0.58`)

This means changing the COGS % assumption in B4 only affects Year 1. Years 2 and 3 are decoupled from the assumption cell. This is either an intentional declining-COGS schedule that should be made explicit, or a copy-paste error.

**Decision for this iteration:** Do NOT fix these bugs yet. The task is to convert formulas without changing values. These will be flagged for review in a future iteration.

---

## Named Ranges Added

All assumption cells were given named ranges to support readable formulas:

| Named Range | Cell Reference | Value |
|-------------|---------------|-------|
| `Revenue_Base` | `$B$2` | 10,000,000 |
| `Revenue_Growth` | `$B$3` | 0.10 |
| `COGS_Pct` | `$B$4` | 0.60 |
| `Equity` | `$B$10` | 5,000,000 |
| `Debt` | `$B$11` | 3,000,000 |
| `Total_Capital` | `$B$12` | 8,000,000 |
| `Cost_of_Equity` | `$B$13` | 0.12 |
| `Cost_of_Debt` | `$B$14` | 0.06 |
| `Tax_Rate` | `$B$15` | 0.25 |

---

## Formulas Converted (3 of 9)

### Formula 1: C6 (Revenue Y1)

| | |
|---|---|
| **Old** | `=B2` |
| **New** | `=Revenue_Base` |
| **Change** | Replaced opaque cell reference `B2` with named range `Revenue_Base` |
| **Expected value** | 10,000,000.00 |
| **Validation** | PASS -- `Revenue_Base` resolves to `$B$2` = 10,000,000, identical to `=B2` |

### Formula 2: D6 (Revenue Y2)

| | |
|---|---|
| **Old** | `=C6*(1+B3)` |
| **New** | `=C6*(1+Revenue_Growth)` |
| **Change** | Replaced `B3` with named range `Revenue_Growth` |
| **Expected value** | 11,000,000.00 |
| **Validation** | PASS -- `Revenue_Growth` resolves to `$B$3` = 0.10, identical to `B3` |

### Formula 3: E6 (Revenue Y3)

| | |
|---|---|
| **Old** | `=D6*(1+B3)` |
| **New** | `=D6*(1+Revenue_Growth)` |
| **Change** | Replaced `B3` with named range `Revenue_Growth` |
| **Expected value** | 12,100,000.00 |
| **Validation** | PASS -- `Revenue_Growth` resolves to `$B$3` = 0.10, identical to `B3` |

---

## Remaining Formulas (6 of 9, unconverted)

| Cell | Current Formula | Proposed Conversion | Notes |
|------|----------------|-------------------|-------|
| C7 | `=C6*B4` | `=C6*COGS_Pct` | Straightforward named range swap |
| D7 | `=D6*0.59` | `=D6*COGS_Pct` | **Would fix bug** -- changes value from 6,490,000 to 6,600,000 |
| E7 | `=E6*0.58` | `=E6*COGS_Pct` | **Would fix bug** -- changes value from 7,018,000 to 7,260,000 |
| C8 | `=C6-C7` | Already readable | No change needed |
| D8 | `=D6-D7` | Already readable | No change needed |
| E8 | `=E6-E7` | Already readable | No change needed |
| B16 | `=($B$10/$B$12)*$B$13+($B$11/$B$12)*$B$14*(1-$B$15)` | `=(Equity/Total_Capital)*Cost_of_Equity+(Debt/Total_Capital)*Cost_of_Debt*(1-Tax_Rate)` | Major readability improvement |

---

## Validation Summary

| Formula | Cell | Old | New | Value | Status |
|---------|------|-----|-----|-------|--------|
| 1 | C6 | `=B2` | `=Revenue_Base` | 10,000,000.00 | PASS |
| 2 | D6 | `=C6*(1+B3)` | `=C6*(1+Revenue_Growth)` | 11,000,000.00 | PASS |
| 3 | E6 | `=D6*(1+B3)` | `=D6*(1+Revenue_Growth)` | 12,100,000.00 | PASS |

**All 3 conversions validated: numbers unchanged.**

---

## Next Steps

1. Convert C7 (`=C6*B4` -> `=C6*COGS_Pct`) -- value-preserving
2. Decide on D7/E7 -- fixing the hardcoded values would change outputs; requires explicit approval
3. Convert B16 WACC formula to use named ranges -- value-preserving
4. C8/D8/E8 are already readable (`=C6-C7` etc.) -- may skip or add labels only
