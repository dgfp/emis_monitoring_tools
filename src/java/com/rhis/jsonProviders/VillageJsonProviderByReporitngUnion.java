package com.rhis.jsonProviders;

import com.rhis.db.DBManagerDistrict;
import java.io.IOException;;
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
@WebServlet(name = "VillageJsonProviderByReporitngUnion", urlPatterns = {"/village-json-provider-by-reporitng-union"})
public class VillageJsonProviderByReporitngUnion extends HttpServlet {

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
                ResultSet vill_rs = db.select("SELECT * FROM public.village where zillaid="+districtId+" and upazilaid="+upazilaId+" and unionid="+rs.getInt("unionid"));
                while (vill_rs.next()) {
                    JSONObject jo = new JSONObject();
                    jo.put("unionid", vill_rs.getInt("unionid"));
                    jo.put("mouzaid", vill_rs.getInt("mouzaid"));
                    jo.put("villageid", vill_rs.getInt("villageid"));
                    jo.put("villagenameeng", vill_rs.getString("villagenameeng"));
                    jo.put("villagename", vill_rs.getString("villagename"));
                    ja.put(jo);
                }
            }
            response.getWriter().write(ja.toString());
        } catch (Exception ex) {
            response.getWriter().write(ex.getMessage());
        }

    }
}
