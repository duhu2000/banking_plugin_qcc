# Line Item Addition Results: Depreciation

**Task:** Add Depreciation as a new line item (10% of Revenue, straight-line as a percentage of revenue) and update EBITDA to EBIT (EBITDA after Depreciation).

**Model:** `idfa_compliant_model.xlsx`
**Date:** 2026-03-11
**Agent:** IDFA Financial Architect
**Methodology:** All values obtained via write-recalculate-read pattern (LibreOffice deterministic recalculation)

---

## LaTeX Verification (Guardrail 2)

Depreciation (simple -- no complex formula requiring full LaTeX verification):

$$Depr_n = R_n \times Depr\%$$

EBIT (simple subtraction):

$$EBIT_n = GP_n - OpEx_n - Depr_n$$

Both formulas are straightforward arithmetic -- no WACC/IRR/NPV/DCF complexity.

---

## Named Ranges Created

### Layer 1 -- Assumptions

| Named Range    | Sheet       | Cell | Value | Description                    |
| -------------- | ----------- | ---- | ----- | ------------------------------ |
| `Inp_Depr_Pct` | Assumptions | B8   | 0.10  | Depreciation as % of Revenue   |

### Layer 2 -- Calculations (New)

| Named Range        | Sheet        | Cell | Formula                    | Description                              |
| ------------------ | ------------ | ---- | -------------------------- | ---------------------------------------- |
| `Depreciation_Y1`  | Calculations | B8   | `=Revenue_Y1*Inp_Depr_Pct` | Year 1 Depreciation = Revenue * 10%      |
| `Depreciation_Y2`  | Calculations | C8   | `=Revenue_Y2*Inp_Depr_Pct` | Year 2 Depreciation = Revenue * 10%      |
| `Depreciation_Y3`  | Calculations | D8   | `=Revenue_Y3*Inp_Depr_Pct` | Year 3 Depreciation = Revenue * 10%      |

### Layer 2 -- Calculations (Modified)

| Named Range  | Sheet        | Cell | Old Formula                        | New Formula                                        |
| ------------ | ------------ | ---- | ---------------------------------- | -------------------------------------------------- |
| `EBITDA_Y1`  | Calculations | B7   | `=Gross_Profit_Y1-OpEx_Y1`         | `=Gross_Profit_Y1-OpEx_Y1-Depreciation_Y1`         |
| `EBITDA_Y2`  | Calculations | C7   | `=Gross_Profit_Y2-OpEx_Y2`         | `=Gross_Profit_Y2-OpEx_Y2-Depreciation_Y2`         |
| `EBITDA_Y3`  | Calculations | D7   | `=Gross_Profit_Y3-OpEx_Y3`         | `=Gross_Profit_Y3-OpEx_Y3-Depreciation_Y3`         |

**Note:** The Named Range names `EBITDA_Y1/Y2/Y3` were preserved (not renamed) to avoid breaking any downstream references. The cell labels and Intent Notes reflect the semantic change to EBIT. The formulas now compute Gross Profit - OpEx - Depreciation, which is EBIT.

### Layer 3 -- Output (Updated)

| Row | Label        | Year 1 Formula    | Year 2 Formula    | Year 3 Formula    |
| --- | ------------ | ----------------- | ----------------- | ----------------- |
| 6   | Depreciation | `=Depreciation_Y1`| `=Depreciation_Y2`| `=Depreciation_Y3`|
| 7   | EBIT         | `=EBITDA_Y1`      | `=EBITDA_Y2`      | `=EBITDA_Y3`      |

---

## Intent Notes (Guardrail 3)

All new and modified formulas have Intent Notes attached. Format:

**Depreciation cells (B8, C8, D8):**
```
INTENT:      Year N Depreciation = Revenue * Depreciation percentage (straight-line as % of revenue)
FORMULA:     Depr_n = R_n * Depr%
ASSUMPTIONS: Revenue_Yn, Inp_Depr_Pct
GENERATED:   2026-03-11 / IDFA Financial Architect
```

**EBIT cells (B7, C7, D7):**
```
INTENT:      Year N EBIT = Gross Profit minus OpEx minus Depreciation
FORMULA:     EBIT_n = GP_n - OpEx_n - Depr_n
ASSUMPTIONS: Gross_Profit_Yn, OpEx_Yn, Depreciation_Yn
GENERATED:   2026-03-11 / IDFA Financial Architect
MODIFIED:    2026-03-11 -- updated from EBITDA to EBIT by adding Depreciation
```

---

## Recalculated Model Values

All values below are the model's deterministic output (read via `idfa_ops.py read` after LibreOffice recalculation).

| Metric           | Year 1       | Year 2       | Year 3       |
| ---------------- | ------------ | ------------ | ------------ |
| Revenue          | $10,000,000  | $11,000,000  | $12,100,000  |
| COGS             | $6,000,000   | $6,490,000   | $7,018,000   |
| Gross Profit     | $4,000,000   | $4,510,000   | $5,082,000   |
| OpEx             | $2,000,000   | $2,100,000   | $2,205,000   |
| **Depreciation** | **$1,000,000** | **$1,100,000** | **$1,210,000** |
| **EBIT**         | **$1,000,000** | **$1,310,000** | **$1,667,000** |

### Before vs. After Comparison

| Metric             | Year 1       | Year 2       | Year 3       |
| ------------------ | ------------ | ------------ | ------------ |
| EBITDA (before)    | $2,000,000   | $2,410,000   | $2,877,000   |
| Depreciation (new) | ($1,000,000) | ($1,100,000) | ($1,210,000) |
| EBIT (after)       | $1,000,000   | $1,310,000   | $1,667,000   |

---

## IDFA Compliance Audit

| Guardrail                         | Status | Details                                             |
| --------------------------------- | ------ | --------------------------------------------------- |
| 1. Named Range Priority           | PASS   | 0 coordinate references in any formula              |
| 2. LaTeX Verification             | PASS   | No complex formulas requiring verification          |
| 3. Audit-Ready Intent Notes       | PASS   | 100% coverage -- all 21 formulas have Intent Notes  |
| 4. Delegated Calculation          | PASS   | All values read from model via spreadsheet engine    |

**Overall Compliance Score: 100%**

---

## Summary

1. Created 1 new input assumption (`Inp_Depr_Pct = 0.10`) in the Assumptions layer
2. Created 3 new Depreciation Named Ranges in the Calculations layer, each using only Named Range references
3. Updated 3 EBITDA formulas to subtract Depreciation, converting them to EBIT
4. Added Depreciation row to the Output layer
5. Updated Output layer label from EBITDA to EBIT
6. All formulas have IDFA-compliant Intent Notes
7. Model passes all 4 IDFA guardrails at 100% compliance
