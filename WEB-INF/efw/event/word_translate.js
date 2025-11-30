var word_translate = {};
word_translate.name = "単語テスト開始";
word_translate.paramsFormat = {
	"#opt_book" : null,
	"#opt_classification" : null,
};

word_translate.fire = function (params) {

	var ret = new Result();

	var threadCount = 6;

	// セッションチェック
	if(sessionCheck(ret) == false){return ret};

	var book = params["#opt_book"];
	var classification = params["#opt_classification"];

	//  检索
	var selectResult = db.select(
		"STUDY",
		"selectWord",
		{
			book : book,
			dayfrom : classification,
			dayto : classification
		}
	).getArray();

	// 単語テスト詳細情報
	for(var i = 0;i < selectResult.length;i++){

		threads = new Threads(threadCount);

		var book = selectResult[i]["book"];
		var classification = selectResult[i]["classification"];
		var wordseq = selectResult[i]["wordseq"];

		var word_e = selectResult[i]["word_e"];
		var sen1_e = selectResult[i]["sen1_e"];
		var sen2_e = selectResult[i]["sen2_e"];
	
		var word_c = selectResult[i]["word_c"];
		var sen1_c = selectResult[i]["sen1_c"];
		var sen2_c = selectResult[i]["sen2_c"];

		var word_j = selectResult[i]["word_j"];
		var sen1_j = selectResult[i]["sen1_j"];
		var sen2_j = selectResult[i]["sen2_j"];

		if((word_j == null || word_j == "") && word_e != null && word_e != ""){

			threads.add(
				{ 
					index: i, 
					book: book, classification: classification, wordseq: wordseq, content: word_e, 
					api: "ExcelAPI",
					div: "word",
					opt: "ja",
					run: getExplain 
				}
			);

		}

		if((word_c == null || word_c == "") && word_e != null && word_e != ""){

			threads.add(
				{ 
					index: i, 
					book: book, classification: classification, wordseq: wordseq, content: word_e, 
					api: "youdaoAPI",
					div: "word",
					opt: "ch",
					run: getExplain 
				}
			);

		}

		if((sen1_j == null || sen1_j == "") && sen1_e != null && sen1_e != ""){

			threads.add(
				{ 
					index: i, 
					book: book, classification: classification, wordseq: wordseq, content: sen1_e, 
					api: "DeepLAPI",
					div: "sen1",
					opt: "ja",
					run: getExplain 
				}
			);

		}

		if((sen1_c == null || sen1_c == "") && sen1_e != null && sen1_e != ""){

			threads.add(
				{ 
					index: i, 
					book: book, classification: classification, wordseq: wordseq, content: sen1_e, 
					api: "googleAPI",
					div: "sen1",
					opt: "ch",
					run: getExplain 
				}
			);

		}

		if((sen2_j == null || sen2_j == "") && sen2_e != null && sen2_e != ""){

			threads.add(
				{ 
					index: i, 
					book: book, classification: classification, wordseq: wordseq, content: sen2_e, 
					api: "DeepLAPI",
					div: "sen2",
					opt: "ja",
					run: getExplain 
				}
			);

		}

		if((sen2_c == null || sen2_c == "") && sen2_e != null && sen2_e != ""){

			threads.add(
				{ 
					index: i, 
					book: book, classification: classification, wordseq: wordseq, content: sen2_e, 
					api: "googleAPI",
					div: "sen2",
					opt: "ch",
					run: getExplain 
				}
			);

		}

		threads.run();
	}

	ret.eval("searchWord();");
	// 画面へ結果を返す
	return ret;

};

function getExplain(){

	var args = new Array();

	args[0] = this.api;
	args[1] = this.book;
	args[2] = this.classification;
	args[3] = this.wordseq;
	args[4] = this.content;
	args[5] = this.div;

	if(this.opt == "ch"){
		excuteJar("OptExplainENtoCH",args);
	}
	if(this.opt == "ja"){
		excuteJar("OptExplainENtoJP",args);
	}

}

