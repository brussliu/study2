var test_init = {};
test_init.name = "テスト情報管理画面初期表示";
test_init.paramsFormat = {
	// "#testname":null, 
	// "#subject":null,
};

test_init.fire = function (params) {

	var ret = new Result();
	// セッションチェック
	if(sessionCheck(ret) == false){return ret};
 
	ret.runat("#testinfotable").remove("tr");

	// var testname = params["#testname"] == ''? null : params["#testname"];
	// var subject = params["#subject"] == ''? null : params["#subject"];
	//  检索
	var selectResult = db.select(
		"TEST",
		"selectstudytest",
		{
			"testname":null,
			"subject":null,
			// "shopid": getShopId()

		}
	).getArray();


	for(var i = 0; i < selectResult.length ;i++){

		var subhtml = "";
		//selectResult[i][""]

		var record = new Record([selectResult[i]]).getSingle();

		// 内容SEQ
		if(record['contentseq'] != null){

			var contentlist2 = record['contentseq'].split(',');
			
			for(var j = 0; j < contentlist2.length; j++){


				var picResult = db.select(
					"DOCUMENT",
					"searchDocumentDetailInfo",
					{
						"doc_no" : contentlist2[j],
					}
				).getArray();

				for(var k = 0; k < picResult.length; k++){


					var suffix = picResult[k]["suffix"];

					if(isPic(suffix)){
						subhtml = subhtml + "<img src='" + picResult[k]["content_tb50"] + "' class='aimg' onclick='openDoc(0,this);'>" +
						"<input type='hidden' value='"+ picResult[k]["doc_no"] + "," + picResult[k]["doc_sub_no"] +"'/>&nbsp;";
					}else{
						subhtml = subhtml + "<img src='img/" + suffix + ".png' class='afile' onclick='openDoc(1,this);'>" +
						"<input type='hidden' value='"+ picResult[k]["doc_no"] + "," + picResult[k]["doc_sub_no"] +"'/>&nbsp;";
					}

				}

				
			}
		}

	
		var resultHTML =
			' <tr class="header">'+
				' <td style="width: 50px;text-align: center;" ><input type="radio" name="seq" value="{seq}" onclick="checkTest();"/></td>'+
				' <td style="width: 150px" class="c">{seq}</td>'+
				' <td style="width: 100px;" class="l">{academicyear}</td>'+
		
				' <td style="width: 220px;" class="l"><a href="{contentseq1}" target="_blank">{tname}</a></td>'+
				' <td style="width: 220px;text-align: center;"  >{fromto}</td>'+
		
				' <td style="width: 100px;" class="c">{project}</td>'+
				' <td style="width: 400px;text-align: center;"> '+
				subhtml +
				' </td>'+
				' <td style="width: 80px;" class="r">{score}</td>'+
				' <td style="width: 80px;" class="r">{fulls}</td>'+
				' <td style="width: 80px;" class="r">{gradeaverage}</td>'+
				' <td style="width: 80px;" class="r">{yearaverage}</td>'+
				' <td style="width: 100px;" class="r">{academicrank}</td>'+
				' <td style="width: 100px;" class="r">{academicyear2}</td> '+
			' </tr>';

			var record2 = new Record([record]).getArray();
			ret.runat("#testinfotable").append(resultHTML).withdata(record2);
	}



 

	// var script = "$('.c_detail_header').show();$('.c_detail_content').show();";
	// ret.eval(script);
	// ret.eval(" changeColor();");  
	// 画面へ結果を返す
	return ret;

};
