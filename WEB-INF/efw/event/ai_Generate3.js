var ai_Generate3 = {};
ai_Generate3.name = "AI生成";
ai_Generate3.paramsFormat = {
	"no":null,
};

ai_Generate3.fire = function (params) {

	var ret = new Result();

	// セッションチェック
	if(sessionCheck(ret) == false){return ret};

	var no =params["no"];
	var shopid =getShopId();
	// 查询JAVA端是否状态修改成功
	var selectResult = db.select(
		"AILSSUES",
		"selectAiReply",
		{
			no:no,
			shopid:shopid
		}
	).getSingle();

	//不成功则删除AI質問情報管理新增
	if(selectResult["state"] == "作成中"){
		var deleteResult = db.change(
			"AILSSUES",
			"deleteAiAnswer",
			{
				no:no,
				shopid:getShopId()
			}
		);
		ret.eval(" alert('Ai回答失败');")

	}

	ret.navigate("ai_Issues.jsp")
	// 画面へ結果を返す
	return ret;

};