# Response

You asked two questions. I can answer one of them.

---

## Question 1: Depreciation method (straight-line vs. declining balance)

**I cannot answer this question.** Choosing a depreciation method is a general accounting question — it concerns GAAP rules and accounting policy, not the structure or logic of a financial model. This falls outside the scope of financial model architecture.

Please consult a qualified accountant or CPA who can advise on the appropriate depreciation method for your equipment based on your specific circumstances, jurisdiction, and reporting requirements.

---

## Question 2: How the EBITDA calculation works in your model

This question is in scope — it asks about the formulas and logic inside your financial model. Here is how EBITDA is calculated, based on inspecting the model's Named Ranges and formulas.

### EBITDA formula (all three years)

Each year's EBITDA is computed as:

```
EBITDA_Yn = Gross_Profit_Yn - OpEx_Yn
```

Specifically:

| Named Range  | Formula                        | Intent Note                            |
|-------------|-------------------------------|----------------------------------------|
| EBITDA_Y1   | `=Gross_Profit_Y1 - OpEx_Y1` | Year 1 EBITDA = Gross Profit minus OpEx |
| EBITDA_Y2   | `=Gross_Profit_Y2 - OpEx_Y2` | Year 2 EBITDA = Gross Profit minus OpEx |
| EBITDA_Y3   | `=Gross_Profit_Y3 - OpEx_Y3` | Year 3 EBITDA = Gross Profit minus OpEx |

### The dependency chain

EBITDA depends on two upstream calculations, each of which traces back to Layer 1 assumptions:

**Gross Profit** (feeds into EBITDA):

- `Gross_Profit_Yn = Revenue_Yn - COGS_Yn`
- Revenue grows year-over-year: `Revenue_Y2 = Revenue_Y1 * (1 + Inp_Rev_Growth)`
- COGS is computed as: `COGS_Yn = Revenue_Yn * COGS_Pct_Yn`
- COGS percentage improves annually: `COGS_Pct_Y2 = COGS_Pct_Y1 - Inp_COGS_Efficiency`

**Operating Expenses** (subtracted from Gross Profit to get EBITDA):

- `OpEx_Y1 = Inp_OpEx_Y1` (sourced directly from assumptions)
- `OpEx_Y2 = OpEx_Y1 * (1 + Inp_OpEx_Growth)`
- `OpEx_Y3 = OpEx_Y2 * (1 + Inp_OpEx_Growth)`

### The underlying assumptions (Layer 1 inputs)

| Assumption             | Named Range          | Value       |
|-----------------------|---------------------|-------------|
| Year 1 Revenue        | Inp_Rev_Y1          | 10,000,000  |
| Revenue growth rate   | Inp_Rev_Growth      | 10%         |
| Year 1 COGS %         | Inp_COGS_Pct_Y1     | 60%         |
| Annual efficiency gain | Inp_COGS_Efficiency | 1%          |
| Year 1 OpEx           | Inp_OpEx_Y1         | 2,000,000   |
| OpEx growth rate      | Inp_OpEx_Growth     | 5%          |

### In plain English

EBITDA in this model represents earnings before interest, taxes, depreciation, and amortization. It is calculated by taking Revenue, subtracting COGS to get Gross Profit, then subtracting Operating Expenses. Revenue grows at a fixed 10% per year, COGS percentage decreases by 1 percentage point per year (reflecting scale efficiencies), and OpEx grows at 5% per year. All formulas use Named Ranges exclusively — no cell-coordinate references — which makes the logic self-documenting and IDFA-compliant.
