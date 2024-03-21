package com.emis.dao;

import com.emis.dao.ProviderManagement.ProviderManagement;
import com.emis.entity.ProviderAreaUnit;
import com.emis.entity.ReportingUpazila;
import com.emis.entity.ReportingUnion;
import com.emis.entity.ReportingUnionFPI;
import com.emis.entity.ReportingUnit;
import com.emis.entity.ReportingUpazilaUFPO;
import com.emis.utility.Convertor;
import com.emis.utility.Print;
import com.rhis.db.DBManagerDistrict;
import com.rhis.db.DBManagerMonitoring;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

/**
 *
 * @author Helal
 */
public class ReportingGeoDao {

    private DBManagerMonitoring db = null;
    private Connection connection = null;
    private String sql = null;

    public ReportingGeoDao() {
        db = new DBManagerMonitoring();
        connection = db.openConnection();
    }

    public ReportingGeoDao(int districtId) {
        db = new DBManagerDistrict(districtId);
        connection = db.openConnection();
    }

    public JSONArray getUFPOList() throws SQLException, Exception {
        ResultSet resultSet = connection.createStatement().executeQuery("select providerid, provname from providerdb where active =1 and provtype=15");
        connection.close();
        return Convertor.toJSON(resultSet);
    }

    public JSONArray getUpazilaList(int districtId) throws SQLException, Exception {
        //ResultSet resultSet = connection.createStatement().executeQuery("select zillaid, upazilaid, upazilanameeng from implemented_div_zila where zillaid = " + districtId + " and is_implemented = 1");
        // ru left join reporting_upazila_ufpo using(zillaid, upazilaid)
//        String sql = "select ru.zillaid, ru.upazilaid, reporting_upazilanameeng upazilanameeng from reporting_upazila ru";
        String sql = "select ru.zillaid, ru.upazilaid, reporting_upazilanameeng upazilanameeng from reporting_upazila ru where ru.zillaid = " + districtId + " and\n"
                + "not exists ( select 1 from reporting_upazila_ufpo ruu where ru.zillaid=ruu.zillaid and ru.upazilaid=ruu.upazilaid)";
        ResultSet resultSet = connection.createStatement().executeQuery(sql);
        connection.close();
        return Convertor.toJSON(resultSet);
    }

    //getReportingUpazilaDetailsByUFPO
    public JSONArray getReportingUpazilaDetailsByUFPO(ReportingUpazila rUpz) throws SQLException, Exception {
        String sql = "SELECT zillaid, upazilaid, reporting_upazilaid, reporting_upazilanameeng, reporting_upazilaname, providerid, assign_type  \n"
                + "FROM reporting_upazila ru join reporting_upazila_ufpo ruu using(zillaid, upazilaid) where providerid = " + rUpz.getProviderid() + " order by ruu.assign_type";
        System.out.println("getReportingUpazilaDetailsByUFPO" + sql);
        ResultSet resultSet = connection.createStatement().executeQuery(sql);
        connection.close();
        return Convertor.toJSON(resultSet);
    }

    public boolean setUFPO(Object ufpoObj) throws SQLException, Exception {
        JSONArray ufpoList = new JSONArray(ufpoObj.toString());
        db.start();
        for (int i = 0; i < ufpoList.length(); i++) {
            JSONObject obj = ufpoList.getJSONObject(i);
            String sql = "INSERT INTO reporting_upazila_ufpo (zillaid, upazilaid, providerid, assign_type)\n"
                    + "VALUES (" + obj.get("zillaid") + ", " + obj.get("upazilaid") + ", " + obj.get("providerid") + ", " + obj.get("assign_type") + ")\n"
                    + "ON CONFLICT (zillaid, upazilaid,providerid) \n"
                    + "DO UPDATE SET providerid = EXCLUDED.providerid, assign_type = EXCLUDED.assign_type;";
            db.update(sql);
        }
        //db.rollback();
        db.commit();
        connection.close();
        return true;
    }

    public String insertReportingUpazilaUFPO(ReportingUpazila ru) throws Exception {
        try {
            System.out.println(ru);
            int zillaid = ru.getZillaid();
            int upazilaid = ru.getUpazilaid();
            int providerid = ru.getProviderid();
            int assign_type = ru.getAssign_type();
            if (assign_type == 0) {
                throw new Exception("Fill Up All Field");
            }
            //CHECK MAIN UNION ASSIGNED
            if (assign_type == 1) {
                String checkUFPOAssigned = "SELECT * FROM reporting_upazila_ufpo where providerid = " + providerid + " and assign_type = 1 and zillaid = " + zillaid;
                Print.o(checkUFPOAssigned);
                ResultSet rsAssignType = connection.createStatement().executeQuery(checkUFPOAssigned);
                if (rsAssignType.next()) {
                    throw new Exception("Main upazila for this provider already assigned");
                }
            }
            //CHECK UNION ALREADY ASSIGNED TO OTHER
            String getUnionAssigned = "SELECT * FROM reporting_upazila_ufpo where  zillaid = " + zillaid + " and upazilaid = " + upazilaid;
            ResultSet rsGetUpazilaAssigned = connection.createStatement().executeQuery(getUnionAssigned);
            if (rsGetUpazilaAssigned.next()) {
                throw new Exception("Upazila already assigned");
            }

            String sql_reporting_upazila_ufpo = "INSERT INTO public.reporting_upazila_ufpo(zillaid, upazilaid, providerid, assign_type, active)\n"
                    + "VALUES (" + zillaid + "," + upazilaid + "," + providerid + "," + assign_type + ",1)";
            db.start();
            db.update(sql_reporting_upazila_ufpo);
            db.commit();
            connection.close();
            return "Successfully Assigned";
        } catch (Exception e) {
            return e.getMessage();
        }
    }

    public JSONArray getUnassignedReportingUnionByUpazila(ReportingUnion ru) throws JSONException {
        try {
            String sql = "select ru.zillaid, ru.upazilaid, ru.reporting_unionid, ru.unionname, ru.unionnameeng, trim(ru.unionids::text, '{}') as unionids, ru.unionid, ru.is_actual "
                    + "from reporting_union ru where ru.zillaid =" + ru.getZillaid() + "and ru.upazilaid = " + ru.getUpazilaid() + " and \n"
                    + "not exists ( select 1 from reporting_union_fpi ruf where ru.zillaid=ruf.zillaid and ru.upazilaid=ruf.upazilaid and ru.reporting_unionid=ruf.reporting_unionid)";

//            String sql = "select z.zillanameeng, upz.upazilanameeng, ru.unionname, ru.unionnameeng, ru.zillaid, ru.upazilaid"
//                    + ", ru.reporting_unionid, trim(ru.unionids::text, '{}') as unionids, ru.unionid, ru.is_actual  from reporting_union ru\n"
//                    + " join zilla z on z.zillaid=ru.zillaid\n"
//                    + " join upazila upz on ru.zillaid = upz.zillaid and ru.upazilaid=upz.upazilaid\n"
//                    + " where ru.zillaid=" + ru.getZillaid() + " and ru.upazilaid=" + ru.getUpazilaid() + "\n"
//                    + " order by z.zillanameeng, upz.upazilanameeng, ru.unionname";
            ResultSet resultSet = connection.createStatement().executeQuery(sql);
            this.print(sql + " HHHH");
            return Convertor.toJSON(resultSet);
        } catch (Exception e) {
            e.printStackTrace();
            JSONObject jo = new JSONObject();
            jo.put("message", e.getMessage());
            JSONArray ja = new JSONArray();
            ja.put(jo);

            return ja;
        }
    }

