package core;


import db.DBManager;
import org.apache.log4j.Logger;
import util.HtmlUtil;

import java.sql.Connection;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;


public class OptTask03 extends AiTaskExecutor {
    private Logger logger = Logger.getLogger(OptTask03.class);
//    DBManager db = new DBManager();
    // 数据库连接（核心：两次新增共用同一个Connection）
    private Connection connection;
    @Override
    protected String makePrompt() {

        //番号
        String no = parameter[0];
        //用户
        String shopId = parameter[3];

        StringBuffer query = new StringBuffer();
        query.append("SELECT  t.\"プロンプト詳細\" ").append("\r\n");
        query.append("FROM  \"プロンプト情報管理\" t ").append("\r\n");
        query.append("LEFT JOIN \"AI質問情報管理\" t1  ").append("\r\n");
        query.append("ON t.\"プロンプト概要\" = t1.\"プロンプト概要\"  ").append("\r\n");
        query.append("AND t.\"類型\" = t1.\"類型\" ").append("\r\n");
        query.append("AND t1.\"番号\" = ? ").append("\r\n");
        query.append("AND t1.\"登録ID\" =  ? ").append("\r\n");

        ArrayList<HashMap<String, Object>> result = DBManager.select(
                query.toString(),
                no,
                shopId
        );
        logger.info("result:"+result);

        String word = String.valueOf(result.get(0).get("プロンプト詳細"));
        if (word == null || word.isEmpty()) {
            logger.error("查询结果集为空，无法获取索引0的行数据！");
            throw new IllegalStateException("查询结果集为空，无法获取索引0的行数据！");

        }
        logger.info("word:"+word);

        return word ;
    }


    @Override
    protected String callAPI(String prompt)  {
        // 调用AI API
        AiClient client = AiClientFactory.getClient(parameter[1]);

        logger.info("ai连接成功");
        // 获取响应内容
        return client.call(prompt);
    }

    @Override
    protected Object analyzeResponse(String rawResponse) {
        logger.info("ai执行成功");
        String response = null;
        try {
            logger.info("解析响应内容: " + rawResponse);

            if ("文章".equals(parameter[2])) {
                response= rawResponse;
            } else if ("HTML".equals(parameter[2])) {
                response =  HtmlUtil.toHtml(rawResponse);

            } else if ("JSON".equals(parameter[2])) {
                response = rawResponse;
            }
         
        } catch (Exception e) {
            logger.error("响应解析失败", e);
            throw new RuntimeException("响应解析失败", e);


        }
        return response;
    }
    @Override
    protected void handleResult(Object parsedResult)  {
        System.out.println("parsedResult:"+parsedResult);
        // 从参数获取必要信息
        //番号
        String no = parameter[0];

        //ステータス
        String state = "作成済";

        //用户
        String shopId = parameter[3];
        try {

            logger.info("新增开始");
            //更新状态与更新回答内容

            System.out.println("parsedResult："+parsedResult);
            StringBuffer updateSQL = new StringBuffer();
            updateSQL.append("UPDATE \"AI質問情報管理\" ").append("\r\n");
            updateSQL.append("SET ").append("\r\n");
            updateSQL.append("\"回答\" = '" + parsedResult + "', ").append("\r\n");
            updateSQL.append("\"ステータス\" = '" + state + "', ").append("\r\n");
            updateSQL.append("\"更新ID\" = '" + shopId + "', ").append("\r\n");
            updateSQL.append("\"更新日時\" =  to_timestamp(CAST(CURRENT_TIMESTAMP AS text), 'YYYY-MM-DD HH24:MI:SS')  ").append("\r\n");

            updateSQL.append("WHERE ").append("\r\n");
            updateSQL.append("\"番号\" = '" + no + "' AND ").append("\r\n");
            updateSQL.append("\"登録ID\" = '" + shopId + "'  ").append("\r\n");
            logger.info("updateSQL:"+updateSQL);
            logger.info("====================================");
            DBManager.update(updateSQL.toString());
            System.out.println("no:"+no);
            System.out.println("shopId:"+shopId);
            System.out.println("state:"+state);
            System.out.println("parsedResult:"+parsedResult);

            Date date = new Date();
            SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
            System.out.println("修改结束时间:"+formatter.format(date));

            //     ArrayList<String> list2 = new ArrayList<>();
            //     list2.add((String) parsedResult);
            //     list2.add(state);
            //     list2.add(shopId);
            //     list2.add(no);
            //     list2.add(shopId);
                // System.out.println(list2);
            // list2.add("1+1");
            // list2.add("state");
            // list2.add("Smart-Bear");
            // list2.add("20251202-204747");
            // list2.add("Smart-Bear");
                //
                // DBManager.update(sql2, list2);

            // System.out.println("sql:"+sql);
            // ArrayList<HashMap<String, Object>> select = DBManager.select(sql);
            // System.out.println("select:"+select);

                logger.info("更新AI質問情報管理成功");
        }catch (Exception e){
                // 5. 任意一次失败，手动回滚事务
            e.printStackTrace();
            logger.error("更新失败", e);
        }
    }

    @Override
    protected void finish()  {

        logger.info("流程结束");
    }

    // 保持原execute方法兼容（调用标准化流程）
    public void excute(String[] parameter) throws Exception {
        this.setParameter(parameter);
        this.process();
    }

    public static String replaceLineBreakToEscape(String rawStr) {
        if (rawStr == null) {
            return "";
        }
        // 步骤1：统一换行符（先将所有换行格式转为\n）
        String unifiedStr = rawStr.replaceAll("\r\n", "\n").replaceAll("\r", "\n");
        // 步骤2：将\n替换为显式的\r\n转义字符串（注意双反斜杠转义）
        return unifiedStr.replaceAll("\n", "\\r\\n");
    }
}