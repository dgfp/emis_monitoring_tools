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
@WebServlet(name = "DistrictJsonProviderByUser", urlPatterns = {"/DistrictJsonProviderByUser"})
public class DistrictJsonProviderByUser extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            DBManagerMonitoring db = new DBManagerMonitoring();
            String division = (String) request.getSession(false).getAttribute("division");
            String district =  (String) request.getSession(false).getAttribute("district");
            
            String where="where id='"+division+"'";
            
            if(district!=null){
                if(!district.equals("0")){
                    where = "where id='"+division+"' and zillaid="+district;
                }
            }
            
            ResultSet result = db.select("select distinct zillaid, zillaname, zillanameeng  from implemented_div_zila "+where+" and is_implemented=1 order by zillanameeng asc");
            JSONArray json = Convertor.convertResultSetIntoJSON(result);
            
            //SELECT distinct zillaid, zillaname, zillanameeng 
            //FROM public.implemented_div_zila where id='30' and zillaid=66  and is_implemented=1 order by zillanameeng asc
            
            response.setContentType("text/plain;charset=UTF-8");
            response.getWriter().write(json.toString());
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        }
    }
}
