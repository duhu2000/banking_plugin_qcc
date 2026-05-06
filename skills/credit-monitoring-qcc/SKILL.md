---
name: credit-monitoring-qcc
description: >
  信贷风险定期监控 SKILL · 企查查 MCP V2.0 增强版。
  贷后管理对存量借款客户的持续风险监控工具。相较授信尽调的"点式评估"，本 SKILL 做的是"面向时间轴的趋势监控"——本期扫描 × 历史对比 × 异动归因三位一体，识别授信后客户的经营恶化、司法风险新增、财务指标退化等所有负面信号。

  核心能力：
  - 本期 × 历史对比分析：qcc-risk 当前快照 × qcc-history 历史存档，形成 YoY / QoQ 风险趋势
  - 新增事件告警：失信、限高、被执行、经营异常、法代变更的增量识别与归因
  - 财务指标 YoY 退化预警：基于 `get_financial_data` 3 年财报的恶化曲线识别
  - 核心人员状态变化：法代 / 实控人近期新增个人风险的即时触发
  - 预警分级 × Action 清单：每个预警都附带处置建议与上报路径

  适用场景：银行存量客户贷后监测 / 供应链金融周期复核 / 融资租赁租后管理 / 保理存量客户预警。

  使用方式：/credit-monitoring 企业名称 [--baseline 基准日期] [--tolerance 容忍度阈值] [--format md|docx|pptx]

license: Apache-2.0
metadata:
  author: Anthropic Financial Services (Enhanced with QCC MCP V2.0)
  version: "2.0"
  plugin-commands: "/credit-monitoring"
  mcp-integrations: "qcc-company, qcc-risk, qcc-history, qcc-executive"
  industry: "Financial Services - Post-Loan Monitoring"
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

# 信贷风险定期监控 · 企查查 MCP V2.0 增强版

## SKILL 定位

本 SKILL 服务于贷后管理的周期性风险复核场景。相较于授信前的"点式尽调"，贷后监控关注的是"时间轴上的变化"——本期扫描的结果必须与上期快照做对比，才能识别"哪些风险是新出现的、哪些风险在恶化、哪些风险在收敛"。V2.0 MCP 相对 V1.0 最根本的升级在于引入 qcc-history 历史工具链，让过去 1 年、3 年、5 年的真实数据可以与当前数据做同口径对比，从而输出真正的趋势分析而非仅基于"发布日期"的粗糙近似。

本 SKILL 的核心产出是"增量风险清单 + 趋势分析 + 预警分级 + 推荐 Action"。与授信尽调输出评级不同，贷后监控以"是否需要上报、是否需要加速回收、是否需要风险缓释动作"为决策目标。

## MCP 依赖与配置

必选：
- `qcc-company`（企业基座）—— 工商登记本期快照，`get_financial_data` 财报对比
- `qcc-risk`（风控大脑）—— 本期司法与经营风险全量快照
- `qcc-history`（历史存档）—— **本 SKILL 核心依赖**，提供跨周期对比基准

强烈建议：
- `qcc-executive`（人员画像）—— 识别核心人员的跨周期状态变化

## 通用执行原则

**第一，基准日期必须明示。** 所有"新增"、"恶化"、"收敛"判断都相对于某个基准日期（通常是上期监控日或授信放款日）。基准日期不同，结论可能完全相反。SKILL 输出须在报告头明确标注"基准日期 = YYYY-MM-DD，本期监控日 = YYYY-MM-DD"。

**第二，增量信号优先于存量信号。** 本期发现的 50 条失信记录如果 48 条是基准日之前就有的，只有 2 条是新增——真正需要告警的是那 2 条，存量的 48 条只是上下文。SKILL 必须能计算增量。

**第三，变化方向必须标注。** 资产负债率从 70% 升到 80% 与从 70% 降到 60% 所需动作完全不同。所有比率类指标必须标注变化方向（↑ 恶化 / ↓ 改善 / → 持平）。

**第四，法代变更视为最高优先级异动。** 授信后法代发生变更是治理结构不稳定的强信号，无论新法代是否清洁都需立即上报核心客户经理 + 信审 + 风控三方。

**第五，预警分级与上报路径严格对齐。** 同一级别预警对应固定的上报路径和处置时限，不允许"感觉严重"的主观判断。

## 工作流

### 维度一：本期风险全景快照

工具链（当前层，与授信尽调 SKILL 相同）：
- `mcp__qcc-risk__get_dishonest_info` / `get_judgment_debtor_info` / `get_high_consumption_restriction` / `get_terminated_cases` / `get_equity_freeze` / `get_equity_pledge_info` / `get_chattel_mortgage_info` / `get_tax_arrears_notice` / `get_business_exception`
- `mcp__qcc-company__get_company_registration_info` — 工商基础信息（识别法代 / 股东 / 注册资本变更）
- `mcp__qcc-company__get_financial_data` — 本期财务数据

产出：本期风险全景一张总表。

### 维度二：历史基准对比（V2.0 核心能力）

