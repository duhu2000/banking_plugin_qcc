# Net_Income_Y1 Formula Analysis

**Model file:** `ops_test_model.xlsx`
**Named Range:** `Net_Income_Y1` (Calculations!B8)
**Method:** Formula tracing via `idfa_ops.py formula` + manual verification from assumptions

---

## Direct Formula

```
=EBIT_Y1 - Tax_Y1
```

Year 1 net income equals earnings before interest and tax minus the tax charge.

---

## Full Dependency Chain

The formula depends on a chain of six calculation-layer Named Ranges, all of which ultimately resolve to five assumption-layer inputs. The chain is:

| Layer | Named Range | Cell | Formula | Plain English |
|-------|-------------|------|---------|---------------|
| Assumption | Inp_Units_Y1 | Assumptions!B2 | (literal) 50,000 | Year 1 unit volume |
| Assumption | Inp_Price | Assumptions!B2 | (literal) 100 | Price per unit |
| Assumption | Inp_Variable_Cost_Per_Unit | Assumptions!B5 | (literal) 40 | Variable cost per unit |
| Assumption | Inp_Fixed_Costs | Assumptions!B6 | (literal) 1,000,000 | Total fixed costs |
| Assumption | Inp_Tax_Rate | Assumptions!B7 | (literal) 0.30 | Tax rate (30%) |
| Calculation | Units_Y1 | Calculations!B2 | `=Inp_Units_Y1` | Passes through the assumption |
| Calculation | Revenue_Y1 | Calculations!B3 | `=Units_Y1 * Inp_Price` | Units times price |
| Calculation | Variable_Costs_Y1 | Calculations!B4 | `=Units_Y1 * Inp_Variable_Cost_Per_Unit` | Units times variable cost |
| Calculation | Contribution_Y1 | Calculations!B5 | `=Revenue_Y1 - Variable_Costs_Y1` | Revenue minus variable costs |
| Calculation | EBIT_Y1 | Calculations!B6 | `=Contribution_Y1 - Inp_Fixed_Costs` | Contribution minus fixed costs |
| Calculation | Tax_Y1 | Calculations!B7 | `=EBIT_Y1 * Inp_Tax_Rate` | EBIT times tax rate |
| **Calculation** | **Net_Income_Y1** | **Calculations!B8** | **`=EBIT_Y1 - Tax_Y1`** | **EBIT minus tax** |

---

## Fully Expanded Formula

Substituting all Named Ranges back to assumptions:

```
Net_Income_Y1
  = EBIT_Y1 - Tax_Y1
  = EBIT_Y1 - (EBIT_Y1 * Inp_Tax_Rate)
  = EBIT_Y1 * (1 - Inp_Tax_Rate)
  = (Contribution_Y1 - Inp_Fixed_Costs) * (1 - Inp_Tax_Rate)
  = ((Revenue_Y1 - Variable_Costs_Y1) - Inp_Fixed_Costs) * (1 - Inp_Tax_Rate)
  = ((Units_Y1 * Inp_Price - Units_Y1 * Inp_Variable_Cost_Per_Unit) - Inp_Fixed_Costs) * (1 - Inp_Tax_Rate)
  = ((Inp_Units_Y1 * (Inp_Price - Inp_Variable_Cost_Per_Unit)) - Inp_Fixed_Costs) * (1 - Inp_Tax_Rate)
```

In one line:

```
Net_Income_Y1 = (Inp_Units_Y1 * (Inp_Price - Inp_Variable_Cost_Per_Unit) - Inp_Fixed_Costs) * (1 - Inp_Tax_Rate)
```

---

## Numerical Verification

Using the current assumption values:

| Step | Computation | Value |
|------|-------------|------:|
| Units_Y1 | = 50,000 | 50,000 |
| Revenue_Y1 | = 50,000 * 100 | 5,000,000 |
| Variable_Costs_Y1 | = 50,000 * 40 | 2,000,000 |
| Contribution_Y1 | = 5,000,000 - 2,000,000 | 3,000,000 |
| EBIT_Y1 | = 3,000,000 - 1,000,000 | 2,000,000 |
| Tax_Y1 | = 2,000,000 * 0.30 | 600,000 |
| **Net_Income_Y1** | **= 2,000,000 - 600,000** | **1,400,000** |

Cross-check with collapsed formula:
`(50,000 * (100 - 40) - 1,000,000) * (1 - 0.30) = (3,000,000 - 1,000,000) * 0.70 = 1,400,000` -- matches.

---

## Assessment: Does the Formula Look Right?

**Yes.** The formula is a textbook after-tax net income calculation for a single-product business:

1. **Revenue** = units sold times price per unit
2. **Variable costs** = units sold times variable cost per unit
3. **Contribution margin** = revenue minus variable costs
4. **EBIT** = contribution margin minus fixed costs
5. **Tax** = EBIT times tax rate
6. **Net income** = EBIT minus tax (equivalent to EBIT times (1 - tax rate))

There are no structural issues:

- No circular references.
- No hardcoded numbers in the calculation layer -- every formula references only Named Ranges.
- The dependency chain flows cleanly from assumptions through calculations.
- Tax is applied to EBIT, which is the standard approach for a simplified P&L (no interest/depreciation modeled separately, consistent with EBIT being the pre-tax profit line).
- One minor modeling note: the `Tax_Y1 = EBIT_Y1 * Inp_Tax_Rate` formula does not floor negative EBIT to zero before applying tax. If EBIT were negative, the model would compute a negative tax (a tax credit), which may or may not be the intended behavior. With the current assumptions (EBIT = 2,000,000), this is not triggered.

---

*All formulas obtained via `uv run skills/idfa-ops/scripts/idfa_ops.py formula`. Numerical values computed by tracing the formula chain from assumption inputs.*
