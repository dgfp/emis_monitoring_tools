package com.emis.resources;

import com.emis.beans.Response;
import com.emis.utility.Convertor;
import com.emis.utility.Menu;
import com.emis.utility.Utility;
import com.fasterxml.jackson.databind.ObjectMapper;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.nio.file.Paths;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.JSONArray;

/**
 *
 * @author ABDUL MANNAN | mannandiu@gmail.com | 2024-04-03
 */
@WebServlet(name = "MNEExpertList", urlPatterns = {"/mne-expert-list"})
public class MNEExpertList extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Menu.setMenu("RESOURCES", "Mne-expert-list", request);
        request.getRequestDispatcher("WEB-INF/jsp/resources/mne-expert-list.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = Utility.getParam("action", "", request);
        String filename = Utility.getParam("filename", "", request);
        Response R= new Response();
        if(!filename.isEmpty()) {
            String dirname=getServletContext().getRealPath("resources/mne-expert-list");
            String data = new String(Files.readAllBytes(Paths.get(dirname+"/"+filename)),"UTF-8");
            R.setStatus(1);
            R.setMessage("Successfully loaded");
            R.setData(data);
            response.setContentType("text/plain;charset=UTF-8");
            ObjectMapper mapper = new ObjectMapper();
            mapper.writeValue(response.getOutputStream(), R);
        }

    }
}
