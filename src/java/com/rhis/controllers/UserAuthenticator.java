package com.rhis.controllers;

import com.rhis.db.DBManagerMonitoring;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Logger;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/**
 * @author Helal
 */
public class UserAuthenticator {

    private Connection connection = null;

    public static boolean authenticate(String username, String password) throws SQLException {
        DBManagerMonitoring db = new DBManagerMonitoring();
        Connection connection = null;
        connection = db.openConnection();

        String query = "select count(*) as exists from loginuser where uname= ? and pass = ? and active = '1'";
        PreparedStatement preparedStatement = connection.prepareStatement(query);
        preparedStatement.setString(1, username);
        preparedStatement.setString(2, password);
        ResultSet rs = preparedStatement.executeQuery();

        int count = 0;
        try {
            while (rs.next()) {
                count = rs.getInt("exists");
            }
            connection.close();
        } catch (SQLException ex) {
            connection.close();
        }
        return count > 0; //return true if > 0 false otherwise
    }

    public static boolean authenticateProvider(String username, String password) throws SQLException {

        DBManagerMonitoring db = new DBManagerMonitoring();
        Connection connection = null;
        connection = db.openConnection();

        String query = "SELECT count(*) as exists FROM public.providerdb where providerid = ? and provpass = ? and active = 1";
        PreparedStatement preparedStatement = connection.prepareStatement(query);
        preparedStatement.setInt(1, Integer.parseInt(username));
        preparedStatement.setString(2, password);
        ResultSet rs = preparedStatement.executeQuery();

        int count = 0;
        try {
            while (rs.next()) {
                count = rs.getInt("exists");
            }
        } catch (SQLException ex) {
        }
        return count > 0; //return true if > 0 false otherwise
    }

    public boolean Login(String username, String password) throws SQLException {

        ResultSet rset = null;
        DBManagerMonitoring db = new DBManagerMonitoring();
        connection = db.openConnection();
        String query = "select count(*) as exists from loginuser where uname= ? and pass = ? and active = ?";

        int count = 0;

        try {
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setString(1, username);
            preparedStatement.setString(2, password);
            preparedStatement.setString(2, "1");
            preparedStatement.executeQuery();
            rset = preparedStatement.executeQuery();
            while (rset.next()) {
                count = rset.getInt("exists");
            }
            connection.close();
        } catch (SQLException ex) {
            connection.close();
        }
        return count > 0; //return true if > 0 false otherwise

    }

    public void updateLoginHistory(HttpSession session, HttpServletRequest request) {
        String sql = "INSERT INTO public.web_login_history\n"
                + "    (userid, session_id, user_ip, session_start, session_end)\n"
                + "    VALUES ('%s','%s', '%s', now(), now()) \n"
                + "    ON CONFLICT (session_id,userid) DO UPDATE SET session_end=now()";

        String visitSql = "INSERT INTO public.web_visit_history(session_id, slug, visit_time)\n"
                + "VALUES ('" + session.getId() + "', '" + request.getServletPath() + "', now())\n"
                + "ON CONFLICT (session_id,slug) DO UPDATE SET visit_time=now()";
        try {
            sql = String.format(sql, session.getAttribute("username"), session.getId(), request.getRemoteAddr());
            new DBManagerMonitoring().update(sql);
            if(this.checkSlug(request.getServletPath())){
                new DBManagerMonitoring().update(visitSql);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private Boolean checkSlug(String path) throws SQLException {
        connection = new DBManagerMonitoring().openConnection();
        String query = "SELECT 1 FROM public.web_modulereport where servlet_url=?";
        Boolean isExist = false;
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setString(1, path.substring(1,path.length()));
            preparedStatement.executeQuery();
            ResultSet rset = preparedStatement.executeQuery();
            while (rset.next()) {
                isExist = true;
            }
            connection.close();
        } catch (SQLException ex) {
            connection.close();
        }
        return isExist;
    }
}