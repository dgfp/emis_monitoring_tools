package com.rhis.jsonProviders;

import com.emis.utility.Convertor;
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
 * @author shahaz
 */
@WebServlet(name = "UpazilaJsonProviderDGFP", urlPatterns = {"/UpazilaJsonProviderDGFP"})
public class UpazilaJsonProviderDGFP extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int districtId = Integer.parseInt(request.getParameter("districtId"));
            DBManagerDistrict db = new DBManagerDistrict(districtId);
            ResultSet result = db.select("select zillaid, upazilaid, reporting_upazilaid, reporting_upazilanameeng upazilanameeng, reporting_upazilaname upazilaname from reporting_upazila where zillaid = " + districtId + " order by reporting_upazilaid");
            //System.out.println("mn"+result);
            JSONArray json = Convertor.convertResultSetIntoJSON(result);
            response.setContentType("text/plain;charset=UTF-8");
            response.getWriter().write(json.toString());
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }
}
