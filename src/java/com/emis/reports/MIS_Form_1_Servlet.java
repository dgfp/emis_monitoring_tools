package com.emis.reports;

import com.emis.service.Service;
import com.emis.utility.Convertor;
import com.rhis.db.DBManagerDistrict;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Base64;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.JSONArray;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Helal | m.helal.k@gmail.com
 */

@WebServlet(name = "MIS_Form_1_Servlet", urlPatterns = {"/mis1-9"})
public class MIS_Form_1_Servlet extends HttpServlet {

    private String data = null;
    private long submissionId = 0;
    private int isApprove = 3; // by default is 3 means 3 is not the meaningfull status
    private int modeRep = 701;
    private String submissionDate = "";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        request.setAttribute("submenu", "mis1-9");
        request.setAttribute("menu", "VIEW REPORTS");
        request.setAttribute("userLevel", (String) request.getSession(false).getAttribute("userLevel"));
        RequestDispatcher view = request.getRequestDispatcher("WEB-INF/jsp/reports/mis-form-1.jsp");
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

        if (action.equalsIgnoreCase("showdata")) {
            try {

                Boolean isSubmitable = this.isSubmitable(districtId, upazilaId, unionId, fwaUnit, month, year, provCode);

                if (isSubmitable) {
                    submissionId = 0;
                    ArrayList<String> mis1 = this.getMis1RealData(divisionId, districtId, upazilaId, unionId, fwaUnit, month, year, date, dates, provCode);
                    response.setContentType("text/plain;charset=UTF-8");
                    response.getWriter().write("{\"MIS\":" + mis1.get(0) + "," + mis1.get(1) + ",\"CSBA\":" + mis1.get(2) + ",\"modrep\":" + modeRep + ",\"isSubmittable\":" + isSubmitable + ",\"submissionId\":" + submissionId +  "}");
                    //response.getWriter().write("{\"MIS\":" + mis1.get(0) + "," + mis1.get(1) + ",\"LMIS\":" + mis1.get(2) + ",\"CSBA\":" + mis1.get(3) + ",\"modrep\":" + modeRep + ",\"isSubmittable\":" + isSubmitable + ",\"submissionId\":" + submissionId +  "}");
                    
                    System.out.println("{\"MIS\":" + mis1.get(0) + "," + mis1.get(1) + ",\"LMIS\":" + mis1.get(2) + ",\"CSBA\":" + mis1.get(3) + ",\"modrep\":" + modeRep + ",\"isSubmittable\":" + isSubmitable + "}");
                
                } else if (!isSubmitable && isApprove != 1) {
                    
                    ArrayList<String> mis1 = this.getMis1RealData(divisionId, districtId, upazilaId, unionId, fwaUnit, month, year, date, dates, provCode);
                    response.setContentType("text/plain;charset=UTF-8");
                    response.getWriter().write("{\"MIS\":" + mis1.get(0) + "," + mis1.get(1) + ",\"CSBA\":" + mis1.get(2) + ",\"modrep\":" + modeRep + ",\"isSubmittable\":" + isSubmitable + ",\"submissionId\":" + submissionId + ",\"status\":" + isApprove + ",\"submissionDate\":\"" + submissionDate.split(" ")[0] + "\"}");
                    //response.getWriter().write("{\"MIS\":" + mis1.get(0) + "," + mis1.get(1) + ",\"LMIS\":" + mis1.get(2) + ",\"CSBA\":" + mis1.get(3) + ",\"modrep\":" + modeRep + ",\"isSubmittable\":" + isSubmitable + ",\"submissionId\":" + submissionId + ",\"status\":" + isApprove + "}");
                    
                } else {
                    System.out.println("Submission ID:" + submissionId);
                    //session.setAttribute("submissionId", submissionId);
                    response.setContentType("text/plain;charset=UTF-8");
                    //Add extra status variable
                    data = data.substring(0, data.length() - 1);
                    data += ",\"submissionId\":" + submissionId + ",\"modrep\":" + modeRep + ",\"status\":" + isApprove + ",\"submissionDate\":\"" + submissionDate.split(" ")[0] + "\"}";
                    response.getWriter().write(data);
                }

            } catch (Exception ex) {
                ex.getMessage();
            }
        }
        
