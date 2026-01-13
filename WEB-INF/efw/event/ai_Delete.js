var ai_Delete = {};
ai_Delete.name = "AI删除";
ai_Delete.paramsFormat = {
	selectedValues : null,
};

ai_Delete.fire = function (params) {

	var ret = new Result();

	// セッションチェック
	if(sessionCheck(ret) == false){return ret};

	var selectedValues = params["selectedValues"];

	for (var i = 0; i<selectedValues.length;i++){

		var Results = db.change(
			"AILSSUES",
			"deleteAiAnswer",
			{
				no:selectedValues[i]
			}
		);
	}
	ret.navigate("ai_Issues.jsp");
	// 画面へ結果を返す
	return ret;

};
