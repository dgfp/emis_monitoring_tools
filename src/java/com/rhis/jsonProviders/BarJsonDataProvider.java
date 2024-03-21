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
@WebServlet(name = "BarJsonDataProvider", urlPatterns = {"/barjsondataprovider"})
public class BarJsonDataProvider extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            DBManagerMonitoring db = new DBManagerMonitoring();
            String query = "select code as id, cname as name  FROM codelist \n"
                    + "WHERE typename='bar' ORDER BY code ASC";
            ResultSet result = db.select(query);
            JSONArray json = Convertor.convertResultSetIntoJSON(result);
            response.setContentType("text/plain;charset=UTF-8");
            response.getWriter().write(json.toString());
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        }
    }
}
