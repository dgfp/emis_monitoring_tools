package com.emis.utility;

import com.rhis.db.DBManagerDistrict;
import com.rhis.db.DBManagerMonitoring;
import java.io.IOException;
import java.io.PrintWriter;
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
@WebServlet(name = "SQL", urlPatterns = {"/sql"})
public class SQL extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String sql = "";
        
         System.out.println("Hello World");

        try {
            //DBManagerMonitoring db = new DBManagerDistrict();
            ResultSet rs = new DBManagerDistrict().select("SELECT zillaid FROM public.host_address;");
            
            PrintWriter out = response.getWriter();
            
            
            
            while (rs.next()) {
                System.out.println(rs.getInt("zillaid"));
                //response.getWriter(rs.getInt("zillaid"));
            }
            
            System.out.println("Hello World");
            

        } catch (Exception ex) {
            
            ex.getMessage();
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }
    
    private Boolean executeSQL(String sql){
        
        return false;
    }

}
