package com.emis.entity;

/**
 *
 * @author Helal
 */
public class PRSStatistics {

    private int divid;
    private int zillaid;
    private int upazilaid;
    private int unionid;
    private int unitid;
    private String level;
    private String startDate;
    private String endDate;

    public PRSStatistics() {
    }

    public PRSStatistics(int divid, int zillaid, int upazilaid, int unionid, int unitid, String level, String startDate, String endDate) {
        this.divid = divid;
        this.zillaid = zillaid;
        this.upazilaid = upazilaid;
        this.unionid = unionid;
        this.unitid = unitid;
        this.level = level;
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

    public int getUnionid() {
        return unionid;
    }

    public void setUnionid(int unionid) {
        this.unionid = unionid;
    }

    public int getUnitid() {
        return unitid;
    }

    public void setUnitid(int unitid) {
        this.unitid = unitid;
    }

    public String getLevel() {
        return level;
    }

    public void setLevel(String level) {
        this.level = level;
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
        return "PopulationStatistics{" + "divid=" + divid + ", zillaid=" + zillaid + ", upazilaid=" + upazilaid + ", unionid=" + unionid + ", unitid=" + unitid + ", level=" + level + ", startDate=" + startDate + ", endDate=" + endDate + '}';
    }
    
}
