# Error Handling Results: Bad Named Range Name

## Task

Read the value of `Total_Revenue_All_Years` from the test model.

**Model file:** `skills/idfa-ops/evals/files/ops_test_model.xlsx`

---

## Step 1 — Attempt to Read `Total_Revenue_All_Years`

**Command:**
```bash
uv run scripts/idfa_ops.py read ops_test_model.xlsx Total_Revenue_All_Years
```

**Result:**
```json
{"error": "Named Range not found: Total_Revenue_All_Years"}
```

**Exit code:** 1

The Named Range `Total_Revenue_All_Years` does not exist in this model. Per the
SKILL.md error handling table, the correct agent action on exit code 1 is:
**"Inspect model to find correct name."**

---

## Step 2 — Inspect Model to Find Revenue-Related Named Ranges

**Command:**
```bash
uv run scripts/idfa_ops.py inspect ops_test_model.xlsx
```

**Result:** The model contains 20 Named Ranges across two sheets. The
revenue-related Named Ranges are:

| Named Range    | Sheet        | Cell | Formula                | Cached Value |
| -------------- | ------------ | ---- | ---------------------- | ------------ |
| `Inp_Price`    | Assumptions  | B2   | *(literal)* 100        | 100          |
| `Revenue_Y1`   | Calculations | B3   | `=Units_Y1*Inp_Price`  | *(needs recalc)* |
| `Revenue_Y2`   | Calculations | C3   | `=Units_Y2*Inp_Price`  | *(needs recalc)* |

There is **no** aggregate "total revenue across all years" Named Range defined
in this model. The model tracks revenue per year (`Revenue_Y1`, `Revenue_Y2`),
not a cross-year total.

---

## Step 3 — Diagnosis and Suggested Alternatives

The requested name `Total_Revenue_All_Years` fails for two reasons:

1. **Naming mismatch.** The model uses the convention `Revenue_Y1`, `Revenue_Y2`
   (metric + year suffix), not a `Total_` prefix aggregation pattern.

2. **No cross-year aggregation exists.** The model computes a two-year P&L
   (Y1 and Y2) but does not define a Named Range that sums revenue across years.

### Suggested alternatives

| If the user wants...                     | Read this Named Range               |
| ---------------------------------------- | ----------------------------------- |
| Year 1 revenue                           | `Revenue_Y1`                        |
| Year 2 revenue                           | `Revenue_Y2`                        |
| Both years' revenue in one call          | `Revenue_Y1 Revenue_Y2`            |
| A cross-year total (does not yet exist)  | Create a new Named Range — see below |

### Creating a cross-year total (if needed)

To add a `Total_Revenue` Named Range that sums all years:

1. Add the formula `=Revenue_Y1+Revenue_Y2` to a cell (e.g., `Calculations!D3`).
2. Create the Named Range:
   ```bash
   uv run scripts/idfa_ops.py create-range ops_test_model.xlsx Total_Revenue Calculations D3
   ```
3. Recalculate, then read:
   ```bash
   uv run scripts/recalc_bridge.py ops_test_model.xlsx
   uv run scripts/idfa_ops.py read ops_test_model.xlsx Total_Revenue
   ```

---

## Full Model Named Range Inventory

For reference, all 20 Named Ranges in the model:

**Assumptions layer (6 inputs):**
- `Inp_Price` = 100
- `Inp_Units_Y1` = 50,000
- `Inp_Units_Growth` = 0.15 (15%)
- `Inp_Variable_Cost_Per_Unit` = 40
- `Inp_Fixed_Costs` = 1,000,000
- `Inp_Tax_Rate` = 0.30 (30%)

**Calculations layer (14 formulas):**
- `Units_Y1`, `Units_Y2`
- `Revenue_Y1`, `Revenue_Y2`
- `Variable_Costs_Y1`, `Variable_Costs_Y2`
- `Contribution_Y1`, `Contribution_Y2`
- `EBIT_Y1`, `EBIT_Y2`
- `Tax_Y1`, `Tax_Y2`
- `Net_Income_Y1`, `Net_Income_Y2`

---

## Conclusion

The skill's error handling worked as designed:

1. `read` returned a clear JSON error with exit code 1.
2. `inspect` revealed the full model structure, making it straightforward to
   identify that `Total_Revenue_All_Years` does not exist and to find the
   correct alternatives (`Revenue_Y1`, `Revenue_Y2`).
3. The agent can recover programmatically — no manual Excel inspection required.
