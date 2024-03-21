package com.emis.communityStatistics;

import com.emis.dao.UserDao;
import com.emis.entity.LMIS;
import com.emis.utility.Convertor;
import com.emis.utility.Menu;
import com.rhis.db.DBManagerDistrict;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
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
@WebServlet(name = "MIS1ApprovalManagerV9", urlPatterns = {"/ReportSubmission"})
public class MIS1ApprovalManagerV9 extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("userLevel", (String) request.getSession(false).getAttribute("userLevel"));
        Menu.setMenu("COMMUNITY STATISTICS", "ReportSubmission", request);
        String view = "WEB-INF/jsp/communityStatistics/MIS1ApprovalManagerV9.jsp";
        try {
            if (request.getSession(false).getAttribute("district") != null) {
                if (new UserDao().isPaperless(request.getSession(false).getAttribute("district").toString())) {
                    response.sendRedirect(request.getContextPath() + "/ReportSubmissionTest");
                } else {
                    request.getRequestDispatcher(view).forward(request, response);
                }
            } else {
                request.getRequestDispatcher(view).forward(request, response);
            }
        } catch (Exception e) {
            request.getRequestDispatcher(view).forward(request, response);
        }
//        request.setAttribute("submenu", "ReportSubmission");
//        request.setAttribute("menu", "COMMUNITY STATISTICS");
//        request.setAttribute("userLevel", (String) request.getSession(false).getAttribute("userLevel"));
//        
//        RequestDispatcher view = request.getRequestDispatcher("WEB-INF/jsp/communityStatistics/MIS1ApprovalManagerV9.jsp");
//        view.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String action = request.getParameter("action");
        String resultJson = "[{\"status\": \"error\",\"message\": \"Somthing went wrong\"}]";
        String providerCode = (String) request.getSession(false).getAttribute("providerCode");

        if (session.getAttribute("designation").toString().equals("FPI") && providerCode == null) {
            session.setAttribute("providerCode", session.getAttribute("username"));
        }

        int district = session.getAttribute("district") == null || session.getAttribute("division").equals("") ? 93 : Integer.parseInt((String) session.getAttribute("district"));
        int upazila = session.getAttribute("upazila") == null || session.getAttribute("upazila").equals("") ? 66 : Integer.parseInt((String) session.getAttribute("upazila"));
        int union = session.getAttribute("union") == null || session.getAttribute("union").equals("") ? 94 : Integer.parseInt((String) session.getAttribute("union"));
        int provCode = session.getAttribute("providerCode") == null || session.getAttribute("providerCode").equals("") ? 93129 : Integer.parseInt((String) session.getAttribute("providerCode"));

