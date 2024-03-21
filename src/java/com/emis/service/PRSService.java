package com.emis.service;

import com.emis.dao.PRSDao;
import com.emis.entity.PRS;
import org.json.JSONArray;

/**
 *
 * @author Helal
 */
public class PRSService {

    private PRSDao prsDao = null;

    public PRSService() {
        prsDao = new PRSDao();
    }

    public PRSService(int districtId) {
        prsDao = new PRSDao(districtId);
    }

    public JSONArray getDistrictPRS(PRS prs) throws Exception {
        return prsDao.getDistrictPRS(prs);
    }

    public JSONArray getUpazilaPRS(PRS prs) throws Exception {
        return prsDao.getUpazilaPRS(prs);
    }

    public JSONArray getUnionPRS(PRS prs) throws Exception {
        return prsDao.getUnionPRS(prs);
    }
}
