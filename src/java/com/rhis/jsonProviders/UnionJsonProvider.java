package com.rhis.jsonProviders;

import com.emis.utility.Convertor;
import com.emis.utility.Utility;
import com.rhis.db.DBManagerMonitoring;

import java.io.IOException;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.JSONArray;

/**
 *
 * @author shahaz
 */
@WebServlet(name = "UnionJsonProvider", urlPatterns = {"/UnionJsonProvider"})
public class UnionJsonProvider extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String upazilaId = request.getParameter("upazilaId");
        String zillaId = request.getParameter("zilaId");
        String where="where zillaid = " + zillaId + " and upazilaid = " + upazilaId;
        
        String action = Utility.getParam("action", "", request);
        String table = action.equals("municipality")?"reporting_units" :"unions";
        
        
        try {
            DBManagerMonitoring db = new DBManagerMonitoring();
            ResultSet result = db.select("select distinct zillaid, upazilaid, unionid, unionnameeng, unionname  from "+table+"  " + where + " ORDER BY unionnameeng ASC");
            
            JSONArray json = Convertor.convertResultSetIntoJSON(result);
            response.setContentType("text/plain;charset=UTF-8");
            response.getWriter().write(json.toString());
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        }
    }
}
