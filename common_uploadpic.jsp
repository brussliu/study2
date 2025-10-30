<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="efw" uri="efw" %>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>写真アップロード</title>
	<link href="favicon.ico" rel="icon" type="image/x-icon" />
	<efw:Client/>

	<script>

		(function ($) {
            $.getUrlParam = function (name) {
                var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
                var r = window.location.search.substr(1).match(reg);
                if (r != null) return unescape(r[2]); return null;
            }
        })(jQuery);

		function selectPic(obj){
			$("#picfile").click();
		}

		function changepic(obj) {

			$("#imgIcon").hide();

			var filelist = $("#picfile")[0].files;

			handleFiles(filelist);

			$("#btn_upload").show();

		}

        function handleFiles(files) {
            const formData = new FormData();
            for (let i = 0; i < files.length; i++) {
                var f = files[i];

                var fname = f.name;
                var fextension = fname.substring(fname.lastIndexOf('.') + 1);
                
                var reader = new FileReader();
                reader.onload = function(e) {
                    // 画像表示
                    displayPic(e.target.result, fextension);
                };
                reader.readAsDataURL(f);
            }
        }

		function displayPic(content, fextension){

			var count = $("#allpic").children().length;
			var no = count - 3;
			var divhtml = "<div id='imgPreview' class='picdiv'>" +
				"<img src='#' class='img' id='img" + no + "'/>" +
				"<input type='hidden' class='fextension' value='" + fextension +"'>" +
				"</div>";
			$("#btnDiv").prev().before(divhtml);
			$("#img" + no).attr("src",content);
			$("#img" + no).show();

		}

		function upload(){

            var list = new Array();
            const promises = [];

            $(".picdiv").each(function () {

				var pic = $(this).find(".img").attr("src");
				var fextension = $(this).find(".fextension").val();

				var pic_tb500 = null;
				var pic_tb200 = null;
				var pic_tb50 = null;

				var data = new Array();

				data[0] = pic;
				data[1] = fextension;

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
						//data.push(pic_tb50);

						data[4] = pic_tb50;
						resolve();
					};

				});
				promises.push(promise3);

				image_tb500.src = pic;
				image_tb200.src = pic;
				image_tb50.src = pic;

				Promise.all(promises).then(() => {
					list.push(data);
				});


			});

			Promise.all(promises).then(() => {

				//alert(list[1]["pic_tb50"]);

				Efw('common_uploadpic',{piclist : list});

			});

		}

	</script>
   	<style>
		#allpic {
			width: 100%;
			height: 100%;
		}
		#imgIcon{
			border-width: 1px;
			border-style: solid;
			width: 600px;
			height: 600px;
			border-color: gray;
			margin:auto;
			text-align: center;
		}
		.picdiv {
			text-align: center;
			margin-top: 10px;
		}
		.img {
			width: 600px;
			display: none;
		}

		#btnDiv{
			width: 600px;
			height: 100px;
			margin:auto;
			text-align: center;
		}

		#btn_upload {
			width: 400px;
			height: 100px;
			background: rgb(240, 240, 240);
			font-size: 42px;
			border: 1px solid rgb(206, 205, 205);
			box-shadow: 5px 5px 2px #888888;
			cursor: pointer;
			margin:auto;
			/* display: none; */
        }
    </style>
