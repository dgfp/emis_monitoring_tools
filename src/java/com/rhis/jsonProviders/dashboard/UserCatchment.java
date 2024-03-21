/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.rhis.jsonProviders.dashboard;

import com.emis.utility.Convertor;
import com.emis.utility.Utility;
import com.rhis.db.DBManagerMonitoring;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.json.JSONArray;

/**
 *
 * @author Helal
 */
@WebServlet(name = "UserCatchment", urlPatterns = {"/api/user-catchment"})
public class UserCatchment extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        try {
            String id = "";
            HttpSession session = request.getSession();
            id = (String) session.getAttribute("username");

            if (request.getParameter("userid") != null) {
                id = request.getParameter("userid");
            }

            String sql = "SELECT lu.userid, lu.divid, d.divisioneng, lu.zillaid, zillanameeng, lu.upazilaid ,upazilanameeng, lu.unionid, unionnameeng\n"
                    + "FROM public.loginuser lu\n"
                    + "left join division d on lu.divid = d.id\n"
                    + "left join zilla z on lu.zillaid = z.zillaid\n"
                    + "left join upazila upz on lu.zillaid = upz.zillaid and lu.upazilaid = upz.upazilaid\n"
                    + "left join unions un on lu.zillaid = un.zillaid and lu.upazilaid = un.upazilaid and lu.unionid = un.unionid\n"
                    + "where lu.userid ='" + id + "'";

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
}
