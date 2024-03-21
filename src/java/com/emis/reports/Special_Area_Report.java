package com.emis.reports;

import com.emis.beans.Response;
import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.emis.utility.Convertor;
import com.emis.utility.Utility;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.rhis.db.DBManagerDistrict;
import com.rhis.db.DBManagerMonitoring;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.Iterator;
import java.util.List;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

/**
 *
 * @author RHIS082
 */
@WebServlet(name = "Special_Area_Report", urlPatterns = {"/Special_Area_Report"})
public class Special_Area_Report extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!Utility.isAjax(request)) {
            request.setAttribute("submenu", "Special_Area_Report");
            request.setAttribute("menu", "VIEW REPORTS");
            RequestDispatcher view = request.getRequestDispatcher("WEB-INF/jsp/reports/special_area_report.jsp");
            view.forward(request, response);
        } else {

            String _divid = (String) request.getSession(false).getAttribute("division");
            String _zillaid = (String) request.getSession(false).getAttribute("district");
            String _upazilaid = (String) request.getSession(false).getAttribute("upazila");
            String _unionid = (String) request.getSession(false).getAttribute("union");
            String _providerid = (String) request.getSession(false).getAttribute("providerCode");
            ///////////////////////////////////
            String sql = "";
            String where = "";
            String action = Utility.getParam("action", "", request);
            //////////////////////////////////
            String divid = Utility.getParam("divid", "0", request);
            String zillaid = Utility.getParam("zillaid", "0", request);
            String upazilaid = Utility.getParam("upazilaid", "0", request);

            JSONArray json = new JSONArray();
            try {

                if (action.equals("division")) {
                    DBManagerMonitoring db = new DBManagerMonitoring();

                    if (!(_divid == null || _divid == "0")) {
                        where = "and id::int= " + _divid;
                    }

                    sql = "SELECT distinct id, division as text, divisioneng FROM public.implemented_div_zila where is_implemented=1 " + where + " order by divisioneng asc";
                    ResultSet result = db.select(sql);
                    json = Convertor.toJSON(result);
                } else if (action.equals("zilla")) {
                    DBManagerMonitoring db = new DBManagerMonitoring();
                    if (!(_zillaid == null || _zillaid == "0")) {
                        where = "and zillaid= " + _zillaid;
                    }

                    sql = "select distinct zillaid as id, zillaname as text, zillanameeng from implemented_div_zila where id::int=" + divid + " and is_implemented=1 " + where + " order by zillanameeng asc";
                    ResultSet result = db.select(sql);
                    json = Convertor.toJSON(result);
                } else if (action.equals("upazila")) {
                    DBManagerMonitoring db = new DBManagerDistrict(Integer.parseInt(zillaid));
                    sql = "select distinct upazilaid as id, upazilaname as text, upazilanameeng from upazila where (zillaid,upazilaid) in (select distinct zillaid,upazilaid from village_special_area ) and   zillaid=" + zillaid + "  order by upazilanameeng asc";
                    ResultSet result = db.select(sql);
                    json = Convertor.toJSON(result);
                } else if (action.equals("provider")) {
                    if (!(_providerid == null || _providerid == "0")) {
                        where = "and providerid= " + _providerid;
                    }
                    DBManagerMonitoring db = new DBManagerDistrict(Integer.parseInt(zillaid));
                    sql = "select distinct providerid as id, provname as text  from special_area_vw where (zillaid,upazilaid) in (select " + zillaid + "," + upazilaid + " )  " + where + " order by 1 desc";
                    ResultSet result = db.select(sql);
                    json = Convertor.toJSON(result);
                } else if (action.equals("specialarea")) {
                    DBManagerMonitoring db = new DBManagerDistrict(Integer.parseInt(zillaid));
                    sql = "select distinct specialarea as id, specialarea_name as text  from special_area_vw where (zillaid,upazilaid) in (select " + zillaid + "," + upazilaid + " ) order by 1 desc";
                    ResultSet result = db.select(sql);
                    json = Convertor.toJSON(result);
                }

            } catch (Exception ex) {
                System.out.println(ex.getMessage());
            }
            System.out.println(action + " / " + sql);
            response.setContentType("text/plain;charset=UTF-8");
            response.getWriter().write(json.toString());
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Connection connection = null;
        DBManagerMonitoring db = null;
        String action = Utility.getParam("action", "", request);
        String json_stringify = Utility.getParam("json_stringify", "[]", request);
        String divid = Utility.getParam("divid", "0", request);
        String zillaid = Utility.getParam("zillaid", "0", request);
        String upazilaid = Utility.getParam("upazilaid", "0", request);
        String unionid = Utility.getParam("unionid", "0", request);
        String specialarea = Utility.getParam("specialarea", "0", request);
        String yearno = Utility.getParam("yearno", "0", request);
        String monthno = Utility.getParam("monthno", "0", request);
        String providerid = Utility.getParam("providerid", "0", request);

        if (action.equals("getData_old")) {
            //System.out.println("getData: " + data);
            JSONArray json = new JSONArray();
            Response R = new Response();
            R.setStatus(0);
            R.setMessage("Something went wrong");
            R.setData(json.toString());

            try {
                db = new DBManagerDistrict(Integer.parseInt(zillaid));
                String sql = "select \n"
                        + "coalesce(r.year_no,%s) year_no\n"
                        + ",coalesce(r.month_no,%s) month_no\n"
                        + ",coalesce(r.zillaid,v.zillaid) zillaid\n"
                        + ",coalesce(r.upazilaid,v.upazilaid) upazilaid\n"
                        + ",coalesce(r.unionid,v.unionid) unionid\n"
                        + ",coalesce(r.mouzaid,v.mouzaid) mouzaid\n"
                        + ",coalesce(r.villageid,v.villageid) villageid\n"
                        + ",coalesce(r.specialarea,v.specialarea) specialarea\n"
                        + ",coalesce(r.unit,v.fwaunit) unit\n"
                        + ",coalesce(r.providerid,v.providerid) providerid\n"
                        + ",coalesce(r.supervisorid,v.supervisorcode) supervisorid\n"
                        + ",coalesce(r.r_villagename,v.villagename) r_villagename\n"
                        + ",r.r_barrack_tot\n"
                        + ",r.r_household_tot\n"
                        + ",r.r_population_tot\n"
                        + ",r.r_capable_elco_tot\n"
                        + ",r.r_permanent_man_tot\n"
                        + ",r.r_permanent_woman_tot\n"
                        + ",coalesce(r.r_permanent_both_tot,0) r_permanent_both_tot\n"
                        + ",r.r_inject_tot\n"
                        + ",r.r_iud_tot\n"
                        + ",r.r_implant_tot\n"
                        + ",r.r_condom_tot\n"
                        + ",r.r_pill_tot\n"
                        + ",coalesce(r.r_all_total_tot,0) r_all_total_tot\n"
                        + ",coalesce(r.r_car,0) r_car\n"
                        + ",r.r_preg_anc_service_visit_csba\n"
                        + ",r.r_pnc_mother_visit_csba\n"
                        + ",r.r_delivary_service_delivery_done_csba\n"
                        + ",r.r_pnc_child_visit_csba\n"
                        + ",r.r_delivary_service_hospital_operation_fwa\n"
                        + ",r.r_general_patients\n"
                        + ",r.r_tot_live_birth_fwa\n"
                        + ",r.r_death_number_maternal_death_fwa\n"
                        + ",r.r_death_number_child_fwa\n"
                        + ",r.r_death_number_other_death_fwa\n"
                        + ",coalesce(r.r_death_number_all_death_fwa,0) r_death_number_all_death_fwa\n"
                        + ",r.is_submitted\n"
                        + ",coalesce(r.is_approved,0) is_approved \n"
                        + ",coalesce(r.entry_date,now())::date entry_date\n"
                        + ",coalesce(r.modifydate,now()) modifydate\n"
                        + "from special_area_vw v\n"
                        + "left join (select * from rpt_special_area where year_no=%s and month_no=%s) r\n"
                        + "using (zillaid,upazilaid,unionid,mouzaid,villageid,specialarea) where (zillaid,upazilaid,specialarea) in (select %s,%s,%s)";
                
//                if(providerid){
//                    coalesce(r.providerid,v.providerid) providerid
//                }

                sql = String.format(sql, yearno, monthno, yearno, monthno, zillaid, upazilaid, specialarea);
                System.out.println("SQL for specialarea :" + sql);
                ResultSet result = db.select(sql);
                json = Convertor.toJSON(result);
                R.setStatus(1);
                R.setMessage("Successfully loaded");
                R.setData(json.toString());

            } catch (Exception ex) {

            }

            response.setContentType("text/plain;charset=UTF-8");
            ObjectMapper mapper = new ObjectMapper();
            mapper.writeValue(response.getOutputStream(), R);

        } 
        else if (action.equals("getData")) {
            //System.out.println("getData: " + data);
            JSONArray json = new JSONArray();
            Response R = new Response();
            R.setStatus(0);
            R.setMessage("Something went wrong");
            R.setData(json.toString());

            try {
                db = new DBManagerDistrict(Integer.parseInt(zillaid));
                String sql = "select zillaname,upazilaname,(web_special_area_report(zillaid,upazilaid,unionid,mouzaid,villageid,%s,%s,%s)).* from special_area_vw where (zillaid,upazilaid) in (select %s,%s)";
                sql = String.format(sql, specialarea, yearno, monthno, zillaid, upazilaid);
                System.out.println("SQL for specialarea :" + sql);
                ResultSet result = db.select(sql);
                json = Convertor.toJSON(result);
                R.setStatus(1);
                R.setMessage("Successfully loaded");
                R.setData(json.toString());

            } catch (Exception ex) {

            }

            response.setContentType("text/plain;charset=UTF-8");
            ObjectMapper mapper = new ObjectMapper();
            mapper.writeValue(response.getOutputStream(), R);

        } 
        else if (action.equals("setData")) {
            System.out.println("setData: " + json_stringify);

            Enumeration<String> params = request.getParameterNames();
            while (params.hasMoreElements()) {
                String paramName = params.nextElement();
                System.out.println("Parameter Name - " + paramName + ", Value - " + request.getParameter(paramName));
            }

           
            int updated = 0;
            String query_format = "INSERT INTO rpt_special_area (%s) VALUES (%s) ON CONFLICT(%s) DO UPDATE SET (%s)=row(%s)";
            String pKeys = "year_no, month_no, zillaid, upazilaid, unionid, mouzaid, villageid, specialarea";
            String[] singleQuoted = new String[]{"r_villagename", "entry_date"};
            JSONArray ja = new JSONArray();
            try {
                
                /*
                        if (obj instanceof String) {
                  Object obj = new String("GeeksForGeeks"); 
        Class c = obj.getClass(); 
        System.out.println("Class of Object obj is : "
                           + c.getName());       
                  */

                ja = new JSONArray(json_stringify);
                JSONObject jo;
                for (int i = 0; i < ja.length(); i++) {
                    jo = ja.getJSONObject(i);
                    System.out.printf(" eq(%s) => (year_no=%s, month_no=%s, zillaid=%s, upazilaid=%s, unionid=%s, mouzaid=%s, villageid=%s, specialarea=%s)", i, jo.get("year_no"), jo.get("month_no"), jo.get("zillaid"), jo.get("upazilaid"), jo.get("unionid"), jo.get("mouzaid"), jo.get("villageid"), jo.get("specialarea"));
                    jo.put("modifydate", "now()");
                    jo.put("is_submitted", "1");
                    jo.put("is_approved", "0");

                    List<String> Keys = new ArrayList<>();
                    List<String> Vals = new ArrayList<>();
                    Iterator<String> keys = jo.keys();
                    while (keys.hasNext()) {
                        String k = keys.next();
                        String v = (String) "" + jo.get(k);
                        //v = v.isEmpty() ? "0" : v;
                        if (Utility.contains(singleQuoted, k)) {
                            v = String.format("'%s'", v);
                        }
                        
                        Keys.add(k);
                        Vals.add(v);
                        //System.out.printf("index=%s, key=%s, val=%s ", i, k, v);
                    }
                    String query = String.format(query_format,
                            String.join(",", Keys),
                            String.join(",", Vals),
                            pKeys,
                            String.join(",", Keys),
                            "excluded." + String.join(",excluded.", Keys)
                    );
//                    for (int j = 0; j < jo.names().length(); j++) {
//                       System.out.println( "INDEX = " + i + ", POS = " + j +", key = " + jo.names().getString(j) + ", value = " + jo.get(jo.names().getString(j)));
//                       //System.out.println(j);
//                    }
                    db = new DBManagerDistrict(jo.getInt("zillaid"));
                    updated = db.update(query);
                    System.out.printf("QUERY(%s): %s => %s ", i, updated, query);

                }

            } catch (JSONException e) {
                System.out.println("Error: " + e.getMessage());
            }

            response.setContentType("text/plain;charset=UTF-8");
            response.getWriter().write(ja.toString());

        }

    }

}
