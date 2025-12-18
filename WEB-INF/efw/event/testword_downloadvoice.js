var testword_downloadvoice = {};
testword_downloadvoice.name = "単語テスト開始";
testword_downloadvoice.paramsFormat = {

	"#hiddenBook": null,
	"#hiddenclassification": null,
	"#hiddenwordseq": null,

	"#hiddenWordE": null,
	"#hiddenWordJ": null,
	"#hiddenWordC": null,
	"#hiddenSen1E": null,
	"#hiddenSen1J": null,
	"#hiddenSen1C": null,
	"#hiddenSen2E": null,
	"#hiddenSen2J": null,
	"#hiddenSen2C": null,
	"type": null
};

testword_downloadvoice.fire = function (params) {

	var ret = new Result();

	// セッションチェック
	if(sessionCheck(ret) == false){return ret};

	var book = params["#hiddenBook"];
	var classification = params["#hiddenclassification"];
	var wordseq = params["#hiddenwordseq"];

	var type = params["type"];

	var word_e = params["#hiddenWordE"].replaceAll(" ", "%20").replaceAll("'", "%27").replaceAll("～", "~");
	var sen1_e = params["#hiddenSen1E"].replaceAll(" ", "%20").replaceAll("'", "%27").replaceAll("～", "~");
	var sen2_e = params["#hiddenSen2E"].replaceAll(" ", "%20").replaceAll("'", "%27").replaceAll("～", "~");


	//var path = "D://apache-tomcat-9.0.30/webapps/study/mp3/" + book + "/" + classification + "/";
	var path = "/usr/local/tomcat/webapps/study2/wordmp3/" + book + "/" + classification + "/";

	if (!absfile.exists(path)){
		absfile.makeDir(path);
	}
	var mp3_path = "/usr/local/tomcat/webapps/study2/wordmp3/";
	if(word_e != null && word_e != ''){

		var args = new Array();

		args[0] = mp3_path;
		args[1] = book;
		args[2] = classification;
		args[3] = wordseq;
		args[4] = word_e;
		args[5] = "word";

		excuteJar("OptEnglishVoice",args);
		// cmd.execute(
		// 	["java","-classpath", "/usr/local/tomcat/webapps/study/java/", "start",
		// 		"\\usr\\local\\tomcat\\webapps\\study\\mp3", book, classification, wordseq, "word",type,word_e]);
	}
	if(sen1_e != null && sen1_e != ''){

		var args = new Array();

		args[0] = mp3_path;
		args[1] = book;
		args[2] = classification;
		args[3] = wordseq;
		args[4] = sen1_e;
		args[5] = "sen1";

		excuteJar("OptEnglishVoice",args);
		// cmd.execute(
		// 	["java","-classpath", "/usr/local/tomcat/webapps/study/java/", "start",
		// 		"\\usr\\local\\tomcat\\webapps\\study\\mp3", book, classification, wordseq, "sen1",type,sen1_e]);

	}
	if(sen2_e != null && sen2_e != ''){

		var args = new Array();

		args[0] = mp3_path;
		args[1] = book;
		args[2] = classification;
		args[3] = wordseq;
		args[4] = sen2_e;
		args[5] = "sen2";

		excuteJar("OptEnglishVoice",args);
		// cmd.execute(
		// 	["java","-classpath", "/usr/local/tomcat/webapps/study/java/", "start",
		// 		"\\usr\\local\\tomcat\\webapps\\study\\mp3", book, classification, wordseq, "sen2",type,sen2_e]);


	}

	// ret.runat("body").withdata(
	// 	{
	// 		"#hiddenMp3" : "got"
			
	// 	}
	// )
	// 画面へ結果を返す
	return ret;

};
