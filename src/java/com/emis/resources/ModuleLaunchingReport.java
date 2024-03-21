package com.emis.resources;

import com.emis.utility.Convertor;
import com.emis.utility.Menu;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.rhis.db.DBManagerDistrict;
import com.rhis.db.DBManagerMonitoring;
import java.sql.ResultSet;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.json.JSONArray;
import com.emis.entity.ELCO;
import com.emis.entity.ModuleLaunchInformation;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import java.io.File;
import java.rmi.ServerException;
import java.util.Iterator;
import java.util.List;
import javax.servlet.ServletContext;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.json.JSONObject;

/**
 *
 * @author Helal
 */
@WebServlet(name = "ModuleLaunchingReport", urlPatterns = {"/module-launching-report"})
public class ModuleLaunchingReport extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Menu.setMenu("MISCELLANEOUS", "module-launching-report", request);
        request.getRequestDispatcher("WEB-INF/jsp/resources/ModuleLaunchingReport.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        DBManagerMonitoring db = new DBManagerMonitoring();
        JSONArray json = new JSONArray();
        try {
            if(action.equalsIgnoreCase("getModule")){
                ResourceSqlUtility sql = new ResourceSqlUtility();
                json = sql.getModuleList();
            }
            if(action.equalsIgnoreCase("getTrainingType")){
                ResourceSqlUtility sql = new ResourceSqlUtility();
                json = sql.getTrainingType();
            }
            if (action.equalsIgnoreCase("getReport")) {
                // select * from public.web_training_report_1('%', '%', '%', null, null);
                ResultSet result = db.select("select * from public.web_training_report_1('%', '%', '%', '%', '%', 'null', 'null');");
                json = Convertor.convertJSONResultSetIntoJSON(result, null);
            }
            else if(action.equalsIgnoreCase("getReportCatchment")){
                ModuleLaunchInformation mli = new ObjectMapper().readValue(request.getParameter("data").toString(), ModuleLaunchInformation.class);
                System.out.println("HHHHH"+mli.getTraining_start_date()+mli.getTraining_end_date());
                ResultSet result = db.select("select * from public.web_training_report_1('"+mli.getDivision()+"', '"+mli.getZilla()
                        +"', '"+mli.getUpazila()+"', '"+mli.getTraining_type_id()+"', '"+mli.getModule_id()+"', '"
                        +mli.getTraining_start_date()+"', '"+mli.getTraining_end_date()+"');");
                json = Convertor.convertJSONResultSetIntoJSON(result, null);
//                if(mli.getDivision() == 0 && mli.getTraining_start_date() =="" && mli.getTraining_end_date() == ""){
//                    ResultSet result = db.select("select * from public.web_training_report_1('%', '%', '%', null, null);");
//                    json = Convertor.convertJSONResultSetIntoJSON(result, null);
//                }
//                if(mli.getDivision() !=0 && mli.getZilla()== 0){
//                    ResultSet result = db.select("select * from public.web_training_report_1('"+mli.getDivision()+"', '%', '%', null, null);");
//                    json = Convertor.convertJSONResultSetIntoJSON(result, null);
//                }
//                if(mli.getDivision() != 0 && mli.getZilla() != 0 && mli.getUpazila() == 0){
//                    ResultSet result = db.select("select * from public.web_training_report_1('"+mli.getDivision() + "','" + mli.getZilla() +"', '%', null, null);");
//                    json = Convertor.convertJSONResultSetIntoJSON(result, null);
//                }
//                if(mli.getDivision() != 0 && mli.getZilla() != 0 && mli.getUpazila() != 0){
//                    ResultSet result = db.select("select * from public.web_training_report_1('"+mli.getDivision() + "','" + mli.getZilla() + "','" +mli.getUpazila()  +"', null, null);");
//                    json = Convertor.convertJSONResultSetIntoJSON(result, null);
//                }
                
                // For date
//                if(mli.getDivision() == 0 && mli.getTraining_start_date() !="" && mli.getTraining_end_date() != ""){
//                    ResultSet result = db.select("select * from public.web_training_report_1('%', '%', '%','"+mli.getTraining_start_date()+"', '"+mli.getTraining_end_date()+"');");
//                    json = Convertor.convertJSONResultSetIntoJSON(result, null);
//                }
//                System.out.println("Start date"+mli.getTraining_start_date());
            }
            response.setContentType("application/json");
            response.getWriter().write(json.toString());
        } catch (Exception ex) {
            Logger.getLogger(ModuleLaunchingReport.class.getName()).log(Level.SEVERE, null, ex);
//            response.getWriter().write("[{\"status\": \"error\",\"message\":"+ "\""+ ex.toString() +"\"}]");
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, ex.toString());
        }
    }
}
