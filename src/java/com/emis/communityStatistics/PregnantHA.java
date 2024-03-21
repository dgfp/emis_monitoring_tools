package com.emis.communityStatistics;

import com.emis.utility.Convertor;
import com.rhis.db.DBManagerDistrict;
import java.io.IOException;
import java.sql.ResultSet;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.JSONArray;

/**
 *
 * @author Helal
 */
@WebServlet(name = "PregnantHA", urlPatterns = {"/pregnantHA"})
public class PregnantHA extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("submenu", "pregnant");
        request.setAttribute("menu", "Community statistics");
        request.setAttribute("userLevel", (String) request.getSession(false).getAttribute("userLevel"));
        RequestDispatcher view = request.getRequestDispatcher("WEB-INF/jsp/communityStatistics/pregnantHA.jsp");
        view.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            String action = request.getParameter("action");
        
            if (action.equals("AggregateUpazila")) {
                String districtId = request.getParameter("districtId").length() == 0 ? "%" : request.getParameter("districtId");
                String startDate = convertToCustomDateFormat(request.getParameter("startDate"));
                String endDate = convertToCustomDateFormat(request.getParameter("endDate"));
                
                String query = "SELECT  * from public.fn_pregwomen_aggregate_upazila("+districtId+",'"+startDate+"','"+endDate+"');";
                try {
                    System.out.println(query);
                    DBManagerDistrict db = new DBManagerDistrict(Integer.parseInt(districtId));
                    ResultSet result = db.select(query);
                    JSONArray json = Convertor.convertResultSetIntoJSON(result);
                    response.setContentType("text/plain;charset=UTF-8");
                    System.out.println(json.toString());
                    response.getWriter().write(json.toString());
                } catch (Exception ex) {
                    ex.getMessage();
                }
                
            }else if (action.equals("AggregateUnion")) {
                String districtId = request.getParameter("districtId").length() == 0 ? "%" : request.getParameter("districtId");
                String upazilaId = request.getParameter("upazilaId").length() == 0 ? "%" : request.getParameter("upazilaId");
                String startDate = convertToCustomDateFormat(request.getParameter("startDate"));
                String endDate = convertToCustomDateFormat(request.getParameter("endDate"));

                String query = "SELECT  * from public.fn_pregwomen_aggregate_union("+districtId+","+upazilaId+",'"+startDate+"','"+endDate+"');";
                try {
                    System.out.println(query);
                    DBManagerDistrict db = new DBManagerDistrict(Integer.parseInt(districtId));
                    ResultSet result = db.select(query);
                    JSONArray json = Convertor.convertResultSetIntoJSON(result);
                    response.setContentType("text/plain;charset=UTF-8");
                    System.out.println(json.toString());
                    response.getWriter().write(json.toString());
                } catch (Exception ex) {
                    ex.getMessage();
                }
                
            }else if (action.equals("AggregateWard")) {
                String districtId = request.getParameter("districtId").length() == 0 ? "%" : request.getParameter("districtId");
                String upazilaId = request.getParameter("upazilaId").length() == 0 ? "%" : request.getParameter("upazilaId");  
                String unionId = request.getParameter("unionId").length() == 0 ? "%" : request.getParameter("unionId");
                String startDate = convertToCustomDateFormat(request.getParameter("startDate"));
                String endDate = convertToCustomDateFormat(request.getParameter("endDate"));

                String query = "SELECT  * from public.fn_pregwomen_aggregate_ward("+districtId+","+upazilaId+","+unionId+",'"+startDate+"','"+endDate+"');";
                
                try {
                    System.out.println(query);
                    DBManagerDistrict db = new DBManagerDistrict(Integer.parseInt(districtId));
                    ResultSet result = db.select(query);
                    JSONArray json = Convertor.convertResultSetIntoJSON(result);
                    response.setContentType("text/plain;charset=UTF-8");
                    System.out.println(json.toString());
                    response.getWriter().write(json.toString());
                } catch (Exception ex) {
                    ex.getMessage();
                }
                
            }else if (action.equals("AggregateVillage")) {
                String districtId = request.getParameter("districtId").length() == 0 ? "%" : request.getParameter("districtId");
                String upazilaId = request.getParameter("upazilaId").length() == 0 ? "%" : request.getParameter("upazilaId");  
                String unionId = request.getParameter("unionId").length() == 0 ? "%" : request.getParameter("unionId");
                String wardId = request.getParameter("wardId").length() == 0 ? "%" : request.getParameter("wardId");
                String startDate = convertToCustomDateFormat(request.getParameter("startDate"));
                String endDate = convertToCustomDateFormat(request.getParameter("endDate"));
                String query = "SELECT  * from public.fn_pregwomen_aggregate_villagebyward("+districtId+","+upazilaId+","+unionId+","+wardId+",'"+startDate+"','"+endDate+"');";
                try {
                    System.out.println(query);
                    DBManagerDistrict db = new DBManagerDistrict(Integer.parseInt(districtId));
                    ResultSet result = db.select(query);
                    JSONArray json = Convertor.convertResultSetIntoJSON(result);
                    response.setContentType("text/plain;charset=UTF-8");
                    System.out.println(json.toString());
                    response.getWriter().write(json.toString());
                } catch (Exception ex) {
                    ex.getMessage();
                }
                
            }else if (action.equals("Individual")) {
                String districtId = request.getParameter("districtId").length() == 0 ? "%" : request.getParameter("districtId");
                String upazilaId = request.getParameter("upazilaId").length() == 0 ? null : request.getParameter("upazilaId");
                String unionId = request.getParameter("unionId").length() == 0 ? null : request.getParameter("unionId");
                String wardId = request.getParameter("wardId").length() == 0 ? null : request.getParameter("wardId");
                String mouzaId = request.getParameter("mouzaId").length() == 0 ? null : request.getParameter("mouzaId");
                String villageId = request.getParameter("villageId").length() == 0 ? null : request.getParameter("villageId");
                String startDate = convertToCustomDateFormat(request.getParameter("startDate"));
                String endDate = convertToCustomDateFormat(request.getParameter("endDate"));
                
                String condition="";
                if(upazilaId==null){
                    condition="where m.sex='2' and m.ms='2' and m.zillaid="+districtId;
                }else if(unionId==null){
                    condition="where m.sex='2' and m.ms='2' and m.zillaid="+districtId+" and m.upazilaid="+upazilaId;
                }else if(wardId==null){
                    condition="where m.sex='2' and m.ms='2' and m.zillaid="+districtId+" and m.upazilaid="+upazilaId+"\n" +
                                    "and m.unionid="+unionId;
                }else if(mouzaId==null || villageId==null){
                    condition="where m.sex='2' and m.ms='2' and m.zillaid="+districtId+" and m.upazilaid="+upazilaId+"\n" +
                                    "and m.unionid="+unionId+"\n" +
                                    "and h.wardold='"+wardId+"'";
                }else if(mouzaId!=null && villageId!=null){
                    condition="where m.sex='2' and m.ms='2' and m.zillaid="+districtId+" and m.upazilaid="+upazilaId+"\n" +
                                    "and m.unionid="+unionId+"\n" +
                                    "and h.wardold='"+wardId+"'\n" +
                                    "and m.mouzaid="+mouzaId+" and m.villageid="+villageId;
                }
            
                String query="select preg.healthid ,elco.husbandname,elco.elcono,sp_villagenameeng(m.zillaid,m.upazilaId,m.unionid,m.mouzaid,m.villageid) villagenameeng \n" +
                ", m.nameeng, date_part('year', age(cast (m.dob as date))) as age, m.mobileno1 ,lmp,edd \n" +
                ",case when extract (day from edd-now())<0 then 'over due' else 'active' end \n" +
                "from pregwomen preg -- limit 10 \n" +
                "left join elco elco on  preg.healthid = elco.healthid  \n" +
                "left join member m on m.generatedid=preg.healthid \n" +
                "left join household h on  \n" +
                "m.zillaid=h.zillaid and m.upazilaId= h.upazilaId and m.unionid=h.unionid and m.mouzaid=h.mouzaid and m.villageid=h.villageid  and m.hhno=h.hhno \n" +
                "left join fwaunit unit on unit.ucode=h.unit "+condition+"   \n" +
                "and preg.systementrydate between to_date('"+startDate+"', 'yyyy/mm/dd') and to_date('"+endDate+"', 'yyyy/mm/dd')\n" +
                "and not exists (select 1 from delivery d where d.healthid=preg.healthid)";
                
                String sql="select preg.healthid \n" +
                ",elco.husbandname,elco.elcono,sp_villagenameeng(m.zillaid,m.upazilaId,m.unionid,m.mouzaid,m.villageid) villagenameeng \n" +
                ", m.nameeng, date_part('year', age(cast (m.dob as date))) as age, m.mobileno1 ,lmp,edd \n" +
                "from pregwomen preg -- limit 10 \n" +
                "left join elco elco on  preg.healthid = elco.healthid  \n" +
                "left join member m on m.generatedid=preg.healthid \n" +
                "left join household h on  \n" +
                "m.zillaid=h.zillaid and m.upazilaId= h.upazilaId and m.unionid=h.unionid and m.mouzaid=h.mouzaid and m.villageid=h.villageid  and m.hhno=h.hhno \n" +
                "left join fwaunit unit on unit.ucode=h.unit "+condition+"   \n" +
                "and preg.systementrydate between to_date('"+startDate+"', 'yyyy/mm/dd') and to_date('"+endDate+"', 'yyyy/mm/dd')\n" +
                "and exists (select 1 from delivery d where d.healthid=preg.healthid)";
                
                System.out.println(query);
                try {

                    DBManagerDistrict db = new DBManagerDistrict(Integer.parseInt(districtId));
                    ResultSet result = db.select(query);
                    
                    DBManagerDistrict db2 = new DBManagerDistrict(Integer.parseInt(districtId));
                    ResultSet result2 = db2.select(sql);

                    JSONArray json = Convertor.convertResultSetIntoJSON(result);
                    response.setContentType("text/plain;charset=UTF-8");
                    JSONArray json2 = Convertor.convertResultSetIntoJSON(result2);
                    response.setContentType("text/plain;charset=UTF-8");

                    System.out.println(json.toString() +" "+json2.toString());
                    response.getWriter().write("{\"current\":"+json.toString()+",\"completed\":"+json2.toString()+"}");
                    //response.getWriter().write(json.toString());

                } catch (Exception ex) {
                    ex.getMessage();
                }
            }
    }
    
    private String convertToCustomDateFormat(String date) {
        String[] parts = date.split("/");
        String day = parts[0];
        String month = parts[1];
        String year = parts[2];
        return (year+"-"+month+"-"+day);
    }

}
