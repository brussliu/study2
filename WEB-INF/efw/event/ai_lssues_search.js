var ai_lssues_search = {};
ai_lssues_search.name = "AI質問查询";
ai_lssues_search.paramsFormat = {
	type : null,
	difficulty : null,
};

ai_lssues_search.fire = function (params) {

	var ret = new Result();

	// セッションチェック
	if(sessionCheck(ret) == false){return ret};

	var type = params["type"];
	var difficulty = params["difficulty"];


	var selectResult2 = db.select(
		"AILSSUES",
		"searchAll",
		{
			type:type,
			difficulty:difficulty
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
