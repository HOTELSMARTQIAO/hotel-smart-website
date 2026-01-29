# 快速开始指南

## 3分钟启动网站

### 步骤1：安装依赖
```bash
pip install -r requirements.txt
```

### 步骤2：启动网站
```bash
python3 app.py
```

### 步骤3：访问网站
打开浏览器访问：http://localhost:5000

---

## 功能测试

### 测试1：访问首页
访问：http://localhost:5000

### 测试2：智能咨询
访问：http://localhost:5000/consult
输入问题："设计一个五星级酒店智能化方案"

### 测试3：方案生成
访问：http://localhost:5000/generate-plan
填写表单，点击"生成方案"

---

## 部署到Render

详见：[DEPLOY_RENDER.md](DEPLOY_RENDER.md)

快速步骤：
1. 推送代码到GitHub
2. 在Render创建Web Service
3. 添加环境变量：`FLASK_ENV=production`
4. 访问：https://hotel-smart-website.onrender.com

---

## 配置Coze API（可选）

如需真实的Skill调用，配置以下环境变量：

```env
COZE_API_KEY=pat_xxxxxxxxxxxxxxxx
COZE_BOT_ID=7389xxxxxxxxxxxxxx
```

详见：[DEPLOY_RENDER.md](DEPLOY_RENDER.md)

---

## 常见问题

**Q: 端口被占用？**
A: 修改app.py中的port参数

**Q: API调用失败？**
A: 检查环境变量配置

**Q: 如何停止服务？**
A: 按Ctrl+C

---

详细文档：[README.md](README.md)
