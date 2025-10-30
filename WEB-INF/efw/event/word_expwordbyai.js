var word_expwordbyai = {};
word_expwordbyai.name = "AIで指定単語を説明する";
word_expwordbyai.paramsFormat = {
	"book" : null,
	"classification" : null,
	"wordseq" : null,
};

word_expwordbyai.fire = function (params) {

	var ret = new Result();

	// セッションチェック
	if(sessionCheck(ret) == false){return ret};

	var book = params["book"];
	var classification = params["classification"];
	var wordseq = params["wordseq"];


	"AAAAAAAAAAAAAAAAAAAAAAAA".debug("AAAAAAAAAAAAAAAAAAAAAAAA");
	ret = makeHtml(ret, book, classification, wordseq, true);
	
	"BBBBBBBBBBBBBBBBBBBBBBBB".debug("BBBBBBBBBBBBBBBBBBBBBBBB");
	// 画面へ結果を返す
	return ret;

};

function makeHtml(ret, book, classification, wordseq, flg){

	//  检索
	var selectResult = db.select(
		"STUDY",
		"selectSingleWord",
		{
			book : book,
			classification : classification,
			wordseq : parseInt(wordseq)
		}
	).getArray();

	var word_e = selectResult[0]["word_e"];
	var ai_html = selectResult[0]["ai_text_ch"];

	"1111111111111111111111111111".debug("111111111111111111111111111111");

	if(ai_html != null && ai_html != ""){

		"99999999999999999999999999999999".debug("99999999999999999999999999999999");
		ret.runat("#word_inputdialog").remove("div").append("<div>" + ai_html + "</div>").withdata(selectResult);
		ret.eval("word_inputdialog.dialog('open');");

		return ret;

	}else{

			if(flg == false){

				return ret;
			}
			"2222222222222222222222222222222".debug("222222222222222222222222222222");
			var key = "OptDeepSeekTask02";
			makeKey(key);

			"3333333333333333333333333333333333".debug("33333333333333333333333333333333");

			var args = new Array();
			args[0] = book;
			args[1] = classification;
			args[2] = wordseq;
			args[3] = word_e;
			args[4] = key;

			"44444444444444444444444444444444".debug("4444444444444444444444444444444");

			excuteJar("OptDeepSeekTask02",args);

			"555555555555555555555555555555555".debug("55555555555555555555555555");

			makeHtml(ret, book, classification, wordseq, false);


			"6666666666666666666666666".debug("66666666666666666666666666");
			// setTimeout(() => {
			// 	makeHtml(ret, book, classification, wordseq, false);
			// }, 10000);


	}
}

