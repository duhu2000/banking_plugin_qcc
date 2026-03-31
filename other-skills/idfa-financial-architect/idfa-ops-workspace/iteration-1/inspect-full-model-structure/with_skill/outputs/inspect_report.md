# IDFA Model Inspection Report — ops_test_model.xlsx

**Source file:** `skills/idfa-ops/evals/files/ops_test_model.xlsx`
**Tool used:** `uv run scripts/idfa_ops.py inspect`
**Total Named Ranges:** 20

---

## Summary

The model is a two-year P&L projection with clean IDFA layer separation:

| Layer        | Sheet        | Named Ranges | Type        | Intent Notes |
|--------------|--------------|--------------|-------------|--------------|
| Assumptions  | Assumptions  | 6            | Raw values  | None         |
| Calculations | Calculations | 14           | Formulas    | All 14 have  |

All 6 assumption inputs carry the `Inp_` prefix. All 14 calculation ranges
contain formulas that reference only Named Ranges (no bare cell references).
Every calculation cell has an intent note (cell comment). No assumption cell
has an intent note.

---

## Layer 1: Assumptions (Sheet: "Assumptions")

These are the model's tuneable inputs. All are raw values (no formulas).
The agent writes to these via `idfa_ops.py write`.

| Named Range                | Cell | Value     | Formula | Intent Note |
|----------------------------|------|-----------|---------|-------------|
| Inp_Price                  | B2   | 100       | --      | --          |
| Inp_Units_Y1               | B3   | 50,000    | --      | --          |
| Inp_Units_Growth           | B4   | 0.15 (15%)| --      | --          |
| Inp_Variable_Cost_Per_Unit | B5   | 40        | --      | --          |
| Inp_Fixed_Costs            | B6   | 1,000,000 | --      | --          |
| Inp_Tax_Rate               | B7   | 0.30 (30%)| --      | --          |

### Assumption descriptions

- **Inp_Price** -- Unit selling price
- **Inp_Units_Y1** -- Year 1 sales volume
- **Inp_Units_Growth** -- Annual unit growth rate (applied Y1 to Y2)
- **Inp_Variable_Cost_Per_Unit** -- Variable cost per unit sold
- **Inp_Fixed_Costs** -- Total fixed costs per year (constant across years)
- **Inp_Tax_Rate** -- Corporate tax rate applied to EBIT

---

## Layer 2: Calculations (Sheet: "Calculations")

All cells contain formulas referencing Named Ranges. Every cell has an intent
note documenting the calculation logic. The agent reads these via
`idfa_ops.py read` after recalculation.

Cached values are `null` because the file has not been recalculated with
LibreOffice since the formulas were written by openpyxl.

### Year 1 (Column B)

| Named Range       | Cell | Formula                                | Intent Note                                     |
|--------------------|------|----------------------------------------|-------------------------------------------------|
| Units_Y1           | B2   | `=Inp_Units_Y1`                       | Year 1 units from assumption input              |
| Revenue_Y1         | B3   | `=Units_Y1*Inp_Price`                 | Year 1 revenue = units * price per unit         |
| Variable_Costs_Y1  | B4   | `=Units_Y1*Inp_Variable_Cost_Per_Unit` | Year 1 variable costs = units * cost per unit   |
| Contribution_Y1    | B5   | `=Revenue_Y1-Variable_Costs_Y1`       | Year 1 contribution = revenue minus variable costs |
| EBIT_Y1            | B6   | `=Contribution_Y1-Inp_Fixed_Costs`    | Year 1 EBIT = contribution minus fixed costs    |
| Tax_Y1             | B7   | `=EBIT_Y1*Inp_Tax_Rate`              | Year 1 tax = EBIT * tax rate                   |
| Net_Income_Y1      | B8   | `=EBIT_Y1-Tax_Y1`                    | Year 1 net income = EBIT minus tax             |

### Year 2 (Column C)

| Named Range       | Cell | Formula                                 | Intent Note                                      |
|--------------------|------|-----------------------------------------|--------------------------------------------------|
| Units_Y2           | C2   | `=Units_Y1*(1+Inp_Units_Growth)`       | Year 2 units = prior year * (1 + growth)         |
| Revenue_Y2         | C3   | `=Units_Y2*Inp_Price`                  | Year 2 revenue = units * price per unit          |
| Variable_Costs_Y2  | C4   | `=Units_Y2*Inp_Variable_Cost_Per_Unit`  | Year 2 variable costs = units * cost per unit    |
| Contribution_Y2    | C5   | `=Revenue_Y2-Variable_Costs_Y2`        | Year 2 contribution = revenue minus variable costs |
| EBIT_Y2            | C6   | `=Contribution_Y2-Inp_Fixed_Costs`     | Year 2 EBIT = contribution minus fixed costs     |
| Tax_Y2             | C7   | `=EBIT_Y2*Inp_Tax_Rate`               | Year 2 tax = EBIT * tax rate                    |
| Net_Income_Y2      | C8   | `=EBIT_Y2-Tax_Y2`                     | Year 2 net income = EBIT minus tax              |

---

## Formula Dependency Chain

The calculation flow follows a strict top-down dependency:

```
Inp_Units_Y1 ──> Units_Y1 ──> Units_Y2
                    │              │
Inp_Price ──────> Revenue_Y1    Revenue_Y2
                    │              │
Inp_Variable_   > Variable_     Variable_
Cost_Per_Unit     Costs_Y1      Costs_Y2
                    │              │
                  Contribution_  Contribution_
                  Y1             Y2
                    │              │
Inp_Fixed_Costs > EBIT_Y1       EBIT_Y2
                    │              │
Inp_Tax_Rate ───> Tax_Y1        Tax_Y2
                    │              │
                  Net_Income_Y1  Net_Income_Y2
```

---

## Observations

1. **Clean layer separation** -- All inputs live on "Assumptions", all formulas
   live on "Calculations". No cross-contamination.
2. **Named Range-only formulas** -- Every formula references Named Ranges
   exclusively. Zero bare cell references (e.g., no `=B2*C3`).
3. **Intent notes on all calculations** -- All 14 calculation cells carry
   cell comments describing the formula logic. Assumption cells have no
   intent notes (consistent -- raw inputs are self-describing via their names).
4. **Cached values are null** -- The file needs a LibreOffice recalculation
   pass before `read` will return computed values. This is expected for a
   model built/modified via openpyxl.
5. **No output/dashboard layer** -- The model has two layers (Assumptions,
   Calculations) but no separate Outputs/Dashboard sheet. This is fine for
   a test model; a production model would typically add a third layer.
6. **Naming convention** -- Inputs use `Inp_` prefix consistently. Calculation
   names use descriptive `<Metric>_Y<N>` convention.
