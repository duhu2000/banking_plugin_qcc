# Full Model Structure Report

**File:** `ops_test_model.xlsx`

---

## 1. Sheet Inventory

Total sheets: **3**

| # | Sheet Name | Dimensions | Rows | Cols |
|---|-----------|------------|------|------|
| 1 | `Assumptions` | `A1:B7` | 7 | 2 |
| 2 | `Calculations` | `A1:C8` | 8 | 3 |
| 3 | `Output` | `A1:C8` | 8 | 3 |

## 2. Named Ranges (Defined Names)

Total defined names: **20**

| # | Name | Scope | Sheet | Cell/Range | Value Type | Raw Cell Value | Computed Value | Comment |
|---|------|-------|-------|------------|------------|----------------|----------------|---------|
| 1 | `Inp_Price` | Workbook | `Assumptions` | `$B$2` | Raw (int) | `100` | `100` |  |
| 2 | `Inp_Units_Y1` | Workbook | `Assumptions` | `$B$3` | Raw (int) | `50000` | `50000` |  |
| 3 | `Inp_Units_Growth` | Workbook | `Assumptions` | `$B$4` | Raw (float) | `0.15` | `0.15` |  |
| 4 | `Inp_Variable_Cost_Per_Unit` | Workbook | `Assumptions` | `$B$5` | Raw (int) | `40` | `40` |  |
| 5 | `Inp_Fixed_Costs` | Workbook | `Assumptions` | `$B$6` | Raw (int) | `1000000` | `1000000` |  |
| 6 | `Inp_Tax_Rate` | Workbook | `Assumptions` | `$B$7` | Raw (float) | `0.3` | `0.3` |  |
| 7 | `Units_Y1` | Workbook | `Calculations` | `$B$2` | Formula | `=Inp_Units_Y1` | `` | Year 1 units from assumption input |
| 8 | `Units_Y2` | Workbook | `Calculations` | `$C$2` | Formula | `=Units_Y1*(1+Inp_Units_Growth)` | `` | Year 2 units = prior year * (1 + growth) |
| 9 | `Revenue_Y1` | Workbook | `Calculations` | `$B$3` | Formula | `=Units_Y1*Inp_Price` | `` | Year 1 revenue = units * price per unit |
| 10 | `Revenue_Y2` | Workbook | `Calculations` | `$C$3` | Formula | `=Units_Y2*Inp_Price` | `` | Year 2 revenue = units * price per unit |
| 11 | `Variable_Costs_Y1` | Workbook | `Calculations` | `$B$4` | Formula | `=Units_Y1*Inp_Variable_Cost_Per_Unit` | `` | Year 1 variable costs = units * cost per unit |
| 12 | `Variable_Costs_Y2` | Workbook | `Calculations` | `$C$4` | Formula | `=Units_Y2*Inp_Variable_Cost_Per_Unit` | `` | Year 2 variable costs = units * cost per unit |
| 13 | `Contribution_Y1` | Workbook | `Calculations` | `$B$5` | Formula | `=Revenue_Y1-Variable_Costs_Y1` | `` | Year 1 contribution = revenue minus variable costs |
| 14 | `Contribution_Y2` | Workbook | `Calculations` | `$C$5` | Formula | `=Revenue_Y2-Variable_Costs_Y2` | `` | Year 2 contribution = revenue minus variable costs |
| 15 | `EBIT_Y1` | Workbook | `Calculations` | `$B$6` | Formula | `=Contribution_Y1-Inp_Fixed_Costs` | `` | Year 1 EBIT = contribution minus fixed costs |
| 16 | `EBIT_Y2` | Workbook | `Calculations` | `$C$6` | Formula | `=Contribution_Y2-Inp_Fixed_Costs` | `` | Year 2 EBIT = contribution minus fixed costs |
| 17 | `Tax_Y1` | Workbook | `Calculations` | `$B$7` | Formula | `=EBIT_Y1*Inp_Tax_Rate` | `` | Year 1 tax = EBIT * tax rate |
| 18 | `Tax_Y2` | Workbook | `Calculations` | `$C$7` | Formula | `=EBIT_Y2*Inp_Tax_Rate` | `` | Year 2 tax = EBIT * tax rate |
| 19 | `Net_Income_Y1` | Workbook | `Calculations` | `$B$8` | Formula | `=EBIT_Y1-Tax_Y1` | `` | Year 1 net income = EBIT minus tax |
| 20 | `Net_Income_Y2` | Workbook | `Calculations` | `$C$8` | Formula | `=EBIT_Y2-Tax_Y2` | `` | Year 2 net income = EBIT minus tax |

