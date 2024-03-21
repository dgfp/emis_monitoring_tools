package com.emis.management;

import com.emis.utility.Convertor;
import com.emis.utility.Menu;
import com.emis.utility.Utility;
import com.rhis.db.DBManagerMonitoring;
import java.io.IOException;
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
@WebServlet(name = "AssetReports", urlPatterns = {"/asset-reports"})
public class AssetReports extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Menu.setMenu("MANAGEMENT", "asset-management", request);
        request.getRequestDispatcher("WEB-INF/jsp/management/AssetReports.jsp").forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            DBManagerMonitoring db = new DBManagerMonitoring();
            String sql = "";
            JSONArray jsonData = null;
            response.setContentType("text/plain;charset=UTF-8");

            switch (request.getParameter("action")) {
                case "getStatus":
                    sql = "select count(*) as total_asset\n"
                            + ",count(*) filter(where d.statusid=1) as functional\n"
                            + ",count(*) filter(where d.statusid=1 and d.locationid=1 ) as functional_user\n"
                            + ",count(*) filter(where d.statusid=1 and d.locationid=2 ) as functional_central_store\n"
                            + ",count(*) filter(where d.statusid=1 and d.locationid=3 ) as functional_local_store\n"
                            + "\n"
                            + ",count(*) filter(where d.statusid=2) as repaired_functional\n"
                            + ",count(*) filter(where d.statusid=2 and d.locationid=4 ) as repaired_functional_user\n"
                            + ",count(*) filter(where d.statusid=2 and d.locationid=5 ) as repaired_functional_central_store\n"
                            + ",count(*) filter(where d.statusid=2 and d.locationid=6 ) as repaired_functional_local_store\n"
                            + "\n"
                            + ",count(*) filter(where d.statusid=3) as non_functional\n"
                            + ",count(*) filter(where d.statusid=3 and d.locationid=7 ) as non_functional_user\n"
                            + ",count(*) filter(where d.statusid=3 and d.locationid=8 ) as non_functional_central_store\n"
                            + ",count(*) filter(where d.statusid=3 and d.locationid=9 ) as non_functional_local_store\n"
                            + ",count(*) filter(where d.statusid=3 and d.locationid=10 ) as non_functional_vendor\n"
                            + "\n"
                            + ",count(*) filter(where d.statusid=4) as damaged\n"
                            + ",count(*) filter(where d.statusid=4 and d.locationid=11 ) as damaged_user\n"
                            + ",count(*) filter(where d.statusid=4 and d.locationid=12 ) as damaged_central_store\n"
                            + ",count(*) filter(where d.statusid=4 and d.locationid=13 ) as damaged_local_store\n"
                            + "\n"
                            + ",count(*) filter(where d.statusid=5) as lost\n"
                            + ",count(*) filter(where d.statusid=5 and d.locationid=14 ) as lost_from_user\n"
                            + ",count(*) filter(where d.statusid=5 and d.locationid=15 ) as lost_from_central_store\n"
                            + ",count(*) filter(where d.statusid=5 and d.locationid=16 ) as lost_from_local_store\n"
                            + "\n"
                            + "FROM public.web_asset_device_master m \n"
                            + "join web_asset_distribution_history d using (imei1)\n"
                            + "where d.active = 1 " + request.getParameter("where");
                    jsonData = Convertor.convertResultSetIntoJSON(db.select(sql));
                    response.getWriter().write("{\"success\":true,\"data\":" + jsonData.toString() + "}");
                    break;

                case "getStatuss":
                    sql = "SELECT * FROM public.web_asset_status";
                    jsonData = Convertor.convertResultSetIntoJSON(db.select(sql));
                    response.getWriter().write("{\"success\":true,\"data\":" + jsonData.toString() + "}");
                    break;

                default:
                    response.getWriter().write(new Utility().errorResponse());
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write(new Utility().errorResponse());
        }
    }

}
