package com.rhis.jsonProviders.dashboard;

import bd.govt.dgfp.meetingManagement.MeetingNotice;
import com.emis.service.Service;
import com.emis.utility.Convertor;
import com.emis.utility.Utility;
import com.rhis.db.DBManagerDistrict;
import com.rhis.db.DBManagerMonitoring;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.json.JSONArray;
import org.json.JSONObject;

/**
 *
 * @author Helal
 */
@WebServlet(name = "User", urlPatterns = {"/api/user"})
public class User extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        try {
            String id = "";
            HttpSession session = request.getSession();
            id = (String) session.getAttribute("username");

            if (request.getParameter("userid") != null) {
                id = request.getParameter("userid");
            }

            String sql = "SELECT userid, uname, active, admin, userlevel, cname userlevelname, credate, \n" +
                            "       divid, zillaid, upazilaid, unionid, villageid, name, email, designation, designame, \n" +
                            "       lu.provtype, designation_provtype\n" +
                            "FROM public.loginuser lu\n" +
                            "left join web_userdesignation ud on lu.designation = ud.id\n" +
                            "left join codelist cl on lu.userlevel = cl.code\n" +
                            "where userid ='"+id+"' and typename = 'UserLevel'";

            DBManagerMonitoring db = new DBManagerMonitoring();
            ResultSet result = db.select(sql);
            JSONArray json = Convertor.convertResultSetIntoJSON(result);
            response.setContentType("text/plain;charset=UTF-8");
            response.getWriter().write(json.toString());

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write(new Utility().errorResponse());
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

}
