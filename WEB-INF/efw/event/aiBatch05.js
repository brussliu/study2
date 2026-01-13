var aiBatch05={};
aiBatch05.paramsFormat={
};
aiBatch05.fire=function(params){

	var ret = new Batch();
	ret.echo("開始 "+new Date().format("yyyy/MM/dd HH:mm:ss"));

	var limitCount = 50;
	var threadCount = 4;

	//  检索
	var selectResult = db.select(
		"AILSSUES",
		"selectTaskToAi05",
		{
		}
	).getArray();

	for(var i = 0;i < selectResult.length;i ++){

		var no = selectResult[i]["no"];
		var aiopt = selectResult[i]["ai"];
		var category = selectResult[i]["category"];


		var args = new Array();
		args[0] = aiopt;
		args[1] = no;
		args[2] = category;

		excuteJar("OptTask06",args);

	}

	ret.echo("完了 "+new Date().format("yyyy/MM/dd HH:mm:ss"));

	return ret;
};