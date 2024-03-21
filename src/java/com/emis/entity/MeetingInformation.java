/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.emis.entity;

import java.util.ArrayList;

/**
 *
 * @author MCHD23
 */
public class MeetingInformation {
    public String meeting_date;
    public String meeting_time;
    public String meeting_place;
    public String meeting_type;
    
    public ArrayList<String> meeting_participants;
    public ArrayList<String> meeting_recipients;

    public MeetingInformation() {
    }

    public MeetingInformation(String meeting_date, String meeting_time, String meeting_place, String meeting_type, ArrayList<String> meeting_participants, ArrayList<String> meeting_recipients) {
        this.meeting_date = meeting_date;
        this.meeting_time = meeting_time;
        this.meeting_place = meeting_place;
        this.meeting_type = meeting_type;
        this.meeting_participants = meeting_participants;
        this.meeting_recipients = meeting_recipients;
    }

    public String getMeeting_date() {
        return meeting_date;
    }

    public void setMeeting_date(String meeting_date) {
        this.meeting_date = meeting_date;
    }

    public String getMeeting_time() {
        return meeting_time;
    }

    public void setMeeting_time(String meeting_time) {
        this.meeting_time = meeting_time;
    }

    public String getMeeting_place() {
        return meeting_place;
    }

    public void setMeeting_place(String meeting_place) {
        this.meeting_place = meeting_place;
    }

    public String getMeeting_type() {
        return meeting_type;
    }

    public void setMeeting_type(String meeting_type) {
        this.meeting_type = meeting_type;
    }

    public ArrayList<String> getMeeting_participants() {
        return meeting_participants;
    }

    public void setMeeting_participants(ArrayList<String> meeting_participants) {
        this.meeting_participants = meeting_participants;
    }

    public ArrayList<String> getMeeting_recipients() {
        return meeting_recipients;
    }

    public void setMeeting_recipients(ArrayList<String> meeting_recipients) {
        this.meeting_recipients = meeting_recipients;
    }
    
    
}
