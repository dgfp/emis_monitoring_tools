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
public class NRCDao {

    private DBManagerDistrict db = null;
    private Connection connection = null;
    private String sql = null;

    public NRCDao() {
    }

    public NRCDao(int districtId) {
        db = new DBManagerDistrict(districtId);
        connection = db.openConnection();
    }

    public JSONArray getDistrictPRS(PRS prs) throws SQLException, Exception {
        prs = this.setStartDate(prs);
        ArrayList<Integer> districtIdList = this.getDistrictIdByDivision(prs.getDivid());
        ArrayList<JSONArray> JSONArrayList = new ArrayList<JSONArray>();
        for (int district : districtIdList) {
            if (prs.getStartDate().equals("")) {
                prs.setStartDate("01/01/2015");
            }
            sql = "select z.zillaid,\n"
                    + "	z.zillanameeng,\n"
                    + "	coalesce(cast (m.progress_population as numeric),0) progress_population,\n"
                    + "	coalesce(cast (c.non_registered_client as numeric),0) non_registered_client\n"
                    + "from\n"
                    + "  \n"
                    + "(select z.zillaid, z.zillanameeng from public.zilla z  where z.zillaid =" + district + ") z\n"
                    + "\n"
                    + "join\n"
                    + "(select m.zillaid, count(*) progress_population  from member m where m.zillaid= " + district + " and date(m.endt) between to_date('" + prs.getStartDate() + "','dd/mm/yyyy') and to_date('" + prs.getEndDate() + "','dd/mm/yyyy')  group by m.zillaid) m\n"
                    + "on z.zillaid=m.zillaid\n"
                    + "\n"
                    + "join (\n"
                    + "	select c.zillaid, count(*) non_registered_client  from clientmap c \n"
                    + "	where c.zillaid= " + district + " \n"
                    + "	and date(c.systementrydate) between to_date('" + prs.getStartDate() + "','dd/mm/yyyy') and to_date('" + prs.getEndDate() + "','dd/mm/yyyy') \n"
                    + "	and providerid in (select providerid from providerdb where provtype in (4,5,6)) \n"
                    + "	and not exists (select 1 from member mc  where mc.generatedid = c.generatedid)\n"
                    + "	group by c.zillaid\n"
                    + ") c\n"
                    + "on z.zillaid=c.zillaid\n"
                    + "order by 1;";
//            if (prs.getStartDate().equals("")) {
//                sql = "select * from fn_popprogress_zila('" + prs.getDivid() + "','" + district + "') where zillaid not in  (99)  order by zillanameeng asc";
//            } else {
//                sql = "select * from fn_popprogress_zila_date_wise('" + prs.getDivid() + "','" + district + "','" + prs.getStartDate() + "','" + prs.getEndDate() + "') where zillaid not in  (99)";
//            }
            db = new DBManagerDistrict(district);
            connection = db.openConnection();
            ResultSet resultSet = connection.createStatement().executeQuery(sql);
            JSONArray json = Convertor.convertResultSetIntoJSON(resultSet);
            JSONArrayList.add(json);
            System.out.println(sql);
        }
        connection.close();
        System.out.println(JSONArrayList);
        return Convertor.getMergeJsonArrays(JSONArrayList);
    }

