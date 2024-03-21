package bd.gov.dgfp.populationregistration;

import com.emis.entity.PRS;
import com.emis.service.PRSService;
import com.emis.utility.Menu;
import com.emis.utility.Utility;
import com.fasterxml.jackson.databind.ObjectMapper;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.postgresql.util.PSQLException;

/**
 *
 * @author Helal
 */
@WebServlet(name = "PRSCoverage", urlPatterns = {"/prs-coverage"})
public class PRSCoverage extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Menu.setMenu("POPULATION REGISTRATION", "prs-coverage", request);
        request.getRequestDispatcher("WEB-INF/jsp/newPopulationRegistration/PRSCoverage.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            ObjectMapper mapper = new ObjectMapper();
            PRS prs = mapper.readValue(request.getParameter("prs").toString(), PRS.class);
            PRSService prsService ;
            response.setContentType("text/plain;charset=UTF-8");
            
            switch (request.getParameter("viewType")) {
                case "District":
                    prsService = new PRSService();
                    response.getWriter().write("{\"success\":true,\"data\":" + prsService.getDistrictPRS(prs) + "}");
                    break;
                    
                case "Upazila":
                    prsService = new PRSService(prs.getZillaid());
                    response.getWriter().write("{\"success\":true,\"data\":" + prsService.getUpazilaPRS(prs) + "}");
                    break;
                    
                case "Union":
                    prsService = new PRSService(prs.getZillaid());
                    response.getWriter().write("{\"success\":true,\"data\":" + prsService.getUnionPRS(prs) + "}");
                    break;

                default:
                    response.getWriter().write(new Utility().errorResponse());
            }
        } 
        catch (PSQLException e) {
            e.printStackTrace();
            response.getWriter().write(new Utility().errorResponse());
        } 
        catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write(new Utility().errorResponse());
        }
    }
}