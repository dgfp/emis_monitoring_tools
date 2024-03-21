package com.emis.management;

import com.emis.utility.Convertor;
import com.emis.utility.Utility;
import com.rhis.db.DBManagerDistrict;
import com.rhis.db.DBManagerMonitoring;
import java.io.IOException;
import java.sql.ResultSet;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.JSONArray;

/**
 *
 * @author Rangan
 */
@WebServlet(name = "Special_Area_Settings", urlPatterns = {"/Special_Area_Settings"})
public class Special_Area_Settings extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("submenu", "Special_Area_Settings");
        request.setAttribute("menu", "MANAGEMENT");
        RequestDispatcher view = request.getRequestDispatcher("WEB-INF/jsp/management/special_area_settings.jsp");
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
        String mouzaid = Utility.getParam("mouzaid", "0", request);
        String villageid = Utility.getParam("villageid", "0", request);
        String specialarea = Utility.getParam("specialarea", "0", request);
        String barrack = Utility.getParam("barrack", "0", request);

        String provtype = "3";
        String in_params = String.join(",", zillaid, upazilaid, unionid);
        System.out.println("zillaid: " + zillaid + " in_params: " + in_params);

        if (action.equalsIgnoreCase("typeSpecialarea")) {
            String query = "select specialarea as id, specialarea_name as text from special_area";
            try {
                DBManagerDistrict db = new DBManagerDistrict(Integer.parseInt(zillaid));
                ResultSet result = db.select(query);
                JSONArray json = Convertor.toJSON(result);
                response.setContentType("text/plain;charset=UTF-8");
                System.out.println(json.toString());
                response.getWriter().write(json.toString());
            } catch (Exception ex) {
                ex.getMessage();
            }
        }

        if (action.equalsIgnoreCase("getSpecialarea")) {
            in_params = String.join(",", zillaid, upazilaid, unionid, mouzaid, villageid);
            String query = "select v.*, vs.specialarea has_specialarea, coalesce(vs.barrack,0) barrack from \n"
                    + "(\n"
                    + "select v.zillaid,v.upazilaid,v.unionid,v.mouzaid,v.villageid,v.villagenameeng,sa.specialarea_name,sa.specialarea from special_area sa\n"
                    + "left join village v on (1=1)\n"
                    + "where (zillaid,upazilaid,unionid,mouzaid,villageid) in (select " + in_params + ")\n"
                    + ") v left join village_special_area vs using(zillaid,upazilaid,unionid,mouzaid,villageid,specialarea)";
            System.out.println("getSpecialarea: " + query);
            try {
                DBManagerDistrict db = new DBManagerDistrict(Integer.parseInt(zillaid));
                ResultSet result = db.select(query);
                JSONArray json = Convertor.toJSON(result);
                response.setContentType("text/plain;charset=UTF-8");
                System.out.println(json.toString());
                response.getWriter().write(json.toString());
            } catch (Exception ex) {
                ex.getMessage();
            }
        }

        if (action.equalsIgnoreCase("setSpecialarea")) {
            in_params = String.join(",", zillaid, upazilaid, unionid, mouzaid, villageid, specialarea, barrack);
            String query = "insert into village_special_area (zillaid, upazilaid, unionid, mouzaid, villageid, specialarea, barrack) values (" + in_params + ") "
                    + "ON  CONFLICT (zillaid, upazilaid, unionid, mouzaid, villageid, specialarea) DO UPDATE SET barrack=excluded.barrack, modifydate=now()";
            System.out.println("setSpecialarea: " + query);
            try {
                DBManagerDistrict db = new DBManagerDistrict(Integer.parseInt(zillaid));
                Integer json = db.update(query);
                response.setContentType("text/plain;charset=UTF-8");
                System.out.println(query.toString());
                response.getWriter().write(query.toString());
            } catch (Exception ex) {
                ex.getMessage();
            }
        }

        if (action.equalsIgnoreCase("delSpecialarea")) {
            in_params = String.join(",", zillaid, upazilaid, unionid, mouzaid, villageid, specialarea);
            String query = "delete from village_special_area where (zillaid, upazilaid, unionid, mouzaid, villageid, specialarea) in (select " + in_params + ")";
            System.out.println("delSpecialarea: " + query);
            try {
                DBManagerDistrict db = new DBManagerDistrict(Integer.parseInt(zillaid));
                Integer json = db.update(query);
                response.setContentType("text/plain;charset=UTF-8");
                System.out.println(query.toString());
                response.getWriter().write(query.toString());
            } catch (Exception ex) {
                ex.getMessage();
            }
        }

        //------------------------For Show Data --------------------------------------------------------------------------------------------
        if (action.equalsIgnoreCase("showdata")) {
            in_params = String.join(",", zillaid, upazilaid, unionid);
            String query = "select m.zillaid,m.upazilaid,m.unionid,m.mouzaid,v.villageid,m.mouzanameeng,v.villagenameeng,array_length(array_agg(sa.specialarea),1) total_specialarea,string_agg(sa.specialarea_name::text, ', ') specialarea_name\n"
                    + "from mouza m \n"
                    + "join village v using(zillaid,upazilaid,unionid,mouzaid)\n"
                    + "left join village_special_area vs using(zillaid,upazilaid,unionid,mouzaid,villageid)\n"
                    + "left join special_area sa on (vs.specialarea=sa.specialarea)\n"
                    + "where (m.zillaid,m.upazilaid,m.unionid) in (select " + in_params + ")\n"
                    + "group by m.zillaid,m.upazilaid,m.unionid,m.mouzaid,v.villageid,m.mouzanameeng,v.villagenameeng";

            try {
                DBManagerDistrict db = new DBManagerDistrict(Integer.parseInt(zillaid));
                ResultSet result = db.select(query);
                JSONArray json = Convertor.toJSON(result);
                response.setContentType("text/plain;charset=UTF-8");
                System.out.println(json.toString());
                response.getWriter().write(json.toString());
            } catch (Exception ex) {
                ex.getMessage();
            }

        }

        if (action.equalsIgnoreCase("updatedata")) {
//            String unit = Utility.getParam("unit", "0", request);
//            String providerid = Utility.getParam("providerid", "0", request);
//            String facility_code = Utility.getParam("facility_code", "0", request);
//            String sdp_code = Utility.getParam("sdp_code", "0", request);
//            String is_additional_charge = Utility.getParam("is_additional_charge", "0", request);
//            String start_date = Utility.getParam("start_date", null, request);
//            String end_date = Utility.getParam("end_date", null, request);
//            String query = "INSERT INTO public.provider_sdp_mapping( zillaid , upazilaid , unionid , unit , provtype , providerid , facility_code, sdp_code, is_additional_charge, start_date, end_date, modifydate)\n"
//                    + "VALUES ( " + zillaid + ", " + upazilaid + ", " + unionid + ", " + unit + ", " + provtype + ", " + providerid + ", '" + facility_code + "', '" + sdp_code + "', " + is_additional_charge + ", " + (start_date == null ? null : "'" + start_date + "'") + ", " + (end_date == null ? null : "'" + end_date + "'") + ", now()) \n"
//                    + "on conflict(zillaid, upazilaid, unionid, unit, providerid) \n"
//                    + "do update set( zillaid , upazilaid , unionid , unit , provtype , providerid , facility_code, sdp_code, is_additional_charge, start_date, end_date, systementrydate, modifydate, uploaddate, upload) =row(EXCLUDED.*);";
//            System.out.println("Query: " + query);
            String query = "";
            DBManagerDistrict db = new DBManagerDistrict(99);
            int rowCount = db.update(query);
            response.setContentType("text/plain;charset=UTF-8");
            response.getWriter().write(rowCount + "");

        }
    }
}
