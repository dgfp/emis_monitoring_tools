/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.rhis.filter;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.rhis.userManagement.UserUtility;

/**
 *
 * @author Nibras
 */
public class PasswordStrengthFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    @Override
    public void destroy() {
    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws ServletException, IOException {
        try {
            HttpServletRequest request = (HttpServletRequest) servletRequest;
            HttpServletResponse response = (HttpServletResponse) servletResponse;
            HttpSession session = request.getSession(false);
            String ctx = request.getContextPath();

            boolean loggedIn = (session != null) && (session.getAttribute("username") != null);

            // Check user password strength
            if (loggedIn) {
                boolean passwordStrengthRequirements = UserUtility.checkPasswordFromFilter(session.getAttribute("username").toString());
                if (passwordStrengthRequirements) {
//                    request.getRequestDispatcher("WEB-INF/jsp/utility/profile-change-password.jsp").forward(request, response);
                    response.sendRedirect(response.encodeRedirectURL(request.getContextPath() + "/profile-change-password"));
                    return;
                }
                else{
                    filterChain.doFilter(request, response);
                }
            }
            else{
                filterChain.doFilter(request, response);
            }
//            filterChain.doFilter(request, response);
        } catch (Exception e) {
        }
    }
}
