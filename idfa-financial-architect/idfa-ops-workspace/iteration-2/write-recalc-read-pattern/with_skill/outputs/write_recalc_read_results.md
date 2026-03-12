# Write-Recalculate-Read Cycle: Unit Price Increase ($100 to $150)

**Date:** 2026-03-11
**Model:** ops_test_model.xlsx (copied from skills/idfa-ops/evals/files/)
**Methodology:** All values obtained via the IDFA Write-Recalculate-Read pattern.
Recalculation performed by LibreOffice (headless, ODS round-trip with separate user profile).

---

## Scenario

Increase the unit price (`Inp_Price`) from $100 to $150 and observe the impact
on Net Income in both Year 1 and Year 2.

---

## Step 0: Establish Baseline

Before modifying the model, the original file was recalculated to obtain baseline
cached values. The original file had no cached values in formula cells (openpyxl
cannot evaluate formulas), so LibreOffice recalculation was required even for the
baseline.

### Command: Recalculate (baseline)

```bash
# LibreOffice ODS round-trip to populate cached values
soffice --headless --convert-to ods --outdir <output_dir> ops_test_model.xlsx
soffice --headless --convert-to xlsx --outdir <output_dir> ops_test_model.ods
```

### Command: Read baseline

```bash
uv run scripts/idfa_ops.py read ops_test_model.xlsx Inp_Price Net_Income_Y1 Net_Income_Y2
```

### JSON output (baseline read):

```json
{
  "status": "ok",
  "values": {
    "Inp_Price": 100,
    "Net_Income_Y1": 1400000,
    "Net_Income_Y2": 1715000
  }
}
```

---

## Step 1: Write — Set Unit Price to $150

### Command:

```bash
uv run scripts/idfa_ops.py write ops_test_model.xlsx Inp_Price 150
```

### JSON output:

```json
{
  "status": "ok",
  "name": "Inp_Price",
  "value": 150,
  "cell": "Assumptions!B2"
}
```

**What happened:** The value in the Named Range `Inp_Price` (cell Assumptions!B2)
was updated from 100 to 150. At this point, the formulas in the Calculations sheet
still reference the old cached values — they have NOT been recalculated yet.

---

## Step 2: Recalculate — Trigger LibreOffice Formula Evaluation

### Command:

```bash
# Using recalc_bridge.py (which delegates to LibreOffice)
uv run scripts/recalc_bridge.py ops_test_model.xlsx
```

Note: The standard `recalc_bridge.py` macro approach was used first and reported
success, but did not populate cached values readable by openpyxl. A LibreOffice
ODS round-trip (xlsx -> ods -> xlsx) with a separate user profile was used to
ensure deterministic recalculation and cached value population:

```bash
soffice --headless --convert-to ods --outdir <output_dir> ops_test_model.xlsx
soffice --headless -env:UserInstallation=file:///tmp/lo_profile_wrr_recalc \
  --convert-to xlsx --outdir <output_dir> ops_test_model.ods
```

### JSON output (recalc bridge):

```json
{
  "status": "ok",
  "recalculated": true,
  "method": "libreoffice-macro"
}
```

**What happened:** LibreOffice opened the workbook, evaluated every formula in
the Calculations sheet using the new Inp_Price = 150, and saved the results as
cached values in the xlsx file. All dependent formulas were recalculated
deterministically by the spreadsheet engine — not by the agent.

---

## Step 3: Read — Retrieve Recalculated Results

### Command:

```bash
uv run scripts/idfa_ops.py read ops_test_model.xlsx \
  Inp_Price Net_Income_Y1 Net_Income_Y2 Revenue_Y1 Revenue_Y2 \
  EBIT_Y1 EBIT_Y2 Units_Y1 Units_Y2 Variable_Costs_Y1 Variable_Costs_Y2 \
  Contribution_Y1 Contribution_Y2 Tax_Y1 Tax_Y2
```

### JSON output:

```json
{
  "status": "ok",
  "values": {
    "Inp_Price": 150,
    "Net_Income_Y1": 3150000,
    "Net_Income_Y2": 3727500,
    "Revenue_Y1": 7500000,
    "Revenue_Y2": 8625000,
    "EBIT_Y1": 4500000,
    "EBIT_Y2": 5325000,
    "Units_Y1": 50000,
    "Units_Y2": 57500,
    "Variable_Costs_Y1": 2000000,
    "Variable_Costs_Y2": 2300000,
    "Contribution_Y1": 5500000,
    "Contribution_Y2": 6325000,
    "Tax_Y1": 1350000,
    "Tax_Y2": 1597500
  }
}
```

### Formula verification (post-recalc):

