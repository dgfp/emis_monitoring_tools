package com.emis.communityStatistics;

import com.emis.utility.Menu;
import com.emis.utility.Utility;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Helal
 */
@WebServlet(name = "PregnantWoman", urlPatterns = {"/PregnantWoman"})
public class PregnantWoman extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Menu.setMenu("Community statistics", "PregnantWoman", request);
        request.setAttribute("type", "familyPlanning");
        request.getRequestDispatcher("WEB-INF/jsp/communityStatistics/PregnantWoman.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("text/plain;charset=UTF-8");
        switch (request.getParameter("action")) {
            case "aggregateUpazila":
                try {
                    response.getWriter().write(new Utility().errorResponse());
                } catch (Exception e) {
                    e.printStackTrace();
                    response.getWriter().write(new Utility().errorResponse());
                }
                break;
                
            case "aggregateUnion":
                try {
                } catch (Exception e) {
                    response.getWriter().write(new Utility().errorResponse());
                }
                break;
                
            case "aggregateUnit":
                try {
                } catch (Exception e) {
                    response.getWriter().write(new Utility().errorResponse());
                }
                break;
                
            case "aggregateVillage":
                try {
                } catch (Exception e) {
                    response.getWriter().write(new Utility().errorResponse());
                }
                break;
                
            case "individual":
                try {
                } catch (Exception e) {
                    response.getWriter().write(new Utility().errorResponse());
                }
                break;
                
            default:
                response.getWriter().write(new Utility().errorResponse());
        }
    }

}
