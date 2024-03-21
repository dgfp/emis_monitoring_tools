package com.rhis.userManagement;

import com.emis.utility.Convertor;
import com.rhis.db.DBManagerMonitoring;
import java.io.IOException;
import java.sql.ResultSet;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.JSONArray;

/**
 *
 * @author Helal
 */
@WebServlet(name = "UserRole", urlPatterns = {"/userRole"})
public class UserRole extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
            request.setAttribute("submenu", "loginUser");
            request.setAttribute("menu", "MANAGEMENT");
            RequestDispatcher view = request.getRequestDispatcher("WEB-INF/jsp/userManagement/_userRole.jsp");
            view.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
          DBManagerMonitoring db = new DBManagerMonitoring();
          String action = request.getParameter("action");
        
//-----------------------------------------------------------------------------------View User Role--------------------------------------------------------------------------------- 
        if (action.equals("viewUserRole")) {
            //String query  = "SELECT  u.userid, r.rolename, l.name FROM public.web_userrole u inner join public.loginuser l on l.userid=u.userid  inner join public.web_role r on u.roleid=r.roleid";
            String query="SELECT u.userid, r.rolename,l.name FROM public.web_userrole u\n" +
                        "inner join public.loginuser l on l.userid=u.userid\n" +
                        "inner join public.web_role r on u.roleid=r.roleid";
            
            String sql  = "SELECT roleid, rolename FROM public.web_role";
            
            String sql2  = "SELECT userid, uname, name  FROM public.loginuser left join web_userrole ur using(userid)  where  ur.userid is null";

            try {
              
                ResultSet result = db.select(query);
                
                DBManagerMonitoring db2 = new DBManagerMonitoring();
                ResultSet result2 = db2.select(sql);
                
                DBManagerMonitoring db3 = new DBManagerMonitoring();
                ResultSet result3 = db3.select(sql2);
                
                
                
                JSONArray json = Convertor.convertResultSetIntoJSON(result);
                JSONArray json2 = Convertor.convertResultSetIntoJSON(result2);
                JSONArray json3 = Convertor.convertResultSetIntoJSON(result3);
                
                response.setContentType("text/plain;charset=UTF-8");
                
                response.getWriter().write("{\"userRole\":"+json.toString()+",\"role\":"+json2.toString()+",\"user\":"+json3.toString()+"}");
               
            } catch (Exception ex) {
                ex.getMessage();
            }
            
        }
        
        
//-----------------------------------------------------------------------------------Add User to role--------------------------------------------------------------------------------- 
        if (action.equals("addUserToRole")) {

            String roleId = request.getParameter("roleId");
            String userId = request.getParameter("userId");

            DBManagerMonitoring dba = new DBManagerMonitoring();
            String sql="INSERT INTO public.web_userrole(userid, roleid) VALUES ('"+userId+"',"+roleId+")";
            
            try {
                dba.update(sql);
                
            } catch (Exception ex) {
                ex.getMessage();
            }
        }
        
//-----------------------------------------------------------------------------------Edit  User to role--------------------------------------------------------------------------------- 
        if (action.equals("editUserRole")) {
                String editUserId = request.getParameter("editUserId");
                String editUserRole = request.getParameter("editUserRole");
            
                String query="UPDATE public.web_userrole SET roleid="+editUserRole+", modifydate=now() WHERE userid='"+editUserId+"'";
                try {
                    db.update(query);

                } catch (Exception ex) {
                    ex.getMessage();

            }
            
        }
        

//-----------------------------------------------------------------------------------Delete User--------------------------------------------------------------------------------- 
        if (action.equals("deleteUserRole")) {
                String username = request.getParameter("username");
            
                String query="DELETE FROM public.web_userrole WHERE userid='"+username+"'";

                try {
                    db.delete(query);

                } catch (Exception ex) {
                    ex.getMessage();
            }
        }

    }
    
}
