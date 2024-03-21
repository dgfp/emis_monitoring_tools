package com.emis.dao;

import com.emis.entity.MISStatus;
import com.emis.entity.PRS;
import com.emis.utility.Convertor;
import com.rhis.db.DBManagerDistrict;
import com.rhis.db.DBManagerMonitoring;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import org.json.JSONArray;

/**
 *
 * @author Helal
 */
public class MISStatusDao {

    private DBManagerDistrict db = null;
    private Connection connection = null;

    public MISStatusDao() {
    }

    public MISStatusDao(int districtId) {
        db = new DBManagerDistrict(districtId);
        connection = db.openConnection();
    }

    public JSONArray getMISSubmissionStatus(MISStatus misStatus, String func) throws SQLException, Exception {
        String sql = "select count(*) as total_provider\n"
                + "	,count(*) filter(where t.status is null) as not_submitted\n"
                + "	,count(*) filter(where t.status is not null) as submitted\n"
                + "	,count(*) filter(where t.status = 1) as approved\n"
                + "	,count(*) filter(where t.status = 0) as pending\n"
                + "	,count(*) filter(where t.status = 2) as need_to_resubmit\n"
                + "	,count(*) filter(where t.status = 3) as resubmitted\n"
                + "	,count(*) filter(where t.status = 4) as reopened\n"
                + " from web_" + func + "_reporting_status (" + misStatus.getZillaid() + "," + misStatus.getUpazilaid() + "," + misStatus.getUnionid() + "," + misStatus.getProvtype() + "," + misStatus.getMonth() + "," + misStatus.getYear() + ") t;";
        System.out.println("SQL: " + sql);
        Statement stmt = connection.createStatement();
        ResultSet resultSet = null;
        resultSet = stmt.executeQuery(sql);
        connection.close();
        return Convertor.convertResultSetIntoJSONWithDash(resultSet);
    }

    public JSONArray getMISSubmissionStatusDGFP(MISStatus misStatus, String func) throws SQLException, Exception {
//        String sql = "select count(*) as total_provider\n"
//                + "	,count(*) filter(where t.status is null) as not_submitted\n"
//                + "	,count(*) filter(where t.status is not null) as submitted\n"
//                + "	,count(*) filter(where t.status = 1) as approved\n"
//                + "	,count(*) filter(where t.status = 0) as pending\n"
//                + "	,count(*) filter(where t.status = 2) as need_to_resubmit\n"
//                + "	,count(*) filter(where t.status = 3) as resubmitted\n"
//                + "	,count(*) filter(where t.status = 4) as reopened\n"
//                + " from web_" + func + "_reporting_status (" + misStatus.getZillaid() + "," + misStatus.getUpazilaid() + "," + misStatus.getUnionid() + "," + misStatus.getProvtype() + "," + misStatus.getMonth() + "," + misStatus.getYear() + ") t;";
//        
        String sql = "select count(*) as total_unit\n"
                + ",count(*) filter(where u.active=1) as total_filled_up\n"
                + ",count(*) filter(where u.active=0) as total_vacant\n"
                + ",count(*) filter(where u.status is not null) as submitted\n"
                + ",count(*) filter(where u.status is not null and u.assign_type=1) as submitted_main\n"
                + ",count(*) filter(where u.status is not null and u.assign_type=2) as submitted_additional\n"
                + ",count(*) filter(where u.status = 1) as approved\n"
                + ",count(*) filter(where u.status in (0,2,3,4)) as waiting --waiting\n"
                + ",count(*) filter(where u.status is null) as not_submitted\n"
                + ",count(*) filter(where u.status is null and u.assign_type=1) as not_submitted_main\n"
                + ",count(*) filter(where u.status is null and u.assign_type=2) as not_submitted_additional\n"
                + ",count(*) filter(where u.status is null and u.active=0) as not_submitted_vacant\n"
                + "from web_" + func + "_reporting_status_dgfp(" + misStatus.getZillaid() + ", " + misStatus.getUpazilaid() + ", " + misStatus.getUnionid() + ", " + misStatus.getMonth() + ", " + misStatus.getYear() + ") u;";
        if (func == "mis2") {
            sql = "select count(*) as total_unit, \n"
                    + "count(*) filter(where t.status is null) as not_submitted\n"
                    + ",count(*) filter(where t.status is not null) as submitted \n"
                    + ",count(*) filter(where t.status = 1) as approved\n"
                    + ",count(*) filter(where t.status in (0,2,3,4)) as waiting\n"
                    + ",count(*) filter(where t.status = 2) as need_to_resubmit\n"
                    + ",count(*) filter(where t.status = 3) as resubmitted\n"
                    + ",count(*) filter(where t.status = 3) as reopened\n"
                    + ",count(*) filter(where t.assign_type=1) as main\n"
                    + ",count(*) filter(where t.assign_type=2) as additional\n"
                    + ",count(*) filter(where t.assign_type=1 and t.status is not null) as submitted_main\n"
                    + ",count(*) filter(where t.assign_type=2 and t.status is not null) as submitted_additional\n"
                    + ",count(*) filter(where t.assign_type=1 and t.status is null) as notsubmitted_main\n"
                    + ",count(*) filter(where t.assign_type=2 and t.status is null) as notsubmitted_additional "
                    + "from web_" + func + "_reporting_status_dgfp(" + misStatus.getZillaid() + ", " + misStatus.getUpazilaid() + ", " + misStatus.getUnionid() + ", " + misStatus.getMonth() + ", " + misStatus.getYear() + ") t;";
        } else if (func == "mis4") {
            sql = "select count(*) as total_unit, \n"
                    + "count(*) filter(where t.status is null) as not_submitted\n"
                    + ",count(*) filter(where t.status is not null) as submitted \n"
                    + ",count(*) filter(where t.status = 1) as approved\n"
                    + ",count(*) filter(where t.status in (0,2,3,4)) as waiting\n"
                    + ",count(*) filter(where t.status = 2) as need_to_resubmit\n"
                    + ",count(*) filter(where t.status = 3) as resubmitted\n"
                    + ",count(*) filter(where t.status = 3) as reopened\n"
                    + ",count(*) filter(where t.assign_type=1) as main\n"
                    + ",count(*) filter(where t.assign_type=2) as additional\n"
                    + ",count(*) filter(where t.assign_type=1 and t.status is not null) as submitted_main\n"
                    + ",count(*) filter(where t.assign_type=2 and t.status is not null) as submitted_additional\n"
                    + ",count(*) filter(where t.assign_type=1 and t.status is null) as notsubmitted_main\n"
                    + ",count(*) filter(where t.assign_type=2 and t.status is null) as notsubmitted_additional "
                    + "from web_" + func + "_reporting_status_dgfp(p_zillaid=>" + misStatus.getZillaid() + ", p_month=>" + misStatus.getMonth() + ", p_year=>" + misStatus.getYear() + ") t;";
        }
        this.print("SQL: " + sql + " function name::" + func);
        Statement stmt = connection.createStatement();
        ResultSet resultSet = null;
        resultSet = stmt.executeQuery(sql);
        connection.close();
        return Convertor.convertResultSetIntoJSONWithDash(resultSet);
    }

