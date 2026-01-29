#!/bin/bash

echo "=========================================="
echo "   Render部署 - 一键指南"
echo "=========================================="
echo ""

echo "📋 部署前检查："
echo ""

# 检查Git
if ! command -v git &> /dev/null; then
    echo "❌ Git未安装"
    echo "   Ubuntu/Debian: apt install git"
    echo "   CentOS/RHEL: yum install git"
    exit 1
fi
echo "✅ Git已安装"

# 检查Python
if ! command -v python3 &> /dev/null; then
    echo "❌ Python3未安装"
    exit 1
fi
echo "✅ Python3已安装"

# 检查render.yaml
if [ ! -f "render.yaml" ]; then
    echo "❌ 未找到render.yaml文件"
    exit 1
fi
echo "✅ render.yaml已就绪"

echo ""
echo "=========================================="
echo "   第一步：推送到GitHub"
echo "=========================================="
echo ""

echo "1️⃣  在GitHub创建新仓库："
echo "   https://github.com/new"
echo "   仓库名：hotel-smart-website"
echo ""

echo "2️⃣  运行以下命令推送代码："
echo ""
echo "   git init"
echo "   git add ."
echo "   git commit -m 'Initial commit'"
echo "   git branch -M main"
echo "   git remote add origin https://github.com/你的用户名/hotel-smart-website.git"
echo "   git push -u origin main"
echo ""

read -p "是否已推送到GitHub？(y/n) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "请先推送到GitHub，然后重新运行此脚本"
    exit 1
fi

echo ""
echo "=========================================="
echo "   第二步：在Render创建Web Service"
echo "=========================================="
echo ""

echo "1️⃣  访问 Render 并注册/登录："
echo "   https://render.com"
echo ""

echo "2️⃣  创建Web Service："
echo "   - 点击右上角 'New'"
echo "   - 选择 'Web Service'"
echo "   - 连接GitHub仓库"
echo "   - 选择 hotel-smart-website"
echo "   - 点击 'Connect'"
echo ""

echo "3️⃣  配置Web Service："
echo "   - Name: hotel-smart-website"
echo "   - Region: Singapore（推荐）"
echo "   - Branch: main"
echo "   - Instance Type: Free"
echo ""

echo "4️⃣  添加环境变量（在 Advanced → Environment Variables）："
echo "   Key: FLASK_ENV, Value: production"
echo ""
echo "   如需调用Coze API，添加："
echo "   Key: COZE_API_KEY, Value: 你的API密钥"
echo "   Key: COZE_BOT_ID, Value: 你的Bot ID"
echo ""

echo "5️⃣  点击 'Create Web Service'"
echo ""

read -p "是否已在Render创建Web Service？(y/n) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "请先在Render创建Web Service"
    exit 1
fi

echo ""
echo "=========================================="
echo "   等待部署完成"
echo "=========================================="
echo ""

echo "🕐 部署大约需要2-3分钟..."
echo ""
echo "在Render控制台查看部署进度："
echo "   https://dashboard.render.com"
echo ""
echo "点击 'Events' 标签查看日志"
echo ""

echo "=========================================="
echo "   部署成功后"
echo "=========================================="
echo ""

echo "🎉 您的网站地址："
echo "   https://hotel-smart-website.onrender.com"
echo ""

echo "📊 访问管理面板："
echo "   https://dashboard.render.com"
echo ""

echo "✅ 测试访问："
echo "   - 首页: https://hotel-smart-website.onrender.com/"
echo "   - 咨询: https://hotel-smart-website.onrender.com/consult"
echo "   - 方案: https://hotel-smart-website.onrender.com/generate-plan"
echo ""

echo "=========================================="
echo "   常见问题"
echo "=========================================="
echo ""

echo "❓ 部署失败？"
echo "   查看 'Events' 日志，检查错误信息"
echo ""

echo "❓ 访问404？"
echo "   检查 render.yaml 配置"
echo ""

echo "❓ 如何更新？"
echo "   git push 后会自动重新部署"
echo ""

echo "❓ 免费额度用完？"
echo "   免费计划：750小时/月（约25天）"
echo "   付费计划：$7/月起"
echo ""

echo "=========================================="
echo "   📚 更多文档"
echo "=========================================="
echo ""

echo "   完整教程: DEPLOY_RENDER.md"
echo "   Render文档: https://render.com/docs"
echo ""

echo "🎉 祝您部署成功！"
