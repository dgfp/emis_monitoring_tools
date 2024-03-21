package com.rhis.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Helal
 */
public class DBManagerDistrict extends DBManagerMonitoring {

    //Server 
//    protected String dbIP = "mchdrhis.icddrb.org";
//    protected String username = "rhis";
//    protected String password = "rhis12#rhis";
//    protected String dbName = "RHIS";
//    protected int port = 5432;
    
    protected Connection connection = null;

    //Dev Server 
//    private String dbIP = "mchdrhis.icddrb.org";
//    private String username = "rhis";
//    private String password = "rhis12#rhis";
//    private String dbName = "RHIS_93_DEV";
//    private int port = 5432;
    //Server for save (Inside) ----12-3-2017
//    private String dbIP = "10.12.0.32";
//    private String username = "postgres";
//    private String password = "postgres";
//    private String dbName = "RHIS_36";
//    private int port = 5432;
//    //Server for save (Outside) ----12-3-2017
//    private String dbIP = "119.148.6.215";
//    private String username = "rhis_admin";
//    private String password = "rhis12#rhis";
//    private String dbName = "RHIS_36";
//    private int port = 5432;
    //Noakhali Server for save (Outside) ----12-3-2017
//        private String dbIP = "10.12.0.43";
//        private String username = "mamoni";
//        private String password = "jama$save";
//        private String dbName = "RHIS_75";
//        private int port = 5432;
    //Lakshmipur Server for save----12-3-2017
    //Inside
//        private String dbIP = "10.12.0.41";
//        private String username = "mamoni";
//        private String password = "jama$save";
//        private String dbName = "RHIS_51";
//        private int port = 5432;
    //Outside
//        private String dbIP = "119.148.43.41";
//        private String username = "mamoni";
//        private String password = "jama$save";
//        private String dbName = "RHIS_51";
//        private int port = 5432;
    public DBManagerDistrict() {

    }

    @SuppressWarnings("OverridableMethodCallInConstructor")
    public DBManagerDistrict(int districtId) {
        try {
            ResultSet result = super.getCredentials(districtId);
            if (result != null) {
                while (result.next()) {
                    dbIP = result.getString("host_name");
                    port = result.getInt("port_no");
                    username = result.getString("username");
                    password = result.getString("password");
                    dbName = result.getString("database_name");
                    //dbName=districtId==93? "RHIS": "RHIS_"+districtId;
                }
                System.out.println("DB: " + getURL ());
                super.setCredentials(dbIP, username, password, dbName, port);
                super.openConnection();
                //System.out.println("```````````````after IF: Credential from DB`````````````````" + getURL ());
            } else {
                //System.out.println("```````````````ELSE: Credential from DB`````````````````" +  getURL ());
            }

        } catch (SQLException ex) {
        }
    }
    
    @Override
    protected void init(){
    }

}
