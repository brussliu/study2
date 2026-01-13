<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <div class="dialog" id="document_inputdialog" style="display:block;background-color: rgb(255,255,240);">
        <script>
            var document_inputdialog = null;

            $(function () {
                document_inputdialog = $("#document_inputdialog").dialog({
                    title: "資料詳細",
                    autoOpen: false,
                    resizable: true,
                    height: 1070,
                    width: 1600,
                    modal: true,
                    position: {
                        my: "center",
                        at: "center",
                        of: window,
                        using: function(pos) {
                            $(this).css({
                                top: pos.top - 100,
                                left: pos.left
                            });
                        }
                    },
                    open: function () {
                        setTimeout(function () { });
                    },
                    close: function () {
                        setTimeout(function () { });
                    },
                });
                //    // 初始化所有加号图标
                // $('.addicon').on('click', function() {
                //     toggleTable(this);
                // }); 
                // $('.contentimg').on('click', function() {
                //     move('1');
                // });
                // $('.contentimg2').on('click', function() {
                //     move('2');
                // });
            });

            function selectPic(){
                Efw('document_recivepic');
            }

            function openFileSelect(){
                $("#picfile").click();
            }

            function changepic(obj) {
                var filelist = $("#picfile")[0].files;
                handleFiles(filelist);
            }

            function displayPicFromSmartphone(content, fextension){
                var img = new Image();
                img.src = content;
                img.onload = function() {
                    var width = img.width;
                    var height = img.height;
                    var filecount = $(".upfile").length;
                    var position_r = Math.floor(filecount / 6);
                    var position_c = filecount % 6;
                    if(position_c == 0){
                        addTR();
                    }
                    addTD(content, width, height, fextension);
                };
            }

            $(document).ready(function() {
                const dropZone = document.getElementById('dropZone');

                dropZone.addEventListener('dragover', (event) => {
                    event.preventDefault();
                    dropZone.classList.add('dragover');
                });

                dropZone.addEventListener('dragleave', () => {
                    dropZone.classList.remove('dragover');
                });

                dropZone.addEventListener('drop', (event) => {
                    event.preventDefault();
                    dropZone.classList.remove('dragover');
                    const files = event.dataTransfer.files;
                    handleFiles(files);
                });

            });

            function handleFiles(files) {
                const formData = new FormData();
                for (let i = 0; i < files.length; i++) {
                    var f = files[i];

                    var fname = f.name;
                    var fextension = fname.substring(fname.lastIndexOf('.') + 1);
                    
                    var reader = new FileReader();
                    reader.onload = function(e) {

                        if(isPic(fextension)){
                            // 画像表示
                            displayPic(e.target.result, fextension, fname);
                        }else{

                            displayFile(e.target.result, fextension, fname);
                            
                        }
                    };
                    reader.readAsDataURL(f);
                }
            }

            function isPic(fextension){

                const imageExtensions = ['jpg', 'jpeg', 'png', 'gif', 'bmp', 'webp', 'svg'];

                return imageExtensions.includes(fextension.toLowerCase());
            }

            var displayDataArr = new Array();

            function cleardisplayData(){
                displayDataArr = new Array();
            }

            function setDisplayData(content, fextension, comment){

                var data = new Array();
                data[0] = content;
                data[1] = fextension;
                data[2] = comment;

                displayDataArr.push(data);

            }

            async function displayData(){

                for(var i = 0;i < displayDataArr.length;i ++){

                    var data = displayDataArr[i];

                    var fextension = data[1];

                    if(isPic(fextension)){
                        await displayPic(data[0], data[1], data[2]);
                    }else{
                        await displayFile(data[0], data[1], data[2]);
                    }
                    


                }

            }

            function displayFile(content, fextension, comment){

                return new Promise((resolve) => {

                    var filecount = $(".upfile").length;
                    var position_r = Math.floor(filecount / 6);
                    var position_c = filecount % 6;
                    if(position_c == 0){
                        addTR();
                    }
                    addTD(content, null, null, fextension, comment);
                    resolve();
                });

            }

            function displayPic(content, fextension, comment){

                return new Promise((resolve) => {

                    var img = new Image();
                    img.onload = function() {

                        var width = img.width;
                        var height = img.height;
                        var filecount = $(".upfile").length;
                        var position_r = Math.floor(filecount / 6);
                        var position_c = filecount % 6;
                        if(position_c == 0){
                            addTR();
                        }
                        addTD(content, width, height, fextension, comment);

                        resolve();
                    };

                    img.src = content;
                });

            }


            function addTD(content, width, height, fextension, comment){

                $(".pictd").each(function() {

                    if($(this).html() == ""){

                        if(isPic(fextension)){

                            var imghtml = width >= height ? "width: 200px;" : "height: 200px;";
                            var html = 
                            "<div class='image-container' style='height: 200px;width: 220px;'>" +
                                "<img src='" + content + "' class='upfile' style='" + imghtml + "'>" +
                                "<button class='delete-icon' onclick='deletePic(this);'><img src='img/delete2.png'></button>" +
                                "<button class='left-icon' onclick='movePicToLeft(this);'><img src='img/left2.png'></button>" +
                                "<button class='right-icon' onclick='movePicToRight(this);'><img src='img/right2.png'></button>" +
                                "<button class='rotate-icon' onclick='rotatePic(this);'><img src='img/kaiten.png'></button>" +
                                "<button class='open-icon' onclick='openPic(this);'><img src='img/open.png'></button>" +
                                "<input type='hidden' class='fextension' value='" + fextension.toLowerCase() +"'>" +
                            "</div>" +
                            "<textarea style='margin-top:" + "10px;' class='piccoment' rows='2'>" + comment + "</textarea>";
                        }else{
                            var html = 
                            "<div class='image-container' style='height: 200px;width: 220px;'>" +
                                "<img src='img/" + fextension.toLowerCase() + ".png' class='upfile' style='width: 200px;height: 200px;'>" +
                                "<button class='delete-icon' onclick='deletePic(this);'><img src='img/delete2.png'></button>" +
                                "<button class='left-icon' onclick='movePicToLeft(this);'><img src='img/left2.png'></button>" +
                                "<button class='right-icon' onclick='movePicToRight(this);'><img src='img/right2.png'></button>" +
                                "<button class='open-icon' onclick='openFile(this);'><img src='img/open.png'></button>" +
                                "<input type='hidden' class='fextension' value='" + fextension.toLowerCase() +"'>" +
                                "<input type='hidden' class='filecontent' value='" + content +"'>" +
                            "</div>" +
                            "<textarea style='margin-top:" + "10px;' class='piccoment' rows='2'>" + comment + "</textarea>";

                        }
                        $(this).html(html);
                        return false;
                    }

                });

            }

            function openFile(obj){

                var filecontent = $(obj).parent().children().last().val();

                const link = document.createElement('a');
                link.href = filecontent;

                link.download = 'DownloadFile';

                link.click();

            }

            function openPic(obj){

                var tdObj = $(obj).parent().parent();
                var rowIndex = tdObj.parent().index();
                var colIndex = tdObj.index();
                var fextension = $(obj).next().val();
                var comment = $(obj).parent().next().val();

                var imgObj = $(obj).parent().children().eq(0);
                var base64Image = imgObj.attr("src");

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

                const picw = window.open("document_pic2.jsp?row=" + rowIndex + "&col=" + colIndex + "&fextension=" + fextension + "&comment=" + comment, 'detailpic', windowFeatures);

                picw.onload = function(){
                    picw.document.getElementById('picsrc').value = base64Image;

                    picw.init();
                }

            }

            function setPicContent(row, col, content){
                
                var table = $("#fileinfotable");
                var rowObj = table.find("tr").eq(row);
                var tdObj = rowObj.find("td").eq(col);

                // console.log(row);
                // console.log(col);
                // console.log(content);

                tdObj.children().eq(0).children().eq(0).attr("src", content);

                //alert(tdObj.html());


            }

            function addTR(){

                var html = 
                "<tr style='height: 264px;width: 224px;' class='pictr1'>" +
                    "<td style='width: 100px;'></td>" +
                    "<td style='width: 220px;' class='pictd'></td>" +
                    "<td style='width: 10px;'></td>" +
                    "<td style='width: 220px;' class='pictd'></td>" +
                    "<td style='width: 10px;'></td>" +
                    "<td style='width: 220px;' class='pictd'></td>" +
                    "<td style='width: 10px;'></td>" +
                    "<td style='width: 220px;' class='pictd'></td>" +
                    "<td style='width: 10px;'></td>" +
                    "<td style='width: 220px;' class='pictd'></td>" +
                    "<td style='width: 10px;'></td>" +
                    "<td style='width: 220px;' class='pictd'></td>" +
                "</tr>" +
                "<tr style='height: 10px;' class='pictr3'>" +
                    "<td colspan='7'></td>" +
                "</tr>";
                $("#fileinfotable").append(html);
            }

            function save(){

                var list = new Array();

                const promises = [];

                $(".image-container").each(function () {

                    var fextension = $(this).find(".fextension").val();

                    var pic = null;
                    if(isPic(fextension)){
                        pic = $(this).find(".upfile").attr("src");
                    }else{
                        pic = $(this).find(".filecontent").val();
                    }
                    
                    
                    var comment = $(this).next().val();

                    var pic_tb500 = null;
                    var pic_tb200 = null;
                    var pic_tb50 = null;

                    var data = new Array();

                    data[0] = pic;
                    data[1] = fextension;

                    if(isPic(fextension)){

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

                                data[2] = pic_tb500;
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

                                data[3] = pic_tb200;
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

                                data[4] = pic_tb50;
                                resolve();
                            };
                        });
                        promises.push(promise3);

                        image_tb500.src = pic;
                        image_tb200.src = pic;
                        image_tb50.src = pic;

                    }else{

                        const promise1 = new Promise((resolve) => {

                            data[2] = null;
                            resolve();

                        });
                        promises.push(promise1);

                        const promise2 = new Promise((resolve) => {

                            data[3] = null;
                            resolve();

                        });
                        promises.push(promise2);

                        const promise3 = new Promise((resolve) => {

                            data[4] = null;
                            resolve();

                        });
                        promises.push(promise3);
                    }

                    data[5] = comment;

                    Promise.all(promises).then(() => {
                        list.push(data);
                    });
                    
                });

                Promise.all(promises).then(() => {
                    Efw('document_save',{piclist : list});
                });

            }

            function rotatePic(obj){

                var imgObj = $(obj).parent().children().eq(0);
                var base64Image = imgObj.attr("src");

                var w = parseFloat(imgObj.css("width").replaceAll("px",""));
                var h = parseFloat(imgObj.css("height").replaceAll("px",""));

                rotateBase64Image(base64Image, -90).then(rotatedBase64Image => {
                    if(w > h){
                        imgObj.css("height","200px");
                        imgObj.css("width","");
                    }
                    if(h > w){
                        imgObj.css("width","200px");
                        imgObj.css("height","");
                    }

                    imgObj.attr("src", rotatedBase64Image);
                });

            }

            function rotateBase64Image(base64Image, degrees) {

                return new Promise((resolve, reject) => {
                    const canvas = document.createElement('canvas');
                    const ctx = canvas.getContext('2d');
                    const image = new Image();
                    image.onload = function() {
                        const width = image.width;
                        const height = image.height;
                        canvas.width = height;
                        canvas.height = width;
                        ctx.translate(height / 2, width / 2);
                        ctx.rotate(degrees * Math.PI / 180);
                        ctx.drawImage(image, -width / 2, -height / 2);
                        resolve(canvas.toDataURL());
                    };
                    image.src = base64Image;
                });
            }

            function movePicToRight(obj){

                var picTdObj = $(obj).parent().parent();

                var nextTD = getNextPicTD(picTdObj);

                if(nextTD != null && nextTD !=undefined){

                    var nhtml = nextTD.html();
                    var html = $(picTdObj).html();

                    if(nhtml != null && nhtml != ""){
                        nextTD.html(html);
                        $(picTdObj).html(nhtml);
                    }

                }

            }

            function movePicToLeft(obj){

                var picTdObj = $(obj).parent().parent();

                var prevTD = getPrevPicTD(picTdObj);

                if(prevTD != null && prevTD !=undefined){

                    var phtml = prevTD.html();
                    var html = $(picTdObj).html();

                    if(phtml != null && phtml != ""){
                        prevTD.html(html);
                        $(picTdObj).html(phtml);
                    }

                }


            }

            function deletePic(obj){

                var tdObj = $(obj).parent().parent();
                tdObj.empty();

                var nextTD = getNextPicTD(tdObj);

                if(nextTD != null && nextTD != undefined && nextTD.html() != null && nextTD.html() != ""){
                    
                    movePicLeft(nextTD, true);
                }
                

            }

            // TD(obj)の下の全て元素を左側に移動してから、自身をクリアする
            function movePicLeft(obj, flg){

                //alert($(obj).html());

                var content = $(obj).html();

                // 前のTDに、内容を設定する
                var prevTD = getPrevPicTD(obj);

                if(prevTD != null && prevTD !=undefined){
                    prevTD.append(content);
                }

                // このTDの内容をクリアする
                $(obj).empty();

                if(flg){
                    var nextTD = getNextPicTD(obj);

                    if(nextTD != null && nextTD != undefined && nextTD.html() != null && nextTD.html() != ""){
                    movePicLeft(nextTD, flg);
                }

                }
            }

            function getNextPicTD(obj){

                if($(obj).is(":last-child") == false){

                    if($(obj).next().next() != null && $(obj).next().next() != undefined){

                        return $(obj).next().next();
                    }else{

                        return null;
                    }
                    
                }else{

                    var nextTR = $(obj).parent().next().next();
                    if(nextTR != null && nextTR != undefined){

                        return nextTR.find("td:nth-child(2)");
                    }else{

                        return null;
                    }
                    
                }

            }


            function getPrevPicTD(obj){

                if($(obj).is(":nth-child(2)") == false){

                    if($(obj).prev().prev() != null && $(obj).prev().prev() != undefined){
                        return $(obj).prev().prev();
                    }else{
                        return null;
                    }

                }else{

                    var prevTR = $(obj).parent().prev().prev();

                    if(prevTR != null && prevTR != undefined){
                        return prevTR.find("td:last");
                    }else{
                        return null;
                    }
                    
                }

            }

            function cancel(){
                document_inputdialog.dialog('close');
            }
            
        </script>
        <style>
            .dragarea {
                font-size: 24px;
                text-align: center;
                font-weight: bold;
                color: gray;
                border-top: 1px dashed gray;
                border-bottom: 1px dashed gray;
                border-left: 1px dashed gray;
                border-right: 1px dashed gray;
            }
            .pictd {
                text-align: center;
                vertical-align: middle;
                border-top: 1px dashed gray;
                border-bottom: 1px dashed gray;
                border-left: 1px dashed gray;
                border-right: 1px dashed gray;
            }
            .image-container {
                /* position: relative;
                display: inline-block; */

                display: flex;
                align-items: center; /* 垂直居中 */
                justify-content: center; /* 水平居中 */

                position: relative;
            }
            .upfile {
                max-width: 100%; /* 确保图片不会超出容器 */
                max-height: 100%;
            }

            .delete-icon {

                position: absolute;
                top: 5px;
                right: 5px;
                border: none;
                padding: 5px;
                border-radius: 50%;
                cursor: pointer;
                font-size: 14px;

                /* position: absolute;
                top: 10px;
                right: 10px;
                background-color: red;
                color: white;
                border: none;
                border-radius: 50%;
                width: 20px;
                height: 20px;
                cursor: pointer; */

            }
            .left-icon {
                position: absolute;
                top: 40%;
                left: 0;
                border: none;
                padding: 5px;
                border-radius: 50%;
                cursor: pointer;
                font-size: 14px;
            }
            .right-icon {
                position: absolute;
                top: 40%;
                right: 0;
                border: none;
                padding: 5px;
                border-radius: 50%;
                cursor: pointer;
                font-size: 14px;
            }
            .rotate-icon {
                position: absolute;
                top: 15%;
                left: 40%;
                border: none;
                padding: 5px;
                border-radius: 50%;
                cursor: pointer;
                font-size: 14px;
            }
            .open-icon {
                position: absolute;
                top: 75%;
                left: 40%;
                border: none;
                padding: 5px;
                border-radius: 50%;
                cursor: pointer;
                font-size: 14px;
            }
            .delete-icon img,.left-icon img,.right-icon img,.rotate-icon img,.open-icon img {
                width: 20px;
                height: 20px;
            }

            .delete-icon:hover,.left-icon:hover,.right-icon:hover,.rotate-icon:hover,.open-icon:hover {
                background-color: gray;
            }

            /* .drop-zone {
                width: 100%;
                height: 100%;
                display: flex;
                align-items: center;
                justify-content: center;
                text-align: center;
                color: #ccc;
                position: absolute;
                top: 0;
                left: 0;
            } */

            .drop-zone.dragover {
                border-color: #333;
                color: #333;
            }

            .piccoment {
                width: 100%;
                height: 50px;
            }

        </style>

    <!-- <div style="margin: 10px;"> -->
        <table border="0">
            <tbody> 
                <tr style="height: 50px;">
                    <td style="width: 100px;">ステータス</td>
                    <td style="width: 270px;">
                        <select style="width: 150px;height: 30px;" id="status">
                            <option value="1">1.有効</option>
                            <option value="9">9.無効</option>
                        </select>
                    </td>
                    <td style="width: 320px;">
                        有効期限&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <input type="date" style="width: 182px;height: 30px;" id="expiration_date"></input>
                    </td>
                    <td rowspan="5" style="width: 120px;text-align: left;">
                        <img src="img\zhaoxiang.png" style="width: 100px;height: 100px;" onclick="selectPic();">
                        <input type="file" id="picfile" style="display: none;" onchange='changepic(this);' multiple>
                    </td>
                    <td rowspan="5" class="dragarea" style="width: 700px;">
                        <div class="drop-zone" id="dropZone">ファイルをここにドラグしてください。</div>
                    </td>
                </tr>
                <tr style="height: 50px;">
                    <td>大分類</td>
                    <td style="width: 270px;">
                        <select style="width: 250px;height: 30px;" id="opt_div1_dialog" onchange="changeDiv1(1);">
                            <option value=""></option>
                        </select>
                    </td>
                    <td><input type="text" style="width: 300px;height: 30px;" id="div1_text"></input></td>
                </tr>
                <tr style="height: 50px;">
                    <td>中分類</td>
                    <td style="width: 270px;">
                        <select style="width: 250px;height: 30px;" id="opt_div2_dialog" onchange="changeDiv2(1);">
                            <option value=""></option>
                        </select>
                    </td>
                    <td><input type="text" style="width: 300px;height: 30px;" id="div2_text"></input></td>
                </tr>
                <tr style="height: 50px;">
                    <td>小分類</td>
                    <td style="width: 270px;">
                        <select style="width: 250px;height: 30px;" id="opt_div3_dialog" onchange="changeDiv3(1);">
                            <option value=""></option>
                        </select>
                    </td>
                    <td><input type="text" style="width: 300px;height: 30px;" id="div3_text"></input></td>
                </tr>
                <tr style="height: 50px;">
                    <td>細分類</td>
                    <td style="width: 270px;">
                        <select style="width: 250px;height: 30px;" id="opt_div4_dialog">
                            <option value=""></option>
                        </select>
                    </td>
                    <td><input type="text" style="width: 300px;height: 30px;" id="div4_text"></input></td>
                </tr>
                <tr style="height: 100px;">
                    <td>コメント</td>
                    <td colspan="4">
                        <textarea style="width: 100%;height: 95px;" rows="5" id="comment"></textarea>
                    </td>
                </tr>
            </tbody>
        </table>
        <br>
        <table border="0" id="fileinfotable">
            <tbody> 
                <tr style='height: 30px;'>
                    <td style='width: 100px;'>内容</td>
                    <td style='width: 220px;'></td>
                    <td style='width: 10px;'></td>
                    <td style='width: 220px;'></td>
                    <td style='width: 10px;'></td>
                    <td style='width: 220px;'></td>
                    <td style='width: 10px;'></td>
                    <td style='width: 220px;'></td>
                    <td style='width: 10px;'></td>
                    <td style='width: 220px;'></td>
                    <td style='width: 10px;'></td>
                    <td style='width: 220px;'></td>
                </tr>
            </tbody>
        </table>
        <br><br>
        <table class="table_inputdialog_btn" border="0">
            <tbody>
                <tr>
                    <td style="width: 650px;">
                        <input type="hidden" id="opt"></input>
                        <input type="hidden" id="document_no"></input>
                    </td>
                    <td style="width: 200px;"><button class="btn" id="btn_login" data-tags="table_inputdialog3" onclick="save()">保　存</button></td>
                    <td style="width: 200px;"><button class="btn" onclick="cancel()">キャンセル</button></td>
                    <td style="width: 650px;"></td>
                </tr>
            </tbody>
        </table>

    <!-- </div> -->
    </div>