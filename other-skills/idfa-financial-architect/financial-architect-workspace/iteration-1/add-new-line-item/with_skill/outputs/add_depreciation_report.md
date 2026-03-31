# Add Depreciation Line Item -- IDFA Modification Report

**Date:** 2026-03-11
**Input file:** `skills/financial-architect/evals/files/idfa_compliant_model.xlsx`
**Output file:** `idfa_compliant_model.xlsx` (this directory)
**Tool:** `idfa-ops` scripts (create-range, write, formula, inspect)

---

## Intent Statement

> Add a Depreciation line item calculated as 10% of Revenue each year
> (straight-line as a percentage of revenue). Add an EBIT line item equal
> to EBITDA minus Depreciation.

---

## LaTeX Verification (Guardrail 2)

Depreciation (straight-line % of revenue):

$$Depreciation_n = Revenue_n \times Inp\_Depr\_Pct$$

EBIT:

$$EBIT_n = EBITDA_n - Depreciation_n$$

Both expressions are simple products/differences -- verified correct.

---

## Changes Made

### Layer 1 -- Assumptions

| Cell | Label                    | Named Range    | Value |
|------|--------------------------|----------------|-------|
| B8   | Depreciation % of Revenue | `Inp_Depr_Pct` | 0.10  |

### Layer 2 -- Calculations

| Row | Label        | Named Range        | Formula (Y1)                    | Formula (Y2)                    | Formula (Y3)                    |
|-----|--------------|--------------------|---------------------------------|---------------------------------|---------------------------------|
| 8   | Depreciation | `Depreciation_Yn`  | `=Revenue_Y1*Inp_Depr_Pct`     | `=Revenue_Y2*Inp_Depr_Pct`     | `=Revenue_Y3*Inp_Depr_Pct`     |
| 9   | EBIT         | `EBIT_Yn`          | `=EBITDA_Y1-Depreciation_Y1`   | `=EBITDA_Y2-Depreciation_Y2`   | `=EBITDA_Y3-Depreciation_Y3`   |

**Existing EBITDA row (row 7) preserved unchanged.** EBIT sits below it in the waterfall.

### Layer 3 -- Output

| Row | Label        | Formula (Y1)        | Formula (Y2)        | Formula (Y3)        |
|-----|--------------|---------------------|---------------------|---------------------|
| 7   | Depreciation | `=Depreciation_Y1`  | `=Depreciation_Y2`  | `=Depreciation_Y3`  |
| 8   | EBIT         | `=EBIT_Y1`          | `=EBIT_Y2`          | `=EBIT_Y3`          |

### Intent Notes (Guardrail 3)

All six new Calculation-layer cells have Excel comments documenting their intent:

- `Depreciation_Yn`: "Year N Depreciation = Revenue * depreciation rate (straight-line % of revenue)"
- `EBIT_Yn`: "Year N EBIT = EBITDA minus Depreciation"

---

## Named Range Summary (31 total)

| Category      | Count | Names                                                                                        |
|---------------|-------|----------------------------------------------------------------------------------------------|
| Inputs (Inp_) | 7     | Inp_Rev_Y1, Inp_Rev_Growth, Inp_COGS_Pct_Y1, Inp_COGS_Efficiency, Inp_OpEx_Y1, Inp_OpEx_Growth, **Inp_Depr_Pct** |
| Calculations  | 24    | Revenue_Y1-Y3, COGS_Pct_Y1-Y3, COGS_Y1-Y3, Gross_Profit_Y1-Y3, OpEx_Y1-Y3, EBITDA_Y1-Y3, **Depreciation_Y1-Y3**, **EBIT_Y1-Y3** |

---

## IDFA Compliance Check

| Guardrail                      | Status |
|--------------------------------|--------|
| 1. Named Range Priority        | PASS -- all new formulas use only Named Ranges, zero coordinate references |
| 2. LaTeX Verification           | PASS -- verified above                                                     |
| 3. Audit-Ready Intent Notes     | PASS -- all six new cells have Intent Notes                                |
| 4. Delegated Calculation        | NOTE -- no recalc engine available (LibreOffice not installed); formulas are structurally correct but cached values are not populated. Open the file in Excel to trigger recalculation. |

---

## Expected Values (for verification when opened in Excel)

Based on the model assumptions (Rev Y1 = $10M, growth 10%, Depr = 10% of Rev):

| Metric       | Year 1       | Year 2       | Year 3       |
|--------------|-------------|-------------|-------------|
| Revenue      | $10,000,000 | $11,000,000 | $12,100,000 |
| EBITDA       | $2,000,000  | $2,410,000  | $2,896,050  |
| Depreciation | $1,000,000  | $1,100,000  | $1,210,000  |
| EBIT         | $1,000,000  | $1,310,000  | $1,686,050  |

*These are reference values for verification. The authoritative values are those computed by the spreadsheet engine (Guardrail 4).*

---

## Waterfall (Calculations Sheet, Final Layout)

```
Row 2:  Revenue            = Inp_Rev_Y1 / Revenue_Yn-1 * (1 + Inp_Rev_Growth)
Row 3:  COGS %             = Inp_COGS_Pct_Y1 / COGS_Pct_Yn-1 - Inp_COGS_Efficiency
Row 4:  COGS               = Revenue_Yn * COGS_Pct_Yn
Row 5:  Gross Profit       = Revenue_Yn - COGS_Yn
Row 6:  Operating Expenses = Inp_OpEx_Y1 / OpEx_Yn-1 * (1 + Inp_OpEx_Growth)
Row 7:  EBITDA             = Gross_Profit_Yn - OpEx_Yn
Row 8:  Depreciation       = Revenue_Yn * Inp_Depr_Pct          <-- NEW
Row 9:  EBIT               = EBITDA_Yn - Depreciation_Yn        <-- NEW
```
