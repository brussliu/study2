<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="efw" uri="efw" %>
<html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>資料管理</title>
    <efw:Client />
    <link rel="stylesheet" href="css/common.css" type="text/css" />
    <link href="favicon.ico" rel="icon" type="image/x-icon" />
    <script type="text/javascript" src="js/common.js"></script>
    <script type="text/javascript" src="js/jQueryRotate.js"></script>
    
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
                $(obj).prev().get(0).scrollLeft = p;
        }


        // function ttt(obj){

        //     $(obj).attr("disabled", true);

        //     var pic = $(obj).prev().prev().prev().prev();
        //     var picCurrentHeight = pic.width();
        //     var picCurrentWidth = pic.height();
        //     // console.log(picCurrentHeight);
        //     // console.log(picCurrentWidth);

        //     var a = parseInt(pic.getRotateAngle()) - 90;
        //     pic.rotate({ animateTo: a });
        //     // picCurrentHeight = pic.width();
        //     // picCurrentWidth = pic.height();
        //     // console.log(picCurrentHeight);
        //     // console.log(picCurrentWidth);

        //     // var div = $(obj).parent();
        //     // var divCurrentHeight = div.height();
        //     // var divCurrentWidth = div.width();
        //     // console.log(divCurrentHeight);
        //     // console.log(divCurrentWidth);

        //     // div.height(divCurrentHeight + picCurrentHeight - picCurrentWidth);
        //     // div.width(divCurrentWidth + picCurrentWidth - picCurrentHeight);

        //     setTimeout(function(){
        //         $(obj).attr("disabled", false);
        //     }, 1000)

        // }

        // 初始化
        function addDoc() {

            $("#document_inputdialog .pictr1").remove();

            $("#document_inputdialog input").val("");

            $("#document_inputdialog textarea").val("");

            var code = "document_init1";
            var inputvalue = "";
            var outputObj = new Array("#opt_div1_dialog");

            Efw('common_selectoption',{code : code, inputvalue : inputvalue, outputObj : outputObj});

            $("#document_inputdialog #opt_div2_dialog").val("");
            $("#document_inputdialog #opt_div3_dialog").val("");
            $("#document_inputdialog #opt_div4_dialog").val("");
            

            $("#opt").val("new");

            document_inputdialog.dialog('open');
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


                // var filecontent = $(obj).next().val();



            }


        }

        function downloadFile(base64Code, suffix){

            const link = document.createElement('a');
            link.href = base64Code;

            link.download = 'DownloadFile' + (new Date()).format("yyyyMMdd-HHmmss") + "." + suffix;

            link.click();

        }

        function init(){

            // Efw('document_search');

            initDiv1(0);
            
        }

        function initDiv1(flg){

            if(flg == 0){
                var code = "document_init1";
                var inputvalue = "";
                var outputObj = new Array("#opt_div1");

                Efw('common_selectoption',{code : code, inputvalue : inputvalue, outputObj : outputObj});
            }else{
                var code = "document_init1";
                var inputvalue = "";
                var outputObj = new Array("#opt_div1_dialog");

                Efw('common_selectoption',{code : code, inputvalue : inputvalue, outputObj : outputObj});
            }

        }

        function changeDiv1(flg){

            if(flg == 0){

                var code = "document_init2";
                var inputvalue = new Array($("#opt_div1").val());
                var outputObj = new Array("#opt_div2");

                Efw('common_selectoption',{code : code, inputvalue : inputvalue, outputObj : outputObj});

                $("#opt_div3 .dbvalue").remove();
                $("#opt_div4 .dbvalue").remove();

            }else{

                var code = "document_init2";
                var inputvalue = new Array($("#opt_div1_dialog").val());
                var outputObj = new Array("#opt_div2_dialog");

                Efw('common_selectoption',{code : code, inputvalue : inputvalue, outputObj : outputObj});

                $("#opt_div3_dialog .dbvalue").remove();
                $("#opt_div4_dialog .dbvalue").remove();

            }

        }

        function changeDiv2(flg){

            if(flg == 0){

                var code = "document_init3";
                var inputvalue = new Array($("#opt_div1").val(), $("#opt_div2").val());
                var outputObj = new Array("#opt_div3");

                Efw('common_selectoption',{code : code, inputvalue : inputvalue, outputObj : outputObj});

                $("#opt_div4 .dbvalue").remove();

            }else{

                var code = "document_init3";
                var inputvalue = new Array($("#opt_div1_dialog").val(), $("#opt_div2_dialog").val());
                var outputObj = new Array("#opt_div3_dialog");

                Efw('common_selectoption',{code : code, inputvalue : inputvalue, outputObj : outputObj});

                $("#opt_div4_dialog .dbvalue").remove();

            }

        }

        function changeDiv3(flg){

            if(flg == 0){

                var code = "document_init4";
                var inputvalue = new Array($("#opt_div1").val(), $("#opt_div2").val(), $("#opt_div3").val());
                var outputObj = new Array("#opt_div4");

                Efw('common_selectoption',{code : code, inputvalue : inputvalue, outputObj : outputObj});

            }else{

                var code = "document_init4";
                var inputvalue = new Array($("#opt_div1_dialog").val(), $("#opt_div2_dialog").val(), $("#opt_div3_dialog").val());
                var outputObj = new Array("#opt_div4_dialog");

                Efw('common_selectoption',{code : code, inputvalue : inputvalue, outputObj : outputObj});

            }

        }

        function searchDoc(){
            Efw('document_search');
        }

        function deleteDoc(){

            var doclist = new Array();

            $('#doclisttable input[type="checkbox"]').each(function() {

                if($(this).prop('checked') == true){

                    doclist.push($(this).parent().next().html());
                    
                }

            });

            Efw('document_delete',{doclist : doclist});
        }

        function updateDoc(){

            var doc_no = "";

            $('#doclisttable input[type="checkbox"]').each(function() {

                if($(this).prop('checked') == true){

                    doc_no = $(this).parent().next().html();
                    return false;
                    
                }

            });

            $("#opt").val("update");

            $("#fileinfotable tr:gt(0)").remove();
            cleardisplayData();

            Efw('document_update',{doc_no : doc_no});
            document_inputdialog.dialog('open');
        }

        function checkDoc(obj){

            $("#btn_delete").prop("disabled", true);
            $("#btn_update").prop("disabled", true);

            var doclist = new Array();

            $('#doclisttable input[type="checkbox"]').each(function() {

                if($(this).prop('checked') == true){

                    doclist.push($(this).parent().next().html());
                    
                }

            });

            if(doclist.length > 0){
                $("#btn_delete").prop("disabled", false);
            }
            if(doclist.length == 1){
                $("#btn_update").prop("disabled", false);
            }
            
            
        }

    </script>
