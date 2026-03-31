# Monte Carlo Simulation Results: Year 3 Gross Profit Distribution

**Date:** 2026-03-11
**Model:** idfa_compliant_model.xlsx (IDFA-compliant 3-Year GP Waterfall)
**Methodology:** All values obtained via write-recalculate-read pattern (IDFA Guardrail 4 — Delegated Calculation)
**Recalculation Engine:** LibreOffice (headless, convert-to xlsx)

---

## Simulation Parameters

| Parameter | Distribution | Min | Max |
|-----------|-------------|-----|-----|
| Revenue Growth Rate (`Inp_Rev_Growth`) | Uniform | 5% | 15% |
| COGS Efficiency Improvement (`Inp_COGS_Efficiency`) | Uniform | 0% | 2% per year |

**Fixed assumptions (held constant):**

| Parameter | Named Range | Value |
|-----------|-------------|-------|
| Year 1 Revenue | `Inp_Rev_Y1` | $10,000,000 |
| Year 1 COGS % | `Inp_COGS_Pct_Y1` | 60% |
| Year 1 OpEx | `Inp_OpEx_Y1` | $2,000,000 |
| OpEx Growth | `Inp_OpEx_Growth` | 5% |

**Iterations requested:** 100
**Iterations completed:** 86 (14 failed due to transient LibreOffice lock contention during rapid sequential invocations)
**Random seed:** 42 (for reproducibility)

---

## Target Output: Year 3 Gross Profit (`Gross_Profit_Y3`)

### Distribution Summary

| Statistic | Value |
|-----------|-------|
| **Mean** | **$5,075,990** |
| **Median** | **$5,028,069** |
| **Standard Deviation** | **$320,891** |
| **Minimum** | **$4,520,458** |
| **Maximum** | **$5,731,553** |
| **Range** | **$1,211,094** |
| **Coefficient of Variation** | **6.3%** |

### Percentile Table

| Percentile | Gross Profit Y3 |
|------------|----------------|
| P5 (downside) | $4,622,924 |
| P10 | $4,699,593 |
| P25 | $4,805,225 |
| **P50 (median)** | **$5,028,069** |
| P75 | $5,324,457 |
| P90 | $5,537,657 |
| P95 (upside) | $5,626,361 |

### 80% Confidence Interval (P10 to P90)

**$4,699,593 to $5,537,657**

This means there is an 80% probability that Year 3 Gross Profit falls within this range, given the stated uncertainty in revenue growth and COGS efficiency.

### Probability Thresholds

| Threshold | Probability |
|-----------|------------|
| GP Y3 >= $5,000,000 | 53.5% |
| GP Y3 >= $5,500,000 | 11.6% |
| GP Y3 < $4,500,000 | 0.0% |

---

## Distribution Histogram

```
  Year 3 Gross Profit Distribution (86 iterations)

  $4.52M - $4.62M | ####################                         (5)
  $4.62M - $4.72M | ################################             (8)
  $4.72M - $4.82M | ########################################    (10)
  $4.82M - $4.92M | ########################################    (10)
  $4.92M - $5.03M | ########################################    (10)
  $5.03M - $5.13M | ####################                         (5)
  $5.13M - $5.23M | ################################             (8)
  $5.23M - $5.33M | ####################################         (9)
  $5.33M - $5.43M | ########################                     (6)
  $5.43M - $5.53M | ########################                     (6)
  $5.53M - $5.63M | ####################                         (5)
  $5.63M - $5.73M | ################                             (4)
```

The distribution is approximately uniform-shaped, which is expected given the uniform input distributions and the near-linear relationship between the inputs and Gross Profit Y3.

---

## Extreme Scenarios

### Top 5 Outcomes (Highest GP Y3)

| Rank | Rev Growth | COGS Efficiency | GP Y3 |
|------|-----------|----------------|-------|
| 1 | 15.0% | 1.67% | $5,731,553 |
| 2 | 14.7% | 1.72% | $5,716,503 |
| 3 | 13.8% | 1.89% | $5,668,730 |
| 4 | 14.1% | 1.74% | $5,663,449 |
| 5 | 15.0% | 1.30% | $5,629,046 |

### Bottom 5 Outcomes (Lowest GP Y3)

| Rank | Rev Growth | COGS Efficiency | GP Y3 |
|------|-----------|----------------|-------|
| 1 | 5.3% | 0.40% | $4,520,458 |
| 2 | 5.9% | 0.19% | $4,531,656 |
| 3 | 5.0% | 0.65% | $4,553,444 |
| 4 | 5.8% | 0.47% | $4,581,509 |
| 5 | 7.3% | 0.06% | $4,619,281 |

