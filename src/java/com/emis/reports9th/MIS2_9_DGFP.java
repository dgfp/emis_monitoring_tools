package com.emis.reports9th;

import com.emis.dao.MISDao;
import com.emis.dao.UserDao;
import com.emis.entity.Mis1SubmissionAttributes;
import com.emis.service.Service;
import com.emis.utility.Convertor;
import com.emis.utility.Menu;
import com.rhis.db.DBManagerDistrict;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.sql.Array;
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
import org.json.JSONObject;
import org.json.simple.parser.JSONParser;

/**
 *
 * @author Helal
 */
@WebServlet(name = "MIS2_9_DGFP", urlPatterns = {"/MIS_2_DGFP"})
public class MIS2_9_DGFP extends HttpServlet {

//    private String data = null;
//    private long submissionId = 0;
//    private int isApprove = 3; // by default is 3 means 3 is not the meaningfull status
    private int modeRep = 702;
//    private String submissionDate = "";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Menu.setMenu("VIEW REPORTS", "MIS_2_DGFP", request);
        String view = "WEB-INF/jsp/reports9th/mis-2-9-dgfp.jsp";
        try {
            if (request.getSession(false).getAttribute("district") != null) {
                if (!new UserDao().isPaperless(request.getSession(false).getAttribute("district").toString())) {
                    response.sendRedirect(request.getContextPath() + "/MIS_2");
                } else {
                    request.getRequestDispatcher(view).forward(request, response);
                }
            } else {
                request.getRequestDispatcher(view).forward(request, response);
            }
        } catch (Exception e) {
            request.getRequestDispatcher(view).forward(request, response);
        }
//        Menu.setMenu("VIEW REPORTS", "MIS_2_DGFP", request);
//        request.getRequestDispatcher("WEB-INF/jsp/reports9th/mis-2-9-dgfp.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String action = request.getParameter("action");
        String divisionId = request.getParameter("divisionId");
        String districtId = request.getParameter("districtId");
        String upazilaId = request.getParameter("upazilaId");
        String unionId = request.getParameter("unionId");
        String providerId = request.getParameter("providerId");
        String month = request.getParameter("month");
        String year = request.getParameter("year");

        JSONArray json = new JSONArray();
        JSONArray lmisJson = new JSONArray();
        JSONArray fpiFwaJson = new JSONArray();
        JSONArray fpiJson = new JSONArray();
        JSONArray fpiSubmittedJson = new JSONArray();
        JSONArray providers = new JSONArray();

        Mis1SubmissionAttributes msa = this.isSubmitable(districtId, upazilaId, unionId, month, year, Integer.parseInt(providerId));
        boolean isSubmitable = msa.isValid();
        long submissionId = msa.getSubmissionId();
        int isApprove = msa.getIsApprove();
        String submissionDate = msa.getSubmissionDate();

