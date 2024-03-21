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
public class FileMeta {
    //
    protected static final String FILE_REGEX = "(.*)\\.(.*)"; //filename.replaceAll(REGEX,"$2");
    protected static final byte[] buffer = new byte[1024];
    protected static final String[] units = new String[]{" bytes", "KB", "MB", "GB", "TB", "PB", "EB"};
    //
    protected String id;
    protected String dirname;
    //
    protected String filename; //emisupdate_{provtype}.{extention}   //extention=txt,apk
    protected String filesize;
    protected String filetype;
    //
    protected InputStream input;
    protected OutputStream output;

    //
    public static void main(String[] args) {
        //getClean();
    }

    public FileMeta() {
    }

    public FileMeta(String dirname) {
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

    //
    public void setPrettySize(Long bytes) {
        filesize = FileMeta.getPrettysize(bytes);
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
