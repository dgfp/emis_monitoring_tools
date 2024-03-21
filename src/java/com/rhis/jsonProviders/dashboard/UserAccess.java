package com.rhis.jsonProviders.dashboard;

import com.emis.dao.UserDao;
import com.emis.utility.Category;
import com.emis.utility.Convertor;
import com.emis.utility.Item;
import com.emis.utility.Menu;
import com.emis.utility.URL;
import com.emis.utility.Utility;
import com.rhis.db.DBManagerMonitoring;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.json.JSONArray;

/**
 *
 * @author Helal
 */
@WebServlet(name = "UserAccess", urlPatterns = {"/api/user-access"})
public class UserAccess extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        try {
            String id = "";
            String district = "";
            HttpSession session = request.getSession();
            
            id = (String) session.getAttribute("username");
            district = (String) session.getAttribute("district");
                    
            if (id == null) {
                id = request.getParameter("userid");
            }
            
//            if (district == null) {
//                district = request.getParameter("district").toString();
//            }

            String sql = "SELECT lu.userid, ur.roleid, m.modcode, modname, icon, mr.modrep, modreptitle, servlet_url\n" +
                            "FROM public.loginuser lu\n" +
                            "left join web_userrole ur on lu.userid = ur.userid\n" +
                            "left join web_roleaccess ra on ur.roleid = ra.roleid\n" +
                            "left join web_modulereport mr on ra.modrep = mr.modrep\n" +
                            "left join web_module m on mr.modcode = m.modcode\n" +
                            "where lu.userid ='"+id+"' and visible=1 order by m.sorted, mr.sorted";
            System.out.println("UserAccess - GET" + sql);
            DBManagerMonitoring db = new DBManagerMonitoring();
            ResultSet result = db.select(sql);
            
            ArrayList<Category> menus = Menu.loadMenuApi(request, id, district);
//            System.out.println(menus);
            JSONArray json = new JSONArray(menus);
            response.setContentType("text/plain;charset=UTF-8");
            response.getWriter().write(json.toString());

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write(new Utility().errorResponse());
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        ArrayList<Category> categories = new ArrayList<>();
        ArrayList<Category> menuCat = new ArrayList<>();

        try {
            DBManagerMonitoring db = new DBManagerMonitoring();
            String query = "select * from public.web_module order by sorted";
            ResultSet rs = db.select(query);

            while (rs.next()) {
                Category category = new Category();
                category.setId(rs.getInt(1));
                category.setName(rs.getString(2));
                category.setIcon(rs.getString(3));
                categories.add(category);
            }
            String username = (String) request.getSession(false).getAttribute("username");

            for (Category category : categories) {
                // System.out.println(category);

                query = "select m.modrep,m.modreptitle,m.servlet_url from public.loginuser u\n"
                        + "inner join public.web_userrole r on u.userid=r.userid\n"
                        + "inner join public.web_roleaccess a on r.roleid=a.roleid\n"
                        + "inner join public.web_modulereport m on a.modrep=m.modrep\n"
                        + "inner join public.web_module md on m.modcode=md.modcode\n"
                        + "where u.userid='" + username + "' and md.modcode='" + category.getId() + "' and m.visible!=0 order by m.sorted";

                db = new DBManagerMonitoring();
                rs = db.select(query);

                ArrayList<Item> items = new ArrayList<>();

                while (rs.next()) {
                    Item item = new Item();
                    item.setId(rs.getInt(1));
                    item.setName(rs.getString(2));
                    item.setUrl(rs.getString(3));
                    items.add(item);
                }
                category.setItems(items);
            }
            for (Category category : categories) {
                if (category.items.size() > 0) {
                    menuCat.add(category);
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        response.setContentType("text/plain;charset=UTF-8");
        response.getWriter().write(menuCat.toString());

    }
}
