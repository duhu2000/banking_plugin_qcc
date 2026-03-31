# IDFA Financial Architect — Response

---

## Question 1: Depreciation Method Selection (Straight-Line vs. Declining Balance)

**This request falls outside the scope of financial model architecture.**

Choosing a depreciation method (straight-line, declining balance, or any other approach) is a general accounting question governed by accounting standards (e.g., GAAP, IFRS), the nature of the asset, and your organization's accounting policies. It does not require referencing the structure or logic of a financial model.

Please consult a qualified accountant or financial advisor for guidance on the appropriate depreciation method for your equipment.

---

## Question 2: How the EBITDA Calculation Works in Your Model

This question is in scope -- it asks about the structure and logic of a specific financial model. Here is the explanation based on inspecting the model.

### Model Inspected

`idfa_compliant_model.xlsx`

### EBITDA Formula Chain

The EBITDA calculation in your model follows a clean, IDFA-compliant formula chain. Each year's EBITDA is computed as **Gross Profit minus Operating Expenses**:

| Named Range   | Formula                        | Business Rule (Plain English)           |
|---------------|--------------------------------|-----------------------------------------|
| `EBITDA_Y1`   | `=Gross_Profit_Y1 - OpEx_Y1`  | Year 1 EBITDA = Gross Profit minus OpEx |
| `EBITDA_Y2`   | `=Gross_Profit_Y2 - OpEx_Y2`  | Year 2 EBITDA = Gross Profit minus OpEx |
| `EBITDA_Y3`   | `=Gross_Profit_Y3 - OpEx_Y3`  | Year 3 EBITDA = Gross Profit minus OpEx |

### Upstream Dependencies

To understand what feeds into EBITDA, here is the full dependency chain:

**Gross Profit** (the first input to EBITDA):

| Named Range        | Formula                               | Business Rule                                     |
|--------------------|---------------------------------------|----------------------------------------------------|
| `Gross_Profit_Y1`  | `=Revenue_Y1 - COGS_Y1`              | Revenue minus Cost of Goods Sold                   |
| `Gross_Profit_Y2`  | `=Revenue_Y2 - COGS_Y2`              | Revenue minus Cost of Goods Sold                   |
| `Gross_Profit_Y3`  | `=Revenue_Y3 - COGS_Y3`              | Revenue minus Cost of Goods Sold                   |

**Revenue** (feeds into Gross Profit):

| Named Range    | Formula                              | Business Rule                                    |
|----------------|--------------------------------------|--------------------------------------------------|
| `Revenue_Y1`   | `=Inp_Rev_Y1`                        | Base year revenue from assumptions               |
| `Revenue_Y2`   | `=Revenue_Y1 * (1 + Inp_Rev_Growth)` | Prior year revenue grown by the growth rate      |
| `Revenue_Y3`   | `=Revenue_Y2 * (1 + Inp_Rev_Growth)` | Prior year revenue grown by the growth rate      |

**COGS** (feeds into Gross Profit):

| Named Range  | Formula                              | Business Rule                                         |
|-------------|--------------------------------------|-------------------------------------------------------|
| `COGS_Y1`    | `=Revenue_Y1 * COGS_Pct_Y1`         | Revenue multiplied by COGS percentage                 |
| `COGS_Y2`    | `=Revenue_Y2 * COGS_Pct_Y2`         | Revenue multiplied by COGS percentage                 |
| `COGS_Y3`    | `=Revenue_Y3 * COGS_Pct_Y3`         | Revenue multiplied by COGS percentage                 |

Where COGS percentages improve each year by an efficiency gain:

| Named Range    | Formula                                | Business Rule                               |
|----------------|----------------------------------------|---------------------------------------------|
| `COGS_Pct_Y1`  | `=Inp_COGS_Pct_Y1`                    | Base COGS % from assumptions                |
| `COGS_Pct_Y2`  | `=COGS_Pct_Y1 - Inp_COGS_Efficiency`  | Prior year COGS % minus efficiency gain     |
| `COGS_Pct_Y3`  | `=COGS_Pct_Y2 - Inp_COGS_Efficiency`  | Prior year COGS % minus efficiency gain     |

**Operating Expenses** (the second input to EBITDA):

| Named Range | Formula                              | Business Rule                                   |
|-------------|--------------------------------------|-------------------------------------------------|
| `OpEx_Y1`    | `=Inp_OpEx_Y1`                       | Base year OpEx from assumptions                 |
| `OpEx_Y2`    | `=OpEx_Y1 * (1 + Inp_OpEx_Growth)`   | Prior year OpEx grown by OpEx growth rate       |
| `OpEx_Y3`    | `=OpEx_Y2 * (1 + Inp_OpEx_Growth)`   | Prior year OpEx grown by OpEx growth rate       |

### Underlying Assumptions (Layer 1 Inputs)

All calculations ultimately trace back to these six assumptions:

| Named Range          | Value       | Description                          |
|----------------------|-------------|--------------------------------------|
| `Inp_Rev_Y1`         | 10,000,000  | Year 1 base revenue                  |
| `Inp_Rev_Growth`     | 10%         | Annual revenue growth rate           |
| `Inp_COGS_Pct_Y1`    | 60%         | Year 1 COGS as a percentage of revenue |
| `Inp_COGS_Efficiency` | 1%         | Annual improvement in COGS percentage |
| `Inp_OpEx_Y1`        | 2,000,000   | Year 1 operating expenses            |
| `Inp_OpEx_Growth`    | 5%          | Annual OpEx growth rate              |

### Summary

In plain English, the model computes EBITDA each year as:

> **EBITDA = Revenue - COGS - Operating Expenses**

Or equivalently (as the model structures it):

> **EBITDA = (Revenue - COGS) - OpEx = Gross Profit - OpEx**

Revenue grows at a fixed annual rate. COGS percentage improves (decreases) by a fixed efficiency gain each year, so gross margins expand over time. Operating expenses grow at their own fixed annual rate. EBITDA captures the net effect of all three dynamics.

Every formula in the EBITDA chain uses Named Ranges exclusively (zero cell-coordinate references), and every formula cell has an Intent Note documenting its purpose. The model is IDFA-compliant for this calculation chain.

---

*Analysis performed by the IDFA Financial Architect agent. Model structure inspected via `idfa_ops.py inspect` and `idfa_ops.py formula` commands. No internal calculations were performed.*
