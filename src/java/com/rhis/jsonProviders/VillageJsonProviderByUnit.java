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
@WebServlet(name = "VillageJsonProviderByUnit", urlPatterns = {"/VillageJsonProviderByUnit"})
public class VillageJsonProviderByUnit extends HttpServlet {
    
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String districtId = request.getParameter("zilaId");
        String upazilaId = request.getParameter("upazilaId");
        String unionId = request.getParameter("unionId");
         String unitId = request.getParameter("unitId");

        try {

            DBManagerDistrict db = new DBManagerDistrict(Integer.parseInt(districtId));

//            ResultSet resultOld = db.select("select distinct v.mouzaid, v.villageid, v.villagenameeng from public.providerarea p inner join  public.village v on  \n" +
//                            "(p.zillaid=v.zillaid) and (p.upazilaid=v.upazilaid) and (p.unionid=v.unionid) and (p.mouzaid=v.mouzaid) and (p.villageid=v.villageid) \n" +
//                            "where p.zillaid="+districtId+" and p.upazilaid="+upazilaId+" and p.unionid="+unionId+" and p.provtype=3 and p.fwaunit="+unitId);
//            
            
        ResultSet result = db.select("select distinct v.mouzaid, v.villageid, v.villagenameeng from public.providerarea p \n" +
        "inner join  public.village v on p.zillaid=v.zillaid and p.upazilaid=v.upazilaid and p.unionid=v.unionid and p.mouzaid=v.mouzaid and p.villageid=v.villageid \n" +
        "where p.zillaid="+districtId+" and p.upazilaid="+upazilaId+" and p.unionid="+unionId+" and p.provtype=3 and p.fwaunit="+unitId);
            
            

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
