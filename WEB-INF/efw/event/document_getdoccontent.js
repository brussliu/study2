var document_getdoccontent = {};
document_getdoccontent.name = "資料";
document_getdoccontent.paramsFormat = {
	"seq" : null,
	"subno" : null,
};

document_getdoccontent.fire = function (params) {

	var ret = new Result();

	// if(sessionCheck(ret) == false){return ret};

	var seq = params["seq"];
	var sub_no = parseInt(params["subno"]);


	//  检索
	var noteResult = db.select(
		"DOCUMENT",
		"searchDocument",
		{
			doc_no : seq,
			sub_no : sub_no
		}
	).getSingle();



	ret.eval("downloadFile('" + noteResult["content"] + "','" + noteResult["suffix"] + "')");
  
	return ret;
};
