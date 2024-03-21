package com.emis.service;

import com.rhis.db.DBManagerDistrict;
//import static com.sun.corba.se.spi.presentation.rmi.StubAdapter.request;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;

/**
 *
 * @author Helal | m.helal.k@gmail.com
 */
public class Service {

    public static int getUpazilaIdBySubId(long submissionId, int districtId) throws SQLException {
        int upazilaid = 0;
        ResultSet rs = new DBManagerDistrict(districtId).select("SELECT upazilaid FROM public.web_report_submission where submission_id=" + submissionId);
        while (rs.next()) {
            upazilaid = rs.getInt("upazilaid");
        }
        return upazilaid;
    }

    public Service() {
    }

    public static int getUserSupervisor(int providerId, int districtId) throws SQLException {
        int supervisorCode = 0;
        DBManagerDistrict db = new DBManagerDistrict(districtId);
        String sql = "SELECT * FROM  public.providerdb where providerid=" + providerId;
        ResultSet rs = db.select(sql);
        while (rs.next()) {
            supervisorCode = rs.getInt("supervisorcode");
        }
        return supervisorCode;
    }

    public static RequestDispatcher getRequestDispatcher(HttpServletRequest request, String subMenu, String menu) {
        request.setAttribute("submenu", subMenu);
        request.setAttribute("menu", menu);
        request.setAttribute("userLevel", (String) request.getSession(false).getAttribute("userLevel"));
        return request.getRequestDispatcher("WEB-INF/jsp/reports/" + subMenu + ".jsp");
    }

    public static int getUFPOByUpazila(String districtId, String upazilaid) throws SQLException {
        int providerid = 0;
        ResultSet rs = new DBManagerDistrict(Integer.parseInt(districtId)).select("SELECT * FROM public.providerdb where zillaid=" + districtId + " and upazilaid=" + upazilaid + " and unionid=999 and provtype=15 and active=1");
        while (rs.next()) {
            providerid = rs.getInt("providerid");
        }
        return providerid;
    }

    public static int getUFPOByUpazilaDGFP(String districtId, String upazilaid) throws SQLException {
        int providerid = 0;
        ResultSet rs = new DBManagerDistrict(Integer.parseInt(districtId)).select("Select providerid from reporting_upazila_ufpo where zillaid=" + districtId + " and upazilaid = " + upazilaid);
        while (rs.next()) {
            providerid = rs.getInt("providerid");
        }
        return providerid;
    }

    public static int getReportingUnionFPI(int zillaid, int upazilaid, int unionId) throws SQLException {
        int providerid = 0;
        ResultSet rs = new DBManagerDistrict(zillaid).select("SELECT providerid FROM public.reporting_union_fpi where zillaid=" + zillaid + " and  upazilaid=" + upazilaid + " and reporting_unionid=" + unionId + " limit 1");
        while (rs.next()) {
            providerid = rs.getInt("providerid");
        }
        return providerid;
    }
}
