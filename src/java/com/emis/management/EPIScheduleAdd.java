package com.emis.management;

import com.emis.utility.Convertor;
import com.rhis.db.DBManagerDistrict;
import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.JSONArray;
/**
 *
 * @author ccah
 */
@WebServlet(name = "EPIScheduleAdd", urlPatterns = {"/epi_schedule_add"})
public class EPIScheduleAdd extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("submenu", "schedule_epi_settings");
        request.setAttribute("menu", "MANAGEMENT");
        RequestDispatcher dispatcher = request.getRequestDispatcher("WEB-INF/jsp/management/epi_schedule_add.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        String query = "";
        String divisionId = request.getParameter("divisionId");
        String districtId = request.getParameter("districtId");
        String upazilaId = request.getParameter("upazilaId");
        String unionId = request.getParameter("unionId");
        String wardId = request.getParameter("wardId");
        String subblockId = request.getParameter("subblockId");
        String year = request.getParameter("year");

        if (action.equalsIgnoreCase("addScheduleData")) {

            DBManagerDistrict db2 = new DBManagerDistrict(Integer.parseInt(districtId));

            String centerName = request.getParameter("centerName");
            String centerType = request.getParameter("centerType");
            String khanaFrom = request.getParameter("khanaFrom");
            String khanaTo = request.getParameter("khanaTo");
	

            String scheduleDateJanuary = request.getParameter("scheduleDateJanuary");
            String scheduleDateFebruary = request.getParameter("scheduleDateFebruary");
            String scheduleDateMarch = request.getParameter("scheduleDateMarch");
            String scheduleDateApril = request.getParameter("scheduleDateApril");
            String scheduleDateMay = request.getParameter("scheduleDateMay");
            String scheduleDateJune = request.getParameter("scheduleDateJune");
            String scheduleDateJuly = request.getParameter("scheduleDateJuly");
            String scheduleDateAugust = request.getParameter("scheduleDateAugust");
            String scheduleDateSeptember = request.getParameter("scheduleDateSeptember");
            String scheduleDateOctober = request.getParameter("scheduleDateOctober");
            String scheduleDateNovember = request.getParameter("scheduleDateNovember");
            String scheduleDateDecember = request.getParameter("scheduleDateDecember");
	
            String dateArrays[] = {scheduleDateJanuary,scheduleDateFebruary,scheduleDateMarch,scheduleDateApril,scheduleDateMay,scheduleDateJune,scheduleDateJuly,scheduleDateAugust,scheduleDateSeptember,scheduleDateOctober,scheduleDateNovember,scheduleDateDecember}; 


            try {
                
                //First check if epi schedule exist or not
                
                 int rowCount = 0;
                 String selectQuery = "select count(*) as count from public.epischedulerupdate\n"
                    + "where zillaid = " + districtId + " and upazilaId = " + upazilaId + " and unionid = " + unionId + " and wardold = " + wardId + " and subblockid = " + subblockId + " and scheduleyear = " + year + ";";
                Connection con = db2.openConnection();
                Statement stmt = con.createStatement();
                ResultSet rs = stmt.executeQuery(selectQuery);
                int schedulerId = 0;
                while (rs.next()) {
                    schedulerId = rs.getInt("count");
                    System.out.println("Check schedule: "+schedulerId);
                }
                System.err.println("Before"+schedulerId);
                
                 if (schedulerId == 0) {
                   for(int i = 0;i<dateArrays.length;i++){
                       DBManagerDistrict db3 = new DBManagerDistrict(Integer.parseInt(districtId));
                          schedulerId = schedulerId + 1;
                           query = "insert into public.epischedulerupdate( \n"
                                   + "divid, zillaid,upazilaid,unionid,wardold, subblockid,scheduleyear,schedulerid, centername,khananofrom,khananoto, centertype, scheduledate,upload) \n"
                                   + "values (" + divisionId + "," + districtId + ", " + upazilaId + ", " + unionId + ", " + wardId + ", " + subblockId + "," + year + "," + schedulerId + ",'" + centerName + "', " + khanaFrom+"," + khanaTo+"," +  centerType + ", to_date('" + dateArrays[i]+"', 'dd/mm/yyyy') , 2);";

                            rowCount = db3.update(query);
                    }
                }else{
                     rowCount = 2;
                }
                 
                System.err.println("After"+schedulerId);
                response.setContentType("text/plain;charset=UTF-8");
                response.getWriter().write(rowCount + "");
            } catch (Exception ex) {
                ex.getMessage();
            }
        }
        if (action.equalsIgnoreCase("getScheduleData")) {
            query = "select *,to_char(scheduledate,'dd/mm/yyyy') as scheduledate1 from public.epischedulerupdate\n"
                    + "where zillaid = " + districtId + "\n"
                    + "and upazilaid = " + upazilaId + "\n"
                    + "and unionid = " + unionId + "\n"
                    + "and wardold = " + wardId + "\n"
                    + "and subblockid = " + subblockId + "\n"
                    + "and scheduleyear = " + year + ";";

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

}
