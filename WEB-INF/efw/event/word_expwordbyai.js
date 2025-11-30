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

	ret = makeHtml(ret, book, classification, wordseq, true);

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
	var ai1_content_ch = selectResult[0]["ai1_content_ch"];
	var ai1_content_jp = selectResult[0]["ai1_content_jp"];
	var ai2_content_ch = selectResult[0]["ai2_content_ch"];
	var ai2_content_jp = selectResult[0]["ai2_content_jp"];

	ai1_content_ch.debug("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA");
	ai1_content_jp.debug("JJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJ");

	if(
		(ai1_content_ch != null && ai1_content_ch != "") ||
		(ai1_content_jp != null && ai1_content_jp != "") 
	){

		"CCCCCCCCCCCCCCCCCCCCCCCCC".debug("CCCCCCCCCCCCCCCCCCCCCCCCC");

		session.set("WORD_BOOK", book);
		session.set("WORD_CLASSIFICATION", classification);
		session.set("WORD_WORDSEQ", wordseq);

		ret.eval("opAiContentPage('" + book + "', '" + classification + "', "+ wordseq + ")");

		return ret;
	}

	var threads = new Threads(2);

	if(ai1_content_ch == null || ai1_content_ch == ""){
		// makeHtml(book, classification, wordseq, word_e, "ai1ch");
		threads.add(
			{ 
				index: i, 
				book: book, 
				classification: classification, 
				wordseq: wordseq, 
				word_e: word_e, 
				flg: "ai1ch",
				run: makeWordHtmlByAi 
			}
		);

	}
	if(ai1_content_jp == null || ai1_content_jp == ""){
		threads.add(
			{ 
				index: i, 
				book: book, 
				classification: classification, 
				wordseq: wordseq, 
				word_e: word_e, 
				flg: "ai1jp",
				run: makeWordHtmlByAi 
			}
		);
	}

	threads.run();

	return ret;
	
}

// function makeHtml(book, classification, wordseq, word_e, flg){

// 	var args = new Array();
// 	args[0] = book;
// 	args[1] = classification;
// 	args[2] = wordseq;
// 	args[3] = word_e;
// 	args[4] = flg;

// 	excuteJar("OptDeepSeekTask02",args);

// }