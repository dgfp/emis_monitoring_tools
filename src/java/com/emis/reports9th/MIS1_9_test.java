package com.emis.reports9th;

import com.emis.beans.UnitMaster;
import com.emis.dao.MISDao;
import com.emis.dao.UserDao;
import com.emis.entity.Mis1SubmissionAttributes;
import com.emis.service.MISService;
import com.emis.service.ReportSubmissionService;
import com.emis.service.Service;
import com.emis.utility.Convertor;
import com.emis.utility.Date;
import com.emis.utility.Menu;
import com.emis.utility.Utility;
import com.rhis.db.DBManagerDistrict;
import java.io.IOException;
import java.sql.Array;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.JSONArray;
import javax.servlet.http.HttpSession;
import org.json.JSONObject;

/**
 *
 * @author Helal | m.helal.k@gmail.com
 */
@WebServlet(name = "MIS1_9_test", urlPatterns = {"/mis-form-1-test"})
public class MIS1_9_test extends HttpServlet {

//    private String data = null;
//    private long submissionId = 0;
//    private int isApprove = 3; // by default is 3 means 3 is not the meaningfull status
    private int modeRep = 701;
//    private String submissionDate = "";
//    private String unionids = "";
//    private int unitid = 0;
//    private int assignType = 1;
//    private int bbsunionid = 0;
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("userLevel", (String) request.getSession(false).getAttribute("userLevel"));
        Menu.setMenu("VIEW REPORTS", "mis-form-1-test", request);
        String view = "WEB-INF/jsp/reports9th/mis-1-9-test.jsp";
        System.out.println("LOL");
        try {
            if (request.getSession(false).getAttribute("district") != null) {
                if (!new UserDao().isPaperless(request.getSession(false).getAttribute("district").toString())) {
                    new MISDao(this.toInt(request.getSession(false).getAttribute("district").toString())).updateSessionUnionIdByFWA(request);
                    response.sendRedirect(request.getContextPath() + "/mis-form-1");
                } else {
                    if (request.getSession(false).getAttribute("unit") != null) {
                        int unitId = this.getUnitId(request);
                        if (unitId != 0) {
                            if (new MISService(Integer.parseInt(request.getSession(false).getAttribute("district").toString())).checkAdditionalUnitByUnitId(Integer.parseInt(request.getSession(false).getAttribute("providerCode").toString()), unitId) == 2) {
                                view = "WEB-INF/jsp/reports9th/mis1Additional.jsp";
                            }
                        } else {
                            if (new MISService(Integer.parseInt(request.getSession(false).getAttribute("district").toString())).checkAdditionalUnitByProvider(Integer.parseInt(request.getSession(false).getAttribute("providerCode").toString()), Integer.parseInt(request.getSession(false).getAttribute("unit").toString())) == 2) {
                                view = "WEB-INF/jsp/reports9th/mis1Additional.jsp";
                            }
                        }
                    }
                    request.getRequestDispatcher(view).forward(request, response);
                }
            } else {
                request.getRequestDispatcher(view).forward(request, response);
            }
            //request.setAttribute("userLevel", (String) request.getSession(false).getAttribute("userLevel"));
            //request.getRequestDispatcher(view).forward(request, response);
        } catch (Exception ex) {
            ex.printStackTrace();
            request.getRequestDispatcher(view).forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        String action = request.getParameter("action");
        String divisionId = request.getParameter("divisionId");
        String districtId = request.getParameter("districtId");
        String upazilaId = request.getParameter("upazilaId").length() == 0 ? "%" : request.getParameter("upazilaId");
        String unionId = request.getParameter("unionId").length() == 0 ? "%" : request.getParameter("unionId");
        String fwaUnit = request.getParameter("fwaUnit");
        String month = request.getParameter("month");
        String year = request.getParameter("year");
        String date = request.getParameter("date");
        String[] dates = date.split("~"); //dates[0];
        String provCode = request.getParameter("provCode");
        ReportSubmissionService reportSubmissionService = new ReportSubmissionService(Integer.parseInt(districtId));
//        String req_unitid = session.getAttribute("unitid").toString();
//        System.out.println("kkk"+req_unitid);
        if (action.equalsIgnoreCase("showdata")) {
            response.setContentType("text/plain;charset=UTF-8");
            try {

//                Boolean isSubmitable = this.isSubmitable(districtId, upazilaId, unionId, fwaUnit, month, year, provCode);
                Mis1SubmissionAttributes msa = this.isSubmitable(districtId, upazilaId, unionId, fwaUnit, month, year, provCode);
                boolean isSubmitable = msa.isValid();
                long submissionId = msa.getSubmissionId();
                int isApprove = msa.getIsApprove();
                String submissionDate = msa.getSubmissionDate();
                String data = msa.getData();
                //Check if unit is additonal and month year is current then Can't see MIS-1
                int checkAdditionalUnitByProvider = new MISService(Integer.parseInt(districtId)).checkAdditionalUnitByProvider(Integer.parseInt(provCode), Integer.parseInt(fwaUnit)
                    , this.getUnitId(request));
                // LocalDate.now().getYear()
                if (checkAdditionalUnitByProvider == 2 && !new MISDao(this.toInt(districtId)).isSubmittedAsAdditional(districtId, upazilaId, unionId, fwaUnit, month, year)) {
                    response.getWriter().write("{\"serverResponse\": \"warning\",\"message\": \"Additional unit report not yet submitted\"}");

                } else {
                    if (isSubmitable) {
                        submissionId = 0;
                        ArrayList<String> mis1 = this.getMis1RealData(divisionId, districtId, upazilaId, unionId, fwaUnit, month, year, date, dates, provCode, request);
                        response.getWriter().write("{\"serverResponse\": \"success\",\"MIS\":" + mis1.get(0) + ","
                                + mis1.get(1) + ",\"LMIS\":{},\"modrep\":" + modeRep + ",\"isSubmittable\":" + isSubmitable
                                + ",\"submissionId\":" + submissionId + ",\"assignType\":" + mis1.get(2) + ",\"unionids\":\""
                                + mis1.get(3) + "\",\"unitid\":" + mis1.get(4) + ",\"bbsunionid\":" + mis1.get(5)
                                + ",\"reporting_upazilaid\":" + mis1.get(6) + ",\"zilla_id\":" + mis1.get(7) + "}");
                        //response.setContentType("text/plain;charset=UTF-8");
                        //response.getWriter().write("{\"MIS\":" + mis1.get(0) + "," + mis1.get(1) + ",\"CSBA\":" + mis1.get(2) + ",\"modrep\":" + modeRep + ",\"isSubmittable\":" + isSubmitable + ",\"submissionId\":" + submissionId + "}");
                        //response.getWriter().write("{\"MIS\":" + mis1.get(0) + "," + mis1.get(1) + ",\"LMIS\":" + mis1.get(2) + ",\"CSBA\":" + mis1.get(3) + ",\"modrep\":" + modeRep + ",\"isSubmittable\":" + isSubmitable + ",\"submissionId\":" + submissionId +  "}");
                        //System.out.println("{\"MIS\":" + mis1.get(0) + "," + mis1.get(1) + ",\"LMIS\":{},\"modrep\":" + modeRep + ",\"isSubmittable\":" + isSubmitable + ",\"submissionId\":" + submissionId + ",\"assignType\":" + mis1.get(2) + ",\"unionids\":" + mis1.get(3) + ",\"unitid\":" + mis1.get(4) + ",\"bbsunionid\":" + mis1.get(5) + "}");
                        //String a = "{\"MIS\":" + mis1.get(0) + "," + mis1.get(1) + ",\"LMIS\":{},\"modrep\":" + modeRep + ",\"isSubmittable\":" + isSubmitable + ",\"submissionId\":" + submissionId + ",\"assignType\":" + mis1.get(2) + ",\"unionids\":" + mis1.get(3) + ",\"unitid\":" + mis1.get(4) + ",\"bbsunionid\":" + mis1.get(5) + "}";
                    } else if (!isSubmitable && isApprove != 1) {
                        ArrayList<String> mis1 = this.getMis1RealData(divisionId, districtId, upazilaId, unionId, fwaUnit, month, year, date, dates, provCode, request);
                        JSONArray LMIS = this.getLMIS(districtId, upazilaId, unionId, fwaUnit, month, year, provCode);
                        response.getWriter().write("{\"serverResponse\": \"success\",\"MIS\":" + mis1.get(0) + "," + mis1.get(1)
                                + ",\"LMIS\":" + LMIS.get(0) + ",\"modrep\":" + modeRep + ",\"isSubmittable\":"
                                + isSubmitable + ",\"submissionId\":" + submissionId + ",\"status\":" + isApprove
                                + ",\"assignType\":" + mis1.get(2) + ",\"unionids\":\"" + mis1.get(3) + "\",\"unitid\":"
                                + mis1.get(4) + ",\"bbsunionid\":" + mis1.get(5) + ",\"reporting_upazilaid\":" + mis1.get(6)
                                + ",\"zilla_id\":" + mis1.get(7)
                                + ",\"submissionDate\":\"" + submissionDate.split(" ")[0] + "\"}");
                        //response.setContentType("text/plain;charset=UTF-8");
                        //response.getWriter().write("{\"MIS\":" + mis1.get(0) + "," + mis1.get(1) + ",\"LMIS\":" + mis1.get(2) + ",\"CSBA\":" + mis1.get(3) + ",\"modrep\":" + modeRep + ",\"isSubmittable\":" + isSubmitable + ",\"submissionId\":" + submissionId + ",\"status\":" + isApprove + "}");

                    } else {
                        //response.setContentType("text/plain;charset=UTF-8");
                        //Add extra status variable
                        data = data.substring(0, data.length() - 1);
                        data += ",\"serverResponse\": \"success\",\"submissionId\":" + submissionId + ",\"modrep\":" + modeRep + ",\"status\":" + isApprove + ",\"assignType\":" + new MISService(Integer.parseInt(districtId)).checkAdditionalUnitByProvider(Integer.parseInt(provCode), Integer.parseInt(fwaUnit)) + ",\"submissionDate\":\"" + submissionDate.split(" ")[0] + "\"}";
                        response.getWriter().write(data);
                    }
                }

            } catch (Exception ex) {
                ex.printStackTrace();
                System.out.println(ex.getMessage());
                response.getWriter().write("[{\"status\": \"error\",\"message\": \"Somthing went wrong\"}]");
            }
        }

        if (action.equalsIgnoreCase("submitReport")) {
            //Status 0=notsubmitted/Pending     1=Submited      2=Need to resubmit      3=Resubmitted   4=Reopen
            String subType = request.getParameter("subType");
            String resultJson = "[{\"status\": \"error\",\"message\": \"Somthing went wrong\"}]";
            int modeRep = 701;
            String data = request.getParameter("data");
            String note = request.getParameter("note");
            String html = request.getParameter("html");

            String reporting_upazilaid = request.getParameter("reporting_upazilaid"),
                    bbsunionid = request.getParameter("bbsunionid"),
                    unionids = request.getParameter("unionids"),
                    unitid = request.getParameter("unitid");

            try {
                //get supervisor code
                //int supervisorCode = Service.getUserSupervisor(Integer.parseInt(provCode), Integer.parseInt(districtId));
                //Get reporting union fpi as supervisorcode 
                int supervisorCode = Service.getReportingUnionFPI(Integer.parseInt(districtId), Integer.parseInt(upazilaId), Integer.parseInt(unionId));

                //Action quries
                String report_submission = "";
                String report_review = "";

                if (subType.equals("2")) {
//                    submissionId = Long.parseLong(request.getParameter("submissionId"));
//                    report_submission = "UPDATE public.web_report_submission_dgfp SET approved=3, data='" + data + "'::json, html='" + html + "', modifydate=now() \n"
//                            + "WHERE submission_id=" + submissionId + " and modrep=" + modeRep + " and divid=" + divisionId + " and zillaid=" + districtId + " and upazilaid=" + upazilaId + " and reporting_unionid=" + unionId + " and month=" + month + " and year=" + year
//                            + " and unitid=" + unitid;
                    long _submissionId = reportSubmissionService.getMis1SubmissionId(Integer.parseInt(districtId), Integer.parseInt(upazilaId),
                             Integer.parseInt(unionId), Integer.parseInt(unitid), Integer.parseInt(year), Integer.parseInt(month));
                    System.out.println("MIS1 _submissionId: " + _submissionId);
                    report_submission = "UPDATE public.web_report_submission_dgfp SET approved=3, data='" + data + "'::json, html='" + html + "', modifydate=now() \n"
                            + "WHERE " + "modrep=" + modeRep + " and divid=" + divisionId + " and zillaid=" + districtId + " and upazilaid=" + upazilaId + " and reporting_unionid=" + unionId + " and month=" + month + " and year=" + year
                            + " and unitid=" + unitid + " and submission_id=" + _submissionId;
                    //need to put proper submissionid
                    report_review = "INSERT INTO public.web_report_review_dgfp (submission_id, submission_from, submission_to, status, notes, data, html) \n"
                            + "VALUES (" + _submissionId + ", " + provCode + ", " + supervisorCode + ", 3, '" + note + "',  '" + data + "'::json, '" + html + "');";

                } else if (subType.equals("undefined")) {
                    String subId = request.getParameter("submissionId");
                    report_submission = "INSERT INTO public.web_report_submission_dgfp (submission_id, submission_from, submission_to, approved, modrep, divid, zillaid, upazilaid, unionid, fwaunit, month, year, provtype, data, html, unionids, reporting_unionid, unitid, reporting_upazilaid) VALUES\n"
                            + " ( " + subId + ", " + provCode + ", " + supervisorCode + ", 0, " + modeRep + ", " + divisionId + ", " + districtId + ", " + upazilaId + ", " + bbsunionid + ", " + fwaUnit + ", " + month + ", " + year + ", 3,  '" + data + "'::json, '" + html + "', '" + unionids + "'," + unionId + ", " + unitid + ", " + reporting_upazilaid + ");";

                    report_review = "INSERT INTO public.web_report_review_dgfp (submission_id, submission_from, submission_to, status, notes, data, html) \n"
                            + "VALUES (" + subId + ", " + provCode + ", " + supervisorCode + ", 0, '" + note + "',  '" + data + "'::json, '" + html + "');";
                }

                //LMIS manual entry procession:-
                String lmisData = request.getParameter("lmis").toString();
                JSONObject lmisJsonObj = new JSONObject(lmisData.trim());

                lmisJsonObj.put("year_no", year);
                lmisJsonObj.put("month_no", month);
                lmisJsonObj.put("zillaid", districtId);
                lmisJsonObj.put("upazilaid", upazilaId);
                lmisJsonObj.put("reporting_upazilaid", reporting_upazilaid);

                lmisJsonObj.put("unionid", bbsunionid);
                lmisJsonObj.put("reporting_unionid", unionId);
                lmisJsonObj.put("unionids", "'" + unionids + "'");

                lmisJsonObj.put("unit", fwaUnit);
                lmisJsonObj.put("unitid", unitid);

                lmisJsonObj.put("providerid", provCode);
                lmisJsonObj.put("supervisorcode", supervisorCode + "");
                lmisJsonObj.put("is_submitted", "1");
                lmisJsonObj.put("is_approved", "0");
                System.out.println(lmisJsonObj);

                String pKeys = "year_no, month_no, zillaid, upazilaid, unionid, unit";
                List<String> Keys = new ArrayList<>();
                List<String> excludedKeys = new ArrayList<>();
                List<String> Vals = new ArrayList<>();

                Iterator<String> keys = lmisJsonObj.keys();
                while (keys.hasNext()) {
                    String k = keys.next();
                    String v = (String) lmisJsonObj.get(k);
                    v = v.isEmpty() ? "0" : v;
                    Keys.add(k);
                    excludedKeys.add("excluded." + k);
                    Vals.add(v);
                }
                String _keys = String.join(",", Keys);
                String _vals = String.join(",", Vals);
//                System.out.println("Keys: " + String.join(",", Keys));
//                System.out.println("Vals: " + String.join(",", Vals));

                String query = "INSERT INTO rpt_mis_form1_lmis_9v_dgfp (%s) VALUES (%s) ON CONFLICT(%s) DO UPDATE SET (%s)=row(%s);";
                query = String.format(query, _keys, _vals, pKeys, _keys, String.join(",", excludedKeys));
//                System.out.println("SQL LMIS: " + report_submission);
//                System.out.println("SQL report_submission: " + report_submission);
//                System.out.println("SQL report_review: " + report_review);

                DBManagerDistrict db = new DBManagerDistrict(Integer.parseInt(districtId));
                db.start();
                int resultReportSubmission = db.update(report_submission);
                int resultReportReview = db.update(report_review);
                int resultLmis = db.update(query);
                System.out.println("SQL LMIS: " + "--" + resultReportSubmission + "--"
                        + resultReportReview + "--" + resultLmis);
                if (resultReportSubmission == 1 && resultReportReview == 1 && resultLmis == 1) {
                    resultJson = "[{\"status\": \"success\",\"message\": \"Submitted successfully\"}]";
                    db.commit();
                } else {
                    resultJson = "[{\"status\": \"error\",\"message\": \"Please reload this page and submit again.\"}]";
                    db.rollback();
                }

                response.setContentType("text/plain;charset=UTF-8");
                response.getWriter().write(resultJson);

            } catch (Exception ex) {
                System.out.println("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
                Utility.customLogWriter(ex.getMessage(), getServletContext().getRealPath(Utility.getLogFile()));
                ex.printStackTrace();
                System.out.println(ex.getMessage());
                System.out.println("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
                response.setContentType("text/plain;charset=UTF-8");
                response.getWriter().write(resultJson);
            }
        } //end submit process
    }

//    private Boolean isSubmitable(String districtId, String upazilaId, String unionId, String fwaUnit, String month, String year, String provCode) {
//        Boolean valid = true;
//        try {
//            Connection connection = new DBManagerDistrict(Integer.parseInt(districtId)).openConnection();
//            String sql = "  SELECT * FROM public.web_report_submission_dgfp where zillaid=? and reporting_upazilaid=? and reporting_unionid=? and fwaunit=? and month=? and year=?";
//            PreparedStatement preparedStatement = connection.prepareStatement(sql);
//            preparedStatement.setInt(1, Integer.parseInt(districtId));
//            preparedStatement.setInt(2, Integer.parseInt(upazilaId));
//            preparedStatement.setInt(3, Integer.parseInt(unionId));
//            preparedStatement.setInt(4, Integer.parseInt(fwaUnit));
//            preparedStatement.setInt(5, Integer.parseInt(month));
//            preparedStatement.setInt(6, Integer.parseInt(year));
//            ResultSet result = preparedStatement.executeQuery();
//            System.out.println("SQL:- %s"+ sql + isApprove);
//            int unitId = 0;
////            isApprove = 3;
//            while (result.next()) {
//                valid = false;
//                data = result.getString("data");
//                isApprove = result.getInt("approved");
//                submissionId = result.getLong("submission_id");
//                submissionDate = result.getString("modifydate");
//                unitId = result.getInt("unitid");
//            }
//
//            if (isApprove == 1) {
//                data = "{\"serverResponse\": \"success\",\"MIS\":" + this.getSubmittedMIS1(unitId, month, year, districtId) + ",\"LMIS\":" + this.getSubmittedLMIS(unitId, month, year, districtId).get(0) + "}";
//            }
////            System.out.println(data);
//        } catch (Exception ex) {
//            ex.printStackTrace();
//            System.out.println(ex.getMessage());
//        }
//        return valid;
//    }
    private Mis1SubmissionAttributes isSubmitable(String districtId, String upazilaId, String unionId, String fwaUnit, String month, String year, String provCode) {
        Boolean valid = true;
        Mis1SubmissionAttributes msa = new Mis1SubmissionAttributes();
        try {
            Connection connection = new DBManagerDistrict(Integer.parseInt(districtId)).openConnection();
            String sql = "SELECT * FROM public.web_report_submission_dgfp where zillaid=? and reporting_upazilaid=? and reporting_unionid=? and fwaunit=? and month=? and year=?";
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, Integer.parseInt(districtId));
            preparedStatement.setInt(2, Integer.parseInt(upazilaId));
            preparedStatement.setInt(3, Integer.parseInt(unionId));
            preparedStatement.setInt(4, Integer.parseInt(fwaUnit));
            preparedStatement.setInt(5, Integer.parseInt(month));
            preparedStatement.setInt(6, Integer.parseInt(year));
            ResultSet result = preparedStatement.executeQuery();
            int unitId = 0;
//            isApprove = 3;
            if (result.next() == false) {
                msa.setValid(true);
                msa.setSubmissionId(0);
                msa.setData(""); 
                msa.setIsApprove(3);
            } else {
                do {
                    msa.setData(result.getString("data"));
                    msa.setIsApprove(result.getInt("approved"));
                    msa.setSubmissionId(result.getLong("submission_id"));
                    msa.setSubmissionDate(result.getString("modifydate"));
                    unitId = result.getInt("unitid");
                    msa.setValid(false);
                } while (result.next());
            }
            if (msa.getIsApprove() == 1) {
                msa.setData("{\"serverResponse\": \"success\",\"MIS\":"
                        + this.getSubmittedMIS1(unitId, month, year, districtId)
                        + ",\"LMIS\":" + this.getSubmittedLMIS(unitId, month, year, districtId).get(0)
                        + "}");
            }
//            System.out.println(data);
        } catch (Exception ex) {
            ex.printStackTrace();
            System.out.println(ex.getMessage());
        }
        return msa;
    }

    private ArrayList<String> getMis1RealData(String divisionId, String districtId, String upazilaId, String unionId, String fwaUnit, String month, String year, String date, String[] dates, String provCode, HttpServletRequest request) {
        int _districtId = Integer.parseInt(districtId);
        int _upazilaId = Integer.parseInt(upazilaId);
        int _unionId = Integer.parseInt(unionId);
        int _fwaUnit = Integer.parseInt(fwaUnit);
        int unitAssignType = 0;
        ArrayList<String> mis1 = new ArrayList<>();
        try {
            //Declaration
            String sql_ka = "", sql_kha_ga_gha_uma_cha = "";
            //String reportType = request.getParameter("reportType"), startDate = request.getParameter("startDate"), endDate = request.getParameter("endDate");
            String startDate = request.getParameter("startDate"), endDate = request.getParameter("endDate");

//            int unitid = 0 //unique unit id
//                    , bbsunionid = 0 // BBS unionid 
//                    , count = 0 //Array of BBS union count
//                    , unitAssignType = 0, reporting_upazilaid = 0;
//            Array unionids = null; //Array of BBS union
            //Get related info from unit_mater
            String sql = "select *, unnest(unionids) unionid from unit_master u join providerarea_unit using (unitid)  where u.zillaid=" + districtId + " and u.upazilaid=" + upazilaId + " and u.reporting_unionid=" + unionId + " and u.unit=" + fwaUnit;
            ResultSet rs = new DBManagerDistrict(Integer.parseInt(districtId)).select(sql);
            while (rs.next()) {
//                unionids = rs.getArray("unionids");
//                unitid = rs.getInt("unitid");
//                bbsunionid = rs.getInt("unionid");
//                count++;
                unitAssignType = rs.getInt("assign_type");
            }
//            reporting_upazilaid = new MISService(Integer.parseInt(districtId)).getReportingUpazilaIdByUnit(unitid);

            ReportSubmissionService service = new ReportSubmissionService(_districtId);
            UnitMaster um = service.getUnitId(_districtId, _upazilaId, _unionId, _fwaUnit);

            System.out.println("Array of union: " + um.unionids);
            System.out.println("Unique Unit ID: " + um.unitid);
            System.out.println("Reporting union ID: " + um.reporting_unionid);
            System.out.println("Assign type: " + unitAssignType);

            startDate = Date.convertToISO(startDate);
            endDate = Date.convertToISO(endDate);
            //Decision making before running mis-1 query (Multiple union of single union) (Date wise or month wise)  ~~~~~~~~~~~~~~~~ Change data view process when the when the unit is additional

            switch (request.getParameter("reportType")) {
                case "monthWise":
//                    sql_ka = "select * from fn_mis_form1_ka_new_9v_dgfp(" + districtId + ", " + upazilaId + ", '" + unionids + "', " + unionId + ", " + fwaUnit + ", " + year + ", " + month + ")";
//                    sql_kha_ga_gha_uma_cha = "select *  from fn_mis_form1_kha_ga_gha_uma_cha_9v_dgfp(" + districtId + ", " + upazilaId + ", '" + unionids + "', " + fwaUnit + ", " + year + ", " + month + ", " + provCode + ")";
//                    sql_ka = "select * from fn_mis_form1_ka_new_9v_dgfp(" + districtId + ", " + upazilaId + ", '" + unionids + "', " + unionId + ", " + unitid + ", " + fwaUnit + ", " + year + ", " + month + ")";
//                    sql_kha_ga_gha_uma_cha = "select *  from fn_mis_form1_kha_ga_gha_uma_cha_9v_dgfp(" + districtId + ", " + upazilaId + ", '" + unionids + "', " + unionId + ", " + unitid + ", " + fwaUnit + ", " + year + ", " + month + ", " + provCode + ")";
                    sql_ka = "select * from fn_mis_form1_ka_new_9v_dgfp(" + um.zillaid + ", " + um.upazilaid + ", '" + um.unionids + "', " + um.reporting_unionid + ", " + um.unitid + ", " + um.unit + ", " + year + ", " + month + ")";
                    sql_kha_ga_gha_uma_cha = "select *  from fn_mis_form1_kha_ga_gha_uma_cha_9v_dgfp(" + um.zillaid + ", " + um.upazilaid + ", '" + um.unionids + "', " + um.reporting_unionid + ", " + um.unitid + ", " + um.unit + ", " + year + ", " + month + ", " + provCode + ")";

                    break;
                case "dateWise":
//                    sql_ka = "select * from fn_mis_form1_ka_new_9v_dgfp_date_range(" + districtId + ", " + upazilaId + ", '" + unionids + "', " + unionId + ", " + fwaUnit + ", " + year + ", " + month + ", '" + startDate + "', '" + endDate + "')";
//                    sql_kha_ga_gha_uma_cha = "select *  from fn_mis_form1_kha_ga_gha_uma_cha_9v_dgfp_date_range(" + districtId + ", " + upazilaId + ", '" + unionids + "', " + fwaUnit + ", " + year + ", " + month + ", '" + startDate + "', '" + endDate + "', " + provCode + ")";
//                    sql_ka = "select * from fn_mis_form1_ka_new_9v_dgfp_date_range(" + districtId + ", " + upazilaId + ", '" + unionids + "', " + unionId + ", " + unitid + ", " + fwaUnit + ", " + year + ", " + month + ", '" + startDate + "', '" + endDate + "')";
//                    sql_kha_ga_gha_uma_cha = "select *  from fn_mis_form1_kha_ga_gha_uma_cha_9v_dgfp_date_range(" + districtId + ", " + upazilaId + ", '" + unionids + "', " + unionId + ", " + unitid + ", " + fwaUnit + ", " + year + ", " + month + ", '" + startDate + "', '" + endDate + "', " + provCode + ")";
                    sql_ka = "select * from fn_mis_form1_ka_new_9v_dgfp_date_range(" + um.zillaid + ", " + um.upazilaid + ", '" + um.unionids + "', " + um.reporting_unionid + ", " + um.unitid + ", " + um.unit + ", " + year + ", " + month + ", '" + startDate + "', '" + endDate + "')";
                    sql_kha_ga_gha_uma_cha = "select *  from fn_mis_form1_kha_ga_gha_uma_cha_9v_dgfp_date_range(" + um.zillaid + ", " + um.upazilaid + ", '" + um.unionids + "', " + um.reporting_unionid + ", " + um.unitid + ", " + um.unit + ", " + year + ", " + month + ", '" + startDate + "', '" + endDate + "', " + provCode + ")";
                    break;
            }

            JSONArray json = Convertor.convertResultSetIntoJSON(new DBManagerDistrict(Integer.parseInt(districtId)).select(sql_ka));
            JSONArray json2 = Convertor.convertResultSetIntoJSON(new DBManagerDistrict(Integer.parseInt(districtId)).select(sql_kha_ga_gha_uma_cha));
            String responseJson1 = (json.toString()).substring(0, (json.toString()).length() - 2);
            String responseJson2 = (json2.toString()).substring(2);

//            mis1.add(responseJson1); // Mis1
//            mis1.add(responseJson2); //Mis 1
//            mis1.add(unitAssignType + ""); //assign type in : 2 index
//            mis1.add(unionids + ""); // unions array : 3 index
//            mis1.add(unitid + ""); // unique unit id: 4 index
//            mis1.add(bbsunionid + ""); // bbs unionid: 5 index
//            mis1.add(reporting_upazilaid + ""); // reporting_upazilaid: 6 index
            mis1.add(responseJson1); // Mis1
            mis1.add(responseJson2); //Mis 1
            mis1.add(unitAssignType + ""); //assign type in : 2 index
            mis1.add(um.unionids + ""); // unions array : 3 index
            mis1.add(um.unitid + ""); // unique unit id: 4 index
            mis1.add(um.reporting_unionid + ""); // bbs unionid: 5 index
            mis1.add(um.upazilaid + ""); // reporting_upazilaid: 6 index
            mis1.add(um.zillaid + "");
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return mis1;
    }

    private JSONArray getLMIS(String districtId, String upazilaId, String unionId, String fwaUnit, String month, String year, String provCode) {
        try {
            String query = "SELECT * FROM public.rpt_mis_form1_lmis_9v_dgfp where month_no =" + month + " and year_no=" + year + " and zillaid=" + districtId + " and upazilaid=" + upazilaId + " and reporting_unionid=" + unionId + " and unit=" + fwaUnit + " and providerid=" + provCode;
            return Convertor.toJSON(new DBManagerDistrict(Integer.parseInt(districtId)).select(query));
        } catch (Exception ex) {
            ex.printStackTrace();
            return new JSONArray();
        }
    }

    private String getSubmittedMIS1(int unitid, String month, String year, String districtId) {
        try {
            String query = "Select *, priv_month_tot_preg_fwa as prir_month_tot_preg_fwa FROM public.rpt_mis_form1_fwa_9v_dgfp where month_no=" + month + " and year_no=" + year + " and unitid = " + unitid;
            query = "Select *\n"
                    + "	,priv_month_tot_preg_fwa as prir_month_tot_preg_fwa\n"
                    + "	,name_zila(zillaid) r_dist_name\n"
                    + "	,name_upazila(zillaid, upazilaid) r_upz_name\n"
                    + "	,(select ru.unionname from reporting_union ru where ru.zillaid = m.zillaid and ru.upazilaid = m.upazilaid and ru.reporting_unionid = m.reporting_unionid) r_un_name\n"
                    + "	,(select unameban from fwaunit where ucode= m.unit) r_unit_name\n"
                    + "	,(select ward from providerarea where zillaid = m.zillaid and upazilaid = m.upazilaid and unionid = m.unionid and fwaunit = m.unit limit 1) r_ward_name\n"
                    + " FROM public.rpt_mis_form1_fwa_9v_dgfp m where month_no=" + month + " and year_no=" + year + " and unitid = " + unitid;
            return Convertor.toJSON(new DBManagerDistrict(Integer.parseInt(districtId)).select(query)).toString();
        } catch (Exception ex) {
            ex.printStackTrace();
            return "";
        }
    }

    private JSONArray getSubmittedLMIS(int unitid, String month, String year, String districtId) {
        try {
            String query = "Select * FROM public.rpt_mis_form1_lmis_9v_dgfp where month_no=" + month + " and year_no=" + year + " and unitid = " + unitid;
            return Convertor.toJSON(new DBManagerDistrict(Integer.parseInt(districtId)).select(query));
        } catch (Exception ex) {
            ex.printStackTrace();
            return new JSONArray();
        }
    }

    private int getUnitId(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session.getAttribute("unitid") != null) {
            String req_unitid = session.getAttribute("unitid").toString();
            return Integer.parseInt(req_unitid);
        }
        return 0;
    }

    public int toInt(String num) {
        return Integer.parseInt(num);
    }
}