    public JSONArray getReportingUnion(ReportingUnion ru) throws JSONException {
        try {
            String sql = "select z.zillanameeng, upz.upazilanameeng, ru.unionname, ru.unionnameeng, ru.zillaid, ru.upazilaid"
                    + ", ru.reporting_unionid, trim(ru.unionids::text, '{}') as unionids, ru.unionid, ru.is_actual  from reporting_union ru\n"
                    + " join zilla z on z.zillaid=ru.zillaid\n"
                    + " join upazila upz on ru.zillaid = upz.zillaid and ru.upazilaid=upz.upazilaid\n"
                    + " where ru.zillaid=" + ru.getZillaid() + " and ru.upazilaid=" + ru.getUpazilaid() + "\n"
                    + " order by z.zillanameeng, upz.upazilanameeng, ru.unionname";
            ResultSet resultSet = connection.createStatement().executeQuery(sql);
            this.print(sql + " HHHH");
            return Convertor.toJSON(resultSet);
        } catch (Exception e) {
            e.printStackTrace();
            JSONObject jo = new JSONObject();
            jo.put("message", e.getMessage());
            JSONArray ja = new JSONArray();
            ja.put(jo);

            return ja;
        }
    }

    public JSONArray getFPI(ReportingUnion ru) throws JSONException {
        try {
            String sql = "select z.zillanameeng, upz.upazilanameeng, ru.unionname, ru.unionnameeng, pdb.provname, ruf.assign_type  from reporting_union_fpi ruf\n"
                    + "	join zilla z on z.zillaid=ruf.zillaid\n"
                    + "	join upazila upz on ruf.zillaid = upz.zillaid and ruf.upazilaid=upz.upazilaid\n"
                    + "	join reporting_union ru on ruf.zillaid = ru.zillaid and ruf.upazilaid = ru.upazilaid and ruf.reporting_unionid = ru.reporting_unionid\n"
                    + "	join providerdb pdb on ruf.providerid = pdb.providerid\n"
                    + "	where ruf.zillaid=" + ru.getZillaid() + " and ruf.upazilaid=" + ru.getUpazilaid();
            ResultSet resultSet = connection.createStatement().executeQuery(sql);
            connection.close();
            this.print(sql);
            return Convertor.toJSON(resultSet);
        } catch (Exception e) {
            e.printStackTrace();
            JSONObject jo = new JSONObject();
            jo.put("message", e.getMessage());
            JSONArray ja = new JSONArray();
            ja.put(jo);
            return ja;
        }
    }

    public boolean duplicateUnionExist(String unionNameEng, String unionNameBn) throws SQLException {
        String sql = "SELECT * FROM reporting_union where unionnameeng = '" + unionNameEng + "' or " + " unionname='" + unionNameBn + "'";
        Print.o(sql);
        ResultSet rs = connection.createStatement().executeQuery(sql);
        if (rs.next()) {
            return true;
        } else {
            return false;
        }
    }

    public boolean duplicateUnionExistByName(ReportingUnion ru) throws SQLException {
        String sql = "SELECT * FROM reporting_union where zillaid=" + ru.getZillaid() + " and upazilaid=" + ru.getUpazilaid() + " and (unionnameeng = '" + ru.getUnionnameeng() + "' or " + " unionname='" + ru.getUnionname() + "')";
        Print.o(sql);
        ResultSet rs = connection.createStatement().executeQuery(sql);
        if (rs.next()) {
            return true;
        } else {
            return false;
        }
    }

    public boolean duplicateUnionExistByUnionId(ReportingUnion ru) throws SQLException {
        String sql = "SELECT * FROM reporting_union where zillaid=" + ru.getZillaid() + " and upazilaid=" + ru.getUpazilaid() + " and reporting_unionid = " + ru.getUnionid();
        Print.o(sql);
        ResultSet rs = connection.createStatement().executeQuery(sql);
        if (rs.next()) {
            return true;
        } else {
            return false;
        }
    }

    private void insertReportingUnion(ReportingUnion ru) throws SQLException {
        db.start();
        //Insert into reporting_union
        //Need to pass is_actual from client based on actual union selection or other union selection
        String sql_reporting_union = "INSERT INTO public.reporting_union(zillaid, upazilaid, reporting_unionid, unionnameeng, unionname, unionids, unionid, is_actual)\n"
                + "VALUES (" + ru.getZillaid() + "," + ru.getUpazilaid() + "," + ru.getUnionid() + ",'"
                + ru.getUnionnameeng() + "','" + ru.getUnionname() + "','" + ru.getUnionids() + "'::integer[],"
                + ru.getUnionid() + "," + ru.getIs_actual() + ")\n"
                + "ON CONFLICT (zillaid, upazilaid, reporting_unionid)\n"
                + "DO UPDATE SET reporting_unionid = EXCLUDED.reporting_unionid, unionnameeng = EXCLUDED.unionnameeng, unionname = EXCLUDED.unionname, unionids = EXCLUDED.unionids, unionid = EXCLUDED.unionid ;";
        db.update(sql_reporting_union);
        db.commit();
        connection.close();
    }

