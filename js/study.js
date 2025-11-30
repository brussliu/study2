function beginTest(){

    showNumber();

	setContent();

	showWord();

    openAIpage();

}

function openAIpage(){

    var kind = $('#hiddenKind').val();
    if(kind == 'A.勉強'){

        Efw('testword_openaipage');
    }
    
}

// タイトル表示
function showNumber(){

    var no = $('#hiddenWordNo').val();
    var count = $('#hiddenWordCount').val();

    var book = $('#hiddenBook').val();
    var classification = $('#hiddenclassification').val();

    $('#nospan').html(no + "/" + count);
    $('#bookspan').html(book + "/" + classification);

    if(no == 1){
        $('#btnback').hide();
    }
    if(no == count){

        $('#btnnext').html("完了");
    }
    
}

// 単語例句設定（中日）
function setContent(){

    $("#wordCSpan").html($('#hiddenWordC').val());
    $("#wordJSpan").html($('#hiddenWordJ').val());

    $("#sen1CSpan").html($('#hiddenSen1C').val());
    $("#sen1JSpan").html($('#hiddenSen1J').val());

    $("#sen2CSpan").html($('#hiddenSen2C').val());
    $("#sen2JSpan").html($('#hiddenSen2J').val());
}

function nextLetter(obj){
    
    var str = $(obj).val();

    if($(obj).val().length == 1){

        if($(obj).hasClass("inputword2")){
            $(obj).val(str.toUpperCase());
        }else{
            $(obj).val(str.toLowerCase());
        }

        if($(obj).next("input").css('display') != 'none'){
            $(obj).next("input").focus();
            return;
        }

        if($(obj).next("input").next("input").css('display') != 'none'){
            $(obj).next("input").next("input").focus();
            return;
        }

        if($(obj).next("input").next("input").next("input").css('display') != 'none'){
            $(obj).next("input").next("input").next("input").focus();
            return;
        }

        if($(obj).next("input").next("input").next("input").next("input").css('display') != 'none'){
            $(obj).next("input").next("input").next("input").next("input").focus();
            return;
        }
    }
    
}


// 単語表示処理
function showWord() {

    // テスト方式
    var type = $("#hiddenType").val();
    // テスト種別
    var kind = $("#hiddenKind").val();
    // テスト種別
    var level = $("#hiddenLevel").val();
    //A.勉強
    //B.中日訳英
    //C.音訳英
    //D.英訳中


    // 中国語表示
    if(kind == 'A.勉強' || kind == 'B.中日訳英'){

        $("#wordCSpan").show();// 中国語
        $("#wordJSpan").show();// 日本語
        $("#wordIcon").show();// 音声

    }
    if(kind == 'C.音訳英'){

        $("#wordCSpan").hide();// 中国語
        $("#wordJSpan").hide();// 日本語
        $("#wordIcon").show();// 音声

    }

    if(kind == 'B.中日訳英' || kind == 'C.音訳英'){

        if(level = '1.簡単') {

            // 単語入力欄の表示
            var wordE = $('#hiddenWordE').val();
            var html = "";
            for(var i = 0;i < wordE.length;i ++){

                if(wordE[i] == ' '){
                    html = html + "<input type='text' class='inputword' maxlength='1' lang='en' style='display: none;' value=' '/>";
                    html = html + "&nbsp;&nbsp;";
                }else if (!/[a-zA-Z\s]/.test(wordE[i])) {

                    if(wordE[i] == "'"){
                        html = html + "<input type='text' class='inputword' maxlength='1' lang='en' style='display: none;' value='&apos;'/>";
                    }else{
                        html = html + "<input type='text' class='inputword' maxlength='1' lang='en' style='display: none;' value='" + wordE[i] + "'/>";
                    }
                    
                    html = html + wordE[i];
                }else{

                    if (/[a-z]/.test(wordE[i])) {
                        html = html + "<input type='text' class='inputword' maxlength='1' lang='en' oninput='nextLetter(this);'/>";
                    }
                    if (/[A-Z]/.test(wordE[i])) {
                        html = html + "<input type='text' class='inputword inputword2' style='background-color: rgb(210,250,210)!important;' maxlength='1'  lang='en' oninput='nextLetter(this);'/>";
                    }
                }
                
            }

            $("#wordEDiv").html(html);
        }
        if(level = '2.困難') {

            
        }

    }else if(kind == 'A.勉強'){

        // 単語
        $('#wordEDiv').hide();
        $('.worddiv').eq(0).parent().css('display', 'flex');
        $('.worddiv').eq(0).html($('#hiddenWordE').val());
        $('.worddiv').eq(0).css('color', 'blue');

        showSen1();
        $('#sen1EDiv').hide();
        $('.sen1div').eq(0).parent().css('display', 'flex');
        $('.sen1div').eq(0).html($('#hiddenSen1E').val());
        $('.sen1div').eq(0).css('color', 'blue');

        showSen2();
        $('#sen2EDiv').hide();
        $('.sen2div').eq(0).parent().css('display', 'flex');
        $('.sen2div').eq(0).html($('#hiddenSen2E').val());
        $('.sen2div').eq(0).css('color', 'blue');

    } 


    $(".inputword").keydown(function(event) {

        // keyboard音
        keyboardVoice();

        // キーコード
        var keycode = (event.keyCode ? event.keyCode : event.which);

        // ENTER
        if(keycode === 13) {
            checkWord();
        }
        // SHIFT 左側
        if(keycode === 16) {
            playVoice(1,0);
        }
        // Ctrl 左側
        if(keycode === 17) {
            playVoice(1,1);
        }
        // Atl 左側
        if(keycode === 18) {
            playVoice(1,2);
        }
        // Delete 削除キー
        if(keycode === 8) {
            if ($(":focus").length > 0) {

                if($(":focus").val().length > 0){
                    
                    $(":focus").val("");
                }else{

                    if($(":focus").prev().css('display') != 'none'){
                        $(":focus").prev().focus();
                    }else{
                        if($(":focus").prev().prev().css('display') != 'none'){
                            $(":focus").prev().prev().focus();
                        }
                    }
                }
            }
        }
    });

    $(".inputword").eq(0).focus();
    
    // 自動音声
    playVoice(1,0);

    if(kind == 'A.勉強'){
        
        setTimeout(function(){
            playVoice(2,0);
        }, 1000);

        setTimeout(function(){
            playVoice(3,0);
        }, 1000);

    }
}

