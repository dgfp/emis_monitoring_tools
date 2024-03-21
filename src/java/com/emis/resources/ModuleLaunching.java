package com.emis.resources;

import com.emis.utility.Convertor;
import com.emis.utility.Menu;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.rhis.db.DBManagerDistrict;
import com.rhis.db.DBManagerMonitoring;
import java.sql.ResultSet;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.json.JSONArray;
import com.emis.entity.ELCO;
import com.emis.entity.ModuleLaunchInformation;
import com.emis.service.FileManagement;
import com.fasterxml.jackson.databind.ObjectMapper;
import java.io.File;
import java.rmi.ServerException;
import java.sql.Timestamp;
import java.util.Iterator;
import java.util.List;
import javax.servlet.ServletContext;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FilenameUtils;
import org.json.JSONObject;

/**
 *
 * @author Helal
 */
@WebServlet(name = "ModuleLaunching", urlPatterns = {"/module-launching-info"})
public class ModuleLaunching extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Menu.setMenu("MISCELLANEOUS", "module-launching-info", request);
        request.getRequestDispatcher("WEB-INF/jsp/resources/ModuleLaunching.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        try {
            if (action.equalsIgnoreCase("getModuleName")) {
                ResourceSqlUtility sql = new ResourceSqlUtility();
                JSONArray json = sql.getModuleList();
                response.setContentType("text/plain;charset=UTF-8");
                response.getWriter().write(json.toString());
            } else if (action.equalsIgnoreCase("getTrainingTypeName")) {
                ResourceSqlUtility sql = new ResourceSqlUtility();
                JSONArray json = sql.getTrainingType();
                response.setContentType("text/plain;charset=UTF-8");
                response.getWriter().write(json.toString());
            } else if (action.equalsIgnoreCase("submitData")) {
                String filePath = getServletContext().getInitParameter("file-upload");
                boolean isMultipart = ServletFileUpload.isMultipartContent(request);
                
//                https://commons.apache.org/proper/commons-fileupload/using.html
                DiskFileItemFactory factory = new DiskFileItemFactory();
                ServletContext servletContext = this.getServletConfig().getServletContext();
                
                System.out.println(isMultipart + " " + servletContext.getAttribute("javax.servlet.context.tempdir"));
                
                File repository = (File) servletContext.getAttribute("javax.servlet.context.tempdir");
                
                int MaxMemorySize = 1024 * 1024 * 1;// 1MB
                // Set factory constraints
                factory.setSizeThreshold(MaxMemorySize);
                factory.setRepository(repository);
                ServletFileUpload upload = new ServletFileUpload(factory);
                long MaxRequestSize = 1024 * 1024 * 10; // 10MB
                upload.setSizeMax(MaxRequestSize);
                List<FileItem> items = upload.parseRequest(request);
                
                // Process the uploaded items
                Iterator<FileItem> iter = items.iterator();

                JSONObject jo = new JSONObject();
                while (iter.hasNext()) {
                    FileItem item = iter.next();

                    if (item.isFormField()) {
//                        processFormField(item);
                        String fieldName = item.getFieldName();
                        String fieldValue = item.getString();
                        jo.put(fieldName, fieldValue);
                    } else if (!item.isFormField()) {
//                        processUploadedFile(item);
//                        String fieldName = item.getFieldName();
//                        String fileName = item.getName();
//                        String ext = FilenameUtils.getExtension(fileName);
//                        Timestamp timestamp = new Timestamp(System.currentTimeMillis());
//                        String fileNameModified = String.valueOf(timestamp.getTime()) + "." + ext;
//                        String contentType = item.getContentType();
//                        boolean isInMemory = item.isInMemory();
//                        long sizeInBytes = item.getSize();
//                        System.out.println(fieldName + " " + fileName + " " + contentType + " " + isInMemory + " " + sizeInBytes);
//                        // String path = servletContext.getAttribute("javax.servlet.context.tempdir") + "/" + fileName;
//                        //ADD DIRECT PATH
//                        String path = filePath + fileNameModified; //E://apache-tomcat-9.0.48-windows-x64/apache-tomcat-9.0.48/webapps/
//                        File uploadedFile = new File(path);
//                        item.write(uploadedFile);
                        FileManagement fm = new FileManagement();
                        String fileNameModified = fm.saveFile(item, filePath);
                        jo.put("document_url",fileNameModified);
                    }
                }
                ModuleLaunchInformation mli = new ObjectMapper().readValue(jo.toString(), ModuleLaunchInformation.class);
                System.out.println(mli.getDivision());
                ResourceSqlUtility sql = new ResourceSqlUtility();
                String rowCount = sql.insertModuleLaunchingInfo(mli);//sql.insertModuleLaunchingInfo(mli);
                response.setContentType("text/plain;charset=UTF-8");
                response.getWriter().write(rowCount);
            } else if (action.equalsIgnoreCase("getData")) {
                ResourceSqlUtility sql = new ResourceSqlUtility();
                JSONArray json = sql.getData();
                response.setContentType("text/plain;charset=UTF-8");
                response.getWriter().write(json.toString());
            } else if (action.equalsIgnoreCase("updateData")) {
                ModuleLaunchInformation mli = new ObjectMapper().readValue(request.getParameter("data"), ModuleLaunchInformation.class);
                ResourceSqlUtility sql = new ResourceSqlUtility();
                String json = sql.updateModuleLaunchingInfo(mli);
                response.setContentType("text/plain;charset=UTF-8");
                response.getWriter().write(json);
            } else if (action.equalsIgnoreCase("deleteData")) {
                ModuleLaunchInformation mli = new ObjectMapper().readValue(request.getParameter("data"), ModuleLaunchInformation.class);
                ResourceSqlUtility sql = new ResourceSqlUtility();
                String json = sql.deleteModuleLaunchingInfo(mli.getId());
                response.setContentType("text/plain;charset=UTF-8");
                response.getWriter().write(json);
            }
        } catch (Exception ex) {
            Logger.getLogger(ModuleLaunching.class.getName()).log(Level.SEVERE, null, ex);
//            response.getWriter().write("[{\"status\": \"error\",\"message\":"+ "\""+ ex.toString() +"\"}]");
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, ex.toString());
        }
    }
}
