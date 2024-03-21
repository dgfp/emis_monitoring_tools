package com.emis.management;

import com.emis.utility.Convertor;
import com.emis.utility.Utility;
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

/**
 * INSERT INTO public.web_modulereport ( modcode, modrep,
 * modreptitle,servlet_url, visible, sorted) VALUES (9, 920, 'Provider DB
 * Status', 'ProviderDB_STATUS', 1, 0);
 *
 * INSERT INTO public.web_roleaccess (roleid, modrep) VALUES (1, 920);
 *
 * @author Rangan
 */
@WebServlet(name = "Provider_SDP_Mapping", urlPatterns = {"/Provider_SDP_Mapping"})
public class Provider_SDP_Mapping extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("submenu", "Provider_SDP_Mapping");
        request.setAttribute("menu", "MANAGEMENT");
        RequestDispatcher view = request.getRequestDispatcher("WEB-INF/jsp/management/provider_sdp_mapping.jsp");
        view.forward(request, response);

    }

    DBManagerMonitoring db = null;

    private String getResultSet(String query) {
        ResultSet result = db.select(query);
        JSONArray json = new JSONArray();
        try {
            json = Convertor.toJSON(result);
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        }
        return json.toString();
    }

    private String executeSelect(String query, String districtId) {
        db = new DBManagerDistrict(Integer.parseInt(districtId));
        System.out.println("getURL: " + db.getURL());
        return getResultSet(query);
    }

    private String executeSelect(String query) {
        db = new DBManagerMonitoring();
        return getResultSet(query);

    }

    //private static String[] OLD_DISTRICTS= new String[] {"93","36","51","75"};
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = Utility.getParam("action", "", request);
        String zillaid = Utility.getParam("zillaid", "0", request);
        String upazilaid = Utility.getParam("upazilaid", "0", request);
        String unionid = Utility.getParam("unionid", "0", request);
        String provtype = Utility.getParam("provtype", "0", request);
        //String provtype = "3";
        String in_params = String.join(",", zillaid, upazilaid, unionid);
        System.out.println("zillaid: " + zillaid + " in_params: " + in_params);

        //------------------------For Show Data --------------------------------------------------------------------------------------------
        if (action.equalsIgnoreCase("showdata")) {
            String query = "select * from public.web_sdb_mapping_select(" + in_params + ")";
            if(!provtype.equals("3")){
                in_params = String.join(",", zillaid, upazilaid, unionid, provtype);
                query = "select * from public.web_sdb_mapping_select_facility(" + in_params + ")";
            }
            
            //String query = "select * from public.web_sdb_mapping_select(" + in_params + ")";
            System.out.println("Query: " + query);
            String jsonString = executeSelect(query);
            //String jsonString = executeSelect(query);
            response.setContentType("text/plain;charset=UTF-8");
            response.getWriter().write(jsonString);

        }

        if (action.equalsIgnoreCase("updatedata")) {
            String unit = Utility.getParam("unit", "0", request);
            String providerid = Utility.getParam("providerid", "0", request);
            String facility_code = Utility.getParam("facility_code", "0", request);
            String sdp_code = Utility.getParam("sdp_code", "0", request);
            String is_additional_charge = Utility.getParam("is_additional_charge", "0", request);
            String start_date = Utility.getParam("start_date", null, request);
            String end_date = Utility.getParam("end_date", null, request);
            String query = "INSERT INTO public.provider_sdp_mapping( zillaid , upazilaid , unionid , unit , provtype , providerid , facility_code, sdp_code, is_additional_charge, start_date, end_date, modifydate)\n"
                    + "VALUES ( "+zillaid+", "+upazilaid+", "+unionid+", "+unit+", "+provtype+", "+providerid+", '"+facility_code+"', '"+sdp_code+"', "+is_additional_charge+", "+(start_date==null?null:"'"+start_date+"'")+", "+(end_date==null?null:"'"+end_date+"'")+", now()) \n"
                    + "on conflict(zillaid, upazilaid, unionid, unit, providerid) \n"
                    + "do update set( zillaid , upazilaid , unionid , unit , provtype , providerid , facility_code, sdp_code, is_additional_charge, start_date, end_date, systementrydate, modifydate, uploaddate, upload) =row(EXCLUDED.*);";
            System.out.println("Query: " + query);
            DBManagerDistrict db = new DBManagerDistrict(0);
            int rowCount = db.update(query);
            response.setContentType("text/plain;charset=UTF-8");
            response.getWriter().write(rowCount + "");

        }
    }
}
