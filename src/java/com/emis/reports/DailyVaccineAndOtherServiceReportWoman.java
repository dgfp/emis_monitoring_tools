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
 * @author Nil_27
 */
@WebServlet(name = "DailyVaccineAndOtherServiceReport", urlPatterns = {"/daily_vaccine_and_other_service_report_woman"})
public class DailyVaccineAndOtherServiceReportWoman extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("submenu", "daily_vaccine_and_other_service_report_woman");
        request.setAttribute("menu", "VIEW REPORTS");
        request.setAttribute("userLevel", (String) request.getSession(false).getAttribute("userLevel"));
        RequestDispatcher view = request.getRequestDispatcher("WEB-INF/jsp/reports/daily_vaccine_and_other_service_report_woman.jsp");
        view.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
            String districtId = request.getParameter("districtId");
            String upazilaId = request.getParameter("upazilaId");
            String unionId = request.getParameter("unionId");
            String wardId = request.getParameter("wardId");
            String subblockId = request.getParameter("subblockId");
            String scheduleDate = request.getParameter("scheduleDate");
            String centerName = request.getParameter("centerName");

            try {
                DBManagerDistrict db = new DBManagerDistrict(Integer.parseInt(districtId));
                ResultSet result = db.select("select * from fn_epi_woman_daily ("+districtId+","+upazilaId+","+unionId+",'"+wardId+"','"+subblockId+"','"+centerName+"','"+scheduleDate+"');");
                //ResultSet result = db.select("select * from fn_epi_child_daily (93,66,87,'2','01','প.প. কেন্দ্র (ডোহাতলী)','2017-01-22');");
                //ResultSet result = db.select("select * from fn_epi_child_daily  (93,66,87,'2','07','বেলাল মাস্টার (ডৌহাতলী)','2017-01-22');");
                JSONArray json = Convertor.convertResultSetIntoJSONEPI(result);
                response.setContentType("text/plain;charset=UTF-8");
                response.getWriter().write(json.toString());
            } catch (Exception ex) {
                System.out.println(ex.getMessage());
            }
        
        
        
        
        
            /*Connection connection=null;
            String districtId = request.getParameter("districtId");
            String upazilaId = request.getParameter("upazilaId");
            String unionId = request.getParameter("unionId");
            String wardId = request.getParameter("wardId");
            String subblockId = request.getParameter("subblockId");
            String scheduleDate = request.getParameter("scheduleDate");
            String centerName = request.getParameter("centerName");

            if(districtId!="" || upazilaId!="" || unionId!="" || wardId!="" || subblockId!="" || scheduleDate!="" || centerName!=""){

                try {
                    DBManagerDistrict db = new DBManagerDistrict(Integer.parseInt(districtId));
                    connection=db.openConnection();
                    String sql = "select * from fn_epi_woman_daily (?,?,?,?,?,?,?);";
                    //select * from fn_epi_woman_daily (93,66,87,'2','01','প.প. কেন্দ্র (ডোহাতলী)','2017-01-22');
                    System.out.println("select * from fn_epi_woman_daily ("+districtId+","+upazilaId+","+unionId+",'"+wardId+"','"+subblockId+"','"+centerName+"','"+scheduleDate+"');");
                    
                    PreparedStatement preparedStatement = connection.prepareStatement(sql);
                    preparedStatement.setInt(1, Integer.parseInt(districtId));
                    preparedStatement.setInt(2, Integer.parseInt(upazilaId));
                    preparedStatement.setInt(3, Integer.parseInt(unionId));
                    preparedStatement.setString(4, wardId);
                    preparedStatement.setString(5, subblockId);
                    preparedStatement.setString(6, centerName);
                    preparedStatement.setString(7, scheduleDate);
                    
                    
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
            }*/
        
    }


}
