<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<div class="dialog" id="test_selectdoc_inputdialog" style="display:block;background-color: rgb(255,255,240);">
    <script>
        var test_selectdoc_inputdialog = null;

        $(function () {
            test_selectdoc_inputdialog = $("#test_selectdoc_inputdialog").dialog({
                title: "資料選択",
                autoOpen: false,
                resizable: true,
                height: 1000,
                width: 1500,
                modal: true,
                position: {
                    my: "center",
                    at: "center",
                    of: window,
                    using: function(pos) {
                        $(this).css({
                            top: pos.top - 50,
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

        });

        function initDiv1(flg){

            if(flg == 0){
                var code = "document_init1";
                var inputvalue = "";
                var outputObj = new Array("#opt_div1");

                Efw('common_selectoption',{code : code, inputvalue : inputvalue, outputObj : outputObj});
            }else{
                var code = "document_init1";
                var inputvalue = "";
                var outputObj = new Array("#opt_div1_dialog");

                Efw('common_selectoption',{code : code, inputvalue : inputvalue, outputObj : outputObj});
            }

        }

        function changeDiv1(flg){

            if(flg == 0){

                var code = "document_init2";
                var inputvalue = new Array($("#opt_div1").val());
                var outputObj = new Array("#opt_div2");

                Efw('common_selectoption',{code : code, inputvalue : inputvalue, outputObj : outputObj});

                $("#opt_div3 .dbvalue").remove();
                $("#opt_div4 .dbvalue").remove();

            }else{

                var code = "document_init2";
                var inputvalue = new Array($("#opt_div1_dialog").val());
                var outputObj = new Array("#opt_div2_dialog");

                Efw('common_selectoption',{code : code, inputvalue : inputvalue, outputObj : outputObj});

                $("#opt_div3_dialog .dbvalue").remove();
                $("#opt_div4_dialog .dbvalue").remove();

            }

        }

        function changeDiv2(flg){

            if(flg == 0){

                var code = "document_init3";
                var inputvalue = new Array($("#opt_div1").val(), $("#opt_div2").val());
                var outputObj = new Array("#opt_div3");

                Efw('common_selectoption',{code : code, inputvalue : inputvalue, outputObj : outputObj});

                $("#opt_div4 .dbvalue").remove();

            }else{

                var code = "document_init3";
                var inputvalue = new Array($("#opt_div1_dialog").val(), $("#opt_div2_dialog").val());
                var outputObj = new Array("#opt_div3_dialog");

                Efw('common_selectoption',{code : code, inputvalue : inputvalue, outputObj : outputObj});

                $("#opt_div4_dialog .dbvalue").remove();

            }

        }

        function changeDiv3(flg){

            if(flg == 0){

                var code = "document_init4";
                var inputvalue = new Array($("#opt_div1").val(), $("#opt_div2").val(), $("#opt_div3").val());
                var outputObj = new Array("#opt_div4");

                Efw('common_selectoption',{code : code, inputvalue : inputvalue, outputObj : outputObj});

            }else{

                var code = "document_init4";
                var inputvalue = new Array($("#opt_div1_dialog").val(), $("#opt_div2_dialog").val(), $("#opt_div3_dialog").val());
                var outputObj = new Array("#opt_div4_dialog");

                Efw('common_selectoption',{code : code, inputvalue : inputvalue, outputObj : outputObj});

            }

        }

        function searchDoc(){

            Efw('test_searchdoc');

        }

        function selectDoc(){

            var no = $("#doc_position").val();

            var docArr = new Array();

            $('#doclisttable input[type="checkbox"]').each(function() {

                var doc_no = "";

                if($(this).prop('checked') == true){

                    doc_no = $(this).parent().next().html();
                    docArr.push(doc_no);
                }

            });

            Efw('test_selectdoc',{docArr : docArr});


        }

        function setDocNo(position, docno){
            $(position).val(docno);
        }
    </script>
    <style>
        table {  
            border-spacing: 0 0px;  
            border-collapse: separate; /* 与border-spacing一起使用时需明确指定 */  
        } 
        .contentimg{
            width: 100px;
            height: 100px;
        }
        .contentimg2{
            width: 100px;
            height: 100px;
        }
        .stacked-img {
            display: block;
            
        }
        .imgcss {
            display:inline-block;
            text-align: center; /* 使内部的块级元素水平居中 */
        }

        .imgcss img:first-child {
            width: 80px;
            height: 80px;
        }

        .imgcss img:last-child {
            width: 20px;
            height: 20px;
            display: block;
            margin: 0 auto; /* 使此图片水平居中 */
        }
        .image-container {
            /* position: relative;
            display: inline-block; */

            display: flex;
            align-items: center; /* 垂直居中 */
            justify-content: left; /* 水平居中 */

            position: relative;

        }
        .upfile {
            max-width: 100%; /* 确保图片不会超出容器 */
            max-height: 100%;

            vertical-align: middle;
            border-top: 1px dashed gray;
            border-bottom: 1px dashed gray;
            border-left: 1px dashed gray;
            border-right: 1px dashed gray;

            margin-left: 10px;
        }
        .upfile1 {
            max-width: 100%; /* 确保图片不会超出容器 */
            max-height: 100%;

            vertical-align: middle;
            border-top: 1px dashed gray;
            border-bottom: 1px dashed gray;
            border-left: 1px dashed gray;
            border-right: 1px dashed gray;
        }
        .num {
            text-align: right;
        }
        .selectimg {
            width: 50px;
            height: 50px;
        }
        .selectfile{
            width: 50px;
            height: 50px;
            border-top: 1px dashed blue;
            border-bottom: 1px dashed blue;
            border-left: 1px dashed blue;
            border-right: 1px dashed blue;
        }
    </style>

    <div class="c_condition" style="height: 100px;width: 98%;">
        <table border="0" style="margin-top: 10px;">
            <tbody>
                <tr style="height: 40px;">
                    <td style="width: 100px;font-weight: bold;">大分類：</td>
                    <td style="width: 220px;">
                        <select style="width: 200px;height:30px;border-style: solid;" id="opt_div1" onchange="changeDiv1(0);">
                            <option value=""></option>
                        </select>
                    </td>
                    <td style="width: 100px;font-weight: bold;">中分類：</td>
                    <td style="width: 220px;">
                        <select style="width: 200px;height:30px;border-style: solid;" id="opt_div2" onchange="changeDiv2(0);"> 
                                <option value=""></option>
                        </select>
                    </td>
                    <td style="width: 100px;font-weight: bold;">小分類：</td>
                    <td style="width: 220px;">
                        <select style="width: 200px;height:30px;border-style: solid;" id="opt_div3" onchange="changeDiv3(0);"> 
                                <option value=""></option>
                        </select>
                    </td>
                    <td rowspan="2" style="width: 350px;text-align: right;vertical-align: top;">
                        <button id="btn_select" onclick="searchDoc();" style="width: 120px;height: 40px;">検&nbsp;索</button>
                        <button id="btn_select" onclick="selectDoc();" style="width: 120px;height: 40px;">選&nbsp;択</button>
                        <input type="hidden" id="doc_pic_position"/>
                        <input type="hidden" id="doc_no_position"/>
                    </td>
                </tr>
                <tr style="height: 40px;">
                    <td style="width: 100px;font-weight: bold;">細分類：</td>
                    <td style="width: 220px;">
                        <select style="width: 200px;height:30px;border-style: solid;" id="opt_div4"> 
                            <option value=""></option>
                    </select>
                    </td>
                    <td style="width: 140px;font-weight: bold;">キーボード：</td>
                    <td style="width: 220px;">
                        <input type="text" style="width: 200px;height: 30px;" id="text_keyword"/>
                    </td>
                    <td style="width: 140px;font-weight: bold;"></td>
                    <td style="width: 220px;"></td>
                </tr>
            </tbody>
        </table>
    </div>

    <div class="c_detail_header" style="overflow: hidden;width: 98%;" onscroll="scrollHead(this);">
        <table class="table_detail_header" style="table-layout: fixed;">
            <thead>
                <tr class="header">
                    <th style="width: 50px;" id="temp">選択</th>
                    <th style="width: 150px">資料番号</th>
                    <th style="width: 100px">ステータス</th>
                    <th style="width: 120px">有効期限</th>
                    <th style="width: 200px;">分類</th>
                    <th style="width: 780px;">内容</th>
                </tr>
            </thead>
        </table>
    </div>
    <div class="c_detail_content_sub" style="margin: auto;overflow: auto;width: 98%;" onscroll="scrollHead(this);">
        <table class="table_detail_content" id="doclisttable" style="table-layout: fixed;">
            <!-- <tr>
                <td rowspan="4" style='width: 50px;text-align: center;'><input type='checkbox' value='' onchange='checkDoc(this);'/></td>
                <td rowspan="4" style='width: 150px;' class='c'>20240908-033320</td>
                <td rowspan="4" style='width: 100px;' class='l'>1.有効</td>
                <td rowspan="4" style='width: 120px;text-align: center;'>2024-09-01</td>
                <td style='width: 200px;'>ああああああ1</td>
                <td rowspan="4" style='width: 780px;'>
                    <img src='img\zhaoxiang.png' class='selectimg' onclick='openDoc(0,this);'>
                    <img src='img\zhaoxiang.png' class='selectimg' onclick='openDoc(0,this);'>
                    <img src='img\zhaoxiang.png' class='selectimg' onclick='openDoc(0,this);'>
                    <img src='img\zhaoxiang.png' class='selectimg' onclick='openDoc(0,this);'>
                    <img src='img\zhaoxiang.png' class='selectimg' onclick='openDoc(0,this);'>
                    <img src='img\zhaoxiang.png' class='selectimg' onclick='openDoc(0,this);'>
                    <img src='img\zhaoxiang.png' class='selectimg' onclick='openDoc(0,this);'>
                    <input type='hidden' value=''/>&nbsp;
                </td>
            </tr>
            <tr>
                <td style='width: 200px;'>ああああああ2</td>
            </tr>
            <tr>
                <td style='width: 200px;'>ああああああ3</td>
            </tr>
            <tr>
                <td style='width: 200px;'>ああああああ4</td>
            </tr> -->
        </table>
    </div>
</div>