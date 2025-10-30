var document_recivepic = {};
document_recivepic.name = "単語テスト開始";
document_recivepic.paramsFormat = {

	// "testno": null,
};

document_recivepic.fire = function (params) {

	var ret = new Result();

	// セッションチェック
	//if(sessionCheck(ret) == false){return ret};

	//  检索
	var selectResult = db.select(
		"COMMON",
		"selectTempPicFromSmartphone",
		{
		}
	).getArray();

	if(selectResult.length <= 0){
		var script = "openFileSelect();"
		ret.eval(script);
		return ret;
	}

	for(var i = 0;i < selectResult.length;i ++){
		var seq = selectResult[i]["seq"];
		var content = selectResult[i]["content"];
		var suffix = selectResult[i]["suffix"];
		// var content_tb500 = selectResult[i]["content_tb500"];
		// var content_tb200 = selectResult[i]["content_tb200"];
		// var content_tb50  = selectResult[i]["content_tb50"];

		// ユーザー更新
		db.change(
			"COMMON",
			"updateTempPicFromSmartphone",
			{
				userid : getUserId(),
				seq : seq,
			}
		);

		var script = "displayPicFromSmartphone('" + content + "','" + suffix + "');"
		ret.eval(script);

	}

	// 画面へ結果を返す
	return ret;

};