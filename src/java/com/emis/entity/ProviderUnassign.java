package com.emis.entity;

import java.util.ArrayList;

/**
 *
 * @author Nibras
 */
public class ProviderUnassign {

    private int zillaid;
    private int upazilaid;
    private int providerid;
    private int provtype;
//    private int unit;
//    private int unidid;
    private String unassign_date;
    private String unassign_leave_end_date;
    private int unassign_provider_emp_id;
    private int district_all;
    private int transfer_upazila;
    private int transfer_union;
    private int unassign_reason_type;
    private int leave_type;
    private int unassign_provider_hris_id;
    private ArrayList<ReportingInfo> reportinginfo;

    public ProviderUnassign() {
    }

    public ProviderUnassign(int zillaid, int upazilaid, int providerid, int provtype, String unassign_date, String unassign_leave_end_date
            , int unassign_provider_emp_id, int district_all, int transfer_upazila, int transfer_union
            , int unassign_provider_hris_id
            , int unassign_reason_type, int leave_type, ArrayList<ReportingInfo> reportinginfo) {
        this.zillaid = zillaid;
        this.upazilaid = upazilaid;
        this.providerid = providerid;
        this.provtype = provtype;
        this.unassign_date = unassign_date;
        this.unassign_leave_end_date =unassign_leave_end_date;
        this.unassign_provider_emp_id = unassign_provider_emp_id;
        this.unassign_provider_hris_id = unassign_provider_hris_id;
        this.district_all = district_all;
        this.transfer_upazila = transfer_upazila;
        this.transfer_union = transfer_union;
        this.unassign_reason_type = unassign_reason_type;
        this.leave_type = leave_type;
        this.reportinginfo = reportinginfo;
    }

    public int getZillaid() {
        return zillaid;
    }

    public void setZillaid(int zillaid) {
        this.zillaid = zillaid;
    }

    public int getUpazilaid() {
        return upazilaid;
    }

    public void setUpazilaid(int upazilaid) {
        this.upazilaid = upazilaid;
    }

    public int getProviderid() {
        return providerid;
    }

    public void setProviderid(int providerid) {
        this.providerid = providerid;
    }

    public int getProvtype() {
        return provtype;
    }

    public void setProvtype(int provtype) {
        this.provtype = provtype;
    }

    public String getUnassign_date() {
        return unassign_date;
    }

    public void setUnassign_date(String unassign_date) {
        this.unassign_date = unassign_date;
    }

    public int getUnassign_provider_emp_id() {
        return unassign_provider_emp_id;
    }

    public void setUnassign_provider_emp_id(int unassign_provider_emp_id) {
        this.unassign_provider_emp_id = unassign_provider_emp_id;
    }

    public int getDistrict_all() {
        return district_all;
    }

    public void setDistrict_all(int district_all) {
        this.district_all = district_all;
    }

    public int getUnassign_reason_type() {
        return unassign_reason_type;
    }

    public void setUnassign_reason_type(int unassign_reason_type) {
        this.unassign_reason_type = unassign_reason_type;
    }

    public ArrayList<ReportingInfo> getReportinginfo() {
        return reportinginfo;
    }

    public void setReportinginfo(ArrayList<ReportingInfo> reportinginfo) {
        this.reportinginfo = reportinginfo;
    }

    public int getLeave_type() {
        return leave_type;
    }

    public void setLeave_type(int leave_type) {
        this.leave_type = leave_type;
    }

    public String getUnassign_leave_end_date() {
        return unassign_leave_end_date;
    }

    public void setUnassign_leave_end_date(String unassign_leave_end_date) {
        this.unassign_leave_end_date = unassign_leave_end_date;
    }

    public int getTransfer_upazila() {
        return transfer_upazila;
    }

    public void setTransfer_upazila(int transfer_upazila) {
        this.transfer_upazila = transfer_upazila;
    }

    public int getTransfer_union() {
        return transfer_union;
    }

    public void setTransfer_union(int transfer_union) {
        this.transfer_union = transfer_union;
    }

    public int getUnassign_provider_hris_id() {
        return unassign_provider_hris_id;
    }

    public void setUnassign_provider_hris_id(int unassign_provider_hris_id) {
        this.unassign_provider_hris_id = unassign_provider_hris_id;
    }

    @Override
    public String toString() {
        return "ProviderUnassign{" + "zillaid=" + zillaid + ", upazilaid=" + upazilaid + ", providerid=" + providerid + ", provtype=" + provtype + ", unassign_date=" + unassign_date + ", unassign_provider_emp_id=" + unassign_provider_emp_id + ", district_all=" + district_all + ", unassign_reason_type=" + unassign_reason_type + ", leave_type=" + leave_type + ", reportinginfo=" + reportinginfo + '}';
    }
}
