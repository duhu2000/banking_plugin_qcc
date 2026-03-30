# 企查查MCP环境变量配置脚本 (PowerShell)
# 使用方式: .\setup-qcc-env.ps1

  Write-Host "==========================================" -ForegroundColor Cyan
  Write-Host "企查查MCP环境变量配置" -ForegroundColor Cyan
  Write-Host "==========================================" -ForegroundColor Cyan

  # 检查是否已设置
  if (-not $env:QCC_MCP_API_KEY) {
      Write-Host "⚠️   未检测到 QCC_MCP_API_KEY 环境变量" -ForegroundColor Yellow
      Write-Host ""
      Write-Host "请从以下渠道获取API Key："
      Write-Host "  1. 访问 https://agent.qcc.com"
      Write-Host "  2. 登录企查查开放平台"
      Write-Host "  3. 创建应用获取 MCP API Key"
      Write-Host ""
      Write-Host "然后执行: $env:QCC_MCP_API_KEY='your_api_key_here'"
      Write-Host ""
  } else {
      Write-Host "✅ QCC_MCP_API_KEY 已配置" -ForegroundColor Green
      Write-Host "📋 Key前缀: $($env:QCC_MCP_API_KEY.Substring(0,8))..."
  }

  # 验证Claude Code MCP配置
  Write-Host ""
  Write-Host "📁 MCP配置文件检查:" -ForegroundColor Cyan
  if (Test-Path ".mcp.json") {
      Write-Host "✅ 发现 .mcp.json 配置文件" -ForegroundColor Green
      Write-Host "📋 配置的服务器:"
      $content = Get-Content ".mcp.json" -Raw
      $matches = [regex]::Matches($content, '"qcc-[^"]*"')
      $matches | ForEach-Object { Write-Host "   - $($_.Value.Trim('"'))" }
  } else {
      Write-Host "⚠️   未发现 .mcp.json 配置文件" -ForegroundColor Yellow
  }

  Write-Host ""
  Write-Host "==========================================" -ForegroundColor Cyan
  Write-Host "配置完成！重启Claude Code以加载MCP配置" -ForegroundColor Cyan
  Write-Host "==========================================" -ForegroundColor Cyan