## 3. Per-Sheet Cell Detail

### Sheet: `Assumptions`

- **Populated cells:** 14
- **Formulas:** 0
- **Raw values:** 14
- **Comments:** 0

| Cell | Type | Raw Value | Computed Value | Number Format | Bold | Named Range | Comment |
|------|------|-----------|----------------|---------------|------|-------------|---------|
| `A1` | str | `Assumption` | `Assumption` | `` | Yes |  |  |
| `B1` | str | `Value` | `Value` | `` | Yes |  |  |
| `A2` | str | `Unit Price` | `Unit Price` | `` |  |  |  |
| `B2` | int | `100` | `100` | `#,##0` |  | `Inp_Price` |  |
| `A3` | str | `Units Sold Year 1` | `Units Sold Year 1` | `` |  |  |  |
| `B3` | int | `50000` | `50000` | `#,##0` |  | `Inp_Units_Y1` |  |
| `A4` | str | `Units Growth Rate` | `Units Growth Rate` | `` |  |  |  |
| `B4` | float | `0.15` | `0.15` | `0.00%` |  | `Inp_Units_Growth` |  |
| `A5` | str | `Variable Cost Per Unit` | `Variable Cost Per Unit` | `` |  |  |  |
| `B5` | int | `40` | `40` | `#,##0` |  | `Inp_Variable_Cost_Per_Unit` |  |
| `A6` | str | `Fixed Costs` | `Fixed Costs` | `` |  |  |  |
| `B6` | int | `1000000` | `1000000` | `#,##0` |  | `Inp_Fixed_Costs` |  |
| `A7` | str | `Tax Rate` | `Tax Rate` | `` |  |  |  |
| `B7` | float | `0.3` | `0.3` | `0.00%` |  | `Inp_Tax_Rate` |  |

### Sheet: `Calculations`

- **Populated cells:** 24
- **Formulas:** 14
- **Raw values:** 10
- **Comments:** 14

