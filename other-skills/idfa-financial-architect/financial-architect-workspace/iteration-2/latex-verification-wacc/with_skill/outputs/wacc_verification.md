# WACC Formula Verification Report

**Model:** `legacy_model.xlsx`
**Date:** 2026-03-11
**Agent:** IDFA Financial Architect
**Methodology:** IDFA Guardrail 2 -- LaTeX Verification

---

## 1. Formula Extracted from Model

**Cell:** B16
**Excel formula:**

```
=($B$10/$B$12)*$B$13+($B$11/$B$12)*$B$14*(1-$B$15)
```

**Cell mapping:**

| Cell  | Label          | Value     |
|-------|----------------|-----------|
| B10   | Equity         | 5,000,000 |
| B11   | Debt           | 3,000,000 |
| B12   | Total Capital  | 8,000,000 |
| B13   | Cost of Equity | 0.12      |
| B14   | Cost of Debt   | 0.06      |
| B15   | Tax Rate       | 0.25      |

---

## 2. LaTeX Verification (Guardrail 2)

### 2.1 Correct Textbook WACC

$$WACC = \frac{E}{E+D} \times K_e + \frac{D}{E+D} \times K_d \times (1-T)$$

### 2.2 Model Formula Expressed in LaTeX

Substituting labels for cell coordinates:

$$WACC = \frac{Equity}{TotalCapital} \times K_e + \frac{Debt}{TotalCapital} \times K_d \times (1-T)$$

$$WACC = \frac{B10}{B12} \times B13 + \frac{B11}{B12} \times B14 \times (1 - B15)$$

### 2.3 Structural Comparison

The model formula structurally matches the textbook WACC identity. Specifically:

| Textbook Component | Model Equivalent                    | Match? |
|--------------------|-------------------------------------|--------|
| $\frac{E}{E+D}$   | `$B$10/$B$12` = 5M/8M = 0.625      | Yes    |
| $K_e$             | `$B$13` = 0.12                      | Yes    |
| $\frac{D}{E+D}$   | `$B$11/$B$12` = 3M/8M = 0.375      | Yes    |
| $K_d$             | `$B$14` = 0.06                      | Yes    |
| $(1-T)$           | `(1-$B$15)` = (1-0.25) = 0.75      | Yes    |

---

## 3. Three LaTeX Verification Checks

Per IDFA Guardrail 2, every WACC formula must pass these three checks:

### Check 1: Equity weight + Debt weight = 1.0

$$w_E + w_D = \frac{E}{V} + \frac{D}{V} = \frac{5{,}000{,}000}{8{,}000{,}000} + \frac{3{,}000{,}000}{8{,}000{,}000} = 0.625 + 0.375 = 1.0$$

**PASS** -- Weights sum to 1.0.

### Check 2: Only the debt term is multiplied by (1 - Tax Rate)

The formula is:

```
=($B$10/$B$12)*$B$13 + ($B$11/$B$12)*$B$14*(1-$B$15)
```

- Equity component: `($B$10/$B$12)*$B$13` -- no tax shield applied. Correct.
- Debt component: `($B$11/$B$12)*$B$14*(1-$B$15)` -- tax shield applied. Correct.

**PASS** -- Tax shield is applied exclusively to the debt component.

### Check 3: Cost of equity and cost of debt are in the same units

- Cost of Equity (B13): 0.12 (decimal)
- Cost of Debt (B14): 0.06 (decimal)

**PASS** -- Both are expressed as decimals, consistent units.

---

## 4. Numerical Verification (via formula tracing -- not model-verified)

$$WACC = 0.625 \times 0.12 + 0.375 \times 0.06 \times 0.75$$

$$WACC = 0.075 + 0.016875$$

$$WACC = 0.091875 = 9.19\%$$

*Note: Computed via formula tracing (not model-verified). LibreOffice recalculation was not performed. This trace is consistent with the formula structure and input values found in the model.*

---

## 5. WACC Verdict

**The WACC math is correct.** The formula in B16 is a structurally sound implementation of the weighted average cost of capital. All three LaTeX verification checks pass. No missing tax shield, no inverted weights, no unit mismatch.

---

## 6. IDFA Compliance Findings

While the WACC formula is **mathematically correct**, the model has several IDFA compliance violations:

### Guardrail 1 -- Named Range Priority: FAIL

The WACC formula uses cell-coordinate references exclusively (`$B$10`, `$B$12`, `$B$13`, `$B$11`, `$B$14`, `$B$15`). No Named Ranges exist anywhere in the model (0 Named Ranges defined).

**IDFA-compliant equivalent:**

```
=Inp_Equity/Inp_Total_Capital*Inp_Cost_of_Equity + Inp_Debt/Inp_Total_Capital*Inp_Cost_of_Debt*(1-Inp_Tax_Rate)
```

This would be self-documenting and resilient to row/column insertions.

### Guardrail 2 -- LaTeX Verification: FAIL (no documentation)

The formula is mathematically correct (verified above), but no LaTeX verification note exists in the model. IDFA requires that the verification be documented before or at the time the formula is written.

### Guardrail 3 -- Audit-Ready Intent Notes: FAIL

No Excel Note/Comment on cell B16. IDFA requires an Intent Note documenting:
- INTENT: the business rule
- FORMULA: the LaTeX expression
- ASSUMPTIONS: the Named Ranges the formula depends on
- GENERATED/MODIFIED: timestamps

### Guardrail 4 -- Delegated Calculation: N/A

This guardrail applies to agent operations, not static model structure. Not evaluated here.

### Additional Finding: Hardcoded Total Capital

Cell B12 (`Total Capital = 8,000,000`) is a hardcoded value, not a formula (`=B10+B11`). If Equity or Debt changes, Total Capital will not update, causing the WACC to use stale weights. This is a latent error risk.

### Additional Finding: Hardcoded COGS Percentages

Cells D7 and E7 contain hardcoded COGS percentages (`=D6*0.59` and `=E6*0.58`) instead of referencing assumption cells. This is a Layer 1/Layer 2 isolation violation -- constants are embedded directly in calculation formulas.

---

## 7. Compliance Summary

| Guardrail                        | Status | Notes                                         |
|----------------------------------|--------|-----------------------------------------------|
| G1: Named Range Priority         | FAIL   | 0 Named Ranges; all formulas use coordinates  |
| G2: LaTeX Verification           | FAIL   | Formula is correct but undocumented           |
| G3: Audit-Ready Intent Notes     | FAIL   | No Intent Notes on any formula                |
| G4: Delegated Calculation        | N/A    | Applies to agent operations                   |
| **WACC Math Correctness**        | **PASS** | **All three LaTeX checks pass**             |

**Overall IDFA Compliance: 0% (0 of 3 applicable guardrails pass)**

---

## 8. Recommendations

If the user proceeds to retrofit this model to IDFA compliance:

1. Define Named Ranges for all six WACC inputs (`Inp_Equity`, `Inp_Debt`, `Inp_Total_Capital`, `Inp_Cost_of_Equity`, `Inp_Cost_of_Debt`, `Inp_Tax_Rate`)
2. Make `Inp_Total_Capital` a formula (`=Inp_Equity + Inp_Debt`) rather than a hardcoded value
3. Rewrite the WACC formula using Named Ranges only
4. Attach an Intent Note documenting the formula's purpose and LaTeX verification
5. Address the hardcoded COGS percentages in D7 and E7

---

*Report generated by IDFA Financial Architect. All values obtained via `idfa_ops.py inspect` and formula tracing. WACC verification follows IDFA Guardrail 2 protocol.*