        if (action.equalsIgnoreCase("getMIS1SubmissionCount")) {
            
            try {
            String query = "SELECT * from ";
            ResultSet result = new DBManagerDistrict(Integer.parseInt(districtId)).select(query);

            //LMIS excution
//            DBManagerLMIS db3 = new DBManagerLMIS();
//            ResultSet result3 = db3.select(lmis);

            JSONArray json = Convertor.convertResultSetIntoJSON(result);
            String responseJson1 = (json.toString()).substring(0, (json.toString()).length() - 2);

        } catch (Exception e) {
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

            //MISStatus misStatus = new ObjectMapper().readValue(request.getParameter("misStatus").toString(), MISStatus.class);
            //LMIS lmis = new ObjectMapper().readValue(request.getParameter("lmis").toString(), LMIS.class);
            
            try {
                //get supervisor code
                int supervisorCode = Service.getUserSupervisor(Integer.parseInt(provCode), Integer.parseInt(districtId));
                //Action quries
                String report_submission = "";
                String report_review = "";

                if (subType.equals("2")) {

                    report_submission = "UPDATE public.web_report_submission SET approved=3, data='" + data + "'::json, html='" + html + "', modifydate=now() \n"
                            + "WHERE submission_id=" + submissionId + " and modrep=" + modeRep + " and divid=" + divisionId + " and zillaid=" + districtId + " and upazilaid=" + upazilaId + " and unionid=" + unionId + " and month=" + month + " and year=" + year;

                    report_review = "INSERT INTO public.web_report_review(submission_id, submission_from, submission_to, status, notes, data, html) \n"
                            + "VALUES (" + submissionId + ", " + provCode + ", " + supervisorCode + ", 3, '" + note + "',  '" + data + "'::json, '" + html + "');";

                } else if (subType.equals("undefined")) {

                    String subId = request.getParameter("submissionId");
                    report_submission = "INSERT INTO public.web_report_submission(submission_id,submission_from, submission_to, approved, modrep,divid, zillaid\n"
                            + ", upazilaid, unionid, fwaunit, month, year, provtype, data, html) VALUES\n"
                            + " ( " + subId + ", " + provCode + ", " + supervisorCode + ", 0, " + modeRep + ", " + divisionId + ", " + districtId + ", " + upazilaId + ", " + unionId + ", " + fwaUnit + ", " + month + ", " + year + ", 3,  '" + data + "'::json, '" + html + "');";

                    report_review = "INSERT INTO public.web_report_review(submission_id, submission_from, submission_to, status, notes, data, html) \n"
                            + "VALUES (" + subId + ", " + provCode + ", " + supervisorCode + ", 0, '" + note + "',  '" + data + "'::json, '" + html + "');";
                }

                System.out.println("SQL/report_submission: " + report_submission);
                System.out.println("SQL/report_review: " + report_review);

                DBManagerDistrict db = new DBManagerDistrict(Integer.parseInt(districtId));
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
                response.setContentType("text/plain;charset=UTF-8");
                response.getWriter().write(resultJson);
            }
        } //end submite process
    }
    
