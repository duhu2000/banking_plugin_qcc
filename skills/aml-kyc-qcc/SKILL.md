---
name: aml-kyc-qcc
description: >
  AML 客户尽职调查 SKILL · 企查查 MCP V2.0 增强版。
  对公客户开户与增强尽职调查（EDD）的全流程工具。对标 FATF Recommendation 10（CDD）/ 12（PEPs）/ 13（代理行业务）标准，实现工商身份核验、最终受益所有人（UBO）穿透、政治公众人物（PEP）启发式筛查、个人司法穿透、关联交易合理性判定的五位一体反洗钱尽调。

  核心能力：
  - UBO 穿透到自然人：qcc-executive `get_personnel_beneficial_owner` + 股权穿透链路，输出符合央行 3 号令受益所有人识别标准的结构化清单
  - PEP 启发式筛查：结合个人任职历史、关联企业质量、行政处罚记录，识别潜在 PEP + RCA（RCA = PEP 关联人）
  - 个人司法穿透：18 维现状 + 14 维历史扫描，识别 UBO 与核心高管的个人风险
  - 关联企业网络：UBO 本人控制 / 任职 / 投资的全部企业的风险画像
  - AML 风险评级：低 / 中 / 高 / 拒绝四级，对齐 FATF 风险矩阵

  适用场景：银行对公开户合规审查 / 证券公司开户 / 保险公司保单审核 / 第三方支付商户入网 / 虚拟资产服务商（VASP）客户尽调。

  使用方式：/banking-aml 企业名称 [--risk-tier low|med|high] [--pep-country 中国|海外] [--format md|docx|pptx]

license: Apache-2.0
metadata:
  author: Anthropic Banking (Enhanced with QCC MCP V2.0)
  version: "2.0"
  plugin-commands: "/banking-aml"
  mcp-integrations: "qcc-company, qcc-executive, qcc-history, qcc-risk"
  standard: "FATF Recommendation 10 (CDD), 12 (PEPs), 13 (Correspondent Banking), 央行 3 号令"
  industry: "Financial Services - Banking AML/KYC"
---

# AML 客户尽职调查 · 企查查 MCP V2.0 增强版

## SKILL 定位

本 SKILL 服务于金融机构客户开户时的反洗钱尽调（CDD / EDD）、证券开户、保险保单审核、第三方支付商户入网、VASP 客户尽调等场景。核心对标 FATF Recommendation 10（CDD）、12（PEPs）、13（代理行业务）以及中国人民银行《金融机构反洗钱和反恐怖融资监督管理办法》（3 号令）要求。

V2.0 相对 V1.0 的最大跃迁在于 qcc-executive 的 42 个人员画像工具——特别是 `get_personnel_beneficial_owner`（董监高-作为最终受益人）和 `get_personnel_related_companies`（董监高-全部关联企业），让 AML 尽调真正实现"穿透到自然人 × 识别其所有关联企业 × 评估每一个关联企业的合规状态"的三层反洗钱风险地图。在 V1.0 下这个工作需要通过反复的企业级查询手工拼接，V2.0 下是一次 MCP 调用的直接返回。

## MCP 依赖与配置

必选：
- `qcc-company`（企业基座）—— 工商核验 + **get_beneficial_owners**（企业层 UBO 识别）+ 主要人员 + 实控人
- `qcc-executive`（人员画像）—— **本 SKILL 核心数据源**，UBO 自然人穿透的全套工具

强烈建议：
- `qcc-history`（历史存档）—— 识别信用修复型与连年失信型 UBO
- `qcc-risk`（风控大脑）—— 企业层司法风险全景（辅助判定）

## 通用执行原则

**第一，UBO 必须穿透到自然人。** 企业层"最终受益人"字段是合规起点而非终点，必须对每个 UBO 自然人启动个人画像扫描。任何一个 UBO 个人有限高 / 限出境 / 失信 / 税收违法 → 自动触发"高风险客户"标签 + 启动 EDD 流程。

**第二，PEP 识别是启发式过程，不做刚性结论。** MCP 不包含国际制裁清单，PEP 判定须依赖以下启发式组合：个人任职历史中是否含党政军公职 / 国有企业高管、关联企业是否为国资背景、姓名在公开 PEP 数据库（如 Dow Jones / World-Check）是否命中。SKILL 输出"疑似 PEP / RCA"标记，最终 PEP 判定由合规岗人工确认。

