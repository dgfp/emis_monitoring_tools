package com.emis.management;

import com.emis.utility.Convertor;
import com.rhis.db.DBManagerDistrict;
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
 * @author shahaz
 */
@WebServlet(name = "VillageSettingsServlet", urlPatterns = {"/village-settings"})
public class VillageSettingsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("submenu", "village-settings");
        request.setAttribute("menu", "MANAGEMENT");
        RequestDispatcher dispatcher = request.getRequestDispatcher("WEB-INF/jsp/management/village_settings_service_module.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        String query = "";
        String districtid = request.getParameter("districtid");
        String upazilaid = request.getParameter("upazilaid");
        String unionid = request.getParameter("unionid");
        if (action.equalsIgnoreCase("addVillage")) {

            String mouzaid = request.getParameter("mouzaid");
            String villageid = request.getParameter("villageid");
            String villagenameeng = request.getParameter("villagenameeng");
            String villagename = request.getParameter("villagename");
            query = "INSERT INTO village(zillaid, upazilaid, unionid, mouzaid, villageid, rmo, villagenameeng,  villagename) \n"
                    + "VALUES (" + districtid + ", " + upazilaid + ", " + unionid + ", " + mouzaid + ", " + villageid + ", '2', '" + villagenameeng + "', \n"
                    + " '" + villagename + "');";

            DBManagerDistrict db2 = new DBManagerDistrict(Integer.parseInt(districtid));
            int rowCount = db2.update(query);
            response.setContentType("text/plain;charset=UTF-8");
            response.getWriter().write(rowCount + "");

        }  else if (action.equalsIgnoreCase("editVillage")) {
            String mouzaid = request.getParameter("mouzaid");
            String villageid = request.getParameter("villageid");
            String mouzanameeng = request.getParameter("mouzanameeng");
            String mouzaname = request.getParameter("mouzaname");
            String villagenameeng = request.getParameter("villagenameeng");
            String villagename = request.getParameter("villagename");
            
            query=" WHERE zillaid = " + districtid  + " AND upazilaid = " + upazilaid + " AND unionid = " + unionid + " AND mouzaid = " + mouzaid;
            String queryMouza = "UPDATE mouza SET modifydate=now(), mouzanameeng='"+mouzanameeng+"' , mouzaname='"+mouzaname + "'" + query+ " ;";
            String queryVillage = "UPDATE village SET modifydate=now(), villagenameeng='"+villagenameeng+"' ,  villagename='"+villagename + "'"+ query + " AND villageid = " + villageid + " ;";
            
             int rowCount=0;
            DBManagerDistrict db2 = new DBManagerDistrict(Integer.parseInt(districtid));
            rowCount = db2.update(queryMouza);
            
            DBManagerDistrict db3 = new DBManagerDistrict(Integer.parseInt(districtid));
            rowCount = db3.update(queryVillage);
            
            response.setContentType("text/plain;charset=UTF-8");
            response.getWriter().write(rowCount + "");

        }  
        else if (action.equalsIgnoreCase("deleteVillage")) {
            String mouzaid = request.getParameter("mouzaid");
            String villageid = request.getParameter("villageid");
            query = "DELETE FROM village "
                     + "WHERE zillaid = " + districtid 
                    + " and upazilaid = " + upazilaid 
                    + " and unionid = " + unionid
                    + " and mouzaid = " + mouzaid
                    + " and villageid = " + villageid + " ;";

            DBManagerDistrict db2 = new DBManagerDistrict(Integer.parseInt(districtid));
            int rowCount = db2.update(query);
            response.setContentType("text/plain;charset=UTF-8");
            response.getWriter().write(rowCount + "");

        }  else if (action.equalsIgnoreCase("addMouza")) {

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
        }

    }

}

/*
 INSERT INTO village(
 zillaid, upazilaid, unionid, mouzaid, villageid, rmo, villagenameeng, villagename)
 VALUES (93, 95, 80, 273, 1, '1', 'Chalabakhla', 'চালাবাখলা');

 --INSERT INTO mouza( zillaid, upazilaid, unionid, mouzaid, mouzanameeng, mouzaname) VALUES       ( 93,         95,         80,     273,     'Chalabakhla', 'চালাবাখলা');

 select * from village where mouzaid=629 and villageid=1 and zillaid=93;

 select * from mouza where zillaid=93 and upazilaid=95 and unionid=80 and  mouzaid=273;

 */
