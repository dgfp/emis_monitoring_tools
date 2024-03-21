package com.emis.dao;

import com.emis.entity.PRS;
import com.emis.utility.Convertor;
import com.rhis.db.DBManagerDistrict;
import com.rhis.db.DBManagerMonitoring;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import org.json.JSONArray;

/**
 *
 * @author Helal
 */
public class PRSDao {

    private DBManagerDistrict db = null;
    private Connection connection = null;
    private String sql = null;

    public PRSDao() {
    }

    public PRSDao(int districtId) {
        db = new DBManagerDistrict(districtId);
        connection = db.openConnection();
    }

    public JSONArray getDistrictPRS(PRS prs) throws SQLException, Exception {
        prs = this.setStartDate(prs);
        ArrayList<Integer> districtIdList = this.getDistrictIdByDivision(prs.getDivid());
        ArrayList<JSONArray> JSONArrayList = new ArrayList<JSONArray>();
        for (int district : districtIdList) {
            if (prs.getStartDate().equals("")) {
                sql = "select * from fn_popprogress_zila('" + prs.getDivid() + "','" + district + "') where zillaid not in  (99,999)  order by zillanameeng asc";
            } else {
                sql = "select * from fn_popprogress_zila_date_wise('" + prs.getDivid() + "','" + district + "','" + prs.getStartDate() + "','" + prs.getEndDate() + "') where zillaid not in  (99)";
            }
            db = new DBManagerDistrict(district);
            connection = db.openConnection();
            ResultSet resultSet = connection.createStatement().executeQuery(sql);
            JSONArray json = Convertor.convertResultSetIntoJSON(resultSet);
            JSONArrayList.add(json);
            System.out.println(sql);
        }
        connection.close();
        return Convertor.getMergeJsonArrays(JSONArrayList);
    }

    public JSONArray getUpazilaPRS(PRS prs) throws SQLException, Exception {
        prs = this.setStartDate(prs);
        sql = "select * from fn_popprogress_upazila_date_wise('" + prs.getDivid() + "','" + prs.getZillaid() + "','%','" + prs.getStartDate() + "','" + prs.getEndDate() + "') where zillaid not in  (99) order by upazilanameeng asc";
        System.out.println(sql);
        ResultSet resultSet = connection.createStatement().executeQuery(sql);
        connection.close();
        return Convertor.toJSON(resultSet);
    }

    public JSONArray getUnionPRS(PRS prs) throws SQLException, Exception {
        prs = this.setStartDate(prs);
        if (prs.getUnionid().equals("0")) {
            prs.setUnionid("%");
        }
        sql = "select * from fn_popprogress_un_date_wise('" + prs.getDivid() + "','" + prs.getZillaid() + "','" + prs.getUpazilaid() + "','" + prs.getUnionid() + "','" + prs.getStartDate() + "','" + prs.getEndDate() + "') where zillaid not in  (99) order by unionnameeng asc";
        System.out.println(sql);
        ResultSet resultSet = connection.createStatement().executeQuery(sql);
        connection.close();
        return Convertor.toJSON(resultSet);
    }

    protected PRS setStartDate(PRS prs) {
        if (prs.getStartDate().equals("")) {
            prs.setStartDate("01/01/2015");
        }
        return prs;
    }

    protected ArrayList<Integer> getDistrictIdByDivision(int divId) throws SQLException, Exception {
        DBManagerMonitoring db = new DBManagerMonitoring();
        connection = db.getConnection();
        ArrayList<Integer> districtIdList = new ArrayList<Integer>();
        sql = "select distinct zillaid, zillaname, zillanameeng from implemented_div_zila where id='" + divId + "' and is_implemented=1 order by zillanameeng asc";
        ResultSet resultSet = connection.createStatement().executeQuery(sql);
        while (resultSet.next()) {
            districtIdList.add(resultSet.getInt("ZILLAID"));
        }
        return districtIdList;
    }
}
