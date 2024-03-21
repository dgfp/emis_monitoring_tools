package com.emis.reports9th;

import com.emis.utility.Menu;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Helal | m.helal.k@gmail.com | 2019-01-29
 */
@WebServlet(name = "MIS5", urlPatterns = {"/mis5"})
public class MIS5 extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Menu.setMenu("VIEW REPORTS", "mis5", request);
        request.getRequestDispatcher("WEB-INF/jsp/reports9th/MIS5.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }
}
