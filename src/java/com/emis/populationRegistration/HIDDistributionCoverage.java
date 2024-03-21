package com.emis.populationRegistration;

import com.emis.service.Area;
import com.emis.utility.Convertor;
import static com.emis.utility.Convertor.convertToCustomDateFormat;
import com.rhis.db.DBManagerDistrict;
import java.io.IOException;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.JSONArray;

/**
 *
 * @author Helal | m.helal.k@gmail.com
 */
@WebServlet(name = "HIDDistributionCoverage", urlPatterns = {"/HIDDistributionCoverage"})
public class HIDDistributionCoverage extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        System.out.println("-------------------------------------@@-------------------------------");
        request.setAttribute("submenu", "HIDDistributionCoverage");
        request.setAttribute("menu", "POPULATION REGISTRATION");
        request.setAttribute("userLevel", (String) request.getSession(false).getAttribute("userLevel"));
        RequestDispatcher view = request.getRequestDispatcher("WEB-INF/jsp/populationRegistration/hidDistributionCoverage.jsp");
        view.forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
            String action = request.getParameter("action");
            String divisionId = request.getParameter("divisionId");
            String districtId = request.getParameter("districtId");
            String startDate = request.getParameter("startDate").length() == 0 ? "01/01/2015" : request.getParameter("startDate");
            String endDate = request.getParameter("endDate");
            
            String query="";
            Boolean isMulipleDistrict=false;
            
            // District wise
            if (action.equals("HIDDistrict")) {
                if(districtId.equals("%")){
                    isMulipleDistrict=true;
                    
                    try {
                        ArrayList<Integer> districtIdList = Area.getDistrictIdByDivision(divisionId);
                        ArrayList<JSONArray> JSONArrayList = new ArrayList<JSONArray>();

                        for (int district : districtIdList){

                                query = "select * from web_hid_zilla("+ district + ",'"+startDate+"','"+endDate+"');";
                                
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
                        query = "select * from web_hid_zilla("+ districtId + ",'"+startDate+"','"+endDate+"');";

                }
                
            }
            
            // Upazila wise
            if (action.equals("HIDUpazila")) {
                String upazilaId = request.getParameter("upazilaId").length() == 0 ? "%" : request.getParameter("upazilaId");
                query = "select * from public.web_hid_upzilla("+districtId+",'"+upazilaId+"','"+startDate+"','"+endDate+"')";
            }
            
            // Union wise
            if (action.equals("HIDUnion")) {
                String upazilaId = request.getParameter("upazilaId");
                String unionId = request.getParameter("unionId").length() == 0 ? "%" : request.getParameter("unionId");
                query = "select * from public.web_hid_union("+districtId+","+upazilaId+",'"+unionId+"','"+startDate+"','"+endDate+"')";
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
