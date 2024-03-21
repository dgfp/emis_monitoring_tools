package com.emis.reports;

import com.emis.utility.Convertor;
import com.emis.utility.Utility;
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
@WebServlet(name = "FpiSuperviseController", urlPatterns = {"/fpi_monitoring_report"})
public class FpiSuperviseController extends HttpServlet {

   
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("submenu", "fpi_monitoring_report");
        request.setAttribute("menu", "VIEW REPORTS");
        RequestDispatcher view = request.getRequestDispatcher("WEB-INF/jsp/reports/fpi_monitoring_report.jsp");
        view.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
       
        
        String divisionId = request.getParameter("divisionId");
        String districtId = request.getParameter("districtId");
        String upazilaId = request.getParameter("upazilaId").length() == 0 ? "0" : request.getParameter("upazilaId");
        String unionId = request.getParameter("unionId").length() == 0 ? "0" : request.getParameter("unionId");
        String startDate = request.getParameter("startDate").length() == 0 ? "01/01/2015" : request.getParameter("startDate");
        String endDate = request.getParameter("endDate").length() == 0 ? Utility.getDateNow() : request.getParameter("endDate");
        
        String query1="select vdate,provname, fpacode,fpaadvance,\n" +
        "case when needitems1='1' and needitems2='1' and needitems3='1' and needitems4='1' and needitems5='1' and needitems6='1' and needitems7='1' and needitems8='1' then 1 else 0 end as sufficientmaterrial ,\n" +
        "b.elcolist , b.totalelco\n" +
        "from fpimonitoring\n" +
        "inner join providerdb on cast(fpimonitoring.fpacode as integer)=providerdb.providerid\n" +
        "inner join (select cast(elcofpi.providerid as character varying) as providerid,count(elco.elcono) as totalelco, string_agg(elco.elcono,', ') as elcolist from elcofpi\n" +
        "inner join elco on elcofpi.healthid=elco.healthid group by 1) as b\n" +
        "on b.providerid=fpimonitoring.userid\n" +
        "where provtype=3\n" +
        "and fpimonitoring.vdate between '"+startDate+"' and '"+endDate+"'";
        
        String query="select * from web_fpi_supervision_report("+divisionId+","+districtId+","+upazilaId+","+unionId+",'"+ Convertor.convertToCustomDateFormat(startDate)+"','"+ Convertor.convertToCustomDateFormat(endDate)+"');";
        
        System.out.println(query);
        
         try {
             
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
