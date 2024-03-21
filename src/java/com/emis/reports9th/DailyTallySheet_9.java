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
 * @author Helal
 */
@WebServlet(name = "DailyTallySheet_9", urlPatterns = {"/daily-tally-sheet-9"})
public class DailyTallySheet_9 extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Menu.setMenu("Reports", "daily-tally-sheet-9", request);
        request.getRequestDispatcher("WEB-INF/jsp/reports9th/DailyTallySheet_9.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

}
