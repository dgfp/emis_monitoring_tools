package bd.gov.dgfp.populationregistration;

import com.emis.entity.PRS;
import com.emis.service.MobileCoverageService;
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
@WebServlet(name = "MobilePhoneCoverageHH", urlPatterns = {"/mobile-phone-coverage-hh"})
public class MobilePhoneCoverageHH extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)  throws ServletException, IOException {
        Menu.setMenu("POPULATION REGISTRATION", "mobile-phone-coverage-hh", request);
        request.setAttribute("userLevel", (String) request.getSession(false).getAttribute("userLevel"));
        request.getRequestDispatcher("WEB-INF/jsp/newPopulationRegistration/MobilePhoneCoverageHH.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            //ObjectMapper mapper = new ObjectMapper();
            PRS prs = new ObjectMapper().readValue(request.getParameter("prs").toString(), PRS.class);
            prs = Utility.setStartDate(prs);
            
            MobileCoverageService mobileCoverageService;
            response.setContentType("text/plain;charset=UTF-8");

            switch (request.getParameter("viewType")) {
                case "District":
                    mobileCoverageService = new MobileCoverageService();
                    response.getWriter().write("{\"success\":true,\"data\":" + mobileCoverageService.getDistrictMobile(prs) + "}");
                    break;

                case "Upazila":
                    mobileCoverageService = new MobileCoverageService(prs.getZillaid());
                    response.getWriter().write("{\"success\":true,\"data\":" + mobileCoverageService.getUpazilaMobile(prs) + "}");
                    break;

                case "Union":
                    mobileCoverageService = new MobileCoverageService(prs.getZillaid());
                    response.getWriter().write("{\"success\":true,\"data\":" + mobileCoverageService.getUnionMobile(prs) + "}");
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
