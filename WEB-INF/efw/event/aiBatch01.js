var aiBatch01={};
aiBatch01.paramsFormat={
};
aiBatch01.fire=function(params){

	var ret = new Batch();
	ret.echo("開始 "+new Date().format("yyyy/MM/dd HH:mm:ss"));

	var limitCount = 50;
	var threadCount = 2;

	//  检索
	var selectResult = db.select(
		"STUDY",
		"selectWordsToAi01",
		{
			limit : limitCount
		}
	).getArray();

	for(var i = 0;i < selectResult.length;i ++){

		var threads = new Threads(threadCount);

		var book = selectResult[i]["book"];
		var classification = selectResult[i]["classification"];
		var wordseq = selectResult[i]["wordseq"];
		var word_e = selectResult[i]["word_e"];

		threads.add(
			{ 
				index: i * 2, 
				book: book, classification: classification, wordseq: wordseq, word_e: word_e, 
				api: "deepseek",
				flg: "ch",
				run: makeWordHtmlByAi01
			}
		);

		threads.add(
			{ 
				index: i * 2 + 1, 
				book: book, classification: classification, wordseq: wordseq, word_e: word_e, 
				api: "deepseek",
				flg: "jp",
				run: makeWordHtmlByAi01 
			}
		);

		threads.run();
	}

	ret.echo("完了 "+new Date().format("yyyy/MM/dd HH:mm:ss"));

	return ret;
};

function makeWordHtmlByAi01(){

	var args = new Array();
	args[0] = this.api;
	args[1] = this.book;
	args[2] = this.classification;
	args[3] = this.wordseq;
	args[4] = this.word_e;
	args[5] = this.flg;

	excuteJar("OptTask01",args);

}
