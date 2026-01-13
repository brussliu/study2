<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="efw" uri="efw" %>
<html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>単語ノート</title>
    <efw:Client />
    <link rel="stylesheet" href="css/common.css" type="text/css" />
    <link href="favicon.ico" rel="icon" type="image/x-icon" />
    <script type="text/javascript" src="js/common.js"></script>
    <script type="text/javascript" src="js/jSignature.min1.js"></script>
    <script type="text/javascript" src="js/flashcanvas.js"></script>
    <style>

        .sign_box {
            padding: 0px 5px 5px 5px;
            /* height: 98.5%; */

            /* position: absolute; */
            /* position: relative; */

            transition: transform 0.3s ease;
        }

        .S0 {
            border: 2px solid red;
            /* width: 1907px;
            height: 1170px;
            cursor: url("img/pen.png"),auto; */
            cursor: move;
            position: relative;
        }

        .S1 {
            border: 2px solid red;
            /* width: 1907px;
            height: 1170px;
            cursor: url("img/pen.png"),auto; */
            cursor: url('img/pen.png'),auto;
            position: relative;
        }

        canvas {
            width: 100% !important;
            height: 100% !important;
        }

        #save_btn:hover {
            background-color: lightgreen;
        }

    </style>
    <script>

        var urlParams = new URLSearchParams(window.location.search);
        var flg = urlParams.get('flg') == null ? "" : urlParams.get('flg');
        var seq = urlParams.get('seq');
        var subno = urlParams.get('subno');

        var pic_w;
        var pic_h;
        let scale = 1;

        $(document).ready(function() {
        });

        function init(){

            Efw("document_showpic",{seq : seq, subno : subno, flg : flg});

            startDiv0();
        }

        function displaypic(v){

            // var w = 5120;
            // var h = 1392;
            $("#picsrc").val(v);

            const base64Image = v;

            getImageDimensions(base64Image).then(dimensions => {

                pic_w = dimensions.width;
                pic_h = dimensions.height;

                // pic_w = w;

                // pic_h = h;

                $("#canvas_box").css("background-image", "url('" + v + "')");

                $("#canvas_box").css("background-repeat", "no-repeat");

                $("#canvas_box").css("width", pic_w);
                $("#canvas_box").css("height", pic_h);

                $("#canvas_title").css("width", pic_w >= 1300 ? pic_w : 1300);
            

                //$("#canvas_box").css("background-image", "url('" + v +"')");

                //$('#myDiv').css('background-image', 'url("path_to_your_image.jpg")');

                $("#canvas_box .jSignature").css("background-color", "");

            }).catch(error => {
                console.error("画像表示できません。", error);
            });





        }

        function getImageDimensions(base64Image) {
            return new Promise((resolve, reject) => {
                const img = new Image();
                img.onload = function() {
                    resolve({ width: img.width, height: img.height });
                };
                img.onerror = reject;
                img.src = base64Image;
            });
        }


        function startDiv0(){
            
            const draggableImage = document.getElementById('canvas_box');

            draggableImage.addEventListener('mousedown', mousedownFunction);

            draggableImage.addEventListener('wheel', wheelFunction, { passive: false });

            $('html').css('overflow', 'hidden');

        }

        function stopDiv0(){
            
            const draggableImage = document.getElementById('canvas_box');

            scale = 1;

            draggableImage.style.transform = "scale(1,1)";

            draggableImage.style.left = (pic_w * (scale - 1) * 0.5) + 'px';
            draggableImage.style.top = (pic_h * (scale - 1) * 0.5) + 'px';

            $("#zoomtxt").html(Math.round(scale.toFixed(1) * 100) + " %");

            draggableImage.removeEventListener('mousedown', mousedownFunction);
            draggableImage.removeEventListener('wheel', wheelFunction);

            $('html').css('overflow', 'scroll');
            
        }





        function mousedownFunction(event) {

            const draggableImage = document.getElementById('canvas_box');

            let shiftX = event.clientX - draggableImage.getBoundingClientRect().left + pic_w * (1 - scale) * 0.5;
            let shiftY = event.clientY - draggableImage.getBoundingClientRect().top + pic_h * (1 - scale) * 0.5;

            function moveAt(pageX, pageY) {
                draggableImage.style.left = pageX - shiftX + 'px';
                draggableImage.style.top = pageY - shiftY + 'px';
            }
            function onMouseMove(event) {
                moveAt(event.pageX, event.pageY);
            }
            document.addEventListener('mousemove',onMouseMove);

            draggableImage.addEventListener('mouseup',function(){
                document.removeEventListener('mousemove', onMouseMove);
                draggableImage.onmouseup = null;
            });

            draggableImage.ondragstart = function() {
                return false;
            };

        }

        function wheelFunction(event) {

            const draggableImage = document.getElementById('canvas_box');
            event.preventDefault();
            // 上
            if (event.deltaY < 0) {
                scale = scale + 0.1;
            // 下
            } else {
                scale = Math.max(0.1, scale - 0.1);
            }

            draggableImage.style.transform = "scale("+ scale.toFixed(1) + "," + scale.toFixed(1) +")";

            draggableImage.style.left = (pic_w * (scale - 1) * 0.5) + 'px';
            draggableImage.style.top = (pic_h * (scale - 1) * 0.5) + 'px';

            $("#zoomtxt").html(Math.round(scale.toFixed(1) * 100) + " %");

        }

        function nextPic(){
            var next = parseInt(subno) + 1;
            window.location.href = "document_pic.jsp?seq=" + seq + "&subno=" + next + "&flg=next";
        }

        function prevPic(){
            var prev = parseInt(subno) - 1;
            window.location.href = "document_pic.jsp?seq=" + seq + "&subno=" + prev + "&flg=prev";
        }

        function saveMemo(){
            let canvas_box = $("#canvas_box");
            let datapair = canvas_box.jSignature("getData","image");
            let signImgSrc = 'data:' + datapair[0] + "," + datapair[1];

            var picBase64 = $("#picsrc").val();

            mergeImages(picBase64, signImgSrc, false);

        }

        function saveNewMemo(){
            let canvas_box = $("#canvas_box");
            let datapair = canvas_box.jSignature("getData","image");
            let signImgSrc = 'data:' + datapair[0] + "," + datapair[1];

            var picBase64 = $("#picsrc").val();

            mergeImages(picBase64, signImgSrc, true);

        }

        function mergeImages(base64Image1, base64Image2, flg) {

            const img1 = new Image();
            const img2 = new Image();

            img1.src = base64Image1;
            img2.src = base64Image2;

            let mergedBase64 = null;

            const promises = [];
            const promise1 = new Promise((resolve) => {

                img1.onload = () => {
                img2.onload = () => {

                    const canvas = document.createElement('canvas');
                    const ctx = canvas.getContext('2d');

                    canvas.width = img1.width;
                    canvas.height = img1.height;

                    ctx.drawImage(img1, 0, 0);
                    ctx.drawImage(img2, 0, 0);

                    mergedBase64 = canvas.toDataURL('image/png');

                    resolve();

                };
                };
                    

            });
            promises.push(promise1);

            Promise.all(promises).then(() => {

                save(mergedBase64, flg);

            });

            
        }

        function save(mergedBase64, flg){

            var list = new Array();

            const promises = [];

            var pic_tb500 = null;
            var pic_tb200 = null;
            var pic_tb50 = null;

            var data = new Array();

            data[0] = mergedBase64;

            var image_tb500 = new Image();
            var image_tb200 = new Image();
            var image_tb50 = new Image();

            const promise1 = new Promise((resolve) => {

                image_tb500.onload = function() {
                    square = 500 / image_tb500.height;
                    canvas = document.createElement('canvas');
                    context = canvas.getContext('2d');
                    imageWidth = Math.round(square * image_tb500.width);
                    imageHeight = Math.round(square * image_tb500.height);
                    canvas.width = imageWidth;
                    canvas.height = imageHeight;
                    context.clearRect(0, 0, imageWidth, imageHeight);
                    context.drawImage(image_tb500, 0, 0, imageWidth, imageHeight);
                    pic_tb500 = canvas.toDataURL('image/jpeg', 1);

                    data[1] = pic_tb500;
                    resolve();
                };
            });
            promises.push(promise1);

            const promise2 = new Promise((resolve) => {

                image_tb200.onload = function(){
                    square = 200 / image_tb200.height;
                    canvas = document.createElement('canvas');
                    context = canvas.getContext('2d');
                    imageWidth = Math.round(square * image_tb200.width);
                    imageHeight = Math.round(square * image_tb200.height);
                    canvas.width = imageWidth;
                    canvas.height = imageHeight;
                    context.clearRect(0, 0, imageWidth, imageHeight);
                    context.drawImage(image_tb200, 0, 0, imageWidth, imageHeight);
                    pic_tb200 = canvas.toDataURL('image/jpeg', 1);

                    data[2] = pic_tb200;
                    resolve();
                };
            });
            promises.push(promise2);

            const promise3 = new Promise((resolve) => {

                image_tb50.onload = function(){
                    square = 50 / image_tb50.height;
                    canvas = document.createElement('canvas');
                    context = canvas.getContext('2d');
                    imageWidth = Math.round(square * image_tb50.width);
                    imageHeight = Math.round(square * image_tb50.height);
                    canvas.width = imageWidth;
                    canvas.height = imageHeight;
                    context.clearRect(0, 0, imageWidth, imageHeight);
                    context.drawImage(image_tb50, 0, 0, imageWidth, imageHeight);
                    pic_tb50 = canvas.toDataURL('image/jpeg', 1);

                    data[3] = pic_tb50;
                    resolve();
                };
            });
            promises.push(promise3);

            image_tb500.src = mergedBase64;
            image_tb200.src = mergedBase64;
            image_tb50.src = mergedBase64;

            Promise.all(promises).then(() => {
                list.push(data);
            });
                

            Promise.all(promises).then(() => {
                Efw('document_savememo',{doc_no : seq, sub_doc_no : subno, memoflg : flg, piclist : list});
            });

        }

    </script>
