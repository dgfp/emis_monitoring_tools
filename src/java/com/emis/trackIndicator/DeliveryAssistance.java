package com.emis.trackIndicator;

import com.emis.utility.Convertor;
import com.emis.utility.Menu;
import com.emis.utility.Utility;
import com.rhis.db.DBManagerDistrict;
import java.io.IOException;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.JSONArray;

/**
 * @author Helal | m.helal.k@gmail.com | 2019-01-29
 */
@WebServlet(name = "DeliveryAssistance", urlPatterns = {"/delivery-assistance"})
public class DeliveryAssistance extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Menu.setMenu("TRACK INDICATOR", "delivery-assistance", request);
        request.getRequestDispatcher("WEB-INF/jsp/trackIndicator/DeliveryAssistance.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        //ObjectMapper mapper = new ObjectMapper();
        //mapper.writeValue(response.getOutputStream(), meta);
        //?zillaid=69&providerid=93659
        String divid = Utility.getParam("divid", "0", request);
        String zillaid = Utility.getParam("zillaid", "0", request);
        String upazilaid = Utility.getParam("upazilaid", "0", request);
        String unionid = Utility.getParam("unionid", "0", request);
        String action = Utility.getParam("action", "0", request);
        String indicator = Utility.getParam("indicator", "1", request);
        String myreport="delivery_livebirth";
        
        if(indicator.equals("1")){
            myreport="delivery_livebirth";
        }
        else if(indicator.equals("2")){
            myreport="delivery_women";
        }
        else if(indicator.equals("3")){
            myreport="delivery_facility";
        }
  
        String query = "with delivery_assistance_place as (\n"
                + "--outcometype (1= Normal, 2 = Cesarean) \n"
                + "	select --distinct on(healthid,pregno) \n"
                + "	zillaid,upazilaid,unionid\n"
                + "	,extract(year from coalesce(outcomedate,systementrydate))::int outcome_year\n"
                + "	,extract(month from coalesce(outcomedate,systementrydate))::int outcome_month\n"
                + "	,date_trunc('month',coalesce(outcomedate,systementrydate))::date outcome_month_trunc\n"
                + "	--,to_char(coalesce(outcomedate,systementrydate), 'Month, YYYY') full_month\n"
                + "	,d.healthid,pregno\n"
                + "	,outcometype\n"
                + "	,coalesce(outcomedate,systementrydate)::date outcomedate\n"
                + "	,outcomeplace\n"
                + "	,(outcomeplace not in (1))::int facility\n"
                + "	,outcometype\n"
                + "	,attendantdesignation\n"
                + "	,(attendantdesignation between 1 and 6)::int skilled_attendant\n"
                + "	,coalesce(livebirth,0) livebirth\n"
                + "	,coalesce(stillbirth,0) stillbirth \n"
                + "	,(coalesce(livebirth,0)+coalesce(stillbirth,0)) totalbirth\n"
                + "	from delivery d\n"
                + "	join member m on m.generatedid=d.healthid\n"
                + "	where (coalesce(livebirth,0)+coalesce(stillbirth,0))>0\n"
                + "),\n"
                + "delivery_livebirth as (\n"
                + "	select outcome_month_trunc, zillaid,upazilaid, sum(livebirth) livebirth,count(*) filter(where skilled_attendant=1) skilled_attendant, (100* count(*) filter(where skilled_attendant=1)::numeric/ nullif(sum(livebirth),0))::int percentage\n"
                + "	from delivery_assistance_place\n"
                + "	group by outcome_month_trunc, zillaid,upazilaid\n"
                + "	order by outcome_month_trunc desc,3,4\n"
                + "),\n"
                + "delivery_women as (\n"
                + "	select outcome_month_trunc, zillaid,upazilaid, sum(1) delivered_women,count(*) filter(where skilled_attendant=1) skilled_attendant, (100* count(*) filter(where skilled_attendant=1)::numeric/ nullif(sum(1),0))::int percentage\n"
                + "	from delivery_assistance_place\n"
                + "	group by outcome_month_trunc, zillaid,upazilaid\n"
                + "	order by outcome_month_trunc desc,3,4\n"
                + "),\n"
                + "delivery_facility as (\n"
                + "	select outcome_month_trunc, zillaid,upazilaid, sum(1) delivered_women,count(*) filter(where facility=1) facility, (100* count(*) filter(where facility=1)::numeric/ nullif(sum(1),0))::int percentage\n"
                + "	from delivery_assistance_place\n"
                + "	group by outcome_month_trunc, zillaid,upazilaid\n"
                + "	order by outcome_month_trunc desc,3,4\n"
                + ")\n"
                + "\n"
                + "\n"
                + "\n"
                + "\n"
                + "select upazilanameeng,d.* from  "+myreport+" d\n"
                + "join upazila using(zillaid,upazilaid)";
        System.out.println("Action::" + action);

        DBManagerDistrict db = new DBManagerDistrict(Integer.parseInt(zillaid));

//        if (action.equals("getZilla")) {
//            query = "SELECT data from __map_zilla(%s);";
//            query = String.format(query, divid);
//        }
        
        ResultSet result = db.select(query);
        JSONArray json = new JSONArray();
        try {
            json = Convertor.toJSON(result);
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        }

        //String json = db.one(query, "data");
        response.setContentType("text/plain;charset=UTF-8");
        response.getWriter().write(json.toString());

        System.out.println("query: " + action + ": " + query);
    }

}
