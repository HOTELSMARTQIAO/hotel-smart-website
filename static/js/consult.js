// 智能咨询页面JavaScript

// 发送消息
async function sendMessage() {
    const input = document.getElementById('userInput');
    const message = input.value.trim();

    if (!message) return;

    // 显示用户消息
    appendMessage('user', message);
    input.value = '';

    // 显示加载状态
    showLoading();

    try {
        // 调用后端API
        const response = await fetch('/api/chat', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ message: message })
        });

        const data = await response.json();

        if (data.success) {
            appendMessage('system', data.message);
        } else {
            appendMessage('system', '抱歉，处理您的请求时出现错误：' + (data.error || '未知错误'));
        }
    } catch (error) {
        appendMessage('system', '网络错误，请稍后重试');
    } finally {
        hideLoading();
    }
}

// 快捷提问
function askQuestion(question) {
    document.getElementById('userInput').value = question;
    sendMessage();
}

// 添加消息到聊天区域
function appendMessage(type, content) {
    const messagesDiv = document.getElementById('chatMessages');
    const messageDiv = document.createElement('div');
    messageDiv.className = `message ${type}`;

    const contentDiv = document.createElement('div');
    contentDiv.className = 'message-content';

    // 如果是系统消息，支持Markdown简单格式
    if (type === 'system') {
        contentDiv.innerHTML = formatMessage(content);
    } else {
        contentDiv.textContent = content;
    }

    messageDiv.appendChild(contentDiv);
    messagesDiv.appendChild(messageDiv);

    // 滚动到底部
    messagesDiv.scrollTop = messagesDiv.scrollHeight;
}

// 格式化消息（简单Markdown解析）
function formatMessage(message) {
    return message
        .replace(/\n/g, '<br>')
        .replace(/\*\*(.*?)\*\*/g, '<strong>$1</strong>')
        .replace(/\*(.*?)\*/g, '<em>$1</em>')
        .replace(/`(.*?)`/g, '<code>$1</code>')
        .replace(/^### (.*$)/gm, '<h3>$1</h3>')
        .replace(/^## (.*$)/gm, '<h2>$1</h2>')
        .replace(/^# (.*$)/gm, '<h1>$1</h1>')
        .replace(/^- (.*$)/gm, '<li>$1</li>');
}

// 显示加载状态
function showLoading() {
    const loadingDiv = document.createElement('div');
    loadingDiv.id = 'chatLoading';
    loadingDiv.className = 'message system';
    loadingDiv.innerHTML = '<div class="message-content"><div class="spinner"></div>正在思考...</div>';
    document.getElementById('chatMessages').appendChild(loadingDiv);
    document.getElementById('chatMessages').scrollTop = document.getElementById('chatMessages').scrollHeight;
}

// 隐藏加载状态
function hideLoading() {
    const loadingDiv = document.getElementById('chatLoading');
    if (loadingDiv) {
        loadingDiv.remove();
    }
}

// 按Enter发送消息
document.getElementById('userInput').addEventListener('keypress', function(e) {
    if (e.key === 'Enter' && !e.shiftKey) {
        e.preventDefault();
        sendMessage();
    }
});
