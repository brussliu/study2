var document_savememo = {};
document_savememo.name = "単語テスト開始";
document_savememo.paramsFormat = {

	"doc_no" : null, 
	"sub_doc_no" : null, 
	"memoflg" : null,

	"piclist" : null,
	
};

document_savememo.fire = function (params) {

	var ret = new Result();

	// セッションチェック
	if(sessionCheck(ret) == false){return ret};

	var document_no = params["doc_no"];
	var sub_document_no = params["sub_doc_no"];

	var memoflg = params["memoflg"];

	//  检索
	var selectResult = db.select(
		"DOCUMENT",
		"searchDocument",
		{
			doc_no : document_no,
			sub_no : parseInt(sub_document_no)
		}
	).getSingle();

	var fextension = selectResult["suffix"];
	var comment = selectResult["comment"];
	var piclist = params["piclist"];
	var picinfo = piclist[0];

	var content = picinfo[0];
	var content_tb500 = picinfo[1];
	var content_tb200 = picinfo[2];
	var content_tb50 = picinfo[3];

	if(memoflg == true){

		//  检索
		var selectResult2 = db.select(
			"DOCUMENT",
			"searchDocumentMaxSubno",
			{
				doc_no : document_no,
			}
		).getSingle();

		var sub_no = selectResult2["doc_sub_no"] + 1;

		// DBへ登録
		db.change(
			"DOCUMENT",
			"insertDocumentDetailInfo",
			{
				document_no : document_no,
				document_sub_no : sub_no,
				suffix : fextension,
				content : content,
				content_tb500 : content_tb500,
				content_tb200 : content_tb200,
				content_tb50 : content_tb50,
				comment : comment + "書き込み",
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

		var filename = document_no + "_" + sub_no + "." + fextension;
		var file_byte = dataURLToByteArray(content);
		file.writeAllBytes( sub_folder + "//" + filename, file_byte);

	}else{

		// 削除
		db.change(
			"DOCUMENT",
			"deleteDocumentDetailInfo2",
			{
				doc_no : document_no,
				sub_no : parseInt(sub_document_no)
			}
		);

		// DBへ登録
		db.change(
			"DOCUMENT",
			"insertDocumentDetailInfo",
			{
				document_no : document_no,
				document_sub_no : parseInt(sub_document_no),
				suffix : fextension,
				content : content,
				content_tb500 : content_tb500,
				content_tb200 : content_tb200,
				content_tb50 : content_tb50,
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

		var filename = document_no + "_" + sub_document_no + "." + fextension;

		file.remove(sub_folder + "//" + filename);

		var file_byte = dataURLToByteArray(content);
		file.writeAllBytes( sub_folder + "//" + filename, file_byte);

	}



	var script = "window.close();";
	ret.eval(script);
	// 画面へ結果を返す
	return ret;
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
