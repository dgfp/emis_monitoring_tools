/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.emis.beans;

/**
 *
 * @author Rahen
 */
import java.io.InputStream;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.emis.utility.Convertor;
import com.rhis.db.DBManagerMonitoring;
import java.io.IOException;
import java.sql.ResultSet;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.sql.ResultSet;
import java.util.Arrays;

@JsonIgnoreProperties({"prefix", "input", "output", "units"})
public class ApkMeta_old {

    private static final String FILE_PREFIX = "emisupdate_";
    private static final String FILE_REGEX = "(.*)\\.(.*)"; //filename.replaceAll(REGEX,"$2");
    private static final byte[] buffer = new byte[1024];
    private static final String[] units = new String[]{" bytes", "KB", "MB", "GB", "TB", "PB", "EB"};
    //
    private String id;
    private String dirname;
    //
    private String filename; //emisupdate_{provtype}.{extention}   //extention=txt,apk
    private String filesize;
    private String filetype;
    //
    private String provtype;
    private String typename;
    private String version;
    private String description;
    private String zillaid;
    private String upazilaid;
    private String unionid;

    //
    private InputStream input;
    private OutputStream output;

    //
    public static void main(String[] args) {
       //getClean();
    }

    public ApkMeta_old() {
    }

    public ApkMeta_old(String dirname) {
        this.dirname = dirname;
    }

    // static methods
    public static String getPrettysize(Long bytes) {
        return getPrettysize(bytes, units);
    }

    public static String getPrettysize(Long bytes, String[] units) {
        return (bytes < (1 << 10)) ? bytes.toString() + units[0] : getPrettysize(bytes >> 10, Arrays.copyOfRange(units, 1, units.length));
    }

    public static String getOnlyExtension(String filename) {
        return filename.replaceAll(FILE_REGEX, "$2");
    }

    public static String getOnlyFilename(String filename) {
        return filename.replaceAll(FILE_REGEX, "$1");
    }

    public static void getClean() {
        new DBManagerMonitoring().update("DELETE FROM apk");
    }

    public static ResultSet getList(String id) {
        String sql = "SELECT a.*,t.typename  FROM apk a JOIN providertype t USING (provtype) ";
        sql += (id == null || !id.isEmpty()) ? " WHERE id=" + id + " LIMIT 1" : " ORDER BY a.provtype ASC, a.releasedate DESC;";
        DBManagerMonitoring db = new DBManagerMonitoring();
        ResultSet result = db.select(sql);
        return result;
    }

    public static ResultSet getType(String id) {
        String sql = "SELECT provtype AS id, designame AS text FROM web_userdesignation WHERE has_apk=1 ";
        sql += (id == null || !id.isEmpty()) ? " AND provtype=" + id + " LIMIT 1" : " ORDER BY 1";
        DBManagerMonitoring db = new DBManagerMonitoring();
        ResultSet result = db.select(sql);
        return result;
    }

    //
    public void setPrettySize(Long bytes) {
        filesize = ApkMeta_old.getPrettysize(bytes);
    }

    public void upload() {
        filename = FILE_PREFIX + typename.toLowerCase() + '-' + version + '-' + id + '.' + getOnlyExtension(filename);
        upload(filename, dirname);
    }

    public void upload(String fileName, String dirName) {
        //String filePath = dirName + File.separator + fileName;
        File file = new File(dirName, fileName);
        try (OutputStream out = new FileOutputStream(file)) {
            int length;
            while ((length = input.read(buffer)) != -1) {
                out.write(buffer, 0, length);
            }
            out.close();
        } catch (Exception e) {
            System.out.println("ERROR/upload: " + e.getMessage());
        }
    }

    public void download() {
        download(filename,dirname);
    }

    public void download(String fileName, String dirName) {
        //String filePath = dirName + File.separator + fileName;
        // for example application/pdf, text/plain, text/html, image/jpg
        File file = new File(dirName, fileName);
        try (FileInputStream in = new FileInputStream(file)) {
            int length;
            while ((length = in.read(buffer)) > 0) {
                output.write(buffer, 0, length);
            }
            in.close();
            output.flush();
        } catch (Exception e) {
            System.out.println("ERROR/download: " + e.getMessage());
        }

    }

    public void delete() {
        File file = new File(this.dirname, this.filename);
        if (file.exists()) {
            file.delete();
        }

    }

    public void renameTo(String filename) {
        File file = new File(this.dirname, this.filename);
        if (file.exists()) {
            File newFile = new File(this.dirname, filename);
            file.renameTo(newFile);
        }
    }

//getters and setters...
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getDirname() {
        return dirname;
    }

    public void setDirname(String dirname) {
        this.dirname = dirname;
    }

    public String getFilename() {
        return filename;
    }

    public void setFilename(String filename) {
        this.filename = filename;
    }

    public String getFilesize() {
        return filesize;
    }

    public void setFilesize(String filesize) {
        this.filesize = filesize;
    }

    public String getFiletype() {
        return filetype;
    }

    public void setFiletype(String filetype) {
        this.filetype = filetype;
    }

    public String getProvtype() {
        return provtype;
    }

    public void setProvtype(String provtype) {
        this.provtype = provtype;
    }

    public String getTypename() {
        return typename;
    }

    public void setTypename(String typename) {
        this.typename = typename;
    }

    public String getVersion() {
        return version;
    }

    public void setVersion(String version) {
        this.version = version;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getZillaid() {
        return zillaid;
    }

    public void setZillaid(String zillaid) {
        this.zillaid = zillaid;
    }

    public String getUpazilaid() {
        return upazilaid;
    }

    public void setUpazilaid(String upazilaid) {
        this.upazilaid = upazilaid;
    }

    public String getUnionid() {
        return unionid;
    }

    public void setUnionid(String unionid) {
        this.unionid = unionid;
    }

    public InputStream getInput() {
        return input;
    }

    public void setInput(InputStream input) {
        this.input = input;
    }

    public OutputStream getOutput() {
        return output;
    }

    public void setOutput(OutputStream output) {
        this.output = output;
    }
}
