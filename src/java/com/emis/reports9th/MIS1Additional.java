package com.emis.reports9th;

import com.emis.dao.MISDao;
import com.emis.entity.Mis1SubmissionAttributes;
import com.emis.service.MISService;
import com.emis.service.ReportSubmissionService;
import com.emis.service.Service;
import com.emis.utility.Convertor;
import com.emis.utility.Utility;
import com.rhis.db.DBManagerDistrict;
import java.io.IOException;
import java.sql.Array;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import javax.servlet.RequestDispatcher;
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
@WebServlet(name = "MIS1Additional", urlPatterns = {"/mis-form-1-additional"})
public class MIS1Additional extends HttpServlet {

//    private String data = null;
//    private long submissionId = 0;
//    private int isApprove = 3; // by default is 3 means 3 is not the meaningfull status
    private int modeRep = 701;
//    private String submissionDate = "";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("submenu", "mis-form-1");
        request.setAttribute("menu", "VIEW REPORTS");
        request.setAttribute("userLevel", (String) request.getSession(false).getAttribute("userLevel"));
        RequestDispatcher view = request.getRequestDispatcher("WEB-INF/jsp/reports9th/mis1Additional.jsp");
        view.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
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
        if (action.equalsIgnoreCase("showdata")) {
            try {
                response.setContentType("text/plain;charset=UTF-8");
//                Boolean isSubmitable = this.isSubmitable(districtId, upazilaId, unionId, fwaUnit, month, year, provCode);
                Mis1SubmissionAttributes mis1sa = this.isSubmitable(districtId, upazilaId, unionId, fwaUnit, month, year, provCode);

                Boolean isSubmitable = mis1sa.isValid();
                String data = mis1sa.getData();
                long submissionId = mis1sa.getSubmissionId();
                int isApprove = mis1sa.getIsApprove();
                String submissionDate = mis1sa.getSubmissionDate();
                String reportType = request.getParameter("reportType");

                /*
                String check = "select count(*) from rpt_mis_form1_fwa_9v where submission_type=2 and providerid = " + provCode;
                ResultSet rs = new DBManagerDistrict(Integer.parseInt(districtId)).select(check);
                rs.next();
                int exist = rs.getInt(1);
                 */
                if (isSubmitable) {
                    submissionId = 0;
                    if (reportType.equals("oldReport") && !new MISDao(this.toInt(districtId)).getAnySubmittedExist(this.toInt(districtId), this.toInt(upazilaId), this.toInt(unionId), this.toInt(fwaUnit), this.toInt(provCode))) {
                        reportType = "newReport";
                    }

                    ArrayList<String> mis1 = this.getMis1RealData(districtId, upazilaId, unionId, fwaUnit, month, year, provCode, reportType);
                    JSONArray LMIS = this.getLMIS(districtId, upazilaId, unionId, fwaUnit, month, year, provCode, reportType);

                    System.out.println(LMIS.length());

                    switch (reportType) {
                        case "newReport":
                            response.getWriter().write("{\"MIS\":" + mis1.get(0) + "," + mis1.get(1) + ",\"LMIS\":{},\"modrep\":" + modeRep + ",\"isSubmittable\":" + isSubmitable + ",\"submissionId\":" + submissionId + "}");
                            break;
                        case "oldReport":

                            if (LMIS.length() > 0) {
                                response.getWriter().write("{\"MIS\":" + mis1.get(0) + ",\"LMIS\":" + LMIS.get(0) + ",\"modrep\":" + modeRep + ",\"isSubmittable\":" + isSubmitable + ",\"submissionId\":" + submissionId + "}");
                            } else {
                                response.getWriter().write("{\"MIS\":" + mis1.get(0) + ",\"LMIS\":{},\"modrep\":" + modeRep + ",\"isSubmittable\":" + isSubmitable + ",\"submissionId\":" + submissionId + "}");
                            }
                            break;
                    }
                    /*
                    if (exist == 0) {
                        System.out.println("~~~~~~~~~~~~~~~Not manual");
                        response.getWriter().write("{\"MIS\":" + mis1.get(0) + "," + mis1.get(1) + ",\"LMIS\":{},\"modrep\":" + modeRep + ",\"isSubmittable\":" + isSubmitable + ",\"submissionId\":" + submissionId + "}");
                    } else {
                        System.out.println("~~~~~~~~~~~~~~~Manual");
                        response.getWriter().write("{\"MIS\":" + mis1.get(0) + ",\"LMIS\":" + LMIS.get(0) + ",\"modrep\":" + modeRep + ",\"isSubmittable\":" + isSubmitable + ",\"submissionId\":" + submissionId + "}");
                    }
                     */

                } else if (!isSubmitable && isApprove != 1) {
                    ArrayList<String> mis1 = this.getMis1RealData(districtId, upazilaId, unionId, fwaUnit, month, year, provCode, "submittedReport");
                    JSONArray LMIS = this.getLMIS(districtId, upazilaId, unionId, fwaUnit, month, year, provCode, "newReport");
                    response.getWriter().write("{\"MIS\":" + mis1.get(0) + ",\"LMIS\":" + LMIS.get(0) + ",\"modrep\":" + modeRep + ",\"isSubmittable\":" + isSubmitable + ",\"submissionId\":" + submissionId + ",\"status\":" + isApprove + ",\"submissionDate\":\"" + submissionDate.split(" ")[0] + "\"}");
                } else {
                    data = data.substring(0, data.length() - 1);
                    data += ",\"submissionId\":" + submissionId + ",\"modrep\":" + modeRep + ",\"status\":" + isApprove + ",\"submissionDate\":\"" + submissionDate.split(" ")[0] + "\"}";
                    response.getWriter().write(data);
                }
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }

        if (action.equalsIgnoreCase("getMIS1SubmissionCount")) {
            try {
                String query = "SELECT * from ";
                ResultSet result = new DBManagerDistrict(Integer.parseInt(districtId)).select(query);
                JSONArray json = Convertor.convertResultSetIntoJSON(result);
                String responseJson1 = (json.toString()).substring(0, (json.toString()).length() - 2);
            } catch (Exception e) {
            }

        }

        if (action.equalsIgnoreCase("submitReport")) {
            String resultJson = "[{\"status\": \"error\",\"message\": \"Somthing went wrong\"}]";
            try {
                //Status 0=notsubmitted/Pending     1=Submited      2=Need to resubmit      3=Resubmitted   4=Reopen
                String subType = request.getParameter("subType");
                int modeRep = 701;
                String data = request.getParameter("data");
                String note = request.getParameter("note");
                String html = request.getParameter("html");

                //Get additinal info for query.
                int unitid = 0//unique unit id
                        , bbsunionid = 0 // BBS unionid 
                        , count = 0 //Array of BBS union count
                        , unitAssignType = 0, reporting_upazilaid = 0;
                Array unionids = null; //Array of BBS union
                String sql = "select *, unnest(unionids) unionid from unit_master u join providerarea_unit using (unitid)  where u.zillaid=" + districtId + " and u.upazilaid=" + upazilaId + " and u.reporting_unionid=" + unionId + " and u.unit=" + fwaUnit;
                ResultSet rs = new DBManagerDistrict(Integer.parseInt(districtId)).select(sql);
                while (rs.next()) {
                    unionids = rs.getArray("unionids");
                    unitid = rs.getInt("unitid");
                    bbsunionid = rs.getInt("unionid");
                    count++;
                    unitAssignType = rs.getInt("assign_type");
                }
                reporting_upazilaid = new MISService(Integer.parseInt(districtId)).getReportingUpazilaIdByUnit(unitid);

                //get supervisor code
                //int supervisorCode = Service.getUserSupervisor(Integer.parseInt(provCode), Integer.parseInt(districtId));
                //Get reporting union fpi as supervisorcode 
                int supervisorCode = Service.getReportingUnionFPI(Integer.parseInt(districtId), Integer.parseInt(upazilaId), Integer.parseInt(unionId));

                //Action quries
                String report_submission = "";
                String report_review = "";

                if (subType.equals("2")) {
                    long _submissionId = reportSubmissionService.getMis1SubmissionId(Integer.parseInt(districtId),
                            Integer.parseInt(upazilaId), Integer.parseInt(unionId),
                            unitid, Integer.parseInt(year), Integer.parseInt(month));
                    
                    report_submission = "UPDATE public.web_report_submission_dgfp SET approved=3, data='" + data + "'::json, html='" + html + "', modifydate=now() \n"
                            + "WHERE submission_id=" + _submissionId + " and modrep=" + modeRep + " and divid=" + divisionId + " and zillaid=" + districtId + " and upazilaid=" + upazilaId + " and reporting_unionid=" + unionId + " and month=" + month + " and year=" + year;

                    report_review = "INSERT INTO public.web_report_review_dgfp (submission_id, submission_from, submission_to, status, notes, data, html) \n"
                            + "VALUES (" + _submissionId + ", " + provCode + ", " + supervisorCode + ", 3, '" + note + "',  '" + data + "'::json, '" + html + "');";

                } else if (subType.equals("undefined")) {
                    String subId = request.getParameter("submissionId");
                    report_submission = "INSERT INTO public.web_report_submission_dgfp (submission_id, submission_from, submission_to, approved, modrep, divid, zillaid, upazilaid, unionid, fwaunit, month, year, provtype, data, html, unionids, reporting_unionid, unitid, reporting_upazilaid) VALUES\n"
                            + " ( " + subId + ", " + provCode + ", " + supervisorCode + ", 0, " + modeRep + ", " + divisionId + ", " + districtId + ", " + upazilaId + ", " + bbsunionid + ", " + fwaUnit + ", " + month + ", " + year + ", 3,  '" + data + "'::json, '" + html + "', '" + unionids + "'," + unionId + ", " + unitid + ", " + reporting_upazilaid + ");";

                    report_review = "INSERT INTO public.web_report_review_dgfp (submission_id, submission_from, submission_to, status, notes, data, html) \n"
                            + "VALUES (" + subId + ", " + provCode + ", " + supervisorCode + ", 0, '" + note + "',  '" + data + "'::json, '" + html + "');";
                }

                //MIS-1 manual entry procession:-
                String mis1Data = request.getParameter("mis1").toString();
                JSONObject mis1JsonObj = new JSONObject(mis1Data.trim());
                mis1JsonObj.put("year_no", year);
                mis1JsonObj.put("month_no", month);
                mis1JsonObj.put("zillaid", districtId);
                mis1JsonObj.put("upazilaid", upazilaId);
                mis1JsonObj.put("reporting_upazilaid", reporting_upazilaid + "");
                mis1JsonObj.put("unionid", bbsunionid + "");
                mis1JsonObj.put("reporting_unionid", unionId + "");
                mis1JsonObj.put("unionids", "'" + unionids + "'");
                mis1JsonObj.put("unit", fwaUnit + "");
                mis1JsonObj.put("unitid", unitid + "");
                mis1JsonObj.put("providerid", provCode);
                mis1JsonObj.put("supervisorcode", supervisorCode + "");
                mis1JsonObj.put("is_submitted", "1");
                mis1JsonObj.put("is_approved", "0");
                mis1JsonObj.put("submission_type", "2");

                String pKeys = "year_no, month_no, zillaid, upazilaid, reporting_unionid, unionid, unit, providerid";
                List<String> Keys = new ArrayList<>();
                List<String> excludedKeys = new ArrayList<>();
                List<String> Vals = new ArrayList<>();

                Iterator<String> keys = mis1JsonObj.keys();
                while (keys.hasNext()) {
                    String k = keys.next();
                    String v = (String) mis1JsonObj.get(k);
                    v = v.isEmpty() ? "0" : v;
                    Keys.add(k);
                    excludedKeys.add("excluded." + k);
                    Vals.add(v);
                }
                String _keys = String.join(",", Keys);
                String _vals = String.join(",", Vals);
                String mis1_sql = "INSERT INTO rpt_mis_form1_fwa_9v_dgfp (%s) VALUES (%s) ON CONFLICT(%s) DO UPDATE SET (%s)=row(%s);";
                mis1_sql = String.format(mis1_sql, _keys, _vals, pKeys, _keys, String.join(",", excludedKeys));
                //END main MIS-1

                //Make LMIS insert statment
                String lmisData = request.getParameter("lmis").toString();
                JSONObject lmisJsonObj = new JSONObject(lmisData.trim());
                lmisJsonObj.put("year_no", year);
                lmisJsonObj.put("month_no", month);
                lmisJsonObj.put("zillaid", districtId);
                lmisJsonObj.put("upazilaid", upazilaId);
                lmisJsonObj.put("reporting_upazilaid", reporting_upazilaid + "");
                lmisJsonObj.put("unionid", bbsunionid + "");
                lmisJsonObj.put("reporting_unionid", unionId + "");
                lmisJsonObj.put("unionids", "'" + unionids + "'");
                lmisJsonObj.put("unit", fwaUnit + "");
                lmisJsonObj.put("unitid", unitid + "");
                lmisJsonObj.put("providerid", provCode);
                lmisJsonObj.put("supervisorcode", supervisorCode + "");
                lmisJsonObj.put("is_submitted", "1");
                lmisJsonObj.put("is_approved", "0");

                //String pKeys = "year_no, month_no, zillaid, upazilaid, unionid, unit";
                pKeys = "year_no, month_no, zillaid, upazilaid, unionid, unit";
                Keys = new ArrayList<>();
                excludedKeys = new ArrayList<>();
                Vals = new ArrayList<>();

                keys = lmisJsonObj.keys();
                while (keys.hasNext()) {
                    String k = keys.next();
                    String v = (String) lmisJsonObj.get(k);
                    v = v.isEmpty() ? "0" : v;
                    Keys.add(k);
                    excludedKeys.add("excluded." + k);
                    Vals.add(v);
                }
                String _keys_lmis = String.join(",", Keys);
                String _vals_lmis = String.join(",", Vals);

                String lmis_sql = "INSERT INTO rpt_mis_form1_lmis_9v_dgfp (%s) VALUES (%s) ON CONFLICT(%s) DO UPDATE SET (%s)=row(%s);";
                lmis_sql = String.format(lmis_sql, _keys_lmis, _vals_lmis, pKeys, _keys_lmis, String.join(",", excludedKeys));
                //END

                System.out.println("SQL Statement: " + mis1_sql);
                System.out.println("SQL Statement: " + lmis_sql);
                //System.out.println("SQL/report_submission: " + report_submission);
                //System.out.println("SQL/report_review: " + report_review);

                DBManagerDistrict db = new DBManagerDistrict(Integer.parseInt(districtId));
                db.start();
                int resultReportSubmission = db.update(report_submission);
                int resultReportReview = db.update(report_review);
                int resultMIS1 = db.update(mis1_sql);
                int resultLmis = db.update(lmis_sql);

                if (resultReportSubmission == 1 && resultReportReview == 1 && resultMIS1 == 1 && resultLmis == 1) {
                    resultJson = "[{\"status\": \"success\",\"message\": \"Submitted successfully\"}]";
                    db.commit();
                } else {
                    resultJson = "[{\"status\": \"error\",\"message\": \"Somthing went wrong\"}]";
                    db.rollback();
                }

                response.setContentType("text/plain;charset=UTF-8");
                response.getWriter().write(resultJson);

            } catch (Exception ex) {
                Utility.customLogWriter(ex.getMessage(), getServletContext().getRealPath(Utility.getLogFile()));
                ex.printStackTrace();
                response.setContentType("text/plain;charset=UTF-8");
                response.getWriter().write(resultJson);
            }
        } //end submite process
    }

//    private Boolean isSubmitable(String districtId, String upazilaId, String unionId, String fwaUnit, String month, String year, String provCode) {
//        Connection connection = null;
//        Boolean valid = true;
//        try {
//            connection = new DBManagerDistrict(Integer.parseInt(districtId)).openConnection();
//            String sql = "  SELECT * FROM public.web_report_submission_dgfp where zillaid=? and upazilaid=? and reporting_unionid=? and fwaunit=? and month=? and year=?";
//            PreparedStatement preparedStatement = connection.prepareStatement(sql);
//            //preparedStatement.setInt(1, Integer.parseInt(provCode));
//            preparedStatement.setInt(1, Integer.parseInt(districtId));
//            preparedStatement.setInt(2, Integer.parseInt(upazilaId));
//            preparedStatement.setInt(3, Integer.parseInt(unionId));
//            preparedStatement.setInt(4, Integer.parseInt(fwaUnit));
//            preparedStatement.setInt(5, Integer.parseInt(month));
//            preparedStatement.setInt(6, Integer.parseInt(year));
//            ResultSet result = preparedStatement.executeQuery();
//
//            System.out.format("SQL:- %s", result.getStatement().toString());
//
//            while (result.next()) {
//                valid = false;
//                data = result.getString("data");
//                isApprove = result.getInt("approved");
//                submissionId = result.getLong("submission_id");
//                submissionDate = result.getString("modifydate");
//            }
//        } catch (Exception ex) {
//            System.out.println(ex.getMessage());
//        }
//        return valid;
//    }
    
