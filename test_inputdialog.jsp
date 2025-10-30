<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<div class="dialog" id="test_inputdialog" style="display:block;background-color: rgb(255,255,240);">
    <script>
        var test_inputdialog = null;
        $(function () {
            test_inputdialog = $("#test_inputdialog").dialog({
                title: "テスト詳細",
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
                // 初始化所有加号图标
            // $('.addicon').on('click', function() {
            //     addSubject(this);
            // });

            // $('.subjectinfo .adddocicon').on('click', function() {
            //     openDocSelectPage(1);
            // });

            $('.contentimg2').on('click', function() {
                move('2');
            });
        });

        // table缩小
        function lessen(t){
            $(t).closest("table").find("tr:gt(0)").toggle();
        }

        function getNoByClass(classname){
            var i = 1;
            while ($("." + classname + i).length > 0) {
                i++;
            }
            return classname + i;
        }

        function addSubject(){

            var count = $(".subjectinfo").length;

            var copyTable = $(".subjectinfo_exc").clone();

            copyTable.css("display", "");
            // copyTable.removeClass("subjectinfo_exc").addClass("subjectinfo").addClass(getNoByClass("newtable"));
            copyTable.removeClass("subjectinfo_exc").addClass("subjectinfo").addClass("newtable");

            // var i = 1;
            // while ($(".picdiv"+(count+i)).length > 0) {
            //     i++;
            // }

            // copyTable.find(".picdiv").removeClass("picdiv").addClass("picdiv"+(count+i));
            // copyTable.find(".doc_content").removeClass("doc_content").addClass("doc_content"+(count+i));

            copyTable.find(".picdiv").removeClass("picdiv").addClass(getNoByClass("picdiv"));
            copyTable.find(".doc_content").removeClass("doc_content").addClass(getNoByClass("doc_content"));

            if(count > 0){
                $(".subjectinfo").last().after(copyTable);
            }else{
                $(".subjectinfo_exc").after(copyTable);
            }

        }

        function addSubjectWithData(project, score, fulls, gradeaverage, academicrank1, academicrank2, yearaverage, academicyear1, academicyear2){

            addSubject();

            var i = 1;
            while ($(".newtable" + i).length > 0) {
                i++;
            }
            $(".newtable" + (i-1) + " .opt_subject").val(project);
            $(".newtable" + (i-1) + " .text_score1").val(score);
            $(".newtable" + (i-1) + " .text_score2").val(fulls);
            $(".newtable" + (i-1) + " .text_classaverage").val(gradeaverage);
            $(".newtable" + (i-1) + " .text_classranking1").val(academicrank1);
            $(".newtable" + (i-1) + " .text_classranking2").val(academicrank2);
            $(".newtable" + (i-1) + " .text_yearaverage").val(yearaverage);
            $(".newtable" + (i-1) + " .text_yearranking1").val(academicyear1);
            $(".newtable" + (i-1) + " .text_yearranking2").val(academicyear2);

        }


        function removeSubject(obj){

            var currentTable = $(obj).closest('.subjectinfo');
            currentTable.remove();

        }

        // 子画面が閉じる
        function cel() {
            //add();
            test_inputdialog.dialog('close');
        }


            
        // 保存処理
        function saveTest(){

            var commoninfo = new Array();

            var academicyear = $("#test_inputdialog #opt_academicyear").val();
            var from = $("#test_inputdialog #text_from").val();
            var to = $("#test_inputdialog #text_to").val();
            var name = $("#test_inputdialog #text_name").val();

            var content = $("#test_inputdialog .commoninfo .doc_content0").val();

            commoninfo.push(academicyear);
            commoninfo.push(from);
            commoninfo.push(to);
            commoninfo.push(name);
            commoninfo.push(content);


            //subject = "0.総合";



            var subjectinfoArr = new Array();

            $("#test_inputdialog .allsubjectinfo").each(function(index, element) {

                var subjectinfo = new Array();

                var subject = "0.総合";
                var score1 = $(element).find(".text_score1").val();
                var score2 = $(element).find(".text_score2").val();

                var classaverage = $(element).find(".text_classaverage").val();
                var classranking1 = $(element).find(".text_classranking1").val();
                var classranking2 = $(element).find(".text_classranking2").val();

                var yearaverage = $(element).find(".text_yearaverage").val();
                var yearranking1 = $(element).find(".text_yearranking1").val();
                var yearranking2 = $(element).find(".text_yearranking2").val();
                var content = null;

                subjectinfo.push(subject);
                subjectinfo.push(score1);
                subjectinfo.push(score2);
                subjectinfo.push(classaverage);
                subjectinfo.push(classranking1);
                subjectinfo.push(classranking2);
                subjectinfo.push(yearaverage);
                subjectinfo.push(yearranking1);
                subjectinfo.push(yearranking2);
                subjectinfo.push(content);

                subjectinfoArr.push(subjectinfo);

            });

            $("#test_inputdialog .subjectinfo").each(function(index, element) {

                var subjectinfo = new Array();

                var subject = $(element).find(".opt_subject").val();

                if(subject != null && subject != ""){

                    var score1 = $(element).find(".text_score1").val();
                    var score2 = $(element).find(".text_score2").val();

                    var classaverage = $(element).find(".text_classaverage").val();
                    var classranking1 = $(element).find(".text_classranking1").val();
                    var classranking2 = $(element).find(".text_classranking2").val();

                    var yearaverage = $(element).find(".text_yearaverage").val();
                    var yearranking1 = $(element).find(".text_yearranking1").val();
                    var yearranking2 = $(element).find(".text_yearranking2").val();

                    var content = $(element).find(".image-container").next().val();

                    subjectinfo.push(subject);
                    subjectinfo.push(score1);
                    subjectinfo.push(score2);
                    subjectinfo.push(classaverage);
                    subjectinfo.push(classranking1);
                    subjectinfo.push(classranking2);
                    subjectinfo.push(yearaverage);
                    subjectinfo.push(yearranking1);
                    subjectinfo.push(yearranking2);
                    subjectinfo.push(content);

                    subjectinfoArr.push(subjectinfo);

                }

            });

            Efw('test_save',{"commoninfo" : commoninfo, "subjectinfo": subjectinfoArr });

        }

        function openDocSelectPage(obj){

            initDiv1(0);

            var picclass = $(obj).parent().next().children().eq(0).attr("class");
            var classArray = picclass.split(" ");
            var lastClassName = classArray[classArray.length - 1];


            var contentclass = $(obj).parent().next().children().eq(1).attr("class");

            $("#doc_pic_position").val("." + lastClassName);
            $("#doc_no_position").val("." + contentclass);

            // if(no < 0){
            //     $("#doc_pic_position").val(".picdiv" + no);
            //     $("#doc_no_position").val(".doc_content" + no);
            // }else{
            //     $("#doc_pic_position").val(".subjectinfo");
            //     $("#doc_no_position").val(".doc_content");
            // }

            test_selectdoc_inputdialog.dialog('open');


        }

        function changeAddIcon(str){

            var delicon = $("#test_inputdialog " + str).parent().prev().children().eq(1);
            var addicon = $("#test_inputdialog " + str).parent().prev().children().eq(2);

            delicon.show();
            addicon.hide();
            // icon.attr("src", "img/delete2.png");
            // icon.off("click").on('click', function() { deletePic(str); });
        }

        function deletePic(obj){
            $(obj).parent().next().children().eq(0).empty();

            $(obj).hide();
            $(obj).next().show();
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
        .selectedimg {
            width: 80px;
            height: 80px;
        }
        .selectedfile{
            width: 80px;
            height: 80px;
            border-top: 1px dashed blue;
            border-bottom: 1px dashed blue;
            border-left: 1px dashed blue;
            border-right: 1px dashed blue;
        }
    </style>

    <div style="margin: 10px;" id="contentdiv">
        <table class="table_inputdialog commoninfo" border="0" padding="0">
            <tbody> 
                <tr>
                    <td style="width: 150px;">学年：</td>
                    <td style="width: 250px;">
                        <select style="width: 200px;" id="opt_academicyear">
                            <option value=""></option>
                            <option value="01.中1-上期">01.中1-上期</option>
                            <option value="02.中1-下期">02.中1-下期</option>
                            <option value="03.中2-上期">03.中2-上期</option>
                            <option value="04.中2-下期">04.中2-下期</option>
                            <option value="05.中3-上期">05.中3-上期</option>
                            <option value="06.中3-下期">06.中3-下期</option>
                            <option value="07.中1-上期">07.高1-上期</option>
                            <option value="08.中1-下期">08.高1-下期</option>
                            <option value="09.中2-上期">09.高2-上期</option>
                            <option value="10.中2-下期">10.高2-下期</option>
                            <option value="11.中3-上期">11.高3-上期</option>
                            <option value="12.中3-下期">12.高3-下期</option>
                        </select>
                    </td>
                    <td style="width: 50px;"></td>
                    <td style="width: 150px;">期間：</td>
                    <td style="width: 250px;"><input type="date" style="width: 200px;" id="text_from"></input></td>
                    <td style="width: 50px;text-align: center;">～</td>
                    <td><input type="date" style="width: 200px;" id="text_to"></input></td>
                </tr>
                <tr>
                    <td style="width: 150px;">名称：</td>
                    <td colspan="6"><input type="text" style="width: 960px;" id="text_name"></input></td>
                </tr>
                <tr style="height: 100px;">
                    <td style="vertical-align: top;">
                        内容：<br>
                        <img src='img\delete2.png' style='height: 50px;width: 50px;float: right;margin-bottom: 30px;margin-right: 20px;display: none;' onclick="deletePic(this);">
                        <img src='img\add.png' style='height: 50px;width: 50px;float: right;margin-bottom: 30px;margin-right: 20px;' onclick="openDocSelectPage(this);">
                    </td>
                    <td colspan="6">
                        <div class='image-container picdiv0' style='height: 100%;width:100%;'></div>
                        <input type="hidden" class="doc_content0">
                    </td> 
                </tr> 
            </tbody>
        </table>
        <!--総合成績  -->
        <table class="table_inputdialog allsubjectinfo" border="0"  padding="0" style="border-top: 1px dashed black;">
            <tbody> 
                <tr style="background-color: D9E1F4;">
                    <td style="width: 150px;" > <img src="img\right.png"  onclick="lessen(this)" width="20" height="20" style="vertical-align: middle;" > 科目：</td>
                    <td colspan="9">総合成績<img src="img\jia.png" class="addicon" width="22" height="22" style="float: right;margin-top: 8px;margin-right: 10px;" onclick="addSubject();"></td>
                </tr>
                <tr style="height: 10px;">
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr> 
                <tr>
                    <td style="width: 150px;">得点：</td>
                    <td style="width: 115px;"><input type="text" style="width: 100px;" class="text_score1 num"></input></td>
                    <td style="width: 20px;">/</td>
                    <td style="width: 250px;"><input type="text" style="width: 100px;" class="text_score2 num"></input></td>
                    <td style="width: 150px;">学級平均点：</td>
                    <td style="width: 250px;"><input type="text" style="width: 100px;" class="text_classaverage num"></input></td>
                    <td style="width: 150px;">学級順位：</td>
                    <td style="width: 115px;"><input type="text" style="width: 100px;" class="text_classranking1 num"></input></td>
                    <td style="width: 20px;">/</td>
                    <td ><input type="text" style="width: 100px;" class="text_classranking2 num"></input></td>
                </tr>
                <tr>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td>学年平均点：</td>
                    <td><input type="text" style="width: 100px;" class="text_yearaverage num"></input></td>
                    <td>学年順位：</td>
                    <td><input type="text" style="width: 100px;" class="text_yearranking1 num"></input></td>
                    <td style="width: 20px;">/</td>
                    <td><input type="text" style="width: 100px;" class="text_yearranking2 num"></input></td>
                </tr>
                <tr style="height: 10px;">
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
            </tbody>
        </table>
        <!-- 单科 -->
        <table class="table_inputdialog subjectinfo_exc" border="0" padding="0" style="border-top: 1px dashed black;display: none;">
            <tbody> 
                <tr style="background-color: E3F2D9;">
                    <td style="width: 150px;"><img src="img\right.png" onclick="lessen(this)" width="20" height="20" style="vertical-align: middle;"> 科目：</td>
                    <td colspan="9">
                        <select style="width: 200px;" class="opt_subject">
                             <option value=""></option>
                             <option value="1.国語">1.国語</option>
                             <option value="2.数学">2.数学</option>
                             <option value="3.英語">3.英語</option>
                             <option value="4.理科">4.理科</option>
                             <option value="5.社会">5.社会</option>
                             <option value="6.地理">6.地理</option>
                             <option value="7.歴史">7.歴史</option>
                        </select>
                        &nbsp;&nbsp;
                        <img src="img\minus.png" class="addicon" width="22" height="22" style="vertical-align: middle;" onclick="removeSubject(this);">
                    </td>
                </tr>
                <tr style="height: 10px;">
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr> 
                <tr>
                    <td style="width: 150px;">得点：</td>
                    <td style="width: 115px;"><input type="text" style="width: 100px;" class="text_score1 num"></input></td>
                    <td style="width: 20px;">/</td>
                    <td style="width: 250px;"><input type="text" style="width: 100px;" class="text_score2 num"></input></td>
                    <td style="width: 150px;">学級平均点：</td>
                    <td style="width: 250px;"><input type="text" style="width: 100px;" class="text_classaverage num"></input></td>
                    <td style="width: 150px;">学級順位：</td>
                    <td style="width: 115px;"><input type="text" style="width: 100px;" class="text_classranking1 num"></input></td>
                    <td style="width: 20px;">/</td>
                    <td ><input type="text" style="width: 100px;" class="text_classranking2 num"></input></td>
                </tr>
                <tr>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td>学年平均点：</td>
                    <td><input type="text" style="width: 100px;" class="text_yearaverage num"></input></td>
                    <td>学年順位：</td>
                    <td><input type="text" style="width: 100px;" class="text_yearranking1 num"></input></td>
                    <td style="width: 20px;">/</td>
                    <td><input type="text" style="width: 100px;" class="text_yearranking2 num"></input></td>
                </tr>
                <tr style="height: 100px;">
                    <td>内容：<br>
                        <img src='img\delete2.png' style='height: 50px;width: 50px;float: right;margin-bottom: 30px;margin-right: 20px;display: none;' onclick="deletePic(this);">
                        <img src='img\add.png' style='height: 50px;width: 50px;float: right;margin-bottom: 30px;margin-right: 20px;' onclick="openDocSelectPage(this);">
                    </td>
                    <td colspan="9">
                        <div class='image-container picdiv' style='height: 100%;width:100%;'></div>
                        <input type="hidden" class="doc_content">
                    </td> 
                </tr> 
                <tr style="height: 10px;">
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
            </tbody>
        </table>
    </div>
    <table class="table_inputdialog_btn" border="0" style="border-top: 1px dashed black;">
        <tbody>
            <tr>
                <td style="width: 650px;"><input type="hidden" id="opt"></input></td>
                <td style="width: 200px;"><button class="btn" id="btn_save" onclick="saveTest()">保存</button></td>
                <td style="width: 200px;"><button class="btn" onclick="cel()">キャンセル</button></td>
                <td style="width: 650px;"><input type="hidden" id="testseq"></input></td>
            </tr>
        </tbody>
    </table>
</div>