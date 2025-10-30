var test_selectdoc = {};
test_selectdoc.name = "資料情報検索";
test_selectdoc.paramsFormat = {
	"docArr" : null,
	"#doc_pic_position" : null,
	"#doc_no_position" : null,
};

test_selectdoc.fire = function (params) {

	var ret = new Result();

	// セッションチェック
	if(sessionCheck(ret) == false){return ret};

	var docArr = params["docArr"];

	var doc_pic_position = params["#doc_pic_position"];
	var doc_no_position = params["#doc_no_position"];

	var docNoStr = "";
	for(var i = 0;i < docArr.length;i ++){
	
		if(i == docArr.length - 1){
			docNoStr += "'" + docArr[i] + "'"
		}else{
			docNoStr += "'" + docArr[i] + "',";
		}
	
	}
	ret.eval("setDocNo('" + doc_no_position + "'," + docNoStr + ");");

	//  检索
	var selectResult = db.select(
		"DOCUMENT",
		"searchDocumentDetailInfo",
		{
			docnolist : docNoStr
		}
	).getArray();

	ret.runat("#test_inputdialog " + doc_pic_position).remove("img").remove("input");

	for(var i = 0; i < selectResult.length; i++){

		var record = new Record([selectResult[i]]).getArray();

		var suffix = selectResult[i]["suffix"];
		var resultHTML = "";

		if(isPic(suffix)){
			resultHTML = "<img src='{content_tb200}' class='selectedimg'>";
		}else{
			resultHTML = "<img src='img/" + suffix + ".png' class='selectedfile'>";
		}

		ret.runat("#test_inputdialog " + doc_pic_position).append(resultHTML).withdata(record);
		
	}

	var script = "changeAddIcon('" + doc_pic_position + "')";
	ret.eval(script);


	// 画面へ結果を返す
	return ret.eval("test_selectdoc_inputdialog.dialog('close');");

};