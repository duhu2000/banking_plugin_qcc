# IDFA Retrofit Results — Legacy Model (First 3 Formulas)

**Date:** 2026-03-11
**Agent:** IDFA Financial Architect
**Methodology:** Intent-Driven Financial Architecture (IDFA) by Panaversity
**Source file:** `skills/financial-architect/evals/files/legacy_model.xlsx`
**Output file:** `financial-architect-workspace/iteration-2/retrofit-one-formula-at-a-time/with_skill/outputs/legacy_model.xlsx`

---

## Executive Summary

Converted the first 3 formulas of the legacy model from coordinate-reference style to
IDFA-compliant Named Range notation. All 10 output values validated against the
baseline after recalculation — zero numeric drift detected.

---

## Legacy Model Structure (Pre-Retrofit)

The legacy model is a single-sheet ("Model") workbook with:
- **3 input assumptions** (hardcoded values in B2:B4)
- **9 calculation formulas** using cell-address references (C6:E8)
- **1 WACC formula** with absolute cell references ($B$10/$B$12, etc.)
- **6 capital structure inputs** (B10:B15)
- **0 Named Ranges** — 100% coordinate-reference formulas

### All Legacy Formulas

| Cell | Label         | Legacy Formula                                           |
|------|---------------|----------------------------------------------------------|
| C6   | Revenue Y1    | `=B2`                                                    |
| D6   | Revenue Y2    | `=C6*(1+B3)`                                             |
| E6   | Revenue Y3    | `=D6*(1+B3)`                                             |
| C7   | COGS Y1       | `=C6*B4`                                                 |
| D7   | COGS Y2       | `=D6*0.59`                                               |
| E7   | COGS Y3       | `=E6*0.58`                                               |
| C8   | Gross Profit Y1 | `=C6-C7`                                               |
| D8   | Gross Profit Y2 | `=D6-D7`                                               |
| E8   | Gross Profit Y3 | `=E6-E7`                                               |
| B16  | WACC          | `=($B$10/$B$12)*$B$13+($B$11/$B$12)*$B$14*(1-$B$15)`    |

---

## Baseline Values (Pre-Retrofit)

Computed via LibreOffice recalculation of the original legacy model.

| Output          | Value         |
|-----------------|---------------|
| Revenue Y1      | 10,000,000    |
| Revenue Y2      | 11,000,000    |
| Revenue Y3      | 12,100,000    |
| COGS Y1         | 6,000,000     |
| COGS Y2         | 6,490,000     |
| COGS Y3         | 7,018,000     |
| Gross Profit Y1 | 4,000,000     |
| Gross Profit Y2 | 4,510,000     |
| Gross Profit Y3 | 5,082,000     |
| WACC            | 9.1875%       |

---

## Named Ranges Created

| Named Range      | Cell     | Type        | Value       |
|------------------|----------|-------------|-------------|
| `Inp_Rev_Y1`     | Model!B2 | Input       | 10,000,000  |
| `Inp_Rev_Growth` | Model!B3 | Input       | 0.10        |
| `Revenue_Y1`     | Model!C6 | Calculation | (formula)   |
| `Revenue_Y2`     | Model!D6 | Calculation | (formula)   |
| `Revenue_Y3`     | Model!E6 | Calculation | (formula)   |

---

## Formula Conversions (3 of 10 Completed)

### Formula 1: Revenue Y1 (Cell C6)

- **Intent:** Year 1 Revenue equals the base revenue assumption
- **LaTeX:** $R_1 = \text{Inp\_Rev\_Y1}$
- **Before:** `=B2`
- **After:** `=Inp_Rev_Y1`
- **Named Ranges used:** `Inp_Rev_Y1` (input assumption)
- **Coordinate references eliminated:** `B2`

**Validation after this step:**
All values recalculated via LibreOffice and exported to CSV.
Revenue Y1 = 10,000,000. All downstream values unchanged. PASS.

---

### Formula 2: Revenue Y2 (Cell D6)

