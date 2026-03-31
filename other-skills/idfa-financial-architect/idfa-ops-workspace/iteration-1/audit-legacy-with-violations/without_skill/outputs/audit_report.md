# Formula Quality Audit Report

**File:** `legacy_model.xlsx`
**Sheet:** Model
**Date:** 2026-03-11

---

## Summary

The spreadsheet is a small financial model with revenue projections (3 years), a COGS/gross-profit build, and a WACC calculation. The audit found **5 distinct formula quality violations** across 4 cells, with material numerical impact on projected financials.

---

## Violation 1: Hardcoded Magic Numbers in COGS Formulas (D7, E7)

**Severity: HIGH**

| Cell | Formula | Issue |
|------|---------|-------|
| C7 | `=C6*B4` | Correctly references the COGS % assumption in B4 (0.60) |
| D7 | `=D6*0.59` | Hardcodes 0.59 instead of referencing B4 |
| E7 | `=E6*0.58` | Hardcodes 0.58 instead of referencing B4 |

**What's wrong:** Year 2 and Year 3 COGS formulas embed literal numeric constants (0.59 and 0.58) instead of referencing the COGS % assumption cell (B4 = 0.60). This means:

- The assumption cell B4 is effectively ignored for two out of three projection years.
- Changing the COGS % assumption in B4 will only update Year 1, creating a silent inconsistency.
- The hardcoded values differ from each other AND from the assumption (60% vs 59% vs 58%), introducing an undocumented declining-COGS assumption with no transparent driver.

**Numerical impact:**

| Year | COGS (as-is) | COGS (using B4) | Difference |
|------|-------------|-----------------|------------|
| Y2 | 6,490,000 | 6,600,000 | -110,000 |
| Y3 | 7,018,000 | 7,260,000 | -242,000 |

Gross Profit is overstated by $110,000 in Y2 and $242,000 in Y3 relative to what the model's own assumption cell implies.

**Fix:** Replace D7 with `=D6*$B$4` and E7 with `=E6*$B$4`. If declining COGS margins are intentional, they should be driven by explicit assumption cells (e.g., a COGS % row for each year).

---

## Violation 2: Inconsistent Row Pattern in COGS Row

**Severity: HIGH**

The COGS row (row 7) breaks its own formula pattern across columns:

| Cell | Formula Pattern |
|------|----------------|
| C7 | `=C6*B4` (cell reference to assumption) |
| D7 | `=D6*0.59` (hardcoded constant) |
| E7 | `=E6*0.58` (different hardcoded constant) |

In contrast, the Revenue row (row 6) and Gross Profit row (row 8) are internally consistent -- each column follows the same structural pattern as the others in its row. The COGS row is the only row where the formula structure changes from column to column.

This inconsistency is a classic spreadsheet error pattern: the first cell was built correctly referencing an assumption, then the subsequent cells were manually entered with different values instead of copying/extending the formula.

---

## Violation 3: Hardcoded Derived Value in Total Capital (B12)

**Severity: MEDIUM**

| Cell | Current Value | Should Be |
|------|--------------|-----------|
| B10 | 5,000,000 (Equity) | -- |
| B11 | 3,000,000 (Debt) | -- |
| B12 | 8,000,000 (hardcoded constant) | `=B10+B11` |

**What's wrong:** Total Capital (B12) is entered as a plain number (8,000,000) rather than a formula summing Equity (B10) and Debt (B11). While the value happens to be correct today, it will NOT update if either B10 or B11 changes. Since B12 is used in the WACC formula (B16), any future change to equity or debt would silently produce an incorrect WACC.

**Fix:** Replace the constant in B12 with `=B10+B11`.

---

## Violation 4: WACC Formula Depends on Hardcoded Total Capital

**Severity: MEDIUM (cascading from Violation 3)**

```
B16: =($B$10/$B$12)*$B$13+($B$11/$B$12)*$B$14*(1-$B$15)
```

The WACC formula is structurally correct and uses absolute references appropriately. However, because it references B12 (which is a hardcoded constant per Violation 3), the entire WACC calculation is fragile. This is a cascading dependency risk rather than a formula-level defect in B16 itself.

Current WACC result: **9.19%** -- numerically correct given today's inputs, but will break silently if capital structure inputs change.

---

## Violation 5: Column B Contains Misleading Repeated Labels

**Severity: LOW**

| Cell | Value |
|------|-------|
| B6 | "Y1" |
| B7 | "Y1" |
| B8 | "Y1" |

Column B contains the label "Y1" in every data row, while columns C, D, and E contain the actual Year 1, Year 2, and Year 3 values respectively. There are no "Y2" or "Y3" labels anywhere. This is structurally confusing -- it suggests all three rows are Year 1 data, when in fact the year dimension runs across columns C-E.

**Fix:** Either place year headers in a dedicated header row (e.g., C5="Y1", D5="Y2", E5="Y3") or remove the misleading B-column labels.

---

## Complete Formula Inventory

| Cell | Formula | Status |
|------|---------|--------|
| C6 | `=B2` | OK |
| D6 | `=C6*(1+B3)` | OK |
| E6 | `=D6*(1+B3)` | OK |
| C7 | `=C6*B4` | OK |
| D7 | `=D6*0.59` | VIOLATION -- hardcoded constant, inconsistent with C7 |
| E7 | `=E6*0.58` | VIOLATION -- hardcoded constant, inconsistent with C7 |
| C8 | `=C6-C7` | OK |
| D8 | `=D6-D7` | OK (but inherits D7's error) |
| E8 | `=E6-E7` | OK (but inherits E7's error) |
| B16 | `=($B$10/$B$12)*$B$13+($B$11/$B$12)*$B$14*(1-$B$15)` | OK structurally; fragile due to B12 |

---

## Cells That Should Be Formulas But Are Constants

| Cell | Label | Current Value | Recommended Formula |
|------|-------|--------------|-------------------|
| B12 | Total Capital | 8,000,000 | `=B10+B11` |

---

## Risk Assessment

| Risk | Likelihood | Impact |
|------|-----------|--------|
| Changing COGS % assumption (B4) produces inconsistent projections | High | High -- Y2/Y3 won't respond to assumption changes |
| Changing equity or debt breaks WACC | Medium | High -- WACC silently wrong |
| Auditor/reviewer misreads year labels | Low | Medium -- confusion during review |

---

## Recommendations (Priority Order)

1. **Fix D7 and E7** to reference `$B$4` instead of hardcoded constants. If declining COGS margins are intentional, create separate assumption cells for each year's COGS %.
2. **Replace B12** with the formula `=B10+B11` so Total Capital stays in sync with its components.
3. **Add proper column headers** for Y1/Y2/Y3 in a header row and remove the misleading B-column labels.
4. **General practice:** Audit all future formulas to ensure assumption cells are always referenced rather than embedding numeric literals.
