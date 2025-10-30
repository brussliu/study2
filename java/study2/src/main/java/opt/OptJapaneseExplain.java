package opt;

import org.apache.log4j.Logger;

import com.deepl.api.DeepLClient;
import com.deepl.api.DeepLException;
import com.deepl.api.TextResult;

import common.PropertiesReader;


public class OptJapaneseExplain{
	
	Logger logger = Logger.getLogger(OptJapaneseExplain.class);
	
	public void excute(String[] parameter) throws Exception {
		
		logger.info("==================OptJapaneseExplain.excute実行開始！==================");

		String book = parameter[0];
		String classification = parameter[1];
		String wordseq = parameter[2];
		String englishContent = parameter[3];
		String div = parameter[4];
		String content = getJanpaneseExplainByAPI2(englishContent);
		if (content == null) {
			logger.info("API-2で日本語取得失敗しました。[" + book + "][" + classification + "][" + wordseq + "]【" + englishContent + "】");
		}else if (content != null && !"".equals(content)) {
			updateWordInfo(book, classification, wordseq, div, content);
		}
		
		logger.info("==================OptJapaneseExplain.excute実行終了！==================");
	}


	private String getJanpaneseExplainByAPI2(String englishContent) throws DeepLException, InterruptedException {
		
		DeepLClient client = new DeepLClient(PropertiesReader.JP_EXP_APP_KEY);
		TextResult result = client.translateText(englishContent, "EN", "JA");
		String content = result.getText();
		return content;
		
	}

	private void updateWordInfo(String book, String classification, String wordseq, String div, String content) {
		
		content = content.replaceAll("'", "''");
		StringBuffer sql = new StringBuffer();
		sql.append("UPDATE \"STY_単語情報\" ").append("\r\n");
		sql.append("SET ").append("\r\n");
		if ("word".equals(div)) {
		  sql.append("\"単語_日本語\" = '" + content + "' ").append("\r\n");
		} else if ("sen1".equals(div)) {
		  sql.append("\"例句1_日本語\" = '" + content + "' ").append("\r\n");
		} else if ("sen2".equals(div)) {
		  sql.append("\"例句2_日本語\" = '" + content + "' ").append("\r\n");
		} 
		sql.append("WHERE ").append("\r\n");
		sql.append("\"書籍\" = '" + book + "' AND ").append("\r\n");
		sql.append("\"分類\" = '" + classification + "' AND ").append("\r\n");
		sql.append("\"単語SEQ\" = " + wordseq + " ").append("\r\n");
		
		//DBManager.update(sql.toString());
		System.out.println(sql.toString());
	}

  
//  private String getJanpaneseExplainByAPI1(String englishContent) throws IOException {
//    englishContent = englishContent.replaceAll(" ", "").replaceAll("'", "").replaceAll("～", "");
//
//    
//    URL url = new URL("https://api.excelapi.org/dictionary/enja?word=" + englishContent);
//    HttpURLConnection connection = (HttpURLConnection)url.openConnection();
//    
//    connection.setRequestMethod("GET");
//    
//    int responseCode = connection.getResponseCode();
//    
//    if (responseCode == 200) {
//      
//      BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(connection.getInputStream(), "UTF-8"));
//      
//      StringBuilder response = new StringBuilder();
//      String inputLine;
//      while ((inputLine = bufferedReader.readLine()) != null) {
//        response.append(inputLine);
//      }
//      bufferedReader.close();
//      
//      System.out.println(response.toString());
//      return response.toString();
//    } 
//
//
//    
//    BufferedReader in = new BufferedReader(new InputStreamReader(connection.getErrorStream()));
//    String errorMessage = in.readLine();
//    in.close();
//    
//    System.out.println(errorMessage);
//    
//    return null;
//  }

}
