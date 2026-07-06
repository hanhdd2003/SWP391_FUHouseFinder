package com.fuhousefinder.entity;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class HistoryOrder {

    private String house_name;
    private int room_number;
    private int house_id;
    private String status;
    private LocalDateTime history_date;

    public HistoryOrder() {
    }

    public HistoryOrder(String house_name, int room_number, int house_id, String status, LocalDateTime history_date) {
        this.house_name = house_name;
        this.room_number = room_number;
        this.house_id = house_id;
        this.status = status;
        this.history_date = history_date;
    }

    public String dateString() {
        DateTimeFormatter format = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm:ss");
        return history_date.format(format);
    }

    public String getStatusString() {
        switch (status) {
            case "Approve":
                return "Đã xác nhận";
            case "Pending":
                return "Đang chờ xác nhận";
            case "CheckOut":
                return "Đã trả phòng";
            case "Reject":
                return "Đã bị từ chối";
            case "Cancel":
                return "Đã hủy";
        }
        return "";
    }

    public String getHouse_name() {
        return house_name;
    }

    public void setHouse_name(String house_name) {
        this.house_name = house_name;
    }

    public int getRoom_number() {
        return room_number;
    }

    public void setRoom_number(int room_number) {
        this.room_number = room_number;
    }

    public int getHouse_id() {
        return house_id;
    }

    public void setHouse_id(int house_id) {
        this.house_id = house_id;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public LocalDateTime getHistory_date() {
        return history_date;
    }

    public void setHistory_date(LocalDateTime history_date) {
        this.history_date = history_date;
    }

}
