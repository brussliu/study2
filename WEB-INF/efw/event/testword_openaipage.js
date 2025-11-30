var testword_openaipage = {};
testword_openaipage.name = "単語AI説明表示";
testword_openaipage.paramsFormat = {
	"#hiddenBook" : null,
	"#hiddenclassification" : null,
	"#hiddenwordseq" : null,
};

testword_openaipage.fire = function (params) {

	var ret = new Result();

	// セッションチェック
	if(sessionCheck(ret) == false){return ret};

	var book = params["#hiddenBook"];
	var classification = params["#hiddenclassification"];
	var wordseq = params["#hiddenwordseq"];

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

	if(selectResult.length > 0){
		if(
			(selectResult[0]["ai1_content_ch"] != null && selectResult[0]["ai1_content_ch"] != "") ||
			(selectResult[0]["ai1_content_jp"] != null && selectResult[0]["ai1_content_jp"] != "") ||
			(selectResult[0]["ai2_content_ch"] != null && selectResult[0]["ai2_content_ch"] != "") ||
			(selectResult[0]["ai2_content_jp"] != null && selectResult[0]["ai2_content_jp"] != "")
		){
			session.set("WORD_BOOK", book);
			session.set("WORD_CLASSIFICATION", classification);
			session.set("WORD_WORDSEQ", wordseq);
			ret.eval("opAiContentPage('" + book + "', '" + classification + "'," + wordseq + ");");
		}

	}

	
	// 画面へ結果を返す
	return ret;

};