```json
{"status": "ok", "name": "Net_Income_Y1", "formula": "=EBIT_Y1-Tax_Y1"}
{"status": "ok", "name": "Net_Income_Y2", "formula": "=EBIT_Y2-Tax_Y2"}
```

Formulas remain intact after recalculation — the model's structure was preserved.

---

## Summary: Before vs. After

| Metric                | Year 1 (Baseline) | Year 1 (New) | Change      | Year 2 (Baseline) | Year 2 (New) | Change      |
| --------------------- | -----------------:| ------------:| -----------:| -----------------:| ------------:| -----------:|
| **Unit Price**        |             $100  |         $150 |    +$50     |             $100  |         $150 |    +$50     |
| Units Sold            |           50,000  |       50,000 |      --     |           57,500  |       57,500 |      --     |
| Revenue               |       $5,000,000  |   $7,500,000 | +$2,500,000 |       $5,750,000  |   $8,625,000 | +$2,875,000 |
| Variable Costs        |       $2,000,000  |   $2,000,000 |      --     |       $2,300,000  |   $2,300,000 |      --     |
| Contribution Margin   |       $3,000,000  |   $5,500,000 | +$2,500,000 |       $3,450,000  |   $6,325,000 | +$2,875,000 |
| EBIT                  |       $2,000,000  |   $4,500,000 | +$2,500,000 |       $2,450,000  |   $5,325,000 | +$2,875,000 |
| Tax (30%)             |         $600,000  |   $1,350,000 |   +$750,000 |         $735,000  |   $1,597,500 |   +$862,500 |
| **Net Income**        |     **$1,400,000**| **$3,150,000**| **+$1,750,000** | **$1,715,000**| **$3,727,500**| **+$2,012,500** |

### Key Observations

1. **Net Income Y1 increased by $1,750,000** (from $1.4M to $3.15M) — a **125% increase**
   from a 50% price increase.

2. **Net Income Y2 increased by $2,012,500** (from $1.715M to $3.7275M) — a **117% increase**.

3. The leverage effect is significant: a 50% price increase drives a >100% Net Income
   increase because variable costs and fixed costs remain unchanged, so the entire
   incremental revenue flows through to contribution margin and EBIT (less 30% tax).

4. **Year 2 gains are larger in absolute terms** ($2,012,500 vs $1,750,000) because
   the 15% unit growth compounds with the higher price, amplifying the revenue impact.

5. Variable costs did not change because they are driven by units (not price).
   Fixed costs did not change because they are, by definition, fixed.

---

## Formula Chain (for audit trail)

```
Inp_Price = 150  (input assumption)

Units_Y1          = Inp_Units_Y1                        = 50,000
Units_Y2          = Units_Y1 * (1 + Inp_Units_Growth)   = 50,000 * 1.15 = 57,500

Revenue_Y1        = Units_Y1 * Inp_Price                = 50,000 * 150 = 7,500,000
Revenue_Y2        = Units_Y2 * Inp_Price                = 57,500 * 150 = 8,625,000

Variable_Costs_Y1 = Units_Y1 * Inp_Variable_Cost_Per_Unit = 50,000 * 40 = 2,000,000
Variable_Costs_Y2 = Units_Y2 * Inp_Variable_Cost_Per_Unit = 57,500 * 40 = 2,300,000

Contribution_Y1   = Revenue_Y1 - Variable_Costs_Y1      = 7,500,000 - 2,000,000 = 5,500,000
Contribution_Y2   = Revenue_Y2 - Variable_Costs_Y2      = 8,625,000 - 2,300,000 = 6,325,000

EBIT_Y1           = Contribution_Y1 - Inp_Fixed_Costs   = 5,500,000 - 1,000,000 = 4,500,000
EBIT_Y2           = Contribution_Y2 - Inp_Fixed_Costs   = 6,325,000 - 1,000,000 = 5,325,000

Tax_Y1            = EBIT_Y1 * Inp_Tax_Rate               = 4,500,000 * 0.30 = 1,350,000
Tax_Y2            = EBIT_Y2 * Inp_Tax_Rate               = 5,325,000 * 0.30 = 1,597,500

Net_Income_Y1     = EBIT_Y1 - Tax_Y1                    = 4,500,000 - 1,350,000 = 3,150,000
Net_Income_Y2     = EBIT_Y2 - Tax_Y2                    = 5,325,000 - 1,597,500 = 3,727,500
```

All formula-traced values match the LibreOffice-recalculated values exactly.

---

## Output Files

- `ops_test_model.xlsx` — Modified model with Inp_Price = 150 and recalculated values
- `write_recalc_read_results.md` — This file (primary deliverable)
