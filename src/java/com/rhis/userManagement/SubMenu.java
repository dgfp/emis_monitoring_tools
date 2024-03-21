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
@WebServlet(name = "SubMenu", urlPatterns = {"/subMenu"})
public class SubMenu extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
            request.setAttribute("submenu", "loginUser");
            request.setAttribute("menu", "MANAGEMENT");
            RequestDispatcher view = request.getRequestDispatcher("WEB-INF/jsp/userManagement/subMenu.jsp");
            view.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        DBManagerMonitoring db = new DBManagerMonitoring();
        
//-----------------------------------------------------------------------------------View User--------------------------------------------------------------------------------- 
        if (action.equals("viewSubMenu")) {
            //For sub-menu View
            String query  = "select r.modcode, r.modrep, r.modreptitle, r.servlet_url, r.visible, m.modname \n" +
                                    "from public.web_modulereport r \n" +
                                    "inner join public.web_module m on r.modcode=m.modcode \n" +
                                    "order by  r.modrep;";
            //for load menu dropdown
            
            String sql  = "select modcode, modname from public.web_module;";

            try {
                ResultSet result = db.select(query);
                
                DBManagerMonitoring db2 = new DBManagerMonitoring();
                ResultSet result2 = db2.select(sql);
                
                JSONArray json = Convertor.convertResultSetIntoJSONWithDash(result);
                JSONArray json2 = Convertor.convertResultSetIntoJSON(result2);
                
                response.setContentType("text/plain;charset=UTF-8");
                System.out.println(json.toString());
                System.out.println(json2.toString());
                
                response.getWriter().write("{\"subMenu\":"+json.toString()+",\"menu\":"+json2.toString()+"}");

            } catch (Exception ex) {
                ex.getMessage();
            }   
        }
        
        //-----------------------------------------------------------------------------------Add Sub-Menu--------------------------------------------------------------------------------- 
        if (action.equals("addSubMenu")) {
   
            String modcode = request.getParameter("menu");
            String modreptitle = request.getParameter("subMenu");
            String servlet_url = request.getParameter("url");
            String visible = request.getParameter("visible");
            
            int modrep=0;
            int sorted=0;
            
            String query="select modrep,sorted from public.web_modulereport where modcode='"+modcode+"'  order by sorted desc limit 1";

            try {                
                ResultSet rs = db.select(query);
                
                while (rs.next()) {
                    modrep = rs.getInt("modrep");
                    sorted = rs.getInt("sorted");
                }
                
                sorted++;
                if(modrep==0){
                    modrep=Integer.parseInt(modcode+"01");
                }else{
                    modrep++;
                }
                
                
                //System.out.println("ModCode: "+modcode+" modretitle: "+modreptitle+" url:"+servlet_url+" visible: "+visible+" Modrepcode: "+modRepCode+" sorted: "+sorted);
                String sql="INSERT INTO public.web_modulereport(\n" +
                                "modcode, modrep, modreptitle, servlet_url, visible, sorted)\n" +
                                "VALUES ('"+modcode+"', '"+modrep+"', '"+modreptitle+"', '"+servlet_url+"', "+visible+", "+sorted+");";
                DBManagerMonitoring db2 = new DBManagerMonitoring(); 
                db2.update(sql);
            } catch (Exception ex) {
                ex.printStackTrace();
                ex.getMessage();
            }
        }
        
        //-----------------------------------------------------------------------------------Edit Sub-menu--------------------------------------------------------------------------------- 
        if (action.equals("editSubMenu")) {
            String id = request.getParameter("id");
            String menu = request.getParameter("menu");
            String subMenu = request.getParameter("subMenu");
            String url = request.getParameter("url");
            int visible = Integer.parseInt(request.getParameter("visible"));
            String query=null;
            
            
            query="UPDATE public.web_modulereport SET   modreptitle='"+subMenu+"',  servlet_url='"+url+"', visible="+visible+" , modifydate=now() WHERE modrep="+ Integer.parseInt(id);
            String b =id.substring(0, menu.length());
            //Check whether user want to change sub-menu from a menu  [int l=menu.length();] [String a=id.substring(0, l);]
            if(menu.equals(id.substring(0, menu.length()))){
                query="UPDATE public.web_modulereport SET  modreptitle='"+subMenu+"', servlet_url='"+url+"', visible="+visible+" , modifydate=now() WHERE modrep="+ Integer.parseInt(id);


            }else{

                int modrep=0;
                int sorted=0;

                String deleteQuery="delete from public.web_modulereport where modrep="+ Integer.parseInt(id);
                String getLastSubMenu="select modrep,sorted from public.web_modulereport where modcode='"+menu+"'  order by sorted desc limit 1";


                try {

                    DBManagerMonitoring db2 = new DBManagerMonitoring();
                    DBManagerMonitoring db3 = new DBManagerMonitoring();

                    ResultSet rs = db2.select(getLastSubMenu);
                    db3.delete(deleteQuery);

                    while (rs.next()) {
                        modrep = rs.getInt("modrep");
                        sorted = rs.getInt("sorted");
                    }
                    sorted++;
                    modrep++;

                    query="INSERT INTO public.web_modulereport(\n" +
                                    "modcode, modrep, modreptitle, servlet_url, visible, sorted)\n" +
                                    "VALUES ('"+menu+"', "+modrep+", '"+subMenu+"', '"+url+"', "+visible+", "+sorted+");";
//                        DBManager db3 = new DBManager();  
//                        db3.update(sql);
                } catch (Exception ex) {
                    ex.getMessage();
                }

            }
            
            ///Execute update query
            try {
                db.update(query);
            } catch (Exception ex) {
                ex.getMessage();
            }
        }
        
        //-----------------------------------------------------------------------------------Check Sub-Menu existance --------------------------------------------------------------------------------- 
        if (action.equals("checkSubMenu")) {
            
            String modName = request.getParameter("subMenu");
            String query  ="select count(*) from public.web_modulereport where modreptitle='"+modName+"'";

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
    }
    
}
