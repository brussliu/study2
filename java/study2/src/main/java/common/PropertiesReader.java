package common;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

import org.apache.log4j.Logger;

public class PropertiesReader {

	public static String DB_URL;
	public static String USER;
	public static String PASS;
	
	public static String JP_EXP_APP_KEY;
	
	static Logger logger = Logger.getLogger(PropertiesReader.class);
	
	public static void configure(String fileName) {
		
		Properties prop = new Properties();
		InputStream input = null;
		
		  try {
			  input = new FileInputStream(fileName);
			  //input = new FileInputStream("D:\\workspace\\study2\\src\\main\\resources\\config.properties");
			  //input = new FileInputStream("/usr/local/tomcat/webapps/study2/java/config.properties");
			  
			  prop.load(input);
			  
			  // 读取属性值
			  DB_URL = prop.getProperty("db.url");
			  USER = prop.getProperty("db.username");
			  PASS = prop.getProperty("db.password");
			  JP_EXP_APP_KEY = prop.getProperty("appkey.japaneseexplain");
			  
			  logger.info("URL: " + DB_URL);
			  logger.info("Username: " + USER);
			  logger.info("Password: " + PASS);
		      
		  } catch (Exception ex) {
		  	
			  logger.error( "プロパティ読み取りエラー発生しました。", ex);
		  	
		      ex.printStackTrace();
		  } finally {
		      if (input != null) {
		          try {
		              input.close();
		          } catch (IOException e) {
		              e.printStackTrace();
		          }
		      }
		  }
		
	}
//    public PropertiesReader() {
//    	
//    	Logger logger = Logger.getLogger(PropertiesReader.class);
//    	
//    	Properties prop = new Properties();
//        InputStream input = null;
//
//        try {
//        	
//        	input = new FileInputStream("D:\\workspace\\study2\\src\\main\\resources\\config.properties");
//            //input = new FileInputStream("/usr/local/tomcat/webapps/study2/java/config.properties");
//            
//            prop.load(input);
//            
//            // 读取属性值
//            DB_URL = prop.getProperty("db.url");
//            USER = prop.getProperty("db.username");
//            PASS = prop.getProperty("db.password");
//            JP_EXP_APP_KEY = prop.getProperty("appkey.japaneseexplain");
//            
//            logger.info("URL: " + DB_URL);
//            logger.info("Username: " + USER);
//            logger.info("Password: " + PASS);
//            
//        } catch (Exception ex) {
//        	
//        	logger.error( "プロパティ読み取りエラー発生しました。", ex);
//        	
//            ex.printStackTrace();
//        } finally {
//            if (input != null) {
//                try {
//                    input.close();
//                } catch (IOException e) {
//                    e.printStackTrace();
//                }
//            }
//        }
//    	
//    	
//    }
	

	
	
}
