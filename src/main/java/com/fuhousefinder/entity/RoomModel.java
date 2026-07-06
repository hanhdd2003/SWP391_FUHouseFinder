package com.fuhousefinder.entity;

import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

/**
 *
 * @author hp
 */
public class RoomModel {

    private int roomId;
    private int houseId;
    private int postId;
    private String roomNumber;
    private String floorNumber;
    private String status;
    private String descriptionRoom;
    private double price;
    private double area;
    private LocalDateTime createDate;
    private LocalDateTime updateDate;

    private List<UtilityModel> utilities;

    public RoomModel(int roomId, String roomNumber) {
        this.roomId = roomId;
        this.roomNumber = roomNumber;
    }

    public RoomModel(int roomId, int houseId, String roomNumber, String status, double price, double area, LocalDateTime createDate, LocalDateTime updateDate) {
        this.roomId = roomId;
        this.houseId = houseId;
        this.roomNumber = roomNumber;
        this.status = status;
        this.price = price;
        this.area = area;
        this.createDate = createDate;
        this.updateDate = updateDate;
    }

    public String getStatusString() {
        return "1".equals(status) ? "Còn phòng" : "Hết phòng";
    }

    public List<UtilityModel> getUtilities() {
        return utilities;
    }

    public String getUtilityString() {
        if (utilities == null || utilities.isEmpty()) {
            return "";
        }
        return utilities.stream()
                .map(UtilityModel::getName)
                .collect(Collectors.joining(" , "));
    }

    public void setUtilities(List<UtilityModel> utilities) {
        this.utilities = utilities;
    }

    public RoomModel(int roomId, int houseId, int postId, String roomNumber, String floorNumber, String status, String descriptionRoom, double price, double area, LocalDateTime createDate, LocalDateTime updateDate) {
        this.roomId = roomId;
        this.houseId = houseId;
        this.postId = postId;
        this.roomNumber = roomNumber;
        this.floorNumber = floorNumber;
        this.status = status;
        this.descriptionRoom = descriptionRoom;
        this.price = price;
        this.area = area;
        this.createDate = createDate;
        this.updateDate = updateDate;
    }

    public RoomModel() {
    }

    public int getRoomId() {
        return roomId;
    }

    public void setRoomId(int roomId) {
        this.roomId = roomId;
    }

    public int getHouseId() {
        return houseId;
    }

    public void setHouseId(int houseId) {
        this.houseId = houseId;
    }

    public int getPostId() {
        return postId;
    }

    public void setPostId(int postId) {
        this.postId = postId;
    }

    public String getRoomNumber() {
        return roomNumber;
    }

    public void setRoomNumber(String roomNumber) {
        this.roomNumber = roomNumber;
    }

    public String getFloorNumber() {
        return floorNumber;
    }

    public void setFloorNumber(String floorNumber) {
        this.floorNumber = floorNumber;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getDescriptionRoom() {
        return descriptionRoom;
    }

    public void setDescriptionRoom(String descriptionRoom) {
        this.descriptionRoom = descriptionRoom;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public double getArea() {
        return area;
    }

    public void setArea(double area) {
        this.area = area;
    }

    public LocalDateTime getCreateDate() {
        return createDate;
    }

    public void setCreateDate(LocalDateTime createDate) {
        this.createDate = createDate;
    }

    public LocalDateTime getUpdateDate() {
        return updateDate;
    }

    public void setUpdateDate(LocalDateTime updateDate) {
        this.updateDate = updateDate;
    }

    

}
