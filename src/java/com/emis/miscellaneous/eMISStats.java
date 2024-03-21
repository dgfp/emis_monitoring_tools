package com.emis.miscellaneous;

import com.emis.utility.Convertor;
import com.emis.utility.Menu;
import com.emis.utility.Utility;
import com.rhis.db.DBManagerDistrict;
import com.rhis.db.DBManagerMonitoring;
import java.io.IOException;
import java.sql.ResultSet;
import java.util.HashMap;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.JSONArray;

/**
 * INSERT INTO public.web_modulereport ( modcode, modrep,
 * modreptitle,servlet_url, visible, sorted) VALUES (9, 920, 'Provider DB
 * Status', 'ProviderDB_STATUS', 1, 0);
 *
 * INSERT INTO public.web_roleaccess (roleid, modrep) VALUES (1, 920);
 *
 * @author Rangan
 */
@WebServlet(name = "eMISStats", urlPatterns = {"/eMISStats"})
public class eMISStats extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Menu.setMenu("MISCELLANEOUS", "eMISStats", request);
        request.getRequestDispatcher("WEB-INF/jsp/miscellaneous/eMISStats.jsp").forward(request, response);
    }

    DBManagerMonitoring db = null;

    private String getResultSet(String query) {
        ResultSet result = db.select(query);
        JSONArray json = new JSONArray();
        try {
            json = Convertor.toJSON(result);
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        }
        return json.toString();
    }

    private String executeSelect(String query, String districtId) {
        db = new DBManagerDistrict(Integer.parseInt(districtId));
        System.out.println("getURL: " + db.getURL());
        return getResultSet(query);
    }

    private String executeSelect(String query) {
        db = new DBManagerMonitoring();
        return getResultSet(query);

    }

    //private static String[] OLD_DISTRICTS= new String[] {"93","36","51","75"};
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = Utility.getParam("action", "", request);
        String divid = Utility.getParam("divid", "0", request);
        String zillaid = Utility.getParam("zillaid", "0", request);
        String upazilaid = Utility.getParam("upazilaid", "0", request);
        String unionid = Utility.getParam("unionid", "0", request);
        String mouzaid = Utility.getParam("mouzaid", "0", request);
        String villageid = Utility.getParam("villageid", "0", request);
        String report_type = Utility.getParam("report_type", "", request);
        String startDate = Utility.getParam("startDate", "", request);
        String endDate = Utility.getParam("endDate", "", request);

        HashMap<String, String> map = new HashMap<>();
        map.put("loginuser", "with u as (\n"
                + "	select distinct zillaid,upazilaid, unionid\n"
                + "	, userid::text providerid\n"
                + "	, name provname\n"
                + "	--, rolename\n"
                + "	--, cname as Level\n"
                + "	--, designation\n"
                + "	, d.designame typename\n"
                + "	, d.provtype\n"
                + "	from loginuser u \n"
                + "	--join web_userrole using(userid) \n"
                + "	--join web_role using(roleid)\n"
                + "	join web_userdesignation d on u.designation=d.id\n"
                + "	--join (select * from codelist where typename='UserLevel') c on c.code=u.userlevel \n"
                + "	where zillaid>0 and u.active=1 and d.provtype between 2 and 99\n"
                + "),\n"
                + "_db_all as (\n"
                + "select distinct zillaid,provtype, count(*)  total\n"
                + "from u \n"
                + "group by zillaid,provtype\n"
                + ")\n"
                + ", output as (\n"
                + "select \n"
                + "(select divisioneng from division where id=z.divid)::text Division, \n"
                + "(select zillanameeng from zilla where zillaid=d.zillaid)::text Zilla, \n"
                + "typename,\n"
                + "directorate,\n"
                + "d.*  from _db_all d \n"
                + "join zilla z using (zillaid)\n"
                + "left join providertype_directorate t using(provtype)\n"
                + ")\n"
                + "select o.* from  output o");
        
        map.put("providerdb", "with db as (\n"
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
                + "	select zillaid,provtype,count(*) total from providerdb \n"
                + "	where zillaid=SUBSTRING(current_database() FROM ''(?=\\w+)\\d{2}'')::integer and active=1 and provtype between 2 and 99 and provname !~''test''\n"
                + "	group by zillaid,provtype\n"
                + ")\n"
                + "select * from pd\n"
                + "\n"
                + "$body$) as (zillaid integer,provtype integer, total integer)',connstr) _sql from db\n"
                + "),\n"
                + "_db_all as (\n"
                + "select * \n"
                + "from dblink('dbname=RHIS_CENTRAL port=5412',(select array_to_string(array_agg(_sql),' union all ') from _db_single)) \n"
                + "as (zillaid integer,provtype integer, total integer)\n"
                + ")\n"
                + ", output as (\n"
                + "select \n"
                + "(select divisioneng from division where id=z.divid)::text Division, \n"
                + "(select zillanameeng from zilla where zillaid=d.zillaid)::text Zilla, \n"
                + "typename,\n"
                + "directorate,\n"
                + "d.*  from _db_all d \n"
                + "join zilla z using (zillaid)\n"
                + "left join providertype_directorate t using(provtype)\n"
                + "--join providertype using(provtype) --where zillaid=93\n"
                + "),\n"
                + "output2 as (\n"
                + "	select \n"
                + "	sum(total) filter(where typename='FWA') FWA\n"
                + "	,count(total) filter(where typename='FWV') FWV\n"
                + "	,count(total) filter(where typename='FPI') FPI\n"
                + "	,count(total) filter(where typename='SACMO_FP') SACMO\n"
                + "	from output\n"
                + ")\n"
                + "\n"
                + "select o.* from  output o ");

        
        startDate = (startDate.equals("")) ? "01/01/2015" : startDate;
        String dateWhere = "between to_date(''" + startDate + "'',''dd/mm/yyyy'') and to_date(''" + endDate + "'',''dd/mm/yyyy'')";
        String prsDate = "and date(endt) " + dateWhere;
        String communityDate = "date(systementrydate) "+dateWhere;
        String serviceDate = "date(visitdate) "+dateWhere;
        String bornDate = "date(outcomedate) "+dateWhere;
        //dateWhere = (startDate.equals("")) ? "" : " and date(endt) between to_date(''" + startDate + "'',''dd/mm/yyyy'') and to_date(''" + endDate + "'',''dd/mm/yyyy'')";
        map.put("stats", "with db as (\n"
                + "--select distinct zillaid,connstr(zillaid) from implemented_vw where zillaid not in (90,91)\n"
                + "  select zillaid,connstr(zillaid) from unnest((select array_agg(distinct zillaid) zillaid from implemented_vw \n"
                + "  --where zillaid  not in (90,91)\n"
                + "  )) zillaid\n"
                + "),\n"
                + "_db_single as (\n"
                + "select format('select * from dblink(''%s'',\n"
                + "$body$\n"
                + "with \n"
                + "pd as (\n"
                + "	select %s as zillaid\n"
                //+ "	,(select count(*) from (select distinct on(zillaid,upazilaid,unionid,mouzaid,villageid,hhno) 1 from member where zillaid=%s) t) household\n"
                + "	,(select count(*) from household where zillaid=%s "+prsDate+") household \n"
                + "	,(select count(*) from member where zillaid=%s "+prsDate+") member \n"
                + "	,(select count(*) from elco where "+ communityDate +") elco\n"
                + "	,(select count(*) from pregwomen where "+ communityDate +") pregwomen\n"
                + "	,(select count(*) from ancservice where "+ serviceDate +") ancservice\n"
                + "	,(select count(*) from delivery where "+bornDate+") delivery\n"
                + "	,(select count(*) from newborn where "+bornDate+") newborn\n"
                + "	,(select count(*) from pncservicechild where "+ serviceDate +") pncservicechild\n"
                + "	,(select count(*) from pncservicemother where "+ serviceDate +") pncservicemother\n"
                + "	,(select count(*) from death where date(deathdt) "+dateWhere+") death\n"
                + "	,(select count(*) from gpservice where "+ serviceDate +") gpservice\n"
                + ")\n"
                + "select * from pd\n"
                + "\n"
                + "$body$) as (\n"
                + "zillaid integer\n"
                + ", household integer\n"
                + ", member integer\n"
                + ", elco integer\n"
                + ", pregwomen integer\n"
                + ", ancservice integer\n"
                + ", delivery integer\n"
                + ", newborn integer\n"
                + ", pncservicechild integer\n"
                + ", pncservicemother integer\n"
                + ", death integer\n"
                + ", gpservice integer\n"
                + ")',connstr,zillaid,zillaid,zillaid) _sql from db\n"
                + "),\n"
                + "_db_all as (\n"
                + "select * \n"
                + "from dblink('dbname=RHIS_CENTRAL port=5412',(select array_to_string(array_agg(_sql),' union all ') from _db_single)) \n"
                + "	as (\n"
                + "	zillaid integer\n"
                + "	, household integer\n"
                + "	, member integer\n"
                + "	, elco integer\n"
                + "	, pregwomen integer\n"
                + "	, ancservice integer\n"
                + "	, delivery integer\n"
                + "	, newborn integer\n"
                + "	, pncservicechild integer\n"
                + "	, pncservicemother integer\n"
                + "	, death integer\n"
                + "	, gpservice integer\n"
                + "	)\n"
                + ")\n"
                + ", output as (\n"
                + "select \n"
                + "(select divisioneng from division where id=z.divid)::text Division, \n"
                + "(select zillanameeng from zilla where zillaid=d.zillaid)::text Zilla, \n"
                + "d.*  from _db_all d \n"
                + "join zilla z using (zillaid)\n"
                + ")\n"
                + "\n"
                + "--select array_to_string(array_agg(_sql),' union all ') from _db_single\n"
                + "\n"
                + " select * from  output");

        map.put("nrc", "with db as (\n"
                + "--select distinct zillaid,connstr(zillaid) from implemented_vw where zillaid not in (90,91)\n"
                + "  select zillaid,connstr(zillaid) from unnest((select array_agg(distinct zillaid)||42 from implemented_vw)) zillaid\n"
                + "),\n"
                + "_db_single as (\n"
                + "select format('select * from dblink(''%s'',\n"
                + "$body$\n"
                + "\n"
                + "with \n"
                + "pd as (\n"
                + "	select zillaid,(select count(*) from member where zillaid=nrc.zillaid) member, count(*) nrc from \n"
                + "	(SELECT generatedid,divid, zillaid\n"
                + "	FROM public.clientmap c  where zillaid=%s and providerid in (select providerid from providerdb where provtype in (4,5,6)) and not exists (select 1 from member m  where m.generatedid = c.generatedid)\n"
                + "	) nrc \n"
                + "	group by zillaid order by 3 desc limit 1\n"
                + ")\n"
                + "select * from pd\n"
                + "\n"
                + "$body$) as (\n"
                + "	zillaid integer\n"
                + "	, member bigint\n"
                + "	, nrc bigint\n"
                + ")',connstr,zillaid) _sql from db\n"
                + "),\n"
                + "_db_all as (\n"
                + "select * \n"
                + "from dblink('dbname=RHIS_CENTRAL port=5412',(select array_to_string(array_agg(_sql),' union all ') from _db_single)) \n"
                + "	as (\n"
                + "	zillaid integer\n"
                + "	, member bigint\n"
                + "	, nrc bigint\n"
                + "	)\n"
                + ")\n"
                + ", output as (\n"
                + "select \n"
                + "(select divisioneng from division where id=z.divid)::text Division, \n"
                + "(select zillanameeng from zilla where zillaid=d.zillaid)::text Zilla, \n"
                + "d.*  from _db_all d \n"
                + "join zilla z using (zillaid)\n"
                + "--order by 5 desc,4 desc\n"
                + ")\n"
                + "\n"
                + " select * from  output");
        map.put("unassigned_healthid", "with db as (\n"
                + "  select zillaid,connstr(zillaid) from unnest((select array_agg(distinct zillaid) zillaid from implemented_vw )) zillaid\n"
                + "),\n"
                + "_db_single as (\n"
                + "select format('select * from dblink(''%s'',\n"
                + "$body$\n"
                + "with \n"
                + "pd as (\n"
                + "	select %s as zillaid\n"
                + "	,(select count(*) from member where zillaid=%s ) member\n"
                + "	,(select count(*) from member where zillaid=%s and (generatedid=healthid or  length(healthid::text)<>11 or generatedid is null or healthid is null) ) unassigned_healthid\n"
                + ")\n"
                + "select * from pd\n"
                + "\n"
                + "$body$) as (\n"
                + "zillaid integer\n"
                + ", member bigint\n"
                + ", unassigned_healthid bigint\n"
                + ")',connstr,zillaid,zillaid,zillaid) _sql from db\n"
                + "),\n"
                + "_db_all as (\n"
                + "select * \n"
                + "from dblink('dbname=RHIS_CENTRAL port=5412',(select array_to_string(array_agg(_sql),' union all ') from _db_single)) \n"
                + "	as (\n"
                + "zillaid integer\n"
                + ", member bigint\n"
                + ", unassigned_healthid bigint\n"
                + "	)\n"
                + ")\n"
                + ", output as (\n"
                + "select \n"
                + "(select divisioneng from division where id=z.divid)::text Division, \n"
                + "(select zillanameeng from zilla where zillaid=d.zillaid)::text Zilla, \n"
                + "d.*  from _db_all d \n"
                + "join zilla z using (zillaid)\n"
                + "order by 5 desc,4 desc\n"
                + ")\n"
                + "\n"
                + "--select array_to_string(array_agg(_sql),' union all ') from _db_single\n"
                + "\n"
                + " select * from  output");

        //------------------------For Show Data --------------------------------------------------------------------------------------------
        String query = "";
        if (action.equals("showdata")) {
            query = map.get(report_type);
            System.out.println("Query: " + report_type + ":::" + query);
            String jsonString = executeSelect(query);
            response.setContentType("text/plain;charset=UTF-8");
            response.getWriter().write(jsonString);

        }

    }
}
