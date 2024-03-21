/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.rhis.controllers;

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
 * @author Nil_27
 */
@WebServlet(name = "PrsDataCheck", urlPatterns = {"/prsdatacheck"})
public class PrsDataCheck extends HttpServlet {



    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        RequestDispatcher view = request.getRequestDispatcher("WEB-INF/jsp/prsdatacheck.jsp");
        view.forward(request, response);
    }

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String districtId = request.getParameter("districtId");
        String upazilaId = request.getParameter("upazilaId").length() == 0 ? "%" : request.getParameter("upazilaId");
        String unionId = request.getParameter("unionId");
        String query = "SELECT h.\"Div\", h.\"Dist\", h.\"Upz\", h.\"UN\",u.\"UNIONNAME\",  h.\"Mouza\",m.\"MOUZANAME\", h.\"Vill\",v.\"VILLAGENAME\", count(*) as household,\n" +
"	(select count(*) FROM public.\"Member\" as m where \"Dist\"=h.\"Dist\" and \"Upz\"=h.\"Upz\" and \"UN\"=h.\"UN\" and \"Mouza\" = h.\"Mouza\" and \"Vill\"=h.\"Vill\") as member\n" +
"  FROM public.\"Household\" as h\n" +
"  left join public.\"Village\" as v on  h.\"Dist\"=v.\"ZILLAID\" and h.\"Upz\"=v.\"UPAZILAID\" and h.\"UN\"=v.\"UNIONID\" and  h.\"Mouza\"= v.\"MOUZAID\" and h.\"Vill\"=v.\"VILLAGEID\"\n" +
" left join public.\"Mouza\" as m on  h.\"Dist\"=m.\"ZILLAID\" and h.\"Upz\"=m.\"UPAZILAID\" and h.\"UN\"=m.\"UNIONID\" and  h.\"Mouza\"= m.\"MOUZAID\"\n"+
                "  left join public.\"Unions\" as u on  h.\"Dist\"=u.\"ZILLAID\" and h.\"Upz\"=u.\"UPAZILAID\" and h.\"UN\"=u.\"UNIONID\" \n" +
"  where  \n" 
                + "h.\"Dist\" = " + districtId + " "
                    + "and \"Upz\"= " + upazilaId + " "
                 + "and \"UN\"= " + unionId + " "+
"  group by h.\"Div\", h.\"Dist\", h.\"Upz\", h.\"UN\",u.\"UNIONNAME\",  h.\"Mouza\", m.\"MOUZANAME\",h.\"Vill\",v.\"VILLAGENAME\"\n" +
"  order by h.\"Div\", h.\"Dist\" asc, h.\"Upz\", h.\"UN\",  h.\"Mouza\", h.\"Vill\" ";

        try {
            DBManagerDistrict db = new DBManagerDistrict(Integer.parseInt(districtId));
            ResultSet result = db.select(query);
            JSONArray json = Convertor.convertResultSetIntoJSON(result);
            response.setContentType("text/plain;charset=UTF-8");
            response.getWriter().write(json.toString());
        } catch (Exception ex) {
            ex.getMessage();
        }
    }

    
}
