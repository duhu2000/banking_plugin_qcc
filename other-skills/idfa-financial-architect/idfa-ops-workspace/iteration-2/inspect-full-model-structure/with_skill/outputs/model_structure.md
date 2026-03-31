# Model Structure — ops_test_model.xlsx

**Generated:** 2026-03-11
**Source file:** `skills/idfa-ops/evals/files/ops_test_model.xlsx`
**Method:** `uv run skills/idfa-ops/scripts/idfa_ops.py inspect` + `uv run skills/idfa-ops/scripts/idfa_audit.py`

---

## Summary

| Metric                 | Value         |
| ---------------------- | ------------- |
| Total Named Ranges     | 20            |
| Sheets                 | 2 (Assumptions, Calculations) |
| Input ranges (raw values) | 6          |
| Calculated ranges (formulas) | 14      |
| Intent notes present   | 14 / 14 formula cells (100%) |
| IDFA compliance score  | 100% — all four guardrails PASS |

---

## Sheet: Assumptions (Input Layer)

All cells on this sheet contain raw values — no formulas. These are the model's tunable inputs (IDFA Layer 1).

| Named Range                | Cell | Value   | Formula | Intent Note |
| -------------------------- | ---- | ------- | ------- | ----------- |
| `Inp_Price`                | B2   | 100     | —       | —           |
| `Inp_Units_Y1`             | B3   | 50000   | —       | —           |
| `Inp_Units_Growth`         | B4   | 0.15    | —       | —           |
| `Inp_Variable_Cost_Per_Unit` | B5 | 40      | —       | —           |
| `Inp_Fixed_Costs`          | B6   | 1000000 | —       | —           |
| `Inp_Tax_Rate`             | B7   | 0.3     | —       | —           |

**Naming convention:** All inputs use the `Inp_` prefix, consistent with IDFA naming rules.

---

## Sheet: Calculations (Calculation + Output Layer)

All cells on this sheet contain formulas that reference Named Ranges exclusively. Every formula cell has an intent note (cell comment) documenting its purpose.

### Units

| Named Range   | Cell | Formula                           | Cached Value | Intent Note                              |
| ------------- | ---- | --------------------------------- | ------------ | ---------------------------------------- |
| `Units_Y1`    | B2   | `=Inp_Units_Y1`                   | —            | Year 1 units from assumption input       |
| `Units_Y2`    | C2   | `=Units_Y1*(1+Inp_Units_Growth)`  | —            | Year 2 units = prior year * (1 + growth) |

### Revenue

| Named Range    | Cell | Formula                | Cached Value | Intent Note                              |
| -------------- | ---- | ---------------------- | ------------ | ---------------------------------------- |
| `Revenue_Y1`   | B3   | `=Units_Y1*Inp_Price`  | —            | Year 1 revenue = units * price per unit  |
| `Revenue_Y2`   | C3   | `=Units_Y2*Inp_Price`  | —            | Year 2 revenue = units * price per unit  |

### Variable Costs

| Named Range          | Cell | Formula                                | Cached Value | Intent Note                                    |
| -------------------- | ---- | -------------------------------------- | ------------ | ---------------------------------------------- |
| `Variable_Costs_Y1`  | B4   | `=Units_Y1*Inp_Variable_Cost_Per_Unit`  | —            | Year 1 variable costs = units * cost per unit  |
| `Variable_Costs_Y2`  | C4   | `=Units_Y2*Inp_Variable_Cost_Per_Unit`  | —            | Year 2 variable costs = units * cost per unit  |

### Contribution

| Named Range         | Cell | Formula                            | Cached Value | Intent Note                                        |
| ------------------- | ---- | ---------------------------------- | ------------ | -------------------------------------------------- |
| `Contribution_Y1`   | B5   | `=Revenue_Y1-Variable_Costs_Y1`     | —            | Year 1 contribution = revenue minus variable costs |
| `Contribution_Y2`   | C5   | `=Revenue_Y2-Variable_Costs_Y2`     | —            | Year 2 contribution = revenue minus variable costs |

### EBIT

| Named Range | Cell | Formula                            | Cached Value | Intent Note                                  |
| ----------- | ---- | ---------------------------------- | ------------ | -------------------------------------------- |
| `EBIT_Y1`   | B6   | `=Contribution_Y1-Inp_Fixed_Costs`  | —            | Year 1 EBIT = contribution minus fixed costs |
| `EBIT_Y2`   | C6   | `=Contribution_Y2-Inp_Fixed_Costs`  | —            | Year 2 EBIT = contribution minus fixed costs |

### Tax

| Named Range | Cell | Formula                   | Cached Value | Intent Note                    |
| ----------- | ---- | ------------------------- | ------------ | ------------------------------ |
| `Tax_Y1`    | B7   | `=EBIT_Y1*Inp_Tax_Rate`   | —            | Year 1 tax = EBIT * tax rate  |
| `Tax_Y2`    | C7   | `=EBIT_Y2*Inp_Tax_Rate`   | —            | Year 2 tax = EBIT * tax rate  |

