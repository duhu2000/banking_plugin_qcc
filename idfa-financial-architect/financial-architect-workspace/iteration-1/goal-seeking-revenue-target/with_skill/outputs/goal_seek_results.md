# Goal-Seeking Report: Year 3 EBITDA Target

## Objective

Find the Year 1 Revenue (`Inp_Rev_Y1`) required to achieve a Year 3 EBITDA
(`EBITDA_Y3`) of at least **$3,500,000** using the IDFA-compliant model.

## Method

**IDFA Goal-Seeking Protocol** -- binary search via the
write-recalculate-read pattern, delegating all arithmetic to the spreadsheet
engine (LibreOffice headless recalculation). No internal calculation was
performed by the agent.

### Model Used

`idfa_compliant_model.xlsx` (IDFA-compliant 3-year P&L model)

### Fixed Assumptions (Unchanged)

| Input                  | Named Range           | Value |
| ---------------------- | --------------------- | ----- |
| Revenue growth rate    | `Inp_Rev_Growth`      | 10%   |
| Year 1 COGS %         | `Inp_COGS_Pct_Y1`     | 60%   |
| Annual efficiency gain | `Inp_COGS_Efficiency` | 1%    |
| Year 1 OpEx            | `Inp_OpEx_Y1`         | $2,000,000 |
| OpEx growth rate       | `Inp_OpEx_Growth`     | 5%    |

### Variable Sought

| Input          | Named Range  | Original Value | Solved Value    |
| -------------- | ------------ | -------------- | --------------- |
| Year 1 Revenue | `Inp_Rev_Y1` | $10,000,000    | **$11,230,468** |

## Iteration Log

All values below were read from the model after LibreOffice recalculation.

| Iteration | Inp_Rev_Y1   | EBITDA_Y3      | Deviation from Target |
| --------- | ------------ | -------------- | --------------------- |
| Baseline  | $10,000,000  | $2,877,000.00  | -17.80%               |
| 1         | $12,500,000  | $4,147,500.00  | +18.50%               |
| 2         | $11,250,000  | $3,512,250.00  | +0.35%                |
| 3         | $10,625,000  | $3,194,625.00  | -8.73%                |
| 4         | $10,937,500  | $3,353,437.50  | -4.19%                |
| 5         | $11,093,750  | $3,432,843.75  | -1.92%                |
| 6         | $11,171,875  | $3,472,546.88  | -0.78%                |
| 7         | $11,210,937  | $3,492,398.18  | -0.22%                |
| 8         | $11,230,468  | $3,502,323.84  | **+0.07%**            |

Converged within 0.1% tolerance at iteration 8.

## Result

**To achieve Year 3 EBITDA of at least $3,500,000, Year 1 Revenue must be
$11,230,468.**

The model produces EBITDA_Y3 = $3,502,323.84 at this input, exceeding the
target by $2,323.84 (0.07%).

## Full Model Output at Solved State

| Line Item         | Year 1         | Year 2         | Year 3         |
| ----------------- | -------------- | -------------- | -------------- |
| Revenue           | $11,230,468.00 | $12,353,514.80 | $13,588,866.28 |
| COGS %            | 60.0%          | 59.0%          | 58.0%          |
| COGS ($)          | $6,738,280.80  | $7,288,573.73  | $7,881,542.44  |
| **Gross Profit**  | $4,492,187.20  | $5,064,941.07  | $5,707,323.84  |
| OpEx              | $2,000,000.00  | $2,100,000.00  | $2,205,000.00  |
| **EBITDA**        | $2,492,187.20  | $2,964,941.07  | **$3,502,323.84** |

## Compliance Notes

- All values were obtained via the IDFA write-recalculate-read pattern
- Zero internal arithmetic was performed by the agent
- The solved value ($11,230,468) is persisted in the model -- the xlsx
  reflects the solved state
- Recalculation engine: LibreOffice headless (convert-to method)
- Scripts used: `idfa_ops.py` (write/read), `recalc_bridge.py` (recalculate)
