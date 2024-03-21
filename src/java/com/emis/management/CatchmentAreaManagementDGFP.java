package com.emis.management;

import com.emis.utility.Convertor;
import com.emis.utility.Menu;
import com.emis.utility.Utility;
import com.rhis.db.DBManagerDistrict;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.JSONArray;
import com.emis.dao.ProviderManagement.ProviderManagement;
import com.emis.dao.ReportingGeoDao;
import com.emis.utility.Print;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.HttpSession;
import org.json.JSONException;

/**
 *
 * @author Helal
 */
@WebServlet(name = "CatchmentAreaManagementDGFP", urlPatterns = {"/catchment-area-management-dgfp"})
public class CatchmentAreaManagementDGFP extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String divisionid = request.getParameter("divisionid");
        String zillaid = request.getParameter("zillaid");
        String upazilaid = request.getParameter("upazilaid");
        String unionid = request.getParameter("unionid");
        String targetModal = request.getParameter("targetModal");
        //String userLevel = session.getAttribute("userLevel").toString();
/*
        if (divisionid != null && zillaid != null && upazilaid != null && unionid != null && targetModal != null) {
            session.setAttribute("division", divisionid);
            session.setAttribute("district", zillaid);
            session.setAttribute("upazila", upazilaid);
            session.setAttribute("union", unionid);
            session.setAttribute("targetModal", targetModal);
            //session.setAttribute("userLevel", "7");
            System.out.println(targetModal);
            System.out.println("Ready for redirect response");

        } else {
            System.out.println("Not ready for redirect response");
        }*/

        Menu.setMenu("MANAGEMENT", "catchment-area-management-dgfp", request);
        request.getRequestDispatcher("WEB-INF/jsp/management/CatchmentAreaManagementDGFP.jsp").forward(request, response);
        //session.setAttribute("userLevel", userLevel);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String action = request.getParameter("action");
        String query = "";
        String districtid = request.getParameter("districtid");
        String upazilaid = request.getParameter("upazilaid");
        String unionid = request.getParameter("unionid");
        if (action.equalsIgnoreCase("addVillage")) {
            try {
                String mouzaid = request.getParameter("mouzaid");
                //String villageid = request.getParameter("villageid");
                String villagenameeng = request.getParameter("villagenameeng");
                String villagename = request.getParameter("villagename");
                String villageid = new ProviderManagement(this.toInt(districtid)).getVillageId(this.toInt(districtid), this.toInt(upazilaid), this.toInt(unionid), this.toInt(mouzaid)) + "";
                
                Print.o(villageid);

                query = "INSERT INTO village(zillaid, upazilaid, unionid, mouzaid, villageid, rmo, villagenameeng,  villagename) \n"
                        + "VALUES (" + districtid + ", " + upazilaid + ", " + unionid + ", " + mouzaid + ", " + villageid + ", '2', '" + villagenameeng + "', \n"
                        + " '" + villagename + "');";
                
                String village_create_history = "INSERT INTO public.village_create_history(zillaid, upazilaid, unionid, mouzaid, villageid, created_by, systementrydate, modifydate)\n" +
                                                        "VALUES (" + districtid + ", " + upazilaid + ", " + unionid + ", " + mouzaid + ", " + villageid + ", " + Utility.getUserId(request) + ",now(), now());"; 

                DBManagerDistrict db2 = new DBManagerDistrict(Integer.parseInt(districtid));
                int rowCount = db2.update(query);
                int rowCount_village_create_history = new DBManagerDistrict(Integer.parseInt(districtid)).update(village_create_history);
                response.setContentType("text/plain;charset=UTF-8");
                response.getWriter().write(rowCount + "");
            } catch (Exception ex) {
                ex.printStackTrace();
                response.getWriter().write(new Utility().errorResponse());
            }

        } else if (action.equalsIgnoreCase("editVillage")) {
            String mouzaid = request.getParameter("mouzaid");
            String villageid = request.getParameter("villageid");
            String mouzanameeng = request.getParameter("mouzanameeng");
            String mouzaname = request.getParameter("mouzaname");
            String villagenameeng = request.getParameter("villagenameeng");
            String villagename = request.getParameter("villagename");

            query = " WHERE zillaid = " + districtid + " AND upazilaid = " + upazilaid + " AND unionid = " + unionid + " AND mouzaid = " + mouzaid;
            String queryMouza = "UPDATE mouza SET modifydate=now(), mouzanameeng='" + mouzanameeng + "' , mouzaname='" + mouzaname + "'" + query + " ;";
            String queryVillage = "UPDATE village SET modifydate=now(), villagenameeng='" + villagenameeng + "' ,  villagename='" + villagename + "'" + query + " AND villageid = " + villageid + " ;";

            int rowCount = 0;
            DBManagerDistrict db2 = new DBManagerDistrict(Integer.parseInt(districtid));
            rowCount = db2.update(queryMouza);

            DBManagerDistrict db3 = new DBManagerDistrict(Integer.parseInt(districtid));
            rowCount = db3.update(queryVillage);

            response.setContentType("text/plain;charset=UTF-8");
            response.getWriter().write(rowCount + "");

        } else if (action.equalsIgnoreCase("deleteVillage")) {

            String mouzaid = request.getParameter("mouzaid");
            String villageid = request.getParameter("villageid");
            response.setContentType("text/plain;charset=UTF-8");
            try {
                if (!new ReportingGeoDao(Integer.parseInt(districtid)).checkDataUnderVillage(Integer.parseInt(districtid), Integer.parseInt(upazilaid), Integer.parseInt(unionid), Integer.parseInt(mouzaid), Integer.parseInt(villageid))) {
                    query = "DELETE FROM village WHERE zillaid = " + districtid + " and upazilaid = " + upazilaid + " and unionid = " + unionid + " and mouzaid = " + mouzaid + " and villageid = " + villageid + " ;";
                    DBManagerDistrict db2 = new DBManagerDistrict(Integer.parseInt(districtid));
                    int rowCount = db2.update(query);
                    response.getWriter().write("{\"success\":\"success\", \"message\":\"Village delete successfully\"}");
                } else {
                    response.getWriter().write("{\"success\":\"error\", \"message\":\"Can't delete, this village has data\"}");
                }
            } catch (Exception ex) {
                ex.printStackTrace();
                response.getWriter().write(new Utility().errorResponse());
            }
        } else if (action.equalsIgnoreCase("addMouza")) {

            String mouzaid = request.getParameter("mouzaid");
            String mouzaname = request.getParameter("mouzaname");
            String mouzanameeng = request.getParameter("mouzanameeng");

            query = "INSERT INTO mouza(\n"
                    + "            zillaid, upazilaid, unionid, mouzaid, rmo, mouzanameeng, \n"
                    + "            mouzaname)\n"
                    + "    VALUES (" + districtid + "," + upazilaid + "," + unionid + "," + mouzaid + ",'1','" + mouzanameeng + "', \n"
                    + "            '" + mouzaname + "');";

            DBManagerDistrict db2 = new DBManagerDistrict(Integer.parseInt(districtid));
            int rowCount = db2.update(query);
            response.setContentType("text/plain;charset=UTF-8");
            response.getWriter().write(rowCount + "");

        } else if (action.equalsIgnoreCase("showVillage")) {
            query = "select m.mouzaid,m.mouzanameeng,m.mouzaname,v.villageid,v.villagenameeng,v.villagename \n"
                    + "from mouza m, village v \n"
                    + "where m.mouzaid=v.mouzaid \n"
                    + "and m.zillaid=v.zillaid \n"
                    + "and m.upazilaid=v.upazilaid \n"
                    + "and m.unionid=v.unionid \n"
                    + "\n and m.zillaid = " + districtid
                    + "\n and  m.upazilaid = " + upazilaid
                    + "\n and m.unionid = " + unionid + " ;";

            try {
                DBManagerDistrict db = new DBManagerDistrict(Integer.parseInt(districtid));
                ResultSet result = db.select(query);
                JSONArray json = Convertor.convertResultSetIntoJSON(result);
                response.setContentType("text/plain;charset=UTF-8");
                System.out.println(json.toString());
                response.getWriter().write(json.toString());
            } catch (Exception ex) {
                ex.getMessage();
            }
        } else if (action.equalsIgnoreCase("getMouzaList")) {
            try {
                response.getWriter().write(new ProviderManagement(this.toInt(districtid)).getMouzaList(this.toInt(districtid), this.toInt(upazilaid), this.toInt(unionid)).toString());
            } catch (Exception ex) {
                ex.printStackTrace();
                response.getWriter().write(new Utility().errorResponse());
            }
        }
    }

    private int toInt(String num) {
        return Integer.parseInt(num);
    }
}
