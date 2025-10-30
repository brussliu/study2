<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="efw" uri="efw" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>単語テスト</title>
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
            /* .d {
                display: none;
            } */
            .e {
                display: none;
            }
        </style>
        <script>


            $(document).ready(function() {

                // alert(screen.availWidth);
                // alert(window.innerWidth);

                // window.moveTo(0,0);
                // window.resizeTo(screen.availWidth + 10,1000);

                // alert(window.innerWidth);
                // 添加一个option
                // for(var i = 1;i <= 70;i ++){

                //     var key = "Day" + i.toString().padStart(2, '0');

                //     $("#opt_dayfrom").append("<option class='addcontent' value='" + i + "'>" + key + "</option>");
                //     $("#opt_dayto").append("<option class='addcontent' value='" + i + "'>" + key + "</option>");
                // }
            
                $("#opt_dayfrom").focus();
            });

            function changeDayTo(){

                var from = $("#opt_dayfrom").val();
                var to = $("#opt_dayto").val();

                $('#opt_dayto option').each(function(){
                    var optionValue = $(this).val();
                    var optionText = $(this).text();

                    if(optionValue < from){
                        $(this).hide();
                    }else{
                        $(this).show();
                    }
                    
                });
                if(to == ""){
                    $("#opt_dayto").val(from);
                }

                $("#opt_dayto").focus();
                
            }

            function changeDayFrom(){

                var from = $("#opt_dayfrom").val();
                var to = $("#opt_dayto").val();

                $('#opt_dayfrom option').each(function(){
                    var optionValue = $(this).val();
                    var optionText = $(this).text();

                    if(optionValue > to){
                        $(this).hide();
                    }else{
                        $(this).show();
                    }
                    
                });
                if(from == ""){
                    $("#opt_dayfrom").val(to);
                }

                $("#btnFixRange").focus();

            }

            function focusNext(){
                $("#rdo_all").focus();
            }

            function fixRange() {
                Efw("testword_fixrange");
            }

            function showWorldCount(count) {

                $('#worldCounthidden').val(count);

                $('#worldCountDiv1').children().eq(0).html("単語数：" + count + "個");
                $('#worldCountDiv1').show();


                var count2 = $("#opt_testcount").val();

                var way = $("input[name='radioword']:checked").val();

                if(way == "all"){

                    $('#worldCountDiv2').children().eq(0).html("単語数：" + count + "個");
                    
                }else{

                    $('#worldCountDiv2').children().eq(0).html("単語数：" + (count < count2 ? count : count2) + "個");

                }          
                $('#worldCountDiv2').show();


                $('#testway').show();
                $('#testway').next().next().show();

                $('#testway').next().next().next().show();

            }

            function changeTestCount(){

                var count = $("#opt_testcount").val();
                $('#worldCountDiv2').children().eq(0).html("単語数：" + count + "個");

                $('#worldCountDiv2').show();
            }

            function changeTestWay1(){

                var way = $("input[name='radioword']:checked").val();
                if(way == "all"){
                    var count = $("#worldCounthidden").val();
                    $('#worldCountDiv2').children().eq(0).html("単語数：" + count + "個");

                    $('#worldCountDiv2').show();
                    $('#opt_testcount').prop('disabled', true);

                    $('#testway1hidden').val("all");
                    

                }else if(way == "part"){

                    var count1 = $("#worldCounthidden").val();
                    var count2 = $("#opt_testcount").val();

                    $('#worldCountDiv2').children().eq(0).html("単語数：" + (count1 < count2 ? count1 : count2) + "個");
                    $('#worldCountDiv2').show();
                    $('#opt_testcount').prop('disabled', false);

                    $('#testway1hidden').val("part");
                }
            }

            function changeKind(){

                var kind = $('#opt_kind').val();
                
                if(kind == "A.勉強" || kind == "D.英訳中"){

                    $('#opt_level').prop('disabled', true);

                }else{

                    $('#opt_level').prop('disabled', false);

                }

            }

            function changeBook(){

                var book = $('#opt_book').val();

                if(book == "99.テスト"){
                    $("#opt_kind .e").show();
                }else{
                    $("#opt_kind .e").hide();
                }

            }

            // function changeTestWay2(){

            //     var way2 = $("#opt_way2").val();



            //     if(way2 == "7"){

            //         $("#opt_way3 option[value='2']").show();

            //         $("#opt_way3").val("2");

            //         $('#opt_way3').prop('disabled', true);

            //         $("input[name='radiodiv'][value='1']").prop('checked', true);

            //         $("input[name='radiodiv'][value='2']").prop('disabled', true);
            //         $("input[name='radiodiv'][value='3']").prop('disabled', true);
                    
                    
            //     }else{

            //         $("#opt_way3 option[value='2']").hide();

            //         $("#opt_way3").val("0");

            //         $('#opt_way3').prop('disabled', false);

            //         $("input[name='radiodiv'][value='2']").prop('disabled', false);
            //         $("input[name='radiodiv'][value='3']").prop('disabled', false);
            //     }



            // }


            function startTest(){
                Efw("testword_starttest");
            }

            function init(){
                Efw("testword_init_init");
            }

            function initclassification(){

                Efw('testword_init_initclassification');
            }

        </script>
    </head>

    <body onload="init()">

        <div class="content" style="width: 100%;">
            <div class="c_detail_header" style="margin-top: 20px;height:205px;">
                <table style="width: 100%;" border="0">
                    <tr style="height: 50px;">
                        <td style="font-weight: bold;font-size: 16px;">
                            <span style="font-weight: bold;font-size: 20px;color:blue;">【テスト範囲】</span>
                        </td>
                    </tr>
                    <tr style="height: 40px;">
                        <td style="font-weight: bold;font-size: 16px;">
                            &nbsp;・書籍　
                            <select id="opt_book" style="width: 250px;height:30px;border-style: solid;font-size: 16px;" tabindex="10" onchange="initclassification();changeBook();">
                            </select>
                        </td>
                    </tr>
                    <tr style="height: 40px;">
                        <td style="font-weight: bold;font-size: 16px;">
                            &nbsp;・条件　
                            <select id="opt_dayfrom" style="width: 109px;height:30px;border-style: solid;font-size: 16px;" onchange="changeDayTo();" tabindex="20">
                                <option value=""></option>
                            </select>
                            ～
                            <select id="opt_dayto" style="width: 109px;height:30px;border-style: solid;font-size: 16px;" onchange="changeDayFrom();" tabindex="30">
                                <option value=""></option>
                            </select>
                        </td>
                    </tr>
                    <tr style="height: 60px;">
                        <td style="font-weight: bold;font-size: 16px;text-align: center;" colspan="2">
                            <button onclick="fixRange();" id="btnFixRange" style="width: 70%;height: 40px;font-size: 20px;font-weight: bold;" tabindex="40">範囲確認</button>
                        </td>
                    </tr>
                </table>
            </div>
            <div style="text-align: center;width: 100%;display: none;" id="worldCountDiv1">
                <span style="font-size: 20px;color: red;font-weight: bold;">
                    <!-- 単語数：9999個 -->
                </span>
                <input type="hidden" id="worldCounthidden">
            </div>
            <div class="c_detail_header" style="margin-top: 0px;height:290px;display: none;" id="testway">
                <table style="width: 100%;" border="0">
                    <tr style="height: 50px;">
                        <td style="font-weight: bold;font-size: 16px;">
                            <span style="font-weight: bold;font-size: 20px;color:blue;">【テスト方式】</span>
                        </td>
                    </tr>
                    <tr style="height: 40px;">
                        <td style="font-weight: bold;font-size: 16px;">
                            &nbsp;・範囲　
                            <input type="radio" tabindex="50" id="rdo_all" style="width: 16px;height: 16px;" name="radioword" onchange="changeTestWay1();" value="all" checked>&nbsp;全部
                            <input type="radio" tabindex="60" id="rdo_port" style="width: 16px;height: 16px;" name="radioword" onchange="changeTestWay1();" value="part">&nbsp;一部抽選
                            <input type="hidden" id="testway1hidden" value="all">
                            <select id="opt_testcount" tabindex="70" style="width: 80px;height:30px;border-style: solid;font-size: 16px;margin-top: 0px;" onchange="changeTestCount();" disabled>
                                <option value="10">10語</option>
                                <option value="20">20語</option>
                                <option value="30">30語</option>
                                <option value="50">50語</option>
                                <option value="80">80語</option>
                                <option value="100">100語</option>
                            </select>
                        </td>
                    </tr>
                    <tr style="height: 40px;">
                        <td style="font-weight: bold;font-size: 16px;">
                            &nbsp;・種類　
                            <select id="opt_kind" tabindex="71" style="width: 250px;height:30px;border-style: solid;font-size: 16px;margin-top: 0px;" onchange="changeKind();">
                                <option value="A.勉強">&nbsp;A.勉強</option>
                                <option value="B.中日訳英">&nbsp;B.中日訳英</option>
                                <option value="C.音訳英">&nbsp;C.音訳英</option>
                                <option value="D.英訳中" class="d">&nbsp;D.英訳中</option>
                                <option value="E.文章練習" class="e">&nbsp;E.文章練習</option>
                            </select>
                        </td>
                    </tr>
                    <tr style="height: 40px;">
                        <td style="font-weight: bold;font-size: 16px;">
                            &nbsp;・難易度
                            <select id="opt_level" tabindex="71" style="width: 250px;height:30px;border-style: solid;font-size: 16px;margin-top: 0px;" disabled>
                                <option value="1.簡単" selected>&nbsp;1.簡単</option>
                                <!-- <option value="2.困難">&nbsp;2.困難</option> -->
                            </select>
                        </td>
                    </tr>
                    <tr style="height: 60px;">
                        <td style="font-weight: bold;font-size: 16px;text-align: center;">
                            <button onclick="startTest();" style="width: 70%;height: 40px;font-size: 20px;font-weight: bold;" tabindex="100" >テスト開始</button>
                        </td>
                    </tr>
                </table>
            </div>
            <div style="margin-top:5px;text-align: center;width: 100%;display: none;" id="worldCountDiv2">
                <span style="font-size: 20px;color: red;font-weight: bold;">
                    <!-- 単語数：10個 -->
                </span>
                <input type="hidden" id="worldCounthidden">
            </div>
        </div>
    </body>
</html>