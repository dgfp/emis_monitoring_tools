package com.emis.service;

import com.rhis.db.DBManagerMonitoring;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import org.json.JSONException;

/**
 *
 * @author Helal
 */
public class Area {
    
    public static ArrayList<Integer> getDistrictIdByDivision(String divisionId) throws JSONException{
        Connection connection=null;
        ArrayList<Integer> districtIdList = new ArrayList<Integer>();
        
        if(divisionId!=null || divisionId.equals("")){
            try {
                DBManagerMonitoring db = new DBManagerMonitoring();
                connection=db.getConnection();
                System.out.println("select distinct zillaid, zillaname, zillanameeng from implemented_div_zila where id="+divisionId+" and is_implemented=1 order by zillanameeng asc");
                String sql = "select distinct zillaid, zillaname, zillanameeng from implemented_div_zila where id=? and is_implemented=? order by zillanameeng asc";
                
                PreparedStatement preparedStatement = connection.prepareStatement(sql);
                preparedStatement.setString(1, divisionId);
                preparedStatement.setInt(2, 1);
                ResultSet result = preparedStatement.executeQuery();
                //Get District population from selected district and implemented division
                while(result.next()){
                    districtIdList.add(result.getInt("ZILLAID"));
                }
            } catch (Exception ex) {
                System.out.println(ex.getMessage());
            }
        }
        return districtIdList;
    }
    
}
