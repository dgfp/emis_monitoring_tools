package bd.govt.dgfp.meetingManagement;

import com.emis.entity.MISStatus;
import com.emis.service.MISStatusService;
import com.emis.service.Service;
import com.emis.utility.Convertor;
import com.emis.utility.Utility;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.rhis.db.DBManagerDistrict;
import java.io.IOException;
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
 * @author Helal
 */
@WebServlet(name = "WorkingPaper", urlPatterns = {"/working-paper"})
public class WorkingPaper extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher view = request.getRequestDispatcher("WEB-INF/jsp/meetingManagement/WorkingPaper.jsp");
        view.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            HttpSession session = request.getSession();
            String district = (String) session.getAttribute("district");
            String upazila = (String) session.getAttribute("upazila");
            String union = (String) session.getAttribute("union");
            String providerCode = (String) session.getAttribute("providerCode");
            String meetingNo = (String) session.getAttribute("meetingNo");
            String meetingYear = (String) session.getAttribute("meetingYear");
            String meetingMonth = (String) session.getAttribute("meetingMonth");
            String designation = (String) session.getAttribute("designation");
            if (designation.equals("FWA")) {
                System.out.println("~~~~~~~~~~~~~~~~~~~~~~~~~~~~FWA: " + providerCode);
                providerCode = Service.getUserSupervisor(Integer.parseInt(providerCode), Integer.parseInt(district)) + "";
                System.out.println("~~~~~~~~~~~~~~~~~~~~~~~~~~~~FPI: " + providerCode);
            }

            response.setContentType("text/plain;charset=UTF-8");
            switch (request.getParameter("action")) {
                case "getWorkingPaper":
                    DBManagerDistrict db = new DBManagerDistrict(966);
                    db.start();
//                    String sql = "select nar.zillaid,nar.upazilaid,nar.unionid,nar.providerid,nar.meeting_year,nar.meeting_month,nar.meeting_no,\n"
//                            + "nar.agenda_code,nar.report_no,nar.report_json,nai.itemcode,nai.itemdes from notice_agenda_report nar\n"
//                            + "left join notice_agenda_item nai on nai.itemcode = nar.agenda_code\n"
//                            + "where zillaid = " + district + " \n"
//                            + "and upazilaid = " + upazila + " \n"
//                            + "and unionid = " + union + " \n"
//                            + "and providerid = " + providerCode + " \n"
//                            + "and meeting_year = " + meetingYear + " \n"
//                            + "and meeting_month in (" + meetingMonth + ")\n"
//                            + "and meeting_no = " + meetingNo + " \n"
//                            + "and agenda_code in (2,3,4,5,6,7) \n"
//                            + "order by agenda_code;";

                    String sql = "select nar.zillaid,nar.upazilaid,nar.unionid,nar.providerid,nar.meeting_year,nar.meeting_month,nar.meeting_no,\n"
                            + "nar.agenda_code,nar.report_no,nar.report_json,nai.itemcode,nai.itemdes from notice_agenda_report nar\n"
                            + "left join notice_agenda_item nai on nai.itemcode = nar.agenda_code\n"
                            + "where zillaid = " + district + " \n"
                            + "and upazilaid = " + upazila + " \n"
                            + "and unionid = " + union + " \n"
                            + "and providerid = " + providerCode + " \n"
                            + "and meeting_year = " + meetingYear + " \n"
                            + "and meeting_month in (" + meetingMonth + ")\n"
                            + "and meeting_no = " + meetingNo + " \n"
                            + "order by agenda_code;";

//                    sql = "select nar.zillaid,nar.upazilaid,nar.unionid,nar.providerid,nar.meeting_year,nar.meeting_month,nar.meeting_no,\n"
//                            + "nar.agenda_code,nar.report_no,nar.report_json,nai.itemcode,nai.itemdes from notice_agenda_report nar\n"
//                            + "left join notice_agenda_item nai on nai.itemcode = nar.agenda_code\n"
//                            + "where zillaid = 99 \n"
//                            + "and upazilaid = 9 \n"
//                            + "and unionid = 57 \n"
//                            + "and providerid = 691017 \n"
//                            + "and meeting_year = 2021 \n"
//                            + "and meeting_month in (3)\n"
//                            + "and meeting_no = 4 \n"
//                            + "order by agenda_code;";

                    JSONArray jsonData = Convertor.toJSON(db.select(sql));
                    db.commit();
                    response.getWriter().write("{\"success\":true,\"data\":" + jsonData.toString() + "}");
                    break;
                case "getMIS1":
                    MISStatus misStatus = new ObjectMapper().readValue(request.getParameter("misStatus").toString(), MISStatus.class);
                    MISStatusService misStatusService = new MISStatusService(misStatus.getZillaid());
                    String mis1[] = misStatusService.getMIS1DGFP(misStatus).toString().split("~");
                    response.getWriter().write("{\"success\":true,\"data\":" + mis1[0] + ",\"modifydate\":\"" + mis1[1] + "\"}");
                    break;
                case "getMIS2":
                    MISStatus misStatus2 = new ObjectMapper().readValue(request.getParameter("misStatus").toString(), MISStatus.class);
                    MISStatusService misStatusService2 = new MISStatusService(misStatus2.getZillaid());
                    String mis2 = misStatusService2.getMIS2DGFP(misStatus2).toString();
                    response.getWriter().write("{\"success\":true,\"data\":" + mis2 + ",\"modifydate\":\"" + "" + "\"}");
                    break;

                default:
                    response.getWriter().write(new Utility().errorResponse());
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write(new Utility().errorResponse());
        }
    }
}
