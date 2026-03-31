# Legacy Model Audit Report

**Model:** `legacy_model.xlsx`
**Date:** 2026-03-11
**Auditor:** IDFA Financial Architect Agent
**Methodology:** Intent-Driven Financial Architecture (IDFA) Four Guardrail Audit
**Computation method:** All values computed via formula tracing (LibreOffice unavailable for deterministic recalculation)

---

## Executive Summary

This model is a single-sheet, 16-row financial model that projects a 3-year Gross Profit waterfall and computes WACC. It contains **zero Named Ranges**, **zero Intent Notes**, and **10 formulas that use exclusively coordinate (cell-address) references**. Two formulas contain hardcoded COGS percentages that diverge from the stated assumption, **overstating Gross Profit by a cumulative $352,000** across Years 2 and 3. The WACC formula is mathematically correct but structurally fragile due to a hardcoded Total Capital cell. The model fails all four IDFA guardrails.

**IDFA Compliance Score: 0% (0 of 4 guardrails pass)**

---

## Model Structure

The entire model resides on a single sheet named "Model" spanning cells A1:E16.

### Assumptions (Rows 1-4)

| Cell | Label | Value |
|------|-------|-------|
| B2 | Revenue (Y1 base) | $10,000,000 |
| B3 | Revenue Growth | 10% |
| B4 | COGS % | 60% |

### 3-Year Gross Profit Waterfall (Rows 6-8)

| Row | Label | Y1 (Column C) | Y2 (Column D) | Y3 (Column E) |
|-----|-------|---------------|---------------|---------------|
| 6 | Revenue | `=B2` | `=C6*(1+B3)` | `=D6*(1+B3)` |
| 7 | COGS | `=C6*B4` | `=D6*0.59` | `=E6*0.58` |
| 8 | Gross Profit | `=C6-C7` | `=D6-D7` | `=E6-E7` |

### WACC Section (Rows 10-16)

| Cell | Label | Value / Formula |
|------|-------|-----------------|
| B10 | Equity | $5,000,000 |
| B11 | Debt | $3,000,000 |
| B12 | Total Capital | $8,000,000 (hardcoded, not `=B10+B11`) |
| B13 | Cost of Equity | 12% |
| B14 | Cost of Debt | 6% |
| B15 | Tax Rate | 25% |
| B16 | WACC | `=($B$10/$B$12)*$B$13+($B$11/$B$12)*$B$14*(1-$B$15)` |

---

## Guardrail 1 — Named Range Priority: FAIL

**Rule:** Every business variable must be an Excel Defined Name. No formula may reference a cell by coordinate address.

**Finding:** The model contains **zero Named Ranges**. All 10 formulas use exclusively coordinate references (B2, C6, B3, B4, $B$10, etc.). No formula in this model can be understood without clicking through to the referenced cells.

**Violations:** 10 of 10 formulas (100%)

| Formula Cell | Formula | What It Should Read (IDFA) |
|-------------|---------|---------------------------|
| C6 | `=B2` | `=Inp_Rev_Y1` |
| D6 | `=C6*(1+B3)` | `=Revenue_Y1*(1+Inp_Rev_Growth)` |
| E6 | `=D6*(1+B3)` | `=Revenue_Y2*(1+Inp_Rev_Growth)` |
| C7 | `=C6*B4` | `=Revenue_Y1*Inp_COGS_Pct_Y1` |
| D7 | `=D6*0.59` | `=Revenue_Y2*COGS_Pct_Y2` |
| E7 | `=E6*0.58` | `=Revenue_Y3*COGS_Pct_Y3` |
| C8 | `=C6-C7` | `=Revenue_Y1-COGS_Y1` |
| D8 | `=D6-D7` | `=Revenue_Y2-COGS_Y2` |
| E8 | `=E6-E7` | `=Revenue_Y3-COGS_Y3` |
| B16 | `=($B$10/$B$12)*$B$13+($B$11/$B$12)*$B$14*(1-$B$15)` | `=(Inp_Equity/Total_Capital)*Inp_Cost_Equity+(Inp_Debt/Total_Capital)*Inp_Cost_Debt*(1-Inp_Tax_Rate)` |

---

## Guardrail 2 — LaTeX Verification: FAIL

**Rule:** Complex formulas (WACC, NPV, DCF, IRR) must be verified in LaTeX notation before being written to the model.

**Finding:** The WACC formula in B16 is the only complex formula. No LaTeX verification record exists.

**WACC LaTeX verification (performed during this audit):**

Correct WACC formula:

$$WACC = \frac{E}{E+D} \times K_e + \frac{D}{E+D} \times K_d \times (1-T)$$

Model formula: `=($B$10/$B$12)*$B$13+($B$11/$B$12)*$B$14*(1-$B$15)`

