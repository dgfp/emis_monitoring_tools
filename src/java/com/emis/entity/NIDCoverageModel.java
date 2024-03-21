package com.emis.entity;

/**
 *
 * @author Helal
 */
public class NIDCoverageModel {

    private int divid;
    private int zillaid;
    private int upazilaid;
    private int unionid;
    private int unitid;
    private String level;
    private String startDate;
    private String endDate;
    private String startMonthYear;
    private String endMonthYear;

    public NIDCoverageModel() {
    }

    public NIDCoverageModel(int divid, int zillaid, int upazilaid, int unionid, int unitid, String level, String startDate, String endDate, String startMonthYear, String endMonthYear) {
        this.divid = divid;
        this.zillaid = zillaid;
        this.upazilaid = upazilaid;
        this.unionid = unionid;
        this.unitid = unitid;
        this.level = level;
        this.startDate = startDate;
        this.endDate = endDate;
        this.startMonthYear = startMonthYear;
        this.endMonthYear = endMonthYear;
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

    public String getStartMonthYear() {
        return startMonthYear;
    }

    public void setStartMonthYear(String startMonthYear) {
        this.startMonthYear = startMonthYear;
    }

    public String getEndMonthYear() {
        return endMonthYear;
    }

    public void setEndMonthYear(String endMonthYear) {
        this.endMonthYear = endMonthYear;
    }

    @Override
    public String toString() {
        return "NIDCoverage{" + "divid=" + divid + ", zillaid=" + zillaid + ", upazilaid=" + upazilaid + ", unionid=" + unionid + ", unitid=" + unitid + ", level=" + level + ", startDate=" + startDate + ", endDate=" + endDate + ", startMonthYear=" + startMonthYear + ", endMonthYear=" + endMonthYear + '}';
    }
}