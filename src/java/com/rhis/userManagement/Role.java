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
@WebServlet(name = "Role", urlPatterns = {"/role"})
public class Role extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
            request.setAttribute("submenu", "loginUser");
            request.setAttribute("menu", "MANAGEMENT");
            RequestDispatcher view = request.getRequestDispatcher("WEB-INF/jsp/userManagement/role.jsp");
            view.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        DBManagerMonitoring db = new DBManagerMonitoring();
        
//-----------------------------------------------------------------------------------View Role--------------------------------------------------------------------------------- 
        if (action.equals("viewRole")) {
            
            String query  = "select roleid, rolename from public.web_role";
            
            try {
                ResultSet result = db.select(query);
                
                JSONArray json = Convertor.convertResultSetIntoJSON(result);
                response.setContentType("text/plain;charset=UTF-8");
                
                System.out.println(json.toString());
                response.getWriter().write(json.toString());
                
            } catch (Exception ex) {
                ex.getMessage();
            }
        }
        
//-----------------------------------------------------------------------------------Add Role--------------------------------------------------------------------------------- 
        if (action.equals("addRole")) {
            
            String roleName = request.getParameter("roleName");
            
            try {
                String sql="select count(*) as id from public.web_role";
               ResultSet result = db.select(sql);
                int i = 0;
                
                while(result.next()) {
                    i = result.getInt("id");
                }
                i++;
                DBManagerMonitoring db2 = new DBManagerMonitoring();
                String query="insert into public.web_role(roleid, rolename) values ("+i+", '"+roleName+"')";
                db2.update(query);
                
            } catch (Exception ex) {
                ex.getMessage();
            }

        }
        
        
////-----------------------------------------------------------------------------------Delete Role--------------------------------------------------------------------------------- 
        if (action.equals("deleteRole")) {
            String deleteRoleId = request.getParameter("deleteRoleId");
            String sql = "DELETE FROM public.web_roleaccess where roleid = "+deleteRoleId;
            String query="delete from public.web_role where roleid="+deleteRoleId;

            try {
                db.delete(sql);
                DBManagerMonitoring db2 = new DBManagerMonitoring();
                db2.delete(query);

            } catch (Exception ex) {
                ex.getMessage();

            }
        }
        
////-----------------------------------------------------------------------------------Update User--------------------------------------------------------------------------------- 
        if (action.equals("editRole")) {
            String editRoleName = request.getParameter("editRoleName");
            String editRoleId = request.getParameter("editRoleId");

            String query="update public.web_role set rolename='"+editRoleName+"', modifydate=now() where roleid="+editRoleId;

            try {
                db.update(query);

            } catch (Exception ex) {
                ex.getMessage();
            }
        }
 
    }

}
