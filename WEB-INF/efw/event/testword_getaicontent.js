var testword_getaicontent = {};
testword_getaicontent.name = "AI情報取得";
testword_getaicontent.paramsFormat = {

};

testword_getaicontent.fire = function (params) {

	var ret = new Result();

	// セッションチェック
	if(sessionCheck(ret) == false){return ret};

	var book = session.get("WORD_BOOK");
	var classification = session.get("WORD_CLASSIFICATION");
	var wordseq = session.get("WORD_WORDSEQ");

	//  检索
	var selectResult = db.select(
		"STUDY",
		"selectSingleWord",
		{
			book : book,
			classification : classification,
			wordseq : parseInt(wordseq)
		}
	).getArray();


	var flg = false;
	var ai1_content_ch = selectResult[0]["ai1_content_ch"];
	if(ai1_content_ch != null && ai1_content_ch != ""){
		ret.runat("#tab1").remove("div").append("<div>" + ai1_content_ch + "</div>").withdata(selectResult);
		ret.eval('$("#tabTitle1").addClass("active");');
		ret.eval('$("#tab1").addClass("active");');
		flg = true;
		
	}else{
		ret.hide("#tabTitle1").eval('$("#tabTitle1").removeClass("active");');
		ret.hide("#tab1").eval('$("#tab1").removeClass("active");');
	}

	var ai1_content_jp = selectResult[0]["ai1_content_jp"];
	if(ai1_content_jp != null && ai1_content_jp != ""){
		
		ret.runat("#tab2").remove("div").append("<div>" + ai1_content_jp + "</div>").withdata(selectResult);

		if(flg == false){
			
			ret.eval('$("#tabTitle2").addClass("active");');
			ret.eval('$("#tab2").addClass("active");');
			flg =true;
		}
	}else{
		ret.hide("#tabTitle2").eval('$("#tabTitle2").removeClass("active");');
		ret.hide("#tab2").eval('$("#tab2").removeClass("active");');
	}

	var ai2_content_ch = selectResult[0]["ai2_content_ch"];
	if(ai2_content_ch != null && ai2_content_ch != ""){
		
		ret.runat("#tab3").remove("div").append("<div>" + ai2_content_ch + "</div>").withdata(selectResult);

		if(flg == false){
			
			ret.eval('$("#tabTitle3").addClass("active");');
			ret.eval('$("#tab3").addClass("active");');
			flg =true;
		}
	}else{
		ret.hide("#tabTitle3").eval('$("#tabTitle3").removeClass("active");');
		ret.hide("#tab3").eval('$("#tab3").removeClass("active");');
	}

	var ai2_content_jp = selectResult[0]["ai2_content_jp"];
	if(ai2_content_jp != null && ai2_content_jp != ""){
		
		ret.runat("#tab4").remove("div").append("<div>" + ai2_content_jp + "</div>").withdata(selectResult);

		if(flg == false){
			
			ret.eval('$("#tabTitle4").addClass("active");');
			ret.eval('$("#tab4").addClass("active");');
			flg =true;
		}
	}else{
		ret.hide("#tabTitle4").eval('$("#tabTitle4").removeClass("active");');
		ret.hide("#tab4").eval('$("#tab4").removeClass("active");');
	}

	session.set("WORD_BOOK", null);
	session.set("WORD_CLASSIFICATION", null);
	session.set("WORD_WORDSEQ", null);

	//ret.eval("searchWord();");
	
	// 画面へ結果を返す
	return ret;

};
