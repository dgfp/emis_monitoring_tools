package bd.govt.dgfp.meetingManagement;

import com.emis.entity.Catchment;
import com.emis.entity.NoticeMaster;
import com.emis.entity.MeetingInformation;
import com.emis.service.Service;
import com.emis.utility.Convertor;
import com.emis.utility.Print;
import com.rhis.db.DBManagerDistrict;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.json.JSONArray;
import java.time.format.DateTimeFormatter;

/**
 *
 * @author Helal
 */
@WebServlet(name = "MeetingNotice", urlPatterns = {"/meeting-notice"})
public class MeetingNotice extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        try {
//            String meetingNo = request.getParameter("meetingNo");
//            String meetingYear = request.getParameter("meetingYear");
//            String meetingMonth = request.getParameter("meetingMonth");
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
            MeetingInformation mi = this.getMeetingInformation(district, upazila, union, meetingMonth, meetingYear, meetingNo, providerCode);
            request.setAttribute("meetingInformation", mi);
            DBManagerDistrict db = new DBManagerDistrict(Integer.parseInt(district));
            db.start();

//            String sql = "select meeting_date\n"
//                    + "	,meeting_time\n"
//                    + "	,case when place = 1 then 'ইউনিয়ন স্বাস্থ্য ও পরিবার কল্যাণ কেন্দ্র'  else 'উপজিলা পরিবার পরিকল্পনা অফিস' end as place \n"
//                    + "	,case when meeting_type = 1 then '১ম পাক্ষিক সভা' else '২য় পাক্ষিক সভা' end as meeting_type \n"
//                    + "	,meeting_circulate_date\n"
//                    + "	--,place\n"
//                    + "	,case \n"
//                    + "		when fwa = 1\n"
//                    + "			then 'পরিবার কল্যাণ সহকারী'\n"
//                    + "		else ''\n"
//                    + "		end as fwa\n"
//                    + "	,case \n"
//                    + "		when fwv = 1\n"
//                    + "			then 'পরিবার কল্যাণ পরিদর্শিকা'\n"
//                    + "		else ''\n"
//                    + "		end fwv\n"
//                    + "	,case \n"
//                    + "		when pharmacist = 1\n"
//                    + "			then 'ফার্মাসিস্ট'\n"
//                    + "		else ''\n"
//                    + "		end pharmacist\n"
//                    + "	,case \n"
//                    + "		when ucmo = 1\n"
//                    + "			then 'উপসহকারী কমিউনিটি মেডিকেল অফিসার'\n"
//                    + "		else ''\n"
//                    + "		end ucmo\n"
//                    + "	,case \n"
//                    + "		when ufpo = 1\n"
//                    + "			then 'উপজিলা পরিবার পরিকল্পনা কর্মকর্তা'\n"
//                    + "		else ''\n"
//                    + "		end cc_ufpo\n"
//                    + "	,case \n"
//                    + "		when uch = 1\n"
//                    + "			then 'ইউনিয়ন পরিষদ চেয়ারম্যান'\n"
//                    + "		else ''\n"
//                    + "		end cc_uch\n"
//                    + "from notice_master_new\n"
//                    + "where zillaid = " + district + "\n"
//                    + "	and upazilaid = " + upazila + "\n"
//                    + "	and unionid = " + union + "\n"
//                    + "	--and providerid = " + providerCode + "\n"
//                    + "	and meeting_year = " + meetingYear + " \n"
//                    + "	and meeting_month = " + meetingMonth + " \n"
//                    + "	and meeting_no = " + meetingNo + "";
//            System.out.println(sql);
//            ResultSet rs = db.select(sql);
//            NoticeMaster nm = new NoticeMaster();
//            while (rs.next()) {
//                nm.setMeeting_date(rs.getString("meeting_date"));
//                nm.setMeeting_circulate_date(rs.getString("meeting_circulate_date"));
//                nm.setMeeting_time(rs.getString("meeting_time"));
//                nm.setMeeting_type(rs.getString("meeting_type"));
//                nm.setPlace(rs.getString("place"));
//                nm.setFwa(rs.getString("fwa"));
//                nm.setFwv(rs.getString("fwv"));
//                nm.setPharmacist(rs.getString("pharmacist"));
//                nm.setUcmo(rs.getString("ucmo"));
//                nm.setCc_ufpo(rs.getString("cc_ufpo"));
//                nm.setCc_uch(rs.getString("cc_uch"));
//            }
//            request.setAttribute("noticeMaster", nm);

