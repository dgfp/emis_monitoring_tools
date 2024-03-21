package com.emis.resources;

import com.emis.utility.Convertor;
import com.rhis.db.DBManagerDistrict;
import com.rhis.db.DBManagerMonitoring;
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
@WebServlet(name = "UserManual", urlPatterns = {"/userManual"})
public class UserManual extends HttpServlet {

   
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("submenu", "userManual");
        request.setAttribute("menu", "RESOURCES");
        RequestDispatcher view = request.getRequestDispatcher("WEB-INF/jsp/resources/userManual.jsp");
        view.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
            String query  = "select * from manual order by id";
            try {
                DBManagerMonitoring db = new DBManagerMonitoring();
                
                ResultSet result = db.select(query);
                
                JSONArray json = Convertor.convertResultSetIntoJSONWithDash(result);
                
                response.setContentType("text/plain;charset=UTF-8");
                System.out.println(json.toString());
                
                response.getWriter().write(json.toString());

            } catch (Exception ex) {
                ex.getMessage();
            }
    }

}
