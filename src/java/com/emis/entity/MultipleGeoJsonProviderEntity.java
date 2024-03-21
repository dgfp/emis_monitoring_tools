/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.emis.entity;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import java.util.ArrayList;

/**
 *
 * @author MCHD23
 */
@JsonIgnoreProperties(ignoreUnknown = true)
public class MultipleGeoJsonProviderEntity {
    public ArrayList<String> divisions;
    public ArrayList<String> districts;
    public ArrayList<String> reporting_upazilas;
    
    public MultipleGeoJsonProviderEntity() {
    }

    public MultipleGeoJsonProviderEntity(ArrayList<String> divisions) {
        this.divisions = divisions;
    }

    public MultipleGeoJsonProviderEntity(ArrayList<String> divisions, ArrayList<String> districts) {
        this.divisions = divisions;
        this.districts = districts;
    }

    public MultipleGeoJsonProviderEntity(ArrayList<String> divisions, ArrayList<String> districts, ArrayList<String> reporting_upazilas) {
        this.divisions = divisions;
        this.districts = districts;
        this.reporting_upazilas = reporting_upazilas;
    }

    public ArrayList<String> getReporting_upazilas() {
        return reporting_upazilas;
    }

    public void setReporting_upazilas(ArrayList<String> reporting_upazilas) {
        this.reporting_upazilas = reporting_upazilas;
    }

    public ArrayList<String> getDivisions() {
        return divisions;
    }

    public void setDivisions(ArrayList<String> divisions) {
        this.divisions = divisions;
    }

    public ArrayList<String> getDistricts() {
        return districts;
    }

    public void setDistricts(ArrayList<String> districts) {
        this.districts = districts;
    }

    @Override
    public String toString() {
        return "MultipleGeoJsonProviderEntity{" + "division=" + divisions + ", districts=" + districts + '}';
    }
    
    
}