    public JSONArray getUpazilaPRS(PRS prs) throws SQLException, Exception {
        prs = this.setStartDate(prs);
        if (prs.getStartDate().equals("")) {
            prs.setStartDate("01/01/2015");
        }
        sql = "select * from fn_popprogress_upazila_date_wise('" + prs.getDivid() + "',' " + prs.getZillaid() + " ','%','" + prs.getStartDate() + "','" + prs.getEndDate() + "') where zillaid not in  (99) order by upazilanameeng asc";
        sql = "select z.zillaid,\n"
                + "	z.zillanameeng,\n"
                + "	upz.upazilaid,\n"
                + "	upz.upazilanameeng,\n"
                + "	coalesce(cast (m.progress_population as numeric),0) progress_population,\n"
                + "	coalesce(cast (c.non_registered_client as numeric),0) non_registered_client\n"
                + "from\n"
                + "  \n"
                + "(select z.zillaid, z.zillanameeng from public.zilla z  where z.zillaid =" + prs.getZillaid() + ") z\n"
                + "\n"
                + "join\n"
                + "(select upz.zillaid, upz.upazilaid, upz.upazilanameeng, upz.upazilaname  from public.upazila upz where upz.zillaid = " + prs.getZillaid() + ") upz\n"
                + "on z.zillaid=upz.zillaid\n"
                + "\n"
                + "join\n"
                + "(select m.zillaid, m.upazilaid, count(*) progress_population  from member m where m.zillaid= " + prs.getZillaid() + " and date(m.endt) between to_date('" + prs.getStartDate() + "','dd/mm/yyyy') and to_date('" + prs.getEndDate() + "','dd/mm/yyyy')  group by m.zillaid,m.upazilaid) m\n"
                + "on upz.zillaid=m.zillaid and upz.upazilaid= m.upazilaid\n"
                + "\n"
                + "join (\n"
                + "	select c.zillaid, c.upazilaid, count(*) non_registered_client  from clientmap c \n"
                + "	where c.zillaid= " + prs.getZillaid() + "\n"
                + "	and date(c.systementrydate) between to_date('" + prs.getStartDate() + "','dd/mm/yyyy') and to_date('" + prs.getEndDate() + "','dd/mm/yyyy') \n"
                + "	and providerid in (select providerid from providerdb where provtype in (4,5,6)) \n"
                + "	and not exists (select 1 from member mc  where mc.generatedid = c.generatedid)\n"
                + "	group by c.zillaid,c.upazilaid\n"
                + ") c\n"
                + "on upz.zillaid=c.zillaid and upz.upazilaid= c.upazilaid\n"
                + "\n"
                + "order by 1;";

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
        //sql = "select * from fn_popprogress_un_date_wise('" + prs.getDivid() + "','" + prs.getZillaid() + "','" + prs.getUpazilaid() + "','" + prs.getUnionid() + "','" + prs.getStartDate() + "','" + prs.getEndDate() + "') where zillaid not in  (99) order by unionnameeng asc";

        sql = "select z.zillaid,\n"
                + "	--z.zillanameeng,\n"
                + "	upz.upazilaid,\n"
                + "	--upz.upazilanameeng,\n"
                + "	un.reporting_unionid,\n"
                + "	un.unionnameeng,\n"
                + "	coalesce(cast (m.progress_population as numeric),0) progress_population,\n"
                + "	coalesce(cast (c.non_registered_client as numeric),0) non_registered_client\n"
                + "from\n"
                + "  \n"
                + "(select z.zillaid, z.zillanameeng from public.zilla z  where z.zillaid =" + prs.getZillaid() + ") z\n"
                + "\n"
                + "join\n"
                + "(select upz.zillaid, upz.upazilaid, upz.upazilanameeng, upz.upazilaname  from public.upazila upz where upz.zillaid = " + prs.getZillaid() + " and upz.upazilaid = " + prs.getUpazilaid() + ") upz\n"
                + "on z.zillaid=upz.zillaid\n"
                + "\n"
                + "join \n"
                + "(select * from reporting_union  where zillaid = " + prs.getZillaid() + " and upazilaid = " + prs.getUpazilaid() + ") un\n"
                + "on upz.zillaid=un.zillaid and upz.upazilaid = un.upazilaid\n"
                + "\n"
                + "left join\n"
                + "(select m.zillaid, m.upazilaid, h.reporting_unionid,  count(*) progress_population from member m \n"
                + "join member_household h using(zillaid, upazilaid, unionid, mouzaid, villageid, hhno)\n"
                + "where m.zillaid= " + prs.getZillaid() + " and m.upazilaid = " + prs.getUpazilaid() + " and date(m.endt) between to_date('" + prs.getStartDate() + "','dd/mm/yyyy') and to_date('" + prs.getEndDate() + "','dd/mm/yyyy')  group by m.zillaid,m.upazilaid, h.reporting_unionid) m\n"
                + "on upz.zillaid=m.zillaid and upz.upazilaid= m.upazilaid and un.reporting_unionid = m.reporting_unionid\n"
                + "\n"
                + "left join (\n"
                + "	select c.zillaid, c.upazilaid, c.unionid, count(*) non_registered_client  from clientmap c \n"
                + "	--left join member_household h using(zillaid, upazilaid, unionid, mouzaid, villageid, hhno)\n"
                + "	where c.zillaid= " + prs.getZillaid() + " and c.upazilaid = " + prs.getUpazilaid() + " \n"
                + "	and date(c.systementrydate) between to_date('" + prs.getStartDate() + "','dd/mm/yyyy') and to_date('" + prs.getEndDate() + "','dd/mm/yyyy')\n"
                + "	and c.providerid in (select providerid from providerdb where provtype in (4,5,6)) \n"
                + "	and not exists (select 1 from member mc  where mc.generatedid = c.generatedid)\n"
                + "	group by c.zillaid, c.upazilaid, c.unionid\n"
                + ") c\n"
                + "on upz.zillaid=c.zillaid and upz.upazilaid= c.upazilaid and un.reporting_unionid = c.unionid\n"
                + "\n"
                + "order by 1;";

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
