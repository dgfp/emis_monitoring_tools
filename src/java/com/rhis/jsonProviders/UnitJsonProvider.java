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

/**
 *
 * @author Helal
 */
@WebServlet(name = "UnitJsonProvider", urlPatterns = {"/UnitJsonProvider"})
public class UnitJsonProvider extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            String districtid= request.getParameter("districtId");
            String upazilaid= request.getParameter("upazilaId");
            String unionid= request.getParameter("unionId");
            String unit =  (String) request.getSession(false).getAttribute("unit");
            String where="";
            if(unit!=null)
                    where =" and ucode = "+unit;
            try {
                ResultSet result = new DBManagerDistrict(Integer.parseInt(districtid)).select("select zillaid, upazilaid, unionid, ucode, uname, unameban from reporting_units where zillaid = "+districtid+" and upazilaid = "+upazilaid+" and unionid = "+unionid+""+where);
                response.setContentType("text/plain;charset=UTF-8");
                response.getWriter().write(Convertor.convertResultSetIntoJSON(result).toString());
            } catch (Exception ex) {
                System.out.println(ex.getMessage());
            }
    }
}