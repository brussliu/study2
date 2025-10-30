package opt;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

import org.apache.log4j.Logger;
import org.json.JSONObject;

import db.DBManager;

public class OptChineseExplain{

	Logger logger = Logger.getLogger(OptChineseExplain.class);
	
//	private static final String APP_KEY = "332c8c525a2b782d";
//	private static final String APP_SECRET = "uNs1mpkwhX5Che4urqYJhI1DramQLuyG";
//	private static final String FROM = "en";
//	private static final String TO = "zh-CHS";
	  
	public void excute(String[] parameter) throws Exception {

		logger.info("==================OptChineseExplain.excute実行開始！==================");
		String book = parameter[0];
		String classification = parameter[1];
		String wordseq = parameter[2];
		String englishContent = parameter[3];    
		String div = parameter[4];
		String content1 = getChineseExplainByAPI1(englishContent);
	    
		if (content1 == null) {
			logger.error("API-1で中国語取得失敗しました。[" + book + "][" + classification + "][" + wordseq + "]【" + englishContent + "】");
		}
	
//		String content2 = getChineseExplainByAPI2(englishContent);
//		if (content2 == null) {
//			logger.error("API-2で中国語取得失敗しました。[" + book + "][" + classification + "][" + wordseq + "]【" + englishContent + "】");
//	    }
	
	    String content = content1;
	    if (content != null && !"".equals(content)) {
	    	updateWordInfo(book, classification, wordseq, div, content);
	    }
	
	    logger.info("==================OptChineseExplain.excute実行終了！==================");
	}
  
	private void updateWordInfo(String book, String classification, String wordseq, String div, String content) {
		
		content = content.replaceAll("'", "''");
		StringBuffer sql = new StringBuffer();
		sql.append("UPDATE \"STY_単語情報\" ").append("\r\n");
		sql.append("SET ").append("\r\n");
		if ("word".equals(div)) {
			sql.append("\"単語_中国語\" = '" + content + "' ").append("\r\n");
		} else if ("sen1".equals(div)) {
			sql.append("\"例句1_中国語\" = '" + content + "' ").append("\r\n");
		} else if ("sen2".equals(div)) {
			sql.append("\"例句2_中国語\" = '" + content + "' ").append("\r\n");
	    }
		sql.append("WHERE ").append("\r\n");
		sql.append("\"書籍\" = '" + book + "' AND ").append("\r\n");
		sql.append("\"分類\" = '" + classification + "' AND ").append("\r\n");
		sql.append("\"単語SEQ\" = " + wordseq + " ").append("\r\n");

		DBManager.update(sql.toString());
		logger.info(sql.toString());
		
	}

	private String getChineseExplainByAPI1(String englishContent) throws IOException {
		
		englishContent = englishContent.replaceAll(" ", "%20").replaceAll("'", "%27").replaceAll("～", "~");
		
		URL url = new URL("http://dict.youdao.com/suggest?num=1&doctype=json&q=" + englishContent);
		HttpURLConnection connection = (HttpURLConnection)url.openConnection();
		    
		connection.setRequestMethod("GET");
		int responseCode = connection.getResponseCode();
		    
		if (responseCode == 200) {
			BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(connection.getInputStream(), "UTF-8"));
			      
			StringBuilder response = new StringBuilder();
			String inputLine;
			while ((inputLine = bufferedReader.readLine()) != null) {
				response.append(inputLine);
			}
			bufferedReader.close();
			
			JSONObject json = new JSONObject(response.toString());
			      
			String msg = json.getJSONObject("result").getString("msg");
			int code = json.getJSONObject("result").getInt("code");
			      
			if ("success".equals(msg) && code == 200){
				return json.getJSONObject("data").getJSONArray("entries").getJSONObject(0).getString("explain");
			}
			return null;
			
		}else {
			
			BufferedReader in = new BufferedReader(new InputStreamReader(connection.getErrorStream()));
			String errorMessage = in.readLine();
			in.close();
			    
			System.out.println(errorMessage);
			return null;
		}
		
	 }

//	// 有道
//	private String getChineseExplainByAPI2(String englishContent) throws NoSuchAlgorithmException {
//		
//		Map<String, String[]> params = createRequestParams(englishContent);
//		AuthV3Util.addAuthParams(APP_KEY, APP_SECRET, params);
//		byte[] result = HttpUtil.doPost("https://openapi.youdao.com/api", null, params, "application/json");
//		
//		JSONObject json = new JSONObject(new String(result, StandardCharsets.UTF_8));
//		int errorCode = json.getInt("errorCode");
//		if (errorCode == 0){
//			return json.getJSONArray("translation").getString(0);
//		}else {
//			return null;
//		}
//	}


//	private static Map<String, String[]> createRequestParams(String englishContent) {
//		
//		Map<String, String[]> map = (Map<String, String[]>)new HashMap<String, String[]>();
//		map.put("q", new String[] { englishContent });
//		map.put("from", new String[] { FROM});
//		map.put("to", new String[] { TO});
//		return map;
//	}
	
}
