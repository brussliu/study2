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
        <script type="text/javascript" src="js/studyD.js"></script>
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

            .inputword,.inputsentence1 {
                width: 60px;
                height: 100px;
                text-align: center;
                font-size: 72px;
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
            .worddiv {
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
            .selected {
                border: 3px solid #3498db;
                box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.2);
                transform: scale(1.02);
            }
            .highlight {
                color: red;
            }
        </style>
        <script>

            // 初期化
            function initD() {
                Efw('testword_test_d');
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
                Efw('testword_updatedetail_d');
            }

        </script>
    </head>

    <body onload="initD();">
        <div class="content" style="width: 100%;overflow: auto;">
            <div class="c_detail_header" style="margin-top: 10px;height:60px;text-align: center;">
                <span style="font-weight: bold;font-size: 40px;color:darkgreen;" id="bookspan"></span>
            </div>
            <div class="c_detail_header" style="margin-top: 0px;height:60px;text-align: center;">
                <span style="font-weight: bold;font-size: 40px;color:maroon;" id="nospan"></span>
            </div>
            <div>
                <div class="c_detail_header" style="margin-top: 0px;height:50px;">
                    <span style="font-weight: bold;font-size: 30px;color:brown">【単語】</span>
                    <img style="width: 40px;height: 40px;margin: -10px;" src="img/speaker.png" id="wordIcon" onclick="playVoice(1,1);" ondblclick="playVoice(1,2);">
                </div>
                <div style="margin-top:10px;text-align: center;width: 100%;">
                    <span style="font-size: 24px;font-weight: bold;display: none;color:blue;" id="wordCSpan"></span><br/>
                    <span style="font-size: 30px;font-weight: bold;display: none;" id="wordJSpan"></span>
                </div>
                <div style="margin-top:10px;text-align: center;width: 100%;">
                    <span style="font-weight: bold;color:blue;font-size: 64px;" id="wordESpan">dog</span>
                </div>
                <div style="margin-top:10px;text-align: center;width: 100%;">
                    <span style="font-weight: bold;color:blue;font-size: 56px;" id="question"></span>
                </div>

                <div style="margin-top:20px;text-align: left;width: 100%;display: flex;justify-content: center;align-items: center;">
                    <div style="text-align: left;width: 600px;font-size: 48px;" class="selected">
                        <input type="radio" id="wordC1" name="resultItem" value="1" onclick="checkResult(this);" style="width: 30px;height: 30px;margin-left: 10px;">
                            &nbsp;<span style="font-size: 40px;"></span>
                        </input>
                    </div>
                </div>
                <div style="margin-top:20px;text-align: left;width: 100%;display: flex;justify-content: center;align-items: center;">
                    <div style="text-align: left;width: 600px;font-size: 48px;">
                        <input type="radio" id="wordC2" name="resultItem" value="2" onclick="checkResult(this);" style="width: 30px;height: 30px;margin-left: 10px;">
                            &nbsp;<span style="font-size: 40px;"></span>
                        </input>
                    </div>
                </div>
                <div style="margin-top:20px;text-align: left;width: 100%;display: flex;justify-content: center;align-items: center;">
                    <div style="text-align: left;width: 600px;font-size: 48px;">
                        <input type="radio" id="wordC3" name="resultItem" value="3" onclick="checkResult(this);" style="width: 30px;height: 30px;margin-left: 10px;">
                            &nbsp;<span style="font-size: 40px;"></span>
                        </input>
                    </div>
                </div>
                <div style="margin-top:20px;text-align: left;width: 100%;display: flex;justify-content: center;align-items: center;">
                    <div style="text-align: left;width: 600px;font-size: 48px;">
                        <input type="radio" id="wordC4" name="resultItem" value="4" onclick="checkResult(this);" style="width: 30px;height: 30px;margin-left: 10px;">
                            &nbsp;<span style="font-size: 40px;"></span>
                        </input>
                    </div>
                </div>
                <div style="margin-top:20px;text-align: left;width: 100%;display: flex;justify-content: center;align-items: center;">
                    <div style="text-align: left;width: 80%;font-size: 32px;color: darkcyan;display: none;" id="explain">

                    </div>
                </div>
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

        <input type="hidden" id="hiddenType">
        <input type="hidden" id="hiddenKind">
        <input type="hidden" id="hiddenLevel">

        <input type="hidden" id="hiddenBook">
        <input type="hidden" id="hiddenclassification">
        <input type="hidden" id="hiddenwordseq">

        <input type="hidden" id="hiddenRightRt">
        <input type="hidden" id="hiddenItem1">
        <input type="hidden" id="hiddenItem2">
        <input type="hidden" id="hiddenItem3">
        <input type="hidden" id="hiddenItem4">

        <!-- <input type="hidden" id="hiddenMp3"> -->

        <input type="hidden" id="hiddenWordNoteSeq">

        <input type="hidden" id="hiddenWordCheckResult">

    </body>
</html>