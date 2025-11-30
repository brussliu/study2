var sitelimit_apply = {};
sitelimit_apply.name = "単語テスト開始";
sitelimit_apply.paramsFormat = {
	site : null,
	time : null,
};

sitelimit_apply.fire = function (params) {

	var ret = new Result();

	// セッションチェック
	if(sessionCheck(ret) == false){return ret};

	var site = params["site"];
	var time = parseInt(params["time"]);

	var role = getRole();
	var flg = "1";
	if(role == "checker"){
		flg = "";
	}

	var selectResult = db.select(
		"SITE",
		"searchSiteList",
		{
			flg : flg,
			site : site
		}
	).getArray();

	var apply_flg = selectResult[0]["apply_flg"];
	var game_quota = selectResult[0]["game_quota"];

	// 額度が無限の場合
	if(game_quota == null || game_quota == ""){

	// 額度が有限の場合
	}else{
		if(apply_flg == null){

			return ret.alert("アクセス申請できません。");
		}

	}
	// ステータス変更（unlocked ⇒ locked）
	db.change("SITE",	"updateStatus1",
		{
			site : site,
			status : "unlocked"
		}
	);


	db.change("SITE",	"updateLockTime",
		{
			site : site,
			time : time
		}
	);

	// 額度が無限場合
	if(game_quota == null || game_quota == ""){
		time = 0;
	}

	db.change("SITE",	"updateApplyTime",
		{
			time : time
		}
	);

	ret.eval("search();");

	// 画面へ結果を返す
	return ret;

};