    public String setReportingUnionFPI(ReportingUnion ru) throws Exception {
        try {
            int zillaid = ru.getZillaid();
            int upazilaid = ru.getUpazilaid();

            int reporting_unionid = ru.getReporting_unionid();
            //work
            int providerid = ru.getProviderid();
            int assign_type = ru.getAssign_type();
            if (assign_type == 0) {
                throw new Exception("Fill Up All Field");
            }
            //CHECK MAIN UNION ASSIGNED
            if (assign_type == 1) {
                String checkFPIAssigned = "SELECT * FROM reporting_union_fpi where providerid = " + providerid + " and assign_type = 1 and zillaid = " + zillaid + " and upazilaid = " + upazilaid;
                ResultSet rsAssignType = connection.createStatement().executeQuery(checkFPIAssigned);
                if (rsAssignType.next()) {
                    throw new Exception("Main union for this provider already assigned");
                }
            }
            //CHECK UNION ALREADY ASSIGNED TO OTHER
            String getUnionAssigned = "SELECT * FROM reporting_union_fpi where  reporting_unionid = " + reporting_unionid + "and zillaid = " + zillaid + " and upazilaid = " + upazilaid;
            ResultSet rsGetUnionAssigned = connection.createStatement().executeQuery(getUnionAssigned);
            if (rsGetUnionAssigned.next()) {
                throw new Exception("Union already assigned");
            }

            String sql_reporting_union_fpi = "INSERT INTO public.reporting_union_fpi(zillaid, upazilaid, reporting_unionid, providerid, assign_type, active)\n"
                    + "VALUES (" + zillaid + "," + upazilaid + "," + reporting_unionid + "," + providerid + "," + assign_type + ",1)";
            db.start();
            db.update(sql_reporting_union_fpi);
            db.commit();
            connection.close();
            return "Successfully Assigned";
        } catch (Exception e) {
            return e.getMessage();
        }
    }

//    public JSONArray getReportingUnionFPI(ReportingUnion ru) throws Exception {
//        try {
//            int providerid = ru.getProviderid();
//            String sql = "select * from reporting_union_fpi ruf"
////                    + " join reporting_union ru on ruf.reporting_unionid = ru.reporting_unionid "
////                    + " join providerdb pdb on ruf.providerid = pdb.providerid "
//                    + " where ruf.providerid =" + providerid + ";";
//            this.print(sql);
//            ResultSet resultSet = connection.createStatement().executeQuery(sql);
////        connection.close();
//            return Convertor.toJSON(resultSet);
//        } catch (Exception e) {
//            e.printStackTrace();
//            JSONObject jo = new JSONObject();
//            jo.put("message", e.getMessage());
//            JSONArray ja = new JSONArray();
//            ja.put(jo);
//            return ja;
//        }
//    }
    public JSONArray getReportingUnionFPI(ReportingUnion ru) throws JSONException {
        try {
            int providerid = ru.getProviderid();
            String sql = "select ru.zillaid, ru.upazilaid, ru.unionnameeng, ru.reporting_unionid, ruf.providerid, ruf.assign_type from public.reporting_union_fpi ruf \n"
                    + "join reporting_union ru on ru.zillaid = ruf.zillaid and ru.upazilaid = ruf.upazilaid and ruf.reporting_unionid = ru.reporting_unionid  \n"
                    + "join providerdb pdb on ruf.providerid = pdb.providerid  where ruf.providerid =" + providerid + " "
                    + "order by ruf.assign_type,ru.unionnameeng;";
            ResultSet resultSet = connection.createStatement().executeQuery(sql);
            this.print(sql);
            return Convertor.toJSON(resultSet);
        } catch (Exception e) {
            e.printStackTrace();
            JSONObject jo = new JSONObject();
            jo.put("message", e.getMessage());
            JSONArray ja = new JSONArray();
            ja.put(jo);
            return ja;
        }
    }
    // when request is from catchment provider management

    public String setReportingUnion(ReportingUnion ru) throws Exception {
        try {
            //Vaidate by id
            boolean duplicateUnionExistByUnionId = this.duplicateUnionExistByUnionId(ru);
            if (duplicateUnionExistByUnionId) {
                throw new Exception("This union already exist");
            }

            //Validate by name
            String unionNameEng = ru.getUnionnameeng();
            String unionName = ru.getUnionname();
            boolean dupeUnionExist = this.duplicateUnionExistByName(ru);
            System.out.println("HHHHH:" + ru.getRequest_from());
            if (dupeUnionExist) {
                throw new Exception("This union already exist");
            }
            //Set is actual value based on same bbs or not
            if (ru.getUnionid() == 99) {
                ru.setIs_actual(0);
                ru = this.setUnonidByReportingUnion(ru);
                if (ru.getUnionid() == 0) {
                    ru = this.setUnonidByUnions(ru);
                }
            }
            if (ru.getRequest_from() != "") {
                int request_from = Integer.parseInt(ru.getRequest_from());
                ru.setUnionid(request_from);
            }
            ru.setUnionids("{" + ru.getUnionids() + "}");
            if (ru.getUnionname().equals("")) {
                ru = this.setUnionname(ru);
            }
            this.insertReportingUnion(ru);
            return "Successfully Added";
        } catch (Exception e) {
            System.out.println("Insert REPORTINGUNIT EXCEPTION: " + e.getMessage());
            return e.getMessage();
        }
    }

    public String updateReportingUnion(ReportingUnion ru) throws Exception {
        try {
            db.start();
            if (ru.getRequest_from() != "") {
                int request_from = Integer.parseInt(ru.getRequest_from());
                ru.setUnionid(request_from);
            }
            ru.setUnionids("{" + ru.getUnionids() + "}");
            if (ru.getUnionname().equals("")) {
                ru = this.setUnionname(ru);
            }

            String update = "unionids='" + ru.getUnionids() + "'::integer[], ";
            if (!ru.getUnionnameeng().equals("")) {
                update += " unionnameeng='" + ru.getUnionnameeng() + "', ";
            }
            if (!ru.getUnionname().equals("")) {
                update += " unionname='" + ru.getUnionname() + "', ";
            }
            String sql = "UPDATE public.reporting_union set " + update + " modifydate=now() WHERE zillaid=" + ru.getZillaid() + " and upazilaid=" + ru.getUpazilaid() + " and reporting_unionid=" + ru.getUnionid();
            Print.o(sql);
            int updateReportingUnion = db.update(sql);
            if (updateReportingUnion > 0) {
                db.commit();
                connection.close();
                return "Union update successfully";
            } else {
                db.rollback();
                connection.close();
                return "Something went wrong";
            }

            //this.insertReportingUnion(ru);
            //return "Successfully Added";
        } catch (Exception e) {
            System.out.println("Insert REPORTINGUNIT EXCEPTION: " + e.getMessage());
            return e.getMessage();
        }
    }

    public String deleteReportingUnion(ReportingUnion ru) throws Exception {
        try {
            db.start();
            String sql = "DELETE FROM public.reporting_union WHERE zillaid=" + ru.getZillaid() + " and upazilaid=" + ru.getUpazilaid() + " and reporting_unionid=" + ru.getUnionid();
            Print.o(sql);
            int deleteReportingUnion = db.update(sql);
            if (deleteReportingUnion > 0) {
                db.commit();
                connection.close();
                return "Union delete successfully";
            } else {
                db.rollback();
                connection.close();
                return "Something went wrong";
            }
        } catch (Exception e) {
            System.out.println("Insert REPORTINGUNIT EXCEPTION: " + e.getMessage());
            return e.getMessage();
        }
    }

