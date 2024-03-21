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
public class ReportingUnit {

    private int division;
    private int zillaid;
    private int upazilaid;
    private int unionid;
    private int unitid;
    private int reporting_unionid;
    private int providerid;
    private String[] villages;
    private int assign_type;
    private String unionnameeng;
    private int unit;
    private String zillanameeng;
    private String upazilanameeng;
    private String villageid;
    private String villagename;
    private String mouzaid;
    private String fwaunitlabel;
    private int dboperationstatus; // 0 - INSERT, 1 - UPDATE
    private int wardnumber;
    

    public ReportingUnit() {
    }

    public ReportingUnit(int division, int zillaid, int upazilaid, int unionid, int unitid, int unit, int reporting_unionid, int providerid, String[] villages, int assign_type, int dboperationstatus, String fwaunitlabel) {
        this.division = division;
        this.zillaid = zillaid;
        this.upazilaid = upazilaid;
        this.unionid = unionid;
        this.unitid = unitid;
        this.unit = unit;
        this.reporting_unionid = reporting_unionid;
        this.providerid = providerid;
        this.villages = villages;
        this.assign_type = assign_type;
        this.dboperationstatus = dboperationstatus;
        this.fwaunitlabel = fwaunitlabel;
        this.wardnumber = wardnumber;
    }

    public int getWardnumber() {
        return wardnumber;
    }

    public void setWardnumber(int wardnumber) {
        this.wardnumber = wardnumber;
    }

    public int getUnitid() {
        return unitid;
    }

    public void setUnitid(int unitid) {
        this.unitid = unitid;
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

    public int getDboperationstatus() {
        return dboperationstatus;
    }

    public void setDboperationstatus(int dboperationstatus) {
        this.dboperationstatus = dboperationstatus;
    }

    public String getFwaUnitLabel() {
        return fwaunitlabel;
    }

    public void setFwaunitlabel(String fwaunitlabel) {
        this.fwaunitlabel = fwaunitlabel;
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

    public int getReporting_unionid() {
        return reporting_unionid;
    }

    public void setReporting_unionid(int reporting_unionid) {
        this.reporting_unionid = reporting_unionid;
    }

    public int getProviderid() {
        return providerid;
    }

    public String getUnionnameeng() {
        return unionnameeng;
    }

    public int getUnit() {
        return unit;
    }

    public void setUnit(int unit) {
        this.unit = unit;
    }

    public String getZillanameeng() {
        return zillanameeng;
    }

    public String getUpazilanameeng() {
        return upazilanameeng;
    }

    public String getVillageid() {
        return villageid;
    }

    public String getVillagename() {
        return villagename;
    }

    public String getMouzaid() {
        return mouzaid;
    }

    public void setProviderid(int providerid) {
        this.providerid = providerid;
    }

    public String[] getVillages() {
        return villages;
    }

    public void setVillages(String[] villages) {
        this.villages = villages;
    }

    public int getAssign_type() {
        return assign_type;
    }

    public void setAssign_type(int assign_type) {
        this.assign_type = assign_type;
    }

    @Override
    public String toString() {
        return "ReportingUnit{" + "division=" + division + ", zillaid=" + zillaid + ", upazilaid=" + upazilaid + ", unionid=" + unionid + ", unitid=" + unitid + ", reporting_unionid=" + reporting_unionid + ", providerid=" + providerid + ", villages=" + villages + ", assign_type=" + assign_type + '}';
    }

}
