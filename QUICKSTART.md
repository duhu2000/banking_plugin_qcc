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

验证文件是否存在：

```bash
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

本插件包含17个专业银行监管SKILL，以下6个SKILL已深度集成企查查MCP服务，在处理中国企业时自动获取工商、风险、股权数据：

---

## 场景1：AML客户尽职调查（CDD/EDD）

**使用SKILL**: `aml-cdd-edd`

**适用场景**：客户开户尽职调查、增强尽职调查（EDD）、政治公众人物（PEP）识别、受益所有人（UBO）穿透、企业股权结构分析

**测试指令**：
```
有个客户来开户，请帮我做客户尽职调查（CDD），
客户名称：企查查科技股份有限公司
```

**企查查MCP数据映射**：

| SKILL功能 | MCP服务 | 获取数据 |
|-----------|---------|----------|
| 企业客户身份核验 | `qcc-company` | 工商登记信息、统一社会信用代码、注册资本、法定代表人 |
| 受益所有人识别 | `qcc-company` | 股权穿透、股东结构、实际控制人 |
| 业务性质验证 | `qcc-operation` | 经营范围、所属行业、资质证书 |
| 负面信息筛查 | `qcc-risk` | 司法风险、行政处罚、经营异常 |
| 持续监控数据 | `qcc-risk` | 实时风险预警、变更记录 |

**预期输出**：
```
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
⚠️ 历史变更记录：X条
✅ 无司法风险记录

CDD结论：
RISK LEVEL: Medium
CDD LEVEL: Standard CDD
RECOMMENDATION: 批准开户，设置3年定期审查
```

---

## 场景2：制裁名单筛查

**使用SKILL**: `sanctions-screening`

**适用场景**：OFAC/SDN名单筛查、OFSI/EU/UN制裁名单检查、50%所有权规则审查、中国企业及关联方全面筛查

**测试指令**：
```
请对以下中国企业进行制裁名单筛查：企查查科技股份有限公司
```

**企查查MCP数据映射**：

| SKILL功能 | MCP服务 | 获取数据 |
|-----------|---------|----------|
| 主实体身份核验 | `qcc-company` | 工商登记信息、注册号、注册地址 |
| 受益所有人识别 | `qcc-company` | 股权穿透、股东结构、实际控制人 |
| 50%规则所有权检查 | `qcc-company` | 多层级股权结构、最终受益人 |
| 关联实体识别 | `qcc-company` | 法定代表人、高管、关联企业 |
| 别名/曾用名筛查 | `qcc-company` | 历史变更记录、曾用名 |
| 负面信息补充 | `qcc-risk` | 司法风险、经营异常、行政处罚 |

**预期输出**：
```
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

## 场景3：KYC风险评级

**使用SKILL**: `kyc-risk-rating`

**适用场景**：客户风险分类、四维度风险评分（客户类型/地理/产品/行为）、高风险客户识别、定期风险评估

**测试指令**：
```
请对企查查科技股份有限公司进行KYC风险评级
```

**企查查MCP数据映射**：

| SKILL功能 | MCP服务 | 获取数据 |
|-----------|---------|----------|
| 客户类型风险 | `qcc-company` | 企业类型、注册资本、成立年限、股东结构 |
| 地理风险 | `qcc-company` | 注册地址、实际经营地址、分支机构分布 |
| 业务性质验证 | `qcc-operation` | 经营范围、所属行业、资质证书 |
| 行为风险信号 | `qcc-risk` | 经营异常、司法诉讼、行政处罚、失信记录 |
| 关联风险 | `qcc-company` | 关联企业、集团关系、一致行动人 |

**预期输出**：
```
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
CDD级别：       Standard CDD
监控频率：      Every 3 years

【风险信号扫描】
✅ 无经营异常
✅ 无司法诉讼
✅ 无行政处罚
✅ 无负面舆情
```

---

## 场景4：信用风险RWA计算

**使用SKILL**: `basel-rwa-credit`

**适用场景**：信用风险RWA标准法计算、企业敞口风险权重评估、交易对手信用风险分析

**测试指令**：
```
请计算对中国企业XXX科技有限公司的信用风险RWA，
敞口金额1000万人民币
```