    private Mis1SubmissionAttributes isSubmitable(String districtId, String upazilaId, String unionId, String fwaUnit, String month, String year, String provCode) {
        Connection connection = null;
        Mis1SubmissionAttributes mis1sa = new Mis1SubmissionAttributes();
        mis1sa.setValid(true);
        try {
            connection = new DBManagerDistrict(Integer.parseInt(districtId)).openConnection();
            String sql = "  SELECT * FROM public.web_report_submission_dgfp where zillaid=? and upazilaid=? and reporting_unionid=? and fwaunit=? and month=? and year=?";
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            //preparedStatement.setInt(1, Integer.parseInt(provCode));
            preparedStatement.setInt(1, Integer.parseInt(districtId));
            preparedStatement.setInt(2, Integer.parseInt(upazilaId));
            preparedStatement.setInt(3, Integer.parseInt(unionId));
            preparedStatement.setInt(4, Integer.parseInt(fwaUnit));
            preparedStatement.setInt(5, Integer.parseInt(month));
            preparedStatement.setInt(6, Integer.parseInt(year));
            ResultSet result = preparedStatement.executeQuery();

            System.out.format("SQL:- %s", result.getStatement().toString());

            while (result.next()) {
                mis1sa.setValid(false);
                mis1sa.setData(result.getString("data"));
                mis1sa.setIsApprove(result.getInt("approved"));
                mis1sa.setSubmissionId(result.getLong("submission_id"));
                mis1sa.setSubmissionDate(result.getString("modifydate"));
            }
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        }
        return mis1sa;
    }

