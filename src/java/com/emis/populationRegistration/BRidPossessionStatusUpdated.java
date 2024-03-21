package com.emis.populationRegistration;

import com.emis.service.Area;
import com.emis.utility.Convertor;
import com.emis.utility.Utility;
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
@WebServlet(name = "BRidPossessionStatusUpdated", urlPatterns = {"/BRidPossessionStatusUpdated"})
public class BRidPossessionStatusUpdated extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("submenu", "BRidPossessionStatusUpdated");
        request.setAttribute("menu", "POPULATION REGISTRATION");
        request.setAttribute("userLevel", (String) request.getSession(false).getAttribute("userLevel"));
        RequestDispatcher view = request.getRequestDispatcher("WEB-INF/jsp/newPopulationRegistration/brid_possession_status_updated.jsp");
        
        view.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
//            String action = request.getParameter("action");
//            String districtId=request.getParameter("districtId");
//            String startDate = Convertor.convertToCustomDateFormat( request.getParameter("startDate").toString());
//            String endDate = Convertor.convertToCustomDateFormat( request.getParameter("endDate").toString());

        String action = request.getParameter("action");
        String divisionId = request.getParameter("divisionId");
        String districtId = request.getParameter("districtId");
        String startDate = request.getParameter("startDate").length() == 0 ? "01/01/2015" : request.getParameter("startDate");
        String endDate = request.getParameter("endDate").length() == 0 ? Utility.getDateNow() : request.getParameter("endDate");
        startDate = Convertor.convertToCustomDateFormat(startDate);
        endDate = Convertor.convertToCustomDateFormat(endDate);
            
            
            String query=null;
            Boolean isMulipleDistrict=false;

            //District wise NID
            if (action.equals("showDistrictWise")) {
                if(districtId.equals("%")){
                    isMulipleDistrict=true;
                    
                    try {
                        ArrayList<Integer> districtIdList = Area.getDistrictIdByDivision(divisionId);
                        ArrayList<JSONArray> JSONArrayList = new ArrayList<JSONArray>();

                        for (int district : districtIdList){

                            query = "select * from sp_possessionbrid_dist("+divisionId+",'"+districtId+"','"+startDate+"','"+endDate+"');";

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
                    query = "select * from sp_possessionbrid_dist("+divisionId+",'"+districtId+"','"+startDate+"','"+endDate+"');";
                }
            }

            //Upazila wise NID
            if (action.equals("showUpazilaWise")) {
                districtId = request.getParameter("districtId");
                String upazilaId = request.getParameter("upazilaId").length() == 0 ? "%" : request.getParameter("upazilaId");

                query = "select * from sp_possessionbrid_upz("               
                        + districtId
                        + ",'"
                        + upazilaId
                        + "','"
                        + startDate
                        + "','"
                        + endDate
                        + "')";

            }

            //Union wise NID
            if (action.equals("showUnionWise")) {
                districtId = request.getParameter("districtId");
                String upazilaId = request.getParameter("upazilaId").length() == 0 ? "%" : request.getParameter("upazilaId");
                String unionId = request.getParameter("unionId").length() == 0 ? "%" : request.getParameter("unionId");

                query = "select * from sp_possessionbrid_un("               
                        + districtId
                        + ","
                        + upazilaId
                        + ",'"
                        + unionId
                        + "','"
                        + startDate
                        + "','"
                        + endDate
                        + "')";
            }

            //Provider wise
            if (action.equals("prsProgressProviderWise")) {
                startDate = Convertor.convertDateToUserFormat(startDate);
                endDate = Convertor.convertDateToUserFormat(endDate);

                String upazilaId = request.getParameter("upazilaId").length() == 0 ? "%" : request.getParameter("upazilaId");
                String unionId = request.getParameter("unionId").length() == 0 ? "%" : request.getParameter("unionId"); 
                String provtype=request.getParameter("designation").length() == 0 ?"%":request.getParameter("designation");
                query= "select * from web_brid_providerwise('"
                            + districtId
                            + "','"
                            + upazilaId
                            + "','"
                            + unionId
                            + "','"
                            + provtype
                            + "','"
                            + startDate
                            + "','"
                            + endDate
                            + "')";
                //query = "select * from web_nid_providerwise(93,66,'%','3','01/01/2015','09/10/2018')";
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
