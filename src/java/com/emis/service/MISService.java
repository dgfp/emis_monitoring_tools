package com.emis.service;

import com.emis.dao.MISDao;
import java.sql.Array;
import java.sql.SQLException;

/**
 *
 * @author Helal
 */
public class MISService {

    private MISDao misDao = null;

    public MISService(int districtId) {
        misDao = new MISDao(districtId);
    }

    public int checkAdditionalUnitByProvider(int providerid, int unit) throws SQLException, Exception {
        return misDao.checkAdditionalUnitByProvider(providerid, unit);
    }
    
    public int checkAdditionalUnitByProvider(int providerid, int unit, int unitId) throws SQLException, Exception {
        return misDao.checkAdditionalUnitByProvider(providerid, unit, unitId);
    }
    
    public int checkAdditionalUnitByUnitId(int providerid, int unitId) throws SQLException, Exception {
        return misDao.checkAdditionalUnitByUnitId(providerid, unitId);
    }
    
    public Array getUnionidsByUnit(int zillaid, int upazilaId, int reporting_unionId, int unit) throws SQLException {
        return misDao.getUnionidsByUnit(zillaid, upazilaId, reporting_unionId, unit);
    }
    
    public  int getReportingUpazilaIdByUnit(int unitid) throws SQLException, Exception{
        return this.misDao.getReportingUpazilaIdByUnit(unitid);
    }
}