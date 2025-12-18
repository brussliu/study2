var aiBatch04={};
aiBatch04.paramsFormat={
};
aiBatch04.fire=function(params){

	var ret = new Batch();
	ret.echo("開始 "+new Date().format("yyyy/MM/dd HH:mm:ss"));

	var limitCount = 50;
	var threadCount = 4;

	//  检索
	var selectResult = db.select(
		"STUDY",
		"selectWordsToAi03",
		{
			limit : limitCount
		}
	).getArray();

	for(var i = 0;i < selectResult.length;i ++){

		var threads = new Threads(threadCount);

		var book = selectResult[i]["book"];
		var classification = selectResult[i]["classification"];
		var wordseq = selectResult[i]["wordseq"];
		var sentence = selectResult[i]["word_e"];

		var ai1_ch_html = selectResult[i]["ai1_content_ch"];
		var ai1_jp_html = selectResult[i]["ai1_content_jp"];
		var ai2_ch_html = selectResult[i]["ai2_content_ch"];
		var ai2_jp_html = selectResult[i]["ai2_content_jp"];

		if(ai1_ch_html == null || ai1_ch_html == ""){
			threads.add(
				{ 
					index: i, 
					book: book, classification: classification, wordseq: wordseq, sentence: sentence, 
					api: "deepseek",
					flg: "ai1ch",
					run: makeSentenceHtmlByAi 
				}
			);

		}

		if(ai1_jp_html == null || ai1_jp_html == ""){
			threads.add(
				{ 
					index: i, 
					book: book, classification: classification, wordseq: wordseq, sentence: sentence, 
					api: "deepseek",
					flg: "ai1jp",
					run: makeSentenceHtmlByAi 
				}
			);
		}

		if(ai2_ch_html == null || ai2_ch_html == ""){
			threads.add(
				{ 
					index: i, 
					book: book, classification: classification, wordseq: wordseq, sentence: sentence, 
					api: "doubao",
					flg: "ai2ch",
					run: makeSentenceHtmlByAi 
				}
			);
		}

		if(ai2_jp_html == null || ai2_jp_html == ""){
			threads.add(
				{ 
					index: i, 
					book: book, classification: classification, wordseq: wordseq, sentence: sentence, 
					api: "doubao",
					flg: "ai2jp",
					run: makeSentenceHtmlByAi 
				}
			);
		}

		threads.run();
	}

	

	ret.echo("完了 "+new Date().format("yyyy/MM/dd HH:mm:ss"));

	return ret;
};

function makeSentenceHtmlByAi(){

	var args = new Array();
	args[0] = this.api;
	args[1] = this.book;
	args[2] = this.classification;
	args[3] = this.wordseq;
	args[4] = this.sentence;
	args[5] = this.flg;

	excuteJar("OptTask03",args);

}
