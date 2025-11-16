package core;

import com.volcengine.ark.runtime.model.completion.chat.ChatCompletionRequest;
import com.volcengine.ark.runtime.model.completion.chat.ChatMessage;
import com.volcengine.ark.runtime.model.completion.chat.ChatMessageRole;
import com.volcengine.ark.runtime.service.ArkService;
import common.PropertiesReader;
import db.DBManager;
import opt.AbstractBusinessTask;
import org.apache.log4j.Logger;
import util.HtmlUtil;

import java.util.ArrayList;
import java.util.List;

/**
 * 继承抽象父类，实现使用Doubao SDK生成选择题的标准化流程
 */
public class OptTask02 extends AiTaskExecutor {
    private Logger logger = Logger.getLogger(OptTask02.class);
    String key;
    @Override
    protected String makePrompt() {
        // 参数解析
        String word = parameter[3];
        String wordFlg = "英文单词";
        String key;
        if (word.contains(" ")) {
            wordFlg = "英文短语";
        }
        String taskAnswer =  "请讲解一下[" + word + "]这个" + wordFlg + "。";

        return taskAnswer ;
    }


    @Override
    protected String callAPI(String prompt) throws Exception {
        // 调用Doubao API
        AiClient client = AiClientFactory.getClient(parameter[5]);

        logger.info("ai连接成功");
        // 获取响应内容
        return client.call(prompt);
    }

    @Override
    protected Object analyzeResponse(String rawResponse) {
        logger.info("ai执行成功");
        try {
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