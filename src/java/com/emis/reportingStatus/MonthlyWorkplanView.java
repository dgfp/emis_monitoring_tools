package com.emis.reportingStatus;

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
@WebServlet(name = "MonthlyWorkplanView", urlPatterns = {"/monthly-workplan-view"})
public class MonthlyWorkplanView extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("userLevel", (String) request.getSession(false).getAttribute("userLevel"));
        Menu.setMenu("REPORTING STATUS", "monthly-workplan-view", request);
        request.getRequestDispatcher("WEB-INF/jsp/reportingStatus/MonthlyWorkplanView.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }
}
