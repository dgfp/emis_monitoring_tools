package com.rhis.controllers;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.lang.StringUtils;
/**
 *
 * @author Helal
 */
@WebServlet(name = "DHIS2RequestService", urlPatterns = {"/DHIS2RequestService"})
public class DHIS2RequestService extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        //System.out.println("Requested");

        String dataset = request.getParameter("dataset");
        String orgunit = request.getParameter("orgunit");
        String districtId = request.getParameter("districtId");
        String upazilaId = request.getParameter("upazilaId").length() == 0 ? "%" : request.getParameter("upazilaId");
        String unionId = request.getParameter("unionId").length() == 0 ? "%" : request.getParameter("unionId");
        String month = request.getParameter("month");
        String year = request.getParameter("year");
        
        if(month.length()!=2){
            month="0"+month;
        }
        
        URL url = new URL("http://emis.icddrb.org:8080/emis-dhis2/hareport?dataset="+dataset+"&orgunit="+orgunit+"&zilla="+districtId+"&upz="+upazilaId+"&un="+unionId+"&year="+year+"&month="+month);
        System.out.println("http://emis.icddrb.org:8080/emis-dhis2/hareport?dataset="+dataset+"&orgunit="+orgunit+"&zilla="+districtId+"&upz="+upazilaId+"&un="+unionId+"&year="+year+"&month="+month);
        
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        conn.setRequestProperty("Accept", "application/json");

        
        if (conn.getResponseCode() != 200) {
         throw new RuntimeException("Failed : HTTP error code : "
           + conn.getResponseCode());
        }else{
            conn.getResponseCode();
            
            System.out.println(conn.getResponseCode());
        }
        
        response.getWriter().write(conn.getResponseCode());
        
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }


}
