package com.emis.service;

import com.emis.utility.Convertor;
import com.rhis.db.DBManagerDistrict;
import java.sql.ResultSet;
import java.sql.SQLException;
import org.json.JSONArray;

/**
 *
 * @author Helal | m.helal.k@gmail.com
 */
public class DropdownLoaderService {

    public DropdownLoaderService() {
    }

    public static JSONArray getProviderByTypeAndUnion(int districtId, int upazilaId, int unionId, int providerType) throws SQLException {
        JSONArray json = new JSONArray();
        try {
            DBManagerDistrict db = new DBManagerDistrict(districtId);
            ResultSet result = db.select("select providerid, provname from providerdb WHERE zillaid=" + districtId + " AND  upazilaid=" + upazilaId + " AND unionid=" + unionId + " AND provtype=" + providerType + " order by provname asc");
            json = Convertor.convertResultSetIntoJSON(result);
            return json;
        } catch (Exception ex) {
            return json;
        }
    }

    public static JSONArray getProviderById(int districtId, int upazilaId, int unionId, int providerType, int providerid) throws SQLException {
        JSONArray json = new JSONArray();
        try {
            DBManagerDistrict db = new DBManagerDistrict(districtId);
            ResultSet result = db.select("select providerid, provname from providerdb WHERE zillaid=" + districtId + " AND  upazilaid=" + upazilaId + " AND unionid=" + unionId + " AND provtype=" + providerType + " AND 0=" + providerid + " or providerid=" + providerid + " order by provname asc");
            json = Convertor.convertResultSetIntoJSON(result);
            return json;
        } catch (Exception ex) {
            return json;
        }
    }

}
