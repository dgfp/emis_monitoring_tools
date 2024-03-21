package com.emis.dao;

import com.emis.entity.AssetReport;
import com.emis.utility.Convertor;
import com.emis.utility.Print;
import com.rhis.db.DBManagerDistrict;
import com.rhis.db.DBManagerMonitoring;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import org.json.JSONArray;

/**
 *
 * @author Helal
 */
public class AssetDashboardDaoBAK {

    private DBManagerMonitoring db = null;
    private Connection connection = null;

    public AssetDashboardDaoBAK() {
        db = new DBManagerMonitoring();
        connection = db.openConnection();
    }

    public AssetDashboardDaoBAK(int districtId) {
        db = new DBManagerDistrict(districtId);
        connection = db.openConnection();
    }

    public JSONArray getTabletStockStatus(AssetReport asset) throws SQLException, Exception {

        String sql = "select \n"
                + "	modelname, \n"
                + "	count(*) tablet_purchased,\n"
                + "	--Tablet Distributed\n"
                + "	count(*) filter(where dh.statusid=1 and dh.locationid=1) as tablet_distributed_functional_user,\n"
                + "	count(*) filter(where dh.statusid=1 and dh.locationid=3) as tablet_distributed_functional_local_store,\n"
                + "	count(*) filter(where dh.statusid=2 and dh.locationid=4) as tablet_distributed_repaired_functional_user,\n"
                + "	count(*) filter(where dh.statusid=2 and dh.locationid=6) as tablet_distributed_repaired_functional_local_store,\n"
                + "	count(*) filter(where dh.statusid=3 and dh.locationid=7) as tablet_distributed_non_functional_user,\n"
                + "	count(*) filter(where dh.statusid=3 and dh.locationid=9) as tablet_distributed_non_functional_local_store,\n"
                + "	count(*) filter(where dh.statusid=3 and dh.locationid=10) as tablet_distributed_non_functional_vendor,\n"
                + "	--Tablet in central store\n"
                + "	count(*) filter(where dh.statusid=1 and dh.locationid=2) as tablet_in_central_store_functional,\n"
                + "	count(*) filter(where dh.statusid=2 and dh.locationid=5) as tablet_in_central_store_repaired_functional,\n"
                + "	count(*) filter(where dh.statusid=3 and dh.locationid=8) as tablet_in_central_store_non_functional\n"
                + "	--count(*) filter(where dh.statusid=1 and dh.statusid=2 and dh.statusid=3 and dh.locationid=3 and dh.locationid=6 and dh.locationid=9 and dh.locationid=10) as tablet_distributed,\n"
                + "	--count(*) filter(where dh.statusid=1 and dh.statusid=2 and dh.statusid=3 and dh.locationid=2 and dh.locationid=5 and dh.locationid=8) as tablet_in_central_store\n"
                + "from web_asset_device_master ms\n"
                + "left join web_asset_distribution_history dh using (imei1)\n"
                + "left join web_asset_model ml on ms.model::int = ml.modelid \n"
                + "where dh.active = 1 " + this.getWhereByUserLevel(asset) + " \n"
                + "group by modelname";
        Print.o("Tablet Stock Status:-");
        Print.o(sql);
        ResultSet resultSet = connection.createStatement().executeQuery(sql);
        connection.close();
        return Convertor.toJSON(resultSet);
    }

    public JSONArray getTabletFunctionalityStatus(AssetReport asset) throws SQLException, Exception {
        String sql = "select \n"
                + "	modelname\n"
                + "	,count(*) tablet_purchased\n"
                + "	,count(*) filter(where dh.statusid=1 or dh.statusid=2) as functional\n"
                + "	,count(*) filter(where dh.statusid=3) as repairable\n"
                + "	,count(*) filter(where dh.statusid=4) as damaged\n"
                + "	,count(*) filter(where dh.statusid=5) as lost\n"
                + "from web_asset_device_master ms\n"
                + "left join web_asset_distribution_history dh using (imei1)\n"
                + "left join web_asset_model ml on ms.model::int = ml.modelid \n"
                + "where dh.active = 1 " + this.getWhereByUserLevel(asset) + " \n"
                + "group by modelname";
        Print.o(sql);
        ResultSet resultSet = connection.createStatement().executeQuery(sql);
        connection.close();
        return Convertor.toJSON(resultSet);
    }

