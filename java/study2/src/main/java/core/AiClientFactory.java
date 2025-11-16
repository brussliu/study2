package core;

import common.PropertiesReader;
import org.apache.log4j.Logger;

import java.io.IOException;
import java.io.InputStream;
import java.util.Locale;
import java.util.Properties;
import common.PropertiesReader;
//工厂类
public class AiClientFactory {

    static Logger logger = Logger.getLogger(AiClientFactory.class);
    public static AiClient getClient(String ai) {
        ApiConfig apiConfig = null;
        InputStream input = null;
        try {

            logger.info("导入参数文件成功");
            logger.info("AI开始连接");

            switch (ai.toLowerCase()){
                       case "deepseek" :
                           apiConfig = new ApiConfig(ai ,PropertiesReader.DEEPSEEK_MODEL,PropertiesReader.DEEPSEEK_APIKEY,PropertiesReader.DEEPSEEK_URL);

                           return new DeepSeekAiClient(apiConfig);
                       case "doubao" :
                           apiConfig = new ApiConfig(ai ,PropertiesReader.DOUBAO_MODEL,PropertiesReader.DOUBAO_APIKEY,PropertiesReader.DOUBAO_URL);

                           return new DoubaoAiClient(apiConfig);
                       default:
                           throw new IllegalArgumentException("暂未导入: " + ai);}

                }
        catch (Exception ex){
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
        logger.info("ai暂未导入");
        return null;
    }


}
