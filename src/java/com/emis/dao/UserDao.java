package com.emis.dao;

import com.emis.beans.LoginUserDGFP;
import com.emis.utility.Convertor;
import com.rhis.db.DBManagerDistrict;
import com.rhis.db.DBManagerMonitoring;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.JSONArray;

/**
 *
 * @author Helal
 */
public class UserDao {

    private DBManagerMonitoring db = null;
    private Connection connection = null;

    public UserDao() {
        db = new DBManagerMonitoring();
        connection = db.openConnection();
    }

    public UserDao(int districtId) {
        db = new DBManagerDistrict(districtId);
        connection = db.openConnection();
    }

    private void print(String text) {
        System.out.println(text);
    }

    public JSONArray getUser() throws SQLException, Exception {
        String sql = "select distinct name,userid from loginuser join web_login_history using(userid)";
        sql = "select distinct name, l.userid, roleid, divid, zillaid, upazilaid, unionid from loginuser l\n"
                + "join web_login_history using(userid)\n"
                + "left join web_userrole ur on l.userid=ur.userid where l.active = 1";
        Statement stmt = connection.createStatement();
        ResultSet resultSet = null;
        resultSet = stmt.executeQuery(sql);
        connection.close();
        return Convertor.convertResultSetIntoJSONWithDash(resultSet);
    }

    public JSONArray getUserRole() throws SQLException, Exception {
        String sql = "select roleid, rolename from web_role order by roleid";
        Statement stmt = connection.createStatement();
        ResultSet resultSet = null;
        resultSet = stmt.executeQuery(sql);
        connection.close();
        return Convertor.convertResultSetIntoJSONWithDash(resultSet);
    }

    public JSONArray getUserLogById(String userId) throws SQLException, Exception {
        String sql = "SELECT userid, user_ip, name, session_id, session_start, session_end, TO_CHAR((session_end-session_start),'HH24h MIm') session_duration FROM public.web_login_history join loginuser using (userid) where userid = '" + userId + "' order by  session_end desc";
        System.out.println("SQL: " + sql);
        Statement stmt = connection.createStatement();
        ResultSet resultSet = null;
        resultSet = stmt.executeQuery(sql);
        connection.close();
        return Convertor.convertResultSetIntoJSONWithDash(resultSet);
    }

    public int getZillaIdByUser(HttpServletRequest request, HttpServletResponse response) {
        if (request.getSession(false).getAttribute("district") != null) {
            return Integer.parseInt(request.getSession(false).getAttribute("district").toString());
        } else {
            return 0;
        }
    }

    public boolean isPaperless(String districtId) throws SQLException, Exception {
        String sql = "SELECT distinct is_paperless FROM public.implemented_div_zila where is_implemented=1 and zillaid = " + districtId + " limit 1";
        boolean exist = false;
        int is_paperless = 0;
        ResultSet rs = connection.createStatement().executeQuery(sql);
        while (rs.next()) {
            is_paperless = rs.getInt("is_paperless");
        }
        if (is_paperless == 1) {
            exist = true;
        }
        connection.close();
        this.print(sql);
        return exist;
    }

    public boolean addUserToWebAccessControl(LoginUserDGFP lu) throws SQLException, Exception {
        boolean isCompleted = false;
        db.start();
        String login_user_sql = "INSERT INTO public.loginuser(cluster, userid, uname, pass, active, admin, userlevel, credate, divid, zillaid, upazilaid, unionid, villageid, name, \n"
                + "			email, designation, systementrydate, modifydate, uploaddate, upload, provtype, designation_provtype, provider_access_active)\n"
                + "VALUES ('*', '" + lu.getUSERID() + "', '" + lu.getUSERID() + "', '" + lu.getPASS() + "', 1, 1, " + lu.getUserLevel() + ", now(), " + lu.getDivision() + ", " + lu.getDistrict() + ", " + lu.getUpazila() + ", " + lu.getUnion() + ", 0, \n"
                + " '" + lu.getName() + "', '-', " + lu.getDesignation() + ", now(), now(), now(), 1, " + lu.getProvtype() + ", " + lu.getDesignation_provtype() + ", 0);";

        int login_user_sql_ = db.update(login_user_sql);
        System.out.println("login_user_sql: " + login_user_sql_);
        if (login_user_sql_ == 1) {
            String role_sql = "INSERT INTO public.web_userrole(userid, roleid) VALUES ('" + lu.getUSERID() + "', " + lu.getRole() + ");";
            int role_sql_ = db.update(role_sql);
            System.out.println("role_sql: " + role_sql_);
            if (role_sql_ == 1) {
                isCompleted = true;
                db.commit();
                connection.close();
            } else {
                db.rollback();
                connection.close();
            }
        } else {
            db.rollback();
            connection.close();
        }
        return isCompleted;
    }
}
