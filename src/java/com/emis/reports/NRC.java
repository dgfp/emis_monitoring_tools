package com.emis.reports;

import com.emis.utility.Convertor;
import com.emis.utility.Utility;
import com.rhis.db.DBManagerDistrict;
import com.rhis.db.DBManagerMonitoring;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
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
@WebServlet(name = "NRC", urlPatterns = {"/NRC"})
public class NRC extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("submenu", "NRC");
        request.setAttribute("menu", "VIEW REPORTS");
        RequestDispatcher view = request.getRequestDispatcher("WEB-INF/jsp/reports/NRC.jsp");
        view.forward(request, response);

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

        String in_params = String.join(",", zillaid, upazilaid, unionid);
        System.out.println("zillaid: " + zillaid + " in_params: " + in_params);

        //------------------------For Show Data --------------------------------------------------------------------------------------------
        if (action.equals("showdata")) {
            String condition= divid.equals("0")?"":"where divid="+divid;
            String query = "with db as (\n"
                    + "  select zillaid,connstr(zillaid) from unnest((select array_agg(distinct zillaid) zillaid from implemented_vw "+condition+" )) zillaid\n"
                    + "),\n"
                    + "_db_single as (\n"
                    + "select format('select * from dblink(''%s'',\n"
                    + "$body$\n"
                    + "with \n"
                    + "pd as (\n"
                    + "	select %s as zillaid\n"
                    + "	,(select count(*) from member where zillaid=%s ) member\n"
                    + "	,(select count(*) from member where zillaid=%s and (generatedid=healthid or generatedid is null or healthid is null) ) nrc\n"
                    + ")\n"
                    + "select * from pd\n"
                    + "\n"
                    + "$body$) as (\n"
                    + "zillaid integer\n"
                    + ", member bigint\n"
                    + ", nrc bigint\n"
                    + ")',connstr,zillaid,zillaid,zillaid) _sql from db\n"
                    + "),\n"
                    + "_db_all as (\n"
                    + "select * \n"
                    + "from dblink('dbname=RHIS_CENTRAL',(select array_to_string(array_agg(_sql),' union all ') from _db_single)) \n"
                    + "	as (\n"
                    + "zillaid integer\n"
                    + ", member bigint\n"
                    + ", nrc bigint\n"
                    + "	)\n"
                    + ")\n"
                    + ", output as (\n"
                    + "select \n"
                    + "(select divisioneng from division where id=z.divid)::text \"Division\", \n"
                    + "(select zillanameeng from zilla where zillaid=d.zillaid)::text \"Zilla\", \n"
                    + "d.*  from _db_all d \n"
                    + "join zilla z using (zillaid)\n"
                    + "order by 5 desc,4 desc\n"
                    + ")\n"
                    + "\n"
                    + "--select array_to_string(array_agg(_sql),' union all ') from _db_single\n"
                    + "\n"
                    + " select * from  output";

            if (zillaid.equals("0")) {
                System.out.println("Query: " + query);
                String jsonString = executeSelect(query);
                response.setContentType("text/plain;charset=UTF-8");
                response.getWriter().write(jsonString);
            }
            else{
                query="select form ";
            }

        }

    }
}
