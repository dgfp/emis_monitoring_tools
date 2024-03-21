package bd.gov.dgfp.communityStatistics;

import com.emis.dao.UserDao;
import com.emis.entity.ELCO;
import com.emis.utility.Convertor;
import com.emis.utility.Menu;
import com.emis.utility.Utility;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.rhis.db.DBManagerDistrict;
import java.io.IOException;
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
@WebServlet(name = "PregnantWomanDGFP", urlPatterns = {"/pregnant-woman-dgfp"})
public class PregnantWomanDGFP extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Menu.setMenu("COMMUNITY STATISTICS", "pregnant-woman-dgfp", request);
        request.setAttribute("userLevel", (String) request.getSession(false).getAttribute("userLevel"));
        String view = "WEB-INF/jsp/dgfpCommunityStatistics/PregnantWomanDGFP.jsp";
        try {
            if (request.getSession(false).getAttribute("district") != null) {
                if (!new UserDao().isPaperless(request.getSession(false).getAttribute("district").toString())) {
                    response.sendRedirect(request.getContextPath() + "/pregnant");
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
                    case "atPoint":
                        elco.setEndDate(elco.getEndDate().length() == 0 ? Utility.getDateNow() : elco.getEndDate());
                        if (elco.getUpazila() == 0  && elco.getReportType().equals("aggregate")) {
                            sql = getSQL(elco, elco.getViewType() + "upazila");
                        } else if (elco.getUnion() == 0 && elco.getReportType().equals("aggregate")) {
                            sql = getSQL(elco, elco.getViewType() + "union");
                        } else if (elco.getUnit() == 0 && elco.getReportType().equals("aggregate")) {
                            sql = getSQL(elco, elco.getViewType() + "unit") +"order by unit";
                        } else if (elco.getUnit() != 0 && elco.getReportType().equals("aggregate")) {
                            sql = getSQL(elco, elco.getViewType() + "unit") + " where unitid="+elco.getUnit();
                        } else if (elco.getDistrict()!= 0 && elco.getUpazila() == 0 && elco.getReportType().equals("individual")){
                            sql = "SELECT * from public.web_pregnant_woman_all_individual_mv(" + elco.getDistrict() + ", " + "'%'" + ", " + "'%'" + ", " + "'%'" + ", '%' ,'" + Utility.changeFormat(elco.getEndDate()) + "') order by village asc";
                        } else if (elco.getDistrict()!= 0 && elco.getUpazila() != 0 && elco.getUnion()== 0 && elco.getReportType().equals("individual")){
                            sql = "SELECT * from public.web_pregnant_woman_all_individual_mv(" + elco.getDistrict() + ", '" + elco.getUpazila() + "', " + "'%'" + ", " + "'%'" + ", '%' ,'" + Utility.changeFormat(elco.getEndDate()) + "') order by village asc";
                        } else if (elco.getDistrict()!= 0 && elco.getUpazila() != 0 && elco.getUnion()!= 0 && elco.getUnit() == 0 && elco.getReportType().equals("individual")){
                            sql = "SELECT * from public.web_pregnant_woman_all_individual_mv(" + elco.getDistrict() + ", '" + elco.getUpazila() + "', '" + elco.getUnion() + "', " + "'%'" + ", '%' ,'" + Utility.changeFormat(elco.getEndDate()) + "') order by village asc";
                        } else if (elco.getDistrict()!= 0 && elco.getUpazila() != 0 && elco.getUnion()!= 0 && elco.getUnit() != 0 && elco.getVillage().equals("0") && elco.getReportType().equals("individual")) {
                            sql = "SELECT * from public.web_pregnant_woman_village_individual_mv(" + elco.getDistrict() + ", " + elco.getUpazila() + ", " + elco.getUnion() + ", " + elco.getUnit() + ", '%' ,'" + Utility.changeFormat(elco.getEndDate()) + "') order by village asc";  
                        } else if (!elco.getVillage().equals("0") && elco.getReportType().equals("individual")) {
                            sql = "SELECT * from public.web_pregnant_woman_village_individual_mv(" + elco.getDistrict() + ", " + elco.getUpazila() + ", " + elco.getUnion() + ", " + elco.getUnit() + ", '" + elco.getVillage().split(" ")[0] + "" + elco.getVillage().split(" ")[1] + "','" + Utility.changeFormat(elco.getEndDate()) + "') order by village asc";
                        }
                        break;

                    case "periodical":
                        elco.setPeriodicalStartDate(elco.getPeriodicalStartDate().length() == 0 ? "01/01/2015" : elco.getPeriodicalStartDate());
                        if (elco.getUpazila() == 0) {
                            sql = "SELECT  * from public.web_pregnant_woman_upazila_wise_date_range(" + elco.getDistrict() + ",'" +  Utility.changeFormat(elco.getPeriodicalStartDate()) + "','" + Utility.changeFormat(elco.getPeriodicalEndDate()) + "') order by upazilanameeng asc";

                        } else if (elco.getUnion() == 0) {
                            sql = "SELECT  * from public.web_pregnant_woman_union_wise_date_range(" + elco.getDistrict() + "," + elco.getUpazila() + ",'" + Utility.changeFormat(elco.getPeriodicalStartDate()) + "','" + Utility.changeFormat(elco.getPeriodicalEndDate()) + "') order by unionnameeng asc";
                            
                        } else if (elco.getUnit() == 0) {
                            sql = "SELECT  * from public.web_pregnant_woman_unit_wise_date_range(" + elco.getDistrict() + ", " + elco.getUpazila() + ", " + elco.getUnion() + ",'" + Utility.changeFormat(elco.getPeriodicalStartDate()) + "','" + Utility.changeFormat(elco.getPeriodicalEndDate()) + "') order by unit asc";
                           
                        } else if (elco.getUnit() != 0 && elco.getReportType().equals("aggregate")) {
                            sql = "SELECT  * from public.web_pregnant_woman_unit_wise_date_range(" + elco.getDistrict() + ", " + elco.getUpazila() + ", " + elco.getUnion() + ",'" + Utility.changeFormat(elco.getPeriodicalStartDate()) + "','" + Utility.changeFormat(elco.getPeriodicalEndDate()) + "') where unitid = " + elco.getUnit() + " order by unit asc";
                           
                        }
                        break;
                    case "monthly":
                        if (elco.getUpazila() == 0) {
                            sql = "SELECT  * from public.web_pregnant_woman_upazila_wise_monthly_year_month(" + elco.getDistrict() + "," + elco.getStartMonthYear().split("/")[1] + "," + elco.getStartMonthYear().split("/")[0] + "," + elco.getEndMonthYear().split("/")[1] + "," + elco.getEndMonthYear().split("/")[0] + ") order by upazilanameeng, years, months asc";

                        } else if (elco.getUnion() == 0) {
                            sql = "SELECT  * from public.web_pregnant_woman_union_wise_monthly_year_month(" + elco.getDistrict() + "," + elco.getUpazila() + "," + elco.getStartMonthYear().split("/")[1] + "," + elco.getStartMonthYear().split("/")[0] + "," + elco.getEndMonthYear().split("/")[1] + "," + elco.getEndMonthYear().split("/")[0] + ") order by reporting_union_name, years, months asc";
                           
                        } else if (elco.getUnit() == 0) {
                            sql = "SELECT  * from public.web_pregnant_woman_unit_wise_monthly_year_month(" + elco.getDistrict() + "," + elco.getUpazila() + ", " + elco.getUnion() + "," + elco.getStartMonthYear().split("/")[1] + "," + elco.getStartMonthYear().split("/")[0] + "," + elco.getEndMonthYear().split("/")[1] + "," + elco.getEndMonthYear().split("/")[0] + ") order by unit, years, months asc";
                            
                        } else if (elco.getUnit() != 0 && elco.getReportType().equals("aggregate")) {
                            sql = "SELECT  * from public.web_pregnant_woman_unit_wise_monthly_year_month(" + elco.getDistrict() + "," + elco.getUpazila() + ", " + elco.getUnion() + "," + elco.getStartMonthYear().split("/")[1] + "," + elco.getStartMonthYear().split("/")[0] + "," + elco.getEndMonthYear().split("/")[1] + "," + elco.getEndMonthYear().split("/")[0] + ") where unitid = " + elco.getUnit() + " order by unit, years, months asc";
                    
                        }
                        break;
                    case "yearly":
                        if (elco.getUpazila() == 0) {
                            sql = "SELECT  * from public.web_pregnant_woman_upazila_wise_yearly(" + elco.getDistrict() + "," + elco.getStartYear() + "," + elco.getEndYear() + ") order by upazilanameeng, years asc";

                        } else if (elco.getUnion() == 0) {
                            sql = "SELECT  * from public.web_pregnant_woman_union_wise_yearly(" + elco.getDistrict() + "," + elco.getUpazila() + "," + elco.getStartYear() + "," + elco.getEndYear() + ") order by reporting_union_name, years asc";
                            
                        } else if (elco.getUnit() == 0) {
                            sql = "SELECT  * from public.web_pregnant_woman_unit_wise_yearly(" + elco.getDistrict() + "," + elco.getUpazila() + ", " + elco.getUnion() + "," + elco.getStartYear() + "," + elco.getEndYear() + ") order by unit, years asc";
                            
                        } else if (elco.getUnit() != 0 && elco.getReportType().equals("aggregate")) {
                            sql = "SELECT  * from public.web_pregnant_woman_unit_wise_yearly(" + elco.getDistrict() + "," + elco.getUpazila() + ", " + elco.getUnion() + "," + elco.getStartYear() + "," + elco.getEndYear() + ") where unitid = " + elco.getUnit() + " order by unit, years asc";
                           
                        }
                        break;
                    default:
                        response.getWriter().write(new Utility().errorResponse());
                }
            } else {
            }
            System.out.println("PregnantWoman::" + sql);
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

    public int toInt(String num) {
        return Integer.parseInt(num);
    }

    private String getSQL(ELCO elco, String type) {
        System.out.println(elco);
        HashMap<String, String> map = new HashMap<>();
        map.put("atPointupazila", "WITH active_pregnant_women AS (\n"
                + "	SELECT \n"
                + "		distinct m.zillaid\n"
                + "		,m.upazilaid\n"
                + "		,p.healthid\n"
                + "		,p.lmp\n"
                + "		,p.edd\n"
                + "		,p.pregno\n"
                + "	FROM household h\n"
                + "	JOIN member m USING (\n"
                + "			zillaid\n"
                + "			,upazilaid\n"
                + "			,unionid\n"
                + "			,mouzaid\n"
                + "			,villageid\n"
                + "			,hhno\n"
                + "			)\n"
                + "	JOIN elco e ON e.healthid = m.generatedid\n"
                + "	JOIN elcovisit ev ON ev.healthid = e.healthid\n"
                + "	JOIN pregwomen p ON m.generatedid = p.healthid\n"
                + "	WHERE m.sex = 2\n"
                + "		AND m.ms = 2\n"
                + "		AND ev.currstatus = 12\n"
                + "		AND ('" + Utility.changeFormat(elco.getEndDate()) + "' - m.dob)::numeric < (50::numeric * 365.25)\n"
                + "		AND NOT (\n"
                + "			EXISTS (\n"
                + "				SELECT NULL::text AS text\n"
                + "				FROM migrationout mo\n"
                + "				WHERE mo.healthid = m.healthid\n"
                + "					AND mo.systementrydate <= '" + Utility.changeFormat(elco.getEndDate()) + "'\n"
                + "				)\n"
                + "			)\n"
                + "		AND NOT (\n"
                + "			EXISTS (\n"
                + "				SELECT NULL::text AS text\n"
                + "				FROM death d_1\n"
                + "				WHERE d_1.healthid = m.healthid\n"
                + "					AND d_1.deathdt <= '" + Utility.changeFormat(elco.getEndDate()) + "'\n"
                + "				)\n"
                + "			)\n"
                + "		AND ('" + Utility.changeFormat(elco.getEndDate()) + "' - p.edd) < 90\n"
                + "		and m.zillaid = " + elco.getDistrict() + " \n"
                + "		and h.reporting_unionid >= 0\n"
                + "		--and h.unitid >= 0\n"
                + "	ORDER BY m.zillaid\n"
                + "		,m.upazilaid\n"
                + "		,p.healthid\n"
                + "		,p.edd DESC\n"
                + "		,p.pregno DESC\n"
                + ")	\n"
                + ",count_active_pregnant AS (\n"
                + "	SELECT\n"
                + "		pw.zillaid\n"
                + "		,pw.upazilaid\n"
                + "		,count(*) AS active_pregnant_count\n"
                + "	FROM active_pregnant_women pw\n"
                + "	GROUP BY pw.zillaid\n"
                + "		,pw.upazilaid\n"
                + ")\n"
                + "\n"
                + ",Registered_ELCO AS (\n"
                + "	SELECT ru.zillaid\n"
                + "		,ru.upazilaid\n"
                + "		,name_upazila_eng(ru.zillaid, ru.upazilaid) upazilanameeng\n"
                + "		,count(e.healthid) Registered_ELCO\n"
                + "		,(count(e.healthid) * 0.04)::INTEGER Estimated_Pregnant_Woman\n"
                + "	FROM public.eligiblecouple e\n"
                + "	JOIN reporting_union ru on (\n"
                + "			e.zillaid = ru.zillaid\n"
                + "			and e.upazilaid = ru.upazilaid\n"
                + "			and e.reporting_unionid = ru.reporting_unionid\n"
                + "			)\n"
                + "	LEFT JOIN elcovisit_hysterectomy ev on ev.healthid = e.healthid\n"
                + "	WHERE e.regdt <= to_date('" + elco.getEndDate() + "', 'dd/mm/yyyy')\n"
                + "		and (cast(((to_date('" + elco.getEndDate() + "', 'dd/mm/yyyy')) - e.dob) as numeric)) < cast(50 * 365.25 as numeric)\n"
                + "		and (coalesce(ev.currstatus, 0) not in (15))\n"
                + "		and e.zillaid = " + elco.getDistrict() + "\n"
                + "		and e.reporting_unionid is not null\n"
                + "		and e.unitid is not null\n"
                + "		and NOT EXISTS (\n"
                + "			select NULL\n"
                + "			from migrationout mo\n"
                + "			where mo.healthid = e.healthid\n"
                + "				and mo.systementrydate <= to_date('" + elco.getEndDate() + "', 'dd/mm/yyyy')\n"
                + "			)\n"
                + "		and NOT EXISTS (\n"
                + "			select NULL\n"
                + "			from death d\n"
                + "			where d.healthid = e.healthid\n"
                + "				and d.deathdt <= to_date('" + elco.getEndDate() + "', 'dd/mm/yyyy')\n"
                + "			)\n"
                + "	GROUP BY ru.zillaid\n"
                + "		,ru.upazilaid\n"
                + ")\n"
                + "SELECT e.zillaid\n"
                + "	,e.upazilaid\n"
                + "	,p.upazilanameeng\n"
                + "	,p.Registered_ELCO\n"
                + "	,p.Estimated_Pregnant_Woman estimated_pregnant_women\n"
                + "	,e.active_pregnant_count registered_pregnant_women\n"
                + "FROM Registered_ELCO p\n"
                + "left JOIN count_active_pregnant e USING (\n"
                + "		zillaid\n"
                + "		,upazilaid\n"
                + "		) ORDER BY p.upazilanameeng;");

        map.put("atPointunion", "WITH active_pregnant_women AS (\n"
                + "	SELECT \n"
                + "		distinct m.zillaid\n"
                + "		,m.upazilaid\n"
                + "		,h.reporting_unionid\n"
                + "		,p.healthid\n"
                + "		,p.lmp\n"
                + "		,p.edd\n"
                + "		,p.pregno\n"
                + "	FROM household h\n"
                + "	JOIN member m USING (\n"
                + "			zillaid\n"
                + "			,upazilaid\n"
                + "			,unionid\n"
                + "			,mouzaid\n"
                + "			,villageid\n"
                + "			,hhno\n"
                + "			)\n"
                + "	JOIN elco e ON e.healthid = m.generatedid\n"
                + "	JOIN elcovisit ev ON ev.healthid = e.healthid\n"
                + "	JOIN pregwomen p ON m.generatedid = p.healthid\n"
                + "	WHERE m.sex = 2\n"
                + "		AND m.ms = 2\n"
                + "		AND ev.currstatus = 12\n"
                + "		AND ('" + Utility.changeFormat(elco.getEndDate()) + "' - m.dob)::numeric < (50::numeric * 365.25)\n"
                + "		AND NOT (\n"
                + "			EXISTS (\n"
                + "				SELECT NULL::text AS text\n"
                + "				FROM migrationout mo\n"
                + "				WHERE mo.healthid = m.healthid\n"
                + "					AND mo.systementrydate <= '" + Utility.changeFormat(elco.getEndDate()) + "'\n"
                + "				)\n"
                + "			)\n"
                + "		AND NOT (\n"
                + "			EXISTS (\n"
                + "				SELECT NULL::text AS text\n"
                + "				FROM death d_1\n"
                + "				WHERE d_1.healthid = m.healthid\n"
                + "					AND d_1.deathdt <= '" + Utility.changeFormat(elco.getEndDate()) + "'\n"
                + "				)\n"
                + "			)\n"
                + "		AND ('" + Utility.changeFormat(elco.getEndDate()) + "' - p.edd) < 90\n"
                + "		and m.zillaid = " + elco.getDistrict() + "\n"
                + "		and m.upazilaid = "+elco.getUpazila()+"\n"
                + "		\n"
                + "	ORDER BY m.zillaid\n"
                + "		,m.upazilaid\n"
                + "		,h.reporting_unionid\n"
                + "		,p.healthid\n"
                + "		,p.edd DESC\n"
                + "		,p.pregno DESC\n"
                + ")	\n"
                + ",count_active_pregnant AS (\n"
                + "	SELECT\n"
                + "		pw.zillaid\n"
                + "		,pw.upazilaid\n"
                + "		,pw.reporting_unionid\n"
                + "		,count(*) AS active_pregnant_count\n"
                + "	FROM active_pregnant_women pw\n"
                + "	GROUP BY pw.zillaid, pw.upazilaid, pw.reporting_unionid\n"
                + "),\n"
                + "\n"
                + "Registered_ELCO AS (\n"
                + "	SELECT distinct ru.zillaid\n"
                + "		,ru.upazilaid\n"
                + "		,name_upazila_eng(ru.zillaid, ru.upazilaid) upazilanameeng\n"
                + "		,ru.reporting_unionid\n"
                + "		,ru.unionnameeng\n"
                + "		,count(e.healthid) Registered_ELCO\n"
                + "		,(count(e.healthid) * 0.04)::INTEGER Estimated_Pregnant_Woman\n"
                + "	FROM public.eligiblecouple e\n"
                + "	JOIN reporting_union ru USING (\n"
                + "			zillaid\n"
                + "			,upazilaid\n"
                + "			,reporting_unionid\n"
                + "			)\n"
                + "	LEFT JOIN elcovisit_hysterectomy ev on ev.healthid = e.healthid\n"
                + "	WHERE e.regdt <= to_date('" + elco.getEndDate() + "', 'dd/mm/yyyy')\n"
                + "		and (cast(((to_date('" + elco.getEndDate() + "', 'dd/mm/yyyy')) - e.dob) as numeric)) < cast(50 * 365.25 as numeric)\n"
                + "		and (coalesce(ev.currstatus, 0) not in (15))\n"
                + "		and e.zillaid = " + elco.getDistrict() + "\n"
                + "		and e.upazilaid = "+elco.getUpazila()+"\n"
                + "		and NOT EXISTS (\n"
                + "			select NULL\n"
                + "			from migrationout mo\n"
                + "			where mo.healthid = e.healthid\n"
                + "				and mo.systementrydate <= to_date('" + elco.getEndDate() + "', 'dd/mm/yyyy')\n"
                + "			)\n"
                + "		and NOT EXISTS (\n"
                + "			select NULL\n"
                + "			from death d\n"
                + "			where d.healthid = e.healthid\n"
                + "				and d.deathdt <= to_date('" + elco.getEndDate() + "', 'dd/mm/yyyy')\n"
                + "			)\n"
                + "	GROUP BY ru.zillaid\n"
                + "		,ru.upazilaid\n"
                + "		,ru.reporting_unionid\n"
                + "		,ru.unionnameeng\n"
                + ")\n"
                + "SELECT e.zillaid\n"
                + "	,e.upazilaid\n"
                + "	,p.reporting_unionid\n"
                + "	,p.unionnameeng\n"
                + "	,p.Registered_ELCO\n"
                + "	,p.Estimated_Pregnant_Woman estimated_pregnant_women\n"
                + "	,e.active_pregnant_count registered_pregnant_women\n"
                + "FROM Registered_ELCO p\n"
                + "left JOIN count_active_pregnant e  USING (\n"
                + "		zillaid\n"
                + "		,upazilaid, reporting_unionid\n"
                + "		) ORDER BY p.unionnameeng;");

        map.put("atPointunit", "WITH active_pregnant_women AS (\n"
                + "	SELECT \n"
                + "		distinct m.zillaid\n"
                + "		,m.upazilaid\n"
                + "		,h.reporting_unionid\n"
                + "		,h.unitid\n"
                + "		,p.healthid\n"
                + "		,p.lmp\n"
                + "		,p.edd\n"
                + "		,p.pregno\n"
                + "	FROM household h\n"
                + "	JOIN member m USING (\n"
                + "			zillaid\n"
                + "			,upazilaid\n"
                + "			,unionid\n"
                + "			,mouzaid\n"
                + "			,villageid\n"
                + "			,hhno\n"
                + "			)\n"
                + "	JOIN elco e ON e.healthid = m.generatedid\n"
                + "	JOIN elcovisit ev ON ev.healthid = e.healthid\n"
                + "	JOIN pregwomen p ON m.generatedid = p.healthid\n"
                + "	WHERE m.sex = 2\n"
                + "		AND m.ms = 2\n"
                + "		AND ev.currstatus = 12\n"
                + "		AND ('" + Utility.changeFormat(elco.getEndDate()) + "' - m.dob)::numeric < (50::numeric * 365.25)\n"
                + "		AND NOT (\n"
                + "			EXISTS (\n"
                + "				SELECT NULL::text AS text\n"
                + "				FROM migrationout mo\n"
                + "				WHERE mo.healthid = m.healthid\n"
                + "					AND mo.systementrydate <= '" + Utility.changeFormat(elco.getEndDate()) + "'\n"
                + "				)\n"
                + "			)\n"
                + "		AND NOT (\n"
                + "			EXISTS (\n"
                + "				SELECT NULL::text AS text\n"
                + "				FROM death d_1\n"
                + "				WHERE d_1.healthid = m.healthid\n"
                + "					AND d_1.deathdt <= '" + Utility.changeFormat(elco.getEndDate()) + "'\n"
                + "				)\n"
                + "			)\n"
                + "		AND ('" + Utility.changeFormat(elco.getEndDate()) + "' - p.edd) < 90\n"
                + "		and m.zillaid = " + elco.getDistrict() + "\n"
                + "		and m.upazilaid = "+elco.getUpazila()+"\n"
                + "		and h.reporting_unionid = "+elco.getUnion()+"\n"
                + "		\n"
                + "	ORDER BY m.zillaid\n"
                + "		,m.upazilaid\n"
                + "		,h.reporting_unionid\n"
                + "		,h.unitid\n"
                + "		,p.healthid\n"
                + "		,p.edd DESC\n"
                + "		,p.pregno DESC\n"
                + ")	\n"
                + ",count_active_pregnant AS (\n"
                + "	SELECT\n"
                + "		pw.zillaid\n"
                + "		,pw.upazilaid\n"
                + "		,pw.reporting_unionid\n"
                + "		,pw.unitid\n"
                + "		,count(*) AS active_pregnant_count\n"
                + "	FROM active_pregnant_women pw\n"
                + "	GROUP BY pw.zillaid, pw.upazilaid, pw.reporting_unionid, pw.unitid\n"
                + "),\n"
                + "\n"
                + "Registered_ELCO AS\n"
                + "(\n"
                + "	SELECT ru.zillaid\n"
                + "		,ru.upazilaid\n"
                + "		,name_upazila_eng(ru.zillaid, ru.upazilaid) upazilanameeng\n"
                + "		,ru.reporting_unionid\n"
                + "		,ru.unionnameeng\n"
                + "		,e.unitid\n"
                + "		,e.unit\n"
                + "		,count(e.healthid) Registered_ELCO\n"
                + "		,(count(e.healthid) * 0.04)::INTEGER Estimated_Pregnant_Woman\n"
                + "	FROM public.eligiblecouple e\n"
                + "	JOIN reporting_union ru USING (\n"
                + "			zillaid\n"
                + "			,upazilaid\n"
                + "			,reporting_unionid\n"
                + "			)\n"
                + "	LEFT JOIN elcovisit_hysterectomy ev on ev.healthid = e.healthid\n"
                + "	WHERE e.regdt\n"
                + "		<= to_date('" + elco.getEndDate() + "', 'dd/mm/yyyy') \n"
                + "		and (cast(((to_date('" + elco.getEndDate() + "', 'dd/mm/yyyy')) - e.dob) as numeric)) < cast(50 * 365.25 as numeric)\n"
                + "		and (coalesce(ev.currstatus, 0) not in (15))\n"
                + "		and e.zillaid = " + elco.getDistrict() + "\n"
                + "		and e.upazilaid = "+elco.getUpazila()+"\n"
                + "		and e.reporting_unionid = "+elco.getUnion()+"\n"
                + "		and NOT EXISTS (\n"
                + "			select NULL\n"
                + "			from migrationout mo\n"
                + "			where mo.healthid = e.healthid\n"
                + "				and mo.systementrydate <= to_date('" + elco.getEndDate() + "', 'dd/mm/yyyy')\n"
                + "			)\n"
                + "		and NOT EXISTS (\n"
                + "			select NULL\n"
                + "			from death d\n"
                + "			where d.healthid = e.healthid\n"
                + "				and d.deathdt <= to_date('" + elco.getEndDate() + "', 'dd/mm/yyyy')\n"
                + "			)\n"
                + "		--and e.reporting_unionid is not null\n"
                + "		--and e.unitid is not null\n"
                + "	GROUP BY ru.zillaid\n"
                + "		,ru.upazilaid\n"
                + "		,ru.reporting_unionid\n"
                + "		,ru.unionnameeng\n"
                + "		,e.unitid\n"
                + "		,e.unit\n"
                + ")\n"
                + ",provider_unit as\n"
                + "(\n"
                + "SELECT  distinct on (um.zillaid,um.upazilaid,um.unitid)\n"
                + "         um.zillaid\n"
                + "	,um.upazilaid\n"
                + "	--,name_upazila_eng(um.zillaid, um.upazilaid) upazilanameeng\n"
                + "	,um.reporting_unionid\n"
                + "	--,um.unionnameeng\n"
                + "	,um.unitid\n"
                + "        ,um.unit\n"
                + "        ,u.uname\n"
                + "        ,pu.providerid\n"
                + "	,sp_providername(pu.providerid) provname\n"
                + "	,public.sp_providermobile(pu.providerid) providermobile\n"
                + "	,um.active\n"
                + "	,pu.assign_type\n"
                + "	\n"
                + "from  unit_master um\n"
                + "LEFT JOIN unit_details ud using (unitid)\n"
                + "LEFT JOIN public.providerarea_unit pu on pu.unitid = um.unitid\n"
                + "LEFT JOIN fwaunit u on um.unit = u.ucode\n"
                + "WHERE um.zillaid=" + elco.getDistrict() + " and um.upazilaid="+elco.getUpazila()+" and um.reporting_unionid="+elco.getUnion()+"\n"
                + "--LEFT JOIN reporting_union ru on um.zillaid = um.zillaid	and um.upazilaid = um.upazilaid	and um.reporting_unionid = um.reporting_unionid\n"
                + ")\n"
                + "\n"
                + "\n"
                + "\n"
                + "SELECT e.zillaid\n"
                + "	,e.upazilaid\n"
                + "	,p.reporting_unionid\n"
                + "	, u.unitid\n"
                + ", u.unit\n"
                + ", u.uname\n"
                + ", u.providerid\n"
                + ", u.provname\n"
                + ", u.providermobile\n"
                + ", u.active\n"
                + ", u.assign_type\n"
                + "	,p.Registered_ELCO\n"
                + "	,p.Estimated_Pregnant_Woman estimated_pregnant_women\n"
                + "	,e.active_pregnant_count registered_pregnant_women\n"
                + "FROM count_active_pregnant e\n"
                + "right JOIN Registered_ELCO p USING (\n"
                + "		zillaid\n"
                + "		,upazilaid, reporting_unionid, unitid\n"
                + "		)\n"
                + "	RIGHT JOIN provider_unit u USING (unitid)");

        return map.get(type);
    }
}
