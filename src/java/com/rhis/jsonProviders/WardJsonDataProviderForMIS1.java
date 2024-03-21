
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
@WebServlet(name = "WardJsonDataProviderForMIS1", urlPatterns = {"/WardJsonDataProviderForMIS1"})
public class WardJsonDataProviderForMIS1 extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
                String provCode = request.getParameter("provCode");
                String districtId = "93";
                    
                try {

                    DBManagerDistrict db = new DBManagerDistrict(Integer.parseInt(districtId));

                    ResultSet result = db.select("select distinct \"Ward\" from public.\"ProviderArea\" where \"provCode\" ="+provCode+"");

                    JSONArray json = Convertor.convertResultSetIntoJSON(result);
                    response.setContentType("text/plain;charset=UTF-8");
                    response.getWriter().write(json.toString());

                } catch (Exception ex) {
                    System.out.println(ex.getMessage());
                }
    }

}
