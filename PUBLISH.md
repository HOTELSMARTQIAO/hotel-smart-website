# 网站发布指南 - 3种方式

## 方式一：本地预览（最快）

### 启动网站
```bash
cd /workspace/projects/hotel-smart-website
python3 app.py
```

### 访问
打开浏览器：http://localhost:5000

**适合**：快速测试、本地演示

---

## 方式二：免费云平台（推荐新手）

### 选项A：PythonAnywhere（免费）

#### 1. 注册账号
访问：https://www.pythonanywhere.com

#### 2. 创建Web应用
- 点击 "Web" → "Add a new web app"
- 选择 "Flask"
- Python版本选择 "3.9"

#### 3. 上传代码
```bash
# 在PythonAnywhere的Bash中
git clone your-repo-url
cd hotel-smart-website
```

#### 4. 安装依赖
```bash
pip install -r requirements.txt
```

#### 5. 配置环境变量
在 Web 标签页 → Virtualenv → Environment Variables 添加：
```
COZE_API_KEY=your_api_key
COZE_BOT_ID=your_bot_id
```

#### 6. 修改WSGI文件
在 /var/www/xxx_pythonanywhere_com_wsgi.py：
```python
from app import app as application
```

#### 7. 重载Web应用
点击 "Reload"

**访问**：https://yourname.pythonanywhere.com

---

### 选项B：Render（免费）

#### 1. 注册账号
访问：https://render.com

#### 2. 创建Web Service
- 点击 "New" → "Web Service"
- 连接GitHub仓库

#### 3. 配置构建
```yaml
# 在项目中创建 render.yaml
services:
  - type: web
    name: hotel-smart-website
    env: python
    buildCommand: pip install -r requirements.txt
    startCommand: gunicorn app:app
    envVars:
      - key: COZE_API_KEY
        value: your_api_key
      - key: COZE_BOT_ID
        value: your_bot_id
```

#### 4. 部署
点击 "Create Web Service"

**访问**：https://hotel-smart-website.onrender.com

---

### 选项C：Vercel（免费）

#### 1. 安装Vercel CLI
```bash
npm install -g vercel
```

#### 2. 登录
```bash
vercel login
```

#### 3. 部署
```bash
cd /workspace/projects/hotel-smart-website
vercel
```

#### 4. 配置环境变量
在Vercel控制台设置：
- COZE_API_KEY
- COZE_BOT_ID

**访问**：https://hotel-smart-website.vercel.app

---

## 方式三：云服务器（推荐企业）

### 选项A：阿里云ECS

#### 1. 购买服务器
- 访问：https://www.aliyun.com
- 购买ECS实例（2核4GB，Ubuntu 20.04）

#### 2. 连接服务器
```bash
ssh root@your-server-ip
```

#### 3. 安装环境
```bash
apt update
apt install python3 python3-pip nginx supervisor
```

#### 4. 上传代码
```bash
# 在服务器上
git clone your-repo-url
cd hotel-smart-website
```

#### 5. 创建虚拟环境
```bash
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
pip install gunicorn
```

#### 6. 配置环境变量
```bash
cp .env.example .env
nano .env
```

#### 7. 启动Gunicorn
```bash
gunicorn -w 4 -b 127.0.0.1:5000 app:app
```

#### 8. 配置Nginx
```bash
nano /etc/nginx/sites-available/hotel-smart
```

配置内容：
```nginx
server {
    listen 80;
    server_name your-domain.com;

    location / {
        proxy_pass http://127.0.0.1:5000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }
}
```

启用配置：
```bash
ln -s /etc/nginx/sites-available/hotel-smart /etc/nginx/sites-enabled/
nginx -t
systemctl reload nginx
```

#### 9. 购买域名并解析
- 在阿里云购买域名
- 添加A记录指向服务器IP

**访问**：http://your-domain.com

---

### 选项B：腾讯云CVM

#### 部署步骤与阿里云类似
- 访问：https://cloud.tencent.com
- 购买CVM实例
- 按照阿里云步骤配置

---

## 方式四：Docker部署（推荐开发者）

### 使用Docker Compose

#### 1. 确保安装Docker
```bash
docker --version
docker-compose --version
```

#### 2. 配置环境变量
```bash
cd /workspace/projects/hotel-smart-website
cp .env.example .env
nano .env
```

#### 3. 启动容器
```bash
docker-compose up -d
```

#### 4. 查看日志
```bash
docker-compose logs -f
```

**访问**：http://localhost:5000

---

## 方式五：使用GitHub Pages（静态部署）

**注意**：只适合静态页面，不支持Flask后端

### 1. 创建GitHub仓库

### 2. 上传HTML/CSS/JS文件

### 3. 启用GitHub Pages
- Settings → Pages
- 选择分支（main）
- 点击Save

**访问**：https://yourname.github.io/hotel-smart-website

---

## ⚡ 快速对比

| 方式 | 成本 | 难度 | 功能完整性 | 推荐场景 |
|------|------|------|-----------|---------|
| 本地预览 | 免费 | 简单 | 完整 | 测试、演示 |
| PythonAnywhere | 免费/低价 | 简单 | 完整 | 个人项目 |
| Render | 免费 | 简单 | 完整 | 个人项目 |
| Vercel | 免费 | 简单 | 完整 | 个人项目 |
| 阿里云ECS | 付费 | 中等 | 完整 | 企业项目 |
| 腾讯云CVM | 付费 | 中等 | 完整 | 企业项目 |
| Docker | 免费 | 中等 | 完整 | 开发者 |

---

## 🎯 推荐方案

### 如果你是新手
**选择**：PythonAnywhere 或 Render
- 免费
- 简单
- 支持完整功能

### 如果你是企业
**选择**：阿里云ECS 或 腾讯云CVM
- 稳定可靠
- 性能好
- 支持定制

### 如果你是开发者
**选择**：Docker
- 环境一致
- 易于部署
- 便于管理

---

## 📝 发布前检查清单

### 代码检查
- [ ] 所有功能已测试
- [ ] 环境变量已配置
- [ ] 依赖包已安装

### 配置检查
- [ ] API Key 已配置
- [ ] Bot ID 已配置
- [ ] 端口已设置

### 功能检查
- [ ] 首页可访问
- [ ] 咨询页可访问
- [ ] 方案生成页可访问
- [ ] API接口正常

### 性能检查
- [ ] 响应速度正常
- [ ] 无明显错误
- [ ] 资源加载正常

---

## 🔐 安全建议

1. **不要提交.env文件到Git**
2. **使用HTTPS**（配置SSL证书）
3. **定期更新依赖**
4. **限制API访问频率**
5. **使用强密码**
6. **定期备份数据**

---

## 📞 遇到问题？

### 常见问题

**Q: 端口被占用？**
A: 修改app.py中的端口，或使用8080

**Q: API调用失败？**
A: 检查环境变量配置

**Q: 页面404？**
A: 检查Nginx配置和路由

**Q: 静态资源加载失败？**
A: 检查static路径和权限

---

## 🎉 发布成功！

发布后，请分享您的网站地址！

如需帮助，请查看详细文档或询问我！
