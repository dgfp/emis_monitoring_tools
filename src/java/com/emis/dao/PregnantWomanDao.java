package com.emis.dao;

import com.emis.entity.WorkplanArea;
import com.emis.utility.Convertor;
import com.rhis.db.DBManagerDistrict;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import org.json.JSONArray;

/**
 *
 * @author Helal
 */
public class PregnantWomanDao {
    
    private DBManagerDistrict db = null;
    private Connection connection = null;
    
    public PregnantWomanDao() {
    }

    public PregnantWomanDao(int districtId) {
        db = new DBManagerDistrict(districtId);
        connection = db.openConnection();
    }

    public JSONArray getStatus(WorkplanArea workplanArea) throws SQLException, Exception {
        String sql="select \n" +
                        "	count(*) as total_provider\n" +
                        "	,count(*) filter(where t.status = 1) as waiting\n" +
                        "	,count(*) filter(where t.status = 2) as approved\n" +
                        "	,count(*) filter(where t.status = 3) as disapproved\n" +
                        "	,count(*) filter(where t.status = 4) as resubmitted\n" +
                        "from\n" +
                        "(\n" +
                        "select distinct on (p.providerid) * from providerdb p\n" +
                        "left join (\n" +
                        "select * from  workplanmaster w where (w.work_plan_mon = "+workplanArea.getMonth()+" and w.work_plan_year = "+workplanArea.getYear()+") \n" +
                        ") w USING (providerid)\n" +
                        "where \n" +
                        "p.zillaid = "+workplanArea.getZillaid()+" \n" +
                        "--and p.upazilaid = "+workplanArea.getUpazilaid()+" \n" +
                        "--and p.unionid = "+workplanArea.getUnionid()+" \n" +
                        "and p.provtype = "+workplanArea.getProvtype()+" \n" +
                        "and active = 1\n" +
                        ") t";
        
        System.out.println("sql:"+sql);
        Statement stmt = connection.createStatement();
        ResultSet resultSet = null;
        resultSet = stmt.executeQuery(sql);
        connection.close();
        return Convertor.convertResultSetIntoJSONWithDash(resultSet);
    }
    
}
