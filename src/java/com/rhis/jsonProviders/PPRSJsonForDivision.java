package com.rhis.jsonProviders;

import com.emis.beans.LoginUser;
import com.emis.utility.Convertor;
import com.rhis.db.DBManagerMonitoring;
import java.io.IOException;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.json.JSONArray;

/**
 *
 * @author Helal
 */
@WebServlet(name = "PPRSJsonForDivision", urlPatterns = {"/pprsJsonForDivision"})
public class PPRSJsonForDivision extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
            HttpSession session=request.getSession();
            LoginUser loginuser=(LoginUser) session.getAttribute("LoginUser");

            String disvionId=loginuser.getDivision();

            try {

                DBManagerMonitoring db = new DBManagerMonitoring();
                String username = (String) request.getSession(false).getAttribute("username");
                ResultSet result=null;

                if(disvionId==null){
                    result = db.select("select * from \"Division\" where \"isImplemented\"=1 ORDER BY \"division\" ASC");

                }else{
                     result = db.select("select * from \"Division\" where \"id\"='"+disvionId+"' and \"isImplemented\"=1 ORDER BY \"division\" ASC");
                }

                JSONArray json = Convertor.convertResultSetIntoJSON(result);
                response.setContentType("text/plain;charset=UTF-8");
                response.getWriter().write(json.toString());
            } catch (Exception ex) {
                System.out.println(ex.getMessage());
            }
        
        
    }
}
