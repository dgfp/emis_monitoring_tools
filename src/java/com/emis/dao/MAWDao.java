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
public class MAWDao {

    private DBManagerDistrict db = null;
    private Connection connection = null;

    public MAWDao() {
    }

    public MAWDao(int districtId) {
        db = new DBManagerDistrict(districtId);
        connection = db.openConnection();
    }

    public JSONArray getStatus(WorkplanArea workplanArea) throws SQLException, Exception {
        String sql = "select * from web_monthly_workplan_dashboard(" + workplanArea.getZillaid() + "," + workplanArea.getUpazilaid() + "," + workplanArea.getUnionid() + "," + workplanArea.getProvtype() + "," + workplanArea.getMonth() + "," + workplanArea.getYear() + ");";
        Statement stmt = connection.createStatement();
        ResultSet resultSet = null;
        resultSet = stmt.executeQuery(sql);
        connection.close();
        return Convertor.convertResultSetIntoJSONWithDash(resultSet);
    }

    public JSONArray getWorkplanStatus(WorkplanArea workplanArea) throws SQLException, Exception {
        String sql = null;

        if (workplanArea.getProvtype() == 3) {
            sql = "select count(*) as total_provider\n"
                    + ",count(*) filter(where t.status is null) as not_submitted\n"
                    + ",count(*) filter(where t.status = 1) as waiting\n"
                    + ",count(*) filter(where t.status = 2) as approved\n"
                    + ",count(*) filter(where t.status = 3) as disapproved\n"
                    + ",count(*) filter(where t.status = 4) as resubmitted\n"
                    + "from web_monthly_workplan_dashboard_fwa(" + workplanArea.getZillaid() + "," + workplanArea.getUpazilaid() + "," + workplanArea.getUnionid() + "," + workplanArea.getProvtype() + "," + workplanArea.getMonth() + "," + workplanArea.getYear() + ") t;";
        } else if (workplanArea.getProvtype() == 10) {
            sql = "select * from web_monthly_workplan_dashboard_fpi(" + workplanArea.getZillaid() + "," + workplanArea.getUpazilaid() + "," + workplanArea.getUnionid() + "," + workplanArea.getProvtype() + "," + workplanArea.getMonth() + "," + workplanArea.getYear() + ");";
        }
        System.out.println("SQL: " + sql);
        Statement stmt = connection.createStatement();
        ResultSet resultSet = null;
        resultSet = stmt.executeQuery(sql);
        connection.close();
        return Convertor.convertResultSetIntoJSONWithDash(resultSet);
    }

    public JSONArray getFPIProviderList(WorkplanArea workplanArea, int type) throws SQLException, Exception {

        String where = "", status = "";
        if (workplanArea.getUpazilaid() != 0) {
            where += " and p.upazilaid = " + workplanArea.getUpazilaid();
            if (workplanArea.getUnionid() != 0) {
                where += " and p.unionid = " + workplanArea.getUnionid();
            }
        }
        switch (type) {
            case 0:
                status = "";
                break;
            case 1:
                status = "where t.status in (1,3,4)";
                break;
            case 2:
                status = "where t.status = " + type;
                break;
            case 3:
                status = "where t.status is null";
                break;
            case 4:
                status = "where t.status in (1,2,3,4)";
                break;
        }
        String sql = "select zillaid, upazilaid, name_upazila_eng(zillaid, upazilaid), unionid, name_union_eng(zillaid, upazilaid, unionid), provtype, providerid, provname, mobileno, work_plan_year, work_plan_mon, status from\n"
                + "(\n"
                + "	select distinct on (p.providerid) * from providerdb p\n"
                + "	left join ( select w.providerid, w.work_plan_year, w.work_plan_mon, w.status from  workplanmaster w where (w.work_plan_mon = " + workplanArea.getMonth() + " and w.work_plan_year = " + workplanArea.getYear() + ") \n"
                + "	) w USING (providerid)\n"
                + "	where \n"
                + "	p.zillaid = " + workplanArea.getZillaid() + " " + where + " \n"
                + "	and p.provtype = " + workplanArea.getProvtype() + " \n"
                + "	and active = 1\n"
                + ") t " + status + " order by name_upazila_eng, name_union_eng";

        System.out.println("SQL:" + sql);
        Statement stmt = connection.createStatement();
        ResultSet resultSet = null;
        resultSet = stmt.executeQuery(sql);
        connection.close();
        return Convertor.toJSON(resultSet);
    }