    private ArrayList<String> getMis1RealData(String districtId, String upazilaId, String unionId, String fwaUnit, String month, String year, String provCode, String reportType) throws SQLException {
        int unitid = this.getUnitId(districtId, upazilaId, unionId, fwaUnit);
        ArrayList<String> mis1 = new ArrayList<>();
        try {
            String sql_ka = "", sql_kha_ga_gha_uma_cha = "";//, lmis = "";
            JSONArray json = new JSONArray();
            JSONArray json2 = new JSONArray();
            Array unionids = new MISService(Integer.parseInt(districtId)).getUnionidsByUnit(this.toInt(districtId), this.toInt(upazilaId), this.toInt(unionId), this.toInt(fwaUnit));
            switch (reportType) {
                case "newReport":
//                    sql_ka = "select * from fn_mis_form1_ka_new_9v_dgfp(" + districtId + ", " + upazilaId + ", '" + unionids + "', " + unionId + ", " + fwaUnit + ", " + year + ", " + month + ")";
//                    sql_kha_ga_gha_uma_cha = "select *  from fn_mis_form1_kha_ga_gha_uma_cha_9v_dgfp(" + districtId + ", " + upazilaId + ", '" + unionids + "', " + fwaUnit + ", " + year + ", " + month + ", " + provCode + ")";
                    sql_ka = "select * from fn_mis_form1_ka_new_9v_dgfp(" + districtId + ", " + upazilaId + ", '" + unionids + "', " + unionId + ", " + unitid + ", " + fwaUnit + ", " + year + ", " + month + ")";
                    sql_kha_ga_gha_uma_cha = "select *  from fn_mis_form1_kha_ga_gha_uma_cha_9v_dgfp(" + districtId + ", " + upazilaId + ", '" + unionids+ "', " + unionId + ", " + unitid  + ", " + fwaUnit + ", " + year + ", " + month + ", " + provCode + ")";
                    json = Convertor.convertResultSetIntoJSON(new DBManagerDistrict(this.toInt(districtId)).select(sql_ka));
                    json2 = Convertor.convertResultSetIntoJSON(new DBManagerDistrict(this.toInt(districtId)).select(sql_kha_ga_gha_uma_cha));
                    mis1.add((json.toString()).substring(0, (json.toString()).length() - 2));
                    mis1.add((json2.toString()).substring(2));
                    break;
                case "oldReport":
                    sql_ka = "select *, name_zila(zillaid) r_dist_name , name_upazila(zillaid, upazilaid) r_upz_name, "
                            + "(select unionname from reporting_union where zillaid = t.zillaid and upazilaid = t.upazilaid and reporting_unionid = t.reporting_unionid) r_un_name, "
                            + "(select unameban from fwaunit where ucode = t.unit) r_unit_name, (select ward from providerarea where providerid = " + provCode + " and ward is not null limit 1) r_ward_name "
                            + "from rpt_mis_form1_fwa_9v_dgfp t where zillaid=" + districtId + " and upazilaid = " + upazilaId + " and reporting_unionid = " + unionId + " and unit = " + fwaUnit + " ORDER BY systementrydate DESC LIMIT 1";

                    json = Convertor.convertResultSetIntoJSON(new DBManagerDistrict(this.toInt(districtId)).select(sql_ka));
                    json2 = null;
                    mis1.add(json.toString());
                    mis1.add(json2.toString());
                    break;
                case "submittedReport":
                    sql_ka = "select *, name_zila(zillaid) r_dist_name ,name_upazila(zillaid, upazilaid) r_upz_name, "
                            + "(select unionname from reporting_union where zillaid = t.zillaid and upazilaid = t.upazilaid and reporting_unionid = t.reporting_unionid) r_un_name, "
                            + "(select unameban from fwaunit where ucode = t.unit) r_unit_name, (select ward r_ward_name from providerarea where providerid = " + provCode + " and ward is not null limit 1) r_ward_name "
                            + "from rpt_mis_form1_fwa_9v_dgfp t where zillaid=" + districtId + " and upazilaid = " + upazilaId + " and reporting_unionid = " + unionId + " and unit = " + fwaUnit + " and year_no=" + year + "and month_no=" + month;

                    json = Convertor.convertResultSetIntoJSON(new DBManagerDistrict(Integer.parseInt(districtId)).select(sql_ka));
                    json2 = null;
                    mis1.add(json.toString());
                    mis1.add(json2.toString());
                    break;
            }
        } catch (Exception e) {
        }
        return mis1;
    }

