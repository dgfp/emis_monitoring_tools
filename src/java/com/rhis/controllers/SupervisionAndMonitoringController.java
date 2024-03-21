package com.rhis.controllers;

import com.emis.dao.MAWDao;
import com.emis.service.SupervisionAndMonitoringService;
import java.io.IOException;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

/**
 *
 * @author Helal | m.helal.k@gmail.com
 */
@WebServlet(name = "SupervisionAndMonitoringController", urlPatterns = {"/SupervisionAndMonitoringController"})
public class SupervisionAndMonitoringController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        JSONObject jsonObject = new JSONObject();
        try {
            jsonObject.put("status", "error");
            jsonObject.put("message", "Somthing went wrong");
            jsonObject.put("data", JSONObject.NULL);

            //Get monthly workplan by provider----------------------------------------------------------------------------------------------------------------------
            if (action.equalsIgnoreCase("getMonthlyWorkplan")) {
                int districtId = Integer.parseInt(request.getParameter("districtId").toString());
                int month = Integer.parseInt(request.getParameter("month").toString());
                int year = Integer.parseInt(request.getParameter("year").toString());
                int providerId = Integer.parseInt(request.getParameter("providerId").toString());
                int type = Integer.parseInt(request.getParameter("providerType").toString());

                JSONArray json = new MAWDao(districtId).getWorkplan(districtId, providerId,type, month, year);
                jsonObject.put("status", "success");
                jsonObject.put("message", "Get Monthly Workplan Successfully");
                if (json != null) {
                    jsonObject.put("data", json.toString());
                }
                response.setContentType("text/plain;charset=UTF-8");
                response.getWriter().write(jsonObject.toString());
            }

        } catch (JSONException ex) {
            response.setContentType("text/plain;charset=UTF-8");
            response.getWriter().write(jsonObject.toString());
        } catch (SQLException ex) {
            response.setContentType("text/plain;charset=UTF-8");
            response.getWriter().write(jsonObject.toString());
        } catch (Exception ex) {
            Logger.getLogger(SupervisionAndMonitoringController.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        
        

    }

}
