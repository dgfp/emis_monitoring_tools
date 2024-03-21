package com.emis.reports;

import com.emis.service.Service;
import com.emis.utility.Convertor;
import com.emis.utility.Menu;
import com.rhis.db.DBManagerDistrict;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
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
@WebServlet(name = "MIS_2_Servlet", urlPatterns = {"/mis2-9"})
public class MIS_2_Servlet extends HttpServlet {
    
    private String data = null;
    private long submissionId = 0;
    private int isApprove = 3; // by default is 3 means 3 is not the meaningfull status
    private int modeRep = 702;
    private String submissionDate = "";
    //private int providerId = 691017;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Menu.setMenu("VIEW REPORTS", "mis2-9", request);
        request.getRequestDispatcher("WEB-INF/jsp/reports/mis-2_1.jsp").forward(request, response);
//        RequestDispatcher view = request.getRequestDispatcher("WEB-INF/jsp/reports/mis-2_1.jsp");
//        view.forward(request, response);
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
        JSONArray providers = new JSONArray();

        if (action.equalsIgnoreCase("showdata")) {
            try {
                Boolean isSubmitable = this.isSubmitable(districtId, upazilaId, unionId, month, year);
                providers = this.getProvider(districtId,upazilaId, providerId);
                if (isSubmitable) {
                    submissionId = 0;
                    json = this.getMIS2Report(districtId, upazilaId, unionId, providerId, month, year, false);
                    lmisJson = this.getMIS2LMIS(districtId, upazilaId, unionId, providerId, month, year, false);
                    
                    
                    System.out.println("1 Output: "+lmisJson);
                    
                    //lmisJson=new JSONArray("[{}]");
                    response.setContentType("text/plain;charset=UTF-8");
                    response.getWriter().write("{\"mis2\":" + json + ",\"lmis\":{},\"isSubmittable\":" + isSubmitable + ",\"modrep\":" + modeRep + ",\"providers\":" + providers + "}");

                } else if (!isSubmitable && isApprove != 1) {
                    json = this.getMIS2Report(districtId, upazilaId, unionId, providerId, month, year, false);
                    lmisJson = this.getMIS2LMIS(districtId, upazilaId, unionId, providerId, month, year, false);
                    System.out.println("2 Output: "+lmisJson);
                    response.setContentType("text/plain;charset=UTF-8");
                    response.getWriter().write("{\"mis2\":" + json.toString() + ",\"lmis\":{},\"isSubmittable\":" + isSubmitable + ",\"submissionId\":" + submissionId + ", \"modrep\":" + modeRep + ", \"status\":" + isApprove + ",\"providers\":" + providers + "}");
                    
                } else {
                    json = this.getMIS2Report(districtId, upazilaId, unionId, providerId, month, year, true);
                    lmisJson = this.getMIS2LMIS(districtId, upazilaId, unionId, providerId, month, year, true);
                    System.out.println("3 Output: "+lmisJson);
                    session.setAttribute("submissionId", submissionId);
                    response.setContentType("text/plain;charset=UTF-8");
                    System.out.println("{\"mis2\":" + json.toString() + ",\"lmis\":{},\"submissionId\":" + submissionId + ", \"modrep\":" + modeRep + ", \"status\":" + isApprove + ",\"providers\":" + providers + "}");
                    response.getWriter().write("{\"mis2\":" + json.toString() + ",\"lmis\":{},\"submissionId\":" + submissionId + ", \"modrep\":" + modeRep + ", \"status\":" + isApprove + ",\"providers\":" + providers + "}");
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

                    report_submission = "UPDATE public.web_report_submission SET approved=3, data='" + data + "'::json, html='" + html + "', modifydate=now() \n"
                            + "WHERE submission_id=" + submissionId + " and modrep=" + modeRep + " and divid=" + divisionId + " and zillaid=" + districtId + " and upazilaid=" + upazilaId + " and unionid=" + unionId + " and month=" + month + " and year=" + year;

                    report_review = "INSERT INTO public.web_report_review(submission_id, submission_from, submission_to, status, notes, data, html) \n"
                            + "VALUES (" + submissionId + ", " + providerId + ", " + supervisorCode + ", 3, '" + note + "',  '" + data + "'::json, '" + html + "');";

                } else if (subType.equals("undefined")) {

                    String subId = request.getParameter("submissionId");
                    report_submission = "INSERT INTO public.web_report_submission(submission_id,submission_from, submission_to, approved, modrep,divid, zillaid\n"
                            + ", upazilaid, unionid, month, year, provtype, data, html) VALUES\n"
                            + " ( " + subId + ", " + providerId + ", " + supervisorCode + ", 0, " + modeRep + ", " + divisionId + ", " + districtId + ", " + upazilaId + ", " + unionId + ", " + month + ", " + year + ", 10,  '" + data + "'::json, '" + html + "');";

                    report_review = "INSERT INTO public.web_report_review(submission_id, submission_from, submission_to, status, notes, data, html) \n"
                            + "VALUES (" + subId + ", " + providerId + ", " + supervisorCode + ", 0, '" + note + "',  '" + data + "'::json, '" + html + "');";                   
                    System.out.println(report_submission+"  ~  "+report_review);
                }
                //System.out.println("SQL/report_submission: " + report_submission);
                //System.out.println("SQL/report_review: " + report_review);
                DBManagerDistrict db = new DBManagerDistrict(Integer.parseInt(districtId));
                //DBManagerMonitoring db = new DBManagerMonitoring();
                db.start();
                int resultReportSubmission = db.update(report_submission);
                int resultReportReview = db.update(report_review);
                if (resultReportSubmission == 1 && resultReportReview == 1) {
                    resultJson = "[{\"status\": \"success\",\"message\": \"Submitted successfully\"}]";
                    db.commit();
                } else {
                    resultJson = "[{\"status\": \"error\",\"message\": \"Somthing went wrong\"}]";
                    db.rollback();
                }
                response.setContentType("text/plain;charset=UTF-8");
                response.getWriter().write(resultJson);
            } catch (Exception ex) {
                System.out.println("---------------------------------------Exception: "+ex.getMessage()+"---------------------------------------");
                response.setContentType("text/plain;charset=UTF-8");
                response.getWriter().write(resultJson);
            }
        } //end submite process
    }
    
    private Boolean isSubmitable(String districtId, String upazilaId, String unionId, String month, String year) {
        Connection connection = null;
        Boolean valid = true;
        try {
            DBManagerDistrict db = new DBManagerDistrict(Integer.parseInt(districtId));
            //DBManagerMonitoring db = new DBManagerMonitoring();
            connection = db.openConnection();
            String sql = "  SELECT * FROM public.web_report_submission where modrep=? and zillaid=? and upazilaid=? and unionid=? and month=? and year=?";

            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, modeRep);
            preparedStatement.setInt(2, Integer.parseInt(districtId));
            preparedStatement.setInt(3, Integer.parseInt(upazilaId));
            preparedStatement.setInt(4, Integer.parseInt(unionId));
            preparedStatement.setInt(5, Integer.parseInt(month));
            preparedStatement.setInt(6, Integer.parseInt(year));
            ResultSet result = preparedStatement.executeQuery();
            System.out.format("SQL: ", result.getStatement().toString());

            while (result.next()) {
                valid = false;
                //data = result.getString("data");
                isApprove = result.getInt("approved");
                submissionId = result.getLong("submission_id");
                submissionDate = result.getString("modifydate");
            }
        } catch (Exception ex) {
        }
        isApprove = 1;
        valid = false;
        return valid;
    }
        
    private JSONArray  getMIS2Report(String districtId, String upazilaId, String unionId, String providerId, String month, String year, Boolean returnAsSubmitted) {
        JSONArray jsonResult= null;
        try {
            // SELECT * from public.web_mis2_report (69, 9, 57, 691017, 2018, 3);
            String query = "SELECT * from public.web_mis2_report (" + districtId + ", " + upazilaId + "," + unionId + "," + providerId + "," + year + "," + month + ");";
            //return when mis2 will be approved 
            if(returnAsSubmitted)
                query = "SELECT * from public.web_mis2_report (" + districtId + ", " + upazilaId + "," + unionId + "," + providerId + "," + year + "," + month + ") where approved = 1";

            DBManagerDistrict db = new DBManagerDistrict(Integer.parseInt(districtId));
            ResultSet result = db.select(query);
            jsonResult = Convertor.toJSON(result);
            return jsonResult;
        } catch (Exception ex) {
            return jsonResult;
        }
    }
    
    private JSONArray  getMIS2LMIS(String districtId, String upazilaId, String unionId, String providerId, String month, String year, Boolean returnAsSubmitted) {
        JSONArray jsonResult= null;
        try {
            //String query = "SELECT * from public.web_mis2_report (" + districtId + ", " + upazilaId + "," + unionId + "," + providerId + "," + year + "," + month + ");";
            String query = "select * from public.rpt_mis_form1_lmis where year_no="+year+" and  month_no="+month+" and zillaid="+districtId+" and  upazilaid="+upazilaId+" and  unionid="+unionId+" and supervisorid = "+providerId+" order by unit";
            //return when mis2 will be approved 
            if(returnAsSubmitted)
                query = "select * from public.rpt_mis_form1_lmis where year_no="+year+" and  month_no="+month+" and zillaid="+districtId+" and  upazilaid="+upazilaId+" and  unionid="+unionId+" and supervisorid = "+providerId+" order by unit";
                //query = "SELECT * from public.web_mis2_report (" + districtId + ", " + upazilaId + "," + unionId + "," + providerId + "," + year + "," + month + ") where approved = 1";
            jsonResult = Convertor.toJSON(new DBManagerDistrict(Integer.parseInt(districtId)).select(query));
            return jsonResult;
        } catch (Exception ex) {
            return jsonResult;
        }
    }
    
    private JSONArray getProvider(String districtId, String upazilaId, String supervisorCode){
                JSONArray jsonResult= null;
        try {
            String query = "select distinct p.zillaid, p.upazilaid, p.unionid, pa.fwaunit, p.supervisorcode, p.providerid, p.provname, p.provtype from providerdb p\n" +
                                    "left join providerarea pa\n" +
                                    "on p.providerid = pa.providerid\n" +
                                    "WHERE p.zillaid = "+districtId+" \n" +
                                    "and   p.upazilaid = "+upazilaId+" \n" +
                                    "and   p.supervisorcode ="+supervisorCode+" and pa.fwaunit is not null order by pa.fwaunit" ;
            
            DBManagerDistrict db = new DBManagerDistrict(Integer.parseInt(districtId));
            ResultSet result = db.select(query);
            jsonResult = Convertor.toJSON(result);

            return jsonResult;

        } catch (Exception ex) {
            System.out.println("---------------------------------------Exception: "+ex.getMessage()+"---------------------------------------");
            return jsonResult;
        }
    }

}
