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
import javax.servlet.http.HttpSession;

/**
 *
 * @author Helal
 */
@WebServlet(name = "ViewNidMissing", urlPatterns = {"/viewNidMissing"})
public class ViewNidMissing extends HttpServlet {


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
                String root = request.getContextPath();

                String districtId = request.getParameter("districtId");
                String upazilaId = request.getParameter("upazilaId");
                String unionId = request.getParameter("unionId");
                String startDate = request.getParameter("sDate");
                String endDate = request.getParameter("eDate");
                
                if("".equals(districtId) || districtId==null || "".equals(upazilaId) || upazilaId==null || "".equals(unionId) || unionId==null ){
                    response.sendRedirect(root+"/NidPossessionStatus");
                }
                
                System.out.print(districtId+" "+upazilaId+" "+unionId);
          
                String query="select \"HHNo\", \"NameEng\", \"Father\", \"DOB\",\n" +
                                "case when \"Sex\"='1' then 'Male' else 'Female' end as \"Sex\",\n" +
                                "case when \"MS\"='1' then 'Married' else 'Unmarried' end as \"MaritalStatus\"\n" +
                                "from \"Member\" \n" +
                                "where \"HaveNID\"='2' and \"NIDStatus\"='2' and \"Age\">='18'  \n" +
                                "and \"Dist\"="+districtId+" and \"Upz\"="+upazilaId+" and \"UN\"="+unionId+" and \"EnDate\" between '"+startDate+"' and '"+endDate+"'";

                try {

                        DBManagerDistrict db = new DBManagerDistrict(Integer.parseInt(districtId));

                        ResultSet rs = db.select(query);

                        JSONArray json = Convertor.convertResultSetIntoJSON(rs);
                        response.setContentType("text/plain;charset=UTF-8");
                        
                        HttpSession session=request.getSession();
                        session.setAttribute("missingJson", json);

                        RequestDispatcher view = request.getRequestDispatcher("WEB-INF/jsp/viewNidMissing.jsp");
                        view.forward(request, response);


                    } catch (Exception ex) {
                        ex.getMessage();
                    }
                
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
 
                HttpSession session=request.getSession();
                JSONArray json=(JSONArray) session.getAttribute("missingJson");
                
                response.setContentType("text/plain;charset=UTF-8");

                System.out.println(json.toString());
                response.getWriter().write(json.toString());
                
                session.removeAttribute("missingJson");
 
    }

}
