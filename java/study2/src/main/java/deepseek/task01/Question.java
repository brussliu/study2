package deepseek.task01;

public class Question {
	
    private String question;
    private java.util.Map<String, String> options;
    private String answer;
    private String analysis;
    
    // getters and setters
    public String getQuestion() { return question; }
    public void setQuestion(String question) { this.question = question; }
    
    public java.util.Map<String, String> getOptions() { return options; }
    public void setOptions(java.util.Map<String, String> options) { this.options = options; }
    
    public String getAnswer() { return answer; }
    public void setAnswer(String answer) { this.answer = answer; }
    
    public String getAnalysis() { return analysis; }
    
    public void setAnalysis(String analysis) { this.analysis = analysis; }
    
}
