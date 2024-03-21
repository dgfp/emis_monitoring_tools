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
import org.json.JSONObject;

/**
 *
 * @author Helal
 */
@WebServlet(name = "AllUnitJosnProvider", urlPatterns = {"/all-unit-josn-provider"})
public class AllUnitJosnProvider extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/plain;charset=UTF-8");
        try {
            DBManagerMonitoring db = new DBManagerMonitoring();
            ResultSet rs = db.select("select * from fwaunit order by ucode");
            JSONArray json = Convertor.toJSON(rs);
            response.getWriter().write(json.toString());
        } catch (Exception ex) {
            response.getWriter().write(ex.getMessage());
        }
    }
}