    public JSONArray getProviderList(MISStatus misStatus, int type, String func) throws SQLException, Exception {
        String status = "";
        switch (type) {
            case 0:
                status = "";
                break;
            case 1:
                status = "where status in (0,2,3,4)";
                break;
            case 2:
                status = "where status = 1";
                break;
            case 3:
                status = "where status is null";
                break;
            case 4:
                status = "where status is not null";
                break;
        }
        String sql = "select * from web_" + func + "_reporting_status(" + misStatus.getZillaid() + "," + misStatus.getUpazilaid() + "," + misStatus.getUnionid() + "," + misStatus.getProvtype() + "," + misStatus.getMonth() + "," + misStatus.getYear() + ") " + status;
        System.out.println("SQL:" + sql);
        Statement stmt = connection.createStatement();
        ResultSet resultSet = null;
        resultSet = stmt.executeQuery(sql);
        connection.close();
        return Convertor.toJSON(resultSet);
    }

    public JSONArray getProviderListDGFP(MISStatus misStatus, int type, String func) throws SQLException, Exception {
        String status = "";
        switch (type) {
            case 0:
                status = "";
                break;
            case 1:
                status = "where status in (0,2,3,4)";
                break;
            case 2:
                status = "where status = 1";
                break;
            case 3:
                status = "where status is null";
                break;
            case 4:
                status = "where status is not null";
                break;
        }
        String sql = "select * from web_" + func + "_reporting_status_dgfp(" + misStatus.getZillaid() + "," + misStatus.getUpazilaid() + "," + misStatus.getUnionid() + "," + misStatus.getMonth() + "," + misStatus.getYear() + ") " + status;
        System.out.println("SQL:" + sql);
        Statement stmt = connection.createStatement();
        ResultSet resultSet = null;
        resultSet = stmt.executeQuery(sql);
        connection.close();
        return Convertor.toJSON(resultSet);
    }