function showSen1(){

    // テスト方式
    var type = $("#hiddenType").val();
    // テスト種別
    var kind = $("#hiddenKind").val();
    // テスト種別
    var level = $("#hiddenLevel").val();
    //A.勉強
    //B.中日訳英
    //C.音訳英
    //D.英訳中


    if($('#sen1CSpan').html() != "" || $('#sen1JSpan').html() != ""){

        // 中国語表示
        if(kind == 'A.勉強' || kind == 'B.中日訳英'){

            $("#sen1CSpan").show();// 中国語
            $("#sen1JSpan").show();// 日本語
            $("#sen1Icon").show();// 音声

        }
        if(kind == 'C.音訳英'){

            $("#sen1CSpan").hide();// 中国語
            $("#sen1JSpan").hide();// 日本語
            $("#sen1Icon").show();// 音声

        }


        

        if(kind == 'B.中日訳英' || kind == 'C.音訳英'){

            if(level = '1.簡単') {

                // 単語入力欄の表示
                var sen1E = $('#hiddenSen1E').val();
                var sen1EArr = sen1E.split(" ");
                var html = "";
                for(var i = 0;i < sen1E.length;i ++){

                    if(sen1E[i] == ' '){
                        html = html + "<input type='text' class='inputsentence1' maxlength='1' lang='en' style='display: none;' value=' '/>";
                        html = html + "&nbsp;&nbsp;";
                    }else if (!/[a-zA-Z\s]/.test(sen1E[i])) {

                        if(sen1E[i] == "'"){
                            html = html + "<input type='text' class='inputsentence1' maxlength='1' lang='en' style='display: none;' value='&apos;'/>";
                        }else{
                            html = html + "<input type='text' class='inputsentence1' maxlength='1' lang='en' style='display: none;' value='" + sen1E[i] + "'/>";
                        }
                        
                        html = html + sen1E[i];
                    }else{

                        if (/[a-z]/.test(sen1E[i])) {
                            html = html + "<input type='text' class='inputsentence1' maxlength='1' lang='en' oninput='nextLetter(this);'/>";
                        }
                        if (/[A-Z]/.test(sen1E[i])) {
                            html = html + "<input type='text' class='inputsentence1 inputword2' style='background-color: rgb(210,250,210)!important;' maxlength='1'  lang='en' oninput='nextLetter(this);'/>";
                        }
                    }
                    
                }

                $("#sen1EDiv").html(html);
            }
            if(level = '2.困難') {

                
            }

        }



        $(".inputsentence1").keydown(function(event) {

            var keycode = (event.keyCode ? event.keyCode : event.which);

            // ENTER
            if(keycode === 13) {
                checkSen1();
            }
            // SHIFT 左側
            if(keycode === 16) {
                playVoice(2,0);
            
            }
            // Ctrl 左側
            if(keycode === 17) {
                playVoice(2,1);
                
            }
            // Atl 左側
            if(keycode === 18) {
                playVoice(2,2);
                
            }
            // Delete 削除キー
            if(keycode === 8) {
                if ($(":focus").length > 0) {

                    if($(":focus").val().length > 0){
                        
                        $(":focus").val("");
                    }else{

                        if($(":focus").prev().css('display') != 'none'){
                            $(":focus").prev().focus();
                        }else{
                            if($(":focus").prev().prev().css('display') != 'none'){
                                $(":focus").prev().prev().focus();
                            }
                        }
                    }
                }
            }
        });

        $('#sen1div').show();
    
        $(".inputsentence1").eq(0).focus();

    }else{
        setTimeout(function(){
            $("#btnnext").focus();
        }, 100);

    }
    
}

