package com.emis.reportingStatus;

import com.emis.dao.UserDao;
import com.emis.entity.MISStatus;
import com.emis.service.MISStatusService;
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
 * @author Helal | m.helal.k@gmail.com | 2019-01-30
 */
@WebServlet(name = "MIS1ApprovalStatus", urlPatterns = {"/mis1-approval-status"})
public class MIS1ApprovalStatus extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Menu.setMenu("REPORTING STATUS", "mis1-approval-status", request);
        String view = "WEB-INF/jsp/reportingStatus/MIS1ApprovalStatus.jsp";
        try {
            if (request.getSession(false).getAttribute("district") != null) {
                if (new UserDao().isPaperless(request.getSession(false).getAttribute("district").toString())) {
                    response.sendRedirect(request.getContextPath() + "/mis1-approval-status-test");
                } else {
                    request.getRequestDispatcher(view).forward(request, response);
                }
            } else {
                request.getRequestDispatcher(view).forward(request, response);
            }
        } catch (Exception e) {
            request.getRequestDispatcher(view).forward(request, response);
        }
//        Menu.setMenu("REPORTING STATUS", "mis1-approval-status", request);
//        request.getRequestDispatcher("WEB-INF/jsp/reportingStatus/MIS1ApprovalStatus.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/plain;charset=UTF-8");
        switch (request.getParameter("action")) {
            case "getStatus":
                try {
//                    
//                    ObjectMapper mapper = new ObjectMapper();
//                    MISStatus misStatus = mapper.readValue(request.getParameter("misStatus").toString(), MISStatus.class);
//                    MISStatusService misStatusService = new MISStatusService(misStatus.getZillaid());
//                    response.getWriter().write("{\"success\":true,\"data\":" + misStatusService.getWorkplanStatus(misStatus).toString() + "}");
//                    
                    ObjectMapper mapper = new ObjectMapper();
                    MISStatus misStatus = mapper.readValue(request.getParameter("misStatus").toString(), MISStatus.class);
                    MISStatusService misStatusService = new MISStatusService(misStatus.getZillaid());
                    response.getWriter().write("{\"success\":true,\"data\":" + misStatusService.getMISSubmissionStatus(misStatus, "mis1").toString() + "}");
                } catch (PSQLException e) {
                    e.printStackTrace();
                    response.getWriter().write(new Utility().errorResponse());
                } catch (Exception e) {
                    e.printStackTrace();
                    response.getWriter().write(new Utility().errorResponse());
                }
                break;

            case "getProviderList":
                try {
                    ObjectMapper mapper = new ObjectMapper();
                    MISStatus misStatus = mapper.readValue(request.getParameter("misStatus").toString(), MISStatus.class);
                    MISStatusService misStatusService = new MISStatusService(misStatus.getZillaid());
                    response.getWriter().write("{\"success\":true,\"data\":" + misStatusService.getProviderList(misStatus, Integer.parseInt(request.getParameter("viewType").toString()), "mis1").toString() + "}");
                } catch (PSQLException e) {
                    e.printStackTrace();
                    response.getWriter().write(new Utility().errorResponse());
                } catch (Exception e) {
                    e.printStackTrace();
                    response.getWriter().write(new Utility().errorResponse());
                }
                break;

            case "getMIS1":
                try {
                    ObjectMapper mapper = new ObjectMapper();
                    MISStatus misStatus = mapper.readValue(request.getParameter("misStatus").toString(), MISStatus.class);
                    MISStatusService misStatusService = new MISStatusService(misStatus.getZillaid());
                    String mis1[] = misStatusService.getMIS1(misStatus, 1).toString().split("~");

                    //response.getWriter().write("{\"success\":true,\"data\":" + mis1.split("~")[0] + "}");
                    response.getWriter().write("{\"success\":true,\"data\":" + mis1[0] + ",\"modifydate\":\"" + mis1[1] + "\"}");
                    //response.getWriter().write("{\"success\":true,\"data\":" + mis1.split("~")[0] + ",\"submissionDate\":1}");
                    //response.getWriter().write("{\"success\":true,\"data\":\"" + mis1[1].toString() + "\",\"submissionDate\":1}");
                } catch (Exception e) {
                    e.printStackTrace();
                    response.getWriter().write(new Utility().errorResponse());
                }
                break;

            default:
                response.getWriter().write(new Utility().errorResponse());
        }
    }
}
