# 🏦 Banking Domain Agents + 企查查MCP增强版

[![MCP](https://img.shields.io/badge/MCP-Compatible-green)](https://github.com/modelcontextprotocol)
[![QCC](https://img.shields.io/badge/企查查-数据底座-blue)](https://www.qcc.com)

> 基于 [Panaversity AgentFactory Business Plugins](https://github.com/panaversity/agentfactory-business-plugins) 银行业务插件集，**零代码改动**集成企查查MCP服务，为金融机构提供智能化、自动化的中国企业尽职调查解决方案。

**原仓库版本**: Jurisdiction-aware banking regulatory agent (v2.0.0) with 17 skills (1 router + 16 products), 7 jurisdiction overlays, 4 commands, hooks, and eval harness covering IFRS 9 ECL, Basel III/IV capital and liquidity, AML/KYC/sanctions compliance, and bank reconciliation across UK, EU, US, Australia, Singapore, UAE, and Pakistan.

---

## 🎯 核心价值

```
+------------------------------------------------------------------+
|                                                                  |
|    Original Banking Skills + QCC MCP (China Data Foundation)     |
|                                                                  |
|    +----------------------+      MCP       +------------------+  |
|    | aml-cdd-edd          |  ◄──────────►  | qcc-company      |  |
|    | sanctions-screening  |    Auto-Route  | qcc-risk         |  |
|    | kyc-risk-rating      |                | qcc-ipr          |  |
|    | basel-rwa-credit     |                | qcc-operation    |  |
|    | ifrs9-ecl            |                +------------------+  |
|    | ifrs9-staging        |                                      |
|    | ... (11 more skills) |                                      |
|    +----------------------+                                      |
|                                                                  |
|    ✅ Zero Code Change: Use original skills as-is                |
|    ✅ Plug & Play: Config MCP to auto-connect QCC data           |
|    ✅ Smart Enhancement: AML/KYC/Credit Risk auto-fetch data     |
|                                                                  |
+------------------------------------------------------------------+
```

---

## 🚀 快速开始

### 1. 克隆本仓库

```bash
git clone https://github.com/duhu2000/banking_plugin_qcc.git
cd banking_plugin_qcc
```

### 2. 设置环境变量

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

### 场景1：AML客户尽职调查（CDD/EDD）

**使用Command**: `/banking-aml`

**使用SKILL**: `aml-cdd-edd`

适用于：客户开户尽职调查、增强尽职调查（EDD）、政治公众人物（PEP）识别、受益所有人（UBO）穿透、企业股权结构分析

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
    GOVERNING STANDARD: FATF Recommendation 10 (CDD), 12 (PEPs)
    DOMAIN: AML/KYC -- Customer Due Diligence
    JURISDICTION: China -- PBOC / CBIRC / CSRC

    【企查查数据核验】
    ✅ 企业工商信息：企查查科技股份有限公司
    ✅ 统一社会信用代码：91320XXXXXXXXXXXX
    ✅ 注册资本：10000万人民币（实缴）
    ✅ 成立日期：2014年
    ✅ 法定代表人：XXX
    ✅ 股权穿透：识别受益所有人（股东A 35%、股东B 25%）
    ✅ 无经营异常记录
    ⚠️  历史变更记录：X条
    ✅ 无司法风险记录
```

---

### 场景2：制裁名单筛查 + 中国企业

**使用SKILL**: `sanctions-screening`

适用于：OFAC/SDN名单筛查、OFSI/EU/UN制裁名单检查、50%所有权规则审查、中国企业及关联方全面筛查

```
📝 用户输入：
"请对以下中国企业进行制裁名单筛查：企查查科技股份有限公司"

⚡ 自动执行：
├── SKILL：OFAC、OFSI、EU、UN制裁名单筛查
├── 企查查MCP增强：
│   ├── qcc-company: 查询企业工商信息（注册号、地址）
│   ├── qcc-company: 股权穿透（50%规则所有权检查）
│   └── qcc-company: 识别关联实体（法人、股东、高管）
└── 综合筛查报告

📄 输出结果：
    GOVERNING STANDARD: OFAC (USA), OFSI/HMT (UK), EU CFSP, UN Security Council
    DOMAIN: Sanctions Screening -- Entity and Associated Parties
    JURISDICTION: Multi-jurisdictional (Primary: China)

    【企查查数据 -- 50%规则检查】
    ✅ 主实体：企查查科技股份有限公司
    ✅ 股权穿透：第一层股东
       - 股东A（自然人）：35%
       - 股东B（自然人）：25%
       - 股东C（法人）：20%
    ✅ 无单一股东≥50%，无SDN关联
    ✅ 法定代表人：XXX（无制裁记录）

    【制裁名单筛查】
    ✅ OFAC SDN List：CLEAR
    ✅ OFSI/HMT：CLEAR
    ✅ EU Sanctions：CLEAR
    ✅ UN Consolidated：CLEAR
    ✅ 50% Rule：PASS

    结论：CLEAR — 可以准入
```

---

### 场景3：KYC风险评级

**使用SKILL**: `kyc-risk-rating`

适用于：客户风险分类、四维度风险评分（客户类型/地理/产品/行为）、高风险客户识别、定期风险评估

```
📝 用户输入：
"请对企查查科技股份有限公司进行KYC风险评级，
客户类型：私营企业，申请开立基本存款账户"

⚡ 自动执行：
├── SKILL：kyc-risk-rating 启动四维度风险评估
├── 企查查MCP增强：
│   ├── qcc-company: 企业类型、注册资本、股东结构
│   ├── qcc-operation: 所属行业、资质证书
│   └── qcc-risk: 风险信号扫描（经营异常、司法风险）
└── 生成KYC风险评级报告

📄 输出结果：
    GOVERNING STANDARD: FATF Recommendation 1 (Risk-Based Approach)
    DOMAIN: KYC Risk Rating
    JURISDICTION: China

    【企查查数据 -- 四维度评估】
    客户类型：     2 — 上市公司（企查查数据显示）
    地理：         1 — 中国（FATF成员）
    产品/服务：    3 — 企业活期账户
    行为：         3 — 新客户

    综合评分：      2.15
    整体评级：      Medium（中等风险）
    CDD级别：       Standard CDD（标准尽职调查）
    监控频率：      Every 3 years

    【风险信号扫描】
    ✅ 无经营异常
    ✅ 无司法诉讼
    ✅ 无行政处罚
    ✅ 无负面舆情
```

---

### 场景4：信用风险RWA计算（中国企业交易对手）

**使用SKILL**: `basel-rwa-credit`

适用于：信用风险RWA标准法计算、企业敞口风险权重评估、交易对手信用风险分析

```
📝 用户输入：
"请计算对中国企业XXX科技有限公司的信用风险RWA，
敞口金额1000万人民币，贷款期限3年"

⚡ 自动执行：
├── SKILL：basel-rwa-credit 标准法计算
├── 企查查MCP增强：
│   ├── qcc-company: 企业信用状况（注册资本、实缴情况）
│   ├── qcc-operation: 经营活跃度、中标记录
│   └── qcc-risk: 失信记录、被执行记录
└── 生成RWA计算报告

📄 输出结果：
    GOVERNING STANDARD: Basel III Standardised Approach for Credit Risk
    DOMAIN: Credit Risk RWA
    JURISDICTION: China

    【企查查数据 -- 信用评估】
    交易对手：XXX科技有限公司
    注册资本：5000万人民币（实缴100%）
    成立年限：8年
    信用评级：A级（企查查）
    ✅ 无失信记录
    ✅ 无被执行记录
    ⚠️  历史行政处罚：1条（已说明）

    【RWA计算】
    敞口类别：企业敞口
    基础风险权重（未评级）：100%
    企查查信用调整：-10%
    调整后风险权重：90%

    EAD：           10,000,000 CNY
    Risk Weight：   90%
    RWA：           9,000,000 CNY
    Minimum Capital (8%)：720,000 CNY
```

---

### 场景5：IFRS 9预期信用损失（ECL）

**使用SKILL**: `ifrs9-ecl`

适用于：预期信用损失计算、PD/LGD/EAD参数估计、情景加权ECL、中国企业客户减值准备

```
📝 用户输入：
"请计算对XXX科技有限公司贷款组合的IFRS 9 ECL，
账面总额1000万人民币，当前 Stage 1"

⚡ 自动执行：
├── SKILL：ifrs9-ecl ECL计算
├── 企查查MCP增强：
│   ├── qcc-risk: 企业风险信号（失信、被执行、经营异常）
│   ├── qcc-company: 企业经营状态、股权冻结
│   └── qcc-operation: 行业景气度、经营趋势
└── 生成ECL计算报告

📄 输出结果：
    GOVERNING STANDARD: IFRS 9 Financial Instruments
    DOMAIN: Expected Credit Loss (ECL)
    JURISDICTION: China

    【企查查数据 -- 信用风险参数】
    客户：XXX科技有限公司

    风险信号扫描：
    ✅ 无失信记录
    ✅ 无被执行记录
    ⚠️  经营异常记录：1条（已移除）
    ✅ 无股权冻结
    ✅ 经营状态：正常

    PD调整：
    基础PD（TTC）：2.5%
    企查查风险调整：+0.3%
    调整后PIT PD：2.8%

    【ECL计算】
    账面总额：        10,000,000 CNY
    Stage：           Stage 1
    PD（12-month）：  2.8%
    LGD：             45%
    EAD：             10,000,000 CNY

    情景加权ECL：
    基础(40%)：       126,000 CNY
    上行(15%)：       90,000 CNY
    下行(30%)：       168,000 CNY
    严重(15%)：       252,000 CNY

    加权ECL：         147,000 CNY
```

---

### 场景6：IFRS 9阶段划分（SICR评估）

**使用SKILL**: `ifrs9-staging`

适用于：信用风险显著增加（SICR）判断、阶段迁移评估、第三阶段违约识别、定性/定量触发因素分析

```
📝 用户输入：
"请评估XXX科技有限公司贷款的阶段划分，
当前Stage 1，最近发现企业有1条经营异常记录"

⚡ 自动执行：
├── SKILL：ifrs9-staging SICR评估
├── 企查查MCP增强：
│   ├── qcc-risk: 实时风险信号（经营异常、司法诉讼、行政处罚）
│   ├── qcc-company: 企业工商变更、股权冻结
│   └── qcc-operation: 行业景气度、关联风险
└── 生成阶段评估报告

📄 输出结果：
    GOVERNING STANDARD: IFRS 9.5.5 Impairment
    DOMAIN: Staging Assessment (SICR)
    JURISDICTION: China

    【企查查数据 -- 风险信号扫描】
    客户：XXX科技有限公司
    当前阶段：Stage 1
    提议阶段：Stage 1（维持）

    定量触发因素：
    ✅ 无逾期记录
    ✅ 内部评级未下调
    ✅ 生命周期PD未超过阈值

    定性触发因素：
    ⚠️  经营异常记录：1条（地址变更未及时备案）
    ✅ 无司法诉讼
    ✅ 无行政处罚
    ✅ 无行业系统性风险
    ✅ 无关联风险传导

    【专业判断】
    经营异常记录为地址变更备案延迟，
    已及时整改移除，不构成实质性SICR。

    ECL影响：
    维持12-month ECL
    继续监控
```

---

## 📚 包含的17个SKILL（原汁原味）

### 🔥 企查查MCP增强版（6个核心SKILL）

| 分类 | SKILL | 功能描述 | 企查查MCP增强场景 |
|------|-------|----------|-------------------|
| **AML** | `aml-cdd-edd` | CDD/EDD尽职调查 | ✅ **工商登记+18类风险扫描** |
| **AML** | `sanctions-screening` | OFAC/OFSI/EU制裁筛查 | ✅ **50%规则+股权穿透** |
| **KYC** | `kyc-risk-rating` | 4维度KYC风险评级 | ✅ **企业类型+风险信号** |
| **Basel** | `basel-rwa-credit` | 信用风险RWA | ✅ **企业信用+交易对手风险** |
| **IFRS 9** | `ifrs9-ecl` | 预期信用损失 | ✅ **PD/LGD参数+风险预警** |
| **IFRS 9** | `ifrs9-staging` | Stage 1/2/3评估 | ✅ **SICR判断+经营状态** |

### 📖 其他11个专业SKILL

| 分类 | SKILL | 功能描述 |
|------|-------|----------|
| **Router** | `banking-global-router` | 智能路由到产品+司法管辖区 |
| **IFRS 9** | `ifrs9-scenarios` | 宏观经济情景 |
| **IFRS 9** | `ifrs9-disclosure` | IFRS 7披露起草 |
| **Basel** | `basel-capital` | 资本充足率 |
| **Basel** | `basel-rwa-market` | 市场风险RWA (FRTB) |
| **Liquidity** | `liquidity-lcr` | 流动性覆盖率 |
| **Liquidity** | `liquidity-nsfr` | 净稳定资金比率 |
| **Stress** | `stress-testing` | ICAAP压力测试 |
| **AML** | `aml-typologies` | 20种AML可疑类型识别 |
| **AML** | `aml-sar-drafting` | SAR/STR报告起草 |
| **Recon** | `bank-reconciliation` | 银行对账 |

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
