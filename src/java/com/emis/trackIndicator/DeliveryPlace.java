package com.emis.trackIndicator;

import com.emis.utility.Menu;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * @author Helal | m.helal.k@gmail.com | 2019-01-29
 */
@WebServlet(name = "DeliveryPlace", urlPatterns = {"/delivery-place"})
public class DeliveryPlace extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Menu.setMenu("TRACK INDICATOR", "delivery-place", request);
        request.getRequestDispatcher("WEB-INF/jsp/trackIndicator/DeliveryPlace.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

}
