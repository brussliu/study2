var testword_initclassification = {};
testword_initclassification.name = "単語テスト開始";
testword_initclassification.paramsFormat = {

	"book": null,
	"classification": null,
};

testword_initclassification.fire = function (params) {

	var ret = new Result();

	// セッションチェック
	if(sessionCheck(ret) == false){return ret};

	//  检索
	var selectResult = db.select(
		"STUDY",
		"searchClassification",
		{ 
			book: params["book"]
		}
	).getArray();

	var resultHTML = "<option class='dbvalue' value='{classification}'>{classification}</option>";

	ret.runat(params["classification"]).remove(".dbvalue").append(resultHTML).withdata(selectResult);


	// 画面へ結果を返す
	return ret;

};

