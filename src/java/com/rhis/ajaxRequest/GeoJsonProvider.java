/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.rhis.ajaxRequest;

import com.emis.utility.Convertor;
import com.rhis.db.DBManagerMonitoring;
import java.sql.ResultSet;
import java.util.ArrayList;
import org.json.JSONArray;

/**
 *
 * @author MCHD23
 */
public class GeoJsonProvider {

    public String getDivision() throws Exception {
        DBManagerMonitoring db = new DBManagerMonitoring();
        ResultSet result = db.select("SELECT distinct id, divisioneng as name FROM public.implemented_div_zila where is_implemented=1 order by divisioneng asc");
        JSONArray json = Convertor.convertResultSetIntoJSON(result);
        return json.toString();
    }

    public String getDistrictMultiple(ArrayList<String> divisionIds) throws Exception {
        DBManagerMonitoring db = new DBManagerMonitoring();
        String divisions = String.join(",", divisionIds);
        ResultSet result = db.select("select distinct id as divid, zillaid as id,  zillanameeng as name from implemented_div_zila where id::int in (" + divisions + ") and is_implemented=1 and zillaid not in (99) order by zillanameeng asc");
        JSONArray json = Convertor.convertResultSetIntoJSON(result);
        return json.toString();
    }

    public String getDistrictAgg(ArrayList<String> divisionIds) throws Exception {
        DBManagerMonitoring db = new DBManagerMonitoring();
        String divisions = String.join(",", divisionIds);
        String sql = "select pg_catalog.row_to_json(r) as json from (select d.id as value,\n"
                + "          d.divisioneng as label,\n"
                + "          pg_catalog.jsonb_agg(json_build_object('value',z.zillaid, 'label', z.zillanameeng,'parent', z.divid::text || '-' || z.zillaid::text, 'lavel', 2)) as json\n"
                + "   from division d\n"
                + "   inner join zilla z on d.id::int = z.divid\n"
                + "   where d.id in(" + divisions +")\n"
                + "   group by d.id) r(id, label, children);";
        ResultSet result = db.select(sql);
        JSONArray json = Convertor.convertJSONResultSetIntoJSON(result, null);
        return json.toString();
    }
}
