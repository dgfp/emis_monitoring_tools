package com.emis.service;

import com.emis.beans.UnitMaster;
import com.emis.utility.Convertor;
import com.rhis.db.DBManagerDistrict;
import com.rhis.db.DBManagerMonitoring;
import java.sql.ResultSet;
import java.sql.SQLException;
import org.json.JSONArray;

/**
 *
 * @author Helal | m.helal.k@gmail.com
 */
public class ReportSubmissionService {

    private DBManagerDistrict db = null;

    public ReportSubmissionService() {
    }

    public ReportSubmissionService(int district) {
        db = new DBManagerDistrict(district);
        db.start();
    }

    public JSONArray getReviewDataByReport(int providerid, int month, int year, int reportId) {
        try {
            String sql = "select * from web_report_submission_dgfp rs\n"
                    + "right join web_report_review_dgfp rr\n"
                    + "using (submission_id)	\n"
                    + "where rs.submission_from=" + providerid + " and month=" + month + " and year=" + year + " and modrep=" + reportId + "\n"
                    + "order by rr.systementrydate";
            ResultSet result = db.select(sql);
            return Convertor.toJSON(result);
        } catch (Exception e) {
            return null;
        }
    }

    public JSONArray getReviewDataBySubmissionId(long submissionId, int modrep) {
        try {
            String sql1 = "SELECT review_id, submission_id, submission_from, submission_to, status, notes, rr.systementrydate, html, provname\n"
                    + "FROM public.web_report_review rr join providerdb p on rr.submission_from = p.providerid where submission_id=" + submissionId + " and modrep= " + modrep + " order by systementrydate ";

            String sql = "SELECT review_id, rr.submission_id, rr.submission_from, rr.submission_to, status, notes, rr.systementrydate, rr.html, provname\n"
                    + "FROM public.web_report_review_dgfp rr \n"
                    + "\n"
                    + "join web_report_submission_dgfp rs on \n"
                    + "rs.submission_id = rr.submission_id\n"
                    + "\n"
                    + "join providerdb p on \n"
                    + "rr.submission_from = p.providerid  \n"
                    + "\n"
                    + "where rr.submission_id=" + submissionId + " and rs.modrep=" + modrep + " order by systementrydate";

            ResultSet result = db.select(sql);
            return Convertor.toJSON(result);
        } catch (Exception e) {
            return null;
        }
    }

    public JSONArray getLMISData(int zillaid, int upazilaid, int unionid, int unit, int year, int month) {
        try {
            //String sql = "select * from public.fn_mis_form1_lmis("+zillaid+", "+upazilaid+", "+unionid+", "+unit+", "+year+", "+month+");";
            UnitMaster um = this.getUnitId(zillaid, upazilaid, unionid, unit);
//            String sql = "select * from public.fn_mis_form1_lmis_distribution("+zillaid+", "+upazilaid+", "+unionid+", "+unit+", "+year+", "+month+");";
            String sql = "select * from public.fn_mis_form1_lmis_distribution(" + um.zillaid + ", " + um.upazilaid + ", '" + um.unionids + "', " + um.reporting_unionid + "," + um.unitid + "," + um.unit + ", " + year + ", " + month + ");";
            //select * from public.fn_mis_form1_lmis_distribution(93, 25, 5, 2, 2017, 07); 
            //DBManagerLMIS db=new DBManagerLMIS();

            ResultSet result = db.select(sql);
            return Convertor.toJSON(result);
        } catch (Exception e) {
            System.out.println(e.getMessage());
            return null;
        }
    }
    
        public JSONArray getCurrentMonthLMISData(int zillaid, int upazilaid, int unionid, int unit, int year, int month) {
        try {
            //String sql = "select * from public.fn_mis_form1_lmis("+zillaid+", "+upazilaid+", "+unionid+", "+unit+", "+year+", "+month+");";
            UnitMaster um = this.getUnitId(zillaid, upazilaid, unionid, unit);
//            String sql = "select * from public.fn_mis_form1_lmis_distribution("+zillaid+", "+upazilaid+", "+unionid+", "+unit+", "+year+", "+month+");";
            String sql = "select * from public.fn_rpt_mis_form1_lims_9v_prev_month_closing_curr_month_received(" + um.zillaid + ", " + um.upazilaid + ", " + um.reporting_unionid + "," + um.unitid + "," + um.unit + ", " + year + ", " + month + ");";
            //select * from public.fn_mis_form1_lmis_distribution(93, 25, 5, 2, 2017, 07); 
            //DBManagerLMIS db=new DBManagerLMIS();

            ResultSet result = db.select(sql);
            return Convertor.toJSON(result);
        } catch (Exception e) {
            System.out.println(e.getMessage());
            return null;
        }
    }

    public UnitMaster getUnitId(int zillaId, int upazilaId, int reporting_union_id, int unit) throws Exception {
        String sql = "select * from unit_master where zillaid=" + zillaId + " and upazilaid = " + upazilaId
                + " and reporting_unionid= " + reporting_union_id + " and unit=" + unit;
        ResultSet result = db.select(sql);
        UnitMaster um = new UnitMaster();
        int count = 0;
        while (result.next()) {
            ++count;
            um.zillaid = result.getInt("zillaid");
            um.upazilaid = result.getInt("upazilaid");
            um.reporting_unionid = result.getInt("reporting_unionid");
            um.unionids = result.getString("unionids");
            um.unit = result.getInt("unit");
            um.unitid = result.getInt("unitid");
            um.unitid_dgfp = result.getInt("unitid_dgfp");
        }
        if (count > 1) {
            um = null;
        }
        return um;
    }
    
    public long getMis1SubmissionId(int zillaid, int upazilaid, 
            int reporting_unionid, int unitid, int year, int month) 
            throws Exception {
        long submissionId = 0;
        String sql = "select submission_id from web_report_submission_dgfp where zillaid="+zillaid
                +" and upazilaid="+ upazilaid + " and reporting_unionid="+reporting_unionid + " and unitid="+unitid
                + " and year="+ year + " and month="+ month;
        ResultSet result = db.select(sql);
        while(result.next()){
            submissionId = result.getLong("submission_id");
        }
        return submissionId;
    }

    public JSONArray getReviewDataBySupervisor(long submissionId) {
        return null;
    }

}
