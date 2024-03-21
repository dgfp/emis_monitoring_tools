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
@WebServlet(name = "ProviderTypeJsonProvider", urlPatterns = {"/providerTypeJsonProvider"})
public class ProviderTypeJsonProvider extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String districtId = request.getParameter("districtId");
        try {
            DBManagerDistrict db = new DBManagerDistrict(Integer.parseInt(districtId));
            ResultSet result = db.select("select provtype, typename from public.providertype where provtype not in (1,2,6,8,9,11,12,16,101)");
            //System.out.println("mn"+result);
            response.setContentType("text/plain;charset=UTF-8");
            response.getWriter().write(Convertor.convertResultSetIntoJSON(result).toString());
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        }
    }
}