    public JSONArray getAgeOfTablet(AssetReport asset) throws SQLException, Exception {
        //Previous logic
        String sql = "select \n"
                + "	modelname\n"
                + "	,count(*) tablet_purchased\n"
                + "	,count(*) filter(where (date_part('year',age(now()::date, dh.receiveddate::date))::int)<1 ) as less_than_one_year\n"
                + "	--,count(*) filter(where ( date_part('year',age(now()::date, dh.receiveddate::date))::int) BETWEEN 1 AND 2 ) as one_to_two_years\n"
                + "	--,count(*) filter(where (date_part('year',age(now()::date, dh.receiveddate::date))::int) BETWEEN 2 AND 3 ) as two_to_three_years\n"
                + "	,count(*) filter(where (date_part('year',age(now()::date, dh.receiveddate::date))::int) >=1 and (date_part('year',age(now()::date, dh.receiveddate::date))::int) <2 ) as one_to_two_years\n"
                + "	,count(*) filter(where (date_part('year',age(now()::date, dh.receiveddate::date))::int) >=2 and (date_part('year',age(now()::date, dh.receiveddate::date))::int) <3 ) as two_to_three_years\n"
                + "	,count(*) filter(where (date_part('year',age(now()::date, dh.receiveddate::date))::int)>3 ) as more_than_three_year\n"
                + "from web_asset_device_master ms\n"
                + "left join web_asset_distribution_history dh using (imei1)\n"
                + "left join web_asset_model ml on ms.model::int = ml.modelid \n"
                + "where dh.active = 1  \n"
                + "group by modelname";
        //New logic
        sql = " select \n"
                + "	modelname\n"
                + "	,count(*) tablet_purchased\n"
                + "	,count(*) filter(where (datediff('month', dh.receiveddate::date, now()::date))<12 ) as less_than_12_months\n"
                + "	,count(*) filter(where (datediff('month', dh.receiveddate::date, now()::date)) >= 13 and (datediff('month', dh.receiveddate::date, now()::date)) <= 24 ) as between_13_and_24_months\n"
                + "	,count(*) filter(where (datediff('month', dh.receiveddate::date, now()::date)) >= 25 and (datediff('month', dh.receiveddate::date, now()::date)) <= 36 ) as between_25_and_36_months\n"
                + "	,count(*) filter(where (datediff('month', dh.receiveddate::date, now()::date))>36 ) as over_36_months\n"
                + "from web_asset_device_master ms\n"
                + "left join web_asset_distribution_history dh using (imei1)\n"
                + "left join web_asset_model ml on ms.model::int = ml.modelid \n"
                + "where dh.active = 1  \n"
                + "group by modelname;";
        Print.o("Age Of Tablet");
        Print.o(sql);
        ResultSet resultSet = connection.createStatement().executeQuery(sql);
        connection.close();
        return Convertor.toJSON(resultSet);
    }

    public JSONArray getTabletStatusByWarrantyPeriod(AssetReport asset) throws SQLException, Exception {
        String sql = "select \n"
                + "	distinct ms.purchaseddate, \n"
                + "	ms.warrentyperiod,\n"
                + "	ms.expireddate, \n"
                + "	modelname,\n"
                + "	count(*) tablet_purchased\n"
                + "from web_asset_device_master ms\n"
                + "left join web_asset_distribution_history dh using (imei1)\n"
                + "left join web_asset_model ml on ms.model::int = ml.modelid \n"
                + "where dh.active = 1  \n"
                + "group by purchaseddate, warrentyperiod, expireddate, modelname";
        Print.o(sql);
        ResultSet resultSet = connection.createStatement().executeQuery(sql);
        connection.close();
        return Convertor.toJSON(resultSet);
    }

