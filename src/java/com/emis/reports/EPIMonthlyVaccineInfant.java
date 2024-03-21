package com.emis.reports;

import com.emis.utility.Convertor;
import com.rhis.db.DBManagerDistrict;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
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
 * @author Nil_27
 */
@WebServlet(name = "EPIMonthlyVaccineChild", urlPatterns = {"/EPIMonthlyVaccineInfant"})
public class EPIMonthlyVaccineInfant extends HttpServlet {

    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("submenu", "EPIMonthlyVaccineInfant");
        request.setAttribute("menu", "VIEW REPORTS");
        request.setAttribute("userLevel", (String) request.getSession(false).getAttribute("userLevel"));
        RequestDispatcher view = request.getRequestDispatcher("WEB-INF/jsp/reports/epiMonthlyVaccineInfant.jsp");
        view.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        Connection connection=null;
        String districtId = request.getParameter("districtId");
        String upazilaId = request.getParameter("upazilaId");
        String unionId = request.getParameter("unionId");
        String wardId = request.getParameter("wardId");
        String month = request.getParameter("month");
        String year = request.getParameter("year");

        if(districtId!="" || upazilaId!="" || unionId!="" || wardId!="" || month!="" || year!=""){

            try {
                DBManagerDistrict db = new DBManagerDistrict(Integer.parseInt(districtId));
                connection=db.openConnection();
                
                String sql = "SELECT * from public.fn_epi_child_monthly (?,?,?,?,?,?);";
                System.out.println("select * from fn_epi_child_monthly ("+districtId+","+upazilaId+","+unionId+","+wardId+","+year+","+month+");");
                
                PreparedStatement preparedStatement = connection.prepareStatement(sql);
                preparedStatement.setInt(1, Integer.parseInt(districtId));
                preparedStatement.setInt(2, Integer.parseInt(upazilaId));
                preparedStatement.setInt(3, Integer.parseInt(unionId));
                preparedStatement.setInt(4, Integer.parseInt(wardId));
                preparedStatement.setInt(5, Integer.parseInt(year));
                preparedStatement.setInt(6, Integer.parseInt(month));
                ResultSet result = preparedStatement.executeQuery();
                JSONArray json = Convertor.convertResultSetIntoJSONEPI(result);

                connection.close();
                response.setContentType("text/plain;charset=UTF-8");
                response.getWriter().write(json.toString());


            } catch (Exception ex) {
                System.out.println(ex.getMessage());
            }

        } else{
            response.setContentType("text/plain;charset=UTF-8");
            response.getWriter().write("");
        }
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        /* //Previous source as Backup
        String districtId = request.getParameter("districtId");
        String upazilaId = request.getParameter("upazilaId");
        String unionId = request.getParameter("unionId");
        String provCode = request.getParameter("provCode");
        
        String month = request.getParameter("month");
        String year = request.getParameter("year");
        
        String startDate=year+"-"+month+"-01";
        String endDate=year+"-"+month+"-30";
        
        String query="select distinct i.*,epi.\"BCode\",epi.\"BName\" \n" +
                            "from\n" +
                            "(\n" +
                            "(select B.\"ZILLANAME\",B.\"UPAZILANAME\", B.\"UNIONNAME\" , A.* from \n" +
                            "(select \"ProviderArea\".\"zillaid\", \"ProviderArea\".\"upazilaid\",\"ProviderArea\".\"unionid\",\"ProviderArea\".\"Ward\", \"immunizationHistory\".\"providerId\", \n" +
                            "count(case when \"immunizationHistory\".\"imuCode\" =1 then 1 end ) as \"BCG\", \n" +
                            "count(case when \"immunizationHistory\".\"imuCode\" =2 then 1 end ) as \"Penta_1\", \n" +
                            "count(case when \"immunizationHistory\".\"imuCode\" =3 then 1 end ) as \"Penta_2\", \n" +
                            "count(case when \"immunizationHistory\".\"imuCode\" =4 then 1 end ) as \"Penta_3\", \n" +
                            "count(case when \"immunizationHistory\".\"imuCode\" =5 then 1 end ) as \"PCV_1\", \n" +
                            "count(case when \"immunizationHistory\".\"imuCode\" =6 then 1 end ) as \"PCV_2\", \n" +
                            "count(case when \"immunizationHistory\".\"imuCode\" =7 then 1 end ) as \"PCV_3\", \n" +
                            "count(case when \"immunizationHistory\".\"imuCode\" =8 then 1 end ) as \"OPV_0\", \n" +
                            "count(case when \"immunizationHistory\".\"imuCode\" =9 then 1 end ) as \"OPV_1\", \n" +
                            "count(case when \"immunizationHistory\".\"imuCode\" =10 then 1 end ) as \"OPV_2\", \n" +
                            "count(case when \"immunizationHistory\".\"imuCode\" =11 then 1 end ) as \"OPV_3\",\n" +
                            "count(case when \"immunizationHistory\".\"imuCode\" =12 then 1 end ) as \"IPV\",\n" +
                            "count(case when \"immunizationHistory\".\"imuCode\" =12 then 1 end ) as \"IPV\",\n" +
                            "count(case when \"immunizationHistory\".\"imuCode\" =13 then 1 end ) as \"MR\",\n" +
                            "count(case when \"immunizationHistory\".\"imuCode\" =14 then 1 end ) as \"MR_2\"\n" +
                            "from \"immunizationHistory\" \n" +
                            "inner join \"immunization\" on \"immunization\".\"imuCode\"=\"immunizationHistory\".\"imuCode\"\n" +
                            "inner join \"ProviderArea\" on \"immunizationHistory\".\"providerId\"=\"ProviderArea\".\"provCode\"\n" +
                            "where \"immunization\".\"forChild\"=1\n" +
                            "and \"immunizationHistory\".\"systemEntryDate\" between '"+startDate+"' and '"+endDate+"' -- @param\n" +
                            "and \"ProviderArea\".\"zillaid\"="+districtId+" -- @param\n" +
                            "and \"ProviderArea\".\"upazilaid\"="+upazilaId+" -- @param\n" +
                            "and \"ProviderArea\".\"unionid\"="+unionId+" -- @param\n" +
                            "group by \"ProviderArea\".\"zillaid\", \"ProviderArea\".\"upazilaid\",\"ProviderArea\".\"unionid\",\"ProviderArea\".\"Ward\", \"immunizationHistory\".\"providerId\"\n" +
                            "order by \"immunizationHistory\".\"providerId\" ) as A\n" +
                            "inner join public.\"StudyAreaVillagev\" as B on A.\"zillaid\"= B.\"ZILLAID\" and A.\"upazilaid\"= B.\"UPAZILAID\" and A.\"unionid\"= B.\"UNIONID\")i\n" +
                            "join\n" +
                            "    (select \"epiSchedulerUpdate\".\"Dist\", \"epiSchedulerUpdate\".\"Upz\", \"epiSchedulerUpdate\".\"UN\",\"HABlock\".\"BCode\", \"HABlock\".\"BName\"\n" +
                            "from \"epiSchedulerUpdate\" join \"HABlock\" on \"epiSchedulerUpdate\".\"subBlockId\"=cast(\"HABlock\".\"BCode\" as integer))epi\n" +
                            "on (i.\"zillaid\" =epi.\"Dist\"  and i.\"upazilaid\"=epi.\"Upz\"  and i.\"unionid\"=epi.\"UN\")\n" +
                            ")";  

        try {
             
            DBManager2 db = new DBManager2();
            ResultSet result = db.select(query);
            
            JSONArray json = Convertor.convertResultSetIntoJSON(result);
            response.setContentType("text/plain;charset=UTF-8");
            
            System.out.println(json.toString());
            response.getWriter().write(json.toString());
            
        } catch (Exception ex) {
            ex.getMessage();
        }
        */
        
    }

    

}