### Net Income

| Named Range      | Cell | Formula              | Cached Value | Intent Note                            |
| ---------------- | ---- | -------------------- | ------------ | -------------------------------------- |
| `Net_Income_Y1`  | B8   | `=EBIT_Y1-Tax_Y1`    | —            | Year 1 net income = EBIT minus tax     |
| `Net_Income_Y2`  | C8   | `=EBIT_Y2-Tax_Y2`    | —            | Year 2 net income = EBIT minus tax     |

**Note:** Cached values show as "—" because the file has not been recalculated via LibreOffice since formulas were written with openpyxl. Running `recalc_bridge.py` would populate these.

---

## Formula Dependency Chain

The model follows a clean top-down dependency flow:

```
Inp_Units_Y1 ──> Units_Y1 ──> Units_Y2
                     │              │
Inp_Price ───────────┼──────────────┤
                     v              v
               Revenue_Y1    Revenue_Y2
                     │              │
Inp_Variable_    ────┼──────────────┤
  Cost_Per_Unit      v              v
            Variable_Costs_Y1  Variable_Costs_Y2
                     │              │
                     v              v
            Contribution_Y1   Contribution_Y2
                     │              │
Inp_Fixed_Costs ─────┼──────────────┤
                     v              v
                EBIT_Y1        EBIT_Y2
                     │              │
Inp_Tax_Rate ────────┼──────────────┤
                     v              v
                 Tax_Y1         Tax_Y2
                     │              │
                     v              v
            Net_Income_Y1    Net_Income_Y2
```

Each year column (Y1 = column B, Y2 = column C) follows the same vertical structure. Year 2 additionally depends on Year 1 through `Units_Y2 = Units_Y1 * (1 + growth)`.

---

## IDFA Compliance Audit

| Guardrail                          | Status | Detail                                          |
| ---------------------------------- | ------ | ----------------------------------------------- |
| G1: All formulas use Named Ranges  | PASS   | 0 violations — no hard-coded cell references    |
| G2: LaTeX verification for complex | PASS   | 0 complex formulas lacking verification         |
| G3: Intent notes on formula cells  | PASS   | 100% coverage (14/14 formula cells documented)  |
| G4: Layer isolation                | PASS   | 0 violations — inputs and calcs on separate sheets |

**Overall: PASS (100% compliant)**

---

## IDFA Layer Mapping

| Layer               | Sheet         | Range Count | Content Type  |
| ------------------- | ------------- | ----------- | ------------- |
| Layer 1 (Inputs)    | Assumptions   | 6           | Raw values    |
| Layer 2 (Calcs)     | Calculations  | 14          | Formulas only |
| Layer 3 (Outputs)   | Calculations  | (shared)    | Terminal formulas (Net_Income_*) |

The model uses a two-sheet layout where the Calculations sheet serves double duty as both the calculation and output layer. The terminal outputs (`Net_Income_Y1`, `Net_Income_Y2`) sit at the bottom of the formula chain.

---

## Named Range Index (Alphabetical)

| # | Named Range                | Sheet        | Cell | Type    |
|---|--------------------------- |------------- |----- |---------|
| 1 | `Contribution_Y1`          | Calculations | B5   | Formula |
| 2 | `Contribution_Y2`          | Calculations | C5   | Formula |
| 3 | `EBIT_Y1`                  | Calculations | B6   | Formula |
| 4 | `EBIT_Y2`                  | Calculations | C6   | Formula |
| 5 | `Inp_Fixed_Costs`          | Assumptions  | B6   | Value   |
| 6 | `Inp_Price`                | Assumptions  | B2   | Value   |
| 7 | `Inp_Tax_Rate`             | Assumptions  | B7   | Value   |
| 8 | `Inp_Units_Growth`         | Assumptions  | B4   | Value   |
| 9 | `Inp_Units_Y1`             | Assumptions  | B3   | Value   |
|10 | `Inp_Variable_Cost_Per_Unit`| Assumptions | B5   | Value   |
|11 | `Net_Income_Y1`            | Calculations | B8   | Formula |
|12 | `Net_Income_Y2`            | Calculations | C8   | Formula |
|13 | `Revenue_Y1`               | Calculations | B3   | Formula |
|14 | `Revenue_Y2`               | Calculations | C3   | Formula |
|15 | `Tax_Y1`                   | Calculations | B7   | Formula |
|16 | `Tax_Y2`                   | Calculations | C7   | Formula |
|17 | `Units_Y1`                 | Calculations | B2   | Formula |
|18 | `Units_Y2`                 | Calculations | C2   | Formula |
|19 | `Variable_Costs_Y1`        | Calculations | B4   | Formula |
|20 | `Variable_Costs_Y2`        | Calculations | C4   | Formula |
