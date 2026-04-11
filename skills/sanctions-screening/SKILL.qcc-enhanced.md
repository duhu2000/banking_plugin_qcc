---
name: sanctions-screening-qcc
description: >
  Activate for: sanctions, OFAC, HMT, SDN list, EU sanctions, UN sanctions,
  sanctioned entity, sanctions screening, false positive, name match,
  OFSI, consolidated list, sanctions breach, SWIFT screening, payments screening,
  sanctions compliance, derisking, Chinese entity sanctions screening.

  **QCC MCP Enhanced**: Validates Chinese entity ownership structures against
  sanctions lists. Automatically checks beneficial owners and actual controllers
  of Chinese corporate customers.

  NOT for: AML transaction monitoring or typology assessment (use aml-typologies),
  KYC customer onboarding CDD/EDD (use aml-cdd-edd), SAR drafting (use aml-sar-drafting).
license: Apache-2.0
metadata:
  version: "2.0"
  author: "Panaversity — The AI Agent Factory (Enhanced with QCC MCP)"
  standard: "OFAC (USA), OFSI/HMT (UK), EU CFSP, UN Security Council Resolutions"
  mcp-integrations: "QCC MCP (Company)"
---

## MCP Configuration Requirements

**⚠️ Important: For Chinese entity sanctions screening, QCC MCP is required**

```bash
# ~/.claude/.mcp.json
{
  "mcpServers": {
    "qcc-company": {
      "url": "https://agent.qcc.com/mcp/company/stream",
      "headers": { "Authorization": "Bearer ${QCC_MCP_API_KEY}" }
    }
  }
}
```

---

## MAJOR SANCTIONS REGIMES

| Authority                  | Scope                                              | Key Lists                                                     |
| -------------------------- | -------------------------------------------------- | ------------------------------------------------------------- |
| OFAC (USA)                 | Extraterritorial (USD transactions globally)       | SDN List; Consolidated Sanctions List; OFAC Country Sanctions |
| OFSI / HMT (UK)            | UK persons, UK-incorporated entities, UK territory | UK Consolidated Sanctions List                                |
| EU Council                 | EU persons, EU-incorporated entities, EU territory | EU Sanctions Map (CFSP)                                       |
| UN Security Council        | All UN member states                               | UN Consolidated List                                          |

---

## QCC ENHANCEMENT — CHINESE ENTITY SANCTIONS SCREENING

### The 50% Rule for Chinese Entities

Before clearing a Chinese corporate counterparty:

1. **Ownership Structure Retrieval (qcc-company)**
   - Retrieve complete shareholder structure
   - Identify beneficial owners (>25% direct/indirect)
   - Identify actual controllers
   - Trace ownership through corporate layers

2. **Sanctions Screening Workflow**
   ```
   Screen entity name -> If clear, proceed to step 2
   Retrieve QCC shareholder data -> Screen each beneficial owner
   Retrieve QCC controller data -> Screen actual controllers
   Check for sanctioned entities in ownership chain
   ```

3. **Enhanced Due Diligence for Complex Structures**
   - Offshore holding companies (Cayman, BVI)
   - Multiple layer ownership structures
   - Nominee arrangements
   - VIE structures (Variable Interest Entities)

### QCC Sanctions Screening Output

```
================================================================
CHINESE ENTITY SANCTIONS SCREENING — QCC Enhanced
================================================================
Entity Name:         [Name]
Unified Credit Code: [Code]
Screening Date:      [YYYY-MM-DD]
----------------------------------------------------------------
ENTITY LEVEL SCREENING:
  OFAC SDN:          [Clear/Match]
  OFSI/HMT:          [Clear/Match]
  EU Sanctions:      [Clear/Match]
  UN Consolidated:   [Clear/Match]

BENEFICIAL OWNERSHIP (QCC Data):
  [Shareholder 1]:   [Name] - [XX]%
    ├─ OFAC SDN:     [Clear/Match]
    ├─ OFSI/HMT:     [Clear/Match]
    └─ EU/UN:        [Clear/Match]

  [Actual Controller]: [Name]
    ├─ OFAC SDN:     [Clear/Match]
    ├─ OFSI/HMT:     [Clear/Match]
    └─ EU/UN:        [Clear/Match]

50% RULE ANALYSIS:
  Sanctioned ownership: [X]% aggregate
  Result:               [Clear/Blocked - Sanctioned Entity]

SCREENING OUTCOME:
  [CLEARED / ESCALATE TO SANCTIONS OFFICER]
================================================================
```

---

## OFAC SDN LIST — CRITICAL RULES

- "50% Rule": Entity owned 50%+ by an SDN is treated as SDN
- This rule requires looking through corporate structures
- **For Chinese entities: Use QCC to retrieve ownership structure for 50% rule analysis**

## SCREENING PROCESS

### What Must Be Screened

- Customers (at onboarding and periodically)
- Beneficial owners and directors
- All payment counterparties
- Correspondent banks
- Trade finance counterparties

### Screening Methodology

1. Name screening against all applicable lists
2. Fuzzy matching (typos, transliterations, Chinese names)
3. Date of birth, nationality if available
4. Entity: registration number, jurisdiction
5. **For Chinese entities: QCC beneficial ownership data**

---

## NEVER DO THESE

- NEVER release a transaction without clearing a sanctions hit
- NEVER inform the customer about a sanctions screening
- NEVER rely solely on name matching without fuzzy-matching
- NEVER omit the 50% ownership rule analysis
- **FOR CHINESE ENTITIES: NEVER rely on customer-provided ownership data — verify through QCC**

---

ALL OUTPUTS REQUIRE REVIEW BY A QUALIFIED PROFESSIONAL BEFORE USE IN REGULATORY FILINGS OR BUSINESS DECISIONS.
