# Logic Map: IDFA-Compliant 3-Year Financial Model

**Source file:** `idfa_compliant_model.xlsx`
**IDFA Compliance:** PASS -- 100% (all four guardrails satisfied)
**Model type:** 3-Year Gross Profit and EBITDA Waterfall
**Generated:** 2026-03-11 by IDFA Financial Architect agent

---

## How to Read This Document

This Logic Map describes every business rule in the model using only Named
Range notation. You do not need to open the spreadsheet to understand the model.
Every formula, every input, every dependency is documented below.

The model follows the Intent-Driven Financial Architecture (IDFA) and is
organized into three strict layers:

- **Layer 1 (Assumptions)** -- User-modifiable inputs. No calculations.
- **Layer 2 (Calculations)** -- Business logic in Named Range formulas. No hardcoded values.
- **Layer 3 (Output)** -- Presentation only. Reads from Layer 2.

---

## Layer 1 -- Assumptions (All Inputs)

These are the six user-modifiable inputs that drive the entire model. Every
value in the model traces back to one or more of these assumptions. Changing
any of these values and recalculating will cascade through all dependent formulas.

| Named Range          | Business Meaning                        | Base Case Value |
| -------------------- | --------------------------------------- | --------------- |
| `Inp_Rev_Y1`         | Year 1 Revenue (starting revenue)       | $10,000,000     |
| `Inp_Rev_Growth`     | Annual revenue growth rate              | 10% (0.10)      |
| `Inp_COGS_Pct_Y1`   | Year 1 COGS as a percentage of revenue  | 60% (0.60)      |
| `Inp_COGS_Efficiency`| Annual COGS efficiency improvement      | 1pp (0.01)      |
| `Inp_OpEx_Y1`        | Year 1 Operating Expenses               | $2,000,000      |
| `Inp_OpEx_Growth`    | Annual OpEx growth rate                 | 5% (0.05)       |

**Key design decisions embedded in these assumptions:**

- Revenue grows at a flat compound rate (same percentage every year).
- COGS improves by a fixed number of percentage points per year (linear efficiency gain, not compound).
- OpEx grows at a flat compound rate independent of revenue (not tied to revenue as a percentage).

---

## Layer 2 -- Calculations (All Business Rules)

### Revenue Chain

**Business Rule:** Year 1 revenue equals the starting assumption. Each subsequent
year grows by the annual revenue growth rate applied to the prior year's revenue.

**Mathematical pattern:** $R_n = R_{n-1} \times (1 + g)$ where $g$ = `Inp_Rev_Growth`

| Named Range   | Formula                              | Plain English                                      |
| ------------- | ------------------------------------ | -------------------------------------------------- |
| `Revenue_Y1`  | `= Inp_Rev_Y1`                      | Year 1 revenue is the starting assumption          |
| `Revenue_Y2`  | `= Revenue_Y1 * (1 + Inp_Rev_Growth)` | Year 2 revenue = Year 1 grown by the growth rate |
| `Revenue_Y3`  | `= Revenue_Y2 * (1 + Inp_Rev_Growth)` | Year 3 revenue = Year 2 grown by the growth rate |

**Dependency:** `Inp_Rev_Y1`, `Inp_Rev_Growth`

**With base case inputs:**
- Revenue_Y1 = $10,000,000
- Revenue_Y2 = $10,000,000 x 1.10 = $11,000,000
- Revenue_Y3 = $11,000,000 x 1.10 = $12,100,000

---

### COGS Percentage Chain

**Business Rule:** The COGS-to-revenue ratio starts at the Year 1 assumption
and decreases by a fixed efficiency gain each year. This models scale economies:
as the company grows, it produces each dollar of revenue more cheaply.

**Mathematical pattern:** $COGS\%_n = COGS\%_{n-1} - \varepsilon$ where $\varepsilon$ = `Inp_COGS_Efficiency`

