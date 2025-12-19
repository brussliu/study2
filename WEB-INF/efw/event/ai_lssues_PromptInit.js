var ai_lssues_PromptInit = {};
ai_lssues_PromptInit.name = "AI生成";
ai_lssues_PromptInit.paramsFormat = {
	"obj":null,
	"type":null,
	"summary":null
};

ai_lssues_PromptInit.fire = function (params) {

	var ret = new Result();

	// セッションチェック
	if(sessionCheck(ret) == false){return ret};
	var obj =params["obj"];


	if(obj == "type"){
		var type =params["type"];
		//  检索プロンプト概要
		var selectResult1 = db.select(
			"AILSSUES",
			"searchSummary",
			{type : type}
		).getArray();

		var resultHTML = "<option class='dbvalue' value='{summary}'>{summary}</option>";
		var resultHTML2 = "<option  value='' selected ></option>";

		ret.runat("#opt_summary2").remove(".dbvalue").append(resultHTML).withdata(selectResult1);

		ret.eval("aiPrompt('summary');")
	}else if(obj == "summary"){
		var type =params["type"];
		var summary =params["summary"];

		//  检索プロンプト詳細&戻る値種類
		var selectResult2 = db.select(
			"AILSSUES",
			"searchDetailedAndCategory",
			{type : type,summary : summary}
		).getSingle();

		ret.eval( " $('#text_detailed2').val('"+selectResult2["detailed"]+"')");
		ret.eval( " $('#opt_category2').val('"+selectResult2["category"]+"')");

	}else{
		//  检索類型
		var selectResult3 = db.select(
			"AILSSUES",
			"searchType",
			{}
		).getArray();

		var resultHTML = "<option class='dbvalue' value='{type}'>{type}</option>";

		ret.runat("#opt_type2").remove(".dbvalue").append(resultHTML).withdata(selectResult3);



	}



	// 画面へ結果を返す
	return ret;

};
