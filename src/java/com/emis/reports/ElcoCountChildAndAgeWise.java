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

/**
 *
 * @author Helal
 */
@WebServlet(name = "ElcoCountChildAndAgeWise", urlPatterns = {"/ElcoCountChildAndAgeWise"})
public class ElcoCountChildAndAgeWise extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Menu.setMenu("VIEW REPORTS", "ElcoCountChildAndAgeWise", request);
        String view = "WEB-INF/jsp/reports/elcoCountChildAndAgeWise.jsp";
        try {
            if (request.getSession(false).getAttribute("district") != null) {
                if (new UserDao().isPaperless(request.getSession(false).getAttribute("district").toString())) {
                    response.sendRedirect(request.getContextPath() + "/elco-by-acceptor-status");
                } else {
                    request.getRequestDispatcher(view).forward(request, response);
                }
            } else {
                request.getRequestDispatcher(view).forward(request, response);
            }
        } catch (Exception e) {
            request.getRequestDispatcher(view).forward(request, response);
        }
//        request.setAttribute("submenu", "ElcoCountChildAndAgeWise");
//        request.setAttribute("menu", "VIEW REPORTS");
//        request.setAttribute("userLevel", (String) request.getSession(false).getAttribute("userLevel"));
//        RequestDispatcher view = request.getRequestDispatcher("WEB-INF/jsp/reports/elcoCountChildAndAgeWise.jsp");
//        view.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String districtId = request.getParameter("districtId");
        String upazilaId = request.getParameter("upazilaId").length() == 0 ? "%" : request.getParameter("upazilaId");
        String unionId = request.getParameter("unionId").length() == 0 ? "%" : request.getParameter("unionId");
        String fwaUnit = request.getParameter("fwaUnit");
        String provCode = request.getParameter("provCode");
        String month = request.getParameter("month");
        String year = request.getParameter("year");

        try {
            DBManagerDistrict db = new DBManagerDistrict(Integer.parseInt(districtId));
            //DBManager db1 = new DBManager();

            ResultSet result = db.select("SELECT * from public.fn_fwa_child_count_wise_elco_distribution (" + districtId + "," + upazilaId + "," + unionId + "," + fwaUnit + "," + year + "," + provCode + ");");
            JSONArray json = Convertor.convertResultSetIntoJSONWithZero(result);
            //ResultSet result1 = db1.select("SELECT * from public.fn_daily_activity_sheet_bottom_monthly_rpt ("+districtId+","+upazilaId+","+unionId+",'"+fwaUnit+"',"+year+","+month+","+provCode+");");
            //JSONArray json1 = Convertor.convertResultSetIntoJSONWithZero(result1);

            response.setContentType("text/plain;charset=UTF-8");
            //response.getWriter().write("{\"First\":"+json.toString()+",\"Second\":"+json1.toString()+"}");
            response.getWriter().write(json.toString());
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        }
    }

}
