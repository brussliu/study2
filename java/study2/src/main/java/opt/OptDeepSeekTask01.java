package opt;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Map;

import org.apache.log4j.Logger;

import com.fasterxml.jackson.databind.ObjectMapper;

import db.DBManager;
import deepseek.DeepSeekClient;
import deepseek.task01.Question;

public class OptDeepSeekTask01{
	
	private Logger logger = Logger.getLogger(OptDeepSeekTask01.class);

	private static final String APP_KEY = "sk-fb2d67c97e1049dcab8292aad67afaad";
	 
	private static final ObjectMapper mapper = new ObjectMapper();
	
	
	public void excute(String[] parameter) throws Exception {

		logger.info("==================OptDeepSeekTask1.excute実行開始！==================");
        
		String book = parameter[0];
		String classification = parameter[1];
		String wordseq = parameter[2];
		String word = parameter[3];
		
		String taskAnswer = String.join("\n",
		        "请用[" + word + "]这个词出一个英译中的六选一的选择题，中间有一个正确答案和五个混淆项。以JSON格式返回：",
		        "{",
		        "  \"question\": \"题目内容\",",
		        "  \"options\": {",
		        "    \"A\": \"选项A\",",
		        "    \"B\": \"选项B\",",
		        "    \"C\": \"选项C\",",
		        "    \"D\": \"选项D\"",
		        "    \"E\": \"选项E\"",
		        "    \"F\": \"选项F\"",
		        "  },",
		        "  \"answer\": \"正确答案选项\",",
		        "  \"analysis\": \"解析内容\"",
		        "}",
		        "只返回JSON，不要其他文字。"
		);
		
        DeepSeekClient client = new DeepSeekClient(APP_KEY);
        
        try {
        	logger.info("DeepSeekの質問：" + taskAnswer);
            String response = client.chatCompletion(taskAnswer);
            logger.info("DeepSeekの回答：" + response);
            
            handleResponse(book, classification, wordseq, response);
            
        } catch (IOException e) {
            e.printStackTrace();
        }
	
        logger.info("==================OptDeepSeekTask1.excute実行終了！==================");
	}

	private void handleResponse(String book, String classification, String wordseq, String response) {
		
		
		try {

			Question question = mapper.readValue(response, Question.class);

			String answerNo = question.getAnswer();
			
			Map<String, String> itemMap = question.getOptions();
			String rightItem = itemMap.get(answerNo);
			
			itemMap.remove(answerNo);
			
			ArrayList<String> wrongItemList = new ArrayList<String>();
			
			for (Map.Entry<String, String> entry : itemMap.entrySet()) {
			    //String key = entry.getKey();
			    String value = entry.getValue();
			    wrongItemList.add(value);
			}
			
			StringBuffer updateSQL = new StringBuffer();
			updateSQL.append("UPDATE \"STY_単語情報\" ").append("\r\n");
			updateSQL.append("SET ").append("\r\n");
			if (!"".equals(rightItem) && rightItem != null) {
				updateSQL.append("\"中国語_正解\" = '" + rightItem + "', ").append("\r\n");
			}
			if (wrongItemList.size() >= 1 && !"".equals(wrongItemList.get(0)) && wrongItemList.get(0) != null) {
				updateSQL.append("\"中国語_誤解1\" = '" + wrongItemList.get(0) + "', ").append("\r\n");
			}
			if (wrongItemList.size() >= 2 && !"".equals(wrongItemList.get(1)) && wrongItemList.get(1) != null) {
				updateSQL.append("\"中国語_誤解2\" = '" + wrongItemList.get(1) + "', ").append("\r\n");
			}
			if (wrongItemList.size() >= 3 && !"".equals(wrongItemList.get(2)) && wrongItemList.get(2) != null) {
				updateSQL.append("\"中国語_誤解3\" = '" + wrongItemList.get(2) + "', ").append("\r\n");
			}
			if (wrongItemList.size() >= 4 && !"".equals(wrongItemList.get(3)) && wrongItemList.get(3) != null) {
				updateSQL.append("\"中国語_誤解4\" = '" + wrongItemList.get(3) + "', ").append("\r\n");
			}
			if (wrongItemList.size() >= 5 && !"".equals(wrongItemList.get(4)) && wrongItemList.get(4) != null) {
				updateSQL.append("\"中国語_誤解5\" = '" + wrongItemList.get(4) + "' ").append("\r\n");
			}
			
			updateSQL.append("WHERE ").append("\r\n");
			updateSQL.append("\"書籍\" = '" + book + "' AND ").append("\r\n");
			updateSQL.append("\"分類\" = '" + classification + "' AND ").append("\r\n");
			updateSQL.append("\"単語SEQ\" = '" + wordseq + "' AND ").append("\r\n");
			updateSQL.append("\"更新日時\" = CURRENT_TIMESTAMP").append("\r\n");
			logger.info("====================================");
			logger.info(updateSQL.toString());
			logger.info("====================================");
			DBManager.update(updateSQL.toString());
			
			
		} catch (Exception e) {

			e.printStackTrace();
		} 
		
		
//		ArrayList<String> wrongItemList = new ArrayList<String>();
//		String rightItemNo = "";
//		String rightItem = "";
//		
//		// 正確答えを取得
//		String answer = "";
//		String[] answerLine = response.split("正确答案");
//		if(answerLine.length > 1) {
//			answer = response.split("正确答案")[1].trim();
//		}else {
//			answerLine = response.split("答案");
//			answer = response.split("答案")[1].trim();
//			
//		}
		
		
		
//        Pattern pattern = Pattern.compile("[A-F]");
//        Matcher matcher = pattern.matcher(answer);
//
//        if (matcher.find()) {
//        	rightItemNo = matcher.group();
//        	logger.info("解析的正确答案No是【" + rightItemNo + "】");
//        } else {
//        	logger.error("解析失败！");
//        }
        
//        logger.info("====================================");
//		String[] responseArray = response.split("\\n");
//
//		for(int i = 0;i < responseArray.length; i ++) {
//			
//			String res = responseArray[i];
//			
//			if (res.matches("[A-F][\\)\\.].*") && res.startsWith(rightItemNo)) {
//                Pattern pattern1 = Pattern.compile("[\\u4e00-\\u9fa5]+");
//                Matcher matcher1 = pattern1.matcher(res);
//
//                while (matcher1.find()) {
//                	rightItem = matcher1.group();
//                	logger.info("解析的正确答案是【" + rightItem + "】");
//                	break;
//                }
//			}
//			
//            if (res.matches("[A-F][\\)\\.].*") && !res.startsWith(rightItemNo)) {
//            	
//                Pattern pattern2 = Pattern.compile("[\\u4e00-\\u9fa5]+");
//                Matcher matcher2 = pattern2.matcher(res);
//
//                while (matcher2.find()) {
//                	wrongItemList.add(matcher2.group());
//                	logger.info("解析的错误答案是【" + matcher2.group() + "】");
//                	break;
//                	
//                }
//            }
//			
//		}
		

		
	}
	
}
