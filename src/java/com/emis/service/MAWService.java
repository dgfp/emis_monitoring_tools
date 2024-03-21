package com.emis.service;

import com.emis.dao.MAWDao;
import com.emis.entity.WorkplanArea;
import org.json.JSONArray;

/**
 *
 * @author Helal
 */
public class MAWService {
    
    private MAWDao mawDao = null;
    
    public MAWService(int districtId){
        mawDao = new MAWDao(districtId);   
    }
   
    public JSONArray getStatus(WorkplanArea workplanArea) throws Exception{
        return mawDao.getStatus(workplanArea);
    }
    
    public JSONArray getWorkplanStatus(WorkplanArea workplanArea) throws Exception{
        return mawDao.getWorkplanStatus(workplanArea);
    }
    
    public JSONArray getFWAProviderList(WorkplanArea workplanArea, int type) throws Exception{
        return mawDao.getFWAProviderList(workplanArea,type);
    }
    
    public JSONArray getFPIProviderList(WorkplanArea workplanArea,int type) throws Exception{
        return mawDao.getFPIProviderList(workplanArea,type);
    }
    
    public JSONArray getWorkplan(int zillaid, int providerid, int provtype, int month, int year) throws Exception{
        return mawDao.getWorkplan(zillaid, providerid, provtype, month, year);
    }
    
}
