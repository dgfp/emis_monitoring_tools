package com.emis.dashboard;

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
 * @author Helal
 */
@WebServlet(name = "DGFPDashboard", urlPatterns = {"/dgfp-dashboard"})
public class DGFPDashboard extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Menu.setMenu("RESOURCES", "emis-documents", request);
        request.getRequestDispatcher("WEB-INF/jsp/dashboard/index.html").forward(request, response);

    }
}
