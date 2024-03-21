/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.emis.entity;

/**
 *
 * @author Helal
 */
public class Asset {

    private int model;
    private int n_divid;
    private int n_imei1;
    private int n_imei2;
    private int n_locationid;
    private int n_statusid;

    private int lost_gd = 0;
    private int lost_varified = 0;

    private int n_unionid;
    private int n_upazilaid;
    private int n_zillaid;
    private int providerType;
    private int providerid;
    private int purchasedby;
    private String purchaseddate;
    private String receiveddate;
    private int purchaseorderno;
    private int simnumber;
    private int telcoid;
    private int userType;
    private int warrentyperiod;

    private String charger = "";
    private String cover = "";
    private String screenprotector = "";
    private String waterproofbag = "";
    private String distributeDevice = "";

    private String Provname = "";
    private String designation = "";
    private String mobileno = "";

    public Asset() {
    }

    public Asset(int model, int n_divid, int n_imei1, int n_imei2, int n_locationid, int n_statusid, int n_unionid, int n_upazilaid, int n_zillaid, int providerType, int providerid, int purchasedby, String purchaseddate, String receiveddate, int purchaseorderno, int simnumber, int telcoid, int userType, int warrentyperiod) {
        this.model = model;
        this.n_divid = n_divid;
        this.n_imei1 = n_imei1;
        this.n_imei2 = n_imei2;
        this.n_locationid = n_locationid;
        this.n_statusid = n_statusid;
        this.n_unionid = n_unionid;
        this.n_upazilaid = n_upazilaid;
        this.n_zillaid = n_zillaid;
        this.providerType = providerType;
        this.providerid = providerid;
        this.purchasedby = purchasedby;
        this.purchaseddate = purchaseddate;
        this.receiveddate = receiveddate;
        this.purchaseorderno = purchaseorderno;
        this.simnumber = simnumber;
        this.telcoid = telcoid;
        this.userType = userType;
        this.warrentyperiod = warrentyperiod;
    }

    public int getModel() {
        return model;
    }

    public void setModel(int model) {
        this.model = model;
    }

    public int getN_divid() {
        return n_divid;
    }

    public void setN_divid(int n_divid) {
        this.n_divid = n_divid;
    }

    public int getN_imei1() {
        return n_imei1;
    }

    public void setN_imei1(int n_imei1) {
        this.n_imei1 = n_imei1;
    }

    public int getN_imei2() {
        return n_imei2;
    }

    public void setN_imei2(int n_imei2) {
        this.n_imei2 = n_imei2;
    }

    public int getN_locationid() {
        return n_locationid;
    }

    public void setN_locationid(int n_locationid) {
        this.n_locationid = n_locationid;
    }

    public int getN_statusid() {
        return n_statusid;
    }

    public void setN_statusid(int n_statusid) {
        this.n_statusid = n_statusid;
    }

    public int getLost_gd() {
        return lost_gd;
    }

    public void setLost_gd(int lost_gd) {
        this.lost_gd = lost_gd;
    }

    public int getLost_varified() {
        return lost_varified;
    }

    public void setLost_varified(int lost_varified) {
        this.lost_varified = lost_varified;
    }

    public int getN_unionid() {
        return n_unionid;
    }

    public void setN_unionid(int n_unionid) {
        this.n_unionid = n_unionid;
    }

    public int getN_upazilaid() {
        return n_upazilaid;
    }

    public void setN_upazilaid(int n_upazilaid) {
        this.n_upazilaid = n_upazilaid;
    }

    public int getN_zillaid() {
        return n_zillaid;
    }

    public void setN_zillaid(int n_zillaid) {
        this.n_zillaid = n_zillaid;
    }

    public int getProviderType() {
        return providerType;
    }

    public void setProviderType(int providerType) {
        this.providerType = providerType;
    }

    public int getProviderid() {
        return providerid;
    }

    public void setProviderid(int providerid) {
        this.providerid = providerid;
    }

    public int getPurchasedby() {
        return purchasedby;
    }

    public void setPurchasedby(int purchasedby) {
        this.purchasedby = purchasedby;
    }

    public String getPurchaseddate() {
        return purchaseddate;
    }

    public void setPurchaseddate(String purchaseddate) {
        this.purchaseddate = purchaseddate;
    }

    public String getReceiveddate() {
        return receiveddate;
    }

    public void setReceiveddate(String receiveddate) {
        this.receiveddate = receiveddate;
    }

    public int getPurchaseorderno() {
        return purchaseorderno;
    }

    public void setPurchaseorderno(int purchaseorderno) {
        this.purchaseorderno = purchaseorderno;
    }

    public int getSimnumber() {
        return simnumber;
    }

    public void setSimnumber(int simnumber) {
        this.simnumber = simnumber;
    }

    public int getTelcoid() {
        return telcoid;
    }

    public void setTelcoid(int telcoid) {
        this.telcoid = telcoid;
    }

    public int getUserType() {
        return userType;
    }

    public void setUserType(int userType) {
        this.userType = userType;
    }

    public int getWarrentyperiod() {
        return warrentyperiod;
    }

    public void setWarrentyperiod(int warrentyperiod) {
        this.warrentyperiod = warrentyperiod;
    }

    public String getCharger() {
        return charger;
    }

    public void setCharger(String charger) {
        this.charger = charger;
    }

    public String getCover() {
        return cover;
    }

    public void setCover(String cover) {
        this.cover = cover;
    }

    public String getScreenprotector() {
        return screenprotector;
    }

    public void setScreenprotector(String screenprotector) {
        this.screenprotector = screenprotector;
    }

    public String getWaterproofbag() {
        return waterproofbag;
    }

    public void setWaterproofbag(String waterproofbag) {
        this.waterproofbag = waterproofbag;
    }

    public String getDistributeDevice() {
        return distributeDevice;
    }

    public void setDistributeDevice(String distributeDevice) {
        this.distributeDevice = distributeDevice;
    }

    public String getProvname() {
        return Provname;
    }

    public void setProvname(String Provname) {
        this.Provname = Provname;
    }

    public String getDesignation() {
        return designation;
    }

    public void setDesignation(String designation) {
        this.designation = designation;
    }

    public String getMobileno() {
        return mobileno;
    }

    public void setMobileno(String mobileno) {
        this.mobileno = mobileno;
    }

    @Override
    public String toString() {
        return "Asset{" + "model=" + model + ", n_divid=" + n_divid + ", n_imei1=" + n_imei1 + ", n_imei2=" + n_imei2 + ", n_locationid=" + n_locationid + ", n_statusid=" + n_statusid + ", lost_gd=" + lost_gd + ", lost_varified=" + lost_varified + ", n_unionid=" + n_unionid + ", n_upazilaid=" + n_upazilaid + ", n_zillaid=" + n_zillaid + ", providerType=" + providerType + ", providerid=" + providerid + ", purchasedby=" + purchasedby + ", purchaseddate=" + purchaseddate + ", receiveddate=" + receiveddate + ", purchaseorderno=" + purchaseorderno + ", simnumber=" + simnumber + ", telcoid=" + telcoid + ", userType=" + userType + ", warrentyperiod=" + warrentyperiod + ", charger=" + charger + ", cover=" + cover + ", screenprotector=" + screenprotector + ", waterproofbag=" + waterproofbag + ", distributeDevice=" + distributeDevice + ", Provname=" + Provname + ", designation=" + designation + ", mobileno=" + mobileno + '}';
    }

}
