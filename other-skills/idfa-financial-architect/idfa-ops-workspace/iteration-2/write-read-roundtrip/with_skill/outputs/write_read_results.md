# Write-Read Roundtrip Results

**Task:** Update price assumption from $100 to $125 and verify the change.

**Model file:** `ops_test_model.xlsx` (copied from `skills/idfa-ops/evals/files/`)

**Methodology:** Write-Read pattern via `idfa_ops.py` scripts. Recalculation was not
performed because the task scope was limited to verifying the write-read roundtrip.
Dependent formula outputs (Revenue, EBIT, Net Income) will not reflect the new price
until a recalculation step is run.

---

## Step 1: Inspect Model

**Command:**

```bash
uv run skills/idfa-ops/scripts/idfa_ops.py inspect \
  idfa-ops-workspace/iteration-2/write-read-roundtrip/with_skill/outputs/ops_test_model.xlsx
```

**JSON output (abbreviated):**

```json
{
  "status": "ok",
  "count": 20,
  "named_ranges": [
    {"name": "Inp_Price", "sheet": "Assumptions", "cell": "B2", "value_raw": 100},
    {"name": "Inp_Units_Y1", "sheet": "Assumptions", "cell": "B3", "value_raw": 50000},
    {"name": "Inp_Units_Growth", "sheet": "Assumptions", "cell": "B4", "value_raw": 0.15},
    {"name": "Inp_Variable_Cost_Per_Unit", "sheet": "Assumptions", "cell": "B5", "value_raw": 40},
    {"name": "Inp_Fixed_Costs", "sheet": "Assumptions", "cell": "B6", "value_raw": 1000000},
    {"name": "Inp_Tax_Rate", "sheet": "Assumptions", "cell": "B7", "value_raw": 0.3}
  ]
}
```

**Finding:** The price assumption is Named Range `Inp_Price`, located at `Assumptions!B2`,
with a current value of 100.

---

## Step 2: Read Current Value (Before Write)

**Command:**

```bash
uv run skills/idfa-ops/scripts/idfa_ops.py read \
  idfa-ops-workspace/iteration-2/write-read-roundtrip/with_skill/outputs/ops_test_model.xlsx \
  Inp_Price
```

**JSON output:**

```json
{"status": "ok", "values": {"Inp_Price": 100}}
```

**Finding:** Confirmed `Inp_Price` = 100 before modification.

---

## Step 3: Write New Value

**Command:**

```bash
uv run skills/idfa-ops/scripts/idfa_ops.py write \
  idfa-ops-workspace/iteration-2/write-read-roundtrip/with_skill/outputs/ops_test_model.xlsx \
  Inp_Price 125
```

**JSON output:**

```json
{"status": "ok", "name": "Inp_Price", "value": 125, "cell": "Assumptions!B2"}
```

**Finding:** Write succeeded. `Inp_Price` set to 125 at cell `Assumptions!B2`.

---

## Step 4: Read Back Value (Verification)

**Command:**

```bash
uv run skills/idfa-ops/scripts/idfa_ops.py read \
  idfa-ops-workspace/iteration-2/write-read-roundtrip/with_skill/outputs/ops_test_model.xlsx \
  Inp_Price
```

**JSON output:**

```json
{"status": "ok", "values": {"Inp_Price": 125}}
```

**Finding:** Read-back confirms the value is now 125. The write-read roundtrip is verified.

---

## Summary

| Named Range | Before | After | Verified |
|-------------|--------|-------|----------|
| Inp_Price   | 100    | 125   | Yes      |

**Result:** The price assumption was successfully updated from $100 to $125.
The write was persisted to the xlsx file and confirmed via an independent read-back.

**Note:** Dependent calculated ranges (Revenue_Y1, Revenue_Y2, EBIT_Y1, EBIT_Y2,
Net_Income_Y1, Net_Income_Y2) have not been recalculated. To see updated outputs,
run `uv run skills/idfa-ops/scripts/recalc_bridge.py <file>` followed by reads
of the calculation-layer ranges.
