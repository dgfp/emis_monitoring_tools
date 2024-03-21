/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package bd.govt.dgfp.meetingManagement;

import com.emis.entity.MeetingInformation;
import com.rhis.db.DBManagerDistrict;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

/**
 *
 * @author MCHD23
 */
public class MeetingInformationService {

    public MeetingInformationService() {
    }

    public MeetingInformation getMeetingInformation(String zillaid, String upazilaid, String unionid, String meetingMonth,
            String meetingYear, String meetingNo, String providerCode) throws SQLException {

        String meeting_info_sql = "select z.zillaname, rupz.reporting_upazilaname, ru.unionname, concat(z.zillaid,'-',rupz.reporting_upazilaid, \n"
                + "            '-', ru.reporting_unionid, '-', nmn.meeting_month, '-', nmn.meeting_year, '-', nmn.meeting_no, '-', nmn.meeting_type) as file_name,\n"
                + "nmn.meeting_year,\n"
                + "       nmn.meeting_month,\n"
                + "       nmt.itemdes as meeting_type,\n"
                + "       nmp.itemdes place, -- nmn.meeting_type,\n"
                + "        -- nmn.meeting_time,\n"
                + "        to_char( to_timestamp ( nmn.meeting_time , 'HH12:MI' ) , 'HH24:MI ' ) meeting_time,\n"
                + "        nmn.meeting_date\n"
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
            System.out.println(rs.getString("meeting_date"));
            mi.setMeeting_date(rs.getString("meeting_date"));
            System.out.println(mi.getMeeting_date());
            mi.setMeeting_time(rs.getString("meeting_time"));
            mi.setMeeting_place(rs.getString("place"));
            mi.setMeeting_type(rs.getString("meeting_type"));
        }

        String meeting_participants_sql = "select nmd.designation_bn_long from notice_designation_checked ndc\n"
                + "                join public.notice_master_designation nmd\n"
                + "                on ndc.designation_code = nmd.designation_code\n"
                + "                where \n"
                + "                ndc.zillaid = " + zillaid + " and ndc.upazilaid = " + upazilaid + " and ndc.unionid = " + unionid + " \n"
                + "                and ndc.meeting_month = " + meetingMonth
                + " and ndc.meeting_year = " + meetingYear + " and ndc.meeting_no = " + meetingNo
                + " and \n"
                + "                ndc.is_attendees = 1 order by nmd.item_weight desc;";
        ResultSet rs2 = db.select(meeting_participants_sql);
        ArrayList<String> participantList = new ArrayList<>();
        while (rs2.next()) {
            participantList.add(rs2.getString("designation_bn_long"));
        }
        mi.setMeeting_participants(participantList);

        String meeting_recipients_sql = "select nmd.designation_bn_long from notice_designation_checked ndc\n"
                + "                join public.notice_master_designation nmd\n"
                + "                on ndc.designation_code = nmd.designation_code\n"
                + "                where \n"
                + "                ndc.zillaid = " + zillaid + " and ndc.upazilaid = " + upazilaid + " and ndc.unionid = " + unionid + " \n"
                + "                and ndc.meeting_month = " + meetingMonth
                + " and ndc.meeting_year = " + meetingYear + " and ndc.meeting_no = " + meetingNo
                + " and \n"
                + "                ndc.is_recipient = 1 order by nmd.item_weight desc;";
        ResultSet rs3 = db.select(meeting_recipients_sql);
        ArrayList<String> recipientList = new ArrayList<>();
        while (rs3.next()) {
            recipientList.add(rs3.getString("designation_bn_long"));
        }
        mi.setMeeting_recipients(recipientList);

        db.commit();
        return mi;
    }
}
