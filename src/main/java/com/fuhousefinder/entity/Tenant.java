package com.fuhousefinder.entity;

public class Tenant {
    private int tenant_ID;
    private int user_ID;
    private String firstName;
    private String lastName;
    private String address;
    private String phone;

    public Tenant() {
    }

    public Tenant(int tenant_ID, int user_ID, String firstName, String lastName, String address, String phone) {
        this.tenant_ID = tenant_ID;
        this.user_ID = user_ID;
        this.firstName = firstName;
        this.lastName = lastName;
        this.address = address;
        this.phone = phone;
    }

    public int getTenant_ID() {
        return tenant_ID;
    }

    public void setTenant_ID(int tenant_ID) {
        this.tenant_ID = tenant_ID;
    }

    public int getUser_ID() {
        return user_ID;
    }

    public void setUser_ID(int user_ID) {
        this.user_ID = user_ID;
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

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    @Override
    public String toString() {
        return "Tenant{"
                + "tenant_ID=" + tenant_ID
                + ", user_ID=" + user_ID
                + ", firstName='" + firstName + '\''
                + ", lastName='" + lastName + '\''
                + ", address='" + address + '\''
                + ", phone='" + phone + '\''
                + '}';
    }
}
