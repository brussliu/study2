var common_menuinit={};
common_menuinit.name="メニュー画面初期化";//
common_menuinit.paramsFormat={ 

};

common_menuinit.fire=function(params){

	var ret = new Result();

	// セッションチェック
	if(sessionCheck(ret) == false){return ret};

	// タイトル情報設定
	setTitleInfo(ret);

	// ============================================日次処理============================================

	const today = new Date();
	const yesterday = new Date(today);
	yesterday.setDate(today.getDate() - 1);

	var yesterdayStr = yesterday.format('yyyyMMdd');

	var selectTodayResult = db.select(
		"STUDY",
		"searchTodayInfo",
		{
			today: yesterdayStr
		}
	).getArray();

	if(selectTodayResult.length <= 0){
		db.change(
		"STUDY",
		"insertTodayInfo",
		{
			today : yesterdayStr,
			userid : getUserId(),
		});

		db.change(
		"STUDY",
		"updateTodayInfo1",
		{
			today : yesterdayStr,
			userid : getUserId(),
		});

		db.change(
		"STUDY",
		"updateTodayInfo2",
		{
			today : yesterdayStr,
			userid : getUserId(),
		});

		db.change(
		"STUDY",
		"updateTodayInfo3",
		{
			today : yesterdayStr,
			userid : getUserId(),
		});

	}


	// ============================================グラフ（下部）============================================
	//  检索
	var selectResult = db.select(
		"STUDY",
		"searchWordInfoByBook",
		{
		}
	).getArray();

	var bookList = "";
	var perList = "";

	for(var i = 0;i < selectResult.length;i ++){

		var book = selectResult[i]["book"];
		var wordCount = selectResult[i]["word_ct"];
		var per = selectResult[i]["per"];

		if(!bookList.includes(book + "<br/>" + wordCount + "個")){

			if(bookList == ""){
				bookList = bookList.concat(book + "<br/>" + wordCount + "個");
			}else{
				bookList = bookList.concat(",", book + "<br/>" + wordCount + "個");
			}
			if(perList != ""){
				perList = perList.concat(",");
			}
			
		}

		if("" == perList || "," == perList.charAt(perList.length - 1)){
			perList = perList.concat(per);
		}else{
			perList = perList.concat("-", per);
		}
	
	}


	ret.runat("body").withdata({
		"#bookList" : bookList,
		"#perList" : perList,
	});


	ret.eval("showTestInfoChatByBook();");

	// ============================================グラフ（右上）============================================
	var selectResult2 = db.select(
		"STUDY",
		"selectStudyInfoList",
		{
		}
	).getArray();

	var dList = "";
	var tkList = "";
	var tmList = "";
	var ptList = "";

	for(var i = 0;i < selectResult2.length;i ++){

		var d = selectResult2[i]["d"];
		var week = selectResult2[i]["week"];
		var tm = selectResult2[i]["tm"];
		var tk = selectResult2[i]["tk"];
		var pt = selectResult2[i]["pt"];

		if(dList == ""){
			dList = dList.concat(d + "\n" + week);
		}else{
			dList = dList.concat(",", d + "\n" + week);
		}
		
		if(tkList == ""){
			tkList = tkList.concat(tk);
		}else{
			tkList = tkList.concat(",", tk);
		}
	
		if(tmList == ""){
			tmList = tmList.concat(tm);
		}else{
			tmList = tmList.concat(",", tm);
		}

		if(ptList == ""){
			ptList = ptList.concat(pt);
		}else{
			ptList = ptList.concat(",", pt);
		}

	}

	ret.runat("body").withdata({
		"#dList" : dList,
		"#tkList" : tkList,
		"#tmList" : tmList,
		"#ptList" : ptList,
	});

	ret.eval("showTestTimeInfoChat();");

	// ============================================グラフ（右中）============================================

	var selectResult3 = db.select(
		"STUDY",
		"selectStudyInfo",
		{
		}
	).getArray();

	var ddList = "";
	var allwordcountList = "";
	var unstudyList = "";
	var studyingList = "";
	var studedList = "";
	var studed_aList = "";
	var studed_bList = "";
	var studed_cList = "";
	var studed_dList = "";

	for(var i = 0;i < selectResult3.length;i ++){

		var dd = selectResult3[i]["dd"];
		var allwordcount = selectResult3[i]["allwordcount"];
		var unstudy = selectResult3[i]["unstudy"];
		var studying = selectResult3[i]["studying"];
		var studed = selectResult3[i]["studed"];

		var studed_a = selectResult3[i]["studed_a"];
		var studed_b = selectResult3[i]["studed_b"];
		var studed_c = selectResult3[i]["studed_c"];
		var studed_d = selectResult3[i]["studed_d"];
		
		if(ddList == ""){
			ddList = ddList.concat(dd);
		}else{
			ddList = ddList.concat(",", dd);
		}

		if(allwordcountList == ""){
			allwordcountList = allwordcountList.concat(allwordcount);
		}else{
			allwordcountList = allwordcountList.concat(",", allwordcount);
		}
	
		if(unstudyList == ""){
			unstudyList = unstudyList.concat(unstudy);
		}else{
			unstudyList = unstudyList.concat(",", unstudy);
		}

		if(studyingList == ""){
			studyingList = studyingList.concat(studying);
		}else{
			studyingList = studyingList.concat(",", studying);
		}

		if(studedList == ""){
			studedList = studedList.concat(studed);
		}else{
			studedList = studedList.concat(",", studed);
		}

		if(studed_aList == ""){
			studed_aList = studed_aList.concat(studed_a);
		}else{
			studed_aList = studed_aList.concat(",", studed_a);
		}

		if(studed_bList == ""){
			studed_bList = studed_bList.concat(studed_b);
		}else{
			studed_bList = studed_bList.concat(",", studed_b);
		}

		if(studed_cList == ""){
			studed_cList = studed_cList.concat(studed_c);
		}else{
			studed_cList = studed_cList.concat(",", studed_c);
		}

		if(studed_dList == ""){
			studed_dList = studed_dList.concat(studed_d);
		}else{
			studed_dList = studed_dList.concat(",", studed_d);
		}

	}

	ret.runat("body").withdata({
		"#ddList" : ddList,
		"#allwordcountList" : allwordcountList,
		"#unstudyList" : unstudyList,
		"#studyingList" : studyingList,
		"#studedList" : studedList,
		"#studed_aList" : studed_aList,
		"#studed_bList" : studed_bList,
		"#studed_cList" : studed_cList,
		"#studed_dList" : studed_dList
	});

	ret.eval("showWordInfoChat();");

	return ret;

	// var selectResult1 = db.select(
	// 	"STUDY",
	// 	"searchAllWordTestInfo",
	// 	{
	// 	}
	// ).getArray();


	// var resultHTML2 =
	// "<tr style='height: 30px; {display}' class='dt'>" +
	// 	"<td class='l' onclick='{click}'><span class='l5'>{book}</span></td>" +
	// 	"<td class='l {sub}'><span class='l5'>{kind}</span></td>" +
	// 	"<td class='l {sub}'><span class='l5'>{level}</span></td>" +
	// 	"<td class='r {sub}'><span class='r5'>{word_ct}</span></td>" +
	// 	"<td class='r {sub}'><span class='r5'>{c_ct}</span></td>" +
	// 	"<td class='r {sub}'><span class='r5'>{i_ct}</span></td>" +
	// 	"<td class='r {sub}'><span class='r5'>{w_ct}</span></td>" +
	// 	"<td class='r {sub}'><span class='r5'>{per}</span></td>" +
	// "</tr>";

	// ret.runat("#testwordinfotable").remove(".dt").append(resultHTML2).withdata(selectResult1);


	// //  检索
	// var selectResult1 = db.select(
	// 	"STUDY",
	// 	"searchWordTestInfoByBook",
	// 	{
	// 	}
	// ).getArray();

	// var resultHTML1 =
	// "<tr style='height: 30px;' class='dt'>" +
	// 	"<td class='l' onclick='openDetail(this);'><span class='l5'>{book}</span></td>" +
	// 	"<td class='l'><span class='l5'>{kind}</span></td>" +
	// 	"<td class='l'><span class='l5'>{level}</span></td>" +
	// 	"<td class='r'><span class='r5'>{word_ct}</span></td>" +
	// 	"<td class='r'><span class='r5'>{c_ct}</span></td>" +
	// 	"<td class='r'><span class='r5'>{i_ct}</span></td>" +
	// 	"<td class='r'><span class='r5'>{w_ct}</span></td>" +
	// 	"<td class='r'><span class='r5'>{per}</span></td>" +
	// "</tr>";

	// var resultHTML2 =
	// "<tr style='height: 30px; display: none;' class='dt'>" +
	// 	"<td class='l'><span class='l5'>{book}</span></td>" +
	// 	"<td class='l sub'><span class='l5'>{kind}</span></td>" +
	// 	"<td class='l sub'><span class='l5'>{level}</span></td>" +
	// 	"<td class='r sub'><span class='r5'>{word_ct}</span></td>" +
	// 	"<td class='r sub'><span class='r5'>{c_ct}</span></td>" +
	// 	"<td class='r sub'><span class='r5'>{i_ct}</span></td>" +
	// 	"<td class='r sub'><span class='r5'>{w_ct}</span></td>" +
	// 	"<td class='r sub'><span class='r5'>{per}</span></td>" +
	// "</tr>";

	// ret.runat("#testwordinfotable").remove(".dt");

	// for(var i = 0;i < selectResult1.length;i ++){

	// 	var record = new Record([selectResult1[i]]).getArray();

	// 	ret.runat("#testwordinfotable").append(resultHTML1).withdata(record);
	// 	var book  = selectResult1[i]["book"];
	// 	var level = selectResult1[i]["level"];

	// 	// 检索
	// 	var selectResult2 = db.select(
	// 		"STUDY",
	// 		"searchWordTestInfo",
	// 		{
	// 			book : book,
	// 			level : level
	// 		}
	// 	).getArray();

	// 	ret.runat("#testwordinfotable").append(resultHTML2).withdata(selectResult2);

	// }

	// var selectResult3 = db.select(
	// 	"STUDY",
	// 	"selectStudyInfoList",
	// 	{
	// 	}
	// ).getArray();

	// for(var i = 0; i < selectResult3.length; i++){

	// 	var record = new Record([selectResult3[i]]).getArray();


	// 	  // 使用示例
	// 	  const analysis = analyzeTimeRanges(selectResult3[i]["ranges"]);
	// 	  // var rangeStr = "";
	// 	  // // 格式化输出
	// 	  // analysis.forEach(item => {
	// 	  //
	// 		// rangeStr = rangeStr + item.start + "～" + item.end + "　" + item.interval + "<br>";
	// 	  //
	// 	  // });
	// 	var rangeStr = "";
	// 	for (var j = 0; j < analysis.length; j++) {
	// 		var item = analysis[j];
	// 		rangeStr += item.start + "～" + item.end + "　" + item.interval + "<br>";
	// 	}
	// 	var resultHTML3 =
	// 	"<tr style='height: 30px;' class='dt'>" +
	// 		"<td class='c'><span>{t}&nbsp;({w})</span></td>" +
	// 		//"<td class='c'><span>{w}</span></td>" +
	// 		"<td class='c'>" +
	// 			"<span >{costtime1}:{costtime2}:{costtime3}</span> / " +
	// 			"<span style='color:red;'>{costtime}</span>" + "<br>" +
	// 			"<span style='color:blue;'>" + rangeStr + "</span>" +
	// 		"</td>" +
	// 		"<td class='r'><span class='r5'>{tk}</span></td>" +
	// 	"</tr>";

	// 	if(i == 0){
	// 		ret.runat("#testwordinfotable2").remove(".dt").append(resultHTML3).withdata(record);
	// 	}else{
	// 		ret.runat("#testwordinfotable2").append(resultHTML3).withdata(record);
	// 	}

	// }

	
	// return ret.eval("changeColor();");

};

