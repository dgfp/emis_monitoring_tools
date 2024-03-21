/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.emis.entity;

/**
 *
 * @author MCHD23
 */
public class Mis1SubmissionAttributes {
    private String data = null;
    private long submissionId = 0;
    private int isApprove = 3; // by default is 3 means 3 is not the meaningfull status
    private String submissionDate = "";
    private boolean valid;
    
    public Mis1SubmissionAttributes() {
    }

    public String getData() {
        return data;
    }

    public void setData(String data) {
        this.data = data;
    }

    public long getSubmissionId() {
        return submissionId;
    }

    public void setSubmissionId(long submissionId) {
        this.submissionId = submissionId;
    }

    public int getIsApprove() {
        return isApprove;
    }

    public void setIsApprove(int isApprove) {
        this.isApprove = isApprove;
    }

    public String getSubmissionDate() {
        return submissionDate;
    }

    public void setSubmissionDate(String submissionDate) {
        this.submissionDate = submissionDate;
    }

    public boolean isValid() {
        return valid;
    }

    public void setValid(boolean valid) {
        this.valid = valid;
    }


    public boolean hasData(){
        return this.data != null;
    }
    @Override
    public String toString() {
        return "Mis1SubmissionAttributes{" + "data=" + data + ", submissionId=" + submissionId + ", isApprove=" + isApprove + ", submissionDate=" + submissionDate + '}';
    }
    
}