            String query = "select CASE\n"
                    + "    when nmd.agenda_code = 16 then nai.itemdes||': '||nmd.others_des\n"
                    + "    ELSE\n"
                    + "    nai.itemdes\n"
                    + "END as itemdes\n"
                    + "	,nmd.*\n"
                    + "from notice_master_detail nmd\n"
                    + "INNER JOIN notice_agenda_item nai on nai.itemcode = nmd.agenda_code\n"
                    + "where nmd.zillaid = " + district + "\n"
                    + "	and nmd.upazilaid = " + upazila + "\n"
                    + "	and nmd.unionid = " + union + "\n"
                    + "	--and nmd.providerid = " + providerCode + "\n"
                    + "	and nmd.meeting_year = " + meetingYear + "\n"
                    + "	and nmd.meeting_month = " + meetingMonth + "\n"
                    + "	and nmd.meeting_no = " + meetingNo 
                    + " and nmd.agenda_code != 16"
                    + ";"
                    ;
            // select * from web_meeting_get_other_agenda_decision(99,23,59,4,2022,4);
            String queryOthers = "select * from web_meeting_get_other_agenda_decision(" + district + "," + upazila
                    + "," + union + "," + meetingMonth + "," + meetingYear + "," + meetingNo
                    +");";
            ResultSet rsDetails = db.select(query);
            ResultSet rsOthers = db.select(queryOthers);
            ArrayList<String> details = new ArrayList<String>();
            ArrayList<String> otherAgendas = new ArrayList<String>();
            while (rsDetails.next()) {
                details.add(rsDetails.getString("itemdes"));
            }
            while (rsOthers.next()) {
                if(!rsOthers.getString("other_agenda1").isEmpty()){
                    details.add(rsOthers.getString("other_agenda1"));
                }
                if(!rsOthers.getString("other_agenda2").isEmpty()){
                    details.add(rsOthers.getString("other_agenda2"));
                }
                if(!rsOthers.getString("other_agenda3").isEmpty()){
                    details.add(rsOthers.getString("other_agenda3"));
                }
                if(!rsOthers.getString("other_agenda4").isEmpty()){
                    details.add(rsOthers.getString("other_agenda4"));
                }
            }
            request.setAttribute("noticeMasterDetails", details);
            request.setAttribute("noticeMasterOther", otherAgendas);
            db.commit();

