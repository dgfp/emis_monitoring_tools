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
 * @author Nil_27
 */
@WebServlet(name = "VillageControllerRHIS2DB_1", urlPatterns = {"/village_settings_service"})
public class VillageControllerRHIS2DB_1 extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("submenu", "village_settings_service");
        request.setAttribute("menu", "MANAGEMENT");
        RequestDispatcher dispatcher = request.getRequestDispatcher("WEB-INF/jsp/management/village_settings_service_module.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        String query = "";
        String districtId = request.getParameter("districtId");
        String upazilaId = request.getParameter("upazilaId");
        String unionId = request.getParameter("unionId");

        if (action.equalsIgnoreCase("addNewVillage")) {

            String mouzaId = request.getParameter("mouzaId");
            String villageId = request.getParameter("villageId");
            String villageNameEng = request.getParameter("villageNameEng");
            String villageNameBn = request.getParameter("villageNameBn");

            query = "INSERT INTO public.\"Village\"(\n"
                    + "            \"ZILLAID\", \"UPAZILAID\", \"UNIONID\", \"MOUZAID\", \"VILLAGEID\", \"RMO\", \n"
                    + "            \"VILLAGENAMEENG\", \"VILLAGENAME\")\n"
                    + "VALUES (" + districtId + ", " + upazilaId + ", " + unionId + ", " + mouzaId + ", " + villageId + ", '2', '" + villageNameEng + "', \n"
                    + " '" + villageNameBn + "');";
            DBManagerDistrict db2 = new DBManagerDistrict(Integer.parseInt(districtId));
            int rowCount = db2.update(query);
            response.setContentType("text/plain;charset=UTF-8");
            response.getWriter().write(rowCount + "");

        } else if (action.equalsIgnoreCase("addMouza")) {

            String mouzaId = request.getParameter("mouzaId");
            String mouzaname = request.getParameter("mouzaname");
            String mouzanameeng = request.getParameter("mouzanameeng");

            query = "INSERT INTO public.\"Mouza\"(\n"
                    + "            \"ZILLAID\", \"UPAZILAID\", \"UNIONID\", \"MOUZAID\", \n"
                    + "            \"RMO\", \"MOUZANAMEENG\", \"MOUZANAME\")\n"
                    + "    VALUES (" + districtId + "," + upazilaId + "," + unionId + "," + mouzaId + ",'1','" + mouzanameeng + "', \n"
                    + "            '" + mouzaname + "');";
            DBManagerDistrict db2 = new DBManagerDistrict(Integer.parseInt(districtId));
            int rowCount = db2.update(query);
            response.setContentType("text/plain;charset=UTF-8");
            response.getWriter().write(rowCount + "");

        } else if (action.equalsIgnoreCase("showVillage")) {
            query = "Select M.\"MOUZAID\",M.\"MOUZANAMEENG\",V.\"VILLAGEID\",V.\"VILLAGEID\",V.\"VILLAGENAMEENG\"\n"
                    + "FROM \"Mouza\" M, \"Village\" V\n"
                    + "Where M.\"MOUZAID\"=V.\"MOUZAID\"\n"
                    + "and M.\"ZILLAID\"=V.\"ZILLAID\"\n"
                    + "and M.\"UPAZILAID\"=V.\"UPAZILAID\"\n"
                    + "and M.\"UNIONID\"=V.\"UNIONID\""
                    + "and M.\"ZILLAID\" = " + districtId + " AND\n"
                    + "M.\"UPAZILAID\" = " + upazilaId + " AND \n"
                    + "M.\"UNIONID\" = " + unionId + " ;";

            try {
                DBManagerDistrict db = new DBManagerDistrict(Integer.parseInt(districtId));
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
