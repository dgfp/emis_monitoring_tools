package com.emis.communityStatistics;

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
@WebServlet(name = "DeathHA", urlPatterns = {"/deathHA"})
public class DeathHA extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("submenu", "death");
        request.setAttribute("menu", "COMMUNITY STATISTICS");
        request.setAttribute("userLevel", (String) request.getSession(false).getAttribute("userLevel"));
        RequestDispatcher view = request.getRequestDispatcher("WEB-INF/jsp/communityStatistics/deathHA.jsp");
        view.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            String action = request.getParameter("action");
        
            if (action.equals("AggregateUpazila")) {
                String districtId = request.getParameter("districtId").length() == 0 ? "%" : request.getParameter("districtId");
                String startDate = convertToCustomDateFormat(request.getParameter("startDate"));
                String endDate = convertToCustomDateFormat(request.getParameter("endDate"));
                
                String query = "SELECT  * from public.fn_death_aggregate_upazila("+districtId+",'"+startDate+"','"+endDate+"');";
                try {
                    System.out.println(query);
                    DBManagerDistrict db = new DBManagerDistrict(Integer.parseInt(districtId));
                    ResultSet result = db.select(query);
                    JSONArray json = Convertor.convertResultSetIntoJSON(result);
                    response.setContentType("text/plain;charset=UTF-8");
                    System.out.println(json.toString());
                    response.getWriter().write(json.toString());
                } catch (Exception ex) {
                    ex.getMessage();
                }
                
            }else if (action.equals("AggregateUnion")) {
                String districtId = request.getParameter("districtId").length() == 0 ? "%" : request.getParameter("districtId");
                String upazilaId = request.getParameter("upazilaId").length() == 0 ? "%" : request.getParameter("upazilaId");
                String startDate = convertToCustomDateFormat(request.getParameter("startDate"));
                String endDate = convertToCustomDateFormat(request.getParameter("endDate"));

                String query = "SELECT  * from public.fn_death_aggregate_union("+districtId+","+upazilaId+",'"+startDate+"','"+endDate+"');";
                try {
                    System.out.println(query);
                    DBManagerDistrict db = new DBManagerDistrict(Integer.parseInt(districtId));
                    ResultSet result = db.select(query);
                    JSONArray json = Convertor.convertResultSetIntoJSON(result);
                    response.setContentType("text/plain;charset=UTF-8");
                    System.out.println(json.toString());
                    response.getWriter().write(json.toString());
                } catch (Exception ex) {
                    ex.getMessage();
                }
                
            }else if (action.equals("AggregateWard")) {
                String districtId = request.getParameter("districtId").length() == 0 ? "%" : request.getParameter("districtId");
                String upazilaId = request.getParameter("upazilaId").length() == 0 ? "%" : request.getParameter("upazilaId");  
                String unionId = request.getParameter("unionId").length() == 0 ? "%" : request.getParameter("unionId");
                String startDate = convertToCustomDateFormat(request.getParameter("startDate"));
                String endDate = convertToCustomDateFormat(request.getParameter("endDate"));
                String query = "SELECT  * from public.fn_death_aggregate_ward("+districtId+","+upazilaId+","+unionId+",'"+startDate+"','"+endDate+"');";
                try {
                    System.out.println(query);
                    DBManagerDistrict db = new DBManagerDistrict(Integer.parseInt(districtId));
                    ResultSet result = db.select(query);
                    JSONArray json = Convertor.convertResultSetIntoJSON(result);
                    response.setContentType("text/plain;charset=UTF-8");
                    System.out.println(json.toString());
                    response.getWriter().write(json.toString());
                } catch (Exception ex) {
                    ex.getMessage();
                }
                
            }else if (action.equals("AggregateVillage")) {
                String districtId = request.getParameter("districtId").length() == 0 ? "%" : request.getParameter("districtId");
                String upazilaId = request.getParameter("upazilaId").length() == 0 ? "%" : request.getParameter("upazilaId");  
                String unionId = request.getParameter("unionId").length() == 0 ? "%" : request.getParameter("unionId");
                String wardId = request.getParameter("wardId").length() == 0 ? "%" : request.getParameter("wardId");
                String startDate = convertToCustomDateFormat(request.getParameter("startDate"));
                String endDate = convertToCustomDateFormat(request.getParameter("endDate"));
                String query = "SELECT  * from public.fn_death_aggregate_villagebyward("+districtId+","+upazilaId+","+unionId+","+wardId+",'"+startDate+"','"+endDate+"');";
                try {
                    System.out.println(query);
                    DBManagerDistrict db = new DBManagerDistrict(Integer.parseInt(districtId));
                    ResultSet result = db.select(query);
                    JSONArray json = Convertor.convertResultSetIntoJSON(result);
                    response.setContentType("text/plain;charset=UTF-8");
                    System.out.println(json.toString());
                    response.getWriter().write(json.toString());
                } catch (Exception ex) {
                    ex.getMessage();
                }
                
            }else if (action.equals("Individual")) {
                String districtId = request.getParameter("districtId").length() == 0 ? "%" : request.getParameter("districtId");
                String upazilaId = request.getParameter("upazilaId").length() == 0 ? "%" : request.getParameter("upazilaId");
                String unionId = request.getParameter("unionId").length() == 0 ||  request.getParameter("unionId").toString()== "0"? "%" : request.getParameter("unionId");
                String wardId = request.getParameter("wardId").length() == 0 ? "%" : request.getParameter("wardId");
                String villageId = request.getParameter("villageId").length() == 0 ? "%" : request.getParameter("villageId");
                String startDate = request.getParameter("startDate");
                String endDate = request.getParameter("endDate");
                //SELECT  * from public.fn_death_individual_h('93','66','%','%','%','01/01/2014','04/01/2018');
                //String query = "SELECT  * from public.fn_death_individual_fp('"+districtId+"','"+upazilaId+"','"+unionId+"','"+unitId+"','"+villageId+"','"+startDate+"','"+endDate+"');";
                String query = "SELECT  * from public.fn_death_individual_h('"+districtId+"','"+upazilaId+"','"+unionId+"','"+wardId+"','"+villageId+"','"+startDate+"','"+endDate+"');";
                
                try {
                    System.out.println(query);
                    DBManagerDistrict db = new DBManagerDistrict(Integer.parseInt(districtId));
                    ResultSet result = db.select(query);
                    JSONArray json = Convertor.convertResultSetIntoJSON(result);
                    response.setContentType("text/plain;charset=UTF-8");
                    System.out.println(json.toString());
                    response.getWriter().write(json.toString());
                } catch (Exception ex) {
                    ex.getMessage();
                }
            
            }
            
