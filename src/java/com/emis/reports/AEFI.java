package com.emis.reports;

import com.emis.utility.Convertor;
import com.rhis.db.DBManagerDistrict;
import java.io.IOException;
import java.io.PrintWriter;
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
 * @author Administrator
 */
@WebServlet(name = "AEFI", urlPatterns = {"/AEFI"})
public class AEFI extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("submenu", "AEFI");
        request.setAttribute("menu", "VIEW REPORTS");
        RequestDispatcher view = request.getRequestDispatcher("WEB-INF/jsp/reports/aefi.jsp");
        view.forward(request, response);
    }

@Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
            Connection connection=null;
            String districtId = request.getParameter("districtId");
            String upazilaId = request.getParameter("upazilaId");
            String unionId = request.getParameter("unionId");
            String startDate = request.getParameter("startDate");
            String endDate = request.getParameter("endDate");

            if(districtId!="" || upazilaId!="" || unionId!="" || startDate!="" || endDate!=""){

                try {
                    DBManagerDistrict db = new DBManagerDistrict(Integer.parseInt(districtId));
                    connection=db.openConnection();
                    String sql = "select * from public.fn_AEFI_individual_village(?,?,?,?,?);";
                    System.out.println("SQL: select * from public.fn_AEFI_individual_village("+districtId+","+upazilaId+","+unionId+",'"+convertToCustomDateFormat(startDate)+"','"+convertToCustomDateFormat(endDate)+"');");
                    
                    PreparedStatement preparedStatement = connection.prepareStatement(sql);
                    preparedStatement.setInt(1, Integer.parseInt(districtId));
                    preparedStatement.setInt(2, Integer.parseInt(upazilaId));
                    preparedStatement.setInt(3, Integer.parseInt(unionId));
                    preparedStatement.setString(4, convertToCustomDateFormat(startDate));
                    preparedStatement.setString(5, convertToCustomDateFormat(endDate));
                    ResultSet result = preparedStatement.executeQuery();
                    JSONArray json = Convertor.convertResultSetIntoJSONEPI(result);

                    connection.close();
                    response.setContentType("text/plain;charset=UTF-8");
                    response.getWriter().write(json.toString());


                } catch (Exception ex) {
                    System.out.println(ex.getMessage());
                }

            } else{
                response.setContentType("text/plain;charset=UTF-8");
                response.getWriter().write("");
            }
    }
    
    private String convertToCustomDateFormat(String date) {
        return date.replaceAll("(\\d+)/(\\d+)/(\\d+)","$3-$2-$1");
    }

}
