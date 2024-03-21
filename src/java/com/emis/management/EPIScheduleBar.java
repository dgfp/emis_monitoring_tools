/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.emis.management;

import com.emis.utility.Convertor;
import com.rhis.db.DBManagerDistrict;
import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.JSONArray;

/**
 *
 * @author ccah
 */
@WebServlet(name = "EPIScheduleBar", urlPatterns = {"/epischedulebar"})
public class EPIScheduleBar extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("WEB-INF/jsp/management/epischedulebar.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        String query = "";
        String divId = request.getParameter("div");
        String districtId = request.getParameter("district");
        String upazilaId = request.getParameter("upazila");
        String year = request.getParameter("year");
        String bar1 = request.getParameter("bar1");
        String bar2 = request.getParameter("bar2");
        String bar3 = request.getParameter("bar3");

        if (action.equalsIgnoreCase("addSchedulebar")) {
            DBManagerDistrict db = new DBManagerDistrict(Integer.parseInt(districtId));
            try {
                int rowCount = 0;
                DBManagerDistrict db1 = new DBManagerDistrict(Integer.parseInt(districtId));
                String query1 = "select count(*) from public.\"epiSessionBar\"\n"
                        + " where  \"Dist\" =" + districtId + " and \"Upazila\"=" + upazilaId + " and \"Year\"=" + year + "  ;";
                Connection con = db1.openConnection();
                Statement stmt = con.createStatement();
                ResultSet rs = stmt.executeQuery(query1);
                int count = 0;
                while (rs.next()) {
                    count = rs.getInt("count");
                }
                if (count < 1) {
                    String query2 = "INSERT INTO public.\"epiSessionBar\"(\n"
                            + "\"Div\", \"Dist\",\"Upazila\",\"Year\",\"Bar1\", \"Bar2\",\"Bar3\") \n"
                            + "VALUES (null," + districtId + ", " + upazilaId + ", " + year + ", " + bar1 + ", " + bar2 + "," + bar3 + ");";

                    rowCount = db.update(query2);
                }
                response.setContentType("text/plain;charset=UTF-8");
                response.getWriter().write(rowCount + "");
            } catch (Exception ex) {
                ex.getMessage();
            }
        }
        if (action.equalsIgnoreCase("getScheduleBar")) {
            String query3 = "SELECT \"Div\", \"Dist\", \"Upazila\", \"Year\", \"Bar1\",b1.\"CName\", \"Bar2\",b2.\"CName\", \"Bar3\",u.\"UPAZILANAME\",z.\"ZILLANAME\" FROM public.\"epiSessionBar\" as  b\n"
                    + "  left join public.\"Upazila\" as u on b.\"Upazila\" = u.\"UPAZILAID\" and b.\"Dist\" = u.\"ZILLAID\"\n"
                    + "  left join public.\"Zilla\" as z on b.\"Dist\" = z.\"ZILLAID\"\n"
                    + "  left join public.\"CodeList\" as b1 on b.\"Bar1\" = cast(b1.\"Code\" as integer)\n"
                    + "  left join public.\"CodeList\" as b2 on b.\"Bar2\" = cast(b2.\"Code\" as integer)\n"
                    + "  where b1.\"TypeName\" = 'bar' and b2.\"TypeName\" = 'bar' "
                    + "and  \"Dist\" = " + districtId + " order by \"Year\" DESC;";

            try {
                DBManagerDistrict db = new DBManagerDistrict(Integer.parseInt(districtId));
                ResultSet result = db.select(query3);
                JSONArray json = Convertor.convertResultSetIntoJSON(result);
                response.setContentType("text/plain;charset=UTF-8");
                System.out.println(json.toString());
                response.getWriter().write(json.toString());
            } catch (Exception ex) {
                ex.getMessage();
            }
        }

    }

}
