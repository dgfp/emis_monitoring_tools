package com.emis.dao;

import com.emis.entity.AssetBACK;
import com.emis.utility.Convertor;
import com.rhis.db.DBManagerDistrict;
import com.rhis.db.DBManagerMonitoring;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import org.json.JSONArray;

/**
 *
 * @author Helal
 * Test..
 */
public class AssetDao {

    private DBManagerMonitoring db = null;
    //private DBManagerDistrict dbd = null;
    private Connection connection = null;
    private String sql = null;

    public AssetDao() {
        db = new DBManagerMonitoring();
        connection = db.openConnection();
    }

    public AssetDao(int districtId) {
        db = new DBManagerDistrict(districtId);
        connection = db.openConnection();
    }

    public JSONArray getProviderType() throws SQLException, Exception {
        String sql = "SELECT  provtype, typename from providertype where typename not in ('Data Collector')";
        ResultSet resultSet = connection.createStatement().executeQuery(sql);
        connection.close();
        return Convertor.toJSON(resultSet);
    }

    public JSONArray getStatus() throws SQLException, Exception {
        String sql = "SELECT  id status_id, name from asset_status ";
        ResultSet resultSet = connection.createStatement().executeQuery(sql);
        connection.close();
        return Convertor.toJSON(resultSet);
    }

    public JSONArray getData(AssetBACK a) throws SQLException, Exception {
        sql = "select * from web_asset(" + a.getZillaid() + ", " + a.getUpazilaid() + ", " + a.getUnionid() + ", " + a.getProvtype() + ", " + a.getStatus_id() + ")";
        System.out.println(sql);
        ResultSet resultSet = connection.createStatement().executeQuery(sql);
        connection.close();
        return Convertor.toJSON(resultSet);
    }

    public JSONArray getAssetDetails(String zillaid, String imei1, String providerid) throws SQLException, Exception {
        sql = "select * from web_asset("+zillaid+", 0, 0, 0, 0) where imei1="+imei1+" and providerid="+providerid;
        System.out.println(sql);
        ResultSet resultSet = connection.createStatement().executeQuery(sql);
        connection.close();
        return Convertor.toJSON(resultSet);
    }

    /*
    public JSONArray getDesignation() throws SQLException, Exception {
        String sql = "SELECT  distinct designation FROM public.asset_dump where designation<>'' order by designation";
        System.out.println("SQL: " + sql);
        Statement stmt = connection.createStatement();
        ResultSet resultSet = null;
        resultSet = stmt.executeQuery(sql);
        connection.close();
        return Convertor.toJSON(resultSet);
    }

//    public JSONArray getStatus() throws SQLException, Exception {
//        String sql = "SELECT  distinct current_status FROM asset_dump order by current_status";
//        System.out.println("SQL: " + sql);
//        Statement stmt = connection.createStatement();
//        ResultSet resultSet = null;
//        resultSet = stmt.executeQuery(sql);
//        connection.close();
//        return Convertor.toJSON(resultSet);
//    }
    public JSONArray getDistributedData() throws SQLException, Exception {
        //String sql = "SELECT  (case when sim_number is not null then right(concat('00000000000',sim_number),11) end) sim_number2, (case when mobileno is not null then right(concat('00000000000',mobileno),11) end) mobileno2, * FROM public.asset_dump";
        String sql = "select * from web_asset(0, 0, 0, 0, 0)";
        System.out.println("SQL: " + sql);
        Statement stmt = connection.createStatement();
        ResultSet resultSet = null;
        resultSet = stmt.executeQuery(sql);
        connection.close();
        return Convertor.toJSON(resultSet);
    }

    public JSONArray getDistributedAssetDetails(String imei1, String sim_number, String name_of_user, String providerid, String mobileno) throws SQLException, Exception {
        String where = "";
        if (!sim_number.equals("")) {
            where += "and sim_number=" + sim_number + " ";
        }
        if (!name_of_user.equals("")) {
            where += "and name_of_user='" + name_of_user + "' ";
        }
        if (!providerid.equals("")) {
            where += "and providerid='" + providerid + "' ";
        }
        if (!mobileno.equals("")) {
            where += "and mobileno=" + mobileno + " ";
        }
        String sql = "SELECT  (case when sim_number is not null then right(concat('00000000000',sim_number),11) end) sim_number2, (case when mobileno is not null then right(concat('00000000000',mobileno),11) end) mobileno2, * FROM public.asset_dump where imei1=" + imei1 + " " + where;
        System.out.println("SQL: " + sql);
        Statement stmt = connection.createStatement();
        ResultSet resultSet = null;
        resultSet = stmt.executeQuery(sql);
        connection.close();
        return Convertor.toJSON(resultSet);
    }

    public JSONArray getDistributedMasterAssetDetails(String imei1, String sim_number, String name_of_user, String providerid, String mobileno) throws SQLException, Exception {
        String where = "";
        if (!sim_number.equals("-")) {
            where += "and sim_number=" + sim_number + " ";
        }
        if (!name_of_user.equals("")) {
            where += "and name_of_user='" + name_of_user + "' ";
        }
        if (!providerid.equals("")) {
            where += "and providerid='" + providerid + "' ";
        }
        if (!mobileno.equals("-")) {
            where += "and mobileno=" + mobileno + " ";
        }
        String sql = "select * from asset_device_master join asset_specifications_master using (spec_id) left join asset_dump using (imei1) where imei1=" + imei1 + " " + where;
        System.out.println("SQL: " + sql);
        Statement stmt = connection.createStatement();
        ResultSet resultSet = null;
        resultSet = stmt.executeQuery(sql);
        connection.close();
        return Convertor.toJSON(resultSet);
    }

    public JSONArray getAssetBySelector(String designation, String status) throws SQLException, Exception {
        String where = "";
        if (!designation.equals("0")) {
            where += "where designation='" + designation + "'";
            if (!status.equals("0")) {
                where += " and current_status='" + status + "'";
            }
        } else if (!status.equals("0")) {
            where += "where current_status='" + status + "'";
            if (!designation.equals("0")) {
                where += " and designation='" + designation + "'";
            }
        }
        String sql = "SELECT  (case when sim_number is not null then right(concat('00000000000',sim_number),11) end) sim_number2, (case when mobileno is not null then right(concat('00000000000',mobileno),11) end) mobileno2, * FROM public.asset_dump " + where;
        System.out.println("SQL: " + sql);
        Statement stmt = connection.createStatement();
        ResultSet resultSet = null;
        resultSet = stmt.executeQuery(sql);
        connection.close();
        return Convertor.toJSON(resultSet);
    }

    public JSONArray getAssetByStatus(String status) throws SQLException, Exception {
        String where = "";
        if (!status.equals("0") && !status.equals("")) {
            where += "where current_status='" + status + "'";
        } else if (status.equals("")) {
            where += "where current_status is null";
        }
        String sql = "select * from asset_device_master join asset_specifications_master using (spec_id) left join asset_dump using (imei1) " + where;
        System.out.println("SQL: " + sql);
        Statement stmt = connection.createStatement();
        ResultSet resultSet = null;
        resultSet = stmt.executeQuery(sql);
        connection.close();
        return Convertor.toJSON(resultSet);
    }

    public JSONArray getMasterAsset() throws SQLException, Exception {
        String sql = "select * from asset_device_master join asset_specifications_master using (spec_id) left join asset_dump using (imei1)";
        System.out.println("SQL: " + sql);
        Statement stmt = connection.createStatement();
        ResultSet resultSet = null;
        resultSet = stmt.executeQuery(sql);
        connection.close();
        return Convertor.toJSON(resultSet);
    }
     */
}
