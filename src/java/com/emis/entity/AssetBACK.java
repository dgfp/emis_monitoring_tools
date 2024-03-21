package com.emis.entity;

/**
 *
 * @author Helal
 */
public class AssetBACK {

    private int divid;
    private int zillaid;
    private int upazilaid;
    private int unionid;
    private int provtype;
    private int status_id;
    
    public AssetBACK(){}

    public AssetBACK(int divid, int zillaid, int upazilaid, int unionid, int provtype, int status_id) {
        this.divid = divid;
        this.zillaid = zillaid;
        this.upazilaid = upazilaid;
        this.unionid = unionid;
        this.provtype = provtype;
        this.status_id = status_id;
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

    public int getProvtype() {
        return provtype;
    }

    public void setProvtype(int provtype) {
        this.provtype = provtype;
    }

    public int getStatus_id() {
        return status_id;
    }

    public void setStatus_id(int status_id) {
        this.status_id = status_id;
    }
}
