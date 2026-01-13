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
            width: 96%;
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
           width: 96%;
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
            width: 95%;
            height: 95%;
        }
        .btn_bottom{
            margin-bottom: 10px;
            position: absolute;
            bottom: 0;
            left: 0;
            right: 0;
        }
        .td_category *{
            overflow: auto;
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


            //保存所有 memo 内容到 Map 集合
            function saveMemoToMap() {
                // // 1. 初始化 Map 存储数据（键=序号，值=内容）
                // const memoDataMap = new Map();

                // // 2. 精准获取目标 textarea：memoTable2 下 .memo-group 中带 data-memo-index 的 textarea
                // const memoTable = $('#memoTable2');
                // const memoTextareas = memoTable.find('.memo-group textarea[data-memo-index]');

                // // 3. 校验前置条件
                // if (!memoTable.length) {
                //     alert('メモーテーブルが見つかりません');
                //     console.error('未找到 #memoTable 表格');
                //     return memoDataMap;
                // }
                // // 4. 遍历 textarea 收集数据
                // memoTextareas.each(function() {
                //     const textarea = $(this);
                //     const memoIndex  =   textarea[0].dataset.memoIndex ;
                //     const memoContent = textarea.val().trim() || '';
                //     // 存储到 Map（自动去重，一个序号对应一个内容）
                //     memoDataMap.set(memoIndex, memoContent);
                // });
                // let no = $('#td_no').text();
                // memoDataMap.set("no",no)
                // // 可选：转为普通对象（方便接口提交等场景）
                // const memoDataObj = Object.fromEntries(memoDataMap);
                // console.log('收集到的 memo 数据（对象格式）：', memoDataObj);

                // 👉 关键：返回数据（可在 onclick 中直接接收，用于后续操作）
                Efw('ai_AnswerAdd',{
                    memo1 : $("#text_aireply1").val(),
                    memo2 : $("#text_aireply2").val(),
                    memo3 : $("#text_aireply3").val(),
                    memo4 : $("#text_aireply4").val(),
                    memo5 : $("#text_aireply5").val()
                });

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

                const htmlContainer = document.createElement('div');
                htmlContainer.id = 'text_aireply_html';
                htmlContainer.style.width = '98%';
                //htmlContainer.style.height = '100%';
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

        function addmemo(){
            if($("#text_aireply1").css("display") == "none"){
                $("#text_aireply1").show();
            }else{
                if($("#text_aireply2").css("display") == "none"){
                    $("#text_aireply2").show();
                }else{
                    if($("#text_aireply3").css("display") == "none"){
                        $("#text_aireply3").show();
                    }else{

                        if($("#text_aireply4").css("display") == "none"){
                            $("#text_aireply4").show();
                        }else{
                            if($("#text_aireply5").css("display") == "none"){
                                $("#text_aireply5").show();
                                $("#btn_memo").hide();
                            }
                        }
                    }
                }
            }
            
        }

        function showMemo(){

            var memo1 = $("#text_aireply1").val();
            var memo2 = $("#text_aireply2").val();
            var memo3 = $("#text_aireply3").val();
            var memo4 = $("#text_aireply4").val();
            var memo5 = $("#text_aireply5").val();

            if(memo5 != null && memo5 != ""){

                $("#text_aireply1").show();
                $("#text_aireply2").show();
                $("#text_aireply3").show();
                $("#text_aireply4").show();
                $("#text_aireply5").show();
                $("#btn_memo").hide();

            }else if(memo4 != null && memo4 != ""){

                $("#text_aireply1").show();
                $("#text_aireply2").show();
                $("#text_aireply3").show();
                $("#text_aireply4").show();

            }else if(memo3 != null && memo3 != ""){

                $("#text_aireply1").show();
                $("#text_aireply2").show();
                $("#text_aireply3").show();

            }else if(memo2 != null && memo2 != ""){

                $("#text_aireply1").show();
                $("#text_aireply2").show();

            }else if(memo1 != null && memo1 != ""){

                $("#text_aireply1").show();

            }
        }


        function printpage(){

            var content = $("#displaydiv").html();
            var old = $("#alldiv").html();

            $("#alldiv").html(content);

            $("#alldiv").css("height", "auto");

            window.print();
            
            // // 恢复原始样式（延迟执行，确保打印完成）
            setTimeout(() => {
                $("#alldiv").html(old);
                $("#alldiv").css("height", "100%");
            }, 1000);

        }


        </script>

    </head>
   <body>
        <div style="width: 100%" class="content" id="alldiv">
            <span id="td_no" style="font-weight: bold;font-size: 20px;color:blue;margin-left: 20px;">456</span>
            <input type="hidden" id="no">
            <div class="c_detail_header" style="margin-top: 20px;height: 90%;">
                <div id="displaydiv" class="td_category">
                </div>
                <div class="div_memo">
                    <textarea style="width: 100%; height: 100px;margin-top: 10px;display: none;" id="text_aireply1"></textarea>
                    <textarea style="width: 100%; height: 100px;margin-top: 10px;display: none;" id="text_aireply2"></textarea>
                    <textarea style="width: 100%; height: 100px;margin-top: 10px;display: none;" id="text_aireply3"></textarea>
                    <textarea style="width: 100%; height: 100px;margin-top: 10px;display: none;" id="text_aireply4"></textarea>
                    <textarea style="width: 100%; height: 100px;margin-top: 10px;display: none;" id="text_aireply5"></textarea>
                </div>
            </div>
            <div class="btn_bottom">
                <table class="table_inputdialog_btn" border="0">
                    <tbody>
                        <tr>
                            <td style="width: 200px;"><button class="btn" id="btn_memo" onclick="addmemo();">メモー</button></td>
                            <td style="width: 200px;"><button class="btn" id="btn_print" onclick="printpage();">印刷</button></td>
                            <td style="width: 200px;"><button class="btn" id="btn_lottery" onclick="saveMemoToMap();">保存</button></td>
                            <td style="width: 200px;"><button class="btn" onclick="window.close();">キャンセル</button></td>
                            <td style="width: 200px;">  </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </body>
</html>