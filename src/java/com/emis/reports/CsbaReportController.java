
package com.emis.reports;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.URL;
import java.net.URLConnection;
import java.util.Base64;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Nil_27
 */
@WebServlet(name = "CsbaReportController", urlPatterns = {"/csba_report"})
public class CsbaReportController extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("submenu", "csba_report");
        request.setAttribute("menu", "VIEW REPORTS");
        RequestDispatcher view = request.getRequestDispatcher("WEB-INF/jsp/reports/csba_report.jsp");
        view.forward(request, response);
    }

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String districtId = request.getParameter("districtId");
        String upazilaId = request.getParameter("upazilaId").length() == 0 ? "%" : request.getParameter("upazilaId");
        String unionId = request.getParameter("unionId").length() == 0 ? "%" : request.getParameter("unionId");
        String providerCode = request.getParameter("providerCode");
        String date = request.getParameter("date");
        String[] dates = date.split("~"); //dates[0];
        
        
        String jsonObject=null;
        String str = "providerId="+providerCode+"&password=123&report1_zilla="+districtId+"&report1_upazila="+upazilaId+"&report1_union="+unionId+"&report1_start_date="+dates[0]+"&report1_end_date="+dates[1];
        Base64.Encoder enc= Base64.getEncoder();
        byte[] strenc =enc.encode(str.getBytes("UTF-8"));
        String url="http://mamoni.net:8080/rhis_fwc_monitoring/mis3report?"+new String(strenc,"UTF-8");
        System.out.println("URL: " + url);

        //Encode String as Base64
        URL getUrl = new URL(url);
        URLConnection con = getUrl.openConnection();
        BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream(),"UTF-8"));
        StringBuilder res = new StringBuilder(); // or StringBuffer if Java version 5+
        String line;
        while ((line = in.readLine()) != null) {
            res.append(line);
            res.append('\r');
        }
        in.close();
        
        response.setContentType("text/html;charset=UTF-8");
        String s = res.toString();
        response.getWriter().write(s);

        
    }

   
}
