package com.emis.management;

import com.emis.utility.EmailUtility;
import com.emis.utility.Menu;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Helal
 */
@WebServlet(name = "Email", urlPatterns = {"/Email"})
public class Email extends HttpServlet {

    private String host;
    private String port;
    private String user;
    private String pass;

    public void init() {
        // reads SMTP server setting from web.xml file
        ServletContext context = getServletContext();
        host = context.getInitParameter("host");
        port = context.getInitParameter("port");
        user = context.getInitParameter("user");
        pass = context.getInitParameter("pass");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Menu.setMenu("MANAGEMENT", "Email", request);
        request.getRequestDispatcher("WEB-INF/jsp/management/Email.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request,
            HttpServletResponse response) throws ServletException, IOException {
        // reads form fields
        String recipient = request.getParameter("recipient");
        String subject = request.getParameter("subject");
        String content = request.getParameter("content");

        boolean success = false;

        try {
            EmailUtility.sendEmail(host, port, user, pass, recipient, subject, content);
            success = true;

        } catch (Exception ex) {
            ex.printStackTrace();
            success = false;
        } finally {
            request.setAttribute("success", success);
            request.getRequestDispatcher("WEB-INF/jsp/management/Email.jsp").forward(request, response);
        }
    }

}