function analyzeTimeRanges(timeStr) {
	// 1. 解析原始字符串为时间范围数组
	var timeRanges = timeStr.split(',').map(function(segment) {
	  var parts = segment.split('～');
	  return {
		start: parts[0].trim(),
		end: parts[1].trim()
	  };
	});

	// 2. 计算持续时间和间隔
	var result = [];
	var previousEnd = null;

	timeRanges.forEach(function(range, index) {
	  // 计算当前时间段持续时间（秒）
	  var duration = timeToSeconds(range.end) - timeToSeconds(range.start);

	  // 计算与前一个时间段的间隔（第一个时间段没有前一个间隔）
	  var interval = index === 0 ? null :
				   timeToSeconds(range.start) - timeToSeconds(previousEnd);

	  // 构建结果对象
	  var rangeInfo = {
		index: index + 1,
		start: range.start,
		end: range.end,
		duration: secondsToTime(duration),
		interval: interval === null ? '00:00:00' : secondsToTime(interval)
	  };

	  result.push(rangeInfo);
	  previousEnd = range.end;
	});

	return result;
  }

  // 辅助函数：将时间字符串转换为秒数
  function timeToSeconds(timeStr) {
	var parts = timeStr.split(':');
	var hh = parseInt(parts[0], 10);
	var mm = parseInt(parts[1], 10);
	var ss = parseInt(parts[2], 10);
	return hh * 3600 + mm * 60 + ss;
  }

  // 辅助函数：将秒数转换为 HH:MM:SS 格式
  function secondsToTime(seconds) {
	var hh = Math.floor(seconds / 3600);
	var remaining = seconds % 3600;
	var mm = Math.floor(remaining / 60);
	var ss = remaining % 60;

	// 补零操作
	hh = hh < 10 ? "0" + hh : hh.toString();
	mm = mm < 10 ? "0" + mm : mm.toString();
	ss = ss < 10 ? "0" + ss : ss.toString();

	return hh + ":" + mm + ":" + ss;
  }
  
