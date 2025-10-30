var testword_savenote = {};
testword_savenote.name = "写真アップロード";
testword_savenote.paramsFormat = {

	"#signContent":null,
	"#signContent_tb":null,
	"flg":null,
	"keycode":null,

};

testword_savenote.fire = function (params) {

	var ret = new Result();

	var content = params["#signContent"];
	var content_tb = params["#signContent_tb"];

	var flg = params["flg"];

	var keycode = params["keycode"];

	if(content != null && content != ""){

		//  画像削除
		db.change(
			"STUDY",
			"deleteTempNote",
			{
				flg : flg
			}
		);

		//  画像登録
		db.change(
			"STUDY",
			"insertTempNote",
			{
				flg : flg,
				content : content,
				content_tb : content_tb
			}
		);

	}

	if(keycode != null && keycode > 0){
		
		optKey(keycode, "3")

		// var file = "D://apache-tomcat-9.0.30/webapps/study/key/" + keycode + ".key";
		// if (!absfile.exists(file)){
		// 	absfile.makeFile(file);
		// }
	}

	// ret.alert("保存しました。");

	ret.eval("overSave();");
  
	return ret;
};