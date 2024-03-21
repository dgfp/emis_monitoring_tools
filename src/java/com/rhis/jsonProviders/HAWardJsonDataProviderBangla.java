package com.rhis.jsonProviders;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Helal
 */
@WebServlet(name = "HAWardJsonDataProviderBangla", urlPatterns = {"/HAWardJsonDataProviderBangla"})
public class HAWardJsonDataProviderBangla extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            String json = "[{\"id\": 1,\"name\": \"ওয়ার্ডঃ ১\"},{\"id\":2,\"name\": \"ওয়ার্ডঃ ২\"},{\"id\": 3,\"name\": \"ওয়ার্ডঃ ৩\"}]";
            response.setContentType("text/plain;charset=UTF-8");
            response.getWriter().write(json.toString());
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }


}
