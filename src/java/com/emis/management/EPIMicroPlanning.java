package com.emis.management;

import com.emis.utility.Convertor;
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
 * @author Helal - m.helal.k@gmail.com
 * Date: 14/11/2017
 */
@WebServlet(name = "EPIMicroPlanning", urlPatterns = {"/EPIMicroPlanning"})
public class EPIMicroPlanning extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("submenu", "schedule_epi_settings");
        request.setAttribute("menu", "MANAGEMENT");
        RequestDispatcher dispatcher = request.getRequestDispatcher("WEB-INF/jsp/management/epiMicroPlanning.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            Connection connection=null;
            String divisionId = request.getParameter("divisionId");
            String districtId = request.getParameter("districtId");
            String upazilaId = request.getParameter("upazilaId");
            String year = request.getParameter("year");
            
            if(divisionId!="" || districtId!="" || upazilaId!="" || year!=""){
                
                try {
                    DBManagerDistrict db = new DBManagerDistrict(Integer.parseInt(districtId));
                    connection=db.getConnection();
                    
                    //sql for getting epi micro planning of hole upazila 
                    System.out.println("SQL Query: select * from public.fn_epi_mirco_planning("+divisionId+","+districtId+","+upazilaId+","+year+");");
                    String sql = "select * from public.fn_epi_mirco_planning(?,?,?,?);";
                    PreparedStatement preparedStatement = connection.prepareStatement(sql);
                    preparedStatement.setInt(1, Integer.parseInt(divisionId));
                    preparedStatement.setInt(2, Integer.parseInt(districtId));
                    preparedStatement.setInt(3, Integer.parseInt(upazilaId));
                    preparedStatement.setInt(4, Integer.parseInt(year));
                    ResultSet result = preparedStatement.executeQuery();
                    JSONArray json = Convertor.convertResultSetIntoJSONEPI(result);
                    
                    //sql for getting epi micro planning area information
                    String areaSQL = "select  distinct unid, name_zila(?,?), name_upazila(?,?), name_union(?,?,unid) from public.fn_epi_mirco_planning(?,?,?,?) order by unid asc";
                    PreparedStatement preparedStatement2 = connection.prepareStatement(areaSQL);
                    preparedStatement2.setInt(1, Integer.parseInt(divisionId));
                    preparedStatement2.setInt(2, Integer.parseInt(districtId));
                    
                    preparedStatement2.setInt(3, Integer.parseInt(districtId));
                    preparedStatement2.setInt(4, Integer.parseInt(upazilaId));
                    
                    preparedStatement2.setInt(5, Integer.parseInt(districtId));
                    preparedStatement2.setInt(6, Integer.parseInt(upazilaId));
                    
                    preparedStatement2.setInt(7, Integer.parseInt(divisionId));
                    preparedStatement2.setInt(8, Integer.parseInt(districtId));
                    preparedStatement2.setInt(9, Integer.parseInt(upazilaId));
                    preparedStatement2.setInt(10, Integer.parseInt(year));
                    
                    ResultSet resultAreaSQL = preparedStatement2.executeQuery();
                    JSONArray jsonAreaSQL = Convertor.convertResultSetIntoJSONEPI(resultAreaSQL);
                    
                    connection.close();
                    response.setContentType("text/plain;charset=UTF-8");
                    response.getWriter().write("{\"epi\":"+json.toString()+",\"areaInfo\":"+jsonAreaSQL.toString()+"}");
                    
                    
                } catch (Exception ex) {
                    System.out.println(ex.getMessage());
                }
                
            } else{
                response.setContentType("text/plain;charset=UTF-8");
                response.getWriter().write("");
            }
        
            
        
    }

}
