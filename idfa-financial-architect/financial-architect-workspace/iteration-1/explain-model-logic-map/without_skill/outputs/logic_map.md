# IDFA-Compliant Financial Model -- Complete Logic Map

**Source file:** `idfa_compliant_model.xlsx`
**Projection horizon:** 3 years (Year 1, Year 2, Year 3)

---

## 1. Architecture Overview

The workbook follows the IDFA (Institute for Digital Financial Architecture) separation-of-concerns pattern. It is organized into three sheets, each with a single responsibility:

| Sheet | Role | Editable? |
|-------|------|-----------|
| **Assumptions** | Stores every user-changeable input. No formulas. | Yes -- this is the only sheet an operator should touch. |
| **Calculations** | Derives all intermediate and final metrics from the Assumptions via named-range formulas. | No -- formula sheet, do not overwrite. |
| **Output** | Presentation layer that references Calculations by name. Contains no logic of its own. | No -- read-only dashboard. |

Data flows **one way**: Assumptions --> Calculations --> Output. There are no circular references and no cross-sheet reverse links.

---

## 2. Assumptions Sheet (Inputs)

All inputs live in column B, rows 2-7. Each cell has a workbook-scoped **defined name** so that formulas elsewhere never use raw cell addresses.

| Row | Label | Defined Name | Value | Format | Meaning |
|-----|-------|-------------|-------|--------|---------|
| 2 | Revenue Year 1 | `Inp_Rev_Y1` | 10,000,000 | `#,##0` | Base-year top-line revenue in absolute currency units. |
| 3 | Revenue Growth Rate | `Inp_Rev_Growth` | 0.10 | `#,##0.00` | Year-over-year revenue growth expressed as a decimal (10%). |
| 4 | COGS % Year 1 | `Inp_COGS_Pct_Y1` | 0.60 | `#,##0.00` | Cost of goods sold as a fraction of revenue in Year 1 (60%). |
| 5 | COGS Efficiency Gain/yr | `Inp_COGS_Efficiency` | 0.01 | `#,##0.00` | Annual reduction in COGS percentage (1 percentage point per year). |
| 6 | OpEx Year 1 | `Inp_OpEx_Y1` | 2,000,000 | `#,##0` | Base-year operating expenses in absolute currency units. |
| 7 | OpEx Growth Rate | `Inp_OpEx_Growth` | 0.05 | `#,##0.00` | Year-over-year OpEx growth expressed as a decimal (5%). |

**Key design choice:** Revenue growth and OpEx growth are **constant rates** (compound growth), while COGS improvement is a **constant absolute decrement** to the percentage. This means gross margin improves linearly (1 pp/year) while revenue and OpEx grow geometrically.

---

## 3. Calculations Sheet (Business Rules)

### 3.1 Named Ranges for Calculated Cells

Every calculated cell also has a defined name, enabling the Output sheet to reference results without knowing cell addresses.

| Defined Name | Cell | Formula |
|-------------|------|---------|
| `Revenue_Y1` | B2 | `=Inp_Rev_Y1` |
| `Revenue_Y2` | C2 | `=Revenue_Y1*(1+Inp_Rev_Growth)` |
| `Revenue_Y3` | D2 | `=Revenue_Y2*(1+Inp_Rev_Growth)` |
| `COGS_Pct_Y1` | B3 | `=Inp_COGS_Pct_Y1` |
| `COGS_Pct_Y2` | C3 | `=COGS_Pct_Y1-Inp_COGS_Efficiency` |
| `COGS_Pct_Y3` | D3 | `=COGS_Pct_Y2-Inp_COGS_Efficiency` |
| `COGS_Y1` | B4 | `=Revenue_Y1*COGS_Pct_Y1` |
| `COGS_Y2` | C4 | `=Revenue_Y2*COGS_Pct_Y2` |
| `COGS_Y3` | D4 | `=Revenue_Y3*COGS_Pct_Y3` |
| `Gross_Profit_Y1` | B5 | `=Revenue_Y1-COGS_Y1` |
| `Gross_Profit_Y2` | C5 | `=Revenue_Y2-COGS_Y2` |
| `Gross_Profit_Y3` | D5 | `=Revenue_Y3-COGS_Y3` |
| `OpEx_Y1` | B6 | `=Inp_OpEx_Y1` |
| `OpEx_Y2` | C6 | `=OpEx_Y1*(1+Inp_OpEx_Growth)` |
| `OpEx_Y3` | D6 | `=OpEx_Y2*(1+Inp_OpEx_Growth)` |
| `EBITDA_Y1` | B7 | `=Gross_Profit_Y1-OpEx_Y1` |
| `EBITDA_Y2` | C7 | `=Gross_Profit_Y2-OpEx_Y2` |
| `EBITDA_Y3` | D7 | `=Gross_Profit_Y3-OpEx_Y3` |

### 3.2 Business Rules in Plain Language

#### Rule 1 -- Revenue Projection (Compound Growth)

> Revenue in any year equals the prior year's revenue multiplied by (1 + growth rate).

