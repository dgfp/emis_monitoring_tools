package com.emis.reportingStatus;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Helal
 */
@WebServlet(name = "MonthlyWorkplanHealth", urlPatterns = {"/MonthlyWorkplanHealth"})
public class MonthlyWorkplanHealth extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("submenu", "MonthlyWorkplanHealth");
        request.setAttribute("menu", "REPORTING STATUS");
        request.setAttribute("userLevel", (String) request.getSession(false).getAttribute("userLevel"));
        RequestDispatcher view = request.getRequestDispatcher("WEB-INF/jsp/reportingStatus/MonthlyWorkplanHealth.jsp");
        view.forward(request, response);
    }
}
