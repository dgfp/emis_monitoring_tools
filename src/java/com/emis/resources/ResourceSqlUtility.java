/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.emis.resources;

import com.emis.entity.ModuleLaunchInformation;
import com.emis.utility.Convertor;
import com.rhis.db.DBManagerMonitoring;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import org.json.JSONArray;

/**
 *
 * @author nar_r
 */
public class ResourceSqlUtility {

    public ResourceSqlUtility() {
    }

    public JSONArray getModuleList() throws Exception {
        DBManagerMonitoring db = new DBManagerMonitoring();
        ResultSet result = db.select("Select * from training_module_name;");
        JSONArray json = new JSONArray();
        json = Convertor.convertResultSetIntoJSON(result);
        return json;
    }

    public JSONArray getTrainingType() throws Exception {
        DBManagerMonitoring db = new DBManagerMonitoring();
        ResultSet result = db.select("Select * from training_type_name;");
        JSONArray json = new JSONArray();
        json = Convertor.convertResultSetIntoJSON(result);
        return json;
    }
//Module launching data entry form - get data for update table

    public JSONArray getData() throws Exception {
        DBManagerMonitoring db = new DBManagerMonitoring();
        String query = "SELECT t.id\n"
                + "     , t.division\n"
                + "     , d.divisioneng\n"
                + "     , t.zilla\n"
                + "     , z.zillanameeng\n"
                + "     , t.upazila\n"
                + "     , u.upazilanameeng\n"
                + "     , TO_CHAR(t.training_start_date, 'dd Mon, yyyy') training_start_date\n"
                + "     , TO_CHAR(t.training_end_date, 'dd Mon, yyyy') training_end_date\n"
                + "     , t.module_id\n"
                + "     , t.training_type_id\n"
                + "     , ttn.name as training_type_name\n"
                + "     , tmn.name as module_name\n"
                + "     , t.participant_number\n"
                + "     , t.document_url\n"
                + "FROM public.training_calendar t\n"
                + "join division d on t.division = d.id\n"
                + "join zilla z on t.division = z.divid and t.zilla = z.zillaid\n"
                + "join upazila u on t.zilla = u.zillaid and t.upazila = u.upazilaid\n"
                + "join public.training_module_name tmn on t.module_id = tmn.id\n"
                + "join public.training_type_name ttn on t.training_type_id = ttn.id\n"
                + "ORDER BY d.divisioneng, z.zillanameeng, u.upazilanameeng";
        ResultSet result = db.select(query);
        System.out.println(query);
        JSONArray json = new JSONArray();
        json = Convertor.convertResultSetIntoJSON(result);
        return json;
    }

    public String insertModuleLaunchingInfo(ModuleLaunchInformation mli) throws SQLException {
        int batchId = this.getTrainingBatchId(mli.getDivision(), mli.getZilla(), mli.getUpazila(),
                 mli.getTraining_start_date(), mli.getTraining_end_date(), mli.getModule_id(),
                 mli.getTraining_type_id());
        DBManagerMonitoring db = new DBManagerMonitoring();
        String query = "INSERT INTO public.training_calendar (\n"
                + "    division\n"
                + "    , zilla\n"
                + "    , upazila\n"
                + "    , organized_for\n"
                + "    , training_start_date\n"
                + "    , training_end_date\n"
                + "    , module_id\n"
                + "    , training_type_id\n"
                + ", batch_id"
                + "    , participant_number\n"
                + "    , document_url\n"
                + ", systementrydate"
                + ", modifydate"
                + ") VALUES ("
                + mli.getDivision() + "," + mli.getZilla() + "," + mli.getUpazila() + "," + mli.getOrganized_for() + ",'" + mli.getTraining_start_date() + "','"
                + mli.getTraining_end_date() + "',"
                + mli.getModule_id() + "," + mli.getTraining_type_id() + "," + batchId + "," + mli.getParticipant_number() + ",'" + mli.getDocument_url() + "',"
                + "now()" + ","
                + "now()"
                + ");";
        int rowCount = db.update(query);
        return ("{\"rowcount\":" + rowCount + "}");
    }