| Cell | Type | Raw Value | Computed Value | Number Format | Bold | Named Range | Comment |
|------|------|-----------|----------------|---------------|------|-------------|---------|
| `A1` | str | `Metric` | `Metric` | `` | Yes |  |  |
| `B1` | str | `Year 1` | `Year 1` | `` | Yes |  |  |
| `C1` | str | `Year 2` | `Year 2` | `` | Yes |  |  |
| `A2` | str | `Units Sold` | `Units Sold` | `` |  |  |  |
| `B2` | Formula | `=Inp_Units_Y1` | `` | `#,##0` |  | `Units_Y1` | Year 1 units from assumption input |
| `C2` | Formula | `=Units_Y1*(1+Inp_Units_Growth)` | `` | `#,##0` |  | `Units_Y2` | Year 2 units = prior year * (1 + growth) |
| `A3` | str | `Revenue` | `Revenue` | `` |  |  |  |
| `B3` | Formula | `=Units_Y1*Inp_Price` | `` | `#,##0` |  | `Revenue_Y1` | Year 1 revenue = units * price per unit |
| `C3` | Formula | `=Units_Y2*Inp_Price` | `` | `#,##0` |  | `Revenue_Y2` | Year 2 revenue = units * price per unit |
| `A4` | str | `Variable Costs` | `Variable Costs` | `` |  |  |  |
| `B4` | Formula | `=Units_Y1*Inp_Variable_Cost_Per_Unit` | `` | `#,##0` |  | `Variable_Costs_Y1` | Year 1 variable costs = units * cost per unit |
| `C4` | Formula | `=Units_Y2*Inp_Variable_Cost_Per_Unit` | `` | `#,##0` |  | `Variable_Costs_Y2` | Year 2 variable costs = units * cost per unit |
| `A5` | str | `Contribution Margin` | `Contribution Margin` | `` |  |  |  |
| `B5` | Formula | `=Revenue_Y1-Variable_Costs_Y1` | `` | `#,##0` |  | `Contribution_Y1` | Year 1 contribution = revenue minus variable costs |
| `C5` | Formula | `=Revenue_Y2-Variable_Costs_Y2` | `` | `#,##0` |  | `Contribution_Y2` | Year 2 contribution = revenue minus variable costs |
| `A6` | str | `EBIT` | `EBIT` | `` |  |  |  |
| `B6` | Formula | `=Contribution_Y1-Inp_Fixed_Costs` | `` | `#,##0` |  | `EBIT_Y1` | Year 1 EBIT = contribution minus fixed costs |
| `C6` | Formula | `=Contribution_Y2-Inp_Fixed_Costs` | `` | `#,##0` |  | `EBIT_Y2` | Year 2 EBIT = contribution minus fixed costs |
| `A7` | str | `Tax` | `Tax` | `` |  |  |  |
| `B7` | Formula | `=EBIT_Y1*Inp_Tax_Rate` | `` | `#,##0` |  | `Tax_Y1` | Year 1 tax = EBIT * tax rate |
| `C7` | Formula | `=EBIT_Y2*Inp_Tax_Rate` | `` | `#,##0` |  | `Tax_Y2` | Year 2 tax = EBIT * tax rate |
| `A8` | str | `Net Income` | `Net Income` | `` |  |  |  |
| `B8` | Formula | `=EBIT_Y1-Tax_Y1` | `` | `#,##0` |  | `Net_Income_Y1` | Year 1 net income = EBIT minus tax |
| `C8` | Formula | `=EBIT_Y2-Tax_Y2` | `` | `#,##0` |  | `Net_Income_Y2` | Year 2 net income = EBIT minus tax |

### Sheet: `Output`

- **Populated cells:** 24
- **Formulas:** 14
- **Raw values:** 10
- **Comments:** 0

| Cell | Type | Raw Value | Computed Value | Number Format | Bold | Named Range | Comment |
|------|------|-----------|----------------|---------------|------|-------------|---------|
| `A1` | str | `Metric` | `Metric` | `` | Yes |  |  |
| `B1` | str | `Year 1` | `Year 1` | `` | Yes |  |  |
| `C1` | str | `Year 2` | `Year 2` | `` | Yes |  |  |
| `A2` | str | `Units Sold` | `Units Sold` | `` | Yes |  |  |
| `B2` | Formula | `=Units_Y1` | `` | `#,##0` |  |  |  |
| `C2` | Formula | `=Units_Y2` | `` | `#,##0` |  |  |  |
| `A3` | str | `Revenue` | `Revenue` | `` | Yes |  |  |
| `B3` | Formula | `=Revenue_Y1` | `` | `#,##0` |  |  |  |
| `C3` | Formula | `=Revenue_Y2` | `` | `#,##0` |  |  |  |
| `A4` | str | `Variable Costs` | `Variable Costs` | `` | Yes |  |  |
| `B4` | Formula | `=Variable_Costs_Y1` | `` | `#,##0` |  |  |  |
| `C4` | Formula | `=Variable_Costs_Y2` | `` | `#,##0` |  |  |  |
| `A5` | str | `Contribution Margin` | `Contribution Margin` | `` | Yes |  |  |
| `B5` | Formula | `=Contribution_Y1` | `` | `#,##0` |  |  |  |
| `C5` | Formula | `=Contribution_Y2` | `` | `#,##0` |  |  |  |
| `A6` | str | `EBIT` | `EBIT` | `` | Yes |  |  |
| `B6` | Formula | `=EBIT_Y1` | `` | `#,##0` |  |  |  |
| `C6` | Formula | `=EBIT_Y2` | `` | `#,##0` |  |  |  |
| `A7` | str | `Tax` | `Tax` | `` | Yes |  |  |
| `B7` | Formula | `=Tax_Y1` | `` | `#,##0` |  |  |  |
| `C7` | Formula | `=Tax_Y2` | `` | `#,##0` |  |  |  |
| `A8` | str | `Net Income` | `Net Income` | `` | Yes |  |  |
| `B8` | Formula | `=Net_Income_Y1` | `` | `#,##0` |  |  |  |
| `C8` | Formula | `=Net_Income_Y2` | `` | `#,##0` |  |  |  |

