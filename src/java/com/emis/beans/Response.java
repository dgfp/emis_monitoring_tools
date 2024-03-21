/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.emis.beans;

import java.util.List;
import org.json.JSONArray;

/**
 *
 * @author Rahen
 */
public class Response<T> {

    protected String message;
    protected String status;
    protected String data; // json
    
    //private Map<String, Person> children;

    public String getMessage() {
        return message;
    }

    public Response setMessage(String message) {
        this.message = message;
        return this;
    }

    public String getStatus() {
        return status;
    }

    public Response setStatus(String status) {
        this.status = status;
        return this;
    }

    public Response setStatus(int status) {
        this.status = (status>0)?"success":"error";
        return this;
    }

    public String getData() {
        return data;
    }

    public Response setData(String data) {
        this.data = data;
        return this;
    }

}
