package com.emis.management;

import com.emis.utility.Convertor;
import com.emis.utility.Utility;
import com.rhis.db.DBManagerDistrict;
import com.rhis.db.DBManagerMonitoring;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.JSONArray;

/**
 * INSERT INTO public.web_modulereport ( modcode, modrep,
 * modreptitle,servlet_url, visible, sorted) VALUES (9, 920, 'Provider DB
 * Status', 'ProviderDB_STATUS', 1, 0);
 *
 * INSERT INTO public.web_roleaccess (roleid, modrep) VALUES (1, 920);
 *
 * @author Rangan
 */
@WebServlet(name = "ProviderDB_STATUS", urlPatterns = {"/ProviderDB_STATUS"})
public class ProviderDB_STATUS extends HttpServlet {

    DBManagerMonitoring db = null;

    private String getResultSet(String query) {
        ResultSet result = db.select(query);
        JSONArray json = new JSONArray();
        try {
            json = Convertor.toJSON(result);
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        }
        return json.toString();
    }

    private String executeSelect(String query, String districtId) {
        db = new DBManagerDistrict(Integer.parseInt(districtId));
        System.out.println("getURL: " + db.getURL());
        return getResultSet(query);
    }

    private String executeSelect(String query) {
        db = new DBManagerMonitoring();
        return getResultSet(query);

    }

    private static String[] OLD_DISTRICTS = new String[]{"93", "36", "51", "75"};

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = Utility.getParam("action", "", request);
        String zillaid = Utility.getParam("zillaid", "0", request);
        String providerid = Utility.getParam("providerid", "0", request);

        if (action.equals("login_history")) {
            String query = "SELECT distinct providerid, modifydate login_time, (now()::date-modifydate::date) day_diff \n"
                    + ", modifydate::date - LAG(modifydate::date, 1) OVER (PARTITION BY providerid ORDER BY  modifydate) AS day_lag \n"
                    + "FROM lastloginforproviders \n"
                    + "JOIN providerdb_vw v USING(providerid)\n"
                    + "WHERE providerid=" + providerid + " \n"
                    + "ORDER BY providerid,modifydate DESC LIMIT 10";

            System.out.println("Query: " + query);
            String jsonString = executeSelect(query, zillaid);
            response.setContentType("text/plain;charset=UTF-8");
            response.getWriter().write(jsonString);
        } else {
            request.setAttribute("submenu", "ProviderDB_STATUS");
            request.setAttribute("menu", "MANAGEMENT");
            RequestDispatcher view = request.getRequestDispatcher("WEB-INF/jsp/management/providerdb_status.jsp");
            view.forward(request, response);
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        String divid = request.getParameter("divid");
        String zillaid = request.getParameter("zillaid");
        String zillaid_db = zillaid;
        String provtype = request.getParameter("provtype");
        //String providerid = request.getParameter("providerid");
        String condition = "";
        String provtypes = (!provtype.isEmpty() ? provtype : "2,3");

        if (!zillaid.isEmpty()) {
//            if(Utility.contains(OLD_DISTRICTS, zillaid_db)){
//                zillaid_db +="0";
//            }
            condition += " WHERE zillaid = " + zillaid;
        }

        System.out.println("zillaid_db: " + zillaid_db);

        //------------------------For Show Data --------------------------------------------------------------------------------------------
        if (action.equalsIgnoreCase("showsummary")) {
            String query = "select * from web_provider_db_summary('{" + provtypes + "}'::int[]);";
            System.out.println("Query: " + query);
            String jsonString = executeSelect(query, zillaid_db);
            //String jsonString = executeSelect(query);
            response.setContentType("text/plain;charset=UTF-8");
            response.getWriter().write(jsonString);
        }

        if (action.equalsIgnoreCase("showdata")) {

            String upazilaid = request.getParameter("upazilaid");
            String unionid = request.getParameter("unionid");

            if (!upazilaid.isEmpty()) {
                condition += " AND upazilaid = " + upazilaid;
            }

            if (!unionid.isEmpty()) {
                condition += " AND unionid = " + unionid;
            }

            if (!unionid.isEmpty()) {
                condition += " AND unionid = " + unionid;
            }

            condition += " AND provtype IN (" + provtypes + ") ";

            // String query = "select * from provider_db_status " + condition + " order by provname asc";
            String query = "select p.*,t.last_login_time,t.last_login \n"
                    + "from provider_db_status p\n"
                    + "left join (select providerid,max(modifydate) last_login_time,(now()::date-max(modifydate)::date) last_login from lastloginforproviders group by providerid) t using(providerid)\n"
                    + condition
                    + "order by provtype,provname asc";

            //System.out.println("Query: " + query);
            String jsonString = executeSelect(query, zillaid_db);
            //System.out.println("data: " + jsonString);
            //String jsonString = executeSelect(query);
            response.setContentType("text/plain;charset=UTF-8");
            response.getWriter().write(jsonString);

        }
    }
}
