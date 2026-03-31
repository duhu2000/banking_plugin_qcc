# Formula Inspection Report: Net_Income_Y1

**Source file:** `skills/idfa-ops/evals/files/ops_test_model.xlsx`
**Named Range inspected:** `Net_Income_Y1`
**Tool used:** `uv run scripts/idfa_ops.py formula`

---

## Direct Formula

```
Net_Income_Y1 = EBIT_Y1 - Tax_Y1
```

## Full Dependency Chain

| Named Range            | Formula                                | Type        |
| ---------------------- | -------------------------------------- | ----------- |
| **Net_Income_Y1**      | `=EBIT_Y1-Tax_Y1`                     | Calculation |
| EBIT_Y1                | `=Contribution_Y1-Inp_Fixed_Costs`     | Calculation |
| Tax_Y1                 | `=EBIT_Y1*Inp_Tax_Rate`               | Calculation |
| Contribution_Y1        | `=Revenue_Y1-Variable_Costs_Y1`        | Calculation |
| Revenue_Y1             | `=Units_Y1*Inp_Price`                  | Calculation |
| Variable_Costs_Y1      | `=Units_Y1*Inp_Variable_Cost_Per_Unit` | Calculation |
| Units_Y1               | `=Inp_Units_Y1`                        | Passthrough |
| Inp_Units_Y1           | 50,000 (literal)                       | Input       |
| Inp_Price              | 100 (literal)                          | Input       |
| Inp_Variable_Cost_Per_Unit | 40 (literal)                       | Input       |
| Inp_Fixed_Costs        | 1,000,000 (literal)                    | Input       |
| Inp_Tax_Rate           | 0.30 (literal)                         | Input       |

## Fully Expanded Formula

Substituting all intermediate Named Ranges, Net_Income_Y1 expands to:

```
Net_Income_Y1
  = EBIT_Y1 - Tax_Y1
  = EBIT_Y1 - (EBIT_Y1 * Inp_Tax_Rate)
  = EBIT_Y1 * (1 - Inp_Tax_Rate)
  = (Contribution_Y1 - Inp_Fixed_Costs) * (1 - Inp_Tax_Rate)
  = ((Revenue_Y1 - Variable_Costs_Y1) - Inp_Fixed_Costs) * (1 - Inp_Tax_Rate)
  = ((Units_Y1 * Inp_Price - Units_Y1 * Inp_Variable_Cost_Per_Unit) - Inp_Fixed_Costs) * (1 - Inp_Tax_Rate)
  = (Units_Y1 * (Inp_Price - Inp_Variable_Cost_Per_Unit) - Inp_Fixed_Costs) * (1 - Inp_Tax_Rate)
```

With current input values:

```
  = (50,000 * (100 - 40) - 1,000,000) * (1 - 0.30)
  = (50,000 * 60 - 1,000,000) * 0.70
  = (3,000,000 - 1,000,000) * 0.70
  = 2,000,000 * 0.70
  = 1,400,000
```

## Plain-English Explanation

Net_Income_Y1 computes **Year 1 net income after tax** using a standard contribution-margin income statement:

1. **Revenue** = units sold multiplied by price per unit
2. **Variable costs** = units sold multiplied by variable cost per unit
3. **Contribution margin** = revenue minus variable costs (the amount available to cover fixed costs and profit)
4. **EBIT (Earnings Before Interest and Tax)** = contribution margin minus fixed costs
5. **Tax** = EBIT multiplied by the tax rate
6. **Net Income** = EBIT minus tax

This is algebraically equivalent to: `EBIT * (1 - tax rate)`, i.e., the after-tax operating profit.

## Assessment

**The formula looks correct.** It implements a textbook contribution-margin net income calculation. Specific observations:

- **Structurally sound:** Each layer references only Named Ranges (no hardcoded cell references), consistent with IDFA guardrails.
- **Clean separation:** All five input assumptions use the `Inp_` prefix, clearly distinguishing inputs from calculated values.
- **Tax treatment is simple but valid:** Tax is applied directly to EBIT with no interest expense or other below-the-line adjustments. This is appropriate for a basic operating model. If the model were extended to include debt/interest, a separate interest-expense line would need to be inserted between EBIT and the tax calculation.
- **No negative-income guard:** If EBIT goes negative (e.g., if fixed costs exceed contribution margin), the tax formula would produce a negative tax amount, effectively modeling a tax refund. Depending on intent, an `=MAX(0, EBIT_Y1 * Inp_Tax_Rate)` guard might be desirable for realism, but this is a modeling-judgment call, not a structural error.
