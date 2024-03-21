/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.emis.management;

import com.emis.beans.ApkMeta;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.rhis.db.DBManagerMonitoring;
import java.io.IOException;
import java.nio.file.Paths;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

/**
 *
 * @author Rahen
 */
@WebServlet(name = "ApkManage", urlPatterns = {"/apk-upload", "/apk-download"})
@MultipartConfig
public class ApkManage extends HttpServlet {

    protected String getDir() {
        String dirname = getServletContext().getRealPath("uploads");
        System.out.println("dirname:" + dirname);
        return dirname;
    }

    protected String getParam(String k, String v, HttpServletRequest request) {
        String p = request.getParameter(k);
        return p == null || "".equals(p) ? v : p;
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("id");
        if (id == null) {
            return;
        }
        ResultSet result = ApkMeta.getList(id);
        try {
            while (result.next()) {
                ApkMeta meta = new ApkMeta(getDir());
                String filename = result.getString("filename");
                meta.setFilename(filename);
                meta.setProvtype(result.getString("filetype"));
                meta.setVersion(result.getString("version"));
                meta.setTypename(result.getString("typename"));
                meta.setOutput(response.getOutputStream());
                //
                String filetype = "application/octet-stream";
                response.setContentType(filetype);
                response.setHeader("Content-disposition", "attachment; filename=" + meta.getFilename()+".txt" );
                meta.download();
            }
        } catch (SQLException ex) {

        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        Part part = request.getPart("file");
        ApkMeta meta = new ApkMeta(getDir());
        meta.setId(request.getParameter("id"));
        meta.setProvtype(request.getParameter("provtype"));
        meta.setTypename(getParam("typename", null, request));
        meta.setVersion(request.getParameter("version"));
        meta.setDescription(request.getParameter("description"));
        meta.setZillaid(getParam("zillaid", null, request));
        meta.setUpazilaid(getParam("upazilaid", null, request));
        meta.setUnionid(getParam("unionid", null, request));

       
        if (part != null) {
            String filename = Paths.get(part.getSubmittedFileName()).getFileName().toString();
            //
            meta.setFilename(filename);
            meta.setPrettySize(part.getSize());
            meta.setFiletype(part.getContentType());
            meta.setInput(part.getInputStream());
            //
             meta.upload();
            //
            try {
                String fmt = "INSERT INTO  apk  (id,filename,filesize,filetype,provtype,version,description,zillaid,upazilaid,unionid) VALUES(%s,'%s' ,'%s', '%s', %s, '%s', '%s', %s, %s, %s)";
                String sql = String.format(fmt, meta.getId(), meta.getFilename(), meta.getFilesize(), meta.getFiletype(), meta.getProvtype(), meta.getVersion(), meta.getDescription(), meta.getZillaid(), meta.getUpazilaid(), meta.getUnionid());
                System.out.println("SQL: " + sql);
                DBManagerMonitoring db = new DBManagerMonitoring();
                int result = db.update(sql);
            } catch (Exception ex) {
                System.out.println("ERR: " + ex.getMessage());
            }
            
            response.setContentType("text/plain;charset=UTF-8");
            ObjectMapper mapper = new ObjectMapper();
            mapper.writeValue(response.getOutputStream(), meta);

        }
        else{
             System.out.println("ERR: " + "file not found");
        }

    }

    private void processRequest(HttpServletRequest request, HttpServletResponse response) {
        String path = request.getServletPath();
        switch (path) {
            case "apk-upload":
                // ... call your function1
                break;
            case "apk-download":
                // ... call your function2
                break;
            default:
                break;
        }
        // do something else
    }

}
