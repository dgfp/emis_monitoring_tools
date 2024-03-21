/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.emis.dao.ProviderManagement;

import com.emis.entity.ProviderUnassign;
import com.emis.entity.ReportingInfo;
import com.emis.utility.Convertor;
import com.emis.utility.Print;
import com.emis.utility.Utility;
import com.rhis.db.DBManagerDistrict;
import com.rhis.db.DBManagerMonitoring;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import javax.servlet.http.HttpServletRequest;
//import jdk.internal.net.http.common.Pair;
import org.json.JSONArray;

/**
 *
 * @author Nibras
 */
public class ProviderManagement {

    private DBManagerMonitoring db = null;
    private Connection connection = null;
    private String sql = null;

    public ProviderManagement() {
        db = new DBManagerMonitoring();
        connection = db.openConnection();
    }

    public ProviderManagement(int districtId) {
        db = new DBManagerDistrict(districtId);
        connection = db.openConnection();
    }

    public int setAreaUpdate(int providerId, int settingId) throws SQLException {
        int resultSet = connection.createStatement().executeUpdate("update providerdb set areaupdate" + " = " + settingId + ",modifydate=now()  where providerid = " + providerId);
        connection.close();
        return resultSet;
    }

    public JSONArray getSupervisor(int zillaid, int upazilaid, int unionid, int provtype) throws SQLException, Exception {
        String sqlCondition = "";
        String selection = "";
        switch (provtype) {
            case 10:
                sqlCondition = " where pdb.active =1 and pdb.zillaid=" + zillaid + "and pdb.upazilaid=" + upazilaid + " and pdb.provtype=" + provtype;
                selection = " un.unionnameeng ";
                break;
            case 15:
                sqlCondition = " where pdb.active =1 and pdb.zillaid=" + zillaid + " and pdb.provtype=" + provtype;
                selection = " upz.upazilanameeng ";
                break;
            default:
                selection = " upz.upazilanameeng ";
                System.out.println("Provider type does not match");
        }
        String union = provtype == 10 ? " and unionid=" + unionid : "";
        //String sql = "select providerid, provname from providerdb where active =1 and zillaid=" + zillaid + " and upazilaid=" + upazilaid + " " + " and provtype=" + provtype;
        String sql = "select providerid, provname, " + selection + " as \"parent_geo\" from providerdb pdb\n"
                + " left join upazila upz on pdb.zillaid = upz.zillaid and pdb.upazilaid = upz.upazilaid\n"
                + " left join unions un on pdb.zillaid=un.zillaid and pdb.upazilaid=un.upazilaid and pdb.unionid=un.unionid\n"
                + sqlCondition;
        System.out.println(sql);
        ResultSet resultSet = connection.createStatement().executeQuery(sql);
        connection.close();
        return Convertor.toJSON(resultSet);
    }

    public JSONArray getNewProviderId(int zillaId, String provtype) throws Exception {
        String sql = "select web_get_new_provider_id as provider_id from web_get_new_provider_id(" + zillaId + ",'" + provtype + "');";
        ResultSet resultSet = connection.createStatement().executeQuery(sql);
        connection.close();
        return Convertor.toJSON(resultSet);
    }

    public JSONArray getOrganizations(int zillaId, int upazilaId, int unionId) throws Exception {
        String sql = "select iuo.organization_id as id, o.organization_name_eng as name\n"
                + " from implemented_unions_by_organization iuo \n"
                + "join organizaions o on iuo.organization_id = o.organization_id\n"
                + " where iuo.zillaid = " + zillaId + " and iuo.upazilaid = " + upazilaId
                + " and iuo.unionid = " + unionId + ";";
        System.out.println(sql);
        ResultSet resultSet = connection.createStatement().executeQuery(sql);
        connection.close();
        return Convertor.toJSON(resultSet);
    }

    public JSONArray getDesignationByOrganization(int zillaId, int organizationId, int providerType) throws Exception {
        String sql = "select prov_role_id as id, typename_abbr as name from provider_role_type where organization_id = "
                + organizationId + " and prov_role_id=" + providerType + ";";
        ResultSet resultSet = connection.createStatement().executeQuery(sql);
        connection.close();
        return Convertor.toJSON(resultSet);
    }

