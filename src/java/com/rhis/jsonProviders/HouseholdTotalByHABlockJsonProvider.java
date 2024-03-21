package com.rhis.jsonProviders;

import com.rhis.db.DBManagerDistrict;
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
 * @author shahaz
 */
@WebServlet(name = "HouseholdTotalByHABlockJsonProvider", urlPatterns = {"/householdtotalbyhablock"})
public class HouseholdTotalByHABlockJsonProvider extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String districtId = request.getParameter("districtId");
        String upazilaId = request.getParameter("upazilaId");
        String unionId = request.getParameter("unionId");
         String wardOld = '0'+request.getParameter("wardOld");
           String subBlock =  request.getParameter("subBlock");

        try {

            DBManagerDistrict db = new DBManagerDistrict(Integer.parseInt(districtId));
            String sql ="select count(*) as count FROM household  "
                    + "where  zillaid  = " + districtId + " "
                    + "and upazilaid= " + upazilaId + " "
                    + "and unionid= " + unionId +" "
                   + "and wardold= '" + wardOld +  "' "
                    + "and subblock= '" + subBlock + "'";
                     ResultSet result = db.select(sql);
             JSONArray json = new JSONArray();
                if(result.next()){
                    JSONObject jo = new JSONObject();
                    jo.put("count",result.getInt(1));
                   // jo.put("query",sql);
                     json.put(jo);
                }
           // JSONArray json = Convertor.convertResultSetIntoJSON(result);
            response.setContentType("text/plain;charset=UTF-8");
            response.getWriter().write(json.toString());
            
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        }

    }

}