    private Boolean isSubmitable(String districtId, String upazilaId, String unionId, String fwaUnit, String month, String year, String provCode) {
        Connection connection = null;
        Boolean valid = true;
        try {
            DBManagerDistrict db = new DBManagerDistrict(Integer.parseInt(districtId));
            //DBManagerMonitoring db = new DBManagerMonitoring();
            connection = db.openConnection();
            //for testing purpose
            String sql = "  SELECT * FROM public.web_report_submission where submission_from=? and zillaid=? and upazilaid=? and unionid=? and fwaunit=? and month=? and year=?";

            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, Integer.parseInt(provCode));
            //preparedStatement.setInt(2, 0);
            preparedStatement.setInt(2, Integer.parseInt(districtId));
            preparedStatement.setInt(3, Integer.parseInt(upazilaId));
            preparedStatement.setInt(4, Integer.parseInt(unionId));
            preparedStatement.setInt(5, Integer.parseInt(fwaUnit));
            preparedStatement.setInt(6, Integer.parseInt(month));
            preparedStatement.setInt(7, Integer.parseInt(year));
            ResultSet result = preparedStatement.executeQuery();

            System.out.format("SQL:- %s", result.getStatement().toString());

            while (result.next()) {
                valid = false;
                data = result.getString("data");

                isApprove = result.getInt("approved");
                submissionId = result.getLong("submission_id");
                submissionDate = result.getString("modifydate");

//                if (result.getInt("approved") == 1) {
//                    isApprove = 1;
//                } else if (result.getInt("approved") == 0) {
//                    isApprove = 0;
//                } else if (result.getInt("approved") == 2) {
//                    isApprove = 2;
//                }
            }
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        }
        return valid;
    }

    private ArrayList<String> getMis1RealData(String divisionId, String districtId, String upazilaId, String unionId, String fwaUnit, String month, String year, String date, String[] dates, String provCode) {

        //Preparation for LMIS execution
        ArrayList<String> mis1 = new ArrayList<>();
        //String lmis = null;
        try {
            
            /*
            DBManagerLMIS dbCheckOpening = new DBManagerLMIS();
            String sqlOpeningBalChecking = "select \"openingBalance\" from \"openingBalance\" where \"createdDate\" between '" + dates[0] + "' and '" + dates[1] + "' and \"providerId\" = '" + provCode + "' order by \"openingBalance\" desc limit 1";
            ResultSet resultCheckOpening = dbCheckOpening.select(sqlOpeningBalChecking);
            int openingBalance = 0;
            while (resultCheckOpening.next()) {
                openingBalance = resultCheckOpening.getInt("openingBalance");
            }

            DBManagerLMIS dbCheckReceive = new DBManagerLMIS();
            String sqlReceiptChecking = "select \"receiveQty\" from \"stockTransaction\" where \"systemEntryDate\" between '" + dates[0] + "' and '" + dates[1] + "' and \"providerId\" = '" + provCode + "' order by \"receiveQty\" desc limit 1 ";
            ResultSet resultCheckReceive = dbCheckReceive.select(sqlReceiptChecking);
            int receiptThisMonth = 0;
            while (resultCheckReceive.next()) {
                receiptThisMonth = resultCheckReceive.getInt("receiveQty");
            }

            //Checking
            String queryselect = null;
            String join = null;
            if (openingBalance >= 0 && receiptThisMonth >= 0) {
                queryselect = "a.\"itemCode\",a.\"misColumnNo\"";
                join = "RIGHT";

            }
            if (openingBalance >= 0 && receiptThisMonth <= 0) {
                queryselect = "aa.\"itemCode\",aa.\"misColumnNo\"";
                join = "LEFT";

            } else if (openingBalance <= 0 && receiptThisMonth >= 0) {
                queryselect = "a.\"itemCode\",a.\"misColumnNo\"";
                join = "RIGHT";

            }
            lmis = "select " + queryselect + ",aa.\"openingBalance\",a.\"receiptThisMonth\" ,c.\"adjustmentPlus\" ,d.\"adjustmentMinus\",b.\"distribution\" from (SELECT opb.\"itemCode\",itm.\"misColumnNo\",sum(opb.\"openingBalance\") as \"openingBalance\" from \"openingBalance\" opb LEFT JOIN \"itemMap\" itm on itm.\"rhisItemCode\" = opb.\"itemCode\"where opb.\"createdDate\" between '" + dates[0] + "' and '" + dates[1] + "' and opb.\"providerId\" = '" + provCode + "' group by opb.\"itemCode\",itm.\"misColumnNo\"order by itm.\"misColumnNo\" ) as aa " + join + " join ( select stm.\"itemCode\",itm.\"misColumnNo\",sum(stm.\"receiveQty\") as \"receiptThisMonth\" from \"stockTransaction\" stm LEFT JOIN \"itemMap\" itm on itm.\"rhisItemCode\" = stm.\"itemCode\" where stm.\"systemEntryDate\" between '" + dates[0] + "' and '" + dates[1] + "' and stm.\"providerId\" = '" + provCode + "' group by stm.\"itemCode\" ,itm.\"misColumnNo\" order by stm.\"itemCode\" asc ) as a on a.\"itemCode\"=aa.\"itemCode\" LEFT JOIN ( select \"stockTransaction\".\"itemCode\",sum(\"issueQty\") as \"distribution\" from \"stockTransaction\" where \"providerId\" = '" + provCode + "' and \"systemEntryDate\" between '" + dates[0] + "' and '" + dates[1] + "' group by \"stockTransaction\".\"itemCode\" ) as b on a.\"itemCode\" = b.\"itemCode\" LEFT JOIN ( select \"itemRequest\".\"itemCode\",sum(\"approveQty\") as \"adjustmentPlus\" from \"itemRequest\" where \"requestBy\" = '" + provCode + "' and \"systemEntryDate\" between '" + dates[0] + "' and '" + dates[1] + "' group by \"itemRequest\".\"itemCode\" ) c on b.\"itemCode\" = c.\"itemCode\" LEFT JOIN ( select \"itemAdjustmentMinus\".\"itemCode\",sum(\"adjustmentQty\") as \"adjustmentMinus\" from \"itemAdjustmentMinus\" where \"providerId\" = '" + provCode + "' and \"createdDate\" between '" + dates[0] + "' and '" + dates[1] + "' group by \"itemAdjustmentMinus\".\"itemCode\" ) d on c.\"itemCode\" = d.\"itemCode\"";
            */
            
            
            
            //Main Excution
            //Getting CSBA data
//            String jsonObject = "{}";
//            //String jsonObject = null;
//                    String str = "providerId=" + provCode + "&password=123&report1_zilla=" + districtId + "&report1_upazila=" + upazilaId + "&report1_union=" + unionId + "&report1_start_date=" + dates[0] + "&report1_end_date=" + dates[1] + "&csba=1";
//                    Base64.Encoder enc = Base64.getEncoder();
//                    byte[] strenc = enc.encode(str.getBytes("UTF-8"));
//                    String url = "http://mamoni.net:8080/rhis_fwc_monitoring/mis3report?" + new String(strenc, "UTF-8");
//                    System.out.println("URL: " + url);
//
//                    //Encode String as Base64
//                    URL getUrl = new URL(url);
//                    URLConnection con = getUrl.openConnection();
//                    BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
//                    String a;
//                    while ((a = in.readLine()) != null) {
//                        jsonObject = a;
//                    }
//                    System.out.println("OBJ: "+jsonObject);
//                    in.close();

            String query = "SELECT * from public.fn_mis_form1_ka_new(" + districtId + "," + upazilaId + "," + unionId + ",cast(null as integer),'" + fwaUnit + "'," + year + "," + month + "," + provCode + ")";
            String query2 = "SELECT * from public.fn_mis_form1_kha_ga_gha_uma_cha (" + districtId + "," + upazilaId + "," + unionId + ",cast(null as integer),'" + fwaUnit + "'," + year + "," + month + "," + provCode + ");";
            //String query_lmis = "select * from public.fn_mis_form1_lmis("+districtId+", "+upazilaId+", "+unionId+", "+fwaUnit+", "+year+", "+month+");";
            //String query_lmis = "";
            
            //DBManagerDistrict db = new DBManagerDistrict(Integer.parseInt(districtId));
            ResultSet result = new DBManagerDistrict(Integer.parseInt(districtId)).select(query);
            //DBManagerDistrict db2 = new DBManagerDistrict(Integer.parseInt(districtId));
            ResultSet result2 = new DBManagerDistrict(Integer.parseInt(districtId)).select(query2);
            
            //ResultSet result_lmis = new DBManagerLMIS().select(query_lmis);
            
            //System.out.println("@@@@@@@@@@@@@@@ "+new ReportSubmission().getLMIS(new DBManagerLMIS().select(query_lmis)));

            //LMIS excution
//            DBManagerLMIS db3 = new DBManagerLMIS();
//            ResultSet result3 = db3.select(lmis);

            JSONArray json = Convertor.convertResultSetIntoJSON(result);
            JSONArray json2 = Convertor.convertResultSetIntoJSON(result2);
            //JSONArray json3 = Convertor.convertResultSetIntoJSON(result3);

            //JSONArray resultJson=new JSONArray();
            //response.setContentType("text/plain;charset=UTF-8");
            String responseJson1 = (json.toString()).substring(0, (json.toString()).length() - 2);
            String responseJson2 = (json2.toString()).substring(2);
            //String lmis = (Convertor.toJSON(result_lmis,"0").toString()).substring(0);

            mis1.add(responseJson1); // Mis1
            mis1.add(responseJson2); //Mis 1
            //mis1.add(lmis); // LMIS
            mis1.add("{}"); //CSBA

            mis1.add(responseJson1);
            //response.getWriter().write("{\"MIS\":" + responseJson1 + "," + responseJson2 + ",\"LMIS\":" + responseJson3 + ",\"CSBA\":" + jsonObject + ",\"isSubmittable\":" + isSubmitable + "}");

        } catch (Exception e) {
        }

        return mis1;
    }

}
