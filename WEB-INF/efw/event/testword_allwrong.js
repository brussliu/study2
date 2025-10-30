var testword_allwrong = {};
testword_allwrong.name = "全て誤り単語テスト";
testword_allwrong.paramsFormat = {


};

testword_allwrong.fire = function (params) {

	var ret = new Result();

	// セッションチェック
	if(sessionCheck(ret) == false){return ret};

	// タイトル情報設定
	setTitleInfo(ret);

	//  检索
	var selectResult = db.select(
		"STUDY",
		"selectAllWrongWord",
		{
		}
	).getArray();

	if(selectResult.length <= 0){
		ret.eval("alert('誤り単語がないので、再テストできません！');");
		return ret;
	}

	// テスト番号


	var book = "";
	var testno = "";
	var kind = "";
	var level = "";

	var new_book = "";
	var new_testno = "";
	var new_kind = "";
	var new_level = "";

	var now = new Date();

	var n = null;
	var new_n = null;

	// 単語テスト詳細情報
	for(var i = 0;i < selectResult.length;i++){

		new_book = selectResult[i]["book"];
		new_kind = selectResult[i]["kind"];
		new_level = selectResult[i]["level"];

		if(book != new_book || kind != new_kind || level != new_level){

			n = new_n;
			new_n = 1;
			if(new_testno == ""){
				new_testno = now.format('yyyyMMdd-HHmmss');


			}else{

				now.setSeconds(now.getSeconds() + 1);
				new_testno = now.format('yyyyMMdd-HHmmss');
			}

		}



		db.change(
			"STUDY",
			"insertTestDetailInfo",
			{
				testno : new_testno,
				subno : new_n,
				book : new_book,
				classification : selectResult[i]["classification"],
				wordseq : selectResult[i]["wordseq"],
				userid : getUserId()
			}
		);

		if((book != new_book || kind != new_kind || level != new_level) && i > 0){
			// 単語テスト情報
			db.change(
				"STUDY",
				"insertTestInfo",
				{
					testno : testno,
					book : book,
					classification : "===ALL===",
					type : "勉強中単語",
					kind : kind,
					level : level,
					count : n - 1,
					userid : getUserId()
				}
			);

		}

		new_n = new_n + 1;
		book = new_book;
		testno = new_testno;
		kind = new_kind;
		level = new_level;
	}

	db.change(
		"STUDY",
		"insertTestInfo",
		{
			testno : testno,
			book : book,
			classification : "===ALL===",
			type : "勉強中単語",
			kind : kind,
			level : level,
			count : new_n - 1,
			userid : getUserId()
		}
	);


	// 画面へ結果を返す
	return ret.navigate("testword.jsp");

};