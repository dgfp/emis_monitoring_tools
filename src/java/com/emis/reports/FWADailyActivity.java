package com.emis.reports;

import com.emis.utility.Convertor;
import com.rhis.db.DBManagerDistrict;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
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
@WebServlet(name = "FWADailyActivity", urlPatterns = {"/fwaDailyActivity"})
public class FWADailyActivity extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.sendRedirect(request.getContextPath() + "/ProviderActivityMonitoring");

        request.setAttribute("submenu", "fwaDailyActivity");
        request.setAttribute("menu", "VIEW REPORTS");

        request.setAttribute("userLevel", (String) request.getSession(false).getAttribute("userLevel"));
        RequestDispatcher view = request.getRequestDispatcher("WEB-INF/jsp/reports/fwaDailyActivity.jsp");
        view.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Connection connection = null;
        String districtId = request.getParameter("districtId");
        String upazilaId = request.getParameter("upazilaId");
        String unionId = request.getParameter("unionId");
        String startDate = request.getParameter("startDate");
        String endDate = request.getParameter("endDate");

        if (districtId != "" || upazilaId != "" || unionId != "" || startDate != "" || endDate != "") {

            try {
                DBManagerDistrict db = new DBManagerDistrict(Integer.parseInt(districtId));
                connection = db.openConnection();
                String sql = "select * from public.fn_fwa_daily_activity(?,?,?,?,?);";
                System.out.println("SQL: select * from public.fn_fwa_daily_activity(" + districtId + "," + upazilaId + "," + unionId + ",'" + startDate + "','" + endDate + "');");

                PreparedStatement preparedStatement = connection.prepareStatement(sql);
                preparedStatement.setInt(1, Integer.parseInt(districtId));
                preparedStatement.setInt(2, Integer.parseInt(upazilaId));
                preparedStatement.setInt(3, Integer.parseInt(unionId));
                preparedStatement.setString(4, startDate);
                preparedStatement.setString(5, endDate);
                ResultSet result = preparedStatement.executeQuery();
                JSONArray json = Convertor.convertResultSetIntoJSONEPI(result);

                connection.close();
                response.setContentType("text/plain;charset=UTF-8");
                response.getWriter().write(json.toString());
            } catch (Exception ex) {
                System.out.println(ex.getMessage());
            }

        } else {
            response.setContentType("text/plain;charset=UTF-8");
            response.getWriter().write("");
        }
    }

    private String convertToCustomDateFormat(String date) {
        String[] parts = date.split("/");
        String day = parts[0];
        String month = parts[1];
        String year = parts[2];
        return (year + "-" + month + "-" + day);
    }

}
