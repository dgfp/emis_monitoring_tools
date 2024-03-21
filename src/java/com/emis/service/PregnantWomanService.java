package com.emis.service;

import com.emis.dao.MAWDao;
import com.emis.dao.PregnantWomanDao;
import com.emis.entity.WorkplanArea;
import org.json.JSONArray;

/**
 *
 * @author Helal
 */
public class PregnantWomanService {
    
    private PregnantWomanDao pregnantWomanDao = null;
    
    public PregnantWomanService(int districtId){
        pregnantWomanDao = new PregnantWomanDao(districtId);   
    }
   
    public JSONArray getStatus(WorkplanArea workplanArea) throws Exception{
        return null;
    }
    
}
