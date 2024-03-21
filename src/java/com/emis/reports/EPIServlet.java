
package com.emis.reports;

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
 * @author shahaz
 */
@WebServlet(name = "EPIServlet", urlPatterns = {"/epi_report"})
public class EPIServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        request.setAttribute("submenu", "epi_report");
        request.setAttribute("menu", "VIEW REPORTS");
        request.setAttribute("userLevel", (String) request.getSession(false).getAttribute("userLevel"));
        RequestDispatcher view = request.getRequestDispatcher("WEB-INF/jsp/reports/epi_report.jsp");
        view.forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        String districtId = request.getParameter("districtId");
        String upazilaId = request.getParameter("upazilaId");
        String unionId = request.getParameter("unionId");
        String wardId = request.getParameter("wardId");
        String subblockId = request.getParameter("subblockId");
        String scheduleDate = request.getParameter("scheduleDate");
        String centerName = request.getParameter("centerName");
        
        try {
            DBManagerDistrict db = new DBManagerDistrict(Integer.parseInt(districtId));
            ResultSet result = db.select("select * from fn_epi_child_daily ("+districtId+","+upazilaId+","+unionId+",'"+wardId+"','"+subblockId+"','"+centerName+"','"+scheduleDate+"');");
            //ResultSet result = db.select("select * from fn_epi_child_daily (93,66,87,'2','01','প.প. কেন্দ্র (ডোহাতলী)','2017-01-22');");
            JSONArray json = Convertor.convertResultSetIntoJSONEPI(result);
            response.setContentType("text/plain;charset=UTF-8");
            response.getWriter().write(json.toString());
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        }
        
    }
}
