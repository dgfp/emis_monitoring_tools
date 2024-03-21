package com.emis.dashboard;

import com.emis.dashboard.*;
import com.emis.utility.Convertor;
import com.emis.beans.Response;
import com.emis.utility.Utility;
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
@WebServlet(urlPatterns = {"/maps"})
public class Map extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("submenu", "Map");
        request.setAttribute("menu", "Dashboard");
        RequestDispatcher dispatcher = request.getRequestDispatcher("WEB-INF/jsp/dashboard/Map.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //ObjectMapper mapper = new ObjectMapper();
        //mapper.writeValue(response.getOutputStream(), meta);
        //?zillaid=69&providerid=93659
        String divid = Utility.getParam("divid","0",request);
        String zillaid = Utility.getParam("zillaid","0",request);
        String upazilaid = Utility.getParam("upazilaid","0",request);
        String unionid = Utility.getParam("unionid","0",request);
        String action = Utility.getParam("action","0",request);
        
        String query = "SELECT data from __map_division();";
        System.out.println("Action::" + action);

        DBManagerDistrict db = new DBManagerDistrict(100);
        
        
        if (action.equals("getZilla")) {
            query = "SELECT data from __map_zilla(%s);";
            query = String.format(query,divid);
        }
        
        if (action.equals("getUpazila")) {
            query = "SELECT data from __map_upazila(%s);";
            query = String.format(query,zillaid);
        }
        
        if (action.equals("getUnions")) {
            query = "SELECT data from __map_unions(%s,%s);";
            query = String.format(query,zillaid,upazilaid);
        }
        
        
        String json = db.one(query, "data");
        response.setContentType("text/plain;charset=UTF-8");
        response.getWriter().write(json);

        System.out.println("query: " + action + ": " + query);
    }
}
