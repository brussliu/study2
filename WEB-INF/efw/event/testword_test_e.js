var testword_test_e = {};
testword_test_e.name = "単語テスト開始";
testword_test_e.paramsFormat = {


};

testword_test_e.fire = function (params) {

	var ret = new Result();

	// セッションチェック
	if(sessionCheck(ret) == false){return ret};

	var test_no = session.get("TEST_NO");
	var test_sub_no = session.get("TEST_SUB_NO");


	//  检索
	var selectResult = db.select(
		"STUDY",
		"selectTestInfo",
		{
			testno: test_no
		}
	).getSingle();

	var selectDetailResult = db.select(
		"STUDY",
		"selectTestDetailInfo",
		{
			testno: test_no,
			testsubno: test_sub_no
		}
	).getSingle();

	var type = selectResult["type"];
	var kind = selectResult["kind"];
	var level = selectResult["level"];

	ret.runat("body").withdata(
		{

			"#hiddenBook" : selectDetailResult["book"],
			"#hiddenclassification" : selectDetailResult["classification"],
			"#hiddenwordseq" : selectDetailResult["wordseq"],

			"#hiddenTestNo" : test_no,
			"#hiddenWordNo" : test_sub_no,
			"#hiddenWordCount" : selectResult["ct"],

			"#hiddenWordWrongTime" : null,
			"#hiddenSen1WrongTime" : null,
			"#hiddenSen2WrongTime" : null,

			"#hiddenWordE" : selectDetailResult["word_e"],
			"#hiddenWordJ" : selectDetailResult["word_j"],
			"#hiddenWordC" : selectDetailResult["word_c"],

			"#hiddenType" : type,
			"#hiddenKind" : kind,
			"#hiddenLevel" : level,
			
		}
	);

	var script = "beginTest();";
	ret.eval(script);


	// 開始時間を残す
	session.set("TEST_SUB_NO_STARTTIME", (new Date()).getTime());

	// 画面へ結果を返す
	return ret;

};
