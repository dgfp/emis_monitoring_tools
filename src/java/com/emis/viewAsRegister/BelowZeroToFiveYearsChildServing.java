package com.emis.viewAsRegister;

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
 * @author RHIS082
 */
@WebServlet(name = "BelowZeroToFiveYearsChildServing", urlPatterns = {"/BelowZeroToFiveYearsChildServing"})
public class BelowZeroToFiveYearsChildServing extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("submenu", "BelowZeroToFiveYearsChildServing");
        request.setAttribute("menu", "VIEW AS REGISTER");
        RequestDispatcher view = request.getRequestDispatcher("WEB-INF/jsp/viewAsRegister/BelowZeroToFiveYearsChildServing.jsp");
        view.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        Connection connection = null;
        String divisionId = request.getParameter("divisionId");
        String districtId = request.getParameter("districtId");
        String upazilaId = request.getParameter("upazilaId").length() == 0 ? "%" : request.getParameter("upazilaId");
        String unionId = request.getParameter("unionId").length() == 0 ? "%" : request.getParameter("unionId");
        String unitId = request.getParameter("unitId").length() == 0 ? "%" : request.getParameter("unitId");
        String startDate = request.getParameter("startDate");
        String endDate = request.getParameter("endDate");
        String resultJson = "[{\"status\": \"error\",\"message\": \"Somthing went wrong\"}]";
        if (districtId != "" || upazilaId != "" || unionId != "" || unitId != "") {
            try {
                DBManagerDistrict db = new DBManagerDistrict(Integer.parseInt(districtId));
                connection = db.openConnection();
                String sql = "select * from web_below_zero_to_five_years_child_serving(?,?,?,?,?,?,?)";
                System.out.println("SQL: select * from web_below_zero_to_five_years_child_serving(" + divisionId + "," + districtId + ",'" + upazilaId + "','" + unionId + "','" + unitId + "','" + startDate + "','" + endDate + "')");

                PreparedStatement preparedStatement = connection.prepareStatement(sql);
                preparedStatement.setInt(1, Integer.parseInt(divisionId));
                preparedStatement.setInt(2, Integer.parseInt(districtId));
                preparedStatement.setString(3, upazilaId);
                preparedStatement.setString(4, unionId);
                preparedStatement.setString(5, unitId);
                preparedStatement.setString(6, startDate);
                preparedStatement.setString(7, endDate);
                ResultSet result = preparedStatement.executeQuery();
                JSONArray json = Convertor.convertResultSetIntoJSONEPI(result);

                connection.close();
                response.setContentType("text/plain;charset=UTF-8");
                response.getWriter().write("{\"status\": \"success\",\"data\": "+json.toString()+",\"message\": \"Return success\"}");

            } catch (Exception ex) {
                response.setContentType("text/plain;charset=UTF-8");
                response.getWriter().write("{\"status\": \"error\",\"data\":null,\"message\": \"Somthing went wrong\"}");
                System.out.println("Error: "+ex.getMessage());
            }

        } else {
            response.setContentType("text/plain;charset=UTF-8");
            response.getWriter().write("{\"status\": \"error\",\"data\":null,\"message\": \"Please fill required field\"}");
        }
    }
}
