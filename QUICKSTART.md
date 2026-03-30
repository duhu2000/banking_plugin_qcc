# 🚀 快速体验指南：银行监管插件 + 企查查MCP

本文档帮助您在5分钟内验证原作者的银行监管SKILL与企查查MCP的集成效果。

> **核心特点**：本仓库完全保持原作者SKILL代码不变，仅通过MCP配置实现中国企业数据的自动对接。

---

## ✅ 前置检查

### 1. 环境变量检查

```bash
# 检查环境变量是否已设置
echo $QCC_MCP_API_KEY

# 如果未设置，请执行
export QCC_MCP_API_KEY="your_api_key_here"
```

### 2. MCP配置检查

```bash
# 验证 .mcp.json 是否存在
cat .mcp.json
```

### 3. 运行配置验证脚本

```bash
# macOS/Linux
source ./setup-qcc-env.sh

# Windows PowerShell
.\setup-qcc-env.ps1
```

---

## 🎯 场景体验

本插件包含17个专业银行监管SKILL（1个路由器 + 16个产品SKILL），覆盖IFRS 9、Basel III/IV、AML/KYC、制裁筛查等领域。

以下场景展示**AML/KYC类SKILL**如何自动调用企查查MCP获取中国企业数据：

---

### 🏢 场景1：KYB企业开户风险评级

**使用Command**: `/banking-aml`

**使用SKILL**: `kyc-risk-rating` + `aml-cdd-edd`

**测试指令**：
```
/banking-aml cn "新客户开户尽职调查：企查查科技股份有限公司，
申请开立基本存款账户，注册资本1亿元人民币，法定代表人：XXX"
```

**企查查MCP自动增强点**：

| 原SKILL功能 | 企查查MCP增强 | 效果 |
|------------|---------------|------|
| 企业类型风险评估 | 自动查询工商登记信息 | 确认企业类型、注册资本、成立日期 |
| 地理风险评估 | 查询企业注册地址 | 验证实际经营地与注册地一致性 |
| 实际控制人识别 | 股权穿透分析 | 自动识别受益所有人（UBO） |
| 风险扫描 | 18类风险信号扫描 | 经营异常、司法风险、行政处罚 |

**预期输出**：
```
GOVERNING STANDARD: FATF Recommendation 10 (CDD), 12 (PEPs)
DOMAIN: AML/KYC -- Customer Due Diligence
JURISDICTION: China -- PBOC / CBIRC / CSRC

【企查查数据自动核验】
✅ 企业工商信息：企查查科技股份有限公司
   - 统一社会信用代码：91320XXXXXXXXXXXX
   - 注册资本：10000万人民币
   - 成立日期：2014-XX-XX
   - 登记状态：存续（在营、开业、在册）
✅ 法定代表人核验通过
✅ 股权结构：穿透识别受益所有人
⚠️ 风险提示：发现X条历史变更记录
✅ 无经营异常记录
✅ 无司法风险记录

KYC RISK RATING ASSESSMENT
Customer Name:      企查查科技股份有限公司
Customer Type:      Domestic corporate (private, no PEP links)
                   Risk Score: 3 — Medium
Geographic:         China (non-FATF, moderate risk)
                   Risk Score: 3 — Medium
Product/Service:    Basic current account
                   Risk Score: 1 — Low
Behavioural:        New customer
                   Risk Score: 3 — Medium

COMPOSITE SCORE:    2.7
OVERALL RATING:     Medium
CDD LEVEL:          Standard CDD
MONITORING FREQUENCY: Every 3 years
```

---

### 🔍 场景2：AML客户尽职调查（CDD/EDD）

**使用Command**: `/banking-aml`

**使用SKILL**: `aml-cdd-edd`

**测试指令**：
```
有个客户来开户，请帮我做客户尽职调查（CDD），
客户名称：企查查科技股份有限公司，
客户类型：私营企业，疑似有复杂股权结构，请做增强尽职调查（EDD）
```

**企查查MCP自动增强点**：

| CDD/EDD要求 | 企查查MCP支持 |
|------------|--------------|
| 识别并验证客户身份 | `qcc-company`: 工商登记信息核验 |
| 识别受益所有人（≥25%） | `qcc-company`: 股权穿透分析 |
| 了解业务性质和目的 | `qcc-operation`: 招投标记录、资质证书 |
| 复杂企业结构穿透 | `qcc-company`: 多层级股权结构图 |
| 负面信息筛查 | `qcc-risk`: 司法风险、行政处罚、经营异常 |
| 持续监控数据 | `qcc-risk`: 实时风险预警 |

**预期输出**：
```
GOVERNING STANDARD: FATF Recommendation 10 (CDD), 12 (PEPs)
DOMAIN: AML/KYC -- Enhanced Due Diligence
JURISDICTION: China -- PBOC / CBIRC

【企查查数据 -- EDD增强调查】

### 1. 企业基础身份核验
✅ 企业名称：企查查科技股份有限公司
✅ 统一社会信用代码：已核验
✅ 注册资本：10000万人民币（实缴）
✅ 成立日期：2014年
✅ 企业类型：股份有限公司
✅ 登记机关：苏州市市场监督管理局

### 2. 受益所有人识别（UBO）
【股权穿透分析结果】
第一层：
- 股东A：持股35%
- 股东B：持股25%
- 股东C：持股20%
- 其他股东：持股20%

受益所有人（≥25%）：
- 股东A（自然人）：35% → 主要受益人
- 股东B（自然人）：25% → 受益人

### 3. 业务性质验证
【企查查经营数据】
- 所属行业：软件和信息技术服务业
- 经营范围：企业信用评估、数据服务、软件开发等
- 资质证书：高新技术企业、ISO认证等
- 招投标记录：近3年中标X个项目

### 4. 风险扫描结果
【18类风险信号扫描】
✅ 无经营异常记录
✅ 无行政处罚记录
✅ 无严重违法失信记录
✅ 无股权冻结记录
✅ 无司法诉讼（作为被告）
⚠️ 历史变更记录：法定代表人变更X次
⚠️ 股东变更记录：X次

### 5. EDD结论
RISK LEVEL: Medium-High
REASON: 股权结构相对复杂，需持续关注
RECOMMENDATION: 批准开户，设置年度审查
```

