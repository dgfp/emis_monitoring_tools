package com.emis.reports9th;

import com.emis.dao.UserDao;
import com.emis.service.Service;
import com.emis.utility.Convertor;
import com.emis.utility.Menu;
import com.emis.service.MISStatusService;
import com.rhis.db.DBManagerDistrict;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

/**
 *
 * @author Helal
 */
@WebServlet(name = "MIS4_9_DGFP", urlPatterns = {"/MIS_4_DGFP"})
public class MIS4_9_DGFP extends HttpServlet {

    private String data = null;
    private long submissionId = 0;
    private int isApprove = 3; // by default is 3 means 3 is not the meaningfull status
    private int modeRep = 704;
    private String submissionDate = "";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Menu.setMenu("VIEW REPORTS", "MIS_4_DGFP", request);
        String view = "WEB-INF/jsp/reports9th/mis-4-9-dgfp.jsp";

        try {
            if (request.getSession(false).getAttribute("district") != null) {
                if (!new UserDao().isPaperless(request.getSession(false).getAttribute("district").toString())) {
                    response.sendRedirect(request.getContextPath() + "/MIS_4");
                } else {
                    request.getRequestDispatcher(view).forward(request, response);
                }
            } else {
                request.getRequestDispatcher(view).forward(request, response);
            }
        } catch (Exception e) {
            request.getRequestDispatcher(view).forward(request, response);
        }

//        Menu.setMenu("VIEW REPORTS", "MIS_4_DGFP", request);
//        request.getRequestDispatcher("WEB-INF/jsp/reports9th/mis-4-9-dgfp.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String action = request.getParameter("action"), divisionId = request.getParameter("division"), districtId = request.getParameter("district"), upazilaId = request.getParameter("upazila"), providerId = request.getParameter("providerId"), month = request.getParameter("month"), year = request.getParameter("year");

        JSONArray mis4Json = new JSONArray();
        JSONArray unionJson = new JSONArray();
        JSONArray descendantSubmissionStatus = new JSONArray();

        JSONArray mis4ColorJson = new JSONArray();
        
        //Facility Submission Status
        if (action.equalsIgnoreCase("descendantSubmissionStatus")){
            response.setContentType("text/plain;charset=UTF-8");
            try {
                System.out.println(divisionId + districtId);
                descendantSubmissionStatus = this.getDescendantSubmissionStatus(districtId, upazilaId, month, year);
                response.getWriter().write("{\"mis4_descendant_submission_status\":" + descendantSubmissionStatus + "}");
            } catch (Exception e) {
            }
        }

        //MISStatusService
        if (action.equalsIgnoreCase("showdata")) {
            response.setContentType("text/plain;charset=UTF-8");
            mis4ColorJson = new MISStatusService(Integer.parseInt(districtId)).getMIS4Color(Integer.parseInt(districtId), Integer.parseInt(upazilaId), Integer.parseInt(month), Integer.parseInt(year));

            try {
                Boolean isSubmitable = this.isSubmitable(districtId, upazilaId, month, year);
                unionJson = this.getUnion(districtId, upazilaId);
                if (isSubmitable) {
                    submissionId = 0;
                    mis4Json = this.getMIS4(districtId, upazilaId, providerId, month, year, false);
                    response.getWriter().write("{\"mis4\":" + mis4Json + ",\"isSubmittable\":" + isSubmitable + ",\"modrep\":" + modeRep + ",\"mis4Color\":" + mis4ColorJson + ",\"union\":" + unionJson + "}");

                } else if (!isSubmitable && isApprove != 1) {

                    mis4Json = this.getMIS4(districtId, upazilaId, providerId, month, year, false);
                    response.getWriter().write("{\"mis4\":" + mis4Json.toString() + ",\"isSubmittable\":" + isSubmitable + ",\"submissionId\":" + submissionId + ", \"modrep\":" + modeRep + ", \"status\":" + isApprove + ",\"mis4Color\":" + mis4ColorJson + ", \"ngo\":" + this.getNGOData(districtId, upazilaId, month, year) + ",\"union\":" + unionJson + ",\"submissionDate\":\"" + submissionDate.split(" ")[0] + "\"}");

                } else {
                    mis4Json = this.getMIS4(districtId, upazilaId, providerId, month, year, false);
                    response.getWriter().write("{\"mis4\":" + mis4Json.toString() + ",\"submissionId\":" + submissionId + ", \"modrep\":" + modeRep + ", \"status\":" + isApprove + ",\"mis4Color\":" + mis4ColorJson + ",\"ngo\":" + this.getNGOData(districtId, upazilaId, month, year) + ",\"union\":" + unionJson + ",\"submissionDate\":\"" + submissionDate.split(" ")[0] + "\"}");

                }
            } catch (Exception ex) {
            }
        }

