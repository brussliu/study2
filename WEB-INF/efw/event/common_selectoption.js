var common_selectoption = {};
common_selectoption.name = "画面遷移";//せんい
common_selectoption.paramsFormat = {
	code : null,
	inputvalue : null,
	outputObj: null
};
 
common_selectoption.fire = function (params) {


	var ret = new Result();

	// セッションチェック
	if(sessionCheck(ret) == false){return ret};

	var inputvalueArr = params["inputvalue"];

	var selectResult = null;
	var resultHTML = "<option class='dbvalue' value='{value}'>{text}</option>";
	var outputObjArr = params["outputObj"];

	if(params["code"] == "document_init1"){

		var selectResult = db.select( 
			"DOCUMENT",
			"searchDocumentDiv1",
			 {
			 }
		).getArray();

	}else if(params["code"] == "document_init2"){

		var selectResult = db.select( 
			"DOCUMENT",
			"searchDocumentDiv2",
			 {
				div1 : inputvalueArr[0],
			 }
		).getArray();

	}else if(params["code"] == "document_init3"){

		var selectResult = db.select( 
			"DOCUMENT",
			"searchDocumentDiv3",
			 {
				div1 : inputvalueArr[0],
				div2 : inputvalueArr[1],
			 }
		).getArray();

	}else if(params["code"] == "document_init4"){

		var selectResult = db.select( 
			"DOCUMENT",
			"searchDocumentDiv4",
			 {
				div1 : inputvalueArr[0],
				div2 : inputvalueArr[1],
				div3 : inputvalueArr[2],
			 }
		).getArray();

	}

	for(var i = 0;i < outputObjArr.length; i++){

		ret.runat(outputObjArr[i]).remove(".dbvalue").append(resultHTML).withdata(selectResult);

	}

	return ret;

};
