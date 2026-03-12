# Create Named Range: Inp_Discount_Rate

## Objective

Add a discount rate input (8%) to the model for future DCF analysis, stored as
a Named Range on the Assumptions sheet at cell B8.

## Steps Executed

### 1. Inspect Model (pre-check)

Confirmed the model had 20 existing Named Ranges. The Assumptions sheet inputs
occupied B2 through B7 (Inp_Price, Inp_Units_Y1, Inp_Units_Growth,
Inp_Variable_Cost_Per_Unit, Inp_Fixed_Costs, Inp_Tax_Rate). Cell B8 was
available.

### 2. Create Named Range

```
uv run scripts/idfa_ops.py create-range ops_test_model.xlsx Inp_Discount_Rate Assumptions B8
```

**Result:**
```json
{"status": "ok", "name": "Inp_Discount_Rate", "reference": "Assumptions!B8"}
```

### 3. Write Value

```
uv run scripts/idfa_ops.py write ops_test_model.xlsx Inp_Discount_Rate 0.08
```

**Result:**
```json
{"status": "ok", "name": "Inp_Discount_Rate", "value": 0.08, "cell": "Assumptions!B8"}
```

### 4. Read Verification

```
uv run scripts/idfa_ops.py read ops_test_model.xlsx Inp_Discount_Rate
```

**Result:**
```json
{"status": "ok", "values": {"Inp_Discount_Rate": 0.08}}
```

## Outcome

| Check                          | Status |
| ------------------------------ | ------ |
| Named Range created            | Pass   |
| Name: Inp_Discount_Rate        | Pass   |
| Location: Assumptions!B8       | Pass   |
| Value set to 0.08 (8%)         | Pass   |
| Read-back confirms value       | Pass   |

All operations completed successfully. The model now contains 21 Named Ranges,
with `Inp_Discount_Rate` ready for use in future DCF formulas.