| Named Range    | Formula                                | Plain English                                          |
| -------------- | -------------------------------------- | ------------------------------------------------------ |
| `COGS_Pct_Y1`  | `= Inp_COGS_Pct_Y1`                   | Year 1 COGS % is the starting assumption              |
| `COGS_Pct_Y2`  | `= COGS_Pct_Y1 - Inp_COGS_Efficiency` | Year 2 COGS % = Year 1 minus the efficiency gain      |
| `COGS_Pct_Y3`  | `= COGS_Pct_Y2 - Inp_COGS_Efficiency` | Year 3 COGS % = Year 2 minus the efficiency gain      |

**Dependency:** `Inp_COGS_Pct_Y1`, `Inp_COGS_Efficiency`

**With base case inputs:**
- COGS_Pct_Y1 = 60.0%
- COGS_Pct_Y2 = 60.0% - 1.0% = 59.0%
- COGS_Pct_Y3 = 59.0% - 1.0% = 58.0%

---

### COGS Dollar Chain

**Business Rule:** COGS in dollars equals Revenue multiplied by the COGS
percentage for that year. Because both Revenue and COGS % change each year,
COGS dollars reflect the combined effect of growth and efficiency.

**Mathematical pattern:** $COGS_n = R_n \times COGS\%_n$

| Named Range | Formula                      | Plain English                                 |
| ----------- | ---------------------------- | --------------------------------------------- |
| `COGS_Y1`   | `= Revenue_Y1 * COGS_Pct_Y1` | Year 1 COGS = Year 1 Revenue x Year 1 COGS % |
| `COGS_Y2`   | `= Revenue_Y2 * COGS_Pct_Y2` | Year 2 COGS = Year 2 Revenue x Year 2 COGS % |
| `COGS_Y3`   | `= Revenue_Y3 * COGS_Pct_Y3` | Year 3 COGS = Year 3 Revenue x Year 3 COGS % |

**Dependency:** `Revenue_Y1..Y3`, `COGS_Pct_Y1..Y3`

**With base case inputs:**
- COGS_Y1 = $10,000,000 x 0.60 = $6,000,000
- COGS_Y2 = $11,000,000 x 0.59 = $6,490,000
- COGS_Y3 = $12,100,000 x 0.58 = $7,018,000

---

### Gross Profit Chain

**Business Rule:** Gross Profit equals Revenue minus COGS. This is the profit
earned from core operations before overhead and operating expenses.

**Mathematical pattern:** $GP_n = R_n - COGS_n$

| Named Range        | Formula                    | Plain English                                  |
| ------------------ | -------------------------- | ---------------------------------------------- |
| `Gross_Profit_Y1`  | `= Revenue_Y1 - COGS_Y1`  | Year 1 GP = Year 1 Revenue minus Year 1 COGS  |
| `Gross_Profit_Y2`  | `= Revenue_Y2 - COGS_Y2`  | Year 2 GP = Year 2 Revenue minus Year 2 COGS  |
| `Gross_Profit_Y3`  | `= Revenue_Y3 - COGS_Y3`  | Year 3 GP = Year 3 Revenue minus Year 3 COGS  |

**Dependency:** `Revenue_Y1..Y3`, `COGS_Y1..Y3`

**With base case inputs:**
- Gross_Profit_Y1 = $10,000,000 - $6,000,000 = $4,000,000
- Gross_Profit_Y2 = $11,000,000 - $6,490,000 = $4,510,000
- Gross_Profit_Y3 = $12,100,000 - $7,018,000 = $5,082,000

---

### Operating Expenses Chain

**Business Rule:** Year 1 OpEx equals the starting assumption. Each subsequent
year grows by the annual OpEx growth rate. OpEx is independent of Revenue --
it grows at its own rate regardless of the top line.

**Mathematical pattern:** $OpEx_n = OpEx_{n-1} \times (1 + g_{OpEx})$ where $g_{OpEx}$ = `Inp_OpEx_Growth`

