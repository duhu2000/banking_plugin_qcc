---
name: trade-finance-compliance-qcc
description: >
  贸易融资合规核查 SKILL · 企查查 MCP V2.0 增强版。
  贸易融资业务（信用证 / 保理 / 福费廷 / 出口退税）的合规核查工具。V2.0 新增进出口关键人员限出境 + 历史行政处罚两层能力。

  使用方式：/trade-finance-compliance 企业名称 [--format md|docx|pptx]

license: Apache-2.0
metadata:
  version: "2.0"
  plugin-commands: "/trade-finance-compliance"
  mcp-integrations: "qcc-company, qcc-risk, qcc-history, qcc-executive, qcc-operation"
---

# 贸易融资合规核查 · 企查查 MCP V2.0 增强版

## SKILL 定位

贸易融资业务（信用证 / 保理 / 福费廷 / 出口退税）的合规核查工具。V2.0 新增进出口关键人员限出境 + 历史行政处罚两层能力。

## 工作流维度

1. 海关信用等级（qcc-operation get_import_export_credit）
2. 进出口资质证书
3. **V2.0 新能力：进出口关键人员限出境**（qcc-executive get_personnel_exit_restriction —— 跨境业务关键否决项）
4. **V2.0 新能力：历史行政处罚**（qcc-history get_historical_admin_penalty —— 海关 / 税务历史违规追溯）
5. 出口退税资格（税收违法扫描）
6. 反洗钱 AML 合规（FATF 对标）

## 评级

A/B/C/D · D 级拒绝业务



## MCP 依赖

- 必选：qcc-company / qcc-risk
- V2.0 强烈建议：qcc-history / qcc-executive / qcc-operation / qcc-ipr（视场景）

## 输出模板

- 章节 1：Decision Pack（评级 + 关键判断 + 推荐 Action）
- 章节 2：数据来源
- 章节 3-7：各维度扫描结果
- 章节 8：V2.0 能力增量说明
- 章节 9：综合评级 × 处置建议

## 参数

- `--format md|docx|pptx`：输出格式，默认 md

## 边界与免责

本 SKILL 基于企查查 MCP V2.0 公开数据生成，不替代专业财务审计 / 律师尽调 / 技术评估。


**SKILL 版本**：v2.0 | **适配 MCP 版本**：146 工具 / 6 Server 全量
