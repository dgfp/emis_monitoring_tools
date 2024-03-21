package com.emis.viewAsRegister;

import com.emis.utility.Convertor;
import com.rhis.db.DBManagerDistrict;
import java.io.IOException;
import java.sql.Connection;
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
@WebServlet(name = "ElcoSheet", urlPatterns = {"/ElcoSheet"})
public class ElcoSheet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("submenu", "ElcoSheet");
        request.setAttribute("menu", "VIEW AS REGISTER");
        request.setAttribute("userLevel", (String) request.getSession(false).getAttribute("userLevel"));
        RequestDispatcher view = request.getRequestDispatcher("WEB-INF/jsp/viewAsRegister/elcoSheet.jsp");
        view.forward(request, response);
        
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        Connection connection=null;
        String divisionId = request.getParameter("divisionId");
        int districtId = Integer.parseInt(request.getParameter("districtId").toString());
        int upazilaId = Integer.parseInt(request.getParameter("upazilaId").toString()); //request.getParameter("upazilaId");
        int unionId = Integer.parseInt(request.getParameter("unionId").toString()); //request.getParameter("unionId");
        String unitId = request.getParameter("unitId");
        String year = request.getParameter("year");

        if(divisionId!="" || districtId!=0 || upazilaId!=0 || unionId!=0 || unitId!="" || year!=""){

            try {
                DBManagerDistrict db = new DBManagerDistrict(districtId);
                //connection=db.getConnection();
                String sql="SELECT * from public.fn_fwa_eligible_couple_list ("+districtId+","+upazilaId+","+unionId+","+unitId+","+year+");";
                System.out.println("SQL: "+sql );
//                String sql = "SELECT * from public.fn_fwa_eligible_couple_list (?,?,?,?,?,?,?,?);";
//                PreparedStatement preparedStatement = connection.prepareStatement(sql);
//                preparedStatement.setInt(1, districtId);
//                preparedStatement.setInt(2, upazilaId);
//                preparedStatement.setInt(3, unionId);
//                preparedStatement.setString(4, year);
//                preparedStatement.setString(5, "01");
//                preparedStatement.setString(6, year);
//                preparedStatement.setString(7, "12");
//                preparedStatement.setString(8, unitId);
//                ResultSet result = preparedStatement.executeQuery();
                ResultSet result = db.select(sql);
                JSONArray json = Convertor.convertResultSetIntoJSONEPI(result);
                System.out.println("JSON: "+json.toString() );
                response.setContentType("text/plain;charset=UTF-8");
                response.getWriter().write("{\"status\": \"success\",\"data\": "+json.toString()+",\"message\": \"Return success\"}");


            } catch (Exception ex) {
                response.setContentType("text/plain;charset=UTF-8");
                response.getWriter().write("{\"status\": \"error\",\"data\":null,\"message\": \"Somthing went wrong\"}");
                System.out.println("Error: "+ex.getMessage());
            }

        } else{
            response.setContentType("text/plain;charset=UTF-8");
            response.getWriter().write("{\"status\": \"error\",\"data\":null,\"message\": \"Please fill required field\"}");
        }
        
    }

}
