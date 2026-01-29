#!/bin/bash

echo "=========================================="
echo "   本地部署 - 最快方式"
echo "=========================================="

# 1. 检查Python
if ! command -v python3 &> /dev/null; then
    echo "❌ Python3未安装，请先安装Python3"
    exit 1
fi

echo "✅ Python3已安装"

# 2. 检查Flask
if ! python3 -c "import flask" 2>/dev/null; then
    echo "📦 正在安装依赖..."
    pip3 install -r requirements.txt
else
    echo "✅ Flask已安装"
fi

# 3. 检查.env文件
if [ ! -f ".env" ]; then
    echo "⚠️  未找到.env文件，从.env.example复制..."
    cp .env.example .env
    echo "⚠️  请编辑.env文件，填入API密钥！"
    echo ""
    read -p "是否继续启动？(y/n) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "取消启动"
        exit 1
    fi
else
    echo "✅ 环境变量已配置"
fi

# 4. 启动网站
echo ""
echo "🚀 启动网站..."
echo "=========================================="
echo "  访问地址: http://localhost:5000"
echo "  按 Ctrl+C 停止服务"
echo "=========================================="
echo ""

python3 app.py
