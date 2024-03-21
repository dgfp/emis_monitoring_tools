package com.emis.management;

import com.emis.utility.Convertor;
import com.emis.beans.Response;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.rhis.db.DBManagerDistrict;
import com.rhis.db.DBManagerMonitoring;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.JSONArray;

/**
 *
 * @author Rahen
 */
@WebServlet(urlPatterns = {"/FreeFloatingHousehold"})
public class FreeFloatingHousehold extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("submenu", "FreeFloatingHousehold");
        request.setAttribute("menu", "MANAGEMENT");
        RequestDispatcher dispatcher = request.getRequestDispatcher("WEB-INF/jsp/management/FreeFloatingHousehold.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //ObjectMapper mapper = new ObjectMapper();
        //mapper.writeValue(response.getOutputStream(), meta);
        //?zillaid=69&providerid=93659

        String providerid = request.getParameter("providerid");
        int zillaid = Integer.parseInt(request.getParameter("zillaid"));
        String action = request.getParameter("action");
        String query = "";

        System.out.println("HELAL::" + action);

        DBManagerDistrict db = new DBManagerDistrict(zillaid);
        if (action.equals("getHousehold")) {
            query = "select * from household h where (zillaid,upazilaid,unionid,mouzaid,villageid) IN (SELECT %s,%s,%s,%s,%s) and providerid=%s;";
            query = String.format(query, zillaid, request.getParameter("upazilaid"), request.getParameter("unionid"), request.getParameter("mouzaid"), request.getParameter("villageid"), providerid);
            ResultSet result = db.select(query);
            JSONArray json;
            try {
                json = Convertor.toJSON(result);
            } catch (Exception ex) {
                json = new JSONArray();
                System.out.println("toJSON: " + action + ": " + ex.getMessage());
            }
            response.setContentType("text/plain;charset=UTF-8");
            response.getWriter().write(json.toString());

        }

        if (action.equals("getHouseholds")) {
            query = "select * from web_free_floating_household();";
            //query = String.format(query, providerid, zillaid);
            String json=db.one(query,"data");
            response.setContentType("text/plain;charset=UTF-8");
            response.getWriter().write(json);
        }

        System.out.println("query: " + action + ": " + query);
    }
}
