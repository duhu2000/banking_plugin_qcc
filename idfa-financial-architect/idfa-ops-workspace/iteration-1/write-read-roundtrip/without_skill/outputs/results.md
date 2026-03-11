# Write-Read Roundtrip: Price Assumption Update (Without Skill)

## Objective
Update the Unit Price assumption in `ops_test_model.xlsx` from $100 to $125 and verify the change persisted after save/reload.

## Input File
`skills/idfa-ops/evals/files/ops_test_model.xlsx`

## Method
- Copied xlsx to outputs directory
- Used `openpyxl` directly (no skill files referenced)
- Opened workbook, wrote new value, saved, closed
- Reopened workbook and read back the value to confirm

## Target Cell
- **Sheet:** Assumptions
- **Cell:** B2 (Unit Price)

## Results

| Check                        | Status |
|------------------------------|--------|
| Old value read as 100        | PASS   |
| New value written as 125     | PASS   |
| Reload confirms value is 125 | PASS   |
| Formulas intact after save   | PASS   |

### Assumptions Sheet After Update

| Assumption             | Value     |
|------------------------|-----------|
| Unit Price             | 125       |
| Units Sold Year 1      | 50000     |
| Units Growth Rate      | 0.15      |
| Variable Cost Per Unit  | 40        |
| Fixed Costs            | 1000000   |
| Tax Rate               | 0.3       |

### Formula Integrity
Revenue formulas in the Calculations sheet remain intact after the write:
- `Calculations!B3` = `=Units_Y1*Inp_Price`
- `Calculations!C3` = `=Units_Y2*Inp_Price`

## Verdict
**PASS** -- The write-read roundtrip succeeded. The price assumption was updated from $100 to $125 and the change was verified on reload. All formulas remain intact.
