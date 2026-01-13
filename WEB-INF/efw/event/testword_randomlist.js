var testword_randomlist = {};
testword_randomlist.name = "ランダム単語テスト";
testword_randomlist.paramsFormat = {

	"list": null,
};

testword_randomlist.fire = function (params) {

	var ret = new Result();

	// セッションチェック
	if(sessionCheck(ret) == false){return ret};


	var randomListArr = params["list"].split(",");

	var now = new Date();

	for(var i = 0;i < randomListArr.length;i ++){

		var randomArr = randomListArr[i].split("-");

		var book = 		randomArr[0];
		var dayfrom =   randomArr[1];
		var dayto =     randomArr[2];
		var status =    randomArr[3];
		var wordcount = parseInt(randomArr[4]);
		var kind =      randomArr[5];
		var level =      randomArr[6];
		

		now.setSeconds(now.getSeconds() + 1);
		var testno = now.format('yyyyMMdd-HHmmss');

		// 抽選の場合
		if(wordcount > 0){

			if(status == "未勉強" || status == "勉強中"){

				//  単語检索
				var selectResult = db.select(
					"STUDY",
					"selectWord",
					{
						book: book == "00.すべて" ? null : book,
						dayfrom: dayfrom,
						dayto: dayto,
						status: status,
						kind: kind,
						count: parseInt(wordcount),
					}
				).getArray();
			
				if(wordcount < selectResult.length){
					selectResult.splice(wordcount, selectResult.length - wordcount);
				}

				var way1Str = "順番抽選" + (status == "" ? "" : "-" + status);


			}else{
				//  単語检索
				var selectResult = db.select(
					"STUDY",
					"selectRodomWord",
					{
						book: book == "00.すべて" ? null : book,
						dayfrom: dayfrom,
						dayto: dayto,
						status: status,
						count: parseInt(wordcount),
					}
				).getArray();
			
				if(wordcount < selectResult.length){
					selectResult.splice(wordcount, selectResult.length - wordcount);
				}

				var way1Str = "ランダム抽選" + (status == "" ? "" : "-" + status);
			}
		
		// 全部の場合
		}else{

			//  检索
			var selectResult = db.select(
				"STUDY",
				"selectWord",
				{
					book: book == "00.すべて" ? null : book,
					dayfrom: dayfrom,
					dayto: dayto,
					kind: kind,
					status: status
				}
			).getArray();

			var way1Str = "全部" + (status == "" ? "" : "-" + status);

		}

		var classification = "";
		if((dayfrom == null || dayfrom == "") && (dayto == null || dayto == "")){
	
			classification = "===ALL===";
	
		}else{
	
			if(dayfrom != dayto){
				classification = dayfrom + "～" + dayto;
			}else{
				classification = dayfrom;
			}
	
		}

		if(selectResult.length > 0){
			// 単語テスト情報
			db.change(
				"STUDY",
				"insertTestInfo",
				{
					testno : testno,
					book : book,
					classification : classification,
					type : way1Str,
					kind : kind,
					level : level,
					count : selectResult.length,
					userid : getUserId()
				}
			);

			// 単語テスト詳細情報
			for(var j = 0;j < selectResult.length;j ++){

				db.change(
					"STUDY",
					"insertTestDetailInfo",
					{
						testno : testno,
						subno : j + 1,
						book : selectResult[j]["book"],
						classification : selectResult[j]["classification"],
						wordseq : selectResult[j]["wordseq"],
						userid : getUserId()
					}
				);
			}
		}


	}

	// 画面へ結果を返す
	return ret.navigate("testword.jsp");

};