package com.rhis.controllers;

import com.emis.service.DropdownLoaderService;
import java.io.IOException;
import java.sql.SQLException;
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
@WebServlet(name = "DropdownLoaderController", urlPatterns = {"/DropdownLoaderController"})
public class DropdownLoaderController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        JSONObject jsonObject = new JSONObject();
        try {
            jsonObject.put("status", "error");
            jsonObject.put("message", "Somthing went wrong");
            jsonObject.put("data", JSONObject.NULL);

            // Get review process data by Report
            if (action.equalsIgnoreCase("getProviderByTypeAndUnion")) {
                int districtId = Integer.parseInt(request.getParameter("districtId").toString());
                int upazilaId = Integer.parseInt(request.getParameter("upazilaId").toString());
                int unionId = Integer.parseInt(request.getParameter("unionId").toString());
                int providerType = Integer.parseInt(request.getParameter("providerType").toString());

                JSONArray json = DropdownLoaderService.getProviderByTypeAndUnion(districtId, upazilaId, unionId, providerType);
                jsonObject.put("status", "success");
                jsonObject.put("message", "Get Provider By Type And Union Successfully");
                if (json != null) {
                    jsonObject.put("data", json.toString());
                }
                response.setContentType("text/plain;charset=UTF-8");
                response.getWriter().write(jsonObject.toString());
            }
            
            
            // Get Provider by ID
            if (action.equalsIgnoreCase("getProviderByType")) {
                
                String providerid =  (String) request.getSession(false).getAttribute("providerCode");
                String userLevel =  (String) request.getSession(false).getAttribute("userLevel");
                int providerCode;
                if(providerid==null && !userLevel.equals("7"))
                    providerCode = 0;
                else
                    providerCode = Integer.parseInt((String) request.getSession(false).getAttribute("providerCode"));
                
                
                int districtId = Integer.parseInt(request.getParameter("districtId").toString());
                int upazilaId = Integer.parseInt(request.getParameter("upazilaId").toString());
                int unionId = Integer.parseInt(request.getParameter("unionId").toString());
                int providerType = Integer.parseInt(request.getParameter("providerType").toString());

                JSONArray json = DropdownLoaderService.getProviderById(districtId, upazilaId, unionId,providerType, providerCode);
                jsonObject.put("status", "success");
                jsonObject.put("message", "Get Provider By Type Successfully");
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
        }

    }

}
