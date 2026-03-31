# IDFA Retrofit Report -- Legacy Model (First 3 Formulas)

**Date:** 2026-03-11
**Source:** `skills/financial-architect/evals/files/legacy_model.xlsx`
**Output:** `legacy_model_retrofit.xlsx` (partially retrofitted)
**Method:** Formula-by-formula in dependency order, validated at each step

---

## Legacy Model Baseline

Single sheet ("Model"), zero Named Ranges, 10 formula cells.
All formulas use coordinate references (A1-style). Two COGS formulas contain
hardcoded percentages (0.59, 0.58) instead of referencing assumptions.

### Cell Map (Pre-Retrofit)

| Cell | Label          | Formula / Value         | Expected Output |
|------|----------------|-------------------------|-----------------|
| B2   | Revenue        | 10,000,000 (input)      | --              |
| B3   | Revenue Growth | 0.10 (input)            | --              |
| B4   | COGS %         | 0.60 (input)            | --              |
| C6   | Revenue Y1     | `=B2`                   | 10,000,000      |
| D6   | Revenue Y2     | `=C6*(1+B3)`            | 11,000,000      |
| E6   | Revenue Y3     | `=D6*(1+B3)`            | 12,100,000      |
| C7   | COGS Y1        | `=C6*B4`                | 6,000,000       |
| D7   | COGS Y2        | `=D6*0.59` (hardcoded!) | 6,490,000       |
| E7   | COGS Y3        | `=E6*0.58` (hardcoded!) | 7,018,000       |
| C8   | Gross Profit Y1| `=C6-C7`                | 4,000,000       |
| D8   | Gross Profit Y2| `=D6-D7`                | 4,510,000       |
| E8   | Gross Profit Y3| `=E6-E7`                | 5,082,000       |
| B10  | Equity         | 5,000,000 (input)       | --              |
| B11  | Debt           | 3,000,000 (input)       | --              |
| B12  | Total Capital  | 8,000,000 (input)       | --              |
| B13  | Cost of Equity | 0.12 (input)            | --              |
| B14  | Cost of Debt   | 0.06 (input)            | --              |
| B15  | Tax Rate       | 0.25 (input)            | --              |
| B16  | WACC           | `=($B$10/$B$12)*$B$13+($B$11/$B$12)*$B$14*(1-$B$15)` | 0.09175 |

---

## Dependency Order Analysis

Retrofit must proceed inputs-first, then leaf formulas, then dependent formulas.

```
Tier 0 (Inputs):  B2, B3, B4, B10-B15  -- create Named Ranges only
Tier 1 (Leaves):  C6 (=B2)             -- depends only on inputs
Tier 2:           C7 (=C6*B4)          -- depends on C6 + input
                  D6 (=C6*(1+B3))      -- depends on C6 + input
Tier 3:           D7, E6, C8           -- depends on Tier 1-2 results
Tier 4:           D8, E7, E8           -- depends on Tier 3 results
Tier 5:           B16 (WACC)           -- depends on inputs only (separate block)
```

---

## Named Ranges Created

### Layer 1 -- Inputs (Tier 0)

| Named Range       | Cell | Value      |
|--------------------|------|------------|
| `Inp_Rev_Y1`       | B2   | 10,000,000 |
| `Inp_Rev_Growth`   | B3   | 0.10       |
| `Inp_COGS_Pct_Y1`  | B4   | 0.60       |

### Layer 2 -- Calculations (Tiers 1-2)

| Named Range  | Cell | Purpose             |
|--------------|------|---------------------|
| `Revenue_Y1` | C6   | Revenue Year 1      |
| `COGS_Y1`    | C7   | Cost of Goods Sold Y1 |
| `Revenue_Y2` | D6   | Revenue Year 2      |

---

## Formulas Retrofitted (3 of 10)

### Formula 1: Revenue_Y1 (C6) -- Tier 1

| Property    | Before       | After            |
|-------------|--------------|------------------|
| Formula     | `=B2`        | `=Inp_Rev_Y1`   |
| Readable as | "equals B2"  | "equals the Year 1 Revenue assumption" |
| Coord refs  | 1 (B2)       | 0                |

**LaTeX:** $R_1 = \text{Inp\_Rev\_Y1}$

**Validation:**
- `Inp_Rev_Y1` resolves to cell B2 = 10,000,000
- Legacy formula `=B2` = 10,000,000
- **Result: MATCH** -- 10,000,000 = 10,000,000

**Intent Note added:**
```
INTENT:      Revenue Year 1 -- direct pass-through from assumption
FORMULA:     R_1 = Inp_Rev_Y1
ASSUMPTIONS: Inp_Rev_Y1
GENERATED:   2026-03-11 / IDFA retrofit session
MODIFIED:    2026-03-11 / initial retrofit
```

---

### Formula 2: COGS_Y1 (C7) -- Tier 2

| Property    | Before        | After                             |
|-------------|---------------|-----------------------------------|
| Formula     | `=C6*B4`      | `=Revenue_Y1*Inp_COGS_Pct_Y1`    |
| Readable as | "C6 times B4" | "Revenue Year 1 times COGS percentage" |
| Coord refs  | 2 (C6, B4)    | 0                                 |

**LaTeX:** $COGS_1 = R_1 \times COGS\%_1$

**Validation:**
- `Revenue_Y1` = 10,000,000 (verified in Formula 1)
- `Inp_COGS_Pct_Y1` = 0.60
- IDFA result: 10,000,000 * 0.60 = 6,000,000
- Legacy formula `=C6*B4` = 10,000,000 * 0.60 = 6,000,000
- **Result: MATCH** -- 6,000,000 = 6,000,000

