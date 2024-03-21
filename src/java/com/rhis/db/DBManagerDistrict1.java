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
public class DBManagerDistrict1 {
    //Server 
    private String dbIP = "mchdrhis.icddrb.org";
    private String username = "rhis";
    private String password = "rhis12#rhis";
    private String dbName = "RHIS";
    private int port = 5432;
    
    
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
        
        
    
    private Connection connection = null;

    public DBManagerDistrict1(int districtId) {
        
        try {
            ResultSet result=new DBManagerMonitoring().getCredentials(districtId);
            if(result!=null){
                while (result.next()) {
                    System.out.println("```````````````Credential from DB`````````````````");
                    
                    dbIP=result.getString("host_name");
                    port=result.getInt("port_no");
                    username=result.getString("username");
                    password=result.getString("password");
                    dbName = result.getString("database_name");
//                    if(districtId==93){
//                        dbName="RHIS";
//                    }else{
//                        dbName="RHIS_"+districtId;
//                    }
                }
            }else{
                System.out.println("```````````````Use Default Credential`````````````````");
            }
            
            Class.forName("org.postgresql.Driver");
            String dbUrl = "jdbc:postgresql://" + dbIP + ":" + port + "/" + dbName;
            System.out.println("DB URL: " + dbUrl);
            connection = DriverManager.getConnection(dbUrl, username, password);
            
        } catch (ClassNotFoundException e) {
            System.out.println("Driver not found");
            //return;
        } catch (SQLException ex) {
        }
    }
    
    public DBManagerDistrict1() {
        try {
            Class.forName("org.postgresql.Driver");
            String dbUrl = "jdbc:postgresql://" + dbIP + ":" + port + "/" + dbName;
            System.out.println("DB URL: " + dbUrl);
            connection = DriverManager.getConnection(dbUrl, username, password);
        } catch (ClassNotFoundException e) {
            System.out.println("Driver not found");
            //return;
        } catch (SQLException ex) {
        }
    }
    
    //modified: taslim
    public  Connection openConnection() {
        try {
            Class.forName("org.postgresql.Driver");
            String dbUrl = "jdbc:postgresql://" + dbIP + ":" + port + "/" + dbName;
            System.out.println("DB URL--: " + dbUrl);
            connection = DriverManager.getConnection(dbUrl, username, password);

        } catch (ClassNotFoundException e) {
            System.out.println("Driver not found");
            //return;
        } catch (SQLException ex) {
        }
        return connection;
    }
    
    public  Connection getConnection() {
        
        return this.connection;
    }

    private void closeConnection() {
        try {
            if (connection != null) {
                connection.close();
            }
        } catch (SQLException ex) {
        }
    }
    
    public ResultSet select(String query) {
        ResultSet rset = null;
        System.out.println("Query String: " + query);
        try {
            Statement stmt = connection.createStatement();
            rset = stmt.executeQuery(query);
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        } finally {
            closeConnection();
        }
        return rset;
    }

    public String ReturnSingleValue(String SQL) {
        String ReturnValue = "";
        try {
            DBManagerDistrict1 db = new DBManagerDistrict1();
            ResultSet rs = db.select(SQL);
            int count = 0;

            while (rs.next()) {
                ReturnValue = rs.getString("starthhno");
            }
            rs.close();

        } catch (SQLException ex) {
            Logger.getLogger(DBManagerDistrict1.class.getName()).log(Level.SEVERE, null, ex);
        }
        return ReturnValue;
    }

    public int update(String query) {
        int affectedRowCount = 0;
        System.out.println("Query String: " + query);
        try {
            Statement stmt = this.connection.createStatement();
            affectedRowCount = stmt.executeUpdate(query);
            System.out.println("Affected Rows:" + affectedRowCount);
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        } finally {
            closeConnection();
        }
        return affectedRowCount;
    }
    
    public void delete(String query) {
        System.out.println("Query String: " + query);
        try {
            Statement stmt = connection.createStatement();
            stmt.execute(query);
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        } finally {
            closeConnection();
        }
    }
    
    public ResultSet selectDouble(String query1,String query2) {
        ResultSet rset = null;
        System.out.println("Query String1: " + query1);
        System.out.println("Query String2: " + query2);
        try {
            Statement stmt = connection.createStatement();
            stmt.executeQuery(query1);
            rset = stmt.executeQuery(query2);
            
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        } finally {
            closeConnection();
        }
        return rset;
    }
    
    /*public ResultSet getCredentials(int districtId) {
        
        System.out.println("`````````````````Called getCredentials()`````````````````````");
        ResultSet result=null;
        try {
            Class.forName("org.postgresql.Driver");
            String dbUrl = "jdbc:postgresql://mchdrhis.icddrb.org:5432/RHIS_CENTRAL";
            connection = DriverManager.getConnection(dbUrl, "rhis", "rhis12#rhis");
            String sql = "SELECT * FROM public.host_address where dist=?";
            
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, districtId);
            result = preparedStatement.executeQuery();
            //connection.close();
            
            

        } catch (ClassNotFoundException e) {
            System.out.println("Driver not found");
        } catch (SQLException ex) {
        }
        return result;
    }*/
   
    
}