        if (action.equalsIgnoreCase("showdata")) {
            try {
//                Boolean isSubmitable = this.isSubmitable(districtId, upazilaId, unionId, month, year);
                providers = this.getProvider(districtId, upazilaId, unionId, providerId);
                Array unionids = new MISDao(this.toInt(districtId)).getUnionidsByReportingUnionId(this.toInt(districtId), this.toInt(upazilaId), this.toInt(unionId));
                if (isSubmitable) {
                    submissionId = 0;
                    json = this.getMIS2Report(districtId, upazilaId, unionId, providerId, month, year, true);
                    lmisJson = this.getMIS2LMIS(districtId, upazilaId, unionId, providerId, month, year, true);
                    fpiJson = this.getMIS2FPI(districtId, upazilaId, unionId, providerId, month, year, unionids);
                    fpiFwaJson = this.getMIS2FPIFWA(districtId, upazilaId, unionId, month, year, unionids);
                    System.out.println("1 Output: " + lmisJson);
                    response.setContentType("text/plain;charset=UTF-8");
                    response.getWriter().write("{\"mis2\":" + json + ",\"lmis\":" + lmisJson + ",\"fpi\":" + fpiJson + ",\"fpiFwaJson\":" + fpiFwaJson + ",\"isSubmittable\":" + isSubmitable + ",\"modrep\":" + modeRep + ",\"providers\":" + providers + "}");

                } else if (!isSubmitable && isApprove != 1) {
                    json = this.getMIS2Report(districtId, upazilaId, unionId, providerId, month, year, true);
                    lmisJson = this.getMIS2LMIS(districtId, upazilaId, unionId, providerId, month, year, true);
                    fpiJson = null;//this.getMIS2FPI(districtId, upazilaId, unionId, providerId, month, year, unionids);
                    fpiFwaJson = null;//this.getMIS2FPIFWA(districtId, upazilaId, unionId, month, year, unionids);
                    fpiSubmittedJson = this.getMIS2FPISubmitted(districtId, upazilaId, unionId, providerId, month, year, false);
                    System.out.println("2 Output: " + lmisJson);
                    response.setContentType("text/plain;charset=UTF-8");
                    response.getWriter().write("{\"mis2\":" + json.toString() + ",\"lmis\":" + lmisJson + ",\"fpi\":" + fpiJson + ",\"fpiFwaJson\":" + fpiFwaJson + ",\"fpiSubmittedJson\":" + fpiSubmittedJson + ",\"isSubmittable\":" + isSubmitable + ",\"submissionId\":" + submissionId + ", \"modrep\":" + modeRep + ", \"status\":" + isApprove + ",\"providers\":" + providers + ",\"submissionDate\":\"" + submissionDate.split(" ")[0] + "\"}");

                } else {
                    json = this.getMIS2Report(districtId, upazilaId, unionId, providerId, month, year, true);
                    lmisJson = this.getMIS2LMIS(districtId, upazilaId, unionId, providerId, month, year, true);
                    fpiJson = null;//this.getMIS2FPI(districtId, upazilaId, unionId, providerId, month, year, unionids);
                    fpiFwaJson = null;//this.getMIS2FPIFWA(districtId, upazilaId, unionId, month, year, unionids);
                    fpiSubmittedJson = this.getMIS2FPISubmitted(districtId, upazilaId, unionId, providerId, month, year, true);
                    int isExportToDHIS2 = 0;
                    if (districtId.equals("93")) {
                        isExportToDHIS2 = this.isExportToDHIS2(districtId, upazilaId, unionId, providerId, month, year);
                    }

                    System.out.println("3 Output: " + lmisJson);
                    session.setAttribute("submissionId", submissionId);
                    response.setContentType("text/plain;charset=UTF-8");
                    System.out.println("{\"mis2\":" + json.toString() + ",\"lmis\":{},\"submissionId\":" + submissionId + ", \"modrep\":" + modeRep + ", \"status\":" + isApprove + ",\"providers\":" + providers + "}");
                    response.getWriter().write("{\"mis2\":" + json.toString() + ",\"lmis\":" + lmisJson + ",\"fpi\":" + fpiJson + ",\"fpiFwaJson\":" + fpiFwaJson + ",\"fpiSubmittedJson\":" + fpiSubmittedJson + ",\"submissionId\":" + submissionId + ",\"isExportToDHIS2\":" + isExportToDHIS2 + ", \"modrep\":" + modeRep + ", \"status\":" + isApprove + ",\"providers\":" + providers + ",\"submissionDate\":\"" + submissionDate.split(" ")[0] + "\"}");
                }
            } catch (Exception ex) {
            }
        }

