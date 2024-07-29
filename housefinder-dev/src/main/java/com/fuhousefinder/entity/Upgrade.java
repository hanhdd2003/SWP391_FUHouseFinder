package com.fuhousefinder.entity;

import com.fuhousefinder.dao.*;
import java.time.LocalDateTime;

public class Upgrade {

    private int upgrade_id;
    private String type;
    private int landlord_id;
    private String transaction_id;
    private double amount;
    private String description;
    private String error_code;
    private String ctt;
    private String bank_code;
    private LocalDateTime time_transaction;
    private boolean status;

    public Upgrade(int upgrade_id, String type, int landlord_id, String transaction_id, double amount, String description, String error_code, String ctt, String bank_code, LocalDateTime time_transaction, boolean status) {
        this.upgrade_id = upgrade_id;
        this.type = type;
        this.landlord_id = landlord_id;
        this.transaction_id = transaction_id;
        this.amount = amount;
        this.description = description;
        this.error_code = error_code;
        this.ctt = ctt;
        this.bank_code = bank_code;
        this.time_transaction = time_transaction;
        this.status = status;
    }

    public Upgrade() {
    }

    public Upgrade(String type, int landlord_id, String transaction_id, double amount, String description, String error_code, String ctt, String bank_code, LocalDateTime time_transaction, boolean status) {
        this.type = type;
        this.landlord_id = landlord_id;
        this.transaction_id = transaction_id;
        this.amount = amount;
        this.description = description;
        this.error_code = error_code;
        this.ctt = ctt;
        this.bank_code = bank_code;
        this.time_transaction = time_transaction;
        this.status = status;
    }

    public int getUpgrade_id() {
        return upgrade_id;
    }

    public void setUpgrade_id(int upgrade_id) {
        this.upgrade_id = upgrade_id;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public int getLandlord_id() {
        return landlord_id;
    }

    public void setLandlord_id(int landlord_id) {
        this.landlord_id = landlord_id;
    }

    public String getTransaction_id() {
        return transaction_id;
    }

    public void setTransaction_id(String transaction_id) {
        this.transaction_id = transaction_id;
    }

    public double getAmount() {
        return amount;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getError_code() {
        return error_code;
    }

    public void setError_code(String error_code) {
        this.error_code = error_code;
    }

    public String getCtt() {
        return ctt;
    }

    public void setCtt(String ctt) {
        this.ctt = ctt;
    }

    public String getBank_code() {
        return bank_code;
    }

    public void setBank_code(String bank_code) {
        this.bank_code = bank_code;
    }

    public LocalDateTime getTime_transaction() {
        return time_transaction;
    }

    public void setTime_transaction(LocalDateTime time_transaction) {
        this.time_transaction = time_transaction;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public ManageUser getLandlord(){
        IUser dao = new UserDAO();
        return dao.getManageUserByLandlordID(landlord_id);
    }
    public String getStatus(){
        return status ?"Thành công":"Thất bại";
    }
}
