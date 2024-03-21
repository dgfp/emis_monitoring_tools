package com.emis.entity;

/**
 *
 * @author Helal
 */
public class ELCO {
    private int division;
    private int district;
    private int upazila;
    private int union;
    private int unit;
    private String village;
    private String viewType;
    private String reportType;
    private String startDate;
    private String endDate;
    private String periodicalStartDate;
    private String periodicalEndDate;
    private String startMonthYear;
    private String endMonthYear;
    private String startYear;
    private String endYear;

    public ELCO() {
    }

    public ELCO(int division, int district, int upazila, int union, int unit, String village, String viewType, String reportType, String startDate, String endDate, String periodicalStartDate, String periodicalEndDate, String startMonthYear, String endMonthYear, String startYear, String endYear) {
        this.division = division;
        this.district = district;
        this.upazila = upazila;
        this.union = union;
        this.unit = unit;
        this.village = village;
        this.viewType = viewType;
        this.reportType = reportType;
        this.startDate = startDate;
        this.endDate = endDate;
        this.periodicalStartDate = periodicalStartDate;
        this.periodicalEndDate = periodicalEndDate;
        this.startMonthYear = startMonthYear;
        this.endMonthYear = endMonthYear;
        this.startYear = startYear;
        this.endYear = endYear;
    }

    public int getDivision() {
        return division;
    }

    public void setDivision(int division) {
        this.division = division;
    }

    public int getDistrict() {
        return district;
    }

    public void setDistrict(int district) {
        this.district = district;
    }

    public int getUpazila() {
        return upazila;
    }

    public void setUpazila(int upazila) {
        this.upazila = upazila;
    }

    public int getUnion() {
        return union;
    }

    public void setUnion(int union) {
        this.union = union;
    }

    public int getUnit() {
        return unit;
    }

    public void setUnit(int unit) {
        this.unit = unit;
    }

    public String getVillage() {
        return village;
    }

    public void setVillage(String village) {
        this.village = village;
    }

    public String getViewType() {
        return viewType;
    }

    public void setViewType(String viewType) {
        this.viewType = viewType;
    }

    public String getReportType() {
        return reportType;
    }

    public void setReportType(String reportType) {
        this.reportType = reportType;
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

    public String getPeriodicalStartDate() {
        return periodicalStartDate;
    }

    public void setPeriodicalStartDate(String periodicalStartDate) {
        this.periodicalStartDate = periodicalStartDate;
    }

    public String getPeriodicalEndDate() {
        return periodicalEndDate;
    }

    public void setPeriodicalEndDate(String periodicalEndDate) {
        this.periodicalEndDate = periodicalEndDate;
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
        return "EligibleCouple{" + "division=" + division + ", district=" + district + ", upazila=" + upazila + ", union=" + union + ", unit=" + unit + ", village=" + village + ", viewType=" + viewType + ", reportType=" + reportType + ", startDate=" + startDate + ", endDate=" + endDate + ", periodicalStartDate=" + periodicalStartDate + ", periodicalEndDate=" + periodicalEndDate + ", startMonthYear=" + startMonthYear + ", endMonthYear=" + endMonthYear + ", startYear=" + startYear + ", endYear=" + endYear + '}';
    }
}