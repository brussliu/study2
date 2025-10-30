<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="efw" uri="efw" %>
<html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>テスト情報管理</title>
        <efw:Client />
        <link rel="stylesheet" href="css/common.css" type="text/css" />
        <link href="favicon.ico" rel="icon" type="image/x-icon" />
        <script type="text/javascript" src="js/common.js"></script>
        <style>
            .table_btn td button {
                width: 100px;
            }
            .hide{
                display: none;  
            }
        
            .aimg{
                width: 50px;
                height: 50px;
                cursor: pointer;
                border-top: 1px dashed gray;
                border-bottom: 1px dashed gray;
                border-left: 1px dashed gray;
                border-right: 1px dashed gray;
            }

            .afile{
                width: 50px;
                height: 50px;
                cursor: pointer;
                border-top: 1px dashed blue;
                border-bottom: 1px dashed blue;
                border-left: 1px dashed blue;
                border-right: 1px dashed blue;
            }
            
        </style>
        <script>

            function scrollHead(obj) {
                var p = $(obj).get(0).scrollLeft;
                $(".c_detail_header").get(0).scrollLeft = p;
            }

            // 初期化
            function init() {
                Efw('test_init');
            }
                // CTRL+O
                $(window).keydown(function(e) {
                
                if (e.keyCode == 79 && e.ctrlKey) {

                    outputToExcelFile(); 
                } 
            });

            // 初始化
            function add() {

                $("#test_inputdialog input").val("");
                $("#test_inputdialog select").val(""); 

                // for(var i = 1;i < 99;i ++){

                //     if($(".newtable" + i).length > 0){
                //         $(".newtable" + i).remove();
                //     }else{
                //         break;
                //     }

                // }
                $('#test_inputdialog .newtable').remove();
                $('#test_inputdialog .image-container').empty();
                $('#test_inputdialog .image-container').next().empty();
                
                $('#opt').val('new');
                test_inputdialog.dialog('open');
            }
        
            // 更新
            function update(){

                $("#test_inputdialog input").val("");
                $("#test_inputdialog select").val(""); 
                // for(var i = 1;i < 99;i ++){

                //     if($(".newtable" + i).length > 0){
                //         $(".newtable" + i).remove();
                //     }else{
                //         break;
                //     }

                // }
                $('#test_inputdialog .newtable').remove();
                $('#test_inputdialog .image-container').empty();
                $('#test_inputdialog .image-container').next().empty();

                $('#opt').val('update');

                var seq = $("input[name='seq']:checked").val();
                Efw('test_update',{"seq":seq});
            }



            // 删除img
            function deleteimg(img) {
                $(img).parent().remove();
            }
            // 移动
            function move(index){
                // Efw('studytest_move',{"seq": index });
            }

            function openDoc(flg, obj){

                var seqArr = $(obj).next().val().split(",");

                var seq = seqArr[0];
                var subno = seqArr[1];

                if(flg == 0){

                    const windowFeatures =
                        "toolbar=no," + 
                        "location=no," + 
                        "directories=no," + 
                        "status=no," + 
                        "menubar=no," + 
                        "scrollbars=yes," + 
                        "resizable=yes," + 
                        "width=1920px," + 
                        "height=1080px";

                        // "width=" + screen.availWidth + "," + 
                        // "height=" + screen.availHeight;

                    window.open("document_pic.jsp?seq=" + seq + "&subno=" + subno, 'documentpic', windowFeatures);

                }else{

                    Efw('document_getdoccontent',{seq : seq, subno : subno});

                }

            }

            function downloadFile(base64Code, suffix){

                const link = document.createElement('a');
                link.href = base64Code;

                link.download = 'DownloadFile' + (new Date()).format("yyyyMMdd-HHmmss") + "." + suffix;

                link.click();

            }

            function checkTest(){

                $("#btn_update").prop("disabled", true);

                var selectedValue = $("input[name='seq']:checked").val();
                if (selectedValue) {
                    $("#btn_update").prop("disabled", false);
                } else {
                    $("#btn_update").prop("disabled", true);
                }

            }
        </script>
    </head>
    <body onload="init();">
        <efw:Part path="test_inputdialog.jsp" /> 
        <efw:Part path="test_selectdoc_inputdialog.jsp" /> 
        <div>
            <div class="head">
                <div class="hleft">
                    <h1 style="height: 80px;line-height: 80px;margin-left:40px;">STUDY</h1>
                </div>
                <div class="hright">
                    <table style="float: right;width: 100%;color: aliceblue;">
                        <tr>
                            <td>
                                <button class="hright_r"
                                    onclick="Efw('common_menu_goto',{page:'common_login.jsp'})">ログオフ</button>
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align: right;padding-right: 20px;" id="sessioninfo">
                                店舗ID：<span id="shopid" style="font-weight: bold;color: yellow;">未选择</span>
                                &nbsp;&nbsp;&nbsp;
                                UserID：<span id="userid" style="font-weight: bold;color: yellow;">XXXX</span>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <div class="topnav">
                <p><a href="common_menu.jsp">メニュー</a> > テスト情報管理</p>
            </div>
            <div class="content">
                <div class="c_btn">
                    <table class="table_btn">
                        <tbody>
                            <tr>
                                <td style="font-weight: bold;color: maroon">【検索条件】</td>
                                <td></td>
                                <td style="width: 120px;"><button id="btn_update" onclick="update()" disabled>更新</button></td>
                                <td style="width: 120px;"><button id="btn_new" onclick="add()">新規</button></td>
                                <td style="width: 120px;"><button   onclick="init()">検　索</button>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>

                <div class="c_detail_header" style="overflow: hidden;" onscroll="scrollHead(this);">
                    <table class="table_detail_header" style="table-layout: fixed;">
                        <thead>
                            <tr class="header">
                                <th style="width: 50px;" id="temp">選択</th>
                                <th style="width: 150px">テスト番号</th>
                                <th style="width: 100px;">学年</th>

                                <th style="width: 220px;">名称</th>
                                <th style="width: 220px;">期間</th>

                                <th style="width: 100px;">科目</th>
                                <th style="width: 400px;">内容</th>

                                <th style="width: 80px;">得点</th>
                                <th style="width: 80px;">満点</th>  
                                <th style="width: 80px;">学級平均点</th>
                                <th style="width: 80px">学年平均点</th>
                                <th style="width: 100px;">学級順位</th>
                                <th style="width: 100px;">学年順位</th>
                            </tr>
                        </thead>
                    </table>
                </div>
                <!-- display: none; -->
                <div class="c_detail_content" style="overflow: auto;" onscroll="scrollHead(this);">
                    <table class="table_detail_content" id="testinfotable" style="table-layout: fixed;">
                    </table>
                </div>
            </div>
        </div>

    </body>
    <script>
        $(document).ready(function() {

            // 获取屏幕宽度
            var screenWidth = window.screen.width;

            // 获取屏幕高度
            var screenHeight = window.screen.height;

            // 获取屏幕可用工作区宽度（不包括任务栏等）
            var screenAvailableWidth = window.screen.availWidth;

            // 获取屏幕可用工作区高度（不包括任务栏等）
            var screenAvailableHeight = window.screen.availHeight;

            var h0 = $(document).height();
            

            var h1 = $(".head").height();
            var h2 = $(".topnav").height();
            var h3 = $(".c_btn").height();
            var h4 = $(".c_condition").height();
            var h5 = $(".c_detail_header").height();

            var h6 = h0 - h1 - h2 - h3 - h4 - h5 - 30 -120;

            $(".c_detail_content").height(h6);
        

        });
    </script>
</html>