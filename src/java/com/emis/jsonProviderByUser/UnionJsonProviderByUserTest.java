/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.emis.jsonProviderByUser;

import com.emis.utility.Convertor;
import com.emis.utility.Utility;
import com.rhis.db.DBManagerDistrict;
import java.io.IOException;
import java.io.PrintWriter;
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
@WebServlet(name = "UnionJsonProviderByUserTest", urlPatterns = {"/UnionJsonProviderByUserTest"})
public class UnionJsonProviderByUserTest extends HttpServlet {

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

        String where = "where zillaid=" + district + " and upazilaid=" + upazila;

        if (union != null) {
            if (!union.equals("0")) {
                where = "where zillaid=" + district + " and upazilaid=" + upazila + " and reporting_unionid=" + union;
            }
        }

        try {
            //DBManagerMonitoring db = new DBManagerMonitoring();
            //DBManagerDistrict db = new DBManagerDistrict(Integer.parseInt(district));
            String sql = "SELECT reporting_unionid unionid, unionname, unionnameeng FROM public.reporting_union " + where + " ORDER BY reporting_unionid ASC ";

            if (designation.equals("FWA")) {
                String unit = (String) request.getSession(false).getAttribute("unit");
                
                sql = "select um.reporting_unionid unionid, ru.unionname, ru.unionnameeng from providerarea_unit pu join unit_master um using(unitid) join reporting_union ru\n" +
                "on um.zillaid = ru.zillaid and um.upazilaid = ru.upazilaid and um.reporting_unionid = ru.reporting_unionid where pu.providerid = "+providerCode+" and um.unit = "+unit+" order by um.reporting_unionid";
            }

            if (designation.equals("FPI")) {
                if (!Utility.isNumeric(username)) {
                    username = providerCode;
                }
                //sql = "select distinct unionid, name_union(zillaid, upazilaid, unionid) unionname, name_union_eng(zillaid, upazilaid, unionid) unionnameeng FROM providerdb where supervisorcode = " + username + " and active = 1 order by unionname";
                sql = "select ru.reporting_unionid unionid, unionname, unionnameeng from reporting_union_fpi ruf join reporting_union ru\n"
                        + "on ruf.zillaid = ru.zillaid and ruf.upazilaid = ru.upazilaid and ruf.reporting_unionid = ru.reporting_unionid where ruf.providerid = " + username + " order by ru.reporting_unionid";
            }

            DBManagerDistrict db = new DBManagerDistrict(Integer.parseInt(district));
            ResultSet result = db.select(sql);
            JSONArray json = Convertor.convertResultSetIntoJSON(result);

            if (json.length() == 0) {
                if (!Utility.isNumeric(username)) {
                    username = providerCode;
                }
                sql = "select ru.reporting_unionid unionid, unionname, unionnameeng from reporting_union_fpi ruf join reporting_union ru\n"
                        + "on ruf.zillaid = ru.zillaid and ruf.upazilaid = ru.upazilaid and ruf.reporting_unionid = ru.reporting_unionid where ruf.providerid = " + username + " order by ru.reporting_unionid";
                //sql = "select unionid, name_union(zillaid,upazilaid,unionid) unionname, name_union_eng(zillaid,upazilaid,unionid) unionnameeng from providerdb where providerid = " + username;
                ResultSet rs = new DBManagerDistrict(Integer.parseInt(district)).select(sql);
                json = Convertor.convertResultSetIntoJSON(rs);
            }
            // WHEN FWA RECEIVES MULTIPLE UNION
            if(json.length() > 1 && designation.equals("FWA")){
                String unit = (String) request.getSession(false).getAttribute("unit");
                
                sql = "select um.reporting_unionid unionid, ru.unionname, ru.unionnameeng from providerarea_unit pu join unit_master um using(unitid) join reporting_union ru\n" +
                "on um.zillaid = ru.zillaid and um.upazilaid = ru.upazilaid and um.reporting_unionid = ru.reporting_unionid where pu.providerid = "+providerCode + " and " +  union + "= ANY(ru.unionids)"+" and um.unit = "+unit+" order by um.reporting_unionid";
                
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
