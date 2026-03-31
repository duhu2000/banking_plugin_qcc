# Write-Recalculate-Read Cycle Results

## Scenario

**Change:** Increase unit price from $100 to $150.
**Named Range modified:** `Inp_Price` (Assumptions!B2)
**Model file:** `ops_test_model.xlsx`

---

## Step 1: WRITE

**Command:**
```bash
uv run scripts/idfa_ops.py write ops_test_model.xlsx Inp_Price 150
```

**Result:**
```json
{"status": "ok", "name": "Inp_Price", "value": 150, "cell": "Assumptions!B2"}
```

Write succeeded. The value in cell `Assumptions!B2` was updated from 100 to 150.
At this point, dependent formula cells are **not** recalculated -- openpyxl stores
the raw value but cannot evaluate Excel formulas.

---

## Step 2: RECALCULATE

**Command:**
```bash
uv run scripts/recalc_bridge.py ops_test_model.xlsx
```

**Result:**
```json
{"status": "error", "message": "No recalculation engine found. Install one of:\n  1. Anthropic's xlsx skill (recommended): provides recalc.py\n  2. LibreOffice (brew install --cask libreoffice)\nWithout a recalc engine, the Write-Recalculate-Read pattern cannot\ncomplete. You can still write assumptions and read cached values."}
```

**Recalculation failed.** Neither LibreOffice nor the Anthropic xlsx skill's
`recalc.py` was found on this machine. The formula cells in the Calculations
sheet retain their previous cached values (which are `null` in this model since
no spreadsheet engine has ever evaluated them).

---

## Step 3: READ

**Command:**
```bash
uv run scripts/idfa_ops.py read ops_test_model.xlsx Net_Income_Y1 Net_Income_Y2 Inp_Price
```

**Result:**
```json
{"status": "ok", "values": {"Net_Income_Y1": null, "Net_Income_Y2": null, "Inp_Price": 150}}
```

- `Inp_Price` confirms the write persisted: **150** (was 100).
- `Net_Income_Y1` and `Net_Income_Y2` return **null** because no recalculation
  engine was available to evaluate the formula chain.

---

## Expected Net Income (Formula Trace)

Since the recalculation engine was unavailable, the expected values are traced
manually through the model's formula chain to show what a spreadsheet engine
**would** compute.

### Model Assumptions (after write)

| Named Range              | Value   |
|--------------------------|---------|
| Inp_Price                | 150     |
| Inp_Units_Y1             | 50,000  |
| Inp_Units_Growth         | 15%     |
| Inp_Variable_Cost_Per_Unit | 40    |
| Inp_Fixed_Costs          | 1,000,000 |
| Inp_Tax_Rate             | 30%     |

### Baseline ($100 price) vs. Scenario ($150 price)

| Metric              | Year 1 @ $100 | Year 1 @ $150 | Year 2 @ $100 | Year 2 @ $150 |
|----------------------|----------------|----------------|----------------|----------------|
| Units                | 50,000         | 50,000         | 57,500         | 57,500         |
| Revenue              | 5,000,000      | 7,500,000      | 5,750,000      | 8,625,000      |
| Variable Costs       | 2,000,000      | 2,000,000      | 2,300,000      | 2,300,000      |
| Contribution         | 3,000,000      | 5,500,000      | 3,450,000      | 6,325,000      |
| EBIT                 | 2,000,000      | 4,500,000      | 2,450,000      | 5,325,000      |
| Tax                  | 600,000        | 1,350,000      | 735,000        | 1,597,500      |
| **Net Income**       | **1,400,000**  | **3,150,000**  | **1,715,000**  | **3,727,500**  |

### Impact Summary

| Metric          | Year 1 Change       | Year 2 Change       |
|-----------------|----------------------|----------------------|
| Net Income      | +$1,750,000 (+125%) | +$2,012,500 (+117%) |

The $50 price increase flows directly through revenue (units unchanged),
increasing contribution by $2,500,000 in Y1 and $2,875,000 in Y2. After the
30% tax rate, Net Income increases by $1,750,000 (Y1) and $2,012,500 (Y2).

---

## Key Observations

1. **Write succeeded** -- `idfa_ops.py write` correctly updated `Inp_Price` from
   100 to 150 in the xlsx file.

2. **Recalc failed** -- No LibreOffice or xlsx-skill recalc engine was available.
   To complete this pattern fully, install LibreOffice:
   ```bash
   brew install --cask libreoffice
   ```

3. **Read returned null** -- Without recalculation, openpyxl's `data_only=True`
   mode returns the last cached value from a spreadsheet engine. Since this model
   was never opened in Excel/LibreOffice, all formula cells cache as `null`.

4. **The pattern is sound** -- The three-step Write-Recalculate-Read cycle is the
   correct IDFA interaction pattern. The only missing piece is a recalculation
   engine to evaluate the formula chain deterministically.

5. **Modified xlsx saved** -- The output file `ops_test_model.xlsx` in this
   directory contains `Inp_Price = 150`. Opening it in Excel or LibreOffice will
   trigger automatic recalculation and show the expected Net Income values.
