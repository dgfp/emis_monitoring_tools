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
@WebServlet(name = "ProviderJsonProviderByUnion_mis2", urlPatterns = {"/ProviderJsonProviderByUnion_mis2"})
public class ProviderJsonProviderByUnion_mis2 extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String zilaId = request.getParameter("zilaId");
        String upazilaId = request.getParameter("upazilaId");
        String unionId = request.getParameter("unionId");

        String providerCode = (String) request.getSession(false).getAttribute("providerCode");
        String userLevel = (String) request.getSession(false).getAttribute("userLevel");
        String where = "";
        System.out.println("CODE: " + providerCode + " Level: " + userLevel + " ``````````````````````````````````````````````````");
        if (providerCode != null && userLevel.equals("7")) {
            where = " and providerid = " + providerCode;
        }

        try {
            DBManagerDistrict db = new DBManagerDistrict(Integer.parseInt(zilaId));
            String sql  = "select * from providerdb where providerid = (select distinct supervisorcode from providerdb p join providerarea pa using (providerid) where pa.zillaid = " + zilaId + " and pa.upazilaid = " + upazilaId + " and pa.unionid = " + unionId + " and p.unionid = " + unionId + " and  pa.provtype=3 and active=1);";
            //ResultSet result = db.select("select * from providerdb where zillaid = " + zilaId + " and upazilaid = " + upazilaId + " and unionid = " + unionId + " and provtype = 10 " + where);
            ResultSet result = db.select(sql);
//            if (result.wasNull()) {
//                String sql = "";
//            }else{
//                System.out.println("Not null");
//            }
            JSONArray json = Convertor.convertResultSetIntoJSON(result);
            System.out.println(json);
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
