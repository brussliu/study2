var word_search = {};
word_search.name = "単語状況検索";
word_search.paramsFormat = {
	"#opt_book" : null,
	"#opt_classification" : null,
	"#opt_accuracy" : null,
	"#keyword" : null,
	"#wordstatus1" : null,
	"#wordstatus2" : null,
	"#wordstatus3" : null,
	//"#wrongword" : null,
};

word_search.fire = function (params) {

	var ret = new Result();

	// セッションチェック
	if(sessionCheck(ret) == false){return ret};

	var book = params["#opt_book"];

	var classification = params["#opt_classification"];

	var accuracy = params["#opt_accuracy"];

	var keyword = params["#keyword"];

	var wordstatus1 = params["#wordstatus1"];
	var wordstatus2 = params["#wordstatus2"];
	var wordstatus3 = params["#wordstatus3"];

	var status = "";

	if(wordstatus1 == '1'){
		status = status + "'-',"
	}
	if(wordstatus2 == '2'){
		status = status + "'△','▲',"
	}
	if(wordstatus3 == '3'){
		status = status + "'○',"
	}

	status = status.length > 0 ? status.slice(0, -1) : status;


	//  检索
	var selectResult = db.select(
		"STUDY",
		"selectWordTestInfo",
		{
			book : book,
			classification : classification,
			accuracy : accuracy,
			keyword : keyword,
			status : status,
			//wrongword : wrongword
		}
	).getArray();


	var resultHTML =
		"<tr>" +
			"<td style='width: 150px;' class='l'><span class='l5'>{book}</span><input type='hidden' value='{wrong_flg}'></td>" +
			"<td style='width: 80px;' class='l'><span class='l5'>{classification}</span></td>" +
			"<td style='width: 80px;' class='r'><span class='r5'>{wordseq}</span></td>" +
			"<td style='width: 150px;' class='l'><span class='l5'>{kind}</span></td>" +

			"<td style='width: 100px;' class='c'><span class=''>{costtime}</span></td>" +
			"<td style='width: 100px;' class='r'><span class='r5'>{testtimes}</span></td>" +
			"<td style='width: 100px;' class='r'><span class='r5'>{all_right}</span></td>" +
			"<td style='width: 100px;' class='r'><span class='r5'>{recentrighttimes}</span></td>" +
			"<td style='width: 100px;' class='r'><span class='r5'>{per}</span></td>" +

			"<td style='width: 100px;' class='c'><span class=''>{we1}</span></td>" +
			"<td style='width: 100px;' class='c'><span class=''>{we2}</span></td>" +
			"<td style='width: 100px;' class='c'><span class=''>{we3}</span></td>" +
			"<td style='width: 100px;' class='c'><span class=''>{we4}</span></td>" +
			"<td style='width: 100px;' class='c'><span class=''>{we5}</span></td>" +
			"<td style='width: 100px;' class='c'><span class=''>{we6}</span></td>" +
			"<td style='width: 100px;' class='c'><span class=''>{we7}</span></td>" +
			"<td style='width: 100px;' class='c'><span class=''>{we8}</span></td>" +
			"<td style='width: 100px;' class='c'><span class=''>{we9}</span></td>" +

			"<td style='width: 200px;' class='l' ondblclick='updateItem(1,this);'>" +
				"<img style='width: 20px;height: 20px;margin: -2px;margin-left: 5px;cursor: pointer;' src='img/ai.png' onclick=\"aiThisWord('{book}','{classification}','{wordseq}');\"/>" +
				"&nbsp;<a herf='#' onclick='openWord(this)'><span class='l5 word' style='text-decoration: underline;'>{word_e}</span></a>" +
			"</td>" +
			"<td style='width: 200px;' class='l' ondblclick='updateItem(2,this);'><span class='l5'>{word_j}</span></td>" +
			"<td style='width: 500px;' class='l' ondblclick='updateItem(3,this);'><span class='l5'>{word_c}</span></td>" +
			"<td style='width: 100px;' class='r'><span class='r5'>{word_right}</span></td>" +
			"<td style='width: 100px;' class='r'><span class='r5'>{word_wrong}</span></td>" +

			"<td style='width: 250px;' class='l' ondblclick='updateItem(4,this);'><span class='l5'>{sen1_e}</span></td>" +
			"<td style='width: 250px;' class='l' ondblclick='updateItem(5,this);'><span class='l5'>{sen1_j}</span></td>" +
			"<td style='width: 250px;' class='l' ondblclick='updateItem(6,this);'><span class='l5'>{sen1_c}</span></td>" +
			"<td style='width: 100px;' class='r'><span class='r5'>{sen1_right}</span></td>" +
			"<td style='width: 100px;' class='r'><span class='r5'>{sen1_wrong}</span></td>" +

			// "<td style='width: 250px;' class='l' ondblclick='updateItem(7,this);'><span class='l5'>{sen2_e}</span></td>" +
			// "<td style='width: 250px;' class='l' ondblclick='updateItem(8,this);'><span class='l5'>{sen2_j}</span></td>" +
			// "<td style='width: 250px;' class='l' ondblclick='updateItem(9,this);'><span class='l5'>{sen2_c}</span></td>" +
			// "<td style='width: 100px;' class='r'><span class='r5'>{sen2_right}</span></td>" +
			// "<td style='width: 100px;' class='r'><span class='r5'>{sen2_wrong}</span></td>" +
		"</tr>";

	ret.runat("#wordinfotable").remove("tr").append(resultHTML).withdata(selectResult);

	ret.eval("changeStyleForWordInfo();");
	// 画面へ結果を返す
	return ret;

};