        if (action.equalsIgnoreCase("submitReport")) {
            //Status 0=notsubmitted/Pending     1=Submited      2=Need to resubmit      3=Resubmitted   4=Reopen
            String resultJson = "[{\"status\": \"error\",\"message\": \"Somthing went wrong\"}]";
            String subType = request.getParameter("subType");
            String data = request.getParameter("data");
            String note = request.getParameter("note");
            String html = request.getParameter("html");

            System.out.println("Sub Type: " + subType);

            try {
                //get supervisor code
                int supervisorCode = Service.getUserSupervisor(Integer.parseInt(providerId), Integer.parseInt(districtId));
                //Action quries
                String report_submission = "";
                String report_review = "";

                if (subType.equals("2")) {

                    report_submission = "UPDATE public.web_report_submission_dgfp SET approved=3, data='" + data + "'::json, html='" + html + "', modifydate=now() \n"
                            + "WHERE submission_id=" + submissionId + " and modrep=" + modeRep + " and divid=" + divisionId + " and zillaid=" + districtId + " and upazilaid=" + upazilaId + " and unionid=" + unionId + " and month=" + month + " and year=" + year;

                    report_review = "INSERT INTO public.web_report_review_dgfp(submission_id, submission_from, submission_to, status, notes, data, html) \n"
                            + "VALUES (" + submissionId + ", " + providerId + ", " + supervisorCode + ", 3, '" + note + "',  '" + data + "'::json, '" + html + "');";

                } else if (subType.equals("undefined")) {

                    String subId = request.getParameter("submissionId");
                    report_submission = "INSERT INTO public.web_report_submission_dgfp(submission_id,submission_from, submission_to, approved, modrep,divid, zillaid\n"
                            + ", upazilaid, unionid, reporting_unionid, month, year, provtype, data, html) VALUES\n"
                            + " ( " + subId + ", " + providerId + ", " + supervisorCode + ", 0, " + modeRep + ", " + divisionId + ", " + districtId + ", " + upazilaId + ", " + unionId + ", " + unionId + ", " + month + ", " + year + ", 10,  '" + data + "'::json, '" + html + "');";

                    report_review = "INSERT INTO public.web_report_review_dgfp(submission_id, submission_from, submission_to, status, notes, data, html) \n"
                            + "VALUES (" + subId + ", " + providerId + ", " + supervisorCode + ", 0, '" + note + "',  '" + data + "'::json, '" + html + "');";
                }

                DBManagerDistrict db = new DBManagerDistrict(Integer.parseInt(districtId));
                db.start();
                int resultReportSubmission = db.update(report_submission);
                int resultReportReview = db.update(report_review);
                if (resultReportSubmission == 1 && resultReportReview == 1) {
                    resultJson = "[{\"status\": \"success\",\"message\": \"Submitted successfully\"}]";

                    //Insert FPI FWA Data part
                    JSONParser parser = new JSONParser();
                    String s = request.getParameter("fpiJson").toString();
                    Object obj = parser.parse(s);
                    org.json.simple.JSONArray array = (org.json.simple.JSONArray) obj;
                    for (Object o : array) {
                        JSONObject fpiMIS2Json = new JSONObject(o.toString());
                        fpiMIS2Json.put("year_no", year);
                        fpiMIS2Json.put("month_no", month);
                        fpiMIS2Json.put("zillaid", districtId);
                        fpiMIS2Json.put("upazilaid", upazilaId);
                        fpiMIS2Json.put("reporting_unionid", unionId);
                        fpiMIS2Json.put("unionid", unionId);
                        fpiMIS2Json.put("is_submitted", "1");
                        fpiMIS2Json.put("is_approved", "0");

                        String pKeys = "year_no, month_no, zillaid, upazilaid, unionid, unit, providerid, supervisorcode";
                        List<String> Keys = new ArrayList<>();
                        List<String> Vals = new ArrayList<>();

                        Iterator<String> keys = fpiMIS2Json.keys();
                        while (keys.hasNext()) {
                            String k = keys.next();
                            String v = (String) fpiMIS2Json.get(k);
                            v = v.isEmpty() ? "0" : v;
                            Keys.add(k);
                            Vals.add(v);
                        }
                        String _keys = String.join(",", Keys);
                        String _vals = String.join(",", Vals);
                        String excludedKeys = "excluded." + String.join(",excluded.", Keys);
                        System.out.println("Keys: " + String.join(",", Keys));
                        System.out.println("Vals: " + String.join(",", Vals));

                        String query = "INSERT INTO rpt_mis_form1_fpi_9v_dgfp (%s) VALUES (%s) ON CONFLICT(%s) DO UPDATE SET (%s)=row(%s);";
                        query = String.format(query, _keys, _vals, pKeys, _keys, excludedKeys);
                        System.out.println("SQL Statement: " + query);
                        db.update(query);
                    }

                    db.commit();
                } else {
                    resultJson = "[{\"status\": \"error\",\"message\": \"Somthing went wrong\"}]";
                    db.rollback();
                }

                resultJson = "[{\"status\": \"success\",\"message\": \"Submitted successfully\"}]";
                response.setContentType("text/plain;charset=UTF-8");
                response.getWriter().write(resultJson);
            } catch (Exception ex) {
                System.out.println("---------------------------------------Exception: " + ex.getMessage() + "---------------------------------------");
                response.setContentType("text/plain;charset=UTF-8");
                response.getWriter().write(resultJson);
            }
        } //end submite process

