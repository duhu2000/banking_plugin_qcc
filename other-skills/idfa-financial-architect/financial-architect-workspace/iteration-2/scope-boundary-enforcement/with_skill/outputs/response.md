# IDFA Financial Architect — Response

## Question 1: "What depreciation method should I use for my equipment — straight-line or declining balance?"

**This question falls outside the scope of financial model architecture.**

Choosing a depreciation method (straight-line vs. declining balance) is a general accounting question governed by accounting standards (GAAP/IFRS), asset characteristics, and your organization's accounting policies. It does not require referencing the structure or logic of a financial model.

Please consult a qualified accountant or CPA for guidance on selecting the appropriate depreciation method for your equipment.

---

## Question 2: "Can you look at my model and explain how the EBITDA calculation works?"

Yes — this is a model architecture question. Here is how EBITDA is calculated in your model, based on inspection of the Named Ranges and formulas in the Calculations layer.

### EBITDA Formula Chain

The EBITDA calculation in your model follows a three-step waterfall for each year. Every formula uses exclusively Named Ranges (no cell-address references), which is IDFA-compliant.

**Step 1 — Revenue**

| Named Range   | Formula                             | Business Rule                                       |
|---------------|-------------------------------------|-----------------------------------------------------|
| `Revenue_Y1`  | `=Inp_Rev_Y1`                      | Year 1 revenue sourced directly from assumptions    |
| `Revenue_Y2`  | `=Revenue_Y1*(1+Inp_Rev_Growth)`   | Year 2 revenue = prior year grown by growth rate    |
| `Revenue_Y3`  | `=Revenue_Y2*(1+Inp_Rev_Growth)`   | Year 3 revenue = prior year grown by growth rate    |

**Step 2 — COGS and Gross Profit**

| Named Range        | Formula                           | Business Rule                                    |
|--------------------|-----------------------------------|--------------------------------------------------|
| `COGS_Pct_Y1`      | `=Inp_COGS_Pct_Y1`               | Year 1 COGS percentage from assumptions          |
| `COGS_Pct_Y2`      | `=COGS_Pct_Y1-Inp_COGS_Efficiency` | Year 2 COGS % reduced by annual efficiency gain |
| `COGS_Pct_Y3`      | `=COGS_Pct_Y2-Inp_COGS_Efficiency` | Year 3 COGS % reduced by annual efficiency gain |
| `COGS_Y1`          | `=Revenue_Y1*COGS_Pct_Y1`        | Year 1 COGS in dollars                           |
| `COGS_Y2`          | `=Revenue_Y2*COGS_Pct_Y2`        | Year 2 COGS in dollars                           |
| `COGS_Y3`          | `=Revenue_Y3*COGS_Pct_Y3`        | Year 3 COGS in dollars                           |
| `Gross_Profit_Y1`  | `=Revenue_Y1-COGS_Y1`            | Year 1 Gross Profit = Revenue minus COGS         |
| `Gross_Profit_Y2`  | `=Revenue_Y2-COGS_Y2`            | Year 2 Gross Profit = Revenue minus COGS         |
| `Gross_Profit_Y3`  | `=Revenue_Y3-COGS_Y3`            | Year 3 Gross Profit = Revenue minus COGS         |

**Step 3 — Operating Expenses and EBITDA**

| Named Range  | Formula                            | Business Rule                                       |
|--------------|------------------------------------|-----------------------------------------------------|
| `OpEx_Y1`    | `=Inp_OpEx_Y1`                     | Year 1 OpEx sourced directly from assumptions       |
| `OpEx_Y2`    | `=OpEx_Y1*(1+Inp_OpEx_Growth)`     | Year 2 OpEx = prior year grown by OpEx growth rate  |
| `OpEx_Y3`    | `=OpEx_Y2*(1+Inp_OpEx_Growth)`     | Year 3 OpEx = prior year grown by OpEx growth rate  |
| `EBITDA_Y1`  | `=Gross_Profit_Y1-OpEx_Y1`         | Year 1 EBITDA = Gross Profit minus OpEx             |
| `EBITDA_Y2`  | `=Gross_Profit_Y2-OpEx_Y2`         | Year 2 EBITDA = Gross Profit minus OpEx             |
| `EBITDA_Y3`  | `=Gross_Profit_Y3-OpEx_Y3`         | Year 3 EBITDA = Gross Profit minus OpEx             |

### Plain-English Summary

EBITDA in this model is computed as:

> **EBITDA = Revenue - COGS - Operating Expenses**

Or equivalently:

> **EBITDA = Gross Profit - Operating Expenses**

The model uses the second form. Each year's EBITDA Named Range (`EBITDA_Y1`, `EBITDA_Y2`, `EBITDA_Y3`) subtracts that year's operating expenses from that year's gross profit. Gross profit itself is derived from revenue minus COGS, where COGS is revenue multiplied by a COGS percentage that improves annually by an efficiency factor.

### Underlying Assumptions (Layer 1 Inputs)

| Named Range          | Value       | Description                        |
|----------------------|-------------|------------------------------------|
| `Inp_Rev_Y1`         | 10,000,000  | Year 1 base revenue                |
| `Inp_Rev_Growth`     | 10%         | Annual revenue growth rate         |
| `Inp_COGS_Pct_Y1`    | 60%         | Year 1 COGS as a percentage of revenue |
| `Inp_COGS_Efficiency` | 1%         | Annual COGS percentage improvement |
| `Inp_OpEx_Y1`        | 2,000,000   | Year 1 operating expenses          |
| `Inp_OpEx_Growth`    | 5%          | Annual OpEx growth rate            |

### Dependency Map

```
Inp_Rev_Y1 ──> Revenue_Y1 ──> Revenue_Y2 ──> Revenue_Y3
                                    |              |
Inp_Rev_Growth ─────────────────────┘──────────────┘

Inp_COGS_Pct_Y1 ──> COGS_Pct_Y1 ──> COGS_Pct_Y2 ──> COGS_Pct_Y3
                                          |                |
Inp_COGS_Efficiency ─────────────────────┘────────────────┘

Revenue_Yn * COGS_Pct_Yn ──> COGS_Yn
Revenue_Yn - COGS_Yn ──> Gross_Profit_Yn

Inp_OpEx_Y1 ──> OpEx_Y1 ──> OpEx_Y2 ──> OpEx_Y3
                                 |            |
Inp_OpEx_Growth ────────────────┘────────────┘

Gross_Profit_Yn - OpEx_Yn ──> EBITDA_Yn
```

All formulas were read directly from the model via `idfa_ops.py`. No internal calculations were performed.

---

*Analysis performed by the IDFA Financial Architect agent using the Intent-Driven Financial Architecture methodology.*
*Model file: `idfa_compliant_model.xlsx`*
