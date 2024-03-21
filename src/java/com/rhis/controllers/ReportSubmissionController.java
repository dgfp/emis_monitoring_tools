package com.rhis.controllers;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.emis.service.ReportSubmissionService;
import com.emis.utility.Convertor;
import com.rhis.db.DBManagerMonitoring;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.HttpSession;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

/**
 *
 * @author Helal | m.helal.k@gmail.com
 */
@WebServlet(name = "ReportSubmissionController", urlPatterns = {"/ReportSubmissionController"})
public class ReportSubmissionController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String action = request.getParameter("action");
        int districtId = Integer.parseInt(request.getParameter("districtId"));
        JSONObject jsonObject = new JSONObject();
        try {
            jsonObject.put("status", "error");
            jsonObject.put("message", "Somthing went wrong");
            jsonObject.put("data", JSONObject.NULL);

            String resultJson = "[{\"status\": \"error\",\"message\": \"Somthing went wrong\",\"data\": \"null\"}";
            ReportSubmissionService service = new ReportSubmissionService(districtId);

            // Get review process data by Report
            if (action.equalsIgnoreCase("ReviewDataByReport")) {
                int providerId = Integer.parseInt(request.getParameter("providerId").toString());
                int month = Integer.parseInt(request.getParameter("month").toString());
                int year = Integer.parseInt(request.getParameter("year").toString());
                int reportId = Integer.parseInt(request.getParameter("reportId").toString());
                JSONArray json = service.getReviewDataByReport(providerId, month, year, reportId);

                if (json != null) {
                    jsonObject.put("data", json.toString());
                    // resultJson = "{\"status\": \"success\",\"message\": \"Ok\",\"data\": \"" + json + "\"}";
                }

                response.setContentType("text/plain;charset=UTF-8");
                response.getWriter().write(jsonObject.toString());
            }

            // Get review data by submission id
            if (action.equalsIgnoreCase("ReviewDataByReportSubmissionId")) {
                System.out.println(request.getParameter("fwaUnit"));
                long submissionId = Long.parseLong(request.getParameter("submissionId"));
                int modrep = Integer.parseInt(request.getParameter("modrep"));
                JSONArray json = service.getReviewDataBySubmissionId(submissionId, modrep);

                if (json != null) {
                    jsonObject.put("data", json.toString());
                }
                if (modrep == 701) {
                    JSONArray lmis = service.getLMISData(Integer.parseInt(request.getParameter("districtId")), Integer.parseInt(request.getParameter("upazilaId")), Integer.parseInt(request.getParameter("unionId")), Integer.parseInt(request.getParameter("fwaUnit")), Integer.parseInt(request.getParameter("year")), Integer.parseInt(request.getParameter("month")));
                    JSONArray currentMonthLMIS = service.getCurrentMonthLMISData(Integer.parseInt(request.getParameter("districtId")),
                             Integer.parseInt(request.getParameter("upazilaId")),
                             Integer.parseInt(request.getParameter("unionId")),
                             Integer.parseInt(request.getParameter("fwaUnit")),
                             Integer.parseInt(request.getParameter("year")),
                             Integer.parseInt(request.getParameter("month")));
                    
                    jsonObject.put("lmisData", lmis.toString());

                    jsonObject.put("currentMonthLMIS", currentMonthLMIS.toString());
                } else {
                    jsonObject.put("lmisData", "[]");
                    jsonObject.put("currentMonthLMIS", "[]");
                }

                response.setContentType("text/plain;charset=UTF-8");
                response.getWriter().write(jsonObject.toString());
            }

        } catch (Exception ex) {
            System.out.println(ex.getMessage());
            Logger.getLogger(ReportSubmissionController.class.getName()).log(Level.SEVERE, null, ex);
            response.sendError(500, ex.getMessage());
        }

    }

}