        if (action.equalsIgnoreCase("exportToDHIS2")) {
            try {
                String url = "http://localhost:8091/interoperability/api/push-emis-mis2/";

                String q = "select * from web_get_mis2_fp_dhis2(" + districtId + ", " + upazilaId + ", " + unionId + ","
                        + providerId + "," + year + "," + month + ")";
                DBManagerDistrict db = new DBManagerDistrict(Integer.parseInt(districtId));
                ResultSet result = db.select(q);
                JSONArray dhis2JA = Convertor.toJSON(result);

                JSONObject jo = new JSONObject();
                //jo.put("orgunit", "30936694");
                jo.put("orgunit", divisionId + districtId + upazilaId + unionId);
                jo.put("databaseid", districtId);
                jo.put("divid", divisionId);
                jo.put("districtid", districtId);
                jo.put("upazilaid", upazilaId);
                jo.put("unionId", unionId);
                jo.put("month", month);
                jo.put("year", year);
                jo.put("data", dhis2JA);
                String res = this.send2Dhis2(new JSONObject().put("data", jo), url);
                System.out.println(String.format("First Name: %s %s", res, url));

                JSONObject joResponse = new JSONObject(res);
                if (joResponse.get("status").toString().equals("SUCCESS")) {
                    System.out.println("Success");
                    this.exportToDHIS2Update(districtId, upazilaId, unionId, providerId, month, year);
                    //write 
                }

                response.getWriter().write(res);
            } catch (Exception e) {
                System.out.println(e.getMessage());
                e.printStackTrace();
                response.getWriter().write("{\"status\":\"error\"}");
            }
        }
    }

