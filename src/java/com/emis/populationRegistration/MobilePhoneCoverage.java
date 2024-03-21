package com.emis.populationRegistration;

import com.emis.service.Area;
import com.emis.utility.Convertor;
import com.rhis.db.DBManagerDistrict;
import java.io.IOException;
import java.sql.ResultSet;
import java.util.ArrayList;
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
@WebServlet(name = "MobilePhoneCoverage", urlPatterns = {"/MobilePhoneCoverage"})
public class MobilePhoneCoverage extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("submenu", "MobilePhoneCoverage");
        request.setAttribute("menu", "POPULATION REGISTRATION");
        request.setAttribute("userLevel", (String) request.getSession(false).getAttribute("userLevel"));
        RequestDispatcher view = request.getRequestDispatcher("WEB-INF/jsp/populationRegistration/mobilePhoneCoverage.jsp");
        view.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            String action = request.getParameter("action");
            String divisionId = request.getParameter("divisionId");
            String districtId=request.getParameter("districtId");
            String startDate =  request.getParameter("startDate").toString();
            String endDate = request.getParameter("endDate").toString();
            String query="";
            Boolean isMulipleDistrict=false;
            
            // District wise
            if (action.equals("mobileCoverageDistrict")) {
                if(districtId.equals("%")){
                    System.out.println("Gooooooooooooooooooooooooooo");
                    isMulipleDistrict=true;
                    
                    try {
                        ArrayList<Integer> districtIdList = Area.getDistrictIdByDivision(divisionId);
                        ArrayList<JSONArray> JSONArrayList = new ArrayList<JSONArray>();

                        for (int district : districtIdList){
                            query = "select * from web_mobile_phone_coverage_districtwise("+ divisionId +","+district+",'"+startDate+"','"+endDate+"');";

                            DBManagerDistrict db = new DBManagerDistrict(district);
                            ResultSet result = db.select(query);
                            JSONArray json = Convertor.convertResultSetIntoJSON(result);
                            JSONArrayList.add(json);
                        }
                        JSONArray json = Convertor.getMergeJsonArrays(JSONArrayList);
                        response.setContentType("text/plain;charset=UTF-8");
                        response.getWriter().write(json.toString());

                    } catch (Exception ex) {
                        ex.getMessage();
                    }
                }else{
                    query = "select * from web_mobile_phone_coverage_districtwise("+ divisionId +","+districtId+",'"+startDate+"','"+endDate+"');";
                }
                
            }
            
            // Upazila wise
            if (action.equals("mobileCoverageUpazila")) {
                districtId = request.getParameter("districtId");
                String upazilaId = request.getParameter("upazilaId").length() == 0 ? "%" : request.getParameter("upazilaId");
                query = "select * from web_mobile_phone_coverage_upazilawise("+districtId+",'"+upazilaId+"','"+startDate+"','"+endDate+"');";
            }
            
            // Union wise
            if (action.equals("mobileCoverageUnion")) {
                districtId = request.getParameter("districtId");
                String upazilaId = request.getParameter("upazilaId").length() == 0 ? "41" : request.getParameter("upazilaId");
                String unionId = request.getParameter("unionId").length() == 0 ? "%" : request.getParameter("unionId");
                query = "select * from web_mobile_phone_coverage_unionwise("+districtId+","+upazilaId+",'"+unionId+"','"+startDate+"','"+endDate+"')";
                //query = "select * from sp_possession_mobile_coverage_un("+ Integer.parseInt(districtId) +","+ Integer.parseInt(upazilaId) +",'"+unionId+"','"+startDate+"','"+endDate+"');";
            }
            
            
            try {
                if(!isMulipleDistrict){
                    //String district = districtId;
//                    if(districtId.equals("93"))
//                        districtId = "931";
                    
                    
                    DBManagerDistrict db = new DBManagerDistrict(Integer.parseInt(districtId));
                    ResultSet result = new DBManagerDistrict(Integer.parseInt(districtId)).select(query);
                    JSONArray json = Convertor.convertResultSetIntoJSON(result);
                    response.setContentType("text/plain;charset=UTF-8");
                    response.getWriter().write(json.toString());
                }
            } catch (Exception ex) {
                ex.getMessage();
            }
        
        
    }
}
