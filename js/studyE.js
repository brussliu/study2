function beginTest(){

    showNumber();

	setContent();

    showWord();

}


// タイトル表示
function showNumber(){

    var no = $('#hiddenWordNo').val();
    var count = $('#hiddenWordCount').val();

    var book = $('#hiddenBook').val();
    var classification = $('#hiddenclassification').val();

    $('#nospan').html(no + "/" + count);
    $('#bookspan').html(book + "/" + classification);

    // if(no == 1){
    //     $('#btnback').hide();
    // }
    if(no == count){

        $('#btnnext').html("完了");
    }
    
}

function setContent(){

    $("#wordCSpan").html($('#hiddenWordC').val());
    $("#wordJSpan").html($('#hiddenWordJ').val());

    // $("#wordC1").next().html($('#hiddenItem1').val());
    // $("#wordC2").next().html($('#hiddenItem2').val());

    // $("#wordC3").next().html($('#hiddenItem3').val());
    // $("#wordC4").next().html($('#hiddenItem4').val());

    //$("#wordC1").focus();

    //wordEDiv

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



    if(level = '1.簡単') {

        // 単語入力欄の表示
        var wordE = $('#hiddenWordE').val();
        var wordEArr = wordE.split(" ");
        var html = "";

        var word_width= 0;
        for(var i = 0;i < wordEArr.length;i ++){

            // if (!/[a-zA-Z\s]/.test(wordEArr[i])) {

            //     if(wordE[i] == "'"){
            //         html = html + "<input type='text' class='inputword' maxlength='1' lang='en' style='display: none;' value='&apos;'/>";
            //     }else{
            //         html = html + "<input type='text' class='inputword' maxlength='1' lang='en' style='display: none;' value='" + wordE[i] + "'/>";
            //     }
                
            //     html = html + wordE[i];

            // }else{

                word_width = getWidthFromWord(wordEArr[i]);
                // if (/[a-z]/.test(wordE[i])) {
                //     html = html + "<input type='text' class='inputword' style='width:" + word_width + "px' lang='en' oninput='nextLetter(this);'/>&nbsp;&nbsp;";
                // }
                if (/[A-Z]/.test(wordE[i])) {
                    html = html + "<input type='text' class='inputword inputword2' style='width:" + word_width + "px;background-color: rgb(210,250,210)!important;' lang='en'/>&nbsp;";
                }else{
                    html = html + "<input type='text' class='inputword' style='width:" + word_width + "px;' lang='en'/>&nbsp;";
                }
            //}
            
        }

        $("#wordEDiv").html(html);
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
        // SPACE
        if(keycode === 32) {
            
            event.preventDefault();
            // console.log("1" + $(":focus").next().val() + "1");
            // if($(":focus").next().val() == " "){
            //     $(":focus").next().val("");
            // }

            $(":focus").next().focus();
        }
        // Delete 削除キー
        if(keycode === 8) {
            if ($(":focus").val().length <= 0) {
                event.preventDefault();
                $(":focus").prev().focus();
            }
            // if ($(":focus").length > 0) {

            //     if($(":focus").val().length > 0){
                    
            //         $(":focus").val("");
            //     }else{

            //         if($(":focus").prev().css('display') != 'none'){
            //             $(":focus").prev().focus();
            //         }else{
            //             if($(":focus").prev().prev().css('display') != 'none'){
            //                 $(":focus").prev().prev().focus();
            //             }
            //         }
            //     }
            // }
        }
    });

    $(".inputword").eq(0).focus();
    
    // // 自動音声
    // playVoice(1,0);

    // if(kind == 'A.勉強'){
        
    //     setTimeout(function(){
    //         playVoice(2,0);
    //     }, 1000);

    //     setTimeout(function(){
    //         playVoice(3,0);
    //     }, 1000);

    // }

    playRightVoice();
}

function getWidthFromWord(width){

    return 30 * width.length + 10 * 2;


}


function checkWord(){

    // 入力内容取得
    var inputword = "";
    $(".inputword").each(function(index, element) {
        inputword = inputword + " " + $(element).val();
    });

    // OKと判定
    if(inputword.trim() == $('#hiddenWordE').val().trim()){

        var time = $('#hiddenWordWrongTime').val();
        if(time == null || time == ""){
            time = 0;
        }
        $('#hiddenWordWrongTime').val(time);

        rightVoice2();
        overWord("OK");
        setTimeout(function(){
            $("#btnnext").show();
            $("#btnnext").focus();
        }, 100);
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
            setTimeout(function(){

                $("#btnnext").show();
                $("#btnnext").focus();
            }, 100);

        }else{
            return;
        }
        
    }
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



