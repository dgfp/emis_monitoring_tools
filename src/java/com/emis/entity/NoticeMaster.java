package com.emis.entity;

/**
 *
 * @author Helal
 */
public class NoticeMaster {
    
    private String meeting_date;
    private String meeting_circulate_date;
    private String meeting_time;
    private String place;
    private String meeting_type;
    private String fwa;
    private String fwv;
    private String pharmacist;
    private String ucmo;
    private String ufpo;
    private String cc_ufpo;
    private String cc_uch;

    public NoticeMaster() {
    }

    public NoticeMaster(String meeting_date, String meeting_circulate_date, String meeting_time, String place, String meeting_type, String fwa, String fwv, String pharmacist, String ucmo, String ufpo, String cc_ufpo, String cc_uch) {
        this.meeting_date = meeting_date;
        this.meeting_circulate_date = meeting_circulate_date;
        this.meeting_time = meeting_time;
        this.place = place;
        this.meeting_type = meeting_type;
        this.fwa = fwa;
        this.fwv = fwv;
        this.pharmacist = pharmacist;
        this.ucmo = ucmo;
        this.ufpo = ufpo;
        this.cc_ufpo = cc_ufpo;
        this.cc_uch = cc_uch;
    }

    public String getMeeting_date() {
        return meeting_date;
    }

    public void setMeeting_date(String meeting_date) {
        this.meeting_date = meeting_date;
    }

    public String getMeeting_circulate_date() {
        return meeting_circulate_date;
    }

    public void setMeeting_circulate_date(String meeting_circulate_date) {
        this.meeting_circulate_date = meeting_circulate_date;
    }

    public String getMeeting_time() {
        return meeting_time;
    }

    public void setMeeting_time(String meeting_time) {
        this.meeting_time = meeting_time;
    }

    public String getPlace() {
        return place;
    }

    public void setPlace(String place) {
        this.place = place;
    }

    public String getMeeting_type() {
        return meeting_type;
    }

    public void setMeeting_type(String meeting_type) {
        this.meeting_type = meeting_type;
    }

    public String getFwa() {
        return fwa;
    }

    public void setFwa(String fwa) {
        this.fwa = fwa;
    }

    public String getFwv() {
        return fwv;
    }

    public void setFwv(String fwv) {
        this.fwv = fwv;
    }

    public String getPharmacist() {
        return pharmacist;
    }

    public void setPharmacist(String pharmacist) {
        this.pharmacist = pharmacist;
    }

    public String getUcmo() {
        return ucmo;
    }

    public void setUcmo(String ucmo) {
        this.ucmo = ucmo;
    }

    public String getUfpo() {
        return ufpo;
    }

    public void setUfpo(String ufpo) {
        this.ufpo = ufpo;
    }

    public String getCc_ufpo() {
        return cc_ufpo;
    }

    public void setCc_ufpo(String cc_ufpo) {
        this.cc_ufpo = cc_ufpo;
    }

    public String getCc_uch() {
        return cc_uch;
    }

    public void setCc_uch(String cc_uch) {
        this.cc_uch = cc_uch;
    }

    @Override
    public String toString() {
        return "NoticeMaster{" + "meeting_date=" + meeting_date + ", meeting_circulate_date=" + meeting_circulate_date + ", meeting_time=" + meeting_time + ", place=" + place + ", meeting_type=" + meeting_type + ", fwa=" + fwa + ", fwv=" + fwv + ", pharmacist=" + pharmacist + ", ucmo=" + ucmo + ", ufpo=" + ufpo + ", cc_ufpo=" + cc_ufpo + ", cc_uch=" + cc_uch + '}';
    }
    
}
