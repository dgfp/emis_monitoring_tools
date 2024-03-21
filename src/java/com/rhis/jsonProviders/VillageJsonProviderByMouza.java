package com.rhis.jsonProviders;

import com.emis.utility.Convertor;
import com.rhis.db.DBManagerDistrict;
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
@WebServlet(name = "VillageJsonProviderByMouza", urlPatterns = {"/VillageJsonProviderByMouza"})
public class VillageJsonProviderByMouza extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            
            String districtId = request.getParameter("zilaId");
            String upazilaId = request.getParameter("upazilaId");
            String unionId = request.getParameter("unionId");
            String mouzaId = request.getParameter("mouzaId");

            try {

                DBManagerDistrict db = new DBManagerDistrict(Integer.parseInt(districtId));

//                ResultSet result = db.select("select \"VILLAGEID\" , \"VILLAGENAMEENG\", \"VILLAGENAME\" from \"Village\" where "
//                        + "\"ZILLAID\" = " + districtId + " "
//                        + "and \"UPAZILAID\"= " + upazilaId + " "
//                        + "and \"UNIONID\"= " + unionId + " "
//                        + "and \"MOUZAID\"= " + mouzaId + " "
//                        + "order by \"VILLAGENAMEENG\" ASC;");
                
                ResultSet result = db.select("select villageid , villagenameeng, villagename from village where\n" +
                "zillaid = "+districtId+" and upazilaid= "+upazilaId+" and unionid= "+unionId+" and mouzaid="+mouzaId+" order by villagenameeng asc");

                JSONArray json = Convertor.convertResultSetIntoJSON(result);
                response.setContentType("text/plain;charset=UTF-8");
                response.getWriter().write(json.toString());

            } catch (Exception ex) {
                System.out.println(ex.getMessage());
            }
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

}
