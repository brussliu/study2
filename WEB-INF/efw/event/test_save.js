var test_save = {};
test_save.name = "テスト情報管理画面保存";
test_save.paramsFormat = {

	"#opt" : null,

	"commoninfo" : null,
	"subjectinfo" : null,

	"#testseq" : null,
	
};

test_save.fire = function (params) {

	var ret = new Result();

	// セッションチェック
	if(sessionCheck(ret) == false){return ret};

	var opt = params["#opt"];

	var commoninfo = params["commoninfo"];
	var subjectinfoArr = params["subjectinfo"];
	 
	if(opt == 'new'){
		
		// testseq
		var testseq = new Date().format("yyyyMMdd-HHmmss");

		// TRN_テスト情報
		db.change(
			"TEST",
			"insertTestInfo",
			{
				"seq" : testseq,
				"academicyear" : commoninfo[0],
				"from" : commoninfo[1],
				"to" : commoninfo[2],
				"tname" : commoninfo[3],
				"content" : commoninfo[4],
				"userid" : getUserId(),
			}
		);


		for(var i = 0;i < subjectinfoArr.length;i ++){

			var subjectinfo = subjectinfoArr[i];

			// TRN_テスト科目情報
			db.change(
				"TEST",
				"insertTestDetailInfo",
				{
					"seq" : testseq,
					"subject" : subjectinfo[0],
					"content" :  subjectinfo[9],

					"score1" : subjectinfo[1],
					"score2" : subjectinfo[2],

					"classaverage" : subjectinfo[3],
					"classranking1" : subjectinfo[4],
					"classranking2" : subjectinfo[5],

					"yearaverage" : subjectinfo[6],
					"yearranking1" : subjectinfo[7],
					"yearranking2" : subjectinfo[8],

					"userid" : getUserId(),
				}
			);

		}

	}

	if(opt == 'update'){
		
		var testseq = params["#testseq"];

		// var seq = params["seq"];
		// // TRN_テスト情報
		// var updateResult1 = db.change(
		// 	"STUDYTEST",
		// 	"updatestudytest",
		// 	{
		// 		"seq":seq,
		// 		"academicyear":academicyear,
		// 		"tname":tname,
		// 		"to":to,
		// 		"from":from,
		// 		"img" :content1, 
		// 		"shopid": shopid 
		// 	}
		// );
		// // 综合
		
		// if(comprehensive[0] != ''){
		// 	var updateResult2 = db.change(
		// 		"STUDYTEST",
		// 		"updatestudytestcomprehensive",
		// 		{
		// 			"seq":seq,
		// 			"score":comprehensive[0],
		// 			"fulls":comprehensive[1],
		// 			"gradeaverage":comprehensive[2],
		// 			"yearaverage":comprehensive[3], 
		// 			"academicrank1":comprehensive[4],
		// 			"academicrank2":comprehensive[5],
		// 			"academicyear1":comprehensive[6],
		// 			"academicyear2":comprehensive[7], 
		// 			"shopid": shopid
		// 		}
		// 	);
		// }else{
		// 	// 单科
		// 	if(tags.length>0 && tags != ''){
		// 		for(var i=0;i<tags.length;i++){
		// 			var updateResult3 = db.change(
		// 				"STUDYTEST",
		// 				"updatestudytestmonotechnical",
		// 				{
		// 					"seq":seq,
		// 					"tags":tags[i],
		// 					"col1":monotechnical[tags[i]][0],
		// 					"col2":monotechnical[tags[i]][1],
		// 					"col3":monotechnical[tags[i]][2],
		// 					"col4":monotechnical[tags[i]][3],
		// 					"col5":monotechnical[tags[i]][4],
		// 					"col6":monotechnical[tags[i]][5],
		// 					"col7":monotechnical[tags[i]][6],
		// 					"col8":monotechnical[tags[i]][7],
		// 					"col9":monotechnical[tags[i]][8],
		// 					"col10":monotechnical[tags[i]][9], 
		// 					"shopid": shopid,
		// 				}
		// 			);
		// 		}
		// 	}
		// }
	
	}


 
	ret.eval("test_inputdialog.dialog('close');");

	return ret.navigate("test.jsp");


};
