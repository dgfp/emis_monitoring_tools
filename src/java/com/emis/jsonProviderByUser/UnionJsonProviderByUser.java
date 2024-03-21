package com.emis.jsonProviderByUser;

import com.emis.utility.Convertor;
import com.emis.utility.Utility;
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
@WebServlet(name = "UnionJsonProviderByUser", urlPatterns = {"/UnionJsonProviderByUser"})
public class UnionJsonProviderByUser extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        //System.out.println("---------------------------------Try to get here");
        
        String district = (String) request.getSession(false).getAttribute("district");
        String upazila = (String) request.getSession(false).getAttribute("upazila");
        String union = (String) request.getSession(false).getAttribute("union");
        
        String designation = (String) request.getSession(false).getAttribute("designation");
        String providerCode = (String) request.getSession(false).getAttribute("providerCode");
        String username = (String) request.getSession(false).getAttribute("username");
        
        String where="where zillaid="+district+" and upazilaid="+upazila;

        if(union!=null){
            if(!union.equals("0")){
                where="where zillaid="+district+" and upazilaid="+upazila+" and unionid="+union;
            }
        }

        try {
            //DBManagerMonitoring db = new DBManagerMonitoring();
            //DBManagerDistrict db = new DBManagerDistrict(Integer.parseInt(district));
            String sql = "SELECT * FROM public.unions "+where+" ORDER BY unionnameeng ASC ";
            
            if(designation.equals("FPI")){
                if(!Utility.isNumeric(username))
                    username = providerCode;
                
//                sql = "select distinct pa.unionid, name_union(pa.zillaid, pa.upazilaid, pa.unionid) unionname, name_union_eng(pa.zillaid, pa.upazilaid, pa.unionid) unionnameeng FROM public.providerdb p\n" +
//                        "join providerarea pa on p.providerid = pa.providerid where p.supervisorcode = "+username+" and active = 1 order by unionname";
                sql = "select distinct unionid, name_union(zillaid, upazilaid, unionid) unionname, name_union_eng(zillaid, upazilaid, unionid) unionnameeng FROM providerdb where supervisorcode = "+username+" and active = 1 order by unionname";
            }
            
            DBManagerDistrict db = new DBManagerDistrict(Integer.parseInt(district));
            ResultSet result = db.select(sql);
            JSONArray json = Convertor.convertResultSetIntoJSON(result);      
            
            if(json.length()==0){
                sql = "select unionid, name_union(zillaid,upazilaid,unionid) unionname, name_union_eng(zillaid,upazilaid,unionid) unionnameeng from providerdb where providerid = "+username;
                ResultSet rs = new DBManagerDistrict(Integer.parseInt(district)).select(sql);
                json = Convertor.convertResultSetIntoJSON(rs);
            }
            
            response.setContentType("text/plain;charset=UTF-8");
            response.getWriter().write(json.toString());
        } catch (Exception ex) {
           System.out.println(ex.getMessage());
        }
    }
}
