package com.emis.entity;

/**
 *
 * @author Helal
 */
public class ReportingUpazilaUFPO {

    private int zillaid;
    private int upazilaid;
    private int reporting_upazilaid;
    private int providerid;
    private int assign_type;

    public ReportingUpazilaUFPO() {
    }

    public ReportingUpazilaUFPO(int zillaid, int upazilaid, int reporting_upazilaid, int providerid, int assign_type) {
        this.zillaid = zillaid;
        this.upazilaid = upazilaid;
        this.reporting_upazilaid = reporting_upazilaid;
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

    public int getReporting_upazilaid() {
        return reporting_upazilaid;
    }

    public void setReporting_upazilaid(int reporting_upazilaid) {
        this.reporting_upazilaid = reporting_upazilaid;
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
        return "ReportingUpazilaUFPO{" + "zillaid=" + zillaid + ", upazilaid=" + upazilaid + ", reporting_upazilaid=" + reporting_upazilaid + ", providerid=" + providerid + ", assign_type=" + assign_type + '}';
    }
}