    public String setFPI(ReportingUnion ru) throws SQLException, Exception {
        try {
            //
            String getUnionAssigned = "";

            if (ru.getUnionid() == 99) {
                getUnionAssigned = "SELECT * FROM reporting_union where unionnameeng = '" + ru.getUnionnameeng() + "'";
            } else {
                getUnionAssigned = "SELECT * FROM reporting_union_fpi where  reporting_unionid = " + ru.getUnionid();
            }

            ResultSet rsUnionAssigned = connection.createStatement().executeQuery(getUnionAssigned);
            if (rsUnionAssigned.next()) {
                return "Union already assigned.";
            }
            //Asssign type main, 
            if (ru.getAssign_type() == 1) {
                String getAssignType = "SELECT * FROM reporting_union_fpi where providerid = " + ru.getProviderid() + " and assign_type = 1";
                ResultSet rsAssignType = connection.createStatement().executeQuery(getAssignType);

                if (rsAssignType.next()) {
                    return "Main union for this provider already assigned";
                }
            }
            //Other Union
            //Set reporting Unionid
            //Formating unionids here
            //ru.setUnionids("{" + ru.getUnionids().substring(0, ru.getUnionids().length() - 1) + "}");
            ru.setUnionids("{" + ru.getUnionids() + "}");
            //Set union name if empty
            if (ru.getUnionname().equals("")) {
                ru = this.setUnionname(ru);
            }
            //Set unionid if empty (other)
            if (ru.getUnionid() == 99) {
                ru = this.setUnonidByReportingUnion(ru);
                if (ru.getUnionid() == 0) {
                    ru = this.setUnonidByUnions(ru);
                }
            }
            db.start();
            //Insert into reporting_union
            //Need to pass is_actual from client based on actual union selection or other union selection
            String sql_reporting_union = "INSERT INTO public.reporting_union(zillaid, upazilaid, reporting_unionid, unionnameeng, unionname, unionids, unionid, is_actual)\n"
                    + "VALUES (" + ru.getZillaid() + "," + ru.getUpazilaid() + "," + ru.getUnionid() + ",'" + ru.getUnionnameeng() + "','" + ru.getUnionname() + "','" + ru.getUnionids() + "'::integer[]," + ru.getUnionid() + ",1)\n"
                    + "ON CONFLICT (zillaid, upazilaid, reporting_unionid)\n"
                    + "DO UPDATE SET reporting_unionid = EXCLUDED.reporting_unionid, unionnameeng = EXCLUDED.unionnameeng, unionname = EXCLUDED.unionname, unionids = EXCLUDED.unionids, unionid = EXCLUDED.unionid ;";
            db.update(sql_reporting_union);
            this.print("SQL: " + sql_reporting_union);
            //Insert into reporting union fpi
            String sql_reporting_union_fpi = "INSERT INTO public.reporting_union_fpi(zillaid, upazilaid, reporting_unionid, providerid, assign_type, active)\n"
                    + "VALUES (" + ru.getZillaid() + "," + ru.getUpazilaid() + "," + ru.getUnionid() + "," + ru.getProviderid() + "," + ru.getAssign_type() + ",1)";
            db.update(sql_reporting_union_fpi);
            this.print("SQL: " + sql_reporting_union_fpi);
            db.commit();
            connection.close();
//            return ru;
            return "Successfully Added";
        } catch (Exception e) {
            e.printStackTrace();
//            return new ReportingUnion();
            return e.getMessage();
        }
    }

    private ReportingUnion setUnionname(ReportingUnion ru) throws SQLException, Exception {
        String sql = "select unionname, unionnameeng from unions where zillaid=" + ru.getZillaid() + " and upazilaid=" + ru.getUpazilaid() + " and unionid=" + ru.getUnionid();
        ResultSet rs = connection.createStatement().executeQuery(sql);
        while (rs.next()) {
            ru.setUnionname(rs.getString("unionname"));
            ru.setUnionnameeng(rs.getString("unionnameeng"));
        }
        return ru;
    }

    private ReportingUnion setUnonidByReportingUnion(ReportingUnion ru) throws SQLException, Exception {
        //Need to change query generating duplicate id.
        //String sql = "select (max(unionid)+1) unionid  from reporting_union where zillaid=" + ru.getZillaid() + " and upazilaid=" + ru.getUpazilaid();

        String sql = "select distinct new_id from (SELECT trunc((random() * (100 - 10)) + 1) AS new_id \n"
                + "FROM generate_series(10,98)) new_id where new_id not in (\n"
                + "	select * from 	(\n"
                + "		select ru.reporting_unionid from reporting_union ru where ru.zillaid=" + ru.getZillaid() + " and ru.upazilaid=" + ru.getUpazilaid() + "\n"
                + "		union \n"
                + "		select un.unionid from unions un where un.zillaid=" + ru.getZillaid() + " and un.upazilaid=" + ru.getUpazilaid() + " order by reporting_unionid\n"
                + "	) all_union_id\n"
                + ") \n"
                + "and length(new_id::text)=2 limit 1;";
        System.out.println(sql);
        ResultSet rs = connection.createStatement().executeQuery(sql);
        while (rs.next()) {
            ru.setUnionid(rs.getInt("new_id"));
        }
        return ru;
    }

    private ReportingUnion setUnonidByUnions(ReportingUnion ru) throws SQLException, Exception {
        String sql = "select (max(unionid)+1) unionid  from unions where zillaid=" + ru.getZillaid() + " and upazilaid=" + ru.getUpazilaid() + " and unionid not in (999)";
        ResultSet rs = connection.createStatement().executeQuery(sql);
        while (rs.next()) {
            ru.setUnionid(rs.getInt("unionid"));
        }
        return ru;
    }

    private ResultSet getUnionIds(int zillaid, int upazilaid, int reporting_union_id) throws SQLException {
        String sql = "select unionids from reporting_union where zillaid = " + zillaid + " and upazilaid =" + upazilaid + " and reporting_unionid = " + reporting_union_id;
        System.out.println(sql);
        ResultSet rs = connection.createStatement().executeQuery(sql);
        return rs;
    }

    private int generateUnitId(int zillaid) throws SQLException {
        String sql = "select max(unitid) as maxunitid from unit_master";
        ResultSet rs = connection.createStatement().executeQuery(sql);
        int unitId = 0;
        while (rs.next()) {
            Integer maxValue = rs.getInt("maxunitid");
            if (maxValue == 0) {
                String s = Integer.toString(zillaid);
                String unitidS = s + "0001";
                unitId = Integer.parseInt(unitidS);
            } else {
                unitId = maxValue + 1;
            }
        }
        return unitId;
    }

    private boolean checkProviderAssignType(int providerId) throws SQLException {
        String sql = "select * from providerarea_unit where providerid=" + providerId + " and assign_type=1";
        System.out.println("checkProviderAssignType: " + sql);
        ResultSet rs = connection.createStatement().executeQuery(sql);
        if (rs.next()) {
            return true;
        } else {
            return false;
        }
    }

    private boolean checkUnitAssigned(int zillaid, int upazilaid, int reporting_union_id, int fwaUnitLabel) throws SQLException {
        String sql = "select * from unit_master where zillaid=" + zillaid + " and upazilaid=" + upazilaid
                + " and reporting_unionid = " + reporting_union_id + " and unit =" + fwaUnitLabel;
        ResultSet rs = connection.createStatement().executeQuery(sql);
        if (rs.next()) {
            return true;
        } else {
            return false;
        }
    }

    private boolean checkUnitDetailsAssigned(int zillaid, int upazilaid, int reporting_union_id, int fwaUnitLabel) throws SQLException {
        String sql = "select * from unit_details where zillaid=" + zillaid + " and upazilaid=" + upazilaid
                + " and unionid = " + reporting_union_id + " and unit =" + fwaUnitLabel;
        ResultSet rs = connection.createStatement().executeQuery(sql);
        if (rs.next()) {
            return true;
        } else {
            return false;
        }
    }

    private void insertUnitMaster(int unitid, int fwaUnitLabel, int zillaid, int upazilaid, int reporting_union_id, String unionids, int providerid) throws SQLException {
        int active = 1;
        int upload = 1;
        int provtype = 3;

        String sql = "INSERT INTO public.unit_master(\n"
                + "            unitid, unit, zillaid, upazilaid, reporting_unionid, \n"
                + "            unionids, active, upload, provtype, providerid) VALUES("
                + unitid + "," + fwaUnitLabel + "," + zillaid + "," + upazilaid
                + "," + reporting_union_id + ",'" + unionids + "'," + active + "," + upload + "," + provtype + "," + providerid + ")";

        System.out.println(sql);
        db.update(sql);
    }