//        int district = session.getAttribute("district") == null || session.getAttribute("division").equals("") ? 93 : Integer.parseInt((String) session.getAttribute("district"));
//        int upazila = session.getAttribute("upazila") == null || session.getAttribute("upazila").equals("") ? 66 : Integer.parseInt((String) session.getAttribute("upazila"));
//        int union = session.getAttribute("union") == null || session.getAttribute("union").equals("") ? 63 : Integer.parseInt((String) session.getAttribute("union"));
//        int provCode = session.getAttribute("providerCode") == null || session.getAttribute("providerCode").equals("") ? 93132 : Integer.parseInt((String) session.getAttribute("providerCode"));
        //System.out.println("Div " + district + "up " + upazila + " un" + union + " p " + provCode);
        int month = 8, year = 2018, reportType = 701;

        //DBManagerMonitoring db = new DBManagerMonitoring();
        DBManagerDistrict db = new DBManagerDistrict(district);
        //db.start();
        try {
            
            if (action.equalsIgnoreCase("showData")) {
                month = Integer.parseInt(request.getParameter("month").toString());
                year = Integer.parseInt(request.getParameter("year").toString());
                reportType = Integer.parseInt(request.getParameter("reportType").toString());

                System.out.println("Here we go");

                String sql = "select * from web_report_submission_list(" + district + "," + upazila + "," + union + "," + provCode + ",3," + reportType + "," + month + "," + year + ");";
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

                String sql2 = "SELECT review_id, submission_id, submission_from, submission_to, status, notes, systementrydate, html, data::text  FROM public.web_report_review where submission_id=" + submissionId + " order by systementrydate";

                String sql = "SELECT p.zillaid, p.upazilaid, p.unionid, review_id, submission_id, submission_from, submission_to, status, notes, rr.systementrydate, html, data::text,  provname\n"
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

                district = Integer.parseInt(request.getParameter("districtid"));
                upazila = Integer.parseInt(request.getParameter("upazilaid"));
                union = Integer.parseInt(request.getParameter("unionid"));

                String fwaunit = request.getParameter("fwaunit");

                String status = request.getParameter("status");
                String message = request.getParameter("message");
                month = Integer.parseInt(request.getParameter("month").toString());
                year = Integer.parseInt(request.getParameter("year").toString());
                reportType = Integer.parseInt(request.getParameter("reportType").toString());
                DBManagerDistrict db2 = new DBManagerDistrict(district);
                db2.start();

                String updatereportSubmission = "UPDATE public.web_report_submission SET approved=" + status + ", modifydate=now() WHERE submission_id=" + submissionId;
                String insertReportReview = "INSERT INTO public.web_report_review(submission_id, submission_from, submission_to, status,notes)\n"
                        + "VALUES (" + submissionId + "," + submissionFrom + "," + submissionTo + ", '" + status + "', '" + message + "')";
                System.out.println("SQL: " + updatereportSubmission);
                System.out.println("SQL: " + insertReportReview);
                int resultUpdatereportSubmission = db2.update(updatereportSubmission);
                int resultInsertReportReview = db2.update(insertReportReview);

                if (resultUpdatereportSubmission == 1 && resultInsertReportReview == 1) {
                    resultJson = "[{\"status\": \"success\",\"message\": \"Response submit successfully\"}]";
                    if (status.equals("1")) {
                        //insert data to flat table - FWA main
                        String sql = "select * from public.fn_mis_form1_fwa_submit_9v (" + district + "," + upazila + "," + union + "," + fwaunit + "," + year + "," + month + "," + submissionTo + "," + submissionFrom + ");";
                        System.out.println("SQL: " + sql);
                        db2.update(sql);
                        //LMIS
                        String updateLMIS = "UPDATE public.rpt_mis_form1_lmis_9v SET is_approved=1 WHERE year_no=" + year + " and month_no=" + month + " and zillaid=" + district + " and upazilaid=" + upazila + " and unionid=" + union + " and unit=" + fwaunit + " and providerid=" + submissionTo + " and supervisorid=" + submissionFrom;
                        System.out.println("LMIS SQL:" + updateLMIS);
                        db2.update(updateLMIS);
                    }
                    db2.commit();
                } else {
                    resultJson = "[{\"status\": \"error\",\"message\": \"Somthing went wrong\"}]";
                    db2.rollback();
                }
                response.setContentType("text/plain;charset=UTF-8");
                response.getWriter().write(resultJson.toString());
            }

        } catch (Exception e) {
            response.setContentType("text/plain;charset=UTF-8");
            response.getWriter().write(resultJson);
        }

    }

    public LMIS getLMIS(ResultSet rs) throws SQLException {
        LMIS lmis = new LMIS();

        while (rs.next()) {
            int i = rs.getInt("itemcode");
            if (i == 1) {
                lmis.setOpeningbalance_sukhi(rs.getInt("openingbalance"));
                lmis.setReceiveqty_sukhi(rs.getInt("receiveqty"));
                lmis.setCurrent_month_stock_sukhi(rs.getInt("current_month_stock"));
                lmis.setAdjustment_plus_sukhi(rs.getInt("adjustment_plus"));
                lmis.setAdjustment_minus_sukhi(rs.getInt("adjustment_minus"));
                lmis.setTotal_sukhi(rs.getInt("total"));
                lmis.setDistribution_sukhi(rs.getInt("distribution"));
                lmis.setClosingbalance_sukhi(rs.getInt("closingbalance"));

            } else if (i == 10) {
                lmis.setOpeningbalance_apon(rs.getInt("openingbalance"));
                lmis.setReceiveqty_apon(rs.getInt("receiveqty"));
                lmis.setCurrent_month_stock_apon(rs.getInt("current_month_stock"));
                lmis.setAdjustment_plus_apon(rs.getInt("adjustment_plus"));
                lmis.setAdjustment_minus_apon(rs.getInt("adjustment_minus"));
                lmis.setTotal_apon(rs.getInt("total"));
                lmis.setDistribution_apon(rs.getInt("distribution"));
                lmis.setClosingbalance_apon(rs.getInt("closingbalance"));

            } else if (i == 2) {
                lmis.setOpeningbalance_condom(rs.getInt("openingbalance"));
                lmis.setReceiveqty_condom(rs.getInt("receiveqty"));
                lmis.setCurrent_month_stock_condom(rs.getInt("current_month_stock"));
                lmis.setAdjustment_plus_condom(rs.getInt("adjustment_plus"));
                lmis.setAdjustment_minus_condom(rs.getInt("adjustment_minus"));
                lmis.setTotal_condom(rs.getInt("total"));
                lmis.setDistribution_condom(rs.getInt("distribution"));
                lmis.setClosingbalance_condom(rs.getInt("closingbalance"));

            } else if (i == 3) {
                lmis.setOpeningbalance_inject_vayal(rs.getInt("openingbalance"));
                lmis.setReceiveqty_inject_vayal(rs.getInt("receiveqty"));
                lmis.setCurrent_month_stock_inject_vayal(rs.getInt("current_month_stock"));
                lmis.setAdjustment_plus_inject_vayal(rs.getInt("adjustment_plus"));
                lmis.setAdjustment_minus_inject_vayal(rs.getInt("adjustment_minus"));
                lmis.setTotal_inject_vayal(rs.getInt("total"));
                lmis.setDistribution_inject_vayal(rs.getInt("distribution"));
                lmis.setClosingbalance_inject_vayal(rs.getInt("closingbalance"));

            } else if (i == 5) {
                lmis.setOpeningbalance_inject_syringe(rs.getInt("openingbalance"));
                lmis.setReceiveqty_inject_syringe(rs.getInt("receiveqty"));
                lmis.setCurrent_month_stock_inject_syringe(rs.getInt("current_month_stock"));
                lmis.setAdjustment_plus_inject_syringe(rs.getInt("adjustment_plus"));
                lmis.setAdjustment_minus_inject_syringe(rs.getInt("adjustment_minus"));
                lmis.setTotal_inject_syringe(rs.getInt("total"));
                lmis.setDistribution_inject_syringe(rs.getInt("distribution"));
                lmis.setClosingbalance_inject_syringe(rs.getInt("closingbalance"));

            } else if (i == 4) {
                lmis.setOpeningbalance_ecp(rs.getInt("openingbalance"));
                lmis.setReceiveqty_ecp(rs.getInt("receiveqty"));
                lmis.setCurrent_month_stock_ecp(rs.getInt("current_month_stock"));
                lmis.setAdjustment_plus_ecp(rs.getInt("adjustment_plus"));
                lmis.setAdjustment_minus_ecp(rs.getInt("adjustment_minus"));
                lmis.setTotal_ecp(rs.getInt("total"));
                lmis.setDistribution_ecp(rs.getInt("distribution"));
                lmis.setClosingbalance_ecp(rs.getInt("closingbalance"));

            } else if (i == 9) {
                lmis.setOpeningbalance_misoprostol(rs.getInt("openingbalance"));
                lmis.setReceiveqty_misoprostol(rs.getInt("receiveqty"));
                lmis.setCurrent_month_stock_misoprostol(rs.getInt("current_month_stock"));
                lmis.setAdjustment_plus_misoprostol(rs.getInt("adjustment_plus"));
                lmis.setAdjustment_minus_misoprostol(rs.getInt("adjustment_minus"));
                lmis.setTotal_misoprostol(rs.getInt("total"));
                lmis.setDistribution_misoprostol(rs.getInt("distribution"));
                lmis.setClosingbalance_misoprostol(rs.getInt("closingbalance"));

            } else if (i == 20) {
                lmis.setOpeningbalance_mnp(rs.getInt("openingbalance"));
                lmis.setReceiveqty_mnp(rs.getInt("receiveqty"));
                lmis.setCurrent_month_stock_mnp(rs.getInt("current_month_stock"));
                lmis.setAdjustment_plus_mnp(rs.getInt("adjustment_plus"));
                lmis.setAdjustment_minus_mnp(rs.getInt("adjustment_minus"));
                lmis.setTotal_mnp(rs.getInt("total"));
                lmis.setDistribution_mnp(rs.getInt("distribution"));
                lmis.setClosingbalance_mnp(rs.getInt("closingbalance"));

            } else if (i == 19) {
                lmis.setOpeningbalance_iron(rs.getInt("openingbalance"));
                lmis.setReceiveqty_iron(rs.getInt("receiveqty"));
                lmis.setCurrent_month_stock_iron(rs.getInt("current_month_stock"));
                lmis.setAdjustment_plus_iron(rs.getInt("adjustment_plus"));
                lmis.setAdjustment_minus_iron(rs.getInt("adjustment_minus"));
                lmis.setTotal_iron(rs.getInt("total"));
                lmis.setDistribution_iron(rs.getInt("distribution"));
                lmis.setClosingbalance_iron(rs.getInt("closingbalance"));
            }

        }

        return lmis;
    }
}
