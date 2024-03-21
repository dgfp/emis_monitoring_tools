package com.emis.management;

import com.emis.utility.Convertor;
import com.rhis.db.DBManagerDistrict;
import java.io.IOException;
import java.sql.ResultSet;
import javax.servlet.RequestDispatcher;
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
@WebServlet(name = "ProviderActivityMonitoring", urlPatterns = {"/ProviderActivityMonitoring"})
public class ProviderActivityMonitoring extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            request.setAttribute("submenu", "ProviderActivityMonitoring");
            request.setAttribute("menu", "COMMUNITY STATISTICS");
        
            RequestDispatcher view = request.getRequestDispatcher("WEB-INF/jsp/management/providerActivityMonitoring.jsp");
            view.forward(request, response);
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        String districtId = request.getParameter("districtId");
        String upazilaId = request.getParameter("upazilaId").length() == 0 ? "%" : request.getParameter("upazilaId");
        String unionId = request.getParameter("unionId").length() == 0 ? "%" : request.getParameter("unionId");
        String providerCode = request.getParameter("providerCode").length() == 0 ? "%" : request.getParameter("providerCode");
        String startDate=request.getParameter("startDate").length() == 0 ? "%" : request.getParameter("startDate");
        String endDate=request.getParameter("endDate").length() == 0 ? "%" : request.getParameter("endDate");
        
        if (action.equals("FWA")) {
            String query1="SELECT  * from public.fn_provider_activity_monitoring_fwa('"+districtId+"','"+upazilaId+"','"+unionId+"','"+providerCode+"','"+startDate+"','"+endDate+"');";
            String query2  = "select * from provider_activity_monitoring_temp_fwa order by upazilaid, unionid, provtype, provider_name;";
//                String query2  = "select * from provider_activity_monitoring_temp_fwa";
            try {

                DBManagerDistrict db = new DBManagerDistrict(Integer.parseInt(districtId));
                ResultSet result = db.selectDouble(query1, query2);
                
                JSONArray json = Convertor.convertResultSetIntoJSONWithDash(result);
                
                response.setContentType("text/plain;charset=UTF-8");
                System.out.println(json.toString());
                
                response.getWriter().write(json.toString());

            } catch (Exception ex) {
                ex.getMessage();
            }
        }
        
        if (action.equals("HA")) {
            String query1="SELECT  * from public.fn_provider_activity_monitoring_ha('"+districtId+"','"+upazilaId+"','"+unionId+"','"+providerCode+"','"+startDate+"','"+endDate+"');";
            String query2  = "select * from provider_activity_monitoring_temp_ha order by upazilaid, unionid, provtype, provider_name;";
            try {

                DBManagerDistrict db = new DBManagerDistrict(Integer.parseInt(districtId));
                ResultSet result = db.selectDouble(query1, query2);
                
                JSONArray json = Convertor.convertResultSetIntoJSONWithDash(result);
                
                response.setContentType("text/plain;charset=UTF-8");
                System.out.println(json.toString());
                
                response.getWriter().write(json.toString());

            } catch (Exception ex) {
                ex.getMessage();
            }
        }
        
    }
}
