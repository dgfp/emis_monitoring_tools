package com.emis.populationRegistration;

import com.emis.dao.NRCDao;
import com.emis.entity.PRS;
import com.emis.service.PRSService;
import com.emis.utility.Menu;
import com.emis.utility.Utility;
import com.fasterxml.jackson.databind.ObjectMapper;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.postgresql.util.PSQLException;

/**
 *
 * @author Helal
 */
@WebServlet(name = "NonRegisteredClients", urlPatterns = {"/non-registered-clients"})
public class NonRegisteredClients extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Menu.setMenu("POPULATION REGISTRATION", "non-registered-clients", request);
        request.getRequestDispatcher("WEB-INF/jsp/populationRegistration/NonRegisteredClients.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            ObjectMapper mapper = new ObjectMapper();
            PRS prs = mapper.readValue(request.getParameter("prs").toString(), PRS.class);
            NRCDao nrcDao;
            response.setContentType("text/plain;charset=UTF-8");

            switch (request.getParameter("viewType")) {
                case "District":
                    nrcDao = new NRCDao();
                    response.getWriter().write("{\"success\":true,\"data\":" + nrcDao.getDistrictPRS(prs) + "}");
                    break;

                case "Upazila":
                    nrcDao = new NRCDao(prs.getZillaid());
                    response.getWriter().write("{\"success\":true,\"data\":" + nrcDao.getUpazilaPRS(prs) + "}");
                    break;

                case "Union":
                    nrcDao = new NRCDao(prs.getZillaid());
                    response.getWriter().write("{\"success\":true,\"data\":" + nrcDao.getUnionPRS(prs) + "}");
                    break;

                default:
                    response.getWriter().write(new Utility().errorResponse());
            }
        } catch (PSQLException e) {
            e.printStackTrace();
            response.getWriter().write(new Utility().errorResponse());
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write(new Utility().errorResponse());
        }
    }
}
