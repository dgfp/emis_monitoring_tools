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
 * @author Helal | m.helal.k@gmail.com
 */
@WebServlet(name = "GetProviderByUnit", urlPatterns = {"/GetProviderByUnit"})
public class GetProviderByUnit extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
            String zilaId = request.getParameter("zilaId");
            String upazilaId = request.getParameter("upazilaId");
            String unionId = request.getParameter("unionId");
            String unitId = request.getParameter("unitId");
            
            String providerCode =  (String) request.getSession(false).getAttribute("providerCode");
            String userLevel =  (String) request.getSession(false).getAttribute("userLevel");
            String username =  (String) request.getSession(false).getAttribute("username");
            String where="";
            if(providerCode!=null && userLevel=="7"){
                    //Temporary Soultions for tab view
                    if(!username.equals("fpi_provider"))
                        where =" and providerid = "+providerCode;
            }

            try {
                DBManagerDistrict db = new DBManagerDistrict(Integer.parseInt(zilaId));
                ResultSet result = db.select("select distinct p.providerid,p.provname from providerarea pa join providerdb p using (zillaid,upazilaid,providerid,provtype)\n" +
                "where (zillaid,upazilaid,fwaunit) in (select "+zilaId+", "+upazilaId+", "+unitId+") \n" +
                "and p.unionid = any(array(select unionids from reporting_units where zillaid = "+zilaId+" and upazilaid= "+upazilaId+" and unionid="+unionId+" and fwaunit="+unitId+"))\n" +
                "and active=1 and provtype=3 "+where);
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
