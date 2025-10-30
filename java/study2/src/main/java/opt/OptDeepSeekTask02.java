package opt;

import java.io.IOException;
import java.util.ArrayList;

import org.apache.log4j.Logger;

import db.DBManager;
import deepseek.DeepSeekClient;
import util.HtmlUtil;

public class OptDeepSeekTask02{
	
	private Logger logger = Logger.getLogger(OptDeepSeekTask02.class);

	private static final String APP_KEY = "sk-61603a4dec9e493ba7ce85e24a5e2766";
	 
//	private static final ObjectMapper mapper = new ObjectMapper();
	
	
	public void excute(String[] parameter) throws Exception {

		logger.info("==================OptDeepSeekTask1.excute実行開始！==================");
        
		String book = parameter[0];
		String classification = parameter[1];
		String wordseq = parameter[2];
		String word = parameter[3];
		String key = parameter[4];
		
		String wordFlg = "英文单词";
		if(word.contains(" ")) {
			wordFlg = "英文短语";
		}
		
		String taskAnswer =  "请讲解一下[" + word + "]这个" + wordFlg + "。";
		
        DeepSeekClient client = new DeepSeekClient(APP_KEY);
        
        try {
        	logger.info("DeepSeekの質問：" + taskAnswer);
            String response = client.chatCompletion(taskAnswer);
            logger.info("DeepSeekの回答：" + response);
            
            handleResponse(book, classification, wordseq, response, key);
            
        } catch (IOException e) {
            e.printStackTrace();
        }
	
        logger.info("==================OptDeepSeekTask1.excute実行終了！==================");
	}

	private void handleResponse(String book, String classification, String wordseq, String response, String key) {
		
		
		try {
			
			String html = HtmlUtil.toHtml(response);
			logger.info(html.toString());

//			StringBuffer updateSQL = new StringBuffer();
//			updateSQL.append("UPDATE \"STY_単語情報\" ").append("\r\n");
//			updateSQL.append("SET ").append("\r\n");
//
//			updateSQL.append("\"AI説明_中国語\" = '" + html + "' ").append("\r\n");
//			
//			updateSQL.append("WHERE ").append("\r\n");
//			updateSQL.append("\"書籍\" = '" + book + "' AND ").append("\r\n");
//			updateSQL.append("\"分類\" = '" + classification + "' AND ").append("\r\n");
//			updateSQL.append("\"単語SEQ\" = " + wordseq + " ").append("\r\n");
//			logger.info("====================================");
//			logger.info(updateSQL.toString());
//			logger.info("====================================");
//			DBManager.update(updateSQL.toString());
			
			String sql = "UPDATE \"STY_単語情報\" SET " + 
				"\"AI説明_中国語\" = ? " + 
				"WHERE " +
				"\"書籍\" = ? AND" + 
				"\"分類\" = ? AND" + 
				"\"単語SEQ\" = ? " ;
			
			ArrayList<Object> list = new ArrayList<>();
			list.add(html);
			list.add(book);
			list.add(classification);
			list.add(Integer.parseInt(wordseq));

			DBManager.update(sql, list);
			
			
			
			cancelKey(key);
			
			
		} catch (Exception e) {

			logger.error("STY_単語情報テーブル更新失敗しました。", e);
			e.printStackTrace();
		} 
		
	}

	private void cancelKey(String key) {
		
		try {
			
			StringBuffer updateSQL = new StringBuffer();
			updateSQL.append("UPDATE \"COM_JAVA操作情報\" ").append("\r\n");
			updateSQL.append("SET ").append("\r\n");

			updateSQL.append("\"ステータス\" = '完了' ").append("\r\n");
			
			updateSQL.append("WHERE ").append("\r\n");
			updateSQL.append("\"キー\" = '" + key + "' ").append("\r\n");

			DBManager.update(updateSQL.toString());
			
		} catch (Exception e) {

			logger.error("キー情報更新失敗しました。", e);
			e.printStackTrace();
		} 
		
	}
	
}
