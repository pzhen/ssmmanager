package cn.zhen.model;

public class Message {
    private Integer code;
    private String message;
    private String url;
    private Object data;

    public Message() {
    }

    public Message(Integer code, String message) {
        this.code = code;
        this.message = message;
    }

    public Message(Integer code, String message, String url) {
        this.code = code;
        this.message = message;
        this.url = url;
    }

    public Message(Integer code, String message, String url, Object data) {
        this.code = code;
        this.message = message;
        this.url = url;
        this.data = data;
    }

    public Object getData() {
        return data;
    }

    public void setData(Object data) {
        this.data = data;
    }

    public Integer getCode() {
        return code;
    }

    public void setCode(Integer code) {
        this.code = code;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }
}
