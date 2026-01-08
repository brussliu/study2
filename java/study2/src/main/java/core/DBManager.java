package db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

import common.PropertiesReader;
import org.apache.log4j.Logger;


public class DBManager {
	

	static Logger logger = Logger.getLogger(DBManager.class);
	
	public static Connection connection = null;
			
	public static void connect() {
		
		try {
			if(connection == null || connection.isClosed()) {
				Class.forName("org.postgresql.Driver");
				connection = DriverManager.getConnection(PropertiesReader.DB_URL, PropertiesReader.USER, PropertiesReader.PASS);
			}
		} catch (ClassNotFoundException | SQLException e) {
				logger.error("DB接続時にエラー発生しました！", e);
				e.printStackTrace();
		}
		
	}
	public static ArrayList<HashMap<String, Object>> select(String paramString) {

		PreparedStatement preparedStatement = null;
		ArrayList<HashMap<String, Object>> arrayList = new ArrayList<HashMap<String, Object>>();
		try {
			connect();
			preparedStatement = connection.prepareStatement(paramString);
			ResultSet resultSet = preparedStatement.executeQuery();
			ResultSetMetaData resultSetMetaData = resultSet.getMetaData();
			
			int i = resultSetMetaData.getColumnCount();
			while (resultSet.next()) {
				  
				HashMap<String, Object> hashMap = new HashMap<>();
				byte b;
				for (b = 1; b <= i; b = (byte)(b + 1)) {
					hashMap.put(resultSetMetaData.getColumnName(b), resultSet.getObject(b)); 
				}
				arrayList.add(hashMap);
			}
		} catch (Exception exception) {
			
			logger.error("DB検索時にエラー発生しました！", exception);
			exception.printStackTrace();
		} finally {
			try {
				if (preparedStatement != null)
					preparedStatement.close(); 
				if (connection != null)
					connection.close(); 
			} catch (Exception exception) {
				exception.printStackTrace();
			} 
		} 
	    return arrayList;
	}
  
  
  
  public static void update(String paramString) {

    PreparedStatement preparedStatement = null;

    try {
    	connect();
    	preparedStatement = connection.prepareStatement(paramString);
    	preparedStatement.executeUpdate();
	} catch (Exception exception) {
		logger.error("DB更新時にエラー発生しました！", exception);
      exception.printStackTrace();
    } finally {
		try {
			if (preparedStatement != null)
				preparedStatement.close(); 
			if (connection != null)
				connection.close(); 
		} catch (Exception exception) {
			exception.printStackTrace();
		}
    }
  }
  
  public static void update(String paramString, ArrayList<?> list) {

	    PreparedStatement preparedStatement = null;
	  String finalSql = paramString;
	  try {
	    	connect();
	    	preparedStatement = connection.prepareStatement(paramString);
	    	
	    	for(int i = 0;i < list.size(); i ++) {
	    		
	    		Object param = list.get(i);
	    		
				if (param instanceof String) {
					preparedStatement.setString(i + 1, (String) param);
					finalSql = finalSql.replaceFirst("\\?", "'" + ((String) param).replace("'", "''") + "'");
				}else if (param instanceof Integer) {
					preparedStatement.setInt(i + 1, (int) param);
					finalSql = finalSql.replaceFirst("\\?", param.toString());
				}
	    		
	    	}
		  // 打印最终执行的 SQL（调试关键）
		  logger.info("最终执行的 SQL: " + finalSql);
	    	// preparedStatement.executeUpdate();
		  int affectedRows = preparedStatement.executeUpdate();
		  logger.info("AI質問情報管理表更新成功！影响行数：{"+affectedRows+"}");


			
		} catch (Exception exception) {
			logger.error("DB更新時にエラー発生しました！", exception);
	      exception.printStackTrace();
	    } finally {
			try {
				if (preparedStatement != null)
					preparedStatement.close(); 
				if (connection != null)
					connection.close(); 
			} catch (Exception exception) {
				exception.printStackTrace();
			}
	    }
	  }


	/**
	 * 支持占位符传参的数据库查询方法
	 * @param sqlTemplate 带?占位符的SQL模板（如：SELECT * FROM t WHERE id = ?）
	 * @param params 占位符对应的参数值（可变参数，数量与?个数一致）
	 * @return 结果集：ArrayList<HashMap<String, Object>>，每行是HashMap（列名→值）
	 */
	public static ArrayList<HashMap<String, Object>> select(String sqlTemplate, Object... params) {
		PreparedStatement preparedStatement = null;
		ArrayList<HashMap<String, Object>> resultList = new ArrayList<>(); // 优化变量名，语义更清晰

		try {
			// 1. 建立数据库连接（确保编码为UTF-8）
			connect();

			// 2. 预编译SQL模板（核心：不再传拼接好的SQL，而是带?的模板）
			preparedStatement = connection.prepareStatement(sqlTemplate);

			// 3. 关键修改：设置占位符参数（解决编码/语法错误的核心）
			if (params != null && params.length > 0) {
				for (int paramIndex = 0; paramIndex < params.length; paramIndex++) {
					// PostgreSQL占位符索引从1开始，所以+1
					preparedStatement.setObject(paramIndex + 1, params[paramIndex]);
				}
			}

			// 4. 执行查询（与原逻辑一致）
			ResultSet resultSet = preparedStatement.executeQuery();
			ResultSetMetaData metaData = resultSet.getMetaData();
			int columnCount = metaData.getColumnCount(); // 优化变量名，替代原有的i

			// 5. 解析结果集（与原逻辑一致，仅优化循环变量类型）
			while (resultSet.next()) {
				HashMap<String, Object> rowMap = new HashMap<>();
				// 关键优化：将byte b改为int b（byte范围-128~127，列数用int更合理，避免类型转换问题）
				for (int colIndex = 1; colIndex <= columnCount; colIndex++) {
					// 列名作为key，列值作为value（兼容所有数据类型）
					rowMap.put(metaData.getColumnName(colIndex), resultSet.getObject(colIndex));
				}
				resultList.add(rowMap);
			}

		} catch (Exception exception) {
			// 异常日志补充SQL模板和参数，便于排查问题
			logger.error("DB検索時にエラー発生しました！SQL模板：" + sqlTemplate);
			exception.printStackTrace();
		} finally {
			// 资源关闭（与原逻辑一致，确保连接和Statement释放）
			try {
				if (preparedStatement != null) {
					preparedStatement.close();
				}
				if (connection != null) {
					connection.close();
					connection = null; // 重置连接，避免复用乱码连接
				}
			} catch (Exception exception) {
				logger.error("资源关闭時にエラー発生しました！", exception);
				exception.printStackTrace();
			}
		}
		return resultList;
	}


}
