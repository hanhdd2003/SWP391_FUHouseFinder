package com.fuhousefinder.dao;

import com.fuhousefinder.entity.*;
import java.util.List;

/**
 *
 * @author hp
 */
public interface IRoom {

    public List<RoomModel> listRoomsByHouseId(int houseId);

    public int addRoom(int houseId, String roomNumber, boolean status, double price, double area);

    public boolean updateRoom(RoomModel room);

    public RoomModel getRoomById(String roomId);

    public List<UtilityModel> getAllUtilities();

    public void addRoomUtility(int roomId, int utilityId);

    public boolean deleteRooms(int houseId, int roomId);

    public List<RoomModel> getRoomss(String houseid);

    public boolean checkRoomNumberExists(int houseId, String roomNumber);

    public boolean updateRoomStatus(int roomId, String status);

    public RoomModel getRoomDetailOrderByTenant(int roomID);

    public String getHouseNameByRoomID(int roomID);

    public String getRoomNameByRoomID(int roomID);

    public String getLandlordNameByLandlordID(int landlordID);

    public void updateRoomStatus(int roomID);

}
