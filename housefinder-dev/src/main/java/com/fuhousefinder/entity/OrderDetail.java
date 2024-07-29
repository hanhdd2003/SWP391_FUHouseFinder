package com.fuhousefinder.entity;

public class OrderDetail {

    private Order order;
    private Tenant tenant;
    private String roomName;

    public OrderDetail(Order order, Tenant tenant, String roomName) {
        this.order = order;
        this.tenant = tenant;
        this.roomName = roomName;
    }

    public Order getOrder() {
        return order;
    }

    public void setOrder(Order order) {
        this.order = order;
    }

    public Tenant getTenant() {
        return tenant;
    }

    public void setTenant(Tenant tenant) {
        this.tenant = tenant;
    }

    public String getRoomName() {
        return roomName;
    }

    public void setRoomName(String roomName) {
        this.roomName = roomName;
    }
}