- **Intent:** Year 2 Revenue equals Year 1 Revenue grown by the annual growth rate
- **LaTeX:** $R_2 = R_1 \times (1 + g)$
- **Before:** `=C6*(1+B3)`
- **After:** `=Revenue_Y1*(1+Inp_Rev_Growth)`
- **Named Ranges used:** `Revenue_Y1` (calculation), `Inp_Rev_Growth` (input assumption)
- **Coordinate references eliminated:** `C6`, `B3`

**Validation after this step:**
All values recalculated via LibreOffice and exported to CSV.
Revenue Y2 = 11,000,000. All downstream values unchanged. PASS.

---

### Formula 3: Revenue Y3 (Cell E6)

- **Intent:** Year 3 Revenue equals Year 2 Revenue grown by the annual growth rate
- **LaTeX:** $R_3 = R_2 \times (1 + g)$
- **Before:** `=D6*(1+B3)`
- **After:** `=Revenue_Y2*(1+Inp_Rev_Growth)`
- **Named Ranges used:** `Revenue_Y2` (calculation), `Inp_Rev_Growth` (input assumption)
- **Coordinate references eliminated:** `D6`, `B3`

**Validation after this step:**
All values recalculated via LibreOffice and exported to CSV.
Revenue Y3 = 12,100,000. All downstream values unchanged. PASS.

---

## Post-Retrofit Validation (All 3 Formulas)

After all 3 conversions, the entire model was recalculated via LibreOffice
and all 10 output values compared against the baseline.

| Output          | Baseline      | Post-Retrofit | Match |
|-----------------|---------------|---------------|-------|
| Revenue Y1      | 10,000,000    | 10,000,000    | PASS  |
| Revenue Y2      | 11,000,000    | 11,000,000    | PASS  |
| Revenue Y3      | 12,100,000    | 12,100,000    | PASS  |
| COGS Y1         | 6,000,000     | 6,000,000     | PASS  |
| COGS Y2         | 6,490,000     | 6,490,000     | PASS  |
| COGS Y3         | 7,018,000     | 7,018,000     | PASS  |
| Gross Profit Y1 | 4,000,000     | 4,000,000     | PASS  |
| Gross Profit Y2 | 4,510,000     | 4,510,000     | PASS  |
| Gross Profit Y3 | 5,082,000     | 5,082,000     | PASS  |
| WACC            | 9.1875%       | 9.1875%       | PASS  |

**Result: 10/10 values match. Zero numeric drift.**

**Methodology:** All values obtained via LibreOffice deterministic recalculation
(not internal calculation). CSV exports compared between original and retrofitted models.

---

## Remaining Work (7 Formulas)

The following formulas still use coordinate references and/or hardcoded constants.
They should be converted in the same one-at-a-time, validate-after-each-step pattern.

### COGS Formulas (3 formulas)

| Cell | Current Formula | Proposed IDFA Formula                     | Named Ranges Needed                  |
|------|-----------------|-------------------------------------------|--------------------------------------|
| C7   | `=C6*B4`        | `=Revenue_Y1*Inp_COGS_Pct_Y1`            | `Inp_COGS_Pct_Y1` (B4), `COGS_Y1` (C7) |
| D7   | `=D6*0.59`      | `=Revenue_Y2*COGS_Pct_Y2`                | `COGS_Pct_Y2` or `Inp_COGS_Pct_Y2`, `COGS_Y2` (D7) |
| E7   | `=E6*0.58`      | `=Revenue_Y3*COGS_Pct_Y3`                | `COGS_Pct_Y3` or `Inp_COGS_Pct_Y3`, `COGS_Y3` (E7) |

**Note:** D7 and E7 contain hardcoded COGS percentages (0.59 and 0.58). These
must be extracted to Layer 1 input assumptions before the formulas can be rewritten.
This is a COGS efficiency pattern (improving 1% per year from 60%), which could
alternatively be modeled using `Inp_COGS_Pct_Y1` and `Inp_COGS_Efficiency` with
a chain formula: `COGS_Pct_Y2 = COGS_Pct_Y1 - Inp_COGS_Efficiency`.

