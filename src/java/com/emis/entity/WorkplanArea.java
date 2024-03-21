package com.emis.entity;

/**
 *
 * @author Helal
 */
public class WorkplanArea {
    
    private int divid;
    private int zillaid;
    private int upazilaid;
    private int unionid;
    private int provtype;
    private int providerid;
    private int month;
    private int year;

    public WorkplanArea() {
    }
    
    public WorkplanArea(int divid, int zillaid, int upazilaid, int unionid, int provtype, int providerid, int month, int year) {
        this.divid = divid;
        this.zillaid = zillaid;
        this.upazilaid = upazilaid;
        this.unionid = unionid;
        this.provtype = provtype;
        this.providerid = providerid;
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

    public int getProvtype() {
        return provtype;
    }

    public void setProvtype(int provtype) {
        this.provtype = provtype;
    }

    public int getProviderid() {
        return providerid;
    }

    public void setProviderid(int providerid) {
        this.providerid = providerid;
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
        return "WorkplanArea{" + "divid=" + divid + ", zillaid=" + zillaid + ", upazilaid=" + upazilaid + ", unionid=" + unionid + ", provtype=" + provtype + ", providerid=" + providerid + ", month=" + month + ", year=" + year + '}';
    }
}
