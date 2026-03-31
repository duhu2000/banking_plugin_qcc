# Excel Model Audit Report

**File:** `ops_test_model.xlsx`
**Date:** 2026-03-11
**Method:** Automated inspection via openpyxl (formula-level, no skill files used)

---

## 1. Model Overview

The workbook contains a 2-year P&L projection with three sheets following a clean Inputs / Calculations / Outputs separation pattern:

| Sheet | Dimensions | Role |
|-------|-----------|------|
| Assumptions | A1:B7 | 6 input parameters (hardcoded values) |
| Calculations | A1:C8 | 14 formula cells deriving Year 1 and Year 2 metrics |
| Output | A1:C8 | 14 formula cells referencing Calculations (presentation layer) |

**Defined Names:** 20 total (6 inputs with `Inp_` prefix, 14 calculation outputs).

---

## 2. Structural Quality Assessment

### What the model does well

| Area | Assessment |
|------|-----------|
| **Sheet separation** | PASS. Clean 3-layer architecture: Assumptions -> Calculations -> Output. This is best-practice for auditability. |
| **Named ranges** | PASS. Every input and every calculated cell has a named range. Formulas use names exclusively -- no raw cell references like `B2` anywhere in Calculations or Output. |
| **Naming convention** | PASS. Inputs consistently prefixed with `Inp_`. Calculation names follow a `Metric_Year` pattern (e.g., `Revenue_Y1`). |
| **No hardcoded values in formulas** | PASS. All numeric inputs live on the Assumptions sheet. Calculations and Output sheets contain only formulas. |
| **No circular references** | PASS. Dependency graph is acyclic. |
| **No unresolved references** | PASS. Every name referenced in a formula resolves to a defined name. |
| **Number formatting** | PASS. Assumptions sheet uses `#,##0` for currency/units and `0.00%` for rates. Calculations and Output use `#,##0` throughout. |
| **Header formatting** | PASS. Headers are bold with blue background and white text, providing clear visual separation. |

### Summary: The formula architecture is clean and well-structured.

---

## 3. Formula Logic Verification

All formulas were traced and verified against manual computation:

| Metric | Formula (Year 1) | Formula (Year 2) | Logic Correct? |
|--------|-------------------|-------------------|----------------|
| Units Sold | `=Inp_Units_Y1` | `=Units_Y1*(1+Inp_Units_Growth)` | Yes |
| Revenue | `=Units_Y1*Inp_Price` | `=Units_Y2*Inp_Price` | Yes |
| Variable Costs | `=Units_Y1*Inp_Variable_Cost_Per_Unit` | `=Units_Y2*Inp_Variable_Cost_Per_Unit` | Yes |
| Contribution Margin | `=Revenue_Y1-Variable_Costs_Y1` | `=Revenue_Y2-Variable_Costs_Y2` | Yes |
| EBIT | `=Contribution_Y1-Inp_Fixed_Costs` | `=Contribution_Y2-Inp_Fixed_Costs` | Yes |
| Tax | `=EBIT_Y1*Inp_Tax_Rate` | `=EBIT_Y2*Inp_Tax_Rate` | See Issue #1 |
| Net Income | `=EBIT_Y1-Tax_Y1` | `=EBIT_Y2-Tax_Y2` | Yes |

**Expected values with current assumptions:**

| Metric | Year 1 | Year 2 |
|--------|--------|--------|
| Units Sold | 50,000 | 57,500 |
| Revenue | 5,000,000 | 5,750,000 |
| Variable Costs | 2,000,000 | 2,300,000 |
| Contribution Margin | 3,000,000 | 3,450,000 |
| EBIT | 2,000,000 | 2,450,000 |
| Tax | 600,000 | 735,000 |
| Net Income | 1,400,000 | 1,715,000 |

---

## 4. Issues Found

### Issue #1 (Medium) -- Tax formula does not guard against negative EBIT

