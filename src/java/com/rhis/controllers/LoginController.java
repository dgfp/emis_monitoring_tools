package com.rhis.controllers;

import com.emis.utility.Category;
import com.emis.utility.Menu;
import com.rhis.filter.LoginFilter;
import com.rhis.userManagement.UserUtility;
import java.io.IOException;
import java.net.URLEncoder;
import java.net.URLDecoder;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.emis.beans.LoginUser;
import com.rhis.db.DBManagerMonitoring;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.Base64;
import java.util.List;

/**
 *
 * @author shahaz
 */
@WebServlet(name = "LoginController", urlPatterns = {"/login"})

public class LoginController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (request.getParameter("username") != null) {

            String targetReportUrl = "login";
            HttpSession session = request.getSession();
            session.setAttribute("username", request.getParameter("username"));
            //Check & set required session for tab user.
            if (request.getParameter("providerCode") != null) {
                session.setAttribute("providerCode", request.getParameter("providerCode"));
            }
            if (request.getParameter("designation") != null) {
                session.setAttribute("designation", request.getParameter("designation"));
            }
            if (request.getParameter("category") != null) {
                session.setAttribute("category", request.getParameter("category"));
            }

            if (request.getParameter("userLevel") != null) {
                //Temporary Soultions for tab view
                if (request.getParameter("username").equals("fpi_provider")) {
                    session.setAttribute("userLevel", "7");
                } else if (request.getParameter("username").equals("fwv_provider")) {
                    session.setAttribute("userLevel", "7");
                }  else if (request.getParameter("username").equals("sacmo_provider")) {
                    session.setAttribute("userLevel", "7");
                } else {
                    session.setAttribute("userLevel", request.getParameter("userLevel"));
                }
            }

            if (request.getParameter("division") != null) {
                session.setAttribute("division", request.getParameter("division"));
            }
            if (request.getParameter("district") != null) { //System.out.println("in"+request.getParameter("district"));
                session.setAttribute("district", request.getParameter("district"));
            }
            if (request.getParameter("upazila") != null) {
                session.setAttribute("upazila", request.getParameter("upazila"));
            }
            if (request.getParameter("union") != null) {
                session.setAttribute("union", request.getParameter("union"));
            }

            //Speciifc for FWA
            if (request.getParameter("unit") != null) {
                session.setAttribute("unit", request.getParameter("unit"));
            }
            if (request.getParameter("unitid") != null) {
                session.setAttribute("unitid", request.getParameter("unitid"));
            }

            //Speciifc for HA
            if (request.getParameter("ward") != null) {
                session.setAttribute("ward", request.getParameter("ward"));
            }

