package com.emis.management;

import com.emis.entity.LMIS;
import com.emis.utility.Convertor;
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
@WebServlet(name = "ReportSubmission", urlPatterns = {"/mis1-approval-manager-v9"})
public class ReportSubmission extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("submenu", "mis1-approval-manager-v9");
        request.setAttribute("menu", "COMMUNITY STATISTICS");
        request.setAttribute("userLevel", (String) request.getSession(false).getAttribute("userLevel"));

        RequestDispatcher view = request.getRequestDispatcher("WEB-INF/jsp/management/ReportSubmission.jsp");
        view.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        String resultJson = "[{\"status\": \"error\",\"message\": \"Somthing went wrong\"}]";

        HttpSession session = request.getSession();

//        int district = session.getAttribute("district")==null || session.getAttribute("division").equals("") ? 69 : Integer.parseInt((String) session.getAttribute("district"));
//        int upazila = session.getAttribute("upazila")==null || session.getAttribute("upazila").equals("") ? 9 : Integer.parseInt((String) session.getAttribute("upazila"));
//        int union = session.getAttribute("union")==null || session.getAttribute("union").equals("") ? 57 : Integer.parseInt((String) session.getAttribute("union"));
//        int provCode = session.getAttribute("providerCode")==null || session.getAttribute("providerCode").equals("") ? 691017 : Integer.parseInt((String) session.getAttribute("providerCode"));
//        System.out.println("Div "+district+"up "+upazila+" un"+union+" p "+provCode);
//        int month = 12, year = 2018, reportType=701;
        
