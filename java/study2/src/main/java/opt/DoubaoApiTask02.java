package opt;

import com.volcengine.ark.runtime.model.completion.chat.ChatCompletionRequest;
import com.volcengine.ark.runtime.model.completion.chat.ChatMessage;
import com.volcengine.ark.runtime.model.completion.chat.ChatMessageRole;
import com.volcengine.ark.runtime.service.ArkService;
import common.PropertiesReader;
import db.DBManager;
import util.HtmlUtil;

import org.apache.log4j.Logger;
import com.fasterxml.jackson.databind.ObjectMapper;
import java.util.ArrayList;
import java.util.List;

/**
 * 继承抽象父类，实现使用Doubao SDK生成选择题的标准化流程
 */
public class DoubaoApiTask02 extends AbstractBusinessTask {
    private Logger logger = Logger.getLogger(DoubaoApiTask02.class);
    private   String API_KEY = PropertiesReader.DOUBAO_APIKEY;
    private   String BASE_URL  = PropertiesReader.DOUBAO_URL ;
    private   String API_MODEL  = PropertiesReader.DOUBAO_MODEL;
    private String key; // 任务标识（从参数中获取）

    @Override
    protected String makePrompt() {
        //
        // this.API_KEY = PropertiesReader.DOUBAO_APIKEY;
        // this.BASE_URL = PropertiesReader.DOUBAO_URL;
        // this.API_MODEL = PropertiesReader.DOUBAO_MODEL;

        // 参数解析
        String word = parameter[3];
        String wordFlg = "英文单词";
        if (word.contains(" ")) {
            wordFlg = "英文短语";
        }
        String taskAnswer =  "请讲解一下[" + word + "]这个" + wordFlg + "。";

        return taskAnswer ;
    }

    @Override
    protected Object configureAPI() {
        // 配置ArkService客户端
        logger.info("Doubao2 SDK开始连接");
        System.out.println(API_KEY);
        System.out.println(BASE_URL);

        return ArkService.builder()
                .apiKey(API_KEY)
                .baseUrl(BASE_URL)
                .build();
    }

    @Override
    protected Object callAPI(String prompt, Object apiConfig) throws Exception {
        // 调用Doubao API
        ArkService arkService = (ArkService) apiConfig;
        
        // 初始化消息列表
        List<ChatMessage> chatMessages = new ArrayList<>();
        ChatMessage userMessage = ChatMessage.builder()
                .role(ChatMessageRole.USER)
                .content(prompt)
                .build();
        chatMessages.add(userMessage);

        // 创建聊天完成请求
        ChatCompletionRequest request = ChatCompletionRequest.builder()
                .model(API_MODEL)
                .messages(chatMessages)
                .build();

        logger.info("Doubao SDK调用成功");
        // 获取响应内容
        return arkService.createChatCompletion(request)
                .getChoices()
                .get(0)
                .getMessage()
                .getContent();
    }

    @Override
    protected Object analyzeResponse(String rawResponse) {
        // 解析JSON响应为Question对象
        try {
              
            // String html = HtmlUtil.toHtml(rawResponse);
          logger.info("解析响应内容: " + rawResponse);
            return HtmlUtil.toHtml(rawResponse);
        } catch (Exception e) {
            logger.error("响应解析失败", e);
            throw new RuntimeException("响应解析失败", e);
        }
    }

    @Override
    protected void handleResult(Object parsedResult) throws Exception {
        // 从参数获取必要信息
        String book = parameter[0];
        String classification = parameter[1];
        String wordseq = parameter[2];
        

      String sql = "UPDATE \"STY_単語情報\" SET " + 
				"\"AI説明_中国語\" = ? " + 
				"WHERE " +
				"\"書籍\" = ? AND" + 
				"\"分類\" = ? AND" + 
				"\"単語SEQ\" = ? " ;
			
			ArrayList<Object> list = new ArrayList<>();
			list.add(parsedResult);
			list.add(book);
			list.add(classification);
			list.add(Integer.parseInt(wordseq));

			DBManager.update(sql, list);
		
    }

    @Override
    protected void finish() throws Exception {
        // 标记任务完成
        this.key = parameter[4]; // 保存key供finish使用
        String updateSQL = "UPDATE \"COM_JAVA操作情報\" " +
                "SET \"ステータス\" = '完了' " +
                "WHERE \"キー\" = ?";
        
        ArrayList<Object> params = new ArrayList<>();
        params.add(key);
        DBManager.update(updateSQL, params);
    }

    // 保持原execute方法兼容（调用标准化流程）
    public void excute(String[] parameter) throws Exception {
        this.setParameter(parameter);
        this.process();
    }
}