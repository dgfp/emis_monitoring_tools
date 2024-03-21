package com.emis.beans;

/**
 * @author Rahen
 */
import com.rhis.db.DBManagerMonitoring;
import java.sql.ResultSet;

public class ApkMeta extends FileMeta {
    //--  /opt/tomcat/webapps/emis_apps_document/emis_update_fwa.txt
    protected static String FILE_PREFIX = "emis_update_";
    protected String provtype;
    protected String typename;
    protected String version;
    protected String systemupdatedt;
    protected String description;
    protected String zillaid;
    protected String upazilaid;
    protected String unionid;

    //
    public static void main(String[] args) {
      //getClean();
    }

    public ApkMeta() {
        super();
    }

    public ApkMeta(String dirname) {
        super(dirname);
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
    
    //update pdb set systemupdatedt='11122000' where concat_ws('-',zillaid,upazilaid,unionid)||'-' like concat_ws('-',69,63,null)||'-%' and provtype=3

//getters and setters...
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

    public String getSystemupdatedt() {
        return systemupdatedt;
    }

    public void setSystemupdatedt(String systemupdatedt) {
        this.systemupdatedt = systemupdatedt;
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

    public void upload() {
        filename = FILE_PREFIX + typename.toLowerCase() + '-' + version + '-' + id + '.' + getOnlyExtension(filename);
        upload(filename, dirname);
    }

    public void download() {
        download(filename, dirname);
    }

}
