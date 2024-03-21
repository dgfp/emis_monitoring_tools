package bd.govt.dgfp.meetingManagement;

import com.emis.entity.Catchment;
import com.emis.entity.NoticeMaster;
import bd.govt.dgfp.meetingManagement.MeetingInformationService;
import com.emis.entity.MeetingInformation;
import com.emis.service.Service;
import com.rhis.db.DBManagerDistrict;
import java.io.IOException;
import java.sql.ResultSet;
import java.util.ArrayList;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.json.JSONObject;

/**
 *
 * @author Helal
 */
@WebServlet(name = "MeetingMinutes", urlPatterns = {"/meeting-minutes"})
public class MeetingMinutes extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

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
            MeetingInformationService mis = new MeetingInformationService();
            MeetingInformation mi = mis.getMeetingInformation(district, upazila, union, meetingMonth, meetingYear, meetingNo, providerCode);
            //Get notice master meeting notice class
            request.setAttribute("noticeMaster", new MeetingNotice().getMeetingNotice(request));
            request.setAttribute("meetingInformation", mi);

            DBManagerDistrict db = new DBManagerDistrict(Integer.parseInt(district));
            db.start();
//            String query = "select * from (select t.attendees_id,\n"
//                    + "       nmd.item_weight,\n"
//                    + "       pdb.provname,\n"
//                    + "       nmd.designation_en_long\n"
//                    + "from notice_master_attendees t\n"
//                    + "join notice_master_designation nmd on t.attendees_type = nmd.designation_code\n"
//                    + "join providerdb pdb on pdb.providerid = t.attendees_id\n"
//                    + "where t.zillaid="+district+"\n"
//                    + "  and t.upazilaid = "+upazila+"\n"
//                    + "  and t.unionid= "+union+"\n"
//                    + "  and t.meeting_year = "+meetingYear+"\n"
//                    + "  and t.meeting_month = "+meetingMonth+"\n"
//                    + "  and t.meeting_no = "+meetingNo+"\n"
//                    + "  and nmd.is_outsider = 0\n"
//                    + "  and t.is_attendance = 1\n"
//                    + "union all \n"
//                    + "select t.attendees_id,\n"
//                    + "       nmd.item_weight,\n"
//                    + "       nop.name,\n"
//                    + "       nmd.designation_en_long\n"
//                    + "from notice_master_attendees t\n"
//                    + "join notice_master_designation nmd on t.attendees_type = nmd.designation_code\n"
//                    + "join public.notice_outside_participant nop on t.attendees_id = nop.id\n"
//                    + "where t.zillaid="+district+"\n"
//                    + "  and t.upazilaid = "+upazila+"\n"
//                    + "  and t.unionid= "+union+"\n"
//                    + "  and t.meeting_year = "+meetingYear+"\n"
//                    + "  and t.meeting_month = "+meetingMonth+"\n"
//                    + "  and t.meeting_no = "+meetingNo+"\n"
//                    + "  and nmd.is_outsider = 1\n"
//                    + "  and t.is_attendance = 1) rs\n"
//                    + "  order by rs.item_weight desc";
            String query = "Select * from public.web_get_meeting_participants_list(" + district
                    + ", " + upazila + ", " + union + ", 0, " + meetingYear + ", " + meetingMonth + ", " + meetingNo + ", 0);";
            ResultSet rsParticipants = db.select(query);
            ArrayList<String> participants = new ArrayList<String>();
            while (rsParticipants.next()) {
                String participantsArea = rsParticipants.getString("attendees_area");
                if(participantsArea == null){
                    participantsArea = "";
                }
                participants.add(rsParticipants.getString("provname") + " (" + rsParticipants.getString("designation_en_long") + ") " + participantsArea);
            }
            request.setAttribute("participants", participants);

            String queryDecisions = "select decision_des from notice_agenda_item_decision naid\n"
                    + "join notice_decision_item ndi on naid.agenda_code = ndi.agenda_code and naid.decisioncode = ndi.decision_code\n"
                    + "where naid.zillaid = " + district + " and naid.upazilaid = " + upazila + " and naid.unionid = " + union + " and meeting_month=" + meetingMonth + " and meeting_year=" + meetingYear + " and meeting_no = " + meetingNo;

            queryDecisions = "select decision from notice_master_detail where zillaid = " + district + " and upazilaid = " + upazila + " \n"
                    + "and unionid = " + union + " and meeting_month=" + meetingMonth + " and meeting_year=" + meetingYear + " and meeting_no = " + meetingNo;

