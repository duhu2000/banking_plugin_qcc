# Error Handling Results: Bad Named Range Lookup (Without Skill)

## Task

Read the value of `Total_Revenue_All_Years` from `ops_test_model.xlsx`.

## Result: FAILED -- Named Range Not Found

The named range `Total_Revenue_All_Years` does not exist in the workbook.

## Workbook Inventory

### Sheets
- Assumptions
- Calculations
- Output

### All Defined Names (20 total)

| Defined Name | Reference |
|---|---|
| Inp_Price | Assumptions!$B$2 |
| Inp_Units_Y1 | Assumptions!$B$3 |
| Inp_Units_Growth | Assumptions!$B$4 |
| Inp_Variable_Cost_Per_Unit | Assumptions!$B$5 |
| Inp_Fixed_Costs | Assumptions!$B$6 |
| Inp_Tax_Rate | Assumptions!$B$7 |
| Units_Y1 | Calculations!$B$2 |
| Units_Y2 | Calculations!$C$2 |
| Revenue_Y1 | Calculations!$B$3 |
| Revenue_Y2 | Calculations!$C$3 |
| Variable_Costs_Y1 | Calculations!$B$4 |
| Variable_Costs_Y2 | Calculations!$C$4 |
| Contribution_Y1 | Calculations!$B$5 |
| Contribution_Y2 | Calculations!$C$5 |
| EBIT_Y1 | Calculations!$B$6 |
| EBIT_Y2 | Calculations!$C$6 |
| Tax_Y1 | Calculations!$B$7 |
| Tax_Y2 | Calculations!$C$7 |
| Net_Income_Y1 | Calculations!$B$8 |
| Net_Income_Y2 | Calculations!$C$8 |

### Closest Matches to Requested Name

The requested name `Total_Revenue_All_Years` has no exact or partial match. The closest revenue-related defined names are:
- `Revenue_Y1` (Calculations!$B$3)
- `Revenue_Y2` (Calculations!$C$3)

There is no aggregation (sum across years) defined anywhere in the workbook.

## Error Classification

| Attribute | Value |
|---|---|
| Error type | Named range not found |
| Requested name | `Total_Revenue_All_Years` |
| Exists in workbook | No |
| Partial match available | No (closest: `Revenue_Y1`, `Revenue_Y2`) |

## Observations

1. The workbook contains only per-year named ranges, not cross-year totals.
2. A generic openpyxl approach with no guard logic would raise a `KeyError` when accessing `wb.defined_names['Total_Revenue_All_Years']`.
3. Without a skill or structured error-handling wrapper, the failure mode is an unhandled exception rather than a graceful diagnostic.
