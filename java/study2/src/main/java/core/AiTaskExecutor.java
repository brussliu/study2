package core;

import org.apache.log4j.Logger;

/**
 * 业务任务抽象父类，定义标准化流程
 */
public abstract class AiTaskExecutor {
    protected Logger logger = Logger.getLogger(this.getClass());
    protected String[] parameter; // 任务参数

    public void setParameter(String[] parameter) {
        this.parameter = parameter;
    }

    /**
     * 模板方法：标准化流程入口
     */
    public final void process() throws Exception {
        logger.info("================== " + this.getClass().getSimpleName() + " 执行开始！==================");

        try {
            // 1. 生成提示词
            String prompt = makePrompt();
            logger.info("生成提示词：" + prompt);



            // 2. 调用API
            String  rawResponse = callAPI(prompt);
            logger.info("API返回原始内容：" + rawResponse);

            // 3. 解析响应
            Object parsedResult = analyzeResponse((String) rawResponse);
            logger.info("响应解析完成");

            // 4. 处理解析结果
            handleResult(parsedResult);
            logger.info("结果处理完成");

            // 4. 处理结束
            finish();
            logger.info("任务结束处理完成");

        } catch (Exception e) {
            logger.error("任务执行异常", e);
            throw e;
        } finally {
            logger.info("================== " + this.getClass().getSimpleName() + " 执行结束！==================");
        }
    }

    /**
     * 1. 生成提示词
     * @return 提示词字符串
     */
    protected abstract String makePrompt();


    /**
     * 2. 调用API
     * @param prompt 提示词
     * @return API原始响应字符串
     */
    protected abstract String  callAPI(String prompt) throws Exception;

    /**
     * 3. 解析响应
     * @param rawResponse API原始响应
     * @return 解析后的结果（可是String、Bean、HTML等）
     */
    protected abstract Object analyzeResponse(String rawResponse) throws Exception;

    /**
     * 4. 处理解析结果（如更新数据库、生成文件等）
     * @param parsedResult 步骤4返回的解析结果
     */
    protected abstract void handleResult(Object parsedResult) throws Exception;

    /**
     * 5. 处理结束（如更新任务状态）
     */
    protected abstract void finish() throws Exception;
}