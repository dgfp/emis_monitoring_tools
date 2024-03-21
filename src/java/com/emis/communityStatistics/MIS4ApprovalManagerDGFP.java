package com.emis.communityStatistics;

import com.emis.dao.UserDao;
import com.emis.service.Service;
import com.emis.utility.Convertor;
import com.emis.utility.Menu;
import com.rhis.db.DBManagerDistrict;
import java.io.IOException;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.json.JSONArray;

/**
 *
 * @author Helal | m.helal.k@gmail.com | 2019-01-30
 */
@WebServlet(name = "MIS4ApprovalManagerDGFP", urlPatterns = {"/mis4-approval-manager-dgfp"})
public class MIS4ApprovalManagerDGFP extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Menu.setMenu("COMMUNITY STATISTICS", "mis4-approval-manager-dgfp", request);
        String view = "WEB-INF/jsp/communityStatistics/MIS4ApprovalManagerDGFP.jsp";
        try {
            if (request.getSession(false).getAttribute("district") != null) {
                if (!new UserDao().isPaperless(request.getSession(false).getAttribute("district").toString())) {
                    response.sendRedirect(request.getContextPath() + "/mis4-approval-manager");
                } else {
                    request.getRequestDispatcher(view).forward(request, response);
                }
            } else {
                request.getRequestDispatcher(view).forward(request, response);
            }
        } catch (Exception e) {
            request.getRequestDispatcher(view).forward(request, response);
        }
//        Menu.setMenu("COMMUNITY STATISTICS", "mis4-approval-manager-dgfp", request);
//        request.getRequestDispatcher("WEB-INF/jsp/communityStatistics/MIS4ApprovalManagerDGFP.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        String resultJson = "[{\"status\": \"error\",\"message\": \"Somthing went wrong\"}]";

        HttpSession session = request.getSession();
        int district = session.getAttribute("district") == null || session.getAttribute("division").equals("") ? 93 : Integer.parseInt((String) session.getAttribute("district"));
        String provCode = session.getAttribute("providerCode") == null || session.getAttribute("providerCode").equals("") ? "930000" : (String) session.getAttribute("providerCode");
        int month = 3, year = 2019, reportType = 704;

        //DBManagerMonitoring db = new DBManagerMonitoring();
        DBManagerDistrict db = new DBManagerDistrict(district);
        //db.start();
        try {
            if (action.equalsIgnoreCase("showData")) {
                month = Integer.parseInt(request.getParameter("month").toString());
                year = Integer.parseInt(request.getParameter("year").toString());
                reportType = Integer.parseInt(request.getParameter("reportType").toString());
                String sql = "select * from web_report_submission_list_mis4_dgfp(" + district + "," + month + "," + year + ");";
                ResultSet result = db.select(sql);
                //db.commit();
                JSONArray json = Convertor.toJSON(result);
                response.setContentType("text/plain;charset=UTF-8");
                response.getWriter().write(json.toString());
            }

            if (action.equalsIgnoreCase("reviewData")) {
                long submissionId = Long.parseLong(request.getParameter("submission_id"));

                String sql2 = "SELECT review_id, submission_id, submission_from, submission_to, status, notes, systementrydate, html  FROM public.web_report_review_dgfp "
                        + "where submission_id=" + submissionId + " order by systementrydate";

                String sql = "SELECT review_id, submission_id, submission_from, submission_to, status, notes, rr.systementrydate, html, provname\n"
                        + "FROM public.web_report_review_dgfp rr join providerdb p on rr.submission_from = p.providerid where submission_id=" + submissionId + " order by systementrydate ";
                ResultSet result = db.select(sql);
                //db.commit();
                //JSONArray json = Convertor.convertResultSetIntoJSON(result);
                JSONArray json = Convertor.toJSON(result);
                response.setContentType("text/plain;charset=UTF-8");
                response.getWriter().write(json.toString());
            }

            if (action.equalsIgnoreCase("actionOnResponse")) {

                long submissionId = Long.parseLong(request.getParameter("submission_id").toString());
                String submissionFrom = request.getParameter("submission_from");
                String submissionTo = request.getParameter("submission_to");
                //String fwaunit = request.getParameter("fwaunit");
                String status = request.getParameter("status");
                String message = request.getParameter("message");
                month = Integer.parseInt(request.getParameter("month").toString());
                year = Integer.parseInt(request.getParameter("year").toString());
                reportType = Integer.parseInt(request.getParameter("reportType").toString());

                String upazila = Service.getUpazilaIdBySubId(submissionId, district) + "";

                db.start();
                String updatereportSubmission = "UPDATE public.web_report_submission_dgfp SET approved=" + status + ", modifydate=now() WHERE submission_id=" + submissionId;
                String insertReportReview = "INSERT INTO public.web_report_review_dgfp(submission_id, submission_from, submission_to, status,notes)\n"
                        + "VALUES (" + submissionId + "," + submissionFrom + "," + submissionTo + ", '" + status + "', '" + message + "')";

                int resultUpdatereportSubmission = db.update(updatereportSubmission);
                int resultInsertReportReview = db.update(insertReportReview);

                if (resultUpdatereportSubmission == 1 && resultInsertReportReview == 1) {
                    resultJson = "[{\"status\": \"success\",\"message\": \"Response submit successfully\"}]";
                    if (status.equals("1")) {
                        String sql = "select * from public.fn_mis_form4_ufpo_submit_9v_dgfp (" + district + ", " + upazila + ", " + submissionFrom + ", " + year + ", " + month + ");";
                        DBManagerDistrict dbm = new DBManagerDistrict(district);
                        dbm.start();
                        dbm.update(sql);
                        dbm.commit();
                    }
                    db.commit();
                } else {
                    resultJson = "[{\"status\": \"error\",\"message\": \"Somthing went wrong\"}]";
                    db.rollback();
                }
                response.setContentType("text/plain;charset=UTF-8");
                response.getWriter().write(resultJson.toString());
            }

        } catch (Exception ex) {
            System.out.println("---------------------------------------Exception: " + ex.getMessage() + "---------------------------------------");
            response.setContentType("text/plain;charset=UTF-8");
            response.getWriter().write(resultJson);
        }

    }
}
