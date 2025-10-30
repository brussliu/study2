var testword_keydown = {};
testword_keydown.name = "キー押下";
testword_keydown.paramsFormat = {

	"keycode": null,

};

testword_keydown.fire = function (params) {

	var ret = new Result();

	var keycode = params["keycode"];

	optKey(keycode, "3");

	// var file = "D://apache-tomcat-9.0.30/webapps/study/key/" + keycode + ".key";

	// if (!absfile.exists(file)){
	// 	absfile.makeFile(file);
	// }
	

	// 画面へ結果を返す
	return ret;

};


