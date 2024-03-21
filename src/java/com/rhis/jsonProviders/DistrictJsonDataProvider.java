package com.rhis.jsonProviders;

import com.emis.utility.Convertor;
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
@WebServlet(name = "DistrictJsonDataProvider", urlPatterns = {"/DistrictJsonDataProvider"})
public class DistrictJsonDataProvider extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            DBManagerMonitoring db = new DBManagerMonitoring();
            String where="where is_implemented=1";
            if(request.getParameter("division") != null){
                where="where id='"+request.getParameter("division").toString()+"' and is_implemented=1";
            }
            
            ResultSet result = db.select("select distinct zillaid, zillaname, zillanameeng from implemented_div_zila "+where+" order by zillanameeng asc");
            
            JSONArray json = Convertor.convertResultSetIntoJSON(result);
            response.setContentType("text/plain;charset=UTF-8");
            response.getWriter().write(json.toString());
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        }
    }
}