    private void insertUnitDetails(int unitid, int fwaUnitLabel, int zillaid, int upazilaid, int reporting_union_id, String[] villages) throws SQLException {
        String sqlValues = "";
        for (int i = 0; i < villages.length; i++) {
            String[] mv = villages[i].split("\\s");
            // mv[0]= unionid, mv[1]= mouzaid, mv[2]= villageid, 
            System.out.println(mv[0] + mv[1]);
            String values = "(" + unitid + "," + fwaUnitLabel + "," + zillaid + "," + upazilaid + "," + mv[0] + "," + mv[1] + "," + mv[2] + ")";
            if (i == (villages.length - 1)) {
                sqlValues += values;
            } else {
                sqlValues += values + ",";
            }
        }
        String sql = "INSERT INTO public.unit_details(\n"
                + "unitid, unit, zillaid, upazilaid, unionid, mouzaid, villageid \n" + ") values " + sqlValues;
        System.out.println("insertUnitDetails::" + sql);

        db.update(sql);
    }

    public JSONArray getUnitDetails(ReportingUnit ru) throws Exception {
//        String sql = "select z.zillanameeng, upz.upazilanameeng, ru.unionnameeng,  ru.reporting_unionid,  ud.unitid, ud.unit, fau.uname as fwaunitlabel, ud.zillaid, ud.upazilaid, "
//                + "ud.unionid, string_agg(ud.mouzaid::text||' '||ud.villageid::text, ',') as villageid, "
//                + "string_agg(ud.mouzaid::text, ',') as mouzaid, string_agg(v.villagenameeng::text, ', ') as villagename\n"
//                + "from unit_details ud\n"
//                + "JOIN zilla z on ud.zillaid = z.zillaid\n"
//                + "JOIN upazila upz on ud.zillaid = upz.zillaid and ud.upazilaid = upz.upazilaid\n"
//                + "JOIN reporting_union ru on ru.zillaid = ud.zillaid and ru.upazilaid = ud.upazilaid and ud.unionid = ru.reporting_unionid\n"
//                + "join fwaunit fau on ud.unit = fau.ucode\n"
//                + "LEFT JOIN village v on ud.zillaid = v.zillaid and ud.upazilaid = v.upazilaid and v.unionid = ANY(ru.unionids) and ud.mouzaid = v.mouzaid and ud.villageid = v.villageid\n"
//                + "group by z.zillanameeng, upz.upazilanameeng, ru.unionnameeng,ru.reporting_unionid, ud.unitid, ud.unit, fau.ucode, ud.zillaid, ud.upazilaid, ud.unionid, ud.unitid"
//                + " order by z.zillanameeng, upz.upazilanameeng, ru.unionnameeng;";
        String sql = "SELECT um.zillaid\n"
                + "	,z.zillanameeng\n"
                + "	,um.upazilaid\n"
                + "	,upz.upazilanameeng\n"
                + "	,um.reporting_unionid\n"
                + "	,ru.unionnameeng\n"
                + "	,um.unitid\n"
                + "	,um.unit\n"
                + "	,fau.uname fwaunitlabel\n"
                + "	,string_agg(DISTINCT ud.unionid::text || ' ' || ud.mouzaid::text || ' ' || ud.villageid::text, ',') as villageid\n"
                + "	,string_agg(DISTINCT ud.mouzaid::text, ',') as mouzaid\n"
                + "	,string_agg(DISTINCT v.villagename::text, ', ') as villagename\n"
                + "FROM unit_master um\n"
                + "LEFT JOIN unit_details ud using(unitid)\n"
                + "JOIN zilla z on um.zillaid = z.zillaid\n"
                + "JOIN upazila upz on um.zillaid = upz.zillaid and um.upazilaid = upz.upazilaid\n"
                + "LEFT JOIN reporting_union ru on ru.zillaid = um.zillaid and ru.upazilaid = um.upazilaid and ru.reporting_unionid = um.reporting_unionid\n"
                + "LEFT join fwaunit fau on um.unit = fau.ucode\n"
                + "LEFT JOIN village v on ud.zillaid = v.zillaid and ud.upazilaid = v.upazilaid and v.unionid = ud.unionid and ud.mouzaid = v.mouzaid and ud.villageid = v.villageid\n"
                + "WHERE um.zillaid = " + ru.getZillaid() + " and um.upazilaid = " + ru.getUpazilaid() + " and " + ru.getUnionid() + "= ANY(um.unionids::int[])\n"
                + "GROUP BY um.zillaid, z.zillanameeng,  um.upazilaid, upz.upazilanameeng, um.reporting_unionid, ru.unionnameeng, um.unitid, um.unit, fwaunitlabel;";
        System.out.println("getUnitDetails::" + sql);
        ResultSet resultSet = connection.createStatement().executeQuery(sql);
        return Convertor.toJSON(resultSet);
    }

    private int insertProviderAreaUnit(int zillaid, int upazilaid, int unitid, int fwaUnitLabel, int providerid, int assign_type) throws SQLException {
        String sql = "INSERT INTO public.providerarea_unit(\n"
                + "zillaid, upazilaid, unitid, unit, providerid, assign_type) values (" + zillaid + ","
                + upazilaid + "," + unitid + "," + fwaUnitLabel + "," + providerid + "," + assign_type + ")";
        this.print(sql);
        return db.update(sql);
    }

    private int deleteUnitDetails(int unitid) throws SQLException {
        String sql = "DELETE FROM public.unit_details WHERE unitid = " + unitid;
        Print.o(sql);
        return db.update(sql);
    }

    private int deleteUnitMaster(int unitid) throws SQLException {
        String sql = "DELETE FROM public.unit_master WHERE unitid = " + unitid;
        Print.o(sql);
        return db.update(sql);
    }

    public String setUnitDetails(ReportingUnit ru) throws SQLException, Exception {
        try {
            int zillaid = ru.getZillaid();
            int upazilaid = ru.getUpazilaid();
            int reporting_union_id = ru.getReporting_unionid();
            int unitid = this.generateUnitId(zillaid);
            int dbOperation = ru.getDboperationstatus();

            db.start();

            if (ru.getUnitid() != 0) {
                unitid = ru.getUnitid();
                this.deleteUnitDetails(unitid);
            }
            int fwaUnitLabelId = ru.getUnit();
            String[] villages = ru.getVillages();
            ResultSet unionidsResultSet = this.getUnionIds(zillaid, upazilaid, reporting_union_id);
            //boolean unitExists = this.checkUnitDetailsAssigned(zillaid, upazilaid, reporting_union_id, fwaUnitLabel);

            boolean unitExists = this.checkUnitAssigned(zillaid, upazilaid, reporting_union_id, fwaUnitLabelId);
            //checkUnitAssigned()
            if (!unionidsResultSet.next()) {
                throw new Exception("Union have not assigned. Please enter reporting union first.");
            }
            if (dbOperation == 0 && unitExists) {
                throw new Exception("Duplicate unit");
            }
            String unionids = unionidsResultSet.getString("unionids");
            if (dbOperation == 0) {
                this.insertUnitMaster(unitid, fwaUnitLabelId, zillaid, upazilaid, reporting_union_id, unionids, 0);
            }
            this.insertUnitDetails(unitid, fwaUnitLabelId, zillaid, upazilaid, reporting_union_id, villages);
            //insertUnitMaster()
            db.commit();
            connection.close();
//            System.out.println("HHH");
//            System.out.println(unitid);
//            System.out.println(unionidsResultSet.getString("unionids"));
            return "Successfully added";
        } catch (Exception e) {
            System.out.println("Insert UNIT DETAILS EXCEPTION: " + e.getMessage());
            return e.getMessage();
        }
    }