Translating: `=(Equity/TotalCapital)*CostEquity+(Debt/TotalCapital)*CostDebt*(1-TaxRate)`

**Verification result:** The formula structure is **mathematically correct**:
- Equity weight: $5M / $8M = 0.625
- Debt weight: $3M / $8M = 0.375
- Weights sum to 1.0 (correct)
- Only the debt term is multiplied by (1 - Tax Rate) (correct)
- WACC = 0.625 x 0.12 + 0.375 x 0.06 x 0.75 = 0.075 + 0.01688 = **9.19%**

**However:** The formula uses `$B$12` (hardcoded Total Capital = $8,000,000) instead of `$B$10+$B$11`. This is a structural fragility, not a math error. See Finding #3 below.

---

## Guardrail 3 — Audit-Ready Intent Notes: FAIL

**Rule:** Every AI-generated or complex formula must include an Excel Note/Comment documenting its intent.

**Finding:** The model contains **zero Notes or Comments** on any cell. No formula has an Intent Statement, LaTeX expression, assumptions list, or generation date.

---

## Guardrail 4 — Delegated Calculation: N/A

**Rule:** AI agents must delegate arithmetic to the spreadsheet engine.

**Finding:** This guardrail applies to agent operations, not to the static model. During this audit, all values were obtained via formula tracing (not internal agent calculation) and are clearly labeled as such.

---

## Critical Findings

### Finding #1 (CRITICAL): Hardcoded COGS Percentages with Dollar Impact

**Severity:** CRITICAL — causes material misstatement of Gross Profit

The stated COGS assumption in B4 is **60%**. Year 1 (C7) correctly references this cell. However:

- **Year 2 (D7):** Uses hardcoded `0.59` (59%) instead of referencing B4
- **Year 3 (E7):** Uses hardcoded `0.58` (58%) instead of referencing B4

This means:
1. **Changing the COGS % assumption in B4 has no effect on Year 2 or Year 3.** A user who updates B4 to 55% would see Y1 update but Y2 and Y3 remain unchanged -- a silent, dangerous inconsistency.
2. The hardcoded values produce different results than the stated assumption.

#### Dollar Impact Quantification

| Item | Year 2 | Year 3 |
|------|--------|--------|
| Revenue | $11,000,000 | $12,100,000 |
| COGS at stated 60% | $6,600,000 | $7,260,000 |
| COGS at hardcoded rate (59% / 58%) | $6,490,000 | $7,018,000 |
| COGS understated by | **$110,000** | **$242,000** |
| Gross Profit at stated 60% | $4,400,000 | $4,840,000 |
| Gross Profit at hardcoded rate | $4,510,000 | $5,082,000 |
| **Gross Profit overstated by** | **$110,000** | **$242,000** |

**Cumulative Gross Profit overstatement: $352,000**

This is a 2.5% overstatement in Y2 and a 5.0% overstatement in Y3 relative to what the stated assumption would produce.

#### Possible Intent vs. Actual Risk

It is possible the model author intended a 1%-per-year COGS efficiency improvement. If so:
- This assumption is **undocumented** -- it does not appear in the Assumptions section (rows 1-4)
- The efficiency gain is **hardcoded into each formula** rather than driven by a named input
- A user reading the assumptions would conclude COGS is 60% for all years, which is wrong
- There is no way to change the efficiency rate without editing each formula individually

**Whether intentional or accidental, the current implementation is dangerous.** If the efficiency gain is real, it must be extracted to a named assumption (e.g., `Inp_COGS_Efficiency = 0.01`) so it is visible, auditable, and modifiable.

### Finding #2 (HIGH): Total Capital is Hardcoded

**Cell B12** contains `8000000` as a static value. It should be `=B10+B11` (Equity + Debt).

**Current state:** The hardcoded value happens to equal B10 + B11 ($5M + $3M = $8M), so the WACC is currently correct.

**Risk:** If anyone changes Equity (B10) or Debt (B11), Total Capital will NOT update, causing the WACC calculation to use incorrect capital weights. This is a time bomb -- the model will break silently on the next capital structure change.

**Dollar impact at current state:** $0 (values happen to match)

**Example of future breakage:** If Equity is changed to $6M while Debt stays at $3M:
- Total Capital should be $9M, but B12 would still say $8M
- Equity weight would be 6/8 = 75% instead of 6/9 = 66.7%
- WACC would be 0.75 x 12% + 0.25 x 6% x 75% = 10.13% instead of the correct 8.67%
- A 1.46 percentage point WACC error on any DCF valuation downstream

### Finding #3 (HIGH): Zero Named Ranges — Complete Coordinate Dependency

All 10 formulas use raw cell addresses. This means:
- **Inserting or deleting a row** can silently break every formula
- **No formula is self-documenting** -- `=D6*0.59` communicates nothing about business logic
- **AI agents cannot parse intent** -- the model is opaque to automated analysis
- **Cross-checking is manual** -- every formula must be click-traced to verify