- Year 1 is seeded directly from the assumption (`Inp_Rev_Y1`).
- Year 2: `Revenue_Y1 * (1 + 0.10)` = 11,000,000
- Year 3: `Revenue_Y2 * (1 + 0.10)` = 12,100,000

This is standard **compound annual growth**. Changing `Inp_Rev_Growth` rescales all future years geometrically.

#### Rule 2 -- COGS Percentage (Linear Efficiency Improvement)

> The COGS-to-revenue ratio drops by a fixed number of percentage points each year.

- Year 1: 60.00% (from `Inp_COGS_Pct_Y1`)
- Year 2: 60.00% - 1.00% = 59.00%
- Year 3: 59.00% - 1.00% = 58.00%

This models **operational efficiency gains** -- e.g., economies of scale, supplier renegotiations, or process improvements that shave a constant slice off the cost base each year.

**Important subtlety:** Because this is a *subtraction* (not a percentage reduction), the improvement is linear in margin points, not proportional to the current COGS %. A 1 pp drop from 60% is a 1.67% relative improvement; the same 1 pp drop from 58% is a 1.72% relative improvement.

#### Rule 3 -- COGS Dollar Amount

> COGS in dollars = Revenue * COGS %.

- Year 1: 10,000,000 * 0.60 = 6,000,000
- Year 2: 11,000,000 * 0.59 = 6,490,000
- Year 3: 12,100,000 * 0.58 = 7,018,000

COGS still grows in absolute terms (because revenue grows faster than the efficiency gain shrinks the percentage), but it grows slower than revenue, widening gross margin.

#### Rule 4 -- Gross Profit

> Gross Profit = Revenue - COGS.

- Year 1: 10,000,000 - 6,000,000 = 4,000,000 (40.0% margin)
- Year 2: 11,000,000 - 6,490,000 = 4,510,000 (41.0% margin)
- Year 3: 12,100,000 - 7,018,000 = 5,082,000 (42.0% margin)

Gross margin expands by exactly 1 percentage point per year, which is a direct consequence of the COGS efficiency rule.

#### Rule 5 -- Operating Expenses (Compound Growth)

> OpEx in any year equals the prior year's OpEx multiplied by (1 + OpEx growth rate).

- Year 1: 2,000,000 (from `Inp_OpEx_Y1`)
- Year 2: 2,000,000 * 1.05 = 2,100,000
- Year 3: 2,100,000 * 1.05 = 2,205,000

OpEx grows at 5% per year (half the revenue growth rate), representing disciplined cost control or operating leverage.

#### Rule 6 -- EBITDA

> EBITDA = Gross Profit - Operating Expenses.

- Year 1: 4,000,000 - 2,000,000 = 2,000,000 (20.0% margin)
- Year 2: 4,510,000 - 2,100,000 = 2,410,000 (21.9% margin)
- Year 3: 5,082,000 - 2,205,000 = 2,877,000 (23.8% margin)

EBITDA margin expands because: (a) gross margin improves linearly, and (b) OpEx grows slower than revenue.

**Note:** The model labels this line "EBITDA" but computes it as Gross Profit minus OpEx. There are no depreciation, amortization, interest, or tax lines in the model. This is therefore equivalent to Operating Income / EBIT under the assumption that D&A are either zero or included within OpEx/COGS. Confirm treatment with the model author if D&A are material.

---

## 4. Output Sheet (Presentation Layer)

The Output sheet contains **no business logic**. Every cell simply references a named range from the Calculations sheet.

| Row | Metric | Year 1 Formula | Year 2 Formula | Year 3 Formula |
|-----|--------|---------------|---------------|---------------|
| 2 | Revenue | `=Revenue_Y1` | `=Revenue_Y2` | `=Revenue_Y3` |
| 3 | COGS | `=COGS_Y1` | `=COGS_Y2` | `=COGS_Y3` |
| 4 | Gross Profit | `=Gross_Profit_Y1` | `=Gross_Profit_Y2` | `=Gross_Profit_Y3` |
| 5 | OpEx | `=OpEx_Y1` | `=OpEx_Y2` | `=OpEx_Y3` |
| 6 | EBITDA | `=EBITDA_Y1` | `=EBITDA_Y2` | `=EBITDA_Y3` |

All cells are formatted as `#,##0` (integers with thousands separator, no decimals).

---

## 5. Complete Named-Range Registry

Every defined name in the workbook, grouped by role:

### Input Names (Assumptions sheet)

| Name | Points To | Description |
|------|-----------|-------------|
| `Inp_Rev_Y1` | Assumptions!$B$2 | Base revenue |
| `Inp_Rev_Growth` | Assumptions!$B$3 | Revenue CAGR |
| `Inp_COGS_Pct_Y1` | Assumptions!$B$4 | Starting COGS ratio |
| `Inp_COGS_Efficiency` | Assumptions!$B$5 | Annual COGS % reduction |
| `Inp_OpEx_Y1` | Assumptions!$B$6 | Base OpEx |
| `Inp_OpEx_Growth` | Assumptions!$B$7 | OpEx CAGR |

