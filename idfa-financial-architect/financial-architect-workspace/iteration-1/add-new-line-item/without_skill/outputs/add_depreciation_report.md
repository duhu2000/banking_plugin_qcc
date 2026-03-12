# Add Depreciation Line Item -- Report

## Task

Add a **Depreciation** line item equal to 10% of Revenue each year, and update the EBITDA formula to account for it.

## Changes Made

### Calculations Sheet

1. **Inserted new row 7: Depreciation**
   - `B7` = `=Revenue_Y1*0.1` (Year 1)
   - `C7` = `=Revenue_Y2*0.1` (Year 2)
   - `D7` = `=Revenue_Y3*0.1` (Year 3)

2. **Updated EBITDA formulas (shifted to row 8)**
   - Before: `=Gross_Profit_Y1-OpEx_Y1`
   - After: `=Gross_Profit_Y1-OpEx_Y1-Depreciation_Y1` (and similarly for Y2, Y3)

### Output Sheet

1. **Inserted new row 6: Depreciation**
   - `B6` = `=Depreciation_Y1`, `C6` = `=Depreciation_Y2`, `D6` = `=Depreciation_Y3`

2. **EBITDA shifted to row 7** (formulas reference named ranges, unchanged)

### Named Ranges

| Name | Reference |
|------|-----------|
| `Depreciation_Y1` | `Calculations!$B$7` |
| `Depreciation_Y2` | `Calculations!$C$7` |
| `Depreciation_Y3` | `Calculations!$D$7` |
| `EBITDA_Y1` | `Calculations!$B$8` (updated from row 7) |
| `EBITDA_Y2` | `Calculations!$C$8` (updated from row 7) |
| `EBITDA_Y3` | `Calculations!$D$8` (updated from row 7) |

## Expected Computed Values

| Metric | Year 1 | Year 2 | Year 3 |
|--------|-------:|-------:|-------:|
| Revenue | 10,000,000 | 11,000,000 | 12,100,000 |
| COGS | 6,000,000 | 6,490,000 | 7,018,000 |
| Gross Profit | 4,000,000 | 4,510,000 | 5,082,000 |
| Operating Expenses | 2,000,000 | 2,100,000 | 2,205,000 |
| **Depreciation** | **1,000,000** | **1,100,000** | **1,210,000** |
| **EBITDA (new)** | **1,000,000** | **1,310,000** | **1,667,000** |
| EBITDA (old, before change) | 2,000,000 | 2,410,000 | 2,877,000 |

## Impact

Depreciation reduces EBITDA by exactly 10% of revenue each year:

- Year 1: -1,000,000 (EBITDA drops from 2,000,000 to 1,000,000)
- Year 2: -1,100,000 (EBITDA drops from 2,410,000 to 1,310,000)
- Year 3: -1,210,000 (EBITDA drops from 2,877,000 to 1,667,000)

## Naming Note

The metric label remains "EBITDA" in the model. Strictly speaking, EBITDA stands for Earnings Before Interest, Taxes, **Depreciation**, and Amortization -- so the resulting metric after subtracting depreciation is closer to EBIT. The label was kept as-is to match the task requirement of "updating EBITDA to account for depreciation," but the user may wish to rename this line to "EBIT" or "Operating Income" for accounting accuracy.
