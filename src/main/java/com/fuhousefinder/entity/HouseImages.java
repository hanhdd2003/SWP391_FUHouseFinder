package com.fuhousefinder.entity;

/**
 *
 * @author hp
 */
public class HouseImages {

    private int id;
    private String imageUrl;
    private int house_id;

    public HouseImages() {
    }

    public HouseImages(int id, String imageUrl, int house_id) {
        this.id = id;
        this.imageUrl = imageUrl;
        this.house_id = house_id;
    }

    public int getHouse_id() {
        return house_id;
    }

    public void setHouse_id(int house_id) {
        this.house_id = house_id;
    }

    public HouseImages(String imageUrl, int house_id) {
        this.imageUrl = imageUrl;
        this.house_id = house_id;
    }



  

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }
}