| Named Range | Formula                            | Plain English                                    |
| ----------- | ---------------------------------- | ------------------------------------------------ |
| `OpEx_Y1`   | `= Inp_OpEx_Y1`                   | Year 1 OpEx is the starting assumption           |
| `OpEx_Y2`   | `= OpEx_Y1 * (1 + Inp_OpEx_Growth)` | Year 2 OpEx = Year 1 grown by the growth rate  |
| `OpEx_Y3`   | `= OpEx_Y2 * (1 + Inp_OpEx_Growth)` | Year 3 OpEx = Year 2 grown by the growth rate  |

**Dependency:** `Inp_OpEx_Y1`, `Inp_OpEx_Growth`

**With base case inputs:**
- OpEx_Y1 = $2,000,000
- OpEx_Y2 = $2,000,000 x 1.05 = $2,100,000
- OpEx_Y3 = $2,100,000 x 1.05 = $2,205,000

---

### EBITDA Chain

**Business Rule:** EBITDA equals Gross Profit minus Operating Expenses. This
is the bottom line of this model -- earnings before interest, taxes,
depreciation, and amortization. (The model does not include D&A, interest, or
taxes, so EBITDA is the terminal output.)

**Mathematical pattern:** $EBITDA_n = GP_n - OpEx_n$

| Named Range  | Formula                            | Plain English                                    |
| ------------ | ---------------------------------- | ------------------------------------------------ |
| `EBITDA_Y1`  | `= Gross_Profit_Y1 - OpEx_Y1`     | Year 1 EBITDA = Year 1 GP minus Year 1 OpEx     |
| `EBITDA_Y2`  | `= Gross_Profit_Y2 - OpEx_Y2`     | Year 2 EBITDA = Year 2 GP minus Year 2 OpEx     |
| `EBITDA_Y3`  | `= Gross_Profit_Y3 - OpEx_Y3`     | Year 3 EBITDA = Year 3 GP minus Year 3 OpEx     |

**Dependency:** `Gross_Profit_Y1..Y3`, `OpEx_Y1..Y3`

**With base case inputs:**
- EBITDA_Y1 = $4,000,000 - $2,000,000 = $2,000,000
- EBITDA_Y2 = $4,510,000 - $2,100,000 = $2,410,000
- EBITDA_Y3 = $5,082,000 - $2,205,000 = $2,877,000

---

## Full Dependency Graph

This diagram shows how every value in the model traces back to the six
assumptions. Read top-to-bottom: inputs flow into calculations, calculations
feed downstream calculations.

```
LAYER 1 (Assumptions)
======================

Inp_Rev_Y1 ($10M)         Inp_Rev_Growth (10%)
    |                           |
    v                           |
LAYER 2 (Calculations)         |
======================         |
                               |
Revenue_Y1 ----[* (1+g)]----> Revenue_Y2 ----[* (1+g)]----> Revenue_Y3
    |                              |                              |
    |                              |                              |
    |  Inp_COGS_Pct_Y1 (60%)      |  Inp_COGS_Efficiency (1pp)  |
    |       |                      |       |                      |
    v       v                      v       v                      v
    |  COGS_Pct_Y1 --[-eff]--> COGS_Pct_Y2 --[-eff]--> COGS_Pct_Y3
    |       |                      |                          |
    v       v                      v                          v
    COGS_Y1                   COGS_Y2                    COGS_Y3
    |                              |                          |
    v                              v                          v
Gross_Profit_Y1             Gross_Profit_Y2            Gross_Profit_Y3
    |                              |                          |
    |  Inp_OpEx_Y1 ($2M)          |  Inp_OpEx_Growth (5%)    |
    |       |                      |       |                   |
    v       v                      v       v                   v
    |  OpEx_Y1 ----[* (1+g)]----> OpEx_Y2 ----[* (1+g)]----> OpEx_Y3
    |       |                      |                          |
    v       v                      v                          v
EBITDA_Y1                   EBITDA_Y2                  EBITDA_Y3
```

---

## Summary Output Table (Base Case)

