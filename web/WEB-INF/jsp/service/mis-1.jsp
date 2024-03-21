<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jspf/header.jspf" %>
<script src="resources/js/area_dropdown_control_mis.js"></script>
<link href="resources/css/style.css" rel="stylesheet" type="text/css"/>

<style>


    .rotate {
        filter:  progid:DXImageTransform.Microsoft.BasicImage(rotation=0.083);  /* IE6,IE7 */
        -ms-filter: "progid:DXImageTransform.Microsoft.BasicImage(rotation=0.083)"; /* IE8 */
        -moz-transform: rotate(-90.0deg);  /* FF3.5+ */
        -ms-transform: rotate(-90.0deg);  /* IE9+ */
        -o-transform: rotate(-90.0deg);  /* Opera 10.5 */
        -webkit-transform: rotate(-90.0deg);  /* Safari 3.1+, Chrome */
        transform: rotate(-90.0deg);  /* Standard */
    }
    
        
#slogan{
        border: 1px solid #000000;
        width: 150px;
        text-align: center;
        padding: 2px;
    }


</style>

<script>
    $(document).ready(function () {

        $('#showdataButton').click(function () {


            $.ajax({
                url: "mis-1",
                data: {
                    districtId: $("select#district").val(),
                    upazilaId: $("select#upazila").val(),
                    unionId: $("select#union").val(),
                    //wardNo: $("#wardNo").val(),
                    //fwaUnit: $("#fwaUnit").val(),
                    provCode: $("select#provCode").val(),
                    //villageId: $("select#village").val(),
                    //startDate: $("#startDate").val(),
                    //endDate: $("#endDate").val()
                    month: $("select#month").val(),
                    year: $("#year").val()
                },
                type: 'POST',
                success: function (result) {
                    //alert("success");

                    var json = JSON.parse(result);
                    if (json.length > 0) {

                        //json[0].r_unit_all_total_tot
                        //r_priv_m_shown_capable_elco_tot
                        //Number((1.005).toFixed(2));
                        
                        var car = Number(((json[0].r_unit_all_total_tot / json[0].r_unit_capable_elco_tot) * 100).toFixed(2));
                        
                        $("#unionValue").html($("#union option:selected").text());
                        $("#upazilaValue").html($("#upazila option:selected").text());
                        $("#districtValue").html($("#district option:selected").text());
                        
                        //MIS Form ka
                        $("#old_pill_gov").html(json[0].r_old_pill_gov);
                        $("#old_pill_purchage").html(json[0].r_old_pill_purchage);
                        $("#old_pill_total").html(json[0].r_old_pill_total);

                        $("#old_condom_gov").html(json[0].r_old_condom_gov);
                        $("#old_condom_purchage").html(json[0].r_old_condom_purchage);
                        $("#old_condom_total").html(json[0].r_old_condom_total);

                        $("#old_inject_gov").html(json[0].r_old_inject_gov);
                        $("#old_inject_purchage").html(json[0].r_old_inject_purchage);
                        $("#old_inject_total").html(json[0].r_old_inject_total);

                        $("#old_iud_gov").html(json[0].r_old_iud_total);
                        $("#old_iud_purchage").html(json[0].r_old_iud_purchage);
                        $("#old_iud_total").html(json[0].r_old_iud_total);

                        $("#old_implant_gov").html(json[0].r_old_implant_gov);
                        $("#old_implant_purchage").html(json[0].r_old_implant_purchage);
                        $("#old_implant_total").html(json[0].r_old_implant_total);

                        $("#old_permanent_man").html(json[0].r_old_permanent_man);
                        $("#old_ipermanent_woman").html(json[0].r_old_permanent_woman);
                        $("#old_all_total").html(json[0].r_old_all_total);

                        $("#new_pill_gov").html(json[0].r_new_pill_gov);
                        $("#new_pill_purchage").html(json[0].r_new_pill_purchage);
                        $("#new_pill_total").html(json[0].r_new_pill_total);

                        $("#new_condom_gov").html(json[0].r_new_condom_gov);
                        $("#new_condom_purchage").html(json[0].r_new_condom_purchage);
                        $("#new_condom_total").html(json[0].r_new_condom_total);

                        $("#new_inject_gov").html(json[0].r_new_inject_gov);
                        $("#new_inject_purchage").html(json[0].r_new_inject_purchage);
                        $("#new_inject_total").html(json[0].r_new_inject_total);

                        $("#new_iud_gov").html(json[0].r_new_iud_gov);
                        $("#new_iud_purchage").html(json[0].r_new_iud_purchage);
                        $("#new_iud_total").html(json[0].r_new_iud_total);

                        $("#new_implant_gov").html(json[0].r_new_implant_gov);
                        $("#new_implant_purchage").html(json[0].r_new_implant_purchage);
                        $("#new_implant_total").html(json[0].r_new_implant_total);

                        $("#new_permanent_man").html(json[0].r_new_permanent_man);
                        $("#new_ipermanent_woman").html(json[0].r_new_permanent_woman);
                        $("#new_all_total").html(json[0].r_new_all_total);

                        $("#curr_month_pill_gov").html(json[0].r_curr_month_pill_gov);
                        $("#curr_month_pill_purchage").html(json[0].r_curr_month_pill_purchage);
                        $("#curr_month_pill_total").html(json[0].r_curr_month_pill_total);

                        $("#curr_month_condom_gov").html(json[0].r_curr_month_condom_gov);
                        $("#curr_month_condom_purchage").html(json[0].r_curr_month_condom_purchage);
                        $("#curr_month_condom_total").html(json[0].r_curr_month_condom_total);

                        $("#curr_month_inject_gov").html(json[0].r_curr_month_inject_gov);
                        $("#curr_month_inject_purchage").html(json[0].r_curr_month_inject_purchage);
                        $("#curr_month_inject_total").html(json[0].r_curr_month_inject_total);

                        $("#curr_month_iud_gov").html(json[0].r_curr_month_iud_gov);
                        $("#curr_month_iud_purchage").html(json[0].r_curr_month_iud_purchage);
                        $("#curr_month_iud_total").html(json[0].r_curr_month_iud_total);

                        $("#curr_month_implant_gov").html(json[0].r_curr_month_implant_gov);
                        $("#curr_month_implant_purchage").html(json[0].r_curr_month_implant_purchage);
                        $("#curr_month_implant_total").html(json[0].r_curr_month_implant_total);

                        $("#curr_month_permanent_man").html(json[0].r_curr_month_permanent_man);
                        $("#curr_month_ipermanent_woman").html(json[0].r_curr_month_permanent_woman);
                        $("#curr_month_all_total").html(json[0].r_curr_month_all_total);

                        $("#priv_month_pill_gov").html(json[0].r_priv_month_pill_gov);
                        $("#priv_month_pill_purchage").html(json[0].r_priv_month_pill_purchage);
                        $("#priv_month_pill_total").html(json[0].r_priv_month_pill_total);

                        $("#priv_month_condom_gov").html(json[0].r_priv_month_condom_gov);
                        $("#priv_month_condom_purchage").html(json[0].r_priv_month_condom_purchage);
                        $("#priv_month_condom_total").html(json[0].r_priv_month_condom_total);

                        $("#priv_month_inject_gov").html(json[0].r_priv_month_inject_gov);
                        $("#priv_month_inject_purchage").html(json[0].r_priv_month_inject_purchage);
                        $("#priv_month_inject_total").html(json[0].r_priv_month_inject_total);

                        $("#priv_month_iud_gov").html(json[0].r_priv_month_iud_gov);
                        $("#priv_month_iud_purchage").html(json[0].r_priv_month_iud_purchage);
                        $("#priv_month_iud_total").html(json[0].r_priv_month_iud_total);

                        $("#priv_month_implant_gov").html(json[0].r_priv_month_implant_gov);
                        $("#priv_month_implant_purchage").html(json[0].r_priv_month_implant_purchage);
                        $("#priv_month_implant_total").html(json[0].r_priv_month_implant_total);

                        $("#priv_month_permanent_man").html(json[0].r_priv_month_permanent_man);
                        $("#priv_month_permanent_woman").html(json[0].r_priv_month_permanent_woman);
                        $("#priv_month_all_total").html(json[0].r_priv_month_all_total);

                        $("#unit_pill_gov_tot").html(json[0].r_unit_pill_gov_tot);
                        $("#unit_pill_purchage_tot").html(json[0].r_unit_pill_purchage_tot);
                        $("#unit_pill_total_tot").html(json[0].r_unit_pill_total_tot);

                        $("#unit_condom_gov_tot").html(json[0].r_unit_condom_gov_tot);
                        $("#unit_condom_purchage_tot").html(json[0].r_unit_condom_purchage_tot);
                        $("#unit_condom_total_tot").html(json[0].r_unit_condom_total_tot);

                        $("#unit_inject_gov_tot").html(json[0].r_unit_inject_gov_tot);
                        $("#unit_inject_purchage_tot").html(json[0].r_unit_inject_purchage_tot);
                        $("#unit_inject_total_tot").html(json[0].r_unit_inject_total_tot);

                        $("#unit_iud_gov_tot").html(json[0].r_unit_iud_gov_tot);
                        $("#unit_iud_purchage_tot").html(json[0].r_unit_iud_purchage_tot);
                        $("#unit_iud_total_tot").html(json[0].r_unit_iud_total_tot);

                        $("#unit_implant_gov_tot").html(json[0].r_unit_implant_gov_tot);
                        $("#unit_implant_purchage_tot").html(json[0].r_unit_implant_purchage_tot);
                        $("#unit_implant_total_tot").html(json[0].r_unit_implant_total_tot);

                        $("#unit_permanent_man_tot").html(json[0].r_unit_permanent_man_tot);
                        $("#unit_permanent_woman_tot").html(json[0].r_unit_permanent_woman_tot);
                        $("#unit_all_total_tot").html(json[0].r_unit_all_total_tot);

                        $("#curr_m_left_pill_no_method").html(json[0].r_curr_m_left_pill_no_method);
                        $("#curr_m_left_condom_no_method").html(json[0].r_curr_m_left_condom_no_method);
                        $("#curr_m_left_inj_no_method").html(json[0].r_curr_m_left_inj_no_method);

                        $("#curr_m_left_iud_no_method").html(json[0].r_curr_m_left_iud_no_method);
                        $("#curr_m_left_implant_no_method").html(json[0].r_curr_m_left_implant_no_method);

                        $("#curr_m_left_per_man_no_method").html(json[0].r_curr_m_left_per_man_no_method);
                        $("#curr_m_left_per_woman_no_method").html(json[0].r_curr_m_left_per_woman_no_method);
                        $("#curr_m_left_no_method_all_tot").html(json[0].r_curr_m_left_no_method_all_tot);

                        $("#curr_m_left_pill_oth_method").html(json[0].r_curr_m_left_pill_oth_method);

                        $("#curr_m_left_condom_oth_method").html(json[0].r_curr_m_left_condom_oth_method);

                        $("#curr_m_left_inj_oth_method").html(json[0].r_curr_m_left_inj_oth_method);

                        $("#curr_m_left_iud_oth_method").html(json[0].r_curr_m_left_iud_oth_method);

                        $("#curr_m_left_implant_oth_method").html(json[0].r_curr_m_left_implant_oth_method);

                        $("#curr_m_left_per_man_oth_method").html(json[0].r_curr_m_left_per_man_oth_method);

                        $("#curr_m_left_per_woman_oth_mthd").html(json[0].r_curr_m_left_per_woman_oth_mthd);

                        $("#curr_m_left_oth_method_all_tot").html(json[0].r_curr_m_left_oth_method_all_tot);

                        $("#sent_method_pill").html(json[0].r_sent_method_pill);

                        $("#sent_method_condom").html(json[0].r_sent_method_condom);

                        $("#sent_method_inj").html(json[0].r_sent_method_inj);

                        $("#sent_method_iud").html(json[0].r_sent_method_iud);
                        $("#sent_method_implant").html(json[0].r_sent_method_implant);

                        $("#sent_method_all_tot").html(json[0].r_sent_method_all_tot);

                        $("#sent_side_effect_inj").html(json[0].r_sent_side_effect_inj);

                        $("#sent_side_effect_iud").html(json[0].r_sent_side_effect_iud);

                        $("#sent_side_effect_implant").html(json[0].r_sent_side_effect_implant);

                        $("#sent_side_effect_per_man").html(json[0].r_sent_side_effect_per_man);

                        $("#sent_side_effect_per_woman").html(json[0].r_sent_side_effect_per_woman);

                        $("#sent_side_effect_all_tot").html(json[0].r_sent_side_effect_all_tot);



                        $("#unit_capable_elco_tot").html(json[0].r_unit_capable_elco_tot);
                        $("#curr_m_v_new_elco_tot").html(json[0].r_curr_m_v_new_elco_tot);
                        $("#curr_m_shown_capable_elco_tot").html(json[0].r_curr_m_shown_capable_elco_tot);
                        $("#priv_m_shown_capable_elco_tot").html(json[0].r_priv_m_shown_capable_elco_tot);


                        $("#r_car").html(car + "%");



                        $("#curr_month_preg_old_fwa").html(json[0].r_curr_month_preg_old_fwa);
                        $("#curr_month_preg_new_fwa").html(json[0].r_curr_month_preg_new_fwa);
                        $("#curr_month_preg_tot_fwa").html(json[0].r_curr_month_preg_tot_fwa);

                        $("#prir_month_tot_preg_fwa").html(json[0].r_prir_month_tot_preg_fwa);
                        $("#unit_tot_preg_fwa").html(json[0].r_unit_tot_preg_fwa);

                        $("#preg_anc_service_visit1_fwa").html(json[0].r_preg_anc_service_visit1_fwa);
                        $("#preg_anc_service_visit1_csba").html(json[0].r_preg_anc_service_visit1_csba);

                        $("#preg_anc_service_visit2_fwa").html(json[0].r_preg_anc_service_visit2_fwa);
                        $("#preg_anc_service_visit2_csba").html(json[0].r_preg_anc_service_visit2_csba);

                        $("#preg_anc_service_visit3_fwa").html(json[0].r_preg_anc_service_visit3_fwa);
                        $("#preg_anc_service_visit3_csba").html(json[0].r_preg_anc_service_visit3_csba);

                        $("#preg_anc_service_visit4_fwa").html(json[0].r_preg_anc_service_visit4_fwa);
                        $("#preg_anc_service_visit4_csba").html(json[0].r_preg_anc_service_visit4_csba);


                        $("#delivary_service_home_trained_fwa").html(json[0].r_delivary_service_home_trained_fwa);
                        $("#delivary_service_home_untrained_fwa").html(json[0].r_delivary_service_home_untrained_fwa);

                        $("#delivary_service_hospital_normal_fwa").html(json[0].r_delivary_service_hospital_normal_fwa);
                        $("#delivary_service_hospital_operation_fwa").html(json[0].r_delivary_service_hospital_operation_fwa);

                        $("#delivary_service_delivery_done_csba").html(json[0].r_delivary_service_delivery_done_csba);
                        $("#delivary_service_3rd_amts1_csba").html(json[0].r_delivary_service_3rd_amts1_csba);
                        $("#delivary_service_misoprostol_taken_csba").html(json[0].r_delivary_service_misoprostol_taken_csba);


                        $("#pnc_mother_visit1_fwa").html(json[0].r_pnc_mother_visit1_fwa);
                        $("#pnc_mother_visit1_csba").html(json[0].r_pnc_mother_visit1_csba);

                        $("#pnc_mother_visit2_fwa").html(json[0].r_pnc_mother_visit2_fwa);
                        $("#pnc_mother_visit2_csba").html(json[0].r_pnc_mother_visit2_csba);

                        $("#pnc_mother_visit3_fwa").html(json[0].r_pnc_mother_visit3_fwa);
                        $("#pnc_mother_visit3_csba").html(json[0].r_pnc_mother_visit3_csba);

                        $("#pnc_mother_visit4_fwa").html(json[0].r_pnc_mother_visit4_fwa);
                        $("#pnc_mother_visit4_csba").html(json[0].r_pnc_mother_visit4_csba);

                        $("#pnc_mother_family_planning_csba").html(json[0].r_pnc_mother_family_planning_csba);


                        $("#pnc_child_visit1_fwa").html(json[0].r_pnc_mother_visit1_fwa);
                        $("#pnc_child_visit1_csba").html(json[0].r_pnc_mother_visit1_csba);

                        $("#pnc_child_visit2_fwa").html(json[0].r_pnc_mother_visit2_fwa);
                        $("#pnc_child_visit2_csba").html(json[0].r_pnc_mother_visit2_csba);

                        $("#pnc_child_visit3_fwa").html(json[0].r_pnc_mother_visit3_fwa);
                        $("#pnc_child_visit3_csba").html(json[0].r_pnc_mother_visit3_csba);

                        $("#pnc_child_visit4_fwa").html(json[0].r_pnc_mother_visit4_fwa);
                        $("#pnc_child_visit4_csba").html(json[0].r_pnc_mother_visit4_csba);

                        $("#ref_risky_preg_cnt_fwa").html(json[0].v_ref_risky_preg_cnt_fwa);


                        $("#ref_preg_delivery_pnc_diff_refer_csba").html(json[0].v_ref_preg_delivery_pnc_diff_refer_csba);
                        $("#ref_eclampsia_mgso4_inj_refer_csba").html(json[0].v_ref_eclampsia_mgso4_inj_refer_csba);
                        $("#ref_newborn_difficulty_csba").html(json[0].v_ref_newborn_difficulty_csba);

                        $("#tt_women_1st_fwa").html(json[0].r_tt_women_1st_fwa);
                        $("#tt_women_2nd_fwa").html(json[0].r_tt_women_2nd_fwa);
                        $("#tt_women_3rd_fwa").html(json[0].r_tt_women_3rd_fwa);
                        $("#tt_women_4th_fwa").html(json[0].r_tt_women_4th_fwa);
                        $("#tt_women_5th_fwa").html(json[0].r_tt_women_5th_fwa);


                        $("#ecp_taken").html(json[0].r_ecp_taken);
                        $("#misoprostol_taken").html(json[0].r_misoprostol_taken);

                        $("#childless_couple_adviced_fwa").html(json[0].v_childless_couple_adviced_fwa);
                        $("#childless_couple_refered_fwa").html(json[0].v_childless_couple_refered_fwa);

                        $("#teenager_counsiling_referred").html(json[0].r_teenager_counsiling_referred);
                        $("#teenager_counsiling_child_marriage_child_preg_disadvantage").html(json[0].r_teenager_counsiling_child_marriage_child_preg_disadvantage);

                        $("#teenager_counsiling_healthy_balanced_diet").html(json[0].r_teenager_counsiling_healthy_balanced_diet);
                        $("#teenager_counsiling_sexual_disease").html(json[0].r_teenager_counsiling_sexual_disease);

                        $("#satelite_clinic_presence").html(json[0].r_satelite_clinic_presence);
                        $("#epi_session_presence").html(json[0].r_epi_session_presence);
                        $("#community_clinic_presence").html(json[0].r_community_clinic_presence);


                        $("#newborn_1min_washed_fwa").html(json[0].r_newborn_1min_washed_fwa);
                        $("#newborn_1min_washed_csba").html(json[0].r_newborn_1min_washed_csba);

                        $("#newborn_71_chlorohexidin_used_fwa").html(json[0].r_newborn_71_chlorohexidin_used_fwa);
                        $("#newborn_71_chlorohexidin_used_csba").html(json[0].r_newborn_71_chlorohexidin_used_csba);

                        $("#newborn_1hr_bfeeded_csba").html(json[0].r_newborn_1hr_bfeeded_csba);
                        $("#newborn_1hr_bfeeded_fwa").html(json[0].r_newborn_1hr_bfeeded_fwa);

                        $("#newborn_diff_breathing_resassite_csba").html(json[0].r_newborn_diff_breathing_resassite_csba);


                        $("#vaccinated_child_bcg_fwa").html(json[0].r_vaccinated_child_bcg_fwa);

                        $("#vaccinated_0t01yrs_child_pcv_pentavalent_1_fwa").html(json[0].r_vaccinated_0t01yrs_child_pcv_pentavalent_1_fwa);
                        $("#vaccinated_0t01yrs_child_pcv_pentavalent_2_fwa").html(json[0].r_vaccinated_0t01yrs_child_pcv_pentavalent_2_fwa);
                        $("#vaccinated_0t01yrs_child_pcv_pentavalent_3_fwa").html(json[0].r_vaccinated_0t01yrs_child_pcv_pentavalent_3_fwa);
                        $("#vaccinated_0t01yrs_child_pcv_pentavalent_4_fwa").html(json[0].r_vaccinated_0t01yrs_child_pcv_pentavalent_4_fwa);

                        $("#vaccinated_0t01yrs_child_opv3_fwa").html(json[0].r_vaccinated_0t01yrs_child_opv3_fwa);
                        $("#vaccinated_child_ham_fwa").html(json[0].r_vaccinated_child_ham_fwa);

                        $("#referred_child_dangerous_disease_fwa").html(json[0].r_referred_child_dangerous_disease_fwa);
                        $("#referred_child_neumonia_fwa").html(json[0].r_referred_child_neumonia_fwa);
                        $("#referred_child_diahoea_fwa").html(json[0].r_referred_child_diahoea_fwa);



                        $("#tot_live_birth_fwa").html(json[0].r_tot_live_birth_fwa);
                        $("#tot_live_birth_csba").html(json[0].r_tot_live_birth_csba);


                        $("#less_weight_birth_fwa").html(json[0].r_less_weight_birth_fwa);
                        $("#less_weight_birth_csba").html(json[0].r_less_weight_birth_csba);

                        $("#immature_birth_fwa").html(json[0].r_immature_birth_fwa);
                        $("#immature_birth_csba").html(json[0].r_immature_birth_csba);

                        $("#death_birth_fwa").html(json[0].r_death_birth_fwa);
                        $("#death_birth_csba").html(json[0].r_death_birth_csba);

                        $("#death_number_less_1yr_0to7days_fwa").html(json[0].r_death_number_less_1yr_0to7days_fwa);
                        $("#death_number_less_1yr_0to7days_csba").html(json[0].r_death_number_less_1yr_0to7days_csba);

                        $("#death_number_less_1yr_8to28days_fwa").html(json[0].r_death_number_less_1yr_8to28days_fwa);
                        $("#death_number_less_1yr_8to28days_csba").html(json[0].r_death_number_less_1yr_8to28days_csba);

                        $("#death_number_less_1yr_29dystoless1yr_fwa").html(json[0].r_death_number_less_1yr_29dystoless1yr_fwa);

                        $("#death_number_less_1yr_tot_fwa").html(json[0].r_death_number_less_1yr_tot_fwa);

                        $("#death_number_1yrto5yr_fwa").html(json[0].r_death_number_1yrto5yr_fwa);

                        $("#death_number_maternal_death_fwa").html(json[0].r_death_number_maternal_death_fwa);
                        $("#death_number_maternal_death_csba").html(json[0].r_death_number_maternal_death_csba);

                        $("#death_number_other_death_fwa").html(json[0].r_death_number_other_death_fwa);

                        $("#death_number_all_death_fwa").html(json[0].r_death_number_all_death_fwa);

                        $("#iron_folicacid_extrafood_counsiling_preg_woman").html(json[0].r_iron_folicacid_extrafood_counsiling_preg_woman);
                        $("#iron_folicacid_extrafood_counsiling_child_0to23months").html(json[0].r_iron_folicacid_extrafood_counsiling_child_0to23months);

                        $("#bfeeding_complementary_food_counsiling_preg_woman").html(json[0].r_bfeeding_complementary_food_counsiling_preg_woman);
                        $("#bfeeding_complementary_food_counsiling_child_0to23months").html(json[0].r_bfeeding_complementary_food_counsiling_child_0to23months);


                        $("#birth_1hr_bfeed_0to6mon").html(json[0].r_birth_1hr_bfeed_0to6mon);

                        $("#birth_only_bfeed_0to6mon").html(json[0].r_birth_only_bfeed_0to6mon);


                        $("#mnp_given_6to23mon").html(json[0].r_mnp_given_6to23mon);
                        $("#mnp_given_24toless60mon").html(json[0].r_mnp_given_24toless60mon);

                        $("#sam_child_0to6mon").html(json[0].r_sam_child_0to6mon);
                        $("#sam_child_6to23mon").html(json[0].r_sam_child_6to23mon);
                        $("#sam_child_24toless60mon").html(json[0].r_sam_child_24toless60mon);

                        $("#mam_child_0to6mon").html(json[0].r_mam_child_0to6mon);
                        $("#mam_child_6to23mon").html(json[0].r_mam_child_6to23mon);
                        $("#mam_child_24toless60mon").html(json[0].r_mam_child_24to60mon);

                        $("#yearValue").append($("#year").val());
                        $("#monthValue").append($("#month  option:selected").text());
                    }
                    else {
                        alert("No data found");
                    }
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    //btn.button('reset');
                    alert("Request can't be processed");
                }
            });
        });


    });


