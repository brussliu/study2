package opt;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URL;
import java.nio.file.Files;
import java.nio.file.Paths;

import org.apache.log4j.Logger;

import common.PropertiesReader;

public class OptEnglishVoice{
	
	Logger logger = Logger.getLogger(PropertiesReader.class);
	
	public void excute(String[] parameter) throws Exception {
		  
		logger.info("==================OptEnglishVoice.excute実行開始！==================");
		
		String mp3folder = parameter[0];
		String book = parameter[1];
		String classification = parameter[2];
		String wordseq = parameter[3];
		String content = parameter[4];
		String div = parameter[5];
		
		downloadVoice(mp3folder, book, classification, wordseq, content, div, 0);
		downloadVoice(mp3folder, book, classification, wordseq, content, div, 1);
		
		logger.info("==================OptEnglishVoice.excute実行終了！==================");
	}

	private void downloadVoice(String mp3folder, String book, String classification, String wordseq, String content, String div, int type) throws IOException {
		
		String filePath = mp3folder + "//" + book + "//";
		String fileName = wordseq + "-" + wordseq + "-" + div + ".mp3";
	
		try {
			File folder = new File(filePath);
		  
			if (!folder.exists()) {
				folder.mkdirs();
			}
		
			File file = new File(filePath + fileName);
			if (!file.exists()) {
				URL url = new URL("http://dict.youdao.com/dictvoice?type=" + type + "&audio=" + content);
				
				try (InputStream in = url.openStream();
			             OutputStream out = Files.newOutputStream(Paths.get(filePath + fileName))) {
			            
			            byte[] buffer = new byte[4096];
			            int bytesRead;
			            
			            while ((bytesRead = in.read(buffer)) != -1) {
			                out.write(buffer, 0, bytesRead);
			            }
			            
			            System.out.println("MP3文件下载完成: " + filePath + fileName);
			        }
			}
		
		}catch (Exception e) {
			logger.error("音声取得失敗しました。[" + book + "][" + classification + "][" + wordseq + "]【" + content + "】[" + div + "][" + type + "]");
			logger.error("音声取得失敗しました。", e);
			e.printStackTrace();
			
		}
	}
	
}
