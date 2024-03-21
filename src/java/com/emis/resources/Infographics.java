package com.emis.resources;

import com.emis.utility.Menu;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Helal | m.helal.k@gmail.com | 2019-01-30
 */
@WebServlet(name = "Infographics", urlPatterns = {"/infographics"})
public class Infographics extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Menu.setMenu("RESOURCES", "infographics", request);
        request.getRequestDispatcher("WEB-INF/jsp/resources/Infographics.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }
}