//        String districtId = request.getParameter("districtId");
//        String upazilaId = request.getParameter("upazilaId").length() == 0 ? "%" : request.getParameter("upazilaId");
//        String unionId = request.getParameter("unionId").length() == 0 ? "%" : request.getParameter("unionId");
//        String villageId = request.getParameter("villageId").length() == 0 ? "%" : request.getParameter("villageId");
//        String startDate = convertToCustomDateFormat(request.getParameter("startDate"));
//        String endDate = convertToCustomDateFormat(request.getParameter("endDate"));
//        String query = "SELECT  * from public.fn_death_list('"+districtId+"','"+upazilaId+"','"+unionId+"','"+villageId+"','"+startDate+"','"+endDate+"');";
//        try {
//            System.out.println(query);
//            DBManager db = new DBManager();
//            ResultSet result = db.select(query);
//            JSONArray json = Convertor.convertResultSetIntoJSON(result);
//            response.setContentType("text/plain;charset=UTF-8");
//            System.out.println(json.toString());
//            response.getWriter().write(json.toString());
//        } catch (Exception ex) {
//            ex.getMessage();
//        }
    }
    
    
    private String convertToCustomDateFormat(String date) {
        String[] parts = date.split("/");
        String day = parts[0];
        String month = parts[1];
        String year = parts[2];
        return (year+"-"+month+"-"+day);
    }
   
}
