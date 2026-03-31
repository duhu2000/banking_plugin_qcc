# Aggressive Scenario: Multi-Write Results

## Scenario Description

Three simultaneous changes applied to the financial model:

| Assumption | Original | New (Aggressive) | Change |
|---|---|---|---|
| Units Sold Year 1 | 50,000 | 75,000 | +25,000 (+50%) |
| Variable Cost Per Unit | $40 | $35 | -$5 (-12.5%) |
| Fixed Costs | $1,000,000 | $800,000 | -$200,000 (-20%) |

Unchanged assumptions: Unit Price = $100, Growth Rate = 15%, Tax Rate = 30%.

## Year 2 Full P&L Comparison

| Metric | Original | Aggressive | Change |
|---|---|---|---|
| Units Sold | 57,500 | 86,250 | +28,750 |
| Revenue | $5,750,000.00 | $8,625,000.00 | +$2,875,000.00 |
| Variable Costs | $2,300,000.00 | $3,018,750.00 | +$718,750.00 |
| Contribution Margin | $3,450,000.00 | $5,606,250.00 | +$2,156,250.00 |
| EBIT | $2,450,000.00 | $4,806,250.00 | +$2,356,250.00 |
| Tax | $735,000.00 | $1,441,875.00 | +$706,875.00 |
| Net Income | $1,715,000.00 | $3,364,375.00 | +$1,649,375.00 |

## Key Result

**Year 2 Net Income increases from $1,715,000.00 to $3,364,375.00** -- a gain of **$1,649,375.00 (+96.2%)**.

### Drivers of the Improvement

1. **Volume increase** (50,000 to 75,000 units in Y1, growing 15% to 86,250 in Y2): drives significantly higher revenue and contribution margin.
2. **Lower variable cost** ($40 to $35 per unit): each unit contributes $65 instead of $60 to margin, compounding with the volume increase.
3. **Lower fixed costs** ($1,000,000 to $800,000): directly adds $200,000 to EBIT in both years.

All three changes are margin-accretive and compound multiplicatively through the P&L.

## Files Modified

- `ops_test_model.xlsx` -- Assumptions sheet cells B3, B5, B6 updated; all formulas in Calculations and Output sheets will recalculate when opened in Excel.
