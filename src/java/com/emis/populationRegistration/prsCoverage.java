package com.emis.populationRegistration;

import com.emis.service.Area;
import com.emis.utility.Convertor;
import com.emis.utility.Utility;
import com.rhis.controllers.UserAuthenticator;
import com.rhis.db.DBManagerDistrict;
import java.io.IOException;
import java.sql.ResultSet;import java.sql.SQLException;
;
import java.util.ArrayList;
import java.util.UUID;
import java.util.logging.Level;
import java.util.logging.Logger;
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
@WebServlet(name = "prsCoverage", urlPatterns = {"/prsCoverage"})
public class prsCoverage extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String a;
        a = UUID.randomUUID().toString();
        System.out.println("~~~~~~~~~~~~~~~~~~~~~~~~"+a.length());
        
        request.setAttribute("submenu", "prsCoverage");
        request.setAttribute("menu", "POPULATION REGISTRATION");
        request.setAttribute("userLevel", (String) request.getSession(false).getAttribute("userLevel"));
        RequestDispatcher view = request.getRequestDispatcher("WEB-INF/jsp/populationRegistration/prsCoverage.jsp");
        view.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
            String action = request.getParameter("action");
            String divisionId = request.getParameter("divisionId");
            String districtId = request.getParameter("districtId");
            String startDate = request.getParameter("startDate").length() == 0 ? "01/01/2015" : request.getParameter("startDate");
            String endDate = request.getParameter("endDate").length() == 0 ? Utility.getDateNow() : request.getParameter("endDate");
            String query="";
            Boolean isMulipleDistrict=false;
            
            // District wise
            if (action.equals("prsProgressDistrict")) {
                if(districtId.equals("%")){
                    isMulipleDistrict=true;
                    
                    try {
                        ArrayList<Integer> districtIdList = Area.getDistrictIdByDivision(divisionId);
                        ArrayList<JSONArray> JSONArrayList = new ArrayList<JSONArray>();

                        for (int district : districtIdList){

                            if(startDate.equals("")){
                                query = "select * from fn_popprogress_zila('"+ divisionId + "','"+ district+ "')  order by zillanameeng asc";

                            }else{
                                query="select * from fn_popprogress_zila_date_wise('"+divisionId+"','"+district+"','"+startDate+"','"+endDate+"')";
                            }

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
                    if(startDate.equals("")){
                        query="select * from fn_popprogress_zila_date_wise('"+divisionId+"','"+districtId+"','01/01/2015','"+endDate+"')";
                    }else{
                        query="select * from fn_popprogress_zila_date_wise('"+divisionId+"','"+districtId+"','"+startDate+"','"+endDate+"')";
                    }
                }
            }
            
            // Upazila wise
            if (action.equals("prsProgressUpazila")) {
                String upazilaId = request.getParameter("upazilaId").length() == 0 ? "%" : request.getParameter("upazilaId");
                
                if(startDate.equals("")){
                    //query = "select * from fn_popprogress_upazila('"+divisionId+"','"+districtId+"','"+upazilaId+"');";
                    query="select * from fn_popprogress_upazila_date_wise('"+divisionId+"','"+districtId+"','"+upazilaId+"','01/01/2015','"+endDate+"');";
                    
                }else{
                    query="select * from fn_popprogress_upazila_date_wise('"+divisionId+"','"+districtId+"','"+upazilaId+"','"+startDate+"','"+endDate+"') order by upazilanameeng asc";
                }
            }
            
            // Union wise
            if (action.equals("prsProgressUnion")) {
                String upazilaId = request.getParameter("upazilaId").length() == 0 ? "%" : request.getParameter("upazilaId");
                String unionId = request.getParameter("unionId").length() == 0 ? "%" : request.getParameter("unionId");
                
                if(startDate.equals("")){
                    query="select * from fn_popprogress_un_date_wise('"+divisionId+"','"+districtId+"','"+upazilaId+"','"+unionId+"','01/01/2015','"+endDate+"');";
                    //query = "select * from fn_popprogress_un('"+divisionId+"','"+districtId+"','"+upazilaId+"','"+unionId+"');";
                    
                }else{
                    query="select * from fn_popprogress_un_date_wise('"+divisionId+"','"+districtId+"','"+upazilaId+"','"+unionId+"','"+startDate+"','"+endDate+"') order by unionnameeng asc";
                }
            }
            
            //Provider wise
            if (action.equals("prsProgressProviderWise")) {
                String upazilaId = request.getParameter("upazilaId").length() == 0 ? "%" : request.getParameter("upazilaId");
                String unionId = request.getParameter("unionId").length() == 0 ? "%" : request.getParameter("unionId"); 
                String provtype=request.getParameter("designation").length() == 0 ?"%":request.getParameter("designation");
                query= "select * from sp_provideractivities_new("
                            + districtId
                            + ","
                            + upazilaId
                            + ",'"
                            + unionId
                            + "','"
                            + provtype
                            + "','"
                            + startDate
                            + "','"
                            + endDate
                            + "')";
            }
            
            try {
                if(!isMulipleDistrict){
                    DBManagerDistrict db = new DBManagerDistrict(Integer.parseInt(districtId));
                    ResultSet result = db.select(query);
                    JSONArray json = Convertor.convertResultSetIntoJSON(result);
                    response.setContentType("text/plain;charset=UTF-8");
                    response.getWriter().write(json.toString());
                }
                
            } catch (Exception ex) {
                ex.getMessage();
            }
        
     
            
    }


}
