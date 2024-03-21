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
@WebServlet(name = "FWAUnitJsonDataProviderForMIS1", urlPatterns = {"/FWAUnitJsonDataProviderForMIS1"})
public class FWAUnitJsonDataProviderForMIS1 extends HttpServlet {


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
            String provCode = request.getParameter("provCode");
            try {

                DBManagerMonitoring db = new DBManagerMonitoring();

                ResultSet result = db.select("select distinct u.\"UCode\", u.\"UName\", u.\"UNameBan\" " +
                                                            "from public.\"ProviderArea\" p\n" +
                                                            "inner join public.\"FWAUnit\" u\n" +
                                                            "on p.\"FWAUnit\" = u.\"UCode\" where p.\"provCode\" = "+provCode+"");

                JSONArray json = Convertor.convertResultSetIntoJSON(result);
                response.setContentType("text/plain;charset=UTF-8");
                response.getWriter().write(json.toString());

            } catch (Exception ex) {
                System.out.println(ex.getMessage());
            }
    }


}
