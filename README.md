# 🏦 Banking Domain Agents + 企查查MCP增强版

[![MCP](https://img.shields.io/badge/MCP-Compatible-green)](https://github.com/modelcontextprotocol)
[![QCC](https://img.shields.io/badge/企查查-数据底座-blue)](https://www.qcc.com)

> 基于 [Panaversity AgentFactory Business Plugins](https://github.com/panaversity/agentfactory-business-plugins) 银行业务插件集，**零代码改动**集成企查查MCP服务，为金融机构提供智能化、自动化的中国企业尽职调查解决方案。

**原仓库版本**: Jurisdiction-aware banking regulatory agent (v2.0.0) with 17 skills (1 router + 16 products), 7 jurisdiction overlays, 4 commands, hooks, and eval harness covering IFRS 9 ECL, Basel III/IV capital and liquidity, AML/KYC/sanctions compliance, and bank reconciliation across UK, EU, US, Australia, Singapore, UAE, and Pakistan.

---

## 🎯 核心价值

```
┌─────────────────────────────────────────────────────────────────┐
│                                                                 │
│   原作者专业银行监管SKILL  +  企查查MCP（中国企业数据底座）     │
│                                                                 │
│   ┌──────────────────────────┐     MCP协议       ┌─────────────┐│
│   │ aml-cdd-edd              │ ◄────────────────►│ qcc-company ││
│   │ kyc-risk-rating          │     智能匹配      │ qcc-risk    ││
│   │ sanctions-screening      │                   │ qcc-ipr     ││
│   │ aml-typologies           │                   │qcc-operation││
│   │ aml-sar-drafting         │                   └─────────────┘│
│   │ ... (17个专业SKILL)      │                                  │
│   └──────────────────────────┘                                  │
│                                                                 │
│   ✅ 零代码改动：原汁原味使用原作者专业银行监管SKILL            │
│   ✅ 即插即用：配置MCP即可自动调用企查查中国企业数据            │
│   ✅ 智能增强：AML/KYC/制裁筛查自动获取中国企业工商、风险数据   │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

---

## 🚀 快速开始

### 1. 克隆本仓库

```bash
git clone https://github.com/duhu2000/banking_plugin_qcc.git
cd banking_plugin_qcc
```

### 2. 配置企查查MCP

`.mcp.json` 已包含在仓库中：

```json
{
  "mcpServers": {
    "qcc-company": {
      "url": "https://agent.qcc.com/mcp/company/stream",
      "headers": {
        "Authorization": "Bearer ${QCC_MCP_API_KEY}"
      },
      "description": "企查查企业基座 - 提供工商登记、股东信息、变更记录等企业基础信息服务"
    },
    "qcc-risk": {
      "url": "https://agent.qcc.com/mcp/risk/stream",
      "headers": {
        "Authorization": "Bearer ${QCC_MCP_API_KEY}"
      },
      "description": "企查查风控大脑 - 提供失信、被执行、限高、破产等18类风险信息"
    },
    "qcc-ipr": {
      "url": "https://agent.qcc.com/mcp/ipr/stream",
      "headers": {
        "Authorization": "Bearer ${QCC_MCP_API_KEY}"
      },
      "description": "企查查知产引擎 - 提供专利、商标、软件著作权等知识产权信息"
    },
    "qcc-operation": {
      "url": "https://agent.qcc.com/mcp/operation/stream",
      "headers": {
        "Authorization": "Bearer ${QCC_MCP_API_KEY}"
      },
      "description": "企查查经营罗盘 - 提供招投标、资质证书、信用评级等经营信息"
    }
  }
}
```

### 3. 设置环境变量

```bash
export QCC_MCP_API_KEY="your_api_key_here"

# 验证配置
source ./setup-qcc-env.sh  # macOS/Linux
# 或 .\setup-qcc-env.ps1   # Windows
```

从 [企查查智能体数据平台](https://agent.qcc.com) 申请API Key。

### 4. 启动Claude Code

```bash
claude --plugin-dir .
```

### 5. 体验SKILL

详见 [QUICKSTART.md](./QUICKSTART.md)

---

## 📦 与原仓库的关系

| 项目 | 说明 |
|------|------|
| **原仓库** | [panaversity/agentfactory-business-plugins](https://github.com/panaversity/agentfactory-business-plugins) |
| **提取目录** | `banking/` 子目录 |
| **本仓库原则** | **零侵入**：不修改任何原作者SKILL代码 |
| **增强方式** | 仅通过 `.mcp.json` 配置企查查MCP服务 |
| **同步更新** | 可直接同步上游仓库更新，无代码冲突 |

---

## 🎬 典型应用场景（企查查MCP增强）

### 场景1：KYB企业开户尽职调查

**使用Command**: `/banking-aml`

**使用SKILL**: `aml-cdd-edd` + `kyc-risk-rating`

```
📝 用户输入：
"有个客户来开户，请帮我做客户尽职调查（CDD），
客户名称：企查查科技股份有限公司"

⚡ 自动执行：
├── 原作者SKILL：aml-cdd-edd 启动CDD流程
├── 企查查MCP自动匹配调用：
│   ├── qcc-company: 工商登记信息核验
│   ├── qcc-company: 股权穿透识别受益所有人
│   └── qcc-risk: 18类风险信号扫描
└── 生成标准化CDD报告（含企查查数据）

📄 输出结果：
    ✅ 企业基础信息：统一社会信用代码、注册资本、法定代表人
    ✅ 股权结构：自动识别受益所有人（UBO）
    ⚠️  风险提示：X条历史变更记录
    ✅ 无经营异常/司法风险/行政处罚
    ✅ KYC风险评级：Medium（标准CDD）
```

### 场景2：制裁名单筛查 + 中国企业

**使用SKILL**: `sanctions-screening`

```
📝 用户输入：
"请对以下中国企业进行制裁名单筛查：企查查科技股份有限公司"

⚡ 自动执行：
├── SKILL：OFAC、OFSI、EU、UN制裁名单筛查
├── 企查查MCP增强：
│   ├── 查询企业工商信息（注册号、地址）
│   ├── 股权穿透（50%规则所有权检查）
│   └── 识别关联实体（法人、股东、高管）
└── 综合筛查报告

📄 输出结果：
    ✅ 主实体：未出现在制裁名单
    ✅ 受益所有人：无制裁记录
    ✅ 50%规则：上层股东无SDN
    ✅ 结论：CLEAR，可准入
```

### 场景3：AML交易监控与SAR报告

**使用Command**: `/banking-aml`

**使用SKILL**: `aml-typologies` + `aml-sar-drafting`

```
📝 用户输入：
"/banking-aml cn '现金交易异常：某中国客户连续多日大额取现'

⚡ 自动执行：
├── SKILL：识别可疑交易类型（20种AML typologies）
├── 企查查MCP：查询客户企业背景
│   ├── 企业经营状况
│   ├── 历史风险记录
│   └── 关联企业分析
└── SAR可疑交易报告生成
```

---

## 📚 包含的17个SKILL（原汁原味）

| 分类 | SKILL | 功能描述 | 企查查MCP增强场景 |
|------|-------|----------|-------------------|
| **Router** | `banking-global-router` | 智能路由到产品+司法管辖区 | - |
| **IFRS 9** | `ifrs9-ecl` | 预期信用损失计算 | 中国企业客户信用数据 |
| **IFRS 9** | `ifrs9-staging` | Stage 1/2/3评估 | 中国企业经营状态 |
| **IFRS 9** | `ifrs9-scenarios` | 宏观经济情景 | - |
| **IFRS 9** | `ifrs9-disclosure` | IFRS 7披露起草 | - |
| **Basel** | `basel-capital` | 资本充足率 | - |
| **Basel** | `basel-rwa-credit` | 信用风险RWA | 中国企业交易对手风险 |
| **Basel** | `basel-rwa-market` | 市场风险RWA (FRTB) | - |
| **Liquidity** | `liquidity-lcr` | 流动性覆盖率 | - |
| **Liquidity** | `liquidity-nsfr` | 净稳定资金比率 | - |
| **Stress** | `stress-testing` | ICAAP压力测试 | - |
| **AML** | `aml-typologies` | 20种AML可疑类型识别 | 中国企业背景核查 |
| **AML** | `aml-sar-drafting` | SAR/STR报告起草 | 中国企业关联信息 |
| **AML** | `aml-cdd-edd` | CDD/EDD尽职调查 | ✅ **企业工商+风险扫描** |
| **AML** | `sanctions-screening` | OFAC/OFSI/EU制裁筛查 | ✅ **中国企业+50%规则** |
| **KYC** | `kyc-risk-rating` | 4维度KYC风险评级 | ✅ **企业类型+股权穿透** |
| **Recon** | `bank-reconciliation` | 银行对账 | - |

---

## 🌍 司法管辖区支持

| 司法管辖区 | 覆盖 | 主要监管机构 | 企查查MCP增强 |
|------------|------|--------------|---------------|
| UK | ✅ | PRA, FCA | - |
| EU | ✅ | ECB, EBA | - |
| USA | ✅ | Fed, OCC, OFAC | - |
| Australia | ✅ | APRA, AUSTRAC | - |
| Singapore | ✅ | MAS | - |
| UAE | ✅ | CBUAE, DFSA | - |
| Pakistan | ✅ | SBP | - |
| **China** | ✅ **新增MCP支持** | PBOC, CBIRC, CSRC | **✅ 全量企查查数据** |

---

## 🛡️ 安全与合规

- **数据安全**：企查查MCP采用HTTPS加密传输，API Key通过环境变量管理
- **代码安全**：零代码改动，保持原作者SKILL的原生安全性
- **授权访问**：需要有效的企查查智能体数据平台账号和API Key
- **合规使用**：遵守《个人信息保护法》《数据安全法》《反洗钱法》等相关法规
- **审计追溯**：所有MCP调用可追溯，支持合规审计

---

## 📖 文档索引

| 文档 | 说明 |
|------|------|
| [QUICKSTART.md](./QUICKSTART.md) | 5分钟快速体验指南，包含真实企查查MCP调用示例 |
| [CLAUDE.md](./CLAUDE.md) | 原作者Agent指令（未修改） |
| `skills/*/SKILL.md` | 各SKILL详细说明 |
| `commands/*.md` | 4个Slash Command使用说明 |
| `setup-qcc-env.sh` | 环境变量配置脚本 |

---

## 🤝 致谢

- 本仓库基于 [Panaversity AgentFactory Business Plugins](https://github.com/panaversity/agentfactory-business-plugins) 构建
- 感谢原作者提供的专业银行监管SKILL
- 企查查智能体数据平台：https://agent.qcc.com
- Email: duhu@qcc.com

---

## 📄 许可证

与原仓库保持一致：Apache-2.0

---

## 💬 问题反馈

- 原作者SKILL问题：[panaversity/agentfactory-business-plugins](https://github.com/panaversity/agentfactory-business-plugins/issues)
- 本仓库MCP配置问题：[duhu2000/banking_plugin_qcc](https://github.com/duhu2000/banking_plugin_qcc/issues)

---

## 💡 使用提示

> **重要**：本插件的SKILL代码完全来自原作者，未做任何修改。企查查MCP的调用是通过 **Claude Code的智能工具匹配机制** 自动完成的——当SKILL需要"企业信息查询"时，系统会自动匹配到配置的 `qcc-company` 等MCP服务。
>
> 这种"配置驱动"的架构让您可以：
> - ✅ **零代码改动**使用专业银行监管SKILL
> - ✅ **灵活切换数据源**（企查查 / 其他数据源）
> - ✅ **保持与上游仓库同步更新**，无代码冲突
