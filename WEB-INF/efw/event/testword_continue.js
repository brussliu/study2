var testword_continue = {};
testword_continue.name = "単語テスト継続";
testword_continue.paramsFormat = {

	"testno": null,

};

testword_continue.fire = function (params) {

	var ret = new Result();

	// セッションチェック
	if(sessionCheck(ret) == false){return ret};

	// タイトル情報設定
	setTitleInfo(ret);

	var testno = params["testno"];


	//  检索
	var selectResult1 = db.select(
		"STUDY",
		"selectMinTestSubNo",
		{
			testno : testno,
		}
	).getSingle();

	var minSubTestNo = selectResult1["minsubtestno"];

	session.set("TEST_NO", testno);
	session.set("TEST_SUB_NO", minSubTestNo);

	//  检索
	var selectResult2 = db.select(
		"STUDY",
		"selectTestInfo",
		{
			testno : testno,
		}
	).getSingle();

	var kind = selectResult2["kind"];

	if(kind == "D.英訳中"){
		ret.eval("continueTestPopup('testword_test_d.jsp');");
	}else if(kind == "E.文章練習"){
		ret.eval("continueTestPopup('testword_test_e.jsp');");
	}else{
		ret.eval("continueTestPopup('testword_test.jsp');");
	}

	//ret.eval("continueTestPopup('" + selectResult2["div3"] + "');"); 
	
	// 画面へ結果を返す
	return ret;

};
