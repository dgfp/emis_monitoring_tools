package com.emis.entity;
/**
 *
 * @author Helal
 */
public class MISStatus {
    
    private int divid;
    private int zillaid;
    private int upazilaid;
    private int unionid;
    private int unit;
    private int providerid;
    private int provtype;
    private int month;
    private int year;

    public MISStatus() {
    }

    public MISStatus(int divid, int zillaid, int upazilaid, int unionid, int unit, int providerid, int provtype, int month, int year) {
        this.divid = divid;
        this.zillaid = zillaid;
        this.upazilaid = upazilaid;
        this.unionid = unionid;
        this.unit = unit;
        this.providerid = providerid;
        this.provtype = provtype;
        this.month = month;
        this.year = year;
    }
    
    public int getDivid() {
        return divid;
    }

    public void setDivid(int divid) {
        this.divid = divid;
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
    

    public int getUnionid() {
        return unionid;
    }

    public void setUnionid(int unionid) {
        this.unionid = unionid;
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

    public int getProvtype() {
        return provtype;
    }

    public void setProvtype(int provtype) {
        this.provtype = provtype;
    }

    public int getMonth() {
        return month;
    }

    public void setMonth(int month) {
        this.month = month;
    }

    public int getYear() {
        return year;
    }

    public void setYear(int year) {
        this.year = year;
    }

    @Override
    public String toString() {
        return "MISStatus{" + "divid=" + divid + ", zillaid=" + zillaid + ", upazilaid=" + upazilaid + ", unionid=" + unionid + ", unit=" + unit + ", providerid=" + providerid + ", provtype=" + provtype + ", month=" + month + ", year=" + year + '}';
    }
}
