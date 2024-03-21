package com.emis.service;

import com.rhis.db.DBManagerMonitoring;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author Helal
 */
public class UserArea {
    
    public UserArea(){
    }

    public String getDivisionById(int id) throws SQLException{
        String division=null;
        DBManagerMonitoring db = new DBManagerMonitoring();
        String query="SELECT divisioneng FROM public.Division where id='"+id+"'";
        System.out.println(query);
        
        ResultSet rs = db.select(query);

        while (rs.next()) {
            division=rs.getString("divisioneng");
        }
        return division+"~"+id;
    }
    
    
//-----------------------------------------Area ID--------------------------------------------------------    
    
    public String getDivisionIdByUserId(String uId) throws SQLException{
        String division=null;
        DBManagerMonitoring db = new DBManagerMonitoring();
        String query="SELECT divid FROM public.LoginUser where UNAME='"+uId+"'";
        ResultSet rs = db.select(query);
        while (rs.next()) {
            if(rs.getString("divid")!=null){
                division=rs.getString("divid");
            }
        }
        return division;
    }
    
    public String getDistrictIdByUserId(String uId) throws SQLException{
        String district=null;
        DBManagerMonitoring db = new DBManagerMonitoring();
        String query="SELECT zillaid FROM public.LoginUser where UNAME='"+uId+"'";
        ResultSet rs = db.select(query);
        while (rs.next()) {
            if(rs.getString("zillaid")!=null){
                district=rs.getString("zillaid");
            }
        }
        return district;
    }
    
    public String getUpazilaIdByUserId(String uId) throws SQLException{
        String upazila=null;
        DBManagerMonitoring db = new DBManagerMonitoring();
        String query="SELECT upazilaid FROM public.LoginUser where UNAME='"+uId+"'";
        ResultSet rs = db.select(query);
        while (rs.next()) {
            if(rs.getString("upazilaid")!=null){
                upazila=rs.getString("upazilaid");
            }
        }
        return upazila;
    }
    
    public String getUnionIdByUserId(String uId) throws SQLException{
        String union=null;
        DBManagerMonitoring db = new DBManagerMonitoring();
        String query="SELECT unionid FROM public.LoginUser where UNAME='"+uId+"'";
        ResultSet rs = db.select(query);
        while (rs.next()) {
            if(rs.getString("unionid")!=null){
                union=rs.getString("unionid");
            }
        }
        return union;
    }
    
    public String getVillageIdByUserId(String uId) throws SQLException{
        String village=null;
        DBManagerMonitoring db = new DBManagerMonitoring();
        String query="SELECT villageid FROM public.LoginUser where UNAME='"+uId+"'";
        ResultSet rs = db.select(query);
        while (rs.next()) {
            if(rs.getString("villageid")!=null){
                village=rs.getString("villageid");
            }
        }
        return village;
    }
    
    
    
//-----------------------------------------Area Name--------------------------------------------------------
    
    public String getDivisionNameByUserId(String uId) throws SQLException{
        String division=null;
        String divisionId=getDivisionIdByUserId(uId)!=null? getDivisionIdByUserId(uId):"0";
        DBManagerMonitoring db = new DBManagerMonitoring();
        String query="SELECT divisioneng FROM public.division where id='"+divisionId+"'";
        ResultSet rs = db.select(query);
        while (rs.next()) {
            division=rs.getString("divisioneng");
        }
        return division;
    }
    
    public String getDistrictNameByUserId(String uId) throws SQLException{
        String district=null;
        String districtId=getDistrictIdByUserId(uId)!=null? getDistrictIdByUserId(uId):"0";
        String divisionId=getDivisionIdByUserId(uId)!=null? getDivisionIdByUserId(uId):"0";
        
        DBManagerMonitoring db = new DBManagerMonitoring();
        //String query="SELECT divisioneng FROM public.Division where id='"+divisionId+"'";
        String sql="SELECT ZILLANAMEENG FROM public.Zilla where DIVID="+divisionId+" and ZILLAID="+districtId+"";
        ResultSet rs = db.select(sql);
        while (rs.next()) {
            district=rs.getString("ZILLANAMEENG");
        }
        return district;
    }
    
    public String getUpazilaNameByUserId(String uId) throws SQLException{
        String upazila=null;
        String upazilaId=getUpazilaIdByUserId(uId)!=null? getUpazilaIdByUserId(uId):"0";
        String districtId=getDistrictIdByUserId(uId)!=null? getDistrictIdByUserId(uId):"0";
        
        DBManagerMonitoring db = new DBManagerMonitoring();
        String query="SELECT UPAZILANAMEENG FROM public.Upazila where ZILLAID="+districtId+" and UPAZILAID="+upazilaId+"";
        ResultSet rs = db.select(query);
        while (rs.next()) {
            upazila=rs.getString("UPAZILANAMEENG");
        }
        return upazila;
    }
    
    public String getUnionNameByUserId(String uId) throws SQLException{
        String union=null;
        String unionId=getUnionIdByUserId(uId)!=null? getUnionIdByUserId(uId):"0";
        String upazilaId=getUpazilaIdByUserId(uId)!=null? getUpazilaIdByUserId(uId):"0";
        String districtId=getDistrictIdByUserId(uId)!=null? getDistrictIdByUserId(uId):"0";
        
        DBManagerMonitoring db = new DBManagerMonitoring();
        String query="SELECT UNIONNAMEENG FROM public.Unions where ZILLAID="+districtId+" and UPAZILAID="+upazilaId+" and UNIONID="+unionId;
        ResultSet rs = db.select(query);
        while (rs.next()) {
            union=rs.getString("UNIONNAMEENG");
        }
        return union;
    }
    
    public String getVillageNameByUserId(String uId) throws SQLException{
        return null;
    }
    
    
}
