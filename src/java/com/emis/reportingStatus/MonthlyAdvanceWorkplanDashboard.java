package com.emis.reportingStatus;

import com.emis.entity.WorkplanArea;
import com.emis.service.MAWService;
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
@WebServlet(name = "MonthlyAdvanceWorkplanDashboard", urlPatterns = {"/MonthlyAdvanceWorkplanDashboard"})
public class MonthlyAdvanceWorkplanDashboard extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Menu.setMenu("REPORTING STATUS", "MonthlyAdvanceWorkplanDashboard", request);
        request.getRequestDispatcher("WEB-INF/jsp/reportingStatus/MonthlyAdvanceWorkplanDashboard.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
                
        response.setContentType("text/plain;charset=UTF-8");
        switch (request.getParameter("action")) {
            case "getStatus":
                try {
                    ObjectMapper mapper = new ObjectMapper();
                    WorkplanArea workplanArea = mapper.readValue(request.getParameter("workplanArea").toString(), WorkplanArea.class);
                    
                    MAWService mawService = new MAWService(workplanArea.getZillaid());
                    response.getWriter().write("{\"success\":true,\"data\":" + mawService.getStatus(workplanArea).toString() + "}");
                } catch(PSQLException e){
                    e.printStackTrace();
                    response.getWriter().write(new Utility().errorResponse());
                } catch (Exception e) {
                    e.printStackTrace();
                    response.getWriter().write(new Utility().errorResponse());
                }
                break;
                
//            case "getAllProvider":
//                try {
//                    MAWService mawService = new MAWService(workplanArea.getZillaid());
//                    response.getWriter().write("{\"success\":true,\"data\":" + mawService.getTotalProvider(workplanArea).toString() + "}");
//                } catch(PSQLException e){
//                    e.printStackTrace();
//                    response.getWriter().write(new Utility().errorResponse());
//                } catch (Exception e) {
//                    e.printStackTrace();
//                    response.getWriter().write(new Utility().errorResponse());
//                }
//                break;
                
            case "getProviderList":
                try {
                    ObjectMapper mapper = new ObjectMapper();
                    WorkplanArea workplanArea = mapper.readValue(request.getParameter("workplanArea").toString(), WorkplanArea.class);
        
                    MAWService mawService = new MAWService(workplanArea.getZillaid());
                    response.getWriter().write("{\"success\":true,\"data\":" + mawService.getFWAProviderList(workplanArea, Integer.parseInt(request.getParameter("type").toString())).toString() + "}");
                } catch(PSQLException e){
                    e.printStackTrace();
                    response.getWriter().write(new Utility().errorResponse());
                } catch (Exception e) {
                    e.printStackTrace();
                    response.getWriter().write(new Utility().errorResponse());
                }
                break;
                
            case "getWorkplan":
                try {
                    int zillaid = Integer.parseInt(request.getParameter("zillaid").toString());
                    int providerid = Integer.parseInt(request.getParameter("providerid").toString());
                    int provtype = Integer.parseInt(request.getParameter("provtype").toString());
                    int month = Integer.parseInt(request.getParameter("month").toString());
                    int year = Integer.parseInt(request.getParameter("year").toString());
                    MAWService mawService = new MAWService(zillaid);
                    response.getWriter().write("{\"success\":true,\"data\":" + mawService.getWorkplan(zillaid, providerid, provtype, month, year) + "}");
                } catch (Exception e) {
                    e.printStackTrace();
                    response.getWriter().write(new Utility().errorResponse());
                }
                break;
                
            default:
                response.getWriter().write(new Utility().errorResponse());
        }
    }

}
