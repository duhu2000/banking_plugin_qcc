# Formula Inspection Report: Net_Income_Y1

**Source file:** `skills/idfa-ops/evals/files/ops_test_model.xlsx`

---

## Named Range Location

| Named Range     | Points To             |
|-----------------|-----------------------|
| Net_Income_Y1   | `'Calculations'!$B$8` |

## Direct Formula in Cell B8

```
=EBIT_Y1 - Tax_Y1
```

This is a simple subtraction of two other named ranges.

---

## Full Dependency Chain

Tracing every named range back to the raw inputs on the Assumptions sheet:

| Step | Named Range / Cell         | Formula                                  | Resolves To (with inputs)                         |
|------|----------------------------|------------------------------------------|---------------------------------------------------|
| 1    | `Inp_Units_Y1` (B3)       | `50000` (literal)                        | 50,000                                            |
| 2    | `Inp_Price` (B2)           | `100` (literal)                          | 100                                               |
| 3    | `Inp_Variable_Cost_Per_Unit` (B5) | `40` (literal)                    | 40                                                |
| 4    | `Inp_Fixed_Costs` (B6)    | `1000000` (literal)                      | 1,000,000                                         |
| 5    | `Inp_Tax_Rate` (B7)       | `0.3` (literal)                          | 30%                                               |
| 6    | `Units_Y1` (Calc B2)      | `=Inp_Units_Y1`                          | 50,000                                            |
| 7    | `Revenue_Y1` (Calc B3)    | `=Units_Y1 * Inp_Price`                  | 50,000 x 100 = 5,000,000                         |
| 8    | `Variable_Costs_Y1` (Calc B4) | `=Units_Y1 * Inp_Variable_Cost_Per_Unit` | 50,000 x 40 = 2,000,000                     |
| 9    | `Contribution_Y1` (Calc B5) | `=Revenue_Y1 - Variable_Costs_Y1`      | 5,000,000 - 2,000,000 = 3,000,000                |
| 10   | `EBIT_Y1` (Calc B6)       | `=Contribution_Y1 - Inp_Fixed_Costs`    | 3,000,000 - 1,000,000 = 2,000,000                |
| 11   | `Tax_Y1` (Calc B7)        | `=EBIT_Y1 * Inp_Tax_Rate`               | 2,000,000 x 0.30 = 600,000                       |
| 12   | **`Net_Income_Y1`** (Calc B8) | **`=EBIT_Y1 - Tax_Y1`**             | **2,000,000 - 600,000 = 1,400,000**              |

---

## Expanded Algebraic Form

Substituting all the way down to raw assumptions:

```
Net_Income_Y1
  = EBIT_Y1 - Tax_Y1
  = EBIT_Y1 - (EBIT_Y1 * Tax_Rate)
  = EBIT_Y1 * (1 - Tax_Rate)
  = (Contribution_Y1 - Fixed_Costs) * (1 - Tax_Rate)
  = ((Revenue_Y1 - Variable_Costs_Y1) - Fixed_Costs) * (1 - Tax_Rate)
  = ((Units_Y1 * Price - Units_Y1 * Variable_Cost_Per_Unit) - Fixed_Costs) * (1 - Tax_Rate)
  = ((Units_Y1 * (Price - Variable_Cost_Per_Unit)) - Fixed_Costs) * (1 - Tax_Rate)
```

With the current assumptions:

```
= ((50,000 * (100 - 40)) - 1,000,000) * (1 - 0.30)
= ((50,000 * 60) - 1,000,000) * 0.70
= (3,000,000 - 1,000,000) * 0.70
= 2,000,000 * 0.70
= 1,400,000
```

---

## Assessment

**The formula is correct.**

It follows the standard income-statement structure:

1. Revenue = Units x Price
2. Variable Costs = Units x Cost Per Unit
3. Contribution Margin = Revenue - Variable Costs
4. EBIT = Contribution Margin - Fixed Costs
5. Tax = EBIT x Tax Rate
6. **Net Income = EBIT - Tax**

One observation: the tax calculation (`=EBIT_Y1 * Inp_Tax_Rate`) applies the tax rate to EBIT regardless of whether EBIT is negative. If EBIT were negative (a loss scenario), the model would compute a negative tax -- effectively a tax credit. This is a reasonable simplification for a planning model, but worth noting if loss scenarios are in scope. For the current inputs, EBIT is positive ($2M), so this has no practical effect.

No errors or anomalies found.
