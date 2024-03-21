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

/**
 *
 * @author Helal
 */
@WebServlet(name = "ProviderType", urlPatterns = {"/providertype"})
public class ProviderType extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String districtId = request.getParameter("districtId"), where = " and provtype in (3, 10, 15)";
            if (districtId.equals("991"))
                where = " and provtype in (3, 10)";
            ResultSet result = new DBManagerDistrict(Integer.parseInt(districtId)).select("select provtype, typename from public.providertype where typename not in ('data collector') " + where+" order by provtype");
            response.setContentType("text/plain;charset=UTF-8");
            response.getWriter().write(Convertor.convertResultSetIntoJSON(result).toString());
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        }
    }
}