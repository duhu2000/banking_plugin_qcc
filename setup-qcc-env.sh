#!/bin/bash
# 企查查MCP环境变量配置脚本
# 使用方式: source setup-qcc-env.sh

  echo "=========================================="
  echo "企查查MCP环境变量配置"
  echo "=========================================="

  # 检查是否已设置
  if [ -z "$QCC_MCP_API_KEY" ]; then
      echo "⚠️   未检测到 QCC_MCP_API_KEY 环境变量"
      echo ""
      echo "请从以下渠道获取API Key："
      echo "  1. 访问 https://agent.qcc.com"
      echo "  2. 登录企查查智能体数据平台"
      echo "  3. 创建应用获取 MCP API Key"
      echo ""
      echo "然后执行: export QCC_MCP_API_KEY='your_api_key_here'"
      echo ""
      return 1
  else
      echo "✅ QCC_MCP_API_KEY 已配置"
      echo "📋 Key前缀: ${QCC_MCP_API_KEY:0:8}..."
  fi

  # 验证Claude Code MCP配置
  echo ""
  echo "📁 MCP配置文件检查:"
  if [ -f ".mcp.json" ]; then
      echo "✅ 发现 .mcp.json 配置文件"
      echo "📋 配置的服务器:"
      grep -o '"qcc-[^"]*"' .mcp.json | tr -d '"' | sed 's/^/   - /'
  else
      echo "⚠️   未发现 .mcp.json 配置文件"
  fi

  echo ""
  echo "=========================================="
  echo "配置完成！重启Claude Code以加载MCP配置"
  echo "=========================================="
