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
public class NIDCoverageDao {

    private DBManagerDistrict db = null;
    private Connection connection = null;
    private String sql = null;

    public NIDCoverageDao() {
    }

    public NIDCoverageDao(int districtId) {
        db = new DBManagerDistrict(districtId);
        connection = db.openConnection();
    }

    public JSONArray getDistrictWise(PRS prs) throws SQLException, Exception {
        prs = new PRSDao().setStartDate(prs);
        ArrayList<Integer> districtIdList = new PRSDao(prs.getZillaid()).getDistrictIdByDivision(prs.getDivid());

        ArrayList<JSONArray> JSONArrayList = new ArrayList<JSONArray>();

        for (int district : districtIdList) {
            sql = "select * from sp_possessionnid_dist(30,'%','2015-04-04','2020-06-07');";
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

    public JSONArray getUpazilaWise(PRS prs) throws SQLException, Exception {
        sql = "select * from sp_possessionnid_upz("+prs.getZillaid()+",'%','" + prs.getStartDate() + "','" + prs.getEndDate()+"');";
        System.out.println(sql);
        ResultSet resultSet = connection.createStatement().executeQuery(sql);
        connection.close();
        return Convertor.toJSON(resultSet);
    }

    public JSONArray getUnionWise(PRS prs) throws SQLException, Exception {
        if (prs.getUnionid().equals("0")) {
            prs.setUnionid("%");
        }
        sql = "select * from sp_possessionnid_un("+prs.getZillaid()+", "+prs.getUpazilaid()+", '"+prs.getUnionid()+"','" + prs.getStartDate() + "','" + prs.getEndDate()+"');";
        System.out.println(sql);
        ResultSet resultSet = connection.createStatement().executeQuery(sql);
        connection.close();
        return Convertor.toJSON(resultSet);
    }
    
    public void print(Object o){
        System.out.println(o);
    }

}
