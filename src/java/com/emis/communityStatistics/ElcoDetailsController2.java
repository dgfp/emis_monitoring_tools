package com.emis.communityStatistics;

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
@WebServlet(name = "ElcoDetailsController2", urlPatterns = {"/elco_details2"})
public class ElcoDetailsController2 extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setAttribute("submenu", "elco_details");
        request.setAttribute("menu", "COMMUNITY STATISTICS");
        request.setAttribute("userLevel", (String) request.getSession(false).getAttribute("userLevel"));
        RequestDispatcher view = request.getRequestDispatcher("WEB-INF/jsp/communityStatistics/elco_details2.jsp");
        view.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        

        String action = request.getParameter("action");

        String districtId = request.getParameter("districtId");
        String upazilaId = request.getParameter("upazilaId").length() == 0 ? "%" : request.getParameter("upazilaId");
        String unionId = request.getParameter("unionId").length() == 0 ? "%" : request.getParameter("unionId");
        String unitId = request.getParameter("unitId").length() == 0 ? "%" : request.getParameter("unitId");
        String startDate = request.getParameter("startDate").length() == 0 ? "01/01/2015" : request.getParameter("startDate");
        String endDate = request.getParameter("endDate").length() == 0 ? Utility.getDateNow() : request.getParameter("endDate");
        String elcoDate = "";
       
        if (action.equals("Aggregate")) {
            //unitId = Integer.parseInt(request.getParameter("unitId").toString())== 0 ? "%" : request.getParameter("unitId");
            String where = "where p.provtype=3 and p.zillaid = "+districtId+" ";
            if (request.getParameter("unitId").length() != 0) {
                where += "and p.upazilaid=" + upazilaId + " and p.unionid=" + unionId + " and pa.fwaunit=" + unitId;

            } else if (request.getParameter("unionId").length() != 0) {
                where += "and p.upazilaid=" + upazilaId + " and p.unionid=" + unionId;

            } else if (request.getParameter("upazilaId").length() != 0) {
                where += "and p.upazilaid=" + upazilaId;
            }
            
            if(request.getParameter("startDate").length()!=0)
                elcoDate = "and date(e.systementrydate) between to_date('01/01/2018','dd/mm/yyyy') and to_date('28/05/2018','dd/mm/yyyy')";

                //String queryFunc="SELECT  * from public.web_elco_aggregate("+districtId+",'"+upazilaId+"','"+unionId+"','"+unitId+"','"+startDate+"','"+endDate+"');";
                
                upazilaId = "%".equals(upazilaId) ? null : upazilaId;
                unionId = "%".equals(unionId) ? null : unionId;
                unitId = "%".equals(unitId) ? null : unitId;
                String queryFunc1="SELECT  * from public.web_elco_aggregate_update("+districtId+","+upazilaId +","+unionId+","+unitId+",'"+startDate+"','"+endDate+"');";
                
                //String queryFunc1="SELECT  * from web_elco_aggregate_update(69,9,19,null,'01/01/2015','17/09/2018')";
                
           

            try {

                DBManagerDistrict db = new DBManagerDistrict(Integer.parseInt(districtId));
                System.out.println(queryFunc1);
                ResultSet result = db.select(queryFunc1);

                //JSONArray json = Convertor.convertResultSetIntoJSON(result);

                response.setContentType("text/plain;charset=UTF-8");
                
                String json="[]";
                try {
                    while (result.next()) {
                        json=result.getString("data");
                    }
                }
                catch(Exception ex){
                }
                
                System.out.println(json);
                response.getWriter().write(json);

            } catch (Exception ex) {
                System.out.println("++++++++++++++++++++++++++++++++++"+ ex.getMessage());
                ex.printStackTrace();
                response.getWriter().write(ex.getMessage());
            }

        }

        if (action.equals("Individual")) {
            System.out.println("```````````````````````````````````````Here we go");
            String villageId = request.getParameter("villageId").length() == 0 ? "%" : request.getParameter("villageId");

            //String preg_status = request.getParameter("preg_status");
            //String query = "SELECT  * from public.fn_ElcoByProvider_Detail(" + districtId + ",'" + upazilaId + "','" + unionId + "','" + villageId + "', '" + preg_status + "')";
            String query = "SELECT  * from public.fn_elco_individual('" + districtId + "','" + upazilaId + "','" + unionId + "','" + unitId + "','" + villageId + "','" + startDate + "','" + endDate + "');";
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
