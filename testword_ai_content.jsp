<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="efw" uri="efw" %>
<html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>単語AI説明</title>
    <efw:Client />
    <link rel="stylesheet" href="css/common.css" type="text/css" />
    <link href="favicon.ico" rel="icon" type="image/x-icon" />
    <script type="text/javascript" src="js/common.js"></script>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', 'Microsoft YaHei', sans-serif;
        }
        
        body {
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            color: #334155;
            line-height: 1.6;
            padding: 20px;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }
        
        .container {
            width: 100%;
            height: 100%;
            /* max-width: 1400px; */
            background: #f0f8ff;
            border-radius: 16px;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.12);
            overflow: hidden;
        }
        
        .tabs-header {
            display: flex;
            /* background: linear-gradient(to right, #f8fafc, #e2e8f0); */
            position: relative;
            border-bottom: 1px solid #e2e8f0;
            padding: 0 20px;
            background-color: #e6f2ff;
        }
        
        .tab {
            padding: 10px 10px;
            cursor: pointer;
            font-weight: 500;
            color: #64748b;
            transition: all 0.3s ease;
            position: relative;
            z-index: 1;
            text-align: center;
            font-size: 1.1rem;
            flex: 1;
            max-width: 200px;
        }
        
        .tab:hover {
            color: #3b82f6;
            background-color: rgba(59, 130, 246, 0.08);
        }
        
        .tab.active {
            color: #1e40af;
            font-weight: 600;
        }
        
        .indicator {
            position: absolute;
            bottom: 0;
            height: 4px;
            background: linear-gradient(90deg, #3b82f6, #1d4ed8);
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            border-radius: 4px 4px 0 0;
            box-shadow: 0 2px 8px rgba(59, 130, 246, 0.4);
        }
        
        .tabs-content {
            padding: 40px 40px;
            min-height: 500px;
            overflow: auto;
            height: 85%;
        }
        
        .tab-content {
            display: none;
        }
        
        .tab-content.active {
            display: block;
        }
        
        .tab-content h2 {
            color: #1e293b;
            margin-bottom: 25px;
            font-size: 2.2rem;
            font-weight: 700;
            background: linear-gradient(90deg, #1e40af, #3b82f6);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            opacity: 0;
            transform: translateY(20px);
        }
        
        .tab-content p {
            color: #475569;
            margin-bottom: 20px;
            font-size: 1.15rem;
            line-height: 1.8;
            opacity: 0;
            transform: translateY(20px);
        }
        
        .tab-content ul {
            padding-left: 30px;
            margin: 25px 0;
        }
        
        .tab-content li {
            margin-bottom: 12px;
            color: #475569;
            font-size: 1.15rem;
            line-height: 1.7;
            padding-left: 10px;
            opacity: 0;
            transform: translateY(20px);
        }
        
        .feature-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 25px;
            margin-top: 30px;
        }
        
        .feature-card {
            background: linear-gradient(135deg, #f8fafc, #e2e8f0);
            padding: 25px;
            border-radius: 12px;
            border-left: 5px solid #3b82f6;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
            opacity: 0;
            transform: translateY(20px);
        }
        
        .feature-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
        }
        
        .feature-card h3 {
            color: #1e40af;
            margin-bottom: 15px;
            font-size: 1.3rem;
            font-weight: 600;
        }
        
        .stats-container {
            display: flex;
            justify-content: space-between;
            margin: 30px 0;
            padding: 25px;
            background: linear-gradient(135deg, #f0f9ff, #e0f2fe);
            border-radius: 12px;
            opacity: 0;
            transform: translateY(20px);
        }
        
        .stat-item {
            text-align: center;
            flex: 1;
        }
        
        .stat-value {
            font-size: 2.5rem;
            font-weight: 700;
            color: #1e40af;
            margin-bottom: 8px;
        }
        
        .stat-label {
            font-size: 1.1rem;
            color: #475569;
        }
        
        .content-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
        }
        
        .logo {
            font-size: 1.8rem;
            font-weight: 700;
            color: #1e40af;
            opacity: 0;
            transform: translateY(20px);
        }
        
        .content-intro {
            font-size: 1.2rem;
            color: #475569;
            margin-bottom: 30px;
            padding: 20px;
            background: #f0f9ff;
            border-radius: 10px;
            border-left: 4px solid #3b82f6;
            opacity: 0;
            transform: translateY(20px);
        }
        
        .typing-cursor {
            display: inline-block;
            width: 2px;
            height: 1.2em;
            background-color: #3b82f6;
            margin-left: 2px;
            animation: blink 1s infinite;
            vertical-align: middle;
        }
        
        @keyframes blink {
            0%, 100% { opacity: 1; }
            50% { opacity: 0; }
        }
        
        .line-animation {
            animation: fadeInUp 0.6s ease forwards;
        }
        
        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        .loading-dots {
            display: inline-block;
            margin-left: 5px;
        }
        
        .loading-dots span {
            display: inline-block;
            width: 6px;
            height: 6px;
            border-radius: 50%;
            background-color: #3b82f6;
            margin: 0 2px;
            animation: loading 1.4s infinite ease-in-out both;
        }
        
        .loading-dots span:nth-child(1) { animation-delay: -0.32s; }
        .loading-dots span:nth-child(2) { animation-delay: -0.16s; }
        
        @keyframes loading {
            0%, 80%, 100% { 
                transform: scale(0);
                opacity: 0.5;
            } 
            40% { 
                transform: scale(1);
                opacity: 1;
            }
        }

        
        header {
            background: linear-gradient(to right, #4dabf5, #74c0fc);
            color: white;
            padding: 20px 30px;
            text-align: center;
        }
        
        h1 {
            font-size: 2.2rem;
            margin-bottom: 8px;
        }
        
        .subtitle {
            font-size: 1rem;
            opacity: 0.9;
        }
        
        .content {
            padding: 25px;
        }
        
        .compact-controls {
            background-color: #f0f8ff;
            padding: 15px;
            border-radius: 10px;
            margin-bottom: 20px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
            border: 1px solid #d0e8ff;
        }
        
        .control-row {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            align-items: center;
            justify-content: space-between;
        }
        
        .btn-group {
            display: flex;
            gap: 8px;
        }
        
        .btn {
            padding: 10px 16px;
            border: none;
            border-radius: 50px;
            font-size: 0.9rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 6px;
            background: linear-gradient(to right, #4dabf5, #74c0fc);
            color: white;
            box-shadow: 0 2px 8px rgba(77, 171, 245, 0.3);
        }
        
        .btn:hover:not(:disabled) {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(77, 171, 245, 0.4);
            background: linear-gradient(to right, #3b9ee5, #63b0f0);
        }
        
        .btn:active {
            transform: translateY(0);
        }
        
        .btn:disabled {
            opacity: 0.5;
            cursor: not-allowed;
            transform: none;
            background: linear-gradient(to right, #a5d8ff, #b8e0ff);
            color: #2c5282;
            box-shadow: none;
        }
        
        .slider-group {
            display: flex;
            flex-wrap: wrap;
            gap: 15px;
            flex: 1;
            /* justify-content: space-between; */
        }
        
        .slider-container {
            /* flex: 1; */
            width: 200px;
        }
        
        .slider-container label {
            display: block;
            margin-bottom: 5px;
            font-weight: 500;
            color: #2c5282;
            font-size: 0.9rem;
        }
        
        .slider {
            width: 100%;
            height: 6px;
            -webkit-appearance: none;
            background: #d0e8ff;
            border-radius: 5px;
            outline: none;
        }
        
        .slider::-webkit-slider-thumb {
            -webkit-appearance: none;
            width: 16px;
            height: 16px;
            border-radius: 50%;
            background: #4dabf5;
            cursor: pointer;
            border: 2px solid white;
            box-shadow: 0 2px 4px rgba(0,0,0,0.2);
        }
        
        .status {
            padding: 12px 15px;
            background-color: #e6f2ff;
            border-radius: 8px;
            display: flex;
            align-items: center;
            gap: 10px;
            font-size: 0.9rem;
            color: #2c5282;
            border: 1px solid #d0e8ff;
        }
        
        .status-indicator {
            width: 10px;
            height: 10px;
            border-radius: 50%;
            background-color: #a5d8ff;
        }
        
        .status-indicator.active {
            background-color: #4dabf5;
            animation: pulse 1.5s infinite;
        }
        
        @keyframes pulse {
            0% { transform: scale(1); opacity: 1; }
            50% { transform: scale(1.2); opacity: 0.7; }
            100% { transform: scale(1); opacity: 1; }
        }
        
        .article {
            margin-bottom: 30px;
        }
        
        .article h2 {
            color: #2c5282;
            margin-bottom: 15px;
            border-bottom: 2px solid #e6f2ff;
            padding-bottom: 10px;
        }
        
        .article p {
            margin-bottom: 15px;
            font-size: 1.1rem;
            text-align: justify;
            color: #2d3748;
        }
        
        .highlight {
            background-color: rgba(77, 171, 245, 0.2);
            transition: background-color 0.3s;
            border-radius: 4px;
            padding: 2px 4px;
        }
        
        footer {
            text-align: center;
            padding: 15px;
            color: #4a5568;
            font-size: 0.85rem;
            border-top: 1px solid #eaeaea;
            background-color: #f7fafc;
        }
        
        @media (max-width: 768px) {
            .control-row {
                flex-direction: column;
                align-items: stretch;
            }
            
            .btn-group {
                width: 100%;
                justify-content: center;
            }
            
            .slider-group {
                width: 100%;
            }
        }
    </style>
    <script>
        function init(){
            Efw('testword_getaicontent');
        }
    </script>
</head>

<body onload="init();">
    <div class="container">
        <div class="compact-controls">
            <div class="control-row">
                <div class="btn-group">
                    <button id="playBtn" class="btn btn-primary">
                        <svg width="18" height="18" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path d="M8 5V19L19 12L8 5Z" fill="currentColor"/>
                        </svg>
                        开始朗读
                    </button>
                    <button id="pauseBtn" class="btn btn-secondary">
                        <svg width="18" height="18" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <rect x="6" y="4" width="4" height="16" fill="currentColor"/>
                            <rect x="14" y="4" width="4" height="16" fill="currentColor"/>
                        </svg>
                        暂停
                    </button>
                    <button id="resumeBtn" class="btn btn-primary">
                        <svg width="18" height="18" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path d="M8 5V19L19 12L8 5Z" fill="currentColor"/>
                        </svg>
                        继续
                    </button>
                    <button id="stopBtn" class="btn btn-secondary">
                        <svg width="18" height="18" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <rect x="6" y="6" width="12" height="12" fill="currentColor"/>
                        </svg>
                        停止
                    </button>
                </div>
                
                <div class="slider-group">
                    <div class="slider-container">
                        <label for="rate">语速: <span id="rateValue">1.0</span></label>
                        <input type="range" id="rate" class="slider" min="1" max="10" step="1" value="2">
                    </div>
                    
                    <div class="slider-container">
                        <label for="pitch">音调: <span id="pitchValue">1.0</span></label>
                        <input type="range" id="pitch" class="slider" min="1" max="10" step="1" value="1">
                    </div>
                    
                    <div class="slider-container">
                        <label for="volume">音量: <span id="volumeValue">1.0</span></label>
                        <input type="range" id="volume" class="slider" min="0" max="10" step="1" value="1">
                    </div>
                </div>

                <div class="status">
                    <div id="statusIndicator" class="status-indicator"></div>
                    <span id="statusText">准备就绪，点击"开始朗读"按钮</span>
                </div>
            </div>
            

        </div>
        <div class="tabs-header">
            <div class="tab" data-tab="tab1" id="tabTitle1" >DeepSeek-中国語</div>
            <div class="tab" data-tab="tab2" id="tabTitle2" >DeepSeek-日本語</div>
            <div class="tab" data-tab="tab3" id="tabTitle3" >豆包-中国語</div>
            <div class="tab" data-tab="tab4" id="tabTitle4" >豆包-日本語</div>
            <div class="indicator"></div>
        </div>
        
        <div class="tabs-content">
            <div class="tab-content" id="tab1" ></div>
            
            <div class="tab-content" id="tab2" ></div>
            
            <div class="tab-content" id="tab3" ></div>
            
            <div class="tab-content" id="tab4" ></div>
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const tabs = document.querySelectorAll('.tab');
            const contents = document.querySelectorAll('.tab-content');
            const indicator = document.querySelector('.indicator');
            
            // 初始化指示器位置
            function initIndicator() {
                const activeTab = document.querySelector('.tab.active');
                if (activeTab) {
                    const tabRect = activeTab.getBoundingClientRect();
                    const containerRect = activeTab.parentElement.getBoundingClientRect();
                    
                    indicator.style.width = `${tabRect.width}px`;
                    indicator.style.left = `${tabRect.left - containerRect.left}px`;
                }
            }
            
            // 逐行显示内容的函数
            function animateContent(content) {
                // 重置所有元素的状态
                const elements = content.querySelectorAll('h2, p, li, .feature-card, .stats-container, .logo, .content-intro');
                elements.forEach(el => {
                    el.style.opacity = '0';
                    el.style.transform = 'translateY(20px)';
                    el.classList.remove('line-animation');
                });
                
                // 逐行动画
                let delay = 0;
                elements.forEach((el, index) => {
                    setTimeout(() => {
                        el.classList.add('line-animation');
                    }, delay);
                    
                    // 根据元素类型设置不同的延迟
                    if (el.tagName === 'H2' || el.classList.contains('logo')) {
                        delay += 200;
                    } else if (el.classList.contains('content-intro')) {
                        delay += 300;
                    } else if (el.classList.contains('stats-container')) {
                        delay += 400;
                    } else if (el.classList.contains('feature-card')) {
                        delay += 100;
                    } else {
                        delay += 100;
                    }
                });
            }
            
            // 切换Tab函数
            function switchTab(tab) {
                // 移除所有active类
                tabs.forEach(t => t.classList.remove('active'));
                contents.forEach(c => c.classList.remove('active'));
                
                // 添加active类到当前tab
                tab.classList.add('active');
                const tabId = tab.getAttribute('data-tab');
                const content = document.getElementById(tabId);
                content.classList.add('active');
                
                // 移动指示器
                const tabRect = tab.getBoundingClientRect();
                const containerRect = tab.parentElement.getBoundingClientRect();
                
                indicator.style.width = `${tabRect.width}px`;
                indicator.style.left = `${tabRect.left - containerRect.left}px`;
                
                // 执行逐行显示动画
                setTimeout(() => {
                    animateContent(content);
                }, 50);
            }
            
            // 绑定点击事件
            tabs.forEach(tab => {
                tab.addEventListener('click', function() {
                    switchTab(this);
                });
            });
            
            // 初始化
            initIndicator();
            
            // 初始加载时执行动画
            setTimeout(() => {
                const activeContent = document.querySelector('.tab-content.active');
                animateContent(activeContent);
            }, 200);
            
            // 窗口大小变化时重新计算指示器位置
            window.addEventListener('resize', initIndicator);
        });

        document.addEventListener('DOMContentLoaded', function() {
            // 获取DOM元素
            const playBtn = document.getElementById('playBtn');
            const pauseBtn = document.getElementById('pauseBtn');
            const resumeBtn = document.getElementById('resumeBtn');
            const stopBtn = document.getElementById('stopBtn');
            const rateSlider = document.getElementById('rate');
            const pitchSlider = document.getElementById('pitch');
            const volumeSlider = document.getElementById('volume');
            const rateValue = document.getElementById('rateValue');
            const pitchValue = document.getElementById('pitchValue');
            const volumeValue = document.getElementById('volumeValue');
            const statusIndicator = document.getElementById('statusIndicator');
            const statusText = document.getElementById('statusText');
            
            // 初始化语音合成
            const synth = window.speechSynthesis;
            let utterance = null;
            let isStopped = false;
            
            // 定义状态常量
            const STATE = {
                IDLE: 'idle',        // 空闲状态
                PLAYING: 'playing',  // 播放中
                PAUSED: 'paused'     // 已暂停
            };
            
            let currentState = STATE.IDLE;
            
            // 更新滑块值显示
            rateSlider.addEventListener('input', () => {
                rateValue.textContent = rateSlider.value;
                if (utterance) {
                    utterance.rate = parseFloat(rateSlider.value);
                }
            });
            
            pitchSlider.addEventListener('input', () => {
                pitchValue.textContent = pitchSlider.value;
                if (utterance) {
                    utterance.pitch = parseFloat(pitchSlider.value);
                }
            });
            
            volumeSlider.addEventListener('input', () => {
                volumeValue.textContent = volumeSlider.value;
                if (utterance) {
                    utterance.volume = parseFloat(volumeSlider.value);
                }
            });
            
            // 更新按钮状态
            function updateButtonStates() {
                switch (currentState) {
                    case STATE.IDLE:
                        // 空闲状态：只能开始朗读
                        playBtn.disabled = false;
                        pauseBtn.disabled = true;
                        resumeBtn.disabled = true;
                        stopBtn.disabled = true;
                        break;
                        
                    case STATE.PLAYING:
                        // 播放中：可以暂停和停止
                        playBtn.disabled = true;
                        pauseBtn.disabled = false;
                        resumeBtn.disabled = true;
                        stopBtn.disabled = false;
                        break;
                        
                    case STATE.PAUSED:
                        // 已暂停：可以继续和停止
                        playBtn.disabled = true;
                        pauseBtn.disabled = true;
                        resumeBtn.disabled = false;
                        stopBtn.disabled = false;
                        break;
                }
            }
            
            // 开始朗读函数
            function startReading() {
                if (currentState === STATE.PLAYING) {
                    synth.cancel();
                }
                
                isStopped = false;
                currentState = STATE.PLAYING;
                
                // 获取所有文本内容
                const contentDiv = document.querySelector('.tabs-content .active');
                const text = contentDiv.innerText;
                
                utterance = new SpeechSynthesisUtterance(text);
                
                // 设置语音参数
                utterance.rate = parseFloat(rateSlider.value);
                utterance.pitch = parseFloat(pitchSlider.value);
                utterance.volume = parseFloat(volumeSlider.value);
                
                // 设置中文语音（如果可用）
                const voices = synth.getVoices();

                if($("#tab1").hasClass('active') || $("#tab3").hasClass('active')){
                    const chineseVoice = voices.find(voice => voice.lang.includes('zh'));
                    if (chineseVoice) {
                        utterance.voice = chineseVoice;
                    }
                }
                if($("#tab2").hasClass('active') || $("#tab2").hasClass('active')){
                    const japaneseVoice = voices.find(voice => voice.lang.includes('ja'));
                    if (japaneseVoice) {
                        utterance.voice = japaneseVoice;
                    }
                }

                // const chineseVoice = voices.find(voice => voice.lang.includes('zh'));
                // if (chineseVoice) {
                //     utterance.voice = chineseVoice;
                // }
                
                // 语音开始事件
                utterance.onstart = function() {
                    currentState = STATE.PLAYING;
                    statusIndicator.classList.add('active');
                    statusText.textContent = '正在朗读页面内容...';
                    updateButtonStates();
                };
                
                // 语音结束事件
                utterance.onend = function() {
                    currentState = STATE.IDLE;
                    statusIndicator.classList.remove('active');
                    if (!isStopped) {
                        statusText.textContent = '朗读完成';
                    } else {
                        statusText.textContent = '已停止';
                    }
                    updateButtonStates();
                };
                
                // 语音错误事件
                utterance.onerror = function(event) {
                    // 忽略用户停止导致的错误
                    if (isStopped) return;
                    
                    console.error('语音合成错误:', event);
                    statusText.textContent = '发生错误: ' + event.error;
                    statusIndicator.classList.remove('active');
                    currentState = STATE.IDLE;
                    updateButtonStates();
                };
                
                // 开始朗读
                synth.speak(utterance);
                updateButtonStates();
            }
            
            // 暂停朗读
            function pauseReading() {
                if (currentState === STATE.PLAYING) {
                    synth.pause();
                    currentState = STATE.PAUSED;
                    statusText.textContent = '已暂停';
                    statusIndicator.classList.remove('active');
                    updateButtonStates();
                }
            }
            
            // 继续朗读
            function resumeReading() {
                if (currentState === STATE.PAUSED) {
                    synth.resume();
                    currentState = STATE.PLAYING;
                    statusText.textContent = '正在朗读页面内容...';
                    statusIndicator.classList.add('active');
                    updateButtonStates();
                }
            }
            
            // 停止朗读
            function stopReading() {
                isStopped = true;
                synth.cancel();
                currentState = STATE.IDLE;
                statusText.textContent = '已停止';
                statusIndicator.classList.remove('active');
                updateButtonStates();
            }
            
            // 绑定按钮事件
            playBtn.addEventListener('click', startReading);
            pauseBtn.addEventListener('click', pauseReading);
            resumeBtn.addEventListener('click', resumeReading);
            stopBtn.addEventListener('click', stopReading);
            
            // 初始按钮状态
            updateButtonStates();
            
            // 页面加载后自动开始朗读（注释掉这行如果需要手动开始）
            // setTimeout(startReading, 1000);
        });

    </script>
</body>

</html>