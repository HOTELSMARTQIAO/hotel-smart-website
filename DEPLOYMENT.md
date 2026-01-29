# 酒店智能化咨询网站 - 部署指南

## 快速启动（本地开发）

### 方式一：使用启动脚本（推荐）

```bash
# 1. 进入项目目录
cd hotel-smart-website

# 2. 运行启动脚本
./start.sh
```

启动脚本会自动：
- 检查Python环境
- 创建虚拟环境
- 安装依赖
- 检查环境变量配置
- 启动Flask应用

### 方式二：手动启动

```bash
# 1. 创建虚拟环境
python3 -m venv venv

# 2. 激活虚拟环境
source venv/bin/activate  # Linux/Mac
# 或
venv\Scripts\activate     # Windows

# 3. 安装依赖
pip install -r requirements.txt

# 4. 配置环境变量
cp .env.example .env
# 编辑.env文件，填入API密钥

# 5. 启动应用
python app.py
```

### 方式三：使用Docker

```bash
# 1. 构建镜像
docker build -t hotel-smart-website .

# 2. 运行容器
docker run -p 5000:5000 \
  -e COZE_API_KEY=your_api_key \
  -e COZE_BOT_ID=your_bot_id \
  hotel-smart-website
```

### 方式四：使用Docker Compose

```bash
# 1. 配置环境变量
cp .env.example .env
# 编辑.env文件

# 2. 启动服务
docker-compose up -d

# 3. 查看日志
docker-compose logs -f
```

---

## 获取 Coze API 密钥

### 步骤1：注册 Coze 账号

访问：https://www.coze.cn

### 步骤2：创建智能体（Bot）

1. 登录后点击"创建Bot"
2. 填写Bot信息：
   - 名称：酒店智能化专家
   - 描述：专业的酒店智能化设计施工交付咨询助手

### 步骤3：添加 Skill

1. 进入Bot编辑页面
2. 点击"插件/Skill"
3. 上传 `hotel-smart-systems.skill` 文件
4. 配置Skill触发条件（可选）

### 步骤4：获取 API 信息

1. 在Bot设置中，点击"API配置"
2. 获取以下信息：
   - **API Key**（Personal Access Token）
   - **Bot ID**

### 步骤5：配置网站

编辑 `.env` 文件：

```env
COZE_API_KEY=pat_xxxxxxxxxxxxxxxx  # 替换为你的API Key
COZE_BOT_ID=7389xxxxxxxxxxxxxx     # 替换为你的Bot ID
```

---

## 生产环境部署

### 使用 Gunicorn + Nginx

#### 1. 安装 Gunicorn

```bash
pip install gunicorn
```

#### 2. 启动 Gunicorn

```bash
gunicorn -w 4 -b 0.0.0.0:5000 app:app
```

参数说明：
- `-w 4`：4个工作进程
- `-b 0.0.0.0:5000`：绑定到5000端口
- `app:app`：模块名:应用名

#### 3. 配置 Nginx

创建 Nginx 配置文件 `/etc/nginx/sites-available/hotel-smart`：

```nginx
server {
    listen 80;
    server_name your-domain.com;

    location / {
        proxy_pass http://127.0.0.1:5000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    }

    location /static {
        alias /path/to/hotel-smart-website/static;
    }

    location /templates {
        alias /path/to/hotel-smart-website/templates;
    }
}
```

启用配置：

```bash
sudo ln -s /etc/nginx/sites-available/hotel-smart /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl reload nginx
```

### 使用 Supervisor（进程管理）

安装 Supervisor：

```bash
sudo apt-get install supervisor
```

创建配置文件 `/etc/supervisor/conf.d/hotel-smart.conf`：

```ini
[program:hotel-smart]
directory=/path/to/hotel-smart-website
command=/path/to/venv/bin/gunicorn -w 4 -b 0.0.0.0:5000 app:app
user=www-data
autostart=true
autorestart=true
stderr_logfile=/var/log/hotel-smart.err.log
stdout_logfile=/var/log/hotel-smart.out.log
environment=COZE_API_KEY="your_api_key",COZE_BOT_ID="your_bot_id"
```

启动服务：

```bash
sudo supervisorctl reread
sudo supervisorctl update
sudo supervisorctl start hotel-smart
```

### 使用 Systemd（系统服务）

创建服务文件 `/etc/systemd/system/hotel-smart.service`：

