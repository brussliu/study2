var ai_Generate = {};
ai_Generate.name = "AI生成";
ai_Generate.paramsFormat = {
	"#opt_type2":null,
	"#opt_summary2":null,
	"#text_detailed2":null,
	"#opt_difficulty2":null,
	"#opt_category2":null,
	"#opt_aiopt2":null
};

ai_Generate.fire = function (params) {

	var ret = new Result();

	// セッションチェック
	if(sessionCheck(ret) == false){return ret}

	var type =params["#opt_type2"];
	var summary =params["#opt_summary2"];
	var detailed =params["#text_detailed2"];
	var difficulty =params["#opt_difficulty2"];
	var category =params["#opt_category2"];
	var aiopt =params["#opt_aiopt2"];
	var state = "作成中";
	var no = formatTime( new Date());

	var insert = db.change(
		"AILSSUES",
		"insertAiAnswer",
		{
			no:no,
			type:type,
			summary:summary,
			detailed:detailed,
			category:category,
			difficulty:difficulty,
			aiopt:aiopt,
			state:state,
			shopid:getShopId()
		}
	);


	ret.eval("   toJAVA( '"+no+"','"+aiopt+"', '"+category+"','"+ getShopId()+"');")
	// 画面へ結果を返す
	return ret;

};
// 格式化日期
function formatTime(date) {
	var year = date.getFullYear();
	var month = (date.getMonth() + 1).toString().padStart(2, '0');
	var day = date.getDate().toString().padStart(2, '0');
	var hours = date.getHours().toString().padStart(2, '0');
	var minutes = date.getMinutes().toString().padStart(2, '0');
	var seconds = date.getSeconds().toString().padStart(2, '0');

	return year+month+day+"-"+hours+minutes+seconds;
}
