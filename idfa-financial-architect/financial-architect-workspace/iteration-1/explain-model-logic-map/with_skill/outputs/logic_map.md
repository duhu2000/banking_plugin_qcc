# Logic Map -- IDFA-Compliant 3-Year P&L Model

**Source file:** `idfa_compliant_model.xlsx`
**IDFA Compliance:** 100% (all four guardrails pass)
**Total Named Ranges:** 24 (6 inputs, 18 calculations)
**Sheets:** Assumptions | Calculations | (Output layer reads from Calculations)

---

## How to Read This Document

This model follows the Intent-Driven Financial Architecture (IDFA). Every
business variable has a **Named Range** -- a human-readable label that replaces
cell addresses. Every formula references only Named Ranges, never cell
coordinates. This means you can understand every formula without opening the
spreadsheet.

The model has three layers:

- **Layer 1 -- Assumptions:** User-editable inputs. Change these to run scenarios.
- **Layer 2 -- Calculations:** Formulas that encode business rules. They reference
  only Named Ranges from Layer 1 or other Layer 2 ranges.
- **Layer 3 -- Output:** Presentation and formatting. Reads from Layer 2 only.

---

## Layer 1 -- Assumptions (Inputs)

These are the six user-modifiable inputs. Every value that drives the model
originates here and nowhere else. All are prefixed `Inp_` to distinguish them
from calculated values.

| Named Range          | Location         | Value       | Plain-English Meaning                                |
| -------------------- | ---------------- | ----------- | ---------------------------------------------------- |
| `Inp_Rev_Y1`         | Assumptions!B2   | 10,000,000  | Year 1 starting revenue in dollars                   |
| `Inp_Rev_Growth`     | Assumptions!B3   | 0.10 (10%)  | Annual revenue growth rate, applied year-over-year    |
| `Inp_COGS_Pct_Y1`   | Assumptions!B4   | 0.60 (60%)  | Year 1 cost of goods sold as a percentage of revenue |
| `Inp_COGS_Efficiency`| Assumptions!B5   | 0.01 (1pp)  | Annual improvement in COGS %, subtracted each year   |
| `Inp_OpEx_Y1`        | Assumptions!B6   | 2,000,000   | Year 1 operating expenses in dollars                 |
| `Inp_OpEx_Growth`    | Assumptions!B7   | 0.05 (5%)   | Annual operating expense growth rate                 |

**Key insight for scenario analysis:** Changing any `Inp_` value cascades
through every dependent calculation automatically. There are no hardcoded
numbers anywhere in the Calculations layer.

---

## Layer 2 -- Calculations (Business Rules)

All 18 formulas below use Named Ranges exclusively. Each is shown with:

1. The Excel formula (exactly as written in the model)
2. A plain-English translation of the business rule
3. The full dependency chain back to Layer 1 inputs

### Revenue Block

Computes top-line revenue for Years 1-3 using compound growth.

| Named Range    | Formula                              | Business Rule in Plain English                                                       |
| -------------- | ------------------------------------ | ------------------------------------------------------------------------------------ |
| `Revenue_Y1`   | `=Inp_Rev_Y1`                        | Year 1 Revenue equals the starting revenue assumption -- no calculation, just a pass-through from Layer 1. |
| `Revenue_Y2`   | `=Revenue_Y1*(1+Inp_Rev_Growth)`     | Year 2 Revenue equals Year 1 Revenue grown by the annual growth rate.                |
| `Revenue_Y3`   | `=Revenue_Y2*(1+Inp_Rev_Growth)`     | Year 3 Revenue equals Year 2 Revenue grown by the same annual growth rate.           |

**Dependency chain:**
```
Revenue_Y1  <--  Inp_Rev_Y1
Revenue_Y2  <--  Revenue_Y1  <--  Inp_Rev_Y1
                  Inp_Rev_Growth
Revenue_Y3  <--  Revenue_Y2  <--  Revenue_Y1  <--  Inp_Rev_Y1
                  Inp_Rev_Growth
```

