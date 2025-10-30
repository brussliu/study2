var document_delete = {};
document_delete.name = "資料情報検索";
document_delete.paramsFormat = {
	"doclist" : null,
};

document_delete.fire = function (params) {

	var ret = new Result();

	// セッションチェック
	if(sessionCheck(ret) == false){return ret};


	var doclist = params["doclist"];
		

	for(var i = 0;i < doclist.length;i ++){

		var doc_no = doclist[i];

		// 削除
		db.change(
			"DOCUMENT",
			"deleteDocumentInfo",
			{
				doc_no : doc_no
			}
		);

		// 削除
		db.change(
			"DOCUMENT",
			"deleteDocumentDetailInfo",
			{
				doc_no : doc_no
			}
		);

	}

	// 画面へ結果を返す
	return ret.navigate("document.jsp");

};