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
@WebServlet(name = "MIS1ApprovalStatusTest", urlPatterns = {"/mis1-approval-status-test"})
public class MIS1ApprovalStatusTest extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Menu.setMenu("REPORTING STATUS", "mis1-approval-status-test", request);
        String view = "WEB-INF/jsp/reportingStatus/MIS1ApprovalStatusTest.jsp";
        try {
            if (request.getSession(false).getAttribute("district") != null) {
                if (!new UserDao().isPaperless(request.getSession(false).getAttribute("district").toString())) {
                    response.sendRedirect(request.getContextPath() + "/mis1-approval-status");
                } else {
                    request.getRequestDispatcher(view).forward(request, response);
                }
            } else {
                request.getRequestDispatcher(view).forward(request, response);
            }
        } catch (Exception e) {
            request.getRequestDispatcher(view).forward(request, response);
        }
//        Menu.setMenu("REPORTING STATUS", "mis1-approval-status-test", request);
//        request.getRequestDispatcher("WEB-INF/jsp/reportingStatus/MIS1ApprovalStatusTest.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            response.setContentType("text/plain;charset=UTF-8");
            MISStatus misStatus = new ObjectMapper().readValue(request.getParameter("misStatus").toString(), MISStatus.class);
            MISStatusService misStatusService = new MISStatusService(misStatus.getZillaid());

            switch (request.getParameter("action")) {
                case "getStatus":
                    response.getWriter().write("{\"success\":true,\"data\":" + misStatusService.getMISSubmissionStatusDGFP(misStatus, "mis1").toString() + "}");
                    //response.getWriter().write("{\"success\":true,\"data\":" + misStatusService.getMISSubmissionStatusDGFP(misStatus, "mis1").toString() + ", \"allData\":" + misStatusService.getAllStatus(misStatus, "mis1").toString() + "}");
                    break;

                case "getProviderList":
                    response.getWriter().write("{\"success\":true,\"data\":" + misStatusService.getProviderListDGFP(misStatus, Integer.parseInt(request.getParameter("viewType").toString()), "mis1").toString() + "}");
                    break;

                case "getMIS1":
                    String mis1[] = misStatusService.getMIS1DGFP(misStatus).toString().split("~");
                    response.getWriter().write("{\"success\":true,\"data\":" + mis1[0] + ",\"modifydate\":\"" + mis1[1] + "\"}");
                    break;

                default:
                    response.getWriter().write(new Utility().errorResponse());
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write(new Utility().errorResponse());
        }
    }
}
