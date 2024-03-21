package com.emis.dao;

import com.emis.entity.PRS;
import com.emis.utility.Convertor;
import com.rhis.db.DBManagerDistrict;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import org.json.JSONArray;

/**
 *
 * @author Helal
 */
public class MobileCoverageDao {

    private DBManagerDistrict db = null;
    private Connection connection = null;
    private String sql = null;

    public MobileCoverageDao() {
    }

    public MobileCoverageDao(int districtId) {
        db = new DBManagerDistrict(districtId);
        connection = db.openConnection();
    }

    public JSONArray getDistrictMobile(PRS prs) throws SQLException, Exception {
        prs = new PRSDao().setStartDate(prs);
        ArrayList<Integer> districtIdList = new PRSDao(prs.getZillaid()).getDistrictIdByDivision(prs.getDivid());
        
        ArrayList<JSONArray> JSONArrayList = new ArrayList<JSONArray>();

        for (int district : districtIdList) {
            sql = "select * from web_mobile_phone_coverage_districtwise('" + prs.getDivid() + "','" + district + "','" + prs.getStartDate() + "','" + prs.getEndDate() + "') where zillaid not in  (99)";
            System.out.println(sql);
            db = new DBManagerDistrict(district);
            connection = db.openConnection();
            ResultSet resultSet = connection.createStatement().executeQuery(sql);
            JSONArray json = Convertor.toJSON(resultSet);
            JSONArrayList.add(json);
        }
        connection.close();
        return Convertor.getMergeJsonArrays(JSONArrayList);
    }

    public JSONArray getUpazilaMobile(PRS prs) throws SQLException, Exception {
        sql = "select * from web_mobile_phone_coverage_upazilawise(" + prs.getZillaid() + ",'%','" + prs.getStartDate() + "','" + prs.getEndDate() + "') where zillaid not in  (99) order by upazilanameeng asc";
        System.out.println(sql);
        ResultSet resultSet = connection.createStatement().executeQuery(sql);
        connection.close();
        return Convertor.toJSON(resultSet);
    }

    public JSONArray getUnionMobile(PRS prs) throws SQLException, Exception {
        if (prs.getUnionid().equals("0")) {
            prs.setUnionid("%");
        }
        sql = "select * from web_mobile_phone_coverage_unionwise(" + prs.getZillaid() + "," + prs.getUpazilaid() + ",'" + prs.getUnionid() + "','" + prs.getStartDate() + "','" + prs.getEndDate() + "') where zillaid not in  (99) order by unionnameeng asc";
        System.out.println(sql);
        ResultSet resultSet = connection.createStatement().executeQuery(sql);
        connection.close();
        return Convertor.toJSON(resultSet);
    }
}
