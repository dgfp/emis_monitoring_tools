package com.emis.communityStatistics;

import com.emis.dao.UserDao;
import com.emis.entity.LMIS;
import com.emis.utility.Convertor;
import com.emis.utility.Menu;
import com.rhis.db.DBManagerDistrict;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.json.JSONArray;

/**
 *
 * @author Helal
 */
@WebServlet(name = "MIS1ApprovalManagerV9Test", urlPatterns = {"/ReportSubmissionTest"})
public class MIS1ApprovalManagerV9Test extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("userLevel", (String) request.getSession(false).getAttribute("userLevel"));
        Menu.setMenu("COMMUNITY STATISTICS", "ReportSubmissionTest", request);
        String view = "WEB-INF/jsp/communityStatistics/MIS1ApprovalManagerV9Test.jsp";
        try {
            if (request.getSession(false).getAttribute("district") != null) {
                if (!new UserDao().isPaperless(request.getSession(false).getAttribute("district").toString())) {
                    response.sendRedirect(request.getContextPath() + "/ReportSubmission");
                } else {
                    request.getRequestDispatcher(view).forward(request, response);
                }
            } else {
                request.getRequestDispatcher(view).forward(request, response);
            }
        } catch (Exception e) {
            request.getRequestDispatcher(view).forward(request, response);
        }