    //Not used
    public JSONArray getProjectedPurchaseNeed(AssetReport asset) throws SQLException, Exception {
        String sql = "with db as (\n"
                + "  select zillaid,connstr(zillaid) from unnest((select array_agg(distinct zillaid)||42 zillaid from implemented_vw \n"
                + "  )) zillaid\n"
                + "),\n"
                + "_db_single as (\n"
                + "select format('select * from dblink(''%s'',\n"
                + "$body$\n"
                + "with \n"
                + "pd as (\n"
                + "	select zillaid, provtype, count(*) total from providerdb \n"
                + "	where zillaid=SUBSTRING(current_database() FROM ''(?=\\w+)\\d{2}'')::integer and active=1 and provtype between 2 and 99 and provname !~''test''\n"
                + "	group by zillaid, provtype\n"
                + ")\n"
                + "select * from pd\n"
                + "$body$) as (zillaid integer, provtype integer, total integer)',connstr) _sql from db\n"
                + "),\n"
                + "_db_all as (\n"
                + "select * \n"
                + "from dblink('dbname=RHIS_CENTRAL',(select array_to_string(array_agg(_sql),' union all ') from _db_single)) \n"
                + "as (zillaid integer, provtype integer, total integer)\n"
                + ")\n"
                + "\n"
                + "select provtype, typename, sum(total) total_user, ((sum(total))*10)/100 total_10_percent, \n"
                + "(\n"
                + "	select count(*) filter(where dh.statusid=1 or dh.statusid=2) as functional\n"
                + "	from web_asset_device_master ms left join web_asset_distribution_history dh using (imei1)\n"
                + "	where dh.active = 1 " + this.getWhereByUserLevel(asset)
                + ")  currently_functional\n"
                + "from _db_all a join providertype p using (provtype)  " + this.getProviderWhere(asset)
                + "group by provtype, typename order by provtype;";

        Print.o("Projected Purchase Need");
        Print.o(sql);
        ResultSet resultSet = connection.createStatement().executeQuery(sql);
        connection.close();
        return Convertor.toJSON(resultSet);
    }

    public JSONArray getProjectedPurchaseNeedByLevel(AssetReport asset) throws SQLException, Exception {
        String sql = "with db as (\n"
                + "  select zillaid,connstr(zillaid) from unnest((select array_agg(distinct zillaid)||42 zillaid from implemented_vw \n"
                + "  )) zillaid\n"
                + "),\n"
                + "_db_single as (\n"
                + "select format('select * from dblink(''%s'',\n"
                + "$body$\n"
                + "with \n"
                + "pd as (\n"
                + "	select divid, zillaid, upazilaid, provtype, count(*) total from providerdb \n"
                + "	where zillaid=SUBSTRING(current_database() FROM ''(?=\\w+)\\d{2}'')::integer and active=1 and provtype between 2 and 99 and provname !~''test''\n"
                + "	group by divid, zillaid, upazilaid, provtype\n"
                + ")\n"
                + "select * from pd\n"
                + "$body$) as (divid integer, zillaid integer, upazilaid integer, provtype integer, total integer)',connstr) _sql from db\n"
                + "),\n"
                + "_db_all as (\n"
                + "select * \n"
                + "from dblink('dbname=RHIS_CENTRAL',(select array_to_string(array_agg(_sql),' union all ') from _db_single)) \n"
                + "as (divid integer,zillaid integer, upazilaid integer, provtype integer, total integer)\n"
                + ")\n"
                + "\n"
                + ",provider as (\n"
                + "select provtype, typename, sum(total) total_user, ((sum(total))*10)/100 total_10_percent, \n"
                + "(\n"
                + "	select count(*) filter(where dh.statusid=1 or dh.statusid=2) as functional\n"
                + "	from web_asset_device_master ms left join web_asset_distribution_history dh using (imei1)\n"
                + "	where dh.active = 1  " + this.getWhereByUserLevel(asset)
                + ")  currently_functional\n"
                + "from _db_all a join providertype p using (provtype) where provtype not in (2,11,12,6,9,16,17,18) " + this.getProviderWhere2(asset) + " group by provtype, typename order by provtype)\n"
                + "\n"
                + "select \n"
                + "	sum(currently_functional) filter(where provtype=3) as currently_functional\n"
                + "	,sum(total_user+total_10_percent) filter(where provtype=3) as FWA\n"
                + "	,sum(total_user+total_10_percent) filter(where provtype=10) as FPI\n"
                + "	,sum(total_user+total_10_percent) filter(where provtype=4) as FWV\n"
                + "	\n"
                + "	,sum(total_user+total_10_percent) filter(where provtype=5) as SACMO\n"
                + "	,sum(total_user+total_10_percent) filter(where provtype=14 or provtype=15 or provtype=19) as upazila_office \n"
                + "	--,sum(total_user+total_10_percent) filter(where provtype=20 or provtype=21 or provtype=22) as district_office \n"
                + "	\n"
                + "	,(select total_user+((total_user*10)/100) total_user from (select count(1) total_user from loginuser where designation in (3,14,35) and active=1 " + this.getLoginUserWhere(asset) + " ) t) as district_office \n"
                + "	,(select total_user+((total_user*10)/100) total_user from (select count(1) total_user from loginuser where designation in (10,32,33,34,36) and active=1 " + this.getLoginUserWhere(asset) + ") t) as central_level \n"
                + "from provider ";

        Print.o("Projected Purchase Need");
        Print.o(sql);
        ResultSet resultSet = connection.createStatement().executeQuery(sql);
        connection.close();
        return Convertor.toJSON(resultSet);
    }

