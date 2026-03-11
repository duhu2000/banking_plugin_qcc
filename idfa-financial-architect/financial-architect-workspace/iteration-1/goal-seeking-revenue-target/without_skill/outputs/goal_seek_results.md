# Goal Seek Results: Year 3 EBITDA Target

## Objective

Find the **Year 1 Revenue** input value required to achieve a **Year 3 EBITDA of at least $3,500,000**.

## Source Model

File: `idfa_compliant_model.xlsx`

### Model Assumptions (Fixed Inputs)

| Assumption              | Value       |
|-------------------------|-------------|
| Revenue Growth Rate     | 10.00%      |
| COGS % Year 1           | 60.00%      |
| COGS Efficiency Gain/yr | 1.00%       |
| OpEx Year 1             | $2,000,000  |
| OpEx Growth Rate        | 5.00%       |

### Model Structure

The model computes Year 3 EBITDA through the following chain:

```
Revenue_Y3 = Rev_Y1 * (1 + 0.10)^2
COGS%_Y3   = 60% - 2 * 1% = 58%
COGS_Y3    = Revenue_Y3 * 58%
GP_Y3      = Revenue_Y3 - COGS_Y3 = Revenue_Y3 * 42%
OpEx_Y3    = $2,000,000 * (1 + 0.05)^2 = $2,205,000
EBITDA_Y3  = GP_Y3 - OpEx_Y3
```

## Goal Seek Solution

### Analytical Formula

```
EBITDA_Y3 = Rev_Y1 * (1.10)^2 * 0.42 - $2,205,000

Solving for Rev_Y1:
Rev_Y1 = (Target_EBITDA_Y3 + $2,205,000) / (1.21 * 0.42)
Rev_Y1 = ($3,500,000 + $2,205,000) / 0.5082
```

### Result

| Item                        | Value           |
|-----------------------------|-----------------|
| **Required Year 1 Revenue** | **$11,225,895.32** |
| Original Year 1 Revenue     | $10,000,000.00  |
| Change Required              | +$1,225,895.32  |
| Percentage Change            | +12.26%         |

## Verification: Full 3-Year P&L with Required Revenue

| Metric       | Year 1          | Year 2          | Year 3          |
|--------------|-----------------|-----------------|-----------------|
| Revenue      | $11,225,895.32  | $12,348,484.85  | $13,583,333.33  |
| COGS %       | 60.00%          | 59.00%          | 58.00%          |
| COGS         | $6,735,537.19   | $7,285,606.06   | $7,878,333.33   |
| Gross Profit | $4,490,358.13   | $5,062,878.79   | $5,705,000.00   |
| OpEx         | $2,000,000.00   | $2,100,000.00   | $2,205,000.00   |
| **EBITDA**   | **$2,490,358.13** | **$2,962,878.79** | **$3,500,000.00** |

## Comparison: Original vs. Goal-Seek EBITDA

| Year   | Original EBITDA | Goal-Seek EBITDA | Difference     |
|--------|-----------------|------------------|----------------|
| Year 1 | $2,000,000.00   | $2,490,358.13    | +$490,358.13   |
| Year 2 | $2,410,000.00   | $2,962,878.79    | +$552,878.79   |
| Year 3 | $2,877,000.00   | $3,500,000.00    | +$623,000.00   |

## Conclusion

Setting **Year 1 Revenue to $11,225,895.32** (a 12.26% increase from the original $10,000,000) produces exactly **$3,500,000 EBITDA in Year 3**, satisfying the target constraint. All other assumptions remain unchanged.