    public String insertFWAUnit(ReportingUnit ru) throws SQLException, Exception {
//        string 
        try {
            int zillaid = ru.getZillaid();
            int upazilaid = ru.getUpazilaid();
            int reporting_union_id = ru.getReporting_unionid();
            int providerid = ru.getProviderid();
            int unitid = this.generateUnitId(zillaid);
            int fwaUnitLabel = ru.getUnitid();
            int assign_type = ru.getAssign_type();
            String[] villages = ru.getVillages();
            ResultSet unionidsResultSet = this.getUnionIds(zillaid, upazilaid, reporting_union_id);
            boolean providerMainExist = this.checkProviderAssignType(providerid);
            boolean unitExists = this.checkUnitAssigned(zillaid, upazilaid, reporting_union_id, fwaUnitLabel);
            if (!unionidsResultSet.next()) {
                throw new Exception("Union have not assigned. Please enter reporting union first.");
            }
//            if (providerMainExist && assign_type == 1) {
//                throw new Exception("Assign type main already exist");
//            }
            if (unitExists) {
                throw new Exception("Unit already assigned");
            }
            String unionids = unionidsResultSet.getString("unionids");
            db.start();
            this.insertUnitMaster(unitid, fwaUnitLabel, zillaid, upazilaid, reporting_union_id, unionids, providerid);
            this.insertUnitDetails(unitid, fwaUnitLabel, zillaid, upazilaid, reporting_union_id, villages);
            //this.insertProviderAreaUnit(zillaid, upazilaid, unitid, fwaUnitLabel, providerid, assign_type);
            db.commit();
            connection.close();
//            System.out.println("HHH");
//            System.out.println(unitid);
//            System.out.println(unionidsResultSet.getString("unionids"));
            return "Successfully added";
        } catch (Exception e) {
            System.out.println("Insert REPORTINGUNIT EXCEPTION: " + e.getMessage());
            return e.getMessage();
        }
    }

    public JSONArray getFWAAssignment() throws SQLException, Exception {
        String sql = "select z.zillanameeng\n"
                + "	,upz.upazilanameeng\n"
                + "	,ru.unionnameeng\n"
                + "	,fwu.uname\n"
                + "	,pau.assign_type\n"
                + "	,pdb.provname\n"
                + "from unit_master um\n"
                + "JOIN zilla z on z.zillaid = um.zillaid\n"
                + "JOIN upazila upz on z.zillaid = upz.zillaid\n"
                + "	and um.upazilaid = upz.upazilaid\n"
                + "JOIN reporting_union ru on ru.zillaid = z.zillaid\n"
                + "	and ru.upazilaid = upz.upazilaid\n"
                + "	and um.reporting_unionid = ru.reporting_unionid\n"
                + "JOIN fwaunit fwu on um.unit = fwu.ucode\n"
                + "JOIN providerarea_unit pau on um.unitid = pau.unitid\n"
                + "JOIN providerdb pdb on pdb.providerid = um.providerid\n" //                + "where um.zillaid = 19 and um.upazilaid = 9 and um.reporting_unionid=11;"
                ;
        ResultSet resultSet = connection.createStatement().executeQuery(sql);
        return Convertor.toJSON(resultSet);
    }

//    UNIT ASSIGNMENT FROM PROVIDER MANAGEMENT
    public boolean checkUnitAssignedProviderAreaUnit(int zillaid, int upazilaid, int reporting_union_id, int unitid) throws SQLException {
        String sql = "select * from providerarea_unit where zillaid=" + zillaid + " and upazilaid=" + upazilaid
                + " and unitid =" + unitid;
        ResultSet rs = connection.createStatement().executeQuery(sql);
        System.out.println(sql);
        if (rs.next()) {
            return true;
        } else {
            return false;
        }
    }

    public JSONArray getReportingUnionByBbsUpazila(ReportingUnion ru) throws JSONException {
        try {
//            SELECT zillaid, upazilaid, municipalityid, reporting_unionid unionid, unionnameeng, unionname, is_actual
//FROM public.reporting_union where zillaid = 99 and upazilaid= 9 and  1 = ANY(unionids::int[]) order by unionnameeng;
            String sql = "SELECT zillaid, upazilaid, municipalityid, reporting_unionid unionid, unionnameeng, unionname, is_actual\n"
                    + "FROM public.reporting_union where zillaid = " + ru.getZillaid() + " and upazilaid= " + ru.getUpazilaid() + " order by unionnameeng";
//                    + " and " + ru.getUnionid() + "= ANY(unionids::int[])" + " order by unionnameeng";
            System.out.println("getReportingUnionByBbsUnion:  " + sql);
            ResultSet resultSet = connection.createStatement().executeQuery(sql);
            return Convertor.toJSON(resultSet);
        } catch (Exception e) {
            e.printStackTrace();
            JSONObject jo = new JSONObject();
            jo.put("message", e.getMessage());
            JSONArray ja = new JSONArray();
            ja.put(jo);
            return ja;
        }
    }

    public JSONArray getReportingUnionByBbsUnion(ReportingUnion ru) throws JSONException {
        try {
//            SELECT zillaid, upazilaid, municipalityid, reporting_unionid unionid, unionnameeng, unionname, is_actual
//FROM public.reporting_union where zillaid = 99 and upazilaid= 9 and  1 = ANY(unionids::int[]) order by unionnameeng;
            String sql = "SELECT zillaid, upazilaid, municipalityid, reporting_unionid unionid, unionnameeng, unionname, is_actual\n"
                    + "FROM public.reporting_union where zillaid = " + ru.getZillaid() + " and upazilaid= " + ru.getUpazilaid()
                    + " and " + ru.getUnionid() + "= ANY(unionids::int[])" + " order by unionnameeng";
            System.out.println("getReportingUnionByBbsUnion:  " + sql);
            ResultSet resultSet = connection.createStatement().executeQuery(sql);
            return Convertor.toJSON(resultSet);
        } catch (Exception e) {
            e.printStackTrace();
            JSONObject jo = new JSONObject();
            jo.put("message", e.getMessage());
            JSONArray ja = new JSONArray();
            ja.put(jo);
            return ja;
        }
    }

    public JSONArray getUnitByReportingUnion(ReportingUnion ru) throws JSONException {
        try {
            String sql = "select fu.uname, um.unitid as ucode from unit_master um \n"
                    + "join fwaunit fu on um.unit = fu.ucode where um.zillaid = " + ru.getZillaid() + " and um.upazilaid = " + ru.getUpazilaid() + " and um.reporting_unionid = " + ru.getReporting_unionid()
                    + " and not exists(\n"
                    + "	select 1 from providerarea_unit pau where pau.unitid = um.unitid\n"
                    + ");";
            System.out.println(sql);
            ResultSet resultSet = connection.createStatement().executeQuery(sql);
            return Convertor.toJSON(resultSet);
        } catch (Exception e) {
            e.printStackTrace();
            JSONObject jo = new JSONObject();
            jo.put("message", e.getMessage());
            JSONArray ja = new JSONArray();
            ja.put(jo);
            return ja;
        }
    }

