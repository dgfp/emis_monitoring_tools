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
@WebServlet(name = "EPIJsonProvider", urlPatterns = {"/EPIJsonProvider"})
public class EPIJsonProvider extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            String districtId = request.getParameter("districtId");
            String upazilaId = request.getParameter("upazilaId");
            String unionId = request.getParameter("unionId");
            String wardOld = request.getParameter("wardOld");
            String subBlock = request.getParameter("subBlock");
            String year = request.getParameter("year");
            
            String action = request.getParameter("action");
            String query=null;
            
            if (action.equals("getExistingEPICenterName")) {
                query="select centername, centertype, khananofrom, khananoto \n" +
                "from epischedulerupdate  \n"+
                 "where zillaid="+districtId+" and upazilaid="+upazilaId+" and unionid="+unionId+" and wardold="+wardOld+" and subblockid="+subBlock+" limit 1";
            }
            
            try {
                DBManagerDistrict db = new DBManagerDistrict(Integer.parseInt(districtId));
                ResultSet result = db.select(query);
                JSONArray json = Convertor.convertResultSetIntoJSON(result);
                response.setContentType("text/plain;charset=UTF-8");
                response.getWriter().write(json.toString());
                
            } catch (Exception ex) {
                ex.getMessage();
            }
    }

}
