# Create Named Range Results

## Task
Add a new named range `Inp_Discount_Rate` with a value of 8% on the Assumptions sheet in cell B8.

## Method
Used openpyxl directly (no skill file referenced).

## Steps Performed
1. Copied `ops_test_model.xlsx` to the outputs directory.
2. Inspected the workbook: 3 sheets (Assumptions, Calculations, Output), 20 existing named ranges.
3. Assumptions sheet had data in rows 1-7 (A1:B7). Row 8 was empty.
4. Wrote `"Discount Rate"` to cell A8 (label) and `0.08` to cell B8 (value, formatted as `0.00%`).
5. Created a workbook-scoped named range `Inp_Discount_Rate` pointing to `'Assumptions'!$B$8`.
6. Saved and re-opened the file to verify.

## Verification
| Check                          | Result |
|--------------------------------|--------|
| A8 contains "Discount Rate"   | Pass   |
| B8 contains 0.08              | Pass   |
| B8 formatted as percentage    | Pass   |
| Named range Inp_Discount_Rate exists | Pass |
| Named range points to 'Assumptions'!$B$8 | Pass |

## Pre-existing Named Ranges (for reference)
| Name | Reference |
|------|-----------|
| Inp_Price | Assumptions!$B$2 |
| Inp_Units_Y1 | Assumptions!$B$3 |
| Inp_Units_Growth | Assumptions!$B$4 |
| Inp_Variable_Cost_Per_Unit | Assumptions!$B$5 |
| Inp_Fixed_Costs | Assumptions!$B$6 |
| Inp_Tax_Rate | Assumptions!$B$7 |
| **Inp_Discount_Rate** | **Assumptions!$B$8** (new) |

## Output Files
- `ops_test_model.xlsx` - Modified workbook with the new named range
- `create_range_results.md` - This file
