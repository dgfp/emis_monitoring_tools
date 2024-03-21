package bd.gov.dgfp.populationregistration;

import com.emis.entity.PRSStatistics;
import com.emis.service.PRSService;
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
import org.postgresql.util.PSQLException;

/**
 *
 * @author Helal
 */
@WebServlet(name = "PopulationStatistics", urlPatterns = {"/population-statistics"})
public class PopulationStatistics extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Menu.setMenu("POPULATION REGISTRATION", "population-statistics", request);
        request.getRequestDispatcher("WEB-INF/jsp/newPopulationRegistration/PopulationStatistics.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            ObjectMapper mapper = new ObjectMapper();
            PRSStatistics prs = mapper.readValue(request.getParameter("data").toString(), PRSStatistics.class);
            response.setContentType("text/plain;charset=UTF-8");
            String sql = "";
            if (prs.getLevel().equals("population")) {
                switch (request.getParameter("viewType")) {
                    case "Upazila":
                        sql = "select * from population_statistics_population_level_upazila_wise(" + prs.getZillaid() + ",'" + prs.getEndDate() + "') order by upazilanameeng asc";
                        break;
                    case "Union":
                        sql = "select * from population_statistics_population_level_union_wise(" + prs.getZillaid() + "," + prs.getUpazilaid() + ",'" + prs.getEndDate() + "') order by unionnameeng asc";
                        break;
                    case "Unit":
                        String where = "";
                        if (prs.getUnitid() != 0) {
                            where = "where unitid=" + prs.getUnitid();
                        }
                        sql = "select * from population_statistics_population_unit_level_unit_wise(" + prs.getZillaid() + "," + prs.getUpazilaid() + "," + prs.getUnionid() + ",'" + prs.getEndDate() + "') " + where + " order by uname asc";
                        break;
                    default:
                        response.getWriter().write(new Utility().errorResponse());
                }
            } else if (prs.getLevel().equals("household")) {
                switch (request.getParameter("viewType")) {
                    case "Upazila":
                        sql = "select * from population_statistics_hh_level_upazila_wise(" + prs.getZillaid() + ",'" + prs.getEndDate() + "') order by upazilanameeng asc";
                        break;
                    case "Union":
                        sql = "select * from population_statistics_hh_level_union_wise(" + prs.getZillaid() + "," + prs.getUpazilaid() + ",'" + prs.getEndDate() + "') order by unionnameeng asc";
                        break;
                    case "Unit":
                        String where = "";
                        if (prs.getUnitid() != 0) {
                            where = "where unitid=" + prs.getUnitid();
                        }
                        sql = "select * from population_statistics_hh_unit_level_unit_wise(" + prs.getZillaid() + "," + prs.getUpazilaid() + "," + prs.getUnionid() + ",'" + prs.getEndDate() + "') " + where + " order by uname asc";
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
