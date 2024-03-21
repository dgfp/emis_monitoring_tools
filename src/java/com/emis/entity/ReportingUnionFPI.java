package com.emis.entity;

/**
 *
 * @author Helal
 */
public class ReportingUnionFPI {

    private int zillaid;
    private int upazilaid;
    private int reporting_unionid;
    private int providerid;
    private int assign_type;

    public ReportingUnionFPI() {
    }

    public ReportingUnionFPI(int zillaid, int upazilaid, int reporting_unionid, int providerid, int assign_type) {
        this.zillaid = zillaid;
        this.upazilaid = upazilaid;
        this.reporting_unionid = reporting_unionid;
        this.providerid = providerid;
        this.assign_type = assign_type;
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

    public int getReporting_unionid() {
        return reporting_unionid;
    }

    public void setReporting_unionid(int reporting_unionid) {
        this.reporting_unionid = reporting_unionid;
    }

    public int getProviderid() {
        return providerid;
    }

    public void setProviderid(int providerid) {
        this.providerid = providerid;
    }

    public int getAssign_type() {
        return assign_type;
    }

    public void setAssign_type(int assign_type) {
        this.assign_type = assign_type;
    }

    @Override
    public String toString() {
        return "ReportingUnionFPI{" + "zillaid=" + zillaid + ", upazilaid=" + upazilaid + ", reporting_unionid=" + reporting_unionid + ", providerid=" + providerid + ", assign_type=" + assign_type + '}';
    }
}