</head>
        <body onload="init();">
            <efw:Part path="document_inputdialog.jsp" /> 
         
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
                    <p><a href="common_menu.jsp">メニュー</a> > 資料管理</p>
                </div>
                <div class="content">
                    <div class="c_btn">
                        <table class="table_btn">
                            <tbody>
                                <tr>
                                    <td style="font-weight: bold;color: maroon">【検索条件】</td>
                                    <td style="width: 120px;"><button id="btn_delete" onclick="deleteDoc()" disabled>削除</button></td>
                                    <td style="width: 120px;"><button id="btn_update" onclick="updateDoc()" disabled>更新</button></td>
                                    <td style="width: 120px;"><button id="btn_new" onclick="addDoc()">新規</button></td>
                                    <td style="width: 120px;"><button onclick="searchDoc()">検索</button></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>

                    <div class="c_condition" style="height: 55px;">
                        <table border="0" style="margin-top: 10px;">
                            <tbody>
                                <tr>
                                    <td style="width: 100px;font-weight: bold;">大分類：</td>
                                    <td style="width: 220px;">
                                        <select style="width: 200px;height:30px;border-style: solid;" id="opt_div1" onchange="changeDiv1(0);">
                                            <option value=""></option>
                                        </select>
                                    </td>
                                    <td style="width: 100px;font-weight: bold;">中分類：</td>
                                    <td style="width: 220px;">
                                        <select style="width: 200px;height:30px;border-style: solid;" id="opt_div2" onchange="changeDiv2(0);"> 
                                                <option value=""></option>
                                        </select>
                                    </td>
                                    <td style="width: 100px;font-weight: bold;">小分類：</td>
                                    <td style="width: 220px;">
                                        <select style="width: 200px;height:30px;border-style: solid;" id="opt_div3" onchange="changeDiv3(0);"> 
                                                <option value=""></option>
                                        </select>
                                    </td>
                                    <td style="width: 100px;font-weight: bold;">細分類：</td>
                                    <td style="width: 220px;">
                                        <select style="width: 200px;height:30px;border-style: solid;" id="opt_div4"> 
                                                <option value=""></option>
                                        </select>
                                    </td>
                                    <td style="width: 140px;font-weight: bold;">キーボード：</td>
                                    <td style="width: 220px;">
                                        <input type="text" style="width: 200px;height: 30px;" id="text_keyword"/>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>


                    <div class="c_detail_header" style="overflow: hidden;" onscroll="scrollHead(this);">
                        <table class="table_detail_header" style="table-layout: fixed;width: 2200px;">
                            <thead>
                                <tr class="header">
                                    <th style="width: 50px;" id="temp">選択</th>
                                    <th style="width: 150px">資料番号</th>
                                    <th style="width: 100px">ステータス</th>
                                    <th style="width: 120px">有効期限</th>
                                    <th style="width: 200px;">大分類</th>
                                    <th style="width: 200px;">中分類</th>
                                    <th style="width: 200px;">小分類</th>
                                    <th style="width: 200px;">細分類</th>
                                    <th style="width: 400px;">コメント</th>
                                    <th style="width: 580px;">内容</th>
                                </tr>
                            </thead>
                        </table>
                    </div>
                    <!-- display: none; -->
                    <div class="c_detail_content" style="overflow: auto;" onscroll="scrollHead(this);">
                        <table class="table_detail_content" id="doclisttable" style="table-layout: fixed;width: 2200px;">
                            
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