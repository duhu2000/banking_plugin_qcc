---
name: ubo-screening-qcc
description: >
  受益所有人穿透 SKILL · 企查查 MCP V2.0 增强版。
  反洗钱合规场景下的股权穿透工具。基于央行 3 号令与 FATF Recommendation 10 的受益所有人识别标准，自动逐层解析多层股权结构，查明最终受益所有人（UBO）及实际持股比例，识别隐藏的控制关系。与 AML 尽调、KYB 核验形成合规闭环。

  核心能力：
  - UBO 识别三层穿透：直接持股 25% + 间接穿透持股 25% + 协议控制
  - **V2.0 核心新能力**：qcc-executive `get_personnel_beneficial_owner` 反查法——以自然人为锚反查其作为 UBO 的全部企业
  - UBO 自然人完整画像：18 维现状 + 14 维历史扫描
  - UBO 关联企业网络：识别 UBO 控制 / 任职的其他企业是否存在合规瑕疵
  - AML 风险联动：与 AML-CDD-EDD 流程深度对接，输出可直接入 KYC 档案的 UBO 报告

  适用场景：银行对公客户 UBO 识别 / 证券公司开户 UBO 核验 / 保险公司高净值客户 UBO / 第三方支付商户 UBO / 复杂架构企业开户审查 / 高风险客户增强尽调。

  使用方式：/ubo-screening 企业名称 [--threshold 25|10] [--profile-depth quick|full] [--format md|docx|pptx]

license: Apache-2.0
metadata:
  author: Anthropic Banking (Enhanced with QCC MCP V2.0)
  version: "2.0"
  plugin-commands: "/ubo-screening"
  mcp-integrations: "qcc-company, qcc-executive, qcc-history"
  standard: "央行 3 号令 / FATF R10"
  industry: "Financial Services - AML/KYC/UBO"
---

## 📖 QCC MCP 术语对照表（强制工具映射）

> **使用约定**：本表列出 SKILL 内业务简写与企查查 MCP 工具的精确映射。AI 执行本 SKILL 时遇到下表"业务简写"列的词汇，**必须调用对应"MCP 工具"列**，禁止使用 web search 或自由文本推测替代。完整规范见 [QCC-MCP-TERMINOLOGY.md](../../QCC-MCP-TERMINOLOGY.md)。

| 业务简写 | 规范全名 | 企查查 MCP 工具 |
| --- | --- | --- |
| 失信 | 失信被执行人 | `mcp__qcc-risk__get_dishonest_info` |
| 被执行 | 被执行人 / 判决债务人 | `mcp__qcc-risk__get_judgment_debtor_info` |
| 限高 | 限制高消费 | `mcp__qcc-risk__get_high_consumption_restriction` |
| 限出境 / 限境 | 限制出境 | `mcp__qcc-risk__get_exit_restriction` |
| 终本 | 终结本次执行案件 | `mcp__qcc-risk__get_terminated_cases` |
| 破产 / 重整 | 破产重整 | `mcp__qcc-risk__get_bankruptcy_reorganization` |
| 经营异常 | 经营异常 | `mcp__qcc-risk__get_business_exception` |
| 严重违法 | 严重违法失信 | `mcp__qcc-risk__get_serious_violation` |
| 行政处罚 / 重大处罚 | 行政处罚 | `mcp__qcc-risk__get_administrative_penalty` |
| 股权冻结 | 股权冻结 | `mcp__qcc-risk__get_equity_freeze` |
| 股权出质 | 股权出质 | `mcp__qcc-risk__get_equity_pledge_info` |
| 欠税 | 欠税公告 | `mcp__qcc-risk__get_tax_arrears_notice` |
| 税务异常 / 税务违法 | 税务异常 / 税收违法 | `mcp__qcc-risk__get_tax_abnormal` / `mcp__qcc-risk__get_tax_violation` |
| 受益所有人 / UBO | 受益所有人 | `mcp__qcc-company__get_beneficial_owners` |
| 实控人 / 实际控制人 | 实际控制人 | `mcp__qcc-company__get_actual_controller` |
| 主要人员 / 董监高 | 主要人员 | `mcp__qcc-company__get_key_personnel` |
| 抽查检查 / 双随机 | 双随机抽查 | `mcp__qcc-operation__get_random_check` |
| 吊销 | （登记状态字段判断）| 调 `mcp__qcc-company__get_company_registration_info` 取"登记状态" |
| 资不抵债 | （资产负债率字段判断）| 调 `mcp__qcc-company__get_financial_data` 判断负债率 > 100% |

