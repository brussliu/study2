var word_downloadvoice = {};
word_downloadvoice.name = "単語テスト開始";
word_downloadvoice.paramsFormat = {
	"#opt_book" : null,
	"#opt_classification" : null,
};

word_downloadvoice.fire = function (params) {

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


	//var mp3_path = "D:/apache-tomcat-9.0.30/webapps/study/mp3/";
	var mp3_path = "/usr/local/tomcat/webapps/study2/wordmp3/";

	// 単語テスト詳細情報
	for(var i = 0;i < selectResult.length;i++){
		
		var threads = new Threads(threadCount);

		// if((i+1) % threadCount == threadCount){
		// 	threads.run();
		// 	threads = new Threads(threadCount);
		// }

		var book = selectResult[i]["book"];
		var classification = selectResult[i]["classification"];
		var wordseq = selectResult[i]["wordseq"];

		var word_e = selectResult[i]["word_e"];
		var sen1_e = selectResult[i]["sen1_e"];
		var sen2_e = selectResult[i]["sen2_e"];

		// var word_e = selectResult[i]["word_e"] == null ? "" : selectResult[i]["word_e"].replaceAll(" ", "%20").replaceAll("'", "%27").replaceAll("～", "~");
		// var sen1_e = selectResult[i]["sen1_e"] == null ? "" : selectResult[i]["sen1_e"].replaceAll(" ", "%20").replaceAll("'", "%27").replaceAll("～", "~");
		// var sen2_e = selectResult[i]["sen2_e"] == null ? "" : selectResult[i]["sen2_e"].replaceAll(" ", "%20").replaceAll("'", "%27").replaceAll("～", "~");
	
		//var path = "D://apache-tomcat-9.0.30/webapps/study/mp3/" + book + "/" + classification + "/";
		var path = mp3_path + book + "/" + classification + "/";

		//////////////////////////////////////////////////////////////////////////////////////////
		if(word_e != null && word_e != ''){
			var name0 = wordseq + "-word-0.mp3";
			if (!absfile.exists(path + name0)){
				threads.add(
					{ 
						index: i, 
						api: "googleAPI",
						mp3_path: mp3_path,
						book: book, classification: classification, wordseq: wordseq, content: word_e, 
						flg: "word",
						type: "0",
						run: downloadVoice 
					}
				);
			}
			var name1 = wordseq + "-word-1.mp3";
			if (!absfile.exists(path + name1)){
				threads.add(
					{ 
						index: i, 
						api: "googleAPI",
						mp3_path: mp3_path,
						book: book, classification: classification, wordseq: wordseq, content: word_e, 
						flg: "word",
						type: "1",
						run: downloadVoice 
					}
				);
			}
		}
		
		//////////////////////////////////////////////////////////////////////////////////////////
		if(sen1_e != null && sen1_e != ''){
			var name0 = wordseq + "-sen1-0.mp3";
			if (!absfile.exists(path + name0)){
				threads.add(
					{ 
						index: i, 
						api: "googleAPI",
						mp3_path: mp3_path,
						book: book, classification: classification, wordseq: wordseq, content: sen1_e, 
						flg: "sen1",
						type: "0",
						run: downloadVoice 
					}
				);
			}
			var name1 = wordseq + "-sen1-1.mp3";
			if (!absfile.exists(path + name1)){
				threads.add(
					{ 
						index: i, 
						api: "googleAPI",
						mp3_path: mp3_path,
						book: book, classification: classification, wordseq: wordseq, content: sen1_e, 
						flg: "sen1",
						type: "1",
						run: downloadVoice 
					}
				);
			}
		}
		//////////////////////////////////////////////////////////////////////////////////////////
		if(sen2_e != null && sen2_e != ''){
			var name0 = wordseq + "-sen2-0.mp3";
			if (!absfile.exists(path + name0)){
				threads.add(
					{ 
						index: i, 
						api: "googleAPI",
						mp3_path: mp3_path,
						book: book, classification: classification, wordseq: wordseq, content: sen2_e, 
						flg: "sen2",
						type: "0",
						run: downloadVoice 
					}
				);
			}
			var name1 = wordseq + "-sen2-1.mp3";
			if (!absfile.exists(path + name1)){
				threads.add(
					{ 
						index: i, 
						api: "googleAPI",
						mp3_path: mp3_path,
						book: book, classification: classification, wordseq: wordseq, content: sen2_e, 
						flg: "sen2",
						type: "1",
						run: downloadVoice 
					}
				);
			}
		}
		//////////////////////////////////////////////////////////////////////////////////////////

		threads.run();

	}

	// 画面へ結果を返す
	return ret;

};


function downloadVoice(){

	var args = new Array();

	args[0] = this.api;
	args[1] = this.mp3_path;
	args[2] = this.book;
	args[3] = this.classification;
	args[4] = this.wordseq;
	args[5] = this.content;
	args[6] = this.flg;
	args[7] = this.type;

	excuteJar("OptVoiceEN",args);

}


