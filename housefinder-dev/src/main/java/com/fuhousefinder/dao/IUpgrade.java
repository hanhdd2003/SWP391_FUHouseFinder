package com.fuhousefinder.dao;

import com.fuhousefinder.entity.Upgrade;
import java.util.List;


public interface IUpgrade {

    public List<Upgrade> getAll();
    
    public List<Upgrade> getUpgradeByLandlordID(int landlord_id);
    
    public List<Upgrade> getUpgradeByUserID(int userId);
    
    public void upgradeLandlord(Upgrade upgrade);
    
    public int getNumberHouseCanAdd(int landlord_id);
}
