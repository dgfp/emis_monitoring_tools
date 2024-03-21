package com.emis.entity;

/**
 *
 * @author Helal
 */
public class Catchment {
    
    private int zillaid;
    private String zillaname;
    private String zillanameeng;
    private int upazilaid;
    private String upazilanameeng;
    private String upazilaname;
    private int unionid;
    private String unionnameeng;
    private String unionname;

    public Catchment() {
    }

    public Catchment(int zillaid, String zillaname, String zillanameeng, int upazilaid, String upazilanameeng, String upazilaname, int unionid, String unionnameeng, String unionname) {
        this.zillaid = zillaid;
        this.zillaname = zillaname;
        this.zillanameeng = zillanameeng;
        this.upazilaid = upazilaid;
        this.upazilanameeng = upazilanameeng;
        this.upazilaname = upazilaname;
        this.unionid = unionid;
        this.unionnameeng = unionnameeng;
        this.unionname = unionname;
    }

    public int getZillaid() {
        return zillaid;
    }

    public void setZillaid(int zillaid) {
        this.zillaid = zillaid;
    }

    public String getZillanameeng() {
        return zillanameeng;
    }

    public void setZillanameeng(String zillanameeng) {
        this.zillanameeng = zillanameeng;
    }

    public int getUpazilaid() {
        return upazilaid;
    }

    public void setUpazilaid(int upazilaid) {
        this.upazilaid = upazilaid;
    }

    public String getUpazilanameeng() {
        return upazilanameeng;
    }

    public void setUpazilanameeng(String upazilanameeng) {
        this.upazilanameeng = upazilanameeng;
    }

    public int getUnionid() {
        return unionid;
    }

    public void setUnionid(int unionid) {
        this.unionid = unionid;
    }

    public String getUnionnameeng() {
        return unionnameeng;
    }

    public void setUnionnameeng(String unionnameeng) {
        this.unionnameeng = unionnameeng;
    }

    public String getZillaname() {
        return zillaname;
    }

    public void setZillaname(String zillaname) {
        this.zillaname = zillaname;
    }

    public String getUpazilaname() {
        return upazilaname;
    }

    public void setUpazilaname(String upazilaname) {
        this.upazilaname = upazilaname;
    }

    public String getUnionname() {
        return unionname;
    }

    public void setUnionname(String unionname) {
        this.unionname = unionname;
    }

    @Override
    public String toString() {
        return "Catchment{" + "zillaid=" + zillaid + ", zillaname=" + zillaname + ", zillanameeng=" + zillanameeng + ", upazilaid=" + upazilaid + ", upazilanameeng=" + upazilanameeng + ", upazilaname=" + upazilaname + ", unionid=" + unionid + ", unionnameeng=" + unionnameeng + ", unionname=" + unionname + '}';
    }
}