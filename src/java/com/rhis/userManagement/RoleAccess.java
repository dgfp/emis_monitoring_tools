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
@WebServlet(name = "RoleAccess", urlPatterns = {"/roleAccess"})
public class RoleAccess extends HttpServlet {

      @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            request.setAttribute("submenu", "loginUser");
            request.setAttribute("menu", "MANAGEMENT");
            RequestDispatcher view = request.getRequestDispatcher("WEB-INF/jsp/userManagement/roleAccess.jsp");
            view.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        DBManagerMonitoring db = new DBManagerMonitoring();
        
//-----------------------------------------------------------------------------------View ROle Access--------------------------------------------------------------------------------- 
        if (action.equals("viewRoleAccess")) {
            //For view Super admin role access view Initially 
            String roleId = request.getParameter("roleId").length() == 0 ? "1" : request.getParameter("roleId");

            String query="select r.modrep, r.modreptitle,r.servlet_url, m.modname from public.web_modulereport r inner join public.web_module m on r.modcode=m.modcode where r.visible!=0 order by r.modrep";
            String sql  = "select roleid, rolename from public.web_role order by roleid asc";
            String sql2  = "select roleid, modrep from public.web_roleaccess where roleid="+roleId;
            try {
//                ResultSet result = new DBManagerMonitoring().select(query);
//                ResultSet result2 = new DBManagerMonitoring().select(sql);
//                ResultSet result3 = new DBManagerMonitoring().select(sql2);

                JSONArray json = Convertor.convertResultSetIntoJSON(new DBManagerMonitoring().select(query));
                JSONArray json2 = Convertor.convertResultSetIntoJSON(new DBManagerMonitoring().select(sql));
                JSONArray json3 = Convertor.convertResultSetIntoJSON(new DBManagerMonitoring().select(sql2));
                
                response.setContentType("text/plain;charset=UTF-8");
                response.getWriter().write("{\"moduleReport\":"+json.toString()+",\"role\":"+json2.toString()+",\"roleAccess\":"+json3.toString()+"}");
                
            } catch (Exception ex) {
                ex.getMessage();
            }     
        }
        
        ////-----------------------------------------------------------------------------------update ROle Access--------------------------------------------------------------------------------- 
        if (action.equals("addRoleAccess")) {
            String roleId = request.getParameter("roleId");
            String subMenu = request.getParameter("subMenu");

            //String query="INSERT INTO public.web_roleaccess(roleid, modrep) VALUES ("+roleId+", '"+subMenu+"')";
            String query="insert into public.web_roleaccess(roleid, modrep)values ("+roleId+", "+subMenu+")";
            try {
                DBManagerMonitoring dbinsert = new DBManagerMonitoring();
                dbinsert.update(query);

            } catch (Exception ex) {
                ex.getMessage();

            }
            
        }
        
        ////-----------------------------------------------------------------------------------Delete ROle Access--------------------------------------------------------------------------------- 
        if (action.equals("removeRoleAccess")) {
            String roleId = request.getParameter("roleId");
            String subMenu = request.getParameter("subMenu");
            String query="delete from public.web_roleaccess where roleid="+roleId+" and modrep="+subMenu;
            try {
                db.delete(query);

            }catch (Exception ex) {
                ex.getMessage();
            }
        }
        
    }

}
