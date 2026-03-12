# Response: Depreciation Method Advice and EBITDA Model Explanation

## Question 1: Depreciation Method — Straight-Line vs. Declining Balance

### General Guidance

**Straight-line depreciation** spreads the cost of an asset evenly over its useful life. For example, a $100,000 piece of equipment with a 10-year useful life would depreciate at $10,000 per year.

**Declining balance depreciation** (e.g., double-declining balance) front-loads the expense, recognizing more depreciation in the early years and less in later years. That same $100,000 asset at double-declining balance would depreciate $20,000 in Year 1, $16,000 in Year 2, $12,800 in Year 3, and so on.

### Which to choose depends on your situation:

| Factor | Straight-Line | Declining Balance |
|--------|--------------|-------------------|
| Simplicity | Simpler to calculate and forecast | More complex |
| Tax benefit timing | Even tax shield each year | Larger tax shield in early years |
| Asset usage pattern | Best for assets that wear evenly over time (buildings, furniture) | Best for assets that lose productivity quickly (tech equipment, vehicles) |
| Cash flow impact | Lower depreciation early = higher early taxable income | Higher depreciation early = lower early taxable income (preserves cash) |
| Financial reporting | Smoother income statement | Front-loaded expenses reduce early earnings |

**Common recommendation:** If your equipment loses value or productivity faster in its early years (as most technology and machinery does), declining balance is more economically accurate and provides better early-year tax benefits. If simplicity and steady financial reporting are priorities, straight-line is appropriate.

**Important caveat:** This is general information, not tax or accounting advice. The right method depends on your jurisdiction's tax rules, the specific asset type, your company's accounting policies, and potentially GAAP/IFRS requirements. Consult with your accountant or tax advisor for a decision tailored to your circumstances.

---

## Question 2: How the EBITDA Calculation Works in Your Model

Your model (`idfa_compliant_model.xlsx`) is structured in three sheets: **Assumptions**, **Calculations**, and **Output**. Here is how the EBITDA calculation flows across them.

### Assumptions Sheet (Inputs)

| Assumption | Value |
|------------|-------|
| Revenue Year 1 | $10,000,000 |
| Revenue Growth Rate | 10% per year |
| COGS % Year 1 | 60% |
| COGS Efficiency Gain/yr | 1% reduction per year |
| OpEx Year 1 | $2,000,000 |
| OpEx Growth Rate | 5% per year |

### Calculations Sheet (Formulas)

The EBITDA calculation follows a four-step chain for each year:

**Step 1 — Revenue:** Year 1 pulls directly from the assumption (`Inp_Rev_Y1`). Each subsequent year grows by the revenue growth rate:
```
Revenue_Y2 = Revenue_Y1 * (1 + 10%) = $11,000,000
Revenue_Y3 = Revenue_Y2 * (1 + 10%) = $12,100,000
```

**Step 2 — COGS (Cost of Goods Sold):** COGS is calculated as a percentage of revenue. That percentage starts at 60% and improves by 1 percentage point per year (the "efficiency gain"):
```
COGS_Y1 = Revenue_Y1 * 60% = $6,000,000
COGS_Y2 = Revenue_Y2 * 59% = $6,490,000
COGS_Y3 = Revenue_Y3 * 58% = $7,018,000
```

**Step 3 — Gross Profit:** Simple subtraction:
```
Gross_Profit = Revenue - COGS
  Y1: $10,000,000 - $6,000,000 = $4,000,000
  Y2: $11,000,000 - $6,490,000 = $4,510,000
  Y3: $12,100,000 - $7,018,000 = $5,082,000
```

**Step 4 — EBITDA:** Gross Profit minus Operating Expenses:
```
EBITDA = Gross_Profit - OpEx
  Y1: $4,000,000 - $2,000,000 = $2,000,000
  Y2: $4,510,000 - $2,100,000 = $2,410,000
  Y3: $5,082,000 - $2,205,000 = $2,877,000
```

Operating expenses grow at 5% per year from the base of $2,000,000.

### Summary Table

| Metric | Year 1 | Year 2 | Year 3 |
|--------|--------|--------|--------|
| Revenue | $10,000,000 | $11,000,000 | $12,100,000 |
| COGS | $6,000,000 | $6,490,000 | $7,018,000 |
| Gross Profit | $4,000,000 | $4,510,000 | $5,082,000 |
| OpEx | $2,000,000 | $2,100,000 | $2,205,000 |
| **EBITDA** | **$2,000,000** | **$2,410,000** | **$2,877,000** |
| EBITDA Margin | 20.0% | 21.9% | 23.8% |

### Key Observations

1. **EBITDA margin expands** from 20.0% to 23.8% over three years. This is driven by two compounding effects: revenue growing faster (10%/yr) than OpEx (5%/yr), and COGS efficiency improving by 1 percentage point per year.

2. **The model calculates EBITDA as Gross Profit minus OpEx**, which is equivalent to Revenue minus COGS minus OpEx. This is a standard simplified EBITDA approach that works when there is no separate depreciation and amortization line (since EBITDA excludes D&A by definition, and the model has no D&A line items, the operating profit here equals EBITDA directly).

3. **Notably, depreciation is not modeled.** Your first question about depreciation methods is relevant here — if you were to add depreciation to this model, it would appear as a line item below EBITDA (reducing it to EBIT), but EBITDA itself would remain unchanged by definition, since EBITDA explicitly excludes depreciation and amortization.
