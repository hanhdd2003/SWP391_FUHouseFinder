package com.fuhousefinder.entity;

/**
 *
 * @author hp
 */
public class LocationModer {

    public LocationModer() {
    }
    private int location_id;
    private String location_name;
    private String location_link;

    public LocationModer(int location_id, String location_name, String location_link) {
        this.location_id = location_id;
        this.location_name = location_name;
        this.location_link = location_link;
    }

    public int getLocation_id() {
        return location_id;
    }

    public void setLocation_id(int location_id) {
        this.location_id = location_id;
    }

    public String getLocation_name() {
        return location_name;
    }

    public void setLocation_name(String location_name) {
        this.location_name = location_name;
    }

    public String getLocation_link() {
        return location_link;
    }

    public void setLocation_link(String location_link) {
        this.location_link = location_link;
    }

}
