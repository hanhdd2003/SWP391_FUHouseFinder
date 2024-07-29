package com.fuhousefinder.dao;

import com.fuhousefinder.entity.*;
import java.sql.SQLException;
import java.util.List;

/**
 *
 * @author hp
 */
public interface IHousIe {

    public List<PropertyLocationModel> getAllPropertyLocations();

    public List<HouseModel> getFilteredHouses(String priceRange, String dateOrder, String distanceRange, String keyword, int userId);

    public HouseModel getHouseById(String houseId);

    public List<HouseImages> getHouseImagesByHouseId(String houseId);

    public List<RoomModel> getRoomsByHouseId(String houseId);

    public List<HouseModel> getFilteredHousess(int userId);

    public boolean addHouse(HouseModel house);

    public boolean updateHouseStatus(int houseId, String newStatus);

    public List<HouseModel> getAllHouse(String id);

    public List<HouseModel> getAllHouses();

    public List<HouseImages> getHouseImage(int house_id);

    public String getUserRole(int userId);

    public boolean updateHouse(HouseModel house, String removedImages);

    public boolean deleteHouse(int houseId);

    public List<LocationModer> getAllLocations() throws SQLException;

    public LocationModer getLocationModerById(int locationId);

    public boolean updateHouseStatusBasedOnRoomStatus(int landlordId);
}
