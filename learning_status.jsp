<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="efw" uri="efw" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>勉強状況確認</title>
        <efw:Client />
        <link rel="stylesheet" href="css/common.css" type="text/css" />
        <link href="favicon.ico" rel="icon" type="image/x-icon" />
        <script type="text/javascript" src="js/common.js"></script>
        <style>
            .c_detail_header {
                width: 95%;
                height: 51px;
            }
            .table_detail_header td{
                border: 1px solid black;
            }
            .table_detail_header th{
                font-size: 12px;
                font-weight: bold;
            }
            .word {
                color: red;
                font-weight: bold;
            }

        </style>
        <script>
            $(document).ready(function() {


            });

            function scrollHead(obj) {
                    var p = $(obj).get(0).scrollLeft;
                    $(obj).prev().get(0).scrollLeft = p;
            }
            
            // 初期化
            function init() {

                Efw('word_init');

            }

            function initclassification(obj,classification){

                var book = $(obj).val();

                Efw('testword_initclassification',{book: book, classification : classification});
            }


            function search(){
                Efw('learning_status_search');
            }

            function changeStyleForWordInfo(){

                
                $("#wordinfotable tr").each(function () {

                    var ct = $(this).children().eq(4).children().eq(0).html();
                    var rt = $(this).children().eq(6).children().eq(0).html();
                    var per = parseFloat($(this).children().eq(7).children().eq(0).html().replaceAll("%",""));

                    var wrong_flg = $(this).children().eq(0).children().eq(1).val();

                    if(wrong_flg == '○'){
                        $(this).css("background-color", "rgb(200,255,200)");
                    }else if(wrong_flg == '△'){
                        $(this).css("background-color", "rgb(255,255,200)");
                    }else if(wrong_flg == '▲'){
                        $(this).css("background-color", "rgb(255,200,200)");
                    }
                    
                });

            }



            function checkWrong(obj){

                if($("#wordstatus1").prop("checked") || $("#wordstatus2").prop("checked") || $("#wordstatus3").prop("checked")){
                
                    // $("#opt_accuracy").val("");
                    // $("#opt_accuracy").prop("disabled", true);

                    $("#keyword").val("");
                    $("#keyword").prop("disabled", true);
                    

                }else{
                    $("#opt_accuracy").prop("disabled", false);
                    $("#keyword").prop("disabled", false);
                }
            }

            // 初期化
            function opAiContentPage(book, classification, wordseq) {

                const windowFeatures =
                "toolbar=no," + 
                "location=no," + 
                "directories=no," + 
                "status=no," + 
                "menubar=no," + 
                "scrollbars=yes," + 
                "resizable=yes," + 
                "width=" + screen.availWidth + "," + 
                "height=" + screen.availHeight;

                window.open("testword_ai_content.jsp", 'aicontent', windowFeatures);

            }

            function aiThisWord(book, classification, wordseq){

                Efw('word_expwordbyai',{book : book, classification : classification, wordseq : wordseq});

            }
        </script>
    </head>

    <body onload="init();">
        <div style="overflow: auto;">
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
                            <td style="text-align: right;padding-right: 20px;" id="sessioninfo" >
                                店舗ID：<span id="shopid" style="font-weight: bold;color: yellow;">未选择</span>
                                &nbsp;&nbsp;&nbsp;
                                UserID：<span id="userid" style="font-weight: bold;color: yellow;">XXXX</span>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <div class="topnav">
                <p><a href="common_menu.jsp">メニュー</a> > 単語状況確認</p>
            </div>
            <div class="content">
                <div class="c_btn">
                    <table class="table_btn" >
                        <tbody>
                            <tr>
                                <td style="width: 240px;">
                                    書籍:
                                    <select id="opt_book" style="width: 160px;" onchange="initclassification(this,'#opt_classification');">
                                        <option value=""></option>
                                    </select>
                                </td>
                                <td style="width: 180px;">
                                    分類:
                                    <select id="opt_classification" style="width: 100px;" >
                                        <option value=""></option>
                                    </select>
                                </td>
                                <td style="width: 200px;">
                                    種別:
                                    <select id="opt_kind" style="width: 100px;" >
                                        <option value=""></option>
                                        <option value="A.勉強">A.勉強</option>
                                        <option value="B.中日訳英">B.中日訳英</option>
                                        <option value="C.音訳英">C.音訳英</option>
                                        <option value="D.英訳中">D.英訳中</option>
                                    </select>
                                </td>
                                <td style="width: 200px;">
                                    正確率:
                                    <select id="opt_accuracy" style="width: 100px;" >
                                        <option value=""></option>
                                        <option value="1">100%</option>
                                        <option value="2">80%～100%</option>
                                        <option value="3">50%～80%</option>
                                        <option value="4">50%未満</option>
                                    </select>
                                </td>
                                <td style="width: 250px;">
                                    キーワード:
                                    <input type="text" style="width: 120px;height: 25px;" id="keyword">
                                </td>
                                <td>
                                    <input type="checkbox" id="wordstatus1" value="1" onchange="checkWrong(this);"/>&nbsp;未勉強
                                    <input type="checkbox" id="wordstatus2" value="2" onchange="checkWrong(this);"/>&nbsp;勉強中
                                    <input type="checkbox" id="wordstatus3" value="3" onchange="checkWrong(this);"/>&nbsp;勉強済
                                </td>
                                <td></td>
                                <td style="width: 130px;"><button style="width: 120px;" onclick="search();">検索</button></td>
                            </tr>
                        </tbody>
                    </table>
                </div>

                <div class="c_detail_header" style="overflow: hidden;" id="wordinfoheaddiv">
                    <table class="table_detail_header" style="table-layout: fixed;" >
                        <thead>
                            <tr class="header">
                                <th style="width: 150px;">書籍</th>
                                <th style="width: 80px;">分類</th>
                                <th style="width: 80px;">単語SEQ</th>

                                <th style="width: 250px;">単語</th>

                                <th style="width: 150px;">テスト種別</th>

                                <th style="width: 100px;color: red;background-color: aqua;">時間</th>
                                <th style="width: 100px;color: red;background-color: aqua;">テスト回数</th>
                                <th style="width: 100px;color: red;background-color: aqua;">全部正確回数</th>
                                <th style="width: 100px;color: red;background-color: aqua;">直近正確回数</th>
                                <th style="width: 100px;color: red;background-color: aqua;">全部正確率</th>

                                <th style="width: 100px;background-color: lightskyblue;">ステータス</th>

                            </tr>
                        </thead>
                    </table>
                </div>

                <div class="c_detail_content" style="overflow: auto;" onscroll="scrollHead(this);">
                    <table class="table_detail_content" id="wordinfotable" style="table-layout: fixed;">

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
            if(h4 == undefined){
                h4 = 0;
            }
            var h5 = $(".c_detail_header").height();

            var h6 = h0 - h1 - h2 - h3 - h4 - h5 - 30 -120;

            $(".c_detail_content").height(h6);

        });
    </script>
</html>