//        request.setAttribute("submenu", "ReportSubmissionTest");
//        request.setAttribute("menu", "COMMUNITY STATISTICS");
//        request.setAttribute("userLevel", (String) request.getSession(false).getAttribute("userLevel"));
//        RequestDispatcher view = request.getRequestDispatcher("WEB-INF/jsp/communityStatistics/MIS1ApprovalManagerV9Test.jsp");
//        view.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String action = request.getParameter("action");
        String resultJson = "[{\"status\": \"error\",\"message\": \"Somthing went wrong\"}]";
        String providerCode = (String) request.getSession(false).getAttribute("providerCode");

        //System.exit(0);
        if (session.getAttribute("designation").toString().equals("FPI") && providerCode == null) {
            session.setAttribute("providerCode", session.getAttribute("username"));
        }

        int district = session.getAttribute("district") == null || session.getAttribute("division").equals("") ? 93 : Integer.parseInt((String) session.getAttribute("district"));
        int upazila = session.getAttribute("upazila") == null || session.getAttribute("upazila").equals("") ? 66 : Integer.parseInt((String) session.getAttribute("upazila"));
        int union = session.getAttribute("union") == null || session.getAttribute("union").equals("") ? 94 : Integer.parseInt((String) session.getAttribute("union"));
        int provCode = session.getAttribute("providerCode") == null || session.getAttribute("providerCode").equals("") ? 93129 : Integer.parseInt((String) session.getAttribute("providerCode"));
        System.out.println("Session ID: " + session.getAttribute("providerCode"));
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

                System.out.println(provCode);

                String sql = "select * from web_report_submission_list_dgfp(p_supervisorcode=>" + provCode + ",p_month=>" + month + ",p_year=>" + year + ");";
                System.out.println(sql);
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

                //String sql2 = "SELECT review_id, submission_id, submission_from, submission_to, status, notes, systementrydate, html, data::text  FROM public.web_report_review_dgfp where submission_id=" + submissionId + " order by systementrydate";
                String sql = "SELECT p.zillaid, p.upazilaid, p.unionid, review_id, submission_id, submission_from, submission_to, status, notes, rr.systementrydate, html, data::text,  provname\n"
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

                district = Integer.parseInt(request.getParameter("districtid"));
                upazila = Integer.parseInt(request.getParameter("upazilaid"));
                int reporting_upazilaid = Integer.parseInt(request.getParameter("reporting_upazilaid"));
                union = Integer.parseInt(request.getParameter("unionid"));
                int reporting_unionid = Integer.parseInt(request.getParameter("reporting_unionid"));
                String unionids = request.getParameter("unionids");
                int unit = Integer.parseInt(request.getParameter("unit"));
                int unitid = Integer.parseInt(request.getParameter("unitid"));

                int fwa_assigntype = Integer.parseInt(request.getParameter("fwa_assigntype"));

                String fwaunitName = request.getParameter("fwaunit"); //UNIT NAME

                String status = request.getParameter("status");
                String message = request.getParameter("message");

                month = Integer.parseInt(request.getParameter("month").toString());
                year = Integer.parseInt(request.getParameter("year").toString());
                reportType = Integer.parseInt(request.getParameter("reportType").toString());
                DBManagerDistrict db2 = new DBManagerDistrict(district);

                db2.start();

                String updatereportSubmission = "UPDATE public.web_report_submission_dgfp SET approved=" + status + ", modifydate=now() WHERE submission_id=" + submissionId;
                String insertReportReview = "INSERT INTO public.web_report_review_dgfp(submission_id, submission_from, submission_to, status,notes)\n"
                        + "VALUES (" + submissionId + "," + submissionTo + "," + submissionFrom + ", '" + status + "', '" + message + "')";

                int resultUpdatereportSubmission = db2.update(updatereportSubmission);
                int resultInsertReportReview = db2.update(insertReportReview);

                if (resultUpdatereportSubmission == 1 && resultInsertReportReview == 1) {
                    resultJson = "[{\"status\": \"success\",\"message\": \"Response submit successfully\"}]";
                    //FWA MAIN UNIT
                    if (status.equals("1")) {
                        int resultUpdateMainFPStatus = 0;
                        int resultUpdateMainLMISStatus = 0;
                        String sql = "";
                        String _sql = "";
                        if (fwa_assigntype == 1) {
                            //insert data to flat table - FWA main
                            sql = "select * from public.fn_mis_form1_fwa_submit_9v_dgfp (" + "p_zillaid=>" + district + ",p_upazilaid=>" + upazila
                                    + ",p_reporting_upazilaid=>" + reporting_upazilaid + ",p_unionid=>" + union + ",p_reporting_unionid=>" + reporting_unionid
                                    + ",p_unionids=>'" + unionids + "',p_unit=>" + unit + ",p_unitid=>" + unitid + ",p_yearno=>" + year + ",p_monthno=>" + month
                                    + ",p_providerid=>" + submissionFrom + ",p_supervisorcode=>" + submissionTo + ");";
                            _sql = "UPDATE public.rpt_mis_form1_fwa_9v_dgfp SET is_approved=1 WHERE year_no="
                                    + year + " and month_no=" + month + " and zillaid=" + district + " and upazilaid=" + upazila
                                    + " and reporting_unionid=" + reporting_unionid + " and unit=" + unit + " and unitid=" + unitid
                                    + " and providerid=" + submissionFrom + " and supervisorcode=" + submissionTo;

                        } else if (fwa_assigntype == 2) {
                            sql = "UPDATE public.rpt_mis_form1_fwa_9v_dgfp SET is_approved=1 WHERE year_no="
                                    + year + " and month_no=" + month + " and zillaid=" + district + " and upazilaid=" + upazila
                                    + " and reporting_unionid=" + reporting_unionid + " and unit=" + unit + " and unitid=" + unitid
                                    + " and providerid=" + submissionFrom + " and supervisorcode=" + submissionTo;
                        }
                        System.out.println("SQL: " + sql);
                        db2.update(sql);
                        if (_sql != "") {
                            db2.update(_sql);
                        }
                        //LMIS
                        String updateLMIS = "UPDATE public.rpt_mis_form1_lmis_9v_dgfp SET is_approved=1 WHERE year_no="
                                + year + " and month_no=" + month + " and zillaid=" + district + " and upazilaid=" + upazila
                                + " and reporting_unionid=" + reporting_unionid + " and unit=" + unit + " and unitid=" + unitid
                                + " and providerid=" + submissionFrom + " and supervisorcode=" + submissionTo;
                        System.out.println("LMIS SQL:" + updateLMIS);
                        resultUpdateMainLMISStatus = db2.update(updateLMIS);

                        //if (resultUpdateMainLMISStatus == 1) {
                        //} else {
                        //resultJson = "[{\"status\": \"error\",\"message\": \"Somthing went wrong\"}]";
                        //db2.rollback();
                        //}
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
