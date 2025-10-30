var common_uploadpic = {};
common_uploadpic.name = "写真アップロード";
common_uploadpic.paramsFormat = {

	"piclist" : null,

};

common_uploadpic.fire = function (params) {

	var ret = new Result();

	var piclist = params["piclist"];

	

	for(var i = 0;i < piclist.length;i ++){

		var picinfo = piclist[i];

		var content = picinfo[0];
		var fextension = picinfo[1];

		var content_tb500 = picinfo[2];
		var content_tb200 = picinfo[3];
		var content_tb50 = picinfo[4];

		if(content != null && content != ""){

			// DBに登録
			db.change(
				"COMMON",
				"insertTempPicFromSmartphone",
				{
					content : content,
					suffix : fextension,
					content_tb500 : content_tb500,
					content_tb200 : content_tb200,
					content_tb50 : content_tb50
				}
			);

		}

	}


	// for(var i = 1;i <= 20;i ++){

	// 	var content = params["#picfile"+i];
	// 	var content_tb500 = params["#picfile" + i + "_tb500"];
	// 	var content_tb200 = params["#picfile" + i + "_tb200"];
	// 	var content_tb50 = params["#picfile" + i + "_tb50"];

	// 	if(content != null && content != ""){

	// 		// DBに登録
	// 		db.change(
	// 			"COMMON",
	// 			"insertTempPicFromSmartphone",
	// 			{
	// 				content : content,
	// 				suffix : suffix,
	// 				content_tb500 : content_tb500,
	// 				content_tb200 : content_tb200,
	// 				content_tb50 : content_tb50
	// 			}
	// 		);

	// 	}

	// }

	ret.alert("写真をアップロード完了しました。");
	ret.eval("window.location.reload();");
  
	return ret;
};