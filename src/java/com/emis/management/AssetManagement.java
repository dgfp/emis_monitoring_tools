package com.emis.management;

import com.emis.entity.Asset;
import com.emis.service.AssetService;
import com.emis.utility.Convertor;
import com.emis.utility.Date;
import com.emis.utility.Menu;
import com.emis.utility.Utility;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.rhis.db.DBManagerDistrict;
import com.rhis.db.DBManagerMonitoring;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
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
@WebServlet(name = "AssetManagement", urlPatterns = {"/asset-management"})
public class AssetManagement extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Menu.setMenu("MANAGEMENT", "asset-management", request);
        request.getRequestDispatcher("WEB-INF/jsp/management/AssetManagement.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            DBManagerMonitoring db = new DBManagerMonitoring();
            String sql = "";
            JSONArray jsonData = null;
            response.setContentType("text/plain;charset=UTF-8");

            switch (request.getParameter("action")) {
                case "showData":
                    sql = "SELECT  m.imei1, mo.modelname, d.provname, d.providerid, d.usertype, pt.typename, d.designation, s.statusname, l.locationname, d.receiveddate, d.active\n"
                            + "	,(now()::date - d.receiveddate::date) total_day_used\n"
                            + "	--,(date_part('year',age(now()::date, d.receiveddate::date))::int) used_as_year\n"
                            + "	--,(date_part('month',age(now()::date, d.receiveddate::date))::int) used_as_month\n"
                            + "	--,(date_part('day',age(now()::date, d.receiveddate::date))::int) used_as_day\n"
                            + "	,age(d.receiveddate::date, now()::date)::text duration\n"
                            + "	,(select age(receiveddate::date, now()::date)::text duration from web_asset_distribution_history where imei1=m.imei1 order by receiveddate limit 1) tab_duration\n"
                            + "  FROM public.web_asset_device_master m \n"
                            + "  left join web_asset_distribution_history d using (imei1)\n"
                            + "  left join web_asset_organization o on m.purchasedby = o.organizationid\n"
                            + "  left join web_asset_model mo on m.model::int = mo.modelid \n"
                            + "  left join providertype pt on pt.provtype = d.provtype\n"
                            + "  left join web_asset_status s using(statusid)\n"
                            + "  left join web_asset_location l using(locationid)\n"
                            + "  where (d.active is NULL or d.active=1) " + request.getParameter("where") + " order by provname";
                    //and d.imei1=863768034616902 
                    jsonData = Convertor.convertResultSetIntoJSON(db.select(sql));
                    response.getWriter().write("{\"success\":true,\"data\":" + jsonData.toString() + "}");
                    break;

                case "getStatus":
                    sql = "SELECT * FROM public.web_asset_status";
                    jsonData = Convertor.convertResultSetIntoJSON(db.select(sql));
                    response.getWriter().write("{\"success\":true,\"data\":" + jsonData.toString() + "}");
                    break;

                case "getLocation":
                    sql = "SELECT * FROM public.web_asset_location where statusId=" + request.getParameter("statusId");
                    jsonData = Convertor.convertResultSetIntoJSON(db.select(sql));
                    response.getWriter().write("{\"success\":true,\"data\":" + jsonData.toString() + "}");
                    break;

                case "getProvider":
                    sql = "SELECT providerid, provname FROM public.providerdb where active=1 and divid=" + request.getParameter("divid") + " and zillaid=" + request.getParameter("zillaid") + " and upazilaid=" + request.getParameter("upazilaid") + " and unionid=" + request.getParameter("unionid") + " and provtype=" + request.getParameter("provtype");
                    jsonData = Convertor.convertResultSetIntoJSON(new DBManagerDistrict(Integer.parseInt(request.getParameter("zillaid").toString())).select(sql));
                    response.getWriter().write("{\"success\":true,\"data\":" + jsonData.toString() + "}");
                    break;

                case "addNewDevice":

                    int a = 0,
                     b = 0;

                    Asset asset = new ObjectMapper().readValue(request.getParameter("asset").toString(), Asset.class);

                    System.out.println("asset:" + asset);

                    sql = "SELECT * FROM public.providerdb where providerid=" + asset.getProviderid();
                    ResultSet rs = new DBManagerDistrict(asset.getN_zillaid()).select(sql);
                    while (rs.next()) {
                        asset.setProvname(rs.getString("provname"));
                        asset.setMobileno(rs.getString("mobileno"));
                    }

                    String web_asset_device_master_sql = "INSERT INTO public.web_asset_device_master( imei1, imei2, purchaseddate, warrentyperiod, model, purchasedby, purchaseorderno, simnumber, telcoid,  createdby, modifiedby)\n"
                            + "VALUES (" + asset.getN_imei1() + ", " + asset.getN_imei2() + ", '" + Date.convertToISO(asset.getPurchaseddate()) + "'::date, '" + asset.getWarrentyperiod() + "', '" + asset.getModel() + "', " + asset.getPurchasedby() + ", " + asset.getPurchaseorderno() + ", '" + asset.getSimnumber() + "', " + asset.getTelcoid() + ", '" + Utility.getUserId(request) + "', '" + Utility.getUserId(request) + "' );";

                    String web_asset_distribution_history_sql = "";

                    if (asset.getDistributeDevice() != "") {
                        web_asset_distribution_history_sql = "";
//                        if (asset.getUserType() != 0) {
                        int charger = !asset.getCharger().equals("") ? 1 : 0;
                        int cover = !asset.getCover().equals("") ? 1 : 0;
                        int screenprotector = !asset.getScreenprotector().equals("") ? 1 : 0;
                        int waterproofbag = !asset.getWaterproofbag().equals("") ? 1 : 0;
                        //Provname, designation mobileno
                        //Change date format
                        
                        web_asset_distribution_history_sql = "INSERT INTO public.web_asset_distribution_history(\n"
                                + "            imei1, imei2, receiveddate, simnumber, telcoid, charger, cover, \n"
                                + "            screenprotector, waterproofbag, statusid, locationid,lost_gd, lost_varified, divid, \n"
                                + "            zillaid, upazilaid, unionid, providerid, provtype, \n"
                                + "             active, usertype, createdby, provname, mobileno)\n"
                                + "    VALUES (" + asset.getN_imei1() + ", " + asset.getN_imei2() + ",'" + Date.convertToISO(asset.getReceiveddate()) + "'::date, '" + asset.getSimnumber() + "', " + asset.getTelcoid() + ", " + charger + ", " + cover + "," + screenprotector + "," + waterproofbag
                                + ", " + asset.getN_statusid() + ", " + asset.getN_locationid() + " , '" + asset.getLost_gd() + "'," + asset.getLost_varified() + " ," + asset.getN_divid() + "," + asset.getN_zillaid() + "," + asset.getN_upazilaid() + "," + asset.getN_unionid() + "," + asset.getProviderid()
                                + ", " + asset.getProviderType() + ", 1,  " + asset.getUserType() + ", '" + Utility.getUserId(request) + "', '" + asset.getProvname() + "', " + asset.getMobileno() + ");";
//                        }
                    }

                    DBManagerMonitoring con = new DBManagerMonitoring();
                    con.start();
                    a = con.update(web_asset_device_master_sql);
                    if (a > 0) {
                        b = new DBManagerMonitoring().update(web_asset_distribution_history_sql);
                    }

                    if (a > 0 && b > 0) {
                        con.commit();
                    } else {
                        con.rollback();
                        a = 0;
                        b = 0;
                    }

                    System.out.println("web_asset_device_master_sql: " + web_asset_device_master_sql);
                    System.out.println("web_asset_distribution_history_sql: " + web_asset_distribution_history_sql);

                    jsonData = null;
                    response.getWriter().write("{\"success\":true,\"data\":" + (a + b) + "}");
                    break;

                case "getAddNewDeviceResource":
                    String sql_web_asset_model = "SELECT * FROM public.web_asset_model";
                    String sql_web_asset_organization = "SELECT * FROM public.web_asset_organization";
                    String sql_web_asset_telco = "SELECT * FROM public.web_asset_telco";
                    String sql_web_asset_status = "SELECT * FROM public.web_asset_status";
                    String sql_web_asset_location = "SELECT * FROM public.web_asset_location";

                    JSONArray json_web_asset_model = Convertor.convertResultSetIntoJSON(new DBManagerMonitoring().select(sql_web_asset_model));
                    JSONArray json_web_asset_organization = Convertor.convertResultSetIntoJSON(new DBManagerMonitoring().select(sql_web_asset_organization));
                    JSONArray json_web_asset_telco = Convertor.convertResultSetIntoJSON(new DBManagerMonitoring().select(sql_web_asset_telco));
                    JSONArray json_web_asset_status = Convertor.convertResultSetIntoJSON(new DBManagerMonitoring().select(sql_web_asset_status));
                    JSONArray json_web_asset_location = Convertor.convertResultSetIntoJSON(new DBManagerMonitoring().select(sql_web_asset_location));

                    response.getWriter().write("{\"success\":true,\"model\":" + json_web_asset_model.toString() + ",\"organization\":" + json_web_asset_organization.toString() + ",\"telco\":" + json_web_asset_telco.toString() + ",\"status\":" + json_web_asset_status.toString() + ",\"location\":" + json_web_asset_location.toString() + "}");
                    break;

                case "getAssetDetails":
                    sql = "SELECT m.imei1\n"
                            + "	, m.imei2\n"
                            + "	,mo.modelname\n"
                            + "	,d.provname\n"
                            + "	,d.providerid\n"
                            + "	,d.mobileno\n"
                            + "	,pt.typename\n"
                            + "	,d.designation\n"
                            + "	,d.simnumber\n"
                            + "	,o.name purchaseby\n"
                            + "	,te.telconame\n"
                            + "	,s.statusname\n"
                            + "	,l.locationname\n"
                            + "	,d.receiveddate\n"
                            + "	,m.purchaseddate\n"
                            + "	,o.name purchaseby \n"
                            + "	,age(d.receiveddate::date, now()::date)::text duration\n"
                            + "	,(select age(receiveddate::date, now()::date)::text duration from web_asset_distribution_history where imei1=m.imei1 order by receiveddate limit 1) tab_duration\n"
                            + "	,u.name createdby, charger, cover,  screenprotector, waterproofbag\n"
                            + "FROM public.web_asset_device_master m\n"
                            + "LEFT JOIN web_asset_distribution_history d using (imei1)\n"
                            + "LEFT JOIN web_asset_organization o on m.purchasedby = o.organizationid\n"
                            + "LEFT JOIN web_asset_model mo on m.model::int = mo.modelid\n"
                            + "LEFT JOIN web_asset_telco te on m.telcoid = te.telcoid\n"
                            + "LEFT JOIN web_asset_status s using (statusid)\n"
                            + "LEFT JOIN web_asset_location l using (locationid)\n"
                            + "LEFT JOIN providertype pt on pt.provtype = d.provtype\n"
                            + "LEFT JOIN loginuser u on u.userid = d.createdby\n"
                            + "where m.imei1 = " + request.getParameter("imei") + " and (d.active is NULL or d.active=1)";
                    jsonData = Convertor.convertResultSetIntoJSON(db.select(sql));
                    response.getWriter().write("{\"success\":true,\"data\":" + jsonData.toString() + "}");
                    break;

                case "getAssetHistory":
                    sql = "SELECT m.imei1\n"
                            + "	,mo.modelname\n"
                            + "	,d.provname\n"
                            + "	,d.providerid\n"
                            + "	,d.usertype\n"
                            + "	,pt.typename\n"
                            + "	,d.designation\n"
                            + "	,s.statusname\n"
                            + "	,l.locationname\n"
                            + "	,d.receiveddate\n"
                            + "	,m.purchaseddate\n"
                            + "	,o.name purchaseby \n"
                            + "	,d.active\n"
                            + "	,d.inactivedate\n"
                            + "	,age(d.receiveddate::date, now()::date)::text duration\n"
                            + "	,(select age(receiveddate::date, now()::date)::text duration from web_asset_distribution_history where imei1=m.imei1 order by receiveddate limit 1) tab_duration\n"
                            + "	,age(d.receiveddate::date, d.inactivedate::date)::text inactivedate_duration\n"
                            + "	,u.name createdby\n"
                            + "FROM public.web_asset_device_master m\n"
                            + "LEFT JOIN web_asset_distribution_history d using (imei1)\n"
                            + "LEFT JOIN web_asset_organization o on m.purchasedby = o.organizationid\n"
                            + "LEFT JOIN web_asset_model mo on m.model::int = mo.modelid\n"
                            + "LEFT JOIN providertype pt on pt.provtype = d.provtype\n"
                            + "LEFT JOIN web_asset_status s using (statusid)\n"
                            + "LEFT JOIN web_asset_location l using (locationid)\n"
                            + "LEFT JOIN loginuser u on u.userid = d.createdby\n"
                            + "where m.imei1 = " + request.getParameter("imei") + "\n"
                            + "order by d.receiveddate";
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
