<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="efw" uri="efw" %>
        <html>

        <head>
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            <title>STUDY</title>
            <efw:Client />
            <link rel="stylesheet" href="css/common.css" type="text/css" />
            <link href="favicon.ico" rel="icon" type="image/x-icon" />
            <script type="text/javascript" src="js/menu.js"></script>
            <style>
                /* content */
                .content {
                    width: var(--width);
                    height: 100%;
                    vertical-align: middle;
                }

                .content_l,
                .content_r {
                    display: inline-block;
                }

                .content_l {
                    width: 60%;
                    height: 700px;
                }

                /* .content_b {
                    width: 100%;
                    height: 20vh;
                    vertical-align: bottom;
                    margin-top: 10px;
                    background-color: aqua;
                } */

                .content_r {
                    width: 39%;
                    height: 750px;
                    vertical-align: top;
                    overflow-y: auto;
                    margin-top: 10px;
                }

                /* content_l_nav     */
                .content_l_nav {
                    line-height: 35px;
                    height: 35px;
                    background: rgb(255, 255, 100);
                }

                .content_l_nav p {
                    text-indent: 2.5em;
                }

                /* content_l_btn */
                .content_l_btn {
                    width: 95%;
                    height: 750px;
                    margin: auto;
                }

                .content_l_btn div {
                    width: 100%;
                    height: 14vh;
                    line-height: 14vh;

                    display: flex;
                    justify-content: flex-start;
                    align-items: center;
                    border-bottom: 1px dashed black;

                }

                .content_l_btn td {
                    width: 25%;
                    border-bottom: 1px dashed black;
                }

                .btn {
                    width: 235px;
                    height: 50px;
                    background: rgb(240, 240, 240);
                    font-size: 20px;
                    border: 1px solid rgb(206, 205, 205);
                    box-shadow: 5px 5px 2px #888888;
                    cursor: pointer;
                }

                /* content_l_con */
                .content_l_con p {
                    display: flex;
                    justify-content: flex-start;
                    flex-wrap: wrap;
                    flex-direction: column;
                    word-break: break-all;
                }

                .span_t {
                    border: 1px dashed rgb(145, 139, 139);
                    background-color: #c8ffff;

                }


                /*滚动条样式*/
                .content_r::-webkit-scrollbar {
                    width: 4px;
                    /*height: 4px;*/
                }

                .content_r::-webkit-scrollbar-thumb {
                    border-radius: 10px;
                    -webkit-box-shadow: inset 0 0 5px rgba(0, 0, 0, 0.2);
                    background: rgba(0, 0, 0, 0.2);
                }

                .content_r::-webkit-scrollbar-track {
                    -webkit-box-shadow: inset 0 0 5px rgba(0, 0, 0, 0.2);
                    border-radius: 0;
                    background: rgba(0, 0, 0, 0.1);

                }

                .content_b {
                    width: 95%;
                    height: 300px;
                    margin: auto;
                    /* margin-top: 20px; */
                    overflow-x: auto;
                    white-space: nowrap;
                }
                .content_b>div {
                    display: inline-block;

                    height: 100%;
                    margin: auto;
                    /* background-color: #ffffff; */
                    /* border: 1px solid rgba(0, 0, 0, 0.2); */
                }
                /* .content_b>div p:first-child {
                    height: 37px;
                    margin-left: 10px;
                    font-size: 20px;
                    line-height: 37px;
                }

                .content_b>div p:last-child {
                    width: 90%;
                    margin: auto;
                    font-size: 3.5em;
                    font-weight: bolder;
                    height: 76px;
                    margin-left: 10px;
                    border: 0;
                    text-align: right;
                } */

                .chart-box {
                    text-align: center;
                }
                
                /* .chart-box canvas{
                    background: #f9f9f9;
                } */

                h3 {
                    margin: 10px 0;
                    font-size: 12px;
                    color: rgb(50,50,50);
                }
                .sub {
                    background-color: #eeeeee;
                }

            </style>
            <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
            <script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels"></script>

            <script>

                function changeColor(){

                    $("#testwordinfotable .dt").each(function () {

                        //var bookTd = $(this).children().eq(0);

                        var book = $(this).children().eq(0).children().eq(0).html();

                        if(book.charAt(0) == '0'){
                            $(this).css("background-color", "rgb(255,255,200)");
                        }else if(book.charAt(0) == '1'){
                            $(this).css("background-color", "rgb(200,255,200)");
                        }else if(book.charAt(0) == '9'){
                            $(this).css("background-color", "rgb(255,200,200)");
                        }else if(book == '合計'){
                           ///$(this).css("background-color", "rgb(255,200,200)");
                        }



                        var kind = $(this).children().eq(1).children().eq(0).html();

                        if(kind != "-"){
                            // $(this).children().eq(0).css("border-top","1px dashed black;");
                            // $(this).children().eq(0).css("border-bottom","1px dashed black;");
                            if(kind == "D.英訳中"){
                                $(this).children().eq(0).css("border-top","none");
                                $(this).children().eq(0).css("border-bottom","1px dashed black");
                            }else{
                                $(this).children().eq(0).css("border-top","none");
                                $(this).children().eq(0).css("border-bottom","none");
                            }
                        }

                        if(kind != "-" && book.charAt(0) == '0'){
                            $(this).children().eq(0).css("color", "rgb(255,255,200)");
                        }
                        if(kind != "-" && book.charAt(0) == '1'){
                            $(this).children().eq(0).css("color", "rgb(200,255,200)");
                        }
                        if(kind != "-" && book.charAt(0) == ''){
                            $(this).children().eq(0).css("color", "rgb(255,200,200)");
                        }
                    });

                }
                
                // 
                function openDetail(obj){

                    var book = $(obj).children().eq(0).html();

                    var flg = false;
                    $("#testwordinfotable tr").each(function () {

                        var book2 = $(this).children().eq(0).children().eq(0).html();
                        var kind2 = $(this).children().eq(1).children().eq(0).html();


                        if(book == book2 && kind2 != "-"){
                            
                            //alert($(this).css("display"));
                            if($(this).css("display") == "none"){
                                $(this).css("display","");
                                // 開く
                                flg = true;
                                //$(this).children().eq(0).css("border-bottom","none");
                            }else{
                                $(this).css("display","none");

                                // 閉じる

                                //$(this).children().eq(0).css("border-bottom","1px dashed black;");
                            }
                            
                        }
                        
                    });

                    if(flg == true){
                        $(obj).css("border-top","1px dashed black");
                        $(obj).css("border-bottom","none");
                    }else{
                        $(obj).css("border-top","1px dashed black");
                        $(obj).css("border-bottom","1px dashed black");
                    }
                    
                }

            </script>

        </head>

        <body onload="Efw('common_menuinit');">
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
                    <p>メニュー</p>
                </div>
                <div class="content">
                    <div class="content_l">
                        <table class="content_l_btn" style="margin-right: 10px;">
                            <tbody>
                                <tr style="height: 80px;">
                                    <td><button class="btn" onclick="Efw('common_menu_goto',{page:'testword.jsp'})">単語テスト</button></td>
                                    <td><button class="btn" onclick="Efw('common_menu_goto',{page:'word.jsp'})">単語情報管理</button></td>
                                    <td><button class="btn" onclick="Efw('common_menu_goto',{page:'learning_status.jsp'})">単語勉強状況</button></td>
                                    <td><button class="btn" onclick="Efw('common_menu_goto',{page:'ai_Issues.jsp'})">AIで勉強する</button></td>
                                </tr>
                                <tr style="height: 80px;">
                                    <td><button class="btn" onclick="Efw('common_menu_goto',{page:'test.jsp'})">テスト情報管理</button></td>
                                    <td><button class="btn" onclick="Efw('common_menu_goto',{page:'study_wrongquestion.jsp'})">不正解情報管理</button></td>
                                    <td></td>
                                    <td></td>
                                </tr>
                                <tr style="height: 80px;">
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                </tr>
                                <tr style="height: 80px;">
                                    <td><button class="btn" onclick="Efw('common_menu_goto',{page:'document.jsp'})">資料管理</button></td>
                                    <td></td>
                                    <td></td>
                                    <td><button class="btn" onclick="Efw('common_menu_goto',{page:'sitelimit.jsp'})">サイトアクセス制限</button></td>
                                </tr>
                                <tr style="height: 80px;">
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    <div class="content_r">
                        <!-- <table id="testwordinfotable" class="table_detail_content" >
                            <tr style="height: 40px;font-weight: bold; background-color: aqua;">
                                <td style="width: 150px;border-top: 1px solid black;text-align: center;">書籍</td>
                                <td style="width: 100px;border-top: 1px solid black;text-align: center;">テスト種別</td>
                                <td style="width: 100px;border-top: 1px solid black;text-align: center;">難易度</td>
                                <td style="width: 75px;border-top: 1px solid black;text-align: center;">単語数</td>
                                <td style="width: 75px;border-top: 1px solid black;text-align: center;">勉強済</td>
                                <td style="width: 75px;border-top: 1px solid black;text-align: center;">勉強中</td>
                                <td style="width: 75px;border-top: 1px solid black;text-align: center;">未勉強</td>
                                <td style="width: 80px;border-top: 1px solid black;text-align: center;">完成度</td>
                            </tr>
                        </table> -->
                        <canvas id="myChart1" style="width:100%;height: 350px;"></canvas>
                        <canvas id="myChart2" style="width:100%;height: 350px;"></canvas>
                        <!-- <table id="testwordinfotable2" class="table_detail_content" >
                            <tbody>
                                <tr style="height: 40px;font-weight: bold; background-color: aqua;">
                                    <td style="width: 150px;border-top: 1px solid black;text-align: center;">日付</td>
                                    <td style="width: 500px;border-top: 1px solid black;text-align: center;">勉強時間</td>
                                    <td style="width: 100px;border-top: 1px solid black;text-align: center;">個数</td>
                                </tr>
                            </tbody>
                        </table> -->
                    </div>
                    <div class="content_b" id="charts"></div>
                </div>
            </div>
            <input type="hidden" id="bookList">
            <input type="hidden" id="perList">

            <input type="hidden" id="dList">
            <input type="hidden" id="tkList">
            <input type="hidden" id="tmList">
            <input type="hidden" id="ptList">

            <input type="hidden" id="ddList">
            <input type="hidden" id="allwordcountList">
            <input type="hidden" id="unstudyList">
            <input type="hidden" id="studyingList">
            <input type="hidden" id="studedList">

            <input type="hidden" id="studed_aList">
            <input type="hidden" id="studed_bList">
            <input type="hidden" id="studed_cList">
            <input type="hidden" id="studed_dList">

        </body>
        <script>
            //showTestTimeInfoChat();
            //showTestInfoChatByBook();
            //showWordInfoChat();

        </script>
        </html>
