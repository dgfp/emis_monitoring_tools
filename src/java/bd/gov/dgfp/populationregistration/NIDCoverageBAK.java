package bd.gov.dgfp.populationregistration;

import com.emis.dao.NIDCoverageDao;
import com.emis.entity.PRS;
import com.emis.utility.Menu;
import com.emis.utility.Utility;
import com.fasterxml.jackson.databind.ObjectMapper;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Helal
 */
@WebServlet(name = "NIDCoverageBAK", urlPatterns = {"/nid-coverage-bak"})
public class NIDCoverageBAK extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Menu.setMenu("POPULATION REGISTRATION", "nid-coverage", request);
        request.setAttribute("userLevel", (String) request.getSession(false).getAttribute("userLevel"));
        request.getRequestDispatcher("WEB-INF/jsp/newPopulationRegistration/NIDCoverage.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            PRS prs = new ObjectMapper().readValue(request.getParameter("prs").toString(), PRS.class);
            prs = Utility.setStartDate(prs);
            prs.setStartDate(Utility.changeFormat(prs.getStartDate()));
            prs.setEndDate(Utility.changeFormat(prs.getEndDate()));
            
            NIDCoverageDao nidCoverageDao;
            response.setContentType("text/plain;charset=UTF-8");
            switch (request.getParameter("viewType")) {
                case "District":
                    nidCoverageDao = new NIDCoverageDao();
                    response.getWriter().write("{\"success\":true,\"data\":" + nidCoverageDao.getDistrictWise(prs) + "}");
                    break;

                case "Upazila":
                    nidCoverageDao = new NIDCoverageDao(prs.getZillaid());
                    response.getWriter().write("{\"success\":true,\"data\":" + nidCoverageDao.getUpazilaWise(prs) + "}");
                    break;

                case "Union":
                    nidCoverageDao = new NIDCoverageDao(prs.getZillaid());
                    response.getWriter().write("{\"success\":true,\"data\":" + nidCoverageDao.getUnionWise(prs) + "}");
                    break;

                default:
                    response.getWriter().write(new Utility().errorResponse());
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write(new Utility().errorResponse());
        }
    }
}