**Mathematical pattern:** $R_n = R_{n-1} \times (1 + g)$, where $g$ = `Inp_Rev_Growth`.
This is standard compound growth. Year 3 Revenue is effectively
$\text{Inp\_Rev\_Y1} \times (1 + \text{Inp\_Rev\_Growth})^2$.

---

### COGS Percentage Block

Tracks how cost efficiency improves each year.

| Named Range    | Formula                                | Business Rule in Plain English                                                    |
| -------------- | -------------------------------------- | --------------------------------------------------------------------------------- |
| `COGS_Pct_Y1`  | `=Inp_COGS_Pct_Y1`                     | Year 1 COGS % equals the starting COGS percentage assumption -- pass-through.    |
| `COGS_Pct_Y2`  | `=COGS_Pct_Y1-Inp_COGS_Efficiency`     | Year 2 COGS % equals Year 1 COGS % minus the annual efficiency improvement.      |
| `COGS_Pct_Y3`  | `=COGS_Pct_Y2-Inp_COGS_Efficiency`     | Year 3 COGS % equals Year 2 COGS % minus the annual efficiency improvement.      |

**Dependency chain:**
```
COGS_Pct_Y1  <--  Inp_COGS_Pct_Y1
COGS_Pct_Y2  <--  COGS_Pct_Y1  <--  Inp_COGS_Pct_Y1
                   Inp_COGS_Efficiency
COGS_Pct_Y3  <--  COGS_Pct_Y2  <--  COGS_Pct_Y1  <--  Inp_COGS_Pct_Y1
                   Inp_COGS_Efficiency
```

**Mathematical pattern:** $COGS\%_n = COGS\%_{n-1} - \varepsilon$, where
$\varepsilon$ = `Inp_COGS_Efficiency`. This is linear improvement (not
compounding). With the base case values: Y1 = 60%, Y2 = 59%, Y3 = 58%.

---

### COGS Dollar Block

Converts COGS percentages into dollar amounts by multiplying against revenue.

| Named Range | Formula                     | Business Rule in Plain English                                   |
| ----------- | --------------------------- | ---------------------------------------------------------------- |
| `COGS_Y1`   | `=Revenue_Y1*COGS_Pct_Y1`   | Year 1 COGS in dollars = Year 1 Revenue times Year 1 COGS %.    |
| `COGS_Y2`   | `=Revenue_Y2*COGS_Pct_Y2`   | Year 2 COGS in dollars = Year 2 Revenue times Year 2 COGS %.    |
| `COGS_Y3`   | `=Revenue_Y3*COGS_Pct_Y3`   | Year 3 COGS in dollars = Year 3 Revenue times Year 3 COGS %.    |

**Dependency chain:**
```
COGS_Y1  <--  Revenue_Y1   <--  Inp_Rev_Y1
               COGS_Pct_Y1  <--  Inp_COGS_Pct_Y1

COGS_Y2  <--  Revenue_Y2   <--  Revenue_Y1     <--  Inp_Rev_Y1
                                  Inp_Rev_Growth
               COGS_Pct_Y2  <--  COGS_Pct_Y1   <--  Inp_COGS_Pct_Y1
                                  Inp_COGS_Efficiency

COGS_Y3  <--  Revenue_Y3   <--  Revenue_Y2     <--  (chain above)
               COGS_Pct_Y3  <--  COGS_Pct_Y2   <--  (chain above)
```

**Mathematical pattern:** $COGS_n = R_n \times COGS\%_n$. This is where the
revenue growth and cost efficiency assumptions interact -- COGS dollars grow
with revenue but are partially offset by the improving COGS percentage.

---

### Gross Profit Block

The first profitability metric: Revenue minus Cost of Goods Sold.

