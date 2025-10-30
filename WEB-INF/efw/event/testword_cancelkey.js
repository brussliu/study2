var testword_cancelkey = {};
testword_cancelkey.name = "キー押下";
testword_cancelkey.paramsFormat = {

	"keycode": null,

};

testword_cancelkey.fire = function (params) {

	var ret = new Result();

	var keycode = params["keycode"];

	var file = "/usr/local/tomcat/webapps/study2/key/" + keycode + ".key";

	if (absfile.exists(file)){
		absfile.remove(file);
	}
	

	// 画面へ結果を返す
	return ret;

};