    public JSONArray getMouzaList(int zillaid, int upazilaid, int unionid) throws SQLException, Exception {
        String sql = "select mouzaid, mouzanameeng from mouza where zillaid = " + zillaid + " and upazilaid = " + upazilaid + " and unionid=" + unionid;
        ResultSet resultSet = connection.createStatement().executeQuery(sql);
        System.out.println(sql);
        connection.close();
        return Convertor.toJSON(resultSet);
    }

    public int getVillageId(int zillaid, int upazilaid, int unionid, int mouzaid) throws SQLException, Exception {
        String sql = "SELECT max(villageid)+1 villageid FROM public.village where zillaid=" + zillaid + " and upazilaid=" + upazilaid + " and unionid=" + unionid + " and mouzaid=" + mouzaid;
        Print.o(sql);
        ResultSet resultSet = connection.createStatement().executeQuery(sql);
        connection.close();
        int villageId = 1;
        while (resultSet.next()) {
            villageId = resultSet.getInt("villageid");
            if (villageId == 0) {
                villageId = 1;
            }
        }
        Print.o(villageId);
        return villageId;
    }

    public JSONArray getUnitDetailsByFWA(int providerid) throws SQLException, Exception {
        String sql = "select * from web_fwa_unit_details(" + providerid + ");";
        ResultSet resultSet = connection.createStatement().executeQuery(sql);
        System.out.println(sql);
        connection.close();
        return Convertor.toJSON(resultSet);
    }

    public boolean unassignProvider(ProviderUnassign pu, HttpServletRequest request) throws SQLException {
        boolean returnType = false;
        switch (pu.getProvtype()) {
            case 3:
                returnType = this.unassignFWAProvider(pu, request);
                break;
            case 10:
                returnType = this.unassignFPIProvider(pu, request);
                break;
            case 15:
                returnType = this.unassignUFPOProvider(pu, request);
                break;
            default:
                returnType = false;
        }
        return returnType;
    }

    private boolean unassignFWAProvider(ProviderUnassign pu, HttpServletRequest request) throws SQLException {
        db.start();
        int deleteProviderareaUnit = 0, deleteProviderarea = 0, insertHistory = 1, updateProviderdb = 0;

        for (ReportingInfo ri : pu.getReportinginfo()) {
            String dateUnassign = null;
            String dateEndLeave = null;
            //delete Providerarea_unit
            deleteProviderareaUnit = db.update("DELETE FROM providerarea_unit WHERE providerid=" + pu.getProviderid() + " and unitid=" + ri.getUnitid());

            //delete Providerarea
            deleteProviderarea += db.update("DELETE FROM providerarea WHERE providerid=" + pu.getProviderid() + " and unitid=" + ri.getUnitid() + " and fwaunit=" + ri.getUnit());
            if (pu.getUnassign_date() != null) {
                dateUnassign = "'" + pu.getUnassign_date() + "'";
            }
            if (pu.getUnassign_leave_end_date() != null) {
                dateEndLeave = "'" + pu.getUnassign_leave_end_date() + "'";
            }
            //insert providerarea_unit_history
            String insertHistorySQL = "INSERT INTO public.providerarea_unit_history(\n"
                    + "zillaid, upazilaid, unitid, unit, providerid, start_date, end_date, assign_type, unassign_date, unassign_leave_end_date, unassign_provider_emp_id, district_all, transfer_upazila, transfer_union, unassign_reason_type, leave_type, unassign_provider_hris_id, created_by)\n"
                    + "VALUES (" + pu.getZillaid() + "," + pu.getUpazilaid() + "," + ri.getUnitid() + "," + ri.getUnit() + "," + pu.getProviderid() + ", now(), now()," + ri.getAssign_type() + "," + dateUnassign + "," + dateEndLeave + ","
                    + pu.getUnassign_provider_emp_id() + "," + pu.getDistrict_all() + "," + pu.getTransfer_upazila() + "," + pu.getTransfer_union() + "," + pu.getUnassign_reason_type() + "," + pu.getLeave_type() + "," + pu.getUnassign_provider_hris_id() + ",'" + request.getSession().getAttribute("username").toString() + "');";
            Print.o(insertHistorySQL);
            insertHistory += db.update(insertHistorySQL);
        }

        //Update providerdb
        updateProviderdb = db.update("UPDATE providerdb SET areaupdate=1 " + this.providerDBWhere(pu) + ", modifydate=now()  where providerid=" + pu.getProviderid());

        if (deleteProviderareaUnit > 0 && deleteProviderarea > 0 && updateProviderdb > 0 && insertHistory > 0) {
            db.commit();
            connection.close();
            return true;
        } else {
            db.rollback();
            connection.close();
            return false;
        }
    }

