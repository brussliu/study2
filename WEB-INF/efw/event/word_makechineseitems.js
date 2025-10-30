var word_makechineseitems = {};
word_makechineseitems.name = "英訳中データ作成";
word_makechineseitems.paramsFormat = {
	"#opt_book" : null,
	"#opt_classification" : null,
};

word_makechineseitems.fire = function (params) {

	var ret = new Result();

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

	var threads = new Threads(10);
	// threads.add({ index: 0, successed: false, run: operate });
	// threads.add({ index: 1, successed: false, run: operate });
	// threads.add({ index: 2, successed: false, run: operate });
	// threads.add({ index: 3, successed: false, run: operate });
	// threads.add({ index: 4, successed: false, run: operate });



	// 単語テスト詳細情報
	for(var i = 0;i < selectResult.length;i++){

		var book = selectResult[i]["book"];
		var classification = selectResult[i]["classification"];
		var wordseq = selectResult[i]["wordseq"];

		var word_e = selectResult[i]["word_e"];

		if((i+1) % 10 == 10){
			threads.run();

			threads = new Threads(10);
		}

		threads.add(
			{ 
				index: i, successed: false, 
				book: book, classification: classification, wordseq: wordseq, word_e: word_e, 
				run: operate 
			}
		);

	}

	threads.run();

	ret.eval("searchWord();");
	
	// 画面へ結果を返す
	return ret;

};


function operate() {

	if(this.word_e != null && this.word_e != ""){

		var args = new Array();

		args[0] = this.book;
		args[1] = this.classification;
		args[2] = this.wordseq;
		args[3] = this.word_e;
		excuteJar("OptDeepSeekTask01",args);
	}

	this.successed = true;
}