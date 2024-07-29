package com.fuhousefinder.entity;

public class User {

    private String fname;
    private String add;
    private String phone;

    private String lname;
    private int id;
    private String email;
    private String hashed_password;
    private String salt;
    private String status;
    private int roleId;
    private String avatarUrl;
    private LandlordMder landlordMder;

    public User() {
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getFname() {
        return fname;
    }

    public void setFname(String fname) {
        this.fname = fname;
    }

    public String getAdd() {
        return add;
    }

    public void setAdd(String add) {
        this.add = add;
    }

    public String getLname() {
        return lname;
    }

    public void setLname(String lname) {
        this.lname = lname;
    }

    public User(int id, String email, String hashed_password, String salt, String status, int roleId, String avatarUrl) {
        this.id = id;
        this.email = email;
        this.hashed_password = hashed_password;
        this.salt = salt;
        this.status = status;
        this.roleId = roleId;
        this.avatarUrl = avatarUrl;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getHashed_password() {
        return hashed_password;
    }

    public void setHashed_password(String hashed_password) {
        this.hashed_password = hashed_password;
    }

    public String getSalt() {
        return salt;
    }

    public void setSalt(String salt) {
        this.salt = salt;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public int getRoleId() {
        return roleId;
    }

    public void setRoleId(int roleId) {
        this.roleId = roleId;
    }

    public String getAvatarUrl() {
        return avatarUrl;
    }

    public void setAvatarUrl(String avatarUrl) {
        this.avatarUrl = avatarUrl;
    }

    public LandlordMder getLandlordMder() {
        return landlordMder;
    }

    public void setLandlordMder(LandlordMder landlordMder) {
        this.landlordMder = landlordMder;
    }

}
