package com.emis.reports9th;

import com.emis.dao.UserDao;
import com.emis.entity.ELCO;
import com.emis.entity.HouseholdAndVillageWisePopulation;
import com.emis.utility.Convertor;
import com.emis.utility.Menu;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.rhis.db.DBManagerDistrict;
import java.io.IOException;
import java.io.PrintWriter;
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
@WebServlet(name = "HouseholdWisePopulation", urlPatterns = {"/household-wise-population"})
public class HouseholdWisePopulation extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        Menu.setMenu("Reports", "household-wise-population", request);
//        RequestDispatcher view = request.getRequestDispatcher("WEB-INF/jsp/reports9th/HouseholdWisePopulation.jsp");
//        view.forward(request, response);

        Menu.setMenu("VIEW REPORTS", "household-wise-population", request);
        String view = "WEB-INF/jsp/reports9th/HouseholdWisePopulation.jsp";
        try {
            if (request.getSession(false).getAttribute("district") != null) {
                if (!new UserDao().isPaperless(request.getSession(false).getAttribute("district").toString())) {
                    response.sendRedirect(request.getContextPath() + "/populationCountKhanaWise");
                } else {
                    request.getRequestDispatcher(view).forward(request, response);
                }
            } else {
                request.getRequestDispatcher(view).forward(request, response);
            }
        } catch (Exception e) {
            request.getRequestDispatcher(view).forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {

            HouseholdAndVillageWisePopulation data = new ObjectMapper().readValue(request.getParameter("data").toString(), HouseholdAndVillageWisePopulation.class);
            String query = "";

            if (data.getViewType().equals("atPoint")) {
                query = "WITH \n"
                        + "registered_population AS\n"
                        + "(\n"
                        + "	SELECT   m.zillaid\n"
                        + "		,m.upazilaid\n"
                        + "		,m.unionid\n"
                        + "		,m.reporting_unionid\n"
                        + "		,m.unitid\n"
                        + "		,m.unit\n"
                        + "		,m.mouzaid\n"
                        + "		,m.villageid\n"
                        + "		,name_village(m.zillaid, m.upazilaid, m.unionid, m.mouzaid, m.villageid) villagename\n"
                        + "		,m.hhno\n"
                        + "		,fn_elco_no(m.zillaid, m.upazilaid, m.unionid, m.mouzaid, m.villageid, m.hhno) elconos\n"
                        + "		,fn_household_head_name(m.zillaid, m.upazilaid, m.unionid, m.mouzaid, m.villageid, m.hhno) household_head_name\n"
                        + "		,count(m.generatedid) as population\n"
                        + "		,sum(CASE WHEN sex=1  THEN 1 ELSE 0 END) as male_count\n"
                        + "		,sum(CASE WHEN sex=2  THEN 1 ELSE 0 END) as female_count\n"
                        + "	FROM public.member_household m\n"
                        + "	WHERE m.endt <=to_date('" + data.getEndDate() + "', 'dd/mm/yyyy') \n"
                        + "	and m.zillaid=" + data.getZillaid() + " and m.upazilaid=" + data.getUpazilaid() + " and m.reporting_unionid=" + data.getReporting_unionid() + " and m.unit = " + data.getUnit() + " \n"
                        + "	and NOT EXISTS (select NULL from migrationout mo where  mo.healthid = m.generatedid  and mo.systementrydate <= to_date('" + data.getEndDate() + "', 'dd/mm/yyyy'))\n"
                        + "	and NOT EXISTS (select NULL from death d where  d.healthid = m.generatedid  and d.deathdt <= to_date('" + data.getEndDate() + "', 'dd/mm/yyyy'))\n"
                        + "	GROUP BY m.zillaid, m.upazilaid,m.reporting_unionid, m.unionid,m.unitid,m.unit,m.mouzaid, m.villageid,m.hhno\n"
                        + "),\n"
                        + "unit_village as\n"
                        + "(\n"
                        + "	SELECT  \n"
                        + "		ud.zillaid,\n"
                        + "		ud.upazilaid,\n"
                        + "		ud.unionid,\n"
                        + "		um.reporting_unionid,\n"
                        + "		um.unitid,\n"
                        + "		ud.mouzaid,\n"
                        + "		ud.villageid,\n"
                        + "		name_village(ud.zillaid, ud.upazilaid, ud.unionid, ud.mouzaid, ud.villageid) villagename\n"
                        + "	from  unit_master um\n"
                        + "	LEFT JOIN unit_details ud using (unitid)\n"
                        + "	WHERE um.zillaid=" + data.getZillaid() + " and um.upazilaid=" + data.getUpazilaid() + " and um.reporting_unionid=" + data.getReporting_unionid() + " and um.unit =" + data.getUnit() + " \n"
                        + ")"
                        + " select * from registered_population RIGHT JOIN unit_village u USING (zillaid, upazilaid, unionid, reporting_unionid,  unitid, mouzaid,villageid )";

            } else {
                query = "SELECT  * from public.web_household_wise_population_yearly_new(" + data.getZillaid() + ", " + data.getUpazilaid() + ", " + data.getReporting_unionid() + ", " + data.getUnit() + ", " + data.getEndYear() + ", " + data.getStartYear() + ");";
            }

            JSONArray json = Convertor.convertResultSetIntoJSON(new DBManagerDistrict(data.getZillaid()).select(query));
            response.setContentType("text/plain;charset=UTF-8");
            response.getWriter().write(json.toString());

        } catch (Exception ex) {
            ex.printStackTrace();
            response.getWriter().write(ex.getMessage());
        }
    }
}