**Cells:** `Calculations!B7`, `Calculations!C7`
**Current formula:** `=EBIT_Y1*Inp_Tax_Rate`
**Problem:** If assumptions change such that EBIT becomes negative (e.g., high fixed costs, low units), the model computes a negative tax amount. This implicitly assumes a full tax refund/credit on losses, which is not standard in most jurisdictions.
**Recommended fix:** `=MAX(EBIT_Y1, 0) * Inp_Tax_Rate` -- or use an `IF` to handle the loss carry-forward scenario explicitly.

### Issue #2 (Medium) -- No input data validation

**Cells:** `Assumptions!B2:B7`
**Problem:** No Excel data validation rules exist on any input cell. A user could enter negative prices, text strings, or tax rates above 100%, and the model would silently produce incorrect results.
**Recommended fix:** Add data validation rules:
- Unit Price >= 0
- Units Sold >= 0
- Growth Rate between -100% and a reasonable upper bound
- Variable Cost Per Unit >= 0
- Fixed Costs >= 0
- Tax Rate between 0% and 100%

### Issue #3 (Medium) -- No sheet protection

**Affected sheets:** Calculations, Output
**Problem:** All three sheets are unprotected. A user could accidentally overwrite formulas in the Calculations or Output sheets, breaking the model silently.
**Recommended fix:** Protect the Calculations and Output sheets (allow only input cells on Assumptions to be editable).

### Issue #4 (Low) -- No error handling in formulas

**Affected cells:** All 28 formula cells
**Problem:** No `IFERROR` or `IFNA` wrappers are used. If an input cell is cleared or contains text, `#VALUE!` errors will cascade through the entire model.
**Recommended fix:** Wrap key formulas in `IFERROR(formula, 0)` or display a descriptive error message.

### Issue #5 (Low) -- Fixed costs are static across years

**Cells:** `Calculations!B6`, `Calculations!C6`
**Problem:** Both years reference `Inp_Fixed_Costs` with no growth or inflation applied. This is a modeling simplification that may understate Year 2 costs in real-world scenarios.
**Note:** This is a modeling assumption, not strictly a formula error. Flag for the model owner to confirm intent.

### Issue #6 (Low) -- Limited scalability beyond 2 years

**Pattern:** Each year uses separate named ranges (`Units_Y1`, `Units_Y2`, `Revenue_Y1`, `Revenue_Y2`, etc.)
**Problem:** Extending this model to 5 or 10 years requires adding columns AND creating new named ranges for every metric-year combination. This grows as O(metrics x years), which becomes unwieldy.
**Recommended fix:** For models expected to expand, consider a row-based time axis or a table-driven approach where formulas reference relative positions rather than named year-specific ranges.

---

## 5. Scoring Summary

| Category | Score | Notes |
|----------|-------|-------|
| Sheet architecture | 5/5 | Clean 3-layer separation |
| Named ranges | 5/5 | Complete coverage, consistent naming |
| Formula correctness | 4/5 | All formulas logically correct; tax edge case unhandled |
| Hardcoded values | 5/5 | None in Calculations or Output |
| Circular references | 5/5 | None detected |
| Data validation | 1/5 | No validation rules present |
| Error handling | 1/5 | No IFERROR wrappers |
| Sheet protection | 1/5 | All sheets unprotected |
| Formatting | 4/5 | Good number formats and headers; no conditional formatting for negative values |
| Scalability | 2/5 | Year-specific named ranges limit extensibility |

**Overall: 33/50** -- The formula architecture and naming are strong. The main gaps are in defensive modeling (validation, protection, error handling) and the tax edge case.

---

## 6. Recommendations Priority

1. **Fix tax formula** to handle negative EBIT (medium effort, high impact on correctness)
2. **Add data validation** on all 6 input cells (low effort, high impact on robustness)
3. **Protect** Calculations and Output sheets (low effort, medium impact)
4. **Add IFERROR wrappers** to key formulas (low effort, medium impact)
5. **Confirm fixed cost assumption** with model owner (no effort, clarifies intent)
6. **Consider scalable architecture** if more years will be added (high effort, long-term benefit)
