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
		
		var folder = "doc" + "//" + document_no.substring(0,6);
		if(!file.exists(folder)){
			file.makeDir(folder);
		}

		var sub_folder = folder + "//" + document_no; 
		if(!file.exists(sub_folder)){
			file.makeDir(sub_folder);
		}

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

			var filename = document_no + "_" + (i + 1) + "." + fextension;
			var file_byte = dataURLToByteArray(content);
			file.writeAllBytes( sub_folder + "//" + filename, file_byte);

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

		var folder = "doc" + "//" + document_no.substring(0,6);
		var sub_folder = folder + "//" + document_no; 

		file.remove(sub_folder);

		if(!file.exists(sub_folder)){
			file.makeDir(sub_folder);
		}

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

			var filename = document_no + "_" + (i + 1) + "." + fextension;
			var file_byte = dataURLToByteArray(content);
			file.writeAllBytes(sub_folder + "//" + filename, file_byte);
		}

	}

	var script = "document_inputdialog.dialog('close');";
	ret.eval(script);
	// 画面へ結果を返す

	return ret.eval("searchDoc();");
	//return ret.navigate("document.jsp");
	// return ret;
};


function dataURLToByteArray(dataURL) {
    // 分离Data URL的头部和base64数据部分
    const base64Data = dataURL.split(',')[1];
    
    // 使用普通数组存储字节数据
    const byteArray = [];
    
    // 自定义base64解码
    const base64Chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/';
    let buffer = 0;
    let bitsLeft = 0;
    
    // 移除可能存在的填充字符和换行符
    const cleanBase64 = base64Data.replace(/[^A-Za-z0-9+/]/g, '');
    
    for (let i = 0; i < cleanBase64.length; i++) {
        const char = cleanBase64[i];
        if (char === '=') break; // 遇到填充字符停止
        
        const value = base64Chars.indexOf(char);
        if (value === -1) continue;
        
        buffer = (buffer << 6) | value;
        bitsLeft += 6;
        
        if (bitsLeft >= 8) {
            bitsLeft -= 8;
            byteArray.push((buffer >> bitsLeft) & 0xFF);
            buffer &= (1 << bitsLeft) - 1;
        }
    }
    
    return byteArray;
}
