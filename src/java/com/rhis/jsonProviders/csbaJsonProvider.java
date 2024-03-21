package com.rhis.jsonProviders;

import java.io.IOException;
import javax.json.JsonObject;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.ws.rs.client.Client;
import javax.ws.rs.client.ClientBuilder;
import javax.ws.rs.client.WebTarget;
import javax.ws.rs.core.MediaType;
import org.json.JSONArray;

/**
 *
 * @author Helal
 */
@WebServlet(name = "csbaJsonProvider", urlPatterns = {"/csbaJsonProvider"})
public class csbaJsonProvider extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        RequestDispatcher view = request.getRequestDispatcher("WEB-INF/jsp/csba.jsp");
        view.forward(request, response);

    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
            //Get Api from save the children
            Client client = ClientBuilder.newClient();
            WebTarget target = client.target("http://mamoni.net:8080/rhis_fwc_monitoring/mis3report?cHJvdmlkZXJJZD05MzAwMiZwYXNzd29yZD0xMjMmcmVwb3J0MV96aWxsYT05MyZyZXBvcnQxX3VwYXppbGE9OSZyZXBvcnQxX3VuaW9uPTExJnJlcG9ydDFfc3RhcnRfZGF0ZT0yMDE3LTAxLTAxJnJlcG9ydDFfZW5kX2RhdGU9MjAxNy0wMS0zMSZjc2JhPTE=");
            JsonObject jsonObject = target.request(MediaType.APPLICATION_JSON).get(JsonObject.class);
                        JSONArray jsonArray = new JSONArray();
            jsonArray.put(jsonObject);

            response.setContentType("text/plain;charset=UTF-8");
            
                       System.out.println("CSBA: "+jsonObject);

            //response.getWriter().write("{\"CSBA\":"+jsonObject +"}");
                        response.getWriter().write(jsonObject.toString());


    }

}
