package com.fuhousefinder.dao;

import com.fuhousefinder.entity.*;
import java.util.List;

public interface IUser {

    public List<User> getAll();

    public void changePassword(String email, String hased_password, String salt);

    public void addUser(User u, String firstname, String lastName, String address, String phone);

    public Profile getProfile(int user_Id, int roleId);

    public boolean editProfile(int roleId, String firstName, String lastName, String address, String phoneNumber, int id);

    public void editAvatar(int userId, String avatarUrl);

    public String getSaltByEmail(String email);

    public String getHashed_Password(String email);

    public boolean checkExistEmail(String email);

    public boolean checkExistPhone(String phone);

    public User getUserByEmail(String email);

    public int getLandlordIdByEmail(String email);
    
    public User getUserById(int user_id);

    public void verifyAccount(String email);

    public void addUserGmail(User u, String firstname, String lastName, String address, String phone);

    public boolean checkBan(String email);

    public List<ManageUser> getUserForAdmin();

    public List<ManageUser> getLandlord(List<ManageUser> list);

    public List<ManageUser> getTenant(List<ManageUser> list);

    public List<ManageUser> getAdmin(List<ManageUser> list);

    public ManageUser getManageUser(String email);

    public ManageUser getManageUserByUserID(int userID);
    
    public ManageUser getManageUserByLandlordID(int landlordID);
    
    public void banUser(String email, int statusBan);

    public User getByAllIdss(String id);

    public User getByAllId(String id);
    
    public String getEmailByLandlordId(int userId);
    
    public int getLandlordByUserID(int userID);
    
    public int getTenantIDByUserID(int userID);
    
    public String getEmailByMd5(String emailMd5);
}
