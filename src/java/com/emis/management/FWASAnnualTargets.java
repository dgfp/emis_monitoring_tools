package com.emis.management;

import com.emis.entity.HouseholdAndVillageWisePopulation;
import com.emis.utility.Convertor;
import com.emis.utility.Menu;
import com.emis.utility.Utility;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.rhis.db.DBManagerDistrict;
import com.rhis.db.DBManagerMonitoring;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
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
@WebServlet(name = "FWASAnnualTargets", urlPatterns = {"/fwas-annual-targets"})
public class FWASAnnualTargets extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Menu.setMenu("MANAGEMENT", "fwas-annual-targets", request);
        request.getRequestDispatcher("WEB-INF/jsp/management/FWASAnnualTargets.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        try {
            FWASAnnualTargetsModel data = new ObjectMapper().readValue(request.getParameter("data").toString(), FWASAnnualTargetsModel.class);
            System.out.println(data);
            response.setContentType("text/plain;charset=UTF-8");
            String sql = "";
            switch (request.getParameter("action")) {
                case "getData":
                    String where="";
                    if(data.getMethodid()>0)
                        where = " and method_id="+data.getMethodid();
                    sql = "SELECT distinct reporting_unionid, method_id, year_number, \n"
                            + "       target, \n"
                            + "       progress, \n"
                            + "       created_by,\n"
                            + "       name_upazila_eng(zillaid, upazilaid) name_upazila_eng, \n"
                            + "       name_union_eng(zillaid, upazilaid,reporting_unionid ) name_union_eng, zillaid, upazilaid\n"
                            + "  FROM public.notice_unit_target where zillaid=" + data.getZillaid() + " and upazilaid=" + data.getUpazilaid() + " and reporting_unionid=" + data.getUnionid() + " and year_number="+data.getYear()+""+where;
                    JSONArray json = Convertor.convertResultSetIntoJSON(new DBManagerDistrict(data.getZillaid()).select(sql));
                    response.getWriter().write(json.toString());
                    break;

                case "setTarget":
                    sql = "update notice_unit_target set target="+data.getTarget()+" where zillaid=" + data.getZillaid() + " and upazilaid=" + data.getUpazilaid() + " and reporting_unionid=" + data.getUnionid() + " and method_id="+data.getMethodid()+" and year_number=2021";
                    int rowCount = new DBManagerDistrict(data.getZillaid()).update(sql);
                    if (rowCount > 0) {
                        response.getWriter().write("{\"success\":\"success\", \"message\":\"Target added successfully\"}");
                    } else {
                        response.getWriter().write("{\"success\":\"danger\", \"message\":\"Can't add target\"}");
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

class FWASAnnualTargetsModel {

    private int divid;
    private int zillaid;
    private int upazilaid;
    private int unionid;
    private int methodid;
    private int year;
    private int target;

    public FWASAnnualTargetsModel() {
    }

    public FWASAnnualTargetsModel(int divid, int zillaid, int upazilaid, int unionid, int methodid, int year, int target) {
        this.divid = divid;
        this.zillaid = zillaid;
        this.upazilaid = upazilaid;
        this.unionid = unionid;
        this.methodid = methodid;
        this.year = year;
        this.target = target;
    }

    public int getDivid() {
        return divid;
    }

    public void setDivid(int divid) {
        this.divid = divid;
    }

    public int getZillaid() {
        return zillaid;
    }

    public void setZillaid(int zillaid) {
        this.zillaid = zillaid;
    }

    public int getUpazilaid() {
        return upazilaid;
    }

    public void setUpazilaid(int upazilaid) {
        this.upazilaid = upazilaid;
    }

    public int getUnionid() {
        return unionid;
    }

    public void setUnionid(int unionid) {
        this.unionid = unionid;
    }

    public int getMethodid() {
        return methodid;
    }

    public void setMethodid(int methodid) {
        this.methodid = methodid;
    }

    public int getYear() {
        return year;
    }

    public void setYear(int year) {
        this.year = year;
    }

    public int getTarget() {
        return target;
    }

    public void setTarget(int target) {
        this.target = target;
    }

    @Override
    public String toString() {
        return "FWASAnnualTargetsModel{" + "divid=" + divid + ", zillaid=" + zillaid + ", upazilaid=" + upazilaid + ", unionid=" + unionid + ", methodid=" + methodid + ", year=" + year + ", target=" + target + '}';
    }
}
