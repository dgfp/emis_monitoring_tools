
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


@WebServlet(name = "PPRS_ReportType_JsonProvider", urlPatterns = {"/pPRS_ReportType_JsonProvider"})
public class PPRS_ReportType_JsonProvider extends HttpServlet {

    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            DBManagerMonitoring db = new DBManagerMonitoring();
            ResultSet result = db.select("SELECT * FROM public.\"CodeList\" WHERE \"TypeName\"='UserLevel' and \"isVisible\"=1");
                                   
            JSONArray json = Convertor.convertResultSetIntoJSON(result);
            response.setContentType("text/plain;charset=UTF-8");
            response.getWriter().write(json.toString());
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        }
        
    }
}