**第三，RCA 扩展覆盖。** PEP 的近亲属与业务密切关联人（RCA）同样须接受 EDD。通过 qcc-executive 的 `get_personnel_historical_partners` 可识别疑似业务关联人。

**第四，受益所有人 25% 阈值不是唯一判定。** 央行 3 号令允许金融机构在"基于风险"的前提下降低阈值（例如对高风险客户降至 10%）。SKILL 默认按 25% 输出，同时列出 10-25% 区间的潜在受益人作为补充。

**第五，关联企业合规联动。** 发现 UBO 控制的关联企业中存在经营异常 / 严重违法 / 破产 / 被吊销等，即便本次申请主体清洁，整个关系也须标记"系内合规风险"。

## 工作流

### 维度一：主体身份核验（FATF CDD Step 1-2）

工具链：
- `mcp__qcc-company__get_company_registration_info` — 工商基础
- `mcp__qcc-company__verify_company_accuracy` — 企业名 + 法代 + USCC 三项匹配核验
- `mcp__qcc-company__get_contact_info` — 联系方式（用于交叉验证申请材料）
- `mcp__qcc-company__get_company_announcement` — 上市披露（如为上市公司）

产出：申请主体身份档案，包括企业全称、USCC、法代、成立日期、登记状态、注册资本与实缴率、经营范围。

**异常标识触发条件**：
- USCC 与工商登记不一致 → 触发身份核验失败
- 登记状态为"吊销 / 注销 / 异常" → 拒绝开户
- 成立时间 < 6 个月且注册资本极低 → 增强核查

### 维度二：UBO 穿透到自然人（FATF CDD Step 3-4）

工具链：
- `mcp__qcc-company__get_beneficial_owners` — 企业层 UBO 清单
- `mcp__qcc-company__get_shareholder_info` — 股东结构
- `mcp__qcc-company__get_actual_controller` — 实际控制人链路
- `mcp__qcc-executive__get_personnel_beneficial_owner` — 以每个自然人为锚反查其作为 UBO 的企业清单

**受益所有人识别逻辑（3 号令标准）**：
1. 直接或间接持股 25% 以上的自然人
2. 通过其他方式实际控制的自然人（协议控制 / 投票权 / 管理层任免）
3. 高管层（法代 / 董事长 / 总经理）作为 UBO 候补

产出：《UBO 清单》——每个 UBO 自然人的姓名、持股比例（直接 + 间接）、身份证明件号（脱敏）、国籍、职务。

### 维度三：UBO 个人司法穿透

对每个 UBO 自然人跑 qcc-executive 核心工具链：

**当前层**（FATF CDD Step 5）：
- `mcp__qcc-executive__get_personnel_dishonest`
- `mcp__qcc-executive__get_personnel_high_consumption_ban`
- `mcp__qcc-executive__get_personnel_judgment_debtor`
- `mcp__qcc-executive__get_personnel_exit_restriction`
- `mcp__qcc-executive__get_personnel_tax_violation`
- `mcp__qcc-executive__get_personnel_admin_penalty`
- `mcp__qcc-executive__get_personnel_property_reward_notice`

**历史层**（识别修复主体）：
- `mcp__qcc-executive__get_personnel_historical_dishonest`
- `mcp__qcc-executive__get_personnel_historical_admin_penalty`
- `mcp__qcc-executive__get_personnel_historical_judgment_debtor`

**AML 风险触发条件**：

| UBO 个人状况 | AML 评级 | 处置建议 |
|--------------|---------|---------|
| 当前失信被执行 | **高风险 / 拒绝** | 不开户，或仅支持受限账户 |
| 当前限制高消费 | **高风险** | 启动 EDD，追加资金来源证明 |
| 当前限制出境 | **高风险** | 启动 EDD + 反洗钱可疑交易监测 |
| 当前税收违法 | **高风险** | 启动 EDD + 要求税务合规证明 |
| 历史失信已移出（5 年内）| **中风险** | 降低阈值监测，每半年复核 |
| 历史全部清洁 | **低风险** | 标准 CDD 流程 |

### 维度四：PEP / RCA 启发式筛查（FATF R12）

工具链：
- `mcp__qcc-executive__get_personnel_positions` / `get_personnel_historical_positions` — 任职履历
- `mcp__qcc-executive__get_personnel_related_companies` / `get_personnel_historical_related_companies` — 关联企业
- `mcp__qcc-executive__get_personnel_historical_partners` — 历史业务伙伴

