var testword_updatedetail4 = {};
testword_updatedetail4.name = "単語テスト開始";
testword_updatedetail4.paramsFormat = {

	"#hiddenOpt": null,
	"#hiddenTestNo": null,
	"#hiddenWordNo": null,
	"#hiddenWordCount": null,

	"#hiddenWordWrongTime": null,
	"#hiddenSen1WrongTime": null,
	"#hiddenSen2WrongTime": null,

	"#hiddenWordNoteSeq": null,
	"#hiddenSen1NoteSeq": null,
	"#hiddenSen2NoteSeq": null,

	"#hiddenWay2": null,
	"#hiddenWay3": null,
	"#hiddenWay4": null,

	"#wordAudioData": null,
	"#sen1AudioData": null,
	"#sen2AudioData": null,
};

testword_updatedetail4.fire = function (params) {

	var ret = new Result();

	// セッションチェック
	if(sessionCheck(ret) == false){return ret};

	// タイトル情報設定
	//setTitleInfo(ret);

	params.debug("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");

	var opt = params["#hiddenOpt"];

	var testno = session.get("TEST_NO");
	var testsubno = 0;

	var way2 = params["#hiddenWay2"];
	var way3 = params["#hiddenWay3"];
	var way4 = params["#hiddenWay4"];

	var wordAudioContent = params["#wordAudioData"];
	var sen1AudioContent = params["#sen1AudioData"];
	var sen2AudioContent = params["#sen2AudioData"];

	var status = 9;
	
	if(way3 != "0" || way2 == "7"){
		status = 2;
	}

	if(opt == "back"){

		var wordCount = parseInt(params["#hiddenWordCount"]);
		var test_sub_no = parseInt(params["#hiddenWordNo"]);

		if(test_sub_no == 1){

			session.invalidate();
			// 前のページに戻る
			return ret.navigate("testword_init.jsp");
		}else{
			testsubno = test_sub_no - 1;

			db.change(
				"STUDY",
				"updateTestDetailInfo4",
				{
					testno : testno,
					testsubno : testsubno,
					status : 1,
					wordWrongTime : null,
					sen1WrongTime : null,
					sen2WrongTime : null,
					wordAudioContent : null,
					sen1AudioContent : null,
					sen2AudioContent : null,
					costtime : null,
					userid : getUserId()
				}
			);

			// 判定結果更新
			db.change(
				"STUDY",
				"updateTestDetailInfo3",
				{
					testno : testno,
					testsubno : testsubno
				}
			);

			session.set("TEST_NO", testno);
			session.set("TEST_SUB_NO", testsubno);
		}

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

		var wordWrongTime = null;
		if(params["#hiddenWordWrongTime"] != null && params["#hiddenWordWrongTime"] != ""){
			wordWrongTime = parseInt(params["#hiddenWordWrongTime"]);;
		}

		var sen1WrongTime = null;
		if(params["#hiddenSen1WrongTime"] != null && params["#hiddenSen1WrongTime"] != ""){
			sen1WrongTime = parseInt(params["#hiddenSen1WrongTime"]);;
		}

		var sen2WrongTime = null;
		if(params["#hiddenSen2WrongTime"] != null && params["#hiddenSen2WrongTime"] != ""){
			sen2WrongTime = parseInt(params["#hiddenSen2WrongTime"]);;
		}

		db.change(
			"STUDY",
			"updateTestDetailInfo4",
			{
				testno : testno,
				testsubno : test_sub_no,
				status : status,
				wordWrongTime : wordWrongTime,
				sen1WrongTime : sen1WrongTime,
				sen2WrongTime : sen2WrongTime,

				wordAudioContent : wordAudioContent,
				sen1AudioContent : sen1AudioContent,
				sen2AudioContent : sen2AudioContent,

				costtime : endtime,
				userid : getUserId()
			}
		);

		// 判定結果更新
		db.change(
			"STUDY",
			"updateTestDetailInfo2",
			{
				testno : testno,
				testsubno : test_sub_no
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

	return ret.navigate("testword_test4.jsp");

	// var test_no = session.get("TEST_NO");
	// var test_sub_no = session.get("TEST_SUB_NO");
	
	// //  检索
	// var selectResult = db.select(
	// 	"STUDY",
	// 	"selectTestInfo",
	// 	{
	// 		testno: test_no
	// 	}
	// ).getSingle();

	// var selectDetailResult = db.select(
	// 	"STUDY",
	// 	"selectTestDetailInfo",
	// 	{
	// 		testno: test_no,
	// 		testsubno: test_sub_no
	// 	}
	// ).getSingle();

	// var way2 = selectResult["div2"];
	// var way3 = selectResult["div3"];
	// var way4 = selectResult["div4"];

	// ret.runat("body").withdata(
	// 	{

	// 		"#hiddenBook" : selectDetailResult["book"],
	// 		"#hiddenclassification" : selectDetailResult["classification"],
	// 		"#hiddenwordseq" : selectDetailResult["wordseq"],

	// 		"#hiddenTestNo" : test_no,
	// 		"#hiddenWordNo" : test_sub_no,
	// 		"#hiddenWordCount" : selectResult["ct"],

	// 		"#hiddenWordWrongTime" : null,
	// 		"#hiddenSen1WrongTime" : null,
	// 		"#hiddenSen2WrongTime" : null,

	// 		"#hiddenWordE" : selectDetailResult["word_e"],
	// 		"#hiddenWordJ" : selectDetailResult["word_j"],
	// 		"#hiddenWordC" : selectDetailResult["word_c"],

	// 		"#hiddenSen1E" : selectDetailResult["sen1_e"],
	// 		"#hiddenSen1J" : selectDetailResult["sen1_j"],
	// 		"#hiddenSen1C" : selectDetailResult["sen1_c"],

	// 		"#hiddenSen2E" : selectDetailResult["sen2_e"],
	// 		"#hiddenSen2J" : selectDetailResult["sen2_j"],
	// 		"#hiddenSen2C" : selectDetailResult["sen2_c"],

	// 		"#hiddenWay2" : way2,
	// 		"#hiddenWay3" : way3,
	// 		"#hiddenWay4" : way4,

	// 		"#hiddenMp3" : null
			
	// 	}
	// );

	// var script = "beginTest();";
	// ret.eval(script);


	// // 開始時間を残す
	// session.set("TEST_SUB_NO_STARTTIME", (new Date()).getTime());



	// return ret;

};
