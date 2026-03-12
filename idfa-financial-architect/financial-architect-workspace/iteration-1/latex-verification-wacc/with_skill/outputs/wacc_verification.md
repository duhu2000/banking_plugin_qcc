# WACC LaTeX Verification Report

**Source file:** `skills/financial-architect/evals/files/legacy_model.xlsx`
**Sheet:** `Model`
**WACC cell:** `B16`
**Date:** 2026-03-11
**Guardrail applied:** Guardrail 2 -- LaTeX Verification

---

## 1. Formula Extracted from Model

The WACC formula was read from cell `B16` of the legacy model using `idfa_ops.py inspect`:

```
=($B$10/$B$12)*$B$13+($B$11/$B$12)*$B$14*(1-$B$15)
```

### Coordinate-to-Label Mapping

| Cell   | Label           | Value       |
| ------ | --------------- | ----------- |
| `B10`  | Equity          | 5,000,000   |
| `B11`  | Debt            | 3,000,000   |
| `B12`  | Total Capital   | 8,000,000   |
| `B13`  | Cost of Equity  | 0.12 (12%)  |
| `B14`  | Cost of Debt    | 0.06 (6%)   |
| `B15`  | Tax Rate        | 0.25 (25%)  |

---

## 2. LaTeX Equivalent

Substituting labels for coordinates, the formula in the model is:

$$WACC = \frac{E}{E+D} \times K_e + \frac{D}{E+D} \times K_d \times (1-T)$$

Where:
- $E$ = Equity = 5,000,000
- $D$ = Debt = 3,000,000
- $E + D$ = Total Capital = 8,000,000
- $K_e$ = Cost of Equity = 0.12
- $K_d$ = Cost of Debt = 0.06
- $T$ = Tax Rate = 0.25

This matches the canonical WACC form specified in the IDFA skill (Guardrail 2).

---

## 3. Three Guardrail 2 Checks

### Check 1: Equity weight + Debt weight = 1.0

$$w_e = \frac{E}{E+D} = \frac{5{,}000{,}000}{8{,}000{,}000} = 0.625$$

$$w_d = \frac{D}{E+D} = \frac{3{,}000{,}000}{8{,}000{,}000} = 0.375$$

$$w_e + w_d = 0.625 + 0.375 = 1.000$$

**PASS.** Weights sum to exactly 1.0. Additionally, the Total Capital in B12 (8,000,000) equals E + D (5,000,000 + 3,000,000), confirming internal consistency.

### Check 2: Only the debt term is multiplied by (1 - Tax Rate)

The formula structure is:

$$\underbrace{\frac{E}{E+D} \times K_e}_{\text{equity term (no tax shield)}} + \underbrace{\frac{D}{E+D} \times K_d \times (1-T)}_{\text{debt term (tax shield applied)}}$$

- Equity term: `($B$10/$B$12)*$B$13` -- no `(1-$B$15)` factor. Correct.
- Debt term: `($B$11/$B$12)*$B$14*(1-$B$15)` -- `(1-$B$15)` applied. Correct.

**PASS.** The tax shield `(1 - T)` is applied exclusively to the debt component.

### Check 3: Cost of equity and cost of debt are in the same units

| Input          | Cell  | Value | Unit    |
| -------------- | ----- | ----- | ------- |
| Cost of Equity | B13   | 0.12  | Decimal |
| Cost of Debt   | B14   | 0.06  | Decimal |

Both are expressed as decimals (not percentages). No unit mismatch.

**PASS.** Units are consistent.

---

## 4. Computed WACC Value

$$WACC = (0.625 \times 0.12) + (0.375 \times 0.06 \times 0.75)$$
$$WACC = 0.075 + 0.016875$$
$$WACC = 0.091875 = 9.1875\%$$

---

## 5. Verdict

| Check                         | Result |
| ----------------------------- | ------ |
| Weights sum to 1.0            | PASS   |
| Tax shield on debt term only  | PASS   |
| Units consistency (Ke vs Kd)  | PASS   |
| **Overall: Formula correct**  | **PASS** |

The WACC formula in the legacy model is **mathematically correct**. The LaTeX expression matches the canonical WACC definition. All three Guardrail 2 verification checks pass.

---

## 6. IDFA Compliance Notes (out of scope but noted)

While the WACC math is correct, the legacy model has IDFA compliance issues that would need to be addressed in a retrofit:

- **Guardrail 1 violation:** The formula uses cell coordinates (`$B$10`, `$B$12`, etc.) instead of Named Ranges. No Named Ranges are defined in the workbook.
- **Guardrail 3 violation:** No Intent Note / Excel comment is attached to the WACC cell.
- **COGS hardcoding:** Cells D7 and E7 contain hardcoded COGS percentages (`0.59`, `0.58`) instead of referencing Named Ranges with an efficiency adjustment.

These are structural issues, not mathematical errors. The WACC formula itself is sound.