    public JSONArray getFWAProviderList(WorkplanArea workplanArea, int type) throws SQLException, Exception {
        String status = "";
        switch (type) {
            case 0:
                status = "";
                break;
            case 1:
                status = "where status in (1,3,4)";
                break;
            case 2:
                status = "where status = 2";
                break;
            case 3:
                status = "where status is null";
                break;
            case 4:
                status = "where status is not null";
                break;
        }
        String sql = "select * from web_monthly_workplan_dashboard_fwa(" + workplanArea.getZillaid() + "," + workplanArea.getUpazilaid() + "," + workplanArea.getUnionid() + "," + workplanArea.getProvtype() + "," + workplanArea.getMonth() + "," + workplanArea.getYear() + ") " + status;

        System.out.println("SQL:" + sql);
        Statement stmt = connection.createStatement();
        ResultSet resultSet = null;
        resultSet = stmt.executeQuery(sql);
        connection.close();
        return Convertor.toJSON(resultSet);
    }

    public JSONArray getWorkplan(int zillaid, int providerid, int provtype, int month, int year) throws SQLException, Exception {
        //String sql = "SELECT distinct wd.workplandate, wi.itemdes as activity, wm.status from workplanmaster wm\n" +
        String sql = "SELECT distinct wd.workplandate,  array_to_string(array_agg(wi.itemdes),',<br> ') as activity, wm.status from workplanmaster wm\n"
                + "join workplandetail wd \n"
                + "on wm.zillaid = wd.zillaid\n"
                + "and wm.upazilaid = wd.upazilaid\n"
                + "and wm.unionid = wd.unionid\n"
                + "and wm.providerid = wd.providerid\n"
                + "and wm.work_plan_mon = wd.work_plan_mon\n"
                + "and wm.work_plan_year = wd.work_plan_year\n"
                + "left join workplan_item wi\n"
                + "on wd.item = wi.itemcode\n"
                + "where wm.providerid = " + providerid + " and wm.work_plan_mon = " + month + " and wm.work_plan_year = " + year + " and wi.type= " + provtype + " group by wd.workplandate, wm.status  order by wd.workplandate";

        sql = "select distinct t.workplandate\n"
                + "	,array_to_string(array_agg(t.activity), ',<br> ') as activity\n"
                + "	,t.status as status\n"
                + "from (\n"
                + "	select d.workplandate\n"
                + "		,CASE \n"
                + "			WHEN CAST(i.itemcode AS int) = 1\n"
                + "				THEN coalesce(i.itemdes, '') || ' - ' || ' ইউনিট: ' || coalesce(u.unameban, '') || ', গ্রাম: ' || coalesce(v.villagename, '') || ', দম্পতি নম্বর: (' || coalesce(d.elcoFrom, 0) || ' - ' || coalesce(d.elcoTo, 0) || ')'\n"
                + "			WHEN CAST(i.itemcode AS int) = 16\n"
                + "				THEN coalesce(i.itemdes, '') || ' - ' || ' ইউনিট: ' || coalesce(u.unameban, '') || ', গ্রাম: ' || coalesce(v.villagename, '') || ', দম্পতি নম্বর: (' || coalesce(d.elcoFrom, 0) || ' - ' || coalesce(d.elcoTo, 0) || ')'\n"
                + "			WHEN CAST(i.itemcode AS int) = 9\n"
                + "				AND d.leaveType = 1\n"
                + "				THEN i.itemdes || ': বাৎসরিক'\n"
                + "			WHEN CAST(i.itemcode AS int) = 9\n"
                + "				AND d.leaveType = 2\n"
                + "				THEN i.itemdes || ': অসুস্থতা জনিত'\n"
                + "			WHEN CAST(i.itemcode AS int) = 9\n"
                + "				AND d.leaveType = 3\n"
                + "				THEN i.itemdes || ': মাতৃত্বকালীন'\n"
                + "			WHEN CAST(i.itemcode AS int) = 9\n"
                + "				AND d.leaveType = 5\n"
                + "				THEN i.itemdes || ': নৈমিত্তিক ছুটি'\n"
                + "			WHEN CAST(i.itemcode AS int) = 9\n"
                + "				AND d.leaveType = 6\n"
                + "				THEN i.itemdes || ': শ্রান্তি ও বিনোদন'\n"
                + "			WHEN CAST(i.itemcode AS int) = 9\n"
                + "				AND d.leaveType = 7\n"
                + "				THEN i.itemdes || ': ঐচ্ছিক ছুটি'\n"
                + "			WHEN CAST(i.itemcode AS int) = 9\n"
                + "				AND d.leaveType = 8\n"
                + "				THEN i.itemdes || ': সরকারী ছুটি'\n"
                + "			WHEN CAST(i.itemcode AS int) = 9\n"
                + "				AND d.leaveType = 9\n"
                + "				THEN i.itemdes || ': অন্যান্য'\n"
                + "			WHEN CAST(i.itemcode AS INT) = 3\n"
                + "				THEN i.itemdes || ':' || d.otherDec\n"
                + "			WHEN CAST(i.itemcode AS INT) = 12\n"
                + "				THEN i.itemdes || ':' || d.otherDec\n"
                + "			WHEN CAST(i.itemcode AS INT) = 13\n"
                + "				THEN i.itemdes || ':' || d.otherDec\n"
                + "			WHEN CAST(i.itemcode AS INT) = 17\n"
                + "				THEN i.itemdes || ':' || d.otherDec\n"
                + "			WHEN CAST(i.itemcode AS INT) = 4\n"
                + "				THEN i.itemdes || ':' || d.otherDec\n"
                + "			WHEN CAST(i.itemcode AS INT) = 18\n"
                + "				THEN i.itemdes || ':' || d.otherDec\n"
                + "			WHEN CAST(i.itemcode AS INT) = 2\n"
                + "				THEN i.itemdes || ': ইউনিয়ন:' || coalesce(un.unionname, '') || ';' || coalesce(cc.organization_name, '')\n"
                + "			ELSE coalesce(i.itemdes, '')\n"
                + "			END activity\n"
                + "		,m.status\n"
                + "	from workplanmaster m\n"
                + "	INNER JOIN workplandetail d on m.providerid = d.providerid\n"
                + "		and m.work_plan_year = d.work_plan_year\n"
                + "		and m.work_plan_mon = d.work_plan_mon\n"
                + "	INNER JOIN workplan_item i on d.item = i.itemcode\n"
                + "	LEFT OUTER JOIN FWAUnit u on d.unitNo = u.ucode\n"
                + "	LEFT JOIN community_clinic cc ON d.satcomclinicid = cc.organization_code\n"
                + "		and d.zillaid = cc.zillaid\n"
                + "		and d.upazilaid = cc.upazilaid\n"
                + "		and d.satcomclinicunion = cc.unionid\n"
                + "	INNER JOIN unions un on d.unionid = un.unionid\n"
                + "		and d.zillaid = un.zillaid\n"
                + "		and d.upazilaid = un.upazilaid\n"
                + "	LEFT OUTER JOIN village v on d.zillaid = v.zillaid\n"
                + "		and d.upazilaid = v.upazilaid\n"
                + "		and d.unionid = v.unionid\n"
                + "		and d.village = v.villageid\n"
                + "		and d.mouzaid = v.mouzaid\n"
                + "	WHERE m.providerId = " + providerid + "\n"
                + "		And i.type = " + provtype + "\n"
                + "		AND m.work_plan_year = " + year + "\n"
                + "		and m.work_plan_mon = " + month + "\n"
                + "	group by m.status\n"
                + "		,m.modifydate\n"
                + "		,m.work_plan_year\n"
                + "		,m.work_plan_mon\n"
                + "		,d.workplandate\n"
                + "		,d.status\n"
                + "		,i.itemcode\n"
                + "		,i.itemdes\n"
                + "		,d.unitNo\n"
                + "		,u.unameban\n"
                + "		,v.villagename\n"
                + "		,d.elcoFrom\n"
                + "		,d.elcoTo\n"
                + "		,d.leaveType\n"
                + "		,otherDec\n"
                + "		,un.unionname\n"
                + "		,cc.organization_name\n"
                + "	) t\n"
                + "group by t.workplandate ,t.status";
        System.out.println("SQL: " + sql);
        Statement stmt = connection.createStatement();
        ResultSet resultSet = null;
        resultSet = stmt.executeQuery(sql);
        connection.close();
        return Convertor.convertResultSetIntoJSONWithDash(resultSet);
    }

}
