<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="efw" uri="efw" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>AI回答</title>
    <efw:Client />
    <link rel="stylesheet" href="css/common.css" type="text/css" />
    <link href="favicon.ico" rel="icon" type="image/x-icon" />
    <script type="text/javascript" src="js/common.js"></script>
    <style>
        .c_detail_header {
            width: 94%;
            height: 100%;
        }
        .table_detail_header td{
            border: 1px solid black;
        }
        .table_detail_header th{
            font-size: 30px;
            font-weight: bold;
        }
       .div_memo{
           width: 94%;
           max-height: 45%;
           margin: auto;
           overflow: auto;
       }
        button{
            height: 40px;
            width: 170px;
        }
        textarea{
            overflow: auto;
            resize : none;
            font-size: 20px;
        }
        .table_header1{
            width: 100%;
            height: 94%;
        }
        .btn_bottom{
            margin-bottom: 10px;
            position: absolute;
            bottom: 0;
            left: 0;
            right: 0;
        }
    </style>
    <script>
        $(document).ready(function() {
            const paramsStr = localStorage.getItem("selectedValues");

            if (paramsStr) {
                const params = JSON.parse(paramsStr);
                console.log("接收的参数：", params);

                // 读取后可删除存储（避免残留）
                localStorage.removeItem("selectedValues");

                  $("#td_no").text("");
                  $('#text_aireply').val('');
                  $('.init').show();
                  $(".init1").hide();
                Efw('ai_Answer',{selectedValues : params});
            }
        });
            //根据memo数量添加组件
            function renderMemoComponents(memo1,memo2,memo3,memo4,memo5,state) {

                var list = [];
                var memoParams = [memo1, memo2, memo3, memo4, memo5];

                memoParams.forEach(function (memo) {
                    // 非空判断（与方式1规则一致）
                    if (memo !== null && memo !== undefined && memo !== ''&& memo !== 'null') {
                        list.push(memo);
                    }
                });
                // 1. 获取目标表格（id=memoTable2，class=table_header1）
                const $table = $('#memoTable2');

                if (!$table.length) {
                    console.error('未找到目标表格：#memoTable2');
                    return;
                }


                // 2. 清空表格中已有的 memo-group 组件（避免重复添加，若需追加可删除此行）
                $table.find('.memo-group').remove();

                // 3. 遍历集合，逐个添加组件（newIndex 从1开始递增）
                list.forEach((content, index) => {

                    const newIndex = index + 1; // 组件索引（メモー1、メモー2...）
                    let memoHtml = '';

                    if (newIndex === 1) {

                        memoHtml = `
                            <tr class="memo-group init1" data-index="`+newIndex+`">
                                <td style="width: 200px;">
                                    メモー`+newIndex+`:
                                </td>
                                <td style="width: 900px; height: 180px" colspan="5" rowspan="2">
                                    <textarea
                                        style="width: 70%; height: 170px; text-align: left;"
                                        data-memo-index=`+newIndex+`
                                    >`+content+`</textarea>
                                </td>
                            </tr>
                            <tr class="memo-group init1" data-index="`+newIndex+`">
                                <td style="width: 200px;">
                                    <button class="add-btn">ADD</button>
                                </td>
                            </tr>
                        `;
                    } else {

                        memoHtml = `
                            <tr class="memo-group init1" data-index="`+newIndex+`">
                                <td style="width: 200px;">
                                    メモー`+newIndex+`:
                                </td>
                                <td style="width: 90% ; height: 180px" colspan="5" rowspan="2">
                                    <textarea
                                        style="width: 70%; height: 170px; text-align: left;"
                                        data-memo-index=`+newIndex+`
                                    >`+content+`</textarea>
                                </td>
                            </tr>

                            <tr class="memo-group init1" data-index="`+newIndex+`">
                                <td style="width: 200px;">
                                    <button class="delete-btn">DELETE</button>
                                </td>
                            </tr>
                        `;
                    }
                    // 5. 将组件追加到表格末尾
                    $table.append(memoHtml);

                 });
                //记录状态
                $("#td_state").attr("data-state",state);
                this.currentTotal = list.length;
                $("#memoTable2 .memo-group").hide();
            }

            //保存所有 memo 内容到 Map 集合
            function saveMemoToMap() {
                // 1. 初始化 Map 存储数据（键=序号，值=内容）
                const memoDataMap = new Map();

                // 2. 精准获取目标 textarea：memoTable2 下 .memo-group 中带 data-memo-index 的 textarea
                const memoTable = $('#memoTable2');
                const memoTextareas = memoTable.find('.memo-group textarea[data-memo-index]');

                // 3. 校验前置条件
                if (!memoTable.length) {
                    alert('メモーテーブルが見つかりません');
                    console.error('未找到 #memoTable 表格');
                    return memoDataMap;
                }
                // 4. 遍历 textarea 收集数据
                memoTextareas.each(function() {
                    const textarea = $(this);
                    const memoIndex  =   textarea[0].dataset.memoIndex ;
                    const memoContent = textarea.val().trim() || '';
                    // 存储到 Map（自动去重，一个序号对应一个内容）
                    memoDataMap.set(memoIndex, memoContent);
                });
                let no = $('#td_no').text();
                memoDataMap.set("no",no)
                // 可选：转为普通对象（方便接口提交等场景）
                const memoDataObj = Object.fromEntries(memoDataMap);
                console.log('收集到的 memo 数据（对象格式）：', memoDataObj);

                // 👉 关键：返回数据（可在 onclick 中直接接收，用于后续操作）
                Efw('ai_AnswerAdd',{memoDataObj : memoDataObj});

            }
            //取消按钮
            function ai_btnCancel(){
                window.open("ai_Issues.jsp");
            }

        // 识别戻る値種類
        /**
         * 切换文本展示元素（textarea/div）
         * @param {string} type - 类型，只能是"文章"或"HTML"
         * @param {string} content - 要显示的内容
         */
        function switchContentElement(type, content) {
            // 1. 定位父容器（textarea所在的td，确保操作目标正确）
            const parentTd = document.querySelector('.td_category');

            // 2. 参数合法性校验
            if (type !== "文章" && type !== "HTML"&& type !== "JSON") {
                console.error('第一个参数必须是"文章"或"HTML"');
                return;
            }

            // 3. 移除现有子元素（确保切换时无残留）
            parentTd.innerHTML = '';

            if (type === "文章") {
                // 3.1 类型为"文章"：创建div并添加
                const div = document.createElement('div');
                // 保持与原textarea相似的样式（宽度、高度、文本对齐）
                div.style.width = '100%';
                div.style.height = '95%';
                div.style.textAlign = 'left';
                div.style.overflow = 'auto'; // 内容过长时可滚动，类似textarea
                // 写入内容
                div.textContent = content; // 用textContent避免HTML注入风险
                // 添加到父容器
                parentTd.appendChild(div);
                console.log('已切换为div元素（文章模式）');

            } else if (type === "HTML") {
                // // 3.2 类型为"HTML"：创建textarea并添加
                // const textarea = document.createElement('textarea');
                // // 恢复原textarea的属性和样式
                // textarea.readOnly = true;
                // textarea.id = 'text_aireply';
                // textarea.style.width = '100%';
                // textarea.style.height = '95%';
                // textarea.style.textAlign = 'left';
                // textarea.style.resize = 'none';
                // // 写入内容
                // textarea.value = content;
                // // 添加到父容器
                // parentTd.appendChild(textarea);
                // console.log('已切换为textarea元素（HTML模式）');
                // 3.2 类型为"HTML"：同时创建textarea（纯文本）和HTML预览容器
// 1. 创建textarea（保留纯文本，隐藏）
                const textarea = document.createElement('textarea');
                textarea.readOnly = true;
                textarea.id = 'text_aireply';
                textarea.style.width = '99%';
                textarea.style.height = '95%';
                textarea.style.textAlign = 'left';
                textarea.style.resize = 'none';
                textarea.style.display = 'none'; // 隐藏textarea
                textarea.value = content; // 纯文本备份
                parentTd.appendChild(textarea);

// 2. 创建HTML渲染容器（显示）
                const htmlContainer = document.createElement('div');
                htmlContainer.id = 'text_aireply_html';
                htmlContainer.style.width = '100%';
                htmlContainer.style.height = '95%';
                htmlContainer.style.border = '1px solid #ccc';
                htmlContainer.style.padding = '2px';
                htmlContainer.style.overflow = 'auto';
                htmlContainer.style.whiteSpace = 'pre-wrap';
                htmlContainer.innerHTML = content; // HTML渲染
                parentTd.appendChild(htmlContainer);

                console.log('已保留textarea（纯文本），并创建HTML预览容器');
            }else if (type === "JSON") {
                console.log('JSON');
            }
        }
        </script>


        <div style="width: 100%" class="content">
            <div class="c_detail_header" style="margin-top: 20px;height:500px;">
                 <table class="table_header1" id="aiprompttable2" style="table-layout: fixed;text-align: left;border-bottom: 10px;margin-top: 20px;">

                    <tbody id="memoTable">
                        <tr>
                            <td style=" height: 50px;font-weight: bold;font-size: 20px;color:blue;" colspan="6" id="td_state">
                                NO：
                                <span  id="td_no">456</span>
                            </td>
                        </tr>
                        <tr style="height: 40%;width: 100%" class="copytr">
                            <td style="width: 100%; height: 100%" colspan="6" class="td_category">
                                <textarea style="width: 100%; height: 95%;text-align: left;resize: none;" readonly id="text_aireply">123</textarea>
                            </td>
                        </tr>
                        <tr class="init" id="tr_memo">
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td style="text-align: right">
                                <button id="btn_memo" >メモー</button>
                            </td>
                        </tr>

                    </tbody>
             </table>
            </div>
            <div class="div_memo">
                <table>
                    <tbody  id="memoTable2"></tbody>
                </table>
            </div>
            <div class="btn_bottom">
                <table class="table_inputdialog_btn" border="0">
                    <tbody>
                        <tr>

                            <td style="width: 200px;"><button class="btn" id="btn_lottery" onclick="saveMemoToMap();">保存</button></td>
                            <td style="width: 200px;"><button class="btn" onclick="ai_btnCancel()">キャンセル</button></td>
                            <td style="width: 200px;">  </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>

