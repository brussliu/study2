var ai_Answer = {};
ai_Answer.name = "Ai回答";
ai_Answer.paramsFormat = {
	selectedValues : null,
};

ai_Answer.fire = function (params) {

	var ret = new Result();

	// セッションチェック
	if(sessionCheck(ret) == false){return ret};

	var no = params["selectedValues"];

	var selectResult = db.select(
		"AILSSUES",
		"searchAnswerListForNO",
		{
			no:no
		}
	).getArray();

  	// ret.eval("renderMemoComponents('"+selectResult2["memo1"]+"','"+selectResult2["memo2"]+"','"+selectResult2["memo3"]+"','"
	//   +selectResult2["memo4"]+"','"+selectResult2["memo5"]+"','"+selectResult2["state"]+"')");

	ret.runat("body").withdata(
		{

			"#td_no" : "NO:" + selectResult[0]["no"],
			"#no" : selectResult[0]["no"],

			"#text_aireply1" : selectResult[0]["memo1"],
			"#text_aireply2" : selectResult[0]["memo2"],
			"#text_aireply3" : selectResult[0]["memo3"],
			"#text_aireply4" : selectResult[0]["memo4"],
			"#text_aireply5" : selectResult[0]["memo5"]

			// "#hiddenMp3" : null
			
		}
	);

	var htmlString = selectResult[0]["answer"];
	//html = processHTMLContentOptimized(html);

  	// 1. 判断是否包含<code>标签（支持各种属性）
	const codeTagRegex = /<code[^>]*>[\s\S]*?<\/code>/i;
	if (!codeTagRegex.test(htmlString)) {
		ret.runat("#displaydiv").remove("div").append("<div>" + htmlString + "</div>").withdata(selectResult);
		ret.eval( "showMemo();");
		return ret;
	}else{

		// 2. 提取<code>标签中间的内容并转成HTML代码
		// 匹配所有<code>标签及其内容（支持任意属性）
		const fullCodeRegex = /<code[^>]*>([\s\S]*?)<\/code>/gi;
		
		// 替换所有<code>标签中的内容
		const processedHTML = htmlString.replace(fullCodeRegex, function(match, codeContent) {
			// 使用优化版本的解码函数
			const decodedContent = decodeHTMLEntitiesFallback(codeContent.trim());
			return decodedContent;
		});

		ret.runat("#displaydiv").remove("div").append("<div>" + processedHTML + "</div>").withdata(selectResult);
		ret.eval( "showMemo();");


		file.remove("/download/templete.html");
		file.makeFile("/download/templete.html");

		file.writeAllLines("/download/templete.html", processedHTML, "UTF-8");

		// return processedHTML;
		ret.attach("/download/templete.html")
		.saveas(selectResult[0]["no"] + ".html")
		.deleteAfterDownload();

		return ret;

	}
	

};

// 如果需要在不支持DOM的环境下运行，可以使用以下版本：
function decodeHTMLEntitiesFallback(text) {
  const entities = {
    '&lt;': '<',
    '&gt;': '>',
    '&amp;': '&',
    '&quot;': '"',
    '&#39;': "'",
    '&apos;': "'",
    '&#34;': '"',
    '&#x27;': "'",
    '&#x22;': '"',
    '&#60;': '<',
    '&#62;': '>',
    '&#38;': '&',
    '&#x3C;': '<',
    '&#x3E;': '>',
    '&#x26;': '&'
  };
  
  return text.replace(/&(?:[a-z]+|#\d+|#x[a-f\d]+);/gi, function(match) {
    return entities[match] || match;
  });
}

// 使用优化版本
function processHTMLContentOptimized(htmlString) {
  // 1. 判断是否包含<code>标签（支持各种属性）
  const codeTagRegex = /<code[^>]*>[\s\S]*?<\/code>/i;
  if (!codeTagRegex.test(htmlString)) {
    return htmlString;
  }
  
  // 2. 提取<code>标签中间的内容并转成HTML代码
  // 匹配所有<code>标签及其内容（支持任意属性）
  const fullCodeRegex = /<code[^>]*>([\s\S]*?)<\/code>/gi;
  
  // 替换所有<code>标签中的内容
  const processedHTML = htmlString.replace(fullCodeRegex, function(match, codeContent) {
    // 使用优化版本的解码函数
    const decodedContent = decodeHTMLEntitiesFallback(codeContent.trim());
    return decodedContent;
  });
  
  return processedHTML;
}
