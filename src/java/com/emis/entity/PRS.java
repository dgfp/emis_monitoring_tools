package com.emis.entity;

/**
 *
 * @author Helal
 */
public class PRS {

    private int divid;
    private int zillaid;
    private int upazilaid;
    private String unionid;
    private String startDate;
    private String endDate;
    
    public PRS(){}

    public PRS(int divid, int zillaid, int upazilaid, String unionid, String startDate, String endDate) {
        this.divid = divid;
        this.zillaid = zillaid;
        this.upazilaid = upazilaid;
        this.unionid = unionid;
        this.startDate = startDate;
        this.endDate = endDate;
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

    public String getUnionid() {
        return unionid;
    }

    public void setUnionid(String unionid) {
        this.unionid = unionid;
    }

    public String getStartDate() {
        return startDate;
    }

    public void setStartDate(String startDate) {
        this.startDate = startDate;
    }

    public String getEndDate() {
        return endDate;
    }

    public void setEndDate(String endDate) {
        this.endDate = endDate;
    }

    @Override
    public String toString() {
        return "PRS{" + "divid=" + divid + ", zillaid=" + zillaid + ", upazilaid=" + upazilaid + ", unionid=" + unionid + ", startDate=" + startDate + ", endDate=" + endDate + '}';
    }
}
