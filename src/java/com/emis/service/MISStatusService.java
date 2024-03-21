package com.emis.service;

import com.emis.dao.MISStatusDao;
import com.emis.entity.MISStatus;
import com.emis.entity.WorkplanArea;
import java.sql.SQLException;
import org.json.JSONArray;

/**
 *
 * @author Helal
 */
public class MISStatusService {

    private MISStatusDao misStatusDao = null;

    public MISStatusService(int districtId) {
        misStatusDao = new MISStatusDao(districtId);
    }

    public Object getMISSubmissionStatus(MISStatus misStatus, String func) throws Exception {
        return misStatusDao.getMISSubmissionStatus(misStatus, func);
    }

    public Object getMISSubmissionStatusDGFP(MISStatus misStatus, String func) throws Exception {
        return misStatusDao.getMISSubmissionStatusDGFP(misStatus, func);
    }

    public JSONArray getProviderList(MISStatus misStatus, int type, String func) throws Exception {
        return misStatusDao.getProviderList(misStatus, type, func);
    }

    public JSONArray getProviderListDGFP(MISStatus misStatus, int type, String func) throws Exception {
        return misStatusDao.getProviderListDGFP(misStatus, type, func);
    }

    public JSONArray getMIS1(MISStatus misStatus) throws Exception {
        return misStatusDao.getMIS1(misStatus);
    }

    public String getMIS1(MISStatus misStatus, int a) throws Exception {
        return misStatusDao.getMIS1(misStatus, 1);
    }

    public String getMIS1DGFP(MISStatus misStatus) throws Exception {
        return misStatusDao.getMIS1DGFP(misStatus);
    }

    public JSONArray getMIS2(MISStatus misStatus) throws Exception {
        return misStatusDao.getMIS2(misStatus);
    }

    public JSONArray getMIS2DGFP(MISStatus misStatus) throws Exception {
        return misStatusDao.getMIS2DGFP(misStatus);
    }

    public String getMIS4(MISStatus misStatus) throws Exception {
        return misStatusDao.getMIS4(misStatus);
    }

    public String getMIS4DGFP(MISStatus misStatus) throws Exception {
        return misStatusDao.getMIS4DGFP(misStatus);
    }

    public JSONArray getNGOData(int districtId, int upazilaId, int month, int year) {
        return misStatusDao.getNGOData(districtId, upazilaId, month, year);
    }

    public JSONArray getNGODataDGFP(int districtId, int upazilaId, int month, int year) {
        return misStatusDao.getNGODataDGFP(districtId, upazilaId, month, year);
    }

    public JSONArray getMIS4Color(int districtId, int upazilaId, int month, int year) {
        return misStatusDao.getMIS4Color(districtId, upazilaId, month, year);
    }

    public JSONArray getAllStatus(MISStatus misStatus, String func) throws SQLException, Exception {
        return misStatusDao.getAllStatus(misStatus, func);
    }
}
