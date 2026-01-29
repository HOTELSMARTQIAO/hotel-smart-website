# 酒店智能化咨询网站

一个专业的酒店智能化设计施工交付咨询平台，集成 `hotel-smart-systems` Skill，提供系统规划、施工指导、验收标准等专业服务。

## 功能特性

### 🏨 核心服务
- **智能咨询**：基于AI智能体的专业问答服务
- **方案生成**：根据酒店参数自动生成智能化设计方案
- **知识库**：完整的酒店智能化专业知识体系

### 📋 支持的系统
- 客房控制系统（RCU）
- 电子门锁系统
- 安防监控系统
- 楼宇自动化系统（BA）
- 综合布线系统
- 计算机网络系统
- 背景音乐与公共广播系统

### 🎯 品牌标准
- 希尔顿 Hilton
- 万豪 Marriott
- 凯悦 Hyatt
- 洲际 IHG
- 雅高 Accor

## 技术栈

- **前端**：HTML5 + CSS3 + JavaScript
- **后端**：Python Flask
- **AI集成**：Coze智能体API（需配置）
- **Skill**：hotel-smart-systems

## 快速开始

### 1. 安装依赖

```bash
pip install -r requirements.txt
```

### 2. 配置环境变量

创建 `.env` 文件：

```env
# Coze API配置
COZE_API_KEY=your_coze_api_key
COZE_BOT_ID=your_coze_bot_id
COZE_API_URL=https://api.coze.cn/open_api/v2/chat

# Flask配置
FLASK_ENV=development
```

### 3. 启动网站

```bash
python app.py
```

访问：http://localhost:5000

## 如何集成 Skill

### 步骤1：准备 Skill 文件

确保您有 `hotel-smart-systems.skill` 文件。

### 步骤2：在 Coze 平台配置智能体

1. 登录 Coze 平台（https://www.coze.cn）
2. 创建一个新的智能体（Bot）
3. 在智能体配置中，添加 Skill：
   - 上传 `hotel-smart-systems.skill`
   - 配置 Skill 触发条件
4. 获取智能体 ID（BOT_ID）
5. 获取 API Key

### 步骤3：配置网站

将获取的 API Key 和 BOT_ID 填入 `.env` 文件：

```env
COZE_API_KEY=your_actual_api_key
COZE_BOT_ID=your_actual_bot_id
```

### 步骤4：测试集成

访问网站首页，尝试以下问题：
- "设计一个五星级酒店智能化方案"
- "客控系统施工时需要注意什么？"
- "智能化系统验收标准是什么？"

## 项目结构

```
hotel-smart-website/
├── app.py                      # Flask后端服务
├── requirements.txt            # Python依赖
├── README.md                   # 项目说明
├── templates/                  # HTML模板
│   ├── index.html             # 首页
│   ├── consult.html            # 智能咨询页面
│   └── generate_plan.html      # 方案生成页面
├── static/                     # 静态资源
│   ├── css/
│   │   └── style.css          # 样式文件
│   ├── js/
│   │   ├── main.js            # 首页脚本
│   │   ├── consult.js         # 咨询页面脚本
│   │   └── generate_plan.js   # 方案生成脚本
│   └── images/                 # 图片资源
└── skill-data/                 # Skill相关数据
```

## API 接口

### 1. 智能对话接口

**请求**：
```
POST /api/chat
Content-Type: application/json

{
  "message": "设计一个五星级酒店智能化方案"
}
```

**响应**：
```json
{
  "success": true,
  "message": "智能体回复内容..."
}
```

### 2. 方案生成接口

**请求**：
```
POST /api/generate-plan
Content-Type: application/json

{
  "hotel_type": "商务酒店",
  "hotel_star": "五星",
  "room_count": "200",
  "public_areas": "大堂、餐厅、会议室",
  "brand": "万豪",
  "budget": "500-800万"
}
```

**响应**：
```json
{
  "success": true,
  "plan": "智能化设计方案..."
}
```

### 3. 模板列表接口

**请求**：
```
GET /api/templates
```

**响应**：
```json
{
  "success": true,
  "templates": [
    {
      "id": 1,
      "name": "智能化设计说明书模板",
      "file": "design-specification.md"
    }
  ]
}
```

## 部署建议

### 开发环境
```bash
python app.py
```

### 生产环境
使用 Gunicorn + Nginx：

```bash
# 安装 Gunicorn
pip install gunicorn

# 启动服务
gunicorn -w 4 -b 0.0.0.0:5000 app:app
```

### Docker 部署（可选）

创建 `Dockerfile`：

```dockerfile
FROM python:3.9-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install -r requirements.txt

COPY . .

EXPOSE 5000

CMD ["gunicorn", "-w", "4", "-b", "0.0.0.0:5000", "app:app"]
```

构建和运行：

```bash
docker build -t hotel-smart-website .
docker run -p 5000:5000 hotel-smart-website
```

## 注意事项

### Skill 调用说明
- 目前网站的 Skill 调用部分是**模拟响应**
- 需要配置真实的 Coze API 才能实际调用 Skill
- 参考下方"如何获取 Coze API"章节

### 如何获取 Coze API

1. 注册 Coze 平台：https://www.coze.cn
2. 创建智能体（Bot）
3. 在智能体中添加 Skill
4. 进入智能体设置 → API配置
5. 获取 API Key 和 Bot ID

### 环境变量配置
```env
# Coze API配置（必需）
COZE_API_KEY=pat_xxxxxxxxxxxxxxxx
COZE_BOT_ID=7389xxxxxxxxxxxxxx

# API地址（可选，默认为Coze国内版）
COZE_API_URL=https://api.coze.cn/open_api/v2/chat
```

## 许可证

MIT License

## 联系方式

如有问题，请联系：[您的联系方式]
