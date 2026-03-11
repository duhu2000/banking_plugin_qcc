# Create Named Range: Inp_Discount_Rate

## Task

Add a new input to the model: a discount rate of 8% for future DCF analysis.
Create a Named Range called `Inp_Discount_Rate` on the Assumptions sheet at cell B8.

## Source File

`skills/idfa-ops/evals/files/ops_test_model.xlsx` (copied to outputs directory before modification)

## Methodology

All operations performed via `idfa_ops.py` scripts (create-range, write, read, inspect).
No manual cell editing. No formula evaluation required (input-only change).

---

## Step 1: Inspect Model (Pre-Modification)

**Command:**
```bash
uv run scripts/idfa_ops.py inspect ops_test_model.xlsx
```

**Result (summary):**
```json
{"status": "ok", "count": 20}
```

Existing Assumptions sheet inputs occupied B2 through B7:

| Named Range                | Cell | Value     |
| -------------------------- | ---- | --------- |
| Inp_Price                  | B2   | 100       |
| Inp_Units_Y1               | B3   | 50000     |
| Inp_Units_Growth           | B4   | 0.15      |
| Inp_Variable_Cost_Per_Unit | B5   | 40        |
| Inp_Fixed_Costs            | B6   | 1000000   |
| Inp_Tax_Rate               | B7   | 0.3       |

Cell B8 was available. Total Named Ranges: 20.

---

## Step 2: Create Named Range

**Command:**
```bash
uv run scripts/idfa_ops.py create-range ops_test_model.xlsx Inp_Discount_Rate Assumptions B8
```

**JSON Output:**
```json
{"status": "ok", "name": "Inp_Discount_Rate", "reference": "Assumptions!B8"}
```

---

## Step 3: Write Value (8% = 0.08)

**Command:**
```bash
uv run scripts/idfa_ops.py write ops_test_model.xlsx Inp_Discount_Rate 0.08
```

**JSON Output:**
```json
{"status": "ok", "name": "Inp_Discount_Rate", "value": 0.08, "cell": "Assumptions!B8"}
```

---

## Step 4: Verify — Read Back Value

**Command:**
```bash
uv run scripts/idfa_ops.py read ops_test_model.xlsx Inp_Discount_Rate
```

**JSON Output:**
```json
{"status": "ok", "values": {"Inp_Discount_Rate": 0.08}}
```

---

## Step 5: Verify — Inspect Model (Post-Modification)

**Command:**
```bash
uv run scripts/idfa_ops.py inspect ops_test_model.xlsx
```

**Result (filtered to new range):**
```json
{
  "count": 21,
  "Inp_Discount_Rate": {
    "name": "Inp_Discount_Rate",
    "sheet": "Assumptions",
    "cell": "B8",
    "formula": null,
    "value_raw": 0.08,
    "cached_value": 0.08,
    "intent_note": null
  }
}
```

---

## Summary

| Check                          | Result |
| ------------------------------ | ------ |
| Named Range created            | Yes    |
| Name is `Inp_Discount_Rate`    | Yes    |
| Located on Assumptions sheet   | Yes    |
| Cell is B8                     | Yes    |
| Value is 0.08 (8%)             | Yes    |
| Total Named Ranges after       | 21     |
| Follows IDFA `Inp_` convention | Yes    |
| No existing ranges disturbed   | Yes    |

All operations completed successfully. The model is ready for future DCF analysis
formulas that reference `Inp_Discount_Rate`.