    private boolean unassignFPIProvider(ProviderUnassign pu, HttpServletRequest request) throws SQLException {
        String dateUnassign = null;
        if (pu.getUnassign_date() != null) {
            dateUnassign = "'" + pu.getUnassign_date() + "'";
        }
        db.start();
        int deleteReportingUnionFPI = 0, updateProviderdb = 0, insertHistory = 0;
        for (ReportingInfo ri : pu.getReportinginfo()) {
            //delete Providerarea_unit
            deleteReportingUnionFPI = db.update("DELETE FROM reporting_union_fpi WHERE providerid=" + pu.getProviderid() + " and zillaid=" + pu.getZillaid() + " and upazilaid=" + ri.getUpazilaid() + " and reporting_unionid=" + ri.getReporting_unionid());

            //insert reporting_union_fpi_history
            String insertHistorySQL = "INSERT INTO public.reporting_union_fpi_history(\n"
                    + "            zillaid, upazilaid, reporting_unionid, providerid, start_date, end_date, assign_type, active, unassign_date, unassign_leave_end_date, unassign_provider_emp_id, \n"
                    + "            district_all, transfer_upazila, transfer_union, unassign_reason_type, leave_type, unassign_provider_hris_id, created_by)\n"
                    + "VALUES (" + pu.getZillaid() + "," + pu.getTransfer_upazila() + "," + ri.getReporting_unionid() + "," + pu.getProviderid() + ", now(), now(), " + ri.getAssign_type() + ",0," + dateUnassign + "," + pu.getUnassign_leave_end_date() + "," + pu.getUnassign_provider_emp_id()
                    + "," + pu.getDistrict_all() + "," + pu.getTransfer_upazila() + "," + pu.getTransfer_union() + "," + pu.getUnassign_reason_type() + "," + pu.getLeave_type() + "," + pu.getUnassign_provider_hris_id() + ",'" + request.getSession().getAttribute("username").toString() + "');";
            Print.o(insertHistorySQL);
            insertHistory += db.update(insertHistorySQL);

        }
        //Update providerdb
        updateProviderdb = db.update("UPDATE providerdb SET areaupdate=1 " + this.providerDBWhere(pu) + " where providerid=" + pu.getProviderid());

        if (deleteReportingUnionFPI > 0 && updateProviderdb > 0 && insertHistory > 0) {
            db.commit();
            connection.close();
            return true;
        } else {
            db.rollback();
            connection.close();
            return false;
        }
    }