## 4. All Comments (Consolidated)

| Sheet | Cell | Author | Comment Text |
|-------|------|--------|-------------|
| `Calculations` | `B2` | IDFA Model Builder | Year 1 units from assumption input |
| `Calculations` | `C2` | IDFA Model Builder | Year 2 units = prior year * (1 + growth) |
| `Calculations` | `B3` | IDFA Model Builder | Year 1 revenue = units * price per unit |
| `Calculations` | `C3` | IDFA Model Builder | Year 2 revenue = units * price per unit |
| `Calculations` | `B4` | IDFA Model Builder | Year 1 variable costs = units * cost per unit |
| `Calculations` | `C4` | IDFA Model Builder | Year 2 variable costs = units * cost per unit |
| `Calculations` | `B5` | IDFA Model Builder | Year 1 contribution = revenue minus variable costs |
| `Calculations` | `C5` | IDFA Model Builder | Year 2 contribution = revenue minus variable costs |
| `Calculations` | `B6` | IDFA Model Builder | Year 1 EBIT = contribution minus fixed costs |
| `Calculations` | `C6` | IDFA Model Builder | Year 2 EBIT = contribution minus fixed costs |
| `Calculations` | `B7` | IDFA Model Builder | Year 1 tax = EBIT * tax rate |
| `Calculations` | `C7` | IDFA Model Builder | Year 2 tax = EBIT * tax rate |
| `Calculations` | `B8` | IDFA Model Builder | Year 1 net income = EBIT minus tax |
| `Calculations` | `C8` | IDFA Model Builder | Year 2 net income = EBIT minus tax |

## 5. Named Range Cross-Reference by Sheet

### `Assumptions` (6 named range(s))

| Named Range | Cell/Range |
|-------------|------------|
| `Inp_Price` | `$B$2` |
| `Inp_Units_Y1` | `$B$3` |
| `Inp_Units_Growth` | `$B$4` |
| `Inp_Variable_Cost_Per_Unit` | `$B$5` |
| `Inp_Fixed_Costs` | `$B$6` |
| `Inp_Tax_Rate` | `$B$7` |

### `Calculations` (14 named range(s))

| Named Range | Cell/Range |
|-------------|------------|
| `Units_Y1` | `$B$2` |
| `Units_Y2` | `$C$2` |
| `Revenue_Y1` | `$B$3` |
| `Revenue_Y2` | `$C$3` |
| `Variable_Costs_Y1` | `$B$4` |
| `Variable_Costs_Y2` | `$C$4` |
| `Contribution_Y1` | `$B$5` |
| `Contribution_Y2` | `$C$5` |
| `EBIT_Y1` | `$B$6` |
| `EBIT_Y2` | `$C$6` |
| `Tax_Y1` | `$B$7` |
| `Tax_Y2` | `$C$7` |
| `Net_Income_Y1` | `$B$8` |
| `Net_Income_Y2` | `$C$8` |

### `Output` (0 named range(s))

_No named ranges on this sheet._

## 6. Formula Dependency Analysis

### `Assumptions` -- _no formulas_

### `Calculations` (14 formula(s))

