package com.emis.beans;

import java.io.Serializable;

/**
 *
 * @author Helal
 */
public class LoginUser implements Serializable {
    
    protected String USERID;
    protected String UNAME;
    protected String PASS;
    protected String Active;
    protected String UserLevel;
    protected String CreDate;
    protected String Division;
    protected String District;
    protected String Upazila;
    protected String Union;
    protected String Village;
    protected String Name;
    protected String Email;
    protected String Designation;
    protected int Category;
    protected String Role;
    
    //--------------------
    public String getUSERID(){
        return this.USERID;
    }
    public void setUSERID(String USERID){
        this.USERID=USERID;
    }
    
    //--------------------
    public String getUNAME(){
        return this.UNAME;
    }
    public void setUNAME(String UNAME){
        this.UNAME=UNAME;
    }
    
        
    //--------------------
    public String getPASS(){
        return this.PASS;
    }
    public void setPASS(String PASS){
        this.PASS=PASS;
    }
    
        
    //--------------------
    public String getActive(){
        return this.Active;
    }
    public void setActive(String Active){
        this.Active=Active;
    }
   
    //--------------------
    public String getUserLevel(){
        return this.UserLevel;
    }
    public void setUserLevel(String UserLevel){
        this.UserLevel=UserLevel;
    }
    
        
    //--------------------
    public String getCreDate(){
        return this.CreDate;
    }
    public void setCreDate(String CreDate){
        this.CreDate=CreDate;
    }
       
        
    //--------------------
    public String getDivision(){
        return this.Division;
    }
    public void setDivision(String Division){
        this.Division=Division;
    }
    
    //--------------------
    public String getDistrict(){
        return this.District;
    }
    public void setDistrict(String District){
        this.District=District;
    }
    
        
    //--------------------
    public String getUpazila(){
        return this.Upazila;
    }
    public void setUpazila(String Upazila){
        this.Upazila=Upazila;
    }
    
        
    //--------------------
    public String getUnion(){
        return this.Union;
    }
    public void setUnion(String Union){
        this.Union=Union;
    }
    
    //--------------------
    public String getVillage(){
        return this.Village;
    }
    public void setVillage(String Village){
        this.Village=Village;
    }
    
    //--------------------
    public String getName(){
        return this.Name;
    }
    public void setName(String Name){
        this.Name=Name;
    }
    
    //--------------------
    public String getDesignation(){
        return this.Designation;
    }
    public void setDesignation(String Designation){
        this.Designation=Designation;
    }
            
    //--------------------
    public int getCategory(){
        return this.Category;
    }
    public void setCategory(int Category){
        this.Category=Category;
    }
    
    //--------------------
    public String getRole(){
        return this.Role;
    }
    public void setRole(String Role){
        this.Role=Role;
    }

    public String getEmail() {
        return Email;
    }

    public void setEmail(String Email) {
        this.Email = Email;
    }

    
    @Override
    public String toString() {
        return "LoginUser{" + "USERID=" + USERID + ", UNAME=" + UNAME + ", PASS=" + PASS + ", Active=" + Active + ", UserLevel=" + UserLevel + ", CreDate=" + CreDate + ", Division=" + Division + ", District=" + District + ", Upazila=" + Upazila + ", Union=" + Union + ", Village=" + Village + ", Name=" + Name + ", Designation=" + Designation + ", Category=" + Category + ", Role=" + Role + '}';
    }
       
}