    private JSONArray getLMIS(String districtId, String upazilaId, String unionId, String fwaUnit, String month, String year, String provCode, String reportType) {
        JSONArray jsonResult = null;
        String sql = null;
        try {
            //String query = "SELECT * FROM public.rpt_mis_form1_lmis_9v_dgfp where zillaid=" + districtId + " and upazilaid=" + upazilaId + " and unionid=" + unionId + " and unit=" + fwaUnit + " and providerid=" + provCode + " ORDER BY systementrydate DESC LIMIT 1";
            switch (reportType) {
                case "newReport":
                    sql = "SELECT * FROM public.rpt_mis_form1_lmis_9v_dgfp where month_no =" + month + " and year_no=" + year + " and zillaid=" + districtId + " and upazilaid=" + upazilaId + " and reporting_unionid=" + unionId + " and unit=" + fwaUnit;
                    break;
                case "oldReport":
                    sql = "SELECT * FROM public.rpt_mis_form1_lmis_9v_dgfp where zillaid=" + districtId + " and upazilaid=" + upazilaId + " and reporting_unionid=" + unionId + " and unit=" + fwaUnit + " ORDER BY systementrydate DESC LIMIT 1";
                    break;
            }

            jsonResult = Convertor.toJSON(new DBManagerDistrict(Integer.parseInt(districtId)).select(sql));
            return jsonResult;
        } catch (Exception ex) {
            return jsonResult;
        }
    }

    public int getUnitId(String districtId, String upazilaId, String unionId, String fwaUnit) throws SQLException {
        int unitid = 0 //unique unit id
                , bbsunionid = 0 // BBS unionid 
                , count = 0 //Array of BBS union count
                , unitAssignType = 0, reporting_upazilaid = 0;
        Array unionids = null; //Array of BBS union
        String sql = "select *, unnest(unionids) unionid from unit_master u join providerarea_unit using (unitid)  where u.zillaid=" + districtId + " and u.upazilaid=" + upazilaId + " and u.reporting_unionid=" + unionId + " and u.unit=" + fwaUnit;
        ResultSet rs = new DBManagerDistrict(Integer.parseInt(districtId)).select(sql);
        while (rs.next()) {
            unionids = rs.getArray("unionids");
            unitid = rs.getInt("unitid");
            bbsunionid = rs.getInt("unionid");
            count++;
            unitAssignType = rs.getInt("assign_type");
        }
        return unitid;
    }

    public int toInt(String num) {
        return Integer.parseInt(num);
    }

}
