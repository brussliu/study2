function beginTest(){

    showNumber();

	setContent();

    highlightWord();
}

function highlightWord() {

    var word = $('#hiddenWordE').val();
    console.log(111);
    // 获取原始span元素
    const question = $('#question');
    console.log(222);
    // 获取原始HTML内容
    const originalHtml = question.html();
    console.log(333);
    // 使用正则表达式全局匹配目标单词，不区分大小写
    // 使用单词边界\b确保匹配完整单词[citation:3]
    const regex = new RegExp(`\\b${word}\\b`, 'gi');
    console.log(444);
    // 替换匹配的单词，保留原文本中的空格和标点
    const newHtml = originalHtml.replace(regex, '<span class="highlight">$&</span>');
    console.log(555);
    // 更新span内容
    question.html(newHtml);
    console.log(666);
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

    $("#wordC1").next().html($('#hiddenItem1').val());
    $("#wordC2").next().html($('#hiddenItem2').val());

    $("#wordC3").next().html($('#hiddenItem3').val());
    $("#wordC4").next().html($('#hiddenItem4').val());

    //highlightWord();

    //$("#wordC1").focus();

    playRightVoice();


    // 键盘事件监听
    document.addEventListener('keydown', function handleKeydown(event) {
        if (event.key === 'ArrowDown') {
            // 向下移动
            //currentIndex = (currentIndex + 1) % boxes.length;
            //updateSelection();

            var selectedid = $('.selected').first().children().eq(0).attr('id');
            if(selectedid == "wordC1"){
                $('#wordC1').parent().removeClass("selected");
                $('#wordC2').parent().addClass("selected");
            }
            if(selectedid == "wordC2"){
                $('#wordC2').parent().removeClass("selected");
                $('#wordC3').parent().addClass("selected");
            }
            if(selectedid == "wordC3"){
                $('#wordC3').parent().removeClass("selected");
                $('#wordC4').parent().addClass("selected");
            }
            if(selectedid == "wordC4"){
                $('#wordC4').parent().removeClass("selected");
                $('#wordC1').parent().addClass("selected");
            }

        } else if (event.key === 'ArrowUp') {
            // 向上移动
            //currentIndex = (currentIndex - 1 + boxes.length) % boxes.length;
            //updateSelection();
            
            var selectedid = $('.selected').first().children().eq(0).attr('id');
            if(selectedid == "wordC1"){
                $('#wordC1').parent().removeClass("selected");
                $('#wordC4').parent().addClass("selected");
            }
            if(selectedid == "wordC2"){
                $('#wordC2').parent().removeClass("selected");
                $('#wordC1').parent().addClass("selected");
            }
            if(selectedid == "wordC3"){
                $('#wordC3').parent().removeClass("selected");
                $('#wordC2').parent().addClass("selected");
            }
            if(selectedid == "wordC4"){
                $('#wordC4').parent().removeClass("selected");
                $('#wordC3').parent().addClass("selected");
            }
        } else if (event.key === 'Enter') {
                $(".selected").first().children().eq(0).click();
                document.removeEventListener('keydown', handleKeydown);

        }

    });



}

function checkResult(obj){

    // 入力内容取得
    var input = $(obj).next().html();

    // OKと判定
    if(input == $('#hiddenRightRt').val()){

        var time = $('#hiddenWordWrongTime').val();
        if(time == null || time == ""){
            time = 0;
        }
        $('#hiddenWordWrongTime').val(time);

        $('#hiddenWordCheckResult').val("OK");

        rightVoice1();

        overOK(obj);

    // NGと判定
    }else{

        wrongVoice();

        overNG(obj);
        
    }

    
    $('#explain').show();

    $('#btnnext').show();

    setTimeout(function(){
        $('#btnnext').focus();
    }, 100);
    
}

function overOK(obj){

    $("#wordC1").prop("disabled",true);
    $("#wordC2").prop("disabled",true);
    $("#wordC3").prop("disabled",true);
    $("#wordC4").prop("disabled",true);

    $(obj).parent().css("background-color", "rgb(200,255,200)");

    $("#wordCSpan").show();
    $("#wordJSpan").show();

}

function overNG(obj){

    $("#wordC1").prop("disabled",true);
    $("#wordC2").prop("disabled",true);
    $("#wordC3").prop("disabled",true);
    $("#wordC4").prop("disabled",true);

    $(obj).parent().css("background-color", "rgb(255,150,150)");

    var input1 = $("#wordC1").next().html();
    var input2 = $("#wordC2").next().html();
    var input3 = $("#wordC3").next().html();
    var input4 = $("#wordC4").next().html();

    if(input1 == $('#hiddenRightRt').val()){
        $("#wordC1").parent().css("background-color", "rgb(200,255,200)");
    }
    if(input2 == $('#hiddenRightRt').val()){
        $("#wordC2").parent().css("background-color", "rgb(200,255,200)");
    }
    if(input3 == $('#hiddenRightRt').val()){
        $("#wordC3").parent().css("background-color", "rgb(200,255,200)");
    }
    if(input4 == $('#hiddenRightRt').val()){
        $("#wordC4").parent().css("background-color", "rgb(200,255,200)");
    }

    $("#wordCSpan").show();
    $("#wordJSpan").show();

}