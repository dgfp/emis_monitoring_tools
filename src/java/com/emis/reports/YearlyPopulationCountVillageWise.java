package com.emis.reports;

import com.emis.dao.UserDao;
import com.emis.utility.Convertor;
import com.emis.utility.Menu;
import com.rhis.db.DBManagerDistrict;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
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
@WebServlet(name = "YearlyPopulationCountVillageWise", urlPatterns = {"/yearlyPopulationCountVillageWise"})
public class YearlyPopulationCountVillageWise extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
//            request.setAttribute("submenu", "yearlyPopulationCountVillageWise");
//            request.setAttribute("menu", "VIEW REPORTS");     
//            request.setAttribute("userLevel", (String) request.getSession(false).getAttribute("userLevel"));
//            RequestDispatcher view = request.getRequestDispatcher("WEB-INF/jsp/reports/yearlyPopulationCountVillageWiseUpdated.jsp");
//            view.forward(request, response);

        Menu.setMenu("VIEW REPORTS", "yearlyPopulationCountVillageWise", request);
        String view = "WEB-INF/jsp/reports/yearlyPopulationCountVillageWiseUpdated.jsp";
        try {
            if (request.getSession(false).getAttribute("district") != null) {
                if (new UserDao().isPaperless(request.getSession(false).getAttribute("district").toString())) {
                    response.sendRedirect(request.getContextPath() + "/villlage-wise-population");
                } else {
                    request.getRequestDispatcher(view).forward(request, response);
                }
            } else {
                request.getRequestDispatcher(view).forward(request, response);
            }
        } catch (Exception e) {
            request.getRequestDispatcher(view).forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
            Connection connection=null;
            String districtId = request.getParameter("districtId");
            String upazilaId = request.getParameter("upazilaId");
            String unionId = request.getParameter("unionId");
            String unitId = request.getParameter("unitId");
            String year = request.getParameter("year");

            if(districtId!="" || upazilaId!="" || unionId!="" || unitId!="" || year!=""){

                try {
                    DBManagerDistrict db = new DBManagerDistrict(Integer.parseInt(districtId));
                    connection=db.openConnection();
                    //String sql = "SELECT * from public.fn_fwa_eligible_couple_list (?,?,?,?,?,?,?,?);";
                    String sql = "SELECT * from public.fn_fwa_village_wise_population_sheet (?,?,?,?,?) order by 8;";
                   
                    PreparedStatement preparedStatement = connection.prepareStatement(sql);
                    preparedStatement.setInt(1, Integer.parseInt(districtId));
                    preparedStatement.setInt(2, Integer.parseInt(upazilaId));
                    preparedStatement.setInt(3, Integer.parseInt(unionId));
                    preparedStatement.setInt(4, Integer.parseInt(unitId));
                    preparedStatement.setInt(5, Integer.parseInt(year));
                    ResultSet result = preparedStatement.executeQuery();
                    System.out.format("SQL:- %s", result.getStatement().toString());
                    JSONArray json = Convertor.convertResultSetIntoJSONEPI(result);

                    connection.close();
                    response.setContentType("text/plain;charset=UTF-8");
                    response.getWriter().write(json.toString());


                } catch (Exception ex) {
                    System.out.println(ex.getMessage());
                }

            } else{
                response.setContentType("text/plain;charset=UTF-8");
                response.getWriter().write("");
            }
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        /*String districtId = request.getParameter("districtId");
        String upazilaId = request.getParameter("upazilaId").length() == 0 ? "%" : request.getParameter("upazilaId");
        String unionId = request.getParameter("unionId").length() == 0 ? "%" : request.getParameter("unionId");
        String fwaUnit = request.getParameter("fwaUnit");
        String provCode = request.getParameter("provCode");
        String year = request.getParameter("year");
            
        try {
            DBManager db = new DBManager();
            DBManager db1 = new DBManager();
            DBManager db2 = new DBManager();
            
            ResultSet resultYear = db.select("SELECT distinct r_year from public.fn_fwa_village_wise_population_sheet ("+districtId+","+upazilaId+","+unionId+",'"+fwaUnit+"',"+year+","+provCode+") order by r_year asc;");
            JSONArray jsonYear = Convertor.convertResultSetIntoJSONWithZero(resultYear);
            ResultSet resultVillage = db1.select("SELECT distinct r_villagenameeng from public.fn_fwa_village_wise_population_sheet ("+districtId+","+upazilaId+","+unionId+",'"+fwaUnit+"',"+year+","+provCode+");");
            JSONArray jsonVillage = Convertor.convertResultSetIntoJSONWithZero(resultVillage);
            ResultSet resultMain = db2.select("SELECT * from public.fn_fwa_village_wise_population_sheet ("+districtId+","+upazilaId+","+unionId+",'"+fwaUnit+"',"+year+","+provCode+");");
            JSONArray jsonMain = Convertor.convertResultSetIntoJSONWithZero(resultMain);
            
            response.setContentType("text/plain;charset=UTF-8");
            response.getWriter().write("{\"Year\":"+jsonYear.toString()+",\"Village\":"+jsonVillage.toString()+",\"Population\":"+jsonMain.toString()+"}");
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        }*/
        
    }

}
