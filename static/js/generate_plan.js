// 方案生成页面JavaScript

// 生成方案
async function generatePlan(event) {
    event.preventDefault();

    const form = document.getElementById('planForm');
    const formData = new FormData(form);

    // 构建请求数据
    const data = {
        hotel_type: formData.get('hotel_type'),
        hotel_star: formData.get('hotel_star'),
        room_count: formData.get('room_count'),
        public_areas: formData.get('public_areas'),
        brand: formData.get('brand'),
        budget: formData.get('budget'),
        requirements: formData.get('requirements')
    };

    // 显示加载状态
    document.getElementById('planResult').classList.add('hidden');
    document.getElementById('loadingPlan').classList.remove('hidden');

    try {
        // 调用后端API
        const response = await fetch('/api/generate-plan', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(data)
        });

        const result = await response.json();

        if (result.success) {
            // 显示生成的方案
            const resultDiv = document.getElementById('planResult');
            resultDiv.innerHTML = `
                <div class="plan-result-content">
                    ${formatPlan(result.plan)}
                </div>
            `;
            resultDiv.classList.remove('hidden');
        } else {
            alert('生成方案失败：' + (result.error || '未知错误'));
            document.getElementById('planResult').classList.remove('hidden');
        }
    } catch (error) {
        alert('网络错误，请稍后重试');
        document.getElementById('planResult').classList.remove('hidden');
    } finally {
        document.getElementById('loadingPlan').classList.add('hidden');
    }
}

// 格式化方案内容
function formatPlan(content) {
    return content
        .replace(/\n/g, '<br>')
        .replace(/\*\*(.*?)\*\*/g, '<strong>$1</strong>')
        .replace(/\*(.*?)\*/g, '<em>$1</em>')
        .replace(/`(.*?)`/g, '<code>$1</code>')
        .replace(/^### (.*$)/gm, '<h3>$1</h3>')
        .replace(/^## (.*$)/gm, '<h2>$1</h2>')
        .replace(/^# (.*$)/gm, '<h1>$1</h1>')
        .replace(/^- (.*$)/gm, '<li>$1</li>')
        .replace(/^\d+\. (.*$)/gm, '<li>$1</li>');
}
