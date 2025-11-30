var global = {};
global.name = "システム初期化";

/**
 * グローバルイベント実行関数
 */
global.fire = function () {



};

function isPic(fextension){

	const imageExtensions = ['jpg', 'jpeg', 'png', 'gif', 'bmp', 'webp', 'svg'];

	return imageExtensions.includes(fextension.toLowerCase());

}

function isBlank(value){
	
	if(value == null || value == ""){
		return true;
	}
	return false;
}

function isNotBlank(value){
	
	if(value == null || value == ""){
		return false;
	}
	return true;
}

function excuteClass(java, params){

	//cmd.execute(params.unshift("java", "-classpath", "D:/apache-tomcat-9.0.30/webapps/study2/java/", java));
	cmd.execute(params.unshift("java", "-classpath", "/usr/local/tomcat/java/", java));

}

function excuteJar(java, params){

	//params.unshift("java", "-jar", "D:/apache-tomcat-9.0.30/webapps/study2/java/study2.jar", java);
	params.unshift("java", "-jar", "/usr/local/tomcat/java/study2.jar", java);
	
	cmd.execute(params);

}

function setTitleInfo(ret){

	ret.runat("#sessioninfo").withdata(
		{
			"#shopid":getShopId(),
			"#userid":getUserId()
		}
	);

}

function setTitleInfoForShopList(ret){

	ret.runat("#sessioninfo").withdata(
		{
			"#shopid":"未選択",
			"#userid":getUserId()
		}
	);

}

function setAuthorityInfo(ret, pageid){

	for (var i = 0; i < 9999; i++) {

		var sessionname = "authority" + i;

		var sessioncontent = session.get(sessionname);

		if(sessioncontent == null){
			return;
		}
		// btn-0201_01-normal

		var sessioncontentArr = sessioncontent.split("-");

		var authority_type = sessioncontentArr[0];
		var authority_id = sessioncontentArr[1];
		var authority_div = sessioncontentArr[2];

		if(authority_id.startsWith(pageid)){

			var script = "";

			var classname = authority_type + "-" + authority_id;

			if(authority_div == "normal"){

				if(authority_type == "btn"){
					script = 
							"$('." + classname + "').show();" + 
							"$('." + classname + "').attr('disabled', false);";
				}else if(authority_type == "div"){
					script = "$('." + classname + "').show();";
				}
				
			}else if(authority_div == "disable"){

				if(authority_type == "btn"){
					script = 
							"$('." + classname + "').show();" + 
							"$('." + classname + "').attr('disabled', true);" +
							"$('." + classname + "').off('click');";

				}else if(authority_type == "div"){
					script = "$('." + classname + "').show();";
				}
				
			}else if(authority_div == "hidden"){

				if(authority_type == "btn"){
					script = 
						"$('." + classname + "').hide();" + 
						"$('." + classname + "').attr('disabled', true);" +
						"$('." + classname + "').off('click');";

				}else if(authority_type == "div"){

					script = "$('." + classname + "').hide();";
				}

			}
			ret.eval(script);

		}

	}


}

function getAuthorityInfo(shopid,btnid){
	
	if(shopid == 'Smart-Bear'){
	 	return	true;
	}
	if(shopid == 'zhixun'){

		for (var i = 0; i < 9999; i++) {

			var sessionname = "authority" + i;

			var sessioncontent = session.get(sessionname);

			if(sessioncontent == null){
				return false;
			}

			var sessioncontentArr = sessioncontent.split("-");

			// var authority_type = sessioncontentArr[0];
			var authority_id = sessioncontentArr[1];
			var authority_div = sessioncontentArr[2];

			if(authority_id == btnid){
				if(authority_div == "normal"){
					return true;
				}else{
					return false;	
				}
			}
		}
		
	}
}

function sessionCheck(ret){

	var smartId = getSmartId();
	if(smartId == null || smartId == ""){
		ret.navigate("common_login.jsp");
		return false;
	}
	var userId = getUserId();
	if(userId == null || userId == ""){
		ret.navigate("common_login.jsp");
		return false;
	}
	var shopId = getShopId();
	if(shopId == null || shopId == ""){
		ret.navigate("common_login.jsp");
		return false;
	}
	var role = getRole();
	if(role == null || role == ""){
		ret.navigate("common_login.jsp");
		return false;
	}
	return true;
}


function sessionCheckForShopList(ret){

	var smartId = getSmartId();
	if(smartId == null || smartId == ""){
		ret.navigate("common_login.jsp");
		return false;
	}
	var userId = getUserId();
	if(userId == null || userId == ""){
		ret.navigate("common_login.jsp");
		return false;
	}
	return true;

}

function clearSessionForShopList(){

	session.set("SHOP_ID", null);

	session.set("ROLE", null);

}


function getSmartId(){

	return session.get("SMART_ID");

}

function getUserId(){

	return session.get("USER_ID");

}

function getShopId(){

	return session.get("SHOP_ID");

}

function getRole(){

	return session.get("ROLE");

}

function optKey(key, kbn){

	//  画像登録
	db.change(
		"COMMON",
		"insertOptkey",
		{
			kbn : kbn,
			key : key,
			userid : getUserId()
		}
	);

}
function clearAllKey(kbn){

	//  画像登録
	db.change(
		"COMMON",
		"deleteOptkey",
		{
			kbn : kbn
		}
	);

}
function selectKey(kbn){

	//  画像登録
	var keyarr = db.select(
		"COMMON",
		"selectOptkey",
		{
			kbn : kbn
		}
	).getSingle();

	return keyarr;

}

function optKeyOver(seq){

	//  画像登録
	var keyarr = db.change(
		"COMMON",
		"optkeyDone",
		{
			seq : seq
		}
	);

}


function makeKey(key){

	var selectResult = db.select("STUDY","selectJavaKey",{	key : key	}).getSingle();

	// 存在しない場合　、keyを登録
	if(JSON.stringify(selectResult) == '{}'){

		db.change("STUDY","insertJavaKey",{	key : key, status : "実行中"	});
		db._commit();
	}else{

		//　存在する場合、ステータスが完了である場合、削除して、再度keyを登録する
		//　存在する場合、ステータスが実行中である場合、更新日時を見る、３分以上である場合、削除する再度keyを登録する
		var status = selectResult["status"];
		var updatetime = selectResult["updatetime"];

		var nowtime = new Date();
		var threeMinutesAgo = new Date(nowtime.getTime() - 3 * 60 * 1000);

		if(status == "完了" || updatetime < threeMinutesAgo){
			db.change("STUDY","deleteJavaKey",{	key : key});
			db.change("STUDY","insertJavaKey",{	key : key, status : "実行中"	});
			db._commit();

		}else{
			//　存在する場合、ステータスが実行中である場合、更新日時が３分以内である場合。
			// 10秒を待って、再度このメソッドを呼び出す
			setTimeout(() => {
				makeKey(key);
			}, 10000); // 10000 毫秒 = 10 秒

		}

	}

}
