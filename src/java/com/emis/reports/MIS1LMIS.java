package com.emis.reports;

import com.emis.utility.Convertor;
import com.rhis.db.DBManagerLMIS;
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
 * @author : Helal
 * @Created on : Oct 18, 2017, 11:40:22 AM
 */
@WebServlet(name = "MIS1LMIS", urlPatterns = {"/mis1-lmis"})
public class MIS1LMIS extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("submenu", "mis1-lmis");
        request.setAttribute("menu", "VIEW REPORTS");     
        request.setAttribute("userLevel", (String) request.getSession(false).getAttribute("userLevel"));
        RequestDispatcher view = request.getRequestDispatcher("WEB-INF/jsp/reports/mis1-lmis.jsp");
        view.forward(request, response);
        
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        

        String districtId = request.getParameter("districtId");
        String upazilaId = request.getParameter("upazilaId").length() == 0 ? "%" : request.getParameter("upazilaId");
        String unionId = request.getParameter("unionId").length() == 0 ? "%" : request.getParameter("unionId");
        String fwaUnit = request.getParameter("fwaUnit");
        String month = request.getParameter("month");
        String year = request.getParameter("year");
        String date = request.getParameter("date");
        String[] dates = date.split("~"); //dates[0];
        String provCode = request.getParameter("provCode");
        
       
        //From LMIS-MSH
        String query3=null;
        try {
                
            DBManagerLMIS dbCheckOpening=new DBManagerLMIS();
            String sqlOpeningBalChecking = "select \"openingBalance\" from \"openingBalance\" where \"createdDate\" between '"+dates[0]+"' and '"+dates[1]+"' and \"providerId\" = '"+provCode+"' order by \"openingBalance\" desc limit 1";
            ResultSet resultCheckOpening = dbCheckOpening.select(sqlOpeningBalChecking);
            int openingBalance=0;
            while(resultCheckOpening.next()){
                openingBalance=resultCheckOpening.getInt("openingBalance");
            }

            DBManagerLMIS dbCheckReceive=new DBManagerLMIS();
            String sqlReceiptChecking = "select \"receiveQty\" from \"stockTransaction\" where \"systemEntryDate\" between '"+dates[0]+"' and '"+dates[1]+"' and \"providerId\" = '"+provCode+"' order by \"receiveQty\" desc limit 1 ";
            ResultSet resultCheckReceive = dbCheckReceive.select(sqlReceiptChecking);
            int receiptThisMonth=0;
            while(resultCheckReceive.next()){
                receiptThisMonth=resultCheckReceive.getInt("receiveQty");
            }

            //Checking
            String queryselect=null;
            String join=null;
            if(openingBalance>=0 && receiptThisMonth>=0){
                    queryselect="a.\"itemCode\",a.\"misColumnNo\"";
                    join="RIGHT";

            } if(openingBalance>=0 && receiptThisMonth<=0){
                    queryselect="aa.\"itemCode\",aa.\"misColumnNo\"";
                    join="LEFT";

            } else if(openingBalance<=0 && receiptThisMonth>=0){
                    queryselect="a.\"itemCode\",a.\"misColumnNo\"";
                    join="RIGHT";

            } 
            query3 = "select "+queryselect+",aa.\"openingBalance\",a.\"receiptThisMonth\" ,c.\"adjustmentPlus\" ,d.\"adjustmentMinus\",b.\"distribution\" from (SELECT opb.\"itemCode\",itm.\"misColumnNo\",sum(opb.\"openingBalance\") as \"openingBalance\" from \"openingBalance\" opb LEFT JOIN \"itemMap\" itm on itm.\"rhisItemCode\" = opb.\"itemCode\"where opb.\"createdDate\" between '"+dates[0]+"' and '"+dates[1]+"' and opb.\"providerId\" = '"+provCode+"' group by opb.\"itemCode\",itm.\"misColumnNo\"order by itm.\"misColumnNo\" ) as aa "+join+" join ( select stm.\"itemCode\",itm.\"misColumnNo\",sum(stm.\"receiveQty\") as \"receiptThisMonth\" from \"stockTransaction\" stm LEFT JOIN \"itemMap\" itm on itm.\"rhisItemCode\" = stm.\"itemCode\" where stm.\"systemEntryDate\" between '"+dates[0]+"' and '"+dates[1]+"' and stm.\"providerId\" = '"+provCode+"' group by stm.\"itemCode\" ,itm.\"misColumnNo\" order by stm.\"itemCode\" asc ) as a on a.\"itemCode\"=aa.\"itemCode\" LEFT JOIN ( select \"stockTransaction\".\"itemCode\",sum(\"issueQty\") as \"distribution\" from \"stockTransaction\" where \"providerId\" = '"+provCode+"' and \"systemEntryDate\" between '"+dates[0]+"' and '"+dates[1]+"' group by \"stockTransaction\".\"itemCode\" ) as b on a.\"itemCode\" = b.\"itemCode\" LEFT JOIN ( select \"itemRequest\".\"itemCode\",sum(\"approveQty\") as \"adjustmentPlus\" from \"itemRequest\" where \"requestBy\" = '"+provCode+"' and \"systemEntryDate\" between '"+dates[0]+"' and '"+dates[1]+"' group by \"itemRequest\".\"itemCode\" ) c on b.\"itemCode\" = c.\"itemCode\" LEFT JOIN ( select \"itemAdjustmentMinus\".\"itemCode\",sum(\"adjustmentQty\") as \"adjustmentMinus\" from \"itemAdjustmentMinus\" where \"providerId\" = '"+provCode+"' and \"createdDate\" between '"+dates[0]+"' and '"+dates[1]+"' group by \"itemAdjustmentMinus\".\"itemCode\" ) d on c.\"itemCode\" = d.\"itemCode\"";
        }catch(Exception e){

        }
        
        try {
            
            DBManagerLMIS db3=new DBManagerLMIS();
            ResultSet result3 = db3.select(query3);
            
            JSONArray json3 = Convertor.convertResultSetIntoJSON(result3);

            response.setContentType("text/plain;charset=UTF-8");
            String responseJson3 = (json3.toString()).substring(0);
            //String responseJson4 = (jsonObject);


            response.getWriter().write("{\"LMIS\":"+responseJson3+"}");
        } catch (Exception ex) {
            ex.getMessage();
        }
    }

}
