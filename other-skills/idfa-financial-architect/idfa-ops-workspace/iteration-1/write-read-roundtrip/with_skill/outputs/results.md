# Write-Read Roundtrip Results

## Objective

Update the `Inp_Price` assumption from $100 to $125 and verify the change persists via a read-back.

## Tool Used

`uv run scripts/idfa_ops.py` from `skills/idfa-ops/`

## Source File

`skills/idfa-ops/evals/files/ops_test_model.xlsx` (copied to outputs before modification)

## Steps and Outputs

### Step 1: Read Current Value (Before Write)

**Command:**
```
uv run scripts/idfa_ops.py read ops_test_model.xlsx Inp_Price
```

**Output:**
```json
{"status": "ok", "values": {"Inp_Price": 100}}
```

Confirmed original value is **100**.

### Step 2: Write New Value

**Command:**
```
uv run scripts/idfa_ops.py write ops_test_model.xlsx Inp_Price 125
```

**Output:**
```json
{"status": "ok", "name": "Inp_Price", "value": 125, "cell": "Assumptions!B2"}
```

Write succeeded. Named Range `Inp_Price` maps to cell `Assumptions!B2`.

### Step 3: Read Back (Verification)

**Command:**
```
uv run scripts/idfa_ops.py read ops_test_model.xlsx Inp_Price
```

**Output:**
```json
{"status": "ok", "values": {"Inp_Price": 125}}
```

Confirmed new value is **125**.

## Result

**PASS** -- Write-read roundtrip successful. Value changed from 100 to 125 and verified via independent read-back. The `idfa_ops.py` script correctly wrote the value to the Named Range `Inp_Price` at `Assumptions!B2` and the subsequent read confirmed persistence.

## Notes

- No recalculation step was performed. Dependent formulas in the model will still reflect the old cached values until `recalc_bridge.py` is run.
- The xlsx file in the outputs directory contains the updated value.
