package com.emis.entity;

/**
 *
 * @author Helal
 */
public class AssetReport {

    private int divid=0;
    private int zillaid=0;
    private int upazilaid=0;

    public AssetReport(int divid, int zillaid, int upazilaid) {
        this.divid = divid;
        this.zillaid = zillaid;
        this.upazilaid = upazilaid;
    }

    public AssetReport() {
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

    @Override
    public String toString() {
        return "AssetDashboard{" + "divid=" + divid + ", zillaid=" + zillaid + ", upazilaid=" + upazilaid + '}';
    }
}