    public JSONArray getNumberOfTabletsLost(AssetReport asset) throws SQLException, Exception {
        String sql = "select\n"
                + "	distinct zillaid\n"
                + "	,name_zilla_eng(divid, zillaid) zillaname\n"
                + "	,count(*) filter(where dh.statusid=5) as lost\n"
                + "	,count(*) filter(where dh.statusid=5 and dh.lost_gd<>'') as gd_received\n"
                + "	,count(*) filter(where dh.statusid=5 and dh.lost_varified<>0) as gd_verified\n"
                + "from web_asset_device_master ms\n"
                + "left join web_asset_distribution_history dh using (imei1)\n"
                + "where dh.active = 1 " + this.getWhereByUserLevel(asset)
                + "group by zillaid, zillaname\n"
                + "order by zillaname;";

        sql = " select\n"
                + "	modelname\n"
                + "	,count(*) filter(where dh.statusid=5) as lost\n"
                + "	,count(*) filter(where dh.statusid=5 and dh.lost_gd<>'') as gd_received\n"
                + "	,count(*) filter(where dh.statusid=5 and dh.lost_varified=1) as gd_verified\n"
                + "from web_asset_device_master ms\n"
                + "left join web_asset_distribution_history dh using (imei1)\n"
                + "left join web_asset_model ml on ms.model::int = ml.modelid \n"
                + "where dh.active = 1  " + this.getWhereByUserLevel(asset)
                + "group by modelname";
        Print.o(sql);
        ResultSet resultSet = connection.createStatement().executeQuery(sql);
        connection.close();
        return Convertor.toJSON(resultSet);
    }

    public JSONArray getTabletRepairStatus(AssetReport asset) throws SQLException, Exception {
        String sql = "select \n"
                + "	modelname\n"
                + "	--,count(*) tablet_purchased\n"
                + "	,count(*) filter(where dh.statusid=3) as non_functional\n"
                + "	,count(*) filter(where dh.statusid=3 and dh.locationid=10) as sent_to_vendor\n"
                + "	,count(*) filter(where dh.statusid=2) as repaired\n"
                + "from web_asset_device_master ms\n"
                + "left join web_asset_distribution_history dh using (imei1)\n"
                + "left join web_asset_model ml on ms.model::int = ml.modelid \n"
                + "where dh.active = 1  \n"
                + "group by modelname";
        Print.o(sql);
        ResultSet resultSet = connection.createStatement().executeQuery(sql);
        connection.close();
        return Convertor.toJSON(resultSet);
    }

    public JSONArray getStatus(AssetReport asset) throws SQLException, Exception {
        String sql = "select\n"
                + "	count(*)  as purchased\n"
                + "	,count(*) filter(where dh.statusid=1) as functional\n"
                + "	,count(*) filter(where dh.statusid=2) as repaired_functional\n"
                + "	,count(*) filter(where dh.statusid=3) as repairable\n"
                + "	,count(*) filter(where dh.statusid=4) as damaged\n"
                + "	,count(*) filter(where dh.statusid=5) as lost\n"
                + "from web_asset_device_master ms\n"
                + "left join web_asset_distribution_history dh using (imei1)\n"
                + "where dh.active = 1 " + this.getWhereByUserLevel(asset);
        Print.o("Status Box: ");
        Print.o(sql);
        ResultSet resultSet = connection.createStatement().executeQuery(sql);
        connection.close();
        return Convertor.toJSON(resultSet);
    }

