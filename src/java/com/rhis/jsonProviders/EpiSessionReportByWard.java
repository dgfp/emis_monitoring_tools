package com.rhis.jsonProviders;

import com.emis.utility.Convertor;
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
 *
 * @author shahaz
 */
@WebServlet(name = "EpiSessionReportByWard", urlPatterns = {"/episessionreportbyward"})
public class EpiSessionReportByWard extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String districtId = request.getParameter("districtId");
        String upazilaId = request.getParameter("upazilaId");
        String unionId = request.getParameter("unionId");
         String year = request.getParameter("year");
        
        try {

            DBManagerDistrict db = new DBManagerDistrict(Integer.parseInt(districtId));
            String sql ="SELECT \"wordOld\", \"subBlockId\", \"centerName\", \"KhanaNoFrom\", \"KhanaNoTo\",\"centerType\" ,\n" +
"  MAX(CASE WHEN extract(year from \"scheduleDate\") = e.\"scheduleYear\" and  extract(month from \"scheduleDate\") = '1' THEN extract(day from \"scheduleDate\") ELSE NULL END) as \"January\",\n" +
"  MAX(CASE WHEN extract(year from \"scheduleDate\") = e.\"scheduleYear\" and  extract(month from \"scheduleDate\") = '2' THEN extract(day from \"scheduleDate\") ELSE NULL END) as \"February\",\n" +
"  MAX(CASE WHEN extract(year from \"scheduleDate\") = e.\"scheduleYear\" and  extract(month from \"scheduleDate\") = '3' THEN extract(day from \"scheduleDate\") ELSE NULL END) as \"March\",\n" +
"  MAX(CASE WHEN extract(year from \"scheduleDate\") = e.\"scheduleYear\" and  extract(month from \"scheduleDate\") = '4' THEN extract(day from \"scheduleDate\") ELSE NULL END) as \"April\",\n" +
"  MAX(CASE WHEN extract(year from \"scheduleDate\") = e.\"scheduleYear\" and  extract(month from \"scheduleDate\") = '5' THEN extract(day from \"scheduleDate\") ELSE NULL END) as \"May\",\n" +
"  MAX(CASE WHEN extract(year from \"scheduleDate\") = e.\"scheduleYear\" and  extract(month from \"scheduleDate\") = '6' THEN extract(day from \"scheduleDate\") ELSE NULL END) as \"June\",\n" +
"  MAX(CASE WHEN extract(year from \"scheduleDate\") = e.\"scheduleYear\" and  extract(month from \"scheduleDate\") = '7' THEN extract(day from \"scheduleDate\") ELSE NULL END) as \"July\",\n" +
"  MAX(CASE WHEN extract(year from \"scheduleDate\") = e.\"scheduleYear\" and  extract(month from \"scheduleDate\") = '8' THEN extract(day from \"scheduleDate\") ELSE NULL END) as \"August\",\n" +
"  MAX(CASE WHEN extract(year from \"scheduleDate\") = e.\"scheduleYear\" and  extract(month from \"scheduleDate\") = '9' THEN extract(day from \"scheduleDate\") ELSE NULL END) as \"September\",\n" +
"  MAX(CASE WHEN extract(year from \"scheduleDate\") = e.\"scheduleYear\" and  extract(month from \"scheduleDate\") = '10' THEN extract(day from \"scheduleDate\") ELSE NULL END) as \"october\",\n" +
"  MAX(CASE WHEN extract(year from \"scheduleDate\") = e.\"scheduleYear\" and  extract(month from \"scheduleDate\") = '11' THEN extract(day from \"scheduleDate\") ELSE NULL END) as \"November\",\n" +
"  MAX(CASE WHEN extract(year from \"scheduleDate\") = e.\"scheduleYear\" and  extract(month from \"scheduleDate\") = '12' THEN extract(day from \"scheduleDate\") ELSE NULL END) as \"December\"\n" +
"  FROM public.\"epiSchedulerUpdate\" as e where "
                    + "\"Dist\" = " + districtId + " "
                    + "and \"Upz\"= " + upazilaId + " "
                    + "and \"UN\"= " + unionId +" "
                     + "and \"scheduleYear\"= " + year +" "
                    
                   + "group by \"wordOld\", \"subBlockId\", \"centerName\", \"KhanaNoFrom\", \"KhanaNoTo\",\"centerType\" order by  \"wordOld\",\"subBlockId\"";
                     ResultSet result = db.select(sql);
//             JSONArray json = new JSONArray();
//                if(result.next()){
//                    JSONObject jo = new JSONObject();
//                    jo.put("count",result.getInt(1));
//                   // jo.put("query",sql);
//                     json.put(jo);
//                }
DBManagerDistrict db2 = new DBManagerDistrict(Integer.parseInt(districtId));
//String person = "SELECT \"Divid\", zillaid, upazilaid, unionid, \"ProvType\", \"ProvCode\", \n" +
//"       \"ProvName\", \"MobileNo\", \"EnDate\", \"ExDate\", \"Active\", \"DeviceSetting\", \n" +
//"       \"SystemUpdateDT\", \"HealthIDRequest\", \"TableStructureRequest\", \n" +
//"       \"AreaUpdate\", \"supervisorCode\", \"ProvPass\", \"FacilityName\", csba\n" +
//"  FROM public.\"ProviderDB\"  where  \"Divid\" = 30 and zillaid=93 and upazilaid=85 and unionid=54;";
String person = "SELECT distinct d.\"Divid\", d.zillaid, d.upazilaid, d.unionid, d.\"ProvType\",t.\"TypeName\", d.\"ProvCode\",d.\"ProvName\", d.\"MobileNo\", a.\"Ward\"\n" +
"FROM public.\"ProviderDB\"  as d\n" +
"left join public.\"ProviderArea\"  as a on d.\"ProvCode\" = a.\"provCode\" \n" +
" left join public.\"ProviderType\" as t  on d.\"ProvType\" = t.\"ProvType\" where "
          + "d.zillaid = " + districtId + " "
                    + "and d.upazilaid= " + upazilaId + " "
                    + "and d.unionid= " + unionId +" order by  d.\"ProvType\"";

String bar = "SELECT distinct \"Div\", \"Dist\", \"Upazila\", \"Year\", \"Bar1\",b1.\"CName\", \"Bar2\",b2.\"CName\", \"Bar3\",u.\"UPAZILANAME\",z.\"ZILLANAME\" FROM public.\"epiSessionBar\" as  b\n" +
"  left join public.\"Upazila\" as u on b.\"Upazila\" = u.\"UPAZILAID\" and b.\"Dist\" = u.\"ZILLAID\"\n" +
"  left join public.\"Zilla\" as z on b.\"Dist\" = z.\"ZILLAID\"\n" +
"  left join public.\"CodeList\" as b1 on b.\"Bar1\" = cast(b1.\"Code\" as integer)\n" +
"  left join public.\"CodeList\" as b2 on b.\"Bar2\" = cast(b2.\"Code\" as integer)\n" +
"  where b1.\"TypeName\" = 'bar' and b2.\"TypeName\" = 'bar' and "
          + "\"Dist\" = " + districtId + " "
                    + "and \"Upazila\"= " + upazilaId + " "
                    + "and  \"Year\"= " + year +" order by  \"Year\"";

//String person = "SELECT distinct d.\"Divid\", d.zillaid, d.upazilaid, d.unionid, d.\"ProvType\", d.\"ProvCode\", \n" +
//"       d.\"ProvName\", d.\"MobileNo\", a.\"Ward\"\n" +
//"  FROM public.\"ProviderDB\"  d\n" +
//"  left join public.\"ProviderArea\"  a  on d.\"ProvCode\" = a.\"provCode\"  where "
//          + "d.zillaid = " + districtId + " "
//                    + "and d.upazilaid= " + upazilaId + " "
//                    + "and d.unionid= " + unionId +" order by  d.\"ProvType\"";

            ResultSet rPerson = db2.select(person);
            DBManagerDistrict db3 = new DBManagerDistrict(Integer.parseInt(districtId));
            ResultSet rbar = db3.select(bar);
           JSONArray json = Convertor.convertResultSetIntoJSON(result);
           JSONArray json1 = Convertor.convertResultSetIntoJSON(rPerson);
            JSONArray json3 = Convertor.convertResultSetIntoJSON(rbar);
            response.setContentType("text/plain;charset=UTF-8");
           String responseJson1=json.toString();
           String responseJson2=json1.toString();
           String responseJson3=json3.toString();
           
       
//            response.getWriter().write("{\"epi\":[\n" +
//"    {\"firstName\":\"John\", \"lastName\":\"Doe\"},\n" +
//"    {\"firstName\":\"Anna\", \"lastName\":\"Smith\"},\n" +
//"    {\"firstName\":\"Peter\", \"lastName\":\"Jones\"}\n" +
//"],\"employees\":[\n" +
//"    {\"firstName\":\"John\", \"lastName\":\"Doe\"},\n" +
//"    {\"firstName\":\"Anna\", \"lastName\":\"Smith\"},\n" +
//"    {\"firstName\":\"Peter\", \"lastName\":\"Jones\"}\n" +
//"]}");
//       {"epi":[
//    {"firstName":"John", "lastName":"Doe"},
//    {"firstName":"Anna", "lastName":"Smith"},
//    {"firstName":"Peter", "lastName":"Jones"}
//],"employees":[
//    {"firstName":"John", "lastName":"Doe"},
//    {"firstName":"Anna", "lastName":"Smith"},
//    {"firstName":"Peter", "lastName":"Jones"}
//]}     

response.getWriter().write("{\"epi\":"+responseJson1+",\"provider\":"+responseJson2+",\"bar\":"+responseJson3+"}");

        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        }

    }

}
