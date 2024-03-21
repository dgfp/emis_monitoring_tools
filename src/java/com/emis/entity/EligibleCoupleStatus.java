package com.emis.entity;

/**
 *
 * @author Helal
 */
public class EligibleCoupleStatus {

    // {"divid":"30","zillaid":"93","upazilaid":"66","unionid":"63","unitid":"0","level":"aggregate","reportType":"byMethodCategory"}
    private int division;
    private int district;
    private int upazila;
    private int union;
    private int unit;
    private String village;
    private String level;
    private String reportType;

    public EligibleCoupleStatus() {
    }

    public EligibleCoupleStatus(int division, int district, int upazila, int union, int unit, String village, String level, String reportType) {
        this.division = division;
        this.district = district;
        this.upazila = upazila;
        this.union = union;
        this.unit = unit;
        this.village = village;
        this.level = level;
        this.reportType = reportType;
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

    public String getLevel() {
        return level;
    }

    public void setLevel(String level) {
        this.level = level;
    }

    public String getReportType() {
        return reportType;
    }

    public void setReportType(String reportType) {
        this.reportType = reportType;
    }

    @Override
    public String toString() {
        return "EligibleCoupleStatus{" + "division=" + division + ", district=" + district + ", upazila=" + upazila + ", union=" + union + ", unit=" + unit + ", village=" + village + ", level=" + level + ", reportType=" + reportType + '}';
    }

}