    private boolean unassignUFPOProvider(ProviderUnassign pu, HttpServletRequest request) throws SQLException {
        db.start();
        int deleteReportingUpazilaUFPO = 0, updateProviderdb = 0, insertHistory = 0;

        for (ReportingInfo ri : pu.getReportinginfo()) {
            //delete Providerarea_unit
            deleteReportingUpazilaUFPO = db.update("DELETE FROM reporting_upazila_ufpo WHERE providerid=" + pu.getProviderid() + " and zillaid=" + pu.getZillaid() + " and upazilaid=" + ri.getUpazilaid());

            //String unassignDate="'" + pu.getUnassign_date() + "'";
            if (pu.getUnassign_date() == null) {
                pu.setUnassign_date(Utility.getDateNowFormated("yyyy-MM-dd"));
                //unassignDate = pu.getUnassign_date();
            }

            //insert providerarea_unit_history
            String insertHistorySQL = "INSERT INTO public.reporting_upazila_ufpo_history(\n"
                    + "zillaid, upazilaid, providerid, start_date, end_date, assign_type, active, unassign_date, unassign_leave_end_date, unassign_provider_emp_id, \n"
                    + "district_all, transfer_upazila, transfer_union, unassign_reason_type, leave_type, unassign_provider_hris_id, created_by)\n"
                    + "VALUES (" + pu.getZillaid() + "," + pu.getTransfer_upazila() + "," + pu.getProviderid() + ", now(), now(), " + ri.getAssign_type() + ",0,'" + pu.getUnassign_date() + "'," + pu.getUnassign_leave_end_date() + "," + pu.getUnassign_provider_emp_id()
                    + "," + pu.getDistrict_all() + "," + pu.getTransfer_upazila() + "," + pu.getTransfer_union() + "," + pu.getUnassign_reason_type() + "," + pu.getLeave_type() + "," + pu.getUnassign_provider_hris_id() + ",'" + request.getSession().getAttribute("username").toString() + "');";
            Print.o(insertHistorySQL);
            insertHistory += db.update(insertHistorySQL);
        }
        //Update providerdb
        updateProviderdb = db.update("UPDATE providerdb SET areaupdate=1 " + this.providerDBWhere(pu) + " where providerid=" + pu.getProviderid());

        if (deleteReportingUpazilaUFPO > 0 && updateProviderdb > 0) {
            db.commit();
            connection.close();
            return true;
        } else {
            db.rollback();
            connection.close();
            return false;
        }
    }

    private String providerDBWhere(ProviderUnassign pu) {
        String where = "";
        if (pu.getUnassign_reason_type() == 2 || pu.getUnassign_reason_type() == 3 || pu.getUnassign_reason_type() == 4) {
            where = ", active = 0";

        } else if (pu.getUnassign_reason_type() == 1) {
            if (pu.getZillaid() == pu.getDistrict_all()) {
                //Update provider own catchment
                where = ", upazilaid = " + pu.getTransfer_upazila() + ", unionid = " + pu.getTransfer_union();
            } else {
                where = ", active = 0";
            }
        }
        return where;
    }

    public String getProviderNameByProviderId(int providerid) throws SQLException {
        String sql = "select provname from providerdb where providerid = " + providerid;
        ResultSet resultSet = connection.createStatement().executeQuery(sql);
        connection.close();
        String providerName = "";
        while (resultSet.next()) {
            providerName = resultSet.getString("provname");
        }
        return providerName;
    }

    public HashMap<String, Integer> getProviderInformation(int providerid) throws SQLException {
        String sql = "select zillaid, provtype from providerdb where providerid = " + providerid;
        ResultSet resultSet = connection.createStatement().executeQuery(sql);
        int zillaid = 0;
        int provtype = 0;
        HashMap<String, Integer> providerInformation = new HashMap<String, Integer>();
//        connection.close();
        while (resultSet.next()) {
            providerInformation.put("zillaid", resultSet.getInt("zillaid"));
            providerInformation.put("provtype", resultSet.getInt("provtype"));
        }
        return providerInformation;
    }

    public void insertDeviceSettingHistory(String monitoringToolUser,
            String providerid, int devicesetting, int datasource) throws SQLException {
        HashMap<String, Integer> providerInformation = getProviderInformation(Integer.valueOf(providerid));
        /*
        datasource = 1 = from monitoring tools
        datasource = 2 = from tab
         */
        String sql = "select public.insert_devicesetting_history('"
                + monitoringToolUser + "'," + providerid + "," + devicesetting
                + "," + providerInformation.get("zillaid") + "," + providerInformation.get("provtype") + "," + datasource + ")";
        ResultSet resultSet = connection.createStatement().executeQuery(sql);
        connection.close();
    }
}
