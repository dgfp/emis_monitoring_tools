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


@WebServlet(name = "PPRSJsonForUpazila", urlPatterns = {"/pprsJsonForUpazila"})
public class PPRSJsonForUpazila extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session=request.getSession();
        LoginUser loginuser=(LoginUser) session.getAttribute("LoginUser");
        
        String zillaId = loginuser.getDistrict();
        String upazilaId = loginuser.getUpazila();
        String userLevel = loginuser.getUserLevel();
        
        //int districtId=Integer.parseInt(request.getParameter("districtId"));

        
        try {
            DBManagerMonitoring db = new DBManagerMonitoring();
            String username = (String) request.getSession(false).getAttribute("username");
            ResultSet result=null;
//            
//            if(upazilaId==null){
//                
//                result=db.select("select * from \"Upazila\" where \"ZILLAID\"  = " + districtId+ "ORDER BY \"UPAZILANAMEENG\" ASC");
//                            
//            }else 

                System.out.print("Hello"+userLevel);
                if(zillaId!=null && upazilaId==null && userLevel!="1"){
                
                        result=db.select("select * from \"Upazila\" where \"ZILLAID\"  = " + zillaId+ " ORDER BY \"UPAZILANAMEENG\" ASC");
                            
                }else if(upazilaId!=null && zillaId!=null){
                    result = db.select("select * from \"Upazila\" where \"UPAZILAID\"='"+upazilaId+"' and \"ZILLAID\"='"+zillaId+"'  ORDER BY \"UPAZILANAMEENG\" ASC");
                }
            
            JSONArray json = Convertor.convertResultSetIntoJSON(result);
            response.setContentType("text/plain;charset=UTF-8");
            response.getWriter().write(json.toString());
            
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        }
    }

}
