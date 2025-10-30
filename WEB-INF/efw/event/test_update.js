var test_update = {};
test_update.name = "テスト情報管理画面更新";
test_update.paramsFormat = {
	"seq":null,
};

test_update.fire = function (params) {

	var ret = new Result();
	// セッションチェック
	if(sessionCheck(ret) == false){return ret};

	// タイトル情報設定
	setTitleInfo(ret);

	var seq = params["seq"];

	//  检索
	var selectResult = db.select(
		"TEST",
		"selectstudytestbyseq",
		{
			seq : seq
		}
	).getArray();

	for(var i = 0; i < selectResult.length; i++){

		var project = selectResult[i]["project"];

		if(i == 0 && project == "0.総合"){

			// 共通入力項目部分,総合科目部分
			ret.runat("#test_inputdialog").withdata({
				"#opt_academicyear" : selectResult[i]["academicyear"],
				"#text_from" : selectResult[i]["froms"],
				"#text_to" : selectResult[i]["tos"],
				"#text_name" : selectResult[i]["tname"],

				".allsubjectinfo .text_score1" : selectResult[i]["score"],
				".allsubjectinfo .text_score2" : selectResult[i]["fulls"],
				".allsubjectinfo .text_classaverage" : selectResult[i]["gradeaverage"],
				".allsubjectinfo .text_classranking1" : selectResult[i]["academicrank1"],
				".allsubjectinfo .text_classranking2" : selectResult[i]["academicrank2"],
				".allsubjectinfo .text_yearaverage" : selectResult[i]["yearaverage"],
				".allsubjectinfo .text_yearranking1" : selectResult[i]["academicyear1"],
				".allsubjectinfo .text_yearranking2" : selectResult[i]["academicyear2"],

				".commoninfo .doc_content0" : selectResult[i]["common_contentseq"],

				"#testseq" : selectResult[i]["seq"],

			});

			// 共通資料部分
			var contentlist = selectResult[i]["common_contentseq"].split(',');

			for(var j = 0; j < contentlist.length; j++){

				var picResult = db.select(
					"DOCUMENT",
					"searchDocumentDetailInfo",
					{
						"doc_no" : contentlist[j],
					}
				).getArray();

				for(var k = 0; k < picResult.length; k++){

					var record = new Record([picResult[k]]).getArray();

					var suffix = picResult[k]["suffix"];

					var resultHTML = "";

					if(isPic(suffix)){
						resultHTML = "<img src='{content_tb200}' class='selectedimg'>";
					}else{
						resultHTML = "<img src='img/" + suffix + ".png' class='selectedfile'>";
					}
			
					ret.runat("#test_inputdialog .picdiv0").append(resultHTML).withdata(record);

				}

			}

		}else{

			var record = new Record([selectResult[i]]).getArray();

			var subject1 = (record[0]["project"] == "1.国語" ? "selected" : "");
			var subject2 = (record[0]["project"] == "2.数学" ? "selected" : "");
			var subject3 = (record[0]["project"] == "3.英語" ? "selected" : "");
			var subject4 = (record[0]["project"] == "4.理科" ? "selected" : "");
			var subject5 = (record[0]["project"] == "5.社会" ? "selected" : "");
			var subject6 = (record[0]["project"] == "6.地理" ? "selected" : "");
			var subject7 = (record[0]["project"] == "7.歴史" ? "selected" : "");

			var picHTML = "";
			// 共通資料部分
			var contentlist = selectResult[i]["contentseq"] == null ? "" : selectResult[i]["contentseq"];

			if(contentlist != ""){

				var contentArr = contentlist.split(',');

				for(var j = 0; j < contentArr.length; j++){
	
					var picResult = db.select(
						"DOCUMENT",
						"searchDocumentDetailInfo",
						{
							"doc_no" : contentArr[j],
						}
					).getArray();
	
					for(var k = 0; k < picResult.length; k++){
	
						var suffix = picResult[k]["suffix"];
	
						if(isPic(suffix)){
							picHTML = picHTML + "<img src='" + picResult[k]["content_tb200"] + "' class='selectedimg'>";
						}else{
							picHTML = picHTML + "<img src='img/" + suffix + ".png' class='selectedfile'>";
						}
	
					}
	
				}
			}



			var html = 
				"<table class='table_inputdialog subjectinfo newtable' border='0' padding='0' style='border-top: 1px dashed black;'>" +
				"<tbody>" +
				"	<tr style='background-color: E3F2D9;'>" +
				"		<td style='width: 150px;'><img src='img/right.png' onclick='lessen(this)' width='20' height='20' style='vertical-align: middle;'> 科目：</td>" +
				"		<td colspan='9'>" +
				"			<select style='width: 200px;' class='opt_subject'>" +
				"				<option value=''></option>" +
				"				<option value='1.国語' " + subject1 + ">1.国語</option>" +
				"				<option value='2.数学' " + subject2 + ">2.数学</option>" +
				"				<option value='3.英語' " + subject3 + ">3.英語</option>" +
				"				<option value='4.理科' " + subject4 + ">4.理科</option>" +
				"				<option value='5.社会' " + subject5 + ">5.社会</option>" +
				"				<option value='6.地理' " + subject6 + ">6.地理</option>" +
				"				<option value='7.歴史' " + subject7 + ">7.歴史</option>" +
				"			</select>" +
				"			&nbsp;&nbsp;" +
				"			<img src='img/minus.png' class='addicon' width='22' height='22' style='vertical-align: middle;' onclick='removeSubject(this);'>" +
				"		</td>" +
				"	</tr>" +
				"	<tr style='height: 10px;'>" +
				"		<td></td>" +
				"		<td></td>" +
				"		<td></td>" +
				"		<td></td>" +
				"		<td></td>" +
				"		<td></td>" +
				"		<td></td>" +
				"		<td></td>" +
				"		<td></td>" +
				"		<td></td>" +
				"	</tr>" +
				"	<tr>" +
				"		<td style='width: 150px;'>得点：</td>" +
				"		<td style='width: 115px;'><input type='text' style='width: 100px;' class='text_score1 num' value='{score}'></input></td>" +
				"		<td style='width: 20px;'>/</td>" +
				"		<td style='width: 250px;'><input type='text' style='width: 100px;' class='text_score2 num' value='{fulls}'></input></td>" +
				"		<td style='width: 150px;'>学級平均点：</td>" +
				"		<td style='width: 250px;'><input type='text' style='width: 100px;' class='text_classaverage num' value='{gradeaverage}'></input></td>" +
				"		<td style='width: 150px;'>学級順位：</td>" +
				"		<td style='width: 115px;'><input type='text' style='width: 100px;' class='text_classranking1 num' value='{academicrank1}'></input></td>" +
				"		<td style='width: 20px;'>/</td>" +
				"		<td ><input type='text' style='width: 100px;' class='text_classranking2 num' value='{academicrank2}'></input></td>" +
				"	</tr>" +
				"	<tr>" +
				"		<td></td>" +
				"		<td></td>" +
				"		<td></td>" +
				"		<td></td>" +
				"		<td>学年平均点：</td>" +
				"		<td><input type='text' style='width: 100px;' class='text_yearaverage num' value='{yearaverage}'></input></td>" +
				"		<td>学年順位：</td>" +
				"		<td><input type='text' style='width: 100px;' class='text_yearranking1 num' value='{academicyear1}'></input></td>" +
				"		<td style='width: 20px;'>/</td>" +
				"		<td><input type='text' style='width: 100px;' class='text_yearranking2 num' value='{academicyear2}'></input></td>" +
				"	</tr>" +
				"	<tr style='height: 100px;'>" +
				"		<td>内容：<br>" +
				"			<img src='img/delete2.png' style='height: 50px;width: 50px;float: right;margin-bottom: 30px;margin-right: 20px;display: none;' onclick='deletePic(this);'>" +
				"			<img src='img/add.png' style='height: 50px;width: 50px;float: right;margin-bottom: 30px;margin-right: 20px;' onclick='openDocSelectPage(this);'>" +
				"		</td>" +
				"		<td colspan='9'>" +
				"			<div class='image-container picdiv" + i + "' style='height: 100%;width:100%;'>" + picHTML + "</div>" +
				"			<input type='hidden' class='doc_content" + i + "' value='" + contentlist + "'>" +
				"		</td> " +
				"	</tr> " +
				"	<tr style='height: 10px;'>" +
				"		<td></td>" +
				"		<td></td>" +
				"		<td></td>" +
				"		<td></td>" +
				"		<td></td>" +
				"		<td></td>" +
				"		<td></td>" +
				"		<td></td>" +
				"		<td></td>" +
				"		<td></td>" +
				"	</tr>" +
				"</tbody>" +
				"</table>";

				ret.runat("#test_inputdialog #contentdiv").append(html).withdata(record);
				















			// var contentlist = selectResult[i]["contentseq"].split(',');
			
			// for(var j = 0; j < contentlist.length; j++){

			// 	var picResult = db.select(
			// 		"DOCUMENT",
			// 		"searchDocumentDetailInfo",
			// 		{
			// 			"doc_no" : contentlist[j],
			// 		}
			// 	).getArray();

			// }


			// var script = "addSubjectWithData(" +
			// 		"'" + selectResult[i]["project"] + "'," +
			// 		"'" + selectResult[i]["score"] + "'," +
			// 		"'" + selectResult[i]["fulls"] + "'," +
			// 		"'" + selectResult[i]["gradeaverage"] + "'," +
			// 		"'" + selectResult[i]["academicrank1"] + "'," +
			// 		"'" + selectResult[i]["academicrank2"] + "'," +
			// 		"'" + selectResult[i]["yearaverage"] + "'," +
			// 		"'" + selectResult[i]["academicyear1"] + "'," +
			// 		"'" + selectResult[i]["academicyear2"] + "'" +
			// 	");";

			// ret.eval(script);

		}

	}
 
	return ret.eval("test_inputdialog.dialog('open');");

};
