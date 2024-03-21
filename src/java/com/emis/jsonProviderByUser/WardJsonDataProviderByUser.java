package com.emis.jsonProviderByUser;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Helal
 */
@WebServlet(name = "WardJsonDataProviderByUser", urlPatterns = {"/WardJsonDataProviderByUser"})
public class WardJsonDataProviderByUser extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
            String json = null;
            
            if(request.getSession(false).getAttribute("ward") != null){
                    String ward = (String) request.getSession(false).getAttribute("ward");

                    if(ward.equals("1")){
                        json = "[{\"id\": 1,\"name\": \"ওয়ার্ডঃ ১\"}]";

                    }else if(ward.equals("2")){
                        json = "[{\"id\":2,\"name\": \"ওয়ার্ডঃ ২\"}]";

                    }else if(ward.equals("3")){
                        json = "[{\"id\": 3,\"name\": \"ওয়ার্ডঃ ৩\"}]";
                    }
                    
                    System.out.println("Ok Here:"+ward);
            }else{
                 json = "[{\"id\": 1,\"name\": \"ওয়ার্ডঃ ১\"},{\"id\":2,\"name\": \"ওয়ার্ডঃ ২\"},{\"id\": 3,\"name\": \"ওয়ার্ডঃ ৩\"}]";
            }
            
            response.setContentType("text/plain;charset=UTF-8");
            response.getWriter().write(json);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }


}
