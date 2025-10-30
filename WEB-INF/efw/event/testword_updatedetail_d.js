var testword_updatedetail_d = {};
testword_updatedetail_d.name = "単語テスト開始";
testword_updatedetail_d.paramsFormat = {

	"#hiddenOpt": null,
	"#hiddenTestNo": null,
	"#hiddenWordNo": null,
	"#hiddenWordCount": null,

	"#hiddenWordCheckResult": null,

	// "#hiddenWordWrongTime": null,
	// "#hiddenSen1WrongTime": null,
	// "#hiddenSen2WrongTime": null,

	// "#hiddenWordNoteSeq": null,
	// "#hiddenSen1NoteSeq": null,
	// "#hiddenSen2NoteSeq": null,

	// "#hiddenWay3": null,
	// "#hiddenWay4": null,
	
};

testword_updatedetail_d.fire = function (params) {

	var ret = new Result();

	// セッションチェック
	if(sessionCheck(ret) == false){return ret};

	// タイトル情報設定
	//setTitleInfo(ret);

	// params.debug("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");

	var opt = params["#hiddenOpt"];

	var testno = session.get("TEST_NO");
	var testsubno = 0;

	// var way3 = params["#hiddenWay3"];
	// var way4 = params["#hiddenWay4"];

	// var wordseq = parseInt(params["#hiddenWordNoteSeq"]);
	// var sen1seq = parseInt(params["#hiddenSen1NoteSeq"]);
	// var sen2seq = parseInt(params["#hiddenSen2NoteSeq"]);

	// var status = 9;
	
	// if(way3 != "0"){
	// 	status = 2;
	// }


	var result = params["#hiddenWordCheckResult"];


	if(opt == "back"){

	}else if(opt == "next"){

		var wordCount = parseInt(params["#hiddenWordCount"]);
		var test_sub_no = parseInt(params["#hiddenWordNo"]);

		var endtime =  (new Date()).getTime();
		

		endtime = endtime - session.get("TEST_SUB_NO_STARTTIME");

		if(endtime >= 1000){
			endtime = Math.round(endtime / 1000);
		}else{
			endtime = 1;
		}

		// var wordWrongTime = null;
		// if(params["#hiddenWordWrongTime"] != null && params["#hiddenWordWrongTime"] != ""){
		// 	wordWrongTime = parseInt(params["#hiddenWordWrongTime"]);;
		// }

		var rt = "×";
		if(result == "OK"){
			rt = "○";
		}

		db.change(
			"STUDY",
			"updateTestDetailInfo3",
			{
				testno : testno,
				testsubno : test_sub_no,
				status : 9,
				rt : rt,

				costtime : endtime,
				userid : getUserId()
			}
		);

		if(test_sub_no == 1){

			// 終了時間更新
			db.change(
				"STUDY",
				"updateTestStartTime",
				{
					testno : testno
				}
			);

		}

		if(test_sub_no == wordCount){
			// 終了時間更新
			db.change(
				"STUDY",
				"updateTestEndTime",
				{
					testno : testno
				}
			);

			session.set("TEST_NO", null);
			session.set("TEST_SUB_NO", null);

			return ret.eval("overTest();");

		}else{

			testsubno = test_sub_no + 1;
			session.set("TEST_NO", testno);
			session.set("TEST_SUB_NO", testsubno);
		}


	}

	// 画面へ結果を返す
	return ret.navigate("testword_test_d.jsp");

};
