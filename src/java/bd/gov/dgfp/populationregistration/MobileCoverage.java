package bd.gov.dgfp.populationregistration;

import com.emis.entity.NIDCoverageModel;
import com.emis.utility.Convertor;
import com.emis.utility.Menu;
import com.emis.utility.Utility;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.rhis.db.DBManagerDistrict;
import java.io.IOException;
import java.io.PrintWriter;
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
@WebServlet(name = "MobileCoverage", urlPatterns = {"/mobile-phone-coverage"})
public class MobileCoverage extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Menu.setMenu("POPULATION REGISTRATION", "mobile-phone-coverage", request);
        request.getRequestDispatcher("WEB-INF/jsp/newPopulationRegistration/MobileCoverage.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            ObjectMapper mapper = new ObjectMapper();
            NIDCoverageModel prs = mapper.readValue(request.getParameter("data").toString(), NIDCoverageModel.class);

            response.setContentType("text/plain;charset=UTF-8");
            String sql = "";
            if (prs.getLevel().equals("atPoint")) {
                switch (request.getParameter("viewType")) {
                    case "Upazila":
                        sql = "select * from sp_possession_mobile_coverage_upazila_wise_up_to_date(" + prs.getZillaid() + ",'" + prs.getEndDate() + "') order by upazilanameeng asc";
                        break;
                    case "Union":
                        sql = "select * from sp_possession_mobile_coverage_union_wise_up_to_date(" + prs.getZillaid() + "," + prs.getUpazilaid() + ",'" + prs.getEndDate() + "') order by unionnameeng asc";
                        break;
                    case "Unit":
                        String where = "";
                        if (prs.getUnitid() != 0) {
                            where = "where unitid=" + prs.getUnitid();
                        }
                        sql = "select * from sp_possession_mobile_coverage_unit_wise_up_to_date(" + prs.getZillaid() + "," + prs.getUpazilaid() + "," + prs.getUnionid() + ",'" + prs.getEndDate() + "') " + where + " order by uname asc";
                        break;
                    default:
                        response.getWriter().write(new Utility().errorResponse());
                }
            } else if (prs.getLevel().equals("monthly")) {
                switch (request.getParameter("viewType")) {
                    case "Upazila":
                        sql = "SELECT  * from public.sp_possession_mobile_coverage_upazila_wise_monthly_year_month(" + prs.getZillaid() + "," + prs.getStartMonthYear().split("/")[1] + "," + prs.getStartMonthYear().split("/")[0] + "," + prs.getEndMonthYear().split("/")[1] + "," + prs.getEndMonthYear().split("/")[0] + ") order by upazilanameeng, years, months asc";
                        break;
                    case "Union":
                        sql = "SELECT  * from public.sp_possession_mobile_coverage_union_wise_monthly_year_month(" + prs.getZillaid() + "," + prs.getUpazilaid() + "," + prs.getStartMonthYear().split("/")[1] + "," + prs.getStartMonthYear().split("/")[0] + "," + prs.getEndMonthYear().split("/")[1] + "," + prs.getEndMonthYear().split("/")[0] + ") order by unionnameeng, years, months asc";
                        break;
                    case "Unit":
                        String where = "";
                        if (prs.getUnitid() != 0) {
                            where = "where unitid=" + prs.getUnitid();
                        }
                        sql = "SELECT  * from public.sp_possession_mobile_coverage_unit_wise_monthly_year_month(" + prs.getZillaid() + "," + prs.getUpazilaid() + ", " + prs.getUnionid() + "," + prs.getStartMonthYear().split("/")[1] + "," + prs.getStartMonthYear().split("/")[0] + "," + prs.getEndMonthYear().split("/")[1] + "," + prs.getEndMonthYear().split("/")[0] + ") " + where + " order by uname, years, months asc";
                        break;
                    default:
                        response.getWriter().write(new Utility().errorResponse());
                }
            }
            DBManagerDistrict db = new DBManagerDistrict(prs.getZillaid());
            JSONArray json = Convertor.convertResultSetIntoJSON(db.select(sql));
            System.out.println(json);
            response.getWriter().write("{\"success\":true,\"data\":" + json.toString() + "}");
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write(new Utility().errorResponse());
        }
    }

}
