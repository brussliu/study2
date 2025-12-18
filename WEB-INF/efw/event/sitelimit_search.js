var sitelimit_search = {};
sitelimit_search.name = "サイトアクセス制限情報検索";
sitelimit_search.paramsFormat = {

};

sitelimit_search.fire = function (params) {

	var ret = new Result();

	// セッションチェック
	if(sessionCheck(ret) == false){return ret};

	// タイトル情報設定
	setTitleInfo(ret);

	var role = getRole();
	var flg = "1";
	if(role == "checker"){
		flg = "";
	}

	var selectResult = db.select(
		"SITE",
		"searchSiteList",
		{
			flg : flg
		}
	).getArray();

	ret.runat("#limitinfotable").remove("tr");

	for(var i = 0; i < selectResult.length; i++){

		var apply_flg = selectResult[i]["apply_flg"];
		var record = new Record([selectResult[i]]).getArray();

		var applyArray = new Array();
		if(apply_flg != null){
			applyArray = apply_flg.split(",");
		}

		var sub_html1 = "";
		var sub_html2 = "";

		if(applyArray.length > 0){
			sub_html1 = "<select style='width: 80px;'>"; 
			for(var j = 0; j < applyArray.length; j++){
				sub_html1 = sub_html1 + "<option value='" + applyArray[j] + "'>" + applyArray[j] + "分</option>";

			}
			sub_html1 = sub_html1 + "</select>";
			sub_html2 = "<input type='checkbox' name='testitem' value='' onchange='checkItem(this);'></input>";
		}

		var resultHTML =
			"<tr>" + 
			"	<td style='width: 50px;text-align: center;'>" + sub_html2 + "</td>" + 
			"	<td style='width: 100px;text-align: center;'>" + 
					sub_html1 + 
			"	</td>" + 
			"	<td style='width: 250px;'><span class='l5'>{site}</span></td>" + 
			"	<td style='width: 80px; '><span class='l5'>{status}</span></td>" + 
			"	<td style='width: 100px;'><span class='l5'>{classification}</span></td>" + 
			"	<td style='width: 60px; '><span class='l5'>{div}</span></td>" + 
			"	<td style='width: 60px; text-align: center;'>{complet_flg}</td>" + 
			"	<td style='width: 40px; text-align: center;'>{condition_1}</td>" + 
			"	<td style='width: 40px; text-align: center;'>{condition_2}</td>" + 
			"	<td style='width: 40px; text-align: center;'>{condition_3}</td>" + 
			"	<td style='width: 40px; text-align: center;'>{condition_4}</td>" + 
			"	<td style='width: 40px; text-align: center;'>{condition_5}</td>" + 
			"	<td style='width: 40px; text-align: center;'>{condition_6}</td>" + 
			"	<td style='width: 40px; text-align: center;'>{condition_7}</td>" + 
			"	<td style='width: 40px; text-align: center;'>{condition_0}</td>" + 
			"	<td style='width: 40px; text-align: center;'>{limit_1}</td>" + 
			"	<td style='width: 40px; text-align: center;'>{limit_2}</td>" + 
			"	<td style='width: 40px; text-align: center;'>{limit_3}</td>" + 
			"	<td style='width: 40px; text-align: center;'>{limit_4}</td>" + 
			"	<td style='width: 40px; text-align: center;'>{limit_5}</td>" + 
			"	<td style='width: 40px; text-align: center;'>{limit_6}</td>" + 
			"	<td style='width: 40px; text-align: center;'>{limit_7}</td>" + 
			"	<td style='width: 40px; text-align: center;'>{limit_0}</td>" + 
			"	<td style='width: 120px;text-align: center;'>{locktimedaily}</td>" + 
			"	<td style='width: 80px;text-align: center;'>{nextlocktime}</td>" + 
			"</tr>";
		ret.runat("#limitinfotable").append(resultHTML).withdata(record);
	}

	var selectResult2 = db.select(
		"SITE",
		"selectHoliday",
		{
		}
	).getArray();

	var isholiday = selectResult2[0]["isholiday"];

	ret.eval("changeColor(" + isholiday + ");");

	// 画面へ結果を返す
	return ret;

};