**Intent Note added:**
```
INTENT:      COGS Year 1 = Revenue * COGS percentage
FORMULA:     COGS_1 = R_1 * COGS%_1
ASSUMPTIONS: Revenue_Y1, Inp_COGS_Pct_Y1
GENERATED:   2026-03-11 / IDFA retrofit session
MODIFIED:    2026-03-11 / initial retrofit
```

---

### Formula 3: Revenue_Y2 (D6) -- Tier 2

| Property    | Before           | After                                 |
|-------------|------------------|---------------------------------------|
| Formula     | `=C6*(1+B3)`     | `=Revenue_Y1*(1+Inp_Rev_Growth)`      |
| Readable as | "C6 times 1+B3"  | "Revenue Y1 times 1 plus growth rate" |
| Coord refs  | 2 (C6, B3)       | 0                                     |

**LaTeX:** $R_2 = R_1 \times (1 + g)$

**Validation:**
- `Revenue_Y1` = 10,000,000
- `Inp_Rev_Growth` = 0.10
- IDFA result: 10,000,000 * (1 + 0.10) = 11,000,000
- Legacy formula `=C6*(1+B3)` = 10,000,000 * (1 + 0.10) = 11,000,000
- **Result: MATCH** -- 11,000,000 = 11,000,000

**Intent Note added:**
```
INTENT:      Revenue Year 2 = prior year revenue * (1 + growth rate)
FORMULA:     R_2 = R_1 x (1 + g)
ASSUMPTIONS: Revenue_Y1, Inp_Rev_Growth
GENERATED:   2026-03-11 / IDFA retrofit session
MODIFIED:    2026-03-11 / initial retrofit
```

---

## Validation Summary

| # | Named Range  | Legacy Value | IDFA Value  | Status |
|---|--------------|-------------|-------------|--------|
| 1 | Revenue_Y1   | 10,000,000  | 10,000,000  | MATCH  |
| 2 | COGS_Y1      | 6,000,000   | 6,000,000   | MATCH  |
| 3 | Revenue_Y2   | 11,000,000  | 11,000,000  | MATCH  |

All 3 retrofitted formulas produce identical results to their legacy equivalents.

---

## Current Model State

```
Retrofitted (3):  C6, C7, D6     -- zero coordinate references
Legacy (7):       E6, D7, E7, C8, D8, E8, B16  -- still coordinate-based
Named Ranges:     6 (3 inputs + 3 calculations)
```

### Remaining Retrofit Queue (in dependency order)

| Priority | Cell | Legacy Formula                                           | IDFA Target                                           | Notes |
|----------|------|----------------------------------------------------------|-------------------------------------------------------|-------|
| Next     | E6   | `=D6*(1+B3)`                                            | `=Revenue_Y2*(1+Inp_Rev_Growth)`                      | Needs Revenue_Y3 range |
| Next     | C8   | `=C6-C7`                                                | `=Revenue_Y1-COGS_Y1`                                 | Needs Gross_Profit_Y1 range |
| Next     | D7   | `=D6*0.59`                                              | `=Revenue_Y2*Inp_COGS_Pct_Y2`                         | Needs Inp_COGS_Pct_Y2 input + COGS_Y2 range; hardcoded 0.59 must become assumption |
| Then     | E7   | `=E6*0.58`                                              | `=Revenue_Y3*Inp_COGS_Pct_Y3`                         | Needs Inp_COGS_Pct_Y3 input + COGS_Y3 range; hardcoded 0.58 must become assumption |
| Then     | D8   | `=D6-D7`                                                | `=Revenue_Y2-COGS_Y2`                                 | Needs Gross_Profit_Y2 range |
| Then     | E8   | `=E6-E7`                                                | `=Revenue_Y3-COGS_Y3`                                 | Needs Gross_Profit_Y3 range |
| Then     | B16  | `=($B$10/$B$12)*$B$13+($B$11/$B$12)*$B$14*(1-$B$15)`   | `=(Inp_Equity/Inp_Total_Capital)*Inp_Cost_Equity+...`  | Needs 6 input ranges; requires LaTeX verification (Guardrail 2) |

### Issues Flagged for Future Steps

1. **D7 and E7 contain hardcoded COGS percentages** (0.59, 0.58). These must be extracted to new assumptions `Inp_COGS_Pct_Y2` and `Inp_COGS_Pct_Y3`. Alternatively, the IDFA-compliant model from `evals/files/idfa_compliant_model.xlsx` uses an `Inp_COGS_Efficiency` assumption (0.01) with calculated `COGS_Pct_Y2 = COGS_Pct_Y1 - Inp_COGS_Efficiency`. The latter is the cleaner IDFA pattern.

2. **WACC formula (B16)** requires LaTeX verification per Guardrail 2 before retrofitting.

3. **No recalculation engine available** -- LibreOffice is not installed. Validation was performed by tracing formulas manually. For production use, install LibreOffice (`brew install --cask libreoffice`) to enable the full Write-Recalculate-Read pattern via `recalc_bridge.py`.

---

## Tools Used

- `idfa_ops.py create-range` -- created 6 Named Ranges (3 inputs, 3 calculations)
- `idfa_ops.py formula` -- verified formula text before and after each retrofit
- `idfa_ops.py inspect` -- confirmed full Named Range inventory
- `idfa_audit.py` -- attempted baseline audit (requires "Calculations" sheet; legacy model has single sheet)
- `recalc_bridge.py` -- attempted recalculation (no engine available)
- Direct openpyxl -- wrote retrofitted formulas and Intent Notes (Guardrail 3)
