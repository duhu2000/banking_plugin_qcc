# Error Handling Results: Bad Named Range Request

**Task:** Read the value of `Total_Revenue_All_Years` from the model.
**Model file:** `ops_test_model.xlsx`
**Date:** 2026-03-11

---

## 1. Initial Read Attempt

**Command:**
```bash
uv run scripts/idfa_ops.py read ops_test_model.xlsx Total_Revenue_All_Years
```

**Result:**
```json
{"error": "Named Range not found: Total_Revenue_All_Years"}
```

**Exit code:** 1

The named range `Total_Revenue_All_Years` does not exist in this model.

---

## 2. Recovery: Model Inspection

Per SKILL.md error handling protocol ("Named Range not found -> Inspect model to
find correct name"), the model was inspected to identify all available named ranges.

**Command:**
```bash
uv run scripts/idfa_ops.py inspect ops_test_model.xlsx
```

**Result:** 20 named ranges found. Full inventory below.

### All Named Ranges in Model

| Name | Sheet | Cell | Type | Formula |
|------|-------|------|------|---------|
| Inp_Price | Assumptions | B2 | Input | -- (value: 100) |
| Inp_Units_Y1 | Assumptions | B3 | Input | -- (value: 50000) |
| Inp_Units_Growth | Assumptions | B4 | Input | -- (value: 0.15) |
| Inp_Variable_Cost_Per_Unit | Assumptions | B5 | Input | -- (value: 40) |
| Inp_Fixed_Costs | Assumptions | B6 | Input | -- (value: 1000000) |
| Inp_Tax_Rate | Assumptions | B7 | Input | -- (value: 0.3) |
| Units_Y1 | Calculations | B2 | Calc | `=Inp_Units_Y1` |
| Units_Y2 | Calculations | C2 | Calc | `=Units_Y1*(1+Inp_Units_Growth)` |
| Revenue_Y1 | Calculations | B3 | Calc | `=Units_Y1*Inp_Price` |
| Revenue_Y2 | Calculations | C3 | Calc | `=Units_Y2*Inp_Price` |
| Variable_Costs_Y1 | Calculations | B4 | Calc | `=Units_Y1*Inp_Variable_Cost_Per_Unit` |
| Variable_Costs_Y2 | Calculations | C4 | Calc | `=Units_Y2*Inp_Variable_Cost_Per_Unit` |
| Contribution_Y1 | Calculations | B5 | Calc | `=Revenue_Y1-Variable_Costs_Y1` |
| Contribution_Y2 | Calculations | C5 | Calc | `=Revenue_Y2-Variable_Costs_Y2` |
| EBIT_Y1 | Calculations | B6 | Calc | `=Contribution_Y1-Inp_Fixed_Costs` |
| EBIT_Y2 | Calculations | C6 | Calc | `=Contribution_Y2-Inp_Fixed_Costs` |
| Tax_Y1 | Calculations | B7 | Calc | `=EBIT_Y1*Inp_Tax_Rate` |
| Tax_Y2 | Calculations | C7 | Calc | `=EBIT_Y2*Inp_Tax_Rate` |
| Net_Income_Y1 | Calculations | B8 | Calc | `=EBIT_Y1-Tax_Y1` |
| Net_Income_Y2 | Calculations | C8 | Calc | `=EBIT_Y2-Tax_Y2` |

---

## 3. Suggested Alternatives

The name `Total_Revenue_All_Years` does not exist. The closest matches are:

| Suggested Name | Why It Matches | Formula |
|----------------|---------------|---------|
| **Revenue_Y1** | Year 1 revenue | `=Units_Y1*Inp_Price` |
| **Revenue_Y2** | Year 2 revenue | `=Units_Y2*Inp_Price` |

To get total revenue across all years, the user could:

1. **Read both revenue ranges individually:**
   ```bash
   uv run scripts/idfa_ops.py read model.xlsx Revenue_Y1 Revenue_Y2
   ```
   Then sum externally or create a new aggregation named range.

2. **Create a new named range** for the total (IDFA-compliant approach):
   ```bash
   uv run scripts/idfa_ops.py create-range model.xlsx Total_Revenue Calculations D3
   ```
   Then add the formula `=Revenue_Y1+Revenue_Y2` in cell D3 of the Calculations sheet.

**Note:** Revenue values are currently `null` (cached values not populated). A
LibreOffice recalculation via `recalc_bridge.py` is required before reading
calculated values.

---

## 4. Summary

| Step | Action | Outcome |
|------|--------|---------|
| 1 | Read `Total_Revenue_All_Years` | Error: Named Range not found (exit code 1) |
| 2 | Inspect model | Found 20 named ranges; no match for requested name |
| 3 | Identify alternatives | `Revenue_Y1` and `Revenue_Y2` are the closest matches |

**Methodology:** All values obtained via idfa_ops.py read and inspect commands.
No values were computed by the agent.
