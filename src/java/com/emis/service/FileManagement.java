/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.emis.service;

import java.io.File;
import java.sql.Timestamp;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FilenameUtils;

/**
 *
 * @author nar_r
 */
public class FileManagement {

    public int maxMemory = 1024 * 1024 * 1;//1MB
    public int maxRequestSize = 1024 * 1024 * 10;// 10MB

    public String saveFile(FileItem item, String filePath) throws Exception {
        String fieldName = item.getFieldName();
        String fileName = item.getName();
        String ext = FilenameUtils.getExtension(fileName);

        Timestamp timestamp = new Timestamp(System.currentTimeMillis());
        String fileNameModified = String.valueOf(timestamp.getTime()) + "." + ext;
        String contentType = item.getContentType();
        boolean isInMemory = item.isInMemory();
        long sizeInBytes = item.getSize();
        System.out.println(fieldName + " " + fileName + " " + contentType + " " + isInMemory + " " + sizeInBytes);
        // String path = servletContext.getAttribute("javax.servlet.context.tempdir") + "/" + fileName;
        //ADD DIRECT PATH
        String path = filePath + fileNameModified; //E://apache-tomcat-9.0.48-windows-x64/apache-tomcat-9.0.48/webapps/
        File uploadedFile = new File(path);
        item.write(uploadedFile);
        return path;
    }
}
