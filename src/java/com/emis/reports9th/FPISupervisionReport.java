package com.emis.reports9th;

import com.emis.utility.Convertor;
import com.emis.utility.Menu;
import com.emis.utility.Utility;
import com.rhis.db.DBManagerDistrict;
import java.io.IOException;
import java.sql.ResultSet;
import java.text.DateFormat;
import java.text.SimpleDateFormat;  
import java.util.Date;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.temporal.TemporalAdjusters;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.json.JSONArray;

/**
 *
 * @author Helal
 */
@WebServlet(name = "FPISupervisionReport", urlPatterns = {"/fpi-supervision-report"})
public class FPISupervisionReport extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Menu.setMenu("Reports", "fpi-supervision-report", request);
        RequestDispatcher view = request.getRequestDispatcher("WEB-INF/jsp/reports9th/FPISupervisionReport.jsp");
        view.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            HttpSession session = request.getSession();
            String action = request.getParameter("action");
            String divisionId = request.getParameter("divisionId");
            String districtId = request.getParameter("districtId");
            String upazilaId = request.getParameter("upazilaId");
            String unionId = request.getParameter("unionId");
            String fwaUnit = request.getParameter("fwaUnit");
            String provCode = request.getParameter("provCode");
            String reportType = request.getParameter("reportType");
            String month = request.getParameter("month");
            String year = request.getParameter("year");
            String startDate = request.getParameter("startDate");
            String endDate = request.getParameter("endDate");
            
            // monthWise dateWise
            if (reportType.equals("monthWise")) {
                startDate = year + "-" + month + "-01";
                String date = "1/13/2012";
                LocalDate lastDayOfMonth = LocalDate.parse(startDate, DateTimeFormatter.ofPattern("yyyy-M-dd"))
                        .with(TemporalAdjusters.lastDayOfMonth());
                endDate = lastDayOfMonth.toString();//year + "-" + month + "-31";
            }
            if(reportType.equals("dateWise")){
                String oldFormat = "dd/MM/yyyy";
                String newFormat = "yyyy-MM-dd";
                
                SimpleDateFormat sdf = new SimpleDateFormat(oldFormat);
                
                Date d1 = sdf.parse(startDate);
                Date d2 = sdf.parse(endDate);
                
                sdf.applyPattern(newFormat);
                
                startDate = sdf.format(d1);
                endDate = sdf.format(d2);
                
            }
            String query = "select * from web_fpi_supervision_report(" + divisionId + "," + districtId + "," + upazilaId + "," + unionId + "," + fwaUnit + ",'" + startDate + "','" + endDate + "')";

            DBManagerDistrict db = new DBManagerDistrict(Integer.parseInt(districtId));
            ResultSet result = db.select(query);
            JSONArray json = Convertor.convertResultSetIntoJSON(result);
            response.setContentType("text/plain;charset=UTF-8");
            response.getWriter().write(json.toString());
        } catch (Exception ex) {
            ex.printStackTrace();
            response.getWriter().write(ex.getMessage());
        }
    }
}
