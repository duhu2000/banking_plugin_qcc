# IDFA Compliance Audit Report

**File:** `skills/financial-architect/evals/files/legacy_model.xlsx`
**Sheet audited:** Model (single sheet)
**Total formulas:** 10
**Overall verdict:** FAIL
**Compliance score:** 27%

---

## Structural Issues

This model fails at the architecture level before guardrail checks even begin:

1. **Single-sheet model** -- IDFA requires three distinct layers (Assumptions, Calculations, Outputs) on separate sheets. This model crams everything onto one "Model" sheet.
2. **Zero Named Ranges defined** -- IDFA requires all inputs and outputs to be accessed via Named Ranges. This model has none.

---

## Guardrail 1: Named Range Priority -- FAIL (10 violations)

Every formula in the model uses raw coordinate references (e.g., `B2`, `C6`, `$B$10`) instead of Named Ranges. This makes the model opaque to both humans and agents.

| Cell | Formula | Coordinate Refs |
|------|---------|-----------------|
| C6 | `=B2` | B2 |
| D6 | `=C6*(1+B3)` | C6, B3 |
| E6 | `=D6*(1+B3)` | D6, B3 |
| C7 | `=C6*B4` | C6, B4 |
| D7 | `=D6*0.59` | D6 |
| E7 | `=E6*0.58` | E6 |
| C8 | `=C6-C7` | C6, C7 |
| D8 | `=D6-D7` | D6, D7 |
| E8 | `=E6-E7` | E6, E7 |
| B16 | `=($B$10/$B$12)*$B$13+($B$11/$B$12)*$B$14*(1-$B$15)` | $B$10, $B$12, $B$13, $B$11, $B$12, $B$14, $B$15 |

**Impact:** Without Named Ranges, an agent cannot write assumptions or read results programmatically. The model is inaccessible to the IDFA Write-Recalculate-Read pattern.

---

## Guardrail 2: LaTeX Verification -- PASS

No complex financial function keywords (WACC, NPV, IRR, etc.) were detected in formula text.

**Note:** Cell B16 contains a WACC calculation (`=($B$10/$B$12)*$B$13+($B$11/$B$12)*$B$14*(1-$B$15)`), but the formula uses raw arithmetic rather than a named function, so the keyword-based check does not flag it. In a properly structured IDFA model, this formula would be in a Named Range (e.g., `Calc_WACC`) and would carry a LaTeX verification comment documenting the mathematical identity.

---

## Guardrail 3: Intent Notes -- FAIL (0% coverage)

Zero of 10 formulas have cell comments explaining their business intent. Every formula is missing an intent note:

| Cell | Formula |
|------|---------|
| C6 | `=B2` |
| D6 | `=C6*(1+B3)` |
| E6 | `=D6*(1+B3)` |
| C7 | `=C6*B4` |
| D7 | `=D6*0.59` |
| E7 | `=E6*0.58` |
| C8 | `=C6-C7` |
| D8 | `=D6-D7` |
| E8 | `=E6-E7` |
| B16 | `=($B$10/$B$12)*$B$13+($B$11/$B$12)*$B$14*(1-$B$15)` |

**Impact:** Without intent notes, the purpose of each formula is ambiguous. An agent (or a new analyst) must reverse-engineer meaning from cell positions and surrounding labels.

---

## Guardrail 4: Layer Isolation -- FAIL (2 violations)

Two formulas contain hardcoded numeric constants that should be Named Range inputs in the Assumptions layer:

| Cell | Formula | Hardcoded Values |
|------|---------|-----------------|
| D7 | `=D6*0.59` | 0.59 |
| E7 | `=E6*0.58` | 0.58 |

**Impact:** These appear to be COGS percentages for Y2 and Y3. They differ from the Y1 COGS % input (0.60 in cell B4), suggesting the model builder manually overrode assumptions inside the calculation. This is a classic layer isolation violation -- assumptions are embedded in formulas rather than sourced from a dedicated Assumptions layer. If someone changes B4, the Y2/Y3 COGS calculations will not update.

---

## Summary

| Guardrail | Status | Violations |
|-----------|--------|------------|
| G1: Named Range Priority | FAIL | 10 (100% of formulas) |
| G2: LaTeX Verification | PASS | 0 |
| G3: Intent Notes | FAIL | 10 (0% coverage) |
| G4: Layer Isolation | FAIL | 2 |
| **Structural** | **FAIL** | **No layers, no Named Ranges** |

This legacy model is fundamentally non-IDFA-compliant. It would require a full retrofit: separating into three sheets, defining Named Ranges for all inputs/outputs, replacing coordinate references, adding intent notes to every formula, and moving hardcoded constants to the Assumptions layer.
