<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="efw" uri="efw" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>サイト制限管理</title>
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
            .highlight {
                background-color: #ff6b6b !important;
                color: white;
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
            
            function search(){
                Efw('sitelimit_search');
            }

            function checkItem(obj){

                var n = 0;

                $('#limitinfotable input[type="checkbox"]').each(function() {

                    if($(this).prop('checked') == true){
                        n = n + 1;
                    }

                });

                if(n == 0){
                    $("#btn_apply").prop("disabled", true);

                }else if(n == 1){
                    $("#btn_apply").prop("disabled", false);

                }else if(n >= 2){
                    $("#btn_apply").prop("disabled", true);
                }

            }

            function apply(){

                var site = "";
                var time = "";
                $('#limitinfotable input[type="checkbox"]').each(function() {

                    if($(this).prop('checked') == true){
                        
                        time = $(this).parent().next().children().eq(0).val();
                        site = $(this).parent().next().next().children().eq(0).html();
                    }

                });

                Efw('sitelimit_apply', {site : site, time : time});

            }

            // // 根据星期几获取需要高亮的列索引
            // function getHighlightColumns(dayOfWeek) {
            //     // 定义星期几对应的列索引（从0开始）
            //     const columnMap = {
            //         0: [6, 13],   // 星期日：第7列和第14列
            //         1: [0, 7],    // 星期一：第1列和第8列
            //         2: [1, 8],    // 星期二：第2列和第9列
            //         3: [2, 9],    // 星期三：第3列和第10列
            //         4: [3, 10],   // 星期四：第4列和第11列
            //         5: [4, 11],   // 星期五：第5列和第12列
            //         6: [5, 12]    // 星期六：第6列和第13列
            //     };
                
            //     return columnMap[dayOfWeek] || [];
            // }


            function changeColor(flg){

                $("#limitinfotable tr").each(function () {

                    var status = $(this).children().eq(3).children().eq(0).html();
                    console.log(status);

                    if(status == 'locked'){
                        //$(this).css("background-color", "rgb(200,255,200)");
                    }else if(status == 'unlocked'){
                        $(this).css("background-color", "rgb(200,255,200)");
                    }
                    
                });

                if(flg == 0){
                    // （0-6，0代表星期日）
                    var week = new Date().getDay();

                    // 移除之前的高亮
                    $("#limitinfotable").find('.highlight').removeClass('highlight');
                    

                    $("#limitinfotable").find('tr').each(function() {
                        if(week != 0){
                            $(this).find('td:eq(' + (week + 6) + '), td:eq(' + (week + 6 + 8) + ')').addClass('highlight');
                        }else{
                            $(this).find('td:eq(' + (week + 13) + '), td:eq(' + (week + 13 + 8) + ')').addClass('highlight');
                        }
                        
                    });

                    if(week != 0){
                    
                        $("#limitinfotitletable").find('tr:eq(1)').find('th:eq(' + (week - 1) + '), th:eq(' + (week - 1 + 8) + ')').addClass('highlight');
                    }else{
                        $("#limitinfotitletable").find('tr:eq(1)').find('th:eq(' + (week + 6) + '), th:eq(' + (week + 6 + 8) + ')').addClass('highlight');
                    }
                }else{
                    $("#limitinfotable").find('tr').each(function() {
                        $(this).find('td:eq(14), td:eq(22)').addClass('highlight');
                    });
                    $("#limitinfotitletable").find('tr:eq(1)').find('th:eq(7), th:eq(15)').addClass('highlight');
                }

                // $("#limitinfotitletable").find('tr:eq(1)').each(function() {
                //     if(week != 0){
                //         $(this).find('th:eq(' + (week + 6) + '), th:eq(' + (week + 6 + 8) + ')').addClass('highlight');
                //     }else{
                //         $(this).find('th:eq(' + (week + 13) + '), th:eq(' + (week + 13 + 8) + ')').addClass('highlight');
                //     }
                    
                // });
                

            }
        </script>
    </head>

    <body onload="">
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
                <p><a href="common_menu.jsp">メニュー</a> > サイトアクセス制限</p>
            </div>
            <div class="content">
                <div class="c_btn">
                    <table class="table_btn" >
                        <tbody>
                            <tr>
                                <td style="width: 180px;">
                                    <!-- 分類:
                                    <select id="opt_classification" style="width: 100px;" >
                                        <option value=""></option>
                                    </select> -->
                                </td>
                                <td></td>
                                <td style="width: 180px;"><button id="btn_apply" onclick="apply();" disabled>アクセス申請</button></td>
                                <td style="width: 180px;"><button style="width: 120px;" onclick="search();">検索</button></td>
                            </tr>
                        </tbody>
                    </table>
                </div>

                <div class="c_detail_header" style="overflow: hidden;height: 91px;" id="wordinfoheaddiv">
                    <table class="table_detail_header" style="table-layout: fixed;" id="limitinfotitletable">
                        <thead>
                            <tr class="header">
                                <th style="width: 50px;" rowspan="2">選択</th>
                                <th style="width: 100px;" rowspan="2">アクセス申請</th>
                                <th style="width: 250px;" rowspan="2">サイト</th>
                                <th style="width: 80px;" rowspan="2">ステータス</th>
                                <th style="width: 100px;" rowspan="2">分類</th>
                                <th style="width: 60px;" rowspan="2" 
                                    title="S0：常にロック&#13;S1：勉強時間達成後はアクセス申請可能&#13;S2：いつでもアクセス申請可能&#13;S3：勉強時間達成後はアクセス可能"
                                >区分</th>
                                <th style="width: 60px;" rowspan="2">条件<br/>達成</th>
                                <th                       colspan="8">条件</th>
                                <th                       colspan="8">額度</th>
                                <th style="width: 120px;" rowspan="2">ロック時間帯</th>
                                <th style="width: 80px;" rowspan="2">ロック時点<br/>次回</th>
                            </tr>
                            <tr class="header">
                                <th style="width: 40px;">月</th>
                                <th style="width: 40px;">火</th>
                                <th style="width: 40px;">水</th>
                                <th style="width: 40px;">木</th>
                                <th style="width: 40px;">金</th>
                                <th style="width: 40px;">土</th>
                                <th style="width: 40px;">日</th>
                                <th style="width: 40px;">休</th>
                                <th style="width: 40px;">月</th>
                                <th style="width: 40px;">火</th>
                                <th style="width: 40px;">水</th>
                                <th style="width: 40px;">木</th>
                                <th style="width: 40px;">金</th>
                                <th style="width: 40px;">土</th>
                                <th style="width: 40px;">日</th>
                                <th style="width: 40px;">休</th>
                            </tr>
                        </thead>
                    </table>
                </div>

                <div class="c_detail_content" style="overflow: auto;" onscroll="scrollHead(this);">
                    <table class="table_detail_content" id="limitinfotable" style="table-layout: fixed;">

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