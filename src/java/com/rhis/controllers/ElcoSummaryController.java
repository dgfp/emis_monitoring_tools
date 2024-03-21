package com.rhis.controllers;

import com.emis.utility.Convertor;
import com.rhis.db.DBManagerDistrict;
import java.io.IOException;
import java.sql.ResultSet;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.JSONArray;

/**
 *
 * @author Rashed
 */
@WebServlet(name = "ElcoSummaryController", urlPatterns = {"/elco_summary"})
public class ElcoSummaryController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        RequestDispatcher view = request.getRequestDispatcher("WEB-INF/jsp/service/elco_summary.jsp");
        view.forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String districtId = request.getParameter("districtId");

        String upazilaId = request.getParameter("upazilaId").length() == 0 ? "%" : request.getParameter("upazilaId");

        String unionId = request.getParameter("unionId").length() == 0 ? "%" : request.getParameter("unionId");

        String query = "SELECT  * from fn_ElcoByProvider_Sum('" + districtId + "','" + upazilaId + "','" + unionId + "')";

        try {

            DBManagerDistrict db = new DBManagerDistrict(Integer.parseInt(districtId));

            ResultSet result = db.select(query);

            JSONArray json = Convertor.convertResultSetIntoJSON(result);

            response.setContentType("text/plain;charset=UTF-8");

            System.out.println(json.toString());
            response.getWriter().write(json.toString());

        } catch (Exception ex) {
            ex.getMessage();
        }
    }
}