</head>

<body onload="init();" class="body0">
    <div id="allcontent" class="sign_box" style="overflow: auto;">
        <div id="canvas_title" style="text-align: left;height: 30px;width: 100%;">
            <input type="radio" name="div" value="0" onchange="changeDiv();" checked>&nbsp;<span style="color: blue;">選択</span></input>
            &nbsp;&nbsp;&nbsp;&nbsp;
            <input type="radio" name="div" value="1" onchange="changeDiv();">&nbsp;<span style="color: blue;">メモ</span></input>
            &nbsp;&nbsp;
            <input type="radio" name="pen" value=" 1" onchange="changePen();" disabled>&nbsp;<span style="font-size: 14px;">極細</span></input>
            <input type="radio" name="pen" value=" 2" onchange="changePen();" disabled>&nbsp;<span style="font-size: 14px;">細</span></input>
            <input type="radio" name="pen" value=" 5" onchange="changePen();" disabled>&nbsp;<span style="font-size: 14px;">中</span></input>
            <input type="radio" name="pen" value="10" onchange="changePen();" disabled>&nbsp;<span style="font-size: 14px;">粗</span></input>
            <input type="radio" name="pen" value="15" onchange="changePen();" disabled>&nbsp;<span style="font-size: 14px;">極粗</span></input>
            &nbsp;&nbsp;
            <input type="radio" name="pencolor" value="black"  onchange="changePenColor();" disabled>&nbsp;<span style="font-size: 14px;">黒</span></input>
            <input type="radio" name="pencolor" value="red"    onchange="changePenColor();" disabled>&nbsp;<span style="font-size: 14px;">赤</span></input>
            <input type="radio" name="pencolor" value="blue"   onchange="changePenColor();" disabled>&nbsp;<span style="font-size: 14px;">青</span></input>
            <input type="radio" name="pencolor" value="green"  onchange="changePenColor();" disabled>&nbsp;<span style="font-size: 14px;">緑</span></input>
            <input type="radio" name="pencolor" value="yellow" onchange="changePenColor();" disabled>&nbsp;<span style="font-size: 14px;">黄</span></input>
            &nbsp;&nbsp;
            <button type="button" id="reset_btn"  style="width: 100px;margin-top: 2px;">クリア</button>
            &nbsp;&nbsp;
            <span id="zoomtxt">100%</span>
            &nbsp;&nbsp;&nbsp;&nbsp;
            <button id="save_btn" style="width: 120px;" onclick="saveMemo();">保存</button>
            <button id="save_btn" style="width: 120px;" onclick="saveNewMemo();">新規で保存</button>
            &nbsp;&nbsp;&nbsp;&nbsp;
            <button id="prev_btn" style="width: 80px;" onclick="prevPic();" disabled>◀前へ</button>
            <button id="next_btn" style="width: 80px;" onclick="nextPic();" disabled>次へ▶</button>
        </div>
        <div id="canvas_box" style="text-align: center;overflow: auto;" class="S0">
        </div>
    </div>
    <input type="hidden" id="signContent">
    <input type="hidden" id="signContent_tb">
    <input type="hidden" id="picsrc">
