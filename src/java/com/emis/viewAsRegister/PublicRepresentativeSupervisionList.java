package com.emis.viewAsRegister;

import com.emis.service.Service;
import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author RHIS082
 */
@WebServlet(name = "PublicRepresentativeSupervisionList", urlPatterns = {"/PublicRepresentativeSupervisionList"})
public class PublicRepresentativeSupervisionList extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("submenu", "PublicRepresentativeSupervisionList");
        request.setAttribute("menu", "VIEW AS REGISTER");
        RequestDispatcher view = request.getRequestDispatcher("WEB-INF/jsp/viewAsRegister/PublicRepresentativeSupervisionList.jsp");
        view.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }
}
