package com.emis.reports;

import com.emis.utility.Convertor;
import com.rhis.db.DBManagerDistrict;
import java.io.IOException;
import java.sql.ResultSet;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.JSONArray;

/**
 *
 * @author Nil_27
 */
@WebServlet(name = "HA_ReportServlet", urlPatterns = {"/ha_report"})
public class HA_ReportServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setAttribute("submenu", "ha_report");
        request.setAttribute("menu", "VIEW REPORTS");
        request.setAttribute("userLevel", (String) request.getSession(false).getAttribute("userLevel"));
        RequestDispatcher view = request.getRequestDispatcher("WEB-INF/jsp/reports/ha_report.jsp");
        view.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String districtId = request.getParameter("districtId");
        String upazilaId = request.getParameter("upazilaId").length() == 0 ? "%" : request.getParameter("upazilaId");
        String unionId = request.getParameter("unionId").length() == 0 ? "%" : request.getParameter("unionId");
        String month = request.getParameter("month");
        String year = request.getParameter("year");
        String ward = request.getParameter("ward").equals("0") ? "%" : request.getParameter("ward");
        
        String query;
//        if(request.getParameter("ward").equals("0")){
//            query="select * from public.fn_ha_health_service_monthly_progress_rpt("+districtId+",'"+upazilaId+"','"+unionId+"',"+year+","+month+")";
//        }else{
//            query="select * from public.fn_ha_health_service_monthly_progress_rpt ("+districtId+","+upazilaId+","+unionId+","+year+","+month+",'"+ward+"')";
//        }

        if(request.getParameter("ward").equals("0")){
            
            //query = "select * from public.fn_ha_health_service_monthly_progress_rpt_dhis_all_ward ("+districtId+","+upazilaId+","+unionId+","+year+","+month+")";
        
            query = "select \n" +
                        "sum(r_preg_woman_new_w1) as r_preg_woman_new_w1,\n" +
                        "sum(r_preg_woman_old_w1) as r_preg_woman_old_w1,\n" +
                        "sum(r_preg_woman_tot_w1) as r_preg_woman_tot_w1,\n" +
                        "sum(r_preg_service_anc_visit1_w1) as r_preg_service_anc_visit1_w1,\n" +
                        "sum(r_preg_service_anc_visit2_w1) as r_preg_service_anc_visit2_w1,\n" +
                        "sum(r_preg_service_anc_visit3_w1) as r_preg_service_anc_visit3_w1,\n" +
                        "sum(r_preg_service_anc_visit4_w1)  as r_preg_service_anc_visit4_w1,\n" +
                        "sum(r_preg_iron_folic_acid_anc__w1) r_preg_iron_folic_acid_anc__w1,\n" +
                        "sum(r_delivery_home_expert_w1) as r_delivery_home_expert_w1,\n" +
                        "sum(r_delivery_home_unexpert_w1) as r_delivery_home_unexpert_w1,\n" +
                        "sum(r_delivery_facility_w1) as r_delivery_facility_w1,\n" +
                        "sum(r_misoprostol_eaten_w1) as r_misoprostol_eaten_w1,\n" +
                        "sum(r_delivery_patern_normal_w1) as r_delivery_patern_normal_w1,\n" +
                        "sum(r_delivery_patern_operation_w1) as r_delivery_patern_operation_w1,\n" +
                        "sum(r_live_birth_w1) as r_live_birth_w1,\n" +
                        "sum(r_birth_less_weight_w1) as r_birth_less_weight_w1,\n" +
                        "sum(r_death_birth_w1) as r_death_birth_w1,\n" +
                        "sum(r_pnc_visit1_w1) as r_pnc_visit1_w1,\n" +
                        "sum(r_pnc_visit2_w1) as r_pnc_visit2_w1,\n" +
                        "sum(r_pnc_visit3_w1) as r_pnc_visit3_w1,\n" +
                        "sum(r_pnc_visit4_w1) as r_pnc_visit4_w1,\n" +
                        "sum(r_total_death_0_7days_w1) as r_total_death_0_7days_w1,\n" +
                        "sum(r_total_death_8_28days_w1) as r_total_death_8_28days_w1,\n" +
                        "sum(r_total_death_29d_bellow_1year_w1) as r_total_death_29d_bellow_1year_w1,\n" +
                        "sum(r_total_death_1y_bellow_5year_w1) as r_total_death_1y_bellow_5year_w1,\n" +
                        "sum(r_total_death_maternal_w1) as r_total_death_maternal_w1,\n" +
                        "sum(r_total_death_oth_all_w1) as r_total_death_oth_all_w1,\n" +
                        "sum(r_cronic_diarrhea_man_w1) as r_cronic_diarrhea_man_w1,\n" +
                        "sum(r_cronic_diarrhea_woman_w1) as r_cronic_diarrhea_woman_w1,\n" +
                        "sum(r_cronic_jockha_man_w1) as r_cronic_jockha_man_w1,\n" +
                        "sum(r_cronic_jockha_woman_w1) as r_cronic_jockha_woman_w1,\n" +
                        "sum(r_cronic_kustha_man_w1) as r_cronic_kustha_man_w1,\n" +
                        "sum(r_cronic_kustha_woman_w1) as r_cronic_kustha_woman_w1,\n" +
                        "sum(r_cronic_filariasis_man_w1) as r_cronic_filariasis_man_w1,\n" +
                        "sum(r_cronic_filariasis_woman_w1) as r_cronic_filariasis_woman_w1,\n" +
                        "sum(r_cronic_kalajor_man_w1) as r_cronic_kalajor_man_w1,\n" +
                        "sum(r_cronic_kalajor_woman_w1) as r_cronic_kalajor_woman_w1,\n" +
                        "sum(r_cronic_ari_man_w1) as r_cronic_ari_man_w1,\n" +
                        "sum(r_cronic_ari_woman_w1) as r_cronic_ari_woman_w1,\n" +
                        "sum(r_cronic_oth_man_w1) as r_cronic_oth_man_w1,\n" +
                        "sum(r_cronic_oth_woman_w1) as r_cronic_oth_woman_w1,\n" +
                        "sum(r_bcc_plan_education_tot_w1) as r_bcc_plan_education_tot_w1,\n" +
                        "sum(r_bcc_done_education_tot_w1) as r_bcc_done_education_tot_w1,\n" +
                        "sum(r_bcc_participated_man_w1) as r_bcc_participated_man_w1,\n" +
                        "sum(r_bcc_participated_woman_w1) as r_bcc_participated_woman_w1\n" +
                        "from (select * from public.fn_ha_health_service_monthly_progress_rpt_dhis(_param,1)\n" +
                        "UNION ALL\n" +
                        "select * from public.fn_ha_health_service_monthly_progress_rpt_dhis(_param,2)\n" +
                        "UNION ALL\n" +
                        "select * from public.fn_ha_health_service_monthly_progress_rpt_dhis(_param,3)) a;";
                        query = query.replaceAll("\\b_param\\b", districtId+","+upazilaId+","+unionId+","+year+","+month);
       
        }else{
            query = "select * from public.fn_ha_health_service_monthly_progress_rpt_dhis ("+districtId+","+upazilaId+","+unionId+","+year+","+month+","+ward+")";
        }
        
        System.out.println("SQL: "+ query);

            
        
        //String query="select * from public.fn_HA_health_service_monthly_progress_rpt ("+districtId+","+upazilaId+","+unionId+","+year+","+month+",'"+ward+"')";
        try {
             
            DBManagerDistrict db = new DBManagerDistrict(Integer.parseInt(districtId));
            ResultSet result = db.select(query);
            
            JSONArray json = Convertor.convertResultSetIntoJSON_MIS(result);
            response.setContentType("text/plain;charset=UTF-8");
            
            System.out.println(json.toString());
            response.getWriter().write(json.toString());
            
        } catch (Exception ex) {
            ex.getMessage();
        }
    }
}