---

### 🚫 场景3：制裁名单筛查 + 中国企业

**使用SKILL**: `sanctions-screening`

**测试指令**：
```
请对以下中国企业进行制裁名单筛查：
客户名称：企查查科技股份有限公司
关联方：包括法定代表人、主要股东、受益所有人
```

**企查查MCP自动增强点**：

| 制裁筛查要求 | 企查查MCP支持 |
|------------|--------------|
| 客户及关联方识别 | `qcc-company`: 企业、股东、高管信息 |
| 50%规则所有权检查 | `qcc-company`: 股权穿透至自然人 |
| 地址信息验证 | `qcc-company`: 注册地址、经营地址 |
| 别名/曾用名筛查 | `qcc-company`: 历史变更记录 |

**预期输出**：
```
GOVERNING STANDARD: OFAC (USA), OFSI/HMT (UK), EU CFSP, UN Security Council
DOMAIN: Sanctions Screening -- Entity and Associated Parties
JURISDICTION: Multi-jurisdictional (Primary: China)

【企查查数据 -- 关联实体识别】

### 筛查实体清单
1. 主实体：企查查科技股份有限公司
   - 注册号：91320XXXXXXXXXXXX
   - 地址：江苏省苏州市...

2. 法定代表人：XXX
   - 关联企业：X家（通过企查查关联图谱）

3. 受益所有人：
   - 股东A（35%）：XXX
   - 股东B（25%）：XXX

4. 历史曾用名：
   - 无前序名称

### 制裁名单筛查结果
✅ OFAC SDN List：无匹配
✅ OFSI/HMT：无匹配
✅ EU Sanctions：无匹配
✅ UN Consolidated：无匹配
✅ 50% Rule Check：上层股东无SDN

### 结论
CLEAR：该实体及其关联方未出现在主要制裁名单上
NEXT STEP：完成客户准入，设置持续监控
```

---

## 🏦 其他银行监管SKILL（企查查增强适用性）

虽然以下SKILL主要面向财务监管，但企查查MCP同样可以提供中国企业数据支持：

### Basel资本充足率 + 中国企业敞口

**SKILL**: `basel-rwa-credit`

**企查查增强**：对中国企业交易对手进行信用风险评估时，调用企查查获取：
- 财务数据（注册资本、股东实缴）
- 信用评级（企查查信用等级）
- 风险信号（失信、被执行）

### IFRS 9 ECL + 中国企业客户

**SKILL**: `ifrs9-ecl`

**企查查增强**：
- 中国企业客户违约概率（PD）评估支持
- 企业经营状态实时监控
- 风险预警信号纳入ECL模型

---

## 🔍 验证MCP调用成功

执行上述指令时，观察返回信息中是否包含企查查特有的数据字段：

### 企查查数据标识

```
✅ 统一社会信用代码
✅ 注册资本（万人民币）
✅ 实缴资本
✅ 法定代表人
✅ 登记状态：存续/在营/开业/在册
✅ 经营异常名录
✅ 股权穿透结构
✅ 受益所有人识别
✅ 18类风险信号
```

### 预期看到的MCP调用日志

```
深度思考

获取 MCP Server 详细信息:

qcc-company 或 qcc-risk

运行成功

[企查查数据返回...]
```

---

## 🛠️ 故障排查

| 问题 | 排查方法 |
|------|----------|
| **未调用企查查MCP** | 检查 `.mcp.json` 是否在项目根目录；重启Claude Code |
| **API Key无效** | 运行 `source ./setup-qcc-env.sh` 验证 |
| **返回模拟/通用数据** | 确认 `QCC_MCP_API_KEY` 已正确导出到环境变量 |
| **SKILL未激活** | 确认SKILL目录结构正确；检查 `CLAUDE.md` 是否在正确位置 |
| **中国企业名识别失败** | 尝试使用完整公司全称，如"企查查科技股份有限公司" |

---

## 📚 下一步

- 查看 [README.md](./README.md) 了解完整插件架构
- 查看 `skills/` 目录了解所有17个SKILL的详细功能
- 访问 [企查查开放平台](https://agent.qcc.com) 获取更多API能力说明
- 根据业务需求配置具体的MCP服务器URL

---

## 💡 使用提示

> **重要**：本插件的SKILL代码完全来自原作者，未做任何修改。企查查MCP的调用是通过Claude Code的智能工具匹配机制自动完成的——当SKILL需要"企业信息查询"时，系统会自动匹配到配置的 `qcc-company` 等MCP服务。
>
> 这种"配置驱动"的架构让您可以：
> - ✅ 零代码改动使用专业银行监管SKILL
> - ✅ 灵活切换数据源（企查查 / 其他数据源）
> - ✅ 保持与上游仓库同步更新
