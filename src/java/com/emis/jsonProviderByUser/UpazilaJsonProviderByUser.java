package com.emis.jsonProviderByUser;

import com.emis.utility.Convertor;
import com.emis.utility.Utility;
import com.rhis.db.DBManagerDistrict;
import com.rhis.db.DBManagerMonitoring;
import java.io.IOException;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.JSONArray;

/**
 *
 * @author Helal
 */
@WebServlet(name = "UpazilaJsonProviderByUser", urlPatterns = {"/UpazilaJsonProviderByUser"})
public class UpazilaJsonProviderByUser extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String district = (String) request.getSession(false).getAttribute("district");
        String upazila = (String) request.getSession(false).getAttribute("upazila");

        String where = "where zillaid=" + district;

        if (upazila != null) {
            if (!upazila.equals("0")) {
                where = "where zillaid=" + district + " and upazilaid=" + upazila;
            }
        }

        try {
            DBManagerMonitoring db = new DBManagerMonitoring();
            //ResultSet result = db.select("select * from upazila " + where + "order by upazilanameeng asc");
            String sql = "select distinct zillaid, upazilaid, upazilaname, upazilanameeng  from implemented_div_zila " + where + " and is_implemented=1 order by upazilanameeng asc";
            ResultSet result = db.select(sql);
            
            if(request.getSession(false).getAttribute("designation").toString().equals("UFPO")){
                sql="select distinct pa.zillaid, pa.upazilaid, name_upazila(pa.zillaid, pa.upazilaid) upazilaname, name_upazila_eng(pa.zillaid, pa.upazilaid) upazilanameeng\n" +
                "from providerdb p join providerarea pa using(providerid)\n" +
                "where p.supervisorcode in (select distinct p2.providerid from providerdb p2 where p2.supervisorcode = "+request.getSession(false).getAttribute("providerCode")+")";
                result = new DBManagerDistrict(Integer.parseInt(district)).select(sql);
            }
            
            
            JSONArray json = Convertor.convertResultSetIntoJSON(result);
            response.setContentType("text/plain;charset=UTF-8");
            response.getWriter().write(json.toString());
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
            response.setContentType("text/plain;charset=UTF-8");
            //response.getWriter().write(Utility.);
        }
    }
}
