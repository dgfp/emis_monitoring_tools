package com.emis.management;

import com.emis.utility.Convertor;
import com.emis.beans.Response;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.rhis.db.DBManagerDistrict;
import com.rhis.db.DBManagerMonitoring;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.JSONArray;
import org.json.JSONObject;

/**
 *
 * @author Nil_27
 */
@WebServlet(name = "ProviderManagement_RHIS2DB", urlPatterns = {"/ProviderManagement_RHIS2DB"})
public class ProviderManagement_RHIS2DB extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

//            String sql="select * from number_of_record_in_server_tab_after_download_in_tab_compare where providerid =58064";
//            try {
//                
//                DBManagerDistrict db = new DBManagerDistrict(Integer.parseInt(districtId));
//                ResultSet rs = db.select(sql);
//                JSONArray json = Convertor.convertResultSetIntoJSONWithDash(rs);
//                System.out.println("Cheacker:   "+json.toString());
//
//            } catch (Exception ex) {
//                ex.getMessage();
//            }
        request.setAttribute("submenu", "ProviderManagement_RHIS2DB");
        request.setAttribute("menu", "MANAGEMENT");
        RequestDispatcher view = request.getRequestDispatcher("WEB-INF/jsp/management/provider_management_rhis2db.jsp");
        view.forward(request, response);

    }

    private String executeSelect(String query, String districtId) {

        DBManagerDistrict db = new DBManagerDistrict(Integer.parseInt(districtId));
        ResultSet result = db.select(query);
        JSONArray json = new JSONArray();
        try {
            json = Convertor.convertResultSetIntoJSON(result);
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        }
        return json.toString();
    }

    private String executeSelect(String query) {

        //DBManagerDistrict db = new DBManagerDistrict(Integer.parseInt(districtId));
        DBManagerMonitoring db = new DBManagerMonitoring();

        ResultSet result = db.select(query);
        JSONArray json = new JSONArray();
        try {
            json = Convertor.convertResultSetIntoJSON(result);
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        }
        return json.toString();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        String globalDistrictId = request.getParameter("districtId");

        //------------------------For Show Data --------------------------------------------------------------------------------------------
        if (action.equalsIgnoreCase("showdata")) {

            String districtId = request.getParameter("districtId");
            String upazilaId = request.getParameter("upazilaId");
            String unionId = request.getParameter("unionId");
            String providerType = request.getParameter("providerType");
            String condition = null;

            if (upazilaId.length() == 0 && unionId.length() == 0) {
                if (providerType.length() == 0) {
                    condition = "WHERE zillaid = " + districtId;
                } else {
                    condition = "WHERE zillaid = " + districtId + " AND providertype.provtype=" + providerType;
                }
            } else if (unionId.length() == 0) {
                if (providerType.length() == 0) {
                    condition = "WHERE zillaid=" + districtId + " AND  upazilaid=" + upazilaId;
                } else {
                    condition = "WHERE zillaid=" + districtId + " AND  upazilaid=" + upazilaId + " AND providertype.provtype=" + providerType;
                }

            } else if (providerType.length() == 0) {
                condition = "WHERE zillaid=" + districtId + " AND  upazilaid=" + upazilaId + " AND unionid=" + unionId;
            } else {
                condition = "WHERE zillaid=" + districtId + " AND  upazilaid=" + upazilaId + " AND unionid=" + unionId + " AND providertype.provtype=" + providerType;
            }

            String query = "select active, supervisorcode, mobileno, providerid, providerdb.areaupdate, providerdb.provtype, provname,divid, zillaid, upazilaid, unionid, providertype.typename, devicesetting, provpass \n"
                    + "from providerdb join providertype on providertype.provtype=providerdb.provtype "
                    + condition + " order by provname asc";

            String jsonString = executeSelect(query, districtId);
            response.setContentType("text/plain;charset=UTF-8");
            response.getWriter().write(jsonString);

            //------------------------End Show Data---------------------------------------------------------------------------------------------
            //------------------------For update Setting ----------------------------------------------------------------------------------------
        } else if (action.equalsIgnoreCase("showDataByProviderId")) {
            String districtId = request.getParameter("districtId");
            String upazilaId = request.getParameter("upazilaId");
            String unionId = request.getParameter("unionId");
            String providerId = request.getParameter("providerId");
            String condition = null;

            if (unionId.length() == 0) {
                condition = "WHERE zillaid=" + districtId + " AND  upazilaid=" + upazilaId + " AND providerid=" + providerId;
            } else {
                condition = "WHERE zillaid=" + districtId + " AND  upazilaid=" + upazilaId + " AND unionid=" + unionId + " AND providerid=" + providerId;
            }

            String query = "select supervisorcode, mobileno, providerid, providerdb.areaupdate, provname, providertype.provtype, providertype.typename, devicesetting, provpass \n"
                    + "from providerdb join providertype on providertype.provtype=providerdb.provtype "
                    + condition + " order by provname asc";

            String jsonString = executeSelect(query, districtId);
            response.setContentType("text/plain;charset=UTF-8");
            response.getWriter().write(jsonString);

        } else if (action.equalsIgnoreCase("updateSettings")) {

            String providerId = request.getParameter("providerId");
            String settingId = request.getParameter("settingId");
            String columnType = request.getParameter("columnType");

            String updatedColumn = columnType.equals("1") ? "devicesetting" : "areaupdate";
            String updatedSetting = settingId.equals("1") ? "2" : "1";
            String query = "update providerdb set " + updatedColumn + " = " + updatedSetting + ",modifydate=now()  where providerid = " + providerId;
            DBManagerDistrict db = new DBManagerDistrict(Integer.parseInt(globalDistrictId));
            int rowCount = db.update(query);
            response.setContentType("text/plain;charset=UTF-8");
            response.getWriter().write(rowCount + "");
            //------------------------End update Setting ---------------------------------------------------------------------------------------

            //------------------------For Get Units ----------------------------------------------------------------------------------------------
        } else if (action.equalsIgnoreCase("getProviderarea")) {

            String zillaid = request.getParameter("zillaid");
            String upazilaid = request.getParameter("upazilaid");
            String unionid = request.getParameter("unionid");
            String mouzaid = request.getParameter("mouzaid");
            String villageid = request.getParameter("villageid");
            String providerid = request.getParameter("providerid");
            String provtype = request.getParameter("provtype");
            DBManagerMonitoring db = new DBManagerDistrict(Integer.parseInt(zillaid));

            String query = "select oid, fwaunit,ward from providerarea where (zillaid,upazilaid,unionid,mouzaid,villageid,providerid,provtype) in (select %s,%s,%s,%s,%s,%s,%s);";
            query = String.format(query, zillaid, upazilaid, unionid, mouzaid, villageid, providerid, provtype);
            ResultSet result = db.select(query);
            try {
                JSONArray json = Convertor.toJSON(result);
                response.setContentType("text/plain;charset=UTF-8");
                response.getWriter().write(json.toString());
            } catch (Exception ex) {
                Logger.getLogger(ProviderManagement_RHIS2DB.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else if (action.equalsIgnoreCase("setProviderarea")) {

            String zillaid = request.getParameter("zillaid");
            String upazilaid = request.getParameter("upazilaid");
            String unionid = request.getParameter("unionid");
            String mouzaid = request.getParameter("mouzaid");
            String villageid = request.getParameter("villageid");
            String providerid = request.getParameter("providerid");
            String provtype = request.getParameter("provtype");
            String fwaunit = request.getParameter("fwaunit");
            String ward = request.getParameter("ward");
            String oid = request.getParameter("oid");
            DBManagerMonitoring db = new DBManagerDistrict(Integer.parseInt(zillaid));

            if (fwaunit.isEmpty()) {
                fwaunit = null;
            }
            if (ward.isEmpty()) {
                ward = null;
            }

            String message;
            String query;
            Response R = new Response();
            if (oid.isEmpty()) {
                query = "INSERT INTO providerarea "
                        + " (zillaid,upazilaid,unionid,mouzaid,villageid,providerid,provtype,fwaunit,ward) "
                        + " values(%s,%s,%s,%s,%s,%s,%s,%s,%s) "
                        + " ;";
                query = String.format(query, zillaid, upazilaid, unionid, mouzaid, villageid, providerid, provtype, fwaunit, ward);
                message = "Area inserted successfully";
            } else {
                query = "UPDATE providerarea SET fwaunit=%s,ward=%s "
                        + " WHERE oid=%s "
                        + " ;";
                query = String.format(query, fwaunit, ward, oid);
                message = "Area updated successfully";
            }

            int result = db.update(query);
            message = result > 0 ? message : "Possibly duplicate area";
            R.setMessage(message);
            ObjectMapper mapper = new ObjectMapper();
            mapper.writeValue(response.getOutputStream(), R);

        } else if (action.equalsIgnoreCase("delProviderarea")) {

            String zillaid = request.getParameter("zillaid");
            String upazilaid = request.getParameter("upazilaid");
            String unionid = request.getParameter("unionid");
            String mouzaid = request.getParameter("mouzaid");
            String villageid = request.getParameter("villageid");
            String providerid = request.getParameter("providerid");
            String provtype = request.getParameter("provtype");
            String oid = request.getParameter("oid");
            DBManagerMonitoring db = new DBManagerDistrict(Integer.parseInt(zillaid));

            String query = "delete from providerarea where (zillaid,upazilaid,unionid,mouzaid,villageid,providerid,provtype,oid) in (select %s,%s,%s,%s,%s,%s,%s,%s);";
            query = String.format(query, zillaid, upazilaid, unionid, mouzaid, villageid, providerid, provtype, oid);
            int result = db.update(query);
            Response R = new Response();
            String message = result > 0 ? "Deleted successfully" : "Error occured";
            R.setMessage(message);
            ObjectMapper mapper = new ObjectMapper();
            mapper.writeValue(response.getOutputStream(), R);

        } else if (action.equalsIgnoreCase("getUnits")) {
            DBManagerMonitoring db = new DBManagerMonitoring();
            String query = "select * from fwaunit order by uname asc";
            ResultSet result = db.select(query);
            try {
                JSONArray json = Convertor.convertResultSetIntoJSON(result);
                //String jsonString = executeSelect(query);
                response.setContentType("text/plain;charset=UTF-8");
                response.getWriter().write(json.toString());
            } catch (Exception ex) {
                Logger.getLogger(ProviderManagement_RHIS2DB.class.getName()).log(Level.SEVERE, null, ex);
            }
            //------------------------End Get Units ----------------------------------------------------------------------------------------------

            //------------------------For Get Mouza --------------------------------------------------------------------------------------------
        } else if (action.equalsIgnoreCase("getMouzaData")) {

            System.out.println("++++++++++++++++++++++++++++" + Integer.parseInt(request.getParameter("providerId")));

            String districtId = request.getParameter("districtId");
            String upazilaId = request.getParameter("upazilaId");
            String unionId = request.getParameter("unionId");
            int providerId = Integer.parseInt(request.getParameter("providerId"));
            int provType = Integer.parseInt(request.getParameter("provType"));

            System.out.println("````````````````````````````````" + districtId + "````````````" + provType + "``````````````" + providerId);

            String sql = "select mouza.unionid, mouza.mouzaid, v.villageid,  mouza.mouzanameeng, mouza.mouzaname, v.villagenameeng, v.villagename , a.provtype,a.providerid,v.fwaunit from mouza \n"
                    + "inner join village v on mouza.zillaid = v.zillaid and mouza.upazilaid = v.upazilaid and mouza.unionid = v.unionid and mouza.mouzaid = v.mouzaid \n"
                    + "left outer join providerarea a on v.zillaid = a.zillaid and v.upazilaid = a.upazilaid and v.unionid = a.unionid and v.mouzaid =a.mouzaid and v.villageid = a.villageid and \n"
                    + "a.providerid= " + providerId + " and a.provtype = " + provType + " \n"
                    + "where mouza.zillaid =  " + districtId + "  and mouza.upazilaid = " + upazilaId + " and mouza.unionid = " + unionId + "\n"
                    + "order by unionid, mouzaid, villageid;";

            String jsonString = executeSelect(sql, districtId);
            response.setContentType("text/plain;charset=UTF-8");
            // [{"unionid":13,"mouzanameeng":"AJGANA","providerid":62461,"provtype":2,"villagenameeng":"AJGANA","villageid":1,"fwaunit":"null","mouzaid":33},{"unionid":13,"mouzanameeng":"BELTAIL","providerid":"null","provtype":"null","villagenameeng":"BELTAIL","villageid":1,"fwaunit":"null","mouzaid":197},{"unionid":13,"mouzanameeng":"BHULUA","providerid":"null","provtype":"null","villagenameeng":"BHULUA","villageid":1,"fwaunit":"null","mouzaid":235},{"unionid":13,"mouzanameeng":"CHANDPUR","providerid":"null","provtype":"null","villagenameeng":"CHANDPUR","villageid":1,"fwaunit":"null","mouzaid":273},{"unionid":13,"mouzanameeng":"CHITESHWARI","providerid":"null","provtype":"null","villagenameeng":"CHITESHWARI","villageid":1,"fwaunit":"null","mouzaid":293},{"unionid":13,"mouzanameeng":"GARAIL","providerid":"null","provtype":"null","villagenameeng":"BANDAR MARA","villageid":1,"fwaunit":"null","mouzaid":427},{"unionid":13,"mouzanameeng":"GARAIL","providerid":"null","provtype":"null","villagenameeng":"TRIMOHAN","villageid":2,"fwaunit":"null","mouzaid":427},{"unionid":13,"mouzanameeng":"GHAGRAI","providerid":"null","provtype":"null","villagenameeng":"GHAGRAI","villageid":1,"fwaunit":"null","mouzaid":442},{"unionid":13,"mouzanameeng":"GORAKHI (GARAKI)","providerid":"null","provtype":"null","villagenameeng":"GORAKHI (GARAKI)","villageid":1,"fwaunit":"null","mouzaid":466},{"unionid":13,"mouzanameeng":"GORAKHI (GARAKI)","providerid":"null","provtype":"null","villagenameeng":"GARAKI","villageid":2,"fwaunit":"null","mouzaid":466},{"unionid":13,"mouzanameeng":"JOGIR KOFA","providerid":"null","provtype":"null","villagenameeng":"JOGIR KOFA","villageid":1,"fwaunit":"null","mouzaid":547},{"unionid":13,"mouzanameeng":"KURATALI","providerid":"null","provtype":"null","villagenameeng":"KURATALI","villageid":1,"fwaunit":"null","mouzaid":648},{"unionid":13,"mouzanameeng":"KURI PARA (KURATALI)","providerid":62461,"provtype":2,"villagenameeng":"KURI PARA (KURATALI)","villageid":1,"fwaunit":"null","mouzaid":653},{"unionid":13,"mouzanameeng":"LATIFPUR","providerid":"null","provtype":"null","villagenameeng":"LATIFPUR","villageid":1,"fwaunit":"null","mouzaid":668},{"unionid":13,"mouzanameeng":"MAJIDPUR","providerid":62461,"provtype":2,"villagenameeng":"MAJIDPUR","villageid":1,"fwaunit":"null","mouzaid":721},{"unionid":13,"mouzanameeng":"MAJIDPUR","providerid":"null","provtype":"null","villagenameeng":"JIBON GONG","villageid":4,"fwaunit":"","mouzaid":721},{"unionid":13,"mouzanameeng":"PALASHTALI","providerid":"null","provtype":"null","villagenameeng":"PALASHTALI","villageid":1,"fwaunit":"null","mouzaid":793},{"unionid":13,"mouzanameeng":"SALIMNAGAR","providerid":"null","provtype":"null","villagenameeng":"SALIMNAGAR","villageid":1,"fwaunit":"null","mouzaid":874},{"unionid":13,"mouzanameeng":"TELINA","providerid":62461,"provtype":2,"villagenameeng":"TELINA","villageid":1,"fwaunit":"null","mouzaid":961}]
            //String jsonStrin2 = "[{\"unionid\":13,\"mouzanameeng\":\"AJGANA\",\"providerid\":62461,\"provtype\":2,\"villagenameeng\":\"AJGANA\",\"villageid\":1,\"fwaunit\":\"null\",\"mouzaid\":33},{\"unionid\":13,\"mouzanameeng\":\"BELTAIL\",\"providerid\":\"null\",\"provtype\":\"null\",\"villagenameeng\":\"BELTAIL\",\"villageid\":1,\"fwaunit\":\"null\",\"mouzaid\":197},{\"unionid\":13,\"mouzanameeng\":\"BHULUA\",\"providerid\":\"null\",\"provtype\":\"null\",\"villagenameeng\":\"BHULUA\",\"villageid\":1,\"fwaunit\":\"null\",\"mouzaid\":235},{\"unionid\":13,\"mouzanameeng\":\"CHANDPUR\",\"providerid\":\"null\",\"provtype\":\"null\",\"villagenameeng\":\"CHANDPUR\",\"villageid\":1,\"fwaunit\":\"null\",\"mouzaid\":273},{\"unionid\":13,\"mouzanameeng\":\"CHITESHWARI\",\"providerid\":\"null\",\"provtype\":\"null\",\"villagenameeng\":\"CHITESHWARI\",\"villageid\":1,\"fwaunit\":\"null\",\"mouzaid\":293},{\"unionid\":13,\"mouzanameeng\":\"GARAIL\",\"providerid\":\"null\",\"provtype\":\"null\",\"villagenameeng\":\"BANDAR MARA\",\"villageid\":1,\"fwaunit\":\"null\",\"mouzaid\":427},{\"unionid\":13,\"mouzanameeng\":\"GARAIL\",\"providerid\":\"null\",\"provtype\":\"null\",\"villagenameeng\":\"TRIMOHAN\",\"villageid\":2,\"fwaunit\":\"null\",\"mouzaid\":427},{\"unionid\":13,\"mouzanameeng\":\"GHAGRAI\",\"providerid\":\"null\",\"provtype\":\"null\",\"villagenameeng\":\"GHAGRAI\",\"villageid\":1,\"fwaunit\":\"null\",\"mouzaid\":442},{\"unionid\":13,\"mouzanameeng\":\"GORAKHI (GARAKI)\",\"providerid\":\"null\",\"provtype\":\"null\",\"villagenameeng\":\"GORAKHI (GARAKI)\",\"villageid\":1,\"fwaunit\":\"null\",\"mouzaid\":466},{\"unionid\":13,\"mouzanameeng\":\"GORAKHI (GARAKI)\",\"providerid\":\"null\",\"provtype\":\"null\",\"villagenameeng\":\"GARAKI\",\"villageid\":2,\"fwaunit\":\"null\",\"mouzaid\":466},{\"unionid\":13,\"mouzanameeng\":\"JOGIR KOFA\",\"providerid\":\"null\",\"provtype\":\"null\",\"villagenameeng\":\"JOGIR KOFA\",\"villageid\":1,\"fwaunit\":\"null\",\"mouzaid\":547},{\"unionid\":13,\"mouzanameeng\":\"KURATALI\",\"providerid\":\"null\",\"provtype\":\"null\",\"villagenameeng\":\"KURATALI\",\"villageid\":1,\"fwaunit\":\"null\",\"mouzaid\":648},{\"unionid\":13,\"mouzanameeng\":\"KURI PARA (KURATALI)\",\"providerid\":62461,\"provtype\":2,\"villagenameeng\":\"KURI PARA (KURATALI)\",\"villageid\":1,\"fwaunit\":\"null\",\"mouzaid\":653},{\"unionid\":13,\"mouzanameeng\":\"LATIFPUR\",\"providerid\":\"null\",\"provtype\":\"null\",\"villagenameeng\":\"LATIFPUR\",\"villageid\":1,\"fwaunit\":\"null\",\"mouzaid\":668},{\"unionid\":13,\"mouzanameeng\":\"MAJIDPUR\",\"providerid\":62461,\"provtype\":2,\"villagenameeng\":\"MAJIDPUR\",\"villageid\":1,\"fwaunit\":\"null\",\"mouzaid\":721},{\"unionid\":13,\"mouzanameeng\":\"MAJIDPUR\",\"providerid\":\"null\",\"provtype\":\"null\",\"villagenameeng\":\"JIBON GONG\",\"villageid\":4,\"fwaunit\":\"\",\"mouzaid\":721},{\"unionid\":13,\"mouzanameeng\":\"PALASHTALI\",\"providerid\":\"null\",\"provtype\":\"null\",\"villagenameeng\":\"PALASHTALI\",\"villageid\":1,\"fwaunit\":\"null\",\"mouzaid\":793},{\"unionid\":13,\"mouzanameeng\":\"SALIMNAGAR\",\"providerid\":\"null\",\"provtype\":\"null\",\"villagenameeng\":\"SALIMNAGAR\",\"villageid\":1,\"fwaunit\":\"null\",\"mouzaid\":874},{\"unionid\":13,\"mouzanameeng\":\"TELINA\",\"providerid\":62461,\"provtype\":2,\"villagenameeng\":\"TELINA\",\"villageid\":1,\"fwaunit\":\"null\",\"mouzaid\":961}]";
            response.getWriter().write(jsonString);
            //------------------------End Get Mouza --------------------------------------------------------------------------------------------

            //------------------------For Setting Unit Word ------------------------------------------------------------------------------------
        } else if (action.equalsIgnoreCase("getDataForSettingUnitWard")) {

            String districtId = request.getParameter("districtId");
            String upazilaId = request.getParameter("upazilaId");
            String unionId = request.getParameter("unionId");

            String query = "select pa.unionid, pa.mouzaid,  pa.villageid, mouza.mouzanameeng,village.villagenameeng,pa.fwaunit, pa.ward, pa.wardnew, pa.block, pa.areacode, pa.provtype, pa.providerid, pdb.provname, pa.starthhno\n"
                    + "from  public.providerarea pa  --where pa.providerid=68975 \n"
                    + "left join mouza\n"
                    + "on (mouza.zillaid = pa.zillaid and mouza.upazilaid = pa.upazilaid and mouza.unionid = pa.unionid and mouza.mouzaid = pa.mouzaid) \n"
                    + "left join village \n"
                    + "on pa.zillaid = village.zillaid and pa.upazilaid = village.upazilaid and pa.unionid = village.unionid and pa.mouzaid = village.mouzaid and pa.villageid = village.villageid \n"
                    + "join providerdb pdb \n"
                    + "on pdb.providerid = pa.providerid \n"
                    + "where mouza.zillaid = " + districtId + "and \n"
                    + "mouza.upazilaid = " + upazilaId + ") and \n"
                    + "mouza.unionid = " + unionId + " \n"
                    + "order by pa.provtype, pa.providerid, pdb.provname";

            String jsonString = executeSelect(query, districtId);
            response.setContentType("text/plain;charset=UTF-8");
            response.getWriter().write(jsonString);
            //------------------------End Setting Unit Word ------------------------------------------------------------------------------------

            //------------------------For Setting Unit Word by Provider----------------------------------------------------------------------
        } else if (action.equalsIgnoreCase("getDataForSettingUnitWardByProvider")) {
            try {
                String districtId = request.getParameter("districtId");
                String upazilaId = request.getParameter("upazilaId");
                String unionId = request.getParameter("unionId");
                String providerId = request.getParameter("providerId");

                String query = "select distinct pa.unionid, pa.mouzaid, pa.villageid, unions.unionnameeng, mouza.mouzanameeng, mouza.mouzaname, village.villagenameeng, village.villagename, pa.fwaunit, pa.ward, pa.wardnew, pa.block, pa.areacode, pa.provtype, pa.providerid, pdb.provname, pa.starthhno \n"
                        + "from public.providerarea pa  --where pa.providerid=68975 \n"
                        + "left join unions on \n"
                        + "unions.zillaid = pa.zillaid and unions.upazilaid = pa.upazilaid and unions.unionid = pa.unionid \n"
                        + "left join mouza \n"
                        + "on (mouza.zillaid = pa.zillaid and mouza.upazilaid = pa.upazilaid and mouza.unionid = pa.unionid and mouza.mouzaid = pa.mouzaid) \n"
                        + "left join  village \n"
                        + "on pa.zillaid = village.zillaid and pa.upazilaid = village.upazilaid and pa.unionid = village.unionid and pa.mouzaid = village.mouzaid and pa.villageid = village.villageid \n"
                        + "join providerdb pdb\n"
                        + "on pdb.providerid = pa.providerid \n"
                        + "where pa.providerid = " + providerId + " and \n"
                        + "mouza.zillaid = " + districtId + " and \n"
                        + "mouza.upazilaid = " + upazilaId + " \n"
                        + "order by pa.provtype, pa.providerid, pdb.provname";

                String jsonString = executeSelect(query, districtId);
                JSONArray unit = Convertor.convertResultSetIntoJSON(new DBManagerMonitoring().select("select * from fwaunit order by ucode asc"));
                response.setContentType("text/plain;charset=UTF-8");
                response.getWriter().write("{\"area\":" + jsonString.toString() + ",\"unit\":" + unit.toString() + "}");
            } catch (Exception ex) {
                Logger.getLogger(ProviderManagement_RHIS2DB.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else if (action.equalsIgnoreCase("getDataForSetRound")) {

            String districtId = request.getParameter("districtId");
            String upazilaId = request.getParameter("upazilaId");
            String unionId = request.getParameter("unionId");

            String query = "select distinct  pa.zillaid, pa.upazilaid, pa.unionid,pa.provtype, pdb.provname, pa.providerid, pa.fwaunit, pa.fwa_round \n"
                    + "from public.providerarea pa \n"
                    + "join providerdb pdb \n"
                    + "on pdb.providerid = pa.providerid \n"
                    + "where pa.provtype=3 and \n"
                    + "pa.zillaid =" + districtId + " and pa.upazilaid =" + upazilaId + " and pa.unionid = " + unionId + " \n"
                    + "order by pa.zillaid, pa.upazilaid, pa.unionid, pa.provtype, pa.providerid, pa.fwaunit";

            String jsonString = executeSelect(query, districtId);
            response.setContentType("text/plain;charset=UTF-8");
            response.getWriter().write(jsonString);
            //------------------------End Get Round --------------------------------------------------------------------------------------------

            //------------------------Add area to provider -------------------------------------------------------------------------------------
        } else if (action.equalsIgnoreCase("addAreaToProvider")) {
            int divisonId = Integer.parseInt(request.getParameter("divisonId"));
            int districtId = Integer.parseInt(request.getParameter("districtId"));
            int upazilaId = Integer.parseInt(request.getParameter("upazilaId"));
            int unionId = Integer.parseInt(request.getParameter("unionId"));
            int mouzaId = Integer.parseInt(request.getParameter("mouzaId"));
            int villageId = Integer.parseInt(request.getParameter("villageId"));
            int providerId = Integer.parseInt(request.getParameter("providerId"));
            int provType = Integer.parseInt(request.getParameter("typeId"));
            int rowCount = 0;

            try {

                String query = "select count(*) as exists from providerarea \n"
                        + "where zillaid = " + districtId + "and upazilaid = " + upazilaId + " and unionid =" + unionId + " \n"
                        + "and mouzaid =  " + mouzaId + " and villageid =  " + villageId + " \n"
                        + "and provtype = " + provType + " and providerid =  " + providerId;

                System.out.println(query);
                DBManagerDistrict db = new DBManagerDistrict(districtId);
                ResultSet rs = db.select(query);
                int count = 0;

                while (rs.next()) {
                    count = rs.getInt("exists");
                }

                if (count > 0) {
                    query = "update providerarea \n"
                            + "set provtype =" + provType + ", providerid = " + providerId + ",modifydate=now() \n"
                            + "where zillaid = " + districtId + "and upazilaid = " + upazilaId + " and unionid =" + unionId + " \n"
                            + "and mouzaid =  " + mouzaId + " and villageid =  " + villageId + " \n"
                            + "and provtype = " + provType + " and providerid =  " + providerId;

                } else {
                    String starthno = null;
                    query = "insert into providerarea(divid, zillaid, upazilaid, unionid, mouzaid, villageid, provtype, providerid, starthhno) \n"
                            + "values (" + divisonId + ", " + districtId + ", " + upazilaId + ", " + unionId + ", " + mouzaId + ", " + villageId + "," + provType + ", " + providerId + ", " + starthno + ")";
                    System.out.println(query);
                }
                db = new DBManagerDistrict(districtId);
                rowCount = db.update(query);
                response.setContentType("text/plain;charset=UTF-8");
                response.getWriter().write(rowCount + "");

                /*//Previous
                    //String starthno = db.ReturnSingleValue("select cast(coalesce(max(cast(\"StartHHno\" as int)),5001)+5000 as text) \"StartHHno\" from \"ProviderArea\" where zillaid=" + districtId + " and upazilaid=" + upazilaId + " and unionid=" + unionId + " and mouzaid=" + mouzaId + " and villageid=" + villageId + "");
                    
                    //Updated by Helal 2017-07-05
                    String starthno=null;
                    if(typeId==3){
                        System.out.println("FWA going");
                        System.out.println("Previous Selected S NO: "+starthno);
                        
                        starthno = db.ReturnSingleValue("select cast(coalesce(max(cast(\"StartHHno\" as int)),1)+10000 as text) \"StartHHno\" from \"ProviderArea\" where zillaid=" + districtId + " and upazilaid=" + upazilaId + " and unionid=" + unionId + " and mouzaid=" + mouzaId + " and villageid=" + villageId + " and \"provType\"=" + typeId + "");    
                        
                        System.out.println("After Selected S NO: "+starthno);
                        
                        
                        if ( Integer.parseInt(starthno) >=50001 ) {
                            System.out.println("FWA exceed");
                            isAllRight=false;
                            rowCount=2;
                        }
                        
                    }else if(typeId==2){
                        System.out.println("HA going");
                        isAllRight=true;
                        System.out.println("Previous Selected S NO: "+starthno);
                        starthno = db.ReturnSingleValue("select cast(coalesce(max(cast(\"StartHHno\" as int)),40001)+10000 as text) \"StartHHno\" from \"ProviderArea\" where zillaid=" + districtId + " and upazilaid=" + upazilaId + " and unionid=" + unionId + " and mouzaid=" + mouzaId + " and villageid=" + villageId + " and \"provType\"=" + typeId + "");    
                        System.out.println("After Selected S NO: "+starthno);
                        if ( Integer.parseInt(starthno) >=100001 ) {
                            System.out.println("HA exceed");
                            isAllRight=false;
                            rowCount=3;
                        }
                                                
                    }else{
                        
                        System.out.println("Other going");
                        isAllRight=true;
                        starthno = db.ReturnSingleValue("select cast(coalesce(max(cast(\"StartHHno\" as int)),5001)+5000 as text) \"StartHHno\" from \"ProviderArea\" where zillaid=" + districtId + " and upazilaid=" + upazilaId + " and unionid=" + unionId + " and mouzaid=" + mouzaId + " and villageid=" + villageId + " and \"provType\" NOT IN (2,3)");
                    }
                    //End update
                    
                    query = "INSERT INTO \"ProviderArea\"("
                            + "zillaid, upazilaid, unionid, mouzaid, villageid,"
                            + "\"provType\", \"provCode\", \"StartHHno\")"
                            + " VALUES (" + districtId + ", " + upazilaId + ", " + unionId + ", " + mouzaId + ", " + villageId + ","
                            + typeId + ", " + providerId + ", " + starthno + ")";*/
                // }
                /*if(isAllRight){
                    db = new DBManagerDistrict(districtId);
                    rowCount = db.update(query);
                    response.setContentType("text/plain;charset=UTF-8");
                    response.getWriter().write(rowCount + "");
                }else{
                    response.setContentType("text/plain;charset=UTF-8");
                    response.getWriter().write(rowCount + "");
                }*/
            } catch (SQLException ex) {
                System.out.println(ex.getMessage());
            }
            //------------------------End area to provider --------------------------------------------------------------------------------------

            //------------------------Remove area to provider --------------------------------------------------------------------------------
        } else if (action.equalsIgnoreCase("removeAreaFromProvider")) {

            System.out.println("GO:~~~~~~~~~~~~~~~~~~~~");

            int districtId = Integer.parseInt(request.getParameter("districtId"));
            int upazilaId = Integer.parseInt(request.getParameter("upazilaId"));
            int unionId = Integer.parseInt(request.getParameter("unionId"));
            int mouzaId = Integer.parseInt(request.getParameter("mouzaId"));
            int villageId = Integer.parseInt(request.getParameter("villageId"));
            int providerId = Integer.parseInt(request.getParameter("providerId"));
            int provType = Integer.parseInt(request.getParameter("typeId"));

            String query = "delete from providerarea \n"
                    + "where zillaid = " + districtId + " and upazilaid = " + upazilaId + " and unionid =" + unionId + " \n"
                    + "and mouzaid =  " + mouzaId + " and villageid =  " + villageId + " \n"
                    + "and provtype = " + provType + " and providerid =  " + providerId;

            System.out.println("SQL: " + query);

            DBManagerDistrict db = new DBManagerDistrict(districtId);
            int rowCount = db.update(query);
            response.setContentType("text/plain;charset=UTF-8");
            response.getWriter().write(rowCount + "");
            //------------------------End remove area to provider ---------------------------------------------------------------------------

        } else if (action.equalsIgnoreCase("assignUnitWard")) {

            int divisonId = Integer.parseInt(request.getParameter("divisonId"));
            int districtId = Integer.parseInt(request.getParameter("districtId"));
            int upazilaId = Integer.parseInt(request.getParameter("upazilaId"));
            int unionId = Integer.parseInt(request.getParameter("unionId"));
            int mouzaId = Integer.parseInt(request.getParameter("mouzaId"));
            int villageId = Integer.parseInt(request.getParameter("villageId"));
            int providerId = Integer.parseInt(request.getParameter("providerId"));
            int provType = Integer.parseInt(request.getParameter("typeId"));
            String fwaUnit = request.getParameter("fwaUnit");
            String ward = request.getParameter("ward");

            try {

                String query = "select count(*) as exists from providerarea \n"
                        + "where divid = " + divisonId + " \n"
                        + "and zillaid = " + districtId + "and upazilaid = " + upazilaId + " and unionid =" + unionId + " \n"
                        + "and mouzaid =  " + mouzaId + " and villageid =  " + villageId + " \n"
                        + "and provtype = " + provType + " and providerid =  " + providerId + " \n"
                        + "and fwaunit = " + fwaUnit + " and ward =  " + ward + " \n";

                DBManagerDistrict db = new DBManagerDistrict(districtId);
                ResultSet rs = db.select(query);

                int count = 0;
                while (rs.next()) {
                    count = rs.getInt("exists");
                }

                if (count > 0) {

                    query = "UPDATE  providerarea \n"
                            + "SET divid = " + divisonId + ",modifydate=now() \n"
                            + ", zillaid = " + districtId + ", upazilaid = " + upazilaId + " , unionid =" + unionId + " \n"
                            + ", mouzaid =  " + mouzaId + " , villageid =  " + villageId + " \n"
                            + ", provtype = " + provType + " , providerid =  " + providerId + " \n"
                            + ", fwaunit = " + fwaUnit + " , ward =  " + ward + " \n"
                            + "where divid = " + divisonId + " \n"
                            + "and zillaid = " + districtId + "and upazilaid = " + upazilaId + " and unionid =" + unionId + " \n"
                            + "and mouzaid =  " + mouzaId + " and villageid =  " + villageId + " \n"
                            + "and provtype = " + provType + " and providerid =  " + providerId + " \n"
                            + "and fwaunit = " + fwaUnit + " \n";
                } else {

                    query = "insert into providerarea (divid, zillaid, upazilaid, unionid, mouzaid, villageid, provtype, providerid, fwaunit, ward) \n"
                            + "values (" + divisonId + ", " + districtId + ", " + upazilaId + ", " + unionId + ", " + mouzaId + ", " + villageId + "," + provType + ", " + providerId + ", " + fwaUnit + ", " + ward + ")";
                }

                int rowCount = 0;
                response.setContentType("text/plain;charset=UTF-8");
                response.getWriter().write(rowCount + "");

            } catch (SQLException ex) {
                System.out.println(ex.getMessage());
            }
        } else if (action.equalsIgnoreCase("updateUnit")) {
            String unitId = request.getParameter("unitId");

            if (unitId.equals("") || unitId == null) {
                unitId = null;

            } else {
                unitId = "'" + unitId + "'";
            }

            int districtId = Integer.parseInt(request.getParameter("districtId"));
            int upazilaId = Integer.parseInt(request.getParameter("upazilaId"));
            int unionId = Integer.parseInt(request.getParameter("unionId"));
            int mouzaId = Integer.parseInt(request.getParameter("mouzaId"));
            int villageId = Integer.parseInt(request.getParameter("villageId"));
            //String unitId = request.getParameter("unitId")=="" ? null : request.getParameter("unitId");
            int providerId = Integer.parseInt(request.getParameter("providerCode"));

            String query = "UPDATE  providerarea \n"
                    + "SET  fwaunit =" + unitId + ",modifydate=now() \n"
                    + " WHERE zillaid=" + districtId + " and upazilaid=" + upazilaId + " and unionid=" + unionId + " and mouzaid=" + mouzaId + " and villageid=" + villageId + " and providerid=" + providerId;

            DBManagerDistrict db = new DBManagerDistrict(districtId);
            int rowCount = db.update(query);
            response.setContentType("text/plain;charset=UTF-8");
            response.getWriter().write(rowCount + "");

        } else if (action.equalsIgnoreCase("updateWard")) {
            String wardId = request.getParameter("wardId");

            if (wardId.equals("") || wardId == null) {
                wardId = null;

            } else {
                wardId = "'" + wardId + "'";
            }

            int districtId = Integer.parseInt(request.getParameter("districtId"));
            int upazilaId = Integer.parseInt(request.getParameter("upazilaId"));
            int unionId = Integer.parseInt(request.getParameter("unionId"));
            int mouzaId = Integer.parseInt(request.getParameter("mouzaId"));
            int villageId = Integer.parseInt(request.getParameter("villageId"));
            //String wardId = request.getParameter("wardId")==""? null:request.getParameter("wardId");
            int providerId = Integer.parseInt(request.getParameter("providerCode"));

            String query = "UPDATE  providerarea \n"
                    + "SET  ward =" + wardId + " ,modifydate=now() \n"
                    + " WHERE zillaid=" + districtId + " and upazilaid=" + upazilaId + " and unionid=" + unionId + " and mouzaid=" + mouzaId + " and villageid=" + villageId + " and providerid=" + providerId;

            DBManagerDistrict db = new DBManagerDistrict(districtId);
            int rowCount = db.update(query);
            response.setContentType("text/plain;charset=UTF-8");
            response.getWriter().write(rowCount + "");

            //Set Provider In Active====================================================================
        } else if (action.equalsIgnoreCase("inActiveProvider")) {

            int districtId = Integer.parseInt(request.getParameter("districtId"));
            int upazilaId = Integer.parseInt(request.getParameter("upazilaId"));
            int unionId = Integer.parseInt(request.getParameter("unionId"));
            int providerId = Integer.parseInt(request.getParameter("providerCode"));
            String query = "UPDATE  providerarea \n"
                    + "SET  active =" + 0 + " ,modifydate=now() \n"
                    + "WHERE zillaid=" + districtId + " and upazilaid=" + upazilaId + " and providerId=" + providerId;

            DBManagerDistrict db = new DBManagerDistrict(districtId);
            int rowCount = db.update(query);
            response.setContentType("text/plain;charset=UTF-8");
            response.getWriter().write(rowCount + "");

        } else if (action.equalsIgnoreCase("updateProvider")) {
            //===================Update Provider-=========================
            int districtId = Integer.parseInt(request.getParameter("districtId"));
            int upazilaId = Integer.parseInt(request.getParameter("upazilaId"));
            int unionId = Integer.parseInt(request.getParameter("unionId"));
            int typeId = Integer.parseInt(request.getParameter("typeId"));

            //int providerId = Integer.parseInt(request.getParameter("providerId"));
            String name = request.getParameter("name");
            int mobile = Integer.parseInt(request.getParameter("mobile"));
            int supervisor = request.getParameter("supervisor").toString().isEmpty() ? 0 : Integer.parseInt(request.getParameter("supervisor"));
            int active = Integer.parseInt(request.getParameter("active"));
            int providerIdHidden = Integer.parseInt(request.getParameter("providerIdHidden"));

            String modifyDate = "modifydate=now(), exdate=null";
            if (active == 0) {
                modifyDate = "modifydate=now(), exdate=now()";
            }

            String query = "update public.providerdb \n"
                    + "set zillaid = " + districtId + ", active = " + active + ", upazilaid = " + upazilaId + ",unionid = " + unionId + ",provtype = " + typeId + ",provname ='" + name + "',mobileno = '" + mobile + "',supervisorcode = " + supervisor + " ," + modifyDate + " \n"
                    + "where providerid=" + providerIdHidden;

            System.out.println("SQL:  " + query);
            DBManagerDistrict db = new DBManagerDistrict(districtId);
            int rowCount = db.update(query);
            response.setContentType("text/plain;charset=UTF-8");
            response.getWriter().write(rowCount + "");
        } else if (action.equalsIgnoreCase("updateRound")) {
            //===================Update Round-=========================
            int districtId = Integer.parseInt(request.getParameter("districtId"));
            int upazilaId = Integer.parseInt(request.getParameter("upazilaId"));
            int unionId = Integer.parseInt(request.getParameter("unionId"));
            int round = Integer.parseInt(request.getParameter("round"));
            int providerId = Integer.parseInt(request.getParameter("providerId"));
            String fwaUnit = request.getParameter("FWAUnit").length() == 1 ? "0" + request.getParameter("FWAUnit") : request.getParameter("FWAUnit");

            System.out.print("Round: " + round + " districtId:" + districtId + " upazilaId:" + upazilaId + " unionId:" + unionId + " providerId:" + providerId + " FWAUnit:" + fwaUnit);

            String query = "update public.providerarea  \n"
                    + "set fwa_round ='" + round + "',modifydate=now()  \n"
                    + "where zillaid=" + districtId + " and upazilaid=" + upazilaId + " and unionid=" + unionId + " and provtype=3 and providerid=" + providerId + " and fwaunit=" + fwaUnit;

            DBManagerDistrict db = new DBManagerDistrict(districtId);
            int rowCount = db.update(query);
            response.setContentType("text/plain;charset=UTF-8");
            response.getWriter().write(rowCount + "");

        } else if (action.equalsIgnoreCase("addNewProvider")) {
            try {

                //int divisonId = 30;
                int divisonId = Integer.parseInt(request.getParameter("divisionId"));
                int districtId = Integer.parseInt(request.getParameter("districtId"));
                int upazilaId = Integer.parseInt(request.getParameter("upazilaId"));
                int unionId = Integer.parseInt(request.getParameter("unionId"));
                int provType = Integer.parseInt(request.getParameter("type"));
                int id = Integer.parseInt(request.getParameter("id"));
                String password = request.getParameter("password");
                String joinDate = request.getParameter("joinDate");
                String name = request.getParameter("name");
                String phone = request.getParameter("phone");
                String superviserId = request.getParameter("superviserCode").length() == 0 ? "0" : request.getParameter("superviserCode");
                //request.getParameter("upazilaId").length() == 0 ? "%" : request.getParameter("upazilaId");
                DBManagerDistrict db = new DBManagerDistrict(districtId);

                String query = "select count(*) as exists from providerdb where providerid=" + id;
                ResultSet rs = db.select(query);

                int count = 0;
                int rowCount = 0;
                while (rs.next()) {
                    count = rs.getInt("exists");
                }

                if (count > 0) {
                    rowCount = 2;

                } else {
//                    query = "SELECT systemupdatedt "
//                            + " FROM public.providerdb "
//                            + " WHERE divid=" + divisonId + " AND zillaid=" + districtId + " AND upazilaid=" + upazilaId + " AND unionid=" + unionId + " AND provtype=" + provType + " AND systemupdatedt IS NOT NULL "
//                            + " LIMIT 1";

                    /*-------------Commented by Helal
                    query = "select to_char(version_update,'ddmmyyyy') systemupdatedt from providerdb_vw  where provtype = " + provType + " and zillaid = " + districtId + " and  upazilaid = " + upazilaId + " and active=1 limit 1";
                    if(provType==15)
                        query = "select to_char(version_update,'ddmmyyyy') systemupdatedt from providerdb_vw  where provtype = " + provType + " and zillaid = " + districtId + " and active=1 limit 1";
                    //-----------End the comment*/
                    query = "SELECT systemupdatedt FROM public.version where provtype = " + provType;
                    //db = new DBManagerDistrict(districtId);
                    //rs = db.select(query);

                    String systemupdatedt = null;
                    systemupdatedt = new DBManagerMonitoring().one(query, "systemupdatedt");
                    new DBManagerMonitoring().one(query, "systemupdatedt");
//                    while (rs.next()) {
//                        systemupdatedt = rs.getString("systemupdatedt");
//                    }
//                    if (systemupdatedt.isEmpty()) {
//                        systemupdatedt = "to_char(now(),'ddmmyyyy')";
//                    }

                    query = "insert into providerdb (divid, zillaid, upazilaid, unionid, provtype, providerid, provname, mobileno, endate, devicesetting, active, healthidrequest, tablestructurerequest, areaupdate , provpass , supervisorcode, systemupdatedt )"
                            + " values (" + divisonId + ", " + districtId + ", " + upazilaId + ", " + unionId + ", " + provType + ", " + id + ",'" + name + "', " + phone + ", to_date('" + joinDate + "', 'dd/mm/yyyy')  , '2', '1', '2', '2', '2', '" + password + "', " + superviserId + "," + systemupdatedt + ")";
                    System.out.println("SQL: " + query);
                    db = new DBManagerDistrict(districtId);
                    rowCount = db.update(query);

                }

                response.setContentType("text/plain;charset=UTF-8");
                response.getWriter().write(rowCount + "");
            } catch (SQLException ex) {

            }
        } //Check Provider Area exits or not
        else if (action.equalsIgnoreCase("checkProviderAreaExistance")) {

            String districtId = request.getParameter("districtId");
            String upazilaId = request.getParameter("upazilaId");
            String unionId = request.getParameter("unionId");
            int providerIdHidden = Integer.parseInt(request.getParameter("providerIdHidden"));

            String query = "select mouzaid , villageid \n"
                    + "from public.providerarea \n"
                    + "where zillaid=" + districtId + " and upazilaid=" + upazilaId + " and unionid=" + unionId + " and providerid=" + providerIdHidden;

            String jsonString = executeSelect(query, districtId);
            response.setContentType("text/plain;charset=UTF-8");
            response.getWriter().write(jsonString);
            //------------------------End Get Round --------------------------------------------------------------------------------------------

            //------------------------Add area to provider -------------------------------------------------------------------------------------
        }
    }
}
