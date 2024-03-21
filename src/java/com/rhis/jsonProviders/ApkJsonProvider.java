package com.rhis.jsonProviders;

import com.emis.beans.ApkMeta;
import com.emis.utility.Convertor;
import com.rhis.db.DBManagerMonitoring;
import java.io.IOException;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.JSONArray;

/*
 * @author Rahen
 */
@WebServlet(name = "ApkJsonProvider", urlPatterns = {"/apkJsonProvider"})
public class ApkJsonProvider extends HttpServlet {

    protected String getPath(HttpServletRequest request) {
        String p = request.getServletPath() != null ? request.getServletPath() : "";
        return p;
    }

    protected String getParam(String key, HttpServletRequest request) {
        String p = request.getParameter(key);
        return p == null ? "" : p;
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = getParam("action", request);
        String id = getParam("id", request);
        ResultSet result = "type".equals(action) ? ApkMeta.getType(id) : ApkMeta.getList(id);
        JSONArray json;
        try {
            json = Convertor.toJSON(result);
            response.setContentType("text/plain;charset=UTF-8");
            response.getWriter().write(json.toString());
        } catch (Exception ex) {
            System.out.println(getClass().getName()+">>"+ex.getMessage());
        }

    }
}