---

# 受益所有人穿透 · 企查查 MCP V2.0 增强版

## SKILL 定位

本 SKILL 服务于金融机构反洗钱合规场景下的受益所有人（UBO）识别需求。相较于 KYB 覆盖主体核验 + 18 维风险、AML 覆盖整个 CDD/EDD 流程、IC Memo 覆盖投资视角的股权穿透，本 SKILL 专注于一件事："**将这家企业的所有 UBO 自然人找出来，并对每个自然人做合规画像**"。

V2.0 相对 V1.0 的颠覆性升级是 qcc-executive 的 `get_personnel_beneficial_owner` 工具——V1.0 只能沿着"企业 → 股东 → 股东的股东 ..."向上穿透，一旦遇到代持、境外主体、信托等架构就终止；V2.0 可以反过来"以自然人为锚，反查其作为 UBO 的全部企业"，从而验证穿透结果的可靠性，并识别同一 UBO 在多家企业的同时角色（可能构成关联关系网络）。

## MCP 依赖与配置

必选：
- `qcc-company`（企业基座）—— 股东 + 实控人 + UBO
- `qcc-executive`（人员画像）—— **本 SKILL 核心数据源**，自然人锁定 + 个人画像

强烈建议：
- `qcc-history`（历史存档）—— 历史股东追溯（识别"已退出但曾任 UBO"的自然人）

## 通用执行原则

**第一，合规标准以央行 3 号令为准。** 中国境内金融机构 UBO 识别的法定标准：①直接或间接持股 25% 以上的自然人；②通过其他方式实际控制的自然人；③高管层兜底。对高风险客户可降至 10% 阈值。

**第二，穿透不是到法人为止。** "某某控股集团持有 60%" 只是中间步骤，必须继续穿透到该集团的自然人 UBO。如遇境外主体无法穿透，必须明示标注。

**第三，V2.0 核心规定动作：反向验证。** 对每个识别出的 UBO 自然人调用 `get_personnel_beneficial_owner`，反查其作为 UBO 的全部企业清单。如该清单与本次分析结果不符（例如 MCP 返回该人是 20 家企业的 UBO 但本次分析只看到 1 家），说明穿透路径可能不完整。

**第四，对每个 UBO 做司法画像扫描。** 不是"找出 UBO 就结束"——每个 UBO 自然人必须过一遍 4 项红线（失信 / 限高 / 被执行 / 限出境），任一命中触发"高风险 UBO"标签。

**第五，UBO 关联企业合规联动。** UBO 控制的其他企业如存在失信 / 破产 / 被吊销，即便本次申请主体清洁，整个关系须标记"系内 UBO 风险"。

## 工作流

### 维度一：企业层 UBO 初筛（25% 阈值）

工具链：
- `mcp__qcc-company__get_beneficial_owners` —— MCP 算法识别的 UBO 清单
- `mcp__qcc-company__get_shareholder_info` —— 直接股东清单
- `mcp__qcc-company__get_actual_controller` —— 实际控制人

**判定**：找出所有直接或通过 get_beneficial_owners 识别出的自然人 UBO。

### 维度二：多层股权向上穿透

对每个机构股东递归调用 `get_shareholder_info`，直到终止条件触发：
- 遇到自然人 → 记录为 UBO，计算累计穿透比例
- 遇到国资委 → 记录为国资控股 UBO
- 遇到境外主体 → 标注"境外穿透受限"
- 深度达 10 层仍未到自然人 → 终止并上报 "UBO 穿透疑点"

**产出**：完整的 UBO 候选清单 + 各自穿透比例。

### 维度三：10% 阈值降低（高风险客户加强核查）

如本次客户被判定为高风险（通过 AML-CDD 流程或业务场景），将阈值降至 10%，重新跑维度一和维度二，识别 10-25% 区间的"潜在 UBO"。

**输出**：25% 阈值 UBO + 10% 阈值 UBO 两组清单。

### 维度四：V2.0 核心规定动作 —— UBO 反向验证

对每个 UBO 自然人调用：
- `mcp__qcc-executive__get_personnel_beneficial_owner` —— 该自然人作为 UBO 的全部企业清单
- `mcp__qcc-executive__get_personnel_related_companies` —— 该自然人的全部关联企业
- `mcp__qcc-executive__get_personnel_controlled_companies` —— 该自然人实际控制的企业

