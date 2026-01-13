var  ai_AnswerAdd = {};
ai_AnswerAdd.name = "Ai回答保存";
ai_AnswerAdd.paramsFormat = {
	"#no": null,
	"#text_aireply1": null,
	"#text_aireply2": null,
	"#text_aireply3": null,
	"#text_aireply4": null,
	"#text_aireply5": null,
};

ai_AnswerAdd.fire = function (params) {

	var ret = new Result();

	// セッションチェック
	if(sessionCheck(ret) == false){return ret};

	var no = params["#no"];

	var memo1 = params["#text_aireply1"];
	var memo2 = params["#text_aireply2"];
	var memo3 = params["#text_aireply3"];
	var memo4 = params["#text_aireply4"];
	var memo5 = params["#text_aireply5"];

	db.change(
		"AILSSUES",
		"updateMemo",
		{
			no : no,
			memo1 : memo1,
			memo2 : memo2,
			memo3 : memo3,
			memo4 : memo4,
			memo5 : memo5,
			state:"回答済"
		}
	);

	ret.eval("window.close();");
	// 画面へ結果を返す
	return ret;

};

