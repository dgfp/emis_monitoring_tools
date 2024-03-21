package com.emis.management;

import com.emis.service.UserService;
import com.emis.utility.Menu;
import com.emis.utility.Utility;
import com.rhis.controllers.MyHttpSessionListener;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.postgresql.util.PSQLException;

/**
 *
 * @author Rangan & Helal
 */
@WebServlet(name = "Analytics", urlPatterns = {"/Analytics"})
public class Analytics extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Menu.setMenu("MANAGEMENT", "Analytics", request);
        request.getRequestDispatcher("WEB-INF/jsp/management/Analytics.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        UserService userService = new UserService();

        response.setContentType("text/plain;charset=UTF-8");
        switch (request.getParameter("action")) {
            case "getUserList":
                try {
                    response.getWriter().write("{\"success\":true,\"data\":" + new UserService().getUser().toString() + ",\"role\":" + new UserService().getUserRole().toString() + "}");
                } catch(PSQLException e){
                    e.printStackTrace();
                    response.getWriter().write(new Utility().errorResponse());
                } catch (Exception e) {
                    e.printStackTrace();
                    response.getWriter().write(new Utility().errorResponse());
                }
                break;
                
            case "getUserLogByUser":
                try {
                    response.getWriter().write("{\"success\":true,\"data\":" + userService.getUserLogById(request.getParameter("userId").toString()) .toString() + "}");
                } catch(PSQLException e){
                    response.getWriter().write(new Utility().errorResponse());
                } catch (Exception e) {
                    response.getWriter().write(new Utility().errorResponse());
                }
                break;
                
            default:
                response.getWriter().write(new Utility().errorResponse());
        }
    }

}
