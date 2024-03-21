/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.rhis.jsonProviders;

import com.emis.utility.Convertor;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.JSONArray;
import org.json.JSONObject;

/**
 *
 * @author ccah
 */
@WebServlet(name = "HAWardJsonDataProvider", urlPatterns = {"/HAWardJsonDataProvider"})
public class HAWardJsonDataProvider extends HttpServlet {

    
   
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
         try {

//            DBManager2 db = new DBManager2();
//
//            ResultSet result = db.select("select * from \"HABlock\" order by \"BCode\" ASC;");

            String json = "[{\"id\": 1,\"name\": \"Ward-1\"},{\"id\":2,\"name\": \"Ward-2\"},{\"id\": 3,\"name\": \"Ward-3\"}]";
            response.setContentType("text/plain;charset=UTF-8");
            response.getWriter().write(json.toString());
            
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        }
    }

}
