# Monte Carlo Simulation: Year 3 Gross Profit Distribution

## Protocol

This simulation follows the **IDFA Stochastic Simulation Protocol** (SKILL.md):
1. Identify uncertain inputs and define distributions with the user
2. Iterate N times via write -> recalculate -> read
3. Analyse the distribution (mean, median, percentiles, probabilities)
4. Restore the model to base case after simulation
5. Report distribution summary

**Key constraint honored:** Each iteration delegates to the spreadsheet's own
formula definitions. The formulas in the xlsx are the single source of truth
for business logic (IDFA Guardrail 4 -- Delegated Calculation).

---

## Simulation Parameters

| Parameter | Value |
|---|---|
| Iterations | 100 |
| Random seed | 42 |
| Target output | `Gross_Profit_Y3` |
| Model file | `idfa_compliant_model.xlsx` |

### Uncertain Inputs

| Named Range | Distribution | Min | Max | Base Case |
|---|---|---|---|---|
| `Inp_Rev_Growth` | Uniform | 5% | 15% | 10% |
| `Inp_COGS_Efficiency` | Uniform | 0% | 2% | 1% |

### Fixed Inputs (held constant)

| Named Range | Value |
|---|---|
| `Inp_Rev_Y1` | $10,000,000 |
| `Inp_COGS_Pct_Y1` | 60% |
| `Inp_OpEx_Y1` | $2,000,000 |
| `Inp_OpEx_Growth` | 5% |

---

## Base Case Result

| Metric | Value |
|---|---|
| `Gross_Profit_Y3` (base case) | **$5,082,000.00** |

Computed with `Inp_Rev_Growth = 10%` and `Inp_COGS_Efficiency = 1%`.

---

## Distribution Summary

| Statistic | Value |
|---|---|
| **Mean** | **$5,069,549.76** |
| **Median** | **$5,028,060.52** |
| Standard deviation | $324,863.54 |
| Minimum | $4,507,834.17 |
| Maximum | $5,731,543.30 |

### Percentiles

| Percentile | Value |
|---|---|
| P5 | $4,612,012.25 |
| P10 | $4,682,130.43 |
| P25 | $4,785,589.47 |
| P50 (median) | $5,028,060.52 |
| P75 | $5,330,464.91 |
| P90 | $5,531,165.93 |
| P95 | $5,618,845.40 |

### 80% Confidence Interval (P10 to P90)

**$4,682,130 to $5,531,166**

The model predicts Year 3 Gross Profit will fall within this range 80% of
the time, given the assumed uncertainty in revenue growth and COGS efficiency.

---

## Probability Thresholds

| Threshold | Probability |
|---|---|
| P(GP_Y3 >= $5.0M) | **54.0%** |
| P(GP_Y3 >= $5.5M) | 11.0% |
| P(GP_Y3 >= $6.0M) | 0.0% |
| P(GP_Y3 < $4.5M) | 0.0% |

---

## Histogram

```
  $4.51M - $4.63M  |========            ( 8)
  $4.63M - $4.75M  |==============      (14)
  $4.75M - $4.87M  |============        (12)
  $4.87M - $5.00M  |============        (12)
  $5.00M - $5.12M  |===========         (11)
  $5.12M - $5.24M  |==========          (10)
  $5.24M - $5.36M  |=============       (13)
  $5.36M - $5.49M  |========            ( 8)
  $5.49M - $5.61M  |=====              ( 5)
  $5.61M - $5.73M  |=======            ( 7)
```

The distribution is roughly uniform/flat, consistent with two uniform input
distributions driving the outcome. There is a slight left skew -- the lower
buckets are slightly more populated because revenue growth has a multiplicative
(compounding) effect while COGS efficiency has an additive effect, so the
upside from high growth is partially offset by the lower density at the high end
of the COGS efficiency distribution.

---

## Interpretation

1. **The range of outcomes is approximately $4.5M to $5.7M** -- a spread of
   about $1.2M (roughly 24% of the base case). This is the full uncertainty
   envelope given the assumed input ranges.

2. **The mean ($5.07M) is close to the base case ($5.08M)**, which is expected
   since the base case assumptions (10% growth, 1% efficiency) sit at the
   midpoints of both uniform distributions.

3. **There is a 54% probability of exceeding $5.0M** in Year 3 Gross Profit --
   essentially a coin flip. The base case itself sits just above $5.0M.

4. **Reaching $5.5M or higher requires 11% probability** -- this would need
   a combination of above-average revenue growth AND above-average COGS
   efficiency improvement.

5. **The downside floor is $4.5M** (P0). Even in the worst-case sampled
   scenario (low growth at ~5.9%, minimal COGS improvement at ~0.1%), Year 3
   Gross Profit remains above $4.5M.

6. **$6.0M is unreachable** under these assumptions -- no combination of
   inputs within the specified ranges produces GP_Y3 >= $6.0M.

---

## Model State

The xlsx has been **restored to base case values** after simulation:
- `Inp_Rev_Growth` = 0.10
- `Inp_COGS_Efficiency` = 0.01

The file `idfa_compliant_model.xlsx` in this directory reflects the base case,
not the last Monte Carlo sample.

---

## Formula Chain (from the xlsx)

These are the spreadsheet formulas that define the business logic evaluated
in each iteration:

```
Revenue_Y1      = Inp_Rev_Y1
Revenue_Y2      = Revenue_Y1 * (1 + Inp_Rev_Growth)
Revenue_Y3      = Revenue_Y2 * (1 + Inp_Rev_Growth)

COGS_Pct_Y1     = Inp_COGS_Pct_Y1
COGS_Pct_Y2     = COGS_Pct_Y1 - Inp_COGS_Efficiency
COGS_Pct_Y3     = COGS_Pct_Y2 - Inp_COGS_Efficiency

COGS_Y1         = Revenue_Y1 * COGS_Pct_Y1
COGS_Y2         = Revenue_Y2 * COGS_Pct_Y2
COGS_Y3         = Revenue_Y3 * COGS_Pct_Y3

Gross_Profit_Y1 = Revenue_Y1 - COGS_Y1
Gross_Profit_Y2 = Revenue_Y2 - COGS_Y2
Gross_Profit_Y3 = Revenue_Y3 - COGS_Y3
```

The agent did not compute any results internally. All arithmetic was performed
by evaluating the spreadsheet's own formula definitions.
