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
@WebServlet(name = "MouzaJsonProvider", urlPatterns = {"/MouzaJsonProvider"})
public class MouzaJsonProvider extends HttpServlet {


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            String districtid = request.getParameter("zilaId");
            String upazilaid = request.getParameter("upazilaId");
            String unionid = request.getParameter("unionId");

            try {

                DBManagerMonitoring db = new DBManagerMonitoring();

                ResultSet result = db.select("SELECT MOUZAID, MOUZANAMEENG, MOUZANAME FROM public.Mouza where ZILLAID="+districtid+" and UPAZILAID="+upazilaid+" and UNIONID="+unionid);

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
