package com.emis.entity;

/**
 *
 * @author Helal
 */
public class ReportingUnion {

    
    private int division;
    private int zillaid;
    private int upazilaid;
    private int unionid;
    private String unionname;
    private String unionnameeng;
    private String unionids;
    private int providerid;
    private int assign_type;
    private String request_from;
    private int is_actual = 1;
    private int reporting_unionid;
    
    public ReportingUnion() {}

    public ReportingUnion(int division, int zillaid, int upazilaid) {
        this.division = division;
        this.zillaid = zillaid;
        this.upazilaid = upazilaid;
    }

    public ReportingUnion(int division, int zillaid, int upazilaid, int unionid, int reporting_unionid, String unionname, String unionnameeng, String unionids, int providerid, int assign_type, int is_actual, String request_from) {
        this.division = division;
        this.zillaid = zillaid;
        this.upazilaid = upazilaid;
        this.unionid = unionid;
        this.reporting_unionid = reporting_unionid;
        this.unionname = unionname;
        this.unionnameeng = unionnameeng;
        this.unionids = unionids;
        this.providerid = providerid;
        this.assign_type = assign_type;
        this.is_actual = is_actual;
        this.request_from = request_from;
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

    public String getUnionname() {
        return unionname;
    }

    public void setUnionname(String unionname) {
        this.unionname = unionname;
    }

    public String getUnionnameeng() {
        return unionnameeng;
    }

    public void setUnionnameeng(String unionnameeng) {
        this.unionnameeng = unionnameeng;
    }

    public String getUnionids() {
        return unionids;
    }

    public void setUnionids(String unionids) {
        this.unionids = unionids;
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
    
    
    public int getIs_actual() {
        return is_actual;
    }

    public void setIs_actual(int is_actual) {
        this.is_actual = is_actual;
    }

    public String getRequest_from() {
        return request_from;
    }

    public void setRequest_from(String request_from) {
        this.request_from = request_from;
    }

    @Override
    public String toString() {
        return "ReportingUnion{" + "division=" + division + ", zillaid=" + zillaid + ", upazilaid=" + upazilaid + ", unionid=" + unionid + ", unionname=" + unionname + ", unionnameeng=" + unionnameeng + ", unionids=" + unionids + ", providerid=" + providerid + ", assign_type=" + assign_type + ", request_from=" + request_from + ", is_actual=" + is_actual + ", reporting_unionid=" + reporting_unionid + '}';
    }

}