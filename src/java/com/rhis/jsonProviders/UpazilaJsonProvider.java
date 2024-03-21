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
 * @author shahaz
 */
@WebServlet(name = "UpazilaJsonProvider", urlPatterns = {"/UpazilaJsonProvider"})
public class UpazilaJsonProvider extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int districtId = Integer.parseInt(request.getParameter("districtId"));
        String where="where zillaid  = " + districtId;
        
        try {
            DBManagerMonitoring db = new DBManagerMonitoring();
            //ResultSet result = db.select("select * from upazila " + where + "order by upazilanameeng asc");
            ResultSet result = db.select("select distinct zillaid, upazilaid, upazilaname, upazilanameeng  from implemented_div_zila " + where + " and is_implemented=1 order by upazilanameeng asc");
            JSONArray json = Convertor.convertResultSetIntoJSON(result);
            response.setContentType("text/plain;charset=UTF-8");
            response.getWriter().write(json.toString());
        } catch (Exception ex) {
           System.out.println(ex.getMessage());
        }
    }
}
