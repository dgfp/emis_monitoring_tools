package com.rhis.jsonProviders;

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
import org.json.JSONObject;

/**
 *
 * @author Helal
 */
@WebServlet(name = "UnionJsonProviderTest", urlPatterns = {"/UnionJsonProviderTest"})
public class UnionJsonProviderTest extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String upazilaId = request.getParameter("upazilaId");
        String zillaId = request.getParameter("zilaId");
        String where="where zillaid = " + zillaId + " and upazilaid = " + upazilaId;
        
        try {
            DBManagerDistrict db =new DBManagerDistrict(Integer.parseInt(zillaId));
            ResultSet rs = db.select("SELECT zillaid, upazilaid, municipalityid, reporting_unionid unionid, unionnameeng, unionname, is_actual\n" +
                                                "FROM public.reporting_union where zillaid = "+zillaId+" and upazilaid= "+upazilaId+" order by reporting_unionid");
            JSONArray ja = new JSONArray();
            while (rs.next()) {
                JSONObject jo = new JSONObject();
                jo.put("unionid", rs.getArray("unionid"));
                jo.put("unionname", rs.getString("unionname"));
                jo.put("unionnameeng", rs.getString("unionnameeng"));
                ja.put(jo);
            }
            response.setContentType("text/plain;charset=UTF-8");
            response.getWriter().write(ja.toString());
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        }
    }
}
