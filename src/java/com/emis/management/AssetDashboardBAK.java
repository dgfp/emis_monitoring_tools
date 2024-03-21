package com.emis.management;

import com.emis.dao.AssetDashboardDao;
import com.emis.dao.AssetDashboardDaoBAK;
import com.emis.entity.AssetReport;
import com.emis.utility.Menu;
import com.emis.utility.Utility;
import com.fasterxml.jackson.databind.ObjectMapper;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.json.JSONArray;

/**
 *
 * @author Helal
 */
@WebServlet(name = "AssetDashboardBAK", urlPatterns = {"/asset-dashboard-bak"})
public class AssetDashboardBAK extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Menu.setMenu("MANAGEMENT", "asset-dashboard", request);
        request.getRequestDispatcher("WEB-INF/jsp/management/AssetDashboardBAK.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        AssetReport asset = new ObjectMapper().readValue(request.getParameter("asset").toString(), AssetReport.class);
        AssetReport userAsset = this.getUserAssetReport(request, asset);
        JSONArray status = null, total_provider = null, total_asset = null, tabletStockStatus = null, tabletFunctionalityStatus = null, ageOfTablet = null, tabletStatusByWarrantyPeriod = null, projectedPurchaseNeedByLevel = null, projectedPurchaseNeed = null, numberOfTabletsLost = null, tabletRepairStatus = null;
        HttpSession session = request.getSession();
        int userLevel = Integer.parseInt(session.getAttribute("userLevel").toString());

        try {
            response.setContentType("text/plain;charset=UTF-8");
            switch (request.getParameter("action")) {
                case "getDashboard":
                    //Status
                    status = new AssetDashboardDaoBAK().getStatus(userAsset);
                    //total_provider = new AssetDashboardDao().getTotalProvider(userAsset);
                    //total_asset = new AssetDashboardDao().getTotalAsset(userAsset);

                    //Table data
                    tabletStockStatus = new AssetDashboardDaoBAK().getTabletStockStatus(userAsset);
                    tabletFunctionalityStatus = new AssetDashboardDaoBAK().getTabletFunctionalityStatus(userAsset);

                    //call based on user
                    if (userLevel != 2 || userLevel != 3 || userLevel != 4) {
                        ageOfTablet = new AssetDashboardDaoBAK().getAgeOfTablet(userAsset);
                    }
                    //call based on user
                    if (userLevel != 2 || userLevel != 3 || userLevel != 4) {
                        tabletStatusByWarrantyPeriod = new AssetDashboardDaoBAK().getTabletStatusByWarrantyPeriod(userAsset);
                    }

                    //projectedPurchaseNeed = new AssetDashboardDao().getProjectedPurchaseNeed(userAsset);
                    projectedPurchaseNeedByLevel = new AssetDashboardDaoBAK().getProjectedPurchaseNeedByLevel(userAsset);

                    numberOfTabletsLost = new AssetDashboardDaoBAK().getNumberOfTabletsLost(userAsset);
                    //call based on user
                    if (userLevel != 2 || userLevel != 3 || userLevel != 4) {
                        tabletRepairStatus = new AssetDashboardDaoBAK().getTabletRepairStatus(userAsset);
                    }

                    response.getWriter().write("{\"success\":true, \"tablet_repair_status\":" + tabletRepairStatus + ", \"number_of_tablets_lost\":" + numberOfTabletsLost + ", \"tablet_status_by_warranty_period\":" + tabletStatusByWarrantyPeriod + ", \"projected_purchase_need\":" + projectedPurchaseNeedByLevel + ", \"status\":" + status + ", \"total_provider\":" + total_provider + ", \"total_asset\":" + total_asset + ", \"tablet_stock_status\":" + tabletStockStatus + ", \"tablet_functionality_status\":" + tabletFunctionalityStatus + ", \"age_of_tablet\":" + ageOfTablet + "}");
                    break;

                case "getTabletStockStatus":
                    tabletStockStatus = new AssetDashboardDaoBAK().getTabletStockStatus(userAsset);
                    response.getWriter().write("{\"success\":true, \"tablet_stock_status\":" + tabletStockStatus + "}");
                    break;

                case "getTabletFunctionalityStatus":
                    tabletFunctionalityStatus = new AssetDashboardDaoBAK().getTabletFunctionalityStatus(userAsset);
                    response.getWriter().write("{\"success\":true, \"tablet_functionality_status\":" + tabletFunctionalityStatus + "}");
                    break;

                case "getAgeOfTablet":
                    ageOfTablet = new AssetDashboardDaoBAK().getAgeOfTablet(userAsset);
                    response.getWriter().write("{\"success\":true, \"age_of_tablet\":" + ageOfTablet + "}");
                    break;

                case "getProjectedPurchaseNeedByLevel":
                    projectedPurchaseNeedByLevel = new AssetDashboardDaoBAK().getProjectedPurchaseNeedByLevel(userAsset);
                    response.getWriter().write("{\"success\":true, \"projected_purchase_need\":" + projectedPurchaseNeedByLevel + "}");
                    break;

                case "getNumberOfTabletsLost":
                    numberOfTabletsLost = new AssetDashboardDaoBAK().getNumberOfTabletsLost(userAsset);
                    response.getWriter().write("{\"success\":true, \"number_of_tablets_lost\":" + numberOfTabletsLost + "}");
                    break;

                default:
                    response.getWriter().write(new Utility().errorResponse());
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write(new Utility().errorResponse());
        }
    }

    private AssetReport getUserAssetReport(HttpServletRequest request, AssetReport userAssetReport) {
        HttpSession session = request.getSession();
        int userLevel = Integer.parseInt(session.getAttribute("userLevel").toString());
        //AssetReport userAssetReport = new AssetReport();
        switch (userLevel) {
            case 2:
                userAssetReport.setDivid(Integer.parseInt(session.getAttribute("division").toString()));
                break;

            case 3:
                userAssetReport.setDivid(Integer.parseInt(session.getAttribute("division").toString()));
                userAssetReport.setZillaid(Integer.parseInt(session.getAttribute("district").toString()));
                break;

            case 4:
                userAssetReport.setDivid(Integer.parseInt(session.getAttribute("division").toString()));
                userAssetReport.setZillaid(Integer.parseInt(session.getAttribute("district").toString()));
                userAssetReport.setUpazilaid(Integer.parseInt(session.getAttribute("upazila").toString()));
                break;
            default:
        }
        return userAssetReport;
    }
}
