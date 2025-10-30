<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<div class="dialog" id="word_inputdialog" style="display:block;background-color: rgb(255,255,240);">
    <script>
        var word_inputdialog = null;
        $(function () {
            word_inputdialog = $("#word_inputdialog").dialog({
                title: "単語説明",
                autoOpen: false,
                resizable: true,
                height: 1000,
                width: 1500,
                modal: true,
                open: function () {
                    setTimeout(function () { });
                },
                close: function () {
                    setTimeout(function () { });
                },
            });

        });
    </script>
    <style>
        #word_inputdialog h3 {
            color: blue;
        }
    </style>
    <div></div>

</div>