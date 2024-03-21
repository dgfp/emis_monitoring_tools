package bd.gov.dgfp.communityStatistics;

import com.emis.dao.UserDao;
import com.emis.entity.ELCO;
import com.emis.utility.Convertor;
import com.emis.utility.Menu;
import com.emis.utility.Utility;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.rhis.db.DBManagerDistrict;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
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
@WebServlet(name = "DeathNotification", urlPatterns = {"/death-notification"})
public class DeathNotification extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        Menu.setMenu("COMMUNITY STATISTICS", "death-notification", request);
        request.setAttribute("userLevel", (String) request.getSession(false).getAttribute("userLevel"));
        String view = "WEB-INF/jsp/dgfpCommunityStatistics/DeathNotification.jsp";
        try {
            if (request.getSession(false).getAttribute("district") != null) {
                if (!new UserDao().isPaperless(request.getSession(false).getAttribute("district").toString())) {
                    response.sendRedirect(request.getContextPath() + "/death");
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
            ELCO elco = new ObjectMapper().readValue(request.getParameter("data").toString(), ELCO.class);
            String sql = "", json = "";
            if (request.getParameter("action").equals("aggregate")) {
                switch (elco.getViewType()) {
                    case "atPoint": //Done
                        elco.setEndDate(elco.getEndDate().length() == 0 ? Utility.getDateNow() : elco.getEndDate());
                        if (elco.getUpazila() == 0 && elco.getReportType().equals("aggregate")) {
                            sql = "SELECT  * from public.web_death_notification_upazila_wise(" + elco.getDistrict() + ",'" + elco.getEndDate() + "') order by upazilanameeng asc";

                        } else if (elco.getUnion() == 0 && elco.getReportType().equals("aggregate")) {
                            sql = "SELECT  * from public.web_death_notification_union_wise(" + elco.getDistrict() + "," + elco.getUpazila() + ",'" + elco.getEndDate() + "') order by unionnameeng asc";

                        } else if (elco.getUnit() == 0 && elco.getReportType().equals("aggregate")) {
                            sql = "SELECT  * from public.web_death_notification_unit_wise(" + elco.getDistrict() + ", " + elco.getUpazila() + ", " + elco.getUnion() + ",'" + elco.getEndDate() + "') order by uname asc";

                        } else if (elco.getUnit() != 0 && elco.getReportType().equals("aggregate")) {
                            sql = "SELECT  * from public.web_death_notification_unit_wise(" + elco.getDistrict() + ", " + elco.getUpazila() + ", " + elco.getUnion() + ",'" + elco.getEndDate() + "') where unitid = " + elco.getUnit() + " order by uname asc";

                        } else if (elco.getUnit() == 0 && elco.getReportType().equals("individual")) {
                            sql = getIndividualSQL(elco, "");
                            //sql = "SELECT * from public.web_pregnant_woman_village_individual_mv(" + elco.getDistrict() + ", " + elco.getUpazila() + ", " + elco.getUnion() + ", " + elco.getUnit() + ", '%' ,'" + Utility.changeFormat(elco.getEndDate()) + "') order by village asc";

                        } else if (elco.getVillage().equals("0") && elco.getReportType().equals("individual")) {
                            sql = getIndividualSQL(elco, "and unitid=" + elco.getUnit());
                            //sql = "SELECT * from public.web_pregnant_woman_village_individual_mv(" + elco.getDistrict() + ", " + elco.getUpazila() + ", " + elco.getUnion() + ", " + elco.getUnit() + ", '%' ,'" + Utility.changeFormat(elco.getEndDate()) + "') order by village asc";

                        } else if (!elco.getVillage().equals("0") && elco.getReportType().equals("individual")) {
                            sql = getIndividualSQL(elco, "and unitid=" + elco.getUnit() + " and mouzaid = " + elco.getVillage().split(" ")[0] + " and villageid = " + elco.getVillage().split(" ")[1]);
                            //sql = "SELECT * from public.web_pregnant_woman_village_individual_mv(" + elco.getDistrict() + ", " + elco.getUpazila() + ", " + elco.getUnion() + ", " + elco.getUnit() + ", '" + elco.getVillage().split(" ")[0] + "" + elco.getVillage().split(" ")[1] + "','" + Utility.changeFormat(elco.getEndDate()) + "') order by village asc";
                        }
                        break;

                    case "periodical": //Done
                        elco.setPeriodicalStartDate(elco.getPeriodicalStartDate().length() == 0 ? "01/01/2015" : elco.getPeriodicalStartDate());
                        if (elco.getUpazila() == 0 && elco.getReportType().equals("aggregate")) {
                            sql = "SELECT  * from public.web_death_notification_upazila_wise_date_range(" + elco.getDistrict() + ",'" + elco.getPeriodicalStartDate() + "','" + elco.getPeriodicalEndDate() + "') order by upazilanameeng asc";

                        } else if (elco.getUnion() == 0 && elco.getReportType().equals("aggregate")) {
                            sql = "SELECT  * from public.web_death_notification_union_wise_date_range(" + elco.getDistrict() + "," + elco.getUpazila() + ",'" + elco.getPeriodicalStartDate() + "','" + elco.getPeriodicalEndDate() + "') order by unionnameeng asc";

                        } else if (elco.getUnit() == 0 && elco.getReportType().equals("aggregate")) {
                            sql = "SELECT  * from public.web_death_notification_unit_wise_date_range(" + elco.getDistrict() + ", " + elco.getUpazila() + ", " + elco.getUnion() + ",'" + elco.getPeriodicalStartDate() + "','" + elco.getPeriodicalEndDate() + "') order by unit asc";

                        } else if (elco.getUnit() != 0 && elco.getReportType().equals("aggregate")) {
                            sql = "SELECT  * from public.web_death_notification_unit_wise_date_range(" + elco.getDistrict() + ", " + elco.getUpazila() + ", " + elco.getUnion() + ",'" + elco.getPeriodicalStartDate() + "','" + elco.getPeriodicalEndDate() + "') where unitid = " + elco.getUnit() + " order by unit asc";

                        }
                        break;
                    case "monthly": //Done
                        if (elco.getUpazila() == 0 && elco.getReportType().equals("aggregate")) {
                            sql = "SELECT  * from public.web_death_notification_upazila_wise_monthly_year_month(" + elco.getDistrict() + "," + elco.getStartMonthYear().split("/")[1] + "," + elco.getStartMonthYear().split("/")[0] + "," + elco.getEndMonthYear().split("/")[1] + "," + elco.getEndMonthYear().split("/")[0] + ") order by upazilanameeng, years, months asc";

                        } else if (elco.getUnion() == 0 && elco.getReportType().equals("aggregate")) {
                            sql = "SELECT  * from public.web_death_notification_union_wise_monthly_year_month(" + elco.getDistrict() + "," + elco.getUpazila() + "," + elco.getStartMonthYear().split("/")[1] + "," + elco.getStartMonthYear().split("/")[0] + "," + elco.getEndMonthYear().split("/")[1] + "," + elco.getEndMonthYear().split("/")[0] + ") order by reporting_union_name, years, months asc";

                        } else if (elco.getUnit() == 0 && elco.getReportType().equals("aggregate")) {
                            sql = "SELECT  * from public.web_death_notification_unit_wise_monthly_year_month(" + elco.getDistrict() + "," + elco.getUpazila() + ", " + elco.getUnion() + "," + elco.getStartMonthYear().split("/")[1] + "," + elco.getStartMonthYear().split("/")[0] + "," + elco.getEndMonthYear().split("/")[1] + "," + elco.getEndMonthYear().split("/")[0] + ") order by unit, years, months asc";

                        } else if (elco.getUnit() != 0 && elco.getReportType().equals("aggregate")) {
                            sql = "SELECT  * from public.web_death_notification_unit_wise_monthly_year_month(" + elco.getDistrict() + "," + elco.getUpazila() + ", " + elco.getUnion() + "," + elco.getStartMonthYear().split("/")[1] + "," + elco.getStartMonthYear().split("/")[0] + "," + elco.getEndMonthYear().split("/")[1] + "," + elco.getEndMonthYear().split("/")[0] + ") where unitid = " + elco.getUnit() + " order by unit, years, months asc";

                        }
                        break;
                    case "yearly": //Done
                        if (elco.getUpazila() == 0 && elco.getReportType().equals("aggregate")) {
                            sql = "SELECT  * from public.web_death_notification_upazila_wise_yearly(" + elco.getDistrict() + "," + elco.getStartYear() + "," + elco.getEndYear() + ") order by upazilanameeng, years asc";

                        } else if (elco.getUnion() == 0 && elco.getReportType().equals("aggregate")) {
                            sql = "SELECT  * from public.web_death_notification_union_wise_yearly(" + elco.getDistrict() + "," + elco.getUpazila() + "," + elco.getStartYear() + "," + elco.getEndYear() + ") order by reporting_union_name, years asc";

                        } else if (elco.getUnit() == 0 && elco.getReportType().equals("aggregate")) {
                            sql = "SELECT  * from public.web_death_notification_unit_wise_yearly(" + elco.getDistrict() + "," + elco.getUpazila() + ", " + elco.getUnion() + "," + elco.getStartYear() + "," + elco.getEndYear() + ") order by unit, years asc";

                        } else if (elco.getUnit() != 0 && elco.getReportType().equals("aggregate")) {
                            sql = "SELECT  * from public.web_death_notification_unit_wise_yearly(" + elco.getDistrict() + "," + elco.getUpazila() + ", " + elco.getUnion() + "," + elco.getStartYear() + "," + elco.getEndYear() + ") where unitid = " + elco.getUnit() + " order by unit, years asc";

                        }
                        break;
                    default:
                        response.getWriter().write(new Utility().errorResponse());
                }
            } else {
            }
            DBManagerDistrict db = new DBManagerDistrict(elco.getDistrict());
            JSONArray jsonRs = Convertor.convertResultSetIntoJSON(db.select(sql));
            System.out.println(jsonRs);
            response.setContentType("text/plain;charset=UTF-8");
            response.getWriter().write(jsonRs.toString());
        } catch (Exception ex) {
            ex.printStackTrace();
            response.getWriter().write(ex.getMessage());
        }
    }

    private String getIndividualSQL(ELCO elco, String where) {
        String dateWhere = " between to_date('" + elco.getPeriodicalStartDate() + "', 'dd/mm/yyyy') and to_date('" + elco.getPeriodicalEndDate() + "', 'dd/mm/yyyy')";
        if (elco.getPeriodicalStartDate() == "") {
            dateWhere = " <= to_date('" + Utility.getDateNow() + "', 'dd/mm/yyyy')";
        }
        String sql = "WITH\n"
                + "Registered_Death AS (\n"
                + "	select DISTINCT ON (1) d.healthid, m.zillaid\n"
                + "			,m.upazilaid\n"
                + "			,m.reporting_unionid\n"
                + "			,mm.unionid\n"
                + "			,ru.unionnameeng\n"
                + "			,m.unitid\n"
                + "			,m.unit\n"
                + "			,mm.mouzaid\n"
                + "			,mm.villageid\n"
                + "			,mm.hhno\n"
                + "			,name_village_eng(mm.zillaid, mm.upazilaid, mm.unionid, mm.mouzaid, mm.villageid) villagenameeng\n"
                + "			,mm.nameeng\n"
                + "			,fn_fathername(mm.zillaid, mm.upazilaid, mm.unionid, mm.mouzaid, mm.villageid, mm.hhno, mm.sno)::CHARACTER VARYING fathername\n"
                + "			,fn_mothername(mm.zillaid, mm.upazilaid, mm.unionid, mm.mouzaid, mm.villageid, mm.hhno, mm.sno)::CHARACTER VARYING mothername\n"
                + "			,d.deathdt date_of_death\n"
                + "			,age(mm.dob, d.deathdt)::text calculated_age\n"
                + "			,case \n"
                + "				when d.placeofdeath = 1\n"
                + "					then 'Home'\n"
                + "				when d.placeofdeath = 2\n"
                + "					then 'Facility'\n"
                + "				when d.placeofdeath = 3\n"
                + "					then 'Other'\n"
                + "				else\n"
                + "					'-'\n"
                + "			end place_of_death\n"
                + "		from public.mv_member_rpt_elco m\n"
                + "		join member mm using (generatedid)\n"
                + "		JOIN death d on d.healthid = m.generatedid\n"
                + "		JOIN reporting_union ru on  (m.zillaid=ru.zillaid  and  m.upazilaid=ru.upazilaid and m.reporting_unionid=ru.reporting_unionid)\n"
                + "	where m.zillaid = " + elco.getDistrict() + "\n"
                + "		and m.upazilaid = " + elco.getUpazila() + "\n"
                + "		and m.reporting_unionid=" + elco.getUnion() + "\n"
                + "		" + where + "\n"
                + "			and date (d.deathdt) " + dateWhere + "\n"
                + "	\n"
                + "	),\n"
                + "\n"
                + "	hh_mobile as \n"
                + "	(\n"
                + "		SELECT  m.zillaid ,m.upazilaid,m.unionid,m.mouzaid,m.villageid,m.hhno,m.mobileno \n"
                + "		   FROM ( select mem.zillaid, mem.upazilaid, mem.unionid, mem.mouzaid, mem.villageid, mem.hhno, max(coalesce(mem.mobileno1,mem.mobileno1)) as mobileno \n"
                + "			  FROM member mem \n"
                + "			  GROUP BY mem.zillaid, mem.upazilaid, mem.unionid, mem.mouzaid, mem.villageid, mem.hhno) m \n"
                + "		   JOIN  household h USING (zillaid,upazilaid,unionid,mouzaid,villageid,hhno)\n"
                + "		   WHERE m.zillaid = " + elco.getDistrict() + "\n"
                + "		   and   m.upazilaid = " + elco.getUpazila() + "\n"
                + "		   and h.reporting_unionid = " + elco.getUnion() + "\n"
                + "		" + where + "\n"
                + "		   and cast(m.mouzaid as text)||  cast(m.villageid  as text) like('%') \n"
                + "	)\n"
                + "	\n"
                + "SELECT * FROM Registered_Death m\n"
                + "left join hh_mobile h \n"
                + "on h.zillaid = m.zillaid AND h.upazilaid = m.upazilaid AND h.unionid = m.unionid AND h.mouzaid = m.mouzaid AND h.villageid = m.villageid AND h.hhno = m.hhno\n"
                + "ORDER BY m.villagenameeng asc;\n"
                + "";

        return sql;
    }

}