    public JSONArray getMIS1(MISStatus misStatus) throws SQLException, Exception {
        String sql = "select data FROM public.web_report_submission where zillaid = " + misStatus.getZillaid() + " and submission_from = " + misStatus.getProviderid() + " and provtype = " + misStatus.getProvtype() + " and fwaunit = " + misStatus.getUnit() + " and month = " + misStatus.getMonth() + " and year = " + misStatus.getYear();
        System.out.println("SQL:" + sql);
        Statement stmt = connection.createStatement();
        ResultSet resultSet = stmt.executeQuery(sql);
        connection.close();
        JSONArray json = null;

        while (resultSet.next()) {
            System.out.println(resultSet.getString(1));
        }
        //System.out.println(json.get("MIS1"));
        //return Convertor.convertResultSetIntoJSONWithDash(resultSet);
        return json;
    }

    public String getMIS1(MISStatus misStatus, int a) throws SQLException, Exception {
        String sql = "select * FROM public.web_report_submission where zillaid = " + misStatus.getZillaid() + " and submission_from = " + misStatus.getProviderid() + " and provtype = " + misStatus.getProvtype() + " and fwaunit = " + misStatus.getUnit() + " and month = " + misStatus.getMonth() + " and year = " + misStatus.getYear();
        System.out.println("SQL:" + sql);
        Statement stmt = connection.createStatement();
        ResultSet resultSet = stmt.executeQuery(sql);
        connection.close();
        String json = null, submissionDate = null;

        while (resultSet.next()) {
            json = resultSet.getString("data");
            submissionDate = resultSet.getString("modifydate");
        }
        return json + "~" + submissionDate;
    }

    public String getMIS1DGFP(MISStatus misStatus) throws SQLException, Exception {
        String sql = "select * FROM public.web_report_submission_dgfp where zillaid = " + misStatus.getZillaid() + " and submission_from = " + misStatus.getProviderid() + " and fwaunit = " + misStatus.getUnit() + " and month = " + misStatus.getMonth() + " and year = " + misStatus.getYear();
        System.out.println("SQL:" + sql);
        Statement stmt = connection.createStatement();
        ResultSet resultSet = stmt.executeQuery(sql);
        connection.close();
        String json = null, submissionDate = null;

        while (resultSet.next()) {
            json = resultSet.getString("data");
            submissionDate = resultSet.getString("modifydate");
        }
        String rs = json + "~" + submissionDate;
        return rs;
    }

    public JSONArray getMIS2(MISStatus misStatus) throws SQLException, Exception {
        String sql = "select * FROM public.web_report_submission where zillaid = " + misStatus.getZillaid() + " and submission_from = " + misStatus.getProviderid() + " and provtype = " + misStatus.getProvtype() + " and month = " + misStatus.getMonth() + " and year = " + misStatus.getYear();
        System.out.println("SQL:" + sql);
        Statement stmt = connection.createStatement();
        ResultSet resultSet = null;
        resultSet = stmt.executeQuery(sql);
        connection.close();
        return Convertor.toJSON(resultSet);
    }

    public JSONArray getMIS2DGFP(MISStatus misStatus) throws SQLException, Exception {
        String sql = "select * FROM public.web_report_submission_dgfp where zillaid = " + misStatus.getZillaid()
                + " and upazilaid = " + misStatus.getUpazilaid() + " and reporting_unionid = " + misStatus.getUnionid() + " and modrep =702"
                + " and month = " + misStatus.getMonth() + " and year = " + misStatus.getYear();
        System.out.println("SQL:" + sql);
        Statement stmt = connection.createStatement();
        ResultSet resultSet = null;
        resultSet = stmt.executeQuery(sql);
        connection.close();
        return Convertor.toJSON(resultSet);
    }

    public String getMIS4(MISStatus misStatus) throws SQLException, Exception {
        String sql = "select *, name_zila(zillaid) zillaname,name_upazila(zillaid, upazilaid) upazilaname FROM public.web_report_submission where zillaid = " + misStatus.getZillaid() + " and submission_from = " + misStatus.getProviderid() + " and provtype = " + misStatus.getProvtype() + " and month = " + misStatus.getMonth() + " and year = " + misStatus.getYear();
        System.out.println("SQL:" + sql);
        Statement stmt = connection.createStatement();
        ResultSet resultSet = null;
        resultSet = stmt.executeQuery(sql);
        connection.close();
        String json = null, submissionDate = null, zillaname = null, upazilaname = null;

        while (resultSet.next()) {
            json = resultSet.getString("data");
            submissionDate = resultSet.getString("modifydate");
            zillaname = resultSet.getString("zillaname");
            upazilaname = resultSet.getString("upazilaname");
        }
        return json + "~" + submissionDate + "~" + zillaname + "~" + upazilaname;
    }