//    private Boolean isSubmitable(String districtId, String upazilaId, String unionId, String month, String year) {
//        Connection connection = null;
//        Boolean valid = true;
//        try {
//            DBManagerDistrict db = new DBManagerDistrict(Integer.parseInt(districtId));
//            //DBManagerMonitoring db = new DBManagerMonitoring();
//            connection = db.openConnection();
//            String sql = "  SELECT * FROM public.web_report_submission_dgfp where modrep=? and zillaid=? and upazilaid=? and unionid=? and month=? and year=?";
//
//            PreparedStatement preparedStatement = connection.prepareStatement(sql);
//            preparedStatement.setInt(1, modeRep);
//            preparedStatement.setInt(2, Integer.parseInt(districtId));
//            preparedStatement.setInt(3, Integer.parseInt(upazilaId));
//            preparedStatement.setInt(4, Integer.parseInt(unionId));
//            preparedStatement.setInt(5, Integer.parseInt(month));
//            preparedStatement.setInt(6, Integer.parseInt(year));
//            ResultSet result = preparedStatement.executeQuery();
//            System.out.format("SQL: ", result.getStatement().toString());
//
//            while (result.next()) {
//                valid = false;
//                //data = result.getString("data");
//                isApprove = result.getInt("approved");
//                submissionId = result.getLong("submission_id");
//                submissionDate = result.getString("modifydate");
//            }
//        } catch (Exception ex) {
//        }
//        return valid;
//    }
    private Mis1SubmissionAttributes isSubmitable(String districtId, String upazilaId, String unionId, String month, String year, int providerId) {
        Connection connection = null;
        Boolean valid = true;
        Mis1SubmissionAttributes msa = new Mis1SubmissionAttributes();
        msa.setValid(true);
        try {
            DBManagerDistrict db = new DBManagerDistrict(Integer.parseInt(districtId));

            //DBManagerMonitoring db = new DBManagerMonitoring();
            connection = db.openConnection();
            String sql = "  SELECT * FROM public.web_report_submission_dgfp where modrep=? and zillaid=? "
                    + "and upazilaid=? and unionid=? and month=? and year=?"
                    + " and submission_from=?";

            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, modeRep);
            preparedStatement.setInt(2, Integer.parseInt(districtId));
            preparedStatement.setInt(3, Integer.parseInt(upazilaId));
            preparedStatement.setInt(4, Integer.parseInt(unionId));
            preparedStatement.setInt(5, Integer.parseInt(month));
            preparedStatement.setInt(6, Integer.parseInt(year));
            preparedStatement.setInt(7, providerId);
            ResultSet result = preparedStatement.executeQuery();
            System.out.format("SQL: ", result.getStatement().toString());

            while (result.next()) {
//                valid = false;
                //data = result.getString("data");
                msa.setValid(false);
                msa.setIsApprove(result.getInt("approved"));
                msa.setSubmissionId(result.getLong("submission_id"));
                msa.setSubmissionDate(result.getString("modifydate"));
            }
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        }
        return msa;
    }

    private JSONArray getMIS2Report(String districtId, String upazilaId, String unionId, String providerId, String month, String year, Boolean returnAsSubmitted) {
        JSONArray jsonResult = null;
        try {
            String query = "SELECT * from public.web_mis2_report_9v_dgfp (" + districtId + ", " + upazilaId + "," + unionId + "," + providerId + "," + year + "," + month + ")";
            if (returnAsSubmitted) {
                query += " where r_is_approved=1";
            }

            DBManagerDistrict db = new DBManagerDistrict(Integer.parseInt(districtId));
            ResultSet result = db.select(query);
            jsonResult = Convertor.toJSON(result);
            return jsonResult;
        } catch (Exception ex) {
            return jsonResult;
        }
    }

    private JSONArray getMIS2LMIS(String districtId, String upazilaId, String unionId, String providerId, String month, String year, Boolean returnAsSubmitted) {
        JSONArray jsonResult = null;
        try {
            //String query = "SELECT * FROM public.rpt_mis_form1_lmis_9v where month_no =" + month + " and year_no=" + year + " and zillaid=" + districtId + " and upazilaid=" + upazilaId + " and unionid=" + unionId + " and supervisorid=" + providerId;
            String query = "SELECT * FROM rpt_mis_form1_lmis_9v_dgfp where month_no =" + month + " and year_no=" + year + " and zillaid=" + districtId + " \n"
                    + "	and upazilaid=" + upazilaId + " and reporting_unionid=" + unionId + " --and supervisorcode=93264";
            if (returnAsSubmitted) {
                query += " and is_approved=1";
            }

            jsonResult = Convertor.toJSON(new DBManagerDistrict(Integer.parseInt(districtId)).select(query));
            return jsonResult;
        } catch (Exception ex) {
            return jsonResult;
        }
    }

    private JSONArray getMIS2FPI(String districtId, String upazilaId, String unionId, String providerId, String month, String year, Array unionids) {
        JSONArray jsonResult = null;
        try {
            String query = "select * from public.fn_mis_form2_2variable_meeting_199_200_fpi_dgfp(" + districtId + "," + upazilaId + ",'" + unionids + "'," + year + "," + month + ");";
            jsonResult = Convertor.toJSON(new DBManagerDistrict(Integer.parseInt(districtId)).select(query));
            return jsonResult;
        } catch (Exception ex) {
            ex.printStackTrace();
            return jsonResult;
        }
    }

    private JSONArray getMIS2FPIFWA(String districtId, String upazilaId, String unionId, String month, String year, Array unionids) {
        JSONArray jsonResult = null;
        try {
            String query = "select * from web_report_submission_mis2_by_fpi_dgfp(" + districtId + "," + upazilaId + ",'" + unionids + "'," + month + "," + year + ");";
            jsonResult = Convertor.toJSON(new DBManagerDistrict(Integer.parseInt(districtId)).select(query));
            return jsonResult;
        } catch (Exception ex) {
            ex.printStackTrace();
            return jsonResult;
        }
    }

    private JSONArray getMIS2FPISubmitted(String districtId, String upazilaId, String unionId, String supervisorid, String month, String year, Boolean returnAsSubmitted) {
        JSONArray jsonResult = null;
        try {
            String query = "select * from rpt_mis_form1_fpi_9v_dgfp where zillaid=" + districtId + " and upazilaid=" + upazilaId + " and unionid=" + unionId + " and supervisorcode=" + supervisorid + " and month_no=" + month + " and year_no=" + year;
//            if(returnAsSubmitted)
//                query += " and is_approved=1";

            jsonResult = Convertor.toJSON(new DBManagerDistrict(Integer.parseInt(districtId)).select(query));
            return jsonResult;
        } catch (Exception ex) {
            return jsonResult;
        }
    }

    private JSONArray getProvider(String districtId, String upazilaId, String unionId, String supervisorCode) {
        JSONArray jsonResult = null;
        try {
//            String query = "select distinct p.zillaid, p.upazilaid, p.unionid, pa.fwaunit, p.supervisorcode, p.providerid, p.provname, p.provtype from providerdb p\n"
//                    + "left join providerarea pa\n"
//                    + "on p.providerid = pa.providerid\n"
//                    + "WHERE p.zillaid = " + districtId + " \n"
//                    + "and   p.upazilaid = " + upazilaId + " \n"
//                    + "and   p.unionid = " + unionId + " \n"
//                    + "and   p.supervisorcode =" + supervisorCode + " and active=1 and pa.fwaunit is not null order by pa.fwaunit";
            String query = "select ru.zillaid, ru.upazilaid, ru.reporting_unionid unionid, um.unit fwaunit, ruf.providerid supervisorcode, pau.providerid, pdb.provname ,pau.assign_type\n"
                    + "	from reporting_union ru\n"
                    + "	left join reporting_union_fpi ruf using(zillaid, upazilaid, reporting_unionid)\n"
                    + "	left join unit_master um using (zillaid, upazilaid, reporting_unionid)\n"
                    + "	left join providerarea_unit pau on um.unitid = pau.unitid\n"
                    + "	left join providerdb pdb on pau.providerid = pdb.providerid\n"
                    + "	where ru.zillaid=" + districtId + " and ru.upazilaid=" + upazilaId + " and ru.reporting_unionid=" + unionId + " and pdb.active=1 --ruf.providerid =  93264 \n"
                    + "	order by unionid, fwaunit";

            DBManagerDistrict db = new DBManagerDistrict(Integer.parseInt(districtId));
            ResultSet result = db.select(query);
            jsonResult = Convertor.toJSON(result);
            return jsonResult;
        } catch (Exception ex) {
            return jsonResult;
        }
    }

    public HttpURLConnection makeConn(String strUrl) throws Exception {
        //String authStringEnc = this.getAuthStrEnc();

        URL urlObj = new URL(strUrl);
        HttpURLConnection httpCon = (HttpURLConnection) urlObj.openConnection();
        httpCon.setDoInput(true);
        httpCon.setDoOutput(true);
        httpCon.setRequestMethod("POST");
        //httpCon.setRequestProperty("Authorization", "Basic " + authStringEnc);
        httpCon.setRequestProperty("Content-Type", "application/json");

        return httpCon;
    }

    public String send2Dhis2(JSONObject jo, String strUrl) {
        System.out.println(jo.toString());
        String resp = null;
        try {
            HttpURLConnection httpConn = this.makeConn(strUrl);
            OutputStream os = httpConn.getOutputStream();
            os.write(jo.toString().getBytes("UTF-8"));
            os.close();

            resp = this.getInputStream(httpConn.getInputStream());
            System.out.println(resp);

        } catch (Exception e) {
            System.err.println("Error creating HTTP connection");
            e.printStackTrace();
        }
        return resp;
    }

    public String getInputStream(InputStream connIs) throws Exception {
        InputStreamReader isr = new InputStreamReader(connIs);
        int numCharsRead;
        char[] charArray = new char[1024];
        StringBuffer sb = new StringBuffer();
        while ((numCharsRead = isr.read(charArray)) > 0) {
            sb.append(charArray, 0, numCharsRead);
        }
        String result = sb.toString();
        return result;
    }

    private int isExportToDHIS2(String districtId, String upazilaId, String unionId, String providerId, String month, String year) {
        int result = 0;
        try {
            String query = "SELECT exported_to_dhis2 FROM public.web_mis_submission_dgfp where zillaid=" + districtId + " and upazilaid=" + upazilaId + " and reporting_unionid=" + unionId + " and month=" + month + " and year=" + year + " and providerid=" + providerId;
            ResultSet rs = new DBManagerDistrict(Integer.parseInt(districtId)).select(query);
            while (rs.next()) {
                result = rs.getInt("exported_to_dhis2");
            }
            return result;
        } catch (Exception ex) {
            return result;
        }
    }

    private int exportToDHIS2Update(String districtId, String upazilaId, String unionId, String providerId, String month, String year) {
        int result = 0;
        try {
            String query = "UPDATE public.web_mis_submission_dgfp SET exported_to_dhis2=1 where zillaid=" + districtId + " and upazilaid=" + upazilaId + " and reporting_unionid=" + unionId + " and month=" + month + " and year=" + year + " and providerid=" + providerId;
            DBManagerDistrict db = new DBManagerDistrict(Integer.parseInt(districtId));
            db.start();
            result = db.update(query);
            db.commit();
            return result;
        } catch (Exception ex) {
            return result;
        }
    }

    private int toInt(String num) {
        return Integer.parseInt(num);
    }

}