**Observations:**
- The worst outcomes combine low revenue growth (5-6%) with low COGS efficiency improvement (0-0.5%)
- The best outcomes combine high revenue growth (14-15%) with high COGS efficiency improvement (1.3-1.9%)
- Revenue growth is the dominant driver: all bottom-5 scenarios have growth below 7.3%, and all top-5 have growth above 13.8%

---

## Input Parameter Validation

The sampled inputs should approximate the theoretical uniform distributions:

| Parameter | Sampled Mean | Theoretical Mean | Sampled Std Dev | Theoretical Std Dev |
|-----------|-------------|-----------------|----------------|-------------------|
| Rev Growth | 10.0% | 10.0% | 3.1% | 2.9% |
| COGS Efficiency | 0.95% | 1.0% | 0.55% | 0.58% |

The sampled distributions are consistent with the specified uniform distributions, confirming proper random sampling.

---

## Model Integrity

### Formula Chain (verified via `idfa_ops.py formula`)

```
Revenue_Y3      = Revenue_Y2 * (1 + Inp_Rev_Growth)
                = [Revenue_Y1 * (1 + Inp_Rev_Growth)] * (1 + Inp_Rev_Growth)
                = Inp_Rev_Y1 * (1 + Inp_Rev_Growth)^2

COGS_Pct_Y3     = COGS_Pct_Y2 - Inp_COGS_Efficiency
                = (Inp_COGS_Pct_Y1 - Inp_COGS_Efficiency) - Inp_COGS_Efficiency
                = Inp_COGS_Pct_Y1 - 2 * Inp_COGS_Efficiency

Gross_Profit_Y3 = Revenue_Y3 - COGS_Y3
                = Revenue_Y3 - (Revenue_Y3 * COGS_Pct_Y3)
                = Revenue_Y3 * (1 - COGS_Pct_Y3)
```

### LaTeX Verification

$$GP_{Y3} = R_{Y1} \times (1 + g)^2 \times \left[1 - \left(COGS\%_{Y1} - 2\varepsilon\right)\right]$$

Where:
- $R_{Y1} = \$10{,}000{,}000$ (fixed)
- $g \sim U(0.05, 0.15)$
- $\varepsilon \sim U(0.00, 0.02)$
- $COGS\%_{Y1} = 0.60$ (fixed)

### Base Case Restoration

After simulation, the model was restored to base case values:

| Parameter | Restored Value | Verified GP Y3 |
|-----------|---------------|----------------|
| `Inp_Rev_Growth` | 0.10 | $5,082,000 |
| `Inp_COGS_Efficiency` | 0.01 | (confirmed) |

The base case GP Y3 of $5,082,000 matches the expected value from the IDFA worked example.

---

## Methodology Notes

1. **Each iteration** followed the IDFA write-recalculate-read pattern:
   - `uv run idfa_ops.py write` to set `Inp_Rev_Growth` and `Inp_COGS_Efficiency`
   - LibreOffice headless recalculation (convert-to xlsx) to evaluate all formulas
   - `uv run idfa_ops.py read` to retrieve `Gross_Profit_Y3` from the model

2. **No internal calculation was performed.** All Gross Profit values were read from the spreadsheet engine's deterministic output.

3. **14 iterations failed** due to transient LibreOffice file-lock contention during rapid sequential invocations. These were skipped (not retried with internal calculation). The 86 successful iterations provide a statistically meaningful sample.

4. **Reproducibility:** Random seed = 42. The same sequence of sampled inputs will be generated on re-run, though LibreOffice lock failures may occur at different iterations.

---

## Key Takeaways

- **Central tendency:** Year 3 Gross Profit is expected to average approximately **$5.08M**, very close to the base case of $5.08M (as expected, since the uniform distributions are centered on the base case values).

- **Downside risk:** There is essentially 0% probability of GP Y3 falling below $4.5M. The P10 downside is $4.7M.

- **Upside potential:** There is about a 12% chance of exceeding $5.5M, with the maximum observed at $5.73M.

- **Total range:** The spread from worst to best case is approximately $1.2M, representing a 24% variation around the mean.

- **Revenue growth matters more than COGS efficiency:** The extreme scenarios show that revenue growth is the dominant driver of GP Y3 outcomes, which is intuitive given that revenue growth compounds over 3 years while COGS efficiency gains are additive.