//            queryDecisions = "select * from notice_master_detail nmd left join notice_agenda_item nai on nai.itemcode = nmd.agenda_code\n"
//                    + "where zillaid = 99 and upazilaid = 9 and unionid = 57 and meeting_month=4 and meeting_year=2021 and meeting_no = 6";
            queryDecisions = "select * from notice_master_detail nmd left join notice_agenda_item nai on nai.itemcode = nmd.agenda_code\n"
                    + "where zillaid =  " + district + "  and upazilaid =  " + upazila + "  and unionid =  " + union
                    + "  and meeting_month=" + meetingMonth + "  and meeting_year=" + meetingYear + "  and meeting_no = " + meetingNo
                    + " and nmd.decision is not null";
            ResultSet rsDecisions = db.select(queryDecisions);
            ArrayList<MeetingMinutesDecision> decisions = new ArrayList<MeetingMinutesDecision>();

            while (rsDecisions.next()) {
                MeetingMinutesDecision mmd = new MeetingMinutesDecision();
                mmd.setItem(rsDecisions.getString("itemdes"));
                JSONObject decision = new JSONObject(rsDecisions.getString("decision"));

                //System.out.println(decision.getString("values"));
                String decisionItemSQL = this.getDecisionItemSQL(decision.getString("ids"), decision.getString("ids").split(","));

                ResultSet rsDecisionItem = db.select(decisionItemSQL);
                ArrayList<String> decisionText = new ArrayList<String>();
                while (rsDecisionItem.next()) {
                    String decisionDes = rsDecisionItem.getString("decision_des");
                    if (!decision.isNull("values") && decisionDes.indexOf("R") != -1) {
                        String[] valueArray = decision.getString("values").split(",");
                        for (int i = 0; i < valueArray.length; i++) {
                            String replaceKey = "R" + i;
                            if (decisionDes != null) {
                                decisionDes = decisionDes.replace(replaceKey, valueArray[i]);
                            }
                        }
                    }
                    decisionText.add(decisionDes);
                }
                mmd.setDecisionText(decisionText);
//                System.out.println("KKKKKK "+decisionOther);
                decisions.add(mmd);
            }
            
            String queryOthers = "select * from web_meeting_get_other_agenda_decision(" + district + "," + upazila
                    + "," + union + "," + meetingMonth + "," + meetingYear + "," + meetingNo
                    + ");";

            ResultSet rsOthers = db.select(queryOthers);
            //Query other agenda
            while (rsOthers.next()) {
                
                if (rsOthers.getString("other_agenda1") != null) {
                    MeetingMinutesDecision mmdOthers = new MeetingMinutesDecision();
                    ArrayList<String> mmdOthersDecision = new ArrayList<>();
                    mmdOthers.setItem(rsOthers.getString("other_agenda1"));
                    mmdOthersDecision.add(rsOthers.getString("other_decision1"));
                    mmdOthers.setDecisionText(mmdOthersDecision);
                    decisions.add(mmdOthers);
                }
                if (rsOthers.getString("other_agenda2") != null) {
                    MeetingMinutesDecision mmdOthers = new MeetingMinutesDecision();
                    ArrayList<String> mmdOthersDecision = new ArrayList<>();
                    mmdOthers.setItem(rsOthers.getString("other_agenda2"));
                    mmdOthersDecision.add(rsOthers.getString("other_decision2"));
                    mmdOthers.setDecisionText(mmdOthersDecision);
                    decisions.add(mmdOthers);
                }
                if (rsOthers.getString("other_agenda3") !=null) {
                    MeetingMinutesDecision mmdOthers = new MeetingMinutesDecision();
                    ArrayList<String> mmdOthersDecision = new ArrayList<>();
                    mmdOthers.setItem(rsOthers.getString("other_agenda3"));
                    mmdOthersDecision.add(rsOthers.getString("other_decision3"));
                    mmdOthers.setDecisionText(mmdOthersDecision);
                    decisions.add(mmdOthers);
                }
                if (rsOthers.getString("other_agenda4") != null) {
                    MeetingMinutesDecision mmdOthers = new MeetingMinutesDecision();
                    ArrayList<String> mmdOthersDecision = new ArrayList<>();
                    mmdOthers.setItem(rsOthers.getString("other_agenda4"));
                    mmdOthersDecision.add(rsOthers.getString("other_decision4"));
                    mmdOthers.setDecisionText(mmdOthersDecision);
                    decisions.add(mmdOthers);
                }
            }
            request.setAttribute("decisions", decisions);

            db.commit();
            Catchment ch = new MeetingNotice().getCatchment(district, upazila, union);
            request.setAttribute("catchment", ch);
        } catch (Exception e) {
            e.printStackTrace();
        }
        RequestDispatcher view = request.getRequestDispatcher("WEB-INF/jsp/meetingManagement/MeetingMinutes.jsp");
        view.forward(request, response);

    }

    private String getDecisionItemSQL(String ids, String[] idArray) {
        String sql = "select * from notice_decision_item  \n"
                + "where decision_code in(" + ids + ") \n"
                + "ORDER BY CASE decision_code \n";
        int i = 1;
        for (String id : idArray) {
            sql += " WHEN " + id + " THEN " + i + "\n";
            i++;
        }
        sql += "END";
        return sql;
    }
}
