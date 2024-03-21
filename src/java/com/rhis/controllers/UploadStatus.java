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

@WebServlet(name = "UploadStatus", urlPatterns = {"/UploadStatus"})
public class UploadStatus extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        RequestDispatcher view = request.getRequestDispatcher("WEB-INF/jsp/upload_status.jsp");
        view.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String districtId = request.getParameter("districtId");
        String upazilaId = request.getParameter("upazilaId").length() == 0 ? "%" : request.getParameter("upazilaId");
        String unionId = request.getParameter("unionId").length() == 0 ? "%" : request.getParameter("unionId");
        String startDate = request.getParameter("startDate");
        String endDate = request.getParameter("endDate");
        String byWho = request.getParameter("byWho");

        System.out.println(byWho);

        String query = "";

        if (byWho.equalsIgnoreCase("provider")) {

            query = "select * from sp_providervisitstatus('"
                    + districtId
                    + "','"
                    + upazilaId
                    + "','"
                    + unionId
                    + "','"
                    + startDate
                    + "','"
                    + endDate
                    + "')";

        } else if (byWho.equalsIgnoreCase("union")) {

            query = "select * from sp_unionvisitstatus('"
                    + districtId
                    + "','"
                    + upazilaId
                    + "','"
                    + unionId
                    + "','"
                    + startDate
                    + "','"
                    + endDate
                    + "')";
        }

        try {

            DBManagerDistrict db = new DBManagerDistrict(Integer.parseInt(districtId));

            ResultSet result = db.select(query);

            JSONArray json = Convertor.convertResultSetIntoJSON(result);

            response.setContentType("text/plain;charset=UTF-8");

            response.getWriter().write(json.toString());

        } catch (Exception ex) {
            ex.getMessage();
        }
    }

}
