package com.fuhousefinder.entity;

import com.fuhousefinder.dao.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;


public class Order {
    private int orderID;
    private int tenantID;
    private int landlordID;
    private String status;
    private int roomID;
    private LocalDateTime orderDate;
    private String note;
    private String roomName;
    private boolean isConfirm;
    public Order() {
    }

    public Order(int orderID, int tenantID, int landlordID, String status, int roomID, LocalDateTime orderDate, String note) {
        this.orderID = orderID;
        this.tenantID = tenantID;
        this.landlordID = landlordID;
        this.status = status;
        this.roomID = roomID;
        this.orderDate = orderDate;
        this.note = note;
    }

    public int getOrderID() {
        return orderID;
    }

    public void setOrderID(int orderID) {
        this.orderID = orderID;
    }

    public int getTenantID() {
        return tenantID;
    }

    public void setTenantID(int tenantID) {
        this.tenantID = tenantID;
    }

    public int getLandlordID() {
        return landlordID;
    }

    public void setLandlordID(int landlordID) {
        this.landlordID = landlordID;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public int getRoomID() {
        return roomID;
    }

    public void setRoomID(int roomID) {
        this.roomID = roomID;
    }

    public String getOrderDate() {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd-MM-yyyy");
        return orderDate.format(formatter);
    }

    public void setOrderDate(LocalDateTime orderDate) {
        this.orderDate = orderDate;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }
    public String getRoomNameByRoomID(int roomID){
        IRoom roomDAO = new RoomDao();
        roomName = roomDAO.getRoomNameByRoomID(roomID);
        return roomName;
    }

    public String getRoomName() {
        return roomName;
    }

    public void setRoomName(String roomName) {
        this.roomName = roomName;
    }

    public boolean isIsConfirm() {
        return isConfirm;
    }

    public void setIsConfirm(boolean isConfirm) {
        this.isConfirm = isConfirm;
    }
    
}
