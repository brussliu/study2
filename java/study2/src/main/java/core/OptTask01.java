package core;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.volcengine.ark.runtime.model.completion.chat.ChatCompletionRequest;
import com.volcengine.ark.runtime.model.completion.chat.ChatMessage;
import com.volcengine.ark.runtime.model.completion.chat.ChatMessageRole;
import com.volcengine.ark.runtime.service.ArkService;
import common.PropertiesReader;
import db.DBManager;
import deepseek.task01.Question;
import opt.AbstractBusinessTask;
import org.apache.log4j.Logger;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * 继承抽象父类，实现使用Doubao SDK生成选择题的标准化流程
 */
public class OptTask01 extends AiTaskExecutor {
    private Logger logger = Logger.getLogger(OptTask01.class);
    private   String API_KEY = PropertiesReader.DOUBAO_APIKEY;
    private   String BASE_URL  = PropertiesReader.DOUBAO_URL ;
    private   String API_MODEL  = PropertiesReader.DOUBAO_MODEL;
    private static final ObjectMapper mapper = new ObjectMapper();

    @Override
    protected String makePrompt() {
        // 参数解析
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
                "}");
        return taskAnswer;

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
        // 解析JSON响应为Question对象
        try {
            logger.info("解析响应内容: " + rawResponse);
            return mapper.readValue(rawResponse, Question.class);
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

        try {

            Question question = (Question) parsedResult;
            logger.info("question: " + question.toString());
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
    }

    @Override
    protected void finish() throws Exception {

    }

    // 保持原execute方法兼容（调用标准化流程）
    public void excute(String[] parameter) throws Exception {
        this.setParameter(parameter);
        this.process();
    }
}