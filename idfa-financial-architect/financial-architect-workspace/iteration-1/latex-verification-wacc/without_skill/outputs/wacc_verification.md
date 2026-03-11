# WACC Formula Verification

**Source file:** `legacy_model.xlsx` — Sheet: `Model`, Cell: `B16`

---

## 1. Spreadsheet Formula (B16)

```
=($B$10/$B$12)*$B$13 + ($B$11/$B$12)*$B$14*(1-$B$15)
```

Substituting cell references:

```
= (Equity / Total Capital) * Cost of Equity
  + (Debt / Total Capital) * Cost of Debt * (1 - Tax Rate)
```

## 2. Textbook WACC Formula

$$
\text{WACC} = \frac{E}{V} \cdot K_e \;+\; \frac{D}{V} \cdot K_d \cdot (1 - T)
$$

Where:
- $E$ = Market value of equity
- $D$ = Market value of debt
- $V = E + D$ = Total capital
- $K_e$ = Cost of equity
- $K_d$ = Cost of debt
- $T$ = Corporate tax rate

**Verdict: The spreadsheet formula structurally matches the standard after-tax WACC formula.**

---

## 3. Input Values

| Cell | Label           | Value        |
|------|-----------------|--------------|
| B10  | Equity          | 5,000,000    |
| B11  | Debt            | 3,000,000    |
| B12  | Total Capital   | 8,000,000    |
| B13  | Cost of Equity  | 12.00%       |
| B14  | Cost of Debt    | 6.00%        |
| B15  | Tax Rate        | 25.00%       |

### Input Consistency Check

- $E + D = 5{,}000{,}000 + 3{,}000{,}000 = 8{,}000{,}000 = V$ (B12). **Consistent.**

---

## 4. Step-by-Step Computation

### Capital Weights

$$
\frac{E}{V} = \frac{5{,}000{,}000}{8{,}000{,}000} = 0.625
$$

$$
\frac{D}{V} = \frac{3{,}000{,}000}{8{,}000{,}000} = 0.375
$$

Weights sum: $0.625 + 0.375 = 1.000$ **OK**

### Equity Component

$$
\frac{E}{V} \cdot K_e = 0.625 \times 0.12 = 0.075
$$

### After-Tax Cost of Debt

$$
K_d \cdot (1 - T) = 0.06 \times (1 - 0.25) = 0.06 \times 0.75 = 0.045
$$

### Debt Component

$$
\frac{D}{V} \cdot K_d \cdot (1 - T) = 0.375 \times 0.045 = 0.016875
$$

### Final WACC

$$
\text{WACC} = 0.075 + 0.016875 = 0.091875 = \boxed{9.1875\%}
$$

---

## 5. Verification Summary

| Check                                      | Result |
|--------------------------------------------|--------|
| Formula structure matches textbook WACC    | PASS   |
| Total Capital = Equity + Debt              | PASS   |
| Capital weights sum to 1.0                 | PASS   |
| Tax shield applied to debt only (correct)  | PASS   |
| Computed WACC = 9.1875%                    | PASS   |

**Overall: The WACC formula in B16 is mathematically correct.**

---

## 6. Notes

- The formula correctly applies the tax shield $(1 - T)$ to the debt component only, reflecting the tax deductibility of interest expense.
- All cell references use absolute addressing (`$B$10`, etc.), which is appropriate since these are fixed assumption inputs.
- The hardcoded `Total Capital = 8,000,000` in B12 is consistent with $E + D$ but is not formula-linked (it is a literal value, not `=B10+B11`). If equity or debt assumptions change, B12 must be updated manually. Consider replacing B12 with `=B10+B11` to prevent drift.