### Calculated Names (Calculations sheet)

| Name | Points To |
|------|-----------|
| `Revenue_Y1` | Calculations!$B$2 |
| `Revenue_Y2` | Calculations!$C$2 |
| `Revenue_Y3` | Calculations!$D$2 |
| `COGS_Pct_Y1` | Calculations!$B$3 |
| `COGS_Pct_Y2` | Calculations!$C$3 |
| `COGS_Pct_Y3` | Calculations!$D$3 |
| `COGS_Y1` | Calculations!$B$4 |
| `COGS_Y2` | Calculations!$C$4 |
| `COGS_Y3` | Calculations!$D$4 |
| `Gross_Profit_Y1` | Calculations!$B$5 |
| `Gross_Profit_Y2` | Calculations!$C$5 |
| `Gross_Profit_Y3` | Calculations!$D$5 |
| `OpEx_Y1` | Calculations!$B$6 |
| `OpEx_Y2` | Calculations!$C$6 |
| `OpEx_Y3` | Calculations!$D$6 |
| `EBITDA_Y1` | Calculations!$B$7 |
| `EBITDA_Y2` | Calculations!$C$7 |
| `EBITDA_Y3` | Calculations!$D$7 |

---

## 6. Dependency Graph

```
Assumptions (Inputs)
 |
 |-- Inp_Rev_Y1 ---------> Revenue_Y1
 |-- Inp_Rev_Growth -----> Revenue_Y1 --> Revenue_Y2 --> Revenue_Y3
 |
 |-- Inp_COGS_Pct_Y1 ----> COGS_Pct_Y1
 |-- Inp_COGS_Efficiency -> COGS_Pct_Y1 --> COGS_Pct_Y2 --> COGS_Pct_Y3
 |                                |              |              |
 |                           Revenue_Y1     Revenue_Y2     Revenue_Y3
 |                                |              |              |
 |                             COGS_Y1        COGS_Y2        COGS_Y3
 |                                |              |              |
 |                          Gross_Profit_Y1 Gross_Profit_Y2 Gross_Profit_Y3
 |                                |              |              |
 |-- Inp_OpEx_Y1 ---------> OpEx_Y1             |              |
 |-- Inp_OpEx_Growth -----> OpEx_Y1 --> OpEx_Y2 --> OpEx_Y3    |
 |                                |         |           |      |
 |                           EBITDA_Y1  EBITDA_Y2  EBITDA_Y3
 |
 v
Output (passthrough references to all calculated names)
```

---

## 7. Computed Results (Default Assumptions)

| Metric | Year 1 | Year 2 | Year 3 |
|--------|--------|--------|--------|
| Revenue | 10,000,000 | 11,000,000 | 12,100,000 |
| COGS % | 60.0% | 59.0% | 58.0% |
| COGS | 6,000,000 | 6,490,000 | 7,018,000 |
| Gross Profit | 4,000,000 | 4,510,000 | 5,082,000 |
| Gross Margin | 40.0% | 41.0% | 42.0% |
| OpEx | 2,000,000 | 2,100,000 | 2,205,000 |
| EBITDA | 2,000,000 | 2,410,000 | 2,877,000 |
| EBITDA Margin | 20.0% | 21.9% | 23.8% |

---

## 8. IDFA Compliance Notes

The model follows IDFA structural conventions:

1. **Separation of concerns** -- Inputs, calculations, and outputs live on dedicated sheets with no mixing.
2. **Named ranges everywhere** -- All 24 defined names eliminate raw cell references, making formulas self-documenting and auditable.
3. **Unidirectional data flow** -- Assumptions --> Calculations --> Output, with no reverse or circular references.
4. **No hardcoded numbers in formulas** -- Every constant is traced back to a named input on the Assumptions sheet.
5. **Consistent naming convention** -- Input names use `Inp_` prefix; calculated names use `Metric_YN` pattern.
6. **Number formatting** -- All monetary values use `#,##0`; all rates use `#,##0.00`.

---

## 9. Sensitivity Guidance

For anyone running scenarios, here is how each input lever affects the bottom line:

| Input | EBITDA Impact Direction | Mechanism |
|-------|------------------------|-----------|
| Increase `Inp_Rev_Y1` | Higher EBITDA | More gross profit at same margins |
| Increase `Inp_Rev_Growth` | Higher EBITDA (compounds) | Accelerates revenue in Y2/Y3 |
| Decrease `Inp_COGS_Pct_Y1` | Higher EBITDA | Lower cost base from day one |
| Increase `Inp_COGS_Efficiency` | Higher EBITDA (accelerates in later years) | Widens gross margin faster |
| Decrease `Inp_OpEx_Y1` | Higher EBITDA | Lower fixed-cost base |
| Decrease `Inp_OpEx_Growth` | Higher EBITDA (compounds) | Slower cost inflation in Y2/Y3 |

**Break-even sensitivity:** With current assumptions, EBITDA remains positive in all years. EBITDA would go negative in Year 1 only if COGS % exceeded 80% (holding all else constant) or if OpEx exceeded 4,000,000.
