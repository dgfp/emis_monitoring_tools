package com.emis.service;

import com.emis.beans.UnitMaster;
import com.emis.utility.Convertor;
import com.rhis.db.DBManagerDistrict;
import com.rhis.db.DBManagerMonitoring;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Iterator;
import java.util.List;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

/**
 *
 * @author Helal | m.helal.k@gmail.com
 */
public class LmisDataEntryService {

    private DBManagerDistrict db = null;

    public LmisDataEntryService() {
    }

    public LmisDataEntryService(int district) {
        db = new DBManagerDistrict(district);
        db.start();
    }

    public String getLmisData(String zilla, String upazila, String reporting_union, String unit, String unitId, String providerId, String month, String year) throws Exception {
        String sql = "select row_number() over (ORDER BY modifydate) as serial, * from rpt_mis_form1_lmis_9v_entry_dgfp where zillaid=" + zilla + " and "
                + " upazilaid=" + upazila + " and " + " reporting_unionid = " + reporting_union + " and "
                + " unit = " + unit + " and " + " unitid = " + unitId + " and year_no=" + year + " and month_no=" + month + " order by modifydate";
        ResultSet result = db.select(sql);
        JSONArray json = new JSONArray();
        json = Convertor.convertResultSetIntoJSON(result);
        return json.toString();
    }

    public int insertOnUpdateData(String zillaId, JSONObject json) throws JSONException {
        String[] pKeys = {"year_no", "month_no", "zillaid", "upazilaid", "reporting_unionid", "unitid"};
        // Arrays.asList(yourArray).contains(yourValue)
        List<String> Keys = new ArrayList<>();
        List<String> keysWithouPk = new ArrayList<>();
        List<String> excludedKeys = new ArrayList<>();
        List<String> Vals = new ArrayList<>();

        Iterator<String> keys = json.keys();
        while (keys.hasNext()) {
            String k = keys.next();
            String v = (String) json.get(k);
            v = v.isEmpty() ? "0" : v;
            if (!Arrays.asList(pKeys).contains(k)) {
                excludedKeys.add("excluded." + k);
                keysWithouPk.add(k);
            }
            Keys.add(k);
            
            Vals.add(v);
        }
        String _keys = String.join(",", Keys);
        String _vals = String.join(",", Vals);

        String query = "INSERT INTO rpt_mis_form1_lmis_9v_entry_dgfp (%s) VALUES (%s) ON CONFLICT ON CONSTRAINT rpt_mis_form1_lmis_9v_entry_dgfp_pkey DO UPDATE SET (%s)=row(%s);";
        query = String.format(query, _keys, _vals, String.join(",", keysWithouPk), String.join(",", excludedKeys));
        System.out.println(query);

        DBManagerDistrict db = new DBManagerDistrict(Integer.parseInt(zillaId));
        db.start();
        int resultLmisEntry = db.update(query);
        if (resultLmisEntry == 1) {
            db.commit();
        } else {
            db.rollback();
        }

        return resultLmisEntry;

    }
}