    public int getUcodeUnitMaster(int zillaid, int upazilaid, int reporting_unionid, int unitid) throws JSONException {
        try {
            int ucode = 0;
            String sql = "select unit from unit_master where zillaid = " + zillaid + ""
                    + " and upazilaid = " + upazilaid + " and reporting_unionid=" + reporting_unionid + " and unitid = " + unitid;
            ResultSet resultSet = connection.createStatement().executeQuery(sql);
            while (resultSet.next()) {
                ucode = resultSet.getInt("unit");
            }
            System.out.println(sql);
            return ucode;
        } catch (Exception e) {
            return 0;
        }
    }

    public JSONArray getProviderAreaUnit(int providerid) throws Exception {
        try {
            String sql = "select ru.unionnameeng, fau.uname,pau.unitid, pau.assign_type from providerarea_unit pau\n"
                    + "join unit_master um on pau.unitid = um.unitid\n"
                    + "join reporting_union ru on ru.reporting_unionid = um.reporting_unionid\n"
                    + "join fwaunit fau on pau.unit = fau.ucode\n"
                    + "where pau.providerid =" + providerid + "\n"
                    + "order by pau.assign_type, ru.unionnameeng\n"
                    + ";";
            ResultSet resultSet = connection.createStatement().executeQuery(sql);
            this.print(sql);
            return Convertor.toJSON(resultSet);
        } catch (Exception e) {
            e.printStackTrace();
            JSONObject jo = new JSONObject();
            jo.put("message", e.getMessage());
            JSONArray ja = new JSONArray();
            ja.put(jo);
            return ja;
        }
    }

    public String insertProviderareaUnit(ReportingUnit ru) throws SQLException, Exception {
        try {
            int zillaid = ru.getZillaid();
            int upazilaid = ru.getUpazilaid();
            int unitid = ru.getUnitid();
            int providerid = ru.getProviderid();
            int assign_type = ru.getAssign_type();
            int reporting_unionid = ru.getReporting_unionid();
            int unit = this.getUcodeUnitMaster(zillaid, upazilaid, reporting_unionid, unitid);
            int wardNumber = ru.getWardnumber();
            boolean unitAssigned = this.checkUnitAssignedProviderAreaUnit(zillaid, upazilaid, providerid, unitid);
            boolean providerMainAssigned = this.checkProviderAssignType(providerid);
            String message = "";
            if (unitAssigned) {
                throw new Exception("This unit already assigned");
            }
            if (providerMainAssigned && assign_type == 1) {
                throw new Exception("This provider already has a main unit");
            }

            db.start();
            int statusPAU = insertProviderAreaUnit(zillaid, upazilaid, unitid, unit, providerid, assign_type);
            int statusPA = this.insertProviderarea(ru);
            if(assign_type == 1){
                // IMPLEMENT AFTER CONSULT WITH SHAMIM BHAI
//                int statusPDB = this.updateProviderDbGeo(zillaid, upazilaid, reporting_unionid, providerid);
//                System.out.println("statusPDB: "+ statusPDB);
            }
            
            if (statusPAU > 0 && statusPA > 0) {
                db.commit();
                new ProviderManagement(zillaid).setAreaUpdate(providerid, 1);
                message = "Successfully Added";
            } else {
                db.rollback();
                message = "Something went wrong";
            }
            connection.close();
            return message;
        } catch (Exception e) {
            this.print("insertProviderarea: EXCEPTION" + e.getMessage());
            return e.getMessage();
        }
    }
    
    private int updateProviderDbGeo(int zillaid, int upazilaid, int reporting_unionid, int providerid ){
        String sql = "update providerdb set zillaid ="+ zillaid + ", upazilaid="+ upazilaid
                + ", unionid = " + reporting_unionid + "where providerid = " + providerid;
        System.out.println(sql);
        return db.update(sql);
    }

    private int insertProviderarea(ReportingUnit ru) throws SQLException {
        String sql = "INSERT INTO providerarea (divid, zillaid, upazilaid, unionid, mouzaid, villageid, fwaunit, ward, provtype, providerid, assign_type, unitid, reporting_unionid)\n"
                + "select * from (\n"
                + "	SELECT distinct " + ru.getDivision() + " divid, ud.zillaid, ud.upazilaid, ud.unionid, ud.mouzaid, ud.villageid, um.unit, " + ru.getWardnumber() + " ward, 3 provtype, pa.providerid, pa.assign_type, ud.unitid, um.reporting_unionid \n"
                + "	FROM unit_master um\n"
                + "	JOIN public.unit_details ud using (unitid)\n"
                + "	LEFT JOIN providerarea_unit pa using (unitid)\n"
                + "	where ud.zillaid = " + ru.getZillaid() + " and um.unitid = " + ru.getUnitid() + "\n"
                + "	and pa.providerid in (" + ru.getProviderid() + ")\n"
                + ") p\n"
                + "where not exists ( \n"
                + "	select 1 from providerarea a where p.zillaid=a.zillaid and p.upazilaid=a.upazilaid and p.unionid=a.unionid and p.mouzaid=a.mouzaid \n"
                + "	and p.villageid=a.villageid and p.unit=a.fwaunit and p.providerid=a.providerid\n"
                + ")";

        this.print("insertProviderarea:" + sql);
        return db.update(sql);
    }

    public boolean checkDataUnderVillage(int zillaid, int upazilaid, int unionid, int mouzaid, int villageid) throws SQLException {
        boolean existData = false;
        String sql = "SELECT * FROM household where zillaid=" + zillaid + " and upazilaid=" + upazilaid + " and unionid=" + unionid + " and mouzaid=" + mouzaid + " and villageid=" + villageid;
        ResultSet resultSet = connection.createStatement().executeQuery(sql);
        print(sql);
        while (resultSet.next()) {
            existData = true;
        }
        return existData;
    }

    public boolean checkDataUnderUnit(ReportingUnit ru) throws SQLException {
        System.out.println(ru);
        boolean existData = false;
        String sql = "SELECT * FROM household where zillaid=" + ru.getZillaid() + " and upazilaid=" + ru.getUpazilaid() + " and unionid=" + ru.getUnionid() + " and mouzaid=" + ru.getMouzaid() + " and villageid=" + ru.getVillageid() + " and unit=" + ru.getUnit();
        sql = "SELECT * FROM household where unitid=" + ru.getUnitid();
        Print.o(sql);
        ResultSet resultSet = connection.createStatement().executeQuery(sql);
        //print(sql);
        while (resultSet.next()) {
            existData = true;
        }
        return existData;
    }

    //Add village to unit by update unit
    public List<String> getNewVillagesByUpdateUnitVillages(ReportingUnit ru) throws SQLException {
        List<String> newVillages = new ArrayList<String>();
        for (int i = 0; i < ru.getVillages().length; i++) {
            System.out.println(ru.getVillages()[i]);
            String[] mv = ru.getVillages()[i].split("\\s");
            String sql = "SELECT 1 FROM public.unit_details where unitid=" + ru.getUnitid() + " and unit=" + ru.getUnit() + " and zillaid=" + ru.getZillaid() + " and upazilaid=" + ru.getUpazilaid() + " and unionid=" + mv[0] + " and mouzaid=" + mv[1] + " and villageid=" + mv[2];
            Print.o(sql);
            ResultSet resultSet = connection.createStatement().executeQuery(sql);
            //print(sql);
            if (resultSet.next() == false) {
                newVillages.add(ru.getVillages()[i]);
            }
        }
        return newVillages;
    }

