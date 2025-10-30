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
        <script type="text/javascript" src="js/study4.js"></script>
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
            .inputword {
                width: 60px;
                height: 100px;
                text-align: center;
                font-size: 50px;
                font-weight: bold;
                color: red;
                background-color: lightyellow;
                border-top-style: none;
                border-left-style: none;
                border-right-style: none;
                border-bottom-style: solid;
                border-bottom-width: 5px;
                ime-mode: disabled;
            }
            .inputsentence {
                width: 800px;
                height: 80px;
                text-align: center;
                font-size: 50px;
                font-weight: bold;
                color: red;
                background-color: lightyellow;
                border-top-style: none;
                border-left-style: none;
                border-right-style: none;
                border-bottom-style: solid;
                border-bottom-width: 5px;
            }
            .wrongworddiv {
                width: 1200px;
                height: 80px;
                text-align: center;
                font-size: 40px;
                font-weight: bold;
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

            }
            #worddiv_right,#sen1div_right,#sen2div_right {
                width: 1200px;
                height: 80px;
                text-align: center;
                font-size: 40px;
                font-weight: bold;
                color: blue;
                background-color: rgb(180, 255, 255);
                border-top-style: none;
                border-left-style: none;
                border-right-style: none;
                border-bottom-style: none;
                display: flex;
                align-items: center;
                justify-content: center;

            }

        </style>
        <script>

            $(document).ready(function() {

                let mediaWordRecorder;
                let mediaSen1Recorder;
                let mediaSen2Recorder;
                let audioChunks = [];
                
                //--------------------------------------------word----------------------------------------------
                $("#wordStartIcon").on('click', async function () {
                    
                    $("#wordStartIcon").hide();
                    $("#wordStopIcon").show();

                    const stream = await navigator.mediaDevices.getUserMedia({ audio: true });

                    mediaWordRecorder = new MediaRecorder(stream);

                    mediaWordRecorder.ondataavailable = event => {
                        audioChunks.push(event.data);
                    };

                    mediaWordRecorder.onstop = () => {
                        const audioBlob = new Blob(audioChunks, { type: 'audio/wav' });
                        const reader = new FileReader();
                        reader.readAsDataURL(audioBlob);
                        reader.onloadend = () => {

                            $("#wordAudioData").val(reader.result);
                            audioChunks = [];
                            $("#wordAudioPlayBack").prop("src", $("#wordAudioData").val());
                        };

                    };

                    mediaWordRecorder.start();
                    $("#wordAudioPlayBack").next().show();
                });

                $("#wordStopIcon").on('click', function(){
                    mediaWordRecorder.stop();
                    $("#wordAudioPlayBack").next().hide();
                    $("#wordStopIcon").hide();

                    overWord();
                    showSen1();
                });

                //--------------------------------------------sen1----------------------------------------------
                $("#sen1StartIcon").on('click', async function () {
                    
                    $("#sen1StartIcon").hide();
                    $("#sen1StopIcon").show();

                    const stream = await navigator.mediaDevices.getUserMedia({ audio: true });

                    mediaSen1Recorder = new MediaRecorder(stream);

                    mediaSen1Recorder.ondataavailable = event => {
                        audioChunks.push(event.data);
                    };

                    mediaSen1Recorder.onstop = () => {
                        const audioBlob = new Blob(audioChunks, { type: 'audio/wav' });
                        const reader = new FileReader();
                        reader.readAsDataURL(audioBlob);
                        reader.onloadend = () => {

                            $("#sen1AudioData").val(reader.result);
                            audioChunks = [];
                            $("#sen1AudioPlayBack").prop("src", $("#sen1AudioData").val());
                        };

                    };

                    mediaSen1Recorder.start();
                    $("#sen1AudioPlayBack").next().show();

                });

                $("#sen1StopIcon").on('click', function(){
                    mediaSen1Recorder.stop();
                    $("#sen1AudioPlayBack").next().hide();
                    $("#sen1StopIcon").hide();

                    overSen1();
                    showSen2();
                });

                //--------------------------------------------sen1----------------------------------------------
                $("#sen2StartIcon").on('click', async function () {
                    
                    $("#sen2StartIcon").hide();
                    $("#sen2StopIcon").show();

                    const stream = await navigator.mediaDevices.getUserMedia({ audio: true });

                    mediaSen2Recorder = new MediaRecorder(stream);

                    mediaSen2Recorder.ondataavailable = event => {
                        audioChunks.push(event.data);
                    };

                    mediaSen2Recorder.onstop = () => {
                        const audioBlob = new Blob(audioChunks, { type: 'audio/wav' });
                        const reader = new FileReader();
                        reader.readAsDataURL(audioBlob);
                        reader.onloadend = () => {

                            $("#sen2AudioData").val(reader.result);
                            audioChunks = [];
                            $("#sen2AudioPlayBack").prop("src", $("#sen2AudioData").val());
                        };

                    };

                    mediaSen2Recorder.start();
                    $("#sen2AudioPlayBack").next().show();

                });

                $("#sen2StopIcon").on('click', function(){
                    mediaSen2Recorder.stop();
                    $("#sen2AudioPlayBack").next().hide();

                    $("#sen2StopIcon").hide();
                    overSen2();
                });

                $("body").keydown(function(event) {

                    var keycode = (event.keyCode ? event.keyCode : event.which);
                    
                    var status = getStatus();

                    optKeyDown(keycode,status);


                });


            });

            function optKeyDown(keycode, status){

                console.log("keycode:" + keycode);

                // キー：右
                if(keycode === 39) {
                    if($("#btnnext").is(":visible")){
                        $("#btnnext").click();
                        return;
                    }
                // キー：左 
                }else if(keycode === 37){
                    if($("#btnback").is(":visible")){
                        $("#btnback").click();
                        return;
                    }
                }

                if(status != null){

                    if(keycode === 16) {
                        playVoice(parseInt(status),0);
                    }
                    if(keycode === 17) {
                        playVoice(parseInt(status),1);
                    }
                    if(keycode === 18) {
                        playVoice(parseInt(status),2);
                    }
                    if(keycode === 13) {
                        optAudio(parseInt(status))
                    }

                }else{
                    if(keycode === 13) {
                        if($("#btnnext").is(":visible")){
                            $("#btnnext").click();
                        }
                    }
                }
            }


            function optAudio(no){

                if(no == 1){
                    
                    if ($("#wordStartIcon").is(":visible")){
                        $("#wordStartIcon").click();
                    }else{
                        $("#wordStopIcon").click();
                    }
                    
                }
                if(no == 2){
                    if ($("#sen1StartIcon").is(":visible")){
                        $("#sen1StartIcon").click();
                    }else{
                        $("#sen1StopIcon").click();
                    }
                }
                if(no == 3){
                    if ($("#sen2StartIcon").is(":visible")){
                        $("#sen2StartIcon").click();
                    }else{
                        $("#sen2StopIcon").click();
                    }
                }
            }



            function getStatus(){

                var status = null;

                if($("#wordCSpan").css("display") == "none"){
                
                    status = "1"; 
                
                }else if($("#hiddenSen1E").val() != null && $("#hiddenSen1E").val() != "" && $("#sen1CSpan").css("display") == "none"){

                    status = "2"; 

                }else if($("#hiddenSen2E").val() != null && $("#hiddenSen2E").val() != "" && $("#sen2CSpan").css("display") == "none"){

                    status = "3"; 

                }

                console.log("status:" + status);
                return status;
            }


        </script>
    </head>

    <body onload="init();">

        <div class="content" style="width: 100%;overflow: auto;" id="alldiv">
            <div class="c_detail_header" style="margin-top: 0px;height:60px;text-align: center;">
                <span style="font-weight: bold;font-size: 40px;color:maroon;" id="nospan"></span>
            </div>
            <div>
                <div class="c_detail_header" style="margin-top: 0px;height:60px;">
                    <span style="font-weight: bold;font-size: 36px;color:brown;display: inline-block; vertical-align: top;">【単語】</span>
                    <img style="width: 50px;height: 50px;margin: -2px;display: none;cursor: pointer;" src="img/speaker.png" id="wordIcon" onclick="playVoice(1,1);" ondblclick="playVoice(1,2);">
                    &nbsp;&nbsp;&nbsp;&nbsp;
                    <img style="width: 50px;height: 50px;margin: -2px;cursor: pointer;" src="img/start.png" id="wordStartIcon" >
                    <img style="width: 50px;height: 50px;margin: -2px;cursor: pointer;display: none;" src="img/stop.png" id="wordStopIcon">
                    <audio id="wordAudioPlayBack" style="height: 50px;" controls></audio><img src='img/audio.gif' width='50px' style='display: none;'>
                </div>
                <div style="margin-top:10px;text-align: center;width: 100%;">
                    <span style="font-size: 24px;font-weight: bold;display: none;color:blue;" id="wordCSpan"></span><br/>
                    <span style="font-size: 30px;font-weight: bold;display: none;" id="wordJSpan"></span>
                </div>
                <div style="margin-top:20px;text-align: center;width: 100%;display: flex;justify-content: center;align-items: center;display: none;">
                    <div id="worddiv_right">
                        <span>this is a dog</span>
                    </div>
                </div>
            </div>
            <br>
            <div id="sen1div" style="display: none;">
                <div class="c_detail_header" style="margin-top: 0px;height:60px;">
                    <span style="font-weight: bold;font-size: 36px;color:brown;display: inline-block; vertical-align: top;">【例句】</span>
                    <img style="width: 50px;height: 50px;margin: -2px;display: none;" src="img/speaker.png" id="sen1Icon" onclick="playVoice(2,1);" ondblclick="playVoice(2,2);">
                    &nbsp;&nbsp;&nbsp;&nbsp;
                    <img style="width: 50px;height: 50px;margin: -2px;cursor: pointer;" src="img/start.png" id="sen1StartIcon" >
                    <img style="width: 50px;height: 50px;margin: -2px;cursor: pointer;display: none;" src="img/stop.png" id="sen1StopIcon">
                    <audio id="sen1AudioPlayBack" style="height: 50px;" controls></audio><img src='img/audio.gif' width='50px' style='display: none;'>
                </div>
                <div style="margin-top:20px;text-align: center;width: 100%;">
                    <span style="font-size: 24px;font-weight: bold;display: none;color:blue;" id="sen1CSpan"></span><br/>
                    <span style="font-size: 30px;font-weight: bold;display: none;" id="sen1JSpan"></span>                    
                </div>
                <div style="margin-top:20px;text-align: center;width: 100%;display: flex;justify-content: center;align-items: center;display: none;">
                    <div id="sen1div_right">
                        <span>this is a dog</span>
                    </div>
                </div>
            </div>
            <br>
            <div id="sen2div" style="display: none;">
                <div class="c_detail_header" style="margin-top: 0px;height:60px;">
                    <span style="font-weight: bold;font-size: 36px;color:brown;display: inline-block; vertical-align: top;">【例句】</span>
                    <img style="width: 40px;height: 50px;margin: -2px;display: none;" src="img/speaker.png" id="sen2Icon" onclick="playVoice(3,1);" ondblclick="playVoice(3,2);">
                    &nbsp;&nbsp;&nbsp;&nbsp;
                    <img style="width: 50px;height: 50px;margin: -2px;cursor: pointer;" src="img/start.png" id="sen2StartIcon" >
                    <img style="width: 50px;height: 50px;margin: -2px;cursor: pointer;display: none;" src="img/stop.png" id="sen2StopIcon">
                    <audio id="sen2AudioPlayBack" style="height: 50px;" controls></audio><img src='img/audio.gif' width='50px' style='display: none;'>
                </div>
                <div style="margin-top:20px;text-align: center;width: 100%;">
                    <span style="font-size: 24px;font-weight: bold;display: none;color:blue;" id="sen2CSpan"></span><br/>
                    <span style="font-size: 30px;font-weight: bold;display: none;" id="sen2JSpan"></span>
                </div>
                <div style="margin-top:20px;text-align: center;width: 100%;display: flex;justify-content: center;align-items: center;display: none;">
                    <div id="sen2div_right">
                        <span>this is a dog</span>
                    </div>
                </div>
                <div style="margin-top:20px;text-align: center;width: 100%;display: flex;justify-content: center;align-items: center;display: none;">
                    <img src="" id="sen2input" width="800px" height="450px" style="border: 1px solid gray;">
                </div>
            </div>
            <div style="margin-top:20px;text-align: center;width: 100%;height: 120px;">
                <button onclick="goBack()" style="width: 30%;height: 80px;font-size: 30px;font-weight: bold;" id="btnback">前へ</button>
                &nbsp;&nbsp;&nbsp;&nbsp;
                <button onclick="goNext()" style="width: 30%;height: 80px;font-size: 30px;font-weight: bold;" id="btnnext">次へ</button>
            </div>
        </div>

        <input type="hidden" id="hiddenOpt">

        <input type="hidden" id="hiddenTestNo">
        <input type="hidden" id="hiddenWordNo">
        <input type="hidden" id="hiddenWordCount">

        
        <input type="hidden" id="hiddenWordWrongTime">
        <input type="hidden" id="hiddenSen1WrongTime">
        <input type="hidden" id="hiddenSen2WrongTime"> 
       

        <input type="hidden" id="hiddenWordE">
        <input type="hidden" id="hiddenWordJ">
        <input type="hidden" id="hiddenWordC">
        <input type="hidden" id="hiddenSen1E">
        <input type="hidden" id="hiddenSen1J">
        <input type="hidden" id="hiddenSen1C">
        <input type="hidden" id="hiddenSen2E">
        <input type="hidden" id="hiddenSen2J">
        <input type="hidden" id="hiddenSen2C">

        <input type="hidden" id="hiddenWay2">
        <input type="hidden" id="hiddenWay3">
        <input type="hidden" id="hiddenWay4">

        <input type="hidden" id="hiddenBook">
        <input type="hidden" id="hiddenclassification">
        <input type="hidden" id="hiddenwordseq">

        <!-- <input type="hidden" id="hiddenMp3"> -->

        <input type="hidden" id="hiddenWordNoteSeq">
        <input type="hidden" id="hiddenSen1NoteSeq">
        <input type="hidden" id="hiddenSen2NoteSeq">

        <input type="hidden" id="wordAudioData">
        <input type="hidden" id="sen1AudioData">
        <input type="hidden" id="sen2AudioData">
    </body>
</html>