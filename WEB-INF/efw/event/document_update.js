var document_update = {};
document_update.name = "資料情報更新";
document_update.paramsFormat = {

	"doc_no" : null,
};

document_update.fire = function (params) {

	var ret = new Result();

	// セッションチェック
	if(sessionCheck(ret) == false){return ret};

	//  检索
	var selectResult = db.select(
		"DOCUMENT",
		"searchDocumentInfo",
		{
			doc_no : params["doc_no"],
		}
	).getSingle();

	ret.runat("#document_inputdialog").withdata(
		{
			// ステータス
			"#status" : 			selectResult["status"],
			// 有効期限
			"#expiration_date" :	selectResult["doc_vp"],
			// // 大分類
			// "#div1":				selectResult["div1"],
			// // 中分類
			// "#div2":				selectResult["div2"],
			// // 小分類
			// "#div3":				selectResult["div3"],
			// // 細分類
			// "#div4":				selectResult["div4"],
			// コメント
			//"#comment":				selectResult["comment"],
			"#document_no":			selectResult["doc_no"],
		}
	);
	ret.eval("$('#document_inputdialog #comment').html('" + selectResult["comment"] + "');");


	var resultHTML = "<option class='dbvalue' value='{value}'>{text}</option>";

	var selectResult1 = db.select( 
		"DOCUMENT",
		"searchDocumentDiv1",
			{
			}
	).getArray();
	ret.runat("#document_inputdialog #opt_div1_dialog").remove(".dbvalue").append(resultHTML).withdata(selectResult1);
	ret.eval("$('#opt_div1_dialog').val('" + selectResult["div1"] + "');");

	var selectResult2 = db.select( 
		"DOCUMENT",
		"searchDocumentDiv2",
			{
			div1 : selectResult["div1"],
			}
	).getArray();
	ret.runat("#document_inputdialog #opt_div2_dialog").remove(".dbvalue").append(resultHTML).withdata(selectResult2);
	ret.eval("$('#opt_div2_dialog').val('" + selectResult["div2"] + "');");

	var selectResult3 = db.select( 
		"DOCUMENT",
		"searchDocumentDiv3",
			{
			div1 : selectResult["div1"],
			div2 : selectResult["div2"],
			}
	).getArray();
	ret.runat("#document_inputdialog #opt_div3_dialog").remove(".dbvalue").append(resultHTML).withdata(selectResult3);
	ret.eval("$('#opt_div3_dialog').val('" + selectResult["div3"] + "');");

	var selectResult4 = db.select( 
		"DOCUMENT",
		"searchDocumentDiv4",
			{
			div1 : selectResult["div1"],
			div2 : selectResult["div2"],
			div3 : selectResult["div3"],
			}
	).getArray();
	ret.runat("#document_inputdialog #opt_div4_dialog").remove(".dbvalue").append(resultHTML).withdata(selectResult4);
	ret.eval("$('#opt_div4_dialog').val('" + selectResult["div4"] + "');");

	var selectResultPic = db.select( 
		"DOCUMENT",
		"searchDocumentDetailInfo",
		 {
			 "doc_no" : params["doc_no"],
		 }
	).getArray();

	ret.eval("cleardisplayData();");

	for(var i = 0; i < selectResultPic.length; i++){

		ret.eval("setDisplayData('" + selectResultPic[i]["content"] + "', '" + selectResultPic[i]["suffix"] + "','" + selectResultPic[i]["comment"] + "');");

		// if(isPic(selectResultPic[i]["suffix"])){

		// 	"pic".debug("AAAAAAAAAAAAAAAAAAAAAAAAAAA");
		// 	ret.eval("displayPic('" + selectResultPic[i]["content"] + "', '" + selectResultPic[i]["suffix"] + "','" + selectResultPic[i]["comment"] + "');");
		// }else{
		// 	"file".debug("BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB");
		// 	ret.eval("displayFile('" + selectResultPic[i]["content"] + "', '" + selectResultPic[i]["suffix"] + "','" + selectResultPic[i]["comment"] + "');");
		// }
		
	}

	ret.eval("displayData();");

	// 画面へ結果を返す
	return ret;

};
