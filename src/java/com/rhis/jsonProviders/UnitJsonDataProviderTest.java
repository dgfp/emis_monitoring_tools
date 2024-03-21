package com.rhis.jsonProviders;

import com.emis.utility.Convertor;
import com.rhis.db.DBManagerDistrict;
import com.rhis.db.DBManagerDistrict;
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
@WebServlet(name = "UnitJsonDataProviderTest", urlPatterns = {"/UnitJsonDataProviderTest"})
public class UnitJsonDataProviderTest extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String districtid = request.getParameter("districtId"),
                    upazilaid = request.getParameter("upazilaId"),
                    unionid = request.getParameter("unionId");
            //System.out.println("mannanzillaid"+request.getParameter("districtId"));
            String unit = (String) request.getSession(false).getAttribute("unit");
            String where = "";
            if (unit != null) {
                where = " and u.unit='" + unit + "'";
            }

            //System.out.println("SELECT unitid, ucode, uname, unameban FROM unit_master u join fwaunit f on u.unit = f.ucode  where zillaid="+districtid+" and upazilaid="+upazilaid+" and reporting_unionid = "+unionid+" "+where+" order by ucode");
            ResultSet result = new DBManagerDistrict(Integer.parseInt(districtid)).select("SELECT unitid, ucode, uname, unameban FROM unit_master u join fwaunit f on u.unit = f.ucode  where zillaid=" + districtid + " and upazilaid=" + upazilaid + " and reporting_unionid = " + unionid + " " + where + " order by ucode");
            JSONArray json = Convertor.convertResultSetIntoJSON(result);
            response.setContentType("text/plain;charset=UTF-8");
            response.getWriter().write(json.toString());

        } catch (Exception ex) {
            ex.printStackTrace();
            System.out.println(ex.getMessage());
        }
    }

}
