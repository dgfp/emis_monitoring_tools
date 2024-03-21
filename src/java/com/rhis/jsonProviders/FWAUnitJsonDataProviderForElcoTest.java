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
@WebServlet(name = "FWAUnitJsonDataProviderForElcoTest", urlPatterns = {"/FWAUnitJsonDataProviderForElcoTest"})
public class FWAUnitJsonDataProviderForElcoTest extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
            String districtid= request.getParameter("districtId");
            String upazilaid= request.getParameter("upazilaId");
            String unionid= request.getParameter("unionId");
            
            String unit =  (String) request.getSession(false).getAttribute("unit");
            String where="";
            if(unit!=null){
                    where =" and u.ucode='"+unit+"'";
            }

            try {

                DBManagerDistrict db = new DBManagerDistrict(Integer.parseInt(districtid));

                ResultSet result = db.select("SELECT u.ucode, (select uname from fwaunit f where f.ucode=u.ucode), (select unameban from fwaunit f where f.ucode=u.ucode)\n" +
                "FROM public.unit_details ud join unit u using(unitid) where ud.zillaid="+districtid+" and ud.upazilaid="+upazilaid+" and unionid="+unionid+" "+where);

                JSONArray json = Convertor.convertResultSetIntoJSON(result);
                response.setContentType("text/plain;charset=UTF-8");
                response.getWriter().write(json.toString());

            } catch (Exception ex) {
                System.out.println(ex.getMessage());
            }
    }

}
