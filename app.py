"""
酒店智能化咨询网站 - 后端服务
"""

from flask import Flask, render_template, request, jsonify
import json
import os

app = Flask(__name__)

# 配置
COZE_API_URL = os.getenv('COZE_API_URL', 'https://api.coze.cn/open_api/v2/chat')
COZE_API_KEY = os.getenv('COZE_API_KEY', '')
SKILL_NAME = 'hotel-smart-systems'

@app.route('/')
def index():
    """首页"""
    return render_template('index.html')

@app.route('/consult')
def consult():
    """智能咨询页面"""
    return render_template('consult.html')

@app.route('/generate-plan')
def generate_plan():
    """方案生成页面"""
    return render_template('generate_plan.html')

@app.route('/api/chat', methods=['POST'])
def chat():
    """
    智能对话API
    调用智能体（集成hotel-smart-systems Skill）回答用户问题
    """
    data = request.json
    user_message = data.get('message', '')

    if not user_message:
        return jsonify({'error': '消息不能为空'}), 400

    try:
        # TODO: 集成真实的Coze智能体API
        # 这里先返回模拟响应，用户需要配置真实的API调用
        response = call_coze_api(user_message)
        return jsonify({
            'success': True,
            'message': response
        })

    except Exception as e:
        return jsonify({
            'success': False,
            'error': str(e)
        }), 500

@app.route('/api/generate-plan', methods=['POST'])
def generate_plan_api():
    """
    智能化方案生成API
    根据用户输入的酒店参数，生成智能化设计方案
    """
    data = request.json

    # 构建提示词
    prompt = f"""
    请为以下酒店生成智能化系统设计方案：

    酒店类型：{data.get('hotel_type', '')}
    星级标准：{data.get('hotel_star', '')}
    客房数量：{data.get('room_count', '')}
    公共区域：{data.get('public_areas', '')}
    品牌要求：{data.get('brand', '')}
    预算范围：{data.get('budget', '')}

    请按照以下结构输出：
    1. 系统模块规划
    2. 设备配置清单
    3. 投资估算
    4. 实施建议
    """

    try:
        # TODO: 调用智能体生成方案
        response = call_coze_api(prompt)
        return jsonify({
            'success': True,
            'plan': response
        })

    except Exception as e:
        return jsonify({
            'success': False,
            'error': str(e)
        }), 500

@app.route('/api/templates')
def list_templates():
    """
    获取文档模板列表
    """
    templates = [
        {
            'id': 1,
            'name': '智能化设计说明书模板',
            'file': 'design-specification.md',
            'description': '用于生成智能化设计说明书的完整模板'
        },
        {
            'id': 2,
            'name': '验收报告模板',
            'file': 'acceptance-report.md',
            'description': '用于生成系统验收报告的标准模板'
        }
    ]
    return jsonify({'success': True, 'templates': templates})

def call_coze_api(message):
    """
    调用Coze智能体API
    需要用户配置COZE_API_KEY和COZE_BOT_ID
    """
    # TODO: 这里是模拟响应，实际使用时需要配置真实的API调用
    # 示例代码（仅供参考）：
    #
    # import requests
    #
    # headers = {
    #     'Authorization': f'Bearer {COZE_API_KEY}',
    #     'Content-Type': 'application/json'
    # }
    #
    # data = {
    #     'bot_id': os.getenv('COZE_BOT_ID', ''),
    #     'user': 'user_' + str(hash(message)),
    #     'query': message,
    #     'stream': False
    # }
    #
    # response = requests.post(COZE_API_URL, headers=headers, json=data)
    # response.raise_for_status()
    #
    # result = response.json()
    # return result['messages'][0]['content']

    # 模拟响应
    return """
    [智能体回复]

    基于您的问题，我已调用hotel-smart-systems Skill为您提供专业解答：

    1. 系统配置建议...
    2. 施工注意事项...
    3. 专业配合要点...

    （请配置真实的Coze API后获取实际回复）
    """

if __name__ == '__main__':
    print('酒店智能化咨询网站启动中...')
    print('访问地址: http://localhost:5000')
    print('\n注意: 如需调用智能体，请配置以下环境变量:')
    print('  - COZE_API_KEY: Coze API密钥')
    print('  - COZE_BOT_ID: 智能体ID（已集成hotel-smart-systems Skill）')
    app.run(debug=True, host='0.0.0.0', port=5000)
