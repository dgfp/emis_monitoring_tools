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
 * @author Helal
 */
@WebServlet(name = "MIS4ApprovalStatus9vAll", urlPatterns = {"/mis4-approval-status-9v-all"})
public class MIS4ApprovalStatus9vAll extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Menu.setMenu("REPORTING STATUS", "mis4-approval-status-9v-all", request);
        String view = "WEB-INF/jsp/reportingStatus/MIS4ApprovalStatus9vAll.jsp";
        try {
            if (request.getSession(false).getAttribute("district") != null) {
                if (!new UserDao().isPaperless(request.getSession(false).getAttribute("district").toString())) {
                    response.sendRedirect(request.getContextPath() + "/mis4-approval-status");
                } else {
                    request.getRequestDispatcher(view).forward(request, response);
                }
            } else {
                request.getRequestDispatcher(view).forward(request, response);
            }
        } catch (Exception e) {
            request.getRequestDispatcher(view).forward(request, response);
        }
//        Menu.setMenu("REPORTING STATUS", "mis4-approval-status-9v-all", request);
//        request.getRequestDispatcher("WEB-INF/jsp/reportingStatus/MIS4ApprovalStatus9vAll.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/plain;charset=UTF-8");
        switch (request.getParameter("action")) {
            case "getStatus":
                try {
                    ObjectMapper mapper = new ObjectMapper();
                    MISStatus misStatus = mapper.readValue(request.getParameter("misStatus").toString(), MISStatus.class);
                    MISStatusService misStatusService = new MISStatusService(misStatus.getZillaid());
                    response.getWriter().write("{\"success\":true,\"data\":" + misStatusService.getMISSubmissionStatusDGFP(misStatus, "mis4").toString() + "}");
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
                    response.getWriter().write("{\"success\":true,\"data\":" + misStatusService.getProviderListDGFP(misStatus, Integer.parseInt(request.getParameter("viewType").toString()), "mis4").toString() + "}");
                } catch (PSQLException e) {
                    e.printStackTrace();
                    response.getWriter().write(new Utility().errorResponse());
                } catch (Exception e) {
                    e.printStackTrace();
                    response.getWriter().write(new Utility().errorResponse());
                }
                break;

            case "getMIS4":
                try {
                    ObjectMapper mapper = new ObjectMapper();
                    MISStatus misStatus = mapper.readValue(request.getParameter("misStatus").toString(), MISStatus.class);

                    MISStatusService misStatusService = new MISStatusService(misStatus.getZillaid());
                    String mis4[] = misStatusService.getMIS4DGFP(misStatus).toString().split("~");

                    //response.getWriter().write("{\"success\":true,\"data\":" + misStatusService.getMIS4(misStatus).toString() + "}");
                    //response.getWriter().write("{\"success\":true,\"data\":" + mis4[0] + ",\"modifydate\":\"" + mis4[1] + "\",\"zillaname\":\"" + mis4[2] + "\",\"upazilaname\":\"" + mis4[3] + "\"}");
                    response.getWriter().write("{\"success\":true,\"data\":" + mis4[0] + ",\"ngo\":" + misStatusService.getNGODataDGFP(misStatus.getZillaid(), misStatus.getUpazilaid(), misStatus.getMonth(), misStatus.getYear()).toString() + ",\"modifydate\":\"" + mis4[1] + "\",\"zillaname\":\"" + mis4[2] + "\",\"upazilaname\":\"" + mis4[3] + "\"}");
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
