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
 * @author Helal | m.helal.k@gmail.com
 */
@WebServlet(name = "Menu", urlPatterns = {"/menu"})
public class Menu extends HttpServlet {

       @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
            request.setAttribute("submenu", "loginUser");
            request.setAttribute("menu", "MANAGEMENT");
            RequestDispatcher view = request.getRequestDispatcher("WEB-INF/jsp/userManagement/menu.jsp");
            view.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
//-----------------------------------------------------------------------------------View Menu--------------------------------------------------------------------------------- 
        if (action.equals("viewMenu")) {
            String query  = "select * from public.web_module order by  sorted;";
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
        
//-----------------------------------------------------------------------------------Add Menu--------------------------------------------------------------------------------- 
        if (action.equals("addMenu")) {
            
            String modName = request.getParameter("modName");
            String icon = request.getParameter("icon");
            String modCode=null;
            int sorted=0;
            
            String query="select modcode,sorted from public.web_module order by sorted desc limit 1"; 
            
            try {
                DBManagerMonitoring db = new DBManagerMonitoring();               
                ResultSet rs = db.select(query);
                
                while (rs.next()) {
                    modCode = rs.getString("ModCode");
                    sorted = rs.getInt("sorted");
                }
                
                int mCode=Integer.parseInt(modCode);
                sorted++;
                mCode++;
                
                String sql="insert into public.web_module(modcode, modname, icon, sorted) values ('"+mCode+"', '"+modName+"', '"+icon+"', "+sorted+");";
                DBManagerMonitoring db2 = new DBManagerMonitoring();
                db2.update(sql);
            } catch (Exception ex) {
                ex.getMessage();
            }
            
            try {
                DBManagerMonitoring db = new DBManagerMonitoring();              
                ResultSet rs = db.select(query);
                
                while (rs.next()) {
                    modCode = rs.getString("ModCode");
                    sorted = rs.getInt("sorted");
                }
            } catch (Exception ex) {
                ex.getMessage();
            }
            
        }
        
        //-----------------------------------------------------------------------------------Edit Menu--------------------------------------------------------------------------------- 
        if (action.equals("editMenu")) {
                String editMenuTitle = request.getParameter("editMenuTitle");
                String editMenuIcon = request.getParameter("editMenuIcon");
                String editMenuId = request.getParameter("editMenuId");
            
                String query="update public.web_module set  modname='"+editMenuTitle+"', modifydate=now(), icon='"+editMenuIcon+"' where modcode='"+editMenuId+"'";

                try {
                    DBManagerMonitoring db = new DBManagerMonitoring();
                    db.update(query);
                } catch (Exception ex) {
                    ex.getMessage();
                }
        }
        
        //-----------------------------------------------------------------------------------Check Menu existance --------------------------------------------------------------------------------- 
        if (action.equals("checkModName")) {
            
            String modName = request.getParameter("modName");
            String query  ="select count(*) from public.web_module where modname='"+modName+"';";

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
