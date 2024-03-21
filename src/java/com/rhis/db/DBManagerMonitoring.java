package com.rhis.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * @author Helal
 */
public class DBManagerMonitoring {


    protected String dbIP = "103.48.19.7";
    protected String username = "monitoring";
    protected String password = "^!@gnI!@#rotinOm#@!";
    protected String dbName = "RHIS_CENTRAL";
    protected int port = 5412;

//    protected String dbIP = "103.48.19.7";
//    protected String username = "mshaque";
//    protected String password = "mshaque321";
//    protected String dbName = "RHIS_CENTRAL";
//    protected int port = 5412;

    protected Connection connection = null;
    protected String message = "";
    protected boolean forceOpen = false;
   
    /*
    --Changeable    
    protected String dbIP = "172.20.20.242";
    protected String username = "rhis";
    protected String password = "!RhIs#@!4RhIs@";
    protected String dbName = "RHIS_CENTRAL";
    protected int port = 5442;
    protected Connection connection = null;
    protected String message = "";
    protected boolean forceOpen = false;
     */
    public DBManagerMonitoring() {
        try {
            init();
        } catch (Exception ex) {
        }
    }

    protected void init() {
        connection = openConnection();
    }

    public String getURL() {
        String dbUrl = "jdbc:postgresql://" + dbIP + ":" + port + "/" + dbName;
        // jdbc:postgresql://
        System.out.println(dbUrl);
        return dbUrl;
    }

    //modified: taslim
    public final Connection openConnection() {
        try {
            Class.forName("org.postgresql.Driver");
            String dbUrl = getURL();
            //System.out.println("DB URL: " + dbUrl);
            connection = DriverManager.getConnection(dbUrl, username, password);

        } catch (ClassNotFoundException e) {
            Message("Driver not found");
            //return;
        } catch (SQLException ex) {
        }
        return connection;
    }

    public void start() {
        try {
            forceOpen();
            connection.setAutoCommit(false);
        } catch (SQLException ex) {
        }
    }

    public void commit() {
        try {
            connection.commit();
            forceClose();

        } catch (SQLException ex) {
        }
    }

    public void rollback() {
        try {
            connection.rollback();
            forceClose();
        } catch (SQLException ex) {
        }
    }

    public void forceOpen() {
        forceOpen = true;
    }

    public void forceClose() {
        forceOpen = false;
        closeConnection();
    }

    public Connection getConnection() {

        return this.connection;
    }

    private void closeConnection() {
        try {
            if (connection != null && !forceOpen) {
                connection.close();
            }
        } catch (SQLException ex) {
        }
    }

    public void Message(String ex) {
        message = ex;
        System.out.println(message);
    }

    public void Message(Exception ex) {
        Message(ex.getMessage());
    }

    public String Message() {
        return message;
    }

    public ResultSet select(String query) {
        ResultSet rset = null;
        System.out.println("SQL: " + query);
        try {
            Statement stmt = connection.createStatement();
            rset = stmt.executeQuery(query);
        } catch (SQLException ex) { System.out.println("mn"+ex);
            Message(ex);
        } finally {
            closeConnection();
        }
        return rset;
    }

    public String one(String query, String column) {
        ResultSet rs = select(query);
        System.out.println("SQL: " + query);
        String value = "";
        try {
            while (rs.next()) {
                value = rs.getString(column);
                return value;
            }
        } catch (SQLException ex) {
            Logger.getLogger(DBManagerMonitoring.class.getName()).log(Level.SEVERE, null, ex);
        }
        return value;
    }

    public String ReturnSingleValue(String query) {
        return one(query, "starthhno");
    }

    public int update(String query) {
        int affectedRowCount = 0;
        //System.out.println("Query String: " + query);
        try {
            Statement stmt = this.connection.createStatement();
            affectedRowCount = stmt.executeUpdate(query);
//            System.out.println("SQL:" + query);
        } catch (SQLException ex) {
            System.out.println("update query error:"+ex.getMessage());
            Message(ex);
        } finally {
            closeConnection();
        }
        return affectedRowCount;
    }

    public void delete(String query) {
        //System.out.println("Query String: " + query);
        try {
            Statement stmt = connection.createStatement();
            stmt.execute(query);
            System.out.println("SQL:" + query);
        } catch (SQLException ex) {
            Message(ex);
        } finally {
            closeConnection();
        }
    }

    public ResultSet selectDouble(String query1, String query2) {
        ResultSet rset = null;
        System.out.println("SQL: " + query1);
        System.out.println("SQL: " + query2);
        try {
            Statement stmt = connection.createStatement();
            stmt.executeQuery(query1);
            rset = stmt.executeQuery(query2);

        } catch (SQLException ex) {
            Message(ex);
        } finally {
            closeConnection();
        }
        return rset;
    }

    public void setCredentials(String dbIP, String username, String password, String dbName, int port) {
        this.dbIP = dbIP;
        this.username = username;
        this.password = password;
        this.dbName = dbName;
        this.port = port;
    }

    public ResultSet getCredentials(int districtId) {
        //System.out.println("`````````````````Called getCredentials()`````````````````````");
        ResultSet result = null;
        try {
            openConnection();
            String sql = "SELECT * FROM public.host_address where zillaid=" + districtId;
            result = select(sql);
        } catch (Exception ex) {
            Message(ex);
        }
        return result;
    }
}
