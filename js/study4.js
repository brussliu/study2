function beginTest(){

    showNumber();

	setContent();

	showWord();
    // overWord();

    // showSen1();
    // overSen1();

    // showSen2();
    // overSen2();

    //$("#btnnext").focus();

}

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

function setContent(){

    $("#worddiv_right span").html($('#hiddenWordE').val());
    $("#wordCSpan").html($('#hiddenWordC').val());
    $("#wordJSpan").html($('#hiddenWordJ').val());

    $("#sen1div_right span").html($('#hiddenSen1E').val());
    $("#sen1CSpan").html($('#hiddenSen1C').val());
    $("#sen1JSpan").html($('#hiddenSen1J').val());

    $("#sen2div_right span").html($('#hiddenSen2E').val());
    $("#sen2CSpan").html($('#hiddenSen2C').val());
    $("#sen2JSpan").html($('#hiddenSen2J').val());
}



function showWord() {

    $("#wordIcon").show();
    $("#worddiv_right").parent().css('display', 'flex');
    
}

function overWord(){

    // 単語
    $('#wordCSpan').show();
    $('#wordJSpan').show();

}


function showSen1(){


    if($('#sen1CSpan').html() != "" || $('#sen1JSpan').html() != ""){

        $("#sen1Icon").show();
        $("#sen1div_right").parent().css('display', 'flex');

        $('#sen1div').show();

    }
    
}

function overSen1(){

    $('#sen1CSpan').show();
    $('#sen1JSpan').show();

}


function showSen2(){

    if($('#sen2CSpan').html() != "" || $('#sen2JSpan').html() != ""){

        $("#sen2Icon").show();
        $("#sen2div_right").parent().css('display', 'flex');

        $('#sen2div').show();
    }

}

function overSen2(){

    $('#sen2CSpan').show();
    $('#sen2JSpan').show();

}
