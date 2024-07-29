package com.fuhousefinder.entity;

public class ManageUser {

    private int user_id;
    private String firstName;
    private String lastName;
    private String email;
    private String phoneNumber;
    private String address;
    private int role;
    private String status;
    private boolean isBan;
    private String avatarUrl;
    private String hased_password;

    public ManageUser() {
    }

    public ManageUser(String string, String string1, String string2, String string3, String string4, int aInt, String string5, boolean aBoolean, String string6, String string7) {
    }

    public ManageUser(int user_id, String firstName, String lastName, String email, String phoneNumber, String address, int role, String status, boolean isBan, String avatarUrl, String hased_password) {
        this.user_id = user_id;
        this.firstName = firstName;
        this.lastName = lastName;
        this.email = email;
        this.phoneNumber = phoneNumber;
        this.address = address;
        this.role = role;
        this.status = status;
        this.isBan = isBan;
        this.avatarUrl = avatarUrl;
        this.hased_password = hased_password;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public int getRole() {
        return role;
    }

    public void setRole(int role) {
        this.role = role;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public boolean isIsBan() {
        return isBan;
    }

    public void setIsBan(boolean isBan) {
        this.isBan = isBan;
    }

    public String getAvatarUrl() {
        return avatarUrl;
    }

    public void setAvatarUrl(String avatarUrl) {
        this.avatarUrl = avatarUrl;
    }

    public String getHased_password() {
        return hased_password;
    }

    public void setHased_password(String hased_password) {
        this.hased_password = hased_password;
    }

    public int getUser_id() {
        return user_id;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }

}