    public int addNewVillagesByUpdateUnitVillages(List<String> addVillages, ReportingUnit ru) throws SQLException {
        db.start();
        int count = 0;
        for (String village : addVillages) {
            String[] mv = village.split("\\s");
            String sql = "INSERT INTO public.unit_details(unitid, unit, zillaid, upazilaid, unionid, mouzaid, villageid)\n"
                    + "VALUES (" + ru.getUnitid() + "," + ru.getUnit() + "," + ru.getZillaid() + "," + ru.getUpazilaid() + "," + mv[0] + "," + mv[1] + "," + mv[2] + ");";
            count += db.update(sql);
        }
        db.commit();
        connection.close();
        this.print("Count: " + count);
        return count;
    }
    //END

    //Remove village from unit by update unit
    public List<String> getVillagesToRemove(ReportingUnit ru) throws SQLException {
        List<String> removeVillages = new ArrayList<String>();
        String sql = "SELECT * FROM public.unit_details where unitid=" + ru.getUnitid();
        Print.o(sql);
        ResultSet resultSet = connection.createStatement().executeQuery(sql);
        //print(sql);
        while (resultSet.next()) {
            String village = resultSet.getInt("unionid") + " " + resultSet.getInt("mouzaid") + " " + resultSet.getInt("villageid");
            boolean isExist = false;
            for (int i = 0; i < ru.getVillages().length; i++) {
                String mv = ru.getVillages()[i].split("\\s")[0] + " " + ru.getVillages()[i].split("\\s")[1] + " " + ru.getVillages()[i].split("\\s")[2];
                if (village.equals(mv)) {
                    isExist = true;
                }
            }
            if (!isExist) {
                removeVillages.add(village);
            }
        }
        return removeVillages;
    }

    public int removeVillagesByUpdateUnitVillages(List<String> removeVillages, ReportingUnit ru) throws SQLException {
        int count = 0;
        db.start();
        for (String village : removeVillages) {
            String[] mv = village.split("\\s");
            String checkHHDataSQL = "SELECT * FROM public.household where zillaid=" + ru.getZillaid() + " and upazilaid=" + ru.getUpazilaid() + " and unionid=" + mv[0] + " and mouzaid=" + mv[1] + " and villageid=" + mv[2] + " and unit=" + ru.getUnit();
            if (db.select(checkHHDataSQL).next() == false) {
                String sql = "DELETE FROM public.unit_details WHERE unitid=" + ru.getUnitid() + " and unit=" + ru.getUnit() + " and zillaid=" + ru.getZillaid() + " and upazilaid=" + ru.getUpazilaid() + " and unionid=" + mv[0] + " and mouzaid=" + mv[1] + " and villageid=" + mv[2];
                count += db.update(sql);
            }
        }
        db.commit();
        connection.close();
        this.print("Count: " + count);
        return count;
    }
    //END

    public boolean checkDataUnderUnion(ReportingUnion ru) throws SQLException {
        System.out.println(ru);
        boolean existData = false;
        String sql = "SELECT * FROM public.web_report_submission_dgfp where modrep=702 and zillaid=" + ru.getZillaid() + " and upazilaid=" + ru.getUpazilaid() + " and reporting_unionid=" + ru.getUnionid();
        Print.o(sql);
        ResultSet resultSet = connection.createStatement().executeQuery(sql);
        //print(sql);
        while (resultSet.next()) {
            existData = true;
        }
        return existData;
    }

    public boolean checkUnionAssignedProvider(ReportingUnion ru) throws SQLException {
        String sql = "Select *  FROM public.reporting_union_fpi where zillaid=" + ru.getZillaid() + " and upazilaid=" + ru.getUpazilaid() + " and reporting_unionid=" + ru.getUnionid();
        ResultSet rs = connection.createStatement().executeQuery(sql);
        System.out.println(sql);
        if (rs.next()) {
            return true;
        } else {
            return false;
        }
    }

    public String deleteUnit(int unitid) throws SQLException {
        db.start();
        int deleteUnitMaster = this.deleteUnitMaster(unitid);
        int deleteUnitDetails = this.deleteUnitDetails(unitid);
        if (deleteUnitMaster > 0 && deleteUnitDetails > 0) {
            db.commit();
            connection.close();
            return "Unit delete successfully";
        } else {
            db.rollback();
            connection.close();
            return "Something went wrong";
        }
    }

    public String updateUnit(ReportingUnit ru) throws SQLException {
        db.start();
        int deleteUnitDetails = this.deleteUnitDetails(ru.getUnitid());
        this.insertUnitDetails(ru.getUnitid(), ru.getUnit(), ru.getZillaid(), ru.getUpazilaid(), ru.getReporting_unionid(), ru.getVillages());
        db.commit();
        connection.close();
        return "Unit update successfully";
    }

    public boolean updateFWAAssignType(ProviderAreaUnit[] pau) throws SQLException {
        db.start();
        int updateCount = 0;
        for (ProviderAreaUnit obj : pau) {
            String sql = "update providerarea_unit set assign_type=" + obj.getAssign_type() + ", modifydate=now() where providerid=" + obj.getProviderid() + " and unitid=" + obj.getUnitid() + " and unit=" + obj.getUnit();
            //IMPLEMENT AFTER CONFIGRMATION FROM SHAMIM BHAI
//            if(obj.getAssign_type() == 1){
//                this.updateProviderDbGeo(obj.getZillaid(), obj.getUpazilaid(), obj.getReporting_unionid(), obj.getProviderid());
//            }
            updateCount += db.update(sql);
        }
        if (updateCount > 0) {
            db.commit();
            connection.close();
            return true;
        } else {
            db.rollback();
            connection.close();
            return false;
        }
    }

    public boolean updateFPIAssignType(ReportingUnionFPI[] ruf) throws SQLException {
        db.start();
        int updateCount = 0;
        for (ReportingUnionFPI obj : ruf) {
            String sql = "update reporting_union_fpi set assign_type=" + obj.getAssign_type() + ", modifydate=now() where providerid=" + obj.getProviderid() + " and zillaid=" + obj.getZillaid() + " and upazilaid=" + obj.getUpazilaid() + " and reporting_unionid=" + obj.getReporting_unionid();
            updateCount += db.update(sql);
        }
        if (updateCount > 0) {
            db.commit();
            connection.close();
            return true;
        } else {
            db.rollback();
            connection.close();
            return false;
        }
    }

    public boolean updateUFPOAssignType(ReportingUpazilaUFPO[] ruu) throws SQLException {
        db.start();
        int updateCount = 0;
        for (ReportingUpazilaUFPO obj : ruu) {
            String sql = "update reporting_upazila_ufpo set assign_type=" + obj.getAssign_type() + ", modifydate=now() where providerid=" + obj.getProviderid() + " and zillaid=" + obj.getZillaid() + " and upazilaid=" + obj.getUpazilaid();
            updateCount += db.update(sql);
        }
        if (updateCount > 0) {
            db.commit();
            connection.close();
            return true;
        } else {
            db.rollback();
            connection.close();
            return false;
        }
    }

    private void print(Object obj) {
        System.out.println(obj);
    }
}
