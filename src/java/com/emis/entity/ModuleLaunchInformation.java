/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.emis.entity;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import java.io.File;
import java.text.DateFormat;

/**
 *
 * @author Nibras Ar Rakib
 */
@JsonIgnoreProperties(ignoreUnknown = true)
public class ModuleLaunchInformation {
    public int id;
    public String division;
    public String zilla;
    public String upazila;
    public int organized_for;
    public String training_start_date;
    public String training_end_date;
    public String training_type_id;
    public String module_id;
    public int participant_number;
    public String document_url;
    public String reportType;

    public ModuleLaunchInformation() {
    }

    public ModuleLaunchInformation(int id, String division, String zilla, String upazila, int organized_for, String training_start_date, String training_end_date, String training_type_id, String module_id, int participant_number, String document_url, String reportType) {
        this.id = id;
        this.division = division;
        this.zilla = zilla;
        this.upazila = upazila;
        this.organized_for = organized_for;
        this.training_start_date = training_start_date;
        this.training_end_date = training_end_date;
        this.training_type_id = training_type_id;
        this.module_id = module_id;
        this.participant_number = participant_number;
        this.document_url = document_url;
        this.reportType = reportType;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getDivision() {
        return division;
    }

    public void setDivision(String division) {
        this.division = division;
    }

    public String getZilla() {
        return zilla;
    }

    public void setZilla(String zilla) {
        this.zilla = zilla;
    }

    public String getUpazila() {
        return upazila;
    }

    public void setUpazila(String upazila) {
        this.upazila = upazila;
    }

    public int getOrganized_for() {
        return organized_for;
    }

    public void setOrganized_for(int organized_for) {
        this.organized_for = organized_for;
    }

    public String getTraining_start_date() {
        return training_start_date;
    }

    public void setTraining_start_date(String training_start_date) {
        this.training_start_date = training_start_date;
    }

    public String getTraining_end_date() {
        return training_end_date;
    }

    public void setTraining_end_date(String training_end_date) {
        this.training_end_date = training_end_date;
    }

    public String getTraining_type_id() {
        return training_type_id;
    }

    public void setTraining_type_id(String training_type_id) {
        this.training_type_id = training_type_id;
    }

    public String getModule_id() {
        return module_id;
    }

    public void setModule_id(String module_id) {
        this.module_id = module_id;
    }

    public int getParticipant_number() {
        return participant_number;
    }

    public void setParticipant_number(int participant_number) {
        this.participant_number = participant_number;
    }

    public String getDocument_url() {
        return document_url;
    }

    public void setDocument_url(String document_url) {
        this.document_url = document_url;
    }

    public String getReportType() {
        return reportType;
    }

    public void setReportType(String reportType) {
        this.reportType = reportType;
    }

    @Override
    public String toString() {
        return "ModuleLaunchInformation{" + "id=" + id + ", division=" + division + ", zilla=" + zilla + ", upazila=" + upazila + ", training_start_date=" + training_start_date + ", training_end_date=" + training_end_date + ", training_type_id=" + training_type_id + ", module_id=" + module_id + ", participant_number=" + participant_number + ", document_url=" + document_url + ", reportType=" + reportType + '}';
    }


    
    
}