- **`B2`**: `=Inp_Units_Y1`
  - Dependencies: Named: `Inp_Units_Y1`, `Units_Y1`
- **`C2`**: `=Units_Y1*(1+Inp_Units_Growth)`
  - Dependencies: Named: `Inp_Units_Growth`, `Units_Y1`
- **`B3`**: `=Units_Y1*Inp_Price`
  - Dependencies: Named: `Inp_Price`, `Units_Y1`
- **`C3`**: `=Units_Y2*Inp_Price`
  - Dependencies: Named: `Inp_Price`, `Units_Y2`
- **`B4`**: `=Units_Y1*Inp_Variable_Cost_Per_Unit`
  - Dependencies: Named: `Inp_Variable_Cost_Per_Unit`, `Units_Y1`
- **`C4`**: `=Units_Y2*Inp_Variable_Cost_Per_Unit`
  - Dependencies: Named: `Inp_Variable_Cost_Per_Unit`, `Units_Y2`
- **`B5`**: `=Revenue_Y1-Variable_Costs_Y1`
  - Dependencies: Named: `Revenue_Y1`, `Variable_Costs_Y1`
- **`C5`**: `=Revenue_Y2-Variable_Costs_Y2`
  - Dependencies: Named: `Revenue_Y2`, `Variable_Costs_Y2`
- **`B6`**: `=Contribution_Y1-Inp_Fixed_Costs`
  - Dependencies: Named: `Inp_Fixed_Costs`, `Contribution_Y1`
- **`C6`**: `=Contribution_Y2-Inp_Fixed_Costs`
  - Dependencies: Named: `Inp_Fixed_Costs`, `Contribution_Y2`
- **`B7`**: `=EBIT_Y1*Inp_Tax_Rate`
  - Dependencies: Named: `Inp_Tax_Rate`, `EBIT_Y1`
- **`C7`**: `=EBIT_Y2*Inp_Tax_Rate`
  - Dependencies: Named: `Inp_Tax_Rate`, `EBIT_Y2`
- **`B8`**: `=EBIT_Y1-Tax_Y1`
  - Dependencies: Named: `EBIT_Y1`, `Tax_Y1`
- **`C8`**: `=EBIT_Y2-Tax_Y2`
  - Dependencies: Named: `EBIT_Y2`, `Tax_Y2`

### `Output` (14 formula(s))

- **`B2`**: `=Units_Y1`
  - Dependencies: Named: `Units_Y1`
- **`C2`**: `=Units_Y2`
  - Dependencies: Named: `Units_Y2`
- **`B3`**: `=Revenue_Y1`
  - Dependencies: Named: `Revenue_Y1`
- **`C3`**: `=Revenue_Y2`
  - Dependencies: Named: `Revenue_Y2`
- **`B4`**: `=Variable_Costs_Y1`
  - Dependencies: Named: `Variable_Costs_Y1`
- **`C4`**: `=Variable_Costs_Y2`
  - Dependencies: Named: `Variable_Costs_Y2`
- **`B5`**: `=Contribution_Y1`
  - Dependencies: Named: `Contribution_Y1`
- **`C5`**: `=Contribution_Y2`
  - Dependencies: Named: `Contribution_Y2`
- **`B6`**: `=EBIT_Y1`
  - Dependencies: Named: `EBIT_Y1`
- **`C6`**: `=EBIT_Y2`
  - Dependencies: Named: `EBIT_Y2`
- **`B7`**: `=Tax_Y1`
  - Dependencies: Named: `Tax_Y1`
- **`C7`**: `=Tax_Y2`
  - Dependencies: Named: `Tax_Y2`
- **`B8`**: `=Net_Income_Y1`
  - Dependencies: Named: `Net_Income_Y1`
- **`C8`**: `=Net_Income_Y2`
  - Dependencies: Named: `Net_Income_Y2`

## 7. Data Validation Rules

**No data validation rules found.**

## 8. Conditional Formatting

**No conditional formatting found.**

---

_Report generated by direct openpyxl inspection (v3.1.5)._