//            if (request.getParameter("providerCode") != null) {
//                session.setAttribute("providerCode", request.getParameter("providerCode"));
//            } && session.getAttribute("providerCode").toString().equals("")
            
        String providerCode =  (String) request.getSession(false).getAttribute("providerCode");
        
        if(session.getAttribute("designation").toString().equals("FPI") && providerCode==null)
                session.setAttribute("providerCode", session.getAttribute("username"));
        
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

                String sql = "SELECT review_id, submission_id, submission_from, submission_to, status, notes, rr.systementrydate, html, data::text,  provname\n"
                        + "FROM public.web_report_review rr join providerdb p on rr.submission_from = p.providerid where submission_id=" + submissionId + " order by systementrydate ";
                ResultSet result = db.select(sql);
                //db.commit();
                //JSONArray json = Convertor.convertResultSetIntoJSON(result);
                JSONArray json = Convertor.toJSON(result);
                response.setContentType("text/plain;charset=UTF-8");
                response.getWriter().write(json.toString());
            }

            if (action.equalsIgnoreCase("actionOnResponse")) {

                System.out.println("Submit from here");

                long submissionId = Long.parseLong(request.getParameter("submission_id").toString());
                String submissionFrom = request.getParameter("submission_from");
                String submissionTo = request.getParameter("submission_to");
                String fwaunit = request.getParameter("fwaunit");
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
                    if (status.equals("1")) {
                        //insert data to flat table - FWA main
                        DBManagerDistrict dbm = new DBManagerDistrict(district);
                        String sql = "select * from public.fn_mis_form1_fwa_submit (" + district + "," + upazila + "," + union + "," + fwaunit + "," + year + "," + month + "," + submissionTo + "," + submissionFrom + ");";
                        System.out.println("SQL: " + sql);
                        dbm.update(sql);
                        /*
                        //LMIS
                        LMIS lmis = this.getLMIS(new DBManagerLMIS().select("select * from public.fn_mis_form1_lmis(" + district + ", " + upazila + ", " + union + ", " + fwaunit + ", " + year + ", " + month + ");"));

                        String query = "INSERT INTO public.rpt_mis_form1_lmis(\n"
                                + "    year_no, month_no, zillaid, upazilaid, unionid, unit, providerid, \n"
                                + "    supervisorid, openingbalance_sukhi, receiveqty_sukhi, current_month_stock_sukhi, \n"
                                + "    adjustment_plus_sukhi, adjustment_minus_sukhi, total_sukhi, distribution_sukhi, \n"
                                + "    closingbalance_sukhi, openingbalance_apon, receiveqty_apon, current_month_stock_apon, \n"
                                + "    adjustment_plus_apon, adjustment_minus_apon, total_apon, distribution_apon, \n"
                                + "    closingbalance_apon, openingbalance_condom, receiveqty_condom, \n"
                                + "    current_month_stock_condom, adjustment_plus_condom, adjustment_minus_condom, \n"
                                + "    total_condom, distribution_condom, closingbalance_condom, openingbalance_inject_vayal, \n"
                                + "    receiveqty_inject_vayal, current_month_stock_inject_vayal, adjustment_plus_inject_vayal, \n"
                                + "    adjustment_minus_inject_vayal, total_inject_vayal, distribution_inject_vayal, \n"
                                + "    closingbalance_inject_vayal, openingbalance_inject_syringe, receiveqty_inject_syringe, \n"
                                + "    current_month_stock_inject_syringe, adjustment_plus_inject_syringe, \n"
                                + "    adjustment_minus_inject_syringe, total_inject_syringe, distribution_inject_syringe, \n"
                                + "    closingbalance_inject_syringe, openingbalance_ecp, receiveqty_ecp, \n"
                                + "    current_month_stock_ecp, adjustment_plus_ecp, adjustment_minus_ecp, \n"
                                + "    total_ecp, distribution_ecp, closingbalance_ecp, openingbalance_misoprostol, \n"
                                + "    receiveqty_misoprostol, current_month_stock_misoprostol, adjustment_plus_misoprostol, \n"
                                + "    adjustment_minus_misoprostol, total_misoprostol, distribution_misoprostol, \n"
                                + "    closingbalance_misoprostol, openingbalance_mnp, receiveqty_mnp, \n"
                                + "    current_month_stock_mnp, adjustment_plus_mnp, adjustment_minus_mnp, \n"
                                + "    total_mnp, distribution_mnp, closingbalance_mnp, openingbalance_iron, \n"
                                + "    receiveqty_iron, current_month_stock_iron, adjustment_plus_iron, \n"
                                + "    adjustment_minus_iron, total_iron, distribution_iron, closingbalance_iron, \n"
                                + "    is_submitted, is_approved)\n"
                                + "VALUES (" + year + "," + month + "," + district + "," + upazila + "," + union + "," + fwaunit + "," + submissionTo + "," + submissionFrom + "," + lmis.getOpeningbalance_sukhi() + "," + lmis.getReceiveqty_sukhi() + "," + lmis.getCurrent_month_stock_sukhi() + "," + lmis.getAdjustment_plus_sukhi() + "," + lmis.getAdjustment_minus_sukhi() + "," + lmis.getTotal_sukhi() + "," + lmis.getDistribution_sukhi() + "," + lmis.getClosingbalance_sukhi() + "," + lmis.getOpeningbalance_apon() + "," + lmis.getReceiveqty_apon() + "," + lmis.getCurrent_month_stock_apon() + "," + lmis.getAdjustment_plus_apon() + "," + lmis.getAdjustment_minus_apon() + "," + lmis.getTotal_apon() + "," + lmis.getDistribution_apon() + "," + lmis.getClosingbalance_apon() + "," + lmis.getOpeningbalance_condom() + "," + lmis.getReceiveqty_condom() + "," + lmis.getCurrent_month_stock_condom() + "," + lmis.getAdjustment_plus_condom() + "," + lmis.getAdjustment_minus_condom() + "," + lmis.getTotal_condom() + "," + lmis.getDistribution_condom() + "," + lmis.getClosingbalance_condom() + "," + lmis.getOpeningbalance_inject_vayal() + "," + lmis.getReceiveqty_inject_vayal() + "," + lmis.getCurrent_month_stock_inject_vayal() + "," + lmis.getAdjustment_plus_inject_vayal() + "," + lmis.getAdjustment_minus_inject_vayal() + "," + lmis.getTotal_inject_vayal() + "," + lmis.getDistribution_inject_vayal() + "," + lmis.getClosingbalance_inject_vayal() + "," + lmis.getOpeningbalance_inject_syringe() + "," + lmis.getReceiveqty_inject_syringe() + "," + lmis.getCurrent_month_stock_inject_syringe() + "," + lmis.getAdjustment_plus_inject_syringe() + "," + lmis.getAdjustment_minus_inject_syringe() + "," + lmis.getTotal_inject_syringe() + "," + lmis.getDistribution_inject_syringe() + "," + lmis.getClosingbalance_inject_syringe() + "," + lmis.getOpeningbalance_ecp() + "," + lmis.getReceiveqty_ecp() + "," + lmis.getCurrent_month_stock_ecp() + "," + lmis.getAdjustment_plus_ecp() + "," + lmis.getAdjustment_minus_ecp() + "," + lmis.getTotal_ecp() + "," + lmis.getDistribution_ecp() + "," + lmis.getClosingbalance_ecp() + "," + lmis.getOpeningbalance_misoprostol() + "," + lmis.getReceiveqty_misoprostol() + "," + lmis.getCurrent_month_stock_misoprostol() + "," + lmis.getAdjustment_plus_misoprostol() + "," + lmis.getAdjustment_minus_misoprostol() + "," + lmis.getTotal_misoprostol() + "," + lmis.getDistribution_misoprostol() + "," + lmis.getClosingbalance_misoprostol() + "," + lmis.getOpeningbalance_mnp() + "," + lmis.getReceiveqty_mnp() + "," + lmis.getCurrent_month_stock_mnp() + "," + lmis.getAdjustment_plus_mnp() + "," + lmis.getAdjustment_minus_mnp() + "," + lmis.getTotal_mnp() + "," + lmis.getDistribution_mnp() + "," + lmis.getClosingbalance_mnp() + "," + lmis.getOpeningbalance_iron() + "," + lmis.getReceiveqty_iron() + "," + lmis.getCurrent_month_stock_iron() + "," + lmis.getAdjustment_plus_iron() + "," + lmis.getAdjustment_minus_iron() + "," + lmis.getTotal_iron() + "," + lmis.getDistribution_iron() + "," + lmis.getClosingbalance_iron() + ",1,1);";
                        System.out.println("LMIS SQL:" + query);
                        new DBManagerDistrict(district).update(query);
                        */
                    }
                    db.commit();
                } else {
                    resultJson = "[{\"status\": \"error\",\"message\": \"Somthing went wrong\"}]";
                    db.rollback();
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