    public String updateModuleLaunchingInfo(ModuleLaunchInformation mli) {
        DBManagerMonitoring db = new DBManagerMonitoring();
        String query = "Update public.training_calendar set participant_number=" + mli.getParticipant_number()
                + ",training_start_date= '" + mli.getTraining_start_date() + "'" + ",training_end_date='" + mli.getTraining_end_date() + "'"
                + " where id = " + mli.getId() + ";";
        int rowCount = db.update(query);
        return ("{\"rowcount\":" + rowCount + "}");
    }

    public String deleteModuleLaunchingInfo(int id) {
        try {
            Connection connection = null;
            connection = new DBManagerMonitoring().openConnection();
            String sql = "Delete from training_calendar where id=?";
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, id);
            System.out.println(preparedStatement.toString());
            int rowCount = preparedStatement.executeUpdate();
            return ("{\"rowcount\":" + rowCount + "}");
        } catch (Exception e) {
            System.out.println(e.getMessage());
            return e.getMessage();
        }
    }

    public int getTrainingBatchId(String division, String zilla, String upazila, String trainingStartDate, String trainingEndDate,
             String moduleId, String trainingTypeId) throws SQLException {
        int batchId = 0;
        DBManagerMonitoring db = new DBManagerMonitoring();
        String query = "select max(batch_id) as batch_id from training_calendar where division = " + division + " and zilla=" + zilla
                + " and upazila=" + upazila + " and module_id=" + moduleId + " and training_type_id=" + trainingTypeId;
        ResultSet result = db.select(query);
        if (!result.isBeforeFirst()) {
            batchId += 1;
        } else {
            while (result.next()) {
                batchId = result.getInt("batch_id");
                batchId += 1;
            }
        }
        return batchId;
    }
//Module launching report - generate table data

    public JSONArray getModuleReport() throws Exception {
        DBManagerMonitoring db = new DBManagerMonitoring();
        String query = "SELECT \n"
                + "     t.division\n"
                + "     , d.divisioneng\n"
                + "     , t.zilla\n"
                + "     , z.zillanameeng\n"
                + "     , u.upazilanameeng\n"
                + "--     , t.module_id\n"
                + "     , sum(case \n"
                + "            when tmn.name = 'FWA' then t.participant_number\n"
                + "            else null::integer\n"
                + "        end) as \"FWA\"\n"
                + "     , sum(case \n"
                + "            when tmn.name = 'FPI' then t.participant_number\n"
                + "            else null::integer\n"
                + "        end) as \"FPI\"\n"
                + "     , sum(case \n"
                + "            when tmn.name = 'UFPO' then t.participant_number\n"
                + "            else null::integer\n"
                + "        end) as \"UFPO\"\n"
                + "     , sum(case \n"
                + "            when tmn.name = 'CSBA' then t.participant_number\n"
                + "            else null::integer\n"
                + "        end) as \"CSBA\"\n"
                + "     , sum(case \n"
                + "            when tmn.name = 'Facility e-Register' then t.participant_number\n"
                + "            else null::integer\n"
                + "        end) as \"Facility e-Register\"\n"
                + "     , sum(case \n"
                + "            when tmn.name = 'Troubleshooting' then t.participant_number\n"
                + "            else null::integer\n"
                + "        end) as \"Troubleshooting\"\n"
                + "     , sum(case \n"
                + "            when tmn.name = 'DHIS2' then t.participant_number\n"
                + "            else null::integer\n"
                + "        end) as \"DHIS2\"\n"
                + "     , sum(case \n"
                + "            when tmn.name = 'HRIS' then t.participant_number\n"
                + "            else null::integer\n"
                + "        end) as \"HRIS\"\n"
                + "    --  , t.document_url\n"
                + "FROM public.training_calendar t\n"
                + "join division d on t.division = d.id\n"
                + "join zilla z on t.division = z.divid and t.zilla = z.zillaid\n"
                + "join upazila u on t.zilla = u.zillaid and t.upazila = u.upazilaid\n"
                + "join public.training_module_name tmn on t.module_id = tmn.id\n"
                + "join public.training_type_name ttn on t.training_type_id = ttn.id\n"
                + "group by t.division, d.divisioneng, t.zilla, z.zillanameeng, u.upazilanameeng--, t.module_id, tmn.name\n"
                + "ORDER BY d.divisioneng, z.zillanameeng, u.upazilanameeng;";
        ResultSet result = db.select(query);
        System.out.println(query);
        JSONArray json = new JSONArray();
        json = Convertor.toJSON(result);
        return json;
    }
}
