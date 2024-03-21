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
 * @author Helal | m.helal.k@gmail.com
 */
@WebServlet(name = "ProviderJsonProviderByUnitTest", urlPatterns = {"/ProviderJsonProviderByUnitTest"})
public class ProviderJsonProviderByUnitTest extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String zilaId = request.getParameter("zilaId"),
                    upazilaId = request.getParameter("upazilaId"),
                    unionId = request.getParameter("unionId"),
                    unitId = request.getParameter("unitId");

            String providerCode = (String) request.getSession(false).getAttribute("providerCode");
            String userLevel = (String) request.getSession(false).getAttribute("userLevel");
            String username = (String) request.getSession(false).getAttribute("username");
            String where = "";
            if (providerCode != null && userLevel == "7") {
                if (!username.equals("fpi_provider")) {
                    where = " and u.providerid = " + providerCode;
                }
            }

            DBManagerDistrict db = new DBManagerDistrict(Integer.parseInt(zilaId));

            String sql = "SELECT u.providerid, p.provname FROM providerarea_unit u \n" +
                            "join providerdb p using(providerid)\n" +
                            "join unit_master um using (unitid)  \n" +
                            "where um.zillaid="+zilaId+" and um.upazilaid="+upazilaId+" and um.reporting_unionid = "+unionId+" and um.unit = "+unitId+" "+where;
            //ResultSet result = db.select("SELECT providerid, provname FROM providerarea_unit u join providerdb using(providerid) where u.zillaid="+zilaId+" and u.upazilaid="+upazilaId+" and reporting_unionid = "+unionId+" and unit = "+unitId+" "+where);
            ResultSet result = db.select(sql);
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
