package com.emis.management;

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
@WebServlet(name = "FWASyncStatus", urlPatterns = {"/fwa-sync-status"})
public class FWASyncStatus extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Menu.setMenu("MANAGEMENT", "fwa-sync-status", request);
        request.getRequestDispatcher("WEB-INF/jsp/management/FWASyncStatus.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }
}