function showSen2(){

        // テスト方式
    var type = $("#hiddenType").val();
    // テスト種別
    var kind = $("#hiddenKind").val();
    // テスト種別
    var level = $("#hiddenLevel").val();
    //A.勉強
    //B.中日訳英
    //C.音訳英
    //D.英訳中

    if($('#sen2CSpan').html() != "" || $('#sen2JSpan').html() != ""){

        // 中国語表示
        if(kind == 'A.勉強' || kind == 'B.中日訳英'){

            $("#sen2CSpan").show();// 中国語
            $("#sen2JSpan").show();// 日本語
            $("#sen2Icon").show();// 音声

        }
        if(kind == 'C.音訳英'){

            $("#sen2CSpan").hide();// 中国語
            $("#sen2JSpan").hide();// 日本語
            $("#sen2Icon").show();// 音声

        }

        $("#inputsentence2").keydown(function(event) {
            var keycode = (event.keyCode ? event.keyCode : event.which);
            // ENTER
            if(keycode === 13) {
                checkSen2();
            }
            // SHIFT 左側
            if(keycode === 16) {
                playVoice(3,0);
                
            }
            // Ctrl 左側
            if(keycode === 17) {
                playVoice(3,1);
                
            }
            // Atl 左側
            if(keycode === 18) {
                playVoice(3,2);
                
            }

        });

        $('#sen2div').show();

        $("#inputsentence2").focus();
    }else{
        setTimeout(function(){
            $("#btnnext").focus();
        }, 100);

    }
}

function checkWord(){

    // 入力内容取得
    var inputword = "";
    $(".inputword").each(function(index, element) {
        inputword = inputword + $(element).val();
    });

    // OKと判定
    if(inputword.trim() == $('#hiddenWordE').val().trim()){

        var time = $('#hiddenWordWrongTime').val();
        if(time == null || time == ""){
            time = 0;
        }
        $('#hiddenWordWrongTime').val(time);

        $('#hiddenWordCheckResult').val("OK");

        rightVoice("word");
        overWord("OK");
        showSen1();

    // NGと判定
    }else{

        wrongVoice();

        $('#wordWrongTimeDiv').show();
        
        var time = $('#hiddenWordWrongTime').val();
        if(time == null || time == ""){
            time = 0;
        }
        time = parseInt(time) + 1;
        $('#hiddenWordWrongTime').val(time);
        $('#wordWrongTimeDiv').children().eq(0).html("誤り回数：" + time + "回");

        if(parseInt(time) >= 3){

            // 3回誤りの場合
            overWord("NG");

            showSen1();
        }else{
            return;
        }
        
    }
}

function checkSen1(){

    //var inputsent1 = $("#inputsentence1").val();
    // 入力内容取得
    var inputsent1 = "";
    $(".inputsentence1").each(function(index, element) {
        inputsent1 = inputsent1 + $(element).val();
    });

    // OK
    if(inputsent1.trim() == $('#hiddenSen1E').val().trim()){

        var time = $('#hiddenSen1WrongTime').val();
        if(time == null || time == ""){
            time = 0;
        }

        $('#hiddenSen1WrongTime').val(time);
        $('#hiddenSen1CheckResult').val("OK");

        rightVoice("sen1");
        overSen1("OK");
        showSen2();

    // NG
    }else{

        wrongVoice();

        $('#sen1WrongTimeDiv').show();
        
        var time = $('#hiddenSen1WrongTime').val();
        if(time == null || time == ""){
            time = 0;
        }

        time = parseInt(time) + 1;

        $('#hiddenSen1WrongTime').val(time);
        $('#sen1WrongTimeDiv').children().eq(0).html("誤り回数：" + time + "回");

        if(parseInt(time) >= 3){

            // 3回誤りの場合
            overSen1("NG");

            showSen2();

            return;
        }else{

            return;
        }
    
        
    }
}

