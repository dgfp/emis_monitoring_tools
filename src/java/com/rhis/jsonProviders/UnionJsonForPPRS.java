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
@WebServlet(name = "UnionJsonForPPRS", urlPatterns = {"/unionJsonForPPRS"})
public class UnionJsonForPPRS extends HttpServlet {


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session=request.getSession();
        LoginUser loginuser=(LoginUser) session.getAttribute("LoginUser");
        
        String unionId = loginuser.getUnion();
        String upazilaId = loginuser.getUpazila();
        String zillaId = loginuser.getDistrict();

       
        try {
            DBManagerMonitoring db = new DBManagerMonitoring();
            ResultSet result=null;
            
            if(unionId==null && zillaId!=null && upazilaId!=null){
                result = db.select("select * from unions where zillaid = " + zillaId + " and upazilaid = " + upazilaId
                    + " ORDER BY unionnameeng ASC");
                
            }else if(upazilaId==null && zillaId!=null){
                
                result = db.select("select * from unions where zillaid = " + zillaId
                    + " ORDER BY unionnameeng ASC");
                
            }else if(unionId!=null && zillaId!=null && upazilaId!=null){
               result = db.select("select * from unions where zillaid = " + zillaId + " and upazilaid = " + upazilaId  +" and unionid = " + unionId
                    + " ORDER BY unionnameeng ASC");
            }
            
            JSONArray json = Convertor.convertResultSetIntoJSON(result);
            response.setContentType("text/plain;charset=UTF-8");
            response.getWriter().write(json.toString());
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        }
        
    }

   
}
