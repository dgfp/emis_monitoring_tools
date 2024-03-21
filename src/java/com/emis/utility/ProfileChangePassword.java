package com.emis.utility;

import java.io.IOException;
import java.sql.ResultSet;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.json.JSONArray;
import com.emis.service.UserArea;
import com.rhis.db.DBManagerMonitoring;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import com.rhis.userManagement.UserUtility;
/**
 *
 * @author Nibras Ar Rakib
 */
@WebServlet(name = "ProfileChangePassword", urlPatterns = {"/profile-change-password"})
public class ProfileChangePassword extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        System.out.println("UserName"+session.getAttribute("username").toString());
        String d = UserUtility.encrypt(session.getAttribute("username").toString());
        System.out.println("Reset URL"+ UserUtility.generateResetPasswordURL(request, d));
        try {
            request.setAttribute("division", new UserArea().getDivisionNameByUserId(session.getAttribute("username").toString()));
            request.setAttribute("district", new UserArea().getDistrictNameByUserId(session.getAttribute("username").toString()));
            request.setAttribute("upazila", new UserArea().getUpazilaNameByUserId(session.getAttribute("username").toString()));
            request.setAttribute("union", new UserArea().getUnionNameByUserId(session.getAttribute("username").toString()));
        } catch (SQLException ex) {
            Logger.getLogger(ProfileChangePassword.class.getName()).log(Level.SEVERE, null, ex);
        }
        RequestDispatcher view = request.getRequestDispatcher("WEB-INF/jsp/utility/profile-change-password.jsp");
        view.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        String username = session.getAttribute("username").toString();

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
}
