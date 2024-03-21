package com.rhis.jsonProviders;

import com.emis.beans.LoginUser;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Helal
 */
@WebServlet(name = "ProviderJsonProvider", urlPatterns = {"/providerJsonProvider"})
public class ProviderJsonProvider extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session=request.getSession();
        LoginUser loginuser=(LoginUser) session.getAttribute("LoginUser");
        
        String upazilaId = loginuser.getUpazila();
        
        String pId = request.getAttribute("pId").toString();
        
        response.getWriter().println("ID: "+pId);
        
        

        
//        try {
//            DBManager2 db = new DBManager2();
//            //String pId = request.getAttribute("pId").toString();
//            ResultSet result=db.select("SELECT \"ProvCode\",\"ProvName\" FROM public.\"ProviderDB\" where upazilaid='"+upazilaId+"' and \"ProvType\"='"+pId+"'");
//
//            
//            
//            JSONArray json = Convertor.convertResultSetIntoJSON(result);
//            response.setContentType("text/plain;charset=UTF-8");
//            response.getWriter().write(json.toString());
//            
//        } catch (Exception ex) {
//            System.out.println(ex.getMessage());
//        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }


}
