package com.fuhousefinder.entity;

public class AlertMessage {

    private String message;
    private String type;

    public AlertMessage() {
    }
    
    public AlertMessage(String message, String type) {
        this.message = message;
        this.type = type;
    }

    public String getMessage() {
        return message;
    }

    public String getType() {
        return type;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public void setType(String type) {
        this.type = type;
    }
    
}
