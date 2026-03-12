# Aggressive Scenario: Sequential Multi-Write Results

## Scenario Description

Three simultaneous assumption changes to model an aggressive growth scenario:

| Assumption                 | Baseline  | Aggressive  | Change      |
| -------------------------- | --------- | ----------- | ----------- |
| Units (Year 1)             | 50,000    | 75,000      | +50.0%      |
| Variable Cost per Unit     | $40       | $35         | -12.5%      |
| Fixed Costs                | $1,000,000| $800,000    | -20.0%      |

All other assumptions held constant: Price = $100, Unit Growth = 15%, Tax Rate = 30%.

## Write-Recalculate-Read Execution

1. **Write 1**: `Inp_Units_Y1` set to 75,000 (Assumptions!B3)
2. **Write 2**: `Inp_Variable_Cost_Per_Unit` set to 35 (Assumptions!B5)
3. **Write 3**: `Inp_Fixed_Costs` set to 800,000 (Assumptions!B6)
4. **Recalculate**: LibreOffice headless (`recalc_bridge.py`, method: libreoffice-convert)
5. **Read**: `Net_Income_Y2` via `idfa_ops.py read`

## Full Model Output (Post-Recalculation)

| Metric              | Year 1        | Year 2        |
| ------------------- | ------------- | ------------- |
| Units               | 75,000        | 86,250        |
| Revenue             | $7,500,000    | $8,625,000    |
| Variable Costs      | $2,625,000    | $3,018,750    |
| Contribution        | $4,875,000    | $5,606,250    |
| EBIT                | $4,075,000    | $4,806,250    |
| Tax                 | $1,222,500    | $1,441,875    |
| **Net Income**      | **$2,852,500**| **$3,364,375**|

## Impact on Year 2 Net Income

| Metric            | Baseline      | Aggressive    | Delta         | Change    |
| ----------------- | ------------- | ------------- | ------------- | --------- |
| Net Income (Y2)   | $1,715,000    | $3,364,375    | +$1,649,375   | +96.2%    |

**Year 2 Net Income under the aggressive scenario is $3,364,375** -- nearly double the baseline of $1,715,000, an increase of $1,649,375 (+96.2%).

The combined effect of higher volume (+50% units), lower variable costs (-$5/unit), and reduced fixed costs (-$200K) creates significant operating leverage, with the contribution margin improvement flowing almost entirely to the bottom line.

## Artifacts

- Modified model: `ops_test_model.xlsx` (in this directory)
- All formulas verified intact after recalculation (e.g., `Net_Income_Y2 = =EBIT_Y2-Tax_Y2`)