        if (action.equalsIgnoreCase("submitReport")) {

            //Status 0=notsubmitted/Pending     1=Submited      2=Need to resubmit      3=Resubmitted   4=Reopen
            String subType = request.getParameter("subType");
            String resultJson = "[{\"status\": \"error\",\"message\": \"Somthing went wrong\"}]";
            int modeRep = 704;
            String data = request.getParameter("data");
            String note = request.getParameter("note");
            String html = request.getParameter("html");

            try {
                //get supervisor code
                providerId = Service.getUFPOByUpazilaDGFP(districtId, upazilaId) + "";

                System.out.println("Provider: " + providerId);
                String supervisorCode = districtId + "0000";//Service.getUserSupervisor(Integer.parseInt(provCode), Integer.parseInt(districtId));
                //Action quries
                String report_submission = "";
                String report_review = "";

                if (subType.equals("2")) {
                    report_submission = "UPDATE public.web_report_submission_dgfp SET approved=3, data='" + data + "'::json, html='" + html + "', modifydate=now() \n"
                            + "WHERE submission_id=" + submissionId + " and modrep=" + modeRep + " and divid=" + divisionId + " and zillaid=" + districtId + " and upazilaid=" + upazilaId + "and unionid=999 and month=" + month + " and year=" + year;

                    report_review = "INSERT INTO public.web_report_review_dgfp(submission_id, submission_from, submission_to, status, notes, data, html) \n"
                            + "VALUES (" + submissionId + ", " + providerId + ", " + supervisorCode + ", 3, '" + note + "',  '" + data + "'::json, '" + html + "');";

                } else if (subType.equals("undefined")) {
                    String subId = request.getParameter("submissionId");
                    report_submission = "INSERT INTO public.web_report_submission_dgfp(submission_id,submission_from, submission_to, approved, modrep,divid, zillaid\n"
                            + ", upazilaid, unionid, month, year, provtype, data, html) VALUES\n"
                            + " ( " + subId + ", " + providerId + ", " + supervisorCode + ", 0, " + modeRep + ", " + divisionId + ", " + districtId + ", " + upazilaId + ", 999, " + month + ", " + year + ", 15,  '" + data + "'::json, '" + html + "');";

                    report_review = "INSERT INTO public.web_report_review_dgfp(submission_id, submission_from, submission_to, status, notes, data, html) \n"
                            + "VALUES (" + subId + ", " + providerId + ", " + supervisorCode + ", 0, '" + note + "',  '" + data + "'::json, '" + html + "');";
                }

                //Manual entry insertion here
                JSONObject mis4_ngo = new JSONObject(request.getParameter("mis4_ngo").toString().trim());
                mis4_ngo.put("year_no", year);
                mis4_ngo.put("month_no", month);
                mis4_ngo.put("zillaid", districtId);
                mis4_ngo.put("upazilaid", upazilaId);
                mis4_ngo.put("reporting_upazilaid", upazilaId);
                mis4_ngo.put("unionid", "1001");
                mis4_ngo.put("reporting_unionid", "1001");
                mis4_ngo.put("providerid", providerId);
                mis4_ngo.put("supervisorcode", supervisorCode + "");
                mis4_ngo.put("is_submitted", "1");
                mis4_ngo.put("is_approved", "0");
                String mis4_ngo_sql = this.ngoSQLGenerator(mis4_ngo);

                JSONObject mis4_versatile = new JSONObject(request.getParameter("mis4_versatile").toString().trim());
                mis4_versatile.put("year_no", year);
                mis4_versatile.put("month_no", month);
                mis4_versatile.put("zillaid", districtId);
                mis4_versatile.put("upazilaid", upazilaId);
                mis4_versatile.put("reporting_upazilaid", upazilaId);
                mis4_versatile.put("unionid", "1002");
                mis4_versatile.put("reporting_unionid", "1002");
                mis4_versatile.put("providerid", providerId);
                mis4_versatile.put("supervisorcode", supervisorCode + "");
                mis4_versatile.put("is_submitted", "1");
                mis4_versatile.put("is_approved", "0");
                String mis4_versatile_sql = this.ngoSQLGenerator(mis4_versatile);

                System.out.println("SQL: " + mis4_ngo_sql);
                System.out.println("SQL: " + mis4_versatile_sql);
                System.out.println("SQL: " + report_submission);
                System.out.println("SQL: " + report_review);

                DBManagerDistrict db = new DBManagerDistrict(Integer.parseInt(districtId));
                db.start();
                int resultReportSubmission = db.update(report_submission);
                int resultReportReview = db.update(report_review);
                int mis4_ngo_sql_ = db.update(mis4_ngo_sql);
                int mis4_versatile_sql_ = db.update(mis4_versatile_sql);

                if (resultReportSubmission == 1 && resultReportReview == 1 && mis4_versatile_sql_ == 1 && mis4_ngo_sql_ == 1) {
                    resultJson = "[{\"status\": \"success\",\"message\": \"Submitted successfully\"}]";
                    db.commit();
                } else {
                    resultJson = "[{\"status\": \"error\",\"message\": \"Somthing went wrong\"}]";
                    db.rollback();
                }
                response.setContentType("text/plain;charset=UTF-8");
                response.getWriter().write(resultJson);

            } catch (Exception ex) {
                ex.printStackTrace();
                response.setContentType("text/plain;charset=UTF-8");
                response.getWriter().write(resultJson);
            }
        } //end submite process
    }

    private JSONArray getMIS4(String districtId, String upazilaId, String providerId, String month, String year, Boolean returnAsSubmitted) {
        JSONArray mis4Json = null;
        try {
            String query = "SELECT * from public.web_mis4_report_9v_dgfp (" + districtId + ", " + upazilaId + "," + providerId + "," + year + "," + month + ") where is_approved=1 and active=1";
            System.out.println("SQL: " + query);
//            if (returnAsSubmitted) {
//                query += " where r_is_approved=1";
//            }
            mis4Json = Convertor.toJSON(new DBManagerDistrict(Integer.parseInt(districtId)).select(query));

            return mis4Json;
        } catch (Exception ex) {
            return mis4Json;
        }
    }

    private JSONArray getUnion(String districtId, String upazilaId) {
        JSONArray unionJson = null;
        try {
            //String query = "Select zillaid, upazilaid, unionid, unionnameeng, unionname from unions where zillaid = " + districtId + " and upazilaid = " + upazilaId + " and unionid not in (999) order by unionnameeng";
            String query = "select zillaid, upazilaid, reporting_unionid unionid, unionnameeng, unionname from reporting_union where zillaid = " + districtId + " and upazilaid = " + upazilaId + " order by reporting_unionid ";
            unionJson = Convertor.toJSON(new DBManagerDistrict(Integer.parseInt(districtId)).select(query));
            return unionJson;
        } catch (Exception ex) {
            return unionJson;
        }
    }

    private Boolean isSubmitable(String districtId, String upazilaId, String month, String year) {
        Connection connection = null;
        Boolean valid = true;
        try {
            DBManagerDistrict db = new DBManagerDistrict(Integer.parseInt(districtId));
            connection = db.openConnection();
            String sql = "  SELECT * FROM public.web_report_submission_dgfp where modrep=? and zillaid=? and upazilaid=? and month=? and year=?";
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, modeRep);
            preparedStatement.setInt(2, Integer.parseInt(districtId));
            preparedStatement.setInt(3, Integer.parseInt(upazilaId));
            preparedStatement.setInt(4, Integer.parseInt(month));
            preparedStatement.setInt(5, Integer.parseInt(year));
            ResultSet result = preparedStatement.executeQuery();
            System.out.format("SQL: ", result.getStatement().toString());
            while (result.next()) {
                valid = false;
                isApprove = result.getInt("approved");
                submissionId = result.getLong("submission_id");
                submissionDate = result.getString("modifydate");
            }
        } catch (Exception ex) {
        }
        return valid;
    }

    private String ngoSQLGenerator(JSONObject ngoObj) throws JSONException {

        String pKeys = "year_no, month_no, zillaid, upazilaid, unionid";
        List<String> Keys = new ArrayList<>();
        List<String> excludedKeys = new ArrayList<>();
        List<String> Vals = new ArrayList<>();

        Iterator<String> keys = ngoObj.keys();
        while (keys.hasNext()) {
            String k = keys.next();
            String v = (String) ngoObj.get(k);
            v = v.isEmpty() ? "0" : v;
            Keys.add(k);
            excludedKeys.add("excluded." + k);
            Vals.add(v);
        }
        String _keys = String.join(",", Keys);
        String _vals = String.join(",", Vals);
        System.out.println("Keys: " + String.join(",", Keys));
        System.out.println("Vals: " + String.join(",", Vals));

        String query = "INSERT INTO rpt_mis_form4_ufpo_9v_dgfp (%s) VALUES (%s) ON CONFLICT(%s) DO UPDATE SET (%s)=row(%s);";
        query = String.format(query, _keys, _vals, pKeys, _keys, String.join(",", excludedKeys));

        return query;
    }

    private JSONArray getNGOData(String districtId, String upazilaId, String month, String year) {
        JSONArray ngo = null;
        try {
            //String query = "select * from rpt_mis_form4_ufpo_9v where month_no = "+month+" and year_no = "+year+" and zillaid = "+districtId+" and upazilaid = "+upazilaId+" and unionid in (1001,1002)";
            String query = "select * from web_mis4_report_9v_ngo_dgfp(" + districtId + "," + upazilaId + "," + year + "," + month + ")";
            ngo = Convertor.toJSON(new DBManagerDistrict(Integer.parseInt(districtId)).select(query));
            return ngo;
        } catch (Exception ex) {
            return ngo;
        }
    }
    
    // Facility Submission Status
    private JSONArray getDescendantSubmissionStatus(String districtId, String upazilaId, String month, String year){
        JSONArray facilitySubmissionStatus = null;
        try {
            String query = "select * from web_get_mis4_descendants_submission_status(" + districtId + "," + upazilaId + "," + year + "," + month + ") order by reporting_unionid;";
            facilitySubmissionStatus = Convertor.toJSON(new DBManagerDistrict(Integer.parseInt(districtId)).select(query));
            System.out.println("facilitySubmissionStatus: " + facilitySubmissionStatus);
            return facilitySubmissionStatus;
        } catch (Exception e) {
            return facilitySubmissionStatus;
        }
    }
}