</head>
<body style="background-color:lightblue;">
	<div id="allpic">
		<div id="imgIcon">
			<img src="img/pic.png" id="icon" style='width: 300px;height: 300px;padding-top: 100px;' onclick='selectPic(this);'>
		</div>
		<br/>
		<div id="btnDiv">
			<input type="button" id="btn_upload" value="アップロード" onclick="upload()"/>
		</div>
		<input type="file" id="picfile" style="display: none;" onchange='changepic(this)' multiple>
	</div>
	
	<!-- 
	<input type="hidden" id="picfile1">
	<input type="hidden" id="picfile2">
	<input type="hidden" id="picfile3">
	<input type="hidden" id="picfile4">
	<input type="hidden" id="picfile5">
	<input type="hidden" id="picfile6">
	<input type="hidden" id="picfile7">
	<input type="hidden" id="picfile8">
	<input type="hidden" id="picfile9">
	<input type="hidden" id="picfile10">
	<input type="hidden" id="picfile11">
	<input type="hidden" id="picfile12">
	<input type="hidden" id="picfile13">
	<input type="hidden" id="picfile14">
	<input type="hidden" id="picfile15">
	<input type="hidden" id="picfile16">
	<input type="hidden" id="picfile17">
	<input type="hidden" id="picfile18">
	<input type="hidden" id="picfile19">
	<input type="hidden" id="picfile20">

	<input type="hidden" id="picfile1_tb500">
	<input type="hidden" id="picfile2_tb500">
	<input type="hidden" id="picfile3_tb500">
	<input type="hidden" id="picfile4_tb500">
	<input type="hidden" id="picfile5_tb500">
	<input type="hidden" id="picfile6_tb500">
	<input type="hidden" id="picfile7_tb500">
	<input type="hidden" id="picfile8_tb500">
	<input type="hidden" id="picfile9_tb500">
	<input type="hidden" id="picfile10_tb500">
	<input type="hidden" id="picfile11_tb500">
	<input type="hidden" id="picfile12_tb500">
	<input type="hidden" id="picfile13_tb500">
	<input type="hidden" id="picfile14_tb500">
	<input type="hidden" id="picfile15_tb500">
	<input type="hidden" id="picfile16_tb500">
	<input type="hidden" id="picfile17_tb500">
	<input type="hidden" id="picfile18_tb500">
	<input type="hidden" id="picfile19_tb500">
	<input type="hidden" id="picfile20_tb500">

	<input type="hidden" id="picfile1_tb200">
	<input type="hidden" id="picfile2_tb200">
	<input type="hidden" id="picfile3_tb200">
	<input type="hidden" id="picfile4_tb200">
	<input type="hidden" id="picfile5_tb200">
	<input type="hidden" id="picfile6_tb200">
	<input type="hidden" id="picfile7_tb200">
	<input type="hidden" id="picfile8_tb200">
	<input type="hidden" id="picfile9_tb200">
	<input type="hidden" id="picfile10_tb200">
	<input type="hidden" id="picfile11_tb200">
	<input type="hidden" id="picfile12_tb200">
	<input type="hidden" id="picfile13_tb200">
	<input type="hidden" id="picfile14_tb200">
	<input type="hidden" id="picfile15_tb200">
	<input type="hidden" id="picfile16_tb200">
	<input type="hidden" id="picfile17_tb200">
	<input type="hidden" id="picfile18_tb200">
	<input type="hidden" id="picfile19_tb200">
	<input type="hidden" id="picfile20_tb200">

	<input type="hidden" id="picfile1_tb50">
	<input type="hidden" id="picfile2_tb50">
	<input type="hidden" id="picfile3_tb50">
	<input type="hidden" id="picfile4_tb50">
	<input type="hidden" id="picfile5_tb50">
	<input type="hidden" id="picfile6_tb50">
	<input type="hidden" id="picfile7_tb50">
	<input type="hidden" id="picfile8_tb50">
	<input type="hidden" id="picfile9_tb50">
	<input type="hidden" id="picfile10_tb50">
	<input type="hidden" id="picfile11_tb50">
	<input type="hidden" id="picfile12_tb50">
	<input type="hidden" id="picfile13_tb50">
	<input type="hidden" id="picfile14_tb50">
	<input type="hidden" id="picfile15_tb50">
	<input type="hidden" id="picfile16_tb50">
	<input type="hidden" id="picfile17_tb50">
	<input type="hidden" id="picfile18_tb50">
	<input type="hidden" id="picfile19_tb50">
	<input type="hidden" id="picfile20_tb50">
	-->
</body>

</html>