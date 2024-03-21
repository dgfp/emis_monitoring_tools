package com.emis.jsonProviderByUser;

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
@WebServlet(name = "DivisionJsonProviderByUser", urlPatterns = {"/DivisionJsonProviderByUser"})
public class DivisionJsonProviderByUser extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
                    try {
                String division = (String) request.getSession(false).getAttribute("division");
                
                String where="where is_implemented=1";

                if(!(division==null || division=="0")){
                    where ="where is_implemented=1 and id='"+division+"'";
                }

                DBManagerMonitoring db = new DBManagerMonitoring();
                ResultSet result= db.select("SELECT distinct id, division, divisioneng FROM public.implemented_div_zila "+where+" order by divisioneng asc");
                
                
                    //System.out.println("DIV______________________SELECT distinct id, division, divisioneng FROM public.implemented_div_zila "+where+" order by divisioneng asc");

                JSONArray json = Convertor.convertResultSetIntoJSON(result);
                response.setContentType("text/plain;charset=UTF-8");
                response.getWriter().write(json.toString());
            } catch (Exception ex) {
                System.out.println(ex.getMessage());
            }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        

        
    }

}