| Line Item        | Year 1         | Year 2         | Year 3         |
| ---------------- | -------------- | -------------- | -------------- |
| Revenue          | $10,000,000    | $11,000,000    | $12,100,000    |
| COGS %           | 60.0%          | 59.0%          | 58.0%          |
| COGS ($)         | $6,000,000     | $6,490,000     | $7,018,000     |
| **Gross Profit** | **$4,000,000** | **$4,510,000** | **$5,082,000** |
| OpEx             | $2,000,000     | $2,100,000     | $2,205,000     |
| **EBITDA**       | **$2,000,000** | **$2,410,000** | **$2,877,000** |

---

## IDFA Compliance Status

| Guardrail                           | Status | Details                                     |
| ----------------------------------- | ------ | ------------------------------------------- |
| G1: Named Range Priority            | PASS   | 0 coordinate references in 18 formulas     |
| G2: LaTeX Verification              | PASS   | No complex formulas requiring verification |
| G3: Audit-Ready Intent Notes         | PASS   | 100% coverage (18/18 formulas have notes)  |
| G4: Layer Isolation                  | PASS   | 0 violations; inputs, calcs, output separated |
| **Overall Compliance**              | **PASS** | **100%**                                  |

---

## Intent Notes (Audit Trail)

Every formula in the Calculations layer carries an Intent Note documenting
what it was designed to calculate. These are listed below for audit reference.

| Named Range        | Intent Note                                          |
| ------------------ | ---------------------------------------------------- |
| `Revenue_Y1`       | Year 1 revenue sourced from assumption input         |
| `Revenue_Y2`       | Year 2 revenue = prior year * (1 + growth rate)      |
| `Revenue_Y3`       | Year 3 revenue = prior year * (1 + growth rate)      |
| `COGS_Pct_Y1`      | Year 1 COGS percentage from assumption               |
| `COGS_Pct_Y2`      | Year 2 COGS % reduced by efficiency gain             |
| `COGS_Pct_Y3`      | Year 3 COGS % reduced by efficiency gain             |
| `COGS_Y1`          | Year 1 COGS = Revenue * COGS percentage              |
| `COGS_Y2`          | Year 2 COGS = Revenue * COGS percentage              |
| `COGS_Y3`          | Year 3 COGS = Revenue * COGS percentage              |
| `Gross_Profit_Y1`  | Year 1 Gross Profit = Revenue minus COGS             |
| `Gross_Profit_Y2`  | Year 2 Gross Profit = Revenue minus COGS             |
| `Gross_Profit_Y3`  | Year 3 Gross Profit = Revenue minus COGS             |
| `OpEx_Y1`          | Year 1 OpEx sourced from assumption input            |
| `OpEx_Y2`          | Year 2 OpEx = prior year * (1 + growth rate)         |
| `OpEx_Y3`          | Year 3 OpEx = prior year * (1 + growth rate)         |
| `EBITDA_Y1`        | Year 1 EBITDA = Gross Profit minus OpEx              |
| `EBITDA_Y2`        | Year 2 EBITDA = Gross Profit minus OpEx              |
| `EBITDA_Y3`        | Year 3 EBITDA = Gross Profit minus OpEx              |

---

## Quick-Reference: What to Change for Common Scenarios

| If you want to...                          | Change this Named Range      | Current Value |
| ------------------------------------------ | ---------------------------- | ------------- |
| Start with different Year 1 revenue        | `Inp_Rev_Y1`                | $10,000,000   |
| Change the annual revenue growth rate      | `Inp_Rev_Growth`            | 10%           |
| Change the starting cost structure         | `Inp_COGS_Pct_Y1`          | 60%           |
| Increase/decrease annual cost improvement  | `Inp_COGS_Efficiency`       | 1pp           |
| Start with different Year 1 operating costs| `Inp_OpEx_Y1`              | $2,000,000    |
| Change how fast operating costs grow       | `Inp_OpEx_Growth`          | 5%            |

All other values in the model are calculated -- never edit them directly.

---

## Methodology

This Logic Map was produced by inspecting the model programmatically using
`idfa_ops.py inspect` and `idfa_ops.py formula` for each Named Range. All
values shown in the "base case" columns were computed via formula tracing from
the assumption values, not calculated internally by the agent. The IDFA
compliance audit was performed by `idfa_audit.py`.
