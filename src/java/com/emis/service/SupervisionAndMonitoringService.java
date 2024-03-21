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
public class SupervisionAndMonitoringService {

    public static JSONArray getMonthlyWorkplan(int districtId, int month, int year, int providerId, int type) throws SQLException {
        JSONArray json = new JSONArray();
        try {
            DBManagerDistrict db = new DBManagerDistrict(districtId);

//            String sql = "SELECT distinct wd.workplandate, wi.itemdes as activity, wm.status from workplanmaster wm\n"
//                    + "\n"
//                    + "join workplandetail wd \n"
//                    + "on wm.zillaid = wd.zillaid\n"
//                    + "and wm.upazilaid = wd.upazilaid\n"
//                    + "and wm.unionid = wd.unionid\n"
//                    + "and wm.providerid = wd.providerid\n"
//                    + "and wm.work_plan_mon = wd.work_plan_mon\n"
//                    + "and wm.work_plan_year = wd.work_plan_year\n"
//                    + "\n"
//                    + "left join workplan_item wi\n"
//                    + "on wd.item = wi.itemcode\n"
//                    + "\n"
//                    + "where wm.providerid = " + providerId + " and wm.work_plan_mon = " + month + " and wm.work_plan_year = " + year + " and wi.type= " + type + "  order by wd.workplandate";

            String sql = "SELECT distinct wd.workplandate\n" +
            ", array_to_string(array_agg(wi.itemdes),',<br> ') as activity\n" +
            ", wm.status as status\n" +
            "from workplanmaster wm\n" +
            "join workplandetail wd \n" +
            "on wm.zillaid = wd.zillaid\n" +
            "and wm.upazilaid = wd.upazilaid\n" +
            "and wm.unionid = wd.unionid\n" +
            "and wm.providerid = wd.providerid\n" +
            "and wm.work_plan_mon = wd.work_plan_mon\n" +
            "and wm.work_plan_year = wd.work_plan_year\n" +
            "left join workplan_item wi\n" +
            "on wd.item = wi.itemcode\n" +
            "where wm.providerid = " + providerId + " and wm.work_plan_mon = " + month + "  and wm.work_plan_year = " + year + " and wi.type= " + type + "  \n" +
            //"and wm.status=2 and wd.status=1\n" +
            "group by wd.workplandate, wm.status\n" +
            "order by wd.workplandate";
            
            
            ResultSet result = db.select(sql);
            System.out.print("`````````````````````````````````" + sql);
            json = Convertor.convertResultSetIntoJSON(result);
            return json;
        } catch (Exception ex) {
            return json;
        }
    }

}
