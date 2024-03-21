
package com.rhis.jsonProviders;

import com.rhis.db.DBManagerDistrict;
import java.io.IOException;
import java.io.PrintWriter;
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
@WebServlet(name = "FWAProviderJsonProviderByReportingUnion", urlPatterns = {"/fwa-provider-json-provider-by-reporting-union"})
public class FWAProviderJsonProviderByReportingUnion extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String districtId = request.getParameter("zillaId");
        String upazilaId = request.getParameter("upazilaId");
        String unionId = request.getParameter("unionId");
        DBManagerDistrict db = null;
        response.setContentType("text/plain;charset=UTF-8");
        try {
            db = new DBManagerDistrict(Integer.parseInt(districtId));
            ResultSet rs = db.select("SELECT unnest(unionids) unionid FROM public.reporting_union where zillaid="+districtId+" and upazilaid="+upazilaId+" and reporting_unionid="+unionId);
            JSONArray ja = new JSONArray();
            while (rs.next()) {
                db = new DBManagerDistrict(Integer.parseInt(districtId));
                ResultSet vill_rs = db.select("SELECT providerid, provname FROM public.providerdb where zillaid="+districtId+" and upazilaid="+upazilaId+" and unionid="+ rs.getInt("unionid") +" and provtype=3 and active = 1");
                while (vill_rs.next()) {
                    JSONObject jo = new JSONObject();
                    jo.put("providerid", vill_rs.getInt("providerid"));
                    jo.put("provname", vill_rs.getString("provname"));
                    ja.put(jo);
                }
            }
            response.getWriter().write(ja.toString());
        } catch (Exception ex) {
            response.getWriter().write(ex.getMessage());
        }

    }
}