function checkSen2(){

    var inputsent2 = $("#inputsentence2").val();

    // OK
    if(inputsent2.trim() == $('#hiddenSen2E').val().trim()){

        var time = $('#hiddenSen2WrongTime').val();
        if(time == null || time == ""){
            time = 0;
        }

        $('#hiddenSen2WrongTime').val(time);
        $('#hiddenSen2CheckResult').val("OK");

        rightVoice("sen2");
        overSen2("OK");

        setTimeout(function(){
            $("#btnnext").focus();
        }, 100);

    // NG
    }else{

        wrongVoice();

        $('#sen2WrongTimeDiv').show();
        
        var time = $('#hiddenSen2WrongTime').val();
        if(time == null || time == ""){
            time = 0;
        }
        time = parseInt(time) + 1;

        $('#hiddenSen2WrongTime').val(time);
        $('#sen2WrongTimeDiv').children().eq(0).html("誤り回数：" + time + "回");

        if(parseInt(time) >= 3){

            // 3回誤りの場合
            overSen2("NG");

            setTimeout(function(){
                $("#btnnext").focus();
            }, 100);

            return;
        }else{


            return;
        }

        
    }
}

function rightVoice(flg) {

    var audioElement = document.createElement('audio');

    if(flg == "word"){
        if($('#hiddenSen1J').val() != "" || $('#hiddenSen2J').val() != ""){
            audioElement.setAttribute('src', './mp3/right1.mp3');
        }else{
            audioElement.setAttribute('src', './mp3/right2.mp3');
        }
    }else if(flg == "sen1"){
        if($('#hiddenSen2J').val() != ""){
            audioElement.setAttribute('src', './mp3/right1.mp3');
        }else{

            if($('#hiddenWordWrongTime').val() > 0){
                audioElement.setAttribute('src', './mp3/right1.mp3');
            }else{
                audioElement.setAttribute('src', './mp3/right2.mp3');
            }
            
        }
    }else if(flg == "sen2"){
        if($('#hiddenWordWrongTime').val() > 0 || $('#hiddenSen1WrongTime').val() > 0){
            audioElement.setAttribute('src', './mp3/right1.mp3');
        }else{
            audioElement.setAttribute('src', './mp3/right2.mp3');
        }
    }
    
    audioElement.setAttribute('autoplay', 'autoplay');
}

function overWord(flg){

    // 単語
    $('#wordEDiv').hide();
    $('.worddiv').eq(0).parent().css('display', 'flex');
    $('.worddiv').eq(0).html($('#hiddenWordE').val());
    if(flg == "OK"){
        $('.worddiv').eq(0).css('color', 'blue');
    }else{
        $('.worddiv').eq(0).css('color', 'red');

        var inputword = "";
        $(".inputword").each(function(index, element) {
            inputword = inputword + $(element).val();
        });
        if(inputword.trim() != ""){
            $('.wrongworddiv').eq(0).html(inputword.trim());
            $('.wrongworddiv').eq(0).parent().css('display', 'flex');

            $('.worddiv').eq(0).css('color', 'blue');
        }
        
    }
}

function overSen1(flg){

    // 単語
    $('#sen1EDiv').hide();
    $('.sen1div').eq(0).parent().css('display', 'flex');
    $('.sen1div').eq(0).html($('#hiddenSen1E').val());
    if(flg == "OK"){
        $('.sen1div').eq(0).css('color', 'blue');
    }else{
        $('.sen1div').eq(0).css('color', 'red');

        var inputsentence1 = "";
        $(".inputsentence1").each(function(index, element) {
            inputsentence1 = inputsentence1 + $(element).val();
        });

        if(inputsentence1.trim() != ""){
            $('.wrongsen1div').eq(0).html(inputsentence1.trim());
            $('.wrongsen1div').eq(0).parent().css('display', 'flex');

            $('.sen1div').eq(0).css('color', 'blue');
        }
    }

}

function overSen2(flg){

    // 単語
    $('#sen2EDiv').hide();
    $('.sen2div').eq(0).parent().css('display', 'flex');
    $('.sen2div').eq(0).html($('#hiddenSen2E').val());
    if(flg == "OK"){
        $('.sen2div').eq(0).css('color', 'blue');
    }else{
        $('.sen2div').eq(0).css('color', 'red');
        if($('#inputsentence2').val() != ""){
            $('.wrongsen2div').eq(0).html($('#inputsentence2').val());
            $('.wrongsen2div').eq(0).parent().css('display', 'flex');

            $('.sen2div').eq(0).css('color', 'blue');
        }
    }

}