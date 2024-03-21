package com.emis.management;

import com.emis.entity.PRS;
import com.emis.service.AssetService;
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
 * @author Helal | m.helal.k@gmail.com | 2019-03-24
 */
@WebServlet(name = "Asset", urlPatterns = {"/asset"})
public class Asset extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Menu.setMenu("MANAGEMENT", "asset", request);
        if (request.getParameter("type") == null) {
            request.getRequestDispatcher("WEB-INF/jsp/management/distributedAsset.jsp").forward(request, response);
        } else if (request.getParameter("type").toString().equals("master")) {
            request.getRequestDispatcher("WEB-INF/jsp/management/masterAsset.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        try {
            ObjectMapper mapper = new ObjectMapper();
            //PRS prs = mapper.readValue(request.getParameter("prs").toString(), PRS.class);
            com.emis.entity.AssetBACK asset = null;
            response.setContentType("text/plain;charset=UTF-8");

            switch (request.getParameter("action")) {
                case "getDesignation":
                    asset = new com.emis.entity.AssetBACK();
                    asset.setZillaid(49);
                    response.getWriter().write("{\"success\":true, \"designation\":" + new AssetService(asset.getZillaid()).getProviderType() + "}");
                    break;
                case "getStatus":
                    asset = new com.emis.entity.AssetBACK();
                    asset.setZillaid(49);
                    response.getWriter().write("{\"success\":true,\"status\":" + new AssetService(asset.getZillaid()).getStatus() + "}");
                    break;
                case "showData":
                    asset = mapper.readValue(request.getParameter("asset"), com.emis.entity.AssetBACK.class);
                    response.getWriter().write("{\"success\":true,\"data\":" + new AssetService(asset.getZillaid()).getData(asset) + "}");
                    break;

                case "assetDetails":
                    response.getWriter().write("{\"success\":true,\"data\":" + new AssetService(Integer.parseInt(request.getParameter("zillaid"))).getAssetDetails(request.getParameter("zillaid"), request.getParameter("imei1"), request.getParameter("providerid")) + "}");
                    break;
                default:
                    response.getWriter().write(new Utility().errorResponse());
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write(new Utility().errorResponse());
        }

        /*
        response.setContentType("text/plain;charset=UTF-8");

        switch (request.getParameter("action")) {
            case "getDesignation":
                try {
                    response.getWriter().write("{\"success\":true,\"status\":1, \"designation\":" + new AssetService().getDesignation() + "}");
                } catch (PSQLException e) {
                    e.printStackTrace();
                    response.getWriter().write(new Utility().errorResponse());
                } catch (Exception e) {
                    e.printStackTrace();
                    response.getWriter().write(new Utility().errorResponse());
                }
                break;

            case "getStatus":
                try {
                    response.getWriter().write("{\"success\":true,\"status\":" + new AssetService().getStatus() + "}");
                } catch (PSQLException e) {
                    e.printStackTrace();
                    response.getWriter().write(new Utility().errorResponse());
                } catch (Exception e) {
                    e.printStackTrace();
                    response.getWriter().write(new Utility().errorResponse());
                }
                break;

            case "getDistributedData":
                try {
                    response.getWriter().write("{\"success\":true,\"data\":" + new AssetService().getDistributedData() + "}");
                } catch (PSQLException e) {
                    e.printStackTrace();
                    response.getWriter().write(new Utility().errorResponse());
                } catch (Exception e) {
                    e.printStackTrace();
                    response.getWriter().write(new Utility().errorResponse());
                }
                break;

            case "viewDistributedAssetDetails":
                try {
                    response.getWriter().write("{\"success\":true,\"data\":" + new AssetService().getDistributedAssetDetails(request.getParameter("imei1"), request.getParameter("sim_number"), request.getParameter("name_of_user"), request.getParameter("providerid"), request.getParameter("mobileno")) + "}");
                } catch (PSQLException e) {
                    e.printStackTrace();
                    response.getWriter().write(new Utility().errorResponse());
                } catch (Exception e) {
                    e.printStackTrace();
                    response.getWriter().write(new Utility().errorResponse());
                }
                break;

            case "viewDistributedMasterAssetDetails":
                try {
                    response.getWriter().write("{\"success\":true,\"data\":" + new AssetService().getDistributedAssetDetails(request.getParameter("imei1"), request.getParameter("sim_number"), request.getParameter("name_of_user"), request.getParameter("providerid"), request.getParameter("mobileno")) + "}");
                } catch (PSQLException e) {
                    e.printStackTrace();
                    response.getWriter().write(new Utility().errorResponse());
                } catch (Exception e) {
                    e.printStackTrace();
                    response.getWriter().write(new Utility().errorResponse());
                }
                break;

            case "viewAssetBySelector":
                try {
                    response.getWriter().write("{\"success\":true,\"data\":" + new AssetService().getAssetBySelector(request.getParameter("designation").toString(), request.getParameter("status").toString()) + "}");
                } catch (PSQLException e) {
                    e.printStackTrace();
                    response.getWriter().write(new Utility().errorResponse());
                } catch (Exception e) {
                    e.printStackTrace();
                    response.getWriter().write(new Utility().errorResponse());
                }
                break;

            case "viewAssetByStatus":
                try {
                    response.getWriter().write("{\"success\":true,\"data\":" + new AssetService().getAssetByStatus(request.getParameter("status").toString()) + "}");
                } catch (PSQLException e) {
                    e.printStackTrace();
                    response.getWriter().write(new Utility().errorResponse());
                } catch (Exception e) {
                    e.printStackTrace();
                    response.getWriter().write(new Utility().errorResponse());
                }
                break;

            case "getMasterAsset":
                try {
                    response.getWriter().write("{\"success\":true,\"data\":" + new AssetService().getMasterAsset() + "}");
                } catch (PSQLException e) {
                    e.printStackTrace();
                    response.getWriter().write(new Utility().errorResponse());
                } catch (Exception e) {
                    e.printStackTrace();
                    response.getWriter().write(new Utility().errorResponse());
                }
                break;

            default:
                response.getWriter().write(new Utility().errorResponse());
        }*/
    }
}
