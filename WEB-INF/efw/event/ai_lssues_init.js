var ai_lssues_init = {};
ai_lssues_init.name = "AI質問開始";
ai_lssues_init.paramsFormat = {
};

ai_lssues_init.fire = function (params) {

	var ret = new Result();

	// セッションチェック
	if(sessionCheck(ret) == false){return ret};

	// タイトル情報設定
	setTitleInfo(ret);

	setAuthorityInfo(ret, "01");

	initSelectOption(ret);

	var selectResult2 = db.select(
		"AILSSUES",
		"searchAll",
		{
			type:null,
			difficulty:null
		}
	).getArray();


	var resultHTML =
		"<tr class='tr1'>" +
			"<td style='width:  60px;text-align: center;'><input type='checkbox' name='testitem' value='{no}' onchange='checkTest(this)'></td>" +
			"<td style='width: 160px;'><span class='l5'>{no}</span></td>" +
			"<td style='width: 200px;' class='l'><span class='l5'>{type}</span></td>" +
			"<td style='width: 100px;'><span class='l5'>{state}</span></td>" +
			"<td style='width: 100px;'><span class='l5'>{difficulty}</span></td>" +
			"<td style='width: 300px;' class='l'><span class='l5'>{summary}</span></td>" +
			"<td style='width: 450px;' class='l'><span class='l5'>{detail}</span></td>" +
			"<td style='width: 200px;'><span class='l5'>{registrationdate}</span></td>" +
			"<td style='width: 200px;'><span class='l5'>{updatedate}</span></td>" +
		"</tr>";

	ret.runat("#testwordtable").remove("tr").append(resultHTML).withdata(selectResult2);

	ret.eval("changeColor();");



	// 画面へ結果を返す
	return ret;

};

function initSelectOption(ret){

	//  检索類型
	var selectResult = db.select(
		"AILSSUES",
		"searchType",
		{}
	).getArray();

	var resultHTML = "<option class='dbvalue' value='{type}'>{type}</option>";

	ret.runat("#opt_type").remove(".dbvalue").append(resultHTML).withdata(selectResult);


}