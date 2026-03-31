# IDFA Compliance Audit Report: legacy_model.xlsx

**Audit date:** 2026-03-11
**Auditor:** IDFA Financial Architect Agent
**Methodology:** Intent-Driven Financial Architecture (IDFA) v1.0, Panaversity
**Source file:** `skills/financial-architect/evals/files/legacy_model.xlsx`
**Working copy:** `outputs/legacy_model.xlsx`

---

## Executive Summary

This model is a single-sheet, coordinate-reference-only financial model with
**zero IDFA compliance**. It contains a 3-year gross profit waterfall and a WACC
calculation, all encoded using cell addresses with no Named Ranges, no Intent
Notes, no LaTeX verification, and no layer separation. Every formula in the model
must be manually traced to be understood.

**Overall IDFA Compliance Score: 0 / 100**

| Guardrail | Status | Detail |
|-----------|--------|--------|
| 1. Named Range Priority | FAIL | 0 Named Ranges defined. All 10 formulas use coordinate references exclusively. |
| 2. LaTeX Verification | FAIL | 0 formulas have LaTeX verification. WACC formula requires mandatory LaTeX check. |
| 3. Audit-Ready Intent Notes | FAIL | 0 cells have comments or Intent Notes of any kind. |
| 4. Delegated Calculation | N/A | This guardrail applies to agent-generated formulas during operation. |

---

## Model Structure Overview

The model consists of a single sheet named "Model" with two logical sections
intermixed on one sheet (no layer separation):

### Section 1: Revenue / COGS / Gross Profit Waterfall (Rows 1-8)

| Cell | Content | Type |
|------|---------|------|
| A1 | "Assumptions" | Label |
| B2 | 10,000,000 | Input: Base revenue |
| B3 | 10.00% | Input: Revenue growth rate |
| B4 | 60.00% | Input: COGS percentage (Y1 only) |
| C6:E6 | Revenue Y1-Y3 | Calculated |
| C7:E7 | COGS Y1-Y3 | Calculated |
| C8:E8 | Gross Profit Y1-Y3 | Calculated |

### Section 2: WACC Calculation (Rows 10-16)

