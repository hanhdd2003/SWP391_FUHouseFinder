package com.fuhousefinder.entity;

import com.fuhousefinder.dao.OrderDAO;

public class BookingOrderModel {

    private Order order;
    private Tenant tenant;
    private HouseModel house;
    private RoomModel roomModel;
    private LandlordMder landlord;

    public BookingOrderModel() {
    }

    public BookingOrderModel(Order order, Tenant tenant, HouseModel house, RoomModel roomModel, LandlordMder landlord) {
        this.order = order;
        this.tenant = tenant;
        this.house = house;
        this.roomModel = roomModel;
        this.landlord = landlord;
    }

    public Order getOrder() {
        return order;
    }

    public Tenant getTenant() {
        return tenant;
    }

    public HouseModel getHouse() {
        return house;
    }

    public RoomModel getRoomModel() {
        return roomModel;
    }

    public LandlordMder getLandlord() {
        return landlord;
    }

    public void setOrder(Order order) {
        this.order = order;
    }

    public void setTenant(Tenant tenant) {
        this.tenant = tenant;
    }

    public void setHouse(HouseModel house) {
        this.house = house;
    }

    public void setRoomModel(RoomModel roomModel) {
        this.roomModel = roomModel;
    }

    public void setLandlord(LandlordMder landlord) {
        this.landlord = landlord;
    }

    public boolean roomBookedByOther(){
        int roomId =  order.getRoomID();
        int tenantId = order.getTenantID();
        OrderDAO dao = new OrderDAO();
        return dao.checkRoomBookedByOther(tenantId, roomId);     
    }
 
}