工具链（历史层）：
- `mcp__qcc-history__get_historical_dishonest` / `get_historical_judgment_debtor` / `get_historical_high_consumption_ban` / `get_historical_terminated_cases` / `get_historical_equity_freeze` / `get_historical_business_exception` / `get_historical_tax_arrears` / `get_historical_admin_penalty`
- `mcp__qcc-history__get_historical_registration` — 历史工商信息（曾用名、注册资本变更）
- `mcp__qcc-history__get_historical_legal_rep` — 历届法定代表人
- `mcp__qcc-history__get_historical_shareholders` — 历史股东

分析要点：

对比逻辑——以上期监控日为基准，本期 MCP 全集 减去 基准日 MCP 全集 = 本期增量。

分类归因：
- **增量失信 / 被执行 / 限高**：按案号、立案日期、涉案金额三项排序，输出 Top 5
- **法代变更**：新旧法代对比，对新任法代做个人画像快扫
- **股东变更**：大股东退出或新增均需标注
- **注册资本变更**：减资是风险信号，增资可能是良性
- **经营异常新增**：识别"未按时报送年报"等常见轻微异常

### 维度三：财务指标 YoY 退化预警

基于 `get_financial_data` 返回的 3 年财报做同比对比：

| 指标 | 正常波动 | 警戒区间 | 致命区间 |
|------|---------|---------|---------|
| 资产负债率同比 | < 5% 上升 | 5-15% 上升 | > 15% 上升 |
| 营收同比 | > 0% | -10% ~ 0% | < -10% |
| 净利润同比 | 任何 | 由正转负 | 连续 2 年净亏损 |
| 经营现金流 | 正 | 由正转负 | 连续 2 年负 |
| 速动比率下降 | < 0.2 | 0.2-0.5 | > 0.5 |

任何一项触及致命区间即触发 S 级预警（见预警分级）。

### 维度四：核心人员状态变化

工具链：
- `mcp__qcc-executive__get_personnel_dishonest` / `_high_consumption_ban` / `_judgment_debtor` / `_exit_restriction` —— 对法代 + 实控人本期扫描
- `mcp__qcc-executive__get_personnel_historical_dishonest` 等历史版 —— 对比基准日

识别内容：
- 法代 / 实控人本期新增任何个人风险 → 最高优先级上报
- 核心高管团队变动（如 CFO、总经理离任）→ 中优先级关注
- 实控人新增控制企业出险 → 可能存在"系内风险传染"

### 维度五：预警分级 × 推荐 Action

**S 级（24 小时内上报 + 紧急处置）**：
- 企业当前新增失信 / 限高 / 被执行
- 实控人或法代新增任何个人风险
- 财务指标触及致命区间
- 处置动作：启动加速回收程序、重新评估贷款风险分类、考虑提前收贷

**A 级（T+3 内上报 + 加强监测）**：
- 历史曾清洁，本期新增经营异常 / 欠税 / 行政处罚
- 财务指标触及警戒区间
- 法代或大股东发生变更
- 处置动作：召集三方（客户经理 + 信审 + 风控）会议、提高监测频率到月度、要求企业提交说明材料

**B 级（T+7 内记录 + 正常监测）**：
- 无新增风险，历史存量无恶化
- 财务指标正常波动
- 处置动作：标准贷后记录归档，下次监控按原周期执行

**C 级（持续优质客户）**：
- 连续两期无任何增量负面信号
- 财务指标稳中有升
- 处置动作：可提交客户经理进入"优质客户白名单"流程，可讨论续贷 / 提额

## 输出模板

- 章节 1：**执行摘要 · 预警 Decision Pack**（预警级别 + 3-5 条核心判断 + T+0/T+3/T+7 推荐 Action）
- 章节 2：基准日期声明与数据来源
- 章节 3：本期 × 基准日增量风险清单（按预警级别分层）
- 章节 4：**财务指标 YoY 退化分析**（近 3 年对比表）
- 章节 5：历史趋势分析（近 5 年时间序列）
- 章节 6：核心人员状态变化
- 章节 7：预警分级结论 × 推荐 Action 清单
- 章节 8：数据来源、采集时间戳、下次监控日建议

## 参数

- `--baseline <日期>`：对比基准日期（默认上期监控日或授信放款日）
- `--tolerance <阈值>`：风险变化容忍度（如 "资产负债率 +5%" 以内视为正常波动）
- `--format md|docx|pptx`：输出格式，默认 md

## 边界与免责

本 SKILL 输出的是"主体侧" 风险监控，不覆盖行业风险、区域政策、利率变化、宏观经济等维度。

历史数据对比依赖 MCP 的历史存档完整性，极早期（2015 年前）历史记录可能不全，对长期限授信的跨 5 年以上对比建议辅以外部数据源。

---

**SKILL 版本**：v2.0（MCP V2.0 升级版）
**适配 MCP 版本**：146 工具 / 6 Server 全量版
**所需 Server**：qcc-company（必选）、qcc-risk（必选）、qcc-history（必选）、qcc-executive（强烈建议）
