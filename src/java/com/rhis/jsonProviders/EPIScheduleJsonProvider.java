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
@WebServlet(name = "EPIScheduleJsonProvider", urlPatterns = {"/EPIScheduleJsonProvider"})
public class EPIScheduleJsonProvider extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String districtId = request.getParameter("district");
        String upazilaId = request.getParameter("upazila");
        String unionId = request.getParameter("union");
        String wardId = request.getParameter("ward");
        String subblockId = request.getParameter("subblock");
        String year = request.getParameter("year");
        
        try {
            DBManagerDistrict db = new DBManagerDistrict(Integer.parseInt(districtId));
            //ResultSet result = db.select("select \"schedulerId\",\"scheduleDate\",\"centerName\" from \"epiSchedulerUpdate\" where \"Dist\"="+Integer.parseInt(districtId)+" and \"Upz\"="+Integer.parseInt(upazilaId)+" and \"UN\"="+Integer.parseInt(unionId)+" and \"wordOld\"="+Integer.parseInt(wardId)+" and \"subBlockId\"="+Integer.parseInt(subblockId)+" and \"scheduleYear\"="+Integer.parseInt(year));
            //ResultSet result = db.select("select * from \"epiSchedulerUpdate\" where \"Dist\"="+Integer.parseInt(districtId)+" and \"Upz\"="+Integer.parseInt(upazilaId)+" and \"UN\"="+Integer.parseInt(unionId)+" and \"wordOld\"="+Integer.parseInt(wardId)+" and \"subBlockId\"="+Integer.parseInt(subblockId)+" and \"scheduleYear\"="+Integer.parseInt(year));
            
            String sql="select e.zillaid, e.upazilaid, e.unionid, e.wardold, e.subblockid, e.scheduleyear, \n" +
                "e.schedulerid, e.scheduledate, e.centername,s.vaccinedate,s.providerid\n" +
                "from public.epischedulerupdate e\n" +
                "join sessionmasterupdate s \n" +
                "on (e.zillaid= s.zillaid and  e.upazilaid= s.upazilaid and  e.unionid= s.unionid and   e.wardold = s.wardold and   \n" +
                "e.subblockid= s.subblockid and   e.scheduleyear= s.scheduleyear and   e.schedulerid=s.schedulerid)  \n" +
                "where e.zillaid="+Integer.parseInt(districtId)+"  and e.upazilaid= "+Integer.parseInt(upazilaId)+" and e.unionid="+Integer.parseInt(unionId)+" and e.wardold= "+Integer.parseInt(wardId)+"  and e.subblockid= "+Integer.parseInt(subblockId);
            System.out.println(sql);
            
            String sql_ = "SELECT scheduledate as vaccinedate, centername  FROM epischedulerupdate where zillaid="+districtId+" and upazilaid="+upazilaId+" and unionid="+unionId+" \n" +
                                "and wardold="+wardId+" and scheduleyear="+year+" and subblockid="+subblockId+" and scheduledate < now()";
            
            ResultSet result = db.select(sql);
          
            
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