### Gross Profit Formulas (3 formulas)

| Cell | Current Formula | Proposed IDFA Formula                  | Named Ranges Needed                         |
|------|-----------------|----------------------------------------|---------------------------------------------|
| C8   | `=C6-C7`        | `=Revenue_Y1-COGS_Y1`                 | `Gross_Profit_Y1` (C8)                      |
| D8   | `=D6-D7`        | `=Revenue_Y2-COGS_Y2`                 | `Gross_Profit_Y2` (D8)                      |
| E8   | `=E6-E7`        | `=Revenue_Y3-COGS_Y3`                 | `Gross_Profit_Y3` (E8)                      |

### WACC Formula (1 formula — requires LaTeX verification)

| Cell | Current Formula | Notes |
|------|-----------------|-------|
| B16  | `=($B$10/$B$12)*$B$13+($B$11/$B$12)*$B$14*(1-$B$15)` | Requires: `Inp_Equity`, `Inp_Debt`, `Inp_Total_Capital`, `Inp_Cost_of_Equity`, `Inp_Cost_of_Debt`, `Inp_Tax_Rate`, `WACC` Named Ranges |

**Proposed IDFA formula:**
`=Inp_Equity/Inp_Total_Capital*Inp_Cost_of_Equity+Inp_Debt/Inp_Total_Capital*Inp_Cost_of_Debt*(1-Inp_Tax_Rate)`

**LaTeX verification (required by Guardrail 2 before writing):**

$$WACC = \frac{E}{E+D} \times K_e + \frac{D}{E+D} \times K_d \times (1-T)$$

Three checks:
1. Equity weight + Debt weight = 5M/8M + 3M/8M = 1.0 -- PASS
2. Only the debt term is multiplied by (1 - Tax Rate) -- PASS
3. Cost of equity (12%) and cost of debt (6%) are in the same units -- PASS

---

## Summary of Named Ranges Still Needed

| Named Range             | Cell      | Type        |
|-------------------------|-----------|-------------|
| `Inp_COGS_Pct_Y1`      | Model!B4  | Input       |
| `Inp_COGS_Pct_Y2`      | (new cell)| Input       |
| `Inp_COGS_Pct_Y3`      | (new cell)| Input       |
| `COGS_Y1`              | Model!C7  | Calculation |
| `COGS_Y2`              | Model!D7  | Calculation |
| `COGS_Y3`              | Model!E7  | Calculation |
| `Gross_Profit_Y1`      | Model!C8  | Calculation |
| `Gross_Profit_Y2`      | Model!D8  | Calculation |
| `Gross_Profit_Y3`      | Model!E8  | Calculation |
| `Inp_Equity`           | Model!B10 | Input       |
| `Inp_Debt`             | Model!B11 | Input       |
| `Inp_Total_Capital`    | Model!B12 | Input       |
| `Inp_Cost_of_Equity`   | Model!B13 | Input       |
| `Inp_Cost_of_Debt`     | Model!B14 | Input       |
| `Inp_Tax_Rate`         | Model!B15 | Input       |
| `WACC`                 | Model!B16 | Calculation |

---

## Compliance Status

| Guardrail                       | Status                                                    |
|---------------------------------|-----------------------------------------------------------|
| G1: Named Range Priority        | Partial — 3 of 10 formulas converted (30%)                |
| G2: LaTeX Verification          | Not yet applicable (no complex formulas converted yet)    |
| G3: Audit-Ready Intent Notes    | Not yet added (add during or after full conversion)       |
| G4: Delegated Calculation       | Compliant — all validation via LibreOffice recalculation  |

**Overall:** 30% of calculation formulas are IDFA-compliant. The revenue chain
(Y1 -> Y2 -> Y3) is fully converted and validated. COGS, Gross Profit, and WACC
remain to be converted.