**PEP 启发式判定组合**：
- 任职企业包含党政军机关、国资委监管中央 / 地方国企、人民银行系统、监管机构系统等
- 历史任职企业经历过"党政转岗"轨迹（政府机关 → 国企高管 → 民企高管）
- 关联企业国资背景占比 > 30%
- 姓名命中公开 PEP 数据库（由合规岗外部工具确认）

**输出**：
- **疑似境内 PEP**：任职履历含公职 / 国企高管
- **疑似境外 PEP**：姓名 + 任职在海外机构
- **疑似 RCA**：历史业务伙伴包含已确认 PEP

### 维度五：关联企业网络与交易背景合理性

工具链：
- `mcp__qcc-executive__get_personnel_controlled_companies` — UBO 当前控制企业
- `mcp__qcc-executive__get_personnel_investments` — UBO 对外投资
- `mcp__qcc-executive__get_personnel_related_companies` — UBO 全部关联企业
- 对每家关联企业做 `mcp__qcc-risk__get_dishonest_info` 快扫风险标签

分析要点：

- UBO 关联企业中存在 1 家以上失信 / 被执行 / 严重违法 → 提升至"中风险"客户
- 关联企业中存在 3 家以上近 2 年内注销 → "资金腾挪"风险信号，提升至"高风险"
- 关联企业注册地高度集中在特殊经济区 / 保税港 / 海外离岸地 → "空壳化"嫌疑
- 申请主体的经营范围与 UBO 其他关联企业的经营范围无交集 → 交易背景合理性存疑

## 综合 AML 评级（FATF 四级风险矩阵）

| 评级 | 核心标准 | CDD 措施 |
|------|---------|---------|
| **低风险** | 所有 UBO 清洁 + 非 PEP/RCA + 关联企业清洁 + 经营范围合理 | 标准 CDD（SDD 简化尽调不适用于中国金融机构） |
| **中风险** | 历史事件已修复 或 关联企业中有已移出负面 或 UBO 持股比例分散 | CDD + 每半年复核 + 可疑交易监测加强 |
| **高风险** | 当前存在负面 或 疑似 PEP/RCA 或 关联企业存在活跃风险 | **EDD 增强尽调**：资金来源证明 + 高管访谈 + 每季复核 + 反洗钱监测升级 |
| **拒绝** | UBO 失信被执行 / 限出境 / 被制裁 / 关联恐怖主义融资 | 不开户，保留记录上报反洗钱监测中心 |

## 输出模板

- 章节 1：**执行摘要 · AML Decision Pack**（评级 + CDD/EDD 措施 + 上报指令 + T+0/T+3/T+7 Action）
- 章节 2：数据来源与 FATF 对标声明
- 章节 3：主体身份档案（CDD Step 1-2）
- 章节 4：**UBO 穿透清单**（自然人级，含持股比例）
- 章节 5：UBO 个人司法画像（按人独立成节，当前 × 历史双层）
- 章节 6：PEP / RCA 启发式筛查结果
- 章节 7：关联企业网络与交易背景合理性
- 章节 8：综合 AML 评级 × CDD/EDD 措施 × 上报建议
- 章节 9：数据来源、采集时间戳、免责声明、FATF 对标说明

## 参数

- `--risk-tier <low|med|high>`：预期风险层级（可指定优先路径）
- `--pep-country <中国|海外|两者>`：PEP 筛查重点（影响启发式判定规则）
- `--ubo-threshold <percentage>`：UBO 识别阈值，默认 25%（风险高客户可降至 10%）
- `--format md|docx|pptx`：输出格式，默认 md

## 边界与免责

本 SKILL 对 PEP / 国际制裁清单的判定基于公开信息启发式推断，**不能替代专业制裁筛查工具**（如 World-Check、Dow Jones、Thomson Reuters）。正式合规场景必须配合专业工具完成制裁命中检查。

FATF 对 CDD / EDD 的标准是原则性的，各国监管细则（如中国央行 3 号令、美国 BSA/AML 法案、欧盟 AMLD5/6）有具体差异。SKILL 输出的评级标准对齐中国央行 3 号令，其他司法管辖区使用前需本地化校准。

可疑交易报告（STR）和大额交易报告（LAR）的报送义务由金融机构自行承担，本 SKILL 仅为客户准入和尽调决策提供数据支持，不构成反洗钱报告的直接生成工具。

---

**SKILL 版本**：v2.0（MCP V2.0 升级版）
**适配 MCP 版本**：146 工具 / 6 Server 全量版
**所需 Server**：qcc-company（必选）、qcc-executive（必选）、qcc-history（强烈建议）、qcc-risk（建议）
