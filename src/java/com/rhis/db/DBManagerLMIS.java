package com.rhis.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 *
 * @author Helal
 */
public class DBManagerLMIS {
    
   //Server
    protected String dbIP = "emis.icddrb.org";
    protected String username = "monitoring";
    protected String password = "@LoOt!dfdsfdsfMoNiToRiNg@1";
    protected String dbName = "rhis_lmis_dev";
    private int port = 5432;
    private Connection connection = null;
    
    public DBManagerLMIS() {
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
            System.out.println("DB URL: " + dbUrl);
            connection = DriverManager.getConnection(dbUrl, username, password);

        } catch (ClassNotFoundException e) {
            System.out.println("Driver not found");
            //return;
        } catch (SQLException ex) {
        }
        return connection;
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


    public int update(String query) {
        int affectedRowCount = 0;
        System.out.println("Query String: " + query);
        try {
            Statement stmt = connection.createStatement();
            affectedRowCount = stmt.executeUpdate(query);
            System.out.println("Affected Rows:" + affectedRowCount);
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        } finally {
            closeConnection();
        }
        return affectedRowCount;
    }
    
}