    //Not used
    public JSONArray getTotalProvider(AssetReport asset) throws SQLException, Exception {
        String sql = "with db as (\n"
                + "--select distinct zillaid,connstr(zillaid) from implemented_vw where zillaid not in (90,91)\n"
                + "  select zillaid,connstr(zillaid) from unnest((select array_agg(distinct zillaid)||42 zillaid from implemented_vw \n"
                + "  --where zillaid  not in (90,91)\n"
                + "  )) zillaid\n"
                + "),\n"
                + "_db_single as (\n"
                + "select format('select * from dblink(''%s'',\n"
                + "$body$\n"
                + "with \n"
                + "pd as (\n"
                + "	select zillaid,upazilaid,count(*) total from providerdb \n"
                + "	where zillaid=SUBSTRING(current_database() FROM ''(?=\\w+)\\d{2}'')::integer and active=1 and provtype between 2 and 99 and provname !~''test''\n"
                + "	group by zillaid,upazilaid\n"
                + ")\n"
                + "select * from pd\n"
                + "$body$) as (zillaid integer,upazilaid integer, total integer)',connstr) _sql from db\n"
                + "),\n"
                + "_db_all as (\n"
                + "select * \n"
                + "from dblink('dbname=RHIS_CENTRAL',(select array_to_string(array_agg(_sql),' union all ') from _db_single)) \n"
                + "as (zillaid integer,upazilaid integer, total integer)\n"
                + ")\n"
                + "select sum(total) total_provider from _db_all a " + this.getProviderWhere(asset);
        Print.o(sql);
        ResultSet resultSet = connection.createStatement().executeQuery(sql);
        connection.close();
        return Convertor.toJSON(resultSet);
    }

    public JSONArray getTotalAsset(AssetReport asset) throws SQLException, Exception {
        String sql = "SELECT count(*) total_asset FROM public.web_asset_device_master where active=1";
        Print.o(sql);
        ResultSet resultSet = connection.createStatement().executeQuery(sql);
        connection.close();
        return Convertor.toJSON(resultSet);
    }

    private String getWhereByUserLevel(AssetReport asset) {
        String where = "";
        if (asset.getDivid() != 0) {
            where += " and dh.divid=" + asset.getDivid() + " ";
        }
        if (asset.getZillaid() != 0) {
            where += " and dh.zillaid=" + asset.getZillaid() + " ";
        }
        if (asset.getUpazilaid() != 0) {
            where += " and dh.upazilaid=" + asset.getUpazilaid() + " ";
        }
        return where;
    }

    private String getProviderWhere(AssetReport asset) {
        String where = "";
        if (asset.getZillaid() != 0) {
            where += "where a.zillaid=" + asset.getZillaid() + " ";
        }
        if (asset.getUpazilaid() != 0) {
            where += " and a.upazilaid=" + asset.getUpazilaid() + " ";
        }
        return where;
    }

    private String getProviderWhere2(AssetReport asset) {
        String where = "";
        if (asset.getDivid() != 0) {
            where += "and a.divid=" + asset.getDivid() + " ";
        }
        if (asset.getZillaid() != 0) {
            where += "and a.zillaid=" + asset.getZillaid() + " ";
        }
        if (asset.getUpazilaid() != 0) {
            where += " and a.upazilaid=" + asset.getUpazilaid() + " ";
        }
        return where;
    }

    private String getLoginUserWhere(AssetReport asset) {
        String where = "";
        if (asset.getDivid() != 0) {
            where += "and divid=" + asset.getDivid() + " ";
        }
        if (asset.getZillaid() != 0) {
            where += "and zillaid=" + asset.getZillaid() + " ";
        }
        if (asset.getUpazilaid() != 0) {
            where += " and upazilaid=" + asset.getUpazilaid() + " ";
        }
        return where;
    }
}
