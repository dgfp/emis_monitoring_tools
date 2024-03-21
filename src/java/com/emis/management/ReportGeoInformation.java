package com.emis.management;

import com.emis.dao.ReportingGeoDao;
import com.emis.entity.PRS;
import com.emis.entity.ProviderAreaUnit;
import com.emis.entity.ReportingUpazila;
import com.emis.entity.ReportingUnion;
import com.emis.entity.ReportingUnionFPI;
import com.emis.entity.ReportingUnit;
import com.emis.entity.ReportingUpazilaUFPO;
import com.emis.service.AssetService;
import com.emis.utility.Menu;
import com.emis.utility.Print;
import com.emis.utility.Utility;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.rhis.db.DBManagerDistrict;
import java.io.IOException;
import java.util.List;
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
@WebServlet(name = "ReportGeoInformation", urlPatterns = {"/report-geo-info"})
public class ReportGeoInformation extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Menu.setMenu("MANAGEMENT", "report-geo-info", request);
        String served = "WEB-INF/jsp/management/ReportGeoInformation/ReportGeoInformationUfpo.jsp";

        if ("ReportingUpazila".equals(request.getParameter("action"))) {
            served = "WEB-INF/jsp/management/ReportGeoInformation/ReportGeoInformationUfpo.jsp";
        } else if ("ReportingUnion".equals(request.getParameter("action"))) {
            served = "WEB-INF/jsp/management/ReportGeoInformation/ReportGeoInformationUnion.jsp";
        } else if ("ReportingUnit".equals(request.getParameter("action"))) {
            served = "WEB-INF/jsp/management/ReportGeoInformation/ReportGeoInformationUnit.jsp";
        }
        request.getRequestDispatcher(served).forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            ReportingUnion ru = null;
            ReportingUnit reportingUnit = null;
            ReportingUpazila reportingUpazila = null;
            String fwaAssignmentresult = "";
            response.setContentType("text/plain;charset=UTF-8");
            switch (request.getParameter("action")) {

                case "getReportingUpazila":
                    reportingUpazila = new ObjectMapper().readValue(request.getParameter("data").toString(), ReportingUpazila.class);
                    response.getWriter().write("{\"success\":true, \"ufpo\":" + new ReportingGeoDao(reportingUpazila.getZillaid()).getUFPOList() + ", \"upazila\":" + new ReportingGeoDao(reportingUpazila.getZillaid()).getUpazilaList(reportingUpazila.getZillaid()) + "}");
                    break;
                case "getReportingUpazilaDetailsByUFPO":
                    reportingUpazila = new ObjectMapper().readValue(request.getParameter("data").toString(), ReportingUpazila.class);
                    response.getWriter().write("{\"success\":true, \"reporting_upazila_assigned\":" + new ReportingGeoDao(reportingUpazila.getZillaid()).getReportingUpazilaDetailsByUFPO(reportingUpazila) + "}");
                    break;
                ////getReportingUpazilaDetailsByUFPO
//                case "insertUFPOAssignment":
//                    response.getWriter().write("{\"success\":true, \"ufpo\":" + new ReportingGeoDao(districtId).setUFPO(request.getParameter("data")) + "}");
//                    break;
                case "getUnassignedReportingUnionByUpazila":
                    ru = new ObjectMapper().readValue(request.getParameter("data").toString(), ReportingUnion.class);
                    response.getWriter().write("{\"success\":true, \"reporting_union\":" + new ReportingGeoDao(ru.getZillaid()).getUnassignedReportingUnionByUpazila(ru) + "}");
                    break;
                case "insertReportingUpazilaUFPO":
                    reportingUpazila = new ObjectMapper().readValue(request.getParameter("data").toString(), ReportingUpazila.class);
                    reportingUpazila.setUpazilaid(reportingUpazila.getReporting_upazilaid());
                    response.getWriter().write("{\"success\":true, \"message\":\"" + new ReportingGeoDao(reportingUpazila.getZillaid()).insertReportingUpazilaUFPO(reportingUpazila) + "\"}");
                    break;

                case "insertUnionDetails":
                    ru = new ObjectMapper().readValue(request.getParameter("data").toString(), ReportingUnion.class);
                    String insertReportingUnionStatus = new ReportingGeoDao(ru.getZillaid()).setReportingUnion(ru);
                    response.getWriter().write("{\"success\":true, \"message\":\"" + insertReportingUnionStatus + "\"}");
                    break;
                case "updateUnionDetails":
                    ru = new ObjectMapper().readValue(request.getParameter("data").toString(), ReportingUnion.class);

                    if (!new ReportingGeoDao(ru.getZillaid()).checkDataUnderUnion(ru)) {
                        if (!new ReportingGeoDao(ru.getZillaid()).checkUnionAssignedProvider(ru)) {
                            String updateReportingUnion = new ReportingGeoDao(ru.getZillaid()).updateReportingUnion(ru);
                            response.getWriter().write("{\"success\":true, \"message\":\"" + updateReportingUnion + "\"}");
                        } else {
                            response.getWriter().write("{\"success\":\"error\", \"message\":\"Please unassign this union defore update\"}");
                        }
                    } else {
                        response.getWriter().write("{\"success\":\"error\", \"message\":\"Can't update, this union has MIS-2 data\"}");
                    }
                    break;
                case "deleteUnionDetails":
                    ru = new ObjectMapper().readValue(request.getParameter("data").toString(), ReportingUnion.class);

                    if (!new ReportingGeoDao(ru.getZillaid()).checkDataUnderUnion(ru)) {
                        if (!new ReportingGeoDao(ru.getZillaid()).checkUnionAssignedProvider(ru)) {
                            String deleteReportingUnion = new ReportingGeoDao(ru.getZillaid()).deleteReportingUnion(ru);
                            response.getWriter().write("{\"success\":true, \"message\":\"" + deleteReportingUnion + "\"}");
                        } else {
                            response.getWriter().write("{\"success\":\"error\", \"message\":\"Please unassign this union defore delete\"}");
                        }
                    } else {
                        response.getWriter().write("{\"success\":\"error\", \"message\":\"Can't delete, this union has MIS-2 data\"}");
                    }
                    break;
//                case "insertFPIAssignment":
//                    ru = new ObjectMapper().readValue(request.getParameter("data").toString(), ReportingUnion.class);
//                    String result = new ReportingGeoDao(districtId).setFPI(ru);
//                    response.getWriter().write("{\"success\":true, \"message\":\"" + result + "\"}");
//                    break;
                case "getReportingUnion":
                    ru = new ObjectMapper().readValue(request.getParameter("data").toString(), ReportingUnion.class);
                    response.getWriter().write("{\"success\":true, \"reporting_union\":" + new ReportingGeoDao(ru.getZillaid()).getReportingUnion(ru) + "}");
                    break;
//                case "getFPIAssignment":
//                    ru = new ObjectMapper().readValue(request.getParameter("data").toString(), ReportingUnion.class);
//                    response.getWriter().write("{\"success\":true, \"fpi\":" + new ReportingGeoDao(ru.getZillaid()).getFPI(ru) + "}");
//                    break;
//                //INSERT REPORTING_UNIONFPI TABLE
                case "setReportingUnionFPI":
                    ru = new ObjectMapper().readValue(request.getParameter("data").toString(), ReportingUnion.class);
                    response.getWriter().write("{\"success\":true, \"message\":\"" + new ReportingGeoDao(ru.getZillaid()).setReportingUnionFPI(ru) + "\"}");
                    break;
                case "getReportingUnionFPI":
                    ru = new ObjectMapper().readValue(request.getParameter("data").toString(), ReportingUnion.class);
                    response.getWriter().write("{\"success\":true, \"fpi\":" + new ReportingGeoDao(ru.getZillaid()).getReportingUnionFPI(ru) + "}");
                    break;
                case "getReportingUnionByBbsUpazila":
                    ru = new ObjectMapper().readValue(request.getParameter("data").toString(), ReportingUnion.class);
                    response.getWriter().write("{\"success\":true, \"reporting_union\":" + new ReportingGeoDao(ru.getZillaid()).getReportingUnionByBbsUpazila(ru) + "}");
                    break;
                case "getReportingUnionByBbsUnion":
                    ru = new ObjectMapper().readValue(request.getParameter("data").toString(), ReportingUnion.class);
                    System.out.println(ru.toString());
                    response.getWriter().write("{\"success\":true, \"reporting_union\":" + new ReportingGeoDao(ru.getZillaid()).getReportingUnionByBbsUnion(ru) + "}");
                    break;

                case "getUnitByReportingUnion":
                    ru = new ObjectMapper().readValue(request.getParameter("data").toString(), ReportingUnion.class);
                    System.out.println(ru.toString());
                    response.getWriter().write("{\"success\":true, \"reporting_unit\":" + new ReportingGeoDao(ru.getZillaid()).getUnitByReportingUnion(ru) + "}");
                    break;
                case "setUnitDetails":
                    reportingUnit = new ObjectMapper().readValue(request.getParameter("data").toString(), ReportingUnit.class);
                    String insertUnitDetailsResult = new ReportingGeoDao(reportingUnit.getZillaid()).setUnitDetails(reportingUnit);
                    response.getWriter().write("{\"success\":true, \"message\":\"" + insertUnitDetailsResult + "\"}");
                    break;
                case "getUnitDetails":
                    reportingUnit = new ObjectMapper().readValue(request.getParameter("data").toString(), ReportingUnit.class);
                    JSONArray unit_details = new ReportingGeoDao(reportingUnit.getZillaid()).getUnitDetails(reportingUnit);
                    response.getWriter().write("{\"success\":true, \"unit_details\":" + unit_details + "}");
                    break;
                case "insertProviderareaUnit":
                    reportingUnit = new ObjectMapper().readValue(request.getParameter("data").toString(), ReportingUnit.class);
                    String insertProviderareaUnit = new ReportingGeoDao(reportingUnit.getZillaid()).insertProviderareaUnit(reportingUnit);
                    response.getWriter().write("{\"success\":true, \"message\":\"" + insertProviderareaUnit + "\"}");
                    break;
                case "getProviderAreaUnit":
                    ru = new ObjectMapper().readValue(request.getParameter("data").toString(), ReportingUnion.class);
                    response.getWriter().write("{\"success\":true, \"providerarea_unit\":" + new ReportingGeoDao(reportingUnit.getZillaid()).getProviderAreaUnit(ru.getProviderid()) + "}");
                    break;
                case "insertFWAAssignment":
                    reportingUnit = new ObjectMapper().readValue(request.getParameter("data").toString(), ReportingUnit.class);
                    fwaAssignmentresult = new ReportingGeoDao(reportingUnit.getZillaid()).insertFWAUnit(reportingUnit);
                    response.getWriter().write("{\"success\":true, \"message\":\"" + fwaAssignmentresult + "\"}");
                    break;
                case "getFWAAssignment":
                    JSONArray ja = new ReportingGeoDao(reportingUnit.getZillaid()).getFWAAssignment();
                    response.getWriter().write("{\"success\":true, \"fwa\":" + ja + "}");
                    break;
                case "deleteUnit":
                    reportingUnit = new ObjectMapper().readValue(request.getParameter("data").toString(), ReportingUnit.class);
                    if (!new ReportingGeoDao(reportingUnit.getZillaid()).checkDataUnderUnit(reportingUnit)) {
                        if (!new ReportingGeoDao(reportingUnit.getZillaid()).checkUnitAssignedProviderAreaUnit(reportingUnit.getZillaid(), reportingUnit.getUpazilaid(), reportingUnit.getUnionid(), reportingUnit.getUnitid())) {
                            //delete unit
                            String msg = new ReportingGeoDao(reportingUnit.getZillaid()).deleteUnit(reportingUnit.getUnitid());
                            response.getWriter().write("{\"success\":\"success\", \"message\":\"" + msg + "\"}");
                        } else {
                            response.getWriter().write("{\"success\":\"error\", \"message\":\"Please unassign this unit defore delete\"}");
                        }
                    } else {
                        response.getWriter().write("{\"success\":\"error\", \"message\":\"Can't delete, this unit has household data\"}");
                    }
                    break;

                case "updateUnit":
                    reportingUnit = new ObjectMapper().readValue(request.getParameter("data").toString(), ReportingUnit.class);
                    Print.o(reportingUnit);
                    if (!new ReportingGeoDao(reportingUnit.getZillaid()).checkUnitAssignedProviderAreaUnit(reportingUnit.getZillaid(), reportingUnit.getUpazilaid(), reportingUnit.getUnionid(), reportingUnit.getUnitid())) {

                        if (!new ReportingGeoDao(reportingUnit.getZillaid()).checkDataUnderUnit(reportingUnit)) {
                            String msg = new ReportingGeoDao(reportingUnit.getZillaid()).updateUnit(reportingUnit);
                            response.getWriter().write("{\"success\":\"success\", \"message\":\"" + msg + "\"}");

                        } else {
                            /*????????????
                                Can't find unionid in payload, after getting unionid, will replace reporting_unionid by unionid from everywhere?
                                Check HH data under village - only for deletetion?
                             */
                            String msg = "";
                            //First find out, is there any new village or not from update unit villages. If found then insert into unit_details table
                            System.out.println("~~~~~~~~~~~~~~~~~~~Add new village in existing unit~~~~~~~~~~~~~~~~~~~~~~~~~~");
                            List<String> addVillages = new ReportingGeoDao(reportingUnit.getZillaid()).getNewVillagesByUpdateUnitVillages(reportingUnit);
                            int addCount = new ReportingGeoDao(reportingUnit.getZillaid()).addNewVillagesByUpdateUnitVillages(addVillages, reportingUnit);
                            msg += addCount + " village added, ";

                            //Secondly find out, is there any village in unit details which is not exist in update unit villages, and then check HH data if not found, then it will be deleted.
                            System.out.println("~~~~~~~~~~~~~~~~~~~Remove village from unit details~~~~~~~~~~~~~~~~~~~~~~~~~~");
                            List<String> removeVillages = new ReportingGeoDao(reportingUnit.getZillaid()).getVillagesToRemove(reportingUnit);
                            int removeCount = new ReportingGeoDao(reportingUnit.getZillaid()).removeVillagesByUpdateUnitVillages(removeVillages, reportingUnit);
                            msg += removeCount + " village removed";

//                            if(removeCount > 0){
//                                msg+="";
//                            }else{
//                                msg+="";
//                            }
//
//                            if (addCount > 0 || removeCount > 0) {
//                                response.getWriter().write("{\"success\":\"success\", \"message\":\"Unit update successfully\"}");
//                            } else {
//                                response.getWriter().write("{\"success\":\"error\", \"message\":\"Can't update, this unit has household data\"}");
//                            }
                            response.getWriter().write("{\"success\":\"success\", \"message\":\""+msg+"\"}");
                        }
                    } else {
                        response.getWriter().write("{\"success\":\"error\", \"message\":\"Please unassign this unit defore update\"}");
                    }
                    break;

                case "updateFWAAssignType":
                    ProviderAreaUnit[] paul = new ObjectMapper().readValue(request.getParameter("data").toString(), ProviderAreaUnit[].class);
                    if (new ReportingGeoDao(paul[0].getZillaid()).updateFWAAssignType(paul)) {
                        response.getWriter().write("{\"success\":\"success\", \"message\":\"Assign type updated successfully\"}");
                    } else {
                        response.getWriter().write("{\"success\":\"error\", \"message\":\"Something went wrong\"}");
                    }
                    break;

                case "updateFPIAssignType":
                    ReportingUnionFPI[] ruf = new ObjectMapper().readValue(request.getParameter("data").toString(), ReportingUnionFPI[].class);
                    if (new ReportingGeoDao(ruf[0].getZillaid()).updateFPIAssignType(ruf)) {
                        response.getWriter().write("{\"success\":\"success\", \"message\":\"Assign type updated successfully\"}");
                    } else {
                        response.getWriter().write("{\"success\":\"error\", \"message\":\"Something went wrong\"}");
                    }
                    break;

                case "updateUFPOAssignType":
                    ReportingUpazilaUFPO[] ruu = new ObjectMapper().readValue(request.getParameter("data").toString(), ReportingUpazilaUFPO[].class);
                    if (new ReportingGeoDao(ruu[0].getZillaid()).updateUFPOAssignType(ruu)) {
                        response.getWriter().write("{\"success\":\"success\", \"message\":\"Assign type updated successfully\"}");
                    } else {
                        response.getWriter().write("{\"success\":\"error\", \"message\":\"Something went wrong\"}");
                    }
                    break;

                default:
                    response.getWriter().write(new Utility().errorResponse());
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write(e.getMessage());
        }
    }
}
