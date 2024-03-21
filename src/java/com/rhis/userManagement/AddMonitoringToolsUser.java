package com.rhis.userManagement;

import com.emis.utility.Convertor;
import com.rhis.db.DBManagerMonitoring;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.time.format.DateTimeFormatter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.JSONArray;
import java.time.LocalDateTime;
import java.util.Date;

/**
 *
 * @author Helal
 */
@WebServlet(name = "MonitoringToolsUser", urlPatterns = {"/monitoring-tools-user"})
public class AddMonitoringToolsUser extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("submenu", "loginUser");
        request.setAttribute("menu", "MANAGEMENT");
        RequestDispatcher view = request.getRequestDispatcher("WEB-INF/jsp/userManagement/addMonitoringToolsUser.jsp");
        view.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        //Get Current date time
        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");
        LocalDateTime now = LocalDateTime.now();
        String dateTimeNow = dtf.format(now);

//-----------------------------------------------------------------------------------View User--------------------------------------------------------------------------------- 
        if (action.equals("viewLoginUser")) {
            String query = "select * from public.loginuser l\n"
                    + "inner join public.codelist c on l.userlevel=c.code\n"
                    + "left join public.web_userrole ur on l.userid=ur.userid\n"
                    + "left join public.web_role r on ur.roleid=r.roleid\n"
                    + "left join public.web_userdesignation d on l.designation=d.id\n"
                    + "where c.typename='UserLevel' order by  name asc";
            String sql = "select code, cname from public.codelist where typename='UserLevel' order by code";
            String sql_role = "select roleid, rolename from web_role order by roleid";

            try {
                JSONArray user = Convertor.convertResultSetIntoJSONWithDash(new DBManagerMonitoring().select(query));
                JSONArray user_level = Convertor.convertResultSetIntoJSON(new DBManagerMonitoring().select(sql));
                JSONArray user_role = Convertor.convertResultSetIntoJSON(new DBManagerMonitoring().select(sql_role));

                response.setContentType("text/plain;charset=UTF-8");
                response.getWriter().write("{\"loginUser\":" + user.toString() + ",\"userType\":" + user_level.toString() + ",\"userRole\":" + user_role.toString() + "}");

            } catch (Exception ex) {
                ex.getMessage();
            }
        }

//-----------------------------------------------------------------------------------Add User--------------------------------------------------------------------------------- 
        if (action.equals("addLoginUser")) {

            String name = request.getParameter("name");
            String username = request.getParameter("username");
            String password = request.getParameter("password");

            String email = request.getParameter("email").equals("") ? "-" : request.getParameter("email");

            String designation = request.getParameter("designation");

            String division = request.getParameter("division") == null ? "" : request.getParameter("division");
            String district = request.getParameter("district") == null ? "" : request.getParameter("district");
            String upazila = request.getParameter("upazila") == null ? "" : request.getParameter("upazila");
            String union = request.getParameter("union") == null ? "" : request.getParameter("union");
            String village = request.getParameter("village") == null ? "" : request.getParameter("village");

            String isActive = request.getParameter("isActive");
            String userLevel = request.getParameter("userLevel");

//            String query="INSERT INTO public.\"LoginUser\"(\"Cluster\", \"USERID\", \"UNAME\", \"PASS\", \"Active\", \"ADMIN\", \"UserLevel\", \"CreDate\",\"Division\", \"District\", \"Upazila\", \"Union\", \"Village\", \"NAME\", \"Email\", \"Designation\")\n" +
//                                    "VALUES ('*', '"+username+"', '"+username+"', '"+password+"', '"+isActive+"', '1', '"+userLevel+"', '"+date+"', '"+division+"', '"+district+"', '"+upazila+"', '"+union+"', '"+village+"', '"+name+"', '"+email+"', "+designation+")";
//            
            String query = "insert into public.loginuser(\n"
                    + "cluster, userid, uname, pass, active, admin, userlevel, credate, divid, zillaid, upazilaid, \n"
                    + "unionid, villageid, name, email, designation)\n"
                    + "values ('*', '" + username + "', '" + username + "', '" + password + "', " + isActive + ", 1, " + userLevel + ", '" + dateTimeNow + "', " + division + ", " + district + ", " + upazila + ", " + union + ", " + village + ", '" + name + "', '" + email + "', " + designation + ");";

            //insert null area for central level user.
            if (userLevel.equals("1")) {
                query = "insert into public.loginuser(\n"
                        + "cluster, userid, uname, pass, active, admin, userlevel, credate, name, email, designation)\n"
                        + "values ('*', '" + username + "', '" + username + "', '" + password + "', " + isActive + ", 1, " + userLevel + ", '" + dateTimeNow + "', '" + name + "', '" + email + "', " + designation + ");";

            }

            try {
                DBManagerMonitoring db = new DBManagerMonitoring();
                db.update(query);

            } catch (Exception ex) {
                ex.getMessage();
            }

        }

//-----------------------------------------------------------------------------------Delete User--------------------------------------------------------------------------------- 
        if (action.equals("deleteLoginUser")) {
            String userId = request.getParameter("userId");
            String username = request.getParameter("userName");

            String query = "delete from public.loginuser where uname='" + userId + "'";
            String sql2 = "delete from public.web_userrole where userid='" + username + "'";

            try {
                DBManagerMonitoring db = new DBManagerMonitoring();
                db.delete(query);

                DBManagerMonitoring db4 = new DBManagerMonitoring();
                db4.delete(sql2);

            } catch (Exception ex) {
                ex.getMessage();

            }

        }

//-----------------------------------------------------------------------------------Edit User--------------------------------------------------------------------------------- 
        if (action.equals("editLoginUser")) {
            String isActive = request.getParameter("isActive");
            String userLevel = request.getParameter("userLevel");
            String userId = request.getParameter("userId");
            String query = "update public.loginuser set active ='" + isActive + "', modifydate =now(), userlevel='" + userLevel + "' where uname='" + userId + "'";

            try {
                DBManagerMonitoring db = new DBManagerMonitoring();
                db.update(query);
            } catch (Exception ex) {
                ex.getMessage();
            }
        }

        //-----------------------------------------------------------------------------------Check User existance --------------------------------------------------------------------------------- 
        if (action.equals("checkUsername")) {

            String username = request.getParameter("username");
            String query = "select count(*) from public.loginuser where uname='" + username + "'";

            try {
                DBManagerMonitoring db = new DBManagerMonitoring();

                ResultSet result = db.select(query);

                JSONArray json = Convertor.convertResultSetIntoJSON(result);

                response.setContentType("text/plain;charset=UTF-8");
                System.out.println(json.toString());

                response.getWriter().write(json.toString());

            } catch (Exception ex) {
                ex.getMessage();
            }

        }

    }

}
