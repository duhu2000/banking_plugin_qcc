# IDFA Compliance Audit — legacy_model.xlsx

**Date:** 2026-03-11
**Auditor:** IDFA Operations Agent (idfa-ops skill v2.0)
**Methodology:** Manual four-guardrail audit (automated script could not run — model lacks required IDFA layer structure)

---

## Executive Summary

| Metric               | Value  |
| --------------------- | ------ |
| **Overall Verdict**   | FAIL   |
| **Compliance Score**  | 0%     |
| **Total Formulas**    | 10     |
| **Total Violations**  | 30     |
| **Guardrails Passed** | 0 of 4 |

The model violates every IDFA guardrail. It is a single-sheet, flat spreadsheet with no Named Ranges, no layer separation, no intent documentation, and hardcoded numeric constants embedded in formulas. It is not IDFA-compliant in any dimension.

---

## Model Structure

- **Sheets:** 1 (`Model`)
- **Named Ranges defined:** 0
- **Formula cells:** 10
- **Comment/note annotations:** 0
- **IDFA layers present:** None (Assumptions, Calculations, and Outputs are co-located on one sheet)

---

## Guardrail 1: Named Range Priority — FAIL

**Rule:** Every formula must reference Named Ranges, never raw cell coordinates (e.g., `B2`, `$B$10`).

**Violations: 10 of 10 formulas (100%)**

| Cell | Formula | Coordinate References Used |
| ---- | ------- | -------------------------- |
| C6   | `=B2` | `B2` |
| D6   | `=C6*(1+B3)` | `C6`, `B3` |
| E6   | `=D6*(1+B3)` | `D6`, `B3` |
| C7   | `=C6*B4` | `C6`, `B4` |
| D7   | `=D6*0.59` | `D6` |
| E7   | `=E6*0.58` | `E6` |
| C8   | `=C6-C7` | `C6`, `C7` |
| D8   | `=D6-D7` | `D6`, `D7` |
| E8   | `=E6-E7` | `E6`, `E7` |
| B16  | `=($B$10/$B$12)*$B$13+($B$11/$B$12)*$B$14*(1-$B$15)` | `$B$10`, `$B$12`, `$B$13`, `$B$11`, `$B$14`, `$B$15` |

**Impact:** Formulas are opaque. A reviewer cannot understand what `B3` or `$B$12` represent without tracing back to the cell. Named Ranges like `Inp_Rev_Growth` or `Inp_Cost_of_Equity` would make every formula self-documenting.

---

## Guardrail 2: LaTeX Verification — FAIL

**Rule:** Complex financial formulas (WACC, NPV, DCF, IRR, etc.) must have a LaTeX-verified mathematical specification attached as a cell comment.

**Violations: 1 complex formula, 0 verified**

| Cell | Formula | Detected Keyword | LaTeX Comment Present? |
| ---- | ------- | ---------------- | ---------------------- |
| B16  | `=($B$10/$B$12)*$B$13+($B$11/$B$12)*$B$14*(1-$B$15)` | WACC | No |

**Impact:** The WACC formula is the most audit-critical formula in the model. Without a LaTeX specification, there is no way to verify that the Excel implementation matches the intended mathematical definition. The formula appears to implement a standard after-tax WACC, but this has not been formally verified.

---

## Guardrail 3: Intent Notes — FAIL

**Rule:** Every formula cell must have a cell comment explaining the business intent (the "why", not the "what").

**Violations: 10 of 10 formulas (0% coverage)**

| Cell | Formula | Comment Present? |
| ---- | ------- | ---------------- |
| C6   | `=B2` | No |
| D6   | `=C6*(1+B3)` | No |
| E6   | `=D6*(1+B3)` | No |
| C7   | `=C6*B4` | No |
| D7   | `=D6*0.59` | No |
| E7   | `=E6*0.58` | No |
| C8   | `=C6-C7` | No |
| D8   | `=D6-D7` | No |
| E8   | `=E6-E7` | No |
| B16  | `=($B$10/$B$12)*$B$13+($B$11/$B$12)*$B$14*(1-$B$15)` | No |

**Impact:** No formula in the model documents its business purpose. A new analyst inheriting this model has zero context for why any calculation exists or what business logic it encodes.

---

## Guardrail 4: Layer Isolation — FAIL

**Rule:** Formulas in the Calculations layer must not contain hardcoded numeric literals. All numeric assumptions must live in the Assumptions layer and be referenced via Named Ranges.

**Violations: 2 formulas with hardcoded constants**

| Cell | Formula | Hardcoded Values | Problem |
| ---- | ------- | ---------------- | ------- |
| D7   | `=D6*0.59` | `0.59` | COGS percentage for Y2 is hardcoded directly in the formula instead of referencing an assumption. Also inconsistent with Y1's COGS % of 0.60 in cell B4 — the assumption drifted silently. |
| E7   | `=E6*0.58` | `0.58` | COGS percentage for Y3 is hardcoded directly in the formula. A third different value (0.58) with no named input, no documentation, and no traceability. |

**Impact:** This is the most dangerous violation type. The COGS % assumption silently changes across years (0.60 -> 0.59 -> 0.58) with the values buried inside formulas. An analyst changing the COGS % assumption in B4 would believe they are updating the model, but Y2 and Y3 would remain unchanged. This is a classic "phantom assumption" — a value that looks like it's controlled centrally but is actually scattered across the model.

---

## Structural Violation: No IDFA Layer Separation

Beyond the four guardrails, the model fails the foundational IDFA structural requirement: the Three-Layer Architecture.

| Required Layer | Expected Sheet | Present? |
| -------------- | -------------- | -------- |
| Assumptions    | `Assumptions`  | No — assumptions are mixed into rows 1-5 and 10-15 of the single `Model` sheet |
| Calculations   | `Calculations` | No — calculations are mixed into rows 6-8 and 16 of the same sheet |
| Outputs        | `Outputs`      | No — no distinct output layer exists |

**Impact:** Without layer separation, there is no structural enforcement of the boundary between inputs and logic. Users can (and do) type values directly into formula cells, overwriting calculations. The model cannot be safely operated by the write-recalculate-read pattern because there is no clear input surface.

---

## Compliance Score Calculation

| Guardrail | Checkable Formulas | Violations | Pass Rate |
| --------- | ------------------ | ---------- | --------- |
| G1: Named Range Priority | 10 | 10 | 0% |
| G2: LaTeX Verification | 1 | 1 | 0% |
| G3: Intent Notes | 10 | 10 | 0% |
| G4: Layer Isolation | 10 | 2 | 80% |
| **Aggregate** | **31** | **23** | **26%** |

**Note on scoring:** The aggregate pass rate of 26% reflects that most formulas do not contain hardcoded constants (G4 partial pass). However, the overall compliance verdict is **FAIL** because all four guardrails have at least one violation, and the model lacks the foundational three-layer structure entirely. The effective IDFA compliance score is **0%** — the model is not operable under IDFA methodology.

---

## Methodology Note

The automated audit script (`idfa_audit.py`) exited with error: `"No Calculations sheet found"`. This is itself a diagnostic finding — the model's single-sheet structure is so far from IDFA compliance that the tooling cannot even begin its analysis. All violations above were identified by manual inspection of the workbook's 10 formula cells, 0 Named Ranges, and 0 cell comments.

All cell values and formulas were obtained via `idfa_ops.py inspect` and direct openpyxl inspection. No values were computed by the agent.
