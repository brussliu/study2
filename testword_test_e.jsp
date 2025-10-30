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
        <script type="text/javascript" src="js/study_common.js"></script>
        <script type="text/javascript" src="js/studyE.js"></script>
        <style>
            .efw_input_focus{
                background-color:lightcyan;
            }
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

            .inputword {
                width: 60px;
                height: 100px;
                text-align: center;
                font-size: 40px;
                color: red;
                background-color: rgb(240, 255, 255);
                border-top-style: none;
                border-left-style: none;
                border-right-style: none;
                border-bottom-style: solid;
                border-bottom-width: 5px;
                ime-mode: disabled;
                /* font-family: -apple-system, BlinkMacSystemFont, "PingFang SC", "Microsoft YaHei", sans-serif; */
                /* font-family:Fredoka, sans-serif; */
                margin-left: 5px;
            }
            .inputword:focus {
                outline: none;
            }

            .inputword2 {
                background-color: rgb(210,250,210);
            }
            #wordEDiv .inputword2:focus {
                background-color: rgb(210,250,210);
            }
            .inputsentence {
                width: 800px;
                height: 100px;
                text-align: center;
                font-size: 72px;
                /* font-weight: bold; */
                color: red;
                background-color: rgb(240, 255, 255);
                border-top-style: none;
                border-left-style: none;
                border-right-style: none;
                border-bottom-style: solid;
                border-bottom-width: 5px;
                /* font-family: -apple-system, BlinkMacSystemFont, "PingFang SC", "Microsoft YaHei", sans-serif; */
                /* font-family:Fredoka, sans-serif; */
            }
            .inputsentence:focus {
                outline: none;
            }

            .wrongworddiv {
                width: 1200px;
                /* height: 80px; */
                text-align: center;
                font-size: 40px;
                /* font-weight: bold; */
                color: red;
                text-decoration: line-through;
                background-color: rgb(180, 255, 255);
                border-top-style: none;
                border-left-style: none;
                border-right-style: none;
                border-bottom-style: none;
                display: flex;
                align-items: center;
                justify-content: center;
                /* font-family: -apple-system, BlinkMacSystemFont, "PingFang SC", "Microsoft YaHei", sans-serif; */
                /* font-family:Fredoka, sans-serif; */

            }
            .worddiv {
                width: 1200px;
                /* height: 80px; */
                text-align: center;
                font-size: 40px;
                /* font-weight: bold; */
                color: blue;
                background-color: rgb(180, 255, 255);
                border-top-style: none;
                border-left-style: none;
                border-right-style: none;
                border-bottom-style: none;
                display: flex;
                align-items: center;
                justify-content: center;
                /* font-family: -apple-system, BlinkMacSystemFont, "PingFang SC", "Microsoft YaHei", sans-serif; */
                /* font-family:Fredoka, sans-serif; */

            }
            .sen1div {
                width: 1200px;
                height: 80px;
                text-align: center;
                font-size: 60px;
                /* font-weight: bold; */
                color: blue;
                background-color: rgb(180, 255, 255);
                border-top-style: none;
                border-left-style: none;
                border-right-style: none;
                border-bottom-style: none;
                display: flex;
                align-items: center;
                justify-content: center;
                /* font-family: -apple-system, BlinkMacSystemFont, "PingFang SC", "Microsoft YaHei", sans-serif; */
                /* font-family:Fredoka, sans-serif; */
            }
            .wrongsen1div {
                width: 1200px;
                height: 80px;
                text-align: center;
                font-size: 60px;
                /* font-weight: bold; */
                color: red;
                text-decoration: line-through;
                background-color: rgb(180, 255, 255);
                border-top-style: none;
                border-left-style: none;
                border-right-style: none;
                border-bottom-style: none;
                display: flex;
                align-items: center;
                justify-content: center;
                /* font-family: -apple-system, BlinkMacSystemFont, "PingFang SC", "Microsoft YaHei", sans-serif; */
                /* font-family:Fredoka, sans-serif; */
            }
            .sen2div {
                width: 1200px;
                height: 80px;
                text-align: center;
                font-size: 60px;
                /* font-weight: bold; */
                color: blue;
                background-color: rgb(180, 255, 255);
                border-top-style: none;
                border-left-style: none;
                border-right-style: none;
                border-bottom-style: none;
                display: flex;
                align-items: center;
                justify-content: center;
                /* font-family: -apple-system, BlinkMacSystemFont, "PingFang SC", "Microsoft YaHei", sans-serif; */
                /* font-family:Fredoka, sans-serif; */
            }
            .wrongsen2div {
                width: 1200px;
                height: 80px;
                text-align: center;
                font-size: 60px;
                /* font-weight: bold; */
                color: red;
                text-decoration: line-through;
                background-color: rgb(180, 255, 255);
                border-top-style: none;
                border-left-style: none;
                border-right-style: none;
                border-bottom-style: none;
                display: flex;
                align-items: center;
                justify-content: center;
                /* font-family: -apple-system, BlinkMacSystemFont, "PingFang SC", "Microsoft YaHei", sans-serif; */
                /* font-family:Fredoka, sans-serif; */
            }

            @font-face {
                font-family: "Fredoka";
                src: url("./fonts/static/Fredoka-Regular.ttf") format("truetype");
            }
            input[type="text"] {
                font-family: "Fredoka", sans-serif;
            }

        </style>
        <script>

            // 初期化
            function initE() {
                Efw('testword_test_e');
            }

            function overTest(){
                alert("テスト完了しました！");
                window.close();
 
                if (window.opener && !window.opener.closed) {
                    window.opener.location.reload();
                }

            }

            // function goBack(){
            //     $('#hiddenOpt').val("back");
            //     Efw('testword_updatedetail');
            // }

            function goNext(){

                // if($('#hiddenWordCheckResult').val() != "OK"){
                //     $('#hiddenWordWrongTime').val(null);
                // }
                // if($('#hiddenSen1CheckResult').val() != "OK"){
                //     $('#hiddenSen1WrongTime').val(null);
                // }
                // if($('#hiddenSen2CheckResult').val() != "OK"){
                //     $('#hiddenSen2WrongTime').val(null);
                // }
                
                $('#hiddenOpt').val("next");
                Efw('testword_updatedetail_e');
            }

        </script>
    </head>

    <body onload="initE();">
        <div class="content" style="width: 100%;">
            <div class="c_detail_header" style="margin-top: 10px;height:60px;text-align: center;">
                <span style="font-weight: bold;font-size: 40px;color:darkgreen;" id="bookspan"></span>
            </div>
            <div class="c_detail_header" style="margin-top: 0px;height:60px;text-align: center;">
                <span style="font-weight: bold;font-size: 40px;color:maroon;" id="nospan"></span>
            </div>
            <div style="justify-content: center;">
                <div class="c_detail_header" style="margin-top: 0px;height:50px;">
                    <span style="font-weight: bold;font-size: 30px;color:brown">【単語】</span>
                    <img style="width: 40px;height: 40px;margin: -10px;" src="img/speaker.png" id="wordIcon" onclick="playVoice(1,1);" ondblclick="playVoice(1,2);">
                </div>
                <div class="c_detail_header" style="height:40px;text-align: right;display: none;" id="wordWrongTimeDiv">
                    <span style="font-weight: bold;font-size: 24px;color:red;">誤り回数：1回</span>
                </div>
                <div style="margin-top:10px;text-align: center;width: 100%;">
                    <span style="font-size: 24px;font-weight: bold;color:blue;" id="wordCSpan"></span><br/>
                    <span style="font-size: 30px;font-weight: bold;" id="wordJSpan"></span>
                </div>
                <div style="margin-top:20px;text-align: center;width: 100%;font-size: 50px;color: red;" id="wordEDiv">
                </div>
                <div style="margin-top:20px;text-align: center;width: 100%;display: flex;justify-content: center;align-items: center;display: none;">
                    <div class="wrongworddiv">this is a dog</div>
                </div>
                <div style="margin-top:20px;text-align: center;width: 100%;display: flex;justify-content: center;align-items: center;display: none;">
                    <div class="worddiv">this is a dog</div>
                </div>
                <!-- 
                <div style="margin-top:10px;text-align: center;width: 100%;">
                    <span style="font-weight: bold;color:blue;font-size: 72px;display: none;" id="wordESpan">dog</span>
                </div>
                <div style="margin-top:20px;text-align: center;width: 100%;font-size: 50px;color: red;" id="wordEDiv">
                </div>
                -->
                <!-- 
                <div style="margin-top:20px;text-align: left;width: 100%;display: flex;justify-content: center;align-items: center;">
                    <div style="text-align: left;width: 600px;font-size: 54px;">
                        <input type="radio" id="wordC1" name="resultItem" value="1" onclick="checkResult(this);" style="width: 30px;height: 30px;margin-left: 10px;">
                            &nbsp;<span style="font-size: 48px;"></span>
                        </input>
                    </div>
                </div>
                -->
            </div>


            <div style="margin-top:20px;text-align: center;width: 100%;height: 120px;;">
                <button onclick="goBack()" style="width: 30%;height: 80px;font-size: 30px;font-weight: bold;display: none;" id="btnback">前へ</button>
                &nbsp;&nbsp;&nbsp;&nbsp;
                <button onclick="goNext()" style="width: 30%;height: 80px;font-size: 30px;font-weight: bold;display: none;" id="btnnext">次へ</button>
            </div>
        </div>

        <input type="hidden" id="hiddenOpt">

        <input type="hidden" id="hiddenTestNo">
        <input type="hidden" id="hiddenWordNo">
        <input type="hidden" id="hiddenWordCount">

        <input type="hidden" id="hiddenWordWrongTime">

        <input type="hidden" id="hiddenWordE">
        <input type="hidden" id="hiddenWordJ">
        <input type="hidden" id="hiddenWordC">

        <input type="hidden" id="hiddenSen1E">
        <input type="hidden" id="hiddenSen1J">
        <input type="hidden" id="hiddenSen1C">
        
        <input type="hidden" id="hiddenSen2E">
        <input type="hidden" id="hiddenSen2J">
        <input type="hidden" id="hiddenSen2C">

        <input type="hidden" id="hiddenType">
        <input type="hidden" id="hiddenKind">
        <input type="hidden" id="hiddenLevel">

        <input type="hidden" id="hiddenBook">
        <input type="hidden" id="hiddenclassification">
        <input type="hidden" id="hiddenwordseq">

        <!-- <input type="hidden" id="hiddenMp3"> -->

        <input type="hidden" id="hiddenWordNoteSeq">

        <input type="hidden" id="hiddenWordCheckResult">

    </body>
</html>