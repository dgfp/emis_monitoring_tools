package com.emis.entity;

/**
 *
 * @author Helal
 */
public class HouseholdAndVillageWisePopulation {

    private int zillaid;
    private int upazilaid;
    private int reporting_unionid;
    private int unit;
    private String viewType;
    private String startDate;
    private String endDate;
    private String startYear;
    private String endYear;

    public HouseholdAndVillageWisePopulation() {
    }

    public HouseholdAndVillageWisePopulation(int zillaid, int upazilaid, int reporting_unionid, int unit, String viewType, String startDate, String endDate, String startYear, String endYear) {
        this.zillaid = zillaid;
        this.upazilaid = upazilaid;
        this.reporting_unionid = reporting_unionid;
        this.unit = unit;
        this.viewType = viewType;
        this.startDate = startDate;
        this.endDate = endDate;
        this.startYear = startYear;
        this.endYear = endYear;
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

    public int getUnit() {
        return unit;
    }

    public void setUnit(int unit) {
        this.unit = unit;
    }

    public String getViewType() {
        return viewType;
    }

    public void setViewType(String viewType) {
        this.viewType = viewType;
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

    public String getStartYear() {
        return startYear;
    }

    public void setStartYear(String startYear) {
        this.startYear = startYear;
    }

    public String getEndYear() {
        return endYear;
    }

    public void setEndYear(String endYear) {
        this.endYear = endYear;
    }

    @Override
    public String toString() {
        return "HouseholdAndVillageWisePopulation{" + "zillaid=" + zillaid + ", upazilaid=" + upazilaid + ", reporting_unionid=" + reporting_unionid + ", unit=" + unit + ", viewType=" + viewType + ", startDate=" + startDate + ", endDate=" + endDate + ", startYear=" + startYear + ", endYear=" + endYear + '}';
    }
}