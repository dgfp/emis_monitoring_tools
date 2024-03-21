package com.emis.trackIndicator;

import java.io.IOException;
import com.emis.utility.Menu;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Helal | m.helal.k@gmail.com | 2019-01-29
 */
@WebServlet(name = "ImmunizationCoverage", urlPatterns = {"/immunization-coverage"})
public class ImmunizationCoverage extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Menu.setMenu("TRACK INDICATOR", "immunization-coverage", request);
        request.getRequestDispatcher("WEB-INF/jsp/trackIndicator/ImmunizationCoverage.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }
}
