/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.rhis.userManagement;

import com.emis.utility.Convertor;
import com.emis.utility.Utility;
import com.rhis.db.DBManagerMonitoring;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.json.JSONArray;

/**
 *
 * @author nar_r
 */
@WebServlet(name = "EmailChangeUserPassword", urlPatterns = {"/profile-online-change-password"})
public class EmailChangeUserPassword extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet EmailChangeUserPassword</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet EmailChangeUserPassword at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            Map params = UserUtility.getQueryMap(request.getQueryString());
            String uNameEncrypt=(String)params.get("u");
            String uName = UserUtility.decrypt(uNameEncrypt);
            boolean userExist = false;
            userExist = UserUtility.checkUserExist(uName);
            if (userExist) {
                request.setAttribute("uName", uName);
                RequestDispatcher view = request.getRequestDispatcher("WEB-INF/jsp/userManagement/EmailChangeUserPassword.jsp");
                view.forward(request, response);
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
            }
        } catch (SQLException ex) {
            Logger.getLogger(EmailChangeUserPassword.class.getName()).log(Level.SEVERE, null, ex);
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        String username = request.getParameter("username");

        if (action.equals("viewProfile")) {
            String sql = "select * from public.loginuser where uname='" + username + "'";

//            SELECT * FROM public."LoginUser" l
//            inner join public."Division" d on l."Division"=d.id
//        
//            String query="SELECT l.\"USERID\", l.\"UNAME\", l.\"PASS\", l.\"Active\", l.\"CreDate\", l.\"Division\", l.\"District\", l.\"Upazila\", l.\"Union\", l.\"Village\", l.\"NAME\", l.\"Email\", r.\"RoleName\", c.\"CName\"\n" +
//                    "FROM public.\"LoginUser\" l\n" +
//                    "inner join public.\"CodeList\" c on l.\"UserLevel\"=c.\"Code\"\n" +
//                    "left join public.\"web_UserRole\" ur on l.\"USERID\"=ur.\"UserId\"\n" +
//                    "left join public.\"web_Role\" r on ur.\"RoleId\"=r.\"RoleID\"\n" +
//                    "where c.\"TypeName\"='UserLevel'";
//            
//            String sql  = "SELECT \"Code\", \"CName\"\n" +
//                                "  FROM public.\"CodeList\" where \"TypeName\"='UserLevel' order by \"Code\"";
//
            try {
                DBManagerMonitoring db = new DBManagerMonitoring();

                ResultSet result = db.select(sql);

                JSONArray json = Convertor.convertResultSetIntoJSONWithDash(result);

                response.setContentType("text/plain;charset=UTF-8");
                System.out.println(json.toString());

                response.getWriter().write(json.toString());

            } catch (Exception ex) {
                ex.getMessage();
            }

        }

//======Update User Info
        if (action.equals("updateProfile")) {
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String query = "UPDATE public.LoginUser SET NAME ='" + name + "', Email='" + email + "' WHERE UNAME='" + username + "'";
            try {
                DBManagerMonitoring db = new DBManagerMonitoring();
                db.update(query);
                session.setAttribute("name", name);
            } catch (Exception ex) {
                ex.getMessage();
            }
        }

        if (action.equals("checkOldPassword")) {
            try {
                username = request.getParameter("username");
                String oldPassword = request.getParameter("oldPassword");
                boolean exist = false;

                DBManagerMonitoring db = new DBManagerMonitoring();
                String query = "select 1 from LoginUser where userid='" + username + "' and pass='" + oldPassword + "'";
                ResultSet rs = db.select(query);
                while (rs.next()) {
                    exist = true;
                }
                response.getWriter().write("{\"success\":true,\"exist\":" + exist + "}");
            } catch (Exception ex) {
                ex.printStackTrace();
                response.getWriter().write(new Utility().errorResponse());
            }
        }

        if (action.equals("changePassword")) {
            try {
                username = request.getParameter("username");
                String newPassword = request.getParameter("newPassword");
                String query = "UPDATE public.LoginUser SET pass ='" + newPassword + "' WHERE UNAME='" + username + "'";
                DBManagerMonitoring db = new DBManagerMonitoring();
                db.update(query);
                response.getWriter().write("{\"success\":true}");
            } catch (Exception ex) {
                ex.printStackTrace();
                response.getWriter().write(new Utility().errorResponse());
            }
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
