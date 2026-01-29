# 酒店智能化咨询网站

一个专业的酒店智能化设计施工交付咨询平台，基于AI智能体 + 专业Skill，提供系统规划、资源配置、施工指导、验收标准等服务。

## ✨ 功能特性

### 核心功能
- 🤖 **智能咨询** - 对话式问答，调用hotel-smart-systems Skill
- 📋 **方案生成** - 根据酒店参数自动生成智能化设计方案
- 📚 **知识库** - 完整的酒店智能化专业知识体系

### 支持的系统
- 客房控制系统（RCU）
- 电子门锁系统
- 安防监控系统
- 楼宇自动化系统（BA）
- 综合布线系统
- 计算机网络系统

## 🚀 快速开始

### 方式一：本地运行
```bash
python3 app.py
```

访问：http://localhost:5000

### 方式二：Docker
```bash
docker-compose up
```

### 方式三：Render部署
详见：[DEPLOY_RENDER.md](DEPLOY_RENDER.md)

## 📋 项目结构

```
hotel-smart-website/
├── app.py                      # Flask后端
├── requirements.txt            # Python依赖
├── render.yaml                # Render配置
├── templates/                 # HTML模板
│   ├── index.html
│   ├── consult.html
│   └── generate_plan.html
├── static/                    # 静态资源
│   ├── css/style.css
│   └── js/
└── docs/                      # 文档
    ├── DEPLOYMENT.md
    ├── DEPLOY_RENDER.md
    └── QUICKSTART.md
```

## 🌐 部署到Render

### 快速部署
1. 推送代码到GitHub
2. 在Render创建Web Service
3. 配置环境变量：`FLASK_ENV=production`
4. 访问：https://hotel-smart-website.onrender.com

详细教程：[DEPLOY_RENDER.md](DEPLOY_RENDER.md)

## 📖 文档

- [QUICKSTART.md](QUICKSTART.md) - 快速开始指南
- [DEPLOYMENT.md](DEPLOYMENT.md) - 完整部署指南
- [DEPLOY_RENDER.md](DEPLOY_RENDER.md) - Render部署教程
- [PUBLISH.md](PUBLISH.md) - 发布方式对比

## 🔧 环境变量

```env
FLASK_ENV=production
COZE_API_KEY=your_api_key
COZE_BOT_ID=your_bot_id
```

## 📞 支持

如有问题，请查看文档或联系开发者。

## 📄 许可证

MIT License
