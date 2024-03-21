package com.emis.communityStatistics;

import com.emis.dao.UserDao;
import com.emis.utility.Convertor;
import com.emis.utility.Menu;
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
@WebServlet(name = "Death", urlPatterns = {"/death"})
public class Death extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        int cat=Integer.parseInt(request.getSession(false).getAttribute("category").toString());
//        String jsp="WEB-INF/jsp/communityStatistics/deathUpdated.jsp";
//        
//        request.setAttribute("submenu", "death");
//        request.setAttribute("menu", "COMMUNITY STATISTICS");
//        request.setAttribute("userLevel", (String) request.getSession(false).getAttribute("userLevel"));
//        if(cat==2){ //cat 2 means this report for load Health related user
//            jsp="WEB-INF/jsp/communityStatistics/deathHA.jsp";
//        }
//        RequestDispatcher view = request.getRequestDispatcher(""+jsp);
//        view.forward(request, response);

        Menu.setMenu("COMMUNITY STATISTICS", "death", request);
        request.setAttribute("userLevel", (String) request.getSession(false).getAttribute("userLevel"));
        String view = "WEB-INF/jsp/communityStatistics/deathUpdated.jsp";
        try {
            if (request.getSession(false).getAttribute("district") != null) {
                if (new UserDao().isPaperless(request.getSession(false).getAttribute("district").toString())) {
                    response.sendRedirect(request.getContextPath() + "/death-notification");
                } else {
                    request.getRequestDispatcher(view).forward(request, response);
                }
            } else {
                request.getRequestDispatcher(view).forward(request, response);
            }
        } catch (Exception e) {
            request.getRequestDispatcher(view).forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action.equals("AggregateUpazila")) {
            String districtId = request.getParameter("districtId").length() == 0 ? "%" : request.getParameter("districtId");
            String startDate = convertToCustomDateFormat(request.getParameter("startDate"));
            String endDate = convertToCustomDateFormat(request.getParameter("endDate"));

            String query = "SELECT  * from public.fn_death_aggregate_upazila(" + districtId + ",'" + startDate + "','" + endDate + "');";
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

        } else if (action.equals("AggregateUnion")) {
            String districtId = request.getParameter("districtId").length() == 0 ? "%" : request.getParameter("districtId");
            String upazilaId = request.getParameter("upazilaId").length() == 0 ? "%" : request.getParameter("upazilaId");
            String startDate = convertToCustomDateFormat(request.getParameter("startDate"));
            String endDate = convertToCustomDateFormat(request.getParameter("endDate"));

            String query = "SELECT  * from public.fn_death_aggregate_union(" + districtId + "," + upazilaId + ",'" + startDate + "','" + endDate + "');";
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

        } else if (action.equals("AggregateUnit")) {
            String districtId = request.getParameter("districtId").length() == 0 ? "%" : request.getParameter("districtId");
            String upazilaId = request.getParameter("upazilaId").length() == 0 ? "%" : request.getParameter("upazilaId");
            String unionId = request.getParameter("unionId").length() == 0 ? "%" : request.getParameter("unionId");
            String startDate = convertToCustomDateFormat(request.getParameter("startDate"));
            String endDate = convertToCustomDateFormat(request.getParameter("endDate"));

            String query = "SELECT  * from public.fn_death_aggregate_unit(" + districtId + "," + upazilaId + "," + unionId + ",'" + startDate + "','" + endDate + "');";
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

        } else if (action.equals("AggregateVillage")) {
            String districtId = request.getParameter("districtId").length() == 0 ? "%" : request.getParameter("districtId");
            String upazilaId = request.getParameter("upazilaId").length() == 0 ? "%" : request.getParameter("upazilaId");
            String unionId = request.getParameter("unionId").length() == 0 ? "%" : request.getParameter("unionId");
            String unitId = request.getParameter("unitId").length() == 0 ? "%" : request.getParameter("unitId");
            String startDate = convertToCustomDateFormat(request.getParameter("startDate"));
            String endDate = convertToCustomDateFormat(request.getParameter("endDate"));

            String query = "SELECT  * from public.fn_death_aggregate_village(" + districtId + "," + upazilaId + "," + unionId + "," + unitId + ",'" + startDate + "','" + endDate + "');";
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
            String unionId = request.getParameter("unionId").length() == 0 || request.getParameter("unionId").toString() == "0" ? "%" : request.getParameter("unionId");
            String unitId = request.getParameter("unitId").length() == 0 ? "%" : request.getParameter("unitId");
            String villageId = request.getParameter("villageId").length() == 0 ? "%" : request.getParameter("villageId");
            String startDate = request.getParameter("startDate");
            String endDate = request.getParameter("endDate");
            String query = "SELECT  * from public.fn_death_individual_fp('" + districtId + "','" + upazilaId + "','" + unionId + "','" + unitId + "','" + villageId + "','" + startDate + "','" + endDate + "');";
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
        return (year + "-" + month + "-" + day);
    }
}
