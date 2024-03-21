/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.emis.beans;

/**
 *
 * @author Helal
 */
public class LoginUserDGFP extends LoginUser{
    
    protected int provtype;
    protected int designation_provtype;

    public int getProvtype() {
        return provtype;
    }

    public void setProvtype(int provtype) {
        this.provtype = provtype;
    }

    public int getDesignation_provtype() {
        return designation_provtype;
    }

    public void setDesignation_provtype(int designation_provtype) {
        this.designation_provtype = designation_provtype;
    }

    @Override
    public String toString() {
        return "LoginUser{" + "USERID=" + USERID + ", UNAME=" + UNAME + ", PASS=" + PASS + ", Active=" + Active + ", UserLevel=" + UserLevel + ", CreDate=" + CreDate + ", Division=" + Division + ", District=" + District + ", Upazila=" + Upazila + ", Union=" + Union + ", Village=" + Village + ", Name=" + Name + ", Designation=" + Designation + ", Category=" + Category + ", Role=" + Role + ", provtype=" + provtype + ", designation_provtype=" + designation_provtype + '}';
        //return "LoginUserDGFP{" + "provtype=" + provtype + ", designation_provtype=" + designation_provtype + '}';
    }
}