| Cell | Content | Type |
|------|---------|------|
| B10 | 5,000,000 | Input: Equity value |
| B11 | 3,000,000 | Input: Debt value |
| B12 | 8,000,000 | Input: Total capital (HARDCODED -- see Issue #5) |
| B13 | 12.00% | Input: Cost of equity |
| B14 | 6.00% | Input: Cost of debt |
| B15 | 25.00% | Input: Tax rate |
| B16 | WACC formula | Calculated |

---

## Issues Found

### Issue #1: CRITICAL -- Hardcoded COGS Percentages in Y2 and Y3

**Cells affected:** D7, E7

**What is wrong:** The COGS formula for Year 1 references the COGS % assumption
in cell B4 (`=C6*B4`), but Years 2 and 3 abandon this pattern and hardcode the
COGS percentages directly into the formulas:

| Year | Formula | COGS % Source |
|------|---------|---------------|
| Y1 | `=C6*B4` | Cell B4 (0.60) -- referenced |
| Y2 | `=D6*0.59` | Hardcoded 0.59 |
| Y3 | `=E6*0.58` | Hardcoded 0.58 |

**Why this is dangerous:** If someone changes the COGS assumption in B4 (e.g.,
from 60% to 55%), only Year 1 will update. Years 2 and 3 will remain at 59% and
58% respectively, producing silently incorrect results. The model gives no
indication that Y2 and Y3 are disconnected from the input assumption. This is the
textbook case of **Logic Diffusion** -- the same business concept (COGS percentage)
is controlled from different locations, and only some of them will be updated.

**What the model builder likely intended:** COGS % starts at 60% and improves by
1 percentage point per year due to scale efficiencies. But the efficiency gain
(1%) is not captured as an explicit assumption -- it is baked invisibly into two
hardcoded values.

**Remediation:** Create an explicit efficiency assumption (`Inp_COGS_Efficiency = 0.01`)
and derive each year's COGS % from the prior year:

```
COGS_Pct_Y1 = Inp_COGS_Pct_Y1
COGS_Pct_Y2 = COGS_Pct_Y1 - Inp_COGS_Efficiency
COGS_Pct_Y3 = COGS_Pct_Y2 - Inp_COGS_Efficiency
COGS_Y2     = Revenue_Y2 * COGS_Pct_Y2
COGS_Y3     = Revenue_Y3 * COGS_Pct_Y3
```

**Priority:** P0 -- this is a silent-breakage risk that will produce wrong numbers
the moment any user adjusts the COGS assumption.

---

### Issue #2: HIGH -- No Named Ranges Defined

**Cells affected:** All 10 formula cells

Every formula in the model uses cell-coordinate references (A1 notation). There
are zero Named Ranges defined anywhere in the workbook. This means:

- No formula is self-documenting -- you must click through every reference to
  understand what a formula calculates
- The model is fragile -- inserting a row or column will shift references and
  can silently break formulas
- AI agents cannot infer business intent from coordinate references
- Audit requires manual tracing of every formula chain

**Complete formula inventory with coordinate references:**

| Cell | Formula | Coordinate Refs Used |
|------|---------|---------------------|
| C6 | `=B2` | B2 |
| D6 | `=C6*(1+B3)` | C6, B3 |
| E6 | `=D6*(1+B3)` | D6, B3 |
| C7 | `=C6*B4` | C6, B4 |
| D7 | `=D6*0.59` | D6 |
| E7 | `=E6*0.58` | E6 |
| C8 | `=C6-C7` | C6, C7 |
| D8 | `=D6-D7` | D6, D7 |
| E8 | `=E6-E7` | E6, E7 |
| B16 | `=($B$10/$B$12)*$B$13+($B$11/$B$12)*$B$14*(1-$B$15)` | B10, B12, B13, B11, B14, B15 |

**Total coordinate references across all formulas:** 22

**Remediation:** Define Named Ranges for every input and every calculated cell per
the IDFA naming conventions:

**Input Named Ranges (Layer 1):**

| Named Range | Cell | Current Value |
|-------------|------|---------------|
| `Inp_Rev_Y1` | B2 | 10,000,000 |
| `Inp_Rev_Growth` | B3 | 0.10 |
| `Inp_COGS_Pct_Y1` | B4 | 0.60 |
| `Inp_COGS_Efficiency` | (new) | 0.01 |
| `Inp_Equity` | B10 | 5,000,000 |
| `Inp_Debt` | B11 | 3,000,000 |
| `Inp_Cost_Equity` | B13 | 0.12 |
| `Inp_Cost_Debt` | B14 | 0.06 |
| `Inp_Tax_Rate` | B15 | 0.25 |

**Calculation Named Ranges (Layer 2):**

| Named Range | Cell | IDFA Formula |
|-------------|------|-------------|
| `Revenue_Y1` | C6 | `=Inp_Rev_Y1` |
| `Revenue_Y2` | D6 | `=Revenue_Y1*(1+Inp_Rev_Growth)` |
| `Revenue_Y3` | E6 | `=Revenue_Y2*(1+Inp_Rev_Growth)` |
| `COGS_Pct_Y1` | (new) | `=Inp_COGS_Pct_Y1` |
| `COGS_Pct_Y2` | (new) | `=COGS_Pct_Y1-Inp_COGS_Efficiency` |
| `COGS_Pct_Y3` | (new) | `=COGS_Pct_Y2-Inp_COGS_Efficiency` |
| `COGS_Y1` | C7 | `=Revenue_Y1*COGS_Pct_Y1` |
| `COGS_Y2` | D7 | `=Revenue_Y2*COGS_Pct_Y2` |
| `COGS_Y3` | E7 | `=Revenue_Y3*COGS_Pct_Y3` |
| `Gross_Profit_Y1` | C8 | `=Revenue_Y1-COGS_Y1` |
| `Gross_Profit_Y2` | D8 | `=Revenue_Y2-COGS_Y2` |
| `Gross_Profit_Y3` | E8 | `=Revenue_Y3-COGS_Y3` |
| `Total_Capital` | B12 | `=Inp_Equity+Inp_Debt` |
| `WACC` | B16 | `=(Inp_Equity/Total_Capital)*Inp_Cost_Equity+(Inp_Debt/Total_Capital)*Inp_Cost_Debt*(1-Inp_Tax_Rate)` |

**Priority:** P0 -- foundational requirement for all other guardrails.

---

### Issue #3: HIGH -- No Layer Separation

**Cells affected:** Entire sheet

The model puts inputs, calculations, and labels all on a single sheet ("Model")
with no structural separation. Rows 2-4 contain assumptions, rows 6-8 contain
calculations that reference those assumptions, and rows 10-16 interleave
assumptions (B10-B15) with a derived value (B12) and a calculation (B16).

**Specific layer violations:**

1. Assumptions and calculations share the same sheet -- no Assumptions layer
2. There is no Output/Presentation layer at all
3. B12 (Total Capital = 8,000,000) is a hardcoded value that should be a
   calculation (`=Inp_Equity+Inp_Debt`) but lives in the assumptions section
4. No visual or structural delineation between input cells and formula cells

**Remediation:** Restructure into three sheets:

- **Assumptions** -- all `Inp_` Named Ranges (user-modifiable inputs only)
- **Calculations** -- all formulas referencing Named Ranges only
- **Output** -- presentation-ready tables reading from Calculations layer only

**Priority:** P1 -- important for maintainability and IDFA compliance, but
can be addressed after Named Ranges are established.

---

### Issue #4: HIGH -- WACC Formula Uses Absolute Cell References as Pseudo-Names

**Cell affected:** B16

**Current formula:**
```
=($B$10/$B$12)*$B$13+($B$11/$B$12)*$B$14*(1-$B$15)
```

While the formula is **mathematically correct**, it uses absolute cell references
(`$B$10`, `$B$12`, etc.) as a substitute for Named Ranges. This makes the formula
impossible to understand without clicking through each reference.

**LaTeX verification of the mathematical expression:**

$$WACC = \frac{E}{E+D} \times K_e + \frac{D}{E+D} \times K_d \times (1-T)$$

Substituting the current values:

$$WACC = \frac{5{,}000{,}000}{8{,}000{,}000} \times 0.12 + \frac{3{,}000{,}000}{8{,}000{,}000} \times 0.06 \times (1-0.25)$$

$$WACC = 0.625 \times 0.12 + 0.375 \times 0.06 \times 0.75$$

$$WACC = 0.075 + 0.016875 = 0.091875 = 9.1875\%$$

**Verification checklist:**
- Equity weight (0.625) + Debt weight (0.375) = 1.0 -- PASS
- Tax shield applied only to debt term -- PASS
- Cost of equity and cost of debt both in decimal form -- PASS
- Formula structure matches standard WACC -- PASS

**The math is correct.** The problem is purely structural -- it uses coordinates
instead of names.

**IDFA-compliant replacement:**
```
=(Inp_Equity/Total_Capital)*Inp_Cost_Equity+(Inp_Debt/Total_Capital)*Inp_Cost_Debt*(1-Inp_Tax_Rate)
```

This formula reads as a plain-English business rule. Any reader can verify the
WACC calculation without clicking a single cell.

**Priority:** P1 -- the formula is correct, so this is a readability/maintainability
issue rather than a correctness issue.

---

### Issue #5: MEDIUM -- Total Capital is Hardcoded Instead of Calculated

**Cell affected:** B12

**Current value:** 8,000,000 (hardcoded constant)

**Expected formula:** `=B10+B11` (or in IDFA: `=Inp_Equity+Inp_Debt`)

Total Capital should be the sum of Equity and Debt. Currently it happens to equal
5,000,000 + 3,000,000 = 8,000,000, so the number is correct. But if someone
updates Equity (B10) or Debt (B11), Total Capital will not update, and the WACC
formula will use the wrong capital structure weights.

**This is another silent-breakage risk.** The formula `=($B$10/$B$12)` in the WACC
cell divides Equity by Total Capital. If Equity changes to 6,000,000 but Total
Capital stays at 8,000,000, the equity weight becomes 0.75 instead of the correct
0.667 (6M / 9M).

**Remediation:** Replace the hardcoded value with `=Inp_Equity+Inp_Debt`.

**Priority:** P0 -- this will produce incorrect WACC if either Equity or Debt
inputs are changed.

---

### Issue #6: MEDIUM -- No Intent Notes or Documentation

**Cells affected:** All formula cells

No cell in the model has an Excel Comment or Note. There is no documentation
explaining:
- What each formula is intended to calculate
- What assumptions each formula depends on
- When the model was built or last modified
- What business decisions the model supports

This means anyone inheriting the model (exactly the user's situation) must
reverse-engineer every formula from scratch.

**Remediation:** Add IDFA Intent Notes to every formula cell in the format:

```
INTENT:      [Plain-English rule]
FORMULA:     [LaTeX expression]
ASSUMPTIONS: [Named Ranges referenced]
GENERATED:   [Date]
```

**Priority:** P1 -- important for maintainability and audit readiness.

---

### Issue #7: LOW -- Revenue Y1 Formula is a Pass-Through

**Cell affected:** C6

**Current formula:** `=B2`

This formula simply copies the value from B2 (the base revenue assumption) into
the Revenue Y1 calculation cell. While not technically wrong, it creates an
unnecessary indirection. In IDFA, this is acceptable as `Revenue_Y1 = Inp_Rev_Y1`
-- it cleanly separates the input layer from the calculation layer. The issue is
that without Named Ranges, it just looks like a pointless cell reference.

**Remediation:** Once Named Ranges are defined, this becomes
`Revenue_Y1 = Inp_Rev_Y1`, which is self-documenting and correct.

**Priority:** P2 -- not a bug; resolves naturally during retrofit.

---

## Remediation Plan

### Phase 1: Fix Silent-Breakage Risks (P0)

These must be fixed first because they produce incorrect results under common
usage scenarios.

| Step | Action | Cells | Risk if Skipped |
|------|--------|-------|----------------|
| 1a | Create `Inp_COGS_Efficiency` named range with value 0.01 | New cell | COGS Y2/Y3 remain disconnected from assumptions |
| 1b | Rewrite D7 as `=Revenue_Y2*COGS_Pct_Y2` (where COGS_Pct_Y2 derives from Inp_COGS_Pct_Y1 - Inp_COGS_Efficiency) | D7 | Changing B4 only affects Y1 |
| 1c | Rewrite E7 as `=Revenue_Y3*COGS_Pct_Y3` | E7 | Same as above |
| 1d | Replace B12 hardcoded 8,000,000 with `=Inp_Equity+Inp_Debt` | B12 | Changing Equity or Debt produces wrong WACC |

### Phase 2: Establish Named Ranges (P0)

| Step | Action | Count |
|------|--------|-------|
| 2a | Define all input Named Ranges (Inp_ prefix) | 9 ranges |
| 2b | Define all calculation Named Ranges | 14 ranges |
| 2c | Rewrite all 10 formulas to use Named Ranges exclusively | 10 formulas |
| 2d | Validate that all outputs match original values after conversion | Full model |

### Phase 3: Add Documentation (P1)

| Step | Action | Count |
|------|--------|-------|
| 3a | Add Intent Notes to all formula cells | 10 cells |
| 3b | Add LaTeX verification note to WACC cell | 1 cell |
| 3c | Document the COGS efficiency assumption rationale | 1 note |

### Phase 4: Layer Separation (P1)

| Step | Action |
|------|--------|
| 4a | Create Assumptions sheet with all Inp_ ranges |
| 4b | Create Calculations sheet with all formula cells |
| 4c | Create Output sheet with formatted presentation tables |
| 4d | Validate all cross-sheet references resolve correctly |

---

## Compliance Scorecard

| Guardrail | Current | Target | Gap |
|-----------|---------|--------|-----|
| 1. Named Range Priority | 0% (0/10 formulas) | 100% (10/10 formulas) | 10 formulas to rewrite |
| 2. LaTeX Verification | 0% (0/1 complex formula) | 100% (1/1) | WACC needs LaTeX note |
| 3. Intent Notes | 0% (0/10 cells) | 100% (10/10 cells) | 10 Intent Notes to add |
| 4. Delegated Calculation | N/A | N/A | Runtime guardrail |
| **Overall** | **0%** | **100%** | **Full retrofit required** |

---

## Summary of Findings

| Category | Count |
|----------|-------|
| Total formulas in model | 10 |
| Formulas using coordinate references | 10 (100%) |
| Formulas with hardcoded constants | 2 (D7, E7) |
| Named Ranges defined | 0 |
| Intent Notes present | 0 |
| LaTeX verifications present | 0 |
| Silent-breakage risks (P0) | 2 (COGS hardcoding, Total Capital hardcoding) |
| Mathematical errors found | 0 (all formulas produce correct results with current inputs) |
| Layer separation | None (single sheet) |

**Bottom line:** The model produces correct numbers today, but it is structurally
fragile. Two specific issues (hardcoded COGS percentages in Y2/Y3 and hardcoded
Total Capital) will produce silently incorrect results the moment a user changes
the relevant inputs. The model requires a complete IDFA retrofit -- Named Ranges,
layer separation, Intent Notes, and LaTeX verification -- to be maintainable,
auditable, and safe for ongoing use.

---

*Audit performed using IDFA methodology v1.0. All formula inspection performed
via `idfa_ops.py inspect`. WACC verification computed via formula tracing for
LaTeX validation.*
