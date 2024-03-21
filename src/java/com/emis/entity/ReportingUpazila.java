/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.emis.entity;

/**
 *
 * @author Nibras
 */
public class ReportingUpazila {

    private int division;
    private int zillaid;
    private int upazilaid;
    private int providerid;
    private int assign_type;
    private int reporting_upazilaid;
    private String reporting_upazilaname;
    private String reporting_upazilanameeng;

    public ReportingUpazila() {
    }

    public ReportingUpazila(int division, int zillaid, int upazilaid, int providerid, int assign_type, int reporting_upazilaid, String reporting_upazilaname, String reporting_upazilanameeng) {
        this.division = division;
        this.zillaid = zillaid;
        this.upazilaid = upazilaid;
        this.providerid = providerid;
        this.assign_type = assign_type;
        this.reporting_upazilaid = reporting_upazilaid;
        this.reporting_upazilaname = reporting_upazilaname;
        this.reporting_upazilanameeng = reporting_upazilanameeng;
    }

    public int getDivision() {
        return division;
    }

    public void setDivision(int division) {
        this.division = division;
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

    public int getReporting_upazilaid() {
        return reporting_upazilaid;
    }

    public void setReporting_upazilaid(int reporting_upazilaid) {
        this.reporting_upazilaid = reporting_upazilaid;
    }

    public String getReporting_upazilaname() {
        return reporting_upazilaname;
    }

    public void setReporting_upazilaname(String reporting_upazilaname) {
        this.reporting_upazilaname = reporting_upazilaname;
    }

    public String getReporting_upazilanameeng() {
        return reporting_upazilanameeng;
    }

    public void setReporting_upazilanameeng(String reporting_upazilanameeng) {
        this.reporting_upazilanameeng = reporting_upazilanameeng;
    }

    @Override
    public String toString() {
        return "ReportingUpazila{" + "division=" + division + ", zillaid=" + zillaid + ", upazilaid=" + upazilaid + ", providerid=" + providerid + ", assign_type=" + assign_type + ", reporting_upazilaid=" + reporting_upazilaid + ", reporting_upazilaname=" + reporting_upazilaname + ", reporting_upazilanameeng=" + reporting_upazilanameeng + '}';
    }
    
}
