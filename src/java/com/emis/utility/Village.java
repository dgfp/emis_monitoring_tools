/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.emis.utility;
import java.io.Serializable;
import java.util.ArrayList;
/**
 *
 * @author ccah
 */

public class Village implements Serializable {

    private String zillaid;
    private String villagenameeng;
    private String villagename;


    public Village(String zillaid, String villagenameeng, String villagename) {
        this.zillaid = zillaid;
        this.villagenameeng = villagenameeng;
        this.villagename = villagename;
    }

    public Village() {

    }

    public String getZillaid() {
        return zillaid;
    }

    public void setZillaid(String zillaid) {
        this.zillaid = zillaid;
    }

    public String getVillagenameeng() {
        return villagenameeng;
    }

    public void setVillagenameeng(String villagenameeng) {
        this.villagenameeng = villagenameeng;
    }

    public String getVillagename() {
        return villagename;
    }

    public void setVillagename(String villagename) {
        this.villagename = villagename;
    }


   
}
