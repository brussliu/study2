var testword_test_d = {};
testword_test_d.name = "単語テスト開始";
testword_test_d.paramsFormat = {


};

testword_test_d.fire = function (params) {

	var ret = new Result();

	// セッションチェック
	if(sessionCheck(ret) == false){return ret};

	var test_no = session.get("TEST_NO");
	var test_sub_no = session.get("TEST_SUB_NO");


	//  检索
	var selectResult = db.select(
		"STUDY",
		"selectTestInfo",
		{
			testno: test_no
		}
	).getSingle();

	var selectDetailResult = db.select(
		"STUDY",
		"selectTestDetailInfo",
		{
			testno: test_no,
			testsubno: test_sub_no
		}
	).getSingle();

	var type = selectResult["type"];
	var kind = selectResult["kind"];
	var level = selectResult["level"];

	var book = selectDetailResult["book"];
	var classification = selectDetailResult["classification"];
	var wordseq = selectDetailResult["wordseq"];


	// var selectTranslationResult = db.select(
	// 	"STUDY",
	// 	"selectSingleWord",
	// 	{
	// 		book: book,
	// 		classification: classification,
	// 		wordseq: wordseq
	// 	}
	// ).getSingle();


	var selectTranslationResult = db.select(
		"STUDY",
		"selectTranslationInfo",
		{
			book: book,
			classification: classification,
			wordseq: wordseq
		}
	).getSingle();

	var rightRt = selectTranslationResult["rightrt"];
	var wrongRt1 = selectTranslationResult["wrongrt1"];
	var wrongRt2 = selectTranslationResult["wrongrt2"];
	var wrongRt3 = selectTranslationResult["wrongrt3"];
	var wrongRt4 = selectTranslationResult["wrongrt4"];
	var wrongRt5 = selectTranslationResult["wrongrt5"];
	var question = selectTranslationResult["question"];

	var explain = selectTranslationResult["explain"];


	var strings = [rightRt, wrongRt1, wrongRt2, wrongRt3, wrongRt4, wrongRt5];
	var selected1 = getRandomStrings(strings, 4);
	var resultArr = new Array();

	if (selected1.includes(rightRt)) {
	
		resultArr = shuffleArray(selected1);
		rightRt = selectTranslationResult["rightrt"];

	}else{

		var selected2 = getRandomStrings(selected1, 3);

		if(Math.random() < 0.5){

			resultArr = shuffleArray(selected2);
			resultArr.push("以上皆非");
			rightRt = "以上皆非";
		
		}else{

			selected2.push(rightRt);
			resultArr = shuffleArray(selected2);
		
		}

	}

	ret.runat("body").withdata(
		{

			"#hiddenBook" : selectDetailResult["book"],
			"#hiddenclassification" : selectDetailResult["classification"],
			"#hiddenwordseq" : selectDetailResult["wordseq"],

			"#hiddenTestNo" : test_no,
			"#hiddenWordNo" : test_sub_no,
			"#hiddenWordCount" : selectResult["ct"],

			"#hiddenWordWrongTime" : null,
			"#hiddenSen1WrongTime" : null,
			"#hiddenSen2WrongTime" : null,

			"#hiddenWordE" : selectDetailResult["word_e"],
			"#hiddenWordJ" : selectDetailResult["word_j"],
			"#hiddenWordC" : selectDetailResult["word_c"],

			"#wordESpan" : selectDetailResult["word_e"],

			"#question" : question,
			"#explain" : explain,

			"#hiddenRightRt" : rightRt,
			"#hiddenItem1" : resultArr[0],
			"#hiddenItem2" : resultArr[1],
			"#hiddenItem3" : resultArr[2],
			"#hiddenItem4" : resultArr[3],

			"#hiddenType" : type,
			"#hiddenKind" : kind,
			"#hiddenLevel" : level,

			// "#hiddenMp3" : null
			
		}
	);

	var script = "beginTest();";
	ret.eval(script);


	// 開始時間を残す
	session.set("TEST_SUB_NO_STARTTIME", (new Date()).getTime());

	// 画面へ結果を返す
	return ret;

};

function getRandomStrings(arr, count) {
  // 创建原数组的副本以避免修改原始数据
  var copy = arr.slice();
  var result = [];

  for (let i = 0; i < count; i++) {
    var index = Math.floor(Math.random() * copy.length);
    result.push(copy.splice(index, 1)[0]); // 从副本中移除并添加到结果中
  }

  return result;
}

function shuffleArray(array) {
  // 创建数组副本
  var shuffled = array.slice();
  
  for (var i = shuffled.length - 1; i > 0; i--) {
    var j = Math.floor(Math.random() * (i + 1));
    
    // 交换元素（不使用解构赋值）
    var temp = shuffled[i];
    shuffled[i] = shuffled[j];
    shuffled[j] = temp;
  }
  
  return shuffled;
}


// function shuffleArray(arr) {
//   const copy = arr.slice(); // 创建副本以避免修改原数组
//   for (let i = copy.length - 1; i > 0; i--) {
//     const j = Math.floor(Math.random() * (i + 1)); // 随机索引
//     [copy[i], copy[j]] = [copy[j], copy[i]]; // 交换元素
//   }
//   return copy;
// }
