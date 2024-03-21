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
@WebServlet(name = "FWAUnitJsonDataProviderForElco", urlPatterns = {"/FWAUnitJsonDataProviderForElco"})
public class FWAUnitJsonDataProviderForElco extends HttpServlet {

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

                ResultSet result = db.select("select distinct u.ucode, u.uname, u.unameban  \n" +
                                                            "from public.providerarea p \n" +
                                                            "inner join public.fwaunit u \n" +
                                                            "on p.fwaunit = u.ucode where p.zillaid="+districtid+" and p.upazilaid="+upazilaid+" and p.unionid="+unionid+" and  p.provtype=3 "+where+" and (select active from providerdb where providerid = p.providerid)=1 order by u.ucode");

                JSONArray json = Convertor.convertResultSetIntoJSON(result);
                response.setContentType("text/plain;charset=UTF-8");
                response.getWriter().write(json.toString());

            } catch (Exception ex) {
                System.out.println(ex.getMessage());
            }
    }

}
