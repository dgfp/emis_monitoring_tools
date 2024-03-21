package com.emis.entity;

/**
 *
 * @author Helal
 */
public class ProviderAreaUnit {
    
    private int zillaid;
    private int upazilaid;
    private int reporting_unionid;
    private int unitid;
    private int unit;
    private int providerid;
    private int assign_type;

    public ProviderAreaUnit(int zillaid, int upazilaid, int reporting_unionid, int unitid, int unit, int providerid, int assign_type) {
        this.zillaid = zillaid;
        this.upazilaid = upazilaid;
        this.reporting_unionid = reporting_unionid;
        this.unitid = unitid;
        this.unit = unit;
        this.providerid = providerid;
        this.assign_type = assign_type;
    }

    public ProviderAreaUnit() {
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

    public int getUnitid() {
        return unitid;
    }

    public void setUnitid(int unitid) {
        this.unitid = unitid;
    }

    public int getUnit() {
        return unit;
    }

    public void setUnit(int unit) {
        this.unit = unit;
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
        return "ProviderAreaUnit{" + "zillaid=" + zillaid + ", upazilaid=" + upazilaid + ", reporting_unionid=" + reporting_unionid + ", unitid=" + unitid + ", unit=" + unit + ", providerid=" + providerid + ", assign_type=" + assign_type + '}';
    }
}