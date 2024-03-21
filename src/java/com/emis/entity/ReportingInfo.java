package com.emis.entity;

/**
 *
 * @author Helal
 */
public class ReportingInfo {

    private int unit;
    private int unitid;
    private int reporting_unionid;
    private int upazilaid;
    private int assign_type;

    public ReportingInfo() {
    }

    public ReportingInfo(int unit, int unitid, int reporting_unionid, int upazilaid, int assign_type) {
        this.unit = unit;
        this.unitid = unitid;
        this.reporting_unionid = reporting_unionid;
        this.upazilaid = upazilaid;
        this.assign_type = assign_type;
    }

    public int getUnit() {
        return unit;
    }

    public void setUnit(int unit) {
        this.unit = unit;
    }

    public int getUnitid() {
        return unitid;
    }

    public void setUnitid(int unitid) {
        this.unitid = unitid;
    }

    public int getReporting_unionid() {
        return reporting_unionid;
    }

    public void setReporting_unionid(int reporting_unionid) {
        this.reporting_unionid = reporting_unionid;
    }

    public int getUpazilaid() {
        return upazilaid;
    }

    public void setUpazilaid(int upazilaid) {
        this.upazilaid = upazilaid;
    }

    public int getAssign_type() {
        return assign_type;
    }

    public void setAssign_type(int assign_type) {
        this.assign_type = assign_type;
    }

    @Override
    public String toString() {
        return "ReportingInfo{" + "unit=" + unit + ", unitid=" + unitid + ", reporting_unionid=" + reporting_unionid + ", upazilaid=" + upazilaid + ", assign_type:" + assign_type + '}';
    }
}