</body>
<script>


    function changeDiv(){
        var div = $("input[name='div']:checked").val();
        let canvas_box = $("#canvas_box");

        if(div == 0){

            startDiv0();

            canvas_box.removeClass("S1").addClass("S0");

            $("input[name='pen']").attr("disabled", true);
            $("input[name='pen']").attr("checked",false);

            $("input[name='pencolor']").attr("disabled", true);
            $("input[name='pencolor']").attr("checked",false);

        }else{

            stopDiv0();

            canvas_box.removeClass("S0").addClass("S1");

            canvas_box.jSignature({lineWidth:'5',color:'red'});

            $("input[name='pen']").attr("disabled", false);
            $("input[name='pen'][value=' 5']").attr("checked",true);

            $("input[name='pencolor']").attr("disabled", false);
            $("input[name='pencolor'][value='red']").attr("checked",true);

            $("#reset_btn").on("click",function (e) {
                canvas_box.jSignature("reset");
                signImgSrc = "";
                e.preventDefault();
            });
        }

    }



    function changePen() {
        var pen = $("input[name='pen']:checked").val();
        let canvas_box = $("#canvas_box");
        canvas_box.jSignature("updateSetting","lineWidth",pen, true);
        //$("#canvas_box").css("cursor", "url('img/pen.png'),auto");

    };

    function changePenColor() {
        var pencolor = $("input[name='pencolor']:checked").val();
        let canvas_box = $("#canvas_box");

        canvas_box.jSignature("updateSetting", "color" , pencolor, true);
        //$("#canvas_box").css("cursor", "url('img/rubber.png'),auto");

    };



    </script>
</html>