| Named Range       | Formula                   | Business Rule in Plain English                                      |
| ----------------- | ------------------------- | ------------------------------------------------------------------- |
| `Gross_Profit_Y1` | `=Revenue_Y1-COGS_Y1`     | Year 1 Gross Profit = Year 1 Revenue minus Year 1 COGS in dollars. |
| `Gross_Profit_Y2` | `=Revenue_Y2-COGS_Y2`     | Year 2 Gross Profit = Year 2 Revenue minus Year 2 COGS in dollars. |
| `Gross_Profit_Y3` | `=Revenue_Y3-COGS_Y3`     | Year 3 Gross Profit = Year 3 Revenue minus Year 3 COGS in dollars. |

**Dependency chain:**
```
Gross_Profit_Y1  <--  Revenue_Y1  <--  Inp_Rev_Y1
                       COGS_Y1     <--  Revenue_Y1    <--  Inp_Rev_Y1
                                        COGS_Pct_Y1   <--  Inp_COGS_Pct_Y1

Gross_Profit_Y2  <--  Revenue_Y2  <--  (Revenue chain)
                       COGS_Y2     <--  (COGS chain)

Gross_Profit_Y3  <--  Revenue_Y3  <--  (Revenue chain)
                       COGS_Y3     <--  (COGS chain)
```

**Mathematical pattern:** $GP_n = R_n - COGS_n = R_n \times (1 - COGS\%_n)$.
Gross Profit benefits from both revenue growth and COGS efficiency gains.

**Ultimate Layer 1 inputs:** `Inp_Rev_Y1`, `Inp_Rev_Growth`, `Inp_COGS_Pct_Y1`,
`Inp_COGS_Efficiency`.

---

### Operating Expenses Block

Computes OpEx for Years 1-3 using compound growth (same pattern as Revenue).

| Named Range | Formula                           | Business Rule in Plain English                                               |
| ----------- | --------------------------------- | ---------------------------------------------------------------------------- |
| `OpEx_Y1`    | `=Inp_OpEx_Y1`                    | Year 1 OpEx equals the starting operating expense assumption -- pass-through.|
| `OpEx_Y2`    | `=OpEx_Y1*(1+Inp_OpEx_Growth)`    | Year 2 OpEx equals Year 1 OpEx grown by the annual OpEx growth rate.         |
| `OpEx_Y3`    | `=OpEx_Y2*(1+Inp_OpEx_Growth)`    | Year 3 OpEx equals Year 2 OpEx grown by the same annual OpEx growth rate.    |

**Dependency chain:**
```
OpEx_Y1  <--  Inp_OpEx_Y1
OpEx_Y2  <--  OpEx_Y1  <--  Inp_OpEx_Y1
               Inp_OpEx_Growth
OpEx_Y3  <--  OpEx_Y2  <--  OpEx_Y1  <--  Inp_OpEx_Y1
               Inp_OpEx_Growth
```

**Mathematical pattern:** $OpEx_n = OpEx_{n-1} \times (1 + g_{opex})$, where
$g_{opex}$ = `Inp_OpEx_Growth`. Year 3 OpEx is effectively
$\text{Inp\_OpEx\_Y1} \times (1 + \text{Inp\_OpEx\_Growth})^2$.

---

### EBITDA Block

The bottom-line metric: Gross Profit minus Operating Expenses. This is where
all six assumptions converge.

| Named Range  | Formula                          | Business Rule in Plain English                                            |
| ------------ | -------------------------------- | ------------------------------------------------------------------------- |
| `EBITDA_Y1`  | `=Gross_Profit_Y1-OpEx_Y1`       | Year 1 EBITDA = Year 1 Gross Profit minus Year 1 Operating Expenses.     |
| `EBITDA_Y2`  | `=Gross_Profit_Y2-OpEx_Y2`       | Year 2 EBITDA = Year 2 Gross Profit minus Year 2 Operating Expenses.     |
| `EBITDA_Y3`  | `=Gross_Profit_Y3-OpEx_Y3`       | Year 3 EBITDA = Year 3 Gross Profit minus Year 3 Operating Expenses.     |

