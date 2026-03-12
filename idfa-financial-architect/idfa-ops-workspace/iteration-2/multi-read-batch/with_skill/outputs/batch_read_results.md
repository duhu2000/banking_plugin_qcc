# Year 1 P&L Snapshot

Source: `ops_test_model.xlsx`
Method: Batch read via `idfa_ops.py read` after LibreOffice recalculation

---

## Input Assumptions

| Assumption                | Named Range                | Value     |
| ------------------------- | -------------------------- | --------- |
| Price per unit            | `Inp_Price`                | 100       |
| Year 1 units              | `Inp_Units_Y1`             | 50,000    |
| Variable cost per unit    | `Inp_Variable_Cost_Per_Unit` | 40      |
| Fixed costs               | `Inp_Fixed_Costs`          | 1,000,000 |
| Tax rate                  | `Inp_Tax_Rate`             | 30%       |

---

## Year 1 Results

| Line Item        | Named Range          | Value         |
| ---------------- | -------------------- | ------------- |
| Units            | `Units_Y1`           | 50,000        |
| Revenue          | `Revenue_Y1`         | 5,000,000     |
| Variable Costs   | `Variable_Costs_Y1`  | (2,000,000)   |
| **Contribution** | `Contribution_Y1`    | **3,000,000** |
| Fixed Costs      | (from `Inp_Fixed_Costs`) | (1,000,000) |
| **EBIT**         | `EBIT_Y1`            | **2,000,000** |
| Tax              | `Tax_Y1`             | (600,000)     |
| **Net Income**   | `Net_Income_Y1`      | **1,400,000** |

---

## Command Log

```
uv run scripts/idfa_ops.py read ops_test_model.xlsx \
  Units_Y1 Revenue_Y1 Variable_Costs_Y1 Contribution_Y1 EBIT_Y1 Tax_Y1 Net_Income_Y1
```

**Raw JSON response:**

```json
{
  "status": "ok",
  "values": {
    "Units_Y1": 50000,
    "Revenue_Y1": 5000000,
    "Variable_Costs_Y1": 2000000,
    "Contribution_Y1": 3000000,
    "EBIT_Y1": 2000000,
    "Tax_Y1": 600000,
    "Net_Income_Y1": 1400000
  }
}
```

All values obtained via the write-recalculate-read pattern (recalculation step only; no assumptions were modified).
