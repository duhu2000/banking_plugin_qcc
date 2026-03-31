# IDFA Compliance Audit Report

**File:** `ops_test_model.xlsx`
**Date:** 2026-03-11
**Tool:** `idfa_audit.py` (IDFA Operations Skill v2.0)

---

## Overall Result

| Metric           | Value  |
| ---------------- | ------ |
| **Overall**      | PASS   |
| **Score**        | 100%   |
| **Total formulas audited** | 14 |

---

## Per-Guardrail Results

### Guardrail 1: Named Range Priority — PASS

All 14 formulas in the Calculations sheet reference Named Ranges exclusively. Zero coordinate references (e.g., `A1`, `$B$2`) detected.

| Check                      | Result |
| -------------------------- | ------ |
| Coordinate references found | 0      |
| Status                     | PASS   |

**Explanation:** Every formula uses Named Ranges instead of cell coordinates. This ensures formulas are self-documenting and resilient to structural changes in the workbook.

---

### Guardrail 2: LaTeX Verification — PASS

No complex financial formulas (WACC, NPV, DCF, IRR, XNPV, XIRR, MIRR) were detected in the model. LaTeX verification is therefore not applicable.

| Check                                    | Result |
| ---------------------------------------- | ------ |
| Complex formulas without LaTeX comment   | 0      |
| Status                                   | PASS   |

**Explanation:** This model uses straightforward arithmetic (multiplication, addition, subtraction). No complex multi-step financial formulas requiring independent mathematical verification were found.

---

### Guardrail 3: Intent Notes — PASS

All 14 formula cells have intent-note comments attached. Coverage is 100%.

| Check                    | Result |
| ------------------------ | ------ |
| Formulas with comments   | 14     |
| Formulas missing comments | 0     |
| Coverage                 | 100%   |
| Status                   | PASS   |

**Explanation:** Every formula cell in the Calculations layer carries a cell comment explaining the business intent of the calculation (e.g., "Year 1 revenue = units * price per unit"). This satisfies the requirement that every formula be accompanied by a human-readable intent note.

---

### Guardrail 4: Layer Isolation — PASS

No hardcoded numeric constants were found embedded in formulas. All numeric inputs flow through the Assumptions layer via Named Ranges.

| Check                       | Result |
| --------------------------- | ------ |
| Hardcoded values in formulas | 0     |
| Status                      | PASS   |

**Explanation:** Formulas like `=Units_Y1*Inp_Price` reference Named Ranges for every numeric value. No magic numbers (e.g., `*0.30`, `+1000000`) appear inside formula text. The only structural constant used is `1` in the growth formula `=Units_Y1*(1+Inp_Units_Growth)`, which is correctly excluded as a structural identity element.

---

## Model Structure Summary

The model follows the IDFA Three-Layer Architecture:

| Layer        | Sheet        | Named Ranges | Purpose                              |
| ------------ | ------------ | ------------ | ------------------------------------ |
| Assumptions  | Assumptions  | 6            | Input parameters (price, units, growth, costs, tax rate) |
| Calculations | Calculations | 14           | All formulas — units, revenue, costs, contribution, EBIT, tax, net income |
| Outputs      | (downstream) | —            | Consumers read from Calculations Named Ranges |

**Named Ranges (Assumptions layer):**
- `Inp_Price` = 100
- `Inp_Units_Y1` = 50,000
- `Inp_Units_Growth` = 15%
- `Inp_Variable_Cost_Per_Unit` = 40
- `Inp_Fixed_Costs` = 1,000,000
- `Inp_Tax_Rate` = 30%

**Calculation chain:** Units → Revenue → Variable Costs → Contribution → EBIT → Tax → Net Income, projected across Y1 and Y2.

---

## Methodology

All values obtained via the `idfa_audit.py` script, which programmatically inspects the workbook using openpyxl. The audit checks every formula cell in the Calculations sheet against the four IDFA guardrails. No manual inspection or agent reasoning was used to determine compliance — the script's JSON output is the source of truth.

---

## Conclusion

This model is **fully IDFA-compliant**. It passes all four guardrails with zero violations and a 100% compliance score. The model is structurally sound for use with the write-recalculate-read pattern.
