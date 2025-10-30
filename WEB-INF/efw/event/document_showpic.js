var document_showpic = {};
document_showpic.name = "写真アップロード";
document_showpic.paramsFormat = {
	"seq" : null,
	"subno" : null,
	"flg" : null
};

document_showpic.fire = function (params) {

	var ret = new Result();

	// if(sessionCheck(ret) == false){return ret};

	var seq = params["seq"];
	var flg = params["flg"];
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

	var nextsubno = sub_no + 1
	if(nextsubno > 0){
		//  检索
		var noteResult1 = db.select(
			"DOCUMENT",
			"searchDocument",
			{
				doc_no : seq,
				sub_no : nextsubno
			}
		).getArray();

		if(noteResult1.length > 0){
			ret.eval("$('#next_btn').prop('disabled', false);");
		}
	}

	var prevsubno = sub_no - 1
	if(prevsubno > 0){
		//  检索
		var noteResult2 = db.select(
			"DOCUMENT",
			"searchDocument",
			{
				doc_no : seq,
				sub_no : prevsubno
			}
		).getArray();

		if(noteResult2.length > 0){
			ret.eval("$('#prev_btn').prop('disabled', false);");
		}
	}  



	ret.eval("displaypic('" + noteResult["content"] + "')");
  
	return ret;
};
