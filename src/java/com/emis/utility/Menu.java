package com.emis.utility;

import com.emis.dao.UserDao;
import com.rhis.db.DBManagerMonitoring;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpServletRequest;

/**
 *
 * @author shahaz
 */
public class Menu {

    public static ArrayList<Category> loadMenu(HttpServletRequest req) throws Exception {

        ArrayList<Category> categories = new ArrayList<>();
        ArrayList<Category> menuCat = new ArrayList<>();

        try {
            DBManagerMonitoring db = new DBManagerMonitoring();
            String query = "select * from public.web_module order by sorted";
//              String query = "Select * from web_Module order by sorted;";
            ResultSet rs = db.select(query);

            while (rs.next()) {
                Category category = new Category();
                category.setId(rs.getInt(1));
                category.setName(rs.getString(2));
                category.setIcon(rs.getString(3));
                categories.add(category);
            }
            String username = (String) req.getSession(false).getAttribute("username");

            String ignoreUrl = "";
            if (req.getSession(false).getAttribute("district") != null) {
                //
                if (new UserDao().isPaperless(req.getSession(false).getAttribute("district").toString())) {
                    //ignoreUrl = " and servlet_url not in ('" + URL.mis1 + "', '" + URL.mis2 + "', '" + URL.mis4 + "', '" + URL.mis1_approval_manager + "', '" + URL.mis2_approval_manager + "', '"
                            //+ URL.mis4_approval_manager + "', '" + URL.mis1_approval_status + "', '" + URL.mis2_approval_status + "', '" + URL.mis4_approval_status + "') ";
                            System.out.println(getIgnoredUrl(new URL().url));
                    ignoreUrl = getIgnoredUrl(new URL().url);
                } else {
                    //ignoreUrl = " and servlet_url not in ('" + URL.mis1_dgfp + "', '" + URL.mis2_dgfp + "', '" + URL.mis4_dgfp + "', '" + URL.mis1_approval_manager_dgfp + "', '" + URL.mis2_approval_manager_dgfp + "', '"
                            //+ URL.mis4_approval_manager_dgfp + "', '" + URL.mis1_approval_status_dgfp + "', '" + URL.mis2_approval_status_dgfp + "', '" + URL.mis4_approval_status_dgfp + "') ";
                     System.out.println(getIgnoredUrl(new URL().url_dgfp));       
                    ignoreUrl = getIgnoredUrl(new URL().url_dgfp);    
                }
            }

            for (Category category : categories) {
                // System.out.println(category);

                query = "select m.modrep,m.modreptitle,m.servlet_url from public.loginuser u\n"
                        + "inner join public.web_userrole r on u.userid=r.userid\n"
                        + "inner join public.web_roleaccess a on r.roleid=a.roleid\n"
                        + "inner join public.web_modulereport m on a.modrep=m.modrep\n"
                        + "inner join public.web_module md on m.modcode=md.modcode\n"
                        + "where u.userid='" + username + "' and md.modcode='" + category.getId() + "' and m.visible!=0 " + ignoreUrl + " order by m.sorted";
                System.out.println("HHHHH"+query);
//                query = " Select m.modrep,m.modreptitle,m.servlet_url from LoginUser u\n"
//                        + " inner join web_userrole r on u.USERID=r.userid \n"
//                        + " inner join web_roleaccess a on r.roleid=a.roleid \n"
//                        + " inner join web_modulereport m on a.modrep=m.modrep \n"
//                        + " inner join web_module md on m.modcode=md.modcode \n"
//                        + " where u.USERID='" + username + "' and md.modcode='" + category.getId() + "' and m.visible!=0 order by m.sorted ";
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
                System.out.println(category);
//                System.out.println(menuCat);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return menuCat;
    }
    
    public static ArrayList<Category> loadMenuApi(HttpServletRequest req, String userid, String district) throws Exception {

        ArrayList<Category> categories = new ArrayList<>();
        ArrayList<Category> menuCat = new ArrayList<>();

        try {
            DBManagerMonitoring db = new DBManagerMonitoring();
            String query = "select * from public.web_module order by sorted";
//              String query = "Select * from web_Module order by sorted;";
            ResultSet rs = db.select(query);

            while (rs.next()) {
                Category category = new Category();
                category.setId(rs.getInt(1));
                category.setName(rs.getString(2));
                category.setIcon(rs.getString(3));
                categories.add(category);
            }
            String username = userid;

            String ignoreUrl = "";
            if (district != null) {
                //
                if (new UserDao().isPaperless(district)) {
                    //ignoreUrl = " and servlet_url not in ('" + URL.mis1 + "', '" + URL.mis2 + "', '" + URL.mis4 + "', '" + URL.mis1_approval_manager + "', '" + URL.mis2_approval_manager + "', '"
                            //+ URL.mis4_approval_manager + "', '" + URL.mis1_approval_status + "', '" + URL.mis2_approval_status + "', '" + URL.mis4_approval_status + "') ";
                            System.out.println(getIgnoredUrl(new URL().url));
                    ignoreUrl = getIgnoredUrl(new URL().url);
                } else {
                    //ignoreUrl = " and servlet_url not in ('" + URL.mis1_dgfp + "', '" + URL.mis2_dgfp + "', '" + URL.mis4_dgfp + "', '" + URL.mis1_approval_manager_dgfp + "', '" + URL.mis2_approval_manager_dgfp + "', '"
                            //+ URL.mis4_approval_manager_dgfp + "', '" + URL.mis1_approval_status_dgfp + "', '" + URL.mis2_approval_status_dgfp + "', '" + URL.mis4_approval_status_dgfp + "') ";
//                     System.out.println(getIgnoredUrl(new URL().url_dgfp));       
//                    ignoreUrl = getIgnoredUrl(new URL().url_dgfp);
                    System.out.println(getIgnoredUrl(new URL().url));
                    ignoreUrl = getIgnoredUrl(new URL().url);
                }
            }

            for (Category category : categories) {
                // System.out.println(category);

                query = "select m.modrep,m.modreptitle,m.servlet_url from public.loginuser u\n"
                        + "inner join public.web_userrole r on u.userid=r.userid\n"
                        + "inner join public.web_roleaccess a on r.roleid=a.roleid\n"
                        + "inner join public.web_modulereport m on a.modrep=m.modrep\n"
                        + "inner join public.web_module md on m.modcode=md.modcode\n"
                        + "where u.userid='" + username + "' and md.modcode='" + category.getId() + "' and m.visible!=0 " + ignoreUrl + " order by m.sorted";
                
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
//                System.out.println(category);
//                System.out.println(menuCat);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return menuCat;
    }

    public static void setMenu(String menu, String subMenu, HttpServletRequest request) {
        request.setAttribute("submenu", subMenu);
        request.setAttribute("menu", menu);
    }

    private static String getIgnoredUrl(List<String> urls) {
        String ignoreUrl = "";
        for (String url : urls) {
            ignoreUrl += "'" + url + "',";
        }
        return ignoreUrl = " and servlet_url not in (" + ignoreUrl.substring(0, ignoreUrl.length() - 1) + ") ";
    }
}