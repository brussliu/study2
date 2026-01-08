var ai_Generate2 = {};
ai_Generate2.name = "AI生成";
ai_Generate2.paramsFormat = {
	"args":null,
};

ai_Generate2.fire = function (params) {

	var ret = new Result();

	// セッションチェック
	if(sessionCheck(ret) == false){return ret};

	var args =params["args"];
	// java -jar
	var no = args[0];
	excuteJar("OptTask03",args);

	// java -cp  测试用可删除
	// var no = args[1];
	// excuteJar("start.Start",args);



	ret.eval(" toJAVA2( '"+no+"');")
	// 画面へ結果を返す
	return ret;

};