**Dependency chain (full trace for EBITDA_Y1 as example):**
```
EBITDA_Y1
  |-- Gross_Profit_Y1
  |     |-- Revenue_Y1      <-- Inp_Rev_Y1
  |     |-- COGS_Y1
  |           |-- Revenue_Y1   <-- Inp_Rev_Y1
  |           |-- COGS_Pct_Y1  <-- Inp_COGS_Pct_Y1
  |-- OpEx_Y1                  <-- Inp_OpEx_Y1
```

**All six Layer 1 inputs feed EBITDA_Y2 and EBITDA_Y3:**
`Inp_Rev_Y1`, `Inp_Rev_Growth`, `Inp_COGS_Pct_Y1`, `Inp_COGS_Efficiency`,
`Inp_OpEx_Y1`, `Inp_OpEx_Growth`.

**Mathematical pattern:**
$$EBITDA_n = R_n \times (1 - COGS\%_n) - OpEx_n$$

Expanding fully for Year 3:
$$EBITDA_3 = \bigl[\text{Inp\_Rev\_Y1} \times (1+g)^2\bigr] \times \bigl[1 - (\text{Inp\_COGS\_Pct\_Y1} - 2\varepsilon)\bigr] - \bigl[\text{Inp\_OpEx\_Y1} \times (1+g_{opex})^2\bigr]$$

---

## Complete Dependency Graph

This shows how every Named Range connects, from inputs at the top to the
final EBITDA outputs at the bottom. Read top-to-bottom as "feeds into."

```
LAYER 1 (Assumptions)
======================

Inp_Rev_Y1 --------+
                    |
Inp_Rev_Growth --+  |
                 |  |
                 v  v
LAYER 2 (Calculations)
======================

           Revenue_Y1 --------> Revenue_Y2 --------> Revenue_Y3
               |                    |                    |
               |                    |                    |
Inp_COGS_Pct_Y1                    |                    |
    |                               |                    |
    v                               |                    |
COGS_Pct_Y1 ----> COGS_Pct_Y2 ----> COGS_Pct_Y3        |
    |        (-e)     |        (-e)     |                |
    |                 |                 |                |
    v                 v                 v                |
COGS_Y1           COGS_Y2           COGS_Y3             |
 (Rev*%)           (Rev*%)           (Rev*%)            |
    |                 |                 |                |
    v                 v                 v                |
Gross_Profit_Y1  Gross_Profit_Y2  Gross_Profit_Y3       |
 (Rev-COGS)       (Rev-COGS)       (Rev-COGS)          |
    |                 |                 |                |
    |                 |                 |                |
Inp_OpEx_Y1 ----+    |                 |                |
                |    |                 |                |
Inp_OpEx_Growth |    |                 |                |
    |           |    |                 |                |
    v           v    |                 |                |
  OpEx_Y1 --> OpEx_Y2 -----------> OpEx_Y3              |
    |           |                    |                  |
    v           v                    v                  |
EBITDA_Y1    EBITDA_Y2           EBITDA_Y3              |
 (GP-OpEx)    (GP-OpEx)           (GP-OpEx)             |
```

**Legend:**
- `(-e)` = minus `Inp_COGS_Efficiency`
- `(Rev*%)` = Revenue times COGS Percentage
- `(Rev-COGS)` = Revenue minus COGS
- `(GP-OpEx)` = Gross Profit minus OpEx
- Arrows show data flow direction

---

## Input Sensitivity Summary

Which inputs affect which outputs? Use this to understand the impact radius of
any assumption change.

| Input                | Affects                                                    |
| -------------------- | ---------------------------------------------------------- |
| `Inp_Rev_Y1`         | All Revenue, all COGS ($), all Gross Profit, all EBITDA   |
| `Inp_Rev_Growth`     | Revenue Y2-Y3, COGS ($) Y2-Y3, GP Y2-Y3, EBITDA Y2-Y3   |
| `Inp_COGS_Pct_Y1`   | All COGS (% and $), all Gross Profit, all EBITDA          |
| `Inp_COGS_Efficiency`| COGS % Y2-Y3, COGS ($) Y2-Y3, GP Y2-Y3, EBITDA Y2-Y3    |
| `Inp_OpEx_Y1`        | All OpEx, all EBITDA                                      |
| `Inp_OpEx_Growth`    | OpEx Y2-Y3, EBITDA Y2-Y3                                  |