            if (request.getParameter("targetReportUrl") != null) {
                targetReportUrl = request.getParameter("targetReportUrl");
                if (targetReportUrl.equals("meeting-notice") || targetReportUrl.equals("working-paper") || targetReportUrl.equals("mail-notification") || targetReportUrl.equals("meeting-minutes")) {
                    session.setAttribute("meetingNo", request.getParameter("meetingNo"));
                    session.setAttribute("meetingType", request.getParameter("meetingType"));
                    session.setAttribute("meetingYear", request.getParameter("meetingYear"));
                    session.setAttribute("meetingMonth", request.getParameter("meetingMonth"));
                    if (targetReportUrl.equals("mail-notification")) {
                        session.setAttribute("recipient", request.getParameter("recipient"));
                    }
                    //targetReportUrl += "?meetingNo=" + request.getParameter("meetingNo") + "&meetingYear=" + request.getParameter("meetingYear") + "&meetingMonth=" + request.getParameter("meetingMonth");
                }
                session.setAttribute("isTabAccess", true);
            }
            response.sendRedirect(targetReportUrl);

        } else if (request.getParameter("user") != null && request.getParameter("pass") != null) {
            String user = null;
            Base64.Decoder decoder = Base64.getUrlDecoder();
            String username = new String(decoder.decode(request.getParameter("user")));
            String password = new String(decoder.decode(request.getParameter("pass")));
            try {
                user = this.getUserId(username, password);
            } catch (SQLException ex) {

            }

            if (user != null) {
                HttpSession session = request.getSession();
                session.setAttribute("user", username + "_user@rss");
                session.setAttribute("pass", password + "*");
                this.doPost(request, response);
            } else {
                RequestDispatcher view = request.getRequestDispatcher("WEB-INF/jsp/login.jsp");
                view.forward(request, response);
            }
        } else {
            RequestDispatcher view = request.getRequestDispatcher("WEB-INF/jsp/login.jsp");
            view.forward(request, response);
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession();
        String username = request.getParameter("username") == null ? session.getAttribute("user").toString() : request.getParameter("username");
        String password = request.getParameter("password") == null ? session.getAttribute("pass").toString() : request.getParameter("password");

        String uri = request.getRequestURI();
        String redirect = request.getParameter("redirect");
        String referer = request.getHeader("referer");
        redirect = redirect == null ? null : URLDecoder.decode(redirect, "UTF-8");
        if (redirect == null && referer != null) {
            redirect = referer.replaceAll("^(?=.*redirect=([^&]+)|).+$", "$1");
        }

        String log = "@@@(%s)@@@  {uri: %s , redirect: %s, referer: %s }";
        //System.out.println(String.format(log,0,uri,redirect,referer));

        boolean valid = false;
        try {
            valid = UserAuthenticator.authenticate(username, password);
        } catch (SQLException ex) {
        }

        if (valid) {
            if (request.getParameter("remember") != null) {
                //session.setMaxInactiveInterval(1*60);
                session.setMaxInactiveInterval(-1);
                System.out.println("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Keep me logged in active~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
            }

            //HttpSession session = request.getSession();
            String userId = "";
            LoginUser loginUser = null;

            try {
                userId = getUserId(username, password);
                loginUser = getUser(username, password);
                session.setAttribute("LoginUser", loginUser);

                session.setAttribute("username", userId);

                session.setAttribute("name", loginUser.getName());
                session.setAttribute("designation", loginUser.getDesignation());
                session.setAttribute("category", loginUser.getCategory());
                session.setAttribute("username", loginUser.getUNAME());
                session.setAttribute("providerCode", loginUser.getUNAME());
                session.setAttribute("since", loginUser.getCreDate());
                session.setAttribute("role", loginUser.getRole());
                session.setAttribute("userLevel", loginUser.getUserLevel());

                //add Session to area
                if (loginUser.getDivision() != null || loginUser.getDivision() != "") {
                    session.setAttribute("division", loginUser.getDivision());
                }

                if (loginUser.getDistrict() != null || loginUser.getDistrict() != "") {
                    session.setAttribute("district", loginUser.getDistrict());
                }

                if (loginUser.getUpazila() != null || loginUser.getUpazila() != "") {
                    session.setAttribute("upazila", loginUser.getUpazila());
                }

                if (loginUser.getUnion() != null || loginUser.getUnion() != "") {
                    session.setAttribute("union", loginUser.getUnion());
                }

                if (loginUser.getVillage() != null || loginUser.getVillage() != "") {
                    session.setAttribute("village", loginUser.getVillage());
                }

                ArrayList<Category> categories = Menu.loadMenu(request);
                request.getSession(true).setAttribute("categories", categories);

                request.setAttribute("message", "");

                String slug = "/dgfp-dashboard";
                System.out.println("loginUser.getRole()" + loginUser.getRole());
                if (!new LoginFilter().isThisUrlIsValid(slug, session.getAttribute("username").toString())) {
                    slug = "/home";
                }

//                if(userId.equals("06067") //Haque
//                        || userId.equals("12457") // NIbras
//                        || userId.equals("12455") //Helal
//                        || userId.equals("269999") //Sir
//                        || userId.equals("07490") //Suman
//                        || userId.equals("01552") //Twaha
//                        || userId.equals("05314") //Oabyed
//                        || userId.equals("gabriela_maria") //Gavi
//                        || userId.equals("program_manager")){ //Nury
//                    slug = "/dgfp-dashboard";
//                }
                System.out.println("LOGINCONTROLLER" + session);
//                response.sendRedirect(request.getContextPath() + slug);

                boolean passwordStrength = UserUtility.redirectUserafterlogin(password, slug, loginUser.getRole());
                boolean emailExists = UserUtility.checkUserEmailExists(userId);
                if (passwordStrength && emailExists) {
                    response.sendRedirect(response.encodeRedirectURL(request.getContextPath() + "/email-profile-change-password-info"));
                } else if (passwordStrength) {
                    response.sendRedirect(response.encodeRedirectURL(request.getContextPath() + "/profile-change-password"));
                }
                response.sendRedirect(response.encodeRedirectURL(request.getContextPath() + slug));
            } catch (Exception ex) {
                Logger.getLogger(LoginController.class.getName()).log(Level.SEVERE, null, ex);
            }

        } else {

            String slug = "/login";
            if (redirect != null) {
                slug += "?redirect=" + redirect;
                slug += "&error=1";
            }
            response.sendRedirect(request.getContextPath() + slug);
        }
    }

    String getUserId(String username, String password) throws SQLException {

        String userId = "";
        Connection connection = null;

        DBManagerMonitoring db = new DBManagerMonitoring();
        connection = db.openConnection();
        //System.out.println("-------------------------------------------------Here-------------------------------------------------------");

        String query = "select  userid from public.loginuser  where uname=? and  pass=?";

        PreparedStatement preparedStatement = connection.prepareStatement(query);
        preparedStatement.setString(1, username);
        preparedStatement.setString(2, password);

        ResultSet rs = preparedStatement.executeQuery();

        //System.out.println(query);
        while (rs.next()) {
            userId = rs.getString("USERID");
        }
        connection.close();

        return userId;
    }

    private LoginUser getUser(String username, String password) throws SQLException {

        LoginUser loginUser = new LoginUser();
        DBManagerMonitoring db = new DBManagerMonitoring();

        String query = "select * from public.loginuser l \n"
                + "inner join public.web_userrole u on l.userid=u.userid\n"
                + "inner join public.web_role r on u.roleid=r.roleid\n"
                + "left join public.web_userdesignation d on l.designation=d.id\n"
                + "where l.uname='" + username + "' and l.pass='" + password + "'";

        //System.out.println(query);
        ResultSet rs = db.select(query);

        while (rs.next()) {
            loginUser.setUSERID(rs.getString("userid"));
            loginUser.setUNAME(rs.getString("uname"));
            loginUser.setPASS(rs.getString("pass"));
            loginUser.setActive(rs.getString("active"));
            loginUser.setUserLevel(rs.getString("userlevel"));
            loginUser.setCreDate(rs.getString("credate"));

            loginUser.setDivision(rs.getString("divid"));
            loginUser.setDistrict(rs.getString("zillaid"));
            loginUser.setUpazila(rs.getString("upazilaid"));
            loginUser.setUnion(rs.getString("unionid"));
            loginUser.setVillage(rs.getString("villageid"));
            loginUser.setName(rs.getString("name"));
            loginUser.setDesignation(rs.getString("designame"));
            loginUser.setCategory(rs.getInt("catid"));
            loginUser.setRole(rs.getString("rolename"));
        }

        return loginUser;
    }
}
