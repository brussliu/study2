var document_search = {};
document_search.name = "資料情報検索";
document_search.paramsFormat = {
	"#opt_div1" : null,
	"#opt_div2" : null,
	"#opt_div3" : null,
	"#opt_div4" : null,
	"#text_keyword" : null,
};

document_search.fire = function (params) {

	var ret = new Result();

	// セッションチェック
	if(sessionCheck(ret) == false){return ret};

	//  检索
	var selectResult = db.select(
		"DOCUMENT",
		"searchDocumentInfo",
		{
			div1 : params["#opt_div1"],
			div2 : params["#opt_div2"],
			div3 : params["#opt_div3"],
			div4 : params["#opt_div4"],
			keyword : params["#text_keyword"]
		}
	).getArray();

	ret.runat("#doclisttable").remove("tr");

	for(var i = 0; i < selectResult.length; i++){

		var doc_no = selectResult[i]["doc_no"];
		var record = new Record([selectResult[i]]).getArray();

		var selectResult2 = db.select( 
			"DOCUMENT",
			"searchDocumentDetailInfo",
			 {
				 "doc_no" : doc_no
			 }
		).getArray();	

		var subhtml = "";

		for(var j = 0; j < selectResult2.length; j++){

			var suffix = selectResult2[j]["suffix"];
			if(isPic(suffix)){
				subhtml = subhtml + "<img src='" + selectResult2[j]["content_tb50"] + "' class='aimg' onclick='openDoc(0,this);'>" +
				"<input type='hidden' value='"+ selectResult2[j]["doc_no"] + "," + selectResult2[j]["doc_sub_no"] +"'/>&nbsp;";
			}else{
				subhtml = subhtml + "<img src='img/" + suffix + ".png' class='afile' onclick='openDoc(1,this);'>" +
				//"<input type='hidden' value='"+ selectResult2[j]["content"] + "'/>&nbsp;";
				"<input type='hidden' value='"+ selectResult2[j]["doc_no"] + "," + selectResult2[j]["doc_sub_no"] +"'/>&nbsp;";
			}
			


		
		}

		var resultHTML =
		"<tr>" +
		"	<td style='width: 50px;text-align: center;'>" +
		"		<input type='checkbox' value='' onchange='checkDoc(this);'/>" +
		"	</td>" +
		"	<td style='width: 150px;' class='c'>{doc_no}</td>" +
		"	<td style='width: 100px;' class='l'>{status}</td>" +
		"	<td style='width: 120px;text-align: center;'>{doc_vp}</td>" +
		"	<td style='width: 200px;'>{div1}</td>" +
		"	<td style='width: 200px;'>{div2}</td>" +
		"	<td style='width: 200px;'>{div3}</td>" +
		"	<td style='width: 200px;'>{div4}</td>" +
		"	<td style='width: 580px;'>" +
				subhtml +
		"	</td>" +
		"</tr>";

		ret.runat("#doclisttable").append(resultHTML).withdata(record);
	}




	



	// var script = "document_inputdialog.dialog('close')";
	// ret.eval(script);


	// 画面へ結果を返す
	return ret;

};