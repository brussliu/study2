var ai_Answer = {};
ai_Answer.name = "Ai回答";
ai_Answer.paramsFormat = {
	selectedValues : null,
};

ai_Answer.fire = function (params) {

	var ret = new Result();

	// セッションチェック
	if(sessionCheck(ret) == false){return ret};

	var no = params["selectedValues"];


	var selectResult2 = db.select(
		"AILSSUES",
		"searchAnswerListForNO",
		{
			no:no
		}
	).getSingle();
	ret.eval( "switchContentElement('"+selectResult2["category"]+"',`"+selectResult2["answer"]+"`)");
  ret.eval("renderMemoComponents('"+selectResult2["memo1"]+"','"+selectResult2["memo2"]+"','"+selectResult2["memo3"]+"','"
	  +selectResult2["memo4"]+"','"+selectResult2["memo5"]+"','"+selectResult2["state"]+"')");

	ret.eval( " $('#td_no').text('"+selectResult2["no"]+"')");

	// 画面へ結果を返す
	return ret;

};

