var  ai_AnswerAdd = {};
 ai_AnswerAdd.name = "Ai回答保存";
 ai_AnswerAdd.paramsFormat = {
	 memoDataObj : null,
};

 ai_AnswerAdd.fire = function (params) {

	var ret = new Result();

	// セッションチェック
	if(sessionCheck(ret) == false){return ret};

	var memoDataObj = params["memoDataObj"];

	 memoDataObj.debug('--')
	var selectResult2 = db.change(
		"AILSSUES",
		"updateMemo",
		{
			no:memoDataObj['no'],
			memo1:memoDataObj['1'],
			memo2:memoDataObj['2'],
			memo3:memoDataObj['3'],
			memo4:memoDataObj['4'],
			memo5:memoDataObj['5'],
			state:"回答済"
		}
	);

	ret.navigate("ai_Issues.jsp");
	// 画面へ結果を返す
	return ret;

};

