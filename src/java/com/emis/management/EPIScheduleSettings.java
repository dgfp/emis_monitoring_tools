package com.emis.management;

import com.emis.utility.Convertor;
import com.rhis.db.DBManagerDistrict;
//import com.rhis.db.DBManagerDistrict2;
import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
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
@WebServlet(name = "EPIScheduleSettings", urlPatterns = {"/schedule_epi_settings"})
public class EPIScheduleSettings extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setAttribute("submenu", "schedule_epi_settings");
        request.setAttribute("menu", "MANAGEMENT");
        RequestDispatcher dispatcher = request.getRequestDispatcher("WEB-INF/jsp/management/epi_schedule_settings.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        Date currentDate = new Date();

        String action = request.getParameter("action");
        String query = "";
        String districtid = request.getParameter("district");
        String upazilaid = request.getParameter("upazila");
        String unionid = request.getParameter("union");
        String wardid = request.getParameter("ward");
        String subblockid = request.getParameter("subblock");
        String year = request.getParameter("year");

        if (action.equalsIgnoreCase("addScheduleData")) {

            DBManagerDistrict db2 = new DBManagerDistrict(Integer.parseInt(districtid));

            String centername = request.getParameter("centerName");
            String centertype = request.getParameter("centerType");
//            String scheduleDate = request.getParameter("scheduleDate");
            String khananofrom = request.getParameter("khanaFrom");
            String khananoto = request.getParameter("khanaTo");
//            String householdTotal = request.getParameter("householdTotal");

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

            String dateArrays[] = {scheduleDateJanuary, scheduleDateFebruary, scheduleDateMarch, scheduleDateApril, scheduleDateMay, scheduleDateJune, scheduleDateJuly, scheduleDateAugust, scheduleDateSeptember, scheduleDateOctober, scheduleDateNovember, scheduleDateDecember};

            try {
                int rowCount = 0;
                for (int i = 0; i < dateArrays.length; i++) {

                    String selectQuery = "select count(*) as count from public.epischedulerupdate\n"
                            + "Where zillaid = " + districtid + "\n"
                            + "and upazilaid = " + upazilaid + "\n"
                            + "and unionid = " + unionid + "\n"
                            + "and wardold = " + wardid + "\n"
                            + "and subblockid = " + subblockid + "\n"
                            + "and scheduleyear = " + year + ";";
                    Connection con = db2.openConnection();
                    Statement stmt = con.createStatement();
                    ResultSet rs = stmt.executeQuery(selectQuery);
                    int schedulerid = 0;
                    while (rs.next()) {
                        schedulerid = rs.getInt("count");
                    }
                    schedulerid = schedulerid + 1;

                    if (schedulerid <= 96) {
                        query = "INSERT INTO public.epischedulerupdate(\n"
                                + "divid, zillaid,upazilaid,unionid,wardold, subblockid,scheduleyear,schedulerid, centerName,khananofrom,khananoto, centerType, scheduleDate,upload) \n"
                                + "VALUES (null," + districtid + ", " + upazilaid + ", " + unionid + ", " + wardid + ", " + subblockid + "," + year + "," + schedulerid + ",'" + centername + "', " + khananofrom + "," + khananoto + "," + centertype + ", to_date('" + dateArrays[i] + "', 'dd/mm/yyyy') , 2);";

                        rowCount = db2.update(query);
                    }
                }
                response.setContentType("text/plain;charset=UTF-8");
                response.getWriter().write(rowCount + "");
            } catch (Exception ex) {
                ex.getMessage();
            }
        }
        if (action.equalsIgnoreCase("getScheduleData")) {

            query = "select *,to_char(scheduledate,'dd/mm/yyyy') as scheduledate1 from public.epischedulerupdate\n"
                    + "Where zillaid = " + districtid + "\n"
                    + "and upazilaid = " + upazilaid + "\n"
                    + "and unionid = " + unionid + "\n"
                    + "and wardold = " + wardid + "\n"
                    + "and subblockid = " + subblockid + "\n"
                    + "and scheduleyear = " + year + " order by schedulerid;";

            try {
                DBManagerDistrict db = new DBManagerDistrict(Integer.parseInt(districtid));
                ResultSet result = db.select(query);
                JSONArray json = Convertor.convertResultSetIntoJSON(result);
                response.setContentType("text/plain;charset=UTF-8");
                System.out.println(json.toString());
                response.getWriter().write(json.toString());
            } catch (Exception ex) {
                ex.getMessage();
            }
        }

        if (action.equals("updateScheduleData")) {

            try {
                String centername = request.getParameter("centerName");
                String khananofrom = request.getParameter("khanaFrom");
                String khananoto = request.getParameter("khanaTo");

                System.out.println("OK");

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

                String dateArrays[] = {scheduleDateJanuary, scheduleDateFebruary, scheduleDateMarch, scheduleDateApril, scheduleDateMay, scheduleDateJune, scheduleDateJuly, scheduleDateAugust, scheduleDateSeptember, scheduleDateOctober, scheduleDateNovember, scheduleDateDecember};
                String result = "";
                DBManagerDistrict db = new DBManagerDistrict(Integer.parseInt(districtid));
                db.start();
                try {
                    for (int i = 0; i < dateArrays.length; i++) {
                        String sql = "UPDATE public.epischedulerupdate \n"
                                + "SET scheduledate='" + convertToCustomDateFormat(dateArrays[i])
                                + "', centername='" + centername + "', khananofrom=" + khananofrom + ", khananoto=" + khananoto + ", modifydate=now() \n"
                                + "WHERE  zillaid=" + districtid + " and upazilaid=" + upazilaid + " and  unionid=" + unionid + " and wardold=" + wardid + " and subblockid=" + subblockid + " and scheduleyear=" + year + " and schedulerid=" + (i + 1);
                        db.update(sql);
                        result += dateArrays[i] + "\t";

                    }
                    db.commit();

                } catch (Exception ex) {
                    db.rollback();
                }

                response.setContentType("text/plain;charset=UTF-8");
                System.out.println("Update result:" + result);
                response.getWriter().write(result);
            } catch (Exception ex) {
                System.out.println(ex);
                ex.getMessage();
            }
        }

        if (action.equalsIgnoreCase("deleteScheduleData")) {

            String sql = "Delete FROM public.epischedulerupdate where (zillaid, upazilaid, unionid,  scheduleyear, wardold, subblockid) in (select " + districtid + "," + upazilaid + "," + unionid + "," + year + "," + wardid + "," + subblockid + ") ";

            query = "select *,to_char(scheduleDate,'dd/mm/yyyy') as scheduledate1 from public.epischedulerupdate\n"
                    + "Where zillaid = " + districtid + "\n"
                    + "and upazilaid = " + upazilaid + "\n"
                    + "and unionid = " + unionid + "\n"
                    + "and wardold = " + wardid + "\n"
                    + "and subblockid = " + subblockid + "\n"
                    + "and scheduleyear = " + year + ";";

            try {
                DBManagerDistrict db = new DBManagerDistrict(Integer.parseInt(districtid));
                db.delete(sql);
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

    private String convertToCustomDateFormat(String date) {
        return date.replaceAll("(\\d+)/(\\d+)/(\\d+)", "$3-$2-$1");
    }

}
