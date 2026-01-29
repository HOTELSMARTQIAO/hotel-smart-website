#!/bin/bash

echo "==================================="
echo "  酒店智能化咨询网站 - 启动脚本"
echo "==================================="

# 检查Python是否安装
if ! command -v python3 &> /dev/null; then
    echo "❌ Python3 未安装，请先安装 Python3"
    exit 1
fi

echo "✅ Python3 已安装"

# 检查虚拟环境
if [ ! -d "venv" ]; then
    echo "📦 创建虚拟环境..."
    python3 -m venv venv
fi

# 激活虚拟环境
echo "🔌 激活虚拟环境..."
source venv/bin/activate

# 安装依赖
echo "📥 安装依赖..."
pip install -r requirements.txt

# 检查.env文件
if [ ! -f ".env" ]; then
    echo "⚠️  未找到.env文件，从.env.example复制..."
    cp .env.example .env
    echo "⚠️  请编辑.env文件，填入正确的API密钥！"
    echo "   COZE_API_KEY=your_api_key"
    echo "   COZE_BOT_ID=your_bot_id"
    echo ""
    read -p "是否继续启动？(y/n) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
fi

# 启动Flask应用
echo "🚀 启动网站..."
echo "==================================="
echo "  访问地址: http://localhost:5000"
echo "  按 Ctrl+C 停止服务"
echo "==================================="
python app.py