<script>

    // 核心配置：最多新增5个，总计最多6个条目（初始1个 + 新增5个）
    const MAX_ADD = 4;
    const MAX_TOTAL = 1 + MAX_ADD;
    let currentTotal = 1; // 当前条目总数

    // DOM元素
    const memoTable = document.getElementById('memoTable2');
    const btn_memo = document.getElementById('btn_memo');

    // 1. 主按钮：隐藏/显示所有备忘录条目
    function setupMemo() {

        let isHidden = false;

        btn_memo.addEventListener('click', () => {
            const allMemoRows = memoTable.querySelectorAll('.memo-group');

            // 2. 没有 memo 时，显示日语提示（不执行显示/隐藏逻辑）
            if (allMemoRows.length === 0) {
                // 默认组件为「メモー1」，2行结构（无 DELETE 按钮）
                const defaultMemoHtml = `
                    <tr class="memo-group init1" data-index="1">
                    <td style="width: 200px;">
                    メモー1:
                    </td>
                    <td style="width:90%; height: 180px" colspan="5" rowspan="2">
                    <textarea  style="width: 70%; height: 170px;text-align: left;"
                    data-memo-index="1"></textarea>
                    </td> </tr>
                    <tr class="memo-group init1" data-index="1">
                    <td style="width: 200px;">
                    <button class="add-btn">ADD</button>
                    </td>
                    </tr>
                `;

            // 将默认组件添加到 memoTable 中
            memoTable.insertAdjacentHTML('beforeend', defaultMemoHtml);
            console.log('默认メモーコンポーネントを追加しました');
                this.currentTotal = this.currentTotal + 1;
            // 添加后默认显示（不隐藏）
            isHidden = false;
            return;
        }
            isHidden = !isHidden;
            allMemoRows.forEach(row => {
                row.style.display = isHidden ? 'none' : '';
            });

        });
    }

    // 2. ADD按钮：新增条目（最多5个，带DELETE按钮）
    function setupAddFunctionality() {
        memoTable.addEventListener('click', (e) => {
            if (e.target.classList.contains('add-btn')) {
                if (this.currentTotal >= MAX_TOTAL) {
                    alert(`最多只能添加`+MAX_ADD+`个メモー（总计`+MAX_TOTAL+`个）`);
                    return;
                }

                const newIndex = this.currentTotal + 1;

                //组件
                const newGroupHTML = `
                        <tr class="memo-group init1" data-index="`+newIndex+`">
                            <td style="width: 200px;">
                                メモー`+newIndex+`:
                            </td>
                            <td style="width: 90%; height: 180px" colspan="5" rowspan="2">
                                <textarea style="width: 70%; height: 170px; text-align: left;" data-memo-index="`+newIndex+`" ></textarea>
                            </td>
                        </tr>

                        <tr class="memo-group  init1" data-index="`+newIndex+`">
                            <td style="width: 200px;">
                                <button class="delete-btn">DELETE</button>
                            </td>
                        </tr>
                    `;

                memoTable.insertAdjacentHTML('beforeend', newGroupHTML);
                this.currentTotal++;
            }
        });
    }

    // 3. DELETE按钮：删除当前完整组件（对应3行结构）
    function setupDeleteFunctionality() {
        memoTable.addEventListener('click', (e) => {

            if (e.target.classList.contains('delete-btn')) {
                const targetIndex = e.target.closest('.memo-group').dataset.index;

                // 删除当前条目所有行（3行）
                const rowsToDelete = memoTable.querySelectorAll(`.memo-group[data-index="`+targetIndex+`"]`);
                rowsToDelete.forEach(row => row.remove());

                // 更新总数并重新编号
                this.currentTotal--;
                updateMemoIndexes();
            }
        });
    }

    // 重新编号所有条目（确保序号连续，仅序号1无DELETE）
    function updateMemoIndexes() {
        // 1. 确认 memoTable 存在（健壮性校验）
        if (!memoTable || !memoTable.nodeType) {
            console.error('updateMemoIndexes 报错：memoTable 未定义或不是 DOM 元素');
            return;
        }

        const allGroupRows = Array.from(memoTable.querySelectorAll('.memo-group'));
        let currentIndex = 1;
        let i = 0;

        console.log('开始重新编号，总组件行数：' + allGroupRows.length);

        // 每个组件固定为 2 个 tr（取消 3 行逻辑）
        const rowCountPerGroup = 2;

        while (i < allGroupRows.length) {
            // 截取当前组件的 2 行 tr
            const currentGroupRows = allGroupRows.slice(i, i + rowCountPerGroup);
            const oldIndex = currentGroupRows[0].dataset.index || '无';
            console.log('处理组件：旧序号=' + oldIndex + ' → 新序号=' + currentIndex + '，行数=' + rowCountPerGroup);

            currentGroupRows.forEach((row, rowIdx) => {
                row.dataset.index = currentIndex; // 更新组件序号标识
                const leftTd = row.querySelector('td:not([colspan])'); // 左侧按钮/标题单元格
                if (!leftTd) return; // 容错：无左侧单元格则跳过

                if (rowIdx === 0) {
                    // 1. 更新标题（如「メモー1:」）
                    leftTd.textContent = 'メモー' + currentIndex + ':';

                    // 2. 定位当前组件的 textarea 并更新 index
                    const textarea = document.querySelector(
                        '.memo-group[data-index="' + currentGroupRows[0].dataset.index + '"] textarea[data-memo-index]'
                    );
                    if (textarea) {
                        const oldMemoIndex = textarea.dataset.memoIndex;
                        textarea.dataset.memoIndex = currentIndex;
                        textarea.setAttribute('data-memo-index', currentIndex);
                        console.log('  - 更新 textarea：旧=' + oldMemoIndex + ' → 新=' + currentIndex);
                    } else {
                        console.warn('  - 未找到当前组件的 textarea！旧序号=' + oldIndex);
                    }

                    // 3. 强制 textarea 跨 2 行（因为每个组件固定 2 行）
                    const textareaTd = row.querySelector('td[colspan]');
                    if (textareaTd) {
                        textareaTd.rowSpan = 2; // 固定跨 2 行
                        console.log('  - textarea 已设置跨 2 行');
                    }
                }
                // 第二行：根据组件序号显示 ADD 或 DELETE 按钮
                else if (rowIdx === 1) {
                    if (currentIndex === 1) {
                        // 第一个组件：显示 ADD 按钮（无 DELETE）
                        if (!leftTd.querySelector('.add-btn')) {
                            leftTd.innerHTML = '<button class="add-btn">ADD</button>';
                            console.log('  - 第一个组件：添加 ADD 按钮');
                        }
                    } else {
                        // 其余组件：显示 DELETE 按钮（替代 ADD）
                        if (!leftTd.querySelector('.delete-btn')) {
                            leftTd.innerHTML = '<button class="delete-btn">DELETE</button>';
                            console.log('  - 第' + currentIndex + '个组件：添加 DELETE 按钮（替换 ADD）');
                        }
                    }
                }
            });

            currentIndex++;
            i += rowCountPerGroup; // 每次跳过当前组件的 2 行
        }

        console.log('重新编号完成！');
    }

    // 初始化功能
    setupMemo();
    setupAddFunctionality();
    setupDeleteFunctionality();
</script>