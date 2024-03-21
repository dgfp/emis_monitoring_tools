package com.emis.dao;

import com.rhis.db.DBManagerDistrict;
import com.rhis.db.DBManagerMonitoring;
import java.sql.Array;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.http.HttpServletRequest;

/**
 *
 * @author Helal
 */
public class MISDao {

    private DBManagerMonitoring db = null;
    private Connection connection = null;

    public MISDao() {
        db = new DBManagerMonitoring();
        connection = db.openConnection();
    }
    
    public MISDao(int districtId) {
        db = new DBManagerDistrict(districtId);
        connection = db.openConnection();
    }

    public int checkAdditionalUnitByProvider(int providerid, int unit) throws SQLException, Exception {
        String sql = "SELECT p.assign_type FROM providerarea_unit p join unit_master u using(unitid) where p.providerid = " + providerid + " and u.unit = " + unit;
        int assign_type = 0;
        ResultSet rs = connection.createStatement().executeQuery(sql);
        while (rs.next()) {
            assign_type = rs.getInt("assign_type");
        }
        connection.close();
        this.print(sql);
        return assign_type;
    }
    
    public int checkAdditionalUnitByProvider(int providerid, int unit, int unitId) throws SQLException, Exception {
        String sql = "SELECT p.assign_type FROM providerarea_unit p join unit_master u using(unitid) where p.providerid "
                + " = " + providerid + " and u.unit = " + unit + " and p.unitid = " + unitId;
        int assign_type = 0;
        ResultSet rs = connection.createStatement().executeQuery(sql);
        while (rs.next()) {
            assign_type = rs.getInt("assign_type");
        }
        connection.close();
        this.print(sql);
        return assign_type;
    }
    
    public int checkAdditionalUnitByUnitId(int providerid, int unitId) throws SQLException, Exception {
        String sql = "SELECT p.assign_type FROM providerarea_unit p join unit_master u using(unitid) where p.providerid = " + providerid + " and u.unitid = " + unitId;
        int assign_type = 0;
        ResultSet rs = connection.createStatement().executeQuery(sql);
        while (rs.next()) {
            assign_type = rs.getInt("assign_type");
        }
        connection.close();
        this.print(sql);
        return assign_type;
    }

    public Array getUnionidsByUnit(int zillaid, int upazilaId, int reporting_unionId, int unit) throws SQLException {
        Array unionids = null;
        String sql = "select * from unit_master where zillaid=" + zillaid + " and upazilaid=" + upazilaId + " and reporting_unionid=" + reporting_unionId + " and unit=" + unit;
        ResultSet rs = new DBManagerDistrict(zillaid).select(sql);
        while (rs.next()) {
            unionids = rs.getArray("unionids");
        }
        connection.close();
        this.print(sql);
        return unionids;
    }

    private void print(String text) {
        System.out.println(text);
    }

    public int getReportingUpazilaIdByUnit(int unitid) throws SQLException, Exception {
        String sql = "SELECT reporting_upazilaid FROM public.reporting_upazila where upazilaid=(select upazilaid from unit_master where unitid=" + unitid + ");";
        int reporting_upazilaid = 0;
        ResultSet rs = connection.createStatement().executeQuery(sql);
        while (rs.next()) {
            reporting_upazilaid = rs.getInt("reporting_upazilaid");
        }
        connection.close();
        this.print(sql);
        return reporting_upazilaid;
    }

    //Unionid should be replace by reporting union id
    public boolean getAnySubmittedExist(int zillaid, int upazilaid, int unionid, int unit, int provCode) throws SQLException, Exception {
        String sql = "select * from rpt_mis_form1_fwa_9v_dgfp where zillaid=" + zillaid + " and upazilaid = " + upazilaid + " and reporting_unionid = " + unionid + " and unit = " + unit + " and providerid=" + provCode + " ORDER BY systementrydate DESC LIMIT 1";
        boolean exist = false;
        ResultSet rs = connection.createStatement().executeQuery(sql);
        while (rs.next()) {
            exist = true;
        }
        connection.close();
        this.print(sql);
        return exist;
    }

    public boolean isSubmittedAsAdditional(String zillaid, String upazilaid, String reporting_unionid, String unit, String month, String year) throws SQLException, Exception {
        String sql = "SELECT 1 FROM public.web_report_submission_dgfp where zillaid=" + zillaid + " and upazilaid=" + upazilaid + " and reporting_unionid=" + reporting_unionid + " and fwaunit=" + unit + " and month=" + month + " and year=" + year;
        boolean exist = false;
        ResultSet rs = connection.createStatement().executeQuery(sql);
        while (rs.next()) {
            exist = true;
        }
        connection.close();
        this.print(sql);
        return exist;
    }

    public Array getUnionidsByReportingUnionId(int zillaid, int upazilaid, int reporting_unionid) throws SQLException {
        Array unionids = null;
        String sql = "select unionids from reporting_union where zillaid=" + zillaid + " and upazilaid=" + upazilaid + " and reporting_unionid=" + reporting_unionid;
        ResultSet rs = new DBManagerDistrict(zillaid).select(sql);
        while (rs.next()) {
            unionids = rs.getArray("unionids");
        }
        connection.close();
        this.print(sql);
        return unionids;
    }

    public void updateSessionUnionIdByFWA(HttpServletRequest request) throws SQLException {
        if (request.getSession(false).getAttribute("designation").toString().equals("FWA")) {
            String sql = "SELECT reporting_unionid FROM public.unit_master um join providerarea_unit pu using(unitid) where pu.providerid = " + request.getSession(false).getAttribute("providerCode") + " and um.unit = " + request.getSession(false).getAttribute("unit");
            int reporting_unionid = 0;
            ResultSet rs = connection.createStatement().executeQuery(sql);
            while (rs.next()) {
                reporting_unionid = rs.getInt("reporting_unionid");
            }
            connection.close();
            request.getSession(false).setAttribute("union", reporting_unionid != 0 ? reporting_unionid : request.getSession(false).getAttribute("union"));
        }
    }
}
