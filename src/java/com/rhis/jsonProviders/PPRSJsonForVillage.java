package com.rhis.jsonProviders;

import com.emis.beans.LoginUser;
import com.emis.utility.Convertor;
import com.rhis.db.DBManagerMonitoring;
import java.io.IOException;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.json.JSONArray;

/**
 *
 * @author Helal
 */
@WebServlet(name = "PPRSJsonForVillage", urlPatterns = {"/pprsJsonForVillage"})
public class PPRSJsonForVillage extends HttpServlet {

    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            
            HttpSession session=request.getSession();
            LoginUser loginuser=(LoginUser) session.getAttribute("LoginUser");

            String upazilaId = loginuser.getUpazila();
            String districtId = loginuser.getDistrict();
            String unionId = loginuser.getUnion();

            try {

                DBManagerMonitoring db = new DBManagerMonitoring();
                ResultSet result=null;
                        
                if(districtId!=null && upazilaId!=null && unionId!=null){
                                    result = db.select("select \"MOUZAID\",\"VILLAGEID\" , \"VILLAGENAMEENG\", \"VILLAGENAME\" from \"Village\" where "
                        + "\"ZILLAID\" = " + districtId + " "
                        + "and \"UPAZILAID\"= " + upazilaId + " "
                        + "and \"UNIONID\"= " + unionId + " "
                        + "order by \"VILLAGENAMEENG\" ASC;");
                
                }


                JSONArray json = Convertor.convertResultSetIntoJSON(result);
                response.setContentType("text/plain;charset=UTF-8");
                response.getWriter().write(json.toString());

            } catch (Exception ex) {
                System.out.println(ex.getMessage());
            }
        
    }

}
