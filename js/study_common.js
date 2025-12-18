// 初期化
function init() {
    Efw('testword_test');
}

function overTest(){
    alert("テスト完了しました！");
    window.close();

    if (window.opener && !window.opener.closed) {
        window.opener.location.reload();
    }

}

function goBack(){
    $('#hiddenOpt').val("back");
    Efw('testword_updatedetail4');
}

function goNext(){
    $('#hiddenOpt').val("next");
    Efw('testword_updatedetail4');
}


///////////////////////////////////////////////////////////////////////////////////////////////

function playRightVoice(){

    // 音声ファイルの存在チェック
    var currentURL = window.location.href;

    var currentURL = currentURL.substring(0, currentURL.lastIndexOf("/"));

    var pathUrl = "/mp3/" + $("#hiddenBook").val() + "/" + $("#hiddenclassification").val() + "/";

    var fileName0 = $("#hiddenwordseq").val() + "-word-0.mp3";
    var fileName1 = $("#hiddenwordseq").val() + "-word-1.mp3"; 


    if (checkFileExists(currentURL + pathUrl + fileName0)) {
        
        var audioElement = document.createElement('audio');
        audioElement.setAttribute('src', '.' + pathUrl + fileName0);
        audioElement.setAttribute('autoplay', 'autoplay');

    }else if(checkFileExists(currentURL + pathUrl + fileName1)) {

        var audioElement = document.createElement('audio');
        audioElement.setAttribute('src', '.' + pathUrl + fileName1);
        audioElement.setAttribute('autoplay', 'autoplay');

    }else{

        var content = $("#hiddenWordE").val();

        let word = content;
        let u = new SpeechSynthesisUtterance();
        u.lang = 'en-US';
        u.text = word;
        speechSynthesis.speak(u);

    }

}

function playVoice(no,flg){

    // var kbn = $("#hiddenWay2").val();

    // 0.全訳英
    // 1.日訳英(音声付き)
    // 2.日訳英(音声無し)
    // 3.音声のみ
    // 4.漢訳英(音声付き)
    // 5.漢訳英(音声無し)

    // 中国語表示
    // if(kbn == 2 || kbn == 5){
    
    //     wrongVoice();
    //     return;
    // }

    if(flg == 0){
        pronounceA(no);
    }else if(flg == 1){
        // アメリカ発音
        pronounceB(no, 0, true);
    }else if(flg == 2){
        // イギリス発音
        pronounceB(no, 1, true);
    }

}

function wrongVoice() {
    var audioElement = document.createElement('audio');
    audioElement.setAttribute('src', './mp3/wrong.mp3');
    audioElement.setAttribute('autoplay', 'autoplay');
}

function keyboardVoice() {
    var audioElement = document.createElement('audio');
    audioElement.setAttribute('src', './mp3/keyboard.mp3');
    audioElement.setAttribute('autoplay', 'autoplay');
}

function pronounceA(no) {

    var content = "";
    if(no == 1){
        content = $("#hiddenWordE").val();
    }
    if(no == 2){
        content = $("#hiddenSen1E").val();
    }
    if(no == 3){
        content = $("#hiddenSen2E").val();
    }

    let word = content;
    let u = new SpeechSynthesisUtterance();
    u.lang = 'en-US';
    u.text = word;
    speechSynthesis.speak(u);

}

function pronounceB(no, type, flg) {

    // 音声ファイルの存在チェック
    // var currentURL = window.location.href;

    // var currentURL = currentURL.substring(0, currentURL.lastIndexOf("/"));

    var pathUrl = "./wordmp3/" + $("#hiddenBook").val() + "/" + $("#hiddenclassification").val() + "/";

    var fileName = "";
    if(no == 1){
        fileName = $("#hiddenwordseq").val() + "-word-" + type + ".mp3"; 
    }else if(no == 2){
        fileName = $("#hiddenwordseq").val() + "-sen1-" + type + ".mp3"; 
    }else if(no == 3){
        fileName = $("#hiddenwordseq").val() + "-sen2-" + type + ".mp3"; 
    }

    // if (checkFileExists(currentURL + pathUrl + fileName)) {
        
        var audioElement = document.createElement('audio');
        audioElement.setAttribute('src', pathUrl + fileName);
        audioElement.setAttribute('autoplay', 'autoplay');

    // } else if( flg == true) {

    //     console.log('File does not exist.');
    //     Efw('testword_downloadvoice',{type : type});
    //     setTimeout(function(){
    //         pronounceB(no, type, false);
    //     }, 6000);

    // }

    
}

function checkFileExists(url) {
    var xhr = new XMLHttpRequest();
    xhr.open('HEAD', url, false);
    xhr.send();
    return xhr.status === 200;
}
function rightVoice1() {
    var audioElement = document.createElement('audio');
    audioElement.setAttribute('src', './mp3/right1.mp3');
    audioElement.setAttribute('autoplay', 'autoplay');
}
function rightVoice2() {
    var audioElement = document.createElement('audio');
    audioElement.setAttribute('src', './mp3/right2.mp3');
    audioElement.setAttribute('autoplay', 'autoplay');
}