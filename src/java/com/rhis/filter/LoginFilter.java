package com.rhis.filter;

import com.emis.utility.Category;
import com.emis.utility.Menu;
import com.rhis.controllers.UserAuthenticator;
import com.rhis.db.DBManagerMonitoring;
import com.rhis.userManagement.UserUtility;
import java.io.IOException;
import java.net.URLEncoder;
import java.net.URLDecoder;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LoginFilter implements Filter {

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain) throws ServletException, IOException {

        try {
            HttpServletRequest request = (HttpServletRequest) req;
            HttpServletResponse response = (HttpServletResponse) res;

            HttpSession session = request.getSession(false);

//            System.out.println("LOGINFILTER" + session);
            String uri = request.getRequestURI();
            String ctx = request.getContextPath();
            String srv = request.getServletPath();
            String loginURI = ctx + "/login";
            String homeURI = "WEB-INF/jsp/home.jsp";

            String redirect = request.getParameter("redirect");
            String referer = request.getHeader("referer");
            String log = "###(%s)###  {uri: %s , redirect: %s, referer: %s }";
//            System.out.println(String.format(log, 0, uri, redirect, referer));

            String action = uri.substring(uri.lastIndexOf('/') + 1, uri.length());
            boolean resourcePath = uri.startsWith(ctx + "/resources/");
            //boolean loggedIn = false;
            boolean loggedIn = (session != null) && (session.getAttribute("username") != null);

            boolean loginRequest = uri.equals(loginURI);
            String fromTab = request.getParameter("fromtab");

            Boolean a = false;

            //Some filters
//            System.out.println("HHH");
//            System.out.println("'" + referer + "'");
            if (referer != null && referer.equals("http://localhost:8081/")) {
//                System.out.println("HHH" + uri);
                //response.sendRedirect("http://localhost:8080/" + uri);
                chain.doFilter(request, response);
                return;
            }
            
//            System.out.println("HHH" + loggedIn);
            if (loggedIn) {
                //update user log
                new UserAuthenticator().updateLoginHistory(session, request);
                //filter for this url is accessable or not
                System.out.println(session.getAttribute("username").toString() + "HHH");
                if (!this.isThisUrlIsValid(srv, session.getAttribute("username").toString())) {
                    request.getRequestDispatcher(homeURI).forward(request, response);

                } else if (srv.equals("/login")) {
                    request.getRequestDispatcher(homeURI).forward(request, response); //for login url check when already logged in

                } else if (srv.equals("/")) {
                    //System.out.println(" for blank url check "); 
                    //request.getRequestDispatcher(homeURI).forward(request, response); //for blank url check     
                    RequestDispatcher view = request.getRequestDispatcher(homeURI);
                    view.forward(request, response);
                }
            }
            boolean skip_rule = uri.startsWith(ctx + "/bypass")
                    || uri.startsWith(ctx + "/maps")
                    || uri.startsWith(ctx + "/downloadChecker")
                    || uri.startsWith(ctx + "/uploadChecker")
                    || uri.startsWith(ctx + "/Release-note")
                    || uri.startsWith(ctx + "/profile-online-change-password")
                    || resourcePath
                    || loggedIn
                    || loginRequest
                    || a;
//            System.out.println("skip_rule" + skip_rule);
            if (skip_rule) {
                //chain.doFilter(request, response);
                //root try catch added.
//                try {
                chain.doFilter(request, response);
                return;
//                } catch (IOException | ServletException ex) {
//                    System.out.println(ex.getMessage());
//                }

            } else if (loggedIn == false) {

                if (srv.equals("/")) {
                    String url = ctx + "/login";
                    response.sendRedirect(url);
                } else {
                    String redirectSlug = "?redirect=" + URLEncoder.encode(srv, "UTF-8");
                    String url = ctx + "/login" + redirectSlug;
                    response.sendRedirect(url);
                }

            } else if (fromTab.equals("1")) {

//                System.out.println("From Tab Login");

                String providerType = request.getParameter("providertype");

                if (providerType.equals("3")) {

                    session.setAttribute("username", "fwa_user");
                    ArrayList<Category> categories = Menu.loadMenu(request);
                    request.getSession(true).setAttribute("categories", categories);
                    chain.doFilter(request, response);

                } else if (providerType.equals("2")) {

                    session.setAttribute("username", "ha_user");
                    ArrayList<Category> categories = Menu.loadMenu(request);
                    request.getSession(true).setAttribute("categories", categories);
                    chain.doFilter(request, response);

                } else {
                    response.sendRedirect(loginURI);
                }
            } else {
                response.sendRedirect(loginURI);
            }

        } catch (IOException | ServletException ex) {
            System.out.println(ex.getMessage());
        } catch (Exception ex) {
            Logger.getLogger(LoginFilter.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    @Override
    public void destroy() {
    }

    //URL filter for role by url & user.
    public Boolean isThisUrlIsValid(String url, String user) {
        Boolean access = true; //access default is true
        String u = url.substring(1), isValidUrl = null, isAccessableUrl = null; //variable for check url is valid or not

        //query for first check is this url is valid, thats  mean user request url or not
        String sql = "select servlet_url from public.web_modulereport where servlet_url='" + u + "'";

        //Check this url is accessable for role or not
        String query = "select servlet_url from public.loginuser u \n"
                + "inner join public.web_userrole r on u.userid=r.userid \n"
                + "inner join public.web_roleaccess a on r.roleid=a.roleid \n"
                + "inner join public.web_modulereport m on a.modrep=m.modrep \n"
                + "where u.userid='" + user + "' and m.servlet_url='" + u + "'";

        try {
            DBManagerMonitoring db1 = new DBManagerMonitoring();
            ResultSet resultSet1 = db1.select(sql);

            DBManagerMonitoring db2 = new DBManagerMonitoring();
            ResultSet resultSet2 = db2.select(query);

            while (resultSet1.next()) {
                isValidUrl = resultSet1.getString("servlet_url");
            } //excute

            while (resultSet2.next()) {
                isAccessableUrl = resultSet2.getString("servlet_url");
            } //execute

        } catch (Exception ex) {
            System.out.println(ex);
        }

        //Check after excution 
        if (isValidUrl != null) {
            if (isAccessableUrl == null) {
                access = false; //set false when url is not accessable for role
            }
        }
        return access;
    }
}