            request.setAttribute("catchment", this.getCatchment(district, upazila, union));
        } catch (Exception e) {
            e.printStackTrace();
        }
        RequestDispatcher view = request.getRequestDispatcher("WEB-INF/jsp/meetingManagement/MeetingNotice.jsp");
        view.forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

    protected NoticeMaster getMeetingNotice(HttpServletRequest request) throws SQLException {

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

        DBManagerDistrict db = new DBManagerDistrict(Integer.parseInt(district));
        db.start();
        String sql = "select meeting_date\n"
                + "	,meeting_time\n"
                + "	,case when place = 1 then 'ইউনিয়ন স্বাস্থ্য ও পরিবার কল্যাণ কেন্দ্র'  else 'উপজিলা পরিবার পরিকল্পনা অফিস' end as place \n"
                + "	,case when meeting_type = 1 then '১ম পাক্ষিক সভা' else '২য় পাক্ষিক সভা' end as meeting_type \n"
                + "	,meeting_circulate_date\n"
                + "	--,place\n"
                + "	,case \n"
                + "		when fwa = 1\n"
                + "			then 'পরিবার কল্যাণ সহকারী'\n"
                + "		else ''\n"
                + "		end as fwa\n"
                + "	,case \n"
                + "		when fwv = 1\n"
                + "			then 'পরিবার কল্যাণ পরিদর্শিকা'\n"
                + "		else ''\n"
                + "		end fwv\n"
                + "	,case \n"
                + "		when pharmacist = 1\n"
                + "			then 'ফার্মাসিস্ট'\n"
                + "		else ''\n"
                + "		end pharmacist\n"
                + "	,case \n"
                + "		when ucmo = 1\n"
                + "			then 'উপসহকারী কমিউনিটি মেডিকেল অফিসার'\n"
                + "		else ''\n"
                + "		end ucmo\n"
                + "	,case \n"
                + "		when ufpo = 1\n"
                + "			then 'উপজিলা পরিবার পরিকল্পনা কর্মকর্তা'\n"
                + "		else ''\n"
                + "		end cc_ufpo\n"
                + "	,case \n"
                + "		when uch = 1\n"
                + "			then 'ইউনিয়ন পরিষদ চেয়ারম্যান'\n"
                + "		else ''\n"
                + "		end cc_uch\n"
                + "from notice_master_new\n"
                + "where zillaid = " + district + "\n"
                + "	and upazilaid = " + upazila + "\n"
                + "	and unionid = " + union + "\n"
                + "	--and providerid = " + providerCode + "\n"
                + "	and meeting_year = " + meetingYear + " \n"
                + "	and meeting_month = " + meetingMonth + " \n"
                + "	and meeting_no = " + meetingNo + "";
        ResultSet rs = db.select(sql);
        NoticeMaster nm = new NoticeMaster();
        while (rs.next()) {
            nm.setMeeting_date(rs.getString("meeting_date"));
            nm.setMeeting_circulate_date(rs.getString("meeting_circulate_date"));
            nm.setMeeting_time(rs.getString("meeting_time"));
            nm.setMeeting_type(rs.getString("meeting_type"));
            nm.setPlace(rs.getString("place"));
            nm.setFwa(rs.getString("fwa"));
            nm.setFwv(rs.getString("fwv"));
            nm.setPharmacist(rs.getString("pharmacist"));
            nm.setUcmo(rs.getString("ucmo"));
            nm.setCc_ufpo(rs.getString("cc_ufpo"));
            nm.setCc_uch(rs.getString("cc_uch"));
        }
        db.commit();
        return nm;
    }

    protected Catchment getCatchment(String zillaid, String upazilaid, String unionid) throws SQLException {
        DBManagerDistrict db = new DBManagerDistrict(Integer.parseInt(zillaid));
        db.start();
        String sql = "select * from zilla z\n"
                + "join upazila u using (zillaid)\n"
                + "join unions un using (zillaid, upazilaid)\n"
                + "where un.zillaid = " + zillaid + "\n"
                + "and un.upazilaid = " + upazilaid + " \n"
                + "and un.unionid = " + unionid + "";

        ResultSet rs = db.select(sql);
        Catchment ch = new Catchment();
        while (rs.next()) {
            ch.setZillaid(rs.getInt("zillaid"));
            ch.setZillaname(rs.getString("zillaname"));
            ch.setZillanameeng(rs.getString("zillanameeng"));
            ch.setUpazilaid(rs.getInt("upazilaid"));
            ch.setUpazilaname(rs.getString("upazilaname"));
            ch.setUpazilanameeng(rs.getString("upazilanameeng"));
            ch.setUnionid(rs.getInt("unionid"));
            ch.setUnionname(rs.getString("unionname"));
            ch.setUnionnameeng(rs.getString("unionnameeng"));
        }
        db.commit();
        return ch;
    }

    protected MeetingInformation getMeetingInformation(String zillaid, String upazilaid, String unionid, String meetingMonth,
            String meetingYear, String meetingNo, String providerCode) throws SQLException {

        String meeting_info_sql = "select z.zillaname, rupz.reporting_upazilaname, ru.unionname, concat(z.zillaid,'-',rupz.reporting_upazilaid, \n"
                + "            '-', ru.reporting_unionid, '-', nmn.meeting_month, '-', nmn.meeting_year, '-', nmn.meeting_no, '-', nmn.meeting_type) as file_name,\n"
                + "nmn.meeting_year,\n"
                + "       nmn.meeting_month,\n"
                + "       nmt.itemdes as meeting_type,\n"
                + "       nmp.itemdes place, -- nmn.meeting_type,\n"
                + "        -- nmn.meeting_time,\n"
                + "        to_char( to_timestamp ( nmn.meeting_time , 'HH12:MI' ) , 'HH24:MI ' ) meeting_time,\n"
                + "        nmn.meeting_held\n"
                + "            from notice_master_new nmn\n"
                + "            join notice_meeting_place nmp on nmn.place = nmp.itemcode\n"
                + "            join notice_meeting_type nmt on nmn.meeting_type = nmt.itemcode\n"
                + "            join zilla z on z.zillaid = nmn.zillaid\n"
                + "            join public.reporting_upazila rupz on z.zillaid = rupz.zillaid and rupz.reporting_upazilaid = nmn.upazilaid\n"
                + "            join public.reporting_union ru on z.zillaid = ru.zillaid and rupz.reporting_upazilaid = ru.upazilaid and nmn.unionid = ru.reporting_unionid\n"
                + "            where nmn.zillaid = " + zillaid + "\n"
                + "            and nmn.upazilaid = " + upazilaid + "\n"
                + "            and nmn.unionid = " + unionid + "\n"
                + "            and nmn.meeting_month = " + meetingMonth + "\n"
                + "            and nmn.meeting_year = " + meetingYear + "\n"
                + "            and nmn.meeting_no = " + meetingNo + "\n"
                + "            ;";
        DateFormat dtf = new SimpleDateFormat("dd/mm/yyyy");
        DBManagerDistrict db = new DBManagerDistrict(Integer.parseInt(zillaid));
        db.start();
        ResultSet rs = db.select(meeting_info_sql);
        MeetingInformation mi = new MeetingInformation();
        while (rs.next()) {
            System.out.println(rs.getString("meeting_held"));
            mi.setMeeting_date(rs.getString("meeting_held"));
            System.out.println(mi.getMeeting_date());
            mi.setMeeting_time(rs.getString("meeting_time"));
            mi.setMeeting_place(rs.getString("place"));
            mi.setMeeting_type(rs.getString("meeting_type"));
        }

        String meeting_participants_sql = "select Concat(name, ' (', designation_en_long, '), ', attendees_area) as designation_bn_long from web_get_meeting_attendees_recipient("+zillaid+", "+upazilaid+
                ", "+unionid+", "+meetingYear+", "+meetingMonth+", "+meetingNo+") where is_attendees = 1;";
//                "select nmd.designation_bn_long from notice_designation_checked ndc\n"
//                + "                join public.notice_master_designation nmd\n"
//                + "                on ndc.designation_code = nmd.designation_code\n"
//                + "                where \n"
//                + "                ndc.zillaid = " + zillaid + " and ndc.upazilaid = " + upazilaid + " and ndc.unionid = " + unionid + " \n"
//                + "                and ndc.meeting_month = " + meetingMonth
//                + " and ndc.meeting_year = " + meetingYear + " and ndc.meeting_no = " + meetingNo
//                +" and \n"
//                + "                ndc.is_attendees = 1 order by nmd.item_weight desc;";
        ResultSet rs2 = db.select(meeting_participants_sql);
        ArrayList<String> participantList = new ArrayList<>();
        while(rs2.next()){
            participantList.add(rs2.getString("designation_bn_long"));
        }
        mi.setMeeting_participants(participantList);
        
        String meeting_recipients_sql = "select Concat(name, ' (', designation_en_long, '), ', attendees_area) as designation_bn_long from web_get_meeting_attendees_recipient("+zillaid+", "+upazilaid+
                ", "+unionid+", "+meetingYear+", "+meetingMonth+", "+meetingNo+") where is_recipient = 1;";
//                "select nmd.designation_bn_long from notice_designation_checked ndc\n"
//                + "                join public.notice_master_designation nmd\n"
//                + "                on ndc.designation_code = nmd.designation_code\n"
//                + "                where \n"
//                + "                ndc.zillaid = " + zillaid + " and ndc.upazilaid = " + upazilaid + " and ndc.unionid = " + unionid + " \n"
//                + "                and ndc.meeting_month = " + meetingMonth
//                + " and ndc.meeting_year = " + meetingYear + " and ndc.meeting_no = " + meetingNo
//                +" and \n"
//                + "                ndc.is_recipient = 1 order by nmd.item_weight desc;";
        ResultSet rs3 = db.select(meeting_recipients_sql);
        ArrayList<String> recipientList = new ArrayList<>();
        while(rs3.next()){
            recipientList.add(rs3.getString("designation_bn_long"));
        }
        mi.setMeeting_recipients(recipientList);
        
        db.commit();
        return mi;
    }
}
