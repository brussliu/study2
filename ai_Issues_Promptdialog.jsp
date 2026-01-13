<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <div class="dialog" id="ai_Issues_Promptdialog" style="display:block;background-color: rgb(255,255,240);">
        <script>
            var ai_Issues_Promptdialog = null;
            $(function () {
                ai_Issues_Promptdialog = $("#ai_Issues_Promptdialog").dialog({
                    title: "AI生成",
                    autoOpen: false,
                    resizable: true,
                    height: 600,
                    width: 1200,
                    modal: true,
                    open: function () {
                        setTimeout(function () { });
                    },
                    close: function () {
                        setTimeout(function () { });
                    },
                });
                
            });

            function  aiGenerate(){
                // $('#td_no').text("")
                // $('#text_aireply').val("");
                // $('#tr_memo').hide();
                // $("#memoTable .memo-group").remove();
                Efw('ai_Generate');
            }


        </script>
        <style>
        </style>

        <div style="margin: 10px;">
            
            <table class="table_header1" id="aiprompttable" style="table-layout: fixed;text-align: left;border-bottom: 10px">
                <thead>
                    <tr class="headers">
                        <td style="width: 150px;">
                            類型:
                        </td>
                        <td style="width: 200px;">
                            <select id="opt_type2" style="width: 180px;height: 30px" onchange="aiPrompt('type');">
                                <option value="" selected hidden></option>
                            </select>
                        </td>
                        <td style="width: 150px;">
                            プロンプト概要:
                        </td>
                        <td style="width: 540px;" colspan="3">
                            <select id="opt_summary2" style="width: 536px;height: 30px" onchange="aiPrompt('summary');">
                                <option value="" selected ></option>
                            </select>
                        </td>

                    </tr>
                </thead>
                <tbody>
                    <tr style="height: 200px;" class="copytr">
                        <td style="width: 150px;"  >
                            プロンプト詳細:
                        </td>
                        <td style="width: 870px; height: 200px" colspan="5">
                            <textarea style="width: 892px; height: 180px;text-align: left"  id="text_detailed2"></textarea>
                        </td>
                    </tr>

                    <tr style="height: 40px;" class="copytr2">
                        <td style="width: 150px;">
                            難易度:
                        </td>
                        <td style="width: 200px;">
                            <select id="opt_difficulty2" style="width: 180px;height: 30px">
                                <option value="１級">１級</option>
                                <option value="準１級">準１級</option>
                                <option value="２級" selected>２級</option>
                                <option value="準２級">準２級</option>
                            </select>
                        </td>
                        <td style="width: 150px;">
                            戻る値種類:
                        </td>
                        <td style="width: 200px;" >
                            <select id="opt_category2" style="width: 180px;height: 30px">
                                <option value="文章">文章</option>
                                <option value="HTML" selected>HTML</option>
                                <option value="JSON">JSON</option>
                            </select>
                        </td>
                        <td style="width: 150px;text-align: center">
                            AI選択:
                        </td>
                        <td style="width: 200px;" >
                            <select id="opt_aiopt2" style="width: 180px;height: 30px">
                                <option value="deepseek" selected>deepseek</option>
                                <option value="doubao">doubao</option>
                            </select>
                        </td>
                    </tr>

                </tbody>
            </table>
            <table class="table_inputdialog_btn" border="0">
                <tbody>
                    <tr>

                        <td style="width: 200px;"><button class="btn" id="btn_lottery" onclick="aiGenerate();">AI生成</button></td>
                        <td style="width: 200px;"><button class="btn" onclick="ai_Issues_Promptdialog.dialog('close');">キャンセル</button></td>
                        <td style="width: 200px;">  </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>