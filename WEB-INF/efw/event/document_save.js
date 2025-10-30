var document_save = {};
document_save.name = "単語テスト開始";
document_save.paramsFormat = {

	"#opt": null,
	"#status": null,
	"#expiration_date": null,
	"#opt_div1_dialog": null,
	"#div1_text": null,
	"#opt_div2_dialog": null,
	"#div2_text": null,
	"#opt_div3_dialog": null,
	"#div3_text": null,
	"#opt_div4_dialog": null,
	"#div4_text": null,
	"#comment": null,
	"#document_no": null,

	"piclist" : null,
	
};

document_save.fire = function (params) {

	var ret = new Result();

	// セッションチェック
	if(sessionCheck(ret) == false){return ret};

	var opt = params["#opt"];
	
	var status = params["#status"];
	var expiration_date = params["#expiration_date"];
	var div1 = isNotBlank(params["#div1_text"]) ? params["#div1_text"] : params["#opt_div1_dialog"];
	var div2 = isNotBlank(params["#div2_text"]) ? params["#div2_text"] : params["#opt_div2_dialog"];
	var div3 = isNotBlank(params["#div3_text"]) ? params["#div3_text"] : params["#opt_div3_dialog"];
	var div4 = isNotBlank(params["#div4_text"]) ? params["#div4_text"] : params["#opt_div4_dialog"];
	var comment = params["#comment"];
	var piclist = params["piclist"];


	params.debug("WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW");

	// 新規登録
	if(opt == "new"){

		var document_no = new Date().format('yyyyMMdd-HHmmss');

		// DBへ登録
		db.change(
			"DOCUMENT",
			"insertDocumentInfo",
			{
				document_no : document_no,
				status : status,
				expiration_date : expiration_date,
				div1 : div1,
				div2 : div2,
				div3 : div3,
				div4 : div4,
				comment : comment,
				userid : getUserId(),
			}
		);

		for(var i = 0;i < piclist.length;i ++){

			var picinfo = piclist[i];

			var content = picinfo[0];
			var fextension = picinfo[1];
			var content_tb500 = picinfo[2];
			var content_tb200 = picinfo[3];
			var content_tb50 = picinfo[4];
			var comment = picinfo[5];

			// if(seq == null || seq == ""){
				
				// DBへ登録
				db.change(
					"DOCUMENT",
					"insertDocumentDetailInfo",
					{
						document_no : document_no,
						document_sub_no : i + 1,
						suffix : fextension,
						content : content,
						content_tb500 : content_tb500,
						content_tb200 : content_tb200,
						content_tb50 : content_tb50,
						comment : comment,
						userid : getUserId(),
					}
				);

			// }else{

			// 	// DBへ登録
			// 	db.change(
			// 		"DOCUMENT",
			// 		"insertDocumentDetailInfo",
			// 		{
			// 			document_no : document_no,
			// 			document_sub_no : i + 1,
			// 			suffix : null,
			// 			content : null,
			// 			content_tb500 : null,
			// 			content_tb200 : null,
			// 			content_tb50 : null,
			// 			comment : comment,
			// 			userid : getUserId(),
			// 		}
			// 	);

			// 	// DB更新
			// 	db.change(
			// 		"DOCUMENT",
			// 		"updateDocumentDetailInfo",
			// 		{
			// 			document_no : document_no,
			// 			document_sub_no : i + 1,
			// 			seq : parseInt(seq),
			// 			userid : getUserId(),
			// 		}
			// 	);

			// }

		}
		

	// 更新
	}else if(opt == "update"){

		var document_no = params["#document_no"];

		// DBへ登録
		db.change(
			"DOCUMENT",
			"updateDocumentInfo",
			{
				document_no : document_no,
				status : status,
				expiration_date : expiration_date,
				div1 : div1,
				div2 : div2,
				div3 : div3,
				div4 : div4,
				comment : comment,
				userid : getUserId(),
			}
		);

		// DBへ登録
		db.change(
			"DOCUMENT",
			"deleteDocumentDetailInfo",
			{
				doc_no : document_no,
			}
		);
				
		for(var i = 0;i < piclist.length;i ++){

			var picinfo = piclist[i];

			var content = picinfo[0];
			var fextension = picinfo[1];
			var content_tb500 = picinfo[2];
			var content_tb200 = picinfo[3];
			var content_tb50 = picinfo[4];
			var comment = picinfo[5];


			// DBへ登録
			db.change(
				"DOCUMENT",
				"insertDocumentDetailInfo",
				{
					document_no : document_no,
					document_sub_no : i + 1,
					suffix : fextension,
					content : content,
					content_tb500 : content_tb500,
					content_tb200 : content_tb200,
					content_tb50 : content_tb50,
					comment : comment,
					userid : getUserId(),
				}
			);

		}

	}

	var script = "document_inputdialog.dialog('close')";
	ret.eval(script);
	// 画面へ結果を返す
	return ret.navigate("document.jsp");
	// return ret;
};


