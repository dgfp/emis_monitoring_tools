package com.emis.utility;

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
@WebServlet(name = "Reports", urlPatterns = {"/reports"})
public class Reports extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            RequestDispatcher view = request.getRequestDispatcher("WEB-INF/jsp/utility/reports.jsp");
            view.forward(request, response);
        
    }
    
        private String executeSelect(String query,String districtId) {

        DBManagerDistrict db = new DBManagerDistrict(Integer.parseInt(districtId));
        ResultSet result = db.select(query);
        JSONArray json = new JSONArray();
        try {
            json = Convertor.convertResultSetIntoJSON(result);
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        }
        return json.toString();
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
          if (action.equalsIgnoreCase("loadProvider")) {
              
            String districtId = request.getParameter("districtId");

            String upazilaId = request.getParameter("upazilaId");

            String unionId = request.getParameter("unionId");
            
            String providerType = request.getParameter("providerType");

            System.out.println(districtId);
            String condition =  " WHERE zillaid=" + districtId + " AND  upazilaid=" + upazilaId + " AND unionid=" + unionId+" and \"ProvType\"="+providerType;



            String query = "SELECT \"ProvCode\",\"ProvName\" FROM \"public\".\"ProviderDB\""+condition;

            String jsonString = executeSelect(query,districtId);
            response.setContentType("text/plain;charset=UTF-8");
            response.getWriter().write(jsonString);
          }
          
           if (action.equalsIgnoreCase("loadCount")) {
                String districtId = request.getParameter("districtId");
                String upazilaId = request.getParameter("upazilaId");
                String unionId = request.getParameter("unionId");
                String provider = request.getParameter("provider");
                String startDate=request.getParameter("startDate");
                String endDate=request.getParameter("endDate");
                
                System.out.println("Provider:"+provider+":");
                
                String condition=null;
                
                if(provider=="0" || provider.equals("0")){
                    condition = "";
                }else{
                    condition =  "and  \"ProvCode\"="+provider;
                }
               


                 String query = "select \n" +
                "\"Dist\",\"Upz\",\"UN\",\"Mouza\",\"Vill\",\"ProvCode\"\n" +
                ",\"Mouza\".\"MOUZANAMEENG\",\"Village\".\"VILLAGENAMEENG\"\n" +
                ", count(\"HHNo\")\n" +
                "from \"Household\"\n" +
                "inner join \"Mouza\" on \"Household\".\"Dist\"=\"Mouza\".\"ZILLAID\" and \"Household\".\"Upz\"=\"Mouza\".\"UPAZILAID\" and \"Household\".\"UN\"=\"Mouza\".\"UNIONID\" and \"Household\".\"Mouza\"=\"Mouza\".\"MOUZAID\"\n" +
                "inner join \"Village\" on \"Household\".\"Dist\"=\"Village\".\"ZILLAID\" and \"Household\".\"Upz\"=\"Village\".\"UPAZILAID\" and \"Household\".\"UN\"=\"Village\".\"UNIONID\" and\"Household\".\"Mouza\"=\"Village\".\"MOUZAID\" and \"Household\".\"Vill\"=\"Village\".\"VILLAGEID\"\n" +
                "--inner join \"Village\" on \"Mouza\".\"ZILLAID\"=\"Village\".\"ZILLAID\" and \"Mouza\".\"UPAZILAID\"=\"Village\".\"UPAZILAID\" and \"Mouza\".\"UNIONID\"=\"Village\".\"UNIONID\" and \"Mouza\".\"MOUZAID\"=\"Village\".\"MOUZAID\"\n" +
                "where \"Dist\"="+districtId+" and \"Upz\"="+upazilaId+" and \"UN\"="+unionId+" \n" +
                " "+condition+" \n" +
                "and  \"EnDt\" between '"+startDate+"' and '"+endDate+"' \n" +
                "group by \"Dist\",\"Upz\",\"UN\",\"Mouza\",\"Vill\",\"ProvCode\"\n" +
                ",\"Mouza\".\"MOUZANAMEENG\",\"Village\".\"VILLAGENAMEENG\"";

                String jsonString = executeSelect(query,districtId);
                response.setContentType("text/plain;charset=UTF-8");
                response.getWriter().write(jsonString);
           
           }
    }

}
