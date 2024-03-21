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
 * @author ccah
 */
@WebServlet(name = "EPIPerReport", urlPatterns = {"/epiperreport"})
public class EPIPerReport extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String jsp="WEB-INF/jsp/reports/epiperreport.jsp";
        String userLevel=(String) request.getSession(false).getAttribute("userLevel");
        
        request.setAttribute("submenu", "epiperreport");
        request.setAttribute("menu", "VIEW REPORTS");
        request.setAttribute("userLevel", userLevel);
        
        if(request.getSession().getAttribute("isTabAccess")!=null){
            jsp = "WEB-INF/jsp/reports/dailyTallySheetByTab.jsp";
        }
        RequestDispatcher dispatcher = request.getRequestDispatcher(jsp);
        dispatcher.forward(request, response);
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
                    DBManagerDistrict db1 = new DBManagerDistrict(Integer.parseInt(districtId));

                    ResultSet result = db.select("SELECT * from public.fn_daily_activity_sheet ("+districtId+","+upazilaId+","+unionId+",'"+fwaUnit+"',"+year+","+month+","+provCode+");");
                    JSONArray json = Convertor.convertResultSetIntoJSONWithZero(result);
                    ResultSet result1 = db1.select("SELECT * from public.fn_daily_activity_sheet_bottom_monthly_rpt ("+districtId+","+upazilaId+","+unionId+",'"+fwaUnit+"',"+year+","+month+","+provCode+");");
                    JSONArray json1 = Convertor.convertResultSetIntoJSONWithZero(result1);
                    
                    response.setContentType("text/plain;charset=UTF-8");
                    response.getWriter().write("{\"First\":"+json.toString()+",\"Second\":"+json1.toString()+"}");
                } catch (Exception ex) {
                    System.out.println(ex.getMessage());
                }
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        

        /*String action = request.getParameter("action");
        String query = "";
        String districtId = request.getParameter("district");
        String upazilaId = request.getParameter("upazila");
        String unionId = request.getParameter("union");
        String wardId = request.getParameter("ward");
        String subblockId = request.getParameter("subblock");
        String year = request.getParameter("year");

        if (action.equalsIgnoreCase("addScheduleData")) {

            DBManager2 db2 = new DBManager2();

            String centerName = request.getParameter("centerName").toString();
            String centerType = request.getParameter("centerType");
//            String scheduleDate = request.getParameter("scheduleDate").toString();
            String khanaFrom = request.getParameter("khanaFrom").toString();
            String khanaTo = request.getParameter("khanaTo").toString();
//            String householdTotal = request.getParameter("householdTotal").toString();
	

            String scheduleDateJanuary = request.getParameter("scheduleDateJanuary").toString();
            String scheduleDateFebruary = request.getParameter("scheduleDateFebruary").toString();
            String scheduleDateMarch = request.getParameter("scheduleDateMarch").toString();
            String scheduleDateApril = request.getParameter("scheduleDateApril").toString();
            String scheduleDateMay = request.getParameter("scheduleDateMay").toString();
            String scheduleDateJune = request.getParameter("scheduleDateJune").toString();
            String scheduleDateJuly = request.getParameter("scheduleDateJuly").toString();
            String scheduleDateAugust = request.getParameter("scheduleDateAugust").toString();
            String scheduleDateSeptember = request.getParameter("scheduleDateSeptember").toString();
            String scheduleDateOctober = request.getParameter("scheduleDateOctober").toString();
            String scheduleDateNovember = request.getParameter("scheduleDateNovember").toString();
            String scheduleDateDecember = request.getParameter("scheduleDateDecember").toString();
	
            String dateArrays[] = {scheduleDateJanuary,scheduleDateFebruary,scheduleDateMarch,scheduleDateApril,scheduleDateMay,scheduleDateJune,scheduleDateJuly,scheduleDateAugust,scheduleDateSeptember,scheduleDateOctober,scheduleDateNovember,scheduleDateDecember}; 


            try {
                 int rowCount = 0;
                   for(int i = 0;i<dateArrays.length;i++){
            
                 String selectQuery = "select count(*) as count from public.\"epiSchedulerUpdate\"\n"
                    + "Where \"Dist\" = " + districtId + "\n"
                    + "and \"Upz\" = " + upazilaId + "\n"
                    + "and \"UN\" = " + unionId + "\n"
                    + "and \"wordOld\" = " + wardId + "\n"
                    + "and \"subBlockId\" = " + subblockId + "\n"
                    + "and \"scheduleYear\" = " + year + ";";
                Connection con = db2.openConnection();
                Statement stmt = con.createStatement();
                ResultSet rs = stmt.executeQuery(selectQuery);
                int schedulerId = 0;
                while (rs.next()) {
                    schedulerId = rs.getInt("count");
                }
                schedulerId = schedulerId + 1;
               
                if (schedulerId <= 96) {
                    query = "INSERT INTO public.\"epiSchedulerUpdate\"(\n"
                            + "\"Div\", \"Dist\",\"Upz\",\"UN\",\"wordOld\", \"subBlockId\",\"scheduleYear\",\"schedulerId\", \"centerName\",\"KhanaNoFrom\",\"KhanaNoTo\", \"centerType\", \"scheduleDate\",upload) \n"
                            + "VALUES (null," + districtId + ", " + upazilaId + ", " + unionId + ", " + wardId + ", " + subblockId + "," + year + "," + schedulerId + ",'" + centerName + "', " + khanaFrom+"," + khanaTo+"," +  centerType + ", to_date('" + dateArrays[i]+"', 'dd/mm/yyyy') , 2);";

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
            query = "select *,to_char(\"scheduleDate\",'dd/mm/yyyy') as scheduledate1 from public.\"epiSchedulerUpdate\"\n"
                    + "Where \"Dist\" = " + districtId + "\n"
                    + "and \"Upz\" = " + upazilaId + "\n"
                    + "and \"UN\" = " + unionId + "\n"
                    + "and \"wordOld\" = " + wardId + "\n"
                    + "and \"subBlockId\" = " + subblockId + "\n"
                    + "and \"scheduleYear\" = " + year + ";";

            try {
                DBManager2 db = new DBManager2();
                ResultSet result = db.select(query);
                JSONArray json = Convertor.convertResultSetIntoJSON(result);
                response.setContentType("text/plain;charset=UTF-8");
                System.out.println(json.toString());
                response.getWriter().write(json.toString());
            } catch (Exception ex) {
                ex.getMessage();
            }
        }*/
        
        
    }

}