</script>

<div id="page-wrapper">
    <div class="row">
        <div class="col-lg-12">
            <h3><b><center>MIS Form 1</center></b> </h3>
        </div>
    </div>
    <div class="container-fluid">
        <div class="well well-sm">

            <div class="row">
                <div class="col-md-1">
                    <label for="month">Month</label>
                </div>
                <div class="col-md-2">
                    <select class="form-control input-sm" name="month" id="month">
                        <option value="1">January</option>
                        <option value="2">February</option>
                        <option value="3">March</option>
                        <option value="4">April</option>
                        <option value="5">May</option>
                        <option value="6">June</option>
                        <option value="7">July</option>
                        <option value="8">August</option>
                        <option value="9">September</option>
                        <option value="10">October</option>
                        <option value="11">November</option>
                        <option value="12">December</option>
                    </select>
                </div>

                <div class="col-md-1">
                    <label for="year">Year</label>
                </div>

                <div class="col-md-2">
                    <select class="form-control input-sm" name="year" id="year"> </select>
                </div>


            </div>
            <br/>

            <div class="row">

                <div class="col-md-1">
                    <label for="district">District</label>
                </div>
                <div class="col-md-2">
                    <select class="form-control input-sm" name="district" id="district"> </select>
                </div>

                <div class="col-md-1">
                    <label for="upazila">Upazila</label>
                </div>

                <div class="col-md-2">
                    <select class="form-control input-sm" name="upazila" id="upazila">
                        <option value="">All</option>
                    </select>
                </div>

                <div class="col-md-1">
                    <label for="union">Union</label>
                </div>

                <div class="col-md-2">
                    <select class="form-control input-sm" name="union" id="union">
                        <option value="">All</option>
                    </select>
                </div>




            </div>

            <br/>
            <div class="row">

                <div class="col-md-1">
                    <label for="provCode">Provider</label>
                </div>


                <div class="col-md-3">
                    <select class="form-control input-sm" name="provCode" id="provCode">
                    </select>
                </div>

            </div>

            <br/>

            <div class="row">
                <div class="col-md-2 col-md-offset-1">
                    <!--            <div class="col-md-2 col-md-offset-1">-->
                    <button type="button" id="showdataButton" data-loading-text=" <i class='fa fa-spinner fa-pulse'></i> Loading" class="btn btn-sm btn-success btn-block" autocomplete="off">
                        Show data
                    </button>
                </div>
            </div>

            <br/>

        </div> 
        
        
        
        
        
        
        
        
        
        
        


        <div class="col-ld-12">
            <table style="table-layout: fixed; width: 100%;border:0px solid white!important;">
                <tr>
                    <th><div id='slogan'>ছেলে হোক, মেয়ে হোক,<br>দু’টি সন্তানই যথেষ্ট</div></th>
                    <th style="text-align:center">গনপ্রজাতন্ত্রী বাংলাদেশ সরকার<br>স্বাস্থ্য ও পরিবার কল্যান মন্ত্রনালয়<br>পরিবার পরিকল্পনা অধিদপ্তর</th>
                    <th style="text-align:right">এম আই এস ফরম - ১</th>
                </tr>
                <tr>
                    <td></td>
                    <td style="text-align:center">পরিবার পরিকল্পনা, মা ও শিশু স্বাস্থ্য কার্যক্রমের মাসিক অগ্রগতির প্রতিবেদন<br>(পরিবার কল্যান সহকারী কর্তৃক পূরণীয়)</td>
                    <td> </td>
                </tr>
            </table>

            <!--     <p>
                     <strong id="unitValue">ইউনিট নম্বর: </strong>&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                     <strong id="wardValue">ওয়ার্ড নম্বর: </strong> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                     <strong id="unionValue">ইউনিয়ন: </strong> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                     <strong id="upazilaValue">উপজেলা/থানা: </strong>&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                     <strong id="zilaValue">জেলা: </strong> 
                 </p>
            -->

            <div class="container-fluid">
                <br>
                <div class="row">

                    <div class="col-md-1">
                        ইউনিট:
                    </div>
                    <div class="col-md-2" id="unitValue">

                    </div>
                    <div class="col-md-1">
                        ওয়ার্ড:
                    </div>
                    <div class="col-md-2" id="wardValue">

                    </div>
                    <div class="col-md-1">
                        ইউনিয়ন:
                    </div>
                    <div class="col-md-2" id="unionValue">

                    </div>

                </div>
                <br>
                <div class="row">
                    <div class="col-md-1">
                        উপজেলা:
                    </div>
                    <div class="col-md-2" id="upazilaValue">

                    </div>
                    <div class="col-md-1">
                        জেলা:
                    </div>
                    <div class="col-md-2" id="districtValue">

                    </div>
                </div>

            </div>
            <br>

            <p> <strong> ক) পরিবার পরিকল্পনা পদ্ধতিঃ </strong> </p>

            <table class="mis_table" style="width: 50%">
                <colgroup>
                    <col style="width: 60px !important; text-align: left;">
                    <col style="width: 60px !important;">
                    <col style="width: 60px !important;">
                    <col style="width: 60px !important;">
                    <col style="width: 50px !important;">
                    <col style="width: 60px !important;">
                    <col style="width: 60px !important;">
                    <col style="width: 50px !important;">
                    <col style="width: 60px !important;">
                    <col style="width: 60px !important;">
                    <col style="width: 60px !important;">
                    <col style="width: 60px !important;">
                    <col style="width: 60px !important;">
                    <col style="width: 50px !important;">
                    <col style="width: 50px !important;">
                    <col style="width: 50px !important;">
                    <col style="width: 50px !important;">
                    <col style="width: 60px !important;">
                    <col style="width: 60px !important;">
                    <col style="width: 60px !important;">
                </colgroup>
                <tr>
                    <th colspan="2" rowspan="3"></th>
                    <th colspan="18">পদ্ধতি গ্রহনকারী</th>
                </tr>
                <tr style="text-align">
                    <td colspan="3">খাবার বড়ি</td>
                    <td colspan="3">কনডম</td>
                    <td colspan="3">ইনজেকটেবল</td>
                    <td colspan="3">আইইউডি</td>
                    <td colspan="3">ইমপ্ল্যান্ট</td>
                    <td colspan="2">স্থায়ী পদ্ধতি</td>
                    <td rowspan="2">সর্বমোট</td>
                </tr>
                <tr>
                    <td>সরকারী</td>
                    <td>ক্রয়সূত্র</td>
                    <td>মোট</td>
                    <td>সরকারী</td>
                    <td>ক্রয়সূত্র</td>
                    <td>মোট </td>
                    <td>সরকারী </td>
                    <td>ক্রয়সূত্র</td>
                    <td>মোট </td>
                    <td>সরকারী </td>
                    <td>ক্রয়সূত্র </td>
                    <td>মোট </td>
                    <td>সরকারী </td>
                    <td>ক্রয়সূত্র </td>
                    <td>মোট </td>
                    <td>পুরুষ </td>
                    <td>মহিলা</td>
                </tr>
                <tr>
                    <td colspan="2" style="text-align:left;">পুরাতন </td>
                    <td id="old_pill_gov"></td>
                    <td id="old_pill_purchage"></td>
                    <td id="old_pill_total"></td>
                    <td id="old_condom_gov"></td>
                    <td id="old_condom_purchage"></td>
                    <td id="old_condom_total"></td>
                    <td id="old_inject_gov"></td>
                    <td id="old_inject_purchage"></td>
                    <td id="old_inject_total"></td>
                    <td id="old_iud_gov"></td>
                    <td id="old_iud_purchage"></td>
                    <td id="old_iud_total"></td>
                    <td id="old_implant_gov"></td>
                    <td id="old_implant_purchage"></td>
                    <td id="old_implant_total"></td>
                    <td id="old_permanent_man"></td>
                    <td id="old_ipermanent_woman"></td>
                    <td id="old_all_total"></td>
                </tr>
                <tr>
                    <td colspan="2" style="text-align:left;">নতুন</td>
                    <td id="new_pill_gov"></td>
                    <td id="new_pill_purchage"></td>
                    <td id="new_pill_total"></td>
                    <td id="new_condom_gov"></td>
                    <td id="new_condom_purchage"></td>
                    <td id="new_condom_total"></td>
                    <td id="new_inject_gov"></td>
                    <td id="new_inject_purchage"></td>
                    <td id="new_inject_total"></td>
                    <td id="new_iud_gov"></td>
                    <td id="new_iud_purchage"></td>
                    <td id="new_iud_total"></td>
                    <td id="new_implant_gov"></td>
                    <td id="new_implant_purchage"></td>
                    <td id="new_implant_total"></td>
                    <td id="new_permanent_man"></td>
                    <td id="new_ipermanent_woman"></td>
                    <td id="new_all_total"></td>
                </tr>
                <tr>
                    <td colspan="2" style="text-align:left;">চলতি মাসের মোট</td>
                    <td id="curr_month_pill_gov"></td>
                    <td id="curr_month_pill_purchage"></td>
                    <td id="curr_month_pill_total"></td>
                    <td id="curr_month_condom_gov"></td>
                    <td id="curr_month_condom_purchage"></td>
                    <td id="curr_month_condom_total"></td>
                    <td id="curr_month_inject_gov"></td>
                    <td id="curr_month_inject_purchage"></td>
                    <td id="curr_month_inject_total"></td>
                    <td id="curr_month_iud_gov"></td>
                    <td id="curr_month_iud_purchage"></td>
                    <td id="curr_month_iud_total"></td>
                    <td id="curr_month_implant_gov"></td>
                    <td id="curr_month_implant_purchage"></td>
                    <td id="curr_month_implant_total"></td>
                    <td id="curr_month_permanent_man"></td>
                    <td id="curr_month_ipermanent_woman"></td>
                    <td id="curr_month_all_total"></td>
                </tr>
                <tr>
                    <td colspan="2" style="text-align:left;">পূর্ববর্তী মাসের মোট</td>
                    <td id="priv_month_pill_gov"></td>
                    <td id="priv_month_pill_purchage"></td>
                    <td id="priv_month_pill_total"></td>
                    <td id="priv_month_condom_gov"></td>
                    <td id="priv_month_condom_purchage"></td>
                    <td id="priv_month_condom_total"></td>
                    <td id="priv_month_inject_gov"></td>
                    <td id="priv_month_inject_purchage"></td>
                    <td id="priv_month_inject_total"></td>
                    <td id="priv_month_iud_gov"></td>
                    <td id="priv_month_iud_purchage"></td>
                    <td id="priv_month_iud_total"></td>
                    <td id="priv_month_implant_gov"></td>
                    <td id="priv_month_implant_purchage"></td>
                    <td id="priv_month_implant_total"></td>
                    <td id="priv_month_permanent_man"></td>
                    <td id="priv_month_permanent_woman"></td>
                    <td id="priv_month_all_total"></td>
                </tr>
                <tr>
                    <td colspan="2" style="text-align:left;">ইউনিটের সর্বমোট</td>
                    <td id="unit_pill_gov_tot"></td>
                    <td id="unit_pill_purchage_tot"></td>
                    <td id="unit_pill_total_tot"></td>
                    <td id="unit_condom_gov_tot"></td>
                    <td id="unit_condom_purchage_tot"></td>
                    <td id="unit_condom_total_tot"></td>
                    <td id="unit_inject_gov_tot"></td>
                    <td id="unit_inject_purchage_tot"></td>
                    <td id="unit_inject_total_tot"></td>
                    <td id="unit_iud_gov_tot"></td>
                    <td id="unit_iud_purchage_tot"></td>
                    <td id="unit_iud_total_tot"></td>
                    <td id="unit_implant_gov_tot"></td>
                    <td id="unit_implant_purchage_tot"></td>
                    <td id="unit_implant_total_tot"></td>
                    <td id="unit_permanent_man_tot"></td>
                    <td id="unit_permanent_woman_tot"></td>
                    <td id="unit_all_total_tot"></td>
                </tr>
                <tr>
                    <td rowspan="2" style="text-align:left;">চলতি মাসে<br>ছেড়ে <br>দিয়েছে</td>
                    <td style="text-align:left;">কোন পদ্ধতি নেয়নি </td>
                    <td colspan="3" id="curr_m_left_pill_no_method"></td>
                    <td colspan="3" id="curr_m_left_condom_no_method"></td>
                    <td colspan="3" id="curr_m_left_inj_no_method"></td>
                    <td colspan="3" id="curr_m_left_iud_no_method"></td>
                    <td colspan="3" id="curr_m_left_implant_no_method"></td>
                    <td id="curr_m_left_per_man_no_method"></td>
                    <td id="curr_m_left_per_woman_no_method"></td>
                    <td id="curr_m_left_no_method_all_tot"></td>
                </tr>
                <tr>
                    <td style="text-align:left;">অন্য পদ্ধতি নিয়েছে </td>
                    <td colspan="3" id="curr_m_left_pill_oth_method"></td>
                    <td colspan="3" id="curr_m_left_condom_oth_method"></td>
                    <td colspan="3" id="curr_m_left_inj_oth_method"></td>
                    <td colspan="3" id="curr_m_left_iud_oth_method"></td>
                    <td colspan="3" id="curr_m_left_implant_oth_method"></td>
                    <td id="curr_m_left_per_man_oth_method"></td>
                    <td id="curr_m_left_per_woman_oth_mthd"></td>
                    <td id="curr_m_left_oth_method_all_tot"></td>
                </tr>
                <tr>
                    <td colspan="2" style="text-align:left;">পদ্ধতির জন্য প্রেরণ</td>
                    <td colspan="3" id="sent_method_pill"></td>
                    <td colspan="3" id="sent_method_condom"></td>
                    <td colspan="3" id="sent_method_inj"></td>
                    <td colspan="3" id="sent_method_iud"></td>
                    <td colspan="3" id="sent_method_implant"></td>
                    <td style="background-color:#BDBDBD"></td>
                    <td style="background-color:#BDBDBD"></td>
                    <td id="sent_method_all_tot"></td>
                </tr>
                <tr>
                    <td colspan="2" style="text-align:left;">পার্শ্ব প্রতিক্রিয়ার জন্য প্রেরণ</td>
                    <td colspan="3" class="ka_table_inactive_field" style="background-color:#BDBDBD"></td>
                    <td colspan="3" class="ka_table_inactive_field" style="background-color:#BDBDBD"></td>
                    <td colspan="3" id="sent_side_effect_inj"></td>
                    <td colspan="3" id="sent_side_effect_iud"></td>
                    <td colspan="3" id="sent_side_effect_implant"></td>
                    <td id="sent_side_effect_per_man"></td>
                    <td id="sent_side_effect_per_woman"></td>
                    <td id="sent_side_effect_all_tot"></td>
                </tr>
            </table>
            <br/>
            <table class="mis_table" style="table-layout: fixed; width: 100%">
                <colgroup>
                    <col style="width: 301px">
                    <col style="width: 101px">
                    <col style="width: 301px">
                    <col style="width: 101px">
                </colgroup>
                <tr>
                    <td>চলতি মাসে পরিদর্শিত সক্ষম দম্পতির সংখ্যা</td>
                    <td id="curr_m_shown_capable_elco_tot"></td>
                    <td>পূর্ববর্তী মাসে পরিদর্শিত সক্ষম দম্পতির সংখ্যা</td>
                    <td id="priv_m_shown_capable_elco_tot"></td>
                </tr>
                <tr>
                    <td>চলতি মাসে নবদম্পতির সংখ্যা</td>
                    <td id="curr_m_v_new_elco_tot"></td>
                    <td>ইউনিটের মোট সক্ষম দম্পতির সংখ্যা</td>
                    <td id="unit_capable_elco_tot"></td>
                </tr>
            </table>
            <br>
            <table class="mis_table" style="table-layout: fixed; width: 100%">
                <colgroup>
                    <col style="width: 701px">
                    <col style="width: 108px">
                </colgroup>
                <tr>
                    <th>পদ্ধতি গ্রহনকারীর হার (CAR): (ইউনিটের সর্বমোট পদ্ধতি গ্রহণকারী/ইউনিটের সর্বমোট সক্ষম দম্পতি)X ১০০= </th>
                    <th id="r_car"></th>
                </tr>
            </table>
            <br><br>
            <p> <strong>খ) প্রজনন স্বাস্থ্য সেবাঃ </strong> </p>

            <table class="mis_table" style="table-layout: fixed; width: 100%">
                <colgroup>
                    <col style="width: 136px">
                    <col style="width: 110px">
                    <col style="width: 151px">
                    <col style="width: 91px">
                    <col style="width: 92px">
                </colgroup>
                <tr>
                    <th colspan="3">সেবার ধরণ<br></th>
                    <th>তথ্য</th>
                    <th>সেবা<br></th>
                </tr>
                <tr>
                    <td colspan="2" rowspan="3">চলতি মাসে গর্ভবতীর সংখ্যা<br></td>
                    <td>নতুন<br></td>
                    <td id="curr_month_preg_new_fwa"></td>
                    <td class="ka_table_inactive_field"></td>
                </tr>
                <tr>
                    <td>পুরাতন</td>
                    <td id="curr_month_preg_old_fwa"></td>
                    <td class="ka_table_inactive_field"></td>
                </tr>
                <tr>
                    <td>মোট</td>
                    <td id="curr_month_preg_tot_fwa"></td>
                    <td class="ka_table_inactive_field"></td>
                </tr>
                <tr>
                    <td colspan="3">পূর্ববতী মাসে মোট গর্ভবতীর সংখ্যা<br></td>
                    <td id="prir_month_tot_preg_fwa"></td>
                    <td class="ka_table_inactive_field"></td>
                </tr>
                <tr>
                    <td colspan="3">ইউনিটের সর্বমোট গর্ভবতীর সংখ্যা<br></td>
                    <td id="unit_tot_preg_fwa"></td>
                    <td class="ka_table_inactive_field"></td>
                </tr>
                <tr>
                    <td rowspan="4">গর্ভবতী সেবার  তথ্য<br></td>
                    <td colspan="2">পরিদর্শন-১ (৪ মাসের মধ্যে)<br></td>
                    <td id="preg_anc_service_visit1_fwa"></td>
                    <td id="preg_anc_service_visit1_csba"></td>
                </tr>
                <tr>
                    <td colspan="2">পরিদর্শন-২ (৬ মাসের মধ্যে)<br></td>
                    <td id="preg_anc_service_visit2_fwa"></td>
                    <td id="preg_anc_service_visit2_csba"></td>
                </tr>
                <tr>
                    <td colspan="2">পরিদর্শন-৩ (৮ মাসের মধ্যে)<br></td>
                    <td id="preg_anc_service_visit3_fwa"></td>
                    <td id="preg_anc_service_visit3_csba"></td>
                </tr>
                <tr>
                    <td colspan="2">পরিদর্শন-৪ (৯ম মাসে)<br></td>
                    <td id="preg_anc_service_visit4_fwa"></td>
                    <td id="preg_anc_service_visit4_csba"></td>
                </tr>
                <tr>
                    <td rowspan="7">প্রসব সেবার তথ্য<br></td>
                    <td rowspan="2"><br>বাড়ী</td>
                    <td>প্রশিক্ষণপ্রাপ্ত ব্যাক্তি দ্বারা<br></td>
                    <td id="delivary_service_home_trained_fwa"></td>
                    <td class="ka_table_inactive_field"></td>
                </tr>
                <tr>
                    <td>প্রশিক্ষণবিহীন ব্যক্তি দ্বারা<br></td>
                    <td id="delivary_service_home_untrained_fwa"></td>
                    <td class="ka_table_inactive_field"></td>
                </tr>
                <tr>
                    <td rowspan="2">হাসপাতাল/ক্লিনিক</td>
                    <td>স্বাভাবিক</td>
                    <td id="delivary_service_hospital_normal_fwa"></td>
                    <td class="ka_table_inactive_field"></td>
                </tr>
                <tr>
                    <td>সিজারিয়ান<br></td>
                    <td id="delivary_service_hospital_operation_fwa"></td>
                    <td class="ka_table_inactive_field"></td>
                </tr>
                <tr>
                    <td colspan="2">প্রসব করানো হয়েছে<br></td>
                    <td class="ka_table_inactive_field"></td>
                    <td id="delivary_service_delivery_done_csba"></td>
                </tr>
                <tr>
                    <td colspan="2">প্রসবের তৃতীয় ধাপের সক্রিয় ব্যবস্থাপনা (AMTSL) অনুসরণ করে প্রসব করানোর সংখ্যা<br></td>
                    <td class="ka_table_inactive_field"></td>
                    <td id="delivary_service_3rd_amts1_csba"></td>
                </tr>
                <tr>
                    <td colspan="2">অক্সিটোসিন না থাকলে মিসোপ্রোস্টল বড়ি খাওয়ানো হয়েছে<br></td>
                    <td class="ka_table_inactive_field"></td>
                    <td id="delivary_service_misoprostol_taken_csba"></td>
                </tr>
                <tr>
                    <td rowspan="9">প্রসবোত্তর সেবার তথ্য<br></td>
                    <td rowspan="5">মা</td>
                    <td>পরিদর্শন-১ (২৪ঘণ্টার মধ্যে)<br></td>
                    <td id="pnc_mother_visit1_fwa"></td>
                    <td id="pnc_mother_visit1_csba"></td>
                </tr>
                <tr>
                    <td>পরিদর্শন-২ (২-৩ দিনের মধ্যে)<br></td>
                    <td id="pnc_mother_visit2_fwa"></td>
                    <td id="pnc_mother_visit2_csba"></td>
                </tr>
                <tr>
                    <td>পরিদর্শন-৩ (৭-১৪ দিনের মধ্যে)<br></td>
                    <td id="pnc_mother_visit3_fwa"></td>
                    <td id="pnc_mother_visit3_csba"></td>
                </tr>
                <tr>
                    <td>পরিদর্শন-৪ (৪২-৪৮ দিনের মধ্যে)<br></td>
                    <td id="pnc_mother_visit4_fwa"></td>
                    <td id="pnc_mother_visit4_csba"></td>
                </tr>
                <tr>
                    <td>প্রসব পরবর্তী পরিবার পরিকল্পনা পদ্ধতি বিষয়ে <br>কাউন্সিলিং</td>
                    <td class="ka_table_inactive_field"></td>
                    <td id="pnc_mother_family_planning_csba"></td>
                </tr>
                <tr>
                    <td rowspan="4">নবজাতক<br></td>
                    <td>পরিদর্শন-১ (২৪ ঘণ্টার মধ্যে)<br></td>
                    <td id="pnc_child_visit1_fwa"></td>
                    <td id="pnc_child_visit1_csba"></td>
                </tr>
                <tr>
                    <td>পরিদর্শন-২ (২-৩ দিনের দিনের মধ্যে)<br></td>
                    <td id="pnc_child_visit2_fwa"></td>
                    <td id="pnc_child_visit2_csba"></td>
                </tr>
                <tr>
                    <td>পরিদর্শন-৩ (৭-১৪ দিনের মধ্যে)<br></td>
                    <td id="pnc_child_visit3_fwa"></td>
                    <td id="pnc_child_visit3_csba"></td>
                </tr>
                <tr>
                    <td>পরিদর্শন-৪ (৪২-৪৪ দিনের মধ্যে)<br></td>
                    <td id="pnc_child_visit4_fwa"></td>
                    <td id="pnc_child_visit4_csba"></td>
                </tr>
                <tr>
                    <td rowspan="4">রেফারকৃত</td>
                    <td colspan="2">ঝুকিপূর্ণ/জটিল গর্ভবতীর সংখ্যা <br></td>
                    <td id="ref_risky_preg_cnt_fwa"></td>
                    <td class="ka_table_inactive_field"></td>
                </tr>
                <tr>
                    <td colspan="2">গর্ভকালীন, প্রসবকালীন ও প্রসবোত্তর জটিলতার সংখ্যা<br></td>
                    <td class="ka_table_inactive_field"></td>
                    <td id="ref_preg_delivery_pnc_diff_refer_csba"></td>
                </tr>
                <tr>
                    <td colspan="2">একলাম্পসিয়া রোগীকে MgSO4 ইনজেকশন দিয়ে রেফার করার সংখ্যা<br></td>
                    <td class="ka_table_inactive_field"> </td>
                    <td id="ref_eclampsia_mgso4_inj_refer_csba"></td>
                </tr>
                <tr>
                    <td colspan="2">নবজাতককে জটিলতার জন্য প্রেরণের সংখ্যা<br></td>
                    <td class="ka_table_inactive_field"></td>
                    <td id="ref_newborn_difficulty_csba"></td>
                </tr>
                <tr>
                    <td colspan="2" rowspan="5">টি টি প্রাপ্ত মহিলার সংখ্যা<br></td>
                    <td>১ম</td>
                    <td id="tt_women_1st_fwa"></td>
                    <td class="ka_table_inactive_field"></td>
                </tr>
                <tr>
                    <td>২য়</td>
                    <td id="tt_women_2nd_fwa"></td>
                    <td class="ka_table_inactive_field"></td>
                </tr>
                <tr>
                    <td>৩য়</td>
                    <td id="tt_women_3rd_fwa"></td>
                    <td class="ka_table_inactive_field"></td>
                </tr>
                <tr>
                    <td>৪র্থ</td>
                    <td id="tt_women_4th_fwa"></td>
                    <td class="ka_table_inactive_field"></td>
                </tr>
                <tr>
                    <td>৫ম<br></td>
                    <td id="tt_women_5th_fwa"></td>
                    <td class="ka_table_inactive_field"></td>
                </tr>
                <tr>
                    <td colspan="3">ইসিপি গ্রহনকারীর সংখ্যা <br></td>
                    <td id="ecp_taken"></td>
                    <td class="ka_table_inactive_field"></td>
                </tr>
                <tr>
                    <td colspan="3">মিসোপ্রোস্টল বড়ি গ্রহণকারীর সংখ্যা<br></td>
                    <td id="misoprostol_taken"></td>
                    <td class="ka_table_inactive_field"></td>
                </tr>
                <tr>
                    <td colspan="2" rowspan="2"><br>বন্ধ্যা দম্পতির তথ্য<br></td>
                    <td>পরামর্শপ্রাপ্ত</td>
                    <td id="childless_couple_adviced_fwa"></td>
                    <td class="ka_table_inactive_field"></td>
                </tr>
                <tr>
                    <td>রেফারকৃত</td>
                    <td id="childless_couple_refered_fwa"></td>
                    <td class="ka_table_inactive_field"></td>
                </tr>
                <tr>
                    <td rowspan="4">কিশোর-কিশোরীর <br>সেবা(১০-১৯ বছর)<br>কাউন্সিলিং<br></td>
                    <td colspan="2">কিশোর-কিশোরীকে বয়োসন্ধিকালীন পরিবর্তন বিষয়ে <br></td>
                    <td id="teenager_counsiling_referred"></td>
                    <td class="ka_table_inactive_field"></td>
                </tr>
                <tr>
                    <td colspan="2">বাল্য-বিবাহ ও কিশোরী মাতৃত্বের কুফল বিষয়ে<br></td>
                    <td id="teenager_counsiling_child_marriage_child_preg_disadvantage"></td>
                    <td class="ka_table_inactive_field"></td>
                </tr>
                <tr>
                    <td colspan="2">কিশোরীকে আয়রন ও ফলিক এসিড বড়ি খাবার বিষয়ে<br></td>
                    <td id="teenager_counsiling_healthy_balanced_diet"></td>
                    <td class="ka_table_inactive_field"></td>
                </tr>
                <tr>
                    <td colspan="2">প্রজননতন্ত্রের সংক্রমন ও যৌনবাহিত রোগ বিষয়ে<br></td>
                    <td id="teenager_counsiling_sexual_disease"></td>
                    <td class="ka_table_inactive_field"></td>
                </tr>
                <tr>
                    <td colspan="3">স্যাটেলাইট ক্লিনিকে উপস্থিতি <br></td>
                    <td id="satelite_clinic_presence"></td>
                    <td class="ka_table_inactive_field"></td>
                </tr>
                <tr>
                    <td colspan="3">ইপিআই সেশনে উপস্থিতি<br></td>
                    <td id="epi_session_presence"></td>
                    <td class="ka_table_inactive_field"></td>
                </tr>
                <tr>
                    <td colspan="3">কমিউনিট ক্লিনিকে উপস্থিতি<br></td>
                    <td id="community_clinic_presence"></td>
                    <td class="ka_table_inactive_field"> </td>
                </tr>
            </table>



            <br/>
            <br/>

            <table class="mis_table" style="table-layout: fixed; width: 100%">
                <colgroup>
                    <col style="width: 105px">
                    <col style="width: 105px">
                    <col style="width: 80px">
                    <col style="width: 91px">
                    <col style="width: 91px">
                    <col style="width: 92px">
                </colgroup>
                <tr>
                <p style="font-weight:600;">গ. শিশু (০-৫ বছর) সেবা</p>
                </tr>
                <tr>
                    <th colspan="4">সেবার ধরণ<br></th>
                    <th>তথ্য</th>
                    <th>সেবা</th>
                </tr>
                <tr>
                    <td rowspan="4">নবজাতকের সেবা সংক্রান্ত তথ্য<br></td>
                    <td colspan="3">১ মিনিটের মধ্যে মোছানোর সংখ্যা<br></td>
                    <td id="newborn_1min_washed_fwa"></td>
                    <td id="newborn_1min_washed_csba"></td>
                </tr>
                <tr>
                    <td colspan="3">নাড়ি কাটার পর ৭.১% ক্লোরহেক্সিডিন ব্যবহারের সংখ্যা<br></td>
                    <td id="newborn_71_chlorohexidin_used_fwa"></td>
                    <td id="newborn_71_chlorohexidin_used_csba"></td>
                </tr>
                <tr>
                    <td colspan="3">জন্মের এক ঘণ্টার মধ্যে বুকের দুধ খাওয়ানোর সংখ্যা<br></td>
                    <td id="newborn_1hr_bfeeded_fwa"></td>
                    <td id="newborn_1hr_bfeeded_csba"></td>
                </tr>
                <tr>
                    <td colspan="3">জন্মকালীন শ্বাসকষ্টে আক্রান্ত শিশুকে ব্যাগ ও মাস্ক ব্যবহার করে রিসাসসিটেট  করার সংখ্যা<br></td>
                    <td class="ka_table_inactive_field"></td>
                    <td id="newborn_diff_breathing_resassite_csba"></td>
                </tr>
                <tr>
                    <td rowspan="7">টিকাপ্রাপ্ত (০-১৮ মাস বয়সী) শিশুর সংখ্যা<br></td>
                    <td colspan="3">বিসিজি</td>
                    <td id="vaccinated_child_bcg_fwa"></td>
                    <td class="ka_table_inactive_field"></td>
                </tr>
                <tr>
                    <td rowspan="3">ওপিভি ও প্যান্টাভেলেন্ট<br>(ডিপিটি,হেপ বি,হিব)<br></td>
                    <td rowspan="2">পিসিভি</td>
                    <td>১</td>
                    <td id="vaccinated_0t01yrs_child_pcv_pentavalent_1_fwa"></td>
                    <td class="ka_table_inactive_field"></td>
                </tr>
                <tr>
                    <td>২</td>
                    <td id="vaccinated_0t01yrs_child_pcv_pentavalent_2_fwa"></td>
                    <td class="ka_table_inactive_field"></td>
                </tr>
                <tr>
                    <td colspan="2" style="text-align:center !important">৩.</td>
                    <td id="vaccinated_0t01yrs_child_pcv_pentavalent_3_fwa"></td>
                    <td class="ka_table_inactive_field"></td>
                </tr>
                <tr>
                    <td colspan="3">পিসিভি-৩<br></td>
                    <td id="vaccinated_0t01yrs_child_pcv_pentavalent_4_fwa"></td>
                    <td class="ka_table_inactive_field"></td>
                </tr>
                <tr>
                    <td colspan="3">এমআর ও ওপিভি-৪<br></td>
                    <td id="vaccinated_0t01yrs_child_opv3_fwa"></td>
                    <td class="ka_table_inactive_field"></td>
                </tr>
                <tr>
                    <td colspan="3">হামের টিকা<br></td>
                    <td id="vaccinated_child_ham_fwa"></td>
                    <td class="ka_table_inactive_field"></td>
                </tr>
                <tr>
                    <td colspan="2" rowspan="3">রেফারকৃত শিশুর সংখ্যা<br></td>
                    <td colspan="2">খুব মারাত্বক রোগ<br></td>
                    <td id="referred_child_dangerous_disease_fwa"></td>
                    <td class="ka_table_inactive_field"></td>
                </tr>
                <tr>
                    <td colspan="2">নিউমোনিয়া</td>
                    <td id="referred_child_neumonia_fwa"></td>
                    <td class="ka_table_inactive_field"></td>
                </tr>
                <tr>
                    <td colspan="2">ডায়রিয়া</td>
                    <td id="referred_child_diahoea_fwa"></td>
                    <td class="ka_table_inactive_field"></td>
                </tr>
            </table>

            <br/>
            <br/>	
            <table class="mis_table" style="table-layout: fixed; width: 100%">
                <colgroup>
                    <col style="width: 91px">
                    <col style="width: 91px">
                    <col style="width: 121px">
                    <col style="width: 91px">
                    <col style="width: 92px">
                </colgroup>
                <tr>
                <p style="font-weight:600;">ঘ. জন্ম-মৃত্যু: </p>
                </tr>
                <tr>
                    <th colspan="3">সেবার ধরণ<br></th>
                    <th>তথ্য</th>
                    <th>সেবা</th>
                </tr>
                <tr>
                    <td colspan="3">মোট জীবিত জন্মের সংখ্যা<br></td>
                    <td id="tot_live_birth_fwa"></td>
                    <td id="tot_live_birth_csba"></td>
                </tr>
                <tr>
                    <td colspan="3">কম জন্মওজনে(জন্ম ওজন&lt;২.৫ কেজি) জন্মগ্রহনকারী নবজাতকের সংখ্যা<br></td>
                    <td id="less_weight_birth_fwa"></td>
                    <td id="less_weight_birth_csba"></td>
                </tr>
                <tr>
                    <td colspan="3">অপরিণত (৩৭ সপ্তাহের পূর্বে জন্ম) নবজাতকের সংখ্যা<br></td>
                    <td id="immature_birth_fwa"></td>
                    <td id="immature_birth_csba"></td>
                </tr>
                <tr>
                    <td colspan="3">মৃত জন্ম<br></td>
                    <td id="death_birth_fwa"></td>
                    <td id="death_birth_csba"></td>
                </tr>
                <tr>
                    <td rowspan="8">মৃতের সংখ্যা<br></td>
                    <td rowspan="4">এক বছরের কম মৃত শিশুর সংখ্যা<br></td>
                    <td>০-৭ দিন<br></td>
                    <td id="death_number_less_1yr_0to7days_fwa"></td>
                    <td id="death_number_less_1yr_0to7days_csba"></td>
                </tr>
                <tr>
                    <td>৮-২৮ দিন<br></td>
                    <td id="death_number_less_1yr_8to28days_fwa"></td>
                    <td id="death_number_less_1yr_8to28days_csba"></td>
                </tr>
                <tr>
                    <td>২৯ দিন -&lt;১ বছর<br></td>
                    <td id="death_number_less_1yr_29dystoless1yr_fwa"></td>
                    <td class="ka_table_inactive_field"></td>
                </tr>
                <tr>
                    <td>মোট</td>
                    <td id="death_number_less_1yr_tot_fwa"></td>
                    <td class="ka_table_inactive_field"></td>
                </tr>
                <tr>
                    <td colspan="2">১-&lt;৫ বছর মৃত শিশুর সংখ্যা<br></td>
                    <td id="death_number_1yrto5yr_fwa"></td>
                    <td class="ka_table_inactive_field"></td>
                </tr>
                <tr>
                    <td colspan="2">মাতৃ মৃত্যুর সংখ্যা<br></td>
                    <td id="death_number_maternal_death_fwa"></td>
                    <td id="death_number_maternal_death_csba"></td>
                </tr>
                <tr>
                    <td colspan="2">অন্যান্য মৃতের সংখ্যা<br></td>
                    <td id="death_number_other_death_fwa"></td>
                    <td class="ka_table_inactive_field"></td>
                </tr>
                <tr>
                    <td colspan="2">সর্বমোট মৃতের সংখ্যা<br></td>
                    <td id="death_number_all_death_fwa"></td>
                    <td class="ka_table_inactive_field"></td>
                </tr>
            </table>

            <table class="mis_table" width=100%>
                <tr>
                <tr>
                <p style="font-weight:600;">ঙ. পুষ্টি সেবাঃ</p> 

                <tr/>
                <tr>
                    <th>সেবার ধরন</th>
                    <th>গর্ভবতী মা</th>
                    <th> শিশুর মা <br>০-২৩ মাস</th>
                </tr>

                <tr> 
                    <td>আয়রন ও ফলিক এসিড বড়ি এবং বাড়তি <br> খাবারের উপর কাউন্সেলিং দেয়া হয়েছে</td>
                    <td id="iron_folicacid_extrafood_counsiling_preg_woman"></td>
                    <td id="iron_folicacid_extrafood_counsiling_child_0to23months"></td>
                </tr>
                <!--
                                <tr> 
                                    <td>আয়রন ও ফলিক এসিড বড়ি বিতরন করা হয়েছে</td>
                                    <td></td>
                                    <td></td>
                                </tr>
                -->
                <tr> 
                    <td>মায়ের দুধ ও পরিপুরক খাবারের উপর কাউন্সেলিং <br> দেওয়া হয়েছে</td>
                    <td id="bfeeding_complementary_food_counsiling_preg_woman"></td>
                    <td id="bfeeding_complementary_food_counsiling_child_0to23months"></td>
                </tr>

                <!--                <tr> 
                                    <td>শিশুকে মাল্টিপল মাইক্রোনিউট্রিয়েন্ট পাউডার <br> (এমএনপি) খাওয়ানো বিষয়ে কাউন্সেলিং দেওয়া হয়েছে</td>
                                    <td></td>
                                    <td></td>
                                </tr>-->
                </tr>
                </tr>

            </table>
            <br/>
            <br/>
            <table class="mis_table" style="table-layout: fixed; width: 100%">
                <colgroup>
                    <col style="width: 301px">
                    <col style="width: 91px">
                    <col style="width: 91px">
                    <col style="width: 92px">
                </colgroup>

                <tr>
                    <th>সেবার ধরণ<br></th>
                    <th>০-৬ মাস<br></th>
                    <th>৬-২৪ মাস<br></th>
                    <th>২৪-৬০ মাস<br></th>
                </tr>
                <tr>
                    <td>জন্মের একঘণ্টার মধ্যে বুকের দুধ খাওয়ানো হয়েছে<br></td>
                    <td id="birth_1hr_bfeed_0to6mon"></td>
                    <td class="ka_table_inactive_field"></td>
                    <td class="ka_table_inactive_field"></td>
                </tr>
                <tr>
                    <td>৬ মাস পর্যন্ত শুধুমাত্র বুকের দুধ খাওয়ানো হয়েছে/হচ্ছে<br></td>
                    <td id="birth_only_bfeed_0to6mon"></td>
                    <td class="ka_table_inactive_field"></td>
                    <td class="ka_table_inactive_field"></td>
                </tr>
                <tr>
                    <td>জন্মের ৬ মাস পর থেকে পরিপূরক খাবার খাওয়ানো হয়েছে/হচ্ছে<br></td>
                    <td class="ka_table_inactive_field"></td>
                    <td></td>
                    <td></td>
                </tr>
                <tr>
                    <td>মাল্টিপল মাইক্রোনিউট্রিয়েন্ট পাউডার (এম এনপি) পেয়েছে<br></td>
                    <td class="ka_table_inactive_field"></td>
                    <td id="mnp_given_6to23mon"></td>
                    <td id="mnp_given_24toless60mon"></td>
                </tr>
                <tr>
                    <td>MAM আক্রান্ত শিশুর সংখ্যা <br></td>
                    <td id="mam_child_0to6mon"></td>
                    <td id="mam_child_6to23mon"></td>
                    <td id="mam_child_24toless60mon"></td>
                </tr>
                <tr>
                    <td>SAM আক্রান্ত শিশুর সংখ্যা <br></td>
                    <td id="sam_child_0to6mon"></td>
                    <td id="sam_child_6to23mon"></td>
                    <td id="sam_child_24toless60mon"></td>
                </tr>
            </table>


        </div>
        
        
        
        
        
        <style type="text/css">
            .tg  {border-collapse:collapse;border-spacing:0;}
            .tg td{font-family:Arial, sans-serif;font-size:14px;padding:10px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;}
            .tg th{font-family:Arial, sans-serif;font-size:14px;font-weight:normal;padding:10px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;}
            .tg .tg-glis{font-size:10px}
            .tg .tg-s6z2{text-align:center}
        </style>
        <br/><br/>
        <table class="mis_table" style="table-layout: fixed; width: 100%">
            <colgroup>
                <col style="width: 93px">
                <col style="width: 120px">
                <col style="width: 91px">
                <col style="width: 91px">
                <col style="width: 91px">
                <col style="width: 91px">
                <col style="width: 91px">
                <col style="width: 91px">
                <col style="width: 91px">
                <col style="width: 91px">
                <col style="width: 93px">
            </colgroup>
            <tr style="text-align:center;">
                মাসিক মওজুদ ও বিতরণের হিসাব বিষয়ক ছকঃ
            </tr>
            <tr>
                <th class="tg-031e" colspan="5" style="text-weight:800px !important" id="monthValue">মাসের নামঃ </th>
                <th class="tg-031e" colspan="6" id="yearValue">সালঃ </th>
            </tr>
            <tr>
                <td class="tg-glis">ইস্যু ভাউচার নং<br></td>
                <td class="tg-031e"></td>
                <td class="tg-s6z2" colspan="2">খাবার বড়ি<br></td>
                <td class="tg-s6z2" rowspan="2">কনডম<br>(নিরাপদ)<br>(পিস)<br></td>
                <td class="tg-s6z2" colspan="2">ইনজেকটেবল</td>
                <td class="tg-s6z2" rowspan="2">ইসিপি<br>(ডোজ)<br></td>
                <td class="tg-s6z2" rowspan="2">মিসো-<br>প্রোস্টল<br>(ডোজ)<br></td>
                <td class="tg-s6z2" rowspan="2">এমএনপি<br>(স্যাসেট)<br></td>
                <td class="tg-s6z2" rowspan="2">আয়রন<br>ফলিক<br>এসিড<br>(সংখ্যা)<br></td>
            </tr>
            <tr>
                <td class="tg-glis">তারিখ</td>
                <td class="tg-031e"></td>
                <td class="tg-s6z2">সুখী<br>(চক্র)<br></td>
                <td class="tg-s6z2">আপন<br>(চক্র)<br></td>
                <td class="tg-s6z2">ভায়াল</td>
                <td class="tg-s6z2">সিরিঞ্জ</td>
            </tr>
            <tr>
                <td class="tg-031e" colspan="2">পূর্বের মওজুদ<br></td>
                <td class="tg-031e"></td>
                <td class="tg-031e"></td>
                <td class="tg-031e"></td>
                <td class="tg-031e"></td>
                <td class="tg-031e"></td>
                <td class="tg-031e"></td>
                <td class="tg-031e"></td>
                <td class="tg-031e"></td>
                <td class="tg-031e"></td>
            </tr>
            <tr>
                <td class="tg-031e" colspan="2">চলতি মাসে পাওয়া গেছে(+)<br></td>
                <td class="tg-031e"></td>
                <td class="tg-031e"></td>
                <td class="tg-031e"></td>
                <td class="tg-031e"></td>
                <td class="tg-031e"></td>
                <td class="tg-031e"></td>
                <td class="tg-031e"></td>
                <td class="tg-031e"></td>
                <td class="tg-031e"></td>
            </tr>
            <tr>
                <td class="tg-031e" colspan="2">চলতি মাসের মোট মওজুদ<br></td>
                <td class="tg-031e"></td>
                <td class="tg-031e"></td>
                <td class="tg-031e"></td>
                <td class="tg-031e"></td>
                <td class="tg-031e"></td>
                <td class="tg-031e"></td>
                <td class="tg-031e"></td>
                <td class="tg-031e"></td>
                <td class="tg-031e"></td>
            </tr>
            <tr>
                <td class="tg-031e" rowspan="2">সমন্বয়</td>
                <td class="tg-031e">(+)</td>
                <td class="tg-031e"></td>
                <td class="tg-031e"></td>
                <td class="tg-031e"></td>
                <td class="tg-031e"></td>
                <td class="tg-031e"></td>
                <td class="tg-031e"></td>
                <td class="tg-031e"></td>
                <td class="tg-031e"></td>
                <td class="tg-031e"></td>
            </tr>
            <tr>
                <td class="tg-031e">(-)</td>
                <td class="tg-031e"></td>
                <td class="tg-031e"></td>
                <td class="tg-031e"></td>
                <td class="tg-031e"></td>
                <td class="tg-031e"></td>
                <td class="tg-031e"></td>
                <td class="tg-031e"></td>
                <td class="tg-031e"></td>
                <td class="tg-031e"></td>
            </tr>
            <tr>
                <td class="tg-031e" colspan="2">সর্বমোট</td>
                <td class="tg-031e"></td>
                <td class="tg-031e"></td>
                <td class="tg-031e"></td>
                <td class="tg-031e"></td>
                <td class="tg-031e"></td>
                <td class="tg-031e"></td>
                <td class="tg-031e"></td>
                <td class="tg-031e"></td>
                <td class="tg-031e"></td>
            </tr>
            <tr>
                <td class="tg-031e" colspan="2">চলতি মাসে বিতরণ করা হয়েছে(-)</td>
                <td class="tg-031e"></td>
                <td class="tg-031e"></td>
                <td class="tg-031e"></td>
                <td class="tg-031e"></td>
                <td class="tg-031e"></td>
                <td class="tg-031e"></td>
                <td class="tg-031e"></td>
                <td class="tg-031e"></td>
                <td class="tg-031e"></td>
            </tr>
            <tr>
                <td class="tg-031e" colspan="2">অবশিষ্ট<br></td>
                <td class="tg-031e"></td>
                <td class="tg-031e"></td>
                <td class="tg-031e"></td>
                <td class="tg-031e"></td>
                <td class="tg-031e"></td>
                <td class="tg-031e"></td>
                <td class="tg-031e"></td>
                <td class="tg-031e"></td>
                <td class="tg-031e"></td>
            </tr>
            <tr>
                <td class="tg-031e" colspan="2">চলতি মাসে কখনও মওজুদ শূণ্যতা হয়ে থাকলে কারণ (কোড) লিখুন <br></td>
                <td class="tg-031e"></td>
                <td class="tg-031e"></td>
                <td class="tg-031e"></td>
                <td class="tg-031e"></td>
                <td class="tg-031e"></td>
                <td class="tg-031e"></td>
                <td class="tg-031e"></td>
                <td class="tg-031e"></td>
                <td class="tg-031e"></td>
            </tr>
        </table>
        <br>
        <br>
    </div>
</div>
<%@include file="/WEB-INF/jspf/footer.jspf" %>
