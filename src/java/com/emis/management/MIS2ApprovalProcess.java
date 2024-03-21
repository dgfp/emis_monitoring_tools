package com.emis.management;

import com.emis.utility.Convertor;
import com.rhis.db.DBManagerDistrict;
import com.rhis.db.DBManagerMonitoring;
import java.io.IOException;
import java.sql.ResultSet;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.json.JSONArray;

/**
 *
 * @author Helal | m.helal.k@gmail.com
 */
@WebServlet(name = "MIS2ApprovalProcess", urlPatterns = {"/mis2-approval-manager-v9"})
public class MIS2ApprovalProcess extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("submenu", "mis2-approval-manager-v9");
        request.setAttribute("menu", "COMMUNITY STATISTICS");
        request.setAttribute("userLevel", (String) request.getSession(false).getAttribute("userLevel"));

        RequestDispatcher view = request.getRequestDispatcher("WEB-INF/jsp/management/MIS2ApprovalProcess.jsp");
        view.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        String resultJson = "[{\"status\": \"error\",\"message\": \"Somthing went wrong\"}]";

        HttpSession session = request.getSession();
        int district = session.getAttribute("district")==null || session.getAttribute("division").equals("") ? 69 : Integer.parseInt((String) session.getAttribute("district"));
        int upazila = session.getAttribute("upazila")==null || session.getAttribute("upazila").equals("") ? 9 : Integer.parseInt((String) session.getAttribute("upazila"));
        int union = session.getAttribute("union")==null || session.getAttribute("union").equals("") ? 999 : Integer.parseInt((String) session.getAttribute("union"));
        int provCode = session.getAttribute("providerCode")==null || session.getAttribute("providerCode").equals("") ? 691503 : Integer.parseInt((String) session.getAttribute("providerCode"));
        System.out.println("Div "+district+"up "+upazila+" un"+union+" p "+provCode);
        int month = 12, year = 2018, reportType=702;
        
//        int district = session.getAttribute("district")==null || session.getAttribute("division").equals("") ? 93 : Integer.parseInt((String) session.getAttribute("district"));
//        int upazila = session.getAttribute("upazila")==null || session.getAttribute("upazila").equals("") ? 66 : Integer.parseInt((String) session.getAttribute("upazila"));
//        int union = session.getAttribute("union")==null || session.getAttribute("union").equals("") ? 999 : Integer.parseInt((String) session.getAttribute("union"));
//        int provCode = session.getAttribute("providerCode")==null || session.getAttribute("providerCode").equals("") ? 931557 : Integer.parseInt((String) session.getAttribute("providerCode"));
//        System.out.println("Div "+district+"up "+upazila+" un"+union+" p "+provCode);
//        int month = 3, year = 2018, reportType=702;

        //DBManagerMonitoring db = new DBManagerMonitoring();
        DBManagerDistrict db = new DBManagerDistrict(district);
        //db.start();
        try {

            if (action.equalsIgnoreCase("showData")) {
                month = Integer.parseInt(request.getParameter("month").toString());
                year = Integer.parseInt(request.getParameter("year").toString());
                reportType = Integer.parseInt(request.getParameter("reportType").toString());
                //select * from web_report_submission_list(69,9,999,691503,15,702,3,2018);
                String sql = "select * from web_report_submission_list_mis2(" + district + "," + upazila + "," + union + "," + provCode + ",15," + reportType + "," + month + "," + year + ");";
                ResultSet result = db.select(sql);
                //db.commit();
                //JSONArray json = Convertor.convertResultSetIntoJSON(result);
                JSONArray json = Convertor.toJSON(result);
                response.setContentType("text/plain;charset=UTF-8");
                response.getWriter().write(json.toString());
            }

            if (action.equalsIgnoreCase("reviewData")) {

                //long submissionId = Integer.parseInt(request.getParameter("submission_id").toString());
                long submissionId = Long.parseLong(request.getParameter("submission_id"));

                String sql2 = "SELECT review_id, submission_id, submission_from, submission_to, status, notes, systementrydate, html  FROM public.web_report_review where submission_id=" + submissionId + " order by systementrydate";

                String sql = "SELECT review_id, submission_id, submission_from, submission_to, status, notes, rr.systementrydate, html, provname\n"
                        + "FROM public.web_report_review rr join providerdb p on rr.submission_from = p.providerid where submission_id=" + submissionId + " order by systementrydate ";
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
                

                db.start();
                String updatereportSubmission = "UPDATE public.web_report_submission SET approved=" + status + ", modifydate=now() WHERE submission_id=" + submissionId;
                String insertReportReview = "INSERT INTO public.web_report_review(submission_id, submission_from, submission_to, status,notes)\n"
                        + "VALUES (" + submissionId + "," + submissionFrom + "," + submissionTo + ", '" + status + "', '" + message + "')";

                int resultUpdatereportSubmission = db.update(updatereportSubmission);
                int resultInsertReportReview = db.update(insertReportReview);

                if (resultUpdatereportSubmission == 1 && resultInsertReportReview == 1) {
                    resultJson = "[{\"status\": \"success\",\"message\": \"Response submit successfully\"}]";
                    if(status.equals("1")){
                        String sql = "INSERT INTO public.web_mis_submission(\n" +
                                        "zillaid, upazilaid, unionid, providerid, month, year, mistype, emis, csba, lmis)\n" +
                                        "VALUES ("+district+", "+upazila+", "+union+", "+submissionTo+", "+month+", "+year+", 2, 1, 0, 0);";
                        String updateMIS2 = "UPDATE public.rpt_mis_form1_fwa SET is_approved=1, modifydate=now() WHERE zillaid = "+district+" and upazilaid = "+upazila+" and supervisorid = "+submissionTo+" and  year_no = "+year+" and month_no = "+month;
                        
                        DBManagerDistrict dbm = new DBManagerDistrict(district);
                        dbm.start();
                        dbm.update(sql);
                        dbm.update(updateMIS2);
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
            System.out.println("---------------------------------------Exception: "+ex.getMessage()+"---------------------------------------");
            response.setContentType("text/plain;charset=UTF-8");
            response.getWriter().write(resultJson);
        }

    }
}
