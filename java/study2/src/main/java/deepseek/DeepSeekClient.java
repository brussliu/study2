package deepseek;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.TimeUnit;

import org.apache.log4j.Logger;

import com.fasterxml.jackson.databind.ObjectMapper;

import okhttp3.MediaType;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.RequestBody;
import okhttp3.Response;

public class DeepSeekClient {
	
	private static Logger logger = Logger.getLogger(DeepSeekClient.class);
	
    private static final String API_URL = "https://api.deepseek.com/v1/chat/completions";
    private final String apiKey;
    private final OkHttpClient client;
    private final ObjectMapper objectMapper;

    public DeepSeekClient(String apiKey) {
        this.apiKey = apiKey;
        this.client = new OkHttpClient.Builder()
                .connectTimeout(60, TimeUnit.SECONDS)
                .readTimeout(90, TimeUnit.SECONDS)
                .writeTimeout(60, TimeUnit.SECONDS)
                .build();
        this.objectMapper = new ObjectMapper();
    }
    
    public String chatCompletion(String userMessage) throws IOException {
        List<Message> messages = new ArrayList<>();
        messages.add(new Message("user", userMessage));

        ChatRequest request = new ChatRequest("deepseek-chat", messages);
        String requestBody = objectMapper.writeValueAsString(request);

        Request httpRequest = new Request.Builder()
                .url(API_URL)
                .post(RequestBody.create(requestBody, MediaType.parse("application/json")))
                .addHeader("Authorization", "Bearer " + apiKey)
                .addHeader("Content-Type", "application/json")
                .build();

        try (Response response = client.newCall(httpRequest).execute()) {
            if (!response.isSuccessful()) {
                String errorBody = response.body() != null ? response.body().string() : "";
                throw new IOException("API请求失败: HTTP " + response.code() + " - " + errorBody);
            }

            String responseBody = response.body().string();
            
            // 调试：打印原始响应
            logger.info("原始响应: " + responseBody);
            
            ChatResponse chatResponse = objectMapper.readValue(responseBody, ChatResponse.class);

            if (chatResponse.getChoices() != null && !chatResponse.getChoices().isEmpty()) {
                Message message = chatResponse.getChoices().get(0).getMessage();
                if (message != null && message.getContent() != null) {
                    return message.getContent();
                } else {
                    return "响应内容为空";
                }
            } else {
                return "没有可用的响应选项";
            }
        }
    }
    
    
    
//    public String chatCompletion(String userMessage) throws IOException {
//        List<Message> messages = new ArrayList<>();
//        messages.add(new Message("user", userMessage));
//
//        ChatRequest request = new ChatRequest("deepseek-chat", messages);
//        String requestBody = objectMapper.writeValueAsString(request);
//
//        Request httpRequest = new Request.Builder()
//                .url(API_URL)
//                .post(RequestBody.create(requestBody, MediaType.parse("application/json")))
//                .addHeader("Authorization", "Bearer " + apiKey)
//                .addHeader("Content-Type", "application/json")
//                .build();
//
//        try (Response response = client.newCall(httpRequest).execute()) {
//            if (!response.isSuccessful()) {
//                String errorBody = response.body() != null ? response.body().string() : "";
//                throw new IOException("API请求失败: HTTP " + response.code() + " - " + errorBody);
//            }
//
//            String responseBody = response.body().string();
//            
//            // 调试：打印原始响应
//            System.out.println("原始响应: " + responseBody);
//            
//            ChatResponse chatResponse = objectMapper.readValue(responseBody, ChatResponse.class);
//
//            if (chatResponse.getChoices() != null && !chatResponse.getChoices().isEmpty()) {
//                Message message = chatResponse.getChoices().get(0).getMessage();
//                if (message != null && message.getContent() != null) {
//                    return message.getContent();
//                } else {
//                    return "响应内容为空";
//                }
//            } else {
//                return "没有可用的响应选项";
//            }
//        }
//    }
    
    
}