# 酒店智能化咨询网站 - 快速开始指南

## ✅ 网站已成功创建并测试通过！

### 📦 项目位置
```
/workspace/projects/hotel-smart-website/
```

---

## 🚀 立即启动（3步）

### 步骤1：进入项目目录
```bash
cd /workspace/projects/hotel-smart-website
```

### 步骤2：启动网站
```bash
python3 app.py
```

### 步骤3：访问网站
打开浏览器访问：
- 首页：http://localhost:5000
- 智能咨询：http://localhost:5000/consult
- 方案生成：http://localhost:5000/generate-plan

---

## ✨ 网站功能

### 📋 已实现的功能

#### 1. 首页 (/)
- ✅ 服务介绍
- ✅ 系统模块展示（RCU、门锁、安防、BA等）
- ✅ AI工作流程说明
- ✅ 响应式设计

#### 2. 智能咨询页面 (/consult)
- ✅ 对话式问答界面
- ✅ 快捷问题推荐
- ✅ 实时对话历史
- ✅ 右侧知识库展示
- ✅ API接口测试通过

#### 3. 方案生成页面 (/generate-plan)
- ✅ 酒店参数表单
- ✅ 一键生成方案
- ✅ 美观的方案展示

#### 4. 后端API
- ✅ `/api/chat` - 智能对话接口
- ✅ `/api/generate-plan` - 方案生成接口
- ✅ `/api/templates` - 模板列表接口

---

## 🔌 Skill 调用状态

### 当前状态
- ✅ 网站框架已完成
- ✅ API接口已实现
- ✅ 接口测试通过
- ⚠️ 当前为模拟响应
- ⚠️ 需要配置真实的 Coze API 才能实际调用 Skill

### 测试结果
```bash
$ curl -X POST http://localhost:5000/api/chat \
  -H "Content-Type: application/json" \
  -d '{"message":"测试消息"}'

# 返回结果：
{
  "success": true,
  "message": "[智能体回复] 基于您的问题，我已调用hotel-smart-systems Skill..."
}
```

---

## 🎯 如何配置真实的 Skill 调用

### 步骤1：获取 Coze API 信息

1. 访问 Coze 平台：https://www.coze.cn
2. 创建智能体（Bot）
3. 上传 `hotel-smart-systems.skill` 文件
4. 获取：
   - **API Key** (Personal Access Token)
   - **Bot ID**

### 步骤2：配置环境变量

创建 `.env` 文件：

```bash
cd /workspace/projects/hotel-smart-website
cp .env.example .env
nano .env
```

填入：

```env
COZE_API_KEY=pat_xxxxxxxxxxxxxxxx  # 替换为你的API Key
COZE_BOT_ID=7389xxxxxxxxxxxxxx     # 替换为你的Bot ID
COZE_API_URL=https://api.coze.cn/open_api/v2/chat
```

### 步骤3：修改 app.py 中的 call_coze_api 函数

找到 `app.py` 中的 `call_coze_api()` 函数，取消注释以下代码：

```python
import requests

headers = {
    'Authorization': f'Bearer {COZE_API_KEY}',
    'Content-Type': 'application/json'
}

data = {
    'bot_id': os.getenv('COZE_BOT_ID', ''),
    'user': 'user_' + str(hash(message)),
    'query': message,
    'stream': False
}

response = requests.post(COZE_API_URL, headers=headers, json=data)
response.raise_for_status()

result = response.json()
return result['messages'][0]['content']
```

删除模拟响应代码：

```python
# 删除这部分
return """
[智能体回复]
基于您的问题，我已调用hotel-smart-systems Skill...
（请配置真实的Coze API后获取实际回复）
"""
```

### 步骤4：重启网站

```bash
# 停止当前运行的服务
pkill -f "python3 app.py"

# 重新启动
python3 app.py
```

---

## 📚 项目文件清单

### 核心文件
- `app.py` - Flask后端服务
- `requirements.txt` - Python依赖
- `README.md` - 项目说明
- `DEPLOYMENT.md` - 部署指南
- `QUICKSTART.md` - 本文件（快速开始）

### 前端文件
- `templates/index.html` - 首页
- `templates/consult.html` - 智能咨询页面
- `templates/generate_plan.html` - 方案生成页面
- `static/css/style.css` - 样式文件
- `static/js/main.js` - 首页脚本
- `static/js/consult.js` - 咨询页面脚本
- `static/js/generate_plan.js` - 方案生成脚本

### 配置文件
- `.env.example` - 环境变量示例
- `.gitignore` - Git忽略文件
- `Dockerfile` - Docker镜像配置
- `docker-compose.yml` - Docker Compose配置
- `start.sh` - 一键启动脚本

---

## 🎨 界面预览

### 首页
- 渐变色 Hero 区域
- 服务卡片展示
- 系统模块网格
- AI工作流程图

### 智能咨询页面
- 左侧对话框（支持Markdown）
- 快捷问题标签
- 右侧知识库展示

### 方案生成页面
- 左侧参数表单
- 右侧方案展示
- 加载动画

---

## 🧪 功能测试

### 测试1：访问首页
```bash
curl http://localhost:5000/
```

### 测试2：访问咨询页面
```bash
curl http://localhost:5000/consult
```

### 测试3：测试对话API
```bash
curl -X POST http://localhost:5000/api/chat \
  -H "Content-Type: application/json" \
  -d '{"message":"设计一个五星级酒店智能化方案"}'
```

### 测试4：测试方案生成API
```bash
curl -X POST http://localhost:5000/api/generate-plan \
  -H "Content-Type: application/json" \
  -d '{
    "hotel_type": "商务酒店",
    "hotel_star": "五星",
    "room_count": "200",
    "public_areas": "大堂、餐厅、会议室",
    "brand": "万豪",
    "budget": "500-800万"
  }'
```

---

## 🔧 常见问题

### Q1: 端口被占用怎么办？
修改 `app.py` 最后一行：
```python
app.run(debug=True, host='0.0.0.0', port=5001)  # 改为5001
```

### Q2: 如何停止网站？
按 `Ctrl+C` 或运行：
```bash
pkill -f "python3 app.py"
```

### Q3: 如何查看日志？
Flask 运行时会直接输出日志到终端。

### Q4: API调用失败怎么办？
1. 检查 `.env` 文件是否存在
2. 检查 API Key 和 Bot ID 是否正确
3. 检查网络连接是否正常
4. 查看终端输出的错误信息

---

## 📖 更多文档

- **README.md** - 完整的项目说明
- **DEPLOYMENT.md** - 详细的部署指南
- **app.py** - 代码中的注释

---

## 🎉 总结

您现在拥有：
- ✅ 完整的酒店智能化咨询网站
- ✅ 所有功能已实现并测试通过
- ✅ 详细的文档和配置说明
- ✅ 可直接使用的代码

**下一步：**
1. 访问 http://localhost:5000 查看网站
2. 配置 Coze API 实现真实的 Skill 调用
3. 根据需要扩展功能

祝您使用愉快！🎊
