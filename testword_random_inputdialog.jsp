<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <div class="dialog" id="testword_random_inputdialog" style="display:block;background-color: rgb(255,255,240);">
        <script>
            var testword_random_inputdialog = null;
            $(function () {
                testword_random_inputdialog = $("#testword_random_inputdialog").dialog({
                    title: "単語抽選",
                    autoOpen: false,
                    resizable: true,
                    height: 600,
                    width: 1300,
                    modal: true,
                    open: function () {
                        setTimeout(function () { });
                        addNewTR();
                    },
                    close: function () {
                        setTimeout(function () { });
                    },
                });
                
            });

            function makeRandomTest(){

                var list = "";
                $("#booklisttable tbody tr").each(function () {

                    var book =                  $(this).children().eq(1).children().eq(0).val();
                    var classification_from =   $(this).children().eq(2).children().eq(0).val();
                    var classification_to =     $(this).children().eq(2).children().eq(1).val();
                    var status =                $(this).children().eq(3).children().eq(0).val();
                    var wordcount =             $(this).children().eq(4).children().eq(0).val();
                    var kind =                  $(this).children().eq(5).children().eq(0).val();
                    var level =                 $(this).children().eq(6).children().eq(0).val();


                    if(book != null && book != ""){

                        var info = book + "-" + classification_from + "-" + classification_to + "-" + status + "-" + wordcount + "-" + kind + "-" + level;
                        list = list + info + ",";

                    }


                });

                list = list.substr(0, list.length - 1);

                if(list != null && list != ""){

                    Efw('testword_randomlist', {list : list});
                }

            }

            function addNewTR(){

                const $table = $("#booklisttable");
                const $motoRow = $table.find(".copytr");
                const $newRow = $motoRow.clone(true);
                const rowCount = $("#booklisttable tr").length;
                // 可以在这里修改新行的内容，例如更新某些单元格的值
                //$newRow.find("td:eq(0)").html("<img src='img/delete2.png' width='20px;' height='20px;' onclick='addNewTR(this);'>");
                $newRow.removeClass("copytr");
                $newRow.addClass("copytr" + rowCount); 
                $newRow.show();

                $table.append($newRow);

            }

            function removeThisTR(obj){

                $(obj).parent().parent().remove();
            }

            function initclassification2(obj){

                var book = $(obj).val();

                if(book == "00.すべて"){

                    //$("#opt_accuracy").val("");
                    //$("#opt_accuracy").prop("disabled", true);


                    $(obj).parent().next().children().eq(0).val("").prop("disabled", true);
                    $(obj).parent().next().children().eq(1).val("").prop("disabled", true);
                }else{

                    $(obj).parent().next().children().eq(0).val("").prop("disabled", false);
                    $(obj).parent().next().children().eq(1).val("").prop("disabled", false);

                    var trclass = $(obj).parent().parent().attr("class");

                    initclassification(obj,"." + trclass + " .classification");
                }


            }

            function changeTestWay2(obj){

                var way2 = $(obj).val();

                if(way2 == "7"){

                    // way3
                    $(obj).parent().next().children().eq(0).val("2");
                    $(obj).parent().next().children().eq(0).prop('disabled', true);

                    // way4
                    $(obj).parent().next().next().children().eq(0).val("1");
                    $(obj).parent().next().next().children().eq(0).prop('disabled', true);
                    
                }else{

                    // way3
                    $(obj).parent().next().children().eq(0).val("0");
                    $(obj).parent().next().children().eq(0).prop('disabled', false);

                    // way4
                    $(obj).parent().next().next().children().eq(0).prop('disabled', false);

                }

            }
            function changeTestWay3(obj){

                var way3 = $(obj).val();

                // キーボードの場合
                if(way3 == "0"){

                    // way2
                    $(obj).parent().prev().children().eq(0).val("0");
                    $(obj).parent().prev().children().eq(0).prop('disabled', false);

                    // way4
                    $(obj).parent().next().children().eq(0).val("1");
                    $(obj).parent().next().children().eq(0).prop('disabled', false);


                // 手書きの場合
                }else if(way3 == "1"){

                    // way2
                    $(obj).parent().prev().children().eq(0).val("0");
                    $(obj).parent().prev().children().eq(0).prop('disabled', true);

                    // way4
                    $(obj).parent().next().children().eq(0).val("1");
                    $(obj).parent().next().children().eq(0).prop('disabled', true);


                // 音声の場合
                }else if(way3 == "2"){

                    // way2
                    $(obj).parent().prev().children().eq(0).val("7");
                    $(obj).parent().prev().children().eq(0).prop('disabled', true);

                    // way4
                    $(obj).parent().next().children().eq(0).val("1");
                    $(obj).parent().next().children().eq(0).prop('disabled', true);


                }

            }

            function changeTestWay4(obj){

                var way4 = $(obj).val();

                // テストの場合
                if(way4 == "1"){

                    // way2
                    if($(obj).parent().prev().prev().children().eq(0).val() == "7"){
                        $(obj).parent().prev().prev().children().eq(0).val("0");
                    }
                    $(obj).parent().prev().prev().children().eq(0).prop('disabled', false);

                    // way3
                    $(obj).parent().prev().children().eq(0).val("0");
                    $(obj).parent().prev().children().eq(0).prop('disabled', false);


                // 練習の場合
                }else if(way4 == "2"){

                    // way2
                    $(obj).parent().prev().prev().children().eq(0).val("0");
                    $(obj).parent().prev().prev().children().eq(0).prop('disabled', false);

                    // way3
                    $(obj).parent().prev().children().eq(0).val("0");
                    $(obj).parent().prev().children().eq(0).prop('disabled', true);


                // 暗記の場合
                }else if(way4 == "3"){

                    // way2
                    $(obj).parent().prev().prev().children().eq(0).val("0");
                    $(obj).parent().prev().prev().children().eq(0).prop('disabled', true);

                    // way3
                    $(obj).parent().prev().children().eq(0).val("0");
                    $(obj).parent().prev().children().eq(0).prop('disabled', true);


                }

            }
        </script>
        <style>
        </style>

        <div style="margin: 10px;">
            
            <table class="table_detail_header" id="booklisttable" style="table-layout: fixed;text-align: center;" border="1">
                <thead>
                    <tr class="header2">
                        <th style="width: 60px;">
                            <img src="img/add.png" width="20px;" height="20px;" onclick="addNewTR(this);">
                        </th>
                        <th style="width: 170px;">書籍</th>
                        <th style="width: 250px;">分類</th>
                        <th style="width: 120px;">状態</th>
                        <th style="width: 100px;">抽選数量</th>
                        <th style="width: 200px;">種類</th>
                        <th style="width: 220px;">難易度</th>
                    </tr>
                </thead>
                <tbody>
                    <tr style="height: 40px;display: none;" class="copytr">
                        <td style="width: 60px;">
                            <img src="img/delete2.png" width="20px;" height="20px;" onclick="removeThisTR(this);">
                        </td>
                        <td style="width: 170px;">
                            <select style="width: 150px;height:30px;" onchange="initclassification2(this);">
                                <option value=""></option>
                                <option class="dbvalue" value="00.すべて">00.すべて</option>
                                <option class="dbvalue" value="01.三級単語">01.三級単語</option>
                                <option class="dbvalue" value="02.三級熟語">02.三級熟語</option>
                                <option class="dbvalue" value="03.キクタン">03.キクタン</option>
                                <option class="dbvalue" value="04.キクジュク">04.キクジュク</option>
                                <option class="dbvalue" value="11.二級単語">11.二級単語</option>
                                <option class="dbvalue" value="12.二級熟語">12.二級熟語</option>
                                <option class="dbvalue" value="13.キクタン準２級">13.キクタン準２級</option>
                                <option class="dbvalue" value="14.キクタンBasic">14.キクタンBasic</option>
                                <option class="dbvalue" value="15.キクタン２級">15.キクタン２級</option>
                                <option class="dbvalue" value="90.新概念単語2">90.新概念単語2</option>
                                <option class="dbvalue" value="90.新概念単語3">90.新概念単語3</option>
                                <option class="dbvalue" value="91.英語の文800個">91.英語の文800個</option>
                            </select>
                        </td>
                        <td style="width: 250px;">
                            <select style="width: 100px;height:30px;" class="classification">
                                <option value=""></option>
                            </select>
                            ～
                            <select style="width: 100px;height:30px;" class="classification">
                                <option value=""></option>
                            </select>
                        </td>
                        <td style="width: 120px;">
                            <select style="width: 100px;height:30px;" >
                                <option value=""></option>
                                <option value="未勉強">未勉強</option>
                                <option value="勉強中">勉強中</option>
                                <option value="勉強済">勉強済</option>
                            </select>
                        </td>
                        <td style="width: 100px;">
                            <select style="width: 80px;height:30px;" >
                                <option value="0" selected>全部</option>
                                <option value="10">10語</option>
                                <option value="20">20語</option>
                                <option value="30">30語</option>
                                <option value="50">50語</option>
                                <option value="80">80語</option>
                                <option value="100">100語</option>
                            </select>
                        </td>
                        <td style="width: 200px;">
                            <select style="width: 180px;height:30px;" onchange="">
                                <option value="A.勉強" selected>&nbsp;A.勉強</option>
                                <option value="B.中日訳英">&nbsp;B.中日訳英</option>
                                <option value="C.音訳英">&nbsp;C.音訳英</option>
                                <option value="D.英訳中">&nbsp;D.英訳中</option>
                            </select>
                        </td>
                        <td style="width: 220px;">
                            <select style="width: 200px;height:30px;" onchange="">
                                <option value="1.簡単" selected>&nbsp;1.簡単</option>
                            </select>
                        </td>
                    </tr>
                    <tr style="height: 40px;" class="copytr2">
                        <td style="width: 60px;">
                            <img src="img/delete2.png" width="20px;" height="20px;" onclick="removeThisTR(this);">
                        </td>
                        <td style="width: 170px;">
                            <select style="width: 150px;height:30px;" onchange="initclassification2(this);" class="">
                                <option value=""></option>
                                <option class="dbvalue" value="00.すべて" selected>00.すべて</option>
                                <option class="dbvalue" value="01.三級単語">01.三級単語</option>
                                <option class="dbvalue" value="02.三級熟語">02.三級熟語</option>
                                <option class="dbvalue" value="03.キクタン">03.キクタン</option>
                                <option class="dbvalue" value="04.キクジュク">04.キクジュク</option>
                                <option class="dbvalue" value="11.二級単語">11.二級単語</option>
                                <option class="dbvalue" value="12.二級熟語">12.二級熟語</option>
                                <option class="dbvalue" value="13.キクタン準２級">13.キクタン準２級</option>
                                <option class="dbvalue" value="14.キクタンBasic">14.キクタンBasic</option>
                                <option class="dbvalue" value="15.キクタン２級">15.キクタン２級</option>
                                <option class="dbvalue" value="90.新概念単語2">90.新概念単語2</option>
                                <option class="dbvalue" value="90.新概念単語3">90.新概念単語3</option>
                                <option class="dbvalue" value="91.英語の文800個">91.英語の文800個</option>
                            </select>
                        </td>
                        <td style="width: 250px;">
                            <select style="width: 100px;height:30px;" class="classification" disabled>
                                <option value=""></option>
                            <option class="dbvalue" value="Day01">Day01</option><option class="dbvalue" value="Day02">Day02</option><option class="dbvalue" value="Day03">Day03</option><option class="dbvalue" value="Day04">Day04</option><option class="dbvalue" value="Day05">Day05</option><option class="dbvalue" value="Day06">Day06</option><option class="dbvalue" value="Day07">Day07</option><option class="dbvalue" value="Day08">Day08</option><option class="dbvalue" value="Day09">Day09</option><option class="dbvalue" value="Day10">Day10</option><option class="dbvalue" value="Day11">Day11</option><option class="dbvalue" value="Day12">Day12</option><option class="dbvalue" value="Day13">Day13</option><option class="dbvalue" value="Day14">Day14</option><option class="dbvalue" value="Day15">Day15</option><option class="dbvalue" value="Day16">Day16</option><option class="dbvalue" value="Day17">Day17</option><option class="dbvalue" value="Day18">Day18</option><option class="dbvalue" value="Day19">Day19</option><option class="dbvalue" value="Day20">Day20</option><option class="dbvalue" value="Day21">Day21</option><option class="dbvalue" value="Day22">Day22</option><option class="dbvalue" value="Day23">Day23</option><option class="dbvalue" value="Day24">Day24</option><option class="dbvalue" value="Day25">Day25</option><option class="dbvalue" value="Day26">Day26</option><option class="dbvalue" value="Day27">Day27</option><option class="dbvalue" value="Day28">Day28</option><option class="dbvalue" value="Day29">Day29</option><option class="dbvalue" value="Day30">Day30</option><option class="dbvalue" value="Day31">Day31</option><option class="dbvalue" value="Day32">Day32</option><option class="dbvalue" value="Day33">Day33</option><option class="dbvalue" value="Day34">Day34</option><option class="dbvalue" value="Day35">Day35</option><option class="dbvalue" value="Day36">Day36</option><option class="dbvalue" value="Day37">Day37</option><option class="dbvalue" value="Day38">Day38</option><option class="dbvalue" value="Day39">Day39</option><option class="dbvalue" value="Day40">Day40</option><option class="dbvalue" value="Day41">Day41</option><option class="dbvalue" value="Day42">Day42</option><option class="dbvalue" value="Day43">Day43</option><option class="dbvalue" value="Day44">Day44</option><option class="dbvalue" value="Day45">Day45</option><option class="dbvalue" value="Day46">Day46</option><option class="dbvalue" value="Day47">Day47</option><option class="dbvalue" value="Day48">Day48</option><option class="dbvalue" value="Day49">Day49</option><option class="dbvalue" value="Day50">Day50</option><option class="dbvalue" value="Day51">Day51</option><option class="dbvalue" value="Day52">Day52</option><option class="dbvalue" value="Day53">Day53</option><option class="dbvalue" value="Day54">Day54</option></select>
                            ～
                            <select style="width: 100px;height:30px;" class="classification" disabled>
                                <option value=""></option>
                            <option class="dbvalue" value="Day01">Day01</option><option class="dbvalue" value="Day02">Day02</option><option class="dbvalue" value="Day03">Day03</option><option class="dbvalue" value="Day04">Day04</option><option class="dbvalue" value="Day05">Day05</option><option class="dbvalue" value="Day06">Day06</option><option class="dbvalue" value="Day07">Day07</option><option class="dbvalue" value="Day08">Day08</option><option class="dbvalue" value="Day09">Day09</option><option class="dbvalue" value="Day10">Day10</option><option class="dbvalue" value="Day11">Day11</option><option class="dbvalue" value="Day12">Day12</option><option class="dbvalue" value="Day13">Day13</option><option class="dbvalue" value="Day14">Day14</option><option class="dbvalue" value="Day15">Day15</option><option class="dbvalue" value="Day16">Day16</option><option class="dbvalue" value="Day17">Day17</option><option class="dbvalue" value="Day18">Day18</option><option class="dbvalue" value="Day19">Day19</option><option class="dbvalue" value="Day20">Day20</option><option class="dbvalue" value="Day21">Day21</option><option class="dbvalue" value="Day22">Day22</option><option class="dbvalue" value="Day23">Day23</option><option class="dbvalue" value="Day24">Day24</option><option class="dbvalue" value="Day25">Day25</option><option class="dbvalue" value="Day26">Day26</option><option class="dbvalue" value="Day27">Day27</option><option class="dbvalue" value="Day28">Day28</option><option class="dbvalue" value="Day29">Day29</option><option class="dbvalue" value="Day30">Day30</option><option class="dbvalue" value="Day31">Day31</option><option class="dbvalue" value="Day32">Day32</option><option class="dbvalue" value="Day33">Day33</option><option class="dbvalue" value="Day34">Day34</option><option class="dbvalue" value="Day35">Day35</option><option class="dbvalue" value="Day36">Day36</option><option class="dbvalue" value="Day37">Day37</option><option class="dbvalue" value="Day38">Day38</option><option class="dbvalue" value="Day39">Day39</option><option class="dbvalue" value="Day40">Day40</option><option class="dbvalue" value="Day41">Day41</option><option class="dbvalue" value="Day42">Day42</option><option class="dbvalue" value="Day43">Day43</option><option class="dbvalue" value="Day44">Day44</option><option class="dbvalue" value="Day45">Day45</option><option class="dbvalue" value="Day46">Day46</option><option class="dbvalue" value="Day47">Day47</option><option class="dbvalue" value="Day48">Day48</option><option class="dbvalue" value="Day49">Day49</option><option class="dbvalue" value="Day50">Day50</option><option class="dbvalue" value="Day51">Day51</option><option class="dbvalue" value="Day52">Day52</option><option class="dbvalue" value="Day53">Day53</option><option class="dbvalue" value="Day54">Day54</option></select>
                        </td>
                        <td style="width: 120px;">
                            <select style="width: 100px;height:30px;" >
                                <option value=""></option>
                                <option value="未勉強">未勉強</option>
                                <option value="勉強中">勉強中</option>
                                <option value="勉強済" selected>勉強済</option>
                            </select>
                        </td>
                        <td style="width: 100px;">
                            <select style="width: 80px;height:30px;" class="">
                                <option value="0">全部</option>
                                <option value="10">10語</option>
                                <option value="20">20語</option>
                                <option value="30">30語</option>
                                <option value="50">50語</option>
                                <option value="80">80語</option>
                                <option value="100" selected>100語</option>
                            </select>
                        </td>
                        <td style="width: 200px;">
                            <select style="width: 180px;height:30px;" onchange="">
                                <option value="A.勉強" selected>&nbsp;A.勉強</option>
                                <option value="B.中日訳英">&nbsp;B.中日訳英</option>
                                <option value="C.音訳英">&nbsp;C.音訳英</option>
                                <option value="D.英訳中">&nbsp;D.英訳中</option>
                            </select>
                        </td>
                        <td style="width: 220px;">
                            <select style="width: 200px;height:30px;" onchange="">
                                <option value="1.簡単" selected>&nbsp;1.簡単</option>
                            </select>
                        </td>
                    </tr>
                    <tr style="height: 40px;" class="copytr3">
                        <td style="width: 60px;">
                            <img src="img/delete2.png" width="20px;" height="20px;" onclick="removeThisTR(this);">
                        </td>
                        <td style="width: 170px;">
                            <select style="width: 150px;height:30px;" onchange="initclassification2(this);" class="">
                                <option value=""></option>
                                <option class="dbvalue" value="00.すべて" selected>00.すべて</option>
                                <option class="dbvalue" value="01.三級単語">01.三級単語</option>
                                <option class="dbvalue" value="02.三級熟語">02.三級熟語</option>
                                <option class="dbvalue" value="03.キクタン">03.キクタン</option>
                                <option class="dbvalue" value="04.キクジュク">04.キクジュク</option>
                                <option class="dbvalue" value="11.二級単語">11.二級単語</option>
                                <option class="dbvalue" value="12.二級熟語">12.二級熟語</option>
                                <option class="dbvalue" value="13.キクタン準２級">13.キクタン準２級</option>
                                <option class="dbvalue" value="14.キクタンBasic">14.キクタンBasic</option>
                                <option class="dbvalue" value="15.キクタン２級">15.キクタン２級</option>
                                <option class="dbvalue" value="90.新概念単語2">90.新概念単語2</option>
                                <option class="dbvalue" value="90.新概念単語3">90.新概念単語3</option>
                                <option class="dbvalue" value="91.英語の文800個">91.英語の文800個</option>
                            </select>
                        </td>
                        <td style="width: 250px;">
                            <select style="width: 100px;height:30px;" class="classification" disabled>
                                <option value=""></option>
                            <option class="dbvalue" value="Day01">Day01</option><option class="dbvalue" value="Day02">Day02</option><option class="dbvalue" value="Day03">Day03</option><option class="dbvalue" value="Day04">Day04</option><option class="dbvalue" value="Day05">Day05</option><option class="dbvalue" value="Day06">Day06</option><option class="dbvalue" value="Day07">Day07</option><option class="dbvalue" value="Day08">Day08</option><option class="dbvalue" value="Day09">Day09</option><option class="dbvalue" value="Day10">Day10</option><option class="dbvalue" value="Day11">Day11</option><option class="dbvalue" value="Day12">Day12</option><option class="dbvalue" value="Day13">Day13</option><option class="dbvalue" value="Day14">Day14</option><option class="dbvalue" value="Day15">Day15</option><option class="dbvalue" value="Day16">Day16</option><option class="dbvalue" value="Day17">Day17</option><option class="dbvalue" value="Day18">Day18</option><option class="dbvalue" value="Day19">Day19</option><option class="dbvalue" value="Day20">Day20</option><option class="dbvalue" value="Day21">Day21</option><option class="dbvalue" value="Day22">Day22</option><option class="dbvalue" value="Day23">Day23</option><option class="dbvalue" value="Day24">Day24</option><option class="dbvalue" value="Day25">Day25</option><option class="dbvalue" value="Day26">Day26</option><option class="dbvalue" value="Day27">Day27</option><option class="dbvalue" value="Day28">Day28</option><option class="dbvalue" value="Day29">Day29</option><option class="dbvalue" value="Day30">Day30</option><option class="dbvalue" value="Day31">Day31</option><option class="dbvalue" value="Day32">Day32</option><option class="dbvalue" value="Day33">Day33</option><option class="dbvalue" value="Day34">Day34</option><option class="dbvalue" value="Day35">Day35</option><option class="dbvalue" value="Day36">Day36</option><option class="dbvalue" value="Day37">Day37</option><option class="dbvalue" value="Day38">Day38</option><option class="dbvalue" value="Day39">Day39</option><option class="dbvalue" value="Day40">Day40</option></select>
                            ～
                            <select style="width: 100px;height:30px;" class="classification" disabled>
                                <option value=""></option>
                            <option class="dbvalue" value="Day01">Day01</option><option class="dbvalue" value="Day02">Day02</option><option class="dbvalue" value="Day03">Day03</option><option class="dbvalue" value="Day04">Day04</option><option class="dbvalue" value="Day05">Day05</option><option class="dbvalue" value="Day06">Day06</option><option class="dbvalue" value="Day07">Day07</option><option class="dbvalue" value="Day08">Day08</option><option class="dbvalue" value="Day09">Day09</option><option class="dbvalue" value="Day10">Day10</option><option class="dbvalue" value="Day11">Day11</option><option class="dbvalue" value="Day12">Day12</option><option class="dbvalue" value="Day13">Day13</option><option class="dbvalue" value="Day14">Day14</option><option class="dbvalue" value="Day15">Day15</option><option class="dbvalue" value="Day16">Day16</option><option class="dbvalue" value="Day17">Day17</option><option class="dbvalue" value="Day18">Day18</option><option class="dbvalue" value="Day19">Day19</option><option class="dbvalue" value="Day20">Day20</option><option class="dbvalue" value="Day21">Day21</option><option class="dbvalue" value="Day22">Day22</option><option class="dbvalue" value="Day23">Day23</option><option class="dbvalue" value="Day24">Day24</option><option class="dbvalue" value="Day25">Day25</option><option class="dbvalue" value="Day26">Day26</option><option class="dbvalue" value="Day27">Day27</option><option class="dbvalue" value="Day28">Day28</option><option class="dbvalue" value="Day29">Day29</option><option class="dbvalue" value="Day30">Day30</option><option class="dbvalue" value="Day31">Day31</option><option class="dbvalue" value="Day32">Day32</option><option class="dbvalue" value="Day33">Day33</option><option class="dbvalue" value="Day34">Day34</option><option class="dbvalue" value="Day35">Day35</option><option class="dbvalue" value="Day36">Day36</option><option class="dbvalue" value="Day37">Day37</option><option class="dbvalue" value="Day38">Day38</option><option class="dbvalue" value="Day39">Day39</option><option class="dbvalue" value="Day40">Day40</option></select>
                        </td>
                        <td style="width: 120px;">
                            <select style="width: 100px;height:30px;" >
                                <option value=""></option>
                                <option value="未勉強">未勉強</option>
                                <option value="勉強中" selected>勉強中</option>
                                <option value="勉強済">勉強済</option>
                            </select>
                        </td>
                        <td style="width: 100px;">
                            <select style="width: 80px;height:30px;" class="">
                                <option value="0">全部</option>
                                <option value="10">10語</option>
                                <option value="20">20語</option>
                                <option value="30">30語</option>
                                <option value="50">50語</option>
                                <option value="80">80語</option>
                                <option value="100" selected>100語</option>
                            </select>
                        </td>
                        <td style="width: 200px;">
                            <select style="width: 180px;height:30px;" onchange="">
                                <option value="A.勉強" selected>&nbsp;A.勉強</option>
                                <option value="B.中日訳英">&nbsp;B.中日訳英</option>
                                <option value="C.音訳英">&nbsp;C.音訳英</option>
                                <option value="D.英訳中">&nbsp;D.英訳中</option>
                            </select>
                        </td>
                        <td style="width: 220px;">
                            <select style="width: 200px;height:30px;" onchange="">
                                <option value="1.簡単" selected>&nbsp;1.簡単</option>
                            </select>
                        </td>
                    </tr>
                </tbody>
            </table>
            <table class="table_inputdialog_btn" border="0">
                <tbody>
                    <tr>
                        <td style="width: 650px;"></td>
                        <td style="width: 200px;"><button class="btn" id="btn_lottery" onclick="makeRandomTest();">抽　選</button></td>
                        <td style="width: 200px;"><button class="btn" onclick="testword_random_inputdialog.dialog('close');">キャンセル</button></td>
                        <td style="width: 650px;"></td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>