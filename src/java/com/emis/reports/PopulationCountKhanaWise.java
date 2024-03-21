package com.emis.reports;

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

@WebServlet(name = "PopulationCountKhanaWise", urlPatterns = {"/populationCountKhanaWise"})
public class PopulationCountKhanaWise extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

//        request.setAttribute("submenu", "populationCountKhanaWise");
//        request.setAttribute("menu", "VIEW REPORTS");
//        request.setAttribute("userLevel", (String) request.getSession(false).getAttribute("userLevel"));
//        RequestDispatcher view = request.getRequestDispatcher("WEB-INF/jsp/reports/populationCountKhanaWise.jsp");
//        view.forward(request, response);

        Menu.setMenu("VIEW REPORTS", "populationCountKhanaWise", request);
        String view = "WEB-INF/jsp/reports/populationCountKhanaWise.jsp";
        try {
            if (request.getSession(false).getAttribute("district") != null) {
                if (new UserDao().isPaperless(request.getSession(false).getAttribute("district").toString())) {
                    response.sendRedirect(request.getContextPath() + "/household-wise-population");
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
        String districtId = request.getParameter("districtId");
        String upazilaId = request.getParameter("upazilaId").length() == 0 ? "%" : request.getParameter("upazilaId");
        String unionId = request.getParameter("unionId").length() == 0 ? "%" : request.getParameter("unionId");
        String fwaUnit = request.getParameter("fwaUnit");
        String provCode = request.getParameter("provCode");
        String year = request.getParameter("year");

        try {
            DBManagerDistrict db = new DBManagerDistrict(Integer.parseInt(districtId));
            DBManagerDistrict db1 = new DBManagerDistrict(Integer.parseInt(districtId));
            DBManagerDistrict db2 = new DBManagerDistrict(Integer.parseInt(districtId));

            ResultSet resultYear = db.select("SELECT distinct r_year from public.fn_fwa_household_wise_population_sheet (" + districtId + "," + upazilaId + "," + unionId + ",'" + fwaUnit + "'," + year + "," + provCode + ") order by r_year asc;");
            JSONArray jsonYear = Convertor.convertResultSetIntoJSONWithZero(resultYear);

            ResultSet resultHouseholdHeadName = db1.select("SELECT distinct r_household_head_name from public.fn_fwa_household_wise_population_sheet (" + districtId + "," + upazilaId + "," + unionId + ",'" + fwaUnit + "'," + year + "," + provCode + ");");
            JSONArray jsonHouseholdHeadName = Convertor.convertResultSetIntoJSONWithZero(resultHouseholdHeadName);

            ResultSet resultMain = db2.select("SELECT * from public.fn_fwa_household_wise_population_sheet (" + districtId + "," + upazilaId + "," + unionId + ",'" + fwaUnit + "'," + year + "," + provCode + ");");
            JSONArray jsonMain = Convertor.convertResultSetIntoJSONWithZero(resultMain);

            response.setContentType("text/plain;charset=UTF-8");
            response.getWriter().write("{\"Year\":" + jsonYear.toString() + ",\"HouseholdHeadName\":" + jsonHouseholdHeadName.toString() + ",\"Population\":" + jsonMain.toString() + "}");
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        }
    }

}