---

## IDFA Compliance Status

| Guardrail                         | Status | Detail                                        |
| --------------------------------- | ------ | --------------------------------------------- |
| G1 -- Named Range Priority        | PASS   | 0 coordinate references in Calculations layer |
| G2 -- LaTeX Verification           | PASS   | No complex formulas requiring verification    |
| G3 -- Audit-Ready Intent Notes     | PASS   | 18/18 formulas have intent notes (100%)       |
| G4 -- Layer Isolation              | PASS   | 0 cross-layer violations                      |
| **Overall**                        | **PASS** | **100% compliant**                          |

---

## Quick Reference -- All Named Ranges Alphabetically

| Named Range          | Layer       | Type         | Formula / Value                         |
| -------------------- | ----------- | ------------ | --------------------------------------- |
| `COGS_Pct_Y1`        | Calculations| Calculation  | `=Inp_COGS_Pct_Y1`                      |
| `COGS_Pct_Y2`        | Calculations| Calculation  | `=COGS_Pct_Y1-Inp_COGS_Efficiency`      |
| `COGS_Pct_Y3`        | Calculations| Calculation  | `=COGS_Pct_Y2-Inp_COGS_Efficiency`      |
| `COGS_Y1`            | Calculations| Calculation  | `=Revenue_Y1*COGS_Pct_Y1`               |
| `COGS_Y2`            | Calculations| Calculation  | `=Revenue_Y2*COGS_Pct_Y2`               |
| `COGS_Y3`            | Calculations| Calculation  | `=Revenue_Y3*COGS_Pct_Y3`               |
| `EBITDA_Y1`          | Calculations| Calculation  | `=Gross_Profit_Y1-OpEx_Y1`              |
| `EBITDA_Y2`          | Calculations| Calculation  | `=Gross_Profit_Y2-OpEx_Y2`              |
| `EBITDA_Y3`          | Calculations| Calculation  | `=Gross_Profit_Y3-OpEx_Y3`              |
| `Gross_Profit_Y1`    | Calculations| Calculation  | `=Revenue_Y1-COGS_Y1`                   |
| `Gross_Profit_Y2`    | Calculations| Calculation  | `=Revenue_Y2-COGS_Y2`                   |
| `Gross_Profit_Y3`    | Calculations| Calculation  | `=Revenue_Y3-COGS_Y3`                   |
| `Inp_COGS_Efficiency` | Assumptions | Input        | 0.01                                    |
| `Inp_COGS_Pct_Y1`    | Assumptions | Input        | 0.60                                    |
| `Inp_OpEx_Growth`     | Assumptions | Input        | 0.05                                    |
| `Inp_OpEx_Y1`         | Assumptions | Input        | 2,000,000                               |
| `Inp_Rev_Growth`      | Assumptions | Input        | 0.10                                    |
| `Inp_Rev_Y1`          | Assumptions | Input        | 10,000,000                              |
| `OpEx_Y1`             | Calculations| Calculation  | `=Inp_OpEx_Y1`                           |
| `OpEx_Y2`             | Calculations| Calculation  | `=OpEx_Y1*(1+Inp_OpEx_Growth)`           |
| `OpEx_Y3`             | Calculations| Calculation  | `=OpEx_Y2*(1+Inp_OpEx_Growth)`           |
| `Revenue_Y1`          | Calculations| Calculation  | `=Inp_Rev_Y1`                            |
| `Revenue_Y2`          | Calculations| Calculation  | `=Revenue_Y1*(1+Inp_Rev_Growth)`         |
| `Revenue_Y3`          | Calculations| Calculation  | `=Revenue_Y2*(1+Inp_Rev_Growth)`         |