    public String getMIS4DGFP(MISStatus misStatus) throws SQLException, Exception {
        String sql = "select *, name_zila(zillaid) zillaname,name_upazila(zillaid, upazilaid) upazilaname FROM public.web_report_submission_dgfp where zillaid = " + misStatus.getZillaid() + " and upazilaid = " + misStatus.getUpazilaid() + " and modrep = 704  and month = " + misStatus.getMonth() + " and year = " + misStatus.getYear();
        System.out.println("SQL:" + sql);
        Statement stmt = connection.createStatement();
        ResultSet resultSet = null;
        resultSet = stmt.executeQuery(sql);
        connection.close();
        String json = null, submissionDate = null, zillaname = null, upazilaname = null;

        while (resultSet.next()) {
            json = resultSet.getString("data");
            submissionDate = resultSet.getString("modifydate");
            zillaname = resultSet.getString("zillaname");
            upazilaname = resultSet.getString("upazilaname");
        }
        return json + "~" + submissionDate + "~" + zillaname + "~" + upazilaname;
    }

    public JSONArray getNGOData(int districtId, int upazilaId, int month, int year) {
        JSONArray ngo = null;
        try {
            String query = "select * from web_mis4_report_9v_ngo(" + districtId + "," + upazilaId + "," + year + "," + month + ")";
            ngo = Convertor.toJSON(new DBManagerDistrict(districtId).select(query));
            return ngo;
        } catch (Exception ex) {
            return ngo;
        }
    }

    public JSONArray getNGODataDGFP(int districtId, int upazilaId, int month, int year) {
        JSONArray ngo = null;
        try {
            String query = "select * from web_mis4_report_9v_ngo_dgfp(" + districtId + "," + upazilaId + "," + year + "," + month + ")";
            ngo = Convertor.toJSON(new DBManagerDistrict(districtId).select(query));
            return ngo;
        } catch (Exception ex) {
            return ngo;
        }
    }

    public JSONArray getMIS4Color(int districtId, int upazilaId, int month, int year) {
        JSONArray mis4Color = null;
        try {
            String query = "select * from web_mis4_report_9v_color(" + districtId + "," + upazilaId + "," + year + "," + month + ")";
            mis4Color = Convertor.toJSON(new DBManagerDistrict(districtId).select(query));
            return mis4Color;
        } catch (Exception ex) {
            return mis4Color;
        }
    }

    public JSONArray getAllStatus(MISStatus misStatus, String func) throws SQLException, Exception {
        ArrayList<Integer> districtIdList = this.getImplDistrictList();
        ArrayList<JSONArray> JSONArrayList = new ArrayList<JSONArray>();
        for (int district : districtIdList) {
            String sql = "select count(*) as total_unit\n"
                    + ",count(*) filter(where u.active=1) as total_filled_up\n"
                    + ",count(*) filter(where u.active=0) as total_vacant\n"
                    + ",count(*) filter(where u.status is not null) as submitted\n"
                    + ",count(*) filter(where u.status is not null and u.assign_type=1) as submitted_main\n"
                    + ",count(*) filter(where u.status is not null and u.assign_type=2) as submitted_additional\n"
                    + ",count(*) filter(where u.status = 1) as approved\n"
                    + ",count(*) filter(where u.status in (0,2,3,4)) as waiting --waiting\n"
                    + ",count(*) filter(where u.status is null) as not_submitted\n"
                    + ",count(*) filter(where u.status is null and u.assign_type=1) as not_submitted_main\n"
                    + ",count(*) filter(where u.status is null and u.assign_type=2) as not_submitted_additional\n"
                    + ",count(*) filter(where u.status is null and u.active=0) as not_submitted_vacant\n"
                    + "from web_mis1_reporting_status_dgfp("+district+", 0, 0, "+misStatus.getMonth()+", "+misStatus.getYear()+") u;";
            db = new DBManagerDistrict(district);
            connection = db.openConnection();
            ResultSet resultSet = connection.createStatement().executeQuery(sql);
            JSONArray json = Convertor.convertResultSetIntoJSON(resultSet);
            JSONArrayList.add(json);
            System.out.println(sql);
        }
        connection.close();
        return Convertor.getMergeJsonArrays(JSONArrayList);
    }
    
    protected ArrayList<Integer> getImplDistrictList() throws SQLException, Exception {
        DBManagerMonitoring db = new DBManagerMonitoring();
        connection = db.getConnection();
        ArrayList<Integer> districtIdList = new ArrayList<Integer>();
        String sql = "select distinct zillaid, zillaname, zillanameeng from implemented_div_zila where is_implemented=1 and is_paperless=1 and zillaid not in (99, 991) order by zillanameeng asc";
        ResultSet resultSet = connection.createStatement().executeQuery(sql);
        while (resultSet.next()) {
            districtIdList.add(resultSet.getInt("ZILLAID"));
        }
        return districtIdList;
    }

    private int toInt(String num) {
        return Integer.parseInt(num);
    }

    private void print(Object o) {
        System.out.println(o);
    }

}
