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
@WebServlet(urlPatterns = {"/PartialPRSbyFWV"})
public class PartialPRSbyFWV extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("submenu", "PartialPRSbyFWV");
        request.setAttribute("menu", "MANAGEMENT");
        RequestDispatcher dispatcher = request.getRequestDispatcher("WEB-INF/jsp/management/PartialPRSbyFWV.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //ObjectMapper mapper = new ObjectMapper();
        //mapper.writeValue(response.getOutputStream(), meta);
        //?zillaid=69&providerid=693066
        String providerid = request.getParameter("providerid");
        int zillaid = Integer.parseInt(request.getParameter("zillaid"));
        String action = request.getParameter("action");
        if (action.equals("getVillage")) {
            String query = "select distinct zillaid,upazilaid,unionid,mouzaid,villageid,upazilaname,unionname,mouzaname,villagename from studyareavillagev join providerarea using(zillaid,upazilaid,unionid,mouzaid,villageid) where providerid=%s;";
            query = String.format(query, providerid);
            DBManagerDistrict db = new DBManagerDistrict(zillaid);
            ResultSet result = db.select(query);
            JSONArray json;
            try {
                json = Convertor.toJSON(result);
            } catch (Exception ex) {
                json = new JSONArray();
                System.out.println(ex.getMessage());
            }
            response.setContentType("text/plain;charset=UTF-8");
            response.getWriter().write(json.toString());
        }

    }
}
