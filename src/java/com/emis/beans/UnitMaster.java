/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.emis.beans;

/**
 *
 * @author nar_r
 */
public class UnitMaster {
    public int zillaid;
    public int upazilaid;
    public int reporting_unionid;
    public String unionids;
    public int unitid_dgfp;
    public int unitid;
    public int unit;

    public UnitMaster() {
    }

    public UnitMaster(int zillaid, int upazilaid, int reporting_unionid, String unionids, int unitid_dgfp, int unitid, int unit) {
        this.zillaid = zillaid;
        this.upazilaid = upazilaid;
        this.reporting_unionid = reporting_unionid;
        this.unionids = unionids;
        this.unitid_dgfp = unitid_dgfp;
        this.unitid = unitid;
        this.unit = unit;
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

    public String getUnionids() {
        return unionids;
    }

    public void setUnionids(String unionids) {
        this.unionids = unionids;
    }

    public int getUnitid_dgfp() {
        return unitid_dgfp;
    }

    public void setUnitid_dgfp(int unitid_dgfp) {
        this.unitid_dgfp = unitid_dgfp;
    }

    public int getUnitid() {
        return unitid;
    }

    public void setUnitid(int unitid) {
        this.unitid = unitid;
    }

    public int getUnit() {
        return unit;
    }

    public void setUnit(int unit) {
        this.unit = unit;
    }

    @Override
    public String toString() {
        return "UnitMaster{" + "zillaid=" + zillaid + ", upazilaid=" + upazilaid + ", reporting_unionid=" + reporting_unionid + ", unionids=" + unionids + ", unitid_dgfp=" + unitid_dgfp + ", unitid=" + unitid + ", unit=" + unit + '}';
    }
    
}
