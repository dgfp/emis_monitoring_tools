package com.rhis.jsonProviders;

import com.emis.utility.Convertor;
import com.rhis.db.DBManagerDistrict;
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
@WebServlet(name = "ProviderJsonProviderByUpazila", urlPatterns = {"/ProviderJsonProviderByUpazila"})
public class ProviderJsonProviderByUpazila extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
            String zillaid = request.getParameter("zillaid");
            String upazilaId = request.getParameter("upazilaId");
            

            try {
                DBManagerDistrict db = new DBManagerDistrict(Integer.parseInt(zillaid));
                ResultSet result = db.select("select providerid, provname from providerdb where zillaid = "+zillaid+" and upazilaid = "+upazilaId+" and provtype = 10 ");
                JSONArray json = Convertor.convertResultSetIntoJSON(result);
                response.setContentType("text/plain;charset=UTF-8");
                response.getWriter().write(json.toString());
            } catch (Exception ex) {
                System.out.println(ex.getMessage());
            }
    }
}
