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
 * @author Helal
 */
@WebServlet(name = "DistrictJsonProviderDGFP", urlPatterns = {"/DistrictJsonProviderDGFP"})
public class DistrictJsonProviderDGFP extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        int divisionId = Integer.parseInt(request.getParameter("divisionId"));

        try {
            DBManagerMonitoring db = new DBManagerMonitoring();
            
            ResultSet result = db.select("select distinct zillaid, zillaname, zillanameeng from implemented_div_zila where id::text like '" + divisionId+ "' and is_implemented=1 and is_paperless=1 and zillaid not in (991) order by zillanameeng asc");
//            SELECT distinct zillaid, zillaname, zillanameeng 
//FROM public.implemented_div_zila where id='30' and zillaid=66  and is_implemented=1 order by zillanameeng asc
        
            JSONArray json = Convertor.convertResultSetIntoJSON(result);
            response.setContentType("text/plain;charset=UTF-8");
            response.getWriter().write(json.toString());
        } catch (Exception ex) {
           System.out.println(ex.getMessage());
        }
    }
}
