#!/bin/bash

echo "=========================================="
echo "   部署到 Render（免费云平台）"
echo "=========================================="

# 1. 检查是否安装Git
if ! command -v git &> /dev/null; then
    echo "❌ Git未安装，请先安装Git"
    exit 1
fi

# 2. 检查是否有.git目录
if [ ! -d ".git" ]; then
    echo "📦 初始化Git仓库..."
    git init
    git add .
    git commit -m "Initial commit: Hotel Smart Website"
fi

# 3. 创建render.yaml
cat > render.yaml << 'EOF'
services:
  - type: web
    name: hotel-smart-website
    env: python
    plan: free
    buildCommand: pip install -r requirements.txt
    startCommand: gunicorn -w 4 -b 0.0.0.0:5000 app:app
    envVars:
      - key: FLASK_ENV
        value: production
      - key: COZE_API_KEY
        sync: false
      - key: COZE_BOT_ID
        sync: false
EOF

# 4. 提交到Git
git add render.yaml
git commit -m "Add Render configuration" 2>/dev/null || echo "No changes to commit"

echo ""
echo "✅ 配置完成！"
echo ""
echo "接下来的步骤："
echo ""
echo "1️⃣  推送到GitHub："
echo "   git remote add origin https://github.com/yourusername/hotel-smart-website.git"
echo "   git push -u origin main"
echo ""
echo "2️⃣  注册Render账号："
echo "   访问 https://render.com"
echo ""
echo "3️⃣  创建Web Service："
echo "   - 点击 'New' → 'Web Service'"
echo "   - 连接GitHub仓库"
echo "   - 点击 'Create Web Service'"
echo ""
echo "4️⃣  配置环境变量："
echo "   在Render控制台添加："
echo "   - COZE_API_KEY = 你的API密钥"
echo "   - COZE_BOT_ID = 你的Bot ID"
echo ""
echo "🎉 部署完成后，Render会给你一个访问地址！"