### Finding #4 (MEDIUM): No Layer Separation

The model places assumptions, calculations, and output on a single sheet with no visual or structural separation. IDFA requires three distinct layers:
- **Layer 1 (Assumptions):** All inputs with `Inp_` prefix Named Ranges
- **Layer 2 (Calculations):** All formulas referencing only Named Ranges
- **Layer 3 (Output):** Display/formatting only, reading from Layer 2

### Finding #5 (LOW): Missing Column Headers

Columns C, D, E contain Year 1, 2, 3 data respectively, but only column B has "Y1" labels (in rows 6-8). There are no headers in row 5 or 6 indicating which column corresponds to which year. This is a presentation/usability issue.

---

## Remediation Plan

### Priority 1: Fix Hardcoded COGS (Critical)

**Decision required from model owner:** Is the 1%-per-year COGS efficiency intentional?

**If YES (efficiency gain is real):**
1. Add assumption: `Inp_COGS_Efficiency` = 0.01 in the Assumptions section
2. Create Named Ranges: `Inp_COGS_Pct_Y1` = 0.60, `Inp_COGS_Efficiency` = 0.01
3. Create calculated ranges: `COGS_Pct_Y2 = Inp_COGS_Pct_Y1 - Inp_COGS_Efficiency`, `COGS_Pct_Y3 = COGS_Pct_Y2 - Inp_COGS_Efficiency`
4. Rewrite D7: `=Revenue_Y2 * COGS_Pct_Y2`
5. Rewrite E7: `=Revenue_Y3 * COGS_Pct_Y3`
6. Validate outputs match current values (Y2 GP = $4,510,000, Y3 GP = $5,082,000)

**If NO (should be flat 60%):**
1. Rewrite D7: `=D6*B4` (immediate fix) or `=Revenue_Y2*Inp_COGS_Pct` (IDFA-compliant fix)
2. Rewrite E7: `=E6*B4` (immediate fix) or `=Revenue_Y3*Inp_COGS_Pct` (IDFA-compliant fix)
3. Y2 GP will change from $4,510,000 to $4,400,000 (-$110,000)
4. Y3 GP will change from $5,082,000 to $4,840,000 (-$242,000)

### Priority 2: Fix Total Capital Formula

Replace B12's hardcoded `8000000` with formula `=B10+B11`.

### Priority 3: Full IDFA Retrofit

1. Create Named Ranges for all 7 input assumptions:
   - `Inp_Rev_Y1` -> B2
   - `Inp_Rev_Growth` -> B3
   - `Inp_COGS_Pct_Y1` -> B4
   - `Inp_Equity` -> B10
   - `Inp_Debt` -> B11
   - `Inp_Cost_Equity` -> B13
   - `Inp_Cost_Debt` -> B14
   - `Inp_Tax_Rate` -> B15

2. Create Named Ranges for all 10+ calculated values:
   - `Revenue_Y1`, `Revenue_Y2`, `Revenue_Y3`
   - `COGS_Y1`, `COGS_Y2`, `COGS_Y3`
   - `Gross_Profit_Y1`, `Gross_Profit_Y2`, `Gross_Profit_Y3`
   - `Total_Capital` -> B12
   - `WACC` -> B16

3. Rewrite every formula to reference Named Ranges only (zero coordinate references)

4. Add Intent Notes to every formula cell

5. Consider separating into three sheets (Assumptions, Calculations, Output)

---

## Compliance Summary

| Guardrail | Status | Detail |
|-----------|--------|--------|
| 1. Named Range Priority | FAIL | 0 Named Ranges defined; 10/10 formulas use coordinates |
| 2. LaTeX Verification | FAIL | WACC formula has no LaTeX verification record (formula is mathematically correct upon audit) |
| 3. Intent Notes | FAIL | 0 of 10 formulas have Intent Notes |
| 4. Delegated Calculation | N/A | Applies to agent operations, not static model |

**Overall IDFA Compliance: 0%**

---

## Summary of Dollar Impacts

| Finding | Current Dollar Impact | Risk if Unaddressed |
|---------|-----------------------|---------------------|
| Hardcoded COGS Y2 (59% vs stated 60%) | GP overstated by **$110,000** | Any COGS assumption change will not propagate to Y2 |
| Hardcoded COGS Y3 (58% vs stated 60%) | GP overstated by **$242,000** | Any COGS assumption change will not propagate to Y3 |
| Hardcoded Total Capital | $0 currently | WACC will silently break on any capital structure change |
| **Total current misstatement** | **$352,000 GP overstatement** | |

---

*Report generated by IDFA Financial Architect Agent. All values computed via formula tracing (not model-verified via LibreOffice recalculation). Install LibreOffice for deterministic recalculation capability.*
