#!/bin/bash

echo "========================================"
echo "🔍 酒店智能化咨询网站 - 部署诊断工具"
echo "========================================"
echo ""

# 检查1：验证GitHub仓库
echo "📋 检查1：验证GitHub仓库..."
REPO_STATUS=$(curl -s -o /dev/null -w "%{http_code}" https://github.com/HOTELSMARTQIAO/hotel-smart-website)
if [ "$REPO_STATUS" = "200" ]; then
    echo "✅ GitHub仓库可访问"
else
    echo "❌ GitHub仓库无法访问"
fi
echo ""

# 检查2：验证render.yaml
echo "📋 检查2：验证render.yaml配置..."
if [ -f "render.yaml" ]; then
    echo "✅ render.yaml 存在"
    echo "内容："
    cat render.yaml
else
    echo "❌ render.yaml 不存在"
fi
echo ""

# 检查3：验证requirements.txt
echo "📋 检查3：验证requirements.txt..."
if [ -f "requirements.txt" ]; then
    echo "✅ requirements.txt 存在"
    echo "内容："
    cat requirements.txt
else
    echo "❌ requirements.txt 不存在"
fi
echo ""

# 检查4：验证app.py
echo "📋 检查4：验证app.py..."
if [ -f "app.py" ]; then
    echo "✅ app.py 存在"
    python3 -m py_compile app.py 2>&1
    if [ $? -eq 0 ]; then
        echo "✅ app.py 语法正确"
    else
        echo "❌ app.py 存在语法错误"
    fi
else
    echo "❌ app.py 不存在"
fi
echo ""

# 检查5：验证目录结构
echo "📋 检查5：验证目录结构..."
echo "static/css/:"
ls -la static/css/ 2>&1 | grep -v "total"
echo ""
echo "static/js/:"
ls -la static/js/ 2>&1 | grep -v "total"
echo ""
echo "templates/:"
ls -la templates/ 2>&1 | grep -v "total"
echo ""

# 检查6：Git状态
echo "📋 检查6：Git状态..."
git status
echo ""

# 检查7：最新提交
echo "📋 检查7：最新提交..."
git log -1 --oneline
echo ""

echo "========================================"
echo "🎯 诊断完成"
echo "========================================"
echo ""
echo "如果以上所有检查都通过（✅），说明代码没问题。"
echo "请按照以下步骤在Render控制台部署："
echo ""
echo "1. 访问 https://render.com"
echo "2. 登录：3232762616@qq.com / qiao@123"
echo "3. 连接GitHub仓库：hotel-smart-website"
echo "4. 确认配置（会自动读取render.yaml）"
echo "5. 添加环境变量：FLASK_ENV=production"
echo "6. 创建服务，等待3分钟"
echo ""
echo "🔗 预计访问地址：https://hotel-smart-website.onrender.com"
echo ""