**验证逻辑**：
- 如本次分析识别出 X 先生是本企业 UBO，但 `get_personnel_beneficial_owner` 返回他是 0 家企业的 UBO → 矛盾，穿透可能错误
- 如返回他是 50 家企业的 UBO → 正常，但需标注"UBO 具有复杂商业帝国"

### 维度五：UBO 个人司法画像

对每个 UBO 自然人（25% 阈值）：
- `mcp__qcc-executive__get_personnel_dishonest`
- `mcp__qcc-executive__get_personnel_high_consumption_ban`
- `mcp__qcc-executive__get_personnel_judgment_debtor`
- `mcp__qcc-executive__get_personnel_exit_restriction`

对高风险场景（10% 阈值 UBO）同样扫描。

**输出 AML 风险标签**：
- 全绿 → **清洁 UBO**
- 任一项命中 → **高风险 UBO**

### 维度六：UBO 关联企业合规联动

对每个 UBO 做 `get_personnel_related_companies` 扫描其关联企业清单，对清单中的每家做快速风险标签（`get_dishonest_info`）：

- 关联企业全部清洁 → **UBO 关联无风险**
- 关联企业 1-2 家有失信 / 经营异常 → **UBO 关联系内风险**
- 关联企业多家出险或出现破产 → **UBO 可能是连续创业失败 / 商业帝国崩溃者**

### 维度七：历史 UBO 追溯（V2.0 新能力）

工具链：
- `mcp__qcc-history__get_historical_shareholders` —— 历史股东（已退出）

识别"曾经是 UBO 但已退出"的自然人——这在反洗钱可疑交易监测中是关键信息，用于判断客户与"已退出 UBO"是否仍存在资金联系。

## UBO 综合评级

### 合规等级（对齐 FATF + 3 号令）

| 等级 | 标准 | KYC / AML 处置 |
|------|------|--------------|
| **合规 A** | 25% 阈值下清晰识别单一或少数 UBO + 全部清洁 | 标准 CDD 流程 |
| **合规 B** | 25% 阈值下多个 UBO（≥ 3 个）但全部清洁 | 标准 CDD + 加强关系监测 |
| **关注 C** | 有 UBO 历史已修复的轻微风险 或 UBO 关联企业有轻微瑕疵 | 标准 CDD + 每半年复核 |
| **高风险 D** | 任何 UBO 当前失信 / 限高 / 限出境 / 税收违法 或 UBO 关联企业存在破产 / 严重违法 | **启动 EDD 流程** + 按 AML 高风险客户处置 |
| **禁入** | UBO 命中国际制裁名单 或 UBO 涉及恐怖主义融资嫌疑 | **拒绝开户** + STR 上报 |

## 输出模板

- 章节 1：**UBO 核验 Decision Pack**（合规等级 + UBO 清单 + 关键风险）
- 章节 2：数据来源
- 章节 3：主体基本信息
- 章节 4：**25% 阈值下的 UBO 清单**（含穿透路径）
- 章节 5：10% 阈值下的 UBO 清单（高风险客户）
- 章节 6：**UBO 反向验证结果**（V2.0 核心能力）
- 章节 7：UBO 个人司法画像（按人独立成节）
- 章节 8：UBO 关联企业合规联动
- 章节 9：历史 UBO 追溯
- 章节 10：UBO 综合评级 × KYC 处置建议
- 章节 11：数据来源、采集时间戳、免责声明

## 参数

- `--threshold <25|10>`：UBO 识别阈值（默认 25，高风险客户可选 10）
- `--profile-depth <quick|full>`：UBO 个人画像深度。quick 只扫 4 项红线；full 扫 18 维现状 + 14 维历史
- `--format md|docx|pptx`：输出格式，默认 md

## 边界与免责

UBO 识别基于公开股权信息，无法识别未披露的代持、协议控制、一致行动安排——这需要结合客户访谈、关联交易审查、合同尽调等手段。

境外主体穿透受限。对 BVI / Cayman / 香港等主体，本 SKILL 只能识别其作为"境外中间层"的地位，最终 UBO 须配合境外工商数据库（如 Orbis）或客户主动申报。

国际制裁清单（OFAC / UN / EU）不在本 SKILL 覆盖范围。对高风险客户，必须配合专业制裁筛查工具完成制裁命中检查。

---

**SKILL 版本**：v2.0（MCP V2.0 升级版）
**适配 MCP 版本**：146 工具 / 6 Server 全量版
**所需 Server**：qcc-company（必选）、qcc-executive（必选，核心数据源）、qcc-history（强烈建议）
