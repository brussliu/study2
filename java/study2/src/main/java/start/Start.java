package start;


import java.lang.reflect.Method;
import java.util.Arrays;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import common.PropertiesReader;

public class Start {

	private static Logger logger = Logger.getLogger(Start.class);
	
	public static PropertiesReader propertiesReader;
	
	  public static void main(String[] args) {
		  propertiesReader.configures();

//		  PropertyConfigurator.configure("/usr/local/tomcat/webapps/study2/java/log4j.properties");
//		  PropertiesReader.configure("/usr/local/tomcat/webapps/study2/java/config.properties")
		  // PropertyConfigurator.configure("D:\\apache-tomcat-9.0.30\\webapps\\study2\\java\\log4j.properties");
		  // PropertiesReader.configure("D:\\apache-tomcat-9.0.30\\webapps\\study2\\java\\config.properties");
//		  PropertiesReader.configure("D:\\workspace\\study2\\src\\main\\resources\\config.properties");
		  
		  // args = new String[7];
		  // args[0] = "OptDeepSeekTask02";
		  // args[1] = "111";
		  // args[2] = "222";
		  // args[3] = "333";
		  // args[4] = "method";
		  // args[5] = "German";
		  // args[6] = "word";
		  
		  logger.info("#####################################################");
		  logger.info(Arrays.toString(args));
		  
		  String opt = args[0];
		  String[] parameter = getParameter(args);
		  excute(opt, parameter);
		  logger.info("#####################################################");
		    
		  }
		  
		  private static void excute(String opt, String[] parameter) {
		    try {
		      Class<?> clazz = Class.forName("opt." + opt);
		      Object instance = clazz.newInstance();
		      Method method = clazz.getMethod("excute", new Class[] { String[].class });
		      method.invoke(instance, new Object[] { parameter });
		    } catch (Exception e) {
		    	
		    	logger.error("システムエラー！", e);
		      e.printStackTrace();
		    } 
		  }
		  
		  private static String[] getParameter(String[] args) {
		    if (args.length <= 1)
		      return null; 
		    String[] newArgs = new String[args.length - 1];
		    for (int i = 1; i < args.length; i++)
		      newArgs[i - 1] = args[i]; 
		    return newArgs;
		  }

}
