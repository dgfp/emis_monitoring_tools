package com.emis.jsonProviderByUser;

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
@WebServlet(name = "ProviderJsonProviderByUnion_mis2_dgfp", urlPatterns = {"/ProviderJsonProviderByUnion_mis2_dgfp"})
public class ProviderJsonProviderByUnion_mis2_dgfp extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String zilaId = request.getParameter("zilaId");
        String upazilaId = request.getParameter("upazilaId");
        String unionId = request.getParameter("unionId");

        String providerCode = (String) request.getSession(false).getAttribute("providerCode");
        String userLevel = (String) request.getSession(false).getAttribute("userLevel");
        String where = "";
        
        if (providerCode != null && userLevel.equals("7")) {
            where = " and puf.providerid = " + providerCode;
        }

        try {
            DBManagerDistrict db = new DBManagerDistrict(Integer.parseInt(zilaId));
            //String sql  = "select * from providerdb where providerid = (select distinct supervisorcode from providerdb p join providerarea pa using (providerid) where pa.zillaid = " + zilaId + " and pa.upazilaid = " + upazilaId + " and pa.unionid = " + unionId + " and p.unionid = " + unionId + " and  pa.provtype=3 and active=1);";
            
            String sql = "select ruf.providerid, pdb.provname  from reporting_union ru\n" +
                            "left join reporting_union_fpi ruf using (zillaid, upazilaid, reporting_unionid)\n" +
                            "left join providerdb pdb using (providerid)\n" +
                            "where ru.zillaid = "+zilaId+" and ru.upazilaid = "+upazilaId+" and reporting_unionid="+unionId;
           
            
            ResultSet result = db.select(sql);
            JSONArray json = Convertor.convertResultSetIntoJSON(result);
            System.out.println(json);
            response.setContentType("text/plain;charset=UTF-8");
            response.getWriter().write(json.toString());
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }
}
