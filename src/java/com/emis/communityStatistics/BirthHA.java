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
 * @author Helal m.helal.k@gmail.com
 */
@WebServlet(name = "BirthHA", urlPatterns = {"/BirthHA"})
public class BirthHA extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("submenu", "birth");
        request.setAttribute("menu", "COMMUNITY STATISTICS");
        request.setAttribute("userLevel", (String) request.getSession(false).getAttribute("userLevel"));
        RequestDispatcher view = request.getRequestDispatcher("WEB-INF/jsp/communityStatistics/birthHa.jsp");
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

            String query = "SELECT  * from public.fn_birth_aggregate_upazila("+districtId+",'"+startDate+"','"+endDate+"');";
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

            String query = "SELECT  * from public.fn_birth_aggregate_union("+districtId+","+upazilaId+",'"+startDate+"','"+endDate+"');";
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

            String query = "SELECT  * from public.fn_birth_aggregate_ward("+districtId+","+upazilaId+","+unionId+",'"+startDate+"','"+endDate+"');";
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

            String query = "SELECT  * from public.fn_birth_aggregate_villagebyward("+districtId+","+upazilaId+","+unionId+","+wardId+",'"+startDate+"','"+endDate+"');";
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

        } else if (action.equals("Individual")) {

            String districtId = request.getParameter("districtId").length() == 0 ? "%" : request.getParameter("districtId");
            String upazilaId = request.getParameter("upazilaId").length() == 0 ? "%" : request.getParameter("upazilaId");
            String unionId = request.getParameter("unionId").length() == 0 ? "%" : request.getParameter("unionId");
            String wardId = request.getParameter("wardId").length() == 0 ? "%" : request.getParameter("wardId");
            String villageId = request.getParameter("villageId").length() == 0 ? "%" : request.getParameter("villageId");
//                if(!villageId.equals("%")){
//                    String village[] = villageId.split(" ");
//                    villageId = village[0]+""+village[1];
//                }
            String startDate = request.getParameter("startDate");
            String endDate = request.getParameter("endDate");
            String query = "SELECT  * from public.fn_birth_individual_ha('"+districtId+"','"+upazilaId+"','"+unionId+"','"+wardId+"','"+villageId+"','"+startDate+"','"+endDate+"');";
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
    }
    
    private String convertToCustomDateFormat(String date) {
        String[] parts = date.split("/");
        String day = parts[0];
        String month = parts[1];
        String year = parts[2];
        return (year+"-"+month+"-"+day);
    }



}
