package com.emis.service;

import com.emis.dao.MobileCoverageDao;
import com.emis.entity.PRS;
import org.json.JSONArray;

/**
 *
 * @author Helal
 */
public class MobileCoverageService {

    private MobileCoverageDao mobileCoverageDao = null;

    public MobileCoverageService() {
        mobileCoverageDao = new MobileCoverageDao();
    }

    public MobileCoverageService(int districtId) {
        mobileCoverageDao = new MobileCoverageDao(districtId);
    }

    public JSONArray getDistrictMobile(PRS prs) throws Exception {
        return mobileCoverageDao.getDistrictMobile(prs);
    }

    public JSONArray getUpazilaMobile(PRS prs) throws Exception {
        return mobileCoverageDao.getUpazilaMobile(prs);
    }

    public JSONArray getUnionMobile(PRS prs) throws Exception {
        return mobileCoverageDao.getUnionMobile(prs);
    }
}