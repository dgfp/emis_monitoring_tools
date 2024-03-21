package com.emis.viewAsRegister;

import com.emis.service.Service;
import com.rhis.db.DBManagerDistrict;
import java.io.IOException;
import java.sql.ResultSet;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author RHIS082
 */
@WebServlet(name = "PregnantMotherAndNewbornInfoServiceList", urlPatterns = {"/PregnantMotherAndNewbornInfoServiceList"})
public class PregnantMotherAndNewbornInfoServiceList extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("submenu", "PregnantMotherAndNewbornInfoServiceList");
        request.setAttribute("menu", "VIEW AS REGISTER");
        RequestDispatcher view = request.getRequestDispatcher("WEB-INF/jsp/viewAsRegister/PregnantMotherAndNewbornInfoServiceList.jsp");
        view.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String divisionId = request.getParameter("division");
        String districtId = request.getParameter("district");
        String upazilaId = request.getParameter("upazila").length() == 0 ? "%" : request.getParameter("upazila");
        String unionId = request.getParameter("union").length() == 0 ? "%" : request.getParameter("union");
        String unitId = request.getParameter("unit").length() == 0 ? "%" : request.getParameter("unit");
        String startDate = request.getParameter("startDate").length() == 0 ? "01/01/2015" : request.getParameter("unit");
        String endDate = request.getParameter("endDate");

        DBManagerDistrict db = new DBManagerDistrict(Integer.parseInt(districtId));
        ResultSet result = db.select("SELECT data::text FROM public.web_pregwomen_sheet(" + divisionId + "," + districtId + ",'" + upazilaId + "','" + unionId + "','" + unitId + "','" + startDate + "','" + endDate + "')");
        response.setContentType("text/plain;charset=UTF-8");
        String json="[]";
        try {
            while (result.next()) {
                json=result.getString("data");
            }
        }
        catch(Exception ex){
        }
        response.getWriter().write(json);

    }

}
