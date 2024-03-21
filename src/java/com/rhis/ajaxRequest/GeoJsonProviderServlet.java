/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.rhis.ajaxRequest;

import com.emis.entity.ModuleLaunchInformation;
import com.emis.entity.MultipleGeoJsonProviderEntity;
import com.emis.utility.Convertor;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.rhis.db.DBManagerMonitoring;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.JSONArray;
import com.rhis.ajaxRequest.GeoJsonProvider;

/**
 *
 * @author MCHD23
 */
@WebServlet(name = "GeoJsonProviderServlet", urlPatterns = {"/GeoJsonProviderServlet"})
public class GeoJsonProviderServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/plain;charset=UTF-8");
        String action = request.getParameter("action");
        try {
            GeoJsonProvider jp = new GeoJsonProvider();
            
            switch (action) {
                case "getDivision":
                    response.getWriter().write(jp.getDivision());
                    break;
                case "getDistricts":
                    MultipleGeoJsonProviderEntity mgjpDistrict = new ObjectMapper().readValue(request.getParameter("data").toString(), MultipleGeoJsonProviderEntity.class);
                    String r = jp.getDistrictAgg(mgjpDistrict.getDivisions());
                    response.getWriter().write(r);
                    break;
                case "getReportingUpazila":
//                    MultipleGeoJsonProviderEntity mgjpUpazila = new ObjectMapper().readValue(request.getParameter("data").toString(), MultipleGeoJsonProviderEntity.class);
//                    System.out.println(mgjpUpazila.getReporting_upazilas());
//                    response.getWriter().write(jp.getDistrictAgg(mgjpUpazila.getDivisions()));
                    String zillaIds = request.getParameter("data");
                    MultipleGeoJsonProviderEntity mgjpUpazila = new ObjectMapper().readValue(zillaIds, MultipleGeoJsonProviderEntity.class);
                    System.out.println(zillaIds);
                    
                    break;
                default:
                    break;
            }
        } catch (Exception ex) {
            response.getWriter().write(ex.getMessage());
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