```ini
[Unit]
Description=Hotel Smart Website
After=network.target

[Service]
User=www-data
WorkingDirectory=/path/to/hotel-smart-website
Environment="PATH=/path/to/venv/bin"
Environment="COZE_API_KEY=your_api_key"
Environment="COZE_BOT_ID=your_bot_id"
ExecStart=/path/to/venv/bin/gunicorn -w 4 -b 0.0.0.0:5000 app:app
Restart=always

[Install]
WantedBy=multi-user.target
```

启动服务：

```bash
sudo systemctl daemon-reload
sudo systemctl start hotel-smart
sudo systemctl enable hotel-smart
```

---

## 云服务器部署

### 阿里云 ECS

1. 购买ECS实例（推荐：2核4GB，Ubuntu 20.04）
2. 安装必要软件：

```bash
sudo apt update
sudo apt install python3 python3-pip nginx supervisor
```

3. 部署应用：

```bash
# 克隆代码
git clone your-repo-url
cd hotel-smart-website

# 创建虚拟环境
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt

# 配置环境变量
cp .env.example .env
nano .env
```

4. 配置Nginx和Supervisor（参考上文）

### 腾讯云 CVM

部署步骤与阿里云类似，使用Ubuntu或CentOS系统。

### 使用云服务（Serverless）

#### 使用 Vercel

1. 创建 `vercel.json`：

```json
{
  "version": 2,
  "builds": [
    {
      "src": "app.py",
      "use": "@vercel/python"
    }
  ],
  "routes": [
    {
      "src": "/(.*)",
      "dest": "app.py"
    }
  ]
}
```

2. 安装 Vercel CLI：

```bash
npm i -g vercel
```

3. 部署：

```bash
vercel
```

---

## 域名配置

### 1. 购买域名

在阿里云、腾讯云等平台购买域名。

### 2. 配置DNS解析

将域名解析到服务器IP地址：

```
类型: A
主机记录: @
记录值: your-server-ip

类型: A
主机记录: www
记录值: your-server-ip
```

### 3. 配置SSL证书（HTTPS）

使用 Let's Encrypt 免费证书：

```bash
sudo apt install certbot python3-certbot-nginx

# 自动配置Nginx
sudo certbot --nginx -d your-domain.com -d www.your-domain.com
```

---

## 监控和日志

### 查看应用日志

```bash
# Supervisor
sudo supervisorctl tail -f hotel-smart

# Systemd
sudo journalctl -u hotel-smart -f

# Docker
docker-compose logs -f
```

### 性能监控

推荐工具：
- **Sentry**：错误监控
- **Prometheus + Grafana**：性能监控
- **New Relic**：应用性能管理

---

## 故障排查

### 问题1：无法访问网站

检查项：
- Flask应用是否正常运行
- Nginx配置是否正确
- 防火墙是否开放5000/80端口

```bash
# 检查Flask进程
ps aux | grep gunicorn

# 检查端口占用
netstat -tlnp | grep 5000

# 检查防火墙
sudo ufw status
```

### 问题2：API调用失败

检查项：
- `.env` 文件是否正确配置
- API Key和Bot ID是否正确
- 网络连接是否正常

### 问题3：静态资源加载失败

检查项：
- Nginx静态资源配置
- 文件路径是否正确
- 文件权限是否正确

---

## 安全建议

1. **不要提交 `.env` 文件到Git**
2. **使用HTTPS**（配置SSL证书）
3. **定期更新依赖**
4. **限制API访问频率**
5. **使用强密码**
6. **定期备份数据**

---

## 备份和恢复

### 备份

```bash
# 备份代码
tar -czf hotel-smart-website-backup-$(date +%Y%m%d).tar.gz .

# 备份数据库（如果使用）
pg_dump hotel_smart > hotel_smart-$(date +%Y%m%d).sql
```

### 恢复

```bash
# 解压备份
tar -xzf hotel-smart-website-backup-20240101.tar.gz

# 恢复数据库
psql hotel_smart < hotel_smart-20240101.sql
```

---

## 性能优化

1. **启用CDN**：加速静态资源加载
2. **使用缓存**：Redis缓存常用数据
3. **数据库优化**：添加索引、优化查询
4. **负载均衡**：使用多台服务器
5. **压缩传输**：启用Gzip压缩

---

## 联系支持

如有问题，请访问：
- 项目仓库：[您的GitHub地址]
- 文档：README.md
- 邮箱：[您的邮箱]
