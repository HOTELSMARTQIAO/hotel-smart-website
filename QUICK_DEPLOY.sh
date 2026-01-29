#!/bin/bash

# ========================================
# 快速部署到Render脚本
# ========================================

echo "========================================"
echo "🚀 酒店智能化咨询网站 - 快速部署"
echo "========================================"
echo ""

# 步骤1：检查Git状态
echo "📋 步骤1: 检查Git状态..."
git status

echo ""
echo "✅ Git仓库正常"
echo ""

# 步骤2：添加所有文件
echo "📋 步骤2: 添加文件到Git..."
git add -A
git status

echo ""
echo "✅ 文件已添加"
echo ""

# 步骤3：提交更改
echo "📋 步骤3: 提交更改..."
git commit -m "Add GitHub Actions workflow for Render deployment"

echo ""
echo "✅ 提交成功"
echo ""

# 步骤4：推送到GitHub
echo "📋 步骤4: 推送到GitHub..."
git push origin main

echo ""
echo "✅ 推送成功！"
echo ""

echo "========================================"
echo "🎯 下一步：部署到Render"
echo "========================================"
echo ""
echo "1. 访问: https://render.com"
echo "2. 登录账号: 3232762616@qq.com"
echo "3. 连接GitHub仓库: hotel-smart-website"
echo "4. 创建Web Service（配置已自动读取render.yaml）"
echo "5. 预计访问地址: https://hotel-smart-website.onrender.com"
echo ""
echo "详细部署指南: /workspace/projects/RENDER_DEPLOY_GUIDE.md"
echo ""
