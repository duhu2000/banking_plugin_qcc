---
name: aml-cdd-edd-qcc
description: >
  Activate for: CDD, EDD, customer due diligence, enhanced due diligence,
  simplified due diligence, KYC, know your customer, customer onboarding,
  source of wealth, source of funds, PEP, politically exposed person,
  beneficial ownership, UBO, corporate structure, ongoing monitoring.

  **QCC MCP Enhanced**: Automatically retrieves Chinese enterprise registration
  data, beneficial ownership information, and risk signals for corporate customers
  registered in China. Validates beneficial ownership through official records.

  NOT for: personal finance advice or retail banking product recommendations,
  tax compliance or tax residency determinations, credit underwriting decisions.
license: Apache-2.0
metadata:
  version: "2.0"
  author: "Panaversity — The AI Agent Factory (Enhanced with QCC MCP)"
  standard: "FATF Recommendation 10 (CDD), 12 (PEPs), 13 (Correspondent Banking)"
  mcp-integrations: "QCC MCP (Company/Risk)"
---

## MCP Configuration Requirements

**⚠️ Important: Before using this skill for Chinese enterprises, ensure QCC MCP servers are configured**

```bash
# ~/.claude/.mcp.json
{
  "mcpServers": {
    "qcc-company": {
      "url": "https://agent.qcc.com/mcp/company/stream",
      "headers": { "Authorization": "Bearer ${QCC_MCP_API_KEY}" }
    },
    "qcc-risk": {
      "url": "https://agent.qcc.com/mcp/risk/stream",
      "headers": { "Authorization": "Bearer ${QCC_MCP_API_KEY}" }
    }
  }
}
```

---

## CUSTOMER DUE DILIGENCE (CDD) — STANDARD MEASURES

Required for all customers at account opening:

1. Identify the customer — obtain identifying information
2. Verify the customer's identity — using reliable, independent source documents
3. Identify the beneficial owner (BO) — persons owning or controlling ≥ 25% (or lower)
4. Verify the beneficial owner's identity
5. Understand the nature and purpose of the business relationship
6. Conduct ongoing monitoring of the relationship

---

## QCC MCP ENHANCEMENT — CHINESE ENTERPRISE CDD

### For Chinese Corporate Customers: Mandatory QCC Verification

**Phase 1: Company Registration Verification (qcc-company)**

1. **Business Registration Check**
   - Verify unified social credit code matches official records
   - Confirm company name, legal representative, registered address
   - Check business status (active/liquidated/revoked)
   - Verify registered capital and paid-in capital

2. **Business Scope Verification**
   - Validate declared business activities against registration
   - Identify any special licenses or permits required
   - Check for restrictions or prohibitions

**Phase 2: Beneficial Ownership Verification (qcc-company)**

3. **Shareholder Structure Analysis**
   - Retrieve complete shareholder register
   - Identify natural persons owning ≥25% (direct or indirect)
   - Calculate total ownership percentages
   - Identify actual controllers (if different from shareholders)

4. **Equity Stability Assessment**
   - Check for recent equity changes
   - Identify equity pledge or freeze records
   - Assess ownership concentration

**Phase 3: Risk Signal Scanning (qcc-risk)**

5. **Adverse Information Check**
   - Judicial cases (as defendant)
   - Court announcements
   - Judgment debtor records
   - Administrative penalties
   - Operating anomaly listings

### QCC CDD Output Format

```
================================================================
CHINESE ENTERPRISE CDD — QCC VERIFICATION REPORT
================================================================
Company Name:        [Name]
Unified Credit Code: [Code]
Query Date:          [YYYY-MM-DD]
Data Source:         QCC MCP (Company/Risk)
----------------------------------------------------------------
REGISTRATION STATUS:
  Legal Status:      [Active/Suspended/Liquidated]
  Legal Rep:         [Name]
  Registered Cap:    [Amount] ([Paid-in/Subscribed])
  Established:       [Date]

BENEFICIAL OWNERSHIP:
  [Shareholder 1]:   [Name] - [XX]% (Natural person/Entity)
  [Shareholder 2]:   [Name] - [XX]% (Natural person/Entity)
  Actual Controller: [Name] (if different)

RISK SIGNALS:
  Judicial Cases:    [Count] ([X] as defendant)
  Court Announces:   [Count]
  Dishonest Debtor:  [Yes/No]
  Admin Penalties:   [Count]
  Operating Anomaly: [Yes/No - Details]

CDD RECOMMENDATION:
  [Proceed/Enhanced Due Diligence/Decline]
================================================================
```

---

## INDIVIDUAL CUSTOMER IDENTITY VERIFICATION

Documents (in order of reliability):
- Tier 1 (highest): Passport; national ID card; government-issued photo ID
- Tier 2: Driving licence; residence permit
- Address verification: Utility bill, bank statement, government correspondence (must be dated within 3 months)
- For non-face-to-face onboarding: certified copies; electronic verification; video identification (where jurisdiction permits)

---

## CORPORATE CUSTOMER IDENTITY VERIFICATION — STANDARD

Company: Certificate of incorporation; memorandum and articles of association;
latest audited accounts; register of directors; register of shareholders

Beneficial owner: Identify all individuals owning or controlling ≥ 25%
(FATF threshold — some jurisdictions use lower: 10% in USA for certain entities)

Director verification: Verify identity of all directors with day-to-day control
Authorised signatories: Verify identity of all authorised signatories

**FOR CHINESE COMPANIES**: Use QCC MCP as primary source for:
- Register of shareholders
- Director information
- Company structure
- Verification of beneficial ownership

---

## POLITICALLY EXPOSED PERSONS (PEPs) — ENHANCED DUE DILIGENCE

### PEP Definition (FATF Recommendation 12)

Individuals entrusted with prominent public functions:
- Heads of state, heads of government, senior politicians
- Senior government officials, judicial or military officials
- Senior executives of state-owned enterprises
- Senior officials of political parties

### QCC PEP Enhancement

**For Chinese enterprises with SOE connections:**
- Check if legal representative or major shareholders hold government positions
- Identify connections to state-owned enterprises
- Assess level of government influence/control

---

## ENHANCED DUE DILIGENCE (EDD) — HIGH RISK CUSTOMERS

### Triggers for EDD

- PEP status (mandatory)
- High-risk jurisdiction (FATF grey/black list)
- Complex corporate structure
- Adverse media or negative information during screening
- **QCC triggers for Chinese enterprises:**
  - Judicial cases as defendant
  - Listed as dishonest judgment debtor
  - Administrative penalties in past 2 years
  - Equity freeze or pledge records
  - Operating anomaly status

### EDD Process

1. Gather more detailed information (source of wealth, source of funds, BO structure)
2. Verify information using independent sources (**QCC MCP for Chinese entities**)
3. Senior management sign-off
4. Enhanced ongoing monitoring
5. Annual EDD refresh (minimum)

---

## NEVER DO THESE

- NEVER approve SDD without a documented risk assessment
- NEVER accept "business income" as sufficient source of wealth evidence for PEPs
- NEVER onboard a customer when beneficial ownership cannot be established through the full corporate chain
- NEVER downgrade a PEP's risk status immediately upon leaving office
- NEVER treat CDD as a one-time onboarding event
- **FOR CHINESE ENTERPRISES: NEVER rely solely on customer-provided documents — verify against QCC official records**
- **FOR CHINESE ENTERPRISES: NEVER accept beneficial ownership declarations without QCC verification**

---

ALL OUTPUTS REQUIRE REVIEW BY A QUALIFIED PROFESSIONAL BEFORE USE IN REGULATORY FILINGS OR BUSINESS DECISIONS.
