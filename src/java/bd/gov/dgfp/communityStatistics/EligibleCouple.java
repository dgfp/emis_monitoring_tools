package bd.gov.dgfp.communityStatistics;

import com.emis.dao.UserDao;
import com.emis.entity.ELCO;
import com.emis.utility.Convertor;
import com.emis.utility.Menu;
import com.emis.utility.Utility;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.rhis.db.DBManagerDistrict;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.JSONArray;

/**
 *
 * @author Helal | m.helal.k@gmail.com
 */
@WebServlet(name = "EligibleCouple", urlPatterns = {"/eligible-couple"})
public class EligibleCouple extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Menu.setMenu("COMMUNITY STATISTICS", "eligible-couple", request);
        request.setAttribute("userLevel", (String) request.getSession(false).getAttribute("userLevel"));
        String view = "WEB-INF/jsp/dgfpCommunityStatistics/EligibleCouple.jsp";
        try {
            if (request.getSession(false).getAttribute("district") != null) {
                if (!new UserDao().isPaperless(request.getSession(false).getAttribute("district").toString())) {
                    response.sendRedirect(request.getContextPath() + "/elco_details");
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
            String sql = "";
            if (request.getParameter("action").equals("aggregate")) {
                switch (elco.getViewType()) {
                    case "atPoint":
                        elco.setEndDate(elco.getEndDate().length() == 0 ? Utility.getDateNow() : elco.getEndDate());
                        if (elco.getUpazila() == 0) {
                            sql = "SELECT  * from public.web_eligible_couple_upazila_wise(" + elco.getDistrict() + ",'" + elco.getEndDate() + "') order by upazilanameeng asc";
                        } else if (elco.getUnion() == 0) {
                            sql = "SELECT  * from public.web_eligible_couple_union_wise(" + elco.getDistrict() + "," + elco.getUpazila() + ",'" + elco.getEndDate() + "') order by unionnameeng asc";
                        } else if (elco.getUnit() == 0) {
                            sql = "SELECT  * from public.web_eligible_couple_unit_wise(" + elco.getDistrict() + ", " + elco.getUpazila() + ", " + elco.getUnion() + ",'" + elco.getEndDate() + "') order by uname asc";
                        } else if (elco.getUnit() != 0 && elco.getReportType().equals("aggregate")) {
                            sql = "SELECT  * from public.web_eligible_couple_unit_wise(" + elco.getDistrict() + ", " + elco.getUpazila() + ", " + elco.getUnion() + ",'" + elco.getEndDate() + "') where unitid = "+elco.getUnit()+" order by uname asc";
                        } else if (elco.getVillage().equals("0") && elco.getReportType().equals("individual")) {
                            sql = "SELECT * from public.web_eligible_couple_village_individual_mv(" + elco.getDistrict() + ", " + elco.getUpazila() + ", " + elco.getUnion() + ", " + elco.getUnit() + ", '%' ,'" + elco.getEndDate() + "') order by village asc";
                        }else if (!elco.getVillage().equals("0") && elco.getReportType().equals("individual")) {
                            sql = "SELECT * from public.web_eligible_couple_village_individual_mv(" + elco.getDistrict() + ", " + elco.getUpazila() + ", " + elco.getUnion() + ", " + elco.getUnit() + ", '" + elco.getVillage().split(" ")[0] + "" + elco.getVillage().split(" ")[1] + "','" + elco.getEndDate() + "') order by village asc";
                        }
                        break;
                    case "periodical":
                        elco.setPeriodicalStartDate(elco.getPeriodicalStartDate().length() == 0 ? "01/01/2015" : elco.getPeriodicalStartDate());
                        if (elco.getUpazila() == 0) {
                            sql = "SELECT  * from public.web_eligible_couple_upazila_wise_date_range(" + elco.getDistrict() + ",'" + elco.getPeriodicalStartDate() + "','" + elco.getPeriodicalEndDate() + "') order by upazilanameeng asc";
                        } else if (elco.getUnion() == 0) {
                            sql = "SELECT  * from public.web_eligible_couple_union_wise_date_range(" + elco.getDistrict() + "," + elco.getUpazila() + ",'" + elco.getPeriodicalStartDate() + "','" + elco.getPeriodicalEndDate() + "') order by unionnameeng asc";
                        } else if (elco.getUnit() == 0) {
                            sql = "SELECT  * from public.web_eligible_couple_unit_wise_date_range(" + elco.getDistrict() + ", " + elco.getUpazila() + ", " + elco.getUnion() + ",'" + elco.getPeriodicalStartDate() + "','" + elco.getPeriodicalEndDate() + "') order by uname asc";
                        } else if (elco.getUnit() != 0 && elco.getReportType().equals("aggregate")) {
                            sql = "SELECT  * from public.web_eligible_couple_unit_wise_date_range(" + elco.getDistrict() + ", " + elco.getUpazila() + ", " + elco.getUnion() + ",'" + elco.getPeriodicalStartDate() + "','" + elco.getPeriodicalEndDate() + "') where unitid = "+elco.getUnit()+" order by uname asc";
                        }
                        break;
                    case "monthly":
                        if (elco.getUpazila() == 0) {
                            sql = "SELECT  * from public.web_eligible_couple_upazila_wise_monthly_year_month(" + elco.getDistrict() + "," + elco.getStartMonthYear().split("/")[1] + "," + elco.getStartMonthYear().split("/")[0] + "," + elco.getEndMonthYear().split("/")[1] + "," + elco.getEndMonthYear().split("/")[0] + ") order by upazilanameeng, years, months asc";
                        } else if (elco.getUnion() == 0) {
                            sql = "SELECT  * from public.web_eligible_couple_union_wise_monthly_year_month(" + elco.getDistrict() + "," + elco.getUpazila() + "," + elco.getStartMonthYear().split("/")[1] + "," + elco.getStartMonthYear().split("/")[0] + "," + elco.getEndMonthYear().split("/")[1] + "," + elco.getEndMonthYear().split("/")[0] + ") order by reporting_union_name, years, months asc";
                        } else if (elco.getUnit() == 0) {
                            sql = "SELECT  * from public.web_eligible_couple_unit_wise_monthly_year_month(" + elco.getDistrict() + "," + elco.getUpazila() + ", " + elco.getUnion() + "," + elco.getStartMonthYear().split("/")[1] + "," + elco.getStartMonthYear().split("/")[0] + "," + elco.getEndMonthYear().split("/")[1] + "," + elco.getEndMonthYear().split("/")[0] + ") order by uname, years, months asc";
                        } else if (elco.getUnit() != 0 && elco.getReportType().equals("aggregate")) {
                            sql = "SELECT  * from public.web_eligible_couple_unit_wise_monthly_year_month(" + elco.getDistrict() + "," + elco.getUpazila() + ", " + elco.getUnion() + "," + elco.getStartMonthYear().split("/")[1] + "," + elco.getStartMonthYear().split("/")[0] + "," + elco.getEndMonthYear().split("/")[1] + "," + elco.getEndMonthYear().split("/")[0] + ") where unitid = "+elco.getUnit()+" order by uname, years, months asc";
                        }
                        break;
                    case "yearly":
                        if (elco.getUpazila() == 0) {
                            sql = "SELECT  * from public.web_eligible_couple_upazila_wise_yearly(" + elco.getDistrict() + "," + elco.getStartYear() + "," + elco.getEndYear() + ") order by upazilanameeng, years asc";
                        } else if (elco.getUnion() == 0) {
                            sql = "SELECT  * from public.web_eligible_couple_union_wise_yearly(" + elco.getDistrict() + "," + elco.getUpazila() + "," + elco.getStartYear() + "," + elco.getEndYear() + ") order by reporting_union_name, years asc";
                        } else if (elco.getUnit() == 0) {
                            sql = "SELECT  * from public.web_eligible_couple_unit_wise_yearly(" + elco.getDistrict() + "," + elco.getUpazila() + ", " + elco.getUnion() + "," + elco.getStartYear() + "," + elco.getEndYear() + ") order by uname, years asc";
                        } else if (elco.getUnit() != 0 && elco.getReportType().equals("aggregate")) {
                            sql = "SELECT  * from public.web_eligible_couple_unit_wise_yearly(" + elco.getDistrict() + "," + elco.getUpazila() + ", " + elco.getUnion() + "," + elco.getStartYear() + "," + elco.getEndYear() + ") where unitid = "+elco.getUnit()+" order by uname, years asc";
                        }
                        break;
                    default:
                        response.getWriter().write(new Utility().errorResponse());
                }
            } else {
            }
            DBManagerDistrict db = new DBManagerDistrict(elco.getDistrict());
            JSONArray json = Convertor.convertResultSetIntoJSON(db.select(sql));
            response.setContentType("text/plain;charset=UTF-8");
            //"{success: true, message: "", data: ""}
            System.out.println(json);
            response.getWriter().write(json.toString());
        } catch (Exception ex) {
            ex.printStackTrace();
            response.getWriter().write(ex.getMessage());
        }
    }

    public int toInt(String num) {
        return Integer.parseInt(num);
    }
}
