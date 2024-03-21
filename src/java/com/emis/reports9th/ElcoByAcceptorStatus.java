package com.emis.reports9th;

import com.emis.dao.UserDao;
import com.emis.utility.Convertor;
import com.emis.utility.Menu;
import com.emis.utility.Utility;
import com.rhis.db.DBManagerDistrict;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
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
@WebServlet(name = "ElcoByAcceptorStatus", urlPatterns = {"/elco-by-acceptor-status"})
public class ElcoByAcceptorStatus extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Menu.setMenu("VIEW REPORTS", "elco-by-acceptor-status", request);
        String view = "WEB-INF/jsp/reports9th/ElcoByAcceptorStatus.jsp";
        try {
            if (request.getSession(false).getAttribute("district") != null) {
                if (!new UserDao().isPaperless(request.getSession(false).getAttribute("district").toString())) {
                    response.sendRedirect(request.getContextPath() + "/ElcoCountChildAndAgeWise");
                } else {
                    request.getRequestDispatcher(view).forward(request, response);
                }
            } else {
                request.getRequestDispatcher(view).forward(request, response);
            }
        } catch (Exception e) {
            request.getRequestDispatcher(view).forward(request, response);
        }
//        Menu.setMenu("VIEW REPORTS", "elco-by-acceptor-status", request);
//        request.getRequestDispatcher("WEB-INF/jsp/reports9th/ElcoByAcceptorStatus.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String district = request.getParameter("district");
        String upazila = request.getParameter("upazila");
        String union = request.getParameter("union");
        String unit = request.getParameter("unit");
        String type = request.getParameter("type");
        String date = Utility.changeFormat(request.getParameter("date").toString());
        String year = request.getParameter("year");
        response.setContentType("text/plain;charset=UTF-8");

        System.out.println(upazila + "~~~~~~~~~~~" + union + "~~~~~~~~~~~" + unit);
        try {
            DBManagerDistrict db = new DBManagerDistrict(Integer.parseInt(district));
            String sql = "";

            if (union.equals("")) {
                if (type.equals("yearWise")) {
                    sql = "select * from public.web_elco_by_acceptor_status_upazila_wise_dgfp (" + district + "," + upazila + "," + year + ") order by age;";
                } else {
                    sql = "select * from public.web_elco_by_acceptor_status_upazila_wise_dgfp_specific_date(" + district + "," + upazila + ",'" + date + "') order by age";
                }
            } else if (unit.equals("")) {
                if (type.equals("yearWise")) {
                    sql = "select * from public.web_elco_by_acceptor_status_union_wise_dgfp (" + district + "," + upazila + "," + union + "," + year + ") order by age";
                } else {
                    sql = "select * from public.web_elco_by_acceptor_status_union_wise_dgfp_specific_date (" + district + "," + upazila + "," + union + ",'" + date + "') order by age";
                }
            } else {
                if (type.equals("yearWise")) {
                    sql = "select * from web_elco_by_acceptor_status_dgfp (" + district + "," + upazila + "," + union + "," + unit + "," + year + ") order by age";
                } else {
                    sql = "select * from web_elco_by_acceptor_status_dgfp_specific_date (" + district + "," + upazila + "," + union + "," + unit + ",'" + date + "') order by age";
                }
            }

//            if (type.equals("yearWise")) {
//                sql = "select * from web_elco_by_acceptor_status_dgfp (" + district + "," + upazila + "," + union + "," + unit + "," + year + ")";
//            } else {
//                sql = "select * from web_elco_by_acceptor_status_dgfp_specific_date (" + district + "," + upazila + "," + union + "," + unit + ",'" + date + "')";
//            }
            //sql = "select * from public.web_elco_by_acceptor_status_union_wise_dgfp (93,66,70,2020)";
            //sql = "select * from public.web_elco_by_acceptor_status_upazila_wise_dgfp (93,66,2020)";
            ResultSet result = db.select(sql);
            JSONArray json = Convertor.convertResultSetIntoJSONWithZero(result);
            response.getWriter().write(json.toString());
        } catch (Exception ex) {
            response.getWriter().write(ex.getMessage());
        }
    }
}
