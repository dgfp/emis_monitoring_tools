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
 * @author Nil_27
 */
@WebServlet(name = "ProviderJsonData", urlPatterns = {"/ProviderJsonData"})
public class ProviderJsonData extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    private String executeSelect(String query,String districtId) {

        DBManagerDistrict db = new DBManagerDistrict(Integer.parseInt(districtId));
        ResultSet result = db.select(query);
        JSONArray json = new JSONArray();
        try {
            json = Convertor.convertResultSetIntoJSON(result);
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        }
        return json.toString();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String districtId = request.getParameter("districtId");

        String upazilaId = request.getParameter("upazilaId");

        String unionId = request.getParameter("unionId");

        System.out.println(districtId);
        String condition = null;

        if (upazilaId.length() == 0 && unionId.length() == 0) {
            condition = "WHERE zillaid = " + districtId;
        } else if (unionId.length() == 0) {
            condition = "WHERE zillaid=" + districtId + " AND  upazilaid=" + upazilaId;

        } else {
            condition = "WHERE zillaid=" + districtId + " AND  upazilaid=" + upazilaId + " AND unionid=" + unionId;
        }

        String query = "select providerid, provname, providertype.provtype, providertype.typename, devicesetting from providerdb \n" +
        "join providertype on providertype.provtype=providerdb.provtype "+ condition +" and providerdb.provtype=3 order by provname asc";

        String jsonString = executeSelect(query,districtId);
        response.setContentType("text/plain;charset=UTF-8");
        response.getWriter().write(jsonString);

    }
}
