package com.fuhousefinder.entity;

import com.google.gson.Gson;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

/**
 *
 * @author hp
 */
public class HouseModel {

    private int id;
    private String house_name;
    private String address;
    private double price;
    private String descriptionHouse;
    private String status;
    private LocalDateTime createDate;
    private LocalDateTime updateDate;

    private LocalDateTime createDates;
    private LocalDateTime updateDates;
    private int location_id;
    private String img;
    private String distance_km;
    private String avatarImage;
    private double minPrice;
    private double MaxPrice;
    private LandlordMder landlordMder;
    private List<HouseImages> houseImagess;
    private LocationModer locationModer;
    private ManageUser landlord;
    private boolean favorite;

    public boolean isFavorite() {
        return favorite;
    }

    public void setFavorite(boolean favorite) {
        this.favorite = favorite;
    }

    public int getLocation_id() {
        return location_id;
    }

    public void setLocation_id(int location_id) {
        this.location_id = location_id;
    }
    
    public LocationModer getLocationModer() {
        return locationModer;
    }

    public LocalDateTime getCreateDates() {
        return createDates;
    }

    public void setCreateDates(LocalDateTime createDates) {
        this.createDates = createDates;
    }

    public LocalDateTime getUpdateDates() {
        return updateDates;
    }

    public void setUpdateDates(LocalDateTime updateDates) {
        this.updateDates = updateDates;
    }

    
    public void setLocationModer(LocationModer locationModer) {
        this.locationModer = locationModer;
    }

    public String getHouseImagesJson() {
        Gson gson = new Gson();
        return gson.toJson(houseImagess);
    }

    public LandlordMder getLandlordMder() {
        return landlordMder;
    }

    public void setLandlordMder(LandlordMder landlordMder) {
        this.landlordMder = landlordMder;
    }

    public String getImg() {
        return img;
    }

    public String getAvatarImage() {
        return avatarImage;
    }

    public void setAvatarImage(String avatarImage) {
        this.avatarImage = avatarImage;
    }

    public double getMinPrice() {
        return minPrice;
    }

    public void setMinPrice(double minPrice) {
        this.minPrice = minPrice;
    }

    public void setImg(String img) {
        this.img = img;
    }

    public double getMaxPrice() {
        return MaxPrice;
    }

    public void setMaxPrice(double MaxPrice) {
        this.MaxPrice = MaxPrice;
    }

    public String getDistance_km() {
        return distance_km;
    }

    public void setDistance_km(String distance_km) {
        this.distance_km = distance_km;
    }

    public List<HouseImages> getHouseImagess() {
        return houseImagess;
    }

    public void setHouseImagess(List<HouseImages> houseImagess) {
        this.houseImagess = houseImagess;
    }

    public HouseModel() {
    }

    public String getHouse_name() {
        return house_name;
    }

    public void setHouse_name(String house_name) {
        this.house_name = house_name;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getDescriptionHouse() {
        return descriptionHouse;
    }

    public void setDescriptionHouse(String descriptionHouse) {
        this.descriptionHouse = descriptionHouse;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getCreateDate() {
        DateTimeFormatter format = DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm:ss");
        return createDate.format(format);
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

    public HouseModel(int id, String address, double price, String descriptionHouse, String status, LocalDateTime createDate, LocalDateTime updateDate) {
        this.id = id;
        this.address = address;
        this.price = price;
        this.descriptionHouse = descriptionHouse;
        this.status = status;
        this.createDate = createDate;
        this.updateDate = updateDate;

    }

    public ManageUser getLandlord() {
        return landlord;
    }

    public void setLandlord(ManageUser landlord) {
        this.landlord = landlord;
    }

    @Override
    public String toString() {
        return "HouseModel{" + "id=" + id + ", houseImagess=" + houseImagess.toString() + '}';
    }

}
