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
@WebServlet(name = "FWAUnitJsonDataProviderForMISStatus", urlPatterns = {"/FWAUnitJsonDataProviderForMISStatus"})
public class FWAUnitJsonDataProviderForMISStatus extends HttpServlet {

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
            
//            String unit =  (String) request.getSession(false).getAttribute("unit");
//            String where="";
//            if(unit!=null){
//                    where =" and u.ucode='"+unit+"'";
//            }

            try {

                DBManagerDistrict db = new DBManagerDistrict(Integer.parseInt(districtid));

                ResultSet result = db.select("select u.ucode, u.uname, u.unameban from \n" +
                "	(select distinct a.zillaid, a.upazilaid, a.unionid, a.fwaunit, a.providerid from providerarea a \n" +
                "	where provtype in (3) \n" +
                "	and zillaid = "+districtid+" and upazilaid = "+upazilaid+" and unionid = "+unionid+"\n" +
                "	and fwaunit is not null\n" +
                "	and exists ( select null from providerdb p where p.providerid=a.providerid and p.provtype=a.provtype and p.active=1  ) \n" +
                "	order by fwaunit nulls first)\n" +
                "	p join fwaunit u on p.fwaunit = u.ucode");

                JSONArray json = Convertor.convertResultSetIntoJSON(result);
                response.setContentType("text/plain;charset=UTF-8");
                response.getWriter().write(json.toString());

            } catch (Exception ex) {
                System.out.println(ex.getMessage());
            }
    }

}