**企查查MCP数据映射**：

| SKILL功能 | MCP服务 | 获取数据 |
|-----------|---------|----------|
| 企业信用状况 | `qcc-company` | 注册资本、实缴资本、股东结构 |
| 财务稳定性 | `qcc-operation` | 招投标记录、中标率、经营活跃度 |
| 风险预警信号 | `qcc-risk` | 失信记录、被执行、限高、破产 |
| 行业地位 | `qcc-operation` | 资质证书、信用评级、行业排名 |
| 经营状态 | `qcc-company` | 经营异常、行政处罚、股权冻结 |

**预期输出**：
```
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
⚠️ 历史行政处罚：1条（已说明）

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

## 场景5：IFRS 9预期信用损失（ECL）

**使用SKILL**: `ifrs9-ecl`

**适用场景**：预期信用损失计算、PD/LGD/EAD参数估计、情景加权ECL、中国企业客户减值准备

**测试指令**：
```
请计算对XXX科技有限公司贷款组合的IFRS 9 ECL，
账面总额1000万人民币，当前 Stage 1
```

**企查查MCP数据映射**：

| SKILL功能 | MCP服务 | 获取数据 |
|-----------|---------|----------|
| PD（违约概率） | `qcc-risk` | 历史失信记录、被执行记录、经营异常 |
| 信用周期调整 | `qcc-operation` | 行业景气度、招投标活跃度 |
| LGD支持 | `qcc-company` | 企业资产状况、股权结构 |
| 阶段划分 | `qcc-risk` | 实时风险信号、预警信息 |
| 前瞻信息 | `qcc-operation` | 经营趋势、资质变化 |

**预期输出**：
```
GOVERNING STANDARD: IFRS 9 Financial Instruments
DOMAIN: Expected Credit Loss (ECL)
JURISDICTION: China

【企查查数据 -- 信用风险参数】
客户：XXX科技有限公司

风险信号扫描：
✅ 无失信记录
✅ 无被执行记录
⚠️ 经营异常记录：1条（已移除）
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

情景加权ECL：     147,000 CNY
```

---

## 场景6：IFRS 9阶段划分（SICR评估）

**使用SKILL**: `ifrs9-staging`

**适用场景**：信用风险显著增加（SICR）判断、阶段迁移评估、第三阶段违约识别、定性/定量触发因素分析

**测试指令**：
```
请评估XXX科技有限公司贷款的阶段划分，
当前Stage 1，最近发现企业有1条经营异常记录
```

**企查查MCP数据映射**：

| SKILL功能 | MCP服务 | 获取数据 |
|-----------|---------|----------|
| 定量SICR触发 | `qcc-risk` | 逾期信息、风险评级变化 |
| 定性SICR信号 | `qcc-risk` | 经营异常、司法诉讼、行政处罚 |
| 行业风险 | `qcc-operation` | 行业景气度、系统性风险 |
| 关联风险 | `qcc-company` | 母公司/关联方风险传导 |
| 财务契约监控 | `qcc-company` | 股权冻结、资产查封 |

**预期输出**：
```
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
⚠️ 经营异常记录：1条（地址变更未及时备案）
✅ 无司法诉讼
✅ 无行政处罚
✅ 无行业系统性风险

【专业判断】
经营异常记录为地址变更备案延迟，
已及时整改移除，不构成实质性SICR。

ECL影响：
维持12-month ECL
继续监控
```

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
- 查看 `skills/*/SKILL.zh.md` 了解各SKILL详细中文说明
- 访问 [企查查智能体数据平台](https://agent.qcc.com) 获取更多能力说明

---

## 💡 使用提示

> **重要**：本插件的SKILL代码完全来自原作者，未做任何修改。企查查MCP的调用是通过Claude Code的智能工具匹配机制自动完成的——当SKILL需要"企业信息查询"时，系统会自动匹配到配置的 `qcc-company` 等MCP服务。
>
> 这种"配置驱动"的架构让您可以：
> - ✅ 零代码改动使用专业银行监管SKILL
> - ✅ 灵活切换数据源（企查查 / 其他数据源）
> - ✅ 保持与上游仓库同步更新
