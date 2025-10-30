var testword_check = {};
testword_check.name = "単語テスト採点";
testword_check.paramsFormat = {


};

testword_check.fire = function (params) {

	var ret = new Result();

	// セッションチェック
	if(sessionCheck(ret) == false){return ret};




	// 画面へ結果を返す
	return ret;

};
