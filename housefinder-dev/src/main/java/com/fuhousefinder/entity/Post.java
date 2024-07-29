package com.fuhousefinder.entity;

import com.fuhousefinder.configs.Validate;
import java.time.LocalDateTime;
import java.util.List;

/**
 *
 * @author tuana
 */
public class Post {
    private int post_id;
    private String title;
    private double price;
    private String address;
    private String area;
    private int number_room;
    private String description;
    private String status;
    private String post_date;
    private int landlord_id;
    private int location_id;
    private List<String> img;
    private Profile lanlord;
    private String avatarLandlord;
    public Post() {
    }

    public Post(String title, double price, String address, String area, int number_room, String description, String status, String post_date, int landlord_id, int location_id) {
        this.title = title;
        this.price = price;
        this.address = address;
        this.area = area;
        this.number_room = number_room;
        this.description = description;
        this.status = status;
        this.post_date = post_date;
        this.landlord_id = landlord_id;
        this.location_id = location_id;
    }

    public Post(int post_id, String title, double price, String address, String area, int number_room, String description, String status, String post_date, int landlord_id, int location_id) {
        this.post_id = post_id;
        this.title = title;
        this.price = price;
        this.address = address;
        this.area = area;
        this.number_room = number_room;
        this.description = description;
        this.status = status;
        this.post_date = post_date;
        this.landlord_id = landlord_id;
        this.location_id = location_id;
    }

    public String getAvatarLandlord() {
        return avatarLandlord;
    }

    public void setAvatarLandlord(String avatarLandlord) {
        this.avatarLandlord = avatarLandlord;
    }

    public int getPost_id() {
        return post_id;
    }

    public void setPost_id(int post_id) {
        this.post_id = post_id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getArea() {
        return area;
    }

    public void setArea(String area) {
        this.area = area;
    }

    public int getNumber_room() {
        return number_room;
    }

    public void setNumber_room(int number_room) {
        this.number_room = number_room;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getPost_date() {
        return post_date;
    }

    public void setPost_date(String post_date) {
        this.post_date = post_date;
    }

    public int getLandlord_id() {
        return landlord_id;
    }

    public void setLandlord_id(int landlord_id) {
        this.landlord_id = landlord_id;
    }

    public int getLocation_id() {
        return location_id;
    }

    public void setLocation_id(int location_id) {
        this.location_id = location_id;
    }

    public List<String> getImg() {
        return img;
    }

    public void setImg(List<String> img) {
        this.img = img;
    }

    public Profile getLanlord() {
        return lanlord;
    }

    public void setLanlord(Profile lanlord) {
        this.lanlord = lanlord;
    }
    
    public String getTimeAgo(){
        Validate v = new Validate();
        LocalDateTime time = v.convertTime(this.post_date);
        LocalDateTime now = LocalDateTime.now();
        int year = now.getYear() - time.getYear();
        int month = now.getMonthValue() - time.getMonthValue();
        int day = now.getDayOfMonth() - time.getDayOfMonth();
        int hour = now.getHour() - time.getHour();
        int minute = now.getMinute() - time.getMinute();
        int second = now.getSecond() - time.getSecond();
        if (second < 0) {
            minute--;
            second += 60;
        }
        if (minute < 0) {
            hour--;
            minute += 60;
        }
        if (hour < 0) {
            day--;
            hour += 24;
        }
        if (day < 0) {
            month--;
            day += time.getMonth().length(v.isLeapYear(time.getYear()));
        }
        if (month < 0) {
            year--;
            month += 12;
        }
        String str = "";
        if (year > 0) {
            str += year + " Năm";
            if (year > 1) str += " trước";
        } else if (month > 0) {
            str += month + " Tháng";
            if (month > 1) str += " trước";
        } else if (day > 0) {
            str +=  day + " Ngày";
            if (day > 1) str += " trước";
        } else if (hour > 0) {
            str += hour + " Giờ";
            if (hour > 1) str += " trước";
        } else if (minute > 0) {
            str += minute + " Phút";
            if (minute > 1) str += " trước";
        } else {
            str += second + " Giây";
            if (second > 1) str += " trước";
        }
        return str;
        
        
    }

    @Override
    public String toString() {
        return "Post{" + "post_id=" + post_id + ", title=" + title + ", price=" + price + ", address=" + address + ", area=" + area + ", number_room=" + number_room + ", description=" + description + ", status=" + status + ", post_date=" + post_date + ", landlord_id=" + landlord_id + ", location_id=" + location_id + '